Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8D0C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 07:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CED7488574;
	Tue, 23 Apr 2024 09:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ToqHeMn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3551E88573; Tue, 23 Apr 2024 09:22:39 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C6248895C
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 09:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ed20fb620fso4427224b3a.2
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 00:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713856955; x=1714461755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkm53GyywzEErLCI4DUqGxywrgz4Z2QJvhViMOcNkvo=;
 b=ToqHeMn96+V7HkeW8WLGRiW4JU3ud79lGaJCW+Ss3RR8AtT0SBwQsZnb0FO8WUQwYl
 29sIRK2Ul2Foicx8280QFlo3Vy/FRxa/99kDE6Yx+V7YjWvImpc0OYyKD7Fwu0m2Zjtx
 1Mf0r26SkVCaMPrKdtLMFGXrjoDv5LfEdSjzMIBzP+ihAqLMvUcE/JpQwwSG1RKxmZQ0
 4eXvuTytkVzG7aBwYO0DrQby9SHx+Jz9ZmuePdqVZK8jy+kN4TOLnwRdWwBjWxewTkVj
 rIKtmoqljnQU60/Aqd9IQyFRqCRT16+WG4uYKwgnB9Mci7+qG5B1COQMyLlyzjEH1YpZ
 3MZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713856955; x=1714461755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkm53GyywzEErLCI4DUqGxywrgz4Z2QJvhViMOcNkvo=;
 b=SU9B6Xneu4SikrFMDwOuZr9ZSXy3W06qcZzroYz0y5Z2l+7J3LYldyj/tyOkvO3pmt
 FhC1sFyMXuIEmYRvbnuuE+WATrJfphb7Negyi+ZHS1N5rrS/gmhQzmKe2i3+H0hXLbU9
 4fQQMpcHMVQCnBd/Z9RDfpxWnCQJFU/XNIKpGbY9PdxA3e2VEeteQwv323Deog9ROvq2
 PpDZ2AEmCX4Ilv9kobeJMrftLdR+5QR3gLTpbR61DR8/tgi4goKzhWi9FBEvNwO0c/+w
 qYf2KUAZgKhXzwEx7rvj4MTqcMkbzpIEFFRL+aAnzkHAIPU3j+ZKf2txLArBY5rnjTnx
 s2tw==
X-Gm-Message-State: AOJu0YylgYoSVl23d56uabHs48wwT5+UG9HinObJrGCJpeRc5kTtKk5m
 257dwMZUzKLr0cjIXdUoLsVimHy6bfWE/mYxbadRxgc3cpX5WPIYFUH4T7Uf
X-Google-Smtp-Source: AGHT+IHdeaTVin+y9cEgyoRBx9pDzZIJ87OmNcS50D99h+8eavNrvMj+5m7Y5EbZ0FO4EWLkW6J9iw==
X-Received: by 2002:a05:6a00:2295:b0:6ec:fd67:a27e with SMTP id
 f21-20020a056a00229500b006ecfd67a27emr15430195pfe.1.1713856955514; 
 Tue, 23 Apr 2024 00:22:35 -0700 (PDT)
Received: from localhost.localdomain ([180.217.143.235])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a634c11000000b005f0793db2ebsm8746695pga.74.2024.04.23.00.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 00:22:34 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: YSCHU@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 KWLIU@nuvoton.com, JJLIU0@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/3] board: arbel: Limit the dram effective size to bank0
 maximal size
Date: Tue, 23 Apr 2024 15:22:10 +0800
Message-Id: <20240423072210.1926141-4-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423072210.1926141-1-JJLIU0@nuvoton.com>
References: <20240423072210.1926141-1-JJLIU0@nuvoton.com>
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

For 4GB dram size, the dram is divided into 2 banks and
the address space of these 2 banks are not concatenated.
Limit the gd->ram_top to not exceed bank0 top to prevent
accessing invalid memory region.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 board/nuvoton/arbel_evb/arbel_evb.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_evb/arbel_evb.c
index 8fc56c1839..53c931c3c2 100644
--- a/board/nuvoton/arbel_evb/arbel_evb.c
+++ b/board/nuvoton/arbel_evb/arbel_evb.c
@@ -27,6 +27,15 @@ int board_init(void)
 	return 0;
 }
 
+phys_size_t get_effective_memsize(void)
+{
+	/* Use bank0 only */
+	if (gd->ram_size > DRAM_2GB_SIZE)
+		return DRAM_2GB_SIZE;
+
+	return gd->ram_size;
+}
+
 int dram_init(void)
 {
 	struct npcm_gcr *gcr = (struct npcm_gcr *)NPCM_GCR_BA;
@@ -70,21 +79,16 @@ int dram_init_banksize(void)
 		gd->bd->bi_dram[1].start = DRAM_4GB_SIZE;
 		gd->bd->bi_dram[1].size = DRAM_2GB_SIZE -
 			(DRAM_4GB_SIZE - DRAM_4GB_ECC_SIZE);
-		/* use bank0 only */
-		gd->ram_size = DRAM_2GB_SIZE;
 		break;
 	case DRAM_4GB_SIZE:
 		gd->bd->bi_dram[0].size = DRAM_2GB_SIZE;
 		gd->bd->bi_dram[1].start = DRAM_4GB_SIZE;
 		gd->bd->bi_dram[1].size = DRAM_2GB_SIZE;
-		/* use bank0 only */
-		gd->ram_size = DRAM_2GB_SIZE;
 		break;
 	default:
 		gd->bd->bi_dram[0].size = DRAM_1GB_SIZE;
 		gd->bd->bi_dram[1].start = 0;
 		gd->bd->bi_dram[1].size = 0;
-		gd->ram_size = DRAM_1GB_SIZE;
 		break;
 	}
 
-- 
2.25.1

