Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF8AD42B85
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA1A589442;
	Tue, 12 Nov 2024 14:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mv1Odh70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2C758942F; Tue, 12 Nov 2024 14:59:55 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F3678944F
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-83e190085d7so124862139f.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419991; x=1732024791; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oS6rCsOsaiHSCiFYXlhxeTxsiILRGAyhz08iiAkhu8c=;
 b=Mv1Odh70WQdNZ7QJe0CWdJjt2WtP5urTDJj5ccwsRwgveYuqcLm2p4X33BMmr9OaJ+
 BXgOXUCIYa9XAcZo25GZnknvcl+0bCQ0Uwr/nEOdF3KktOr/nBhMzr6WaSvleEwL7LAW
 XNqPyIjl38wiOgUxFamk9KhJdeADaYdAgn3rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419991; x=1732024791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oS6rCsOsaiHSCiFYXlhxeTxsiILRGAyhz08iiAkhu8c=;
 b=Ac1nL9S7bDcsU4Wl70nTDt7mq/V5tmHhVMfPEpxOs7P5atKd4jqc1cWiUuBscYpXvq
 LrvXjiFHkROGXOAIz8eOChbsWUt17rjfU1seM8NA8rPkoj54zD1gwB0rZDg76JojdNP1
 jez3NJzNK64LXTJy6BvbhjQ7fPnyRajBtwgwPE1PwOY9Qv3HIVJD7MLhyXXNCSoxseyx
 W1U5pe4IitW4tWh0vVx40DOsmHrDLFeoCHLu85Gj+TbiJFa4FaJNC7VIut3P0Im7Jiqb
 U+cMlZWgz0Mf/BeX7HfiCl0YbvCc2WeO2bITgb75ny82L6LEisD8TZkplQn0DVvj3pa2
 MOeQ==
X-Gm-Message-State: AOJu0Yzv5evt9xu9N9GU8Dv8Q9Gdid3JR2L3owrSRawW42mQqVWAaqP0
 fgIw4PC4blxbAxHwbjTveH0tOkzjTEuxxpPlKV603olLXlSvhyEEWBhChLH2MdoUE4qjzGfPpHA
 =
X-Google-Smtp-Source: AGHT+IHt59Sj5MpK2rcv7U4mx/Oxk9nOXjyfVXcP+uZWJhmAIQsHdGNO5FRSY1f3ftH+iR0zuPVpmw==
X-Received: by 2002:a05:6602:2d91:b0:81f:75bf:6570 with SMTP id
 ca18e2360f4ac-83e0329dc3dmr1900238639f.5.1731419991172; 
 Tue, 12 Nov 2024 05:59:51 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/18] x86: Use defines for the cache flags
Date: Tue, 12 Nov 2024 06:59:04 -0700
Message-Id: <20241112135911.630586-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
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

Use some named flags when setting up the cache, so it is easier to see
what is going on.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/i386/cpu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index 3bbad3b2eca..845e00ca439 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -592,6 +592,13 @@ int cpu_has_64bit(void)
 #define PAGETABLE_BASE		0x80000
 #define PAGETABLE_SIZE		(6 * 4096)
 
+#define _PRES BIT(0)	/* present */
+#define _RW   BIT(1)	/* write allowed */
+#define _US   BIT(2)	/* user-access allowed */
+#define _A    BIT(5)	/* has been accessed */
+#define _D    BIT(6)	/* has been written to */
+#define _PS   BIT(7)	/* indicates 2MB page size here */
+
 /**
  * build_pagetable() - build a flat 4GiB page table structure for 64-bti mode
  *
@@ -604,15 +611,17 @@ static void build_pagetable(uint32_t *pgtable)
 	memset(pgtable, '\0', PAGETABLE_SIZE);
 
 	/* Level 4 needs a single entry */
-	pgtable[0] = (ulong)&pgtable[1024] + 7;
+	pgtable[0] = (ulong)&pgtable[1024] + _PRES + _RW + _US + _A;
 
 	/* Level 3 has one 64-bit entry for each GiB of memory */
 	for (i = 0; i < 4; i++)
-		pgtable[1024 + i * 2] = (ulong)&pgtable[2048] + 0x1000 * i + 7;
+		pgtable[1024 + i * 2] = (ulong)&pgtable[2048] + 0x1000 * i +
+			_PRES + _RW + _US + _A;
 
 	/* Level 2 has 2048 64-bit entries, each repesenting 2MiB */
 	for (i = 0; i < 2048; i++)
-		pgtable[2048 + i * 2] = 0x183 + (i << 21UL);
+		pgtable[2048 + i * 2] = _PRES + _RW + _US + _PS + _A +  _D +
+					 (i << 21UL);
 }
 
 int cpu_jump_to_64bit(ulong setup_base, ulong target)
-- 
2.34.1

