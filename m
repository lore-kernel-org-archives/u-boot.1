Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED657C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 21:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE01287FAA;
	Thu, 15 Feb 2024 21:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lbdGMxHp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6690D87F07; Thu, 15 Feb 2024 21:54:17 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A0687F36
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d09bdddfc9so16689491fa.2
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030386; x=1708635186; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GRuImgON68635C61y2wrswywA/M3xEFNmPNS/PzjQ64=;
 b=lbdGMxHprJ2Y8R7P0ozEkoTw5yLmqAs4YUOyR6NfRI8CHQ9ZloO8taoNHzFYInB+/z
 Cl8X3z5NzC82ujv5oYIwBJV5CTqMNyj2yKcLQrRRly3qiWVkcEf5s7m27JmCn7d4lbqT
 vM8zw9yB70TkM0RorPxgrlfpqnb3jxLWGW8Y0xWbXR69vI1YPeoCqDeQjPYhJF9djSMj
 ZCNqYo4Kma9ETUKIdDwzbIGDlwVELfiwzs33GKBCl/NMRlRUQ8lh6ZoGcwSc6abjaSEJ
 GBbB1FP4MvNMl1HipK1Db9FWY1bisvMv+yhC3saLGb0C4fOQAZxe0iBYb6oo4EpcKXRP
 Em9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030386; x=1708635186;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRuImgON68635C61y2wrswywA/M3xEFNmPNS/PzjQ64=;
 b=m9ETo883bZEtRYzRDVPqa3zTlM8T521bEXn/f57yyxJBEBVz78R8++12VYImwWQvQL
 EoGnF0t8lLeKH51BDAo2JnH2c0nfarKtP846RSUbK7UkllZxbrbhZI7p+TQX6CnWJDg+
 2Qk/mPmoW6GdDPHxe59efsQTNCoufRpRHvy51CRyn8ACMGe/HCZZ4/CGEeHWY80BML+X
 ersFKmg79kiez77jyBBx7EvUP4xgbEtQWmJ2Jjv2WnZOKoQnayL14o/tA6DINy0+6PW/
 upwnoaswV1IY3meE9k8dyITdRJ6t362fHzUWpOkbos0QU+jT8B2TjVFlCqRe3NaOqYWR
 47sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwqDMFr0NEnzuf/qJtOZG5py6zqQfPl0+elroVpWHkxQdK3VYafXBuHlNpfUQFmutLmI/3oMQhpEEQfbZzwTaQieSLmA==
X-Gm-Message-State: AOJu0Yx/THDiOL/toNfWB4zRRXXN9z3XL9ul+iSwQ1mrsjEgOVd4dG3t
 TC9zV6NoA5E/Tg+3/k7ByxW9hA0qLOWn5cjMOKvBV0DxcUiGuLsKFGLcYxf/0KFSUkM/ypJsLCd
 p
X-Google-Smtp-Source: AGHT+IHfekHKaWpqrHtSdSE6v1SFyX0K5eQBLXXYFntuSTWVchGOH/4GAZuadVHAbsNVKxdGYLgw0A==
X-Received: by 2002:a2e:3a07:0:b0:2d0:fa5f:af60 with SMTP id
 h7-20020a2e3a07000000b002d0fa5faf60mr2145587lja.18.1708030385928; 
 Thu, 15 Feb 2024 12:53:05 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:53:05 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:57 +0000
Subject: [PATCH v4 39/39] MAINTAINERS: Qualcomm: add some missing paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-39-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=cGPyNx4yf2cePyuZzzLO7l33GOsBYG4W16uUbhTu42Q=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzlR2BEt27d4gvtzZ1ePcr8k+Fs5y7lXOmd0auTPrXf
 y0Xhdg6SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwETYnzP8jw28kP3rQGT3qWtW
 Pf/97s3oP29T/zA6ddoNU19hz2+ThBn+hzN80OXNc521W+Hb4sMyyj+UhDzP/Usseaxa8b9fIV3
 4LQA=
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

Add drivers and DTS files, as well as regex matches for
qcom/qualcomm/snapdragon.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 MAINTAINERS | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46ba17647f3e..8b048b1faf7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -576,18 +576,22 @@ M:	Caleb Connolly <caleb.connolly@linaro.org>
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 R:	Sumit Garg <sumit.garg@linaro.org>
 S:	Maintained
-F:	arch/arm/mach-snapdragon/
-F:	drivers/button/button-qcom-pmic.c
-F:	drivers/clk/qcom/
+F:	arch/arm/dts/msm8*.dtsi
+F:	arch/arm/dts/pm8???.dtsi
+F:	arch/arm/dts/pms405.dtsi
+F:	arch/arm/dts/sdm845.dtsi
+F:	drivers/*/*/pm8???-*
 F:	drivers/gpio/msm_gpio.c
 F:	drivers/mmc/msm_sdhci.c
 F:	drivers/phy/msm8916-usbh-phy.c
-F:	drivers/pinctrl/qcom/
 F:	drivers/serial/serial_msm.c
 F:	drivers/serial/serial_msm_geni.c
 F:	drivers/smem/msm_smem.c
 F:	drivers/spmi/spmi-msm.c
 F:	drivers/usb/host/ehci-msm.c
+N:	qcom
+N:	snapdragon
+N:	qualcomm
 
 ARM STI
 M:	Patrice Chotard <patrice.chotard@foss.st.com>

-- 
2.43.1

