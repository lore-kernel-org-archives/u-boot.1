Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12F7C3DA42
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 11:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A756886DB;
	Mon,  8 Jul 2024 13:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w6sGY1nw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D459788703; Mon,  8 Jul 2024 13:33:14 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A065886E8
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 13:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a77cc73d35fso455910766b.0
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 04:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720438391; x=1721043191; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nIIvJbrAbNJRYWo+J18YgLbk7RXm9zDJv7nP2Beyq5g=;
 b=w6sGY1nwNhpadq+qILH41q6dZ/3FOvKcO4Ae1hsCL/ocTPkhRqr4HezpfDTus+D24c
 oFL3tg2vXQ9I/4ciM42b/PvMOhEZemkzVs7Gzn1cHq+IwPZeyGWEzthV1iiTYbSQldrQ
 0QEoOMgTO3jluxbpjAaOAn6Zc6+Fia0ig8GsGQDEl+TrLeUcmQEkXEo3uzkobwVJCVij
 rzekf8+mKo0GkCc3HeEMGznWdTZRpgvsV4t4PqJUOgd18J6vVyx157Z4/1C9p7G1COMJ
 QfoIY89l1xwWtKhBdCuMbDphkDKkj2rDHjfpkgXKiJ1tHhWSU2wXfibtqG7mc3J+G5To
 Y+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720438391; x=1721043191;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIIvJbrAbNJRYWo+J18YgLbk7RXm9zDJv7nP2Beyq5g=;
 b=Rx+dqi0EoEggYs719dlkn9OI3WKIeSXOg4Z9tlNtk1MpdaqPq/DitAfyK0JRXFXFlX
 eLFV/pJ7P0lF19BKDA+4FL2aoQRz0HcV6oQ5hf2whvKbs3iP0KWgFm4Ay7bTakYLntQJ
 2rp2fBbVj6aptYLpgA7c0nbIAPrIeFTpHl3/aUJmimr3Kl8hZeML3L0FFmcKUSUk5jju
 lacioHiheACgIR+xm1v10j69tX8kBhF1a/YLhr3ZUwqTt5tS7eZnVvwXbmJRIUgj6cdi
 OQfp2xuwzu3iXOVR88Dw22sHSlUqsNjNLxMfVFID2tqWmANmCEKZ8ERJ9i/gftOrlJLk
 dV3g==
X-Gm-Message-State: AOJu0Yyc/N4LpO7WPT7IFq1D9vzCOnFyP7KLrYp5I5bLvWB2c/cCRq1b
 uI4SXBch0W+6wDriDIdzsKktQ6k957GW5WZjqknwj4wrbKfKBoj/Mc4vxDhqUBFf2dfIZuvd1Nh
 g3/c=
X-Google-Smtp-Source: AGHT+IFZItE6VqIk5uWK9TqqJDuW0oPJAtwf4AfKiyeYZzRZVu+p71QyAFNWGvrOf6z7cSkiSQB88w==
X-Received: by 2002:a17:906:2bc2:b0:a77:dd70:a161 with SMTP id
 a640c23a62f3a-a77dd70a6d8mr604558966b.10.1720438390782; 
 Mon, 08 Jul 2024 04:33:10 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77c9925463sm303628466b.69.2024.07.08.04.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 04:33:10 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 08 Jul 2024 13:32:56 +0200
Subject: [PATCH v2 4/4] qcom_defconfig: enable rpmh regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-b4-qcom-rpmh-v2-4-8bc765606e56@linaro.org>
References: <20240708-b4-qcom-rpmh-v2-0-8bc765606e56@linaro.org>
In-Reply-To: <20240708-b4-qcom-rpmh-v2-0-8bc765606e56@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=gRFw9sllDNNt4nSyWXUL+01p1obRypQjKFtWQBwneRw=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmi85wl461iyakkFwvvG+IZdicpOTSKg5BvK4h6
 iyuCGisOTCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZovOcAAKCRAFgzErGV9k
 tmniD/4+YR+2MwjDRZdsfuOXksr7jXMQJRkio985rsaGbOkGrU3PeZD++W8l92onkLUYWXdv0EX
 QWasrB+63bm2AwtfNz+ptEnJkicvESCCNPFo9xDwJr3NPSagrnfWXDHJxW7lhnwJSseM3uWMFyx
 50idHel4O/Bgg3sMflzMl4kdAdj7w8elZBmLjM1H46fKc61ZhS+Fm5Q6JCu91e2buACkfmi5RHu
 IUL/oNBEltKCjP2GqGkX8uvdp2ddUlZTLIARZRrr587iXXsuHvQHMZUtiqFnnKXcnUs9y7q/avA
 vlzi3++teV+cWgZ5k+m5zgj9237mX/Tp+kGfG0wdYnuVRZ/cXD4z9Y9vKtu6O069O8IrA1v/Rw9
 /LbwP0M3fTRpnd3TuJf96M7khBWecUIADgRIOg9pKJZ2j8zVeRxOaji8XN1j8VUu8kTzw1NchTA
 5+op45trj5sRGYqdO2chcFndwydneUXn/fZsoTYeNCl6Nm7YQsgOF6jY4CBAkUd1l7MOEFTa8DR
 jyL08RDaHJXCsDqMH9nCKeYP9jtyNGAvvZfDz1dOz4iWHxGaXeTID5Ct7AVdtWF/tgfD2WBy7+O
 4DU+QBw3WsPLfVtfgzSTkASMnrVxOG/yENB4N2WhSutiAd/qugYWFyTV8aCUDj5+WNbhvfmQdSv
 YH3p5FftW24YBtw==
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

Enable RPMh, cmd-db, and RPMh regulators. Additionally enable
CMD_REGULATOR for debugging.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 60a8e38cc6bb..8a55bb9af708 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -35,8 +35,9 @@ CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
@@ -90,11 +91,15 @@ CONFIG_PINCTRL_QCOM_SM8650=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_QCOM_RPMH=y
 CONFIG_SCSI=y
 CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_RPMH=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y

-- 
2.45.2

