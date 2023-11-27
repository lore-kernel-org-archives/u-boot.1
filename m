Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B33C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEBA087753;
	Mon, 27 Nov 2023 14:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qnXydXjp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D969A8772C; Mon, 27 Nov 2023 14:01:14 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01CEB8774C
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5098e423ba2so5974382e87.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090072; x=1701694872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJeg23sW8Yw+xxzz35ozyxcHoiIIMDWpggcEEGRDd2A=;
 b=qnXydXjpMYpYT7bwD3sdTot5swSPFfY7figgD6aPRCJ9lDDlLwsyq5hhDJSWr6Oiod
 65w0p5vtAeV5WWymCGETU3+pFLJVZXZ/uYUCJPytbPzfa5ueT4ksAxdq4bLLOlLUSDP4
 t24uYtBxWSegjgng2jWyofv/qrzVEA6Y+P3hQjNW0uz5vt92ICBsqerw64QPRnKQeZeh
 uSQqZKxULZpfnurH3/JoMUAPkRbB+iGZVXWGia88T25l5p73K8ActTrZ7TUEAvxua3ix
 F2wuPTLs5oBe5jF2OObDpB0KB+g5PfimsZbfiItbLriiFN3u5dzgx7u+LmAnEcP0OeSM
 JNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090072; x=1701694872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJeg23sW8Yw+xxzz35ozyxcHoiIIMDWpggcEEGRDd2A=;
 b=iLGJHPo7MJ0PxdCL/aHb1wZxCYuTsJnpLXYjnel7g6f9rIvSt4DCzguxKvmT1oA9ob
 2+izVvf5+ht+mnZt5JbcN6oiOhAFkjawFSRwpxB70noBnnY0Obuda0E54hHLDx8Ubljp
 VIphOCBtDPGWwX/ozfo+T4jAnkPdK8DHaqOyWLM3Jv2fqvPokSquAxYKYsbP10el7z/p
 HXAbBemmFYJL2okKmAT9sV/H7enot0t2dpVsLO7LSVEuP1j3D98Peai2W6n+dkPeWqsH
 Rmkct/Ro04WOhrtSNKLdDiPLvikCkzwulHT9xz3r3AX09vpEXRe+DePk8nvX62cdn0Wq
 boJA==
X-Gm-Message-State: AOJu0YxlkoRptyBWVS2Pa2Yw1ju8Gw48xKfgapZWFXpTN39c3Oj4owHx
 rqUnp68yhuMyGg3V6v8lnnAa4WmU0cmfSbaoOBFxwg==
X-Google-Smtp-Source: AGHT+IEThUFGLJkItPcY+7tXn4zI2m3lFuhg9VYum/tg8x75198bnlqgqkzLkLMedw+tXD91H3475w==
X-Received: by 2002:a05:6512:2805:b0:509:5d4b:44c4 with SMTP id
 cf5-20020a056512280500b005095d4b44c4mr10806730lfb.1.1701090072076; 
 Mon, 27 Nov 2023 05:01:12 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:11 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 27/43] configs/socfpga_secu1_defconfig: enable LTO
Date: Mon, 27 Nov 2023 18:57:10 +0600
Message-Id: <20231127125726.3735-28-maxim.uvarov@linaro.org>
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

Decrease allowed binary size to fit lwip code.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 configs/socfpga_secu1_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_secu1_defconfig b/configs/socfpga_secu1_defconfig
index b8052f1dee..4213941bcf 100644
--- a/configs/socfpga_secu1_defconfig
+++ b/configs/socfpga_secu1_defconfig
@@ -113,3 +113,4 @@ CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
 # CONFIG_GZIP is not set
+CONFIG_LTO=y
-- 
2.30.2

