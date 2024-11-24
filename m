Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8503FD75E5D
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 20:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB0B1899C3;
	Sun, 24 Nov 2024 21:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CRyaQzBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9651899B1; Sun, 24 Nov 2024 21:27:51 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B5A9899B1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 21:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa549d9dffdso93782066b.2
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 12:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732480068; x=1733084868; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fe8hsgm9j+tJkFel+8Ij9tGx+yPDSUwYvyvHQZyhCzE=;
 b=CRyaQzBFLLrEL6uN9Ehk92JT63leV7J5Sve0l1WcRichszQvGF7EBKOigG+yIxhguw
 1b9+E+8Qstym6878LiuhdYbwxef+eXdDX1ZXQwoHu1UWH6MSq4DoFkzPpG/4FNN/XPjG
 5RoXvZfMsc00NnOv5tR4L+S8r3wB0FSnO+30S5/3MICV0xwhdygOb9cewGpTuQ7lP8rx
 uELn3p/zAc0bmUwoPI/f1OOgB9UWswtLvm3t9AMH0rcRH/jO9/Yo7sZEIIeF950LdwiQ
 fvPaSxt7e83Dh049X2IPMBacQ6ZbjGK6EcCabBc5AEH1i55gSRyWMAXJpK5VedSeOsJI
 Kqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732480068; x=1733084868;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fe8hsgm9j+tJkFel+8Ij9tGx+yPDSUwYvyvHQZyhCzE=;
 b=nwEKy2UjX19SEyK0mmCzA+0TMyvAsMYqN6GHfc9d90Av0wp7Szxza2oPt7aEmuB9oj
 nPZr4calAa4Zz3WOhfAz0nXYkUIksmWJAnK6daLy3xLanQ370OQIcNN+eyHiSxnOHePk
 SvyXKsrMI2DepRGXyDSVb7/X/lYmNw8mT1sRIEGqhvBkh22nikYQZYjVgbtUquHDxX5n
 Ce6Ny0Qvt27b8WLAWqcvxG8pya/G1afWE6Yvh1FR+k1C/pdNvEjn+fIaneCA0+82oLSI
 7Ne0Ts2IjbgD5jKkKMXqjcrgviINWnvkWTT5Hlm0IwVGqua088o1UCsa1mZmJCLeorfu
 jW5Q==
X-Gm-Message-State: AOJu0YzrVqxOcyCnOYoSCiOvO3JsOoHoy66gbHfQeNcbQu3OwVXkbS0x
 inbDhMiS9c5R542hXQZG7pNYTuhed/RfgICWIXk/Aq8TIGC8e22MlVPcLCbX6yk=
X-Gm-Gg: ASbGncu6kuj1NfuC9ETn6P/KxctSiNnmbENj3+Zhl0BwU+WNFhBksOWxSKqzOYH1Bol
 DR5LalmJSSuAjuEmFP0pjfwr1NvVxafeEnziamZK0VubpegOH2dhRkBtvVm8FHzSt/wZVgR6kvU
 KVGIPTxHgspFfyTt0EekLA4N11/1EAMeIjgW4DhykFltNotFVGD9ERBgEkYX9JSF/jjYe+mDHIo
 vSP8hjJm7dUI/Hqsj2SHLKfh5Vjm1BozEPRAQ3KSSKZqBd00bz+KEa8hExlJHVwj4lO
X-Google-Smtp-Source: AGHT+IEeQ1Bmwb/5PvFpV5wGbuW52RHAPNOInuBzR7+SJ+a6NyRUng11EqmL5OpMUNxicKbgKfcGCg==
X-Received: by 2002:a17:906:2931:b0:aa1:dd58:aebc with SMTP id
 a640c23a62f3a-aa521fdcdd3mr653204866b.39.1732480068542; 
 Sun, 24 Nov 2024 12:27:48 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28cda1sm378720666b.9.2024.11.24.12.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 12:27:48 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 21:27:09 +0100
Subject: [PATCH RFC 13/14] qcom_defconfig: enable X1E80100 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-efistub-arm64-v1-13-3e33f0340071@linaro.org>
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=672;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=kzNN57up+QIhcMiwGYOZjS1cr7Nr4YzcMPUc91iGM+E=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTnHqO7lk0LPxgwhNrcT77SV2PLYrxc1zNTnWWe6CMXf
 YZjbzQ7SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwEQkfzL8r5CUVfiyYP6kP5vm
 33br9lwRsPn2J8uFE4ukzmk4KG1mC2L4H7A+8ItulbP+xEj2yYzyW5cKGpZcuHQ2u5YpMPIAlwi
 fPQA=
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

From: Neil Armstrong <neil.armstrong@linaro.org>

Enable the X1E80100 pinctrl driver in the Qualcomm defconfig.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 8e9cb3cddaa3..877c48b5684c 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -99,8 +99,9 @@ CONFIG_PINCTRL_QCOM_SM6115=y
 CONFIG_PINCTRL_QCOM_SM8150=y
 CONFIG_PINCTRL_QCOM_SM8250=y
 CONFIG_PINCTRL_QCOM_SM8550=y
 CONFIG_PINCTRL_QCOM_SM8650=y
+CONFIG_PINCTRL_QCOM_X1E80100=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y

-- 
2.47.0

