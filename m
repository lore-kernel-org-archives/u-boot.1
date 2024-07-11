Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782CAC3DA45
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACA1C8880C;
	Thu, 11 Jul 2024 18:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zqR8NCR4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCFE688805; Thu, 11 Jul 2024 18:47:11 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D66A088791
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a77cbb5e987so146014566b.3
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716429; x=1721321229; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9fS17EJfpRajXdHZM+aigrI8s0lABvMSNi6Hs5iNv8s=;
 b=zqR8NCR4Te0OJ9wgQZk0aKjpXTosAWLRYUOxGCxnVBE1ZbQumfI34rMUj3Ug9WKE1A
 KaIoYwjtk+QPslB8SX1UaPZSPYTZtuftgRpyBYH80tN5L9sNbcPIWRvEEsM/ODAWVG68
 XXYE3QoZKmOZ8rRjAs8yix1DrAkmb5FPkktCbExIFhsb2+4D9YX+Nd2+tIiRTKb9txsR
 dmnsv7cXA1C2MRDF0yLM3xBFNfSDOg90k22dmt9Ij6fB80Fy2ncmYu6FV+F2PUSr4/Ji
 vA62hXHM74kHLDQffL8eXWJfhPKUF4fyaM6MtYr9UtrJGuKAz5isUJOsNnslXlkZeK9d
 6b9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716429; x=1721321229;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fS17EJfpRajXdHZM+aigrI8s0lABvMSNi6Hs5iNv8s=;
 b=EI9s7tdJWMCVonA+sdbjqEK2ip3ybMcTHi+sk4mXuvFTJxjmlQv0rkvDZfeuXH8bTt
 II/iUBKNDX7noWZmSdJYTI0fgPm8mEixKpXhWBKduqsubrZ3ws+RLo9byIWu0XCq7D8T
 4ViSjv27BQsv4jUIApGC1GrjhmHWLmeh/+tBEgurU3K/XeAQOXFPm8S9wfEJNQrLs4At
 l/YJqnVVoEJMDL4LikFYA++WnxNsV6UdnifVnQYNHuqSz5T+b5EfkzhP3fzbZqJU82vK
 woeblq6j4hCoYIvB0g+UInNAIQ8hZLhKjDBWJmrm7Btfz3sHT9IF3lSwSMlQmVsl6+eb
 IR2Q==
X-Gm-Message-State: AOJu0Yx212W+Uv4hFptUW8rL9gQKDB/IFGJxJy9IfZSmSFWeh574vqb2
 YyeqUOpAzxMLz1nwMVjWr1qae+UagwwyA9CcYsNByQMB0p8MN+CRf4/t+1FN0BQ=
X-Google-Smtp-Source: AGHT+IHwariRbvYkR7+euNNNELwYoKSbvU6ejWle3OU9EIflke4Y2T1/tBKfzXBDTOeKMVNd9ZLe9w==
X-Received: by 2002:a17:907:7e82:b0:a77:cd51:3b32 with SMTP id
 a640c23a62f3a-a780b8854e1mr658945066b.62.1720716429452; 
 Thu, 11 Jul 2024 09:47:09 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:47:08 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 11 Jul 2024 18:46:55 +0200
Subject: [PATCH v5 23/23] qcom_defconfig: enable rpmh regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-qcom-rpmh-v5-23-fbf04ce6a7e8@linaro.org>
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=L0Z3UjALgAoIr8Xjx+Xnl++TWCG7gLgrnDFM/1FfGKY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxwJ+x8c+sMuZcbem27IN1sJlY3adSt/fKd3
 kMV2zkTImyJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMcAAKCRAFgzErGV9k
 tlyoD/9/WQw9TeoaYIY/DPG+Gf30X3RA27KfwTGxxSe3Zthi7p2MAWWA3ZmW5QNKKvfG3mNBbaY
 ZQ7Gxna731JdQHODPgAcbCu6MUTNUzUBqREpkPfr8MkTawH854yAxK8Z7/mkX08GoXSLGZx1OFJ
 6n44R7/HBPqEezOg2PkTPqO8FJ4Kc/lqaCKW8VS1+HYnoKKLaRSHPFsDI+7cif/Z6bciY8cAzoK
 MKMA0SHkiaoDCyFyawk3baCH4N9FFvhHBgFyx+wCwhix+nSpYMyPMPjfYEJhKkrxd9yR5jJ3qPp
 IG0+aBPFbnUYbMIgZ4heC2YoStOuEIZitZ/mB5KGNuFA5Z+AeLGFQSJWysItaZsb56UPnWa1fPG
 KV474Qnv67MnJdHEpJ4bbiUhln5AJs6QImZCj3OGqmkV99l2BWN73wKDep0e0D3Ix7Fw5xIGFlK
 D/v+blovV+83HpEADF6MV7gEXDvb70cU2hTYyPIcWEh4nq1hl+Yow/sUSmAP6OqYFH4lCWGW5Pb
 VgBLE0WFDtGax1VsJbjNQzyA5Wu67OuttsAbaaiyAlSA1Id4MhzFYOSWIU9kxa28BVNYWxm7a1Y
 ztX++k7UOYpJcUAkmAGyPyfHmogN7liQPUnuk3H7p+N4W4a52IwyYIoQNXhll5vRnQxGZH0Xw6j
 UJ/loAvcixQ22Rw==
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

Enable RPMh, cmd-db, and RPMh regulators. Additionally enable
CMD_REGULATOR for debugging.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index ac5ffe772ade..1cbad9db72eb 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -35,8 +35,9 @@ CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
@@ -90,11 +91,15 @@ CONFIG_PINCTRL_QCOM_SM8650=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_QCOM_RPMH=y
 CONFIG_SCSI=y
 CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_RPMH=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y

-- 
2.45.2

