Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F367C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 533F488017;
	Mon, 26 Feb 2024 18:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pP8Cfyye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0046887FC0; Mon, 26 Feb 2024 18:27:23 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 273498801A
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:27:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33de4d3483eso440021f8f.3
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968420; x=1709573220; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1aiJTVbpJdRSa3Qg4hyrSKKN4cFrRLxr5dBu+hyKbi8=;
 b=pP8Cfyye2eQxT8R49k112ufVp6llxdMgseglvuTe/Bs+uwpi18SClj3Fdc6YFBWaQQ
 oJZl9VIKNNbGWYar7LmYQVAvSB1TolDJXIALFeeAgdhCtk1pfcdZnMGPvh8+W5UjkPLK
 uKdoZU6Pp6OvvdLwvffAP0ktaLcjnZNZHKEfymscCVcIJBzH2MTqIlJd4vCGqbOwIZmI
 riXQ9fdUicGsjFRJdchVGsxgR7qyOXRzQyUSInJMTkEoSnpYxDtm5YRotncUum21bw4O
 AU930B03zQGmGhQFkFDTxsZdAbAyTCS7SCf8dVaBI83Nhk/4BxYNF94ny/jY5Se4kO8J
 KcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968420; x=1709573220;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1aiJTVbpJdRSa3Qg4hyrSKKN4cFrRLxr5dBu+hyKbi8=;
 b=KQO6rliReTeGL67SyDJrLsW3H5Ru4EvBGVUCPhMV3LFbdiPD6ORvW6tk8ymTdGPXCg
 R3D7zcmZp1FSTxy4XsNDfcMJf2AkjisVArxlu5TEaa9KYRHDnxJNEb5/NDscuM5cyB7f
 EKO7Btt+KZUnYRrNNmaTrjz/4SdCVR3jfHm28yvoLA2J6FaI+Ea6BT1/bnbjCq5AwBqw
 AaeGTdXwc691XiT1/31Wv+YZCLNRCD6/pi/Vi3uksrq4ZFw99sNZ/qtSRlePnncMsa6Z
 h6LiJXYYC1v78zFQVsm36gqgaGFFSPTKua5BmVCGyCNqf6TNV1e6wMz0UKBy/FRXTnZv
 j9OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnkQ/dULtRhtEPOtaTf7StC7gNmfOgIiGxXMToYDtrlDa4lz7i8qYOW09On2qmppk5vTek+JGiB462DKaqZ6b3ixczqQ==
X-Gm-Message-State: AOJu0YwR4OMJJkq5s3Gdj4uLdvX6CVoRaZ6LGg3NXxsU+1SPG5+OL1kB
 dJr2hwPKdUKflSQQi+u+LdVpEA3Dxd0+mfTtBK5TyKL71O1CcYaEjHgGYggGo2yeJjFWUFG+qIM
 M
X-Google-Smtp-Source: AGHT+IGS4SoTBVDrgWYisO3MLxE0TFb5b+r3xgP0uK5bf8WF4lIz++FjtwmoXLbPPnHLrY77v1GtoA==
X-Received: by 2002:adf:f28d:0:b0:33d:731f:b74e with SMTP id
 k13-20020adff28d000000b0033d731fb74emr6101176wro.6.1708968420742; 
 Mon, 26 Feb 2024 09:27:00 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:27:00 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:43 +0000
Subject: [PATCH v5 39/39] MAINTAINERS: Qualcomm: add some missing paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-39-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1305;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=sbYigozZf+ZrqAXacEFqr/w3B1NbnoXthKGgaNOy8vc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J/fe/XQ1eXObUXTHoaX5izayRBRvcjbIX3bHkfmsv
 nH5rCSljlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRZ1cZGSZfnvPmYbXccj1n
 2+2FecsmP3p9wlMvamPDnLAz7qzGpqKMDLNDbp79rR28xK8rxs7GYMP8gqZtLzOcd8xq77pUE79
 2SysA
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
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 MAINTAINERS | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b08ca192397..22e807d36b6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -602,20 +602,24 @@ ARM SNAPDRAGON
 M:	Caleb Connolly <caleb.connolly@linaro.org>
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
 S:	Maintained

-- 
2.43.1

