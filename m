Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4792BC369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 23:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AA2782E38;
	Fri, 18 Apr 2025 01:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UOUcVnzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99A118309D; Thu, 17 Apr 2025 21:39:07 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F1B882CF1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 21:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bschnei@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7376e311086so1611391b3a.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 12:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744918744; x=1745523544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hlwksk0srm7MtC4dQFHip97GP+xy/3p+zMZSwTZuSQg=;
 b=UOUcVnzz6Jod5IuGQ1spVXZO95C9CGWS/sVl1Nq8gaHDRR59dqaNNZ/kGdSMab4jRA
 t4Jk7lwGWT6zFpRoOxej0zg+xAFVc6cmBjf5HxzD8KBjdZUKOH5lVczY5ZQGJ8dLiNoQ
 4GmcOpketrr3baUHiXnwxzp6igal35wKDXmvZIP5JZ/O1hnlcm4fagVMAaaO+z2wpjx3
 M9+2hzEfAJssfIg/ryOXUaETXBL7pHwdZux9Z9IdA8RL3OR7vN3wPFjISkc9JYEY6bfF
 sIRAeo1GE+SSlkqX0q6gasKjfaKhx2Kd/Y6ZE45vzbo0p6TJiUrcWuqRlsCHkMirGLAF
 Vn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744918744; x=1745523544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hlwksk0srm7MtC4dQFHip97GP+xy/3p+zMZSwTZuSQg=;
 b=YRs9ea5jElQahi4BMIU40TnPv//T/u48lvxQJh1h9dWg/Fth4rY72oh2I7f5Z27q5R
 JjHU9nYSNd90VFLklvs42V7TXSyetEWGJ+mseDReVofLm41MPM1cTpU5lDBErGFxjSZA
 66ci2Ket9TnIAqLf8fDaKAV4v7SBwsY07LQ7s5sPMPTYGDXOfjkex0mQOMIs9bSepgWe
 V8TTqc99HRMQbKs9JsGcM2ww6iLJwLdt6lGwfCCpO8hRMWOJweJ4JkO2kAZ7GcH4TI9S
 O0dgTAIuwoHk7ECCySdVWq+u4Zhv8VjeoVSv13Z/Uiq1OOB4+s/A/QeYxuZk1DYX1Thb
 96ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXae937e7R9DXyVVzG9oJ/jVIBq4plrVH9qeeeHZ5k1hphGBlQSq+leqNhbnG1jxdaiXu65LW4=@lists.denx.de
X-Gm-Message-State: AOJu0YwxGXsCHXKd1Ai6tg5xZ67DkQWpznGpbaGXmOW4BxBF8wrmRXpa
 mO3S0U3oTwN8KIfVHGvoZw19E9ryYRxx/IpEU9xSh4Yxs94jmgZe
X-Gm-Gg: ASbGncuSxG8XcTiLMolzW1pXTKEi7O088PgIwyRKzu+2gDKIpoHWEItMM1xAHV066c+
 PgXIYs4QOpHj2+Kpu+MxnSHy9BrvSpyGcD0Y9L2RrjYQGLoTaRVUxflEbKTzy4NBklX0QxLa6mD
 +eOiSdjzMnzYLaGD1tzSJ9UXG3+ihjmQIX4UM8upNF5DlQgGmi9pyAMYz6Gpb/Cbo+NktE8KRdR
 VIPQiVjTOQ3nW2yTwrqSX9X0LBTWFXcNzRN6nrR8eiYk9ejEDLeh7C68pdxFcYv7pG9nx8thT0f
 pYawfedqpXyZywJEC6ea5TJrJ7IsKtm8RB1dRmFTcdG6OKuyuQ==
X-Google-Smtp-Source: AGHT+IGWTnctuXqX3zJJy7l7dtk82ikVSdHaQNFavxX897qKRadSajgsme7W9wwY3lz7c2YO7UhVzg==
X-Received: by 2002:a05:6a00:1811:b0:736:692e:129 with SMTP id
 d2e1a72fcca58-73dc15d0c0fmr111390b3a.24.1744918743816; 
 Thu, 17 Apr 2025 12:39:03 -0700 (PDT)
Received: from desky.home.arpa ([2605:59c8:492:c300:b17:6d0b:3920:6ba4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfaed86csm238208b3a.180.2025.04.17.12.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 12:39:03 -0700 (PDT)
From: Benjamin Schneider <bschnei@gmail.com>
X-Google-Original-From: Benjamin Schneider <ben@bens.haus>
To: Stefan Roese <sr@denx.de>
Cc: Benjamin Schneider <ben@bens.haus>, Benjamin Schneider <bschnei@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH] configs: mvebu_espressobin_ultra-88f3720_defconfig: enable
 hwrng
Date: Thu, 17 Apr 2025 12:37:24 -0700
Message-ID: <20250417193841.106509-1-ben@bens.haus>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Apr 2025 01:35:40 +0200
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

This device has a hardware random number generator. Linux can
use this feature to randomize the location of the kernel in
memory for better security. However, that functionality is only
available if the bootloader firmware provides it. Enable support
for it in the default configuration for this device.

Signed-off-by: Benjamin Schneider <ben@bens.haus>
---

 configs/mvebu_espressobin_ultra-88f3720_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/mvebu_espressobin_ultra-88f3720_defconfig b/configs/mvebu_espressobin_ultra-88f3720_defconfig
index 1cbeee8fcb7..fb8efbdf0b9 100644
--- a/configs/mvebu_espressobin_ultra-88f3720_defconfig
+++ b/configs/mvebu_espressobin_ultra-88f3720_defconfig
@@ -97,3 +97,5 @@ CONFIG_USB_EHCI_HCD=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_ARMADA_37XX=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_TURRIS_RWTM=y
-- 
2.49.0

base-commit: 278be62c052f3a5749c3c7a57bcd307b82dcdc2d
branch: master
