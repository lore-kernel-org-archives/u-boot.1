Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2CBCF259D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 07:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7DD388E3C;
	Mon, 14 Oct 2024 09:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ABNxryB+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D39988EF7; Mon, 14 Oct 2024 09:00:33 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54D5087F7D
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 09:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43124843b04so16916945e9.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 00:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728889231; x=1729494031; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZxSHMTDDGpjc9iqbCSzfy8IvVbCcEOA3UUkaVHQfFMo=;
 b=ABNxryB+qby6xO82tfdWFAp1ASDh2EPoeSPVB4eUPM8bKunT3mmptSHDZ4o2t6n44/
 eKQQGFzpe7yXBHVd4fMsV/lXBdHIYFmYjZ2zBuERm4HHZ9lHR/m8rnQJB44PyabPIBZZ
 He440L63It71plvH42E0yMcvVgsWB8mc/N8LhbUAzI4y6OWPpjlUKnvtr0uQIO5QpAxr
 DC0ONgqtxatx4fUD6s+h82ed1RZ/YPdnqtJ16YDOr64IB2pc9Vzs93FMvkTBRapHK3Ef
 2XobtN3353MREYY/rD16qGzNWYJGKfxcsnNMvxF3O5qwfWacMpa9sEIew7X48lX8ywT8
 VqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728889231; x=1729494031;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZxSHMTDDGpjc9iqbCSzfy8IvVbCcEOA3UUkaVHQfFMo=;
 b=LtH+jZYeeaSwH+QLkx/5EvrR1DSoDMBbQu7nrEJNKCufFSYkoEV0sNaGV9E/PsBxH1
 4fRBBiAXmHLAK/jtGPrUjuXQ2weFGDf9AI8BZduIHdC2XcHJu3UzCylZhgSdBTFxSdsK
 purNJOWyn+s4EEx7teQKYvi+0RiZqeWCRIjN8nHFJMhQnyMeE+JassINKJvfqFxhGczz
 2UN3h+RMtC9h9fkBCQBN4wUQ6NzKzX838FgnTvkOtcm3X+/tg1QM/PbhMqosUtQEFqTa
 hz9YVSWxSyIrIytXLWcy+bAQjltIeQOm3MCSHIs63R7gqczWhG9iRIRyWChzvKawwivo
 C05g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqWbC17F4Bh3oS2kRYwUqsXYMkbgGW4ULFN2NSkq98JyF+2bKCIdVA6EP/H3prUlgxfGH0yHc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzo/zU7xGRaxiistZoqKZlguetEyROkUWMV6FvPydbreb7qSMdA
 NdKsvwv10KU220CK1WOkDe6LuK3lwwJ4vr1ZT4jman8PmsEDkNd3xI8dGp0rcZ4=
X-Google-Smtp-Source: AGHT+IFMxbez5rBg3omEyKl3uzGiVe8ZME0hP6jHLO5OnH1DNGXXGYDo2LJWKDTw4AZPm5VmtvJipg==
X-Received: by 2002:a05:600c:c0d:b0:42c:b80e:5e50 with SMTP id
 5b1f17b1804b1-4311ddffb8dmr89357465e9.0.1728889230737; 
 Mon, 14 Oct 2024 00:00:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6bd382sm10554540f8f.43.2024.10.14.00.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 00:00:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 14 Oct 2024 09:00:26 +0200
Subject: [PATCH] qcom_defconfig: enable UFS Qualcomm controller and PHY drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-topic-ufs-qcom-config-v1-1-b33cf11b6adb@linaro.org>
X-B4-Tracking: v=1; b=H4sIAInBDGcC/x3MTQ5AMBBA4avIrE3Sip9wFbFgTGsWWlpEIu6us
 fwW7z0QOQhH6LIHAl8SxbsEnWdAy+gso8zJUKii1EqXePhNCE8TcSe/InlnxGKr64q54bmdCFK
 7BTZy/99+eN8PzSV14mcAAAA=
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=XmAU6GSv96qkEuqcvCjXUMzFBl07fM9n2bR0G3LnN8c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnDMGNDkVgFAJqFhR4dMB1ed7LhJf6ubIAnLvToHdh
 OzvrZ4qJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwzBjQAKCRB33NvayMhJ0UROD/
 9dZwR+c+xDJ4gpPr0fgqQEB+3lg1zrcQ99YSL5tJ+PSa/gjorZuNP6hqRB02aE4T2LGzMqSgsDF5ub
 odGLdrJEH0uLPRjGnm6ToOnnLMuZOyCMH3Vi9Te8jV4uTSkOaXd4RCZ/F7Q7bScV0O3RrgH0Xi1GtE
 Vsf6o4QjqmM29Vv/2bW8NrfTnOnc5f1AMqBf0q8u9kHdFbrXrv2JMDgcE3BD5TwAPPy6BMVmzcWPtm
 WBz0WNL1fNxrjknrUiQCfv7Kbzj+Qk0eBVjr+Bst1D7BXulElxlSFL2duiuB8sjAWxbAa0r3is0Dpv
 jZykYI2LifkKkz8ZG2dXkOHocFJ2H4SFFVkIYSWrT8dXrCrHjaBPL/7Ff7X+71VhVn50yYK9ChbBvH
 wOEG0NmGVDZ+Pz94uibnI7KDg364Ht0zIDMfXEM75TO+V6hDp4HoA//owwdVObC1akUkn6lJfB3NYg
 fZM0aU9s3iuZXywYgm9cvQTet2PGqSjtJ+B7kXGQwzk6m7TPUx4HK+jOBeAcwIn0obURR2kJ1VM5Gv
 pjhl/zu+wPFX03l7jxlWqRLntpQopOKoRKZeL9Y7NA4A7uEN0e5c8IlzDcH90UVPnAW9noAtdF24KS
 BlKMRCmPrrG/oFXjBDSMdJJyWbmO8/h3akbRDo4DR8qYCz0jxxidqZftFKxg==
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

Now the Qualcomm controller and PHY drivers were accepted,
enable then in the qcom_defconfig file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index ea0dd3e5801..def171150b1 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -77,6 +77,7 @@ CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_QCOM=y
 CONFIG_RGMII=y
 CONFIG_PHY=y
+CONFIG_PHY_QCOM_QMP_UFS=y
 CONFIG_PHY_QCOM_QUSB2=y
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
 CONFIG_PHY_QCOM_SNPS_EUSB2=y
@@ -114,6 +115,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_MASS_STORAGE=y
 CONFIG_UFS=y
+CONFIG_QCOM_UFS=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_FONT_8X16 is not set
 CONFIG_VIDEO_FONT_16X32=y

---
base-commit: 580fb5773634c4a01f907a164b2a05961840b4c0
change-id: 20241014-topic-ufs-qcom-config-9165ee7ed9bc

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

