Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E6DC0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 23:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A423C87AB4;
	Thu, 26 Oct 2023 01:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UsatW0pO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAD12874F7; Thu, 26 Oct 2023 01:05:12 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37A6387AC6
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 01:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-778999c5ecfso22308885a.2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 16:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698275104; x=1698879904; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wQ2Pnq1Vm4nfpe2SvuiHVpdZ2ZxELXUlwBH8y1qmak=;
 b=UsatW0pOxRKAQnwmt5ZHlZ8wE3l8mV/W8nV1nv+roVqfxtU6mElZY2D1vRtLt5ZNXQ
 Enkk5SLrZZWlvvPu4kLVTyt1DcgNyaHlNiGXvjgkHKNDlKuihMLu0o6PLVJWbemiokt5
 Vp3DnI9Hd1c0tYyQ3NfMBWO5aFKO/YgzqU9cGF9MGG0gR1xwOYmRfUHYT5UyVTbEXaus
 iakl6B886yTGKrm8n/eTXSfO7ym3P+kdl38Y9z5c10q11PhIqhwK11QHYvWDhHIY0FBV
 hpvkEJ+5OYgdNhTLCvJ5AuD2eVWO4muR7yMHPD+4n8O7OBC+f2n9/AwxlSnT5WtbhaWa
 ufnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698275104; x=1698879904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6wQ2Pnq1Vm4nfpe2SvuiHVpdZ2ZxELXUlwBH8y1qmak=;
 b=Lr83TQgrQp85UYQ8XPXGnWmCbZ/3EaBV+hv7/dj14o0/xwWSVEilUE51lWePqokLrJ
 ukqMMzR6EDSr5ODyiUE5XD55P6MjFM8JtSXgIB5FcqHVozuZLyOc/65LMGof0hNgPvvf
 Ti1437O8+gxrvuD2YiNd5UZR1M7cxLGISfhTk6c7u4UhZN87IdunSkZBP4/cRuQaV+d7
 45w/6pdixveUn0w3v/zLeYAem73Iq8JPCisYkPJqN7/shLFTPdpneuBBR5/uZ0Zli62y
 d+DEVtdzwSVxiIFTiXD5nSahQHHHDxLjTPQ4InWyGqIcVn/b6BZV6PmfUXh9MJMaMJfX
 jiBQ==
X-Gm-Message-State: AOJu0YyMuJUzXdnWdaiYu6QrvDIP7/blwaLkVcFAMtwnzUBQxbwLcrJj
 pAuDvlRmKCUhbeQJONwa9Lvy26q1rkg=
X-Google-Smtp-Source: AGHT+IEuYBZlTatkttK+lf0Xiq3JZl0lS9w+Dtp5BPhbumaJ7yfxkMr9PTgAK2ZAlaph2zby/8zZLg==
X-Received: by 2002:a05:620a:4089:b0:76c:992e:1b2f with SMTP id
 f9-20020a05620a408900b0076c992e1b2fmr18074688qko.13.1698275104217; 
 Wed, 25 Oct 2023 16:05:04 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:449a:a220:d0aa:3d6a])
 by smtp.gmail.com with ESMTPSA id
 a24-20020a05620a103800b00767da10efb6sm4559567qkk.97.2023.10.25.16.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:05:03 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: sbabic@denx.de, aford@beaconembedded.com, Adam Ford <aford173@gmail.com>
Subject: [PATCH 3/5] configs: imx8mm_beacon: Disable the WDT autostart
Date: Wed, 25 Oct 2023 18:04:54 -0500
Message-Id: <20231025230456.7924-3-aford173@gmail.com>
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
 configs/imx8mm_beacon_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8mm_beacon_defconfig b/configs/imx8mm_beacon_defconfig
index 886d912650..b33e113580 100644
--- a/configs/imx8mm_beacon_defconfig
+++ b/configs/imx8mm_beacon_defconfig
@@ -148,4 +148,5 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_SDP_LOADADDR=0x40400000
 CONFIG_SPL_USB_SDP_SUPPORT=y
+# CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_IMX_WATCHDOG=y
-- 
2.40.1

