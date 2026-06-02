Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AABACD6E5D
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 00:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB6E0848DF;
	Wed,  3 Jun 2026 02:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="aM/d9mVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 276F28485F; Tue,  2 Jun 2026 23:30:25 +0200 (CEST)
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch
 [79.135.106.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 372E783EF9
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 23:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1780435820; x=1780695020;
 bh=O3dUPD3mVzQFgXPf84ylwsb8G5+dEs60lwiIfegFPTg=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=aM/d9mVaAgt2twECHNpyVz5VQ/PcXjzhfFuyR/oW9uL2bUsCHwOufv/MnALKgIVej
 NpGaOSvLwMunGqWrZn808KMNotUD/eKR4T9AdFBrsBQRt1QzxGAODFt1x918b3PM0Y
 pBmhTc+WcfTg9Ttl5d9biuic/Jn/UpKplVuhoWZlCkxX+CrB2sG6JNCwiPKkmT3fl2
 aAY9SNnXglqW5/6Reeq2dvMHrHzRrg3v/H1IwGEyzw5H4x9gBo54Yg1Q1k6nVnCLfD
 nROE5I0nYi9YMmaHENCF26QEv5gXI9ES275gV8YiN/naJY9iKoOKHRJ6JGMULSigJj
 e5AEn6SDK1p4Q==
X-Pm-Submission-Id: 4gVPBM6Ymwz1DDLQ
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v4 0/3] allow control DTB to double as "FIT image"
Date: Tue,  2 Jun 2026 23:30:10 +0200
Message-ID: <20260602213013.558064-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jun 2026 02:23:44 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The commit message for patch 1 explains what it is I'd like to be able
to do, but here's some more background:

For a long time, we've embedded the boot script in the U-Boot binary
by building a bootscript.itb, and using a .dtsi like

  / {
          config {
                 bootscript = /incbin/("/path/to/bootscript.itb");
          };
  };

which in turn is mentioned in CONFIG_DEVICE_TREE_INCLUDES, that
bootscript.itb FIT image has been embedded in U-Boot's control
dtb. Running that was then a matter of doing

  fdt addr ${fdtcontroladdr} && fdt get addr bsaddr /config bootscript && source ${bsaddr}

There are a couple of advantage of having the bootscript (and other
script logic) embedded in the U-Boot binary. First, there's no need to
figure out some separate partition to store the script in, and making
sure that gets updated whenever the bootloader itself does. Second,
one doesn't need to worry about verifying the script; whatever steps
one needs to take to implement secure boot for U-Boot itself will by
necessity also cover the control dtb (if nothing else then because
that's where the public key for the kernel verification lives). And
third, the boot script is automatically updated together with U-Boot
itself; and if U-Boot is stored in an eMMC boot partition, that update
is guaranteed to be atomic.

Now with the stricter requirements of libfdt starting from v2026.04,
the above command no longer worked, or only half the time, because the
embedded FIT image may not land on an 8-byte aligned address. So that
line had to be changed a little (line breaks added)

  fdt addr ${fdtcontroladdr}
    && fdt get addr bsaddr /config bootscript
    && fdt get size bssize /config bootscript
    && cp.b ${bsaddr} ${loadaddr} ${bssize}
    && source ${loadaddr}

which is getting quite unwieldy.

Then it struck me that one could perhaps simplify all of this quite a
lot: Cut out the intermediate bootscript.itb, just create a .dtsi
which directly puts a /images node inside the control dtb

/ {
  	images {
		default = "bootscript";
		bootscript {
			description = "Boot script";
			data = /incbin/("/path/to/bootscript.sh");
			type = "script";
			compression = "none";
		};
	};
};

and treat the control dtb itself as a FIT image; so the command to put
in $bootcmd becomes simply

  source ${fdtcontroladdr}:bootscript

and embedding other pieces of callable scripts is quite trivial.

And that almost works out-of-the-box, except for the fit_check_format() sanity check.

Introduce a CONFIG_ knob that allows one to opt out of those sanity
checks, for the special case of the address being checked being
identical to gd->fdt_blob.

v1: https://lore.kernel.org/u-boot/20260512161631.284143-1-ravi@prevas.dk/
v2: https://lore.kernel.org/u-boot/20260519225458.5587-1-ravi@prevas.dk/
v3: https://lore.kernel.org/u-boot/20260529194621.1470583-1-rv@rasmusvillemoes.dk/

Changes in v4:

- Wrap comment at 80 columns (patch 1)

- Remove sandbox condition from negative test so it actually runs on
  some targets (patch 3)

- Include Simon's R-bs.

Changes in v3:

- Factor out tail of fit_check_format (verifying existence of /images
  node) to separate function, instead of using goto.

- Reword the config help text to emphasize that this is safe to use
  even in a secure boot setup.

- Put test cases in separate function to not lose coverage when
  !CONTROL_DTB_AS_FIT, and add a separate function verifying that
  source ${fdtcontroladdr} is always rejected in that case.

- Change author email address to private address because company smtp
  server (*cough* office365 *cough*) can apparently no longer be used
  for, erh, sending emails ?!

Changes in v2:

- Guard this behind a CONFIG_ option

- Move the exemption logic into fit_check_format()

- Add a section to doc/develop/devicetree/control.rst describing this feature.

- Fix and improve the included tests.


Rasmus Villemoes (3):
  image-fit.c: introduce CONTROL_DTB_AS_FIT config knob
  doc: develop: add section on embedding scripts inside control DTB
  test: hook up test of allowing control DTB to act as FIT image

 arch/sandbox/dts/sandbox-boot.sh      |  2 +
 arch/sandbox/dts/sandbox-inner.sh     |  4 ++
 arch/sandbox/dts/sandbox-outer.sh     |  4 ++
 arch/sandbox/dts/sandbox_scripts.dtsi | 24 +++++++++++
 boot/Kconfig                          | 13 ++++++
 boot/image-fit.c                      | 24 ++++++++---
 configs/sandbox_defconfig             |  2 +
 doc/develop/devicetree/control.rst    | 58 +++++++++++++++++++++++++++
 test/py/tests/test_source.py          | 31 ++++++++++++++
 9 files changed, 156 insertions(+), 6 deletions(-)
 create mode 100644 arch/sandbox/dts/sandbox-boot.sh
 create mode 100644 arch/sandbox/dts/sandbox-inner.sh
 create mode 100644 arch/sandbox/dts/sandbox-outer.sh
 create mode 100644 arch/sandbox/dts/sandbox_scripts.dtsi

-- 
2.54.0

