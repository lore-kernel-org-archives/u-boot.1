Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41369CE7AA3
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 12:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AB4988D33;
	Fri,  6 Sep 2024 14:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RbAvXJ6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58FF288D10; Fri,  6 Sep 2024 14:35:29 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91EC188D39
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42bb7298bdeso20709525e9.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725626126; x=1726230926; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7RhZvZ3tdk5Mh8Ow/UvFZRPsh9uBCSvtkeaZiSHafRM=;
 b=RbAvXJ6M3stKutu9e97vDc5eCTK4c8xSNITvahb55dqdct1J9eigxx5/q70GDr/+0D
 aiYEL0CeQykGmEj4ENrSSkm3CG0OIDRT7RTko3K6sEj1jSbff/LQizbx0PQJ56li8uHP
 W9rNa5rjoR+11Hhk8i7VpwflIIBq8YrqfhPzIvabykKDDcNEHUwjDydH1NDl0BkDXCpL
 kKrTFL4YFJXUDc5JJ7+LY6XAmE6SeJljf8iCMAsPNqDEefz5Skw8AnvubE9p7n0X1ldy
 ZJzu1yaPlCJ+aoc/NtOQaqBWK1zMw0mkHhBBqcrPGNTVCp37DDqFBW+fI2a2BzPXTLhI
 O1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725626126; x=1726230926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7RhZvZ3tdk5Mh8Ow/UvFZRPsh9uBCSvtkeaZiSHafRM=;
 b=A8zmUfR91tJfMWVgONVopf6k9UxnChatBHby8LgSp0BLLSfV4M5o6+cDCyW8qpUPgh
 aLdt4TxXJynUqzipiT9KoOCCw/tYNZNNtgBuNzv26HKp26Ue7YDMOkdwk8HMZdKf0bb2
 Bgoutlv4A9j2717E3XT0gtChlDHEb+WavATatOfZwbFbYvGkU+dxV825pI49l4e11Mm+
 fccO9oPEJA5lTzExSTQHqf5rDMN4aKIi6iGqasI6fMG8IVwifS60dtJ76+HCHQX7jXlJ
 z+a+68HT8JRSrnEQYrRrasRRrPPr7BBzMBWMYlByhF9LWzF5Znm3tLTUvIeO3WYSYoiC
 82Kg==
X-Gm-Message-State: AOJu0YzinxhlRjMMtp0sI2AVCKVB3bRDI8TXGxV8ySgicothAQf9N0oA
 vlNdlrjk8PrIZWwe1Dw/cfZHp3+9phcLf1aqX7bh22u4cO664Afbj4SMairxlJMnFfepj7Vt8jj
 f6yggKiQ9
X-Google-Smtp-Source: AGHT+IGmxpInBMlGCOXVzloZuy7BivCBpPHRK4UY2NpNXdsLY94e3iOV0G7tRDr8+GOUG3obSR7FmA==
X-Received: by 2002:a05:600c:3b21:b0:426:6714:5415 with SMTP id
 5b1f17b1804b1-42c9fa0b26cmr19825765e9.30.1725626125753; 
 Fri, 06 Sep 2024 05:35:25 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1ff1:215c:d8a4:9f99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cf0e8sm19640125e9.27.2024.09.06.05.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:35:25 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Maxim Sloyko <maxims@google.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 23/25] [TESTING] configs: set CONFIG_NET=y for FTGMAC100
Date: Fri,  6 Sep 2024 14:33:39 +0200
Message-Id: <899c2f112327af9fc697113e07dd7aeeb8c1f4c4.1725625913.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725625913.git.jerome.forissier@linaro.org>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
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

