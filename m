Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E24C25B6B
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 23:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8777187ADA;
	Thu, 26 Oct 2023 01:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="USljwUd3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66D4787AD7; Thu, 26 Oct 2023 01:05:14 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20CEC87ADE
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 01:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7788fb06997so23500585a.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 16:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698275106; x=1698879906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kB+EonsTxxMtnART8l1gvf9OyQ2V+zkMlnCmyb2IUEo=;
 b=USljwUd3TVMakVrW4qILPB0TKYs1eETxSvyGEn+EGBquMXrL00xaUM6SpYjvenWq8p
 OrmJr6+zuJX1sQdT+T3caU+5S8fQMbh7vJRH598j3KclkfOCMPlxl3D5MAbjWtJ71+Dd
 S5aVgMgn1uSFL010St73sEFgbDyp2uu0vb5AeUPfmAg1ItscgoiBqti8FOKdUNXndK6O
 ZFIktWWFcYu9+EehxyliF5IR3qQJTRQKjHAQMnf9L+FQt+v+4Nk8DWMHJzKSUezTGUbv
 asrAK/7t+om8aXH0QPUoU2Z3+De2NwdJuoShcpLBc0ExZmM1BT46TWv8TiMrprm2lHAt
 Ql7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698275106; x=1698879906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kB+EonsTxxMtnART8l1gvf9OyQ2V+zkMlnCmyb2IUEo=;
 b=W+CejH/+RmXPVxnXldF21TyuOd0974HNu0OoAqpN5DMYRATajbdMmuccERlfMwh/rL
 3Lj5Y9m5V7sg0aBU1uiO9Y9rkmCpTBoeuCyPjwjs2RCP4uIKng+PM5v7qCcMxkRAJW6j
 JxBULpHI9g7cFHG6zB9HPfpKUa3Rs/yts/63R8b+rqLGruWYGnMAX4u2Pp9uCvuPR8RY
 sRUFQvsHlV9XBDr0RssAPhY771vBBWYAOG8fiGTvq2HL4dLqCOHe4HP3r7KeaBxWjscH
 Q2yu7pe/t79MXgztt+YqJrBGO+pyjy642S1pIH5w3p5nA68wXOAUu9eDnRY8HhkSoYym
 ZBQA==
X-Gm-Message-State: AOJu0Yz2/M0IWo18NCddCS7ZWisdIFCkKQ/bjLTX6u9ybMgR93OygR8g
 Y3pEzmeeO1LnNDXma+b1mXcBFtBDcaU=
X-Google-Smtp-Source: AGHT+IH9go1eAJBy/XfmZ1BvUnUqWE3grJ2FiQczXCE2gl/V96JQiZ/aaQBPwl/Tc2tneSfxmvF+6g==
X-Received: by 2002:a05:620a:3951:b0:775:cf5f:8a81 with SMTP id
 qs17-20020a05620a395100b00775cf5f8a81mr19259069qkn.62.1698275106435; 
 Wed, 25 Oct 2023 16:05:06 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:449a:a220:d0aa:3d6a])
 by smtp.gmail.com with ESMTPSA id
 a24-20020a05620a103800b00767da10efb6sm4559567qkk.97.2023.10.25.16.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:05:05 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: sbabic@denx.de, aford@beaconembedded.com, Adam Ford <aford173@gmail.com>
Subject: [PATCH 5/5] configs: imx8mn_beacon: Disable the WDT autostart
Date: Wed, 25 Oct 2023 18:04:56 -0500
Message-Id: <20231025230456.7924-5-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231025230456.7924-1-aford173@gmail.com>
References: <20231025230456.7924-1-aford173@gmail.com>
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

Auto-starting the WDT can cause false reboots when the user
is not intentionally trying to use the WDT, so leave it off until
it is requested.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 configs/imx8mn_beacon_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8mn_beacon_defconfig b/configs/imx8mn_beacon_defconfig
index cfff20f84f..d1c27ce22c 100644
--- a/configs/imx8mn_beacon_defconfig
+++ b/configs/imx8mn_beacon_defconfig
@@ -150,4 +150,5 @@ CONFIG_USB_GADGET_MANUFACTURER="FSL"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
+# CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_IMX_WATCHDOG=y
-- 
2.40.1

