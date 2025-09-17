Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0907DCAC5A8
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 16:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB227837B9;
	Wed, 17 Sep 2025 18:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="efSBqVyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF4B9835A2; Wed, 17 Sep 2025 14:47:57 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA73080C93
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 14:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b079c13240eso1067396566b.1
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 05:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758113275; x=1758718075; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hroQZTh6lemAPc2qiL/lmXc7F/j1zZ1C0hRs/gJRotQ=;
 b=efSBqVyDlFzVhnLTcnFSe1+VD52fnY8nr8HiJ9ow7FW38WK3khGcJEjt9zaJzlz+3H
 Vhka3xAEXRAbyRmQj2FAAg7fo6bwqVTex0KGXm/R3XCcYy/aEAQIYImn2WIE8RoYmkY8
 y/OrFY/CeRErTg1lh7fXNhRZnNlzGf+ZQhvpFS+t+UY2MmG1ETr/lQD7EIriRovuLxm2
 cb4t8p0sZGG8QyN8MLZBwtA5YhyJcFaXWcRE7oYaaf3Wc6JnySfmdrxDKXH+51GO0feq
 jn3QzjkN0CwtKBxqsUEd7gZWbtGS28jVwX4/cZIKHY/D+Am6JgjnPVzpnMDv3h87VJu/
 rfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758113275; x=1758718075;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hroQZTh6lemAPc2qiL/lmXc7F/j1zZ1C0hRs/gJRotQ=;
 b=FeeGS+iL6hTXv2A+ifdPAPojfGr/tC6RYQTLb/y/ulGQBxrWkgaEdejsmeLgv5YtHT
 Q4tsZ8/zU3S80ajCO7iNNWeEfoOsUUVcMRQKmmvY0Z9GpS6gHIYKjQONzejV/0VF7hYG
 EP7eCLuPSpY/oHG2rGLpzhoo5IqJt6v33dzh3aZInSRI2yu/6MlyStq5Xy4oh2apHukp
 G8AjgxU34E7zOTGJKv9BQtEeNPHbcogPaG1WmuK6RnHpBDfJAHJx7hgH4h0SVnyfHr9V
 ugIsPfF5QNZK9fx8UyO+YqckHB2cZOFkkFDBfG9l+aMEbNYl8Dr8gCTlADodKGyFrUxD
 m86A==
X-Gm-Message-State: AOJu0Yyy8QJqRl9fEgfups3sB8izt2XkhpSpLbCg6Ff6bu8mKu8kkSL3
 C6jj5/25f/tHZEr8rKy/z5R6hO70EpNsq64wkczTPf5KqrgBhmEQHL8FnSlCr9m8QjE=
X-Gm-Gg: ASbGncslYDrcE8ghOrqewpYulx//KG4WBK5W0xqnWgjkSw7Gc+YKh4JHGjgwXvQcFX7
 4OApMGaoTR2ony+xhfXHbNPr5BwqlrXwvN5CZ2ms1aQ3WoUMbJh5M/mgzcwAiqx5ZEsKxtMVD+e
 egzvzryJrVEh0mfgK+EQtVC9wDN26TosYMuY46OFiJ8BjYlsVNA7QlzsJhLNoIzFF9L8fVGI3CN
 d8yG8bL1KEkh/QLfz3QWdmSHF3ndgVN5z8FC6/eyY7D47f23MYOTopaUP+gwWErMla3xNay7mSE
 PEXF5t/7VihprRoUJkGNLIf1OCD/wQM2EWqAKltuqJY+ZQzXe/X4dx9MyDMnzzOIlZRbd4tZ6oB
 CvNRgHIvBD832/9rbG4tAwdLBRH8oHUXv08KVO+SJO9jk3R56Lr+WpzjihQfkgPajEjOO+Q==
X-Google-Smtp-Source: AGHT+IE1UjeSnZvERvwSNRRBSHOzfNvv+CIitSEkkbpODdJ//DM8sD8jg23UlfQernJswKdEQjdJ3g==
X-Received: by 2002:a17:907:8691:b0:afe:ea93:ddbb with SMTP id
 a640c23a62f3a-b1bb8300984mr241481866b.45.1758113275292; 
 Wed, 17 Sep 2025 05:47:55 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b08cab32303sm937441866b.72.2025.09.17.05.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:47:54 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 17 Sep 2025 14:47:40 +0200
Subject: [PATCH v2 7/9] gpio: qcom: Support GPIOs on PM6350 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-sm6350-bringup-v2-7-13346fc2a2f6@fairphone.com>
References: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
In-Reply-To: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758113268; l=844;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=e4cgKiuOYUyNUE/CYSYpYCqOXNLEqFI56tAAmVoYLMY=;
 b=g7v762O7pZ8137/SYgTpyaB26HWMMC5uLXLZTe+JeKTEsbFYZ2DTLhc1qGw17oB/Ksg64h7UH
 SbdaytYHb3eCkEX1cr1AEIwDQsp5mew+h4BMfsfKZaNPXuNPAIkFdJK
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 17 Sep 2025 18:22:41 +0200
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

The GPIOs on PM6350 work fine using the qcom_spmi_gpio driver and
enables the use of the Volume Up button Fairphone 4 smartphone.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/gpio/qcom_spmi_gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
index 22c8072534e9188445f0aaef5336863fd1da7a75..3f3c98e2d935a34bb030532025e8765a2dd2b186 100644
--- a/drivers/gpio/qcom_spmi_gpio.c
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -743,6 +743,7 @@ static int qcom_spmi_pmic_gpio_probe(struct udevice *dev)
 }
 
 static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
+	{ .compatible = "qcom,pm6350-gpio" },
 	{ .compatible = "qcom,pm8550-gpio" },
 	{ .compatible = "qcom,pm8550b-gpio" },
 	{ .compatible = "qcom,pm8550ve-gpio" },

-- 
2.51.0

