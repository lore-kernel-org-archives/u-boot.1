Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A836C28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F7668129F;
	Sat, 15 Mar 2025 15:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EAzzF4sG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC0081A0C; Sat, 15 Mar 2025 15:27:53 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B5581C67
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so6174895e9.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048871; x=1742653671; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0teTz8VB7qBHHw32SJpt8MR6+uPFQRq39wPMmlhV20=;
 b=EAzzF4sGxJ7eOO1S0mqbnruvvOplmEQvuLi7IbohNWIzbMJWXQpulG/xk1QpZjuvq8
 d7755HiRz4BYLqRK/qmiO97WuQH8PwhjOqwq1mr/LiebdgzAVqywVy8fsV+jCGLxDQUX
 2N8fbSxECNgih62W/XRRgZEQpSLtN+j3qrPZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048871; x=1742653671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0teTz8VB7qBHHw32SJpt8MR6+uPFQRq39wPMmlhV20=;
 b=JqumqNfaUFYBwYQfBHZCh1/wMonSt957J84a0jTuoLhT5vgq7+5Pa7ZI1uyggxo7CX
 89sj4BDQhs3sjCg1+KRbMLXODH5o8bl1ebIs3QKTsZZqeHxUfpjarGJ1+y0DTheVvZqr
 MUWPtHOrFMAdXmlD/9A+GAaH09oYd/p1aWy4TC0+nIam4Xo2xny8PoNtgq9bxUm7ZiXR
 fe/pQ3UEhdsFn9A6hqHVHO9RGWfLJZ7cwbTA3oUUlDBX5lyyG1L9dlVAz7EhPxIp1SuF
 z8t1X3A9S1PoFcpUarZaQprORNhXRtNdVFCo9XuK9mn3hshhwm67jJanNUMd67So3BZD
 0ycg==
X-Gm-Message-State: AOJu0YzmaL0Nhq9eZ7OXVvdeHZz5dEfX8lh14yk4iNckCubIiOAHzuvB
 UkjGX63R6iRoOKDW5zD6/1t+e91qCCwckq5o1UI4nKTkt35InEXcYDLoVxNyyZBrGaNWyCLg5jU
 lgg==
X-Gm-Gg: ASbGncuWxUQAfe15OjMlxHQYRY5PSwEuHReb8gERG+4pPbofWALNFrohHgwkJeRI2lq
 F2WB0tea8H01nKxdx6Amx5m2Yl2FMacalGL6k0fkeNoMqrSzM+ojONeFt6w7DMvWXAohkcEbYxV
 TQ3zTsy6b+p5nmWCkpCdNmqarcqsUxZBckMaUXqyHE3g1NMZOtTroS3zWzU+rUEEVXt69w7voa6
 K7ko0gFCDELcRq52qdgn7rH1uBexP+xRPhMwnv9ltKEttnPDyMstyaENRNjVJYGhbehV5mib4PH
 SDi44AUl1tRZR0Mtrlk8YqyzqCtGwoatyVW9jrsWxw==
X-Google-Smtp-Source: AGHT+IEdSSGO65cHAG2ULvx+PcezwbpZlKA/b5SpiWEXazmi8nA3XD/nN95DYzS19luAqo2G9XSi8Q==
X-Received: by 2002:a05:600c:510f:b0:43d:7a:471f with SMTP id
 5b1f17b1804b1-43d1ec8d504mr74437245e9.18.1742048870589; 
 Sat, 15 Mar 2025 07:27:50 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 20/46] x86: Rename the _D dirty flag
Date: Sat, 15 Mar 2025 14:25:40 +0000
Message-ID: <20250315142643.2600605-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

This value happens to be used by ctype.h so chose a different name.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch to rename the _D dirty flag

 arch/x86/cpu/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index 845e00ca439..b108f724c51 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -596,7 +596,7 @@ int cpu_has_64bit(void)
 #define _RW   BIT(1)	/* write allowed */
 #define _US   BIT(2)	/* user-access allowed */
 #define _A    BIT(5)	/* has been accessed */
-#define _D    BIT(6)	/* has been written to */
+#define _DT   BIT(6)	/* has been written to */
 #define _PS   BIT(7)	/* indicates 2MB page size here */
 
 /**
@@ -620,7 +620,7 @@ static void build_pagetable(uint32_t *pgtable)
 
 	/* Level 2 has 2048 64-bit entries, each repesenting 2MiB */
 	for (i = 0; i < 2048; i++)
-		pgtable[2048 + i * 2] = _PRES + _RW + _US + _PS + _A +  _D +
+		pgtable[2048 + i * 2] = _PRES + _RW + _US + _PS + _A +  _DT +
 					 (i << 21UL);
 }
 
-- 
2.43.0

