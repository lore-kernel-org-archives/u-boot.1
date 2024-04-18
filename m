Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E82DC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 09:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0630885AE;
	Thu, 18 Apr 2024 11:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="XgWgcrT6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E51D9885AD; Thu, 18 Apr 2024 11:14:41 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E71E788120
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 11:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a523524e5baso58643866b.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713431679; x=1714036479; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q8Op8D0sCv9gs8k/sPlG3CKjR/OHqAO4Syv3WsRD+Gs=;
 b=XgWgcrT6wAkwWDqgmHvg9y4c3I+3ZUXi6zNLmK/v3S0RNWbOnTyqfnDOvu1pRW2DJE
 CCqwQieXeb/26uieOz5qu0QTq7rMr0czKUfPZvEc6G//NgB/ngnVNsXsZj0MSCPlBaYs
 kFV/NqXsRXtb2v/kIl6x3LwqfYKdWklJdxj+RUhH8JwFDxUsuspTYzMrFGDn23fUUiBh
 v3gLkyDELVpTIYw12vqZ/kYxOZvTD+LCI/Uk9c+59AfvSOxIIWtX17Z4+KCO/YkK7vKf
 5OCjLZ+oJQdUYl2+1Dp+MQVvvyCaSxMio9tbjr1arU74/uVGwhFtYft/YEzSpUN5udht
 v35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713431679; x=1714036479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q8Op8D0sCv9gs8k/sPlG3CKjR/OHqAO4Syv3WsRD+Gs=;
 b=IYI5pBbawaJ6X0FBUBNYt0S2nPLMQJWxQGXI5yzD9hG6KYfIC6XxM5TzafAvccROIG
 E4d2C7/anb+DhvqZpjk5QDCQlvGU8W2fZTfequUnOucZ0LDugkC7vb8Wpx+K0d5gsTog
 +l/1OTdvfHZFcxDvfmznzHX0Zc5k/9BtpoHGsx2muXv4B/cyFVE5pQxkOpllGyp6pWL3
 ntRB0DGR5DefBTOfWWlhIbeeRk9lkCG6ppBw0IYUENxN5ZJ0C8OswV/ticrsJNsURwCV
 sSwuE0EsRl8dYiCGhpZPJU1yLSSgaeUeL3XZ2uOiDsEGxEcYrMAFHRnRFwCEEPVtA6rG
 hqnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0unfYfvWotHduLRR8rGuMHWd3zPzuOfY4oODkawJAWMtfykM3KTf1kFgTNIpnKCzD9K8o78NgExx8lcZwWjVNg07tdA==
X-Gm-Message-State: AOJu0YxrdCNOPlMDx0rFRpUgoUr1BHViuMe/WeydHhS/YQUzpGkswdud
 j6jh0a8sijQKzizcS+9flVfnlwSs+Pq2ybzmxR+WBXh/DkWBZETLpibP+RvQaF6L5NHx+R/VK5e
 E
X-Google-Smtp-Source: AGHT+IEQHa2nEOArmjF2V5jkw11MmqVs6JvwGriQlyo6XLZ9EmRTdEjM4WpaiMUOJknAXrzoSmr3mw==
X-Received: by 2002:a17:906:234c:b0:a52:401c:472b with SMTP id
 m12-20020a170906234c00b00a52401c472bmr1824242eja.73.1713431679297; 
 Thu, 18 Apr 2024 02:14:39 -0700 (PDT)
Received: from fedora.. (cpe-188-129-45-161.dynamic.amis.hr. [188.129.45.161])
 by smtp.googlemail.com with ESMTPSA id
 c19-20020a170906155300b00a526a99ccecsm624322ejd.42.2024.04.18.02.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 02:14:38 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/3] pinctrl: qcom: allow selecting with ARCH_IPQ40XX
Date: Thu, 18 Apr 2024 11:14:02 +0200
Message-ID: <20240418091435.18232-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

IPQ4019 pinctrl driver was moved to the dedicated Qualcomm pinctrl
directory, but the KConfig depends on ARCH_SNAPDRAGON only and thus
PINCTRL_QCOM_IPQ4019 cannot be selected when ARCH_IPQ40XX is used.

Fixes: 24d2908e987a ("pinctrl: qcom: move ipq4019 driver from mach-ipq40xx")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/pinctrl/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 2fe6398147..bd2019c866 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -1,4 +1,4 @@
-if ARCH_SNAPDRAGON
+if ARCH_SNAPDRAGON || ARCH_IPQ40XX
 
 config PINCTRL_QCOM
 	depends on PINCTRL_GENERIC
-- 
2.44.0

