Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF97C83F0F
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 10:35:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE2AF8318E;
	Tue,  8 Jul 2025 12:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mr2PuAAz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82B6B83043; Tue,  8 Jul 2025 12:35:46 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA19483015
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 12:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-607cc1a2bd8so6831271a12.2
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 03:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1751970944; x=1752575744;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KhVGrwBxYHK3vvLEWCPQWeNAp9bwMKnu9f5y1sbF6as=;
 b=mr2PuAAz2Gb7BLLhCV+bYXRCp4YnLOM2O/xWiKCOjCLqFdiESFucxWeAQ/+REHvdh7
 uFJTuhYR4V+A45brj82g9lb/CfhUwPD3gvUhHSTYyE3f5UAPdQY2Dvx3xv6oJem6QhBy
 qRTc1wuexv4HZoKHLsmggLVTW3fZiirNqRO4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751970944; x=1752575744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KhVGrwBxYHK3vvLEWCPQWeNAp9bwMKnu9f5y1sbF6as=;
 b=T+OtjuHFzSlghYtMc3vLiKH4SIqbIIa4EbJZAHazco6X9yR/x5btsMkISpQTALIYiU
 2R9vQ5wxnXNqbG6fQShNx2uLzMXOJPXY9MuiU12kNpp7dGsgr5kaQgYPDs6uikbF0Vz7
 Z5k8ZIpE96K7M/5cWTM0YcSUAB0tKVPDhZ8zww3WZfLcglNQc5WI97I+W4MhCRnPU3wW
 khWQLi/iFPt7oJWCIGTmXiHmJX0xfbrpoFEJk3FPVZi4DeFkjtYjKuj5lLQ0XZl2I5YW
 ul7xM4ydoFTwfiARveWAivhfHL0o0s1n3PeKKmJiGekKTCOj0R+uFDz8dXEc+bAqyT1b
 STyw==
X-Gm-Message-State: AOJu0Yz3FerfbSmxBXTcPcL5cEto3AyzSsBE1sgGy35+rjj+EqpDIce0
 hcG6ZXFJaLMbbjC6vX00pogPqeUn57cU3EvW9Cs5SBtIg/2OaegZqlyqRl5gsiKomyOOsGGqHRZ
 ZkAlWU0Y=
X-Gm-Gg: ASbGncv638inWqT48+IhwsdeJcLwItlCqBFzRJnKfOsbaArqAjEjOwIGVio63nzGIkA
 8A2MWVwWUfLHiV1irQWLSoiY11D8/cyP9USPGR2ljGIoAkwyanK0rI3viAo3uCs7rGLoNk+jc0u
 E609uEzs14Nx5Q/d7jixhfcvS8/41Q/UY3QVG32THESRWx0s8L1Oi6YKxcXU18hSuz6vzmXBsI4
 4GyfjupGv+xLuDf9uoXbyqQm3pWms/2mD+0HrO52IPi9EnHeKrk8Qbv+I2a9viot5pgToEKQKNy
 Kix2/hVRQJxGNk48/AutwVPSE1BL4EqqKojEOEoybJUxjLjs9IQBAmYOnUYzDaetQHaUe3L2p8R
 BA1ILD/CoAqq98sWXrs8TgAFQa7rVNPFrZ5w974DKbbv/ymLh3VjzoVpcQf59zkePwluaP2GNVA
 ==
X-Google-Smtp-Source: AGHT+IFSQF9jgk3UPlo73ZQ/lG5GwUR6FphY64pgIzSAF6/OlEKR1xQe9TnzjvAJJ4O45ZFO+Ba0BA==
X-Received: by 2002:a05:6402:350f:b0:602:36ce:d0e7 with SMTP id
 4fb4d7f45d1cf-60fd65185edmr13317817a12.14.1751970943484; 
 Tue, 08 Jul 2025 03:35:43 -0700 (PDT)
Received: from panicking.amarulasolutions.com
 (mob-176-246-194-172.net.vodafone.it. [176.246.194.172])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60ff11c3e83sm5373473a12.66.2025.07.08.03.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 03:35:42 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] configs/imx6ulz_smm_m2b_defconfig: Enable clock framework
Date: Tue,  8 Jul 2025 12:35:28 +0200
Message-ID: <20250708103537.27632-1-michael@amarulasolutions.com>
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

Enable the clock framework on the m2b platform as was done
in m2 variant. This helps to increase the NAND controller performance.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---

 configs/imx6ulz_smm_m2b_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/imx6ulz_smm_m2b_defconfig b/configs/imx6ulz_smm_m2b_defconfig
index c0eb1093d8b..3d7530431fd 100644
--- a/configs/imx6ulz_smm_m2b_defconfig
+++ b/configs/imx6ulz_smm_m2b_defconfig
@@ -44,6 +44,8 @@ CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
+CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_CLK_IMX6UL=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x82000000
 CONFIG_FASTBOOT_FLASH=y
-- 
2.43.0

base-commit: b379335f141e3ddca0cdbb5d9d39af0444530542
