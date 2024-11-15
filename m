Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1727FD68BC6
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 15:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28F4E89650;
	Fri, 15 Nov 2024 16:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eyqKbR8/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8291E89473; Fri, 15 Nov 2024 16:44:23 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB8168933F
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 16:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-432d9bb168cso12245345e9.1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 07:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731685460; x=1732290260; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rrvJRiV3dcn6pHpmLcnFwuBGtehzce3TKQ1cUNVV4Z8=;
 b=eyqKbR8/u6kwCg9hwlQ34VThWEk1/GMFk3sWMtDRreeK3OYXY+oK6eyU/ph7YZS2XH
 AbVVn6MC5WNX+VKB7giIaX8x6aM7e3QHdWalRD/pXn0nFiwYc9WnE9GmYL/6WrWEkCnS
 ri3WMOJLaT1rKt8vzRhaGmtkjcgPquQ6/zr5JYtZZyobN2tVjv0xRzeinUYwAevqBjaZ
 wb5mhpMril19rwJPjXqmDtriOfbN7r3t1LcH2qndWtz3k+DCiACLzXpQf8EQ/5mZJ5FK
 hUuP1keLw3nA3ey1qfl1uXiucJlCbCnTb4InASOOj49FfQ+kM2JpqvnETlq7F6Wcab6h
 rnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731685460; x=1732290260;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rrvJRiV3dcn6pHpmLcnFwuBGtehzce3TKQ1cUNVV4Z8=;
 b=OKjQ+VWqZEqR27QI/jPbU8UnKYvkhkAJeU5oYmnRLFLHEmQk2M1xhyk/RYUHXbSsmc
 9i2dViirkWI2dY6mb8Yv6/x17EZWxyXRf8ha6j5a0SaHY5uRFFBUTgbo0eHTsoh3iaYv
 6kh1+lJOVrG7Rxhnc7z3o+xtVk1zveTk7OgVLXtqFLTYRKVXnfckHt4/aP3SbSOb+WPQ
 i9yJOipR7FJotD3JPMG7NbKdZ9xz+JXK9iQyYuTxIcturPuYRr2YhdL+sp15Smgf2bXG
 JgJow1ZkO9s36srsWNKMNlpegux2eUzhd1GI0dla31H6nYJafDtTyKugOqcH8ZkxeSxC
 mzvQ==
X-Gm-Message-State: AOJu0YxkoVHmUfaRh5wbRukuIiuu86Q2MdcPiVQbvFJvtJOpUVV3Eiwa
 XWjIdq8Eg0cRg8Acl27GaLbdV8j9RQ7EKW1HwwlrFdA0pipOjLKoVCzet48uuuM=
X-Google-Smtp-Source: AGHT+IGg8pD3ePlbM34PEDnLAWOWsFgaLzqcMFeKXAkf+xYs25oJj2A8ZpULinbtUF33mHLbhyzd3Q==
X-Received: by 2002:a05:600c:3c8f:b0:431:15f1:421d with SMTP id
 5b1f17b1804b1-432d976c221mr75847355e9.16.1731685460137; 
 Fri, 15 Nov 2024 07:44:20 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ada3fc9sm4637773f8f.20.2024.11.15.07.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 07:44:19 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 15 Nov 2024 16:44:16 +0100
Subject: [PATCH 2/2] qcom_defconfig: enable X1E80100 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-topic-x1e80100-pinctrl-v1-2-35f984226e47@linaro.org>
References: <20241115-topic-x1e80100-pinctrl-v1-0-35f984226e47@linaro.org>
In-Reply-To: <20241115-topic-x1e80100-pinctrl-v1-0-35f984226e47@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=667;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jrxg3E1Ktm7qMTsO7msEH1Cuk9ciU0/GrfGse9Qs9SE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnN2xRSlCPpl6gI6FWuoZBBeI+PLTPgnFLYurU32np
 XkCgPu6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZzdsUQAKCRB33NvayMhJ0SsyD/
 432fVfhKckUbo1gDHYg4AGeQBCvkFeqzUO/jsddiIpiDMmAiUVF/Bl61oKpukqO0+GfQCEERhcgfLo
 5egdQjQyx97djCaeN4P31fh2ZmKQ6IDGaVw0o5/1uwX0RR24cj1phebqJQWmDvs4cbcemRf9aWkPcS
 vwfzaqG/E6HXF1HaNnCJWwXnxspayo30pz8JuiNNXrb4dH1CU7MlAkmBx0dfYl2vvC0e5S9qNMgRJM
 c1LJ3s2AWKjNCJ8UQPeUsQtZwAajXBlMFyLUr5/Mk9kAOUvr2Qi1S/FwCjUhs1cApU2OxYfMutJqNb
 NvJKljlNCj9B7XNdXubDpPI3Idap2UCiNuaa2wdLJXo8rTcZDVDFHkEIcM1gHWRgtU4QLq3YjtEl2L
 u2HsmW1O6355tdd+KuKfYeKgWDN3f7YRXwACD/BxW4GGkjTbphGlpW2xTdBGEnLe0Ei8uUBzJWhU3m
 +ur0KxeFBgk0OKYHGIVaQTtR2R5BG1eC6k/+l3us9xnPnvdkDcUHQAVx6YG9sWHcv84HF+q+huNaEk
 Oc2fJgjY6ECJQos8X12LIwRDJJJSTW1T9sSN/SZH42TEv94fznFxpkTQ/koMjLAS6kfHrYFflyt9FL
 IRjBfDnkvfOOZjjro7QW8dOSF/mqi9ovMaLWlPgzLAY656Mo9vToNApqiVJg==
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

Enable the X1E80100 pinctrl driver in the Qualcomm defconfig.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index ea0dd3e58018c8bf08e4a455a47e29cf1bbd3c60..7e87cbc4dac57c55fa9093b4642e4fa93fb671e8 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -91,6 +91,7 @@ CONFIG_PINCTRL_QCOM_SM8150=y
 CONFIG_PINCTRL_QCOM_SM8250=y
 CONFIG_PINCTRL_QCOM_SM8550=y
 CONFIG_PINCTRL_QCOM_SM8650=y
+CONFIG_PINCTRL_QCOM_X1E80100=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y

-- 
2.34.1

