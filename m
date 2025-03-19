Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59EAC282EC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 01:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9DE48129F;
	Wed, 19 Mar 2025 02:43:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ieCbt5XC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C429815D1; Wed, 19 Mar 2025 02:43:15 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E091C805C3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 02:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7c0a159ded2so867222685a.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742348590; x=1742953390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lAgUvdDRiGxdW45SZg2Uft2v4KbWfJAIbiz3XTpIIXY=;
 b=ieCbt5XCO0J8kKZ2Uu1byBapFCakenGHyNQE1ray9gN05SuoPesBh0g98xIDzwo8K+
 jULDly9Teh59iGqjOjdG10W1AB40+wOhQT1K4F79Ir2ymzjAShj3B7XV6sWd/V/7Le0C
 Bj6djQzd5TjPiJs8m64VISbowXDxTRBASaCU8QamOaFQQB/ZoFBr4xqni04qOcAjYsuN
 h7A0BDbApcEt0aOr0Zi05ebwGRsI28SkemnWLpmwaX33IFMJnSBg82PCh82OIz2sK9yV
 j9nAhyqVZrmpPtNooTpGW0lzAVvEqva5bENrrivJTYfNJZs7csyAjgf+/tT9fSmp5Thm
 av/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742348590; x=1742953390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lAgUvdDRiGxdW45SZg2Uft2v4KbWfJAIbiz3XTpIIXY=;
 b=TEd6p4lEnlohlJkgyiktJkELu1GLS4JGy7xg2IObGUKP5kMOj8jW3A+ex694YYDRwo
 pnKO3DBZC7bQ+hlhtLp8J28CBHeL9FDt40iI0gT0TcrBlRB9o8cqLh/x6HgsXyY5Vpux
 fn52wZWTp4HvjSi2dlZajopdrQtFBZYzH06SnIa8IT3znEl3D6vhYFJQbhU084g6tdup
 GzE5XUgAZT04m3Pw9yZ6z26IgX6z0A8S0MD1K9C6GUDNGcrfvtjwM6OPNUS4XZZalMag
 EriAy2DRWQR7c/4hNnBUJ0qIAR19I4Ue+PTxZ1nNdnbYJXeKa/cSaz984dvPn4SWNxBo
 39oQ==
X-Gm-Message-State: AOJu0YyV+srBgBtIKyt04SU+58N6IriSUqGVBZlF2LYZWzbl8x3rkQuY
 cwRXQsLLOTZQgsuEB0cFAOgxnTPMCv7llqxuCrc+ptC6li6J/YfhUmDx6w==
X-Gm-Gg: ASbGncu8r0/jxM/c8ZiG0dgH/a1chNXKRclcGLz4BtFOcoWywGhl2hIhdTH6auzgOmo
 z920oZicimK1q52rR9VyNH4HbyYrmPDovj3e9B3c8ZmfgCMFkD35QE6x63n6F1xoEyEQ/SHKKin
 kP3UNc5p16v8McNVmdYF8I934dLlOCIu+zfozCgmvwTfqo7NrVOub8iryha/gMg/MFBLCk0/cFW
 5+1wllwSB0m0biB3aqs3a2/rIkNpJP/ndC5lyfysadMVbCUpw3uyXORW+1Gga7o+nWF5QssYlfM
 DM1j+B0OvTclWkIua2mQouBFEdlbKjiCLR3JFt3JIbxvOfMvLooakGeFUldcaBI6YzmCLsdpHKF
 o3OfNubvkAq3TuECpFw4=
X-Google-Smtp-Source: AGHT+IEBbHuqJawzocutR+yL7DHbpOZOHs+/QN/pUmLSyQ9CULFtabs15lST7rmVtwMy6QcjwKdy4g==
X-Received: by 2002:a05:620a:4485:b0:7c5:55f9:4bbf with SMTP id
 af79cd13be357-7c5a827d845mr125877385a.7.1742348590074; 
 Tue, 18 Mar 2025 18:43:10 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c4e6a1sm795871185a.18.2025.03.18.18.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 18:43:09 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Ye Li <ye.li@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 1/4] cpu: imx8_cpu: Print Speed grade if IMX_THERMAL or IMX_TMU
Date: Tue, 18 Mar 2025 20:42:34 -0500
Message-ID: <20250319014240.592189-1-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
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

Much of the data that is display by imx8_cpu.c is also
displayed from arch/arm/mach-imx/cpu.c, except the
speed grade and temperature unless the SoC is an i.MX9.
Expand this to include checks for IMX_THERMAL or IMX_TMU
in the same way it's done for mach-imx/cpu.c.

Before:
CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
Model: Beacon EmbeddedWorks i.MX8MPlus Development kit

After:
CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
CPU:   Industrial temperature grade  (-40C to 105C) at 28C
Model: Beacon EmbeddedWorks i.MX8MPlus Development kit

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 53d31b3c0bf..facd561022f 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -177,7 +177,9 @@ static int cpu_imx_get_desc(const struct udevice *dev, char *buf, int size)
 	ret = snprintf(buf, size, "NXP i.MX%s Rev%s %s at %u MHz",
 		       plat->type, plat->rev, plat->name, plat->freq_mhz);
 
-	if (IS_ENABLED(CONFIG_IMX9)) {
+	if (IS_ENABLED(CONFIG_IMX9) ||
+	    IS_ENABLED(CONFIG_IMX_THERMAL) ||
+	    IS_ENABLED(CONFIG_IMX_TMU)) {
 		switch (get_cpu_temp_grade(&minc, &maxc)) {
 		case TEMP_AUTOMOTIVE:
 			grade = "Automotive temperature grade ";
-- 
2.45.2

