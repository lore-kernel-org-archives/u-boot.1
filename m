Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59663C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 21:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D8898893A;
	Thu,  4 Jul 2024 23:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VMLS+k68";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE8738893A; Thu,  4 Jul 2024 23:22:54 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5CAC8893E
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 23:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7f64942fc54so39597039f.3
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 14:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720128171; x=1720732971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bgrinFvzzloWGU80tiYqCcj1zfsn8P9r07Wk1YNmy2k=;
 b=VMLS+k68xLCqUNjlyYG4WFU4VhGa92FAIOPkEuA/Ohn22myjsSayjyyWwgz1TTy9JG
 3Y6yhKE8XhJdIVK9EyKe0PzNGHyNmzCT2FQKL4DPm7GuhbavQ2hiQ6bU3RptT9lOpkxy
 fM1tlf1wf4+TkUXzvWeGlwTWawO/XfHHEKXb0mZU6pFVw6D+Ylaez0g4p/UxLmOF8+8Z
 IRCbaMShGLCgFlvoXNAEoZLrcyCORYFr4qeXleXZKxbLfKXk2rk2hOw82mdxuyUyTFRx
 5S6yqz6qtfnxqBzVIP8CG9ozT5qF8oe92UHnKh44WCPYsolBDyJJJ2AgjUS0bPtXyet/
 5dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720128171; x=1720732971;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bgrinFvzzloWGU80tiYqCcj1zfsn8P9r07Wk1YNmy2k=;
 b=dZ389MpCi8FQnjLhPDkkF49qCR2VRKvB/CK+sfqSnyUWobs3m3GLLpSGn+Y/alUGwP
 CiXugTct5C8+VHK29MhRMm1a9Z5O0EIx+TVceeNe/x3bIIvnnK87QF8zaYtBFjlp1Ywq
 rc9dMI2Ng6YIuh5JayPzDZLmq31Wt984IeVzwWlnGjEenfMG+nEPVP3/t+FmcfWW9wmS
 0rF7Rw2lz5aPNPexQSjCvyVg5LyKGnHev5W5j70s3AyaczNuSCcqr6iD4F8vKNvJmlyJ
 9t2GDSjDokmiF8gQ1k/Fa1YRa5MA2a3p9TYFf21VcbLQyY7+UlscnmS46WYkhEbKoO4O
 CfSQ==
X-Gm-Message-State: AOJu0Ywk14keb8w2zl3drqqh/2xZfXXdkBaR+xrCpd9X8e5U8aa5yAlf
 OTaRpaQFrsHrmnPxMaJG9vqLtApUtTEGRf4C9mjQrHd49RHifOsXPZJ+pw==
X-Google-Smtp-Source: AGHT+IFOVdtd5vjlywP1bGlaOHPwEx6sSrq5gdBq+JLLYkAIF02PBX2c/V0c1/FWYL6YQcsw60g3rQ==
X-Received: by 2002:a05:6602:6605:b0:7f6:23fd:a27e with SMTP id
 ca18e2360f4ac-7f66deae311mr309888039f.5.1720128170849; 
 Thu, 04 Jul 2024 14:22:50 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:942a:d3ed:712c:8c5a])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4bd4d7cedf4sm1331128173.10.2024.07.04.14.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 14:22:50 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH] ARM: dts: imx8mp-beacon-kit-u-boot: Drop EQoS clock
 work-around
Date: Thu,  4 Jul 2024 16:22:46 -0500
Message-ID: <20240704212247.178521-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Since commit ecb1c37a7b64 ("clk: imx8mp: Add EQoS MAC clock"),
the clocks for the DWMAC driver can be configured, and removing
them breaks operation.

Fixes: ecb1c37a7b64 ("clk: imx8mp: Add EQoS MAC clock")
Suggested-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi b/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
index ed183f83a7..380146596c 100644
--- a/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
@@ -32,12 +32,6 @@
 	bootph-pre-ram;
 };
 
-&eqos {
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	/delete-property/ assigned-clock-rates;
-};
-
 &ethphy0 {
 	reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
 	reset-assert-us = <15000>;
-- 
2.43.0

