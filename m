Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C1BCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1907380E46;
	Mon, 28 Sep 2026 15:07:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0sBGOL-hs9pY; Mon, 28 Sep 2026 15:07:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 21C4580ED2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608067;
	b=l+5SXCUkSoH+0+dN/2ozQxBeHg1QFlBHOiOtkQM3xi+0PNVhrQWau3uG0exPsKfqxPco
	 7CJJTO1L4Xk3ImSiYb/fFrOuNWooAm6m+IBYTp1G+iN1GZuMGmbvMUUuvFhC9OdaKM2h7
	 LGf9KmUU47pvvCzUVTWbjBhvja2d8MkFYd/sz/KRJrAj2MiRq3RvC4YMWiDxZ5dBiH/mT
	 wIcVXi0LyhaR0T8/ZXIKKjyl61tS3Mlzffbf8QlctdnT4ozEnB1xJz97rzjMx1W4SOf9/
	 GnmbdvgoKRHmRMCLXOR75sCp9Bg6wqwpXQcXtjpyUHylzRNzyQ/6AzfLKvSIO5pbYlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608067;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X81IQa5iKrwaXqGThG7E8Ss5H88Td8cEJcBkTSCzb+M=;
	b=WxxhzVJhyakvJEefZmvutW8lJkfFFBSZ3YTJkyK98Fcu8JcEmZos5Btv7XXP+e4qCp/f
	 Y50++YiKXEoKS4pBsEE/fliZ+VnnvLQucGgRHLEoi6qlZeTbpXmkf4OfYBxKgo8GEeKwJ
	 6d7cgNi3uzsWYHW8Rf3o9UlaF4u+7z0ma7uxLErozjNmXTTDl/QoLTbvo0tKFIm28QtcE
	 7QiMhOrPu4HEJiymwMYcUZzYyUQ4m0C7CtSaVLmciigEIZNlVgAWFwKhIhaVG+W6M3WaB
	 5OOH44gDpaCupI2/UOypYImuPPG1zQobdYF4z0oopi/4GoiYw5cQ73vgeC6B+8dn1bw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JqRr4eJ1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608067;
	bh=X81IQa5iKrwaXqGThG7E8Ss5H88Td8cEJcBkTSCzb+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P0eDeSDzY67rsRfdqdkqlpR5RkI2LRBNoROV6LqPouIxWpWYKgOOD3SAjGQ/5lTJZ
	 Mq+hqThEihyy8dzjhVqG9mCTQ6EWH2EP1V2zqVTVkQBS1taJiuPU3mvZlBHw2PXFb7
	 iSafDeeV1gdVSjvS4YvI4pqfGo2vqNIBFnB+dsNVUwSnkY/X4eouTpOTmIBwot7/25
	 vi5okAboTxDoSA61WiXMpTGukLvWDM2XQxM+NbuQJBgVWd7mkpJ0druN57sxuuX9bf
	 TNj8aSOvbJPnnhK9KPfQFwfAESoaIv8SwBBmEkI9CCz1g0HY91mAAM4hcHa7CyN5yh
	 jHf2fqpwyupSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21C4580ED2;
	Mon, 28 Sep 2026 15:07:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A7CC43A0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D76B80EEF
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TufHldw6Ktii for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:07:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 21E9B80E25
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790608063;
 b=Ee0M2ugS3qQZKIheBy/29M3Adh3yd9BohbhHE2HVztiLkuIZLQcDxRvWuEd8I1vS5Nvp
 More7UEoFd72s1B+aKtIIc46JK6FsFA4HTTq9srGZsgjep7u1N0OuJ0vvEIZVf90/htYc
 Bsfxq284W8D6/6lDk4T/ytiKKjfrZaI0TRGyQJ54M2MMpb6507po6oqTowDCnz51Jg2wi
 xGkfGiwKnAx0O5LxpxZ8wF7fYwtXkZsDR/UBebWang00n2MsQIAHrp9Y20Sj+M+uomoaO
 GlwFtNq1CqVSsLv9/WJc+8MUiv/ZIc7jrx7qTbUPQn8w2UJMUs6dF+k2LuGDDSyECXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608063;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=X81IQa5iKrwaXqGThG7E8Ss5H88Td8cEJcBkTSCzb+M=;
 b=U9yI0DUxQbi9jFzIp4zzmcXHpEZQ6AZiPG5Xg+wPlRqN70dIiThIo/8YL/tay1PT5gbM
 jZa13xOdlHLG/d03aQllyodRpcXMXtGZ6K4KFsWGMxFxJAFB8M83ZnZpGG5OgceCXGUhU
 zAkLdBLytprQghj/6o4z8kdYO62GZIlhWEvxC+oqb1RyRaY2lY+PQUv7X/NYwKXX7zYVW
 YI2wHaAmfD8wtNSuoVOB4sp0e1B0CoY3myYoMie/c7YaiNw3E7hxa4Cq8PZl0bRAp+Ltg
 zY7cL/Q8cVU8L0izXHKXWu03DcAs3jN0m1dPBDzoCKV8xVNUfpH/fXhTWx7PmfsKi7w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=JqRr4eJ1; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JqRr4eJ1
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21E9B80E25
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:42 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7d2bb404so11156065e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790608061; x=1791212861;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X81IQa5iKrwaXqGThG7E8Ss5H88Td8cEJcBkTSCzb+M=;
 b=JqRr4eJ1iRLzbSaa4Ys3FRWCb1YDvvNwKUdXQ2RvuBNl8RFUEGbrjtVPJ38C1boOLu
 w3LF+CaiBzJTJZfEhwRGGoSMqxjFg/+ov4c8Aw5K+nvYMriGh3M3+Wjfs0QFu+uhyFZE
 JMdc+qsVZhW4ij/f+rMMP/g1oK72Yye2VbRahMseEUjPzWmN6AB+EwwSWibJWEtmrnW4
 Go4lrCZjc6zV3d5UrvgwV8u13E1H7npaORYv1h9LoihD/U5iNQ0gftWqubmsRQexCocF
 PW2rCnQmL5qziTVR7YamhVQq1KZl6cbmCYs63S7eG2FUtbSqqkGeoYEowO86NfTnJLLR
 8Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608061; x=1791212861;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X81IQa5iKrwaXqGThG7E8Ss5H88Td8cEJcBkTSCzb+M=;
 b=VNM21XoInXpeTrua9GTuYjuerRougHa3AtTgar9VS1kaoP8hSAlEIqrdrYRgo94jAW
 1h7BZ86Rq+h9hvCa9rJRXOr0I5nCEcWeD5eyJI/aeJaNMvuN9NXQO+Igx1RReAOeRuvv
 O/x9JikfoC7c8lEUqy8VP2bN6r0hVgVREM6mPPMFv0l65zm8PdwsLbn98mnOsw7a8kCy
 Yg2rfBf30YbvVrFcAUf09Gg65exHfE2VTEWlyRPeTFIXxAaDg1tZmS+WNfUcsxpuLqTn
 PB6/dN4bWUzowAY2aINYTrEb2fNUB7CdOHADiv0Qh1VzSLROc5V906yrBHw/MFAZp+JB
 rpQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1niHdVZaGNOfd2NNeRA+0Q7Z5z8NuVqW8Y7PEJPTS7jUhQY+xLtB+nvYEvc+v+MObQvtc+Ls=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nkq5/LEOXkjYrRSq9EkNXovUGaDLw3wIfn24UNcWmufOgXdYNB
 T6zdbfkE93YhatLfZjba5hdsJG2okEPVxcs+ZPXXEkx4JjlzqBBcGzFaoJErYCFoJoM=
X-Gm-Gg: AYBFou0IYOHDa/A44C+F9XmnNa65UCsBiWvZP2SD4Op88xDHrQdUmzvIahZPh+ch8n8
 pLmPkYf+VJ4T9sNo+M10V19+lwOnq/06CZ34bRYE15e0azsd/PfjrXpY3+BRpV5yQilK98fcGvj
 Jek9qKEqt08Ugx21jgyAdwdERwju7Vte6NvroZfCYRmRaaWworgtABFv8tWWdcgqWawAhLfr/6f
 3whZ5GQvBm6t4azImSJFNGIfbxvGFRwVqWYp3u9d9XGmSl1F/Ppbmb5TMfixUTO0KfKeH2c8b8Q
 +JbBv0x0TaioLCcvHjWTXOMMQve1CYiGS4O1umARSxAmBNObKBZ+MwohJd8SXJeqcLLRCmOUHI0
 OZ2mrVTrIp8Spxk4PEXIHQUWr8q/+pxfE7dH8CcIlDAj/eb5a5ARFGN4JEuhkjz29cYWN5E/1nH
 7iALMZCFS77tl8kV7NLOHFlO+QvvMgHJt9g8tH4Bt/VEXbLeP2YC3l/q3TDuXnIY3iPkfJYNjL6
 LWhVrlQiTA3HPtWg7wTqQ2AQgvOsAatINm5DBaGkaI93Mbj0t1tHAgT6cpYaSB7YC3eybpLHQJY
 nzviDXPbI9+tWG4yjeKocDqeFG9v73oIbWe/w+XdePAc85NeTLFd6es=
X-Received: by 2002:a05:600c:3513:b0:49e:6836:5386 with SMTP id
 5b1f17b1804b1-49fe66ca6f5mr249074665e9.0.1790608059699; 
 Mon, 28 Sep 2026 08:07:39 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f0e79sm235270105e9.7.2026.09.28.08.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:07:39 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 17:08:50 +0200
Subject: [PATCH 13/13] configs: mediatek: mt8366_genio_360_evk: enable dsi
 pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mt8365-mt8366-add-dsi-support-v1-13-212f51b1742b@baylibre.com>
References: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
In-Reply-To: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Enable the configuration required for the DSI pipeline on Genio 360 EVK:
video, the MediaTek DSI driver and the startek kd070fhfid078 panel which
is the default display for the Genio 360 EVK. The PHY uclass, DM_GPIO
and the fixed regulator are already enabled for the other peripherals of
the board.

Unlike the Genio 350 panel, the kd070fhfid078 drives its backlight
through the display PWM, so the PWM uclass and the MediaTek display
PWM driver are enabled as well. The backlight uclass and the generic PWM
backlight driver are "default y", so CONFIG_DM_PWM=y is enough to bring
them in.

Everything else the driver needs, the MIPI DSI PHY included, is selected
by CONFIG_VIDEO_MEDIATEK_DSI. The U-Boot logo is not enabled by a symbol
of its own: CONFIG_VIDEO_LOGO is "default y if !SPLASH_SCREEN", so
CONFIG_VIDEO=y already brings it in.

CONFIG_VIDEO also turns CONFIG_CONSOLE_MUX and CONFIG_CMD_CLS on by
default. Both are turned back off: the display is only there for the
boot logo, the console stays on the serial port.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8366_genio_360_evk_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/mt8366_genio_360_evk_defconfig b/configs/mt8366_genio_360_evk_defconfig
index abc3667d566..18e67f09816 100644
--- a/configs/mt8366_genio_360_evk_defconfig
+++ b/configs/mt8366_genio_360_evk_defconfig
@@ -12,6 +12,7 @@ CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_FIT=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_DEFAULT_FDT_FILE="mt8366-genio-360-evk"
+# CONFIG_CONSOLE_MUX is not set
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DM=y
@@ -20,6 +21,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_USB=y
+# CONFIG_CMD_CLS is not set
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_NET_LWIP=y
@@ -49,6 +51,8 @@ CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_MT6358=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_MTK_DISP=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
@@ -59,5 +63,8 @@ CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_MTK=y
 CONFIG_USB_MTU3=y
+CONFIG_VIDEO=y
+CONFIG_PANEL_STARTEK_KD070FHFID078=y
+CONFIG_VIDEO_MEDIATEK_DSI=y
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y

-- 
2.55.0

