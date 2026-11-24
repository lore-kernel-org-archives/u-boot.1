Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82F606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DecMuV8w;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GlGpHpq/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9ED0D600C4;
	Tue, 24 Nov 2026 19:52:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2rduwKs6rrlX; Tue, 24 Nov 2026 19:52:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BA86A605E7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795549974;
	b=EoOqQEhNF7z4rVmfSPkAhY+BNFzTRSBGCDAZB6aIq1W0l3ZTVSv9/Fbn7Oe+/vG5YnXP
	 XmZNnAMqJiOz3hQbKjCvCDhEdgLkaLX34zQUfqxfO+EELKeNdFGJi00fUZHwaYERxE9+3
	 QB3hhOc8l/y6M+TGEPqN7aDyTZdPEl64J1z000f7e65n4RXaiX0/n+Z0iarsx14Uhk0Xm
	 o3WNRorQl8mReYPfm391o/n2V6Se13IRPW3yJ1bNKW5MqujtoUvmCq8xmjLrJoD7EIwyD
	 n/TuKGS7UUWeNvN8UlESN1Ddztl4snt1W61UdRoOpdbMGJFxYMgeoNvAMxRxzJ0GYWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795549974;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lB7mKKf0EiyAWBjYb60P/Y7SNMnH+C3arqjM1zdN5IY=;
	b=aMf75wTKJ58iiZSjEgZuaxKcL+GlvSK5e/l4saq0cfTqBHBBm8WYcFigHptQfchVky3f
	 C/yzyfHBK+pc9Vy+uhX90x7U/YdJVRf7R3ZGHA9fUdrMAybXH/tUl4nTD5LWzkBvHUj7c
	 rTlHYP8Sd0/7uKYRh751ZFBlZqGalxL9euygzlLqc6rEgOMox/i8S2svMKw3gY0MGXwJI
	 SZo52k9CXtt0qEHUyFGR39keCINjLUjmaGjZi8LRHKUgR8kLL/T5xN3S4gHB7V8M7Wizr
	 wY+19WfAb8lE6omNjKz48daucCasp5VgtpRJXtuyr9qXkDpleO1vBNGYljbEZbaNKjA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795549974;
	bh=lB7mKKf0EiyAWBjYb60P/Y7SNMnH+C3arqjM1zdN5IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DecMuV8wjQ1GbgKo46SzF3QK3DwbdHfVYl32eJvyLzSHlN+0BlnYr65/8AEbmajx5
	 TVfkzOJ0cK65/n1mxzeefkFdriQfaySVyFb/Kaul63FpThSKi2wQNP+GB06hjfilpR
	 +bwR1Gpa5otvMTeRe0MDE0hsiaQjZAjedvSGcnDg9P75lTr/OAP0P621TiHdMcTzsO
	 yFibAoSfYhPcsSt2ZA8+iql0uNBy7DtcSnqltTUAiNXGVzSvIsM9dFsa2AlUKvgbrm
	 yk5KQa7raAK+BDM1WomforOL7XfRDhnDKLih/UqzhC4xo16HEFuifQvwJep0f2r19Y
	 TL8/fg284gypw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA86A605E7;
	Tue, 24 Nov 2026 19:52:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C606325
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:52:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E80B403F4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:52:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yz_uSEltWvQU for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 19:52:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 62561403E4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::12b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12b; helo=mail-lf1-x12b.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=GlGpHpq/
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62561403E4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:52:51 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5be3ed646a5so6716188e87.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795549970; x=1796154770;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lB7mKKf0EiyAWBjYb60P/Y7SNMnH+C3arqjM1zdN5IY=;
 b=GlGpHpq/t72JwsG38Iub+wGRcIJzC/dCBPVLqhmDF8OZXqdzI+MusoYg8z51vqcnwn
 BuXTAqM5bEVKVEQueROcgP+8Ft69JJir1jYPXLSTxWFSZ8wRNYKTiqvA1f8X5uEDBkK4
 RHbjBmoEUQN/81DT/rG0PzPBpVuGQj3DPHs0XpN4OKJUCGxKrj1sXiaueOeFbFeR+O/2
 OThwS+yqQ0YP+gYiclXOX7HaNpKxfS2zboFH1yMYI3XtAYplbEPOdgHVU3BqV7PhIT8v
 JWH9DKyd6chTD4qBXxptqRgEWjHzcAuLFObZfttWj5JQ92ob1YqvvpCz5bs5eUrORTGt
 dJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795549970; x=1796154770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lB7mKKf0EiyAWBjYb60P/Y7SNMnH+C3arqjM1zdN5IY=;
 b=JOXwhSxrvZNbTlaXSN8s/KCg2X8xuXbY9qb07gFPBZTwtamzNr1v+M5FOYs2ar9UXN
 WPSaeIieRVuawVNTZdPfbb5o4jk11hbnwA+Pb4o6tDLlrt0X1UHsx6EKTAn9smhgO0Yt
 nwWbGdZfbH6P520dCSUm0Tg6T5PfmASZdKdwSsJpDinUM83ShiUL6qxt+LqrCwVIJ31N
 Gt8BbF2KeW/8KN+fvEmHRd574XGJioysTqDSHyjgG2LoeF+SXFUEviIsO8GleoWynNMC
 2UBM3znQJqQ2Yfw6O4Fr9bOYjdhUAy8iN4tA88tSYAJPrDktxytAnljQB/lTj2oesNZg
 U9Ew==
X-Forwarded-Encrypted: i=1;
 AL+hErHhppdpOQo7Fu90vli9VonSlhfumaDol0s9fJblZuLWuriASNO+18ChFpraFPLmkHHKdFoSfok=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+HEr20PWHZNMEWMy1GzrrasE2BlgCbkc2nJNKj3UPtkY7gEzBN
 rHWrkqOHGGpmys3waVFyunf9HxxLsbCOjVG7YPRf3kJHvd/+BONrcJOF
X-Gm-Gg: AZFdTZce7XqjH4McxJLXu/XiojT6so6/fQ39g0hWbm5Mt9N0cOY860kEzUXpdG2+ETu
 8J+DTB4khrhtkb52Fgp0tcLKbpSO9hpZR4GATvFeJUxX7gQeyLos/2DWila6vHrpqrSriwrQfrn
 T/KIwBISByaVttg8IsvBsHG9jeo6kHXMPwc5r+N1R4vBMXKXiChJVOaXc1RrmOR3LeONBBIeOW8
 NdHSnWLnk3LV1eu3eap6kNrGad6ju0yk3xplzQwPsmKojWMaUxExghSfls5fJw0fd5fgtzi9vJL
 7ELMecpAczXQ08N2uBVnMwiRkOSV7Jvo7GLczcKI7lO66tFYOgUog21lT0de+gzIJ85p3BgfkSj
 GTyI0hFKRyoRuALGCceouCi7DVGAYFSE3TRoZRoV5bgZgCumJCyq5pJOpRrzR0CAj/qXk9CvPiO
 ooFLHuerhnrCvcGWe41Jlw+TDUSvv2VMvYDBTq5Kj2T21+jPMuP9om/PSPiAAg2ikONTjco8bL6
 SZOaZsBiyRyEfRrXrBLIbxBaZTnvu5zy6XCSye/ueGB3AyWv/V8XYg53nW+Q/lrHC6J1iu6wxDh
 sqHMe0IN5qIxVgmJzl+CWDRin3A9khRBBZ3b+L4oYkUZHZBOE9k0rnwUhDcPc0/2DPY=
X-Received: by 2002:a05:6512:3d10:b0:5c0:d7c:7a1 with SMTP id
 2adb3069b0e04-5c1bc7d0f5amr5142015e87.25.1795549969739; 
 Tue, 24 Nov 2026 11:52:49 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 2adb3069b0e04-5c1bd041813sm4057216e87.53.2026.11.24.11.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:52:49 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: Tim Ouyang <tim609@andestech.com>,
	Leo Liang <leo.liang@sifive.com>
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Han Gao <gaohan@iscas.ac.cn>, Kongyang Liu <seashell11234455@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hiago De Franco <hfranco@baylibre.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot@lists.u-boot-project.org, Indrek Kruusa <indrek.kruusa@gmail.com>
Subject: [PATCH 1/4] riscv: thead: add a common header for the C9xx CSRs
Date: Tue, 24 Nov 2026 21:52:34 +0200
Message-ID: <20261124195237.692679-2-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124195237.692679-1-indrek.kruusa@gmail.com>
References: <20261124195237.692679-1-indrek.kruusa@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a header with the register numbers and bitfields currently used by the
C9xx ports. It is placed in asm/ so that both SPL and U-Boot proper can
include it. M-mode only.

Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
---
 arch/riscv/include/asm/thead_csr.h | 105 +++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 arch/riscv/include/asm/thead_csr.h

diff --git a/arch/riscv/include/asm/thead_csr.h b/arch/riscv/include/asm/thead_csr.h
new file mode 100644
index 00000000000..32d3bf773ee
--- /dev/null
+++ b/arch/riscv/include/asm/thead_csr.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
+ * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
+ *
+ * T-Head C9xx machine-mode control registers.
+ *
+ * Register numbers are shared, but the fields defined here are only those used
+ * by the in-tree ports. Availability and layout may differ between cores. Any
+ * known differences that could cause incorrect configuration are noted at the
+ * corresponding definitions.
+ */
+
+#ifndef _ASM_RISCV_THEAD_CSR_H
+#define _ASM_RISCV_THEAD_CSR_H
+
+#include <linux/bitops.h>
+
+/* M-mode control registers */
+#define CSR_MXSTATUS		0x7c0
+#define CSR_MHCR		0x7c1
+#define CSR_MCOR		0x7c2
+#define CSR_MHINT		0x7c5
+
+/* not decoded by every core */
+#define CSR_MCCR2		0x7c3
+#define CSR_MHINT2		0x7cc
+#define CSR_MHINT4		0x7ce
+#define CSR_MSMPR		0x7f3
+
+/* MXSTATUS - machine-mode status */
+#define MXSTATUS_THEADISAEE	BIT(22)	/* T-HEAD ISA extensions enable */
+#define MXSTATUS_MAEE		BIT(21)	/* MMU honours the PTE memory type */
+#define MXSTATUS_CLINTEE	BIT(17)	/* CLINT extension enable */
+#define MXSTATUS_UCME		BIT(16)	/* user-mode cache ops enable */
+#define MXSTATUS_MM		BIT(15)	/* misaligned access enable */
+
+/*
+ * MHCR - machine-mode hardware configuration
+ *
+ * WB and WBR are read-only and always read back as 1.
+ */
+#define MHCR_IE			BIT(0)	/* I-cache enable */
+#define MHCR_DE			BIT(1)	/* D-cache enable */
+#define MHCR_WA			BIT(2)	/* D-cache write allocate */
+#define MHCR_WB			BIT(3)	/* D-cache write back */
+#define MHCR_RS			BIT(4)	/* return stack enable */
+#define MHCR_BPE		BIT(5)	/* branch prediction enable */
+#define MHCR_BTB		BIT(6)	/* branch target buffer enable */
+#define MHCR_WBR		BIT(8)	/* write-back read allocate */
+
+/*
+ * MCOR - machine-mode cache operation
+ *
+ * The address is common but the encoding is not: the C906 decodes a single
+ * INV and CLR bit qualified by a cache select field, the C910 four separate
+ * invalidate bits.  The layout below is the C910's; a core whose manual
+ * documents the C906 form must not reuse these bits.
+ */
+#define MCOR_CACHE_SEL(n)	((n) << 0)	/* 1: I-cache, 2: D-cache, 3: both */
+#define MCOR_INV		BIT(4)		/* invalidate the selected caches */
+#define MCOR_BHT_INV		BIT(16)		/* branch history table */
+#define MCOR_BTB_INV		BIT(17)		/* branch target buffer */
+#define MCOR_IBP_INV		BIT(18)		/* indirect branch predictor */
+
+/* MCCR2 - machine-mode L2 cache configuration */
+#define MCCR2_RFE		BIT(0)		/* read allocate enable */
+#define MCCR2_L2EN		BIT(3)		/* L2 cache enable */
+#define MCCR2_DLNTCY(n)		((n) << 16)	/* data RAM latency */
+#define MCCR2_DSETUP		BIT(19)		/* data RAM setup time */
+#define MCCR2_TLNTCY(n)		((n) << 22)	/* tag RAM latency */
+#define MCCR2_TSETUP		BIT(25)		/* tag RAM setup time */
+#define MCCR2_IPRF(n)		((n) << 29)	/* instruction prefetch lines */
+#define MCCR2_TPRF		BIT(31)		/* tag RAM prefetch enable */
+
+/*
+ * MHINT - machine-mode implicit operation
+ *
+ * AMR selects how many consecutive stores to the same 4 KiB region make the
+ * core stop allocating cache lines for the rest of it.  It is a two-bit field
+ * on the C906 but the C910 only decodes bit 3.
+ *
+ * Some of the fields the C906 does not have also mean something else there:
+ * bit 20 is L2STPLD on the C910 and AEE on the C906, so it is left undefined
+ * until one of them needs it.
+ */
+#define MHINT_DPLD		BIT(2)		/* D-cache prefetch enable */
+#define MHINT_AMR(n)		((n) << 3)	/* write-allocate adjustment */
+#define MHINT_IPLD		BIT(8)		/* I-cache prefetch enable */
+#define MHINT_LPE		BIT(9)		/* loop prefetch enable */
+#define MHINT_DCACHE_PREF_DIST(n)	((n) << 13)	/* in 64 B lines */
+/* not decoded by every core */
+#define MHINT_L2PLD		BIT(15)		/* L2 prefetch enable */
+#define MHINT_L2_PREF_DIST(n)	((n) << 16)	/* in 64 B lines */
+#define MHINT_NSFE		BIT(18)
+#define MHINT_TLB_BROAD_DIS	BIT(21)		/* keep TLB ops hart-local */
+#define MHINT_FENCERW_BROAD_DIS	BIT(22)	/* keep fence rw hart-local */
+
+/* MHINT2 - per-unit clock gating */
+#define MHINT2_LOCAL_ICG_EN(n)	BIT((n) + 14)
+
+/* MSMPR - machine-mode SMP control */
+#define MSMPR_SMPEN		BIT(0)		/* cache snooping enable */
+
+#endif /* _ASM_RISCV_THEAD_CSR_H */
-- 
2.43.0

