Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2495103E18F
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC00184132;
	Wed, 18 Mar 2026 15:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="s6Ydjrrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C8A84142; Wed, 18 Mar 2026 13:47:06 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42827841FF
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 13:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-661be3380adso12695322a12.3
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 05:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773838021; x=1774442821; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=31ui1/O4MEohzRcm+qGZXZUTtz80RnSkAlAH1s+78NA=;
 b=s6YdjrrlGfBrAGWWSYRZMHTRf4vtv4gXtNZTI6BuNuk+5sHoe+OKEOEyy/BP7lpUHH
 of4q+hRvhqfzP9y5tPC6WXax9RdvR0U1AXaqCbJAlOSJtHyptCULycVn08nDEbBdKkVo
 t1DkjaEz5KYwN7jwC6jBANx0pUSbNhJFBcM5H/NdMkAbXRvAZ+RyJg8gVr00rZqkDGK6
 vVKFTNcm7gS5/DyJTZ8kKAGNCZV3JsSuordixVS4IDwBbm1Kw5ASDJhduDUO/wwGVztY
 OYENGc5Xc41hd8mF25eYbWwIfHnuAAVVwgzaFODhEZnk42ZYg/+U5taPleUbb+LIm2Gd
 ukdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773838021; x=1774442821;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=31ui1/O4MEohzRcm+qGZXZUTtz80RnSkAlAH1s+78NA=;
 b=P9p1BnpOLTOlyav6kUuvIVOYGXUqbgpk4bMHR7TjUtbiBMjr/z0YyJEMKdL/1KeZbP
 URHSvVSW+jVBJM8YqmB8XHt2uzLGrL/fYWN+wbwrQx9VoGsFtSqNQ2S/OnUpy7Ea8OhX
 RtiOIECgBVz2zl6K2Nl3znTV1WCARbKF0HUYIoxU8a+px8m7MMoteAiIp9X8v3Zg3Xu3
 38dE+GNIFdrb7Bmznh50flqCfZrNMl89syk3/f/ngmCG3sRGnVmoulq9uJguXitHl7Ve
 cwk19kwyutSYWBtgGsQQVWxICYbGtprQgDrHy8TcFYHzml/8UNUir68AkuMu6PULkRoq
 GaBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9eeyUfgwslnItawVnanUyqaMZmRbzm4p+kOcme+7SU6P5DRa8iKwXZ9SiN0IZh9G75KTLYe4=@lists.denx.de
X-Gm-Message-State: AOJu0YwfBEts1d/k57OF01gdqKK50VvM/7Je4imOphuimdIisgdFqp7v
 B7QtZHhnEzjMLliQ0HEW2lnL+CN2/v9AANxGEKtfW47nE0t2TjEKuJhKxtTVKDsfIks=
X-Gm-Gg: ATEYQzz/rVxjdbpEHRovTlrBfyIV1Z6x/bDzfMim9DWL6npbK5oenlRVcO1pjPLGOAE
 ZFjoCC2bxhF9GpA2r1GtwCZvgEPBD/x1Gv/QFOah59NxT17jl2aeZg31wkPdYe3dhZwVkJqjDDD
 jRqLQmFxFrlXqEFfrodjysyoi5PHlsgg732JV+IDfVaSs+DdAQGknRfHS51P4yg+j8+Rs/YSEJJ
 NAbVMXjpvDL942CPrxVxN8iQcJq0n+jF4qZkfTRJm5+nPbbszt7dnryvFHWmxFEIsNbGWRwKFTF
 Hdm779QKkx+CoycYSPNK+TNcXkz3pEzrD/huGMMs5M8Zfvaez+YkHa2yn5K26Xdj43/MsijCoWb
 OB50vG+fCnAoP8+IwtVsuDuggCPhY5PpW+neizYE4ynMGRvjWs6orknSSuiRXo6ZIeDoH5Xd9JU
 dnOVtEdhnbFCYXZ/6xYi2Xf/lKRxP5sdP9MfDLvX/x+TWy8SqMabJ+EzV8cYopt/tDwpOlMM6Av
 Coc6Q==
X-Received: by 2002:a17:907:2da7:b0:b97:a5a2:cec8 with SMTP id
 a640c23a62f3a-b97f4863c2dmr240530966b.11.1773838020576; 
 Wed, 18 Mar 2026 05:47:00 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f142cf16sm206080366b.20.2026.03.18.05.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 05:47:00 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Mar 2026 13:46:31 +0100
Subject: [PATCH v2 5/7] gpio: qcom: Support GPIOs on PM7550 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-milos-bringup-v2-5-650b91dd75d8@fairphone.com>
References: <20260318-milos-bringup-v2-0-650b91dd75d8@fairphone.com>
In-Reply-To: <20260318-milos-bringup-v2-0-650b91dd75d8@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773838014; l=912;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=FaJUH3hfjmoc0nLsN/nxQANSPNgiu/9B1oV/scZlj+o=;
 b=0ugL5pG+mi78eQWIO2a226a2F1LN0Vbk9rTqiQyewo5S0BwJRZeLhuKa4Xl8IR9Ya2B17K4G2
 pHijdi5YA7QBn/jUcsCBOrsdwH7Yyfs/S2hKoH7wbEhbWDMEOvz8jUB
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 18 Mar 2026 15:44:14 +0100
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

The GPIOs on PM7550 work fine using the qcom_spmi_gpio driver and
enables the use of the Volume Up button on the Fairphone (Gen. 6)
smartphone.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/gpio/qcom_spmi_gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
index 1a7c7c48dfc..77a69140213 100644
--- a/drivers/gpio/qcom_spmi_gpio.c
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -747,6 +747,7 @@ static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
 	{ .compatible = "qcom,pm6350-gpio" },
 	{ .compatible = "qcom,pm660l-gpio" },
 	{ .compatible = "qcom,pm7325-gpio" },
+	{ .compatible = "qcom,pm7550-gpio" },
 	{ .compatible = "qcom,pm8550-gpio" },
 	{ .compatible = "qcom,pm8550b-gpio" },
 	{ .compatible = "qcom,pm8550ve-gpio" },

-- 
2.53.0

