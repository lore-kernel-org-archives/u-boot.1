Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60043C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:12:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD2DD87E5D;
	Tue, 30 Jan 2024 15:06:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YVGVV5GA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1038A87E8C; Tue, 30 Jan 2024 15:06:11 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9B3387EDA
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-511207d62b6so361826e87.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623548; x=1707228348; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IUwVlOjkasug5xiwQXMQf6TKBwoPBD4vLVh5BDYYI7I=;
 b=YVGVV5GA3B3E+kM83tHivHhcGHGfabFwPh85eELb5q2ie6SJ3eg/nkWab6bLsq1xFM
 Fd0nUrD7zjIF9S3CreYrNYQuprBdrpQZKhEBYVhzlGuOJRO725++ebA8tffF9eq0g8M2
 O8bTGersi4KdiGbqDl5Z/cvhe+tckA7SpJyU6utsvej5BMpN01gw4jxXLJFuepVGoPjo
 9y07WkZU4hFIYFPZc7l1CT74/vBebb8pJ0a7y6nOYaSgkK9mbEaRQrwqusmJjvjuxU/j
 y/Ynb1luMY59n1o71zMgUckzAOye9TSJOygx4qQ7CQqFyY1vrrWUK+BydO2umou3FfzG
 Rdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623548; x=1707228348;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IUwVlOjkasug5xiwQXMQf6TKBwoPBD4vLVh5BDYYI7I=;
 b=GZVY7cR3a8e7KfP07esicN8b5kyjc4pfha4NsUM8caMjxLXYH9RlAMah4pAMm7Pyp5
 qRhUSMbp+VvW3RP9LrPi3nXwgF5i8+lFbcaP5jry9eA+WfGdiU7obycy44fkgPxV8h63
 w04jdMO9lEn2jb3JKERD4TMFTPmw8XVxkvHZJVe9uSxEMCTLTCYzMQ/EbRLVJutRinz6
 EWVRnkrHswZsDxU0+0VIdMjS2hEZcaoVkYReKO0MNRR9KmZpg7X0hyn6evQ43S60jWHm
 kVlGpdtyQUo0/lEgmf2s9Bvct8Ht65H2u9DrJoTMwml58xmw5tf43kZfBMCbmJll9RQi
 a4UA==
X-Gm-Message-State: AOJu0YzgYMTxt0qiwXuS5fJYZ6ayv1K1e8NzpCM42pfldZ0Da5PNDBAX
 JsgKGo4ckLto7txqwBsH0qsg/xUAUdTKC95KV6vk72jmoFuxbA44D1hqNsThDyg=
X-Google-Smtp-Source: AGHT+IGyU8PHy/agekuJX6nrUO31IWKDLe04Epg5U6f1AyoUwblrwy3VgylvfNd6RMnibgUEuzTYHg==
X-Received: by 2002:ac2:5f4e:0:b0:50e:b204:b6d1 with SMTP id
 14-20020ac25f4e000000b0050eb204b6d1mr5295198lfz.33.1706623548177; 
 Tue, 30 Jan 2024 06:05:48 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:47 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:05:24 +0000
Subject: [PATCH v3 36/36] MAINTAINERS: Qualcomm: add some missing paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-36-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
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
 bh=G/EGekomE4t3s1DKW9uy2tDnRqtVgQYWuXk1dfvq21s=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTMKb9tpWM2++Zta83D1+WdmUhexsEic+iplL/duy9
 HfCQf4DHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAibfYMf4UepnAXCva6vDZt
 vGfOKu/yIPmdzYtTFzWybfv3/lUyO8nIMFVEZ4/Ep5MFct8VWqaX7D1t8FTt7qvl+55ln2ndylb
 x4QgA
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
index da477a4e6add..75f7156f5c0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -574,18 +574,22 @@ M:	Caleb Connolly <caleb.connolly@linaro.org>
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
2.43.0

