Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52F0C52D7C
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 11:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE3A088677;
	Sun, 11 Aug 2024 13:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="A35Kq/KK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8344F881BA; Sun, 11 Aug 2024 13:01:23 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96FB7885C5
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 13:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D80AE401AC
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723374077;
 bh=Oval9tyHnY/1xGNWJgiykGFFKsB+sLh1aczU0qyIuMI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=A35Kq/KKD6EceJno1Zt/G0HUETu4wNS6flBSPvtcoHGRoOjypashn8BI9IKMe5G6e
 smRBq5kBlzR2DD31BvtPshCJ0vUyl8+bgRCOzSi17wf8uiPrMWuMiOxua63jDJnz0b
 +oA0H6fucaX/4bvcy4ZH2P67+8d0xw5TAmFs0v6negoaGbDz1mNFMY4Fw80l5JBPwy
 j+9Qu1shW5fDpbPcZrPSIhZygkgRiZQ54yWW9yzq32wsuDMX/kv1THR/XStaZq2ohB
 tB3m9uyuKhGu1oDuU/BXN4OK8iRC8pcpGzi5lk8Tct3svwfDQaw7pzH0PBPTZs97NA
 sLwdYXmmITzMw==
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2f1752568cfso41223941fa.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 04:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723374076; x=1723978876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oval9tyHnY/1xGNWJgiykGFFKsB+sLh1aczU0qyIuMI=;
 b=q0DVaV43JXZgLsaNYn3I8n5Uby20KYbsoz0F1RlHRAgRUr80jJ4zsRsNmLz/x2Dv3E
 u3SO0FsfkL4X2GuzO33CGT/KAre8aIJ5RiWeUlUrt027xXF4Pmg/fbOtHnO4705iC3tJ
 7D/zFGXBu/SR3bsCJcGiCZEGbIUAIMJGUIeQl2Ibcnne1KA66OGI36dvVoEWtUj0g7/y
 3t9VoGL6lrGRMMwyZc9aeaWUNEBF8RkC8HrpYGqHYtEl99xQzVB027XKg95qE2edoko7
 1WFQGz3f6zC5wm+wi+rjBFUdxn6ontEjg1fL5+1mgU4Ezhdk6HTRsIC56W1r0ZNedw50
 HX3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZIFR8kIvEsaROBTZ5mwdWXAn93pDamPo8mZSYNAwchWSPL6K74OrxsPSfAXaqfqZdudDpqFZsP1LDf0886eGYOBlzgw==
X-Gm-Message-State: AOJu0YyE+T8/Itgk1WDpsNUejkxtB646XtDR4XRCRLJbFELaEarmG6B0
 WsAOBGBMNXIUbR62L2h/6678JrWfCIvCKg8ftmPuE/vsO6HN8JYeSgpNoonMdE/P0ktZbabcpCn
 +taM476qzP3wOixmze/eqDq4i7SAckX7qUarwsg1S48R+OdVyoFruXZ5PDgbHRvsSunE=
X-Received: by 2002:a2e:a587:0:b0:2ef:22a4:6415 with SMTP id
 38308e7fff4ca-2f1a6d269a2mr54843201fa.28.1723374076158; 
 Sun, 11 Aug 2024 04:01:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKp2koRnOKLozKwyDef8J0uj3B7MGUsNRG679h1rtwG2mq68Uk3wkvtDlPlqJTEpjaz4jLTA==
X-Received: by 2002:a2e:a587:0:b0:2ef:22a4:6415 with SMTP id
 38308e7fff4ca-2f1a6d269a2mr54842791fa.28.1723374075345; 
 Sun, 11 Aug 2024 04:01:15 -0700 (PDT)
Received: from localhost.localdomain
 (ip-178-202-041-098.um47.pools.vodafone-ip.de. [178.202.41.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4cfee31fsm4604568f8f.47.2024.08.11.04.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 04:01:14 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Randolph <randolph@andestech.com>, Michal Simek <michal.simek@amd.com>,
 =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Samuel Holland <samuel@sholland.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] riscv: allow to enable SHOW_REGS in main U-Boot only
Date: Sun, 11 Aug 2024 13:01:03 +0200
Message-ID: <20240811110104.143714-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240811110104.143714-1-heinrich.schuchardt@canonical.com>
References: <20240811110104.143714-1-heinrich.schuchardt@canonical.com>
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

To minimize SPL size it is reasonable to disable SHOW_REGS. For main U-Boot
the size restrictions are much more relaxed.

* Provide separate Kconfig symbols for SPL and main U-Boot.
* Add a help text.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/Kconfig          | 12 ++++++++++++
 arch/riscv/lib/interrupts.c |  7 +++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa3b016c527..66cd512b23f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -438,6 +438,18 @@ config AVAILABLE_HARTS
 
 config SHOW_REGS
 	bool "Show registers on unhandled exception"
+	help
+	  By default only the program counter and the return address register
+	  are shown in crash dumps. Enable this symbol to show all registers in
+	  main U-Boot.
+
+config SPL_SHOW_REGS
+	bool "In SPL show registers on unhandled exception"
+	depends on SPL
+	help
+	  By default only the program counter and the return address register
+	  are shown in crash dumps. Enable this symbol to show all registers in
+	  SPL.
 
 config RISCV_PRIV_1_9
 	bool "Use version 1.9 of the RISC-V priviledged specification"
diff --git a/arch/riscv/lib/interrupts.c b/arch/riscv/lib/interrupts.c
index f9a1428a486..714cc92d03e 100644
--- a/arch/riscv/lib/interrupts.c
+++ b/arch/riscv/lib/interrupts.c
@@ -34,9 +34,8 @@ static void show_efi_loaded_images(uintptr_t epc)
 	efi_print_image_infos((void *)epc);
 }
 
-static void show_regs(struct pt_regs *regs)
+static void __maybe_unused show_regs(struct pt_regs *regs)
 {
-#ifdef CONFIG_SHOW_REGS
 	printf("\nSP:  " REG_FMT " GP:  " REG_FMT " TP:  " REG_FMT "\n",
 	       regs->sp, regs->gp, regs->tp);
 	printf("T0:  " REG_FMT " T1:  " REG_FMT " T2:  " REG_FMT "\n",
@@ -57,7 +56,6 @@ static void show_regs(struct pt_regs *regs)
 	       regs->s10, regs->s11, regs->t3);
 	printf("T4:  " REG_FMT " T5:  " REG_FMT " T6:  " REG_FMT "\n",
 	       regs->t4, regs->t5, regs->t6);
-#endif
 }
 
 static void __maybe_unused show_backtrace(struct pt_regs *regs)
@@ -157,7 +155,8 @@ static void _exit_trap(ulong code, ulong epc, ulong tval, struct pt_regs *regs)
 		printf("EPC: " REG_FMT " RA: " REG_FMT " reloc adjusted\n",
 		       epc - gd->reloc_off, regs->ra - gd->reloc_off);
 
-	show_regs(regs);
+	if (CONFIG_IS_ENABLED(SHOW_REGS))
+		show_regs(regs);
 	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
 		show_backtrace(regs);
 	show_code(epc);
-- 
2.45.2

