Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90307C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B025E87FFF;
	Fri, 15 Mar 2024 16:06:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XHHQ8Y2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FCE887FDD; Fri, 15 Mar 2024 16:06:15 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069508800B
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:06:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5131a9b3d5bso2634441e87.0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515169; x=1711119969; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e9PNn3A0M8j5XRDzvbl1vLHxbY2HeF4JRZJRcDlmjgE=;
 b=XHHQ8Y2XpHeG7uMhfEfLxw1mq4xoKJIFydTi0oYZ2Lk6ENr8DD1WwDVjOFoNrnQibd
 B7fdWzOZz7Pnop6BhawGz/+xKxEoT6+gRi60oiOihMjUucodbDzzjiNRgvesp8WtvRVw
 o7h19FhYrKyen1w3hoOTafV2yZagWzPm8SXh1Cp1eAInQAsFqSzPHiDMZcS5dKgO5aq0
 d1XsGOC1vHi4cSweSLGgn8X3aF46rvsPDY/IAIYmhW6KAPICmm+AYn9NT1X/g4op94g7
 Sm9Akj3buiRSvlQ7ESiY4cidEM0C1+DIQ/qjHloA/FtR7OuLCq0w9Wo6iFbqxcu2WUvz
 UIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515169; x=1711119969;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e9PNn3A0M8j5XRDzvbl1vLHxbY2HeF4JRZJRcDlmjgE=;
 b=jnIPbV3tlQvZi/bvb2d2M5lK7alKLvSX/8nuXODkLDb1aMC1RICKleQjoYf+l/ofwG
 wHS2NpcrBq0LpnLjxEjaXXzC9V5cuA8/cuYOY3SSmU3rbJibwilF0wIirMQ3vZLrKc62
 RLCRXc8Wf1E6Z7whWu7fzKruhf2iNLY7L0EO22Mj+QkECYDmwsnQB1UOK1fG0x5QJJj5
 /MUuHDueVopFsfPErY13Nf8e5zo1yJRZR0Iw+PzrFvehI4eqaw8Vr9ifjvcsHfW2ixPR
 g4wIYrPEfy5jKRzc5pNtKwKBh/b91ICk6FXsav6jANhAdiNsy7/v1muW0+CvPmdNsSzO
 Zu8g==
X-Gm-Message-State: AOJu0YxADFl17vwm79kX6Hjw+5egAmVMmsHTEf6lx1MGdYf7et8kgksI
 lxxN5QStNjhWy7WYjR7K22ZqcNs6g9vZTdY68dW0S60pf0TbcyG39USnVynRHIw=
X-Google-Smtp-Source: AGHT+IGbJmQGgDwFXBg0ghjxNiXHSqmcc2f4MO7f+iugGXweGVwmFnPfF+2Av5FEVUzSxtSkLHdqJA==
X-Received: by 2002:a19:5f04:0:b0:513:cd2e:ceae with SMTP id
 t4-20020a195f04000000b00513cd2eceaemr3541890lfb.20.1710515169373; 
 Fri, 15 Mar 2024 08:06:09 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 jg28-20020a05600ca01c00b0041401fbe446sm1939502wmb.11.2024.03.15.08.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:06:08 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:06:02 +0000
Subject: [PATCH v2 3/5] usb: gadget: CDC ACM: call usb_gadget_initialize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-usb-v2-3-5467ec27cb26@linaro.org>
References: <20240315-b4-qcom-usb-v2-0-5467ec27cb26@linaro.org>
In-Reply-To: <20240315-b4-qcom-usb-v2-0-5467ec27cb26@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=iF44ey0WhRVVVgOg2Xo34JBjuNlV4OImTlpeBMxGr20=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvyXc1Fuc4y10SOP4idWL8zd8PuFdWNW8OF1S8GFk74
 51mpgxjRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhI+29GhtbSpud+Jpc/58RK
 fK28s+3ZA8cQtffP/livL7nU2eccupqRYUptx/nwmxJ/Z3sxyPgwNTu4Wt24PdV59u2+lyH1NjF
 nLwIA
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

To actually use the gadget the peripheral driver must be probed and we
must call g_dnl_clear_detach(). Otherwise acm_stdio_start() will always
fail to find a UDC on DT platforms.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/usb/gadget/f_acm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index de42e0189e8d..ba216128ab27 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -622,14 +622,23 @@ static void acm_stdio_puts(struct stdio_dev *dev, const char *str)
 }
 
 static int acm_stdio_start(struct stdio_dev *dev)
 {
+	struct udevice *udc;
 	int ret;
 
 	if (dev->priv) { /* function already exist */
 		return 0;
 	}
 
+	ret = udc_device_get_by_index(0, &udc);
+	if (ret) {
+		pr_err("USB init failed: %d\n", ret);
+		return ret;
+	}
+
+	g_dnl_clear_detach();
+
 	ret = g_dnl_register("usb_serial_acm");
 	if (ret)
 		return ret;
 

-- 
2.44.0

