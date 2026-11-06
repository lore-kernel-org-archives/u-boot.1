Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4F606A32D
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 04:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BvL/qM6d;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CsKXfD/L
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C070B81248;
	Sat,  7 Nov 2026 04:42:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id obDihuOBLxcI; Sat,  7 Nov 2026 04:42:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9F72581335
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794026564;
	b=eQivgjGk2kY7ziUxR41G9okg1JhsMD6hpM05sPS3qV8diyEKfH3WWUI5AP4IZypWmAak
	 mn/pW9N/MPX/Bla1cwAB+l1xHuPq3fiSzKEbgJSvQu77GCjza42L4BlH+EPoWBDWdCf81
	 +6JpJONMYmXDxdVnq1TxCgDqW0Snvl920Q0afrZzX39vRdloNpaFkrPOuqCOWpwJvB1K+
	 mB4qVRkmT4a30EeOFsDyUCnhG6pq8mfPNrwrPS9uusdaE541I+dOUIaz+Zyczni5DTVk6
	 sPI6AJ+qjTH97Re4GEXexTks2RWe3Z13N1Lf66jbnPkzkA/hnZjZJ19Qy2mZ9yLDxOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794026564;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Hty3GSQD/nj+14HYwsuPJQqiS56/qyKFy7VEio7520Y=;
	b=RhaJ7WZbCGRvTKIIbZwkn2MKNi8eGAkwV5E93A5wC5FWHp3nidsCPpdx7IImnxW8+3nE
	 pB7yuHamMB9beO7oZteGvvxNV9s9bLJgu01l4uv/q6u3NzYXKfiIozXQkCxe4zih+MNkr
	 vPYqAcOpPepZtr4U2pLagUCNPRES0B5AuKKbP74sOUhCGmDh93BkMmWBx+hdKLFAgYlni
	 PEPcX+mkntWhCdC4Xw9IIwogYNluib5qxJD77vuAKRdNEI38IANe8LTmTfx7p5KH5lT3t
	 pSDvL7KTuZI/P3V6ZuclpDEb02zAnNrBecPn7ZbrMM/xIifObrbQOkGKiARCEH4vLBg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794026564;
	bh=Hty3GSQD/nj+14HYwsuPJQqiS56/qyKFy7VEio7520Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BvL/qM6d6AscdBnXxC2RK+eC7Zepfg/leyJlGXStOxMfh1hw0HeK2op2E7srg+Z1x
	 A8VKGjBwwE+0Jez7ueEDb8gUFx82T6SDqQLrCT8va7yclNXqnN+midOMp0O1ExRFHg
	 yyrUpD+cR5po5aYvCRDU68PS/zjQJEDstpgL5lz0YqQiiKLAlyz0uNZwxCOcnvI2jF
	 xWzndfA7lCeKlUrosb2p+prHTkuYqarTvdg0XCNKt8KiV3HxPNSytl2t41j2v91TnJ
	 DM1RnxBGOSOi2gghgzXuWV8Bln3iAsiv+5/JDh8EBWaZZRFlXlt4evUJzPsYhzsWdS
	 OkCC7yoVl9wng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F72581335;
	Sat,  7 Nov 2026 04:42:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B7652E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 10F8C409A5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:15:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4xceoIBmdVWi for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:15:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3C74540907
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92d; helo=mail-ua1-x92d.google.com;
 envelope-from=mateuslima.ti@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=CsKXfD/L
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C74540907
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:15:52 +0000 (UTC)
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-99ac154431bso204262241.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793999752; x=1794604552;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hty3GSQD/nj+14HYwsuPJQqiS56/qyKFy7VEio7520Y=;
 b=CsKXfD/Lku8BVe/WAtez+1iMx1hGqzFEnD3Iw9oGpOXqHLEKqo5jpCbllSMTXQ2/S5
 Y+3QgGyN3i+1StvfLK1OL/ludyWfuHxj1r/OTUvf38eKf6RrjizDrhNbX+rf0g7H0CZK
 JEQFHXqPDwLqmrv7VYGXyar0kfjiqyKRlc4aseeruJ18Vhnw1I7ITTchI9PTmGIzWj8q
 eTX99tKTEjnBW0IIUsG1+4L9mImIqafp3nw9W1szorHyhKCnpk1SxOC2m0LQ7IF1UoL/
 8aAmPfOFLfo49VTCSsm01OMCJcAYn+menTEOFhzXIc/KEMdC+hkpMauS+sZ7On22yP2f
 wfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793999752; x=1794604552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hty3GSQD/nj+14HYwsuPJQqiS56/qyKFy7VEio7520Y=;
 b=K110jCLmqr8BAy+Wi+zCWckX0Ca3LxcTsz1LlnKYkEj4CxGMYjWb/0qndbJ0QSLUwe
 cWEnPdAw7nPEF7s4KAw7NnhNxaZfiMeSW80sJjHbvyLqL/GjFhHHmTH+vQqk5EIt/H9g
 0elbamNiHRyJKdWIuon9y6MOmLAW8h3T9aI9OoVrfGMI2q1FOm3FN1HhbW3uEPwYFK0a
 GhmhUWuQSzy8HUg/Lw2G/QFb3xkRqI1si/B9FIxie4sCNPnihFkA+CL8tYShBk5MtsfG
 X0wor1JvV77IkgFu0VwHiNxqen0MvoGPKf7o7V/BcFSiNZcDExldgovRVbMD250tJ7ot
 LD9g==
X-Gm-Message-State: APuU4Z++FwJWoGr4fvJ+AUdmmanG+vCJ+YKiW4Y0YglZu4gEqV7ozXWP
 VkzhHjifS74TNfV02YlKzZahI0/lyPP61e1QPffjh71xgNIWwpJRPuDVtKa9JR32
X-Gm-Gg: AYBFou1vFMZRS7e88OFJHtVq5IR2fctAI5moNTX4vU3hha+Muh/ICCO7tidRfYR1E/A
 XFhKXcE0yx4e2hzF8XZZ2fTFfByqwRQL178sVqsH/SMsfBU9XdJGWwnPBQ6do2LEmzoHxL2dWBq
 JI5hvbpOuHznEvKIE1te7A4loAMZO45TEZp7Z34JL0J9mlPZ5xyHXeJJYK1+Soj/aRQuPddyToI
 kpi1VAl8DTWkRORXaR1w/+Y/6kFN60Jnyf7qIF/hPfm5gHonnTV51bsyXw+2MUmjWlvRlvQRAIq
 wYaDeY8a8ETjBB0KRmDNhSR6fVlXm2v2z1wTGQt3BachNR9NKrevy3GpawBtb+ycqINPLU1Ofmn
 MyS0bQoGL9voLAib7jIYNie6miz3wYEZJa1SwCCQlg/Xcm3t4oLt8TGYijk+jPp0mTY5i+TsNgB
 Gusw230Gh/PI++86hdlM2bMhiqVqbwXGu8UkS5EAZt3LVoN92iKzoJW6QKI0o919+pBc2d3qyPo
 jxz2ifvIHaoxaikKyOnQBfjXpghTdPLQieTfnmbBdTiQCzL/q//MDkgcs9TnAdqw8ChFcd6+cw+
 EqmI4xtnfCa9pyVGvkP2DBvfiwAmQx1G5Vs3Ihj1u6LoHWdCNZRIDRYdbKlikLuEbzU=
X-Received: by 2002:a05:6102:3346:b0:7d2:754c:23e7 with SMTP id
 ada2fe7eead31-7d2a16a0823mr1911839137.35.1793999748965; 
 Fri, 06 Nov 2026 13:15:48 -0800 (PST)
Received: from mateus-laptop.. ([2804:1eb0:a0:15ff:e3:543a:df0a:607a])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99bab48acb7sm2614087241.1.2026.11.06.13.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:15:48 -0800 (PST)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Alison Wang <alison.wang@nxp.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>
Subject: [PATCH v2 1/6] armv7: ls102xa: Apply erratum A-008850 on all LS1021A
 boards
Date: Fri,  6 Nov 2026 18:15:33 -0300
Message-ID: <7333bc8fbf197209f42cdac3d1003519f42854ef.1793999703.git.mateuslima.ti@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793999703.git.mateuslima.ti@gmail.com>
References: <cover.1793999703.git.mateuslima.ti@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 04:42:41 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit f9147d636ce2 ("Convert CONFIG_CHIP_SELECTS_PER_CTRL to Kconfig")
made SYS_FSL_ERRATUM_A008850 depend on SYS_FSL_DDR, since soc.c includes
fsl_ddr_sdram.h for the DDR_EOR bits and that header needs
CONFIG_CHIP_SELECTS_PER_CTRL. The ls1021aiot and ls1021atwr boards set
up the DDR controller in ddrmc_init() and do not select SYS_FSL_DDR, so
the workaround is silently compiled out there, even though both boards
still call erratum_a008850_post() from dram_init().

Move the two DDR_EOR bits next to struct ccsr_ddr in fsl_immap.h, drop
the fsl_ddr_sdram.h include from soc.c and select the erratum again for
all LS1021A boards.

Fixes: f9147d636ce2 ("Convert CONFIG_CHIP_SELECTS_PER_CTRL to Kconfig")
Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Alison Wang <alison.wang@nxp.com>

Changes in v2:
- Rebase on main, no other changes
---
 arch/arm/cpu/armv7/ls102xa/Kconfig | 2 +-
 arch/arm/cpu/armv7/ls102xa/soc.c   | 3 ---
 include/fsl_ddr_sdram.h            | 4 ----
 include/fsl_immap.h                | 4 ++++
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/cpu/armv7/ls102xa/Kconfig b/arch/arm/cpu/armv7/ls102xa/Kconfig
index 9ce94555ed0..70170e735be 100644
--- a/arch/arm/cpu/armv7/ls102xa/Kconfig
+++ b/arch/arm/cpu/armv7/ls102xa/Kconfig
@@ -9,7 +9,7 @@ config ARCH_LS1021A
 	select SYS_FSL_IFC_BE
 	select SYS_FSL_ERRATUM_A008378
 	select SYS_FSL_ERRATUM_A008407
-	select SYS_FSL_ERRATUM_A008850 if SYS_FSL_DDR
+	select SYS_FSL_ERRATUM_A008850
 	select SYS_FSL_ERRATUM_A008997 if USB
 	select SYS_FSL_ERRATUM_A009008 if USB
 	select SYS_FSL_ERRATUM_A009663
diff --git a/arch/arm/cpu/armv7/ls102xa/soc.c b/arch/arm/cpu/armv7/ls102xa/soc.c
index 7ff59edd452..60f63da73f8 100644
--- a/arch/arm/cpu/armv7/ls102xa/soc.c
+++ b/arch/arm/cpu/armv7/ls102xa/soc.c
@@ -12,9 +12,6 @@
 #include <asm/arch/ls102xa_soc.h>
 #include <asm/arch/ls102xa_stream_id.h>
 #include <fsl_csu.h>
-#ifdef CONFIG_SYS_FSL_ERRATUM_A008850
-#include <fsl_ddr_sdram.h>
-#endif
 
 struct liodn_id_table sec_liodn_tbl[] = {
 	SET_SEC_JR_LIODN_ENTRY(0, 0x10, 0x10),
diff --git a/include/fsl_ddr_sdram.h b/include/fsl_ddr_sdram.h
index 182f5836533..650bfc29b49 100644
--- a/include/fsl_ddr_sdram.h
+++ b/include/fsl_ddr_sdram.h
@@ -146,10 +146,6 @@ typedef struct ddr4_spd_eeprom_s generic_spd_eeprom_t;
 #define WR_DATA_DELAY_SHIFT	10
 #endif
 
-/* DDR_EOR register */
-#define DDR_EOR_RD_REOD_DIS	0x07000000
-#define DDR_EOR_WD_REOD_DIS	0x00100000
-
 /* DDR_MD_CNTL */
 #define MD_CNTL_MD_EN		0x80000000
 #define MD_CNTL_CS_SEL_CS0	0x00000000
diff --git a/include/fsl_immap.h b/include/fsl_immap.h
index 54d6e0ab377..759a484a926 100644
--- a/include/fsl_immap.h
+++ b/include/fsl_immap.h
@@ -136,6 +136,10 @@ struct ccsr_ddr {
 	u32     debug[64];		/* debug_1 to debug_64 */
 };
 
+/* DDR_EOR register */
+#define DDR_EOR_RD_REOD_DIS	0x07000000
+#define DDR_EOR_WD_REOD_DIS	0x00100000
+
 #ifdef CONFIG_SYS_FSL_HAS_CCI400
 #define CCI400_CTRLORD_TERM_BARRIER	0x00000008
 #define CCI400_CTRLORD_EN_BARRIER	0
-- 
2.43.0

