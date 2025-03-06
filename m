Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683CFC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B3B817E6;
	Thu,  6 Mar 2025 17:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EM5y2nmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 937FC805D7; Thu,  6 Mar 2025 17:05:18 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B276981760
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-85ae9566c52so23737339f.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277114; x=1741881914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OHbEsnHwRxX59csm80YE2M40ZbkK24iC/vPmoTrBDE=;
 b=EM5y2nmCZkmS5ohotq4iqmP36zyL0uGNDY/1CilV6qjDdBm3WI5SzoIhW4tLy6ZYGK
 koNvcIfmEPHZBUgUv2Y7th9dPuprQ5X4fCDfU4eSKMhULRfxaBDrcdoXYjZwnOZZd64C
 97bmi4jYQoHs3MFsctWdhVJJd2o4chPcNBQkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277114; x=1741881914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7OHbEsnHwRxX59csm80YE2M40ZbkK24iC/vPmoTrBDE=;
 b=lT0PMyliQtb4m5I/RSKz/sQarZDBnGhpprq3xAuUBvFI5hMCnJZpmWmCXUNTK4NBLp
 8/8Dg8qV80hSlTO+LNwvTeJzuPPVZnMGaYTbrIrPmGEG56bOT2tY+ThelaW4PtdUi9vh
 PG3l+Wv6E1KloMKIkjEJyFh1vOK3UP8047Te9J9Xcu8G2F1HCtP6Y1kcCPjJRyzxGjTF
 /ZywIuHMTTIVwcMcPaOpGqtC3Y5q2glUE5ZKIb0Yblmz9LJI/SedKj40oJCtLlwX5IYo
 5QuFpgbHf+tsN5QKwIc3xr3RCLWepCLP/hNJqU1tRzKW8QN51mY02OUeUXFIjRxNLBI4
 rCsQ==
X-Gm-Message-State: AOJu0YxBV23q5FLtqwUce6+TXccP87kMFBduHJ1oDrjQ+X7xReg+i2SX
 i7d9AIuMHZxRnfBiO1x7p3sbOX+L5vCX3PQ0bAEgKMaprF3NnpeJiMlix4y3t7SIsoWOap7kPpY
 =
X-Gm-Gg: ASbGncta0g7MHOcZNCZNR4H3QSQyHvBxAeTEAeJ873kDmA01VwPi6a+MBQSWuH8KVby
 VzSPrfE6oyYnDPjVmj/3yY17H/ceKvlAhT7uJSHfh7SNIxhvNaoVii6fTsZzspzt1gWfqmAC8K1
 3OlMRf75jtq861g8PmXzCTt9CgWpILSSZ+8EdrZKk2/q1aR4Hh20EmuTqviXjMQdGQX/rDFJgqN
 brVDIeXfrM/UbaHzO9sUdP3VRSLrTwlJesl6rl7QjWhVG75YHtlYX2q5MbTXuQjCpKBwmrvr08Z
 oOU2+xvXMt6KHkGnQP5xeh7ciwAkbU1nGPHjoMrQ2zG/GlOUL1COzouDdj2i17Xrq9DQKy2aIv/
 9u3AyNQ==
X-Google-Smtp-Source: AGHT+IGMSh9DiJ2H+NEZFytFE9DmwO+ND4RrTGjVAss3URDY5lMYdCyiv/Nl8W5f3hArlIbijatNqw==
X-Received: by 2002:a05:6602:3714:b0:85a:dea5:2c5a with SMTP id
 ca18e2360f4ac-85b1d06ac6bmr3421539f.6.1741277113580; 
 Thu, 06 Mar 2025 08:05:13 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 13/47] x86: spl: Drop duplicate CPU init
Date: Thu,  6 Mar 2025 09:03:40 -0700
Message-ID: <20250306160428.3041057-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

x86_cpu_init_f() is called by arch_cpu_init() a few lines below this
code. Drop the duplicate call.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/spl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index 7a033505101..47cf9c862b5 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -84,8 +84,6 @@ static int x86_spl_init(void)
 	log_debug("x86 spl starting\n");
 	if (IS_ENABLED(TPL))
 		ret = x86_cpu_reinit_f();
-	else
-		ret = x86_cpu_init_f();
 	ret = spl_init();
 	if (ret) {
 		log_debug("spl_init() failed (err=%d)\n", ret);
-- 
2.43.0

