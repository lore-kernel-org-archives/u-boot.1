Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13288C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 15:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8885084942;
	Mon,  6 Jul 2026 17:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Rdyxey45";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3205B8490A; Mon,  6 Jul 2026 17:07:06 +0200 (CEST)
Received: from mail-wr2-x02.google.com (mail-wr2-x02.google.com
 [IPv6:2a00:1450:4864:30::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4867846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 17:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wr2-x02.google.com with SMTP id
 ffacd0b85a97d-47825ef3fd4so39115f8f.0
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783350423; x=1783955223; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TQFHKWEpnhw6cHf6p5ADtDYlW4u9PeVy00NnBccc0XM=;
 b=Rdyxey45KUBUGzu6aYGs0RNs2g6NFAqQmPpJI/0578nakrL6bETqjo0fG1EDn1qCAu
 L7XiqANYSt5SGvH0qjx9XHZlTxZB9i6uuBlHbp0rHJoEPrmi82NNioeU4KeR1CR05rrI
 XRJaxo//Ukwg/a3cLarlWPCJ6GH5vW+6y4mUqYdaA5cqBhCY21XicvifbAW0JmqiE4Ns
 tmpmyHsOgrCohzsICv7EhZNksd8eu6oYegAtFuVDBSO7zB4R/oCEt+CuqF6YFk9RDUPp
 4hhTNG89WH6/U2Q1XakwQXRBWgyTd0p1wrJGQRdVW8K5scU6aAWLNIfL8nr6PFdFFMdb
 CyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783350423; x=1783955223;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQFHKWEpnhw6cHf6p5ADtDYlW4u9PeVy00NnBccc0XM=;
 b=Ji+GOq9uBsnxADIHKes94gFA3KSRW9ytVfC2OLcdVPtphAXE0SlVnSMe+QSOzmsBz1
 ksLLEWcePICWI50txLgP90J/XuRuN3Ulk85MC0sP13777LEPJlWl5b6kHeXcyn6ojIbd
 SjY51R9MZDz2sf53+KduPa0OuJQH2yQvl/VJ+mV+NdkTdV/j9XeB/R24drwu9HklGQcK
 OzPHpjDFDYvA4xqGSzySRE1yzqkiVNdXfUJdqAmzZJssFt2EPRanMdqOEXU8o+SVbmGZ
 fQ/TFm1hltUUZkd4lDHBSajMGahU3oA8Mz07GW+INx3GXoVTnwlwYn9DGd0hPdjYjJC/
 20TA==
X-Gm-Message-State: AOJu0YxNXtorwY4sK+RJlnfuACln4ktC/sVtAVdokavBm10WYJyGSa6Q
 RMvvUK9Zs1MAogFLp5AbyhmeO7yroKkY7ajnDhEUmRH6biYsfyVbsov6RZ1rCHg1vGc=
X-Gm-Gg: AfdE7cknxtBULX+T0MjEavuKCopC5pnBF6aA1JeJvMCOneJhJ5a2y5pksIkOwSMWufc
 X+29eugf6mIeQl+Osox+7BQRFJCu0tfPnva3WWN3wfhwFHBGu0DsWt7y/z1J47rDp62qOmJU0An
 O4VuyrNOFOi8CFHpLzm2T0evfKcwAT2vhanlEawITnKSB4McD5LKWNxmqUMs8hmdlkwJAOTJwZ3
 MPWcupvJ2HBKIwqVzzsuy9VvVLjNt2eqOjPiaJOzJOq/8OjOEMaOWXJIZ4OKxVzXGyaWWXFjd9H
 7LPvo7oJJfsFZErcFoMRefGLbD5tjtKekR7hydFM56afBBC3vmGfY+9OJNMjo25yq7SHGJrYkPg
 aFB9I70szGvvZrDCyxjSnwTKvFRGugBo8pZz0b/0NEgIaHbF8aL+j0d4/FzXShvGbCAyZpZdE6K
 ED7oKA27rfVuWs39eiF+Ygbic0nVXNT34HK179OEHoFSJVmNHsY752Nvqk1Spbx3ztGlg=
X-Received: by 2002:a05:600c:4584:b0:492:3fb5:3a17 with SMTP id
 5b1f17b1804b1-493decb3dc8mr14742355e9.2.1783350423165; 
 Mon, 06 Jul 2026 08:07:03 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it ([95.236.170.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce03fa1sm281421265e9.11.2026.07.06.08.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 08:07:02 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH 0/4] bootstd: firmware-owned devicetree for EBBR /
 SystemReady IR
Date: Mon, 06 Jul 2026 17:06:41 +0200
Message-Id: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCQAyF4auUrA3EGRjBq4iLTEw1grUkbRFK7
 +5Ylx+8968Q6qYB524F18XC3kPD8dCBPHi4K9qtGRKlQicqKMJtojiPMbnyC7VWx0RFMlXNnBn
 ad3Tt7bN3L9e/Y65PlekXg237Ah6VqqF5AAAA
X-Change-ID: 20260706-ccaione-upstream-ebbr-206c30be3a3a
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, Anshul Dalal <anshuld@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Javier Tia <floss@jetm.me>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Martin Schwan <m.schwan@phytec.de>, 
 Michal Simek <michal.simek@amd.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
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

EBBR-style firmware (SystemReady IR) owns the devicetree: the OS is
booted via UEFI and receives the devicetree from the firmware through
the EFI configuration table instead of shipping its own. U-Boot has
the handoff mechanism (efi_install_fdt()), but no generic way to say
which devicetree the firmware owns or where it lives, so vendors carry
downstream commands for it (e.g. MediaTek's dtbprobe) and every board
reinvents discovery, selection and authentication.

This series adds a bootstd-level facility for sourcing the
firmware-owned devicetree from a FIT manifest on a dedicated GPT
partition:

- one FIT image ("fdt.itb" by default) on a partition identified by
  type UUID and/or name describes and carries the base devicetree and
  its overlays. FIT configurations name the bootable combinations, so
  signing a configuration authenticates the base, the overlay set and
  their ordering in one go;

- the control devicetree points at the source: a 'firmware-fdt-source'
  phandle under /bootstd referencing a 'u-boot,firmware-fdt-block' node
  under the owning media device;

- configuration selection: compatible best-match against the control
  devicetree (CONFIG_FIT_BEST_MATCH), then the manifest default, with
  environment overrides for explicit choice (one manifest can serve
  both a vendor OS wanting the full overlay stack and a generic
  distro wanting the plain base tree);

- both EFI launch paths consume it, the EFI bootmeth (disk and network)
  and the EFI boot manager, all funneling into efi_install_fdt();

- fail closed: once a source is configured, any failure to produce
  the devicetree ends the boot rather than silently falling back to an
  unverified one.

Patch 1 adds the core helper (source binding, partition lookup,
manifest assembly and selection); patch 2 hooks the EFI bootmeth,
disk and network paths; patch 3 the EFI boot manager; patch 4 adds
the sandbox tests.

For more details please check the RFC at [1] (or the commits).

[1] https://lore.kernel.org/u-boot/140504E6-5BCB-4566-A03F-2A94B0F5BA01@baylibre.com/

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Carlo Caione (4):
      bootstd: add a firmware-owned devicetree source
      bootmeth: efi: source the devicetree from a firmware partition
      efi_loader: bootmgr: install the firmware-owned devicetree
      test: bootstd: add firmware-FDT source tests

 MAINTAINERS                               |   3 +
 arch/sandbox/dts/test.dts                 |  24 ++
 boot/Kconfig                              |  23 ++
 boot/Makefile                             |   1 +
 boot/bootmeth_efi.c                       |  81 +++++++
 boot/firmware_fdt.c                       | 382 ++++++++++++++++++++++++++++++
 configs/sandbox_defconfig                 |   1 +
 doc/develop/bootstd/firmware_fdt.rst      |  94 ++++++++
 doc/develop/bootstd/index.rst             |   1 +
 doc/device-tree-bindings/firmware-fdt.txt | 149 ++++++++++++
 include/firmware_fdt.h                    |  78 ++++++
 lib/efi_loader/efi_bootmgr.c              |  50 +++-
 test/boot/Makefile                        |   1 +
 test/boot/firmware_fdt.c                  | 292 +++++++++++++++++++++++
 test/py/tests/test_ut.py                  | 110 +++++++++
 15 files changed, 1283 insertions(+), 7 deletions(-)
---
base-commit: a3f393c02cf10f44310c6ddf3dedf354c2e877a0
change-id: 20260706-ccaione-upstream-ebbr-206c30be3a3a

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

