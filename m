Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5E5C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 09:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B49B87E91;
	Fri, 12 Apr 2024 11:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LP/bzugq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6F6387E01; Fri, 12 Apr 2024 11:54:56 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF5BC87E91
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6eb5887f225so540604a34.2
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 02:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712915693; x=1713520493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qmjG6y1HI+u+5brs6XyZbV3yR3pW90gAcjVe/0I1eLk=;
 b=LP/bzugqWaywKjOJ5HbFN5J8Wte2TukR8eJSHHA8lKJI7hb3YWMc/70yKeN2ymKrsI
 OvEBzi8DOWgJnXQysNlJA2mA6MbhSK/Yy2I7ZsD/jd5OuAB1fi/ttfOvRFIvfAJdKOYn
 bCOp1wfN0o45qc9Fqd9NxXWO4MgWYi7GdR6p1AIXHcv/so6GZ96k1z15SKIR3/ryBySH
 Y6H35fyu8hsjt1p/QddhcNsowba5T8nVQg5AlHT/RxJ2l6C4tUaHOgsAXWKDrSTM8eLN
 a5Tq1UGyHA1LhhqkUgQW9uI3tklyQy+bqa2RPGNbbGNIGyfzyR5mChoSb20TKGivtD5L
 oqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712915693; x=1713520493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qmjG6y1HI+u+5brs6XyZbV3yR3pW90gAcjVe/0I1eLk=;
 b=Q8k7HXYYrS7ip7WTUKl/qlhAbW4Ps6OMIE/Xgkyzh99QgKjmjwiEwk6FnZSCcCTBAN
 ag05M3ZHk+isE+tgrhqqSWVD33zeKAh9K6qfuOHbvlFhdbjKU1/rZF0dkyRj0bZTHLvt
 VXc+ynZkevok64Ie26ZTPOpsG1DhWe6DNdJeurqg6qWqNeFnORjCro1vRWLMBpJzLBKS
 D9cSBGb1nMGiz7YVelzlnTdWxRhAN8s1ATYbMxLb7j0l2xAIIh/yfiRtXBs4W30L73wV
 NBotN3xzuNL9sPeyFSxNtGuaaNTwzQv7QNp+NJp4LDK9ePeFqdtWvnHE9AAxA6I6AdEZ
 snOQ==
X-Gm-Message-State: AOJu0YyvIe3NC55ZcgVJY9g1+StMeM25+cIirhlVbPQCyqD4UfjnXZQe
 jfYEDWTgHQcUWLvQCnQQ4vIdx66o1PmTYJvscWeGrPOyzUt7KIHJk4nIJkqsOiIYd5pRiJNXML2
 r
X-Google-Smtp-Source: AGHT+IFJpHs6TDhEfXN3Nem6MpvxyEAmkalHXMpCSSOJ+Qvcj0POMp7cku7queU13MS77Xso0HeVKw==
X-Received: by 2002:a05:6808:3a95:b0:3c5:fa5c:7762 with SMTP id
 fb21-20020a0568083a9500b003c5fa5c7762mr2199751oib.44.1712915693370; 
 Fri, 12 Apr 2024 02:54:53 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.92]) by smtp.gmail.com with ESMTPSA id
 bn19-20020a056a00325300b006ed0b798f1fsm2534839pfb.119.2024.04.12.02.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 02:54:53 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 1/7] qcom: Don't enable LINUX_KERNEL_IMAGE_HEADER by default
Date: Fri, 12 Apr 2024 15:24:32 +0530
Message-Id: <20240412095438.410570-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412095438.410570-1-sumit.garg@linaro.org>
References: <20240412095438.410570-1-sumit.garg@linaro.org>
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
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 23ee25269a2..1d451c46d32 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1088,7 +1088,7 @@ config ARCH_SNAPDRAGON
 	select BOARD_LATE_INIT
 	select OF_BOARD
 	select SAVE_PREV_BL_FDT_ADDR
-	select LINUX_KERNEL_IMAGE_HEADER
+	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	imply CMD_DM
 
 config ARCH_SOCFPGA
-- 
2.34.1

