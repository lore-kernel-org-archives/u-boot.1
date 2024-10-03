Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5001CF34B6
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E6A888FA9;
	Thu,  3 Oct 2024 17:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vb04DEY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65AC88C0F; Thu,  3 Oct 2024 17:48:09 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48CB988FAF
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so14724825e9.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970485; x=1728575285; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7RhZvZ3tdk5Mh8Ow/UvFZRPsh9uBCSvtkeaZiSHafRM=;
 b=Vb04DEY+lAMClF5WZ0m5eMYGqWKvFstN1D2/n1sOaNIQjgtRaf51Oq+3+D8KDhQyO+
 +UIGcUEmtUF1fkt3DCdfD5OSk79ix2unUXy7Duhdai47m219rIBjxgAl2Ig90G2HXq37
 mnWYJGDQvnFJ9Tt8MThva1SPisUemIY2hSTFjxzdUtHiPJpb+eRw12J0+PDurHGLQj9M
 6Fxgprv9YQR7Jfhs8lEPft5Vfa05K85jtgWw4G9ZyGLE2AjuJsSDBZQz9Tu6bexdesB3
 y4RkVBsJlc6N1x5YeoIM9fzkoaWz0amcEBcXHjgl2mCC7/6aSYW/F8gzV4H2Gj4dGimO
 SIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970485; x=1728575285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7RhZvZ3tdk5Mh8Ow/UvFZRPsh9uBCSvtkeaZiSHafRM=;
 b=MvxUSiu5rG1RcIKZkBhAs79zrpmKezGw7jqCZYAeDieCwYrNxHawrxvEN/bCaVfzQZ
 jNugo7eBnYnqrucV+Gicj8I78jW0hqGupaS9PMRVuGbmgTKv4gmX1Xt5v2+Cwt4WSvpS
 qW3qGeOtp2adsuAzKA6k24SSyhqkOeEYy7EQRh5okqUqUigBmrDXKVy9R1M4+3/l9J2/
 pF+Oa4iqBfOKW1GMDoJqhQf8pdCdPwKPPPoLKiXzKnpC/rsaTRUlLYEh9i8XMT3oKtNP
 gZpPyoIOzVObD9b18L5rKjVn8GOUPJSD86OZqFYvYo6zFbbTH1m36Rr7gqcFIMd4RH2M
 uWPA==
X-Gm-Message-State: AOJu0YwbCS0wPlgXyh1CIUlRZJG2M+sUKii4ZkZj2aby0a3h3CZwQjQD
 ERSMRfJlHcczkDTNbxKz8dE+F9m1xZrVcgwW4+59eV1j7GFrddPf/+fIq3yc25PTevxQsvI4z5O
 as/SyJnaK
X-Google-Smtp-Source: AGHT+IGCcS5Fn84Jwa4ce8MerTIujimp8We04rvdwFmZGNTFi8cehIWALWcI+puaoT1RLmRyc1XzkQ==
X-Received: by 2002:a05:600c:4587:b0:42c:bae0:f05f with SMTP id
 5b1f17b1804b1-42f777ba357mr67471075e9.13.1727970485545; 
 Thu, 03 Oct 2024 08:48:05 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082d22f3sm1531036f8f.103.2024.10.03.08.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:48:05 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Maxim Sloyko <maxims@google.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v11 28/29] [TESTING] configs: set CONFIG_NET=y for FTGMAC100
Date: Thu,  3 Oct 2024 17:47:51 +0200
Message-Id: <4326113733e2d84c4849f004b30f41021a9a525d.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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

FTGMAC100 is not compatible with NET_LWIP which was enabled as the
default stack in a previous commit. So enable NET in the defconfig.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 configs/evb-ast2500_defconfig | 1 +
 configs/evb-ast2600_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/evb-ast2500_defconfig b/configs/evb-ast2500_defconfig
index 6685f37e3f5..d20ccf16797 100644
--- a/configs/evb-ast2500_defconfig
+++ b/configs/evb-ast2500_defconfig
@@ -35,6 +35,7 @@ CONFIG_CMD_NCSI=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_REGMAP=y
 CONFIG_CLK=y
diff --git a/configs/evb-ast2600_defconfig b/configs/evb-ast2600_defconfig
index e6a4e4d1b7c..47faf05a242 100644
--- a/configs/evb-ast2600_defconfig
+++ b/configs/evb-ast2600_defconfig
@@ -78,6 +78,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
-- 
2.40.1

