Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33ED7C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 19:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60BEB88B81;
	Fri, 19 Jul 2024 21:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NMSeCUqS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78A0488BB3; Fri, 19 Jul 2024 21:04:07 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 559F988B65
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 21:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-6c2d04b0833so65139a12.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721415844; x=1722020644; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=twnrMbDkein0AOcFFy9fdUcj9hF7OJjlp5xJnG4Bs4M=;
 b=NMSeCUqS9jldQ0zcRuI4ATfJlZxhU+/ttg/wJjf3WrC9jCA0SpLG/lzSOd+uRTGuGh
 za0kdi3QRDUTSh2h2Gs63t2FHaBMVF1c3pj4XJCs9LwfrgxrIdJHQcTwmJHg6+tW1SVu
 mNjCZfReuCNJzAFmf00acro3MZK8thlBb6VnWgaMq4XVz7xICkTkGd4JqE5iBmeIQQQd
 e+NmuxBNPUKiEP2E1ylcU1Mb9m/+8SV7APUkv/C+eIHf5EPSSrmI8Km8rzMQQv6r/w9v
 8Yu3lCWKZgZ6wiJqS/lqobCsksfEIO2DR8bZsi2dh3oUgAXe726TaxZJG+/fwF+xUAcL
 XQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721415844; x=1722020644;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=twnrMbDkein0AOcFFy9fdUcj9hF7OJjlp5xJnG4Bs4M=;
 b=m0HfyUnl1u0rMVuaYPoqdfsO2x5L2XxZoK9n7pN6YTCiUhGuEyhhSNCArtMwfplNIn
 YCluiByEl33S3m5H95YFQcOv35zxIM/z5GNLJczm1zT6/0YtJUHMp3sLOPyOkPdjrcvT
 gYEGIot2AQCEwfzZSQIZ5HWj/jv4q/Tk9/I+ZpJ7IxM7h/hjjjKf/Pe81Fwf3CDZkcXB
 SgVD9WkiUAojaA8OL48Dt7ESs3MN2oUIc63tbAWVDWVa4xLeK8cSDfWGDP0K7RZ1XusK
 Olv/85K8R2xf3Q/7R2xjozfBqB7D7zmNtb6o0gpQGpoSoO0whjCgGrUiaIiKSQdueG5T
 pfmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgOdYjX8AXZZFJIajyScrUtAGdpfZ0ggGKp1QQ3sMKHSwvjE5jvUs7d2xu7CNa3Zk65f9QL1ckEnAL32S0yw18k83VNw==
X-Gm-Message-State: AOJu0YyCEbNHxZwprFhOUnLSho+07q/rB43KsAUcoea0o88tH8VOsnOK
 bkDtiyHXf72CEU7wA9SlrGNbixoW5oaQvfZB/K0ymW1EVo3LYGTCR6XLFA==
X-Google-Smtp-Source: AGHT+IHdS2RfAVPVVqV6OqNGhlk6T9w6Y+A91l4E31b04DRoasuhwwO807Nf7NwaeJV968JH7BDvZQ==
X-Received: by 2002:a17:903:22c9:b0:1fb:1cc3:647b with SMTP id
 d9443c01a7336-1fd7457ea53mr5587045ad.5.1721415843692; 
 Fri, 19 Jul 2024 12:04:03 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:c08b:f396:b4ea:b716])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f48f7e8sm7992695ad.309.2024.07.19.12.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 12:04:03 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: breno.lima@nxp.com
Cc: francesco.montefoschi@udoo.org, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] udoo_neo: Convert to watchdog driver model
Date: Fri, 19 Jul 2024 16:03:37 -0300
Message-Id: <20240719190337.1598053-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
the 'reset' command in U-Boot to not cause a board reset.
    
Fix it by switching to the watchdog driver model via sysreset, which
is the preferred method for implementing the watchdog reset.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/dts/imx6sx-udoo-neo-basic-u-boot.dtsi | 12 ++++++++++++
 configs/udoo_neo_defconfig                     |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/dts/imx6sx-udoo-neo-basic-u-boot.dtsi b/arch/arm/dts/imx6sx-udoo-neo-basic-u-boot.dtsi
index b5e1f2b9a16f..7f5a6424bac8 100644
--- a/arch/arm/dts/imx6sx-udoo-neo-basic-u-boot.dtsi
+++ b/arch/arm/dts/imx6sx-udoo-neo-basic-u-boot.dtsi
@@ -1,5 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+/ {
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
+};
+
 &soc {
 	bootph-all;
 };
@@ -15,3 +23,7 @@
 &uart1 {
 	bootph-all;
 };
+
+&wdog1 {
+	bootph-pre-ram;
+};
diff --git a/configs/udoo_neo_defconfig b/configs/udoo_neo_defconfig
index 4986b4c26260..9f9ad0ad5ec7 100644
--- a/configs/udoo_neo_defconfig
+++ b/configs/udoo_neo_defconfig
@@ -61,5 +61,8 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_ANATOP=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
+CONFIG_IMX_WATCHDOG=y
-- 
2.34.1

