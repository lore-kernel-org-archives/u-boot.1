Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED975C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F07B5876ED;
	Mon, 27 Nov 2023 14:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CT7MMOSO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9319D876ED; Mon, 27 Nov 2023 14:00:58 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EA8787690
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50aaaf6e58fso6350579e87.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090055; x=1701694855; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUj9bNeOAFJnUgjAIYZdSaerdiXzEkAzNcyxyKkqUBs=;
 b=CT7MMOSO5VOYC5vCfn8n8BTIGWXJOFG7UQhqPGrAN1XCg5JMw8LN0NntmaDtxJmipu
 ZWNgKIqnT2/RuW2shd/Jf9aABXuvhqUbPCBcHQFXnp7fX4VRSciSxfzoscsQRzVEHAor
 DGmujPh78G2buyzolzVwW7t+52Xux6VZdsyO3fAWMtYjHTS4hNBVwWnVvN0MXcY7d+kd
 5HMpHPX4Z4Bo3ZqGtlH989FqM/Vr47tFOZFJk8xwragjxd6Q5fN5pqDhI3dIYLpzSlzv
 igeIGuwkttWNFcP8MVlvOqnXKm7+rLoO36BiwLhNQsOk3xB4WoVJqK7LltKDmBzlA3pS
 JxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090055; x=1701694855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nUj9bNeOAFJnUgjAIYZdSaerdiXzEkAzNcyxyKkqUBs=;
 b=T2/oqqxtFsuqkc1cIOhr19SQjM2CK+9yZdKrdB2GPj9oQHZVa3nIai2yNmbN/n72Ti
 QIm3OLtJnRjDuJMnUqNvXWKgOH6LEgKFrM5M5n/nTpywv1Dt6VWfqykMpRqw0QkI0zxX
 OxZsjXa2K3wjgb7j78yskqz35m2aLowyYNLh0Uzob0NsM0j/1kKgBO5Xs5qXzpEZ77bX
 uBZTLR+5lSJXFwrOc9rYJD5duoaDEV5RTjmQLNROsCUQ8i3WbiXbsQma8cJFKWK+Nfq+
 hALLXZlKm9lKNAmbLm7OgPca2V6cQXaeuUHvNelSvi6qixO0wGXNHpk255AE1O6NVWuo
 pO7Q==
X-Gm-Message-State: AOJu0Yx/XaYFSL4W5yN/umHGEmaLRDYn+gN5E1QoEjXTPVkj6l7+ibqt
 NaD87MsSC/hG1GxNecr/45+NMNKT9eKIszwz9u6VjQ==
X-Google-Smtp-Source: AGHT+IFD+SzxFwtEZU+6m8vPx9bJ7iGELPtta0NUGV0LJcHOADqb4zDaFY+I9yOqD4WikLcFDWh7wA==
X-Received: by 2002:a05:6512:104b:b0:50b:b5c0:fe8b with SMTP id
 c11-20020a056512104b00b0050bb5c0fe8bmr343848lfb.28.1701090055739; 
 Mon, 27 Nov 2023 05:00:55 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:55 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 20/43] driver/net/rtl8139: remove debug print
Date: Mon, 27 Nov 2023 18:57:03 +0600
Message-Id: <20231127125726.3735-21-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

debug print delays reset of the driver. Finally I see
bunch of "rx error FFFF" errors in the screen. CI can
not handle many prints. While network works fine there

Reproduced with:
make CROSS_COMPILE=sh2-linux- r2dplus_defconfig all
qemu-system-sh4 -M r2d -nographic -serial null \
-serial mon:stdio -net user,tftp=`pwd` \
-net nic,model=rtl8139 -kernel ./u-boot.bin

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 drivers/net/rtl8139.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/rtl8139.c b/drivers/net/rtl8139.c
index 106bc1c7ae..6003b88274 100644
--- a/drivers/net/rtl8139.c
+++ b/drivers/net/rtl8139.c
@@ -453,7 +453,6 @@ static int rtl8139_recv_common(struct rtl8139_priv *priv, unsigned char *rxdata,
 			  RTL_STS_RXBADALIGN)) ||
 	    (rx_size < ETH_ZLEN) ||
 	    (rx_size > ETH_FRAME_LEN + 4)) {
-		printf("rx error %hX\n", rx_status);
 		/* this clears all interrupts still pending */
 		rtl8139_reset(priv);
 		return 0;
-- 
2.30.2

