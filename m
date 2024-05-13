Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DC6C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 18:17:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FECE881BC;
	Mon, 13 May 2024 20:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="FAE6v39m";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="aPj37DL8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B2858830F; Mon, 13 May 2024 20:13:11 +0200 (CEST)
Received: from fhigh2-smtp.messagingengine.com
 (fhigh2-smtp.messagingengine.com [103.168.172.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 183F887D08
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 20:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id D65651140118;
 Mon, 13 May 2024 14:13:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Mon, 13 May 2024 14:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1715623987; x=1715710387; bh=7s
 MqLPVaxj0touXlN17Ov6NosGmWiAW35u8vT/HRAEs=; b=FAE6v39m+ZTKsiVvGE
 InYFogheNptzC1PPaivGIzn3NY1fhHsN0mOCjkoRsKscXQzgOnRTND/2M6Gnd+CU
 /qsrP7sM/dIAAzjcwyaFdv6pztykq+xET7Vw5dG0o1NrjsW3//txkmNq5ffilRcI
 sNNF8FlEW7u5Cgh3cBVTcwTqnO2vXWqSV7Mij2bT5VauEb9Xu4cuagbcOR7Dhm1A
 1hZPB974KGxUdath3ky/k3yK1FGlfvHuvHiCQ79H4etZkQvaEakMUnT2t5ptVqVF
 qkTHV7eQrU68U/IDA8KNY7owKsBJ0xu7qzPCZeis8aVpxlLqn3bQRKqXlbRTe9r3
 wMmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1715623987; x=1715710387; bh=7sMqLPVaxj0to
 uXlN17Ov6NosGmWiAW35u8vT/HRAEs=; b=aPj37DL8Kg9b98SD6ADl6B+gocv3F
 ID7WO3/sd13W5QcLJZCs4eh9VNK8eZXbFyGfL/YsOmannxuihLGIhC2x8lLNGZem
 LblR2S5f/uInbxCcf042eCEJnjXWC4x4sfrUxjMmDpQflLAMom2T1AUbSTTS0ro6
 eyDt0m3FsVbL8Ez6Gowrdwj5DqkujF4f3oMtKVe3q3tBucgYciVNXkGVpFjdnHGQ
 3XjGBLEGZ5kiGDrHOs4wpv0uv5IlspDOnrN/8O35uw/hBrcrJ9p1FghIP0I1guqI
 sNKAmH3kHIHj/kPrIlgOe5UjlUBjJ28pZbr7HEpIYq34zHOnQ7yty44MQ==
X-ME-Sender: <xms:M1hCZgTgiO6-NjpbQBVcXxPupYs-QFGSmR4LQhXECVV5f6fH7qxR6w>
 <xme:M1hCZtwVMc2L_ZsPlyPXsbcijJdyr62BPdPGWms35OFV-WGHOPfTLNFEYX5Hl0LaJ
 _2H5fbbcO21cybFnmI>
X-ME-Received: <xmr:M1hCZt1Oul20qxf2Zf4xPMtcjtadHbYpW9j4QXAIKloRPoE2NBDTYoI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddvtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpedufffffffhueehvefhgfelveekueegteefgeeiieejheefkeeh
 keevudevieegueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:M1hCZkCOzek7Qqchv0k9yMQ4BA6g6DqHvQY03JN9gOXDJi1dj1RycA>
 <xmx:M1hCZpjVlhlBabf42D9BER1gh1RO5qgSrEVEma5P4R99ZvvRkTC4Ow>
 <xmx:M1hCZgoeJqKNuEan3cscb3Fg9NF1DBGTIm-jx5ZPtGHMCfT9_ZgPqg>
 <xmx:M1hCZshXDRnXx966rGhA-VUfVuBcZw5X5wnN9EaE2uXtmxtPAFM6uw>
 <xmx:M1hCZub9PQZ3QxoHfqeBsAaZFkvSLxjHYVW6PEyHrOtg8rMNry4ygHQu>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 14:13:06 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 00/13] MIPS: Boston: Various enhancements
Date: Mon, 13 May 2024 19:12:57 +0100
Message-Id: <20240513-boston-v1-0-fac96938417e@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAClYQmYC/2WMQQrDIBAAvxL23C1qTKA99R8hh2jWZKHVokEag
 n+vzbXHGYY5IFFkSnBvDoiUOXHwFeSlAbtOfiHkuTIoobToZIsmpC141B25nmar5M1Bjd+RHH/
 O0TBWXrlmcT+/Wf7s3yJLFGiEUKSNbcn0D/fclzBtVxteMJZSvrDHkpqeAAAA
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2782;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=nisqF0Ww/OvSVhzVZ3zZNUUMfcDbjCmXWYkg+tnGkRE=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSnCONNasFhUzebp7gGqvBs36NwY20qw+ecp5X+AnzGl
 +quNW/tKGVhEONgkBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIk8MmH4p+ZtkDDThSFFicte
 XyFJZkIUq7nPhasFZr9MGjZ9Ld4+iZFh61PeJDvj+GlFj3c86c3+456fse2D7f0thboOG+Y+7ot
 gBgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
X-Mailman-Approved-At: Mon, 13 May 2024 20:17:26 +0200
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

Hi all,

This is a huge series which promoted MIPS/Boston target into a
usable state, with fixes to drivers and general framework issues
I found in this process.

I also converted the target to OF_UPSTREAM.

This target is covered by QEMU, to test on QEMU:
```
make boston64r6el_defconfig
make
qemu-system-mips64el -M boston -cpu I6500 -bios ./u-boot.bin -nographic
```

This is my first u-boot contribution, please kindly advise if you
have any comments.

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (13):
      pci: xilinx: Handle size of ecam region properly
      pci: auto: Reduce bridge mem alignment boundary for boston
      pci: Enable PCI_MAP_SYSTEM_MEMORY when ARCH_MAP_SYSMEM is not set
      ahci: DMA addressing fixes
      ahci: dwc_ahsata: Generalize the driver
      MIPS: Provide dummy acpi_table.h
      MIPS: boston: Imply various options
      MIPS: boston: Provide default env vars
      syscon: Probe device first in syscon_get_regmap
      clk: boston: Allow to get regmap from parent device
      dts/upstream: Add Makefile for MIPS
      MIPS: boston: Migrate to OF_UPSTREAM
      mailmap: Update email for Paul Burton

 .mailmap                           |   3 +-
 arch/mips/Kconfig                  |  28 +++++
 arch/mips/dts/Makefile             |   1 -
 arch/mips/dts/boston-u-boot.dtsi   |  10 ++
 arch/mips/dts/img,boston.dts       | 222 -------------------------------------
 arch/mips/include/asm/acpi_table.h |  10 ++
 board/imgtec/boston/Kconfig        |   4 +
 board/imgtec/boston/MAINTAINERS    |   3 +-
 board/imgtec/boston/boston.env     |   9 ++
 board/imgtec/malta/MAINTAINERS     |   2 +-
 configs/boston32r2_defconfig       |   2 +-
 configs/boston32r2el_defconfig     |   2 +-
 configs/boston32r6_defconfig       |   2 +-
 configs/boston32r6el_defconfig     |   2 +-
 configs/boston64r2_defconfig       |   2 +-
 configs/boston64r2el_defconfig     |   2 +-
 configs/boston64r6_defconfig       |   2 +-
 configs/boston64r6el_defconfig     |   2 +-
 drivers/ata/ahci.c                 |  34 +++---
 drivers/ata/dwc_ahsata.c           |  82 +++++++++-----
 drivers/ata/dwc_ahsata_priv.h      |   2 -
 drivers/clk/clk_boston.c           |  15 ++-
 drivers/core/syscon-uclass.c       |   4 +
 drivers/pci/Kconfig                |  10 ++
 drivers/pci/pci_auto.c             |  16 +--
 drivers/pci/pcie_xilinx.c          |  53 ++++++---
 dts/upstream/src/mips/Makefile     |  14 +++
 include/ahci.h                     |   4 +-
 28 files changed, 234 insertions(+), 308 deletions(-)
---
base-commit: c8ffd1356d42223cbb8c86280a083cc3c93e6426
change-id: 20240513-boston-45ef6edc219f

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

