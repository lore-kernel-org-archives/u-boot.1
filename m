Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CE2C28B30
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 01:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BE7D810F2;
	Fri, 21 Mar 2025 02:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MdjqyVgR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B5B2810FE; Fri, 21 Mar 2025 02:31:29 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3A9580756
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 02:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-476f4e9cf92so10310811cf.3
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 18:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742520684; x=1743125484; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p27JZ9cC5kgAgZt62oStiro/vLx02Wj7C/gb6sf5NL8=;
 b=MdjqyVgRmykh4ov5gM6x+/tOp6xfXfylA7Z6XIAzUj2zAjvJmzHWcQ+xfx1h2dYPKj
 9ZyLNstTHbViEioShJvF+yuWuQiqmI71+cvS/XLjFBuLRnvchmoqtuI5wa5lLyjbqZ0m
 jK4/u++y0B8A9X/k4nea4fVl8yRl8YzUbHMI9KsshGkSdTf8pjZgSAB/ZsNQiAT0Ye1F
 72/ceHeunhlUTuohgXN2LaEhVeVQ8iNozO2a6OTOB6yrHUpiC2wjwPotSnWTd8I+Fs4B
 Bw1yM36v29IwXJ7cBlOXFjSnwaJzbTaUp/TCYWqhGLgTUUpnPm4cJrqKjp9wIqyg8Kod
 3MRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742520684; x=1743125484;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p27JZ9cC5kgAgZt62oStiro/vLx02Wj7C/gb6sf5NL8=;
 b=V2iVJw1WzIN0KLWhgBYvRHetGu/ZkP+P8+qdy3ys5ZVPgXIK47/UIwR/VU8Dxi7pt0
 x4wzZSypxNl+ce9QkclclbNRxKLK/09HxVpIOruqWsqFpZfnc63j1ZrCY8gj16WK5jjM
 Uvdvl2dKxpmN0gxKSkkQGM+qptbvNx1t0P272sb/tgOoZP4kML6OLkRTYwS4JYq7JF77
 CXbwVsMpayfM/fGyqgvx59VlMVqGqzdxu0qUZNJc2Utk4b15snIsbrNR7IQ7GFrM0Kqb
 v0uoX7NAb/jlbt3GIA8HQOKRhkyXYitm/jMHDlTGF2QQL1GQxNPagYrfBZn9pOnc2il0
 mg6w==
X-Gm-Message-State: AOJu0YyDpT+0xEusCC/wH/3maFiq+BiQ8YOD9Oyq1x9Hg12rkxJ13Dn1
 QlA8X+ybKvzYxfht9IvNsCpYlnB74G1bW28QugHjcgeMpEXaMXRyYCuB4w==
X-Gm-Gg: ASbGncu6tCM9iJCKtk6WTMr8qrQu0lpGbA4u0rNExo8uUEG8g/EayJ/Zs+UbAR3ZMbF
 tb1ofQcFtA7VpO+ezHd6pl7OhZe+cbPiJsBJEAxIh8Tbq76bOFEjOhz2O5K1sd6LZ/X2rdpBhSO
 4cvwge0htzKY9NY2WKf4FdJiZN+kadd259uDnSxb5H3fX07li8vq/0iqMHcLMn17xkdN0spiPxk
 FlHs5cFWUrsk935ntX9D27rtPytUAHRJWfgaV9n/+0trgLoXYNZSGgaUSw5phVYslHIVIkycjhC
 uoBaAN4rPQbv8b/DN06EolzBDAXct6JrKTKMMo283J9ZudfrO/b/X4XooRAlQfn3gosKTjmYBat
 DqDDc94dSasZvACY9fnXBSFCQKB7W9w==
X-Google-Smtp-Source: AGHT+IHIszNmf4opKjgHEBuNAwq4hdqCkSs+wm4chG5n9I/zyOYA+T8ldh2/M1fOgBOnPbtb7eSN8w==
X-Received: by 2002:a05:620a:19a3:b0:7c5:4278:d151 with SMTP id
 af79cd13be357-7c5ba211387mr228825885a.43.1742520683850; 
 Thu, 20 Mar 2025 18:31:23 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92d0137sm60501185a.31.2025.03.20.18.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 18:31:23 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, marek.vasut@mailbox.org, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Yannic Moog <y.moog@phytec.de>,
 Sean Anderson <seanga2@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V2 1/5] imx: imx9: Imply IMX_TMU
Date: Thu, 20 Mar 2025 20:31:01 -0500
Message-ID: <20250321013109.709431-1-aford173@gmail.com>
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

If the CPU Information is displayed from imx8_cpu, it displays the
cpu temperature grade and operating temperature if CONFIG_IMX9 is defined.
This behavior is similar to what happens arch/arm/mach-imx/cpu.c except that
the latter checks for CONFIG_IMX_THERMAL or CONFIG_IMX_TMU.  In preparation
to make imx8_cpu act like the previous implementation for any CPU, make IMX9
imply IMX_TMU so it will be always displayed unless a user decides to
disable it.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/mach-imx/imx9/Kconfig | 1 +
 1 file changed, 1 insertion(+)

V2:  New to series

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 49220c0955e..c3e758e103a 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -10,6 +10,7 @@ config IMX9
 	select BINMAN
 	select HAS_CAAM
 	select ROM_UNIFIED_SECTIONS
+	imply IMX_TMU
 
 config IMX93
 	bool
-- 
2.45.2

