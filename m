Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ADA606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e+l1FyDs;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RLvDi4wD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42D93814BC;
	Thu, 22 Oct 2026 19:03:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XLlPQAiDBbcI; Thu, 22 Oct 2026 19:03:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E91A98146C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695789;
	b=dMrWR+JZxnBib4A8GFnTi2l1E3S0kFLLCTPqHjIlHvLVpWya/WJxc5KH01HODuwax5ml
	 nyc1Yaq118kP46V7oiWQJ2mQXMe8VxCd30bQ26gVG2OFHfIszm9uZUY3cfqyilotjv556
	 wVinLT9/ywne/8zE6H1HRrGb/wDvbnao/CmZGaSvLV7TFL4W1TKg40G/6jpc5Wc1Po9i/
	 SfU22KhEjJRLlEqtXk8TgHSXnhhl3+PrB98NwtN87yPHR2yGDAw11szG8LhTnrUgJRgZz
	 mM5n0E5hHH3Gr0PxwFm8fXfwgh8u4hqqY8mBKGtZ0Lg031A+4L+EZaREe5j/xpFLDHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695789;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UVgaYPDuslu1ZpiyZAC5RAKIyCdJ60o1cjrqFb7TIRE=;
	b=ccMavQqav0a0k+/E9KdbhmyZJXBIulmcwsXpJ0QY4CLqdtgwXTkjmMFkFBxZG3SzPsWr
	 U7PH1/p84uo/KFxFZ5BJTPpNuzNG0rJtG+74AoA9m5z1rgqQeXf1Gta0rrdFHeGISVv0w
	 IoJbS700oJ4TVv4DvPPWbdI36KMpqrnoQYrI7K6tsjWURWYmseJJGlD6ftlqrSJIqeIiC
	 V5ypU9MrIaPRDc9owgfv4bCFD7GPtu1tDA52W4ySCePfJ6REUXnGZClv39KHdzZLd2HtT
	 hJtqWXno+a6FFssPA0kennW+tR/rmiM+/AAA66GAFY1ZRQIudu6SbAOSixFJamxgqWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695789;
	bh=UVgaYPDuslu1ZpiyZAC5RAKIyCdJ60o1cjrqFb7TIRE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e+l1FyDs2qgv79Jb2uezWiaHDMqM7lN1qzyusZgyujc0WtWF+9Zs0wFf6UM/l8kRv
	 QhoXRH66I1T41bHtIrHTvFYOzm180FgOOao6gSSGKR/yj12dyxlgsWMM/IamA1rrzj
	 goPfSfk7AdUUirnA8hyfDk5OD4fRP2i3oRv8wCDwxeuhxmBlEbaoxafCMWhPLLEnFp
	 yLlKfxvXKqEbezYSjqsJ1ntzMTLvxTWK3WMYNaKkjP4KR9OUJpJHYhQ8UhUldV9LwV
	 ZaLEFfpCfq7B2djWw3G6hENxzMxha5/IqJMNRa73eYNhPAx/Apxw6DpYdBfCVq6Qgq
	 GATq00ZMMGTJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E91A98146C;
	Thu, 22 Oct 2026 19:03:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DF9C53C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D16866070C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IcYB8iEPZLf6 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:02:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 011926080C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695777;
 b=BbLQImsItzu4bEzLJVkWB7AMhgXgIW34QN5e+GJ3cJdocuek3KJhYj7YiiI/ELdHu4Yc
 qCWO0ORexQoisDw+bXefp4MsQjX1+//CS0CXdsZVUExOMKfjwo3WCztQ53qhPwWwSj/b8
 GDAGSfiNvBoa4iB1a6RnXpDGHuAjyfN1Ekc7ZVgDijovziTB70TMd4Xav3ZuC66wdfuSz
 cc73khN/FwgiE6nHLPK0HUk4EK3qjkPWgW7ZugdVTXwHcaLydEod0MT973iBvLrPaAk0D
 F+dBEEeAMaDFD4sgkNuQkwcTxgY6wIGeEJ3MaWy76Q2GfbZGXE1hhR0xQ3YDbNNJXGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695777;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=UVgaYPDuslu1ZpiyZAC5RAKIyCdJ60o1cjrqFb7TIRE=;
 b=eMSiZyW1X8HdtuOaktSkZnm2sq307eYi9MXRl4msHQ6lzgdqE81qRHF8RbphnyDCtK6T
 GXRd3EN0e4dsE/szZGsIp5zJXNudwKzpx/w+Gu7C9WDohH6CrKyP6YqQAc7AaHqINc008
 A2b6gxmAiySeCUNzmxL79xLt0vS4zXPxb+z9aUIaOtm0evGh20kHbQfrXvM1BzRKUtlH6
 N/D2v1irTMDWBPFnZmMWvQUFhyM3uh/YaFH7QjX3kvWH2MYBhyxj4R16ATGkLwMpdMjkp
 oI3lctKZiMVYPY12CEzLvDajguC/raVbZ7GNPsJ8nngHkjE9Yb1iZVkItCYus/YS/TA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RLvDi4wD; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RLvDi4wD
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 011926080C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:56 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e20edd106so107749f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792695775; x=1793300575;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UVgaYPDuslu1ZpiyZAC5RAKIyCdJ60o1cjrqFb7TIRE=;
 b=RLvDi4wDKQEK9mExQj5MnRU1J5wotvg46C+F37GisUCvbS61F2xx1S+1v3hMQrjDYq
 dmSd4jAztInaUbCZF/TXDROhNBxrUQ385WHtNq4ln76XdxBhQqYs9eGS6Q4p4Z7j6/73
 rkEIawVXpIrYJg5Ai0tVmOtUwNWIKqjkWDuzzD5IGnXx1EaJrFeiMD4F08azNWO9Zv6t
 zHzyOIJRAxOepbuT8MDd+2gzelIC0vV+ErWKSFi1s0hH92h6ox/2OO+JWRtYG7luXV9o
 ewQZNghpHEhpfsoOZOuOiAM5CTFezgco4rNDgb4Yxc9rNZClrWbcnwNK/QT1mTsktwJ/
 Rw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695775; x=1793300575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UVgaYPDuslu1ZpiyZAC5RAKIyCdJ60o1cjrqFb7TIRE=;
 b=r8YGCvRhjzHou5k8dx/+CWUxLDuvtfhAxsScfhB5AH8GI3c0CX5WHSSRFX7p8FmQo8
 o/1MPBLcVP5+8IariwRxS764Wz7JoOgeqbtxIbfB2l0ilSGyJliGIYmTI1spvz8dlo3V
 OOeGNxiGWFo+Z+8X+3+YnOqDvJNjN2gRSFMScDfDPCvDo0yMlzJ3mz+biwmm7g3O/uij
 7DyoVsyQkKiTau0xXXnFiEkv8NscQ/JE4QwMHvCJpVeH+8RX4GeLyJDlIIkdtVfiD2U9
 sXciN5TS7Rq2gPG+P0XZdaYegSpAAJizj29BabSFzhTAR2j/ZqXDJVZcy7vixwsnsi2J
 lepQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjZ7KwLkroM6vvRxrWoY1n3pcOzYMldGZ81Ja/Io4gsYQutoZI1MC0moxWkN1hxoz2FeEUCcw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLPc6HqgV1qGbCpAVI7Fynlzo/92JDTXArBL857eSEhON0XiPlN
 Do33RfktEbLuaQ3/MtRKzigSaTIEsPbLOJ+IYZse4EUNrLJ0DLD5utarvvntAQ==
X-Gm-Gg: AYBFou03u5EKx910FNPdH7rBnEEIpV/Y5ccDaVuMvZJkXmQlQ1abhROD+DDXdbh5VKr
 IC5wMvwLdTGXnXpua6NLWQfKrL3HLgmrHwzsZf8b/wMoQS0VOpffL24VTs4/0dWOjuWxU7dxIhQ
 UIdkEmmB+0IL+pjMOlCeCkF9pWOw6H3GsBsIikV1lT3voys4KG8j6Vx7KHul/5AAuCAKO82VebS
 OF6TiXZ6US/SOQJxB8p/oytQxwrjuv7PuOjB5TQ+yfBgxLwm/X+JWLw8iUFfpGi+H/iYKtn06f8
 Cur8a19jEtMvCR8/ooYFwHSiiogp97gXYx+WyMckcvl7rV68sVEJlDHckfr7hpsu9HVtnN03FV6
 byIyvQEpeFHn6GrsZosr1DpXTU1LWVEKoE+sFwz1xJc7+VaLRk2JrAbY43Kh1tg6AaQlcU16/+N
 9AFnT2FUzgyEBoOhCiuxowJRMWF+SLnjynXO3nrv1ttl1z2Zj7b7H/Lyczzu+xzSc8ILYup5WFJ
 8eUhSZddppcLKVddS2fNRGS5YoQ5Vq/5sAinLRb/cFq2dWJkUVeBWgnhDiLlNrgC6WxSdzyvS29
 dHJsFB0Mz9WeiNVLQSD6pPWptwD4u5w6HWWlWwboPkhZcH42bZia2MNKouU6
X-Received: by 2002:a05:6000:2313:b0:48d:f025:110d with SMTP id
 ffacd0b85a97d-48e264d182cmr14301834f8f.43.1792695774570; 
 Thu, 22 Oct 2026 12:02:54 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0e841sm189495f8f.54.2026.10.22.12.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:02:53 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Zhengping Zhang <zhengping.zhang@airoha.com>,
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 16/16] configs: an7583: enable MDIO_AIROHA by default
Date: Thu, 22 Oct 2026 21:01:58 +0200
Message-ID: <20261022190206.666950-17-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022190206.666950-1-ansuelsmth@gmail.com>
References: <20261022190206.666950-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable MDIO_AIROHA in the default config for Airoha AN7583.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7583_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7583_evb_defconfig b/configs/an7583_evb_defconfig
index 8b076c1cfe5c..08bcbd52c99a 100644
--- a/configs/an7583_evb_defconfig
+++ b/configs/an7583_evb_defconfig
@@ -65,6 +65,7 @@ CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_DM_MDIO=y
+CONFIG_MDIO_AIROHA=y
 CONFIG_PCS_AIROHA_AN7583=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
-- 
2.55.0

