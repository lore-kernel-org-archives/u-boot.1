Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC59FCD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 20:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 906F384693;
	Fri, 29 May 2026 22:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="jAKDcswy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D544846A3; Fri, 29 May 2026 21:46:29 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA3C1805D7
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 21:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bd8d0e4e341so2063886866b.0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 12:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google; t=1780083986; x=1780688786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iV2thp7XRVnDrCfLG2sSxQkjjVRCWx/njLH9eOSunTA=;
 b=jAKDcswyw/TNygx4vWbnLGZfgpfBVYVr4g59sDMG6ig4/ntn8T3c9E+qhB7NA/4zrp
 WKxm/Xi/8JtbNtJKQk8FK4yUjaHlBmtNP0m4zeWAOq+IpZGUDl5AUASFcS9bBHh4div7
 LbBDbLWE+H8FkOZogyLpewgkzEYvT6GNigyyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780083986; x=1780688786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iV2thp7XRVnDrCfLG2sSxQkjjVRCWx/njLH9eOSunTA=;
 b=AYHYXXy9v/qJtqLd7VxJtRgUBIFGtwvVQ/lcY1M/DuSuzg3kzT8Dkj0fdxkLVH0OFY
 8vONKIPDgq0ixnecXQM51KX3GYkDIDDd31EfiWFd8V0MwmvpNGhEGZHcsch4KO1eqKlM
 wL0wmLVzD5+vIIHP6yDbmZbaRfgvF8mR0YdIwJJLrv/iuGuJpw2kQF+fuXIYJmmxvDEk
 QODvlr6lAFw1MOu33f9fbThHTiUbn64X+NRUgzTkR0vy76hNP6Tlxq7JTHcLo26u4iw1
 738nwD9nJplJkUPJA8jvYV2wh+dMkv/9xNxC6sBAnRJYbnG/ctJUYq5CAbgYLChk89t/
 eYAQ==
X-Gm-Message-State: AOJu0Yz85LSk/yQjjDjpBlt2j0lZor3NGo/H11vF8VDziMWibl3M4Sq1
 t7/JwRB6zmHdTeFwdAUUaOhJ2cp+0WuBvVaeER1CNHV8hNnOmxxMorIDatcCgmd5sQbE5DU3bkM
 2MHDskjo=
X-Gm-Gg: Acq92OG9W5NkWMnMFGL6HvTxidLkUntRalN3sYAJ+cusryvH7F58CdI65+HhRxOfJ4B
 ncbkUiWqQV97//8mTWq+SxEAQDsu3Zm++s1PNTyP8V3Iq/rSAiSo0PGOxa4r7WtEeAnu2HLVYdX
 mvtE64NQXyfnb1By2h6ckwmRH314nOJ8oEzEK6QD2IYFQOhWVqKBp/xHAnDBvghZddrEvG/trh0
 +WYaHPtYu/WZCzrlfZiqLpBO5+92rqlAH5ZhEK+24XnkS0ODQy5QjY9hHrVN1jajVSTabtPq/29
 vR1KteIUv9PNy7Jks/m60H/59BF8E+KkXyeiaNAtAxZAWBFjCQZ/hNuDT/Fni0xrSZk+PUFucbp
 0ZeDj1Bd1/YM80QOON1f4LSrm1p+wlzhy3rfG5Xrn412hcAa13wggm9h0rHGwzurM3kQtF+88gD
 fH67nVCk0NnjsAGl0hqwYd5lush4roUxDcDw/gl272SinNJ2JEEMfGvMI0L/72tRgt
X-Received: by 2002:a17:906:8468:b0:bd2:4aa6:1a9d with SMTP id
 a640c23a62f3a-beab08d8085mr49400166b.16.1780083985485; 
 Fri, 29 May 2026 12:46:25 -0700 (PDT)
Received: from localhost (77.33.185.121.dhcp.fibianet.dk. [77.33.185.121])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68c16317344sm852126a12.29.2026.05.29.12.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 12:46:24 -0700 (PDT)
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v3 0/3] allow control DTB to double as "FIT image"
Date: Fri, 29 May 2026 21:46:18 +0200
Message-ID: <20260529194621.1470583-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 May 2026 22:17:03 +0200
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
 boot/image-fit.c                      | 21 +++++++---
 configs/sandbox_defconfig             |  2 +
 doc/develop/devicetree/control.rst    | 58 +++++++++++++++++++++++++++
 test/py/tests/test_source.py          | 32 +++++++++++++++
 9 files changed, 154 insertions(+), 6 deletions(-)
 create mode 100644 arch/sandbox/dts/sandbox-boot.sh
 create mode 100644 arch/sandbox/dts/sandbox-inner.sh
 create mode 100644 arch/sandbox/dts/sandbox-outer.sh
 create mode 100644 arch/sandbox/dts/sandbox_scripts.dtsi

-- 
2.54.0

