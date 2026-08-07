Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB78C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 19:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B87BC409CE;
	Fri,  7 Aug 2026 19:00:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nVBT19A8GLeT; Fri,  7 Aug 2026 19:00:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9132409F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786129229;
	bh=LaQyhDrOhmfRkKmWtrsrUzN4Lti1nbqAikC2oPRPa8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rDcKPzLuA4JXQ6FaFWBpDKNl2cGbgbdR4Py4c2rUGi1grSod+bFprmc5NC+ySAl7B
	 r+JieYwkgMiFxLjCgMReo75LgsWB9dQ+g4oe1xRf2QlY2FWKxWRshvorabJ/rWumhr
	 W5TmqSEHWEpj+ip/UB9bruD7qiZl+UbXBkpGDcEudMlVqeUUHsn5Sp3z8EDpswKPvG
	 NdVgxJa50nf3See4OnjnwEk1qy3gz8C/tiwTYsm5P7BJALRbZliqKIBAma2YFWJE0Q
	 eVvQ/sU2sgakb7YK6G40dKtsnrRN0uHeec0ydMehrQ1coqcD5XPwSMNVKdBoIEITDq
	 7iFM0NWJef0Bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9132409F5;
	Fri,  7 Aug 2026 19:00:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1530C2F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 052B4409D1
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:00:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id llxA2gnb3oYD for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 19:00:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4D16B409EF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D16B409EF
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4D16B409EF
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:00:25 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6aaf3f54dbeso2230051eaf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 12:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786129224; x=1786734024;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LaQyhDrOhmfRkKmWtrsrUzN4Lti1nbqAikC2oPRPa8U=;
 b=V1eJDSSQ4D/GXiSxQMhXUsx1PgwDq8MgFmRuO/5VwObhhmkJXKQP19h4+gHIVlwMPJ
 3zQpJpQsQNw3xFc5swPPs3W3gWRVQTcWz2325MLO3aUEYIif/Bo3so8JzcEm/FCZQREW
 yYwfgaRiaVXnzlzduDsxDvYDC7ytwEBcjjlI4mR5AYJC5IvM6uXK7NyvBSN8KYFnqJ8l
 eDcmKM6l/ew4UbZBwVX7Yiim2bIve+tVcSj0Z63btqAu4eSZGzIn7Ww+2X1WOkQB705B
 c7D/a2Liz3S5/uwKx0ay7wRfQRwjRrcPAnUhzencqKSdE+9hZ1bvUTm7dArAIO/ZK83u
 +oBw==
X-Gm-Message-State: AOJu0YwXpXzDLhIyAFit6juFVSDPyzViSADb9sBAumC6aHhU/1xoj9s3
 U5cTldiJKenTMhVBCLsZY6mDNQ/3WNRHT0yjsis/E8/BH5+7ZrsDpS4Wy23FdtI7Svg=
X-Gm-Gg: AR+sD13TEJ0iZaA3LERdxja9PaGO9BJ12enEVLgCjL33cGU7jEZYC9zyrYc4SnulCUL
 7rrcsR2aXop4AnbbCttKatjc5e0HvKnFnR5NdaS6fYt8XWQNedNCJq+Lftkha5GkpYWkcknNNRg
 Re1oCGC+R7TV62yslq2ucX8NJeDCkchuF/aBrHvPNYCcKiwxc/2e+VshUbEMCpLd/wxlTchcsyS
 jP2H3IRCbIOf4taZmfXqtOwBDTWO41qLcubKYuWl+8TIQupeYZ2pi7jx4QIK71s2DcZTUx50jLF
 XPNB5JAw7H7smbZjQVVGNzCPoJDqQSoUYQjTJIEboGjEYnSKCgmW+x340xe4pNK1YBvRAicq5dY
 bcxQtd83AhzIpUxmWQ530Nq+L+N470OwdfWS3UQCNGgvzxodR1FvQXw47pJLBaqldYjsKj8RUsa
 2OHOsC3iJ5nUE1DsNmOTNK+Fgcwh5CNUm8ZOD39/rLACEztEcrxeMybOdUT0dO+eMp
X-Received: by 2002:a05:6820:3095:b0:6aa:d13c:a709 with SMTP id
 006d021491bc7-6b0421b037amr1385295eaf.31.1786129224218; 
 Fri, 07 Aug 2026 12:00:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02be47604sm2679283eaf.10.2026.08.07.12.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 12:00:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 13:59:42 -0500
Subject: [PATCH v3 4/4] serial: serial_mtk: drop check before clk_bus
 enable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-serial-mtk-clock-fixes-v3-4-8cc94d313b57@baylibre.com>
References: <20260807-serial-mtk-clock-fixes-v3-0-8cc94d313b57@baylibre.com>
In-Reply-To: <20260807-serial-mtk-clock-fixes-v3-0-8cc94d313b57@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=739; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BGWLafYTCQQkl4NVST3s9nuTaLSeaFNTzyoF8kzSJow=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdis5iHRyu0yeoicABfDiVzVfwcDkDsKZqPIzQ
 4yyyCwEh0+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYrORYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AT2IH/iOxLQdoPlWDZp95QqzYqiPigkk3hHuMB7KXLI8
 13xdqhcSYSJGCb2x5kR0Dz0G8Z7etkwSTADXgPoXVv6IcKBzIHQwRriZSry3M/qSRn7YWIwMOjc
 7BLzVV8agmxT3/sDLSmi/H0LnzUKUhBLpKlegUBl+RsVV7nImtqhpk4+0ln32ecSihRDN9+mCam
 /65QNROniIPKjnX2kr1LvHJaWM4azVE9W+7HKOj72P8vT2XPN9tULbh8WT4uGZp+eMuMcJjw04Z
 sEPS7kCG8vIL8RJo9s4hxDUVYwoaAMCoRRyFq2GqEKpJQdg6USXFioI+ZrMBxjSy9xtOdUueI8I
 dt7Y=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786129224; x=1786734024;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LaQyhDrOhmfRkKmWtrsrUzN4Lti1nbqAikC2oPRPa8U=;
 b=kU8jnWztISGuXvu0CSIG6oqnhlVsS9hffhzcGtn3YRPHZC0Z6+aLpw8fZXvTaM8VYX
 lScLaNVKHKVva4Y9z/bGolGbTna901FFovrf87+Sogmme+6JkG8psW6Uii2Ro8snGyu9
 svuc4b4D4rDsR9PrAW61VleacQMUSaUgAPvB4PXI+ABMXiY2dPk53LKF9R5/PZOkbhDV
 rl78XxKSU33xf7CAsvpsZ1dZxQ0HDo39I6S1Q2SmU0yRm2nTXrQUymY+Z5mhw1UK6kDq
 g+GR2k5NU7ajN6hlVqw+sX6QRBYVIt+3sVoNg+dY1TVHPC3HlJy82j9mLADWZiiEQKm2
 L4AA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kU8jnWzt
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Drop the redundant check that clk_bus.dev is valid before enabling it.
clk_enable() already calls clk_is_valid() which does the same check.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/serial/serial_mtk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
index 3ddac510c21..75f204bfe56 100644
--- a/drivers/serial/serial_mtk.c
+++ b/drivers/serial/serial_mtk.c
@@ -260,8 +260,7 @@ static int mtk_serial_probe(struct udevice *dev)
 	writel(UART_FCRVAL, &priv->regs->fcr);
 
 	clk_enable(&priv->clk);
-	if (priv->clk_bus.dev)
-		clk_enable(&priv->clk_bus);
+	clk_enable(&priv->clk_bus);
 
 	return 0;
 }

-- 
2.43.0

