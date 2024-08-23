Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106CEC52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F26FA88C13;
	Fri, 23 Aug 2024 15:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oiw0OBrq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47CD488C13; Fri, 23 Aug 2024 15:50:19 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6534F88C8A
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-371aa511609so981029f8f.1
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724421017; x=1725025817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJQB/lVIEuaOTisBmT/KtDxk9lFVqELDc6NKg+RqMYs=;
 b=oiw0OBrqtcuG1mkPXR0Tp3np4xX8dh6Q0xeIcdzPzOwFiejI1HOZtmCKx7PQTFb9RL
 NDOIuP5aVZt7bGygDcAklTjofp19ER2IODmzE8ZkwX1qzU1VKthdxY+s04egP0hkKKtJ
 SZI1jyhPb6tLlQUSSFgmLet9t4G72XnZRQNWpV6HZHwVx1VsnrfGMM2pqyzJc6d03SWL
 +0AgraayCZzE15FjUTeTd8DtiBQb0gp7cBBPtBR/MSSdn6CGeDA42tmjT3/XnIK6nNss
 2PdSfweYJM9XYOk/jrVF0WXdA8FQnXyViGahOakbVBa02Ys643uMFPw1CkmkUMEfSr62
 iCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724421017; x=1725025817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJQB/lVIEuaOTisBmT/KtDxk9lFVqELDc6NKg+RqMYs=;
 b=lyrwqkUCv/TB26xfkgqxRBl3ZvuvbCgDjEZtyTUEMpvVHJ/x+Hv8ZzUc4L/ST2F04d
 +RNt5zc/HzTqgE0opAoO9m0v6pcbeptUcJ87+zEiFADo+JroHIOw48wswMPSxYCjZsCf
 xRFtElTP53lRqP3fxYnUfVzWdNBcesgkIsf8tvW0R3aMffh3jIX1oT3B3gM8xhUyfsqn
 uMjc+dbe8XU7NyQnkNZApyHEKxt7XviP4khAvH8Xt6vfWMwaDO9V3REvxyGCbsd4BvC5
 Cy8x337pXxaIte5JVJeHiqKGEKCB8yGgVPu0GqRDJS0lLtxgzE+NX7wabz9PEuF4D7Dt
 o2Ew==
X-Gm-Message-State: AOJu0Yz6LvRJc0PrJniePnRibG9jNJUZjrlp8l3UGwkMNunAWjKDQ0vB
 Yrc88kO0dkfut6K4p2CpXeq8ZwyFRb4Hx2QCwjcLMRC97JAFwynnT8qRQqluYIBmLebXSK9Hbu5
 hdjclQPHP
X-Google-Smtp-Source: AGHT+IG4HnMMXJ/wBCUQgtK6o+fhHGmuxdy4/FFqKqTAA5Q7tBhVbPE/6+A87xXvEk9OrVH0/1N4GA==
X-Received: by 2002:a05:6000:c85:b0:371:7d3c:51bb with SMTP id
 ffacd0b85a97d-3731185ea64mr1314252f8f.19.1724421016607; 
 Fri, 23 Aug 2024 06:50:16 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:50:16 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maxim Sloyko <maxims@google.com>, Tom Rini <trini@konsulko.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
Subject: [PATCH v9 36/37] [TESTING] configs: set CONFIG_NET=y for FTGMAC100
Date: Fri, 23 Aug 2024 15:48:40 +0200
Message-Id: <29c7d3f8d92ef223c269dc4b27076b99cb3c142a.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

