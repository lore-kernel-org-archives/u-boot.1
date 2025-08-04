Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D5FC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71BF68401A;
	Mon,  4 Aug 2025 23:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ipcQUNNu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5999584019; Mon,  4 Aug 2025 23:57:30 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88ED183FFD
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3e3d2ad9180so18665095ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344646; x=1754949446; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=K0Pgv6mPfbU8UkjZrtlMnPyl9GATjDurJ7iY8Vc5xy4=;
 b=ipcQUNNu9sZl9K2OS1U5PQcstF6mOfOOPmFA0aazoGdPSK3LRrXVPBWy3/8zEyXjpR
 1AstS1UU87j1HqaL+dXgrR5klW4nQXRaPq7NoHOo2FnPPZwKpQ8YvrFXrH3VDl8ck43f
 +NnFZM1hAMT36V5tmKMqXDA05JD32dq+I8FwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344646; x=1754949446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K0Pgv6mPfbU8UkjZrtlMnPyl9GATjDurJ7iY8Vc5xy4=;
 b=qKBqUVSjifng5MztHgp0stPWLVnFC8FWRUIj1NSZOFDe4ftnOCJvlX0qsGYfKYj9wL
 HvIamzZ5POYSEEJIfJGC4lu2IVStnmIwZsSLUAYoTmrndAb1fDX6cS4bKNSwpY22lkJ7
 xbbvExcajfw8b9jQtI6M0Cg7sLCeElgltI7Bodbq1DHjfeFhHaf59m/AB30+sTw8luwY
 CKOym5DlgKvx6OBOZj6yCupMNbHHBKLu6Izs/oClQ/XI28FKQVso5ViLuGAZOW6AZpQ+
 fFFJ69SVBJOGp5s/+Focu02FShUu544npR2JKGnkMHJsX/gcKjiANAZU4+rA2VqS0CmZ
 n5jQ==
X-Gm-Message-State: AOJu0Yz6GuIg6vquhrV/dTrLtk4LjyzjytTBEnRq/ag7kGSpPVJlSZd5
 +2djpE1MtYPR/f/YUUl56nhHSFvAUi/noi8BFYXw0CT8dPCfqdXAYifVr0VtFadUMRUVQZCH0KE
 YM5B4dUU=
X-Gm-Gg: ASbGncuRy3JmLMprriKUtpuZ2iSDoi+Yc1eTqOAkFjypORvsWO3OpCtWI6wC86FCGwd
 3gMzzaj5Dp+zirvEcAkZfKJ1YBtF+jilBn+Q4l5sDISft+y7a8qFnx5Tlm7HsMNBOgRJRvbKynQ
 Fz6V2r2v0QQ2XkYhL8vebO75QJykhNAM2nsz8qV/ICHB0x9A3dhXbR998UJCOuPxHic8rZHeUIy
 CwRwc2EyYX8iyLZe6n98a/uxH0K+n4kwGNcC1fYsifAl8PYDLThs6mBTdcRO0/j+LfO7Q1dPxfz
 LagY0p2h1pZRm0W4GzE+rISARCMkCV/A9hrFsqPkq4EnphDUKf9XkDN6ivM9Nw0RPpf6grTj/D0
 HSQr4KXm8VXEz9DgnCGxh3IXkcMbVqyjE2UvE1yqlf4Mrg3cSvoRtulUi1y06/wD9o1V5unHB0R
 6GUX8=
X-Google-Smtp-Source: AGHT+IHRaHPB0yEEnmzOt6EQTTSNoFNvc7zSUx/Rleivhr37F2ph+2wsTY5XR7td2ke2ikD3AapGbg==
X-Received: by 2002:a05:6e02:1529:b0:3e3:e659:2d5f with SMTP id
 e9e14a558f8ab-3e4161f3644mr206048725ab.0.1754344641181; 
 Mon, 04 Aug 2025 14:57:21 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50a9f677f81sm1066177173.39.2025.08.04.14.57.20
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:57:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/3] rtc: Tighten some rtc driver dependencies
Date: Mon,  4 Aug 2025 15:57:10 -0600
Message-ID: <20250804215719.1413106-1-trini@konsulko.com>
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

The Marvell RTC rtc driver cannot build without access to some
platform specific header files. Express that requirements in Kconfig as
well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 79b879d68d1b..ed903999f067 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -218,7 +218,7 @@ config RTC_PL031
 
 config RTC_MV
 	bool "Enable Marvell RTC driver"
-	depends on DM_RTC
+	depends on DM_RTC && ARCH_KIRKWOOD
 	help
 	  Enable Marvell RTC driver. This driver supports the rtc that is present
 	  on some Marvell SoCs.
-- 
2.43.0

