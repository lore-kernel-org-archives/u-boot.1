Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC743C46CA3
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3F61876F8;
	Thu, 30 Nov 2023 21:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ididmm5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28513876F1; Thu, 30 Nov 2023 21:14:01 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 152E387483
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:13:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6d817ccaa6dso826222a34.2
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375237; x=1701980037; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZGo3AxZObaWz6+b2adD14ayircumvMyk4o/xEJcx/1A=;
 b=Ididmm5Q0JHw1dpU73aEwPH7Krj76vwVxqcbUnO0ra67zfhv1Zc6UCRheYL6tyBw9F
 3VtiUvCsR1xx0bxPoIvoTvw9xbxKf2zXioEYjj0OVyJJ7G6CHSQhjir0jPh647r1dgms
 xUWbUogZ/Zr6HEl4wQ2UqhqGTkLcMpEN+lz1Wpsq+7fgSHMRCe59Q6A2S5CK/ZcHnvRm
 cTQudxdZl3zUfWfUmEESOA2rDdctJ/woQWitSeCI4D6cLNBJg6mQlaxtab9kgCau+jLb
 8knHivESI4Wu2iRWcpN0Rrfsx/Hj22ErVfQ2y+r/vQ75su9nOKntQ4ZTs1srAeMmwQSy
 FZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375237; x=1701980037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZGo3AxZObaWz6+b2adD14ayircumvMyk4o/xEJcx/1A=;
 b=bqiF0WZB37GM2jldheaQwOHNgpBQeE5JxTlTQ7A8A5vkSCEsENLl6L33WNBlSEfq+H
 VLjnT0VubHCg+Rz332ZXRWmlNi3HiqBAQN3vBX2PLKC+2mPJWYh8q2+mEAnwV4rt8ok2
 fMcew4/eTDI0oDEn87XAsSJnY34uLVx91DL5zdsJVgfKgR8vpoWwW9badg72PGpyMSms
 zqgJsyuYVC4TKTznUY80jLHCYOvAh1M48/NBmQPt9lgqti6glsCeAZqHki9lEtwnsw+8
 8Qs4tar+yNGx9j3wRwpxW8c4PsEhYyy46gtuIZ83izLyXT/e1sHmcsFP2EbVZZKAI0r9
 cjIg==
X-Gm-Message-State: AOJu0Yy/f8e+ad2EwaPaLCYrvDAxfGsCH3fQ4bEVE1fEyu+hHAUVh3ve
 Yq4UkQvhn2WiSlKJkAWuGiChAw==
X-Google-Smtp-Source: AGHT+IFM7s/z2M0C6XjaH/g5pB3gaFbxn5szxhYEQ2+ujMDVUCxZaCcdX7+RQHFgF0L6geWNQ9iRBg==
X-Received: by 2002:a9d:6853:0:b0:6d8:28ce:3af8 with SMTP id
 c19-20020a9d6853000000b006d828ce3af8mr736395oto.7.1701375237759; 
 Thu, 30 Nov 2023 12:13:57 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 w21-20020a9d6395000000b006d812c49f21sm258790otk.17.2023.11.30.12.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:13:57 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH 6/7] pinctrl: exynos: Reduce variables scope
Date: Thu, 30 Nov 2023 14:13:51 -0600
Message-Id: <20231130201352.6379-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130201352.6379-1-semen.protsenko@linaro.org>
References: <20231130201352.6379-1-semen.protsenko@linaro.org>
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

Pull some variables declared in exynos_pinctrl_set_state() into its
loop, to reduce their scope. Style commit, no functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/pinctrl/exynos/pinctrl-exynos.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/exynos/pinctrl-exynos.c b/drivers/pinctrl/exynos/pinctrl-exynos.c
index e79ce5113d84..b6af3befbf9b 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos.c
@@ -120,10 +120,8 @@ int exynos_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 	struct exynos_pinctrl_priv *priv = dev_get_priv(dev);
 	const void *fdt = gd->fdt_blob;
 	int node = dev_of_offset(config);
-	unsigned int count, idx, pin_num;
+	unsigned int count, idx;
 	unsigned int pinvals[PINCFG_TYPE_NUM];
-	unsigned long reg;
-	const char *name;
 
 	/*
 	 * refer to the following document for the pinctrl bindings
@@ -141,7 +139,10 @@ int exynos_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 
 	for (idx = 0; idx < count; idx++) {
 		const struct samsung_pin_bank_data *bank;
+		unsigned int pin_num;
 		char bank_name[10];
+		unsigned long reg;
+		const char *name;
 		int pincfg;
 
 		name = fdt_stringlist_get(fdt, node, "samsung,pins", idx, NULL);
-- 
2.39.2

