Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136CCC25B6B
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 00:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F0587BCF;
	Fri, 27 Oct 2023 02:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T3nmdZWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02AA287BD2; Fri, 27 Oct 2023 02:24:44 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 303A287BC6
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 02:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-27d8e2ac2b1so1182118a91.2
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 17:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698366279; x=1698971079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vUvRWsxU4YS3GV0CbbN4wHN3r8u01+N/KxViWdot4l8=;
 b=T3nmdZWxKieVCnQ2JA4k97DQfH3IQ/woen0ZdUKRkc9OYJlcfVDw+y6D5oTw5QZRZs
 H/unicJyIghZbgSu57wNlLWdSp5l2gmuubrWuhF8IHPU6zf5vFlNBaDPAfstQ/Njw+MA
 jJhAnytZp16hgEg7gBNbyqAgFF3dwmDHMD+q5MZb7LQ3QfKDNIP/21ggH4Q447xDBvPB
 pKROWTKQQTMPNuOP7lP+jaSjiMxkVSa9YABAngyjOZyNpx8qkE4gF6k7kdDt8qwaheOr
 eP0MgJL6iJO+Dfjs3FJ6VZs7nlrog92f8gbyTKC810knRxklLh2nmrKkfvS3zSq5EIqK
 y8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698366279; x=1698971079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vUvRWsxU4YS3GV0CbbN4wHN3r8u01+N/KxViWdot4l8=;
 b=mzzcAJF4WWTq7fHym1jV5Kog2YAb2SAXSQADxoS6UH/GZvdQE6k9ORj0SFJrehbOTN
 PtQbb6/eQbuhiYdIDtAJ7Z62bG6Q3QUON34HGKSPB/l2TfhRNnldAX7qu1HE6U1l0OcH
 ZBwJ40+4VoUadNStdx/9Pg3TnJA3RUm88rc51ZEVm7hwU9Vt8UY6lJQEkasdk4wi+PBT
 4OLTkTT1RFk2FD9d+O8nwpRvX6oe1jhxHSbZzjqYbeq6MLRNsKqLhbRG2CRGOXd02g4J
 wnymXQ743uQyqSAvTWMRtLkUTidklxCGDo48Iw+8sROj2Mp0C97T39ztr6pBaV4fCOxJ
 S2Bg==
X-Gm-Message-State: AOJu0YxoPjEfff22ImWSpUDXbRXy79f5UayqLFAGyClObeQL93tHFvLB
 VIXDxt/8o1scImJXBsa7/AM8lE8MAqe63A==
X-Google-Smtp-Source: AGHT+IHFcqkd5o0eKDfap/NJkwjhLL5aYy2LE8q2Vjxo8vIgg9UkEQuUuFvOWdkpeiSeHcUdDc19OQ==
X-Received: by 2002:a17:90a:ea09:b0:27d:1af5:3b17 with SMTP id
 w9-20020a17090aea0900b0027d1af53b17mr1099343pjy.26.1698366279120; 
 Thu, 26 Oct 2023 17:24:39 -0700 (PDT)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:b6a2:eace:f54:1956])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a031600b0027476c68cc3sm167606pje.22.2023.10.26.17.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 17:24:38 -0700 (PDT)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>, Marc Zyngier <maz@kernel.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Will Deacon <willdeacon@google.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 meitao <meitaogao@asrmicro.com>
Subject: [PATCH 1/3] Revert "armv8: enable HAFDBS for other ELx when
 FEAT_HAFDBS is present"
Date: Fri, 27 Oct 2023 13:23:52 +1300
Message-ID: <20231027002409.430285-2-judge.packham@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027002409.430285-1-judge.packham@gmail.com>
References: <20231027002409.430285-1-judge.packham@gmail.com>
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

This reverts commit c1da6fdb5c239b432440721772d993e63cfdeb20. This is
part of a series trying to make use of the arm64 hardware features for
tracking dirty pages. Unfortunately this series causes problems for the
AC5/AC5X SoCs. Having exhausted other options the consensus seems to be
reverting this series is the best course of action.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 arch/arm/cpu/armv8/cache_v8.c    |  6 +-----
 arch/arm/include/asm/armv8/mmu.h | 10 ++--------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index cb1131a0480e..4c6a1b1d6c5e 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -94,15 +94,11 @@ u64 get_tcr(u64 *pips, u64 *pva_bits)
 	if (el == 1) {
 		tcr = TCR_EL1_RSVD | (ips << 32) | TCR_EPD1_DISABLE;
 		if (gd->arch.has_hafdbs)
-			tcr |= TCR_EL1_HA | TCR_EL1_HD;
+			tcr |= TCR_HA | TCR_HD;
 	} else if (el == 2) {
 		tcr = TCR_EL2_RSVD | (ips << 16);
-		if (gd->arch.has_hafdbs)
-			tcr |= TCR_EL2_HA | TCR_EL2_HD;
 	} else {
 		tcr = TCR_EL3_RSVD | (ips << 16);
-		if (gd->arch.has_hafdbs)
-			tcr |= TCR_EL3_HA | TCR_EL3_HD;
 	}
 
 	/* PTWs cacheable, inner/outer WBWA and inner shareable */
diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
index 19a9e112a434..98a27db3166b 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -102,14 +102,8 @@
 #define TCR_TG0_16K		(2 << 14)
 #define TCR_EPD1_DISABLE	(1 << 23)
 
-#define TCR_EL1_HA		BIT(39)
-#define TCR_EL1_HD		BIT(40)
-
-#define TCR_EL2_HA		BIT(21)
-#define TCR_EL2_HD		BIT(22)
-
-#define TCR_EL3_HA		BIT(21)
-#define TCR_EL3_HD		BIT(22)
+#define TCR_HA			BIT(39)
+#define TCR_HD			BIT(40)
 
 #define TCR_EL1_RSVD		(1U << 31)
 #define TCR_EL2_RSVD		(1U << 31 | 1 << 23)
-- 
2.42.0

