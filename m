Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D65DC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 18:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7FF181DCA;
	Mon, 24 Mar 2025 19:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GtpV4hrA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3082A801CF; Mon, 24 Mar 2025 19:17:56 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F86B819B1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso31721415e9.0
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742840273; x=1743445073; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6kfPNCoFRoQKKZz0EtecB89NxlD6vAPz7YE5Pf84+nA=;
 b=GtpV4hrA/MTPvjq+oTT+vCeuI3faUAilDsB5g9LR2qU9dIh0zSAc0rpD3WKh7UbhsT
 sf7oPbLLhGiyZSYUEBpwuGBO/nO8UpgKu6dJkuzYU23hnoZhnOgZjOMEzFMe5zf6CkB4
 sD/8v0LVcHc2Rri73U4X4MB/iHFwWaDKNyV/wO9lLL/wTw4htaIc3O2CjHO2sfGuLVPM
 v2B4I3vzBPhPj1lCpv9cdLzDeGl4xGHvdsiNXyli9LFuAfggBVmFB54cQnqhh/fJ3y4A
 Fj4G3vMJhBmNvz7+jTrpyhHlK0Wtn68exTPAcWltIKfZ07QeGKsR1sw2cJ2eooSmtUqj
 Tg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742840273; x=1743445073;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6kfPNCoFRoQKKZz0EtecB89NxlD6vAPz7YE5Pf84+nA=;
 b=q8F+njWHePEyJ1hCHy7mh1h1ekSLLdpdU64bkX6T0b0ZGc9SqU0BR/o/VC4okvFXO3
 G5eTlaRf+2tEahF67PcjuHwGRgg/AoNIj0t+2+xKN0uzRXwqroePXKe/IiadMszDgONM
 iFAsi79rXx0/uzQK5K/OXDjLCu8eRXhuT0xAUwt5m6psxFXC7ucmi+/FkEvFEvcNN9Oh
 EmeFGvrQe4qdWHt/HJikTQHNhJWeWUTY2NEydEhRxhuS//rEnr3BUEgyVRX59qyU7Vj2
 KWhXc/OG3mpR6MmMS0cIhota2KClvXk5d3pNjo5zTz51BE28jXMXXqriHQzoJdn+U/VN
 GKWQ==
X-Gm-Message-State: AOJu0Yw+BKdLCQ+LgNqfr6lFHP3Evgda411zx4cQmyTXk1BKJu/n+9vQ
 VLagw4tmb1C5yJ1fvBFB+sxxbakv3oLg0YMl2O0cdRdJX4jIxanIBbOZRiuyTfk=
X-Gm-Gg: ASbGncuzX9n6qGWhTyh/xYnvA+TgOKDNsJ/mJVhpTaH4Hb/sLjUReUanjRyK/fii4OC
 JbqbsXX0jcqYcK1hBxntM9HKgDMWLc+DiVEDKEz3DAZoANEddGaKSz5sTHKzqa8UZO+QcgcsKXg
 urRFOQleHN+rLW3+a3zl1NKXSyH/WSKLYIHWNyQoM7O6X/XmlYaFx8nHwIW1xBGtPDUpm334iPU
 fRqYqbOSa6HC82KDCpeRBZLbS3jbkz7v4GBZs8N+yB3BN4TqQomD2+MbTLLiVrrrh8TTpDLlfzX
 HZN+6Hong9mJsX4J34ZqXI4ZEgM+MsCff89loWkTF6iIM4phW1ZAXUMHZ9Vp/nsfZ0hgzAQLbw9
 +Du/hzeiseErwgRcgMJm7eHg=
X-Google-Smtp-Source: AGHT+IFfTeopybJKDKCkLvVQtl3r5fkpJ3LNDN5p12tJWnYnneEQRqefMyI3kQMT5LSwvEjWKiFOww==
X-Received: by 2002:a05:600c:3109:b0:43b:cf12:2ca5 with SMTP id
 5b1f17b1804b1-43d509efa3bmr122626395e9.8.1742840273465; 
 Mon, 24 Mar 2025 11:17:53 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6450sm11690651f8f.70.2025.03.24.11.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 11:17:52 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 24 Mar 2025 19:17:40 +0100
Subject: [PATCH 4/4] qcom_defconfig: enable fastboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-sdm845-fixes-fastboot-v1-4-d177a10f336d@linaro.org>
References: <20250324-sdm845-fixes-fastboot-v1-0-d177a10f336d@linaro.org>
In-Reply-To: <20250324-sdm845-fixes-fastboot-v1-0-d177a10f336d@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=kw8/EtqNuL9E7nUCG1FuZQogVqqtBqs4+sEez5Iw2M4=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn4aHIOwVVmKH5fgEmaqMg2soIUA6qnx+Y5e5wZ
 ynUWoH0+DGJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+GhyAAKCRAFgzErGV9k
 tpoUD/99rE80QT/XMfHXovHgsUvsslAfDzN+7ggV1RW0cGTgpvoN00gA7vI/060zkOpXlfnzRuM
 IjCAXFJrGgWIJ8x8T0nXzphfijztwa8YfFXgAqr6ElLZLy1IYa+Y+bZnSVoMYa/Po81URTYVgx8
 x4TlaNJaUFs+qG9od0Vk9KyXK4uP2udFp/YJfN0MaV6M23A6Jq1WUZVUO2ByBLmwF+6dGYh9sR3
 KlXP2LgHqkCAfF9hBH68olYgGrd20n+xZ1PROCRS2Td/qkt3Z9CQTdqjX18mhtfHZgvAbYjCRc1
 2qQC7JL6RxPVvA0jYbKFWJjhc/azogkthVP8Jhss02etZwkjHdYLDTektYr25nKztV9myiQUbvO
 Y2IMA48lJaWRA/Ut96pzEKQrNYRcRZJ0Q1zLerB3Xqtz9ZARVJeE3CpyPSsBaMEdM1yHF6Yyk0y
 MMhbaoykRGpDCTk1Mq9P02zcq7SHRfUVuqpZYfu2sBwSmR786dNrEtHJsmmb3yhdeu5nAqWweQh
 6LV51NbazUgVUG84KQirGPzfVAvAEFZpxgeQYXyB0X1nMODRAk8LjTudJkQgHxbb1qPLSojklX/
 PeBP6FIUVDhx3SomwTAfnq7SqpsuemoM4r2pkHjC1J04jjVVGg6jIs2Qf5zqfYNW1BheH9l4yES
 avLejvsmGszORnQ==
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

Enable fastboot support over USB, using MMC as the backend. This will be
the internal eMMC on devices that have it, or the sdcard slot on devices
with UFS (if available).

We don't use a fixed address for the fastboot buffer because it's
allocated at runtime per-board. Entering fastboot mode should be done by
executing "run fastboot" or manually running:

fastboot -l $fastboot_addr_r usb 0

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index ba4d38d100e053e3708ee2623bf3530787b6b94f..f5c005d9c4093e4902b05213ab2f54c8ca70208a 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -61,8 +61,13 @@ CONFIG_CLK_QCOM_SC7280=y
 CONFIG_CLK_QCOM_X1E80100=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_SCSI=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x0
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_QUP=y

-- 
2.49.0

