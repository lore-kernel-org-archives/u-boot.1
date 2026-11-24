Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2BE606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uM41GuGW;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u8OrJ/z9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47CF280DD1;
	Tue, 24 Nov 2026 19:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BZpysIQoREFt; Tue, 24 Nov 2026 19:53:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 71CB080D02
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795549981;
	b=qlNgAjgz3tW5fx5L64Ws6AChvnnpELpxYNTSO+yusIpWkfE0IIQrShsvxxc/eHyCLNaC
	 n0RtLJ9GjZ5NLBwMALYbaWn4BOAbjSCWy/zNuInfMhWdrUGLA7ZibYZWQFembT/VZjYH3
	 gpbT1hAywabmu1Kd/zJj3+08Gb99Nf/tZOGjMc43UlBn0F+JljAUNDvNLOMGrlmr60agJ
	 y7tNeR4QLbvci39JGPptgooj7TcLPnJ8eOqfekrROf4uOdY2ykWp8zwMSQlkxclsZUU7x
	 Y9QheH7tb9uURvl3XNePsIvMqSjPBBKBEocj927zEjKeuPMONp/V4Nvtk8UCX8rRyWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795549981;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BNui5AXt1/UYAcdyF9HJYrZGHWX4ol07skvyfaCqbMM=;
	b=cPTHBg/64JMoDxMTVucDQI5H/Y+zeaCAHYr1D3Yk6sb5fFGpn8PdAbqiM4SBJJ6ssAM0
	 F1WulfW7MhHJkWvsDw0MbQntB9OTVcsAaVU10nONDQfJATjTe/KLV1j8HbIw+7KQ9prtS
	 DuvPMXxUOl1/I5B+7EIfpnrXn1h0SkU/RYQfJPv2gkCtKCrj+aXUh3t+7YbYdnX+oHHFD
	 pO1q3zPyY3J/PeFnH3xJsboZBajZfBygx6IKr6BG2pCu/18QqiXNmDadobKVx8YFXBhhT
	 64rqOZT3m+zGTuDOnsZUmeWChvkRDyzVUDVRGfJzXpYT/bLB+dC66IQwOyKO1JB18ZA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="u8OrJ/z9";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795549981;
	bh=BNui5AXt1/UYAcdyF9HJYrZGHWX4ol07skvyfaCqbMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uM41GuGWWCjIJbQsNF8Pgx1/FST6/Ma5QRnYKF8qZybZJXvfkkDSXnDMRdtXl6/0Z
	 /Jg+z5a3uWQV4jHaK1Qh2/sQrYiGe2WCwdgr4sr5NK1fnG0WZnfArkE9NDhYO9gI8j
	 ysrb81yQzz66OJ5Ted1BseVoo7SKE9v6xZkhTRiIdnMcvwUldCiI52jRnSB84oJLF5
	 Qo03MuDTcpHYKInxxFCGu6k7L2bAJblhMHU9DCCDKJ53GtAS7Aa2JprAe0fu4n9n5U
	 YIMbzbNC5DO8nTIvkRgw8/tJe/Od2T++GaEOHyAVzw5bafzwCT4AZdlOmblfsEtseo
	 saMX96oaKiDMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71CB080D02;
	Tue, 24 Nov 2026 19:53:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D2FA426D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:53:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C520980D02
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:53:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zLRmIQYQLsHL for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 19:53:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BFDB080CD9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::236"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::236; helo=mail-lj1-x236.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=u8OrJ/z9
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BFDB080CD9
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:52:59 +0000 (UTC)
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-3ae85add512so40495261fa.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795549977; x=1796154777;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BNui5AXt1/UYAcdyF9HJYrZGHWX4ol07skvyfaCqbMM=;
 b=u8OrJ/z9EHuAxXbmb+g4OF5x05RidP1HxcjcWmyaPlUVS28UouQo8BtCLqtbGIlNlK
 QhWpkXdKihdysvhWIa95P1Ri6XGIYtXG32b0o2aqEyIC4STMB8mlX8GrKKd3Qldxg7MZ
 btAL0NXHunKqonBWeYDvhLYoHM1XC+LstiAlUOyHhlCZwIuTcU3qLpxVFO16ZkQn/Rcc
 N/7L14h44gaIrj6QXWTA6tbSQ7oqxh8Tl6TV0DIfsq7V+jGyZ1wF6h7fvBFcEXHqlysX
 gXGp1xaxxDRsh+aH+gTmKS6CuvcffwlLu+sBcJXG3W0QL3YeilEg4Ks1dx4/r3ZbH1oE
 z/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795549977; x=1796154777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BNui5AXt1/UYAcdyF9HJYrZGHWX4ol07skvyfaCqbMM=;
 b=h7nANz/0FpbFKF0fcrT5JxYdEbCf/jk2QKQ1n3DarC00E7yjJ6oueqBLhUbACYKH4q
 nQw00U1lagrdaBYd6lWI4G3gYOqijaKBNVyI6GBmAUehXe+zNuXCfqnRDBXlf+kGljnA
 vUbHFf0vAZGFZjxieUbxnuwbTSdPesSraYZv7jitNpV9VqCNZ8Ea4Iz4ccyvWjbBTg+9
 ri7zbC5yMx54VZnOd864t0xzviHp4BeUzq3AMf2cdeZQGYhDcEAm+SemohP+xRo3NF13
 twgBUMi200JupQosSozIMGelGIJU+2B823vq96vq0Ki8EZQoFD0rNEJJRQ3bHjrsB/iJ
 reSg==
X-Forwarded-Encrypted: i=1;
 AL+hErEm3a8KITJkQ0paNpQ4g+SGWCR+OsOfyDmjDW+VuihlkZMS2sfpEHVwXQEtJfqirJRJ+t8FPf8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+Bjpf0bZXnEu23l40w1a59UcyawQ/CecOAL7GviIaxGH579Hi+
 abDWk1XZPdUnAlajbc6adUQhZdbTB1UvtlwCitXZogzHngX+9sC3Mhtz
X-Gm-Gg: AZFdTZfZAgKOd/gibXg0yN3Gbf1U1SYmyl2d664TA8Q1VI+owuWewjH6mNzu1/Fxo/t
 20abVwz8fB6TuanDhKcenjzUHxcKM9KhLZyi57iMndt0+bWm1ufi1V4A1z6qtpB7Rpt83vuQWeb
 KSGxDIFLFqkRNmZmsIflXJVX0JIKkOR6rOpWQ0Xj6tPvTbZD1b5U2IJmle+/UwSvtGgPqWPj46F
 f3KrvQld/S4fjhDT24K4vnYwZZI/uHJNbiPTTgJtX/nlIJuXmbWY/IJp3jQHqD1ZaUpiPsFXBwz
 Nvd4F3L4jCnv8daYwzdf++eL+3EFu2SHxSuoZCssMRtK20sKl/1hMkvxdUOO5sJ5Ufgs7tk/cnn
 eDLO7FWHvW1Q5iZCmTNP9FyvWPJ9oIPxxZD6CC2xa6RE70PuvmA+rPsBp8etdlSq9uoVUN6+vju
 KB87irdeK/yNMvmkjRkNcs94+iZo1vU6lBK0p4hqEWqn/VZ8egkCucNHSYxThT9/PbgLOEn/mjj
 MIbYynd+cyMJxL+/NnIeZtrWZ2dgCPGtv05nK16SUjVwyWF9btzWn9osUfPwQy1v3wA3wUharxR
 L40eQeNxdNAKe3FYRx/mEM5tlL5LeBTX4juCb6qPbB+GCzfXcK1sgQwkuAH0j/ZmdEU=
X-Received: by 2002:a05:6512:1320:b0:5c1:57d2:c1bd with SMTP id
 2adb3069b0e04-5c1bc7ca4b1mr4487034e87.25.1795549977025; 
 Tue, 24 Nov 2026 11:52:57 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 2adb3069b0e04-5c1bd041813sm4057216e87.53.2026.11.24.11.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:52:56 -0800 (PST)
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
Subject: [PATCH 2/4] riscv: th1520: use the common C9xx CSR definitions
Date: Tue, 24 Nov 2026 21:52:35 +0200
Message-ID: <20261124195237.692679-3-indrek.kruusa@gmail.com>
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
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use asm/thead_csr.h instead of the definitions in spl.c.  The header
keeps CSR_ on register numbers and drops it on bitfields; the values
written are unchanged.

Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
---
 arch/riscv/cpu/th1520/spl.c | 96 ++++++++++---------------------------
 1 file changed, 26 insertions(+), 70 deletions(-)

diff --git a/arch/riscv/cpu/th1520/spl.c b/arch/riscv/cpu/th1520/spl.c
index ceb934021d9..d6fa8724334 100644
--- a/arch/riscv/cpu/th1520/spl.c
+++ b/arch/riscv/cpu/th1520/spl.c
@@ -4,6 +4,7 @@
  */
 #include <asm/arch/iopmp.h>
 #include <asm/io.h>
+#include <asm/thead_csr.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <linux/sizes.h>
@@ -20,52 +21,6 @@
 #define  TH1520_SUBSYS_RST_VI_N		BIT(1)
 #define  TH1520_SUBSYS_RST_DSP_N	BIT(0)
 
-#define CSR_MXSTATUS			0x7c0
-#define  CSR_MXSTATUS_THEADISAEE	BIT(22)
-#define  CSR_MXSTATUS_MAEE		BIT(21)
-#define  CSR_MXSTATUS_CLINTEE		BIT(17)
-#define  CSR_MXSTATUS_UCME		BIT(16)
-#define  CSR_MXSTATUS_MM		BIT(15)
-#define CSR_MHCR			0x7c1
-#define  CSR_MHCR_WBR			BIT(8)
-#define  CSR_MHCR_BTB			BIT(6)
-#define  CSR_MHCR_BPE			BIT(5)
-#define  CSR_MHCR_RS			BIT(4)
-#define  CSR_MHCR_WB			BIT(3)
-#define  CSR_MHCR_WA			BIT(2)
-#define  CSR_MHCR_DE			BIT(1)
-#define  CSR_MHCR_IE			BIT(0)
-#define CSR_MCOR			0x7c2
-#define  CSR_MCOR_IBP_INV		BIT(18)
-#define  CSR_MCOR_BTB_INV		BIT(17)
-#define  CSR_MCOR_BHT_INV		BIT(16)
-#define  CSR_MCOR_CACHE_INV		BIT(4)
-#define CSR_MCCR2			0x7c3
-#define  CSR_MCCR2_TPRF			BIT(31)
-#define  CSR_MCCR2_IPRF(n)		((n) << 29)
-#define  CSR_MCCR2_TSETUP		BIT(25)
-#define  CSR_MCCR2_TLNTCY(n)		((n) << 22)
-#define  CSR_MCCR2_DSETUP		BIT(19)
-#define  CSR_MCCR2_DLNTCY(n)		((n) << 16)
-#define  CSR_MCCR2_L2EN			BIT(3)
-#define  CSR_MCCR2_RFE			BIT(0)
-#define CSR_MHINT			0x7c5
-#define  CSR_MHINT_FENCERW_BROAD_DIS	BIT(22)
-#define  CSR_MHINT_TLB_BRAOD_DIS	BIT(21)
-#define  CSR_MHINT_NSFE			BIT(18)
-#define  CSR_MHINT_L2_PREF_DIST(n)	((n) << 16)
-#define  CSR_MHINT_L2PLD		BIT(15)
-#define  CSR_MHINT_DCACHE_PREF_DIST(n)	((n) << 13)
-#define  CSR_MHINT_LPE			BIT(9)
-#define  CSR_MHINT_ICACHE_PREF		BIT(8)
-#define  CSR_MHINT_AMR			BIT(3)
-#define  CSR_MHINT_DCACHE_PREF		BIT(2)
-#define CSR_MHINT2			0x7cc
-#define  CSR_MHINT2_LOCAL_ICG_EN(n)	BIT((n) + 14)
-#define CSR_MHINT4			0x7ce
-#define CSR_MSMPR			0x7f3
-#define  CSR_MSMPR_SMPEN		BIT(0)
-
 int spl_dram_init(void)
 {
 	int ret;
@@ -123,11 +78,11 @@ void harts_early_init(void)
 	int i;
 
 	/* Invalidate cache and buffer entries */
-	csr_write(CSR_MCOR, CSR_MCOR_IBP_INV | CSR_MCOR_BTB_INV |
-			    CSR_MCOR_BHT_INV | CSR_MCOR_CACHE_INV | 0x3);
+	csr_write(CSR_MCOR, MCOR_IBP_INV | MCOR_BTB_INV | MCOR_BHT_INV |
+			    MCOR_INV | MCOR_CACHE_SEL(3));
 
 	/* Enable cache snooping */
-	csr_write(CSR_MSMPR, CSR_MSMPR_SMPEN);
+	csr_write(CSR_MSMPR, MSMPR_SMPEN);
 
 	/*
 	 * Configure and enable L2 cache,
@@ -135,27 +90,28 @@ void harts_early_init(void)
 	 *	Prefetch 3 cache lines of instructions
 	 *	Enable read allocation
 	 */
-	csr_write(CSR_MCCR2, CSR_MCCR2_TPRF   | CSR_MCCR2_IPRF(3)	|
-			     CSR_MCCR2_TSETUP | CSR_MCCR2_TLNTCY(1)	|
-			     CSR_MCCR2_DSETUP | CSR_MCCR2_DLNTCY(1)	|
-			     CSR_MCCR2_L2EN   | CSR_MCCR2_RFE);
-	csr_write(CSR_MXSTATUS, CSR_MXSTATUS_THEADISAEE | CSR_MXSTATUS_MAEE |
-				CSR_MXSTATUS_CLINTEE    | CSR_MXSTATUS_UCME |
-				CSR_MXSTATUS_MM);
-	csr_write(CSR_MHINT, CSR_MHINT_FENCERW_BROAD_DIS	|
-			     CSR_MHINT_TLB_BRAOD_DIS		|
-			     CSR_MHINT_NSFE			|
-			     CSR_MHINT_L2_PREF_DIST(2)		|
-			     CSR_MHINT_L2PLD			|
-			     CSR_MHINT_DCACHE_PREF_DIST(3)	|
-			     CSR_MHINT_LPE			|
-			     CSR_MHINT_ICACHE_PREF		|
-			     CSR_MHINT_AMR			|
-			     CSR_MHINT_DCACHE_PREF);
-	csr_write(CSR_MHCR, CSR_MHCR_WBR | CSR_MHCR_BTB | CSR_MHCR_BPE |
-			    CSR_MHCR_RS  | CSR_MHCR_WB  | CSR_MHCR_WA | 0x3);
-	csr_write(CSR_MHINT2, CSR_MHINT2_LOCAL_ICG_EN(8)	|
-			      CSR_MHINT2_LOCAL_ICG_EN(3));
+	csr_write(CSR_MCCR2, MCCR2_TPRF   | MCCR2_IPRF(3)		|
+			     MCCR2_TSETUP | MCCR2_TLNTCY(1)		|
+			     MCCR2_DSETUP | MCCR2_DLNTCY(1)		|
+			     MCCR2_L2EN   | MCCR2_RFE);
+	csr_write(CSR_MXSTATUS, MXSTATUS_THEADISAEE | MXSTATUS_MAEE |
+				MXSTATUS_CLINTEE    | MXSTATUS_UCME |
+				MXSTATUS_MM);
+	csr_write(CSR_MHINT, MHINT_FENCERW_BROAD_DIS	|
+			     MHINT_TLB_BROAD_DIS	|
+			     MHINT_NSFE			|
+			     MHINT_L2_PREF_DIST(2)	|
+			     MHINT_L2PLD		|
+			     MHINT_DCACHE_PREF_DIST(3)	|
+			     MHINT_LPE			|
+			     MHINT_IPLD			|
+			     MHINT_AMR(1)		|
+			     MHINT_DPLD);
+	csr_write(CSR_MHCR, MHCR_WBR | MHCR_BTB | MHCR_BPE |
+			    MHCR_RS  | MHCR_WB  | MHCR_WA  |
+			    MHCR_IE  | MHCR_DE);
+	csr_write(CSR_MHINT2, MHINT2_LOCAL_ICG_EN(8)	|
+			      MHINT2_LOCAL_ICG_EN(3));
 	csr_write(CSR_MHINT4, 0x410);
 
 	/*
-- 
2.43.0

