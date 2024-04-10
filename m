Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36745CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 16:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DFC1881CD;
	Wed, 10 Apr 2024 18:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yKvVAv4u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02F1D881C2; Wed, 10 Apr 2024 18:01:21 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21AB7881B8
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 18:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41551639550so47737455e9.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 09:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712764877; x=1713369677; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U397QMxjRPtL4eZUzJ/Kl79N5zgnre2QvU7AvDmK8pI=;
 b=yKvVAv4u0z0o4kolkous+Dq63r2qxvtvySb5GEEcayVtkKJgcvBJpXJMPsQsbXEN5/
 dkJwEFW4ZdVfYsVmpmA8VkBQwE/pLvUwGGoAL/Pf6LhNijbxsQf3zrjgGAqzEa86If3j
 vCf+mKpP3HM5QbuIQiZBdzHbJUFPNGlFvQWWf4wCgErPxoVTpizfnZx2ObsXps1TsDLv
 L3iGv2xMQp94XGl/DEHFi/i+NlZzZ96vhTe4UwKaZocNi5nkVfNLP3KIPopCLYNQR6zu
 4RZZOZKZJX4uFRAQFY5l2jazgdM9BB2b/rN93rCL4HrWnkIXvfBwFrDsUN31wrkYFFKb
 SVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712764877; x=1713369677;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U397QMxjRPtL4eZUzJ/Kl79N5zgnre2QvU7AvDmK8pI=;
 b=TJ5tX9XiJa6EUM8P6XcXLVVIwr3D1bO9xNmfGrOTxxhQCybPhW81qU8TaBq1ENx19W
 S6GsLyMPl04uv7ipPsfSjvfgUeU9w+br19iIm+zA1avDU6GkAxUT04siNDMs/FHwvyur
 XG6du5viJZ5KBztKCQ39CrZOrMDXngwfKTqkdlVNc55+PP/RzwUNU4rWys2qsMm/tqLl
 q/U+N46SpZWx2DaqVdbbx2CMuZqWZ8jiziN5g+ujmRSD0y1xhGScXRg3zGfQFxOSPwWD
 j7RSEmw8yj9R1Rh4RbMOL9NZVlbm4NDjI7aKNR67gIFOX6epXftsV7dlxhjD3r2UAJmP
 j2Eg==
X-Gm-Message-State: AOJu0YyDKfDY2qgO10hg+cvUNhznPA4L5S3w2+Rr9R4/8k5D5IZoAIaJ
 EEQGdMODFJsnrrJWaXbjLhxvwwQBNX7ws64BJygNHAAp4OH4bclY63up8FySc/vnmJCw7ZWE4HU
 6z9o=
X-Google-Smtp-Source: AGHT+IElH2eiS8gsZRIJzc+YdYDtDVl+/IQM2dpZbY7lSXE/UnIlu/mHy8lNkIpld2xXK9qqIso7FA==
X-Received: by 2002:a5d:420f:0:b0:343:ae9a:b8c0 with SMTP id
 n15-20020a5d420f000000b00343ae9ab8c0mr1923280wrq.65.1712764877326; 
 Wed, 10 Apr 2024 09:01:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 l10-20020adfe58a000000b003434f526cb5sm13872624wrm.95.2024.04.10.09.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 09:01:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 10 Apr 2024 18:01:13 +0200
Subject: [PATCH v2 2/2] qcom_defconfig: enable the Qualcomm Synopsys eUSB2
 PHY driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-topic-sm8x50-usb-phy-v2-2-9d2d90bd04da@linaro.org>
References: <20240410-topic-sm8x50-usb-phy-v2-0-9d2d90bd04da@linaro.org>
In-Reply-To: <20240410-topic-sm8x50-usb-phy-v2-0-9d2d90bd04da@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=603;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=boXUB3s3CNQ8QkpPwrcBtwUbJTpUbLx5DIWT8T92m44=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmFrfKClfocR6hTVDizYyT063ftUP7PC08FsjyJQZl
 ftLURAeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZha3ygAKCRB33NvayMhJ0azzD/
 4nhFR8zskr36If+HjDpWDqC3mvCAPrmamV0P/tP9xwll6jrkiy2S6KtY0s5VClNVqMHHDU+JnkNMbK
 T8XBft+IhRDZsWkQeHw2l7NO09n89L/YnM65gMskA1QF/k8NhITIALpDzp+qHv+9LCV1oacq8wwnjP
 sBexjhNpgMZJWRj3syvUMy+5mCTW10gfhayKZZSoGrd3zqqGYDz6l7mJQ8CbJcldZMqP5BL+/2uU6E
 TA2r4UpXjqGmm9H1q3KBFvB2eElDJollH1ZJ+AUsGWLGnCjoDs4xrPgP1cUGwrKBgy9bjyVdsxEMH5
 EjIz1nQqjUX9n68XFFuq/h4FXjlr40IvYz+5VEGJMRU3N51FCtVLv0Q+rzrRmCP5adD7F0kdIyR94c
 HhGB3NoQNrc5VdxvJND+9pQzBi618aUg/XEv3bgxasstFvE4kA+2PLFL2dA6Mn21Ar/9QpUipzx74H
 GTae5Ynhpnr+fj7svNBC5CIN1AuFRj7XWiiZGVWEgV2uNpe4Ywbcv3YdaoG5oDX4pYI03XhUS/9fTe
 pXm1nVkEa14jPuhjsBbDINXqQ05z8fArASz9BG59oPZLKdfZyhxv5VXkdQemUUl1N7jRZrGFIY1OHl
 /Q/TnLnhTUb6uy5iN7t6AVxzGi0zYsenCCf0q4l0ROT/8/bMCefhOxjaHnYQ==
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

