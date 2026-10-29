Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4FE606A31E
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BzBBWVE+;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=KqbkjFHl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 880A9810D9;
	Thu, 29 Oct 2026 16:23:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dFROuyaIf4Bd; Thu, 29 Oct 2026 16:23:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6613781094
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793291034;
	b=lcn6XQjb9DB0QNRq6iaMBYkXCPOIun4PmDY3MlhWE7t262vtgqignZCruUpfZBcYcBqc
	 DfDoHwJD/0WdGsxphssfIQLSPuYYzi2pAM+l4XGsXkRK2zXCxYz3LwGpn3QeImtX9noKd
	 CduFuHCQTRb/Ky9JO0qKHvBKc84y76RHBtP2SqhyS1Lv7F9uBL2y+fOn3yIMgZmZMBG1j
	 a7etu+G08e8TuJFz0J8QJizBCchM9wdJsS8KYN+rI/4T1/TiPdOoq3J2gs1bSBAClsDnl
	 6RldRv/BUkqETLdr9vu98qAffzozkm1HrpaGzQj1U3KBp/kVq+U5jdakDnwt5OQboJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793291034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IZ9LNO793nHOgEpyJc0WVd6R1h6x2yECIgvhWypuCnk=;
	b=czqZVixBzopDcJCGQSigDRpQ7BygUK6d0ohuL5U4lEZ/CGUyis7o0NUzV1wGLo9/34Ym
	 2C9dT3qXW6Myz8H3jZ85U1V6NNsH8u/pfyzE1PK2OWJjPIJxbOYHoiijEbaHjnkBr7OAR
	 r1KH4xkwEec081rNTdMAw6e0NBj4MV97GY9O0P2/rX+4VMs/WHxvncMXul+31edMVluf5
	 FgmBVkUzeF6qdBPFCgISRHenF/Qk0kWugU2e/6YyTMxtbJr6sdsD7AgbSDVQSpVQ0xzCP
	 n/y5uWHxdX7MW0HN11ZYumZ/k252VhQQ9QggP8ZqoHYXChRTB0vRPswC6oHAkewfx2w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=fris.de;
	dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=KqbkjFHl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793291034;
	bh=IZ9LNO793nHOgEpyJc0WVd6R1h6x2yECIgvhWypuCnk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BzBBWVE+j6cid+1DIqh2jpYq9KgAEpHvyLnyNPdWdtO7FjjFg+9vWwbyXXUmw+Oxj
	 4DHnWNiZXPzFBrPsLm6QBGV/Cbc8SP/gjILMUaQA76r1TyNxcsQY/OaIy8bvu0DfQC
	 dAjepfq0AsBU4DR9pF3p2bez8lO867Ug5EpWcBwN6UeXFNWXVEj1yfwrhG8oGyk5dV
	 tNoc9ugHCTHkKfq16eW46fNFWTYEkdtSDU1kNACDtsgb7sO47SfMnjp82obUGldPFD
	 he+rmKJoYxqKAxk25n1RprzQoheI63qxPakCZdi4ec5E+ZlliXEnLy+xXZSQlIC57B
	 xraohkRtsfZZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6613781094;
	Thu, 29 Oct 2026 16:23:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2228E362
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0887980FB9
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PJkT2dqhml_9 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:23:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B121E80FB4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793291012;
 b=LbOx4QxR7YwgoeYmOqsO7IbNK8rTneWsUZbS7IjZxdvo3tf9IX3ZONQ7tmhWhXU0n9eg
 /JhKWKlJLSYulhkbgpqtE1cLsuDh9OXQ8En84T/xSWYVCsZDhLeNWvHaAU3NVl4OMqaQm
 fMowgdnryppcuquh5TYkOAK20Li2n/NswzlUlucblHZ+Y0klnPSST9Ui6AbbCw61W2BDK
 6/q+/4kW1qmioYAllmS2lTZ6vxML9Ugl+cX06BV8fW1CxXslnFjmScRKe9c/a9CJzuiOc
 MgiLk2wV4xJ7PF6oaSSc6r2lw91BaUf4afXBjNKeDgSrEgX9ehXy+o+C/JFEyNElH5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793291012;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=IZ9LNO793nHOgEpyJc0WVd6R1h6x2yECIgvhWypuCnk=;
 b=Ct2FLKjRPG3KoytWTmuLOpW5vVk+FKA+21RN5PuAu+twJclGWpCWCOv3eQcFNquQTI98
 ff5jO2BAt9wPpjC/CGy25U5UxqeBarbuRqzj34lgK2z8LYfGjpTZ4M4W7UJUzK7UmGRDT
 XtfauZc7NRXpVBlxadV3W4TyJm0fayf3Lne3yVYSf+Xc0wB93WB3E5Gm+n/qxAS37DoNA
 ZDBEsjdBLByOOfrdZ3hF66ecETrDgba/t/l1edz5RIVj7bsT6ZY/Ye9VOJxz321oEalc0
 NH7eB008ME3CiFUsNO+FaGEuqMN3YJ20qSA+bZXwnhaYce+UamRjRRrskQwmLafhcmw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=KqbkjFHl; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=KqbkjFHl
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B121E80FB4
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:31 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793291006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZ9LNO793nHOgEpyJc0WVd6R1h6x2yECIgvhWypuCnk=;
 b=KqbkjFHlOwzcQFdC6xsnVLqGC1OVDKLoMvmfzSg6IgLbYZ+UlcRBz9zOM/RdZX8cI8Vc8o
 U2JA2muvCE2xKmksVk6NDjGY4eZRt8ksO/C/ROu9gQSjgfk0Vk+Tx1fhjSJFwA5JAzE+/w
 48G9i7tL9CHbk4g26upfnQ0oxzkBykm02MmHtShRZVbEAT3DZpltb1SHuW/S0+VtWm+kYi
 U8NlFiAWBkKfTov0JBOIpOQugU01FKJeIdobGSrdCkkKGvkY8Ms2hzZxNvJUBZ2S3ofUD9
 uUJfpgeuxxx9Tobd5QRwgUIYBM1rCqnNZ4Lod6ZwKJL5bxeu9R0T3YQpiJToTA==
Date: Thu, 29 Oct 2026 17:23:12 +0100
Subject: [PATCH 06/10] bootstd: rauc: Optionally check the partition names
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-main-v1-6-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
In-Reply-To: <20261029-main-v1-0-b5a878627107@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7700;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=HnxqS1cf5BlsDURfbFCS5jAh28UF2VEYEL+v0QFDIbI=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIetx0a9i+d47j5P1OtO/zlWLnMAc8vf999Do4rRcg4eLZ
 LV4p7Z0lLIwiHExyIopskjxW7y2NYv1kT9WHQUzh5UJZAgDF6cATGSSMSPDeUWHnZteN6Raav/a
 +uBTecLm/KJN0r5zGOT/VRxmXvS6n5HhbNCaRlGZlOWPeBbK7F5ac/Rq8//cPr8TCaU1nFHJG9V
 ZAA==
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The RAUC bootmeth uses any MMC device on which the boot partition of a
slot holds a filesystem and the root partition exists. This also matches
devices with a different layout, for example a single-system image or a
standard distro installed to eMMC. The bootmeth then claims such a
device and creates and saves its BOOT_ORDER and BOOT_x_LEFT variables in
the environment, which makes it difficult to run BOOTMETH_RAUC alongside
other bootmeths.

Add CONFIG_BOOTMETH_RAUC_PART_NAMES to set the expected names of the
boot and root partitions of each slot, in the same format as
CONFIG_BOOTMETH_RAUC_PARTITIONS. If set, a slot only counts if its
partitions carry these names. As only GPT provides partition names,
this also rejects MBR devices. The option is empty by default, which
keeps the current behaviour.

Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 boot/Kconfig                 | 13 +++++++++
 boot/bootmeth_rauc.c         | 68 ++++++++++++++++++++++++++++++++++++++++----
 doc/develop/bootstd/rauc.rst |  7 +++++
 3 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 8fcdc36c931..5f89c9d86fa 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -968,6 +968,19 @@ config BOOTMETH_RAUC_PARTITIONS
 	  The first value in pair is for the boot partition and second for the
 	  root partition.
 
+config BOOTMETH_RAUC_PART_NAMES
+	string "RAUC boot and root partition names"
+	default ""
+	help
+	  Sets the expected names of the boot and root partitions of each slot,
+	  for example "boot_a,root_a boot_b,root_b". The format is the same as
+	  for BOOTMETH_RAUC_PARTITIONS, with names instead of indexes, and each
+	  pair belongs to the slot at the same position.
+
+	  A device is only used if at least one slot's partitions carry these
+	  names. Partition names are only available on GPT, so this rejects
+	  MBR devices. Leave this empty to not check the names.
+
 config BOOTMETH_RAUC_DEFAULT_TRIES
 	int "RAUC slot default tries"
 	default 3
diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 3bb9a2ace3d..ff2e2d48145 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -37,11 +37,15 @@ static const char * const script_names[] = { "boot.scr", "boot.scr.uimg", NULL }
  * @name	The slot name
  * @boot_part	The boot partition number on disk
  * @root_part	The root partition number on disk
+ * @boot_part_name	The expected boot partition name, or NULL to not check it
+ * @root_part_name	The expected root partition name, or NULL to not check it
  */
 struct distro_rauc_slot {
 	char *name;
 	int boot_part;
 	int root_part;
+	char *boot_part_name;
+	char *root_part_name;
 };
 
 /**
@@ -54,14 +58,20 @@ struct distro_rauc_priv {
 	struct distro_rauc_slot **slots;
 };
 
+static void distro_rauc_slot_free(struct distro_rauc_slot *slot)
+{
+	free(slot->name);
+	free(slot->boot_part_name);
+	free(slot->root_part_name);
+	free(slot);
+}
+
 static void distro_rauc_priv_free(struct distro_rauc_priv *priv)
 {
 	int i;
 
-	for (i = 0; priv->slots[i]; i++) {
-		free(priv->slots[i]->name);
-		free(priv->slots[i]);
-	}
+	for (i = 0; priv->slots[i]; i++)
+		distro_rauc_slot_free(priv->slots[i]);
 	free(priv->slots);
 	free(priv);
 }
@@ -88,6 +98,19 @@ static struct distro_rauc_slot *get_slot(struct distro_rauc_priv *priv,
 	return NULL;
 }
 
+static bool distro_rauc_part_name_ok(struct blk_desc *desc, int part,
+				     const char *name)
+{
+	struct disk_partition info;
+
+	if (!name)
+		return true;
+	if (part_get_info(desc, part, &info))
+		return false;
+
+	return !strcmp((char *)info.name, name);
+}
+
 static int distro_rauc_check(struct udevice *dev, struct bootflow_iter *iter)
 {
 	/*
@@ -138,6 +161,11 @@ static int distro_rauc_scan_parts(struct bootflow *bflow)
 			ret = part_get_info(desc, slot->root_part, &fs_info);
 			if (ret)
 				continue;
+			if (!distro_rauc_part_name_ok(desc, slot->boot_part,
+						      slot->boot_part_name) ||
+			    !distro_rauc_part_name_ok(desc, slot->root_part,
+						      slot->root_part_name))
+				continue;
 			slot_found = true;
 		}
 	}
@@ -164,6 +192,8 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 	char *boot_order_cursor;
 	char boot_left[BOOT_LEFT_LEN];
 	char *parts;
+	char *part_names = NULL;
+	char *part_names_cursor;
 
 	/* Get RAUC variables or set their default values */
 	boot_order = env_get("BOOT_ORDER");
@@ -211,8 +241,14 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 		ret = log_msg_ret("buf", -ENOMEM);
 		goto rauc_read_bootflow_err;
 	}
+	part_names = strdup(CONFIG_BOOTMETH_RAUC_PART_NAMES);
+	if (!part_names) {
+		ret = log_msg_ret("buf", -ENOMEM);
+		goto rauc_read_bootflow_err;
+	}
 
 	partitions_cursor = partitions;
+	part_names_cursor = part_names;
 	boot_order_cursor = boot_order_copy;
 	for (i = 1;
 	     (parts = strsep(&partitions_cursor, " ")) &&
@@ -234,11 +270,29 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 		}
 		s->boot_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
 		s->root_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
+		if (CONFIG_BOOTMETH_RAUC_PART_NAMES[0]) {
+			char *names = strsep(&part_names_cursor, " ");
+			char *boot_name = names ? strsep(&names, ",") : NULL;
+			char *root_name = names ? strsep(&names, ",") : NULL;
+
+			if (!boot_name || !*boot_name || !root_name || !*root_name) {
+				log_err("ERROR: No partition names for slot %s\n", slot);
+				distro_rauc_slot_free(s);
+				ret = log_msg_ret("names", -EINVAL);
+				goto rauc_read_bootflow_err;
+			}
+			s->boot_part_name = strdup(boot_name);
+			s->root_part_name = strdup(root_name);
+			if (!s->boot_part_name || !s->root_part_name) {
+				distro_rauc_slot_free(s);
+				ret = log_msg_ret("buf", -ENOMEM);
+				goto rauc_read_bootflow_err;
+			}
+		}
 		new_slots = realloc(priv->slots, (i + 1) *
 				    sizeof(struct distro_rauc_slot));
 		if (!new_slots) {
-			free(s->name);
-			free(s);
+			distro_rauc_slot_free(s);
 			ret = log_msg_ret("buf", -ENOMEM);
 			goto rauc_read_bootflow_err;
 		}
@@ -257,6 +311,7 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 
 	free(boot_order_copy);
 	free(partitions);
+	free(part_names);
 
 	return 0;
 
@@ -265,6 +320,7 @@ rauc_read_bootflow_err:
 	bflow->bootmeth_priv = NULL;
 	free(boot_order_copy);
 	free(partitions);
+	free(part_names);
 
 	return ret;
 }
diff --git a/doc/develop/bootstd/rauc.rst b/doc/develop/bootstd/rauc.rst
index 5afd705dcb1..dfbe010a60f 100644
--- a/doc/develop/bootstd/rauc.rst
+++ b/doc/develop/bootstd/rauc.rst
@@ -14,6 +14,13 @@ filesystem each. The partition numbers must be specified with
 the following syntax: ``1,2 3,4``, where 1 and 3 are the slots' boot partition
 and 2 and 4 the slots' root partition.
 
+Optionally, ``CONFIG_BOOTMETH_RAUC_PART_NAMES`` gives the expected GPT
+partition names in the same format, for example
+``boot_a,root_a boot_b,root_b``. The bootmeth then only uses a device if the
+partitions of at least one slot carry these names. This prevents it from
+claiming devices with a different layout which happen to have a filesystem in
+the first partition. If empty, the names are not checked.
+
 Each pair of boot and rootfs partition form a "slot". The default order in which
 available slots are tried is set through ``CONFIG_BOOTMETH_RAUC_BOOT_ORDER``,
 with the left one tried first.

-- 
2.56.0

