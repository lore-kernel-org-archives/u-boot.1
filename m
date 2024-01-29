Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20012C47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 21:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF19087DB0;
	Mon, 29 Jan 2024 22:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="I7orZm2x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C935B87B1D; Mon, 29 Jan 2024 22:05:15 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A8BC87DC1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 22:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 674213F8CC; 
 Mon, 29 Jan 2024 21:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706562300;
 bh=B2A2SuGr90jHZ/vmKCCDaPhcOzNeszSC0QbEmGRgnuA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=I7orZm2xaOA67blJqLZT1Wv0C6bxKWGGMAMVnIssuDNQmpxeY2YjFSIs7CbkewpzW
 MYPfCn3djg18Pq7BDngEcRD+UDWQqbzi71pG2O8MrY6R1mMaEc8Hyh9JHTldCVurSK
 ETIPt59UuB3rBgfYuj8/PZ+iH5dUA3ZZgFQbIVpEWyVTBdHy68VDt6TsOikyLDdSk4
 J6pko+7gBegDNEFppF9JVLpnighf42as1DzOr3dzLRPWm5qp5NL/XEXKVxLgBJEyKh
 rW+H80P6IKZG+llqWMtLr2y17UrqMfSZKZCvoKsBbGcuVM+eqwwIieZbcKE04Tc9pI
 MYATyU3OyUMFA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 5/7] smbios: if a string value is unknown, use string number 0
Date: Mon, 29 Jan 2024 22:04:51 +0100
Message-ID: <20240129210453.31070-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129210453.31070-1-heinrich.schuchardt@canonical.com>
References: <20240129210453.31070-1-heinrich.schuchardt@canonical.com>
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

The SMBIOS specification describes: "If a string field references no
string, a null (0) is placed in that string field."

Accordingly we should avoid writing a string "Unknown" to the SMBIOS table.

dmidecode displays 'Not Specified' if the string number is 0.

Commit 00a871d34e2f ("smbios: empty strings in smbios_add_string()")
correctly identified that strings may not have length 0 as two
consecutive NULs indentify the end of the string list. But the suggested
solution did not match the intent of the SMBIOS specification.

Fixes: 00a871d34e2f ("smbios: empty strings in smbios_add_string()")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/smbios.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index 81908e89610..50072adb4e8 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -135,13 +135,16 @@ static const struct map_sysinfo *convert_sysinfo_to_dt(const char *node, const c
  *
  * @ctx:	SMBIOS context
  * @str:	string to add
- * Return:	string number in the string area (1 or more)
+ * Return:	string number in the string area. 0 if str is NULL.
  */
 static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
 {
 	int i = 1;
 	char *p = ctx->eos;
 
+	if (!str)
+		return 0;
+
 	for (;;) {
 		if (!*p) {
 			ctx->last_str = p;
@@ -216,7 +219,7 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
 	int ret;
 
 	if (!dval || !*dval)
-		dval = "Unknown";
+		dval = NULL;
 
 	if (!prop)
 		return smbios_add_string(ctx, dval);
@@ -378,19 +381,19 @@ static int smbios_write_type1(ulong *current, int handle,
 	memset(t, 0, sizeof(struct smbios_type1));
 	fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->manufacturer = smbios_add_prop(ctx, "manufacturer", "Unknown");
-	t->product_name = smbios_add_prop(ctx, "product", "Unknown");
+	t->manufacturer = smbios_add_prop(ctx, "manufacturer", NULL);
+	t->product_name = smbios_add_prop(ctx, "product", NULL);
 	t->version = smbios_add_prop_si(ctx, "version",
 					SYSINFO_ID_SMBIOS_SYSTEM_VERSION,
-					"Unknown");
+					NULL);
 	if (serial_str) {
 		t->serial_number = smbios_add_prop(ctx, NULL, serial_str);
 		strncpy((char *)t->uuid, serial_str, sizeof(t->uuid));
 	} else {
-		t->serial_number = smbios_add_prop(ctx, "serial", "Unknown");
+		t->serial_number = smbios_add_prop(ctx, "serial", NULL);
 	}
-	t->sku_number = smbios_add_prop(ctx, "sku", "Unknown");
-	t->family = smbios_add_prop(ctx, "family", "Unknown");
+	t->sku_number = smbios_add_prop(ctx, "sku", NULL);
+	t->family = smbios_add_prop(ctx, "family", NULL);
 
 	len = t->length + smbios_string_table_len(ctx);
 	*current += len;
@@ -409,12 +412,12 @@ static int smbios_write_type2(ulong *current, int handle,
 	memset(t, 0, sizeof(struct smbios_type2));
 	fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->manufacturer = smbios_add_prop(ctx, "manufacturer", "Unknown");
-	t->product_name = smbios_add_prop(ctx, "product", "Unknown");
+	t->manufacturer = smbios_add_prop(ctx, "manufacturer", NULL);
+	t->product_name = smbios_add_prop(ctx, "product", NULL);
 	t->version = smbios_add_prop_si(ctx, "version",
 					SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
-					"Unknown");
-	t->asset_tag_number = smbios_add_prop(ctx, "asset-tag", "Unknown");
+					NULL);
+	t->asset_tag_number = smbios_add_prop(ctx, "asset-tag", NULL);
 	t->feature_flags = SMBIOS_BOARD_FEATURE_HOSTING;
 	t->board_type = SMBIOS_BOARD_MOTHERBOARD;
 
@@ -435,7 +438,7 @@ static int smbios_write_type3(ulong *current, int handle,
 	memset(t, 0, sizeof(struct smbios_type3));
 	fill_smbios_header(t, SMBIOS_SYSTEM_ENCLOSURE, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->manufacturer = smbios_add_prop(ctx, "manufacturer", "Unknown");
+	t->manufacturer = smbios_add_prop(ctx, "manufacturer", NULL);
 	t->chassis_type = SMBIOS_ENCLOSURE_DESKTOP;
 	t->bootup_state = SMBIOS_STATE_SAFE;
 	t->power_supply_state = SMBIOS_STATE_SAFE;
@@ -453,8 +456,8 @@ static void smbios_write_type4_dm(struct smbios_type4 *t,
 				  struct smbios_ctx *ctx)
 {
 	u16 processor_family = SMBIOS_PROCESSOR_FAMILY_UNKNOWN;
-	const char *vendor = "Unknown";
-	const char *name = "Unknown";
+	const char *vendor = NULL;
+	const char *name = NULL;
 
 #ifdef CONFIG_CPU
 	char processor_name[49];
-- 
2.43.0

