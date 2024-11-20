Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79DDD6C2BC
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 01:22:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E969A89555;
	Wed, 20 Nov 2024 02:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SIvOUdXZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C6DA89555; Wed, 20 Nov 2024 02:22:08 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECCF889001
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 02:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7f809332ffcso282310a12.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 17:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732065724; x=1732670524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AHsaqYjSt+olXUWC5jg88WJFgbX2cIMX937ugfnnvPw=;
 b=SIvOUdXZqKUQFklYZLHCH/q50LNs5QNbct3Ywyv15GTKoNNC2cZtyjXxkTfTUFiFQC
 0CLw9ZE0Kbz9VjFGtHaSF6rwedrzYtkBJXMNFGhc7tdfhfHF7x9+WZyJgm7I5QxMs9Vv
 8XRVdkt1/627cp3+Ad+N/APuOCvnF/4eiXoo3uvbLXBOaipm1zV9MTB02XE+yowGojo7
 Soly1wCAYq8Udhu3SSdabU0bcSzeOyKAUfJ1m5kK3a+3DXEsngaomUHjlOUCFMTpa7pZ
 H9TGa6NEQvaSXHt3LD1RtqtSlhzOPYmdaPsx1csz5Tl7TYH7iN7V1tzMbnQu1G6ro/J9
 djdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732065724; x=1732670524;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AHsaqYjSt+olXUWC5jg88WJFgbX2cIMX937ugfnnvPw=;
 b=Utbd7P6IZFMZH4PlOdNaYHwImWmqwVQy7+C06f8BP+cfAUdEPvsmKyjVwwm8VQu8eQ
 KHqJWB0pCBI8SLVxlAWre/9sFUuuuvbBGrFpXOW03uTYU9z9oBBsvvAby4/UjeyXLK0I
 95dNWqD+acFyrak7TWSonIq9CVVOXxg5268WLMFAvfog1lkQZ1ZN2Qm2LTw7k//sHRZM
 eqCBuRenM4XBaNgtGjj3xlwKy4LY43klBj3dMU2WXr7ukmi1LaSw7ICqBSsWfIscbj4s
 D7DU7fwVzPqam11Vkqo4OoRyvN/6US88BXXtJVj0PLP0hhvljGWjvE3UMeyjkbuH2WRy
 S8Jg==
X-Gm-Message-State: AOJu0YzZgyQd6QE0TRTyygTNFMEwHeCQDd1FxEcG7mhEMSjEJASXQ1bt
 qGs5eRTFayEkbGj/khCAL5hxMNbzjwf/xDEwL2daR0xI9hOxvqbuRcTiWiFM
X-Google-Smtp-Source: AGHT+IEF/KJMsN3ae4Pu5b74FR3YMhegIonfTnV9efg5n9TdPikuENP8Y5+hs+yA0rf161HZ/nru0w==
X-Received: by 2002:a05:6a20:6a13:b0:1db:94ca:660c with SMTP id
 adf61e73a8af0-1dcc0eff8damr8581966637.18.1732065724368; 
 Tue, 19 Nov 2024 17:22:04 -0800 (PST)
Received: from cs20-buildserver.. ([2403:c300:d40e:7213:8c17:76d:53ee:112])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f8c1dac443sm8330992a12.65.2024.11.19.17.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 17:22:04 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] configs: arbel_evb: enable arbel feature
Date: Wed, 20 Nov 2024 09:21:54 +0800
Message-Id: <20241120012154.3335110-1-JJLIU0@nuvoton.com>
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

Enable GPIO_HOG, net, WDT feature for Arbel EVB.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 configs/arbel_evb_defconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/configs/arbel_evb_defconfig b/configs/arbel_evb_defconfig
index 2ef2e253b4..4a58146e61 100644
--- a/configs/arbel_evb_defconfig
+++ b/configs/arbel_evb_defconfig
@@ -106,3 +106,17 @@ CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_LIB_HW_RAND=y
 CONFIG_TPM=y
 CONFIG_SHA_HW_ACCEL=y
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WATCHDOG_TIMEOUT_MSECS=120000
+CONFIG_WDT=y
+CONFIG_WDT_NPCM=y
+CONFIG_NPCM_SGPIO=y
+CONFIG_GPIO_HOG=y
+CONFIG_NET_RETRY_COUNT=6
+CONFIG_IPV6=y
+CONFIG_IPV6_ROUTER_DISCOVERY=y
+CONFIG_CMD_PXE=y
+CONFIG_CMD_DHCP6=y
+CONFIG_BOOTP_PXE_DHCP_OPTION=y
+CONFIG_DHCP6_PXE_DHCP_OPTION=y
+CONFIG_DHCP6_ENTERPRISE_ID=311
-- 
2.34.1

