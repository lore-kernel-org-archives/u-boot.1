Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E87C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 14:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 678E680B98;
	Fri, 14 Feb 2025 15:01:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QD7BGyyn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4C6B80EAF; Fri, 14 Feb 2025 15:01:00 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9368A80756
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso13744295e9.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 06:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739541658; x=1740146458; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJ/WOo4fTLMKMXvV7x5SKkbdsCeYlarnyOLSSxr3gnM=;
 b=QD7BGyynAUcYKovHDQ5QZyWCCM2bMrVjbXgvQBxbB/mXJvxMr+Cx6FK63Mz1/Hu5Zz
 StnRLy1InPzjFGEO4rn3wuHMQrkjfgW1cxfWJf0ATsNx5YjUqhHICghvmFMyPa50j9S6
 +znX5MVgB6HqPjmClqmPyD5Vle51hXgveSqJm2vFayCNo45TgLCTi+qKROe2+7P6Ivkm
 pGNlX8h19LLPuMKiQ55YqSe6Zm5qiuz6uK1GCvT8gQEFPeKfg7XLCm2M3VKJ7vjtzgGG
 klRTmK3kfvK9kZj69Bai0t7SSIxXcVUsBTF2qzzfn6XiMTB9THo3a/NhnZdZYHjNv2TO
 Jz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739541658; x=1740146458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJ/WOo4fTLMKMXvV7x5SKkbdsCeYlarnyOLSSxr3gnM=;
 b=b10GyyRo7grc5I8sGb+f6/2cVpngtTXzaGEpVUycwTZ0YR/vVtDD67XqkahF1hCykc
 H+6Rd17nPAZuu/aaeXOJQq/hF456kyhQ6g011D25hTjknb4TZKo4CaMK7jhNXakiLQio
 LS2zhpu6N3RCJKF6iw2vMD3awoaqpwaH/ETDAjRo91pzzHMkxFCJRUPMCZGwNHQFqaU0
 Q1F14AJ4mcL7Kdg5M8d3f9xWSzHPQSHN0Xc1D+IhXyy9gBk/fXImPN/sVLTVumI6w7zk
 DlDHaKhunFaFtYd++QEUGr1Fiow8ytdp8hfD7+q8ysr7Y3MbJWOfpaNC4pkP1xOxP61d
 FU8A==
X-Gm-Message-State: AOJu0Yy/xKRoz/P/UtY9pvDaQpv4fi+DuLA5qd+3udBAwnqElLXaw7qD
 Htxpy8VfTxOXxCqEQgqWZEd8lL6rwZQAmpWX5o2CPPVm5hN7UOGWk8TXZd5LmlIOT7kb9subTLP
 fUXvKPg==
X-Gm-Gg: ASbGnctwYdoLIItYWz/qRD+QH1zbmQpeYVoczqFHsCGNWF6IdkXmDbizvhpNrNR4Gqd
 bqr+9UTJSE2+126ATEPVHN6+X9/bBFV9suBF9m5sGn5QfaMxF8SjefoTBE6JMnzrgbSKySy+eBF
 xRKQqLxiD5RQGhdFyREdsY+I6EXxOdyCgjOlLDobsdMAWrZZABSMxW7s53k5qhmh3jL00J8bCvY
 aIjsuVfIqLxasBS980ApdE/yrMIp1SSbZMeKDueFYe18qa+AsU3xDctvTR/NUXFB1x8VCfxN7QH
 LyLj/HsGpJj1ipitp77N3IPd
X-Google-Smtp-Source: AGHT+IEdKhXbS5GbdYPtOxOpmrBHW41yMaGHB46ky8/+8acVW3wILwIUQi2bC/uITMv/DoWLiUcrcg==
X-Received: by 2002:a05:600c:548e:b0:439:5aa1:1efa with SMTP id
 5b1f17b1804b1-439601a119bmr96458835e9.22.1739541657624; 
 Fri, 14 Feb 2025 06:00:57 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:65ac:d875:2c3e:607f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc7e0sm4666391f8f.48.2025.02.14.06.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:00:57 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [RFC PATCH 01/10] arch: introduce symbol HAVE_INITJMP
Date: Fri, 14 Feb 2025 15:00:16 +0100
Message-ID: <20250214140031.484344-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214140031.484344-1-jerome.forissier@linaro.org>
References: <20250214140031.484344-1-jerome.forissier@linaro.org>
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

HAVE_INIJMP will be set by architectures that support initjmp(), a
non-standard extension to setjmp()/longjmp() allowing to initialize a
jump buffer with a function pointer and a stack pointer. This will be
useful to later introduce threads.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 35b19f9bfdc..8d5b54031b3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -13,6 +13,12 @@ config HAVE_SETJMP
 	help
 	 The architecture supports setjmp() and longjmp().
 
+config HAVE_INITJMP
+	bool
+	help
+	 The architecture supports initjmp(), a non-standard companion to
+	 setjmp() and longjmp().
+
 config SUPPORT_BIG_ENDIAN
 	bool
 
-- 
2.43.0

