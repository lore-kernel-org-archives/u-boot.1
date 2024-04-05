Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7D3CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 099F1884D2;
	Fri,  5 Apr 2024 10:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kj9nki1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 277CC884D2; Fri,  5 Apr 2024 10:36:08 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13957884D5
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e0ae065d24so16141605ad.1
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712306164; x=1712910964; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U397QMxjRPtL4eZUzJ/Kl79N5zgnre2QvU7AvDmK8pI=;
 b=Kj9nki1NoIQM7/YEG24Gd3ol6D3hPpiKJK1KbAp2Ao/oBtWo455tUHUxUWtOSbgLwP
 mNxVm3RQmzxJy9KR175TYsKTf1N3mgfazoZ4DQrOv5NkDCbBopFRQKJKfHKs3JrLr7s2
 9Ov2VpVVT4KDnL3cTqOpsrE2RNb9hPegI4IdC0FR14maxF6b10yHXzep/H+smKcp5qmi
 lgWVAuWoRrQFWpvdBT/ZfvWrg/71bpSuy1/Xq2liHnDwlEdp8U2HAy0rDU8EKrZX1FL7
 Q1Kk2CFibDLhoJ5PSxAq+qYGPZw5y3D9remImCnowXBJc5l6Itqr5NgBv2wYJIm5z9gC
 hBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712306164; x=1712910964;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U397QMxjRPtL4eZUzJ/Kl79N5zgnre2QvU7AvDmK8pI=;
 b=skgkBcZD5Z9bSZXMXFgWdMlSXU3DC0EtEDzMLLviA24l9l2wAAPsjGXjnhGvQyU3kJ
 n1pRYnZ6/Q1XtHAhMeZ8V4W7kMMOD/NQfRF1Arwrg+VeKzZMSKsWk+jWfG8kLBDYdpbx
 BQTcARGA1hVo4iMwL2fwDxNWdfZbRJBRqIJEns+/p0gmMnAbh44opvf3OSQn1daqmSNM
 qz9GRwdlsjLAGvv2f9gI0OLKcW9PKWX7OKpVUgMGTYSP09znGq1+CPIymJ618nkb+yof
 sOZ+Abm9bQ/fSQ9ehXQ1uDHU4uOR9279GQyu0r0eQZYJO+FwrHYgNbRiUUHWa1KMh4XL
 0QNg==
X-Gm-Message-State: AOJu0Yz+cs2rY46Q4VOtXjoJFuVBgLOGeAGC2hVvmi/Z8MO0GadHoM94
 qogoI8D32UxeJC4HVEOXOZ/hYXPEmtbA3gsWbT6SH6rhPWtsTrjpBQtboHCb5i4=
X-Google-Smtp-Source: AGHT+IEI1XXvdlUX4dRuNXZb0KhI8KFxCI60xwfyT9/F+FsoeJwnO7/DKKF/Utu1b0Urdx/dTZFsWw==
X-Received: by 2002:a17:902:7484:b0:1e2:8eee:ca5a with SMTP id
 h4-20020a170902748400b001e28eeeca5amr672217pll.52.1712306164494; 
 Fri, 05 Apr 2024 01:36:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a170902650c00b001e27e52a7e4sm1006572plk.285.2024.04.05.01.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:36:04 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 05 Apr 2024 10:35:49 +0200
Subject: [PATCH 2/2] qcom_defconfig: enable the Qualcomm Synopsys eUSB2 PHY
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-topic-sm8x50-usb-phy-v1-2-8a8604bf818f@linaro.org>
References: <20240405-topic-sm8x50-usb-phy-v1-0-8a8604bf818f@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-usb-phy-v1-0-8a8604bf818f@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=603;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=boXUB3s3CNQ8QkpPwrcBtwUbJTpUbLx5DIWT8T92m44=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmD7fqV7GiGbRzaUVIb+jYf2WLjaM92haItM1kkFQP
 wVCVlaWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg+36gAKCRB33NvayMhJ0bIfD/
 4kwZgRARlM2fWNbZdltfzdaQKC+x65qSUHT8rRWPvCP5IMienJkmBF8Tv5z83hAR61fxRsf/Uj5UO9
 AvsHTjy2FZTiI362WHmqstUNbFgNmpAIIwJxiuE1Ps8hWYoNV6Nf+gjawjVN5hjnoY6AyKwN0NTfg5
 r9ewWCpeV0IpjmE1iDs95RHgX90/aABfJz4zSJw11yV3JTHjgGCgfKdF+Gaex6BiBK96cXYGM0Uvaj
 eBH4ZIabe/vVe4jHgjylIbaIar7m3hb3pC3e97sH5R2Lq/7qGJ+QblZEFSsMfgfXVzTCuO48fHhv5O
 XfGX45kQg3WzfGWhWFbngpoNi5J2IMSa/wXrYAQJiXbuxo5a0o8WM3eOKixYKs+HqlJvhBVTX2+U7e
 pl05roQldReor34TPP4dWF6g5Bgyb/M8XyK2AoWGe4uCYU4FNrgkvzmTS4yIG10pH//5Np8LLmYLIh
 hRlZHjq5MaGYiJhbe0+eoh3cxVYH/v8eIeEIGsVLgEutPUCCrEig49cRv1vJPYa3e139f0CBqEFZ4i
 avHXYSo6hbf1CDUCTcyRqgxLQ1w6ytYO4hDFaGc1rmaH1aaHzz07eNVCJdrI0jIyh2QfZeVZ+mzdVC
 QNtNeu4ROUaKy3d3dx6h3FYxztdYMMJ1Cn85bWhrjrCLtFiAQOt7c4z6sfMQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Enable the Qualcomm Synopsys eUSB2 PHY driver in Qualcomm defconfig.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 1abb57345ff..b0ae5eb4df3 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -63,6 +63,7 @@ CONFIG_RGMII=y
 CONFIG_PHY=y
 CONFIG_PHY_QCOM_QUSB2=y
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
+CONFIG_PHY_QCOM_SNPS_EUSB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_QCOM_QCS404=y
 CONFIG_PINCTRL_QCOM_SDM845=y

-- 
2.34.1

