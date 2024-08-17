Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F790C52D7F
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 11:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A48488533;
	Sat, 17 Aug 2024 13:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IfXWHBCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28EDC8862E; Sat, 17 Aug 2024 13:02:43 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A19C87C38
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 13:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5becfd14353so1408857a12.1
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 04:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723892560; x=1724497360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pAKKSblecRyN8eiOmRUBYdSl1cSPEtKGQC4mh+OBVv0=;
 b=IfXWHBCwaEZIMG6O6Ead1WFYAkataI/+KGtK81xYrzTjyzVr/KYputojMHq5yScjTY
 bLhup7yVs1VPqiAY5TrK9PWHVQRYZDwbHoX60NkBooyCB/W+nxYoCJw30JpLC+x+r3NB
 hCCgoel8yERAzewSNjSKaCknrH11SviHJ943BNPofLoFLmYdS1C55eFoVQKIP9Pz3w2o
 OPRvx3DNrlTdpdhiqBg24IyIt8GnXBX0v2oCNtoHxSKaM1FqRuWdQHkQLB0w+GkQek4V
 u6Dq+Ujcddbq1e5TCVrU1gUyZJUPN7WoG574jv/Itbal6yaMRezRqCFQxWvPhVruR8AL
 HzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723892560; x=1724497360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pAKKSblecRyN8eiOmRUBYdSl1cSPEtKGQC4mh+OBVv0=;
 b=a6ndS8UCM4zjnlvdL3/X9To7gVkGayypyHHdpkDQE3Cbc2QWAis0Jl1r4GalkKnb7F
 QNKav8OfLlgteDT1SfqtybOYaUCKenKOgaFEjtpHsQE9QbwjOfm+cyRyWtuTleoKfWqy
 oOjYdpZq140QPn2DrKHY+XXb/cEQO0rLt6VZ/4y6Kl61q1y21Uy78nia+ym4FMYAGPrA
 wsbfdETKpwOaykoVnxKIcMi8bjrO8pPVzByyJLAKi/wKYiIwuePfAIUhBJWLBGR6rLw/
 QJKJrcPROwaRsiXIP4F9G54DYlBcvnMWwbYa7E9Sw+2qJ9tThkOAkNCx/2L3Qj/sRrrS
 zfXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUmG6xgln/GkeQK7h8MPtFz9SPLSL25wHj7Pg+uGcjWmNFzTKgXu/YOB4B2QvHmRimq9v3YM1bpmXX1Ntull3YiARoMw==
X-Gm-Message-State: AOJu0YyFZl8rkKcrp4Ivyl1tRy4Uhx7akU9ztJ9hNAMltROTm7S7dI1j
 FcCovw+YbWavWCLlrTmVmzAEcMpa4to3ZsFrkTYajQuQKUlHqoij
X-Google-Smtp-Source: AGHT+IFOw4unULLUZ/5M+JyNd+L6kvWK4Qg22A4cKegJhr74IYsjIatnZAfL9iTTI+l3rbL6uK9wwA==
X-Received: by 2002:a17:906:d7d3:b0:a7d:3de1:4abd with SMTP id
 a640c23a62f3a-a8392940e37mr376510766b.39.1723892559994; 
 Sat, 17 Aug 2024 04:02:39 -0700 (PDT)
Received: from localhost.localdomain (109-252-15-116.nat.spd-mgts.ru.
 [109.252.15.116]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839356efsm387363366b.135.2024.08.17.04.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Aug 2024 04:02:39 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: trini@konsulko.com, u-boot@lists.denx.de, sjg@chromium.org,
 xypron.glpk@gmx.de
Cc: Maxim.Moskalets@kaspersky.com,
	Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH] lib: move phdr increment to for loop heading
Date: Sat, 17 Aug 2024 14:02:22 +0300
Message-Id: <20240817110222.31415-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
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

Shifting this pointer in the loop will be more logical when working
with the code later, because you can see at a glance what exactly
changes at each iteration. Moreover, the code remains equivalent
because this variable is not used after the loop.

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
---
 lib/elf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/elf.c b/lib/elf.c
index dc13935e103..205724b71dc 100644
--- a/lib/elf.c
+++ b/lib/elf.c
@@ -86,7 +86,7 @@ unsigned long load_elf64_image_phdr(unsigned long addr)
 	phdr = (Elf64_Phdr *)(addr + (ulong)ehdr->e_phoff);
 
 	/* Load each program header */
-	for (i = 0; i < ehdr->e_phnum; ++i) {
+	for (i = 0; i < ehdr->e_phnum; ++i, ++phdr) {
 		void *dst = (void *)(ulong)phdr->p_paddr;
 		void *src = (void *)addr + phdr->p_offset;
 
@@ -99,7 +99,6 @@ unsigned long load_elf64_image_phdr(unsigned long addr)
 			       phdr->p_memsz - phdr->p_filesz);
 		flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
 			    roundup(phdr->p_memsz, ARCH_DMA_MINALIGN));
-		++phdr;
 	}
 
 	if (ehdr->e_machine == EM_PPC64 && (ehdr->e_flags &
@@ -201,7 +200,7 @@ unsigned long load_elf_image_phdr(unsigned long addr)
 	phdr = (Elf32_Phdr *)(addr + ehdr->e_phoff);
 
 	/* Load each program header */
-	for (i = 0; i < ehdr->e_phnum; ++i) {
+	for (i = 0; i < ehdr->e_phnum; ++i, ++phdr) {
 		void *dst = (void *)(uintptr_t)phdr->p_paddr;
 		void *src = (void *)addr + phdr->p_offset;
 
@@ -214,7 +213,6 @@ unsigned long load_elf_image_phdr(unsigned long addr)
 			       phdr->p_memsz - phdr->p_filesz);
 		flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
 			    roundup(phdr->p_memsz, ARCH_DMA_MINALIGN));
-		++phdr;
 	}
 
 	return ehdr->e_entry;
-- 
2.39.2

