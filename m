Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FFDC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA6CC87778;
	Mon, 27 Nov 2023 14:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pozX3qrR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4545387781; Mon, 27 Nov 2023 14:01:31 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284818777F
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50ba73196b1so3112964e87.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090088; x=1701694888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWCV+Hf0TDVhRzblYYNCjboO9kwYyGmNOBN3Gxq1Ssk=;
 b=pozX3qrRhOwUA2aJU7uFJixu2LpqExrcHDmk832Xy2pYwHn3XR3VI0ncZiGyfRxooJ
 sVSa+4GFYNvSyHjjjshvLQNFLi+VtsTpdLk+uffoHjPU0URVsPizVuTKU6brLcih/15D
 bxfGEX9WyCXpybv1BTlr8jM7iPz86aeMSS/rRbwl0UXXhZlQ+m2JuUxE+0LRglR22XwO
 EA/T9YaeHkh/pqWJ5NtdTkwpwGLEMfPPfVmHz3M+uMTHBhmX4EHKcdeTh1t3dYfoNcu2
 HxZpDs38INjOSTmcEAVFjfNRV+VNyzawLv5BYTIeaiGqvckY1ddhXJ5JolIzMtnuJ5My
 XwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090088; x=1701694888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWCV+Hf0TDVhRzblYYNCjboO9kwYyGmNOBN3Gxq1Ssk=;
 b=Ow1w/QWLaUXYNnHpq+EGvOtvwzUvrdsUy4rmjzBmA+CQEjD7iRVAC92lPKD2T/Xkna
 sguXKKZXTtYk2GlMg6oyd/rW53Nf2StjodRiwYlwkcAdcq3elStv7cq6JdI/vkberv3W
 aUlU2k1M/NA6yhpUBFBQNVN7t4iPv021UQ3ZDYkTMEMVZuRtZJodG67hHvVji9F6tyH6
 fXTk+3edeSuhWDvsFn07fQnVJllADj0TAJbgV1wsgMD1RMX35UA0TmXpm7fFg8U1vbOz
 JQAWPynVmJ1qWpcl9I/KpX4hSMobR6hGi2koAg+Cs5zz4J1pfqW+xoqwkL9ytiOpmUl/
 xxPA==
X-Gm-Message-State: AOJu0YyYpKZkgPF9Zjutlaj1/g9FX0XiJJr4OYGG5SUpGNAdjERblBiV
 ca1mZ6nqjTEeMnXh/+YWf3nExji51S6NQ3Vxmpk+Mg==
X-Google-Smtp-Source: AGHT+IE5jpGOvxphcJO4M3Dr27GZzTlcb9ViHfdt5GU8IVrRSr0ltY3btU8KbdWx8qsLYNbup3NUcQ==
X-Received: by 2002:a05:6512:280c:b0:503:3808:389a with SMTP id
 cf12-20020a056512280c00b005033808389amr10534407lfb.11.1701090088051; 
 Mon, 27 Nov 2023 05:01:28 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:27 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 34/43] configs/bk4r1_defconfig: inc size
Date: Mon, 27 Nov 2023 18:57:17 +0600
Message-Id: <20231127125726.3735-35-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Increase allowed binary size to fit lwip code.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 configs/bk4r1_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/bk4r1_defconfig b/configs/bk4r1_defconfig
index 95f0c30cde..30ab54a849 100644
--- a/configs/bk4r1_defconfig
+++ b/configs/bk4r1_defconfig
@@ -20,7 +20,7 @@ CONFIG_SYS_MEMTEST_START=0x80010000
 CONFIG_SYS_MEMTEST_END=0x87c00000
 CONFIG_LTO=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
-CONFIG_BOARD_SIZE_LIMIT=520192
+CONFIG_BOARD_SIZE_LIMIT=526336
 CONFIG_FIT=y
 CONFIG_BOOTDELAY=3
 CONFIG_AUTOBOOT_KEYED=y
-- 
2.30.2

