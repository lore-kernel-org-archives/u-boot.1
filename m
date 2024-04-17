Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727BEC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 12:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ACA088492;
	Wed, 17 Apr 2024 14:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JNvMMuFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64D8E8836E; Wed, 17 Apr 2024 10:49:19 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B58B68842B
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 10:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eichest@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-518a3e0d2ecso6835062e87.3
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 01:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713343755; x=1713948555; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KvC5DkgQjtZ8tM1BjbOKRa6fkKPc6s/2w2RM/1XZW9E=;
 b=JNvMMuFf7YYKJTtpRYpBTVq1cOZsTpdOhc3egHaSR3EIUzN7Ip/4D0YVe5Sd/CmG6/
 kSCYMPT6maJ00EUW3VnfAuLJQXiNRK0jp04s580KMQUV9SdyfIC5Ezuagj6eKQKEFPxE
 y/uELn5I4ZwEgE55oYzyue+VinVG84XoDF9sLzjYgC08nvjd4PQIw6cTag8Yx8Q+R8UM
 nqWe+tA86ufPvwGpmmVDIsl9OFaoagzuwilgsTQPiT3oaiyknnyobOPVcLB3ZguCSWqs
 YPhKnokW9LuBEoy9YfF84nmgJbqO6U2wJ46JMSVqpJUHv9TReBfPNEGeA3w7LDlX9658
 Ugqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713343755; x=1713948555;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KvC5DkgQjtZ8tM1BjbOKRa6fkKPc6s/2w2RM/1XZW9E=;
 b=PKqISa7pN6lIZhJ7bTtg1FQP+exxl2aKggb0Df35e54bcweIM7EMjo2aCw1hukXMvG
 y+W0GRAj/DLYPJ+EwxZJ44JvNBeThZUdBsjN5pFBKq0hcqFzwaP3fl+jAHVrzQ0A6S4b
 z6fXJLPMC95TS7WCwBxYDiwAQKGjOM7vHAe10x0LJDJQSEatx2KvmepEvsVitLzA6BKn
 JJCBbe71+xEJEEh0CzvSJJ31elDXuyY35xODeisb4jsn8JTZyFefbFKu83RNyzZUqTsI
 b54v8sGclLl5OKNXz6JSkkUpPR6rFAYO6PzjvUPcx8BBIocuL48BHJUR93hWj2lHbwXt
 aKng==
X-Gm-Message-State: AOJu0Yz0Px00x2LIVLB+MTQiPT2myuC4QuZxGslLHbI8McLJblj3xijr
 SOpKZcik2BqLN8BuwcpdgBK/mJvhGn7zSysU6PVknJu9zdy8UsW2
X-Google-Smtp-Source: AGHT+IFOp/CyTiRcW0/9oxI+9z9iV3VNtmhbG3bZGZs0ZhFncEwSNQPd/noEkLZ7c4zrVNyoMx3Emg==
X-Received: by 2002:ac2:51b6:0:b0:518:bd37:606e with SMTP id
 f22-20020ac251b6000000b00518bd37606emr8134806lfk.13.1713343754671; 
 Wed, 17 Apr 2024 01:49:14 -0700 (PDT)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 w6-20020a1709064a0600b00a5209dc79c1sm7953155eju.146.2024.04.17.01.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 01:49:14 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: marcel.ziswiler@toradex.com, sbabic@denx.de, festevam@gmail.com,
 uboot-imx@nxp.com, trini@konsulko.com, francesco.dolcini@toradex.com,
 emanuele.ghidoli@toradex.com, tharvey@gateworks.com,
 andrejs.cainikovs@toradex.com, stefan.eichenberger@toradex.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] arm: dts: verdin-imx8mm/imx8mp: use gpio-hog for sleep moci
Date: Wed, 17 Apr 2024 10:49:02 +0200
Message-Id: <20240417084902.13904-1-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 17 Apr 2024 14:36:56 +0200
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

In Linux, we allow sleep moci to be turned off when the carrier board
supports it and the system is in suspend. In U-Boot, however, we want
the sleep moci to be always on. So we use a gpio hog and disable the
regulator. This change is necessary because we switched to upstream
device tree files with commit 23fe2def1edf
("verdin-imx8mm/verdin-imx8mp: move imx verdins to OF_UPSTREAM"). A
recent upstream patch removes the gpio hog from the Linux device tree,
so we need to add it to the u-boot dtsi. The following patch will remove
the gpio hog from the Linux device tree:
https://lore.kernel.org/linux-devicetree/20240405160720.5977-1-eichest@gmail.com/
The U-Boot patch can be applied without it and will not break the build.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi | 5 +++++
 arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
index 38db56059d..8b397f535c 100644
--- a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
@@ -60,6 +60,11 @@
 
 	ctrl-sleep-moci-hog {
 		bootph-pre-ram;
+		gpio-hog;
+		output-high;
+		gpios = <1 GPIO_ACTIVE_HIGH>;
+		line-name = "CTRL_SLEEP_MOCI#";
+
 	};
 };
 
diff --git a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
index 03f211d5f7..7b45a87450 100644
--- a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
@@ -58,6 +58,10 @@
 
 	ctrl-sleep-moci-hog {
 		bootph-pre-ram;
+		gpio-hog;
+		output-high;
+		gpios = <29 GPIO_ACTIVE_HIGH>;
+		line-name = "CTRL_SLEEP_MOCI#";
 	};
 };
 
-- 
2.40.1

