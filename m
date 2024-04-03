Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E08CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35DAF88399;
	Wed,  3 Apr 2024 14:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i/hI2lk6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8C7883C5; Wed,  3 Apr 2024 14:08:07 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DD30883AC
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a517a492055so15230766b.1
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712146083; x=1712750883; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rT2hJHvXJ3OID9Ciyja3ANXjBepnBUwLb+A7aW2D5jw=;
 b=i/hI2lk6UnGXOP2YBdjKQ0da1wFGQ9XxqpZyqzwgvLShYTNdWS23TSbR/lhRy6SUmQ
 M44d3BcBaGpLr2MQy4HZ6DGL/VUk9acXMcTkQdIaqlaQ0LvQQgm2+ZuXZkr0fLAYGZQS
 zJBu+jA1HIZ3e5liIoTTXKLtYAnwBnMHdghCE5imE03GCbOZHH/1UQd4fOiU3QSXrDNq
 C92mUufd3m3ZVAWMb8ZLciunXPpWzhD9Uk3QVynnv0m+DoU7r440KHsRK9QQDWM/aIxA
 xLWe71697dhJX+/rJFkYIMRVBeHCr2TCqFXL7CXHDTrPCk94XksuqqwIrZSB6LM4k5uZ
 Gmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712146083; x=1712750883;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rT2hJHvXJ3OID9Ciyja3ANXjBepnBUwLb+A7aW2D5jw=;
 b=DsgcHe0GJZ7N8an+f58FyBCioXf8fDMyBDuvRBg8wkhfY1llrYvVYYEpyLVuvQTI1v
 IsOFOIQu95dCiFE5IMJqS66zvsInFf1yFg8PSpzzo3HL+MnW3MWzpEE3anBGEQgxxpwy
 d1/hccBj+j8r5nHkdQ+lhXcnvepYbqyLeACSq3Wg3gc6jQeIA9A0tlzuLL1lNNF4rplB
 hWuVpu5ABGU6ZiR/nULGcmoZ9M1Nfac5tyCcbYN6Idly2qAiuBAlQqK+1cwsgXwaergH
 01VEPr0O4+Nkp9Rvdl8QHdr80+nZBMkD3H0ViT/5PJkOqxHDgBDxA/R5quQ5BAAdR/4Y
 mFnQ==
X-Gm-Message-State: AOJu0YzY6Z94Svc/Idg/bNGr1GzY9QBJF/CXH1+gNjLCl6joZotlogs8
 lEWxH2q3M5/6mJlbEomzo/XtjHSOvoFRWc4FJr8uSQ8f92AE5ZXE85TxsW0zZo0=
X-Google-Smtp-Source: AGHT+IGbC7HTepLFKQ+OZQ9uLW4nEYtucnMnVP5QjE1lcTIh2ckFOwehkFemK1ad50p1WrlrPkFWIA==
X-Received: by 2002:a17:906:22ca:b0:a4e:a7a:84e0 with SMTP id
 q10-20020a17090622ca00b00a4e0a7a84e0mr1559586eja.34.1712146082954; 
 Wed, 03 Apr 2024 05:08:02 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 lr20-20020a170906fb9400b00a46a04d7dc4sm7654674ejb.61.2024.04.03.05.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:08:02 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 03 Apr 2024 14:07:48 +0200
Subject: [PATCH v6 13/16] dts: sdm845-db845c: add u-boot fixups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-b4-qcom-livetree-v6-13-130f8f50b538@linaro.org>
References: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
In-Reply-To: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=1IDFJJ2BawZVnf9CpUigdeE7f6YRQUBvg/1YpdTtwBY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmDUaRgBKiXoaLUJGiuJjkydjXsh9X5t5TpTITi
 0a/FryVOoGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZg1GkQAKCRAFgzErGV9k
 tnumD/9DXm++u+nC9Np19NklsZE63Uqlepa02+VfYA96QNC3DizJxmyWR+1iubtPqLdvFWJKFtZ
 mP1g59LCMG8p5pkFiUSecltdTgV7MJvB3yvq5EJAvGkBhw5bF6NLHFwD8jv3QXgWiKgqklrYBCX
 Mxsg8kfFNnJ9qeeen1lrC+3cPUoWCXo+EtTmivL993vXpLCImvVvxYV2tXf33+DqNWrKnf+8XVI
 NpriFkiXIxHNpbR4HiiZ5+XfHGIpBK9QgSFZ3Fp+ET28wA/6pWXcj1O7sfaswVeGMsgZVsXpTJL
 GBvtM9lJXY//PUT3wvQ1vzwLkEr/ER/Wt9CXknXjmAKZ93H7cAh9VfLlUOCgxUdBzcHtcSDw2FV
 6tF0uDj4KNZxGWqd/y7WbcQwFtL1/IFXTlHG/y+m/F6qfotZph9rWXEluWi/RdyftwXj1vAUurh
 psj6gjX/gQJvo5OJ5OUdjNQTVIARWcZCal6JVrgQ4rdiDiFUahR6zXuESGNTNv7zGx4Jy9X8DsU
 cV7/cOJgbck47b91y6OoweZ0s7UI1jUWvzQCNY1/nH1qcgY5GUVaVZudMUwqeBU6gTOlyWGPBG4
 RCGAiMpX8rpyX7MrWOdZ4AWgRNDM+dMPZCyWfgSFhVL73ecqxgVA9tmP7YMBihnBdrqiYtgf2pe
 xx3RJrGs1CtBKBg==
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
expressed. The correct way to handle this will be through a
usb-connector node, but for now we'll just mark the regulator as
always-on so that it will be enabled automatically during boot.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/sdm845-db845c-u-boot.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/sdm845-db845c-u-boot.dtsi b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
new file mode 100644
index 000000000000..906f9faa5451
--- /dev/null
+++ b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Needed for Linux to boot from USB, otherwise if PCIe driver is not in initramfs
+ * the VBUS supply will never get turned on.
+ * https://lore.kernel.org/linux-arm-msm/20240320122515.3243711-1-caleb.connolly@linaro.org/
+ */
+&pcie0_3p3v_dual {
+	regulator-always-on;
+};

-- 
2.44.0

