Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A153AC44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 01:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A958384D1B;
	Thu, 16 Jul 2026 03:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="l24Y58oe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E93B84BB3; Wed, 15 Jul 2026 17:17:54 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F16F84BD8
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 17:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c15f360851aso335968166b.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784128671; x=1784733471; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lZtzzq3q0Aa5ebSTtiUntAPRJKx0Ks65oX6M46mc/VE=;
 b=l24Y58oe7slOwsP874rXD4hc2EN9Xbo70i+bApsgmDw7aBgDK3PHTeWNfYswch9osW
 OdBaJl7R17YCNIikK67V118zpjlLw6wuZqjzNI7vbBxdDSWaIwMV7PBCSFsI39nCgEpZ
 DOFm5bl+FFcngxuh1cxzrPzAtW1Uhml8Mmlx9M2285nHuEO0MkgKpr2pP/4oj7FMo/9O
 AN2R08mMcN/tPqBy5iULVthMbv37YNitafJu/nADwSGbAGpaanjSr6ZVAyhcZFT0E0q9
 xKk721UYytKiAZXK+67QyV8COvqoL8aWPNUXqz19Phs+Lm1w3IZhXSl+iRO7JfW6cCJE
 DT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784128671; x=1784733471;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lZtzzq3q0Aa5ebSTtiUntAPRJKx0Ks65oX6M46mc/VE=;
 b=qplO+ug5A3nPQPRhGU3FPF86q/JGykV4gWsIzuj7CHS/qzKoU2TKXNrYHEkBT4l15v
 dzd+y2PUfT8rfPRCbjPZAsMSMxK8PZ1J01mvyjX0vFPuT7V+va7982d/2vNlXAoOv9uN
 Yt1kIV8Zef3IlByCQ4aGAOJT0wF76Pni0YHLY/NE6cWYrL4+uDwCXTBUNQHn0OA7NKDg
 lZI3KnHooDhflluJYO8OPc4uS+z5t/EgtBOIVzp7/waURhFXqd706tvWl1bibK1Ix+cG
 S/xTH8KIZOF0MUPcUZ/8AY6bHChP9dJbL5UDxSPnxUwVROLAbsK2ShOXfrCVRjS/n5y+
 5nzw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmA2hOOGqkl6CUwY4O8U17BKTe2BoK/glikrjOxLegPcelAvd/2sukuF82U40yenv28I6dGz4=@lists.denx.de
X-Gm-Message-State: AOJu0YzE866Fvsm1Q8mj+gXLHbiXbI5A5b7zLMqsRlYvHl1a+FYduYpn
 3yWkhIxjuOlm2FVdtNuUp/YXfHkXATACXBfBXR/uiTAVIvZgBGcVSgiOuqGV3S3R18s=
X-Gm-Gg: AfdE7cm7lhpHuuz9rAjkEmjDBwq1dvSJgcBWxRPqidfomLYwQcvk8qRpBCS1j6RDQ5T
 iqD7U8SqO9zJPA2TqSCpbA+hNiqI0DC+byWVsvsrfToTULGNycwKhCSGkjxyVjb36FO7YIziaNc
 CWzVR4QEIfJ2kYwrP7U6HG6CWAp1xMI/2UjXsNMTq+rswRCarMxz+Vd4kSABRVw+m8EkaA1lI8A
 ZLM3Pk2P2alRDwM9CHyVoiXxAhieSzEk0WSlaDGyWFxtxW1kDBCICwMWCWJRwFDlLhLaQUVDzYE
 pBKKqhMY+gQwktxr5hnONIRuXAQflFh6o+9ybULlKDyge6Hlsr9G/5ZJkhEtjY9168E3zfPWP+o
 zIKHhiTv+g+MY/Acp/fneou+FxDV8G0lsOuqV1HS65myzq7J+Caq5dnjInoNbilbTVP1DITSmQ/
 vNUIcoV+bQxd6ePoEB4owduzGdMO9UZ8kXvyoHbXLBabY9nL9xbGD9UV0C5Ly9PSjKTTg=
X-Received: by 2002:a17:907:7b9d:b0:c16:61d9:1679 with SMTP id
 a640c23a62f3a-c1661d93e6fmr511510366b.52.1784128670747; 
 Wed, 15 Jul 2026 08:17:50 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168716f6dbsm59145766b.15.2026.07.15.08.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:17:50 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 15 Jul 2026 17:17:41 +0200
Subject: [PATCH 2/4] qcom_defconfig: Enable MSM8953 clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-msm8953-basic-v1-2-bc4cb5099d8e@fairphone.com>
References: <20260715-msm8953-basic-v1-0-bc4cb5099d8e@fairphone.com>
In-Reply-To: <20260715-msm8953-basic-v1-0-bc4cb5099d8e@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784128669; l=605;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=H/1QsAAReVZ92Meq1wd8wnwFQkX9WA53NChezWzYeMU=;
 b=9l6o3uzPIOw2NjwekdHdMpgLOqod5QzNKETBwXgl+ZvTaRoULtfyHOuQwRjCD+xThRPtIiBp9
 To1AvXugmYEA7tthGHddJaucuehBcRdP317LBpixDxZYNSLMldNTvh/
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Thu, 16 Jul 2026 03:03:52 +0200
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

Enable the driver so that MSM8953 devices can boot with qcom_defconfig.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index c52f619850d..9b54903869e 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -59,6 +59,7 @@ CONFIG_CLK_STUB=y
 CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_CLK_QCOM_MILOS=y
+CONFIG_CLK_QCOM_MSM8953=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_QCS615=y

-- 
2.55.0

