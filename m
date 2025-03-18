Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15E3C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 23:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C26F881A10;
	Wed, 19 Mar 2025 00:42:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fnN+yCOY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 939FA81026; Wed, 19 Mar 2025 00:42:54 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 777A78129F
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 00:42:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-476f4e9cf92so18513491cf.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742341371; x=1742946171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxdafoiS3AUknOcWE+1KLPlmGvHwEnj0u4Sk7yM+190=;
 b=fnN+yCOYNhhvfCvfPLY4n9CjchZRQq+OGxBzDqIZhXLJacGLrTdXVLhEwsIUIavIm+
 IH+doJY67SHAladB9D03WJZ6T6fZnQ0mEPso8aSf629qahIl9p6O+qMgXKrShQnSMwGJ
 sIpL9kTEvjML6krxICxxvgnxYETmhe+ps+8HPibuBna6KXQ4Mmv7Br5eNRrFAXupgveR
 JlmWZm5U3kIIX40XDnT1B1gKsp+XDkYxPO+2FGKJWZJ5q/S+I4evg4OHac47ubm2L9FB
 bMBLIreNXHwqWK6MiIOhEUkuOkz7KOrB3UkWB6/x9S11RaJsUvsgPIVCIl2I2hD7w9cs
 hKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742341371; x=1742946171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YxdafoiS3AUknOcWE+1KLPlmGvHwEnj0u4Sk7yM+190=;
 b=I0OFw/2uca/Dp+JWMJkz9Xp7AEejwSm0NyI/BXz/9ZezINj24wk3PezzxOznccG8AN
 +kLn4Ne9sa0FL9xKxHGu/9zKsTcBgIoAspUwbxXSKFbXOwArSrl1PZz8Nzubh1KIOaSr
 yy+DZagOZKK3wpUkC+KfubopBvAFK2W5XHWEM0S+j+8LuRkQluqEbaT67uegj3RVGIhN
 BgF7aJtSLWtzH9GfNAIxuDidTJP7M2k/8XY5rp2UYaOu/10xFqN9dymcmbKCPMQ9EdaT
 Pek4yZLvM3dolpJZKXPd/BtC+/W50X7bow8fg7TBYbmGWrBesBFPyabArh6iUWu6T9r4
 TMOg==
X-Gm-Message-State: AOJu0YwH7cCAmiXDK/q30FXaaFEYvh55+xhL64hmwmdB4HlDKRQWbFuR
 TwGZzqD5hmCNpyxma2AKVwDP7tepVReLvmiAbINhsqlxvLxBTjDZ9fVTYA==
X-Gm-Gg: ASbGncttpOdZRjhThcNAwbExVonK1kHulanOeO8bLxRkkDdxC7bXaTxu8lRH1fn2Mbj
 TcYFQIs9MXcfKy5zN9Uy2nW23Mk1Q77Zl3n9aHnSPu94KO16EQ+wfa7lcs/CAw6SZP0J8gSpg0s
 3nrHyUkf1kCpKBXmSIR5vXVTMgXK6P3WKNPzCkkMDLTJ3V0HZlBlaWMCaNMgkr/ayY7HARcVeOK
 AWkVmABHpzsei/n6RVInEmpTiz8feCDca9AdGy1jx2EMwoRBeN3tivEmz5SrtHPvtNPcmoSwvtT
 XuUHppcJUjTfJeeX82xQN2A4ZxWdE+o0bnTNbsGZ3swuZ9VASzNEZQadKavpiDMbJ7xlwaTu2zo
 VPmkxbibGmBiUkDBK65Y=
X-Google-Smtp-Source: AGHT+IGJJ5/SZqZYr70UHxXgwYJdVfANJHwfpnePXKSjQwSKA89I1KSA4NSEijTY0FNTuz5erAFzMg==
X-Received: by 2002:a05:622a:4c8e:b0:476:964a:e338 with SMTP id
 d75a77b69052e-4770831f03amr16617431cf.28.1742341370723; 
 Tue, 18 Mar 2025 16:42:50 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82c1b7sm72518261cf.74.2025.03.18.16.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 16:42:50 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V3 05/10] serial: mxc: Support bulk enabling clocks
Date: Tue, 18 Mar 2025 18:38:33 -0500
Message-ID: <20250318233849.587520-6-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250318233849.587520-1-aford173@gmail.com>
References: <20250318233849.587520-1-aford173@gmail.com>
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

Depending on the platform, there may be multiple clock sources
required to enable a UART.  Use the bulk functions to get and
enable the clocks when the UART probes.  This can facilitate
the removal of functions to manually enable the clock.

This is made dependent on CLK_CCF which is used on imx6q,
imx8m[mnqp], several imxrt, imx9.  If/when the UART clock
registration is done for older boards, this limitation
could be updated.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/serial/serial_mxc.c           | 11 +++++++++++
 include/dm/platform_data/serial_mxc.h |  3 +++
 2 files changed, 14 insertions(+)

V3:  Fix second build issue not caught in V2
V2:  Fix build issue when built without CLK_CCF

diff --git a/drivers/serial/serial_mxc.c b/drivers/serial/serial_mxc.c
index c5fd740be4d..28f4435d01d 100644
--- a/drivers/serial/serial_mxc.c
+++ b/drivers/serial/serial_mxc.c
@@ -3,6 +3,7 @@
  * (c) 2007 Sascha Hauer <s.hauer@pengutronix.de>
  */
 
+#include <clk.h>
 #include <dm.h>
 #include <errno.h>
 #include <watchdog.h>
@@ -312,7 +313,17 @@ int mxc_serial_setbrg(struct udevice *dev, int baudrate)
 static int mxc_serial_probe(struct udevice *dev)
 {
 	struct mxc_serial_plat *plat = dev_get_plat(dev);
+#if CONFIG_IS_ENABLED(CLK_CCF)
+	int ret;
 
+	ret = clk_get_bulk(dev, &plat->clks);
+	if (ret)
+		return ret;
+
+	ret = clk_enable_bulk(&plat->clks);
+	if (ret)
+		return ret;
+#endif
 	_mxc_serial_init(plat->reg, plat->use_dte);
 
 	return 0;
diff --git a/include/dm/platform_data/serial_mxc.h b/include/dm/platform_data/serial_mxc.h
index cc59eeb1dd1..52657aa3deb 100644
--- a/include/dm/platform_data/serial_mxc.h
+++ b/include/dm/platform_data/serial_mxc.h
@@ -9,6 +9,9 @@
 /* Information about a serial port */
 struct mxc_serial_plat {
 	struct mxc_uart *reg;  /* address of registers in physical memory */
+#if CONFIG_IS_ENABLED(CLK_CCF)
+	struct clk_bulk clks;
+#endif
 	bool use_dte;
 };
 
-- 
2.45.2

