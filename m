Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12F5C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D21388694;
	Thu, 18 Apr 2024 19:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="prF3WYwL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E73988697; Thu, 18 Apr 2024 19:26:28 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44BBF88691
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-418ee2fcd6dso5239595e9.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 10:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713461185; x=1714065985; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kjhWfkg2iMXib1TZN4ivFfM1EGBgzLIKjXndcigHPmE=;
 b=prF3WYwLG2izaSyZ7ert0/uSq0hdrA//b9bx50u1ukb8jbB0T7jXnue+CcjRrQfkE5
 /kcz99sg7Ly6d+0yflLJCBtM9lKd7LKwP3M9InSu+p82hCWZ1Gx7G+CvPVR25sbWLhRJ
 1q9BuGqpnnTQ3Cg1YmY2RNRb9vPjFT5LXJ+bruR0o2iZsKX1Uk9wi2pvh0cEC2794Sn/
 e6XwWdE1cVtdsBUSJMRYki0SsaEU8+fgVjVFlyu9tjPWfSqKgMangjrydOyCsbarHksn
 cVc99pMskTqZOrlSybG9XD8evKzX0Vw+As/K608Vzk0rMWh26gpyCmma7c4sZG0HPIEA
 yDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713461185; x=1714065985;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kjhWfkg2iMXib1TZN4ivFfM1EGBgzLIKjXndcigHPmE=;
 b=mXZ4cM66O1xYKeujX/7AahgQWiLqUvPSYAgGfrbN5nsdQBATpjAwPBye2f07VnoetN
 UtkPJpuAKUi1KPrv31B6qjNltl70UyK1keMbCYy7C5J/1JuRSdR4AxY2NSx8n+4GNer4
 HQHTjkPY8SAKwr0Q9pmJ7U7ZwTZvPGiRVLRS+jliXbI02zafLFrex+4xETC6NT5v/wqh
 j5ptl8fdFWjji5MQPcRrVEjHr7dTZIgNV0ElRN9f/MJCNKaL0PgBwOgWwOOP4EOaAT+5
 B88ZVTZlB/50B2AVHzzUe0KAXCpwjtxwKfN7/4PVhahlpSIDcWeByY5nkkmXgE8qZiOa
 8Zhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0hnn93EzJBebmw++jxfm2ZHftNueEzPpgd2EfWKQYEGO3l/33/cesWAFby5sYjboGLDhWTvNCrlUVFcZT4ERbGppc/g==
X-Gm-Message-State: AOJu0YyoCQEPD83XTEjIvrkdhJRyjov8drP0SXoHpvuKhmdTgI6Z9ZGg
 oMhW1koUJ7wbUqys/MkWVjxB28Swwjb0Kv3p9Y1Ciwrw4bxYjT7TfN7G9dkgcqc=
X-Google-Smtp-Source: AGHT+IGQuZ5P/VbYzsVEzEfd4Yz3f9k1Z0p9TNpCfiZv2SuxgjkZBxzz2tX3r+OS7yWjQlp9T1qFFg==
X-Received: by 2002:a05:600c:358a:b0:416:c23a:2c4b with SMTP id
 p10-20020a05600c358a00b00416c23a2c4bmr2578764wmq.17.1713461184842; 
 Thu, 18 Apr 2024 10:26:24 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00416b163e52bsm7166057wmq.14.2024.04.18.10.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 10:26:24 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 18 Apr 2024 18:25:44 +0100
Subject: [PATCH 1/9] gpio: qcom_pmic: add pm6125
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-b4-qcom-rbx-fixes-v1-1-f5f19d52969e@linaro.org>
References: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=884;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=kfdleW4GLsQlnwbnRLqDXz1KJnE26LYo2jLTTPsZmUg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTF8H2Rcut/fBJfpfbtV42V2+qt1/P4iowTjJgkF6Q1L
 lfrnLCno5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAExkggLDP/2qwl2ue04cPrRi
 71ODsxseaZkqLdoZ8iV+feX007MenzBn+GdW6ZF2sPHz2yV7TQztJGw7y6JKxZ7IPgqcKrLaJOm
 uRzYA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

As with some other modern PMICs, writing to the GPIOs seems to make the
device reset.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index dfb70faf94b4..362d98dbf8cb 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -363,8 +363,9 @@ static const struct udevice_id qcom_gpio_ids[] = {
 	{ .compatible = "qcom,pm8916-gpio" },
 	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
 	{ .compatible = "qcom,pm8998-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
 	{ .compatible = "qcom,pms405-gpio" },
+	{ .compatible = "qcom,pm6125-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
 	{ .compatible = "qcom,pm8550-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
 	{ }
 };
 

-- 
2.44.0

