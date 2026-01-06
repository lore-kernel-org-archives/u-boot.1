Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAD4CEFD18
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 22:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BFA583B9B;
	Tue,  6 Jan 2026 23:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="O/+z5OxZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F10CA83C4B; Tue,  6 Jan 2026 23:22:27 +0100 (CET)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB21483B86
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 23:22:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1767738145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iFmCkd2VN6/CB1kU+cp87tmvEdgBFf1m4B6XIvm24Vw=;
 b=O/+z5OxZ0KOdn1FOhLHfHX1wYDOS2KgYgMoMYcTe8TGtBHvfdXtN9lKTlJJPV5J+rmAa4C
 7IOBV4GUm8aL1vUFn7rhEJYCl7zxVP8qOkrWB7pEaqFhNO0Ohk5vC6w7vlKs3LNpffCDT1
 hIzVAReCB2ioa7c42NUp4GMgfHYOeHc=
From: Sean Anderson <sean.anderson@linux.dev>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] dfu: Report error codes
Date: Tue,  6 Jan 2026 17:22:11 -0500
Message-Id: <20260106222212.744823-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

A lot of things can go wrong while parsing dfu_alt_info. Make sure to
pass the real error codes all the way up instead of replacing them with
an unhelpful -1.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/dfu/dfu.c | 52 ++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
index eefdf44ec87..90d8b45ce8a 100644
--- a/drivers/dfu/dfu.c
+++ b/drivers/dfu/dfu.c
@@ -185,7 +185,7 @@ int dfu_init_env_entities(char *interface, char *devstr)
 		ret = dfu_config_entities(env_bkp, interface, devstr);
 
 	if (ret) {
-		pr_err("DFU entities configuration failed!\n");
+		pr_err("DFU entities configuration failed: %d\n", ret);
 		pr_err("(partition table does not match dfu_alt_info?)\n");
 		goto done;
 	}
@@ -518,7 +518,7 @@ static int dfu_fill_entity(struct dfu_entity *dfu, char *s, int alt,
 			   char *interface, char *devstr)
 {
 	char *argv[DFU_MAX_ENTITY_ARGS];
-	int argc;
+	int argc, ret;
 	char *st;
 
 	debug("%s: %s interface: %s dev: %s\n", __func__, s, interface, devstr);
@@ -547,30 +547,37 @@ static int dfu_fill_entity(struct dfu_entity *dfu, char *s, int alt,
 
 	/* Specific for mmc device */
 	if (strcmp(interface, "mmc") == 0) {
-		if (dfu_fill_entity_mmc(dfu, devstr, argv, argc))
-			return -1;
+		ret = dfu_fill_entity_mmc(dfu, devstr, argv, argc);
+		if (ret)
+			return ret;
 	} else if (strcmp(interface, "mtd") == 0) {
-		if (dfu_fill_entity_mtd(dfu, devstr, argv, argc))
-			return -1;
+		ret = dfu_fill_entity_mtd(dfu, devstr, argv, argc);
+		if (ret)
+			return ret;
 	} else if (strcmp(interface, "nand") == 0) {
-		if (dfu_fill_entity_nand(dfu, devstr, argv, argc))
-			return -1;
+		ret = dfu_fill_entity_nand(dfu, devstr, argv, argc);
+		if (ret)
+			return ret;
 	} else if (strcmp(interface, "ram") == 0) {
-		if (dfu_fill_entity_ram(dfu, devstr, argv, argc))
-			return -1;
+		ret = dfu_fill_entity_ram(dfu, devstr, argv, argc);
+		if (ret)
+			return ret;
 	} else if (strcmp(interface, "sf") == 0) {
-		if (dfu_fill_entity_sf(dfu, devstr, argv, argc))
-			return -1;
+		ret = dfu_fill_entity_sf(dfu, devstr, argv, argc);
+		if (ret)
+			return ret;
 	} else if (strcmp(interface, "virt") == 0) {
-		if (dfu_fill_entity_virt(dfu, devstr, argv, argc))
-			return -1;
+		ret = dfu_fill_entity_virt(dfu, devstr, argv, argc);
+		if (ret)
+			return ret;
 	} else if (strcmp(interface, "scsi") == 0) {
-		if (dfu_fill_entity_scsi(dfu, devstr, argv, argc))
-			return -1;
+		ret = dfu_fill_entity_scsi(dfu, devstr, argv, argc);
+		if (ret)
+			return ret;
 	} else {
 		printf("%s: Device %s not (yet) supported!\n",
 		       __func__,  interface);
-		return -1;
+		return -EOPNOTSUPP;
 	}
 	dfu_get_buf(dfu);
 
@@ -624,12 +631,12 @@ int dfu_alt_add(struct dfu_entity *dfu, char *interface, char *devstr, char *s)
 	int ret;
 
 	if (alt_num_cnt >= dfu_alt_num)
-		return -1;
+		return -EINVAL;
 
 	p_dfu = &dfu[alt_num_cnt];
 	ret = dfu_fill_entity(p_dfu, s, alt_num_cnt, interface, devstr);
 	if (ret)
-		return -1;
+		return ret;
 
 	list_add_tail(&p_dfu->list, &dfu_list);
 	alt_num_cnt++;
@@ -645,16 +652,15 @@ int dfu_config_entities(char *env, char *interface, char *devstr)
 
 	ret = dfu_alt_init(dfu_find_alt_num(env), &dfu);
 	if (ret)
-		return -1;
+		return ret;
 
 	for (i = 0; i < dfu_alt_num; i++) {
 		s = strsep(&env, ";");
 		s = skip_spaces(s);
 		ret = dfu_alt_add(dfu, interface, devstr, s);
-		if (ret) {
+		if (ret)
 			/* We will free "dfu" in dfu_free_entities() */
-			return -1;
-		}
+			return ret;
 	}
 
 	return 0;
-- 
2.35.1.1320.gc452695387.dirty

base-commit: 38ace442b630c5ddf049af83e8db229c012ed355
branch: dfu_err
