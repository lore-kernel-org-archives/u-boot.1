Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA61F46C46
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 14:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC158406D;
	Mon,  6 Apr 2026 16:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="jvlnlxsA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A8F38406D; Mon,  6 Apr 2026 16:24:35 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00EE18341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 16:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b0afa0210bso19374745ad.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775485471; x=1776090271; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOI1OYw5L9OgSAUVFCFOz1abNqr83KHrn1G2y294vG0=;
 b=jvlnlxsAac8my78Lq0pezNJx51HRTmaGZ5OSTbnuMLo8klr+x+BH9aUPUIs40A2owm
 rdSaR8+yU84vsDm/g5Q3chTm/MLD0LiJUBeyp0VfU9goL3zxFIusn+4/FR5Xz+ohTvGp
 6LRSauVB6N1KLHf3my4JkMW17Ujm4sU/waMew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485471; x=1776090271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dOI1OYw5L9OgSAUVFCFOz1abNqr83KHrn1G2y294vG0=;
 b=RPNWEa8gBpJJgB24OqTv7A1avrY/910hPKGML4vJo4yr3S6UM5IQ5CB4SSXJg+vQES
 ZxNrlqOgBDSujph0nN/A6oFcNEsvsY0r5UZ+Gj6ZtRzoGwqLMCc6kb3jcSYGwvrw9JgG
 i8DftkhFyif1RJTi99fEPqbmdYTKE5gZ3WYMs7KL+jU0QPPvkasxZIHxcp4tDkwSovo3
 e3yOkMdftGW24OGux3R9ixDnk2bnpdJTOeq8pCOzZNLH8dRuDnNlqqD8gHgiDfkNouta
 Jz35FrOPHxPh/gg5Y8WG3vIRvG6jyxy7M4hEo/RXrk5Ejf7UcVikrtdjbbMt61G01paU
 KL6Q==
X-Gm-Message-State: AOJu0Yx6OCEdmpZ1Wph4F++Z4Ii+ijiuD7eWw6gI76twTtP12M1F4b1c
 GtpmqB1DCRwzOB0sX8Prt+FFuJfm0tqOtvve9Z62TOmXWFfLcQlePzcb7m97MKj9E4M=
X-Gm-Gg: AeBDieu5eqx9iGXZgfy2Y/NbHmzoOG2d29Vbhh21lpxW9RJDCn2jkOrIgk/5sVhRCBZ
 aw2N8Y9p0O7pBXdi843sNzldpR6ZzZZAGWnBCUiUSDmB/pikx1Lhu97OBKNnk8HLxD8oN9FISKZ
 kVTTRubpCL41HS5dHHlu6ts18qWDbqfItcpj4eGJOKwme35rYfDzPoUbLVSYXYfuTiEfGa6aPiV
 hXvo7L+reDpkQiPImtYqOY/e2Ny793OECYweociLwSViyAzC6j2/1IcpEKMaL5nrZ46b6w7jcQD
 MW19SqY1JyhONiJYXrJWPQT1PrSMZulKYKA2m9hj/Zqcdgkc1gV29MSqk7g8qBISoBlIeO9JWU1
 LmahwHVIi5/GGJq0pRO5Tur2RjhZU6o059+LUYJDYu1M394Py5knCbQ9tf4jblS048kFDr1Hgo/
 eAD2eLOLph7QJVxVoLLMPmLd7U/9nOMivI50VgJQHSF2q7pp9ByFqPcLf1JW4CHUFBlbQqp7w79
 I/kAcAqDJc=
X-Received: by 2002:a17:903:1a30:b0:2b0:c90f:449b with SMTP id
 d9443c01a7336-2b2817d8a15mr129536815ad.10.1775485471387; 
 Mon, 06 Apr 2026 07:24:31 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1866070-ipxg00f01sizuokaden.shizuoka.ocn.ne.jp. [180.1.30.70])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156885295ad.29.2026.04.06.07.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:24:30 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v2 2/5] m68k: Fix writew(), writel(), readw(),
 readl() endianness
Date: Mon,  6 Apr 2026 23:24:08 +0900
Message-ID: <20260406142411.2992618-3-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406142411.2992618-1-daniel@thingy.jp>
References: <20260406142411.2992618-1-daniel@thingy.jp>
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

In Linux these are meant to read a little-endian value and swap
to the CPU endian.

In u-boot for m68k this is currently borken and prevents
virtio-mmio from functioning.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 arch/m68k/include/asm/io.h | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/m68k/include/asm/io.h b/arch/m68k/include/asm/io.h
index 35ad4a1c0444..f4877b0446cf 100644
--- a/arch/m68k/include/asm/io.h
+++ b/arch/m68k/include/asm/io.h
@@ -24,18 +24,11 @@
 #define __raw_writel(l,addr) ((*(volatile u32 *) (addr)) = (l))
 
 #define readb(addr)		in_8((volatile u8 *)(addr))
-#define writeb(b,addr)		out_8((volatile u8 *)(addr), (b))
-#if !defined(__BIG_ENDIAN)
-#define readw(addr)		(*(volatile u16 *) (addr))
-#define readl(addr)		(*(volatile u32 *) (addr))
-#define writew(b,addr)		((*(volatile u16 *) (addr)) = (b))
-#define writel(b,addr)		((*(volatile u32 *) (addr)) = (b))
-#else
-#define readw(addr)		in_be16((volatile u16 *)(addr))
-#define readl(addr)		in_be32((volatile u32 *)(addr))
-#define writew(b,addr)		out_be16((volatile u16 *)(addr),(b))
-#define writel(b,addr)		out_be32((volatile u32 *)(addr),(b))
-#endif
+#define writeb(b, addr)		out_8((volatile u8 *)(addr), (b))
+#define readw(addr)		in_le16((volatile u16 *)(addr))
+#define readl(addr)		in_le32((volatile u32 *)(addr))
+#define writew(b, addr)		out_le16((volatile u16 *)(addr), (b))
+#define writel(b, addr)		out_le32((volatile u32 *)(addr), (b))
 
 /*
  * The insw/outsw/insl/outsl macros don't do byte-swapping.
-- 
2.51.0

