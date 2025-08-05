Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D119C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 09:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED345831BE;
	Tue,  5 Aug 2025 11:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R/R/1U1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E9E831D5; Tue,  5 Aug 2025 11:19:54 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52314801DD
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 11:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76bdea88e12so3339151b3a.0
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 02:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754385591; x=1754990391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oy9G+MWXnn1ko1VUZg0DE+CN4s4cmDBTloo0BmhtuU4=;
 b=R/R/1U1mQzVCHQO9zJl1V0/mToL9UUe8E+U6zHLnJCwODde8qkZMwFunDoWK/2yUtD
 N9u7zX46VJeOrKbRhaYZzpfsbeWfF1FeEbztyBBXgeTP9n+hRkV+ktePnBFnVoQXQmls
 3gv1rkNyDPwshgM/lMP+d+BAHqvv6tIws3cbgv6CXbjTcF7axwYe28uyyFd9ANF1wOQN
 xeFeZeG1GBBC0x9wR2VkOHWyJgIr+VfYz8/xfB1Yqy3fUzeyI7hvYDYIRulvbu9bGsgA
 hOZahxON24JPsakapTuMRMR+9YBDklVu67gc8mYBDC57mgGNYl3MaYB1egs/qslMEhj8
 fG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754385591; x=1754990391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oy9G+MWXnn1ko1VUZg0DE+CN4s4cmDBTloo0BmhtuU4=;
 b=etYgnlagEoteJGVfAYgIXgZs5uOCjJYkWAcTevR63N0YgkzTft+7klDs+W63pZpm+J
 0gtMRjZnRY8+uN0P4a3hPYf+U5nE6DUCOgczvFTcyNVoCrjJyxYnbjT/msYRsHys0Nsu
 YZpJUNEPX/b7IuYb9aTTuzLKpHs+aiR0bRfSzmyYBW50CppjUSon+kttwssxZiQIhlpi
 LgVaKXzkWwbyfj+5VuIXdfVGhkQChFc7UCRU/H4D8HJGMYC/g5wtb0iwFbjZRoHikBEI
 c0yPpYbXSSAUSrEFeVZZ3cMwDaVDzXi4nyU5S+9YgeOpluxWoXn/ugka/KicctTJaws+
 rVPA==
X-Gm-Message-State: AOJu0Yzni3bJdMzfC4oEcJsxIqt5fC/mVoJ1DQDJxfFjTv81w5u6oAYn
 bCbdlj6YnadotWMu1aBD5WMjOmc8dI8O0uJSW19SuiJNXdvw0ezl+VUx/26g+xth
X-Gm-Gg: ASbGncu3eK8KWOBeTR/jKNn2BUcf1N6BMSS/RELdBSijO7OW5FRwQZB2X/Ru4xnuWp/
 jGOBGZpxH5a8WUonchC6Akb/aVnF9wFFf8u5Z/8rhNReRAPrKfKbXyVaKqut/4eS3knpCh+1LZ3
 M5bg937T2YxvtaDY2jRy4LAUNPWQlX6qMdsLQOWEaxXeO4Rmh1St+uSkBpetE3fxYWFbcKRSLPB
 FRD+oru52lnANp8LBYehyhQ86n1kTaEAEotyXrllDKkwpqDWq6wpRscx3PvQK946YTGCc3ijGtA
 PMuHmLNZGW+qhtcY3EP0pBedcgZFzTi3DSjp14WV3HuxlZK956u9SE4K8aBL8zixP6xHRFfiLVm
 mgLaudhEQ1cRUOmhc12gO0JPbbdFYLCSAnA==
X-Google-Smtp-Source: AGHT+IFIopagK/7gX4P3KrD0YFcEuZlE/GnxhU7S5OPyYO0dBXoXA/KBSf8H9wq6W3C2TqK+khODqw==
X-Received: by 2002:a05:6a00:852:b0:76b:dbe2:40f4 with SMTP id
 d2e1a72fcca58-76bec4e1af4mr15272128b3a.16.1754385590732; 
 Tue, 05 Aug 2025 02:19:50 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce89125sm12495185b3a.33.2025.08.05.02.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 02:19:50 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, YSCHU@nuvoton.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v1 2/9] pinctrl: npcm8xx: add support for setting VCD input
 source
Date: Tue,  5 Aug 2025 17:18:43 +0800
Message-Id: <20250805091850.2051096-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
References: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
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

From: Stanley Chu <yschu@nuvoton.com>

Add pinmux for the VCD input to use the HSYNC signal.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index 67e564f85c3..c960ca3393d 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -23,6 +23,7 @@
 #define TIPRSTC		0x50
 #define CORSTC		0x5c
 #define FLOCKR1		0x74
+#define INTCR		0x3c
 #define INTCR4		0xc0
 #define I2CSEGSEL	0xe0
 #define MFSEL1		0x260
@@ -280,6 +281,7 @@ struct npcm8xx_pinctrl_priv {
 	FUNC(lkgpo2, FLOCKR1, 8, 9) \
 	FUNC(nprd_smi, FLOCKR1, 20, 190) \
 	FUNC(mmcwp, FLOCKR1, 24, 153) \
+	FUNC(vcdhs, INTCR, 27) \
 	FUNC(rg2refck, INTCR4, 6) \
 	FUNC(r1en, INTCR4, 12) \
 	FUNC(r2en, INTCR4, 13) \
-- 
2.34.1

