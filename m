Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DED7C54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B1B88019;
	Tue, 19 Mar 2024 13:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jhiCCKjh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 493F6880A7; Tue, 19 Mar 2024 13:22:55 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1B358806F
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33ed6078884so2148652f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850968; x=1711455768; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p1DgpWWU6EAciyMI+tFL4AWkmHHqHFUrK84uXLk8RKs=;
 b=jhiCCKjh3uqajxveV7F9iLK5gkvMPKv305pIoESEGNabj+/IbXzrzQyyTyJw8HzGcV
 58yEJJYnAmIJYHZUJkRrsxshyEZEXUO982Er4XskwOdsBODjLkkQVRFi+ldtSV5/rTsI
 mWo2IxEJrw9G8zHfsHExIETpTcqQZi4kjjJOVBtoafn58mtrXokBD+VR4F2QG2FMlsDT
 eWAagciO+yQvm6BLPeCgNq44GLZ9TCR8P8FTlMO/pX/p3/LXX9hqd0H+XbmjBBIGt+mV
 xYJcVOe84fxJU/Xaq8R1wSs14jKcQzOCt4PrV7OoJc7z5CuiJfBzU3FG3sIqmjuuFaKh
 t3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850968; x=1711455768;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p1DgpWWU6EAciyMI+tFL4AWkmHHqHFUrK84uXLk8RKs=;
 b=kdllVt0BQTXgisz5mwst0H54I7L/W9uu0Hes1bAeTYdMeM0XCWVs1IJLya4G5hHZ9y
 qz4AYMzHGZiIMh3xDooYQRi50lgdoM7kFkkKftwxoEaesvTtPtzrHu1kQskwOYAn01Ym
 SRxmDjpn76LwnN6x6cdQqMmjgekjacikrlgUWyvDidOeSMJgCNYjGzmoBih7p6ftc7H4
 8pTsp/tE/4F7gKiqpAm5AvU+9S+KGT4cLUMIsMbepQJUWYBgsROpUpZuIvBBKeGY+W99
 kn54VTvGMXsLJB7o/N8Qdett7nGpPJgey0pI+BjNZqPJCg1j4iczcz+BRWEfN9q1lNvi
 MSOw==
X-Gm-Message-State: AOJu0Yx/bYYRTL6AGCHlwlW5pr6x2uQJMHTspwl6UrQqzcilYvgiRzoX
 j/TP62BjypCGF8GDQ70BtWLsctfOZAl0sitfIAlmznTCpHqgKtNLl/D0lcKs3YR8MO8YKqDqvOQ
 B
X-Google-Smtp-Source: AGHT+IHHx06/slZyA5Yhoklam9XKKt+JilKoypscSKHHb8Z6ZtYizR9XMWbtxKSgOfAuc3e+MJWzrQ==
X-Received: by 2002:a5d:694c:0:b0:33d:7e9:9543 with SMTP id
 r12-20020a5d694c000000b0033d07e99543mr2653197wrw.32.1710850967983; 
 Tue, 19 Mar 2024 05:22:47 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 du18-20020a0560000d5200b0033b7ce8b496sm12170498wrb.108.2024.03.19.05.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:22:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Mar 2024 12:22:11 +0000
Subject: [PATCH v3 12/14] dts: sdm845-db845c: add u-boot fixups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-b4-qcom-livetree-v3-12-e1b38d9b4fa4@linaro.org>
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=YmBgscYN04ZbVZGGJFD08tSuDrrGuIbLaNGLiTo8A1w=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfzV1/mpc95eapMemNPVi5ofru17cLnC60HJF3bU8xy
 PbLT/nVUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbSsJKRoScrgV9/hZvcrkMx
 Rjfd1v/97J9wxPSL2Zp/N30CfZcuOsrw39dgz9o/xRL7EgJuSSmpKmt/zblwrWfbJKt1RVOvdd9
 a6AsA
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

The USB VBUS supply for the type-A port is enabled via a GPIO regulator.
This is incorrectly modelled in Linux where only the PCIe dependency is
expressed. Add a U-Boot specific dtsi snippet so that this supply will
get enabled when initialising USB.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/sdm845-db845c-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/sdm845-db845c-u-boot.dtsi b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
new file mode 100644
index 000000000000..3c83e21251c4
--- /dev/null
+++ b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* This GPIO must be turned on to enable the 5v VBUS
+ * supply on the USB port.
+ */
+&usb_2_dwc3 {
+	vbus-supply = <&pcie0_3p3v_dual>;
+};

-- 
2.44.0

