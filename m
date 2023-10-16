Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D86ECDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 11:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD128667B;
	Mon, 16 Oct 2023 13:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HuxWwmTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A404586BF7; Mon, 16 Oct 2023 07:35:18 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F85B86801
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 07:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=iuncuim@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507a3b8b113so1752633e87.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 22:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697434510; x=1698039310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RX5oUMTvXjyALKUlW8ByqYU+GsWMab76MLfoc4SlNs0=;
 b=HuxWwmTRJ1827R2HyiYP/uFgcwrN8+FUXtJWXOCIv/kUzchBlRmPq1J462h18euOVg
 NCCigiXDA5yyKLu/MUJ3OIrSwhqy+jyQFf4soIucyj0BwgXCedIdULZoDyHVQckIItZl
 0RBTuFuUzNR6GZoJgXwiNawx52wMIkAkH/iaBvrtbO6H7Q/27TLRrOuxlawGzOoQRtSa
 Nhpc39bgW9boZdtauwmGkQSXo4mLcP3fOksle6/7wrXVm+hCVMifzLeOhngu8O2KNPTc
 gJSjpNg7aCCVcgNPTndfdjeQCF1t+deLqytP5KuPKHyUBsKeMSAxuHQ2lfLrda5wTUF3
 ntew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697434510; x=1698039310;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RX5oUMTvXjyALKUlW8ByqYU+GsWMab76MLfoc4SlNs0=;
 b=qaUiv4U3miosBCiSjLCZPCu+4ciiVhBHmMhZB2otX+1q4MLlRYQJH1QzMukh2kJX5X
 HnbrJ1uT+mONMBp4/g7p06ybu3sPce7hF0F2EJVfOHeZo7Za1fbX0E0j5mAWFBSIKT2n
 PdJiaF6049Mjoz/b/J+5oARGv8eo8jkVmtt6vhj9ETZ+HyP3+dLyujZ4A2mgZMESTRCS
 pSkZ/tS+Cx41W3X0np6uiSirdEFjBatKOmzFi6FpNtMoKc8r8WgGurnB3R7HEmnWz8WO
 V75Qd2rs7HK9Py18Uy1HV4aJsjDLOqYD2EcE2vrxa0coiHJfWLktoPY9UtihAW2Iia3s
 gM6Q==
X-Gm-Message-State: AOJu0YzrYlAk+qFRLbrb3KX8hKhR4+rJ7WhnzrFrCj+E49KOvfokDxEL
 tfqisxhvzc3H6JdlkuatOKY=
X-Google-Smtp-Source: AGHT+IGy1WZi3rRSrgv0cf5sRB3Gepqcu2zAG/Ouc5aIHlegv0f34O7lfQEA2rihysGiLI39G4nDHA==
X-Received: by 2002:a19:9111:0:b0:507:9e56:5b1c with SMTP id
 t17-20020a199111000000b005079e565b1cmr5041919lfd.13.1697434510009; 
 Sun, 15 Oct 2023 22:35:10 -0700 (PDT)
Received: from SerialExperiment.lan ([46.251.195.25])
 by smtp.gmail.com with ESMTPSA id
 n14-20020a05651203ee00b00507987edd22sm1527031lfq.156.2023.10.15.22.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 22:35:09 -0700 (PDT)
From: Mikhail Kalashnikov <iuncuim@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v2 0/1] sunxi: H616: add LPDDR4 support
Date: Mon, 16 Oct 2023 08:34:40 +0300
Message-ID: <20231016053441.3197087-1-iuncuim@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Oct 2023 13:49:12 +0200
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

From: iuncuim <iuncuim@gmail.com>

At the moment, the driver only supports DDR3 and LPDDR3 memory.
Add support for a new type DRAM.
These changes have been successfully tested by me with orangepi
zero3 4GB (DRAM: Rayson RS1G32LO4D2BDS-53BT).
This patch should be applied after this:
https://lore.kernel.org/all/20231014170236.16211-1-andre.przywara@arm.com/

Changes from v1:
 * replaced the phy_init array with one compatible with opizero3
 * added DRAM TPR6 parameter
 * adaptation to new mctl_phy_configure_odt()
 * added timings for the board orangepi zero3 4GB 
https://lore.kernel.org/u-boot/20230729111331.173768-2-iuncuim@gmail.com/

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

iuncuim (1):
  sunxi: H616: add LPDDR4 DRAM support

 .../include/asm/arch-sunxi/dram_sun50i_h616.h |   2 +
 arch/arm/mach-sunxi/Kconfig                   |  16 ++
 arch/arm/mach-sunxi/dram_sun50i_h616.c        | 176 ++++++++++++++----
 arch/arm/mach-sunxi/dram_timings/Makefile     |   1 +
 .../dram_timings/h616_lpddr4_2133.c           |  97 ++++++++++
 5 files changed, 258 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c

-- 
2.42.0

