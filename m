Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BE9C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 13:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 977C988B91;
	Wed,  7 Aug 2024 15:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WlnlvZY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2234D88B7E; Wed,  7 Aug 2024 15:40:06 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37AD188BA6
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 15:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f16d2f2b68so29097341fa.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 06:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723038003; x=1723642803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rQXDt47tigEoQ7ei+vXu64hESbcdAVmkKueLCMh64HQ=;
 b=WlnlvZY/ywhQCeVRpISv4Rl6jt0NF9BzdpOGSncQchSTv8wu4r8LSbkDxzMnmb91AV
 bNaSzKE/q9dnJURzKSzN0Y3gnCA7m153a/vYJaD4+f4IiMjBGMLNezMuUSA08Fl/mgI2
 b1DJABn8YFYXnPS8ThrNsDy8xFHBJKT34+57S7okzcLs5p3yaswbRnInSpO1h5PxBKoh
 vz/YBv0Ra2pug6MJuq6LJlfQq5MvdMm+6Owo1xH6oLBUQrXPiqYB9mXBaPLqNIDY155V
 wGt/plXM61pI+dPplyi3T6FioATyDVxhEZYbHXYUax5J5vOo2dT6+By5s0d+y4r6iVlv
 LrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723038003; x=1723642803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rQXDt47tigEoQ7ei+vXu64hESbcdAVmkKueLCMh64HQ=;
 b=MnGn3hbxhw8r9wXMwbSdBqlOw0WMR3UTw7bkdPSEstLuZaEJFXiAuOEUVN7WR1rLgZ
 JhmbTSy59B+j8hdnInnJXMItWqFN2rb4HEyUG6+NiCPIJMdPRmuuayxXqePKArCwa52l
 KCar1taLa60Dxh734esbyuq26cRdzSjWvTvfXTI6DrPA1YofB9Vh+/JRB2xDK4yvdojh
 r6SRUHw+Se25icknNocfET047xiwVOa8xfFO20lpMBwtwGz4me92yprBlqhkmsNecBXy
 RzHxQkcRfN67rYL1i5Ju3310SF5xZprVZ2Q71NVADF6vOTJz3hnpzsLmgjaVLnyZexHW
 655Q==
X-Gm-Message-State: AOJu0YxqC9xjVpR4nJlPYvNGzMrnP34VMQNLLQBA2Feum6qFYIj74AyZ
 ppAGPI/PTZ2O4Ygwk1tjPahDQ7Qr7AhuQDudxe4cFJy6I1ovH0nLIVHfnA==
X-Google-Smtp-Source: AGHT+IGhMml2KhvSsEXnT3KAVDwpul7Zo6DDNOSzxePS4rFOCY8UW2X/mcx/Pwh1io0h/V5roZSeyA==
X-Received: by 2002:a2e:320b:0:b0:2ef:28ed:1ff2 with SMTP id
 38308e7fff4ca-2f15aa88cb7mr149580221fa.9.1723038002243; 
 Wed, 07 Aug 2024 06:40:02 -0700 (PDT)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83a03b403sm7181742a12.42.2024.08.07.06.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 06:40:02 -0700 (PDT)
From: max.oss.09@gmail.com
To: u-boot@lists.denx.de
Cc: Max Krummenacher <max.krummenacher@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH] imx: imx8: fix build when CONFIG_IMX_BOOTAUX is set
Date: Wed,  7 Aug 2024 15:39:11 +0200
Message-ID: <20240807133919.4155815-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Max Krummenacher <max.krummenacher@toradex.com>

Use correct function name.

Fixes: e8cd1f60d964 ("imx: imx8: bootaux: Add i.MX8 M4 boot support")
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/mach-imx/imx8/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
index accba502e492..834aca82bcfd 100644
--- a/arch/arm/mach-imx/imx8/cpu.c
+++ b/arch/arm/mach-imx/imx8/cpu.c
@@ -258,14 +258,14 @@ int arch_auxiliary_core_up(u32 core_id, ulong boot_private_data)
 			return -EIO;
 		}
 
-		if (!power_domain_lookup_name("audio_sai0", &pd)) {
+		if (!imx8_power_domain_lookup_name("audio_sai0", &pd)) {
 			if (power_domain_on(&pd)) {
 				printf("Error power on SAI0\n");
 				return -EIO;
 			}
 		}
 
-		if (!power_domain_lookup_name("audio_ocram", &pd)) {
+		if (!imx8_power_domain_lookup_name("audio_ocram", &pd)) {
 			if (power_domain_on(&pd)) {
 				printf("Error power on HIFI RAM\n");
 				return -EIO;
-- 
2.42.0

