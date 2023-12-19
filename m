Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353BDC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C6687874;
	Tue, 19 Dec 2023 17:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XLufGZKz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8EFB87864; Tue, 19 Dec 2023 17:05:29 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70EFA878AF
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d12b56a38so38487295e9.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001896; x=1703606696; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GwDGw1vDkBu42KU7BklRu/7TWeIKDW8ICE4EXS09uOo=;
 b=XLufGZKz6twOUGIVBdhV69UQadsYRicWCh8M7XB9Wi6iljVXfwi7luuAHQJThpceYz
 dJAsHk6PEaQrG9cJOWCwRvrtQ/800mHk3PZmiIdmtNMJnNc1F7lg5mEyq1ilGFJYtDHk
 vAdZJQA+sLAmbWqaTbI59O4rVFiSpR64a4GtWy0TstKG0jyT59AfK9pQmQFiV9JPBNiA
 uwOOkf2bdKfK3XphqgT1wcyXTpF1fG/srXNw/c/J0jU2DOtGS8NDMYForEEvBf96FPBW
 W8Xvgf0NZn9D8m5+HaYDmU79kAIqpiCmH1qvjgjmS9V7X2xHDrGxvPumVb/xQD+ViG5Q
 Rplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001896; x=1703606696;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GwDGw1vDkBu42KU7BklRu/7TWeIKDW8ICE4EXS09uOo=;
 b=HnElU9Y6gF9K5af9eDsCvvqHpYKVHhely7IoMnMYG5DiTysqd/P5C0yI2G9jWb7xjl
 lfZFkj1LMSRkyczakqtHbzWor0UDNHbMLGVcMpYL2vhjPYA3/rdDPpe8KJNOnDC44arf
 Owm36zyDEOYQl/cwsU5nW9b4EBE9xwYO67rpEwXHkI4avpC3wIIajIan7IgZMQI5VnOl
 GZisVgo/+3Lx2UjIjGcASDuUsh+FWqigk60dvw3GE/T7XseDalRS5vPei9AnSVYuSw4u
 vjZIGQsLkTXC+OytzF2b/nlNOQUGMa2ADl89rXYAC48D3DoAa5mGnmSeR8BKvvPy02a7
 DYGA==
X-Gm-Message-State: AOJu0YzAqtKp+bwg68YEUs/s5h2l2LKHpH8gwm8RnAwxyiuwjU5G2U2f
 DMb2iNYYb5il5y88FMwG3RcLgw==
X-Google-Smtp-Source: AGHT+IHUnDcg7gS2Uuis7m68dQIuqAuW+dMQMYWOpTOser9NoaEHWBJt1nFuyd+mzP86sZ8DWn4cKw==
X-Received: by 2002:a05:600c:1ca7:b0:40b:5e59:f726 with SMTP id
 k39-20020a05600c1ca700b0040b5e59f726mr5031472wms.152.1703001895895; 
 Tue, 19 Dec 2023 08:04:55 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:55 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:33 +0000
Subject: [PATCH v2 32/32] MAINTAINERS: Qualcomm: add some missing paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-32-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=eqQjCTAChQfJ8EnsZUO2re+wsRZxzaG9pZYwSJZSI0g=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/Sype3dvS3+bMKfhqM9cXgbLfMdll8wlA1mnS59TY
 n7zWupCRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIwlyGX0wlr8J+9msWTX9w
 8u+l+G1PPxWH7l9y+EI1Q8nL1Z/iZ3cy/PezLDoXGhr7tH3p3x/WOhWb0ptneS0ycY26WnFo84+
 T2x8CAA==
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 MAINTAINERS | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cd102eaa070..b41801078c94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -571,18 +571,22 @@ M:	Caleb Connolly <caleb.connolly@linaro.org>
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
2.42.1

