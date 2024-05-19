Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159C9C25B77
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 12:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E5D882B5;
	Sun, 19 May 2024 14:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="e131jzlw";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xj/0hP1n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25256882F0; Sun, 19 May 2024 14:57:00 +0200 (CEST)
Received: from wfhigh1-smtp.messagingengine.com
 (wfhigh1-smtp.messagingengine.com [64.147.123.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E020088281
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 14:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.west.internal (Postfix) with ESMTP id 25D7E18000DF;
 Sun, 19 May 2024 08:56:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Sun, 19 May 2024 08:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716123414;
 x=1716209814; bh=x8m/IF5ca9Ta8yonTh1b1up8Bgq3edgJeP3Bl0vjhFg=; b=
 e131jzlweL2wmHAedIjJypFTY7Vcm7ZzqEnE1LD0iHnrt7CdIRvbHMuzMucP9tAF
 Tng3oBC6gX/eHmZfKlYIC7QcYidXEjZRec/Gj3z5h3iF/9a/l2WgPlPRFRwojkJS
 mq7iS5TapFiGN5oudbKEXAyEgdA52+vyMtq2Dg75nk7X/yza83ucxbV/J6Xg54wK
 2NHo0Th8b3th2qSH010uAgbknGdVxbf6uGSAvRW03IGXKuzhoN2CAyCnW+xvQ4VK
 aDXf/V3TIA4vNkdpKBziNukuYLCNjQQ6WNA7Xjy3TRAYjcTpp+pVHsY9Q3bnl7gf
 24C5LG86t2cE1nBYIsaRag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716123414; x=
 1716209814; bh=x8m/IF5ca9Ta8yonTh1b1up8Bgq3edgJeP3Bl0vjhFg=; b=X
 j/0hP1nwlnaZ18c1p2zpzVuUEM1Y18e63LXhfr8cmjCVQp3Am6xctXsmjod21YoD
 X68iEDY1/a9CJHsbq7sJ6XHYAoYkkT6+U9Mvg03AM8w7xOrUxTVt2I1b7OH+WBYw
 7Edbvux+RmSDn8WVWiLW7gCsHaZSxaS21guj5EF5vsdU036I0ZWwgqPrKzRYHmym
 6eVyZcfVVBXTNY8TnBH4LBTwXa04V12D0ZsYi3S4N0+kgIDkaFjWpsVpZ8ZLoNIT
 CF74xJm4J0eGKt1xH37X0u1WbuXRL6a9RSZGoKC6DauctIi+2dtxunPlnrcRNIpx
 bzxQt7RJoN/HUhsQ4S6FQ==
X-ME-Sender: <xms:FvdJZiNAqlB_9PuogpPIP6UbsJIbJd_Pxyva3LaYbS08_inva2Ebug>
 <xme:FvdJZg_dVhB3eJaN5GAEHI8WZDAt8bLlVwh1Rijmb9jBYBysjKV-3lskm0Pw9DLK7
 cAe15-NMNHfvc_CopQ>
X-ME-Received: <xmr:FvdJZpTxy8Ju1OqSKVSu4OJkwvgCNP5Twonyb91Us92mA2yGTnrrE8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:FvdJZitANH0VqS2Xv-0frMUKGD-PHir3-Ga906JatGptUR7ZpxYp7A>
 <xmx:FvdJZqe4ze6aOnue1WFPe6BaE-dX6KScLZVc_tsuzOZgOwotXwxksA>
 <xmx:FvdJZm1FWA7K9Pb6I-XfnyCgWj2nOqV3yJA4lx7gYp4kUBYZgIfiNg>
 <xmx:FvdJZu8OD2OLKjPYvJjEXbkoypSJSDdHa8FMTOipp_pegNBFcLCZPQ>
 <xmx:FvdJZhBlkV3q3ikb_8LWTvV3tuhGzVopdZok8WkvYKSJvC-bNr-1es8C>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 08:56:52 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 13:56:46 +0100
Subject: [PATCH 01/13] tools/relocate-rela: Fix Big Endian elf64 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-aarch64-be-v1-1-75cc328eddfa@flygoat.com>
References: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
In-Reply-To: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
To: u-boot@lists.denx.de, uboot-snps-arc@synopsys.com
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Ezequiel Garcia <ezequiel@collabora.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3522;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=ZEJJHvJlIv1tyBAt8PLFUgc4SCvgXoWdePXwCkdD8D0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTP7/xMmd9SPJQ9ujq4VvcdLrk+81RLTUdxfdTDb1c2G
 1d16J/qKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIlYH2T4w32jT+t0RGuiwq2Z
 kQW75i/Tn8uTe3VhT92sS7eWXvmX0cPIsGi77N3qT++d5yiJSFl/DDdZ0Fiu31xje30V12Kvf3z
 mbAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Implement elf64_to_cpu and use it when necessary.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 tools/relocate-rela.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/tools/relocate-rela.c b/tools/relocate-rela.c
index 613abd25ef46..cbdd2552ec6e 100644
--- a/tools/relocate-rela.c
+++ b/tools/relocate-rela.c
@@ -111,6 +111,14 @@ static uint32_t cpu_to_elf32(uint32_t data)
 	return cpu_to_be32(data);
 }
 
+static uint64_t elf64_to_cpu(uint64_t data)
+{
+	if (ei_data == ELFDATA2LSB)
+		return le64_to_cpu(data);
+
+	return be64_to_cpu(data);
+}
+
 static bool supported_rela(Elf64_Rela *rela)
 {
 	uint64_t mask = 0xffffffffULL; /* would be different on 32-bit */
@@ -150,7 +158,7 @@ static int decode_elf64(FILE *felf, char **argv)
 		return 25;
 	}
 
-	machine = le16_to_cpu(header.e_machine);
+	machine = elf16_to_cpu(header.e_machine);
 	debug("Machine\t%d\n", machine);
 
 	if (machine != EM_AARCH64) {
@@ -158,10 +166,10 @@ static int decode_elf64(FILE *felf, char **argv)
 		return 30;
 	}
 
-	text_base = le64_to_cpu(header.e_entry);
-	section_header_base = le64_to_cpu(header.e_shoff);
-	section_header_size = le16_to_cpu(header.e_shentsize) *
-			      le16_to_cpu(header.e_shnum);
+	text_base = elf64_to_cpu(header.e_entry);
+	section_header_base = elf64_to_cpu(header.e_shoff);
+	section_header_size = elf16_to_cpu(header.e_shentsize) *
+			      elf16_to_cpu(header.e_shnum);
 
 	sh_table = malloc(section_header_size);
 	if (!sh_table) {
@@ -189,8 +197,8 @@ static int decode_elf64(FILE *felf, char **argv)
 		return 27;
 	}
 
-	sh_index = le16_to_cpu(header.e_shstrndx);
-	sh_size = le64_to_cpu(sh_table[sh_index].sh_size);
+	sh_index = elf16_to_cpu(header.e_shstrndx);
+	sh_size = elf64_to_cpu(sh_table[sh_index].sh_size);
 	debug("e_shstrndx %x, sh_size %lx\n", sh_index, sh_size);
 
 	sh_str = malloc(sh_size);
@@ -205,8 +213,8 @@ static int decode_elf64(FILE *felf, char **argv)
 	 * Specifies the byte offset from the beginning of the file
 	 * to the first byte in the section.
 	 */
-	sh_offset = le64_to_cpu(sh_table[sh_index].sh_offset);
-	sh_num = le16_to_cpu(header.e_shnum);
+	sh_offset = elf64_to_cpu(sh_table[sh_index].sh_offset);
+	sh_num = elf16_to_cpu(header.e_shnum);
 
 	ret = fseek(felf, sh_offset, SEEK_SET);
 	if (ret) {
@@ -228,13 +236,13 @@ static int decode_elf64(FILE *felf, char **argv)
 	}
 
 	for (i = 0; i < sh_num; i++) {
-		char *sh_name = sh_str + le32_to_cpu(sh_table[i].sh_name);
+		char *sh_name = sh_str + elf32_to_cpu(sh_table[i].sh_name);
 
 		debug("%s\n", sh_name);
 
-		sh_addr = le64_to_cpu(sh_table[i].sh_addr);
-		sh_offset = le64_to_cpu(sh_table[i].sh_offset);
-		sh_size = le64_to_cpu(sh_table[i].sh_size);
+		sh_addr = elf64_to_cpu(sh_table[i].sh_addr);
+		sh_offset = elf64_to_cpu(sh_table[i].sh_offset);
+		sh_size = elf64_to_cpu(sh_table[i].sh_size);
 
 		if (!strcmp(".rela.dyn", sh_name)) {
 			debug("Found section\t\".rela_dyn\"\n");
@@ -480,9 +488,9 @@ static int rela_elf64(char **argv, FILE *f)
 			return 4;
 		}
 
-		swrela.r_offset = le64_to_cpu(rela.r_offset);
-		swrela.r_info = le64_to_cpu(rela.r_info);
-		swrela.r_addend = le64_to_cpu(rela.r_addend);
+		swrela.r_offset = elf64_to_cpu(rela.r_offset);
+		swrela.r_info = elf64_to_cpu(rela.r_info);
+		swrela.r_addend = elf64_to_cpu(rela.r_addend);
 
 		if (!supported_rela(&swrela))
 			continue;

-- 
2.43.0

