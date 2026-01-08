Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90678D1D462
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0443A84230;
	Thu,  8 Jan 2026 15:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PULHTeU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E031841B8; Thu,  8 Jan 2026 15:47:17 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BFA98420C
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-432777da980so1788636f8f.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767883634; x=1768488434;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AmVTxxNtWbyevDLG+GH2J7ZMVD7sHI1E7niOOxGCckM=;
 b=PULHTeU9nRUUxOdbfuOSguX1Z9GCOJq7wGABZvtU6VfMIeNkiVjU9pskBzYceUOxhz
 M+pLppvWy/9O5u70TZ3etQWbnqlMYc6URWrbzA7UafeJib+ltbd9Ute1jL9+S6HyIKXe
 JiSCBO8H3L+7VWrT5EFWHjeuoV00f7ET5OxsyjIdiPEsOtJAedlYeQS7dCrpu1aijUjc
 2fGLeXxIEZxpnbmQEuqiwr4pVnCk/9e8IbZzDs5ntWhvmY+SZ3iE9uL6OPpZnYjud4Sp
 bMG+wAjOkLx1OgxWRwuftp33bIyriBEY5O8swoBv7i1EhZY0g0SFmas6sO+5B14sB1rb
 UyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767883634; x=1768488434;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AmVTxxNtWbyevDLG+GH2J7ZMVD7sHI1E7niOOxGCckM=;
 b=QZoQu7Pmap4/lkWd9E743/lwEdX7mmGP2Moxr+6AN4AC7i2aWFKxMFxkaa5olNW5Er
 AItyJDgQj/yr9Fk0catIKM1LhrQJbAD4GsVYy63FS/i0C9shM1ngpc31BVvjseMi9QZM
 80IS79Wr3CNKqVEAbAsT7ybsAZ8CUg4VGwLjd4GykErelI6CtZ8jQKQRUD8YK6d0z51N
 h+huTCFx32yAwlP3UdC2+Mt28WJ8E7NvEFc9xFBYVx6wKey4oYzVs6QSSMuJqFg7qIp1
 05hSX46KFoEpiY+PE8ZZG1xiO0NUXB7kY6KPQFz53e1ktv2AzMd18RRvNBa3qqjQXeg/
 iioA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV85ePorUR470QphgH5iilQHApYGCMwWH+tMtqZOuFhEyPogYPG58BQrtIV7kIaQqM55idt4aE=@lists.denx.de
X-Gm-Message-State: AOJu0Yzdr1M780i5hH/bNqUqxIrSDIVHTfuEViuGNdrV3v04lj2unGyO
 oD0YhpCBdKWuwK7NzbxvfgfvD127dbXKgKdIYumnXLE0+vMqPCsoNXoieRszeIh3pqA=
X-Gm-Gg: AY/fxX7hyzmjGuvj/DioFEWQkwx7NvdU/KOEGuL7IoiFwp87NGGT4OzM5G4ayyrQwHG
 DqeDowVx8qVpu5VYFhldu6987/PJVJOhW4Iq2cZpPz5eb6b1ab6ubp7mjLAZyk/C8G5859iNDLC
 EDYizd+U55vynB+uhIp0mRPw39K1c3Ouc8mEnmdQpuftqCnLgoMRSXwqSOQKGNsZN5cxbZTZe7f
 VVhJImP/q/LOU8f7WFw2x0OmfuRK5iiyqp6ZLdOz9Ggh7DT2nNd9YjkWhQOvpxq1WJzCK88Gcxc
 F2NircrPxkKbhRdijnPcrK6UrncBhr2TierMalKg4+4N+kvctieV524xzSIPxgNkSJyIz0YaTzu
 tJrFHUhDXs0D+wc/JQd2mMUhmxHivmiN+VYL+pSrTHE/8gRkmM8yPwdE/1rbMHz2z+aVe1B62aT
 cupY+FTqHI7O/pjxisv6DzLXOGko4N5HXbgh4ztWf1J/uZGExSIMqayBkMkchxsa8AS/MLKgOUF
 l1PWxmW
X-Google-Smtp-Source: AGHT+IGMHcENFbA0NVVrRVhvQajAxBsk624UEnBVuF9o/SWAErYCxFRk+UgADw3934oPFEMjDkz8tA==
X-Received: by 2002:a05:6000:2409:b0:432:c07a:ee62 with SMTP id
 ffacd0b85a97d-432c3775b85mr9240159f8f.62.1767883634461; 
 Thu, 08 Jan 2026 06:47:14 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee5eesm16872463f8f.34.2026.01.08.06.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:47:14 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 08 Jan 2026 15:47:15 +0100
Subject: [PATCH v2 1/2] pinctrl: mediatek: kconfig: fix logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-pinctrl-mediatek-fix-compilation-issue-v2-1-3d0499d3b6db@baylibre.com>
References: <20260108-pinctrl-mediatek-fix-compilation-issue-v2-0-3d0499d3b6db@baylibre.com>
In-Reply-To: <20260108-pinctrl-mediatek-fix-compilation-issue-v2-0-3d0499d3b6db@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Sam Shih <sam.shih@mediatek.com>, dlechner@baylibre.com, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2
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

We can't have PINCTRL_MTK depend on PINCTRL_GENERIC and then all
drivers select it. Individual drivers should directly depend on
PINCTRL_GENERIC.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/pinctrl/mediatek/Kconfig | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 8b9180bd2aaeb56325ba42d08afa42d9317f23a1..d10d08d9fe80441a5a2f8acc13e312825fa43a5d 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -1,47 +1,46 @@
 if ARCH_MEDIATEK
 
 config PINCTRL_MTK
-	depends on PINCTRL_GENERIC
 	bool
 
 config PINCTRL_MT7622
 	bool "MT7622 SoC pinctrl driver"
-	select PINCTRL_MTK
+	depends on PINCTRL_GENERIC
 
 config PINCTRL_MT7623
 	bool "MT7623 SoC pinctrl driver"
-	select PINCTRL_MTK
+	depends on PINCTRL_GENERIC
 
 config PINCTRL_MT7629
 	bool "MT7629 SoC pinctrl driver"
-	select PINCTRL_MTK
+	depends on PINCTRL_GENERIC
 
 config PINCTRL_MT7981
 	bool "MT7981 SoC pinctrl driver"
-	select PINCTRL_MTK
+	depends on PINCTRL_GENERIC
 
 config PINCTRL_MT7986
 	bool "MT7986 SoC pinctrl driver"
-	select PINCTRL_MTK
+	depends on PINCTRL_GENERIC
 
 config PINCTRL_MT7987
 	bool "MT7987 SoC pinctrl driver"
-	select PINCTRL_MTK
+	depends on PINCTRL_GENERIC
 
 config PINCTRL_MT7988
 	bool "MT7988 SoC pinctrl driver"
-	select PINCTRL_MTK
+	depends on PINCTRL_GENERIC
 
 config PINCTRL_MT8512
 	bool "MT8512 SoC pinctrl driver"
-	select PINCTRL_MTK
+	depends on PINCTRL_GENERIC
 
 config PINCTRL_MT8516
 	bool "MT8516 SoC pinctrl driver"
-	select PINCTRL_MTK
+	depends on PINCTRL_GENERIC
 
 config PINCTRL_MT8518
         bool "MT8518 SoC pinctrl driver"
-	select PINCTRL_MTK
+	depends on PINCTRL_GENERIC
 
 endif

-- 
2.50.1

