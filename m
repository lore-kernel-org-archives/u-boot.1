Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A106C3DA7F
	for <u-boot@archiver.kernel.org>; Sun,  4 Aug 2024 15:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C0CB88814;
	Sun,  4 Aug 2024 17:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ja/4GTdY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B055388814; Sun,  4 Aug 2024 17:06:18 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D556988808
 for <u-boot@lists.denx.de>; Sun,  4 Aug 2024 17:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=32c7=PE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722783972; bh=aFRI8biPf3JLD21QAxvVwEsLeP8E/j7272Q50tqTzaU=;
 b=ja/4GTdYPwoYrbvN9Hz3UIqlx+1sxN2HPa8HtsV0zVK+9RAm/9rZ1EwQZ6T/zIAeLsC72F+W2
 OxoyxOrD98K3udYKvoAaq2XI5J5BmedFLfgJWMwTZcwhWbnP7E8bHceFpeFX74vX3kLjXVEAcfg
 k++yPKO3mIRwPMquxAZZm5oBR4SIVKiS3kNk+WbSwce8+EAILecs5SSWWw4/qce7r5kO5Ptp9uR
 rG3/RD0L/7zrO3tzCON/YCWBmRp2cpFrOrT97grUxU5xNgiKlxPMBVFbxfzmxoEcqNNYxqDybdQ
 oW3hKlO6otnD7z/OTHGEgrjjNFPoaYqXn0Y/wPSALJvg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/3] dm: core: regmap: Avoid multiple calls to
 ofnode_get_parent()
Date: Sun,  4 Aug 2024 15:05:51 +0000
Message-ID: <20240804150556.3519995-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804150556.3519995-1-jonas@kwiboo.se>
References: <20240804150556.3519995-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66af98e0b04314fb234e2fe1
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

Until a live tree is used in U-Boot proper after relocation, use of
ofnode_get_parent() will trigger a call to the very expensive
fdt_parent_offset(), as detailed by the function documentation:

  NOTE: This function is expensive, as it must scan the device tree
  structure from the start to nodeoffset, *twice*.

Re-use the returned value from a single call instead of having to make
multiple calls for same node.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/core/regmap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/core/regmap.c b/drivers/core/regmap.c
index 304d5b02bcd5..5cb5fa27343a 100644
--- a/drivers/core/regmap.c
+++ b/drivers/core/regmap.c
@@ -168,18 +168,21 @@ static int init_range(ofnode node, struct regmap_range *range, int addr_len,
 
 int regmap_init_mem_index(ofnode node, struct regmap **mapp, int index)
 {
+	ofnode parent;
 	struct regmap *map;
 	int addr_len, size_len;
 	int ret;
 
-	addr_len = ofnode_read_simple_addr_cells(ofnode_get_parent(node));
+	parent = ofnode_get_parent(node);
+
+	addr_len = ofnode_read_simple_addr_cells(parent);
 	if (addr_len < 0) {
 		dm_warn("%s: Error while reading the addr length (ret = %d)\n",
 			ofnode_get_name(node), addr_len);
 		return addr_len;
 	}
 
-	size_len = ofnode_read_simple_size_cells(ofnode_get_parent(node));
+	size_len = ofnode_read_simple_size_cells(parent);
 	if (size_len < 0) {
 		dm_warn("%s: Error while reading the size length: (ret = %d)\n",
 			ofnode_get_name(node), size_len);
@@ -241,6 +244,7 @@ int regmap_init_mem_range(ofnode node, ulong r_start, ulong r_size,
 
 int regmap_init_mem(ofnode node, struct regmap **mapp)
 {
+	ofnode parent;
 	struct regmap_range *range;
 	struct regmap *map;
 	int count;
@@ -249,14 +253,16 @@ int regmap_init_mem(ofnode node, struct regmap **mapp)
 	int index;
 	int ret;
 
-	addr_len = ofnode_read_simple_addr_cells(ofnode_get_parent(node));
+	parent = ofnode_get_parent(node);
+
+	addr_len = ofnode_read_simple_addr_cells(parent);
 	if (addr_len < 0) {
 		dm_warn("%s: Error while reading the addr length (ret = %d)\n",
 			ofnode_get_name(node), addr_len);
 		return addr_len;
 	}
 
-	size_len = ofnode_read_simple_size_cells(ofnode_get_parent(node));
+	size_len = ofnode_read_simple_size_cells(parent);
 	if (size_len < 0) {
 		dm_warn("%s: Error while reading the size length: (ret = %d)\n",
 			ofnode_get_name(node), size_len);
-- 
2.45.2

