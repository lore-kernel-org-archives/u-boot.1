Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0F8C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 15:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF02788851;
	Wed, 22 May 2024 17:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="kprPCtc4";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="HcE5HwS5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9890388836; Wed, 22 May 2024 17:35:09 +0200 (CEST)
Received: from wfout5-smtp.messagingengine.com
 (wfout5-smtp.messagingengine.com [64.147.123.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65EF887CDB
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 17:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.west.internal (Postfix) with ESMTP id 3F38A1C00176;
 Wed, 22 May 2024 11:35:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 22 May 2024 11:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716392104;
 x=1716478504; bh=C9xIworzKuIheF3D6pKKb12BpumbLfp4RV6PHRCuaHw=; b=
 kprPCtc4MDnwEq7TIxSzOCdJwH37JRQB/dnT08/Kc3nhHJyujWQuB9iaN9hDmQAW
 SR9wwn2Ef2WYFumo0n6Rlh+AVED1ETY1KBG+YarxJGs2z6KhSMBD0iW85//lAxZa
 +oZM//QvRQzWiHgUHa9QTTuX5HUpmYj7hFzxUgEXV66/EZZRg2erpS8ov0M9ZMY+
 tZasZyl1UJzoG9rhUH85gYvmjoyNcLQdsH588eG2fI3ecnstmslavaAF8EKH/5ys
 fULM/Tac2onTRs20SIO4wcn2sS2+7evIWzPUZPqB5Vi16cuwHOuy4LILTUPUJh3p
 5zJH1UAEMMhQTe495pl94Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716392104; x=
 1716478504; bh=C9xIworzKuIheF3D6pKKb12BpumbLfp4RV6PHRCuaHw=; b=H
 cE5HwS5KUPlOTSXv/lr+YMzq+4NUGCpCckSN1d01E9A4QX0ZyyG7JKfYNw/+awws
 Lz86VzHuXFEB6jEvHIHBdhPkxq296I3c7Emkl12TgcN68WgTYCAxB2kHK0e/mG6e
 Vl0zDyr5Qp96eAUalRVP48FGOF7Hsh33Od4K6VXK8h8pwOVwlwulD0KpPPCAIyUq
 nWE42tNVuGoy547pTBkYLoz42C6fWaPEYy0qyDLVrNN8zn61GZ+CgntsOpzZKmBE
 W4RvYceCUcd85IR8jHOXqRb4c2UZwq/Xo9Ct1x8mPhVIYH/yDoLs6iXijHWliIhK
 Y34XnQLr9I0uqTXmvACTw==
X-ME-Sender: <xms:qBBOZpWCm4byoxawWvlGGHNvU-XLwIrLXilVHHXLC4qZOK5eKTHiUw>
 <xme:qBBOZpmT2uauYsCRAh3JMlnis9vdCo1UmjHec0zZwd8Plf7C8owzNYH4iJa3q2trV
 QSr94y9wbrgxXCtmwU>
X-ME-Received: <xmr:qBBOZlamGGI72dPgAE5WEARe6OkDgAl-AUDNww6cvnj-mObtXFHD36A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:qBBOZsWCGxq28Vc_uDQAcWCxPmW4DRqs2LCKNQzfmKJhZm_JOXWL5A>
 <xmx:qBBOZjlwE3WMb4C5M72Fqm7nvAAxgDccq1RVewshOnObmadZxvQUWg>
 <xmx:qBBOZpeajLMlP_jvj1dXXGNfzVJESHlvv2LqKvQkXRqETWWCZJKCHA>
 <xmx:qBBOZtENk60NWQNAuF4eqLmDQWCih_74CrQlMfhhbeZsmpkjL7dltA>
 <xmx:qBBOZha3chtzL4mtgf5328fkH0ZEkrFutBQj1xrl4lhMkJoQ6AEHhEr2>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 11:35:03 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 16:34:44 +0100
Subject: [PATCH 01/16] lib: fdtdec: Handle multiple memory nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-v1-1-1407e0b69678@flygoat.com>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
In-Reply-To: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5085;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=BknJt5GVc51vSr9yIp4GJqL+wk7/OpvsOtohY8ir8JE=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/geUH3QM+s3d/rlU9eMDrpnRHeuGWmc2nnlgseht08
 2qk0Y+EjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZhIIifD/+ylUtLqjoVWHHNf
 fQvYFpSutcq7YGWJK5eSSwvn++N6CowM9y7wrCm6sU1ApcZj+/Vqt6PW9jv3Cdzdf0DvaZb4Xe0
 7HAA=
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

Current code only tries to fetch the first memory node found in
fdt tree and determine memory banks from multiple reg properties.

Linux do allow multiple memory nodes in devicetree, rework
fdtdec_setup_mem_size_base_lowest and fdtdec_setup_memory_banksize
to iterate over all memory nodes.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 lib/fdtdec.c | 137 ++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 83 insertions(+), 54 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b2c59ab3818b..403b363043d6 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1075,90 +1075,119 @@ ofnode get_next_memory_node(ofnode mem)
 	return mem;
 }
 
+static void sort_memory_banks(int num)
+{
+	int i, j;
+	phys_addr_t tmp_start;
+	phys_size_t tmp_size;
+	struct bd_info *bd = gd->bd;
+
+	for (i = 0; i < num - 1; i++) {
+		for (j = i + 1; j < num; j++) {
+			if (bd->bi_dram[i].start > bd->bi_dram[j].start) {
+				tmp_start = bd->bi_dram[i].start;
+				tmp_size = bd->bi_dram[i].size;
+				bd->bi_dram[i].start = bd->bi_dram[j].start;
+				bd->bi_dram[i].size = bd->bi_dram[j].size;
+				bd->bi_dram[j].start = tmp_start;
+				bd->bi_dram[j].size = tmp_size;
+			}
+		}
+	}
+}
+
 int fdtdec_setup_memory_banksize(void)
 {
-	int bank, ret, reg = 0;
-	struct resource res;
+	int bank = 0;
 	ofnode mem = ofnode_null();
 
-	mem = get_next_memory_node(mem);
-	if (!ofnode_valid(mem)) {
-		debug("%s: Missing /memory node\n", __func__);
-		return -EINVAL;
-	}
+	while (true) {
+		struct resource res;
+		int reg = 0;
 
-	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		ret = ofnode_read_resource(mem, reg++, &res);
-		if (ret < 0) {
-			reg = 0;
-			mem = get_next_memory_node(mem);
-			if (!ofnode_valid(mem))
-				break;
+		mem = get_next_memory_node(mem);
+		if (!ofnode_valid(mem))
+			break;
 
-			ret = ofnode_read_resource(mem, reg++, &res);
+		while (true) {
+			int ret = ofnode_read_resource(mem, reg, &res);
 			if (ret < 0)
 				break;
-		}
 
-		if (ret != 0)
-			return -EINVAL;
+			if (bank >= CONFIG_VAL(NR_DRAM_BANKS))
+				goto too_may_memory_banks;
 
-		gd->bd->bi_dram[bank].start = (phys_addr_t)res.start;
-		gd->bd->bi_dram[bank].size =
-			(phys_size_t)(res.end - res.start + 1);
+			gd->bd->bi_dram[bank].start = (phys_addr_t)res.start;
+			gd->bd->bi_dram[bank].size =
+				(phys_size_t)(res.end - res.start + 1);
 
-		debug("%s: DRAM Bank #%d: start = 0x%llx, size = 0x%llx\n",
-		      __func__, bank,
-		      (unsigned long long)gd->bd->bi_dram[bank].start,
-		      (unsigned long long)gd->bd->bi_dram[bank].size);
+			log_debug("%s: DRAM Bank #%d %s.%d: start = 0x%llx, size = 0x%llx\n",
+				  __func__, bank, ofnode_get_name(mem), reg,
+				 (unsigned long long)gd->bd->bi_dram[bank].start,
+				 (unsigned long long)gd->bd->bi_dram[bank].size);
+			reg++;
+			bank++;
+		}
 	}
 
+	if (!bank) {
+		log_warning("%s: Missing /memory node\n", __func__);
+		return -EINVAL;
+	}
+
+	sort_memory_banks(bank);
+
 	return 0;
+
+too_may_memory_banks:
+	log_warning("%s: Too many memory banks\n", __func__);
+	return -EINVAL;
 }
 
 int fdtdec_setup_mem_size_base_lowest(void)
 {
-	int bank, ret, reg = 0;
-	struct resource res;
-	unsigned long base;
-	phys_size_t size;
+	int bank = 0;
 	ofnode mem = ofnode_null();
+	__maybe_unused const char *final_name;
+	__maybe_unused int final_reg;
 
 	gd->ram_base = (unsigned long)~0;
 
-	mem = get_next_memory_node(mem);
-	if (!ofnode_valid(mem)) {
-		debug("%s: Missing /memory node\n", __func__);
-		return -EINVAL;
-	}
+	while (true) {
+		struct resource res;
+		phys_size_t base, size;
+		int reg = 0;
 
-	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		ret = ofnode_read_resource(mem, reg++, &res);
-		if (ret < 0) {
-			reg = 0;
-			mem = get_next_memory_node(mem);
-			if (!ofnode_valid(mem))
-				break;
+		mem = get_next_memory_node(mem);
+		if (!ofnode_valid(mem))
+			break;
 
-			ret = ofnode_read_resource(mem, reg++, &res);
+		while (true) {
+			int ret = ofnode_read_resource(mem, reg, &res);
 			if (ret < 0)
 				break;
+			base = res.start;
+			size = res.end - res.start + 1;
+			if (gd->ram_base > base && size) {
+				gd->ram_base = base;
+				gd->ram_size = size;
+				final_name = ofnode_get_name(mem);
+				final_reg = reg;
+			}
+			reg++;
+			bank++;
 		}
+	}
 
-		if (ret != 0)
-			return -EINVAL;
-
-		base = (unsigned long)res.start;
-		size = (phys_size_t)(res.end - res.start + 1);
-
-		if (gd->ram_base > base && size) {
-			gd->ram_base = base;
-			gd->ram_size = size;
-			debug("%s: Initial DRAM base %lx size %lx\n",
-			      __func__, base, (unsigned long)size);
-		}
+	if (!bank) {
+		log_warning("%s: Missing /memory node\n", __func__);
+		return -EINVAL;
 	}
 
+	log_debug("%s: Initial DRAM %s.%d: base %lx size %lx\n",
+		  __func__, final_name, final_reg,
+		  (ulong)gd->ram_base, (ulong)gd->ram_size);
+
 	return 0;
 }
 

-- 
2.43.0

