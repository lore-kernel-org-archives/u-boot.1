Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EFAC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 20:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 603128754B;
	Thu,  9 Nov 2023 21:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="onvE/Mor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 419BC87516; Thu,  9 Nov 2023 21:13:18 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366D887520
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 21:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6d31f3e8ca8so688869a34.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 12:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699560794; x=1700165594; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zAlazYIUcdwCQ629FvIbqNjaTtJk6c08UiZ0/PXj2g=;
 b=onvE/MoruaDrmAyXDlVJl31aDZdvioeNNSe8HxrmNCs4Ut+RrRtlYAL/Bz8mOY8+i+
 8wXKSEU+mssEtI+LfwAQe5weYhkPDH70pDq+FGeXyduPptQ4t7SVMQLm8MGxVXuhiVrS
 IR4Jdia5HHplBLwt+4V6v9c12fpxnXDkxI7qruAyf+FnxFeGOj5i8bjXZBpwSlFGjUDw
 tOM0jHsOetUxQvShi41xTlMUUA+2njrm2FLIhRK1hO9Za6jsTGHJmUxLYtT0neola+Te
 LIVU1DeF+vI2XxCnTl12FfwWPhXgIbo+YhRPCHAeQPhXArgv7/Cubf4vse3/8q/aoLoJ
 6S9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699560794; x=1700165594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8zAlazYIUcdwCQ629FvIbqNjaTtJk6c08UiZ0/PXj2g=;
 b=Bjg/SwbbxrrpsXZKUvIJLsX8YDgC19eK99zKpaKv3Xitcu6ZG9Xg8u1MgDFLS5z9TT
 HylUZLdDZmlqtpyY+ij/SraX9d+p7+QPRwl9vs2q4PvrF1mWVEBdYHzSclTJ24WtB75Q
 qMrDj6OthBRZUCa4B9TT7eArVVlC+yfXmbXSQVUtIRoikZcMX7LEfd4ShYVGEuB2p8sk
 +Z15CDJp8pSJVLQ4bhkBVtjCx4XxcVDBZdjUPHOh/PbCch1NInxBwYR9g7LGTTKs8zL/
 H3aaE5XGoQamocCGbObxTAbs5gi/d8uxG3/3Kzn0z+823uLbU5zXdBIhIdl6Zjf4US7l
 pX6w==
X-Gm-Message-State: AOJu0YyqX5ZDKpYB0U41NT/oq3jmzmENDbY6/HMGNlFXYKEXheNQivb0
 AUlP93I0StipDFR3RxCKJ5IkSg==
X-Google-Smtp-Source: AGHT+IGaBZfmuqVo89AGimTydf3jDYEQNHiyIN1234+ihR1Jo2Lz72FoKVqnXna/HmHk7FSt4su22A==
X-Received: by 2002:a54:4186:0:b0:3a8:6693:135d with SMTP id
 6-20020a544186000000b003a86693135dmr2634486oiy.49.1699560794569; 
 Thu, 09 Nov 2023 12:13:14 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 s7-20020a056808008700b003ae53e64549sm82382oic.31.2023.11.09.12.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 12:13:14 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 2/2] configs: Remove unneeded SYS_CONFIG_NAME from a*y17lte
 defconfigs
Date: Thu,  9 Nov 2023 14:13:13 -0600
Message-Id: <20231109201313.29791-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109201313.29791-1-semen.protsenko@linaro.org>
References: <20231109201313.29791-1-semen.protsenko@linaro.org>
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

As correct default SYS_CONFIG_NAME value is now set in
board/samsung/axy17lte/Kconfig (in commit "board: samsung: Fix
SYS_CONFIG_NAME configs in axy17lte Kconfig"), the SYS_CONFIG_NAME
option can be safely removed from all a*y17lte defconfigs. That removal
doesn't change resulting .config files.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - None. This patch wasn't present in v1

 configs/a3y17lte_defconfig | 1 -
 configs/a5y17lte_defconfig | 1 -
 configs/a7y17lte_defconfig | 1 -
 3 files changed, 3 deletions(-)

diff --git a/configs/a3y17lte_defconfig b/configs/a3y17lte_defconfig
index 42fcd2a3d317..043f3a04db88 100644
--- a/configs/a3y17lte_defconfig
+++ b/configs/a3y17lte_defconfig
@@ -1,5 +1,4 @@
 CONFIG_ARM=y
-CONFIG_SYS_CONFIG_NAME="exynos78x0-common"
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=26000000
 CONFIG_ARCH_EXYNOS=y
diff --git a/configs/a5y17lte_defconfig b/configs/a5y17lte_defconfig
index 3b80536c12c8..14590f65e9c0 100644
--- a/configs/a5y17lte_defconfig
+++ b/configs/a5y17lte_defconfig
@@ -1,5 +1,4 @@
 CONFIG_ARM=y
-CONFIG_SYS_CONFIG_NAME="exynos78x0-common"
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=26000000
 CONFIG_ARCH_EXYNOS=y
diff --git a/configs/a7y17lte_defconfig b/configs/a7y17lte_defconfig
index 9390e35057eb..ccb0bf2e8059 100644
--- a/configs/a7y17lte_defconfig
+++ b/configs/a7y17lte_defconfig
@@ -1,5 +1,4 @@
 CONFIG_ARM=y
-CONFIG_SYS_CONFIG_NAME="exynos78x0-common"
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=26000000
 CONFIG_ARCH_EXYNOS=y
-- 
2.39.2

