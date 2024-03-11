Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21E5C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 11:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2465687F01;
	Mon, 11 Mar 2024 12:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rQ3bywO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2363787F1C; Mon, 11 Mar 2024 12:10:59 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06F4587DD3
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 12:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dd955753edso7835525ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 04:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710155455; x=1710760255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h2QgLH5YwYZ18JCgqVSGKouXGjATaF+HQBW6lr5ss6s=;
 b=rQ3bywO4R7tkM7iy9wo/Z4TqQdgNGVN1tbd3yD3/CHZP+53NGkYeOy3UhYlogy/Sgz
 WZH2uncHLY0S9RI+7m3b+L9TlkckFkiB5ggvAjIy3yT/WwPx2opujGxoC1bmK2jD1UGc
 ctMaYmkvHh5OtqFbk+FQ66+v8y8LwI2L6PF7R+DPpVTbOzyiLkF8YfGH9zjLYA2Cahwh
 5BIoahGG6cDu/wehUnnet0npacTYJMm4MlXeleMaY7w57pTE4hp013GGN5eaUZASWrtT
 lzPfGSSknGzFR0DaccyTyy23wU4qz6DFWPhL00JhjNGEJvmdERU5APKRQPtCpbkEsoza
 UDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710155455; x=1710760255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h2QgLH5YwYZ18JCgqVSGKouXGjATaF+HQBW6lr5ss6s=;
 b=Z2Pi2pAEEgaxkvCrwsXjn4NopgxEXnqcVp9HAcqgo/Y+mTqqaUwfGSrLpZ5wr5YjZo
 1K/JrBCpCvx0kkUUZof3nMPzdxYVucR9uW2xEzUpfcoU2np3A+fcK6JBQ1XJRCy8Q+By
 W4RAxduQVicsZ1wIPVNXktT389Gujyt4zTgn4AnLi6IKMHJF86DxAnIWLkN4LRCRtaNc
 hckGXG+p9Yl58Tt+22Zg6O3eS2fazhGmC9yBdnSE9TbNEGi1jPLWYK5v+z5Rrg9Ll4R0
 GrFnXcDnZyUpHztRkhPsHe/KWyvE5BKS2HHAZ58dxACaf6rvjFG0lFVUULoyOUx8t7Ef
 y3lg==
X-Gm-Message-State: AOJu0YwUG2iMWOCW3xbZQsG65/Mt6UVQXtWVdFOR5toFINU8pG2YVECb
 D1jLf4uRae/URzmqy6G3w5Pj3W0gbfOX3AiF3Fb8LVQ1Og+rO8sEms0plvHeXhHYfurOp932kt6
 C
X-Google-Smtp-Source: AGHT+IGwqXgf6GmUKKvMC/qCiKd9W1Gnmp9boTHyxQZteC+zzlKliuqWxc1OEVkfPDnfYgqx4UNmDw==
X-Received: by 2002:a17:902:e750:b0:1dd:9cb3:8f96 with SMTP id
 p16-20020a170902e75000b001dd9cb38f96mr2448704plf.42.1710155455084; 
 Mon, 11 Mar 2024 04:10:55 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 o13-20020a170902d4cd00b001dd8ce888aasm2877895plg.74.2024.03.11.04.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 04:10:54 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 1/5] qcom: Don't enable LINUX_KERNEL_IMAGE_HEADER by default
Date: Mon, 11 Mar 2024 16:40:22 +0530
Message-Id: <20240311111027.44577-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311111027.44577-1-sumit.garg@linaro.org>
References: <20240311111027.44577-1-sumit.garg@linaro.org>
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

Enabling LINUX_KERNEL_IMAGE_HEADER by default doesn't allow
ENABLE_ARM_SOC_BOOT0_HOOK to work properly on db410c when U-Boot is
loaded as a first stage bootloader. It leads to secondary CPUs bringup
failure and later causing the Linux kernel to freeze.

So fix it via selectively enabling LINUX_KERNEL_IMAGE_HEADER where it's
actually required.

Fixes: 059d526af312 ("mach-snapdragon: generalise board support")
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 65fa7ba4ce7..27f3d9a43e1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1090,7 +1090,7 @@ config ARCH_SNAPDRAGON
 	select BOARD_LATE_INIT
 	select OF_BOARD
 	select SAVE_PREV_BL_FDT_ADDR
-	select LINUX_KERNEL_IMAGE_HEADER
+	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	imply CMD_DM
 
 config ARCH_SOCFPGA
-- 
2.34.1

