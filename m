Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286B2C55174
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 20:31:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97BF060657;
	Fri, 31 Jul 2026 20:31:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0RFaVCiRTDqu; Fri, 31 Jul 2026 20:31:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A90DE60650
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785529913;
	bh=TVUVW3Mmjym6nbt0V1nRIxmDvAvLdb7NwQyTjU2DPRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TiZ8gRSCOB9gjoUfrtcJkRTvhbXX5cHAo3IJL77vI8iTKRGNNKAJild8f0N1/904D
	 K/sgwTSuOlAkGCB66fl6z5qGWlyAesvuyguG4JHFlyTD8sQPqYYFZXKilxpB3u+/3R
	 68o6eRZONesk6p6jT7zJm4OtAQgpf4HFMuWjx/hd8L8bJzGs2JQOn943SMPzaUeFH9
	 +sJ2aQz9gno+cuV78rhnvgGz998neAvIXhXx27qelM7VV6f0ebIAK/LdxMRm220hGa
	 XKHhxuxmRIYVfE3/ua0IdILotRxeK+UTC5Jae56AtfjtvX+48UPeLjx3OZhAAxlMfa
	 gQj3Tq/b+qzwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A90DE60650;
	Fri, 31 Jul 2026 20:31:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A4D7636E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 20:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9659580B88
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 20:31:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SlrlIloG4Lm8 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 20:31:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6492E80B4C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6492E80B4C
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6492E80B4C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 20:31:51 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4a43c2a126fso649229b6e.3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 13:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785529910; x=1786134710;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TVUVW3Mmjym6nbt0V1nRIxmDvAvLdb7NwQyTjU2DPRM=;
 b=hgWHrFuM20Bpgf7Tr7CfnREApB832ZbM//yigq7lIn+o+I7hClBJtjei4a41DTzotp
 Vx/EuHYVcNoheTYdcHcQ8+4BlChXqG1bPL1zD3hGnPheAeNEfYOdQH6ywuo2Y5y6uTwU
 f2GOkyBY2UmpKE2Dr0/Ofc43qpMwWBY53t3CGQ8TA8zFDCp5NAsszQ54UaP5CW2QzcQ/
 zjwo7BLBLpthMOt0aPaTZ0TRjiGUDNR+g3+LSLa6bkqtz4F14933UOqStfims79w25YB
 9btzxYo3g0PvXCRgFwmxQ68Iuh1zYHwsdQp2gHInoyXvVlZtY4FOKrrosy7S0fP0JtPG
 FwFQ==
X-Gm-Message-State: AOJu0Yw6CGQyAbAKc7I9F/OKxObKC6cq9Xaaw1S7HEaZUcGGqZTwgIdO
 P2f5D5t4nFMh3PiqQZZl4iAmQmpxlXnrdiBUlpMO4pXDUdF7p0a2pjLr3Hqmb71e35I=
X-Gm-Gg: AR+sD122VZ6PQgcc33unYBj+Q7r5ND5JJpsqOQfzgJjMfIO0zN1fRjKvIXOI6htu576
 M5OdU9IxtaunYTuZNuSUvqU5cfZ3Gtaw6hunSLc7N3A3lHXRGou+GcaWBtxIpcOQwKqtSINr1rn
 JLAl+3xiKuxDsMqt3RubvWA2x43OS7cBFrV2QZeg/ohRkPrYBtN1Q0wsWhyyVlY/HvmhiEmaliF
 S+el4PnxwCO8XoUzt2AuvlizwdmydIpPjufQ0Kn6F1DS37qCiFwekh4Una/UVx4HTeNgqW+J9mb
 vzN9R4U1MnKrHvC4IQxtVqRGtG77llkNXGlPBRVBfhJcjKYlyAf9e+/UZN+ckjt5cLCp+HYLtho
 19QTVdnWBkozFB9Bwv9yNlT46mTDm6K4Jl1hz+oqdBntzjMQ4IIhT/JY6lzIj399b/ank72ZrJM
 1lPxNDFUhT7E8ye9nSVZslMDA/YqfaDss2+vxMApy7lRKuW46xEylt2lJR/ekBBLaS0yH7jqM7J
 35T
X-Received: by 2002:a05:6808:1991:b0:496:301:36b9 with SMTP id
 5614622812f47-4af5dcec44cmr2848841b6e.0.1785529910346; 
 Fri, 31 Jul 2026 13:31:50 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fa40:746f:401a:3b75])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4af58ce0a1bsm1445791b6e.2.2026.07.31.13.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 13:31:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jul 2026 15:31:26 -0500
Subject: [PATCH 1/2] arm: mediatek: use phase-aware PSCI reset on MT8365
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-mtk-mach-phase-aware-reset-v1-1-90b918aa52f5@baylibre.com>
References: <20260731-mtk-mach-phase-aware-reset-v1-0-90b918aa52f5@baylibre.com>
In-Reply-To: <20260731-mtk-mach-phase-aware-reset-v1-0-90b918aa52f5@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=770; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ck6rtwfxyTGQMFBB7DjY2l7Q6FiB8baJDtnbPMBoG+E=; 
 b=kA0DAAoBwswgAf8Bj8AByyZiAGptBiejr1RKAMO7uoCihVC/V96zFY5o6LTVPuYRbp31zDpiY
 4kBSgQAAQoANBYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJqbQYnFhxkbGVjaG5lckBiYXlsaWJy
 ZS5jb20ACgkQwswgAf8Bj8Cn+gf/RjMDZCyPWcVu1uMbMc4sYt3IJjARxQlV+Ni7AeoJ4idFrtl
 FXfRWB7LJ4c1/8RKGlTGB2TB0yU8HGVq1T2sYpascHUOVMkbM8CJQqbHWhIyIAN2vDuYSRFX+0i
 zb6oFR1H7LsHP4jQuLWEv8lDRjf8XzzhNRyOsebiG7iF2mgzbjpUxq0NKFFRBtf/ZZpu0xKz0Va
 4XiYYvU+LPtzXphy8/Q8Z4ywXueRQeg2QE+BCGk2QN7tfdkiWmsGu8QuoB9hpxEhwyuCAerdKWC
 3eRi36OhOsxZ0Hley3Oz43V/By25tVxI4ibk+Vqd5qVyeIWmy87kze42DC11RnWDSr4YSQ==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785529910; x=1786134710;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TVUVW3Mmjym6nbt0V1nRIxmDvAvLdb7NwQyTjU2DPRM=;
 b=FPuT0w9Q8DkoCtqP77lHpFLZ2whXyFDj+KuvI9TXgZpzmewgqf4XM7FZvWkQGDnQpF
 zoLNWQqHiWnSEWNqEAFoj2Ui367Ug55gysK6dOtdS5O0BgI+tvJFASa68e6MRE5yKfwq
 DepdQtTqdA3OtHaq7AL999+dw9jdBS5M+aPuyVOjX6+FKCbZ3zkcIL98ILJftxdpq74U
 envPI4eO3Gyv4iaM8jygVB1LBtU66h8N9FeLBOM9UF4yobW9XVHgi71gA6jBj3snGb+n
 in9rDfUgPExtGKqmHqaOFJW44B0yiVA1sd01iN4nXYeUxYqicSbmOQZf3avt/Wc9BaOB
 k8BQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FPuT0w9Q
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

Change IS_ENABLED() to CONFIG_IS_ENABLED() to prepare for SPL support.
PSCI is not available in the SPL stage and would cause a lock-up if
called.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8365/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/mt8365/init.c b/arch/arm/mach-mediatek/mt8365/init.c
index 1063dbf72a9..0f990197a38 100644
--- a/arch/arm/mach-mediatek/mt8365/init.c
+++ b/arch/arm/mach-mediatek/mt8365/init.c
@@ -22,7 +22,7 @@ void reset_cpu(void)
 {
 	struct udevice *wdt;
 
-	if (IS_ENABLED(CONFIG_PSCI_RESET)) {
+	if (CONFIG_IS_ENABLED(PSCI_RESET)) {
 		psci_system_reset();
 	} else {
 		uclass_first_device(UCLASS_WDT, &wdt);

-- 
2.43.0

