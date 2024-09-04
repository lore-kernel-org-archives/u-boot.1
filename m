Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C265ACD4844
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 02:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3748688C63;
	Wed,  4 Sep 2024 04:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F8P2rYgh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71AA988AE8; Wed,  4 Sep 2024 04:43:29 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE2188C86
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 04:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7b8884631c4so2482021a12.2
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 19:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725417806; x=1726022606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlGWsJIdrdUK7KWwTokA2y2oXKg8dIjW/dS4UPVeRHM=;
 b=F8P2rYghqjfJ2qDmV5xj/BSdP52GWH8UrOAALRN+VKBQKbH342E1Cll5Yevp9ERJRt
 bxMEFQBF9/ctHMcSjMO9HOTcHE/TWqH97GDz6QM9G8QLOSEW95cDfP+0lphRhULXFvvU
 9fWD18dpLLZ07KRSS+t+8oz1BOjLbBVaijW4+uIQbhRv6kcO33//ckm2ET5rlPKK/c36
 XryX814FunHFEfeBefikjFfHT7uBCGCcHqDxn5h9oWOdKXZYD6t8UYzInUYFl89OrMGq
 Wt/U8Sjqz/UvOt4B2F1V+I7h4cagUwDT2reup5BpRn3bgz0Tlm2ZobEom/Y3Rl3m7vEk
 Z+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725417806; x=1726022606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WlGWsJIdrdUK7KWwTokA2y2oXKg8dIjW/dS4UPVeRHM=;
 b=bDxjz3pgqKISngAELgFgiSHSL9fk/4WZ5hj7r0uFtY4CVmy2F9kTatQ2kiGDZTqpCm
 paEBgRjFfsLU+uCh86j3SfqloZ48LS9ozeATMbXIPbzQOdchYD5O4J7hqIz+81d1Xp4M
 Ybb+bMuudNktz/38jT/q2KtfsJsqwd8ekX/WFkElSh+57UzFrKULMCaOmXuO0MJ6qjez
 xR6+teUUGEuOfrnjAA49F+zJBelzb+xQOz1KxghoEhkIwebRiRMRd3NVWfq77WMRy5bB
 w+q0QSRTbcN0v3RSbl087yV3Q+jWx/k5E8rSgDRzdZE4AzDR5kDS+QHklMPeD8BFZVAc
 2HxQ==
X-Gm-Message-State: AOJu0Yxxo3ugDzfGl7IdXnXQInGxGk8H+Eil8fh1Nit3QQdESBCg5P2/
 HL0zwu/vfNSeXpG5fLwjfJvk/DgGiDCBnN04VjseTKv4bb4ZvttKvVgLPbe6
X-Google-Smtp-Source: AGHT+IHZKL6CU1u3NU7sBVwMkuh+jEmUanGyrmF7Pcyig+lQxLaktQ3CpLEF9qSrVXeLEz9nvd+yog==
X-Received: by 2002:a17:90b:3e89:b0:2da:6a4d:53a6 with SMTP id
 98e67ed59e1d1-2da748855c4mr3422875a91.19.1725417805706; 
 Tue, 03 Sep 2024 19:43:25 -0700 (PDT)
Received: from cs20-buildserver.. ([180.217.139.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2da7ba49b57sm1141829a91.18.2024.09.03.19.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 19:43:25 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	trini@konsulko.com,
	jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/3] board: arbel: correct the dram bank size
Date: Wed,  4 Sep 2024 10:41:04 +0800
Message-Id: <20240904024106.2030437-2-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904024106.2030437-1-JJLIU0@nuvoton.com>
References: <20240904024106.2030437-1-JJLIU0@nuvoton.com>
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

If CONFIG_SYS_MEM_TOP_HIDE is defined, gd->ram_size is reduced by
CONFIG_SYS_MEM_TOP_HIDE. Need to correct the actual ram size in
dram_init_banksize.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 board/nuvoton/arbel_evb/arbel_evb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_evb/arbel_evb.c
index 1f519219e7..55e93a77f0 100644
--- a/board/nuvoton/arbel_evb/arbel_evb.c
+++ b/board/nuvoton/arbel_evb/arbel_evb.c
@@ -59,17 +59,21 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
+	phys_size_t ram_size = gd->ram_size;
 
 	gd->bd->bi_dram[0].start = 0;
 
-	switch (gd->ram_size) {
+	#if defined(CONFIG_SYS_MEM_TOP_HIDE)
+		ram_size += CONFIG_SYS_MEM_TOP_HIDE;
+	#endif
+	switch (ram_size) {
 	case DRAM_512MB_ECC_SIZE:
 	case DRAM_512MB_SIZE:
 	case DRAM_1GB_ECC_SIZE:
 	case DRAM_1GB_SIZE:
 	case DRAM_2GB_ECC_SIZE:
 	case DRAM_2GB_SIZE:
-		gd->bd->bi_dram[0].size = gd->ram_size;
+		gd->bd->bi_dram[0].size = ram_size;
 		gd->bd->bi_dram[1].start = 0;
 		gd->bd->bi_dram[1].size = 0;
 		break;
-- 
2.34.1

