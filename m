Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DCB609A716
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Nqb3eEBS;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=sFq+1/VZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85AEF8117B;
	Mon,  2 Nov 2026 16:21:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LY2h6B_DK771; Mon,  2 Nov 2026 16:21:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6889581181
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793636480;
	b=Azyws+Fgbb02ZjJnvWaMRZjkoBg6G7O4uK8+/8ftix/D2QVNlQJCNHHH8+uX1O1xq0Oi
	 65Ic4WU7MlpeVdGyt5h08RvOgMyefqWgw3O4t3Wnq1yLigAJWtSvhlUGVzpBIbB3wWycG
	 YguAxcq0OhJPKiNGeCCoxTL4MvDejDCTXFZblzsBcxKXFNSMr3gsX6tqmN/fiDwVduEuV
	 s9KMZ0cC3K/hULKD6xoRsMRS+pquVI+xaq9yyjAZ3SuJBscy1+IihOLtdT+aBRBB+u4OG
	 IMAbQ64dADM0DpAFJuh6sTFRZKB6vc4zABcPVrYwItGff0Un2mtkHbDQAKzyQs1Qz2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636480;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2fP6YuO++kaZ3TgL/7NZeaMQ8VEOj2vC0mOuvszaktY=;
	b=YJYBq5b5BnGUzkXDST/MU9WxYHL297eberIC0dI32BQyr+1q4B+sJVEyBI0UIYtnjdt5
	 oXc+MH4kmxxigF0lLn3slmVSUC+i8w0YJKwZmmxMj2SHRvZ/KW/dvaX1AB717e/k9baoG
	 oPB+64Gg6CEHqYc6FvEJ91Swg/IGrdWHb7OrlnWM8/Zgx3xA/CiyYPEDncUfrHTZsXrAU
	 C4MptSOOXRAEBHG+gyj8RaFDVEMdPlbNuJY30w3hXJQmNRNr11ELTtOKqRRTVtvrvU8vN
	 NDkqIv2jHWOLOQouA7YU77OhTmMNnOyMvLBjrIhazZpM63J+3XOJbJzUx7dtEOA4oWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=fris.de;
	dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b="sFq+1/VZ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636480;
	bh=2fP6YuO++kaZ3TgL/7NZeaMQ8VEOj2vC0mOuvszaktY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nqb3eEBSCm9NSNy/hrgL7DGKgl+oQLHYzHlQv6b9r0AyIcLo23rUEcPc0kfgOK4WS
	 9BkqYNGFoDyCC/ahQO+/OXvh5vFOTpXxAcUW9yxTtg7iWC2wMxUH9aieHc23tcncz1
	 DPzCp3LhF4SzyyGNBp4F7y0X8u59nxu//xQoA8UrgtY2xUWmVR7Eza413XLUQYtPeL
	 GGLrx+jwrSg+gw+p1k6uxcMIv9LRXcOx9f6Mm4mEeYBlIWhKyDwoK9vvetehibNBOV
	 SEIw6KiPekQuXlQ4VJbfRmPvMjZgWt4b6Gil0aFDkgr7cL9sjilF79FCQZklWj30Lm
	 vVzGDXO/mZv4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6889581181;
	Mon,  2 Nov 2026 16:21:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D82312A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3C99810F4
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aBDpPZvflTkj for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:20:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B45581090
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793636455;
 b=onlp1HtN0F2/Xipaa9g+d1W3V1bZKFi7fLAR2TRx/YhjtfuAf9NimHEgPyHABxpj4owi
 QMWQUBLpdcSE8oPHcvvw4N3RI/FBs0q8RMy0KUYyETyFcIOUt1i8ugflMGpnn+y095sJB
 OKm3AKXbXDKgktKXFKBTSMdCAWWCZQDsC3NF0BclbLbH0xQAskcWTr0lFlwE4Sza4AkAj
 3qEHHvkFrmJbRzGuv+D+GwVHioK3w8WijpAj6qoPxAbp+E51obkE2aSuIju1JkLdguhEd
 m9Dg67JQKSsk9eK2GXlMA5NoZ/zeUNM8/TrRZHxvfXlTUMb37Lw5lFTV9yu7LTHvJYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793636455;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=2fP6YuO++kaZ3TgL/7NZeaMQ8VEOj2vC0mOuvszaktY=;
 b=JouASgreBfqksbFJ1Ja4BykAZCAn7j2CAjmxq3EukClQx5Al+0Ysdc8lAZe3OMsmsc9b
 Q5JEvxtgGDDHqCCMkVXKgonqyl96l2UDxxOafB2SHlR+SkvQIrDP5gn3YZxNUDvGsvjAt
 e+G4mOgYY9zMl232aVD3Z1ErwswGEy7+R4y3GJx8rkgigoilDTKIUAiUv13cRFLitHMwy
 6Ph4Zh1vM6PDGQfWQ3KESWqghI/KlVrGy1UCF6aF9N8Uc6ZTdDWHVBZ8e6L21R6W+EQF+
 azMqsB6fRZxg6L0/kYfIUNXdaYhZ0SJKJx6lhbLqBnUeydeMPxaIynGRAfzooV+6Yig==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b="sFq+1/VZ"; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=sFq+1/VZ
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B45581090
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:54 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793636449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2fP6YuO++kaZ3TgL/7NZeaMQ8VEOj2vC0mOuvszaktY=;
 b=sFq+1/VZkaaum6bmR/jUH3TsH1pE4FrzxHkvsqEDKoZcmCiz5V4z0DcVLo7gYpLdr9AUBJ
 ZT0JfOTZlUtUt3rmvaJabjdf0AGX9J2yy0AH9dsONXKAN+R4By5mh14eqoYfHI1qpndVkJ
 Y0oLGngFtPKL37w9QTG0surkH8spdZkbpKP0qUCl97ByFYAYS7KKIaaNO4GS6QiPgV5Nxa
 V09ZH5/zMpWvan/F/+rx14kPl8BMqaXq7DT/YEZDy38gDnHDfTHJKeKPb9oz1ZyX+0jO8E
 pOiq+vE1lahPYP8Yc4hwj8KL8DpWMd1gkwbbK5D5lEW1BZfzWLqBZoMxiAwaJQ==
Date: Mon, 02 Nov 2026 17:20:25 +0100
Subject: [PATCH v2 08/12] bootstd: rauc: Optionally find the partitions by name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-main-v2-8-4537bcb19d66@kontron.de>
References: <20261102-main-v2-0-4537bcb19d66@kontron.de>
In-Reply-To: <20261102-main-v2-0-4537bcb19d66@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10970;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=bl7ATd6MDkFQY70ANpsUTHOB2IMSB8twldlriQoWVgQ=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevFjljO2nc+hv/+z/2RKXTPdarsrC6nDZPazi9p/flv3
 RZpeeXsjlIWBjEuBlkxRRYpfovXtmaxPvLHqqNg5rAygQxh4OIUgImodzD8Zr8VU1g3/b74tpiJ
 wZNi3rCIzMpnfr5bvf9fx9n2DaePzWD4X6zVwm3+8l7BTQ//dLuYfV0/EtVr1t+VnP7lOk+yGus
 /bgA=
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

Allow to give the boot and root partitions in
CONFIG_BOOTMETH_RAUC_PARTITIONS by their GPT names instead of their
numbers, for example "boot_a,root_a boot_b,root_b". The bootmeth looks
up the names on each device and only uses a device which has the
partitions of all slots, so that it never boots a slot whose partitions
are missing. As only GPT has partition names, this also rejects MBR
devices. A value consisting only of digits is still taken as a
partition number, which keeps the current behaviour.

The bootmeth keeps the partitions in its platform data, which is set
from the option when the bootmeth is bound. This allows tests to check
other layouts at runtime. Also report a slot without a boot or root
partition in the option, instead of passing NULL to simple_strtoul().

Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
- Give the partition names in CONFIG_BOOTMETH_RAUC_PARTITIONS instead
  of the new option CONFIG_BOOTMETH_RAUC_PART_NAMES (Bastien)
- Only use a device which has the partitions of all slots (Simon)
- Keep the partitions in the platform data of the bootmeth, so that
  tests can change them at runtime (Simon)
- Report a slot without a boot or root partition in the option
- Rename from "bootstd: rauc: Optionally check the partition names"
---
 MAINTAINERS                  |   1 +
 boot/Kconfig                 |   7 +++
 boot/bootmeth_rauc.c         | 108 +++++++++++++++++++++++++++++++++++++++----
 doc/develop/bootstd/rauc.rst |   7 +++
 include/bootmeth_rauc.h      |  22 +++++++++
 5 files changed, 136 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index af3ca0f1bf2..63bed54e8bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -846,6 +846,7 @@ F:	drivers/mmc/mmc_bootdev.c
 F:	include/bootdev.h
 F:	include/bootflow.h
 F:	include/bootmeth.h
+F:	include/bootmeth_rauc.h
 F:	include/bootstd.h
 F:	test/boot/
 
diff --git a/boot/Kconfig b/boot/Kconfig
index d4d2a77f15a..072108db64a 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -969,6 +969,13 @@ config BOOTMETH_RAUC_PARTITIONS
 	  The first value in pair is for the boot partition and second for the
 	  root partition.
 
+	  Instead of an index, a value can also be the name of a GPT partition,
+	  for example "boot_a,root_a boot_b,root_b". A device is then only used
+	  if it has partitions with these names for all slots, so the bootmeth
+	  does not claim devices with a different layout. As only GPT has
+	  partition names, this also rejects MBR devices. A value consisting
+	  only of digits is always taken as an index.
+
 config BOOTMETH_RAUC_DEFAULT_TRIES
 	int "RAUC slot default tries"
 	default 3
diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index a32f19303a5..acf9413591b 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -11,6 +11,7 @@
 #include <blk.h>
 #include <bootflow.h>
 #include <bootmeth.h>
+#include <bootmeth_rauc.h>
 #include <bootstd.h>
 #include <dm.h>
 #include <env.h>
@@ -38,11 +39,17 @@ static const char * const script_names[] = { "boot.scr", "boot.scr.uimg", NULL }
  * @name	The slot name
  * @boot_part	The boot partition number on disk
  * @root_part	The root partition number on disk
+ * @boot_part_name	The name of the boot partition, or NULL if it is given by
+ *			its number
+ * @root_part_name	The name of the root partition, or NULL if it is given by
+ *			its number
  */
 struct distro_rauc_slot {
 	char *name;
 	int boot_part;
 	int root_part;
+	char *boot_part_name;
+	char *root_part_name;
 };
 
 /**
@@ -55,14 +62,20 @@ struct distro_rauc_priv {
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
@@ -89,6 +102,60 @@ static struct distro_rauc_slot *get_slot(struct distro_rauc_priv *priv,
 	return NULL;
 }
 
+/**
+ * distro_rauc_parse_part() - Parse a partition of a slot
+ *
+ * @str: Partition number, or name of a GPT partition
+ * @part: Returns the partition number, if @str is a number
+ * @name: Returns a copy of @str, if it is not a number
+ * Return: 0 if OK, -EINVAL if @str is empty, -ENOMEM if out of memory
+ */
+static int distro_rauc_parse_part(const char *str, int *part, char **name)
+{
+	if (!str || !*str)
+		return log_msg_ret("part", -EINVAL);
+
+	if (strspn(str, "0123456789") == strlen(str)) {
+		*part = simple_strtoul(str, NULL, 10);
+		return 0;
+	}
+
+	*name = strdup(str);
+	if (!*name)
+		return log_msg_ret("buf", -ENOMEM);
+
+	return 0;
+}
+
+/**
+ * distro_rauc_find_parts() - Find the partitions of a slot by their names
+ *
+ * @desc: Block device to search
+ * @slot: Slot to update, if its partitions are given by name
+ * Return: 0 if OK, -ENOENT if a partition was not found
+ */
+static int distro_rauc_find_parts(struct blk_desc *desc,
+				  struct distro_rauc_slot *slot)
+{
+	struct disk_partition info;
+	int part;
+
+	if (slot->boot_part_name) {
+		part = part_get_info_by_name(desc, slot->boot_part_name, &info);
+		if (part < 0)
+			return log_msg_ret("boot", -ENOENT);
+		slot->boot_part = part;
+	}
+	if (slot->root_part_name) {
+		part = part_get_info_by_name(desc, slot->root_part_name, &info);
+		if (part < 0)
+			return log_msg_ret("root", -ENOENT);
+		slot->root_part = part;
+	}
+
+	return 0;
+}
+
 static int distro_rauc_check(struct udevice *dev, struct bootflow_iter *iter)
 {
 	/*
@@ -121,6 +188,15 @@ static int distro_rauc_scan_parts(struct bootflow *bflow)
 	if (!priv || !priv->slots)
 		return log_msg_ret("priv", -EINVAL);
 
+	/* With partition names, the partitions of all slots must exist */
+	if (desc) {
+		for (i = 0; priv->slots[i]; i++) {
+			ret = distro_rauc_find_parts(desc, priv->slots[i]);
+			if (ret)
+				return ret;
+		}
+	}
+
 	/* BOOT_ORDER is only set once a device has been found */
 	boot_order = env_get("BOOT_ORDER");
 	if (!boot_order)
@@ -198,6 +274,7 @@ static int distro_rauc_set_defaults(void)
 
 static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 {
+	const struct distro_rauc_plat *rplat = dev_get_plat(dev);
 	struct distro_rauc_priv *priv = NULL;
 	int ret = 0;
 	char *slot;
@@ -226,7 +303,7 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 		ret = log_msg_ret("buf", -ENOMEM);
 		goto rauc_read_bootflow_err;
 	}
-	partitions = strdup(CONFIG_BOOTMETH_RAUC_PARTITIONS);
+	partitions = strdup(rplat->partitions);
 	if (!partitions) {
 		ret = log_msg_ret("buf", -ENOMEM);
 		goto rauc_read_bootflow_err;
@@ -252,13 +329,23 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 			ret = log_msg_ret("buf", -ENOMEM);
 			goto rauc_read_bootflow_err;
 		}
-		s->boot_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
-		s->root_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
+		ret = distro_rauc_parse_part(strsep(&parts, ","), &s->boot_part,
+					     &s->boot_part_name);
+		if (!ret)
+			ret = distro_rauc_parse_part(strsep(&parts, ","),
+						     &s->root_part,
+						     &s->root_part_name);
+		if (ret) {
+			if (ret == -EINVAL)
+				log_err("ERROR: Invalid partitions for slot %s\n",
+					slot);
+			distro_rauc_slot_free(s);
+			goto rauc_read_bootflow_err;
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
@@ -527,9 +614,11 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 static int distro_rauc_bootmeth_bind(struct udevice *dev)
 {
 	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
+	struct distro_rauc_plat *rplat = dev_get_plat(dev);
 
 	plat->desc = "RAUC distro boot from MMC";
 	plat->flags = BOOTMETHF_ANY_PART;
+	rplat->partitions = CONFIG_BOOTMETH_RAUC_PARTITIONS;
 
 	return 0;
 }
@@ -552,4 +641,5 @@ U_BOOT_DRIVER(bootmeth_rauc) = {
 	.of_match	= distro_rauc_bootmeth_ids,
 	.ops		= &distro_rauc_bootmeth_ops,
 	.bind		= distro_rauc_bootmeth_bind,
+	.plat_auto	= sizeof(struct distro_rauc_plat),
 };
diff --git a/doc/develop/bootstd/rauc.rst b/doc/develop/bootstd/rauc.rst
index 5afd705dcb1..eee8d103fb9 100644
--- a/doc/develop/bootstd/rauc.rst
+++ b/doc/develop/bootstd/rauc.rst
@@ -14,6 +14,13 @@ filesystem each. The partition numbers must be specified with
 the following syntax: ``1,2 3,4``, where 1 and 3 are the slots' boot partition
 and 2 and 4 the slots' root partition.
 
+Instead of their numbers, the partitions can also be given by their GPT
+partition names, for example ``boot_a,root_a boot_b,root_b``. The bootmeth then
+only uses a device if it has partitions with these names for all slots. This
+prevents it from claiming devices with a different layout which happen to have
+a filesystem in the first partition. A value consisting only of digits is
+always taken as a partition number.
+
 Each pair of boot and rootfs partition form a "slot". The default order in which
 available slots are tried is set through ``CONFIG_BOOTMETH_RAUC_BOOT_ORDER``,
 with the left one tried first.
diff --git a/include/bootmeth_rauc.h b/include/bootmeth_rauc.h
new file mode 100644
index 00000000000..0faeab192d4
--- /dev/null
+++ b/include/bootmeth_rauc.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Bootmethod for distro boot with RAUC
+ */
+
+#ifndef __BOOTMETH_RAUC_H
+#define __BOOTMETH_RAUC_H
+
+/**
+ * struct distro_rauc_plat - Platform data of the RAUC bootmeth
+ *
+ * This is set from Kconfig when the bootmeth is bound. Tests can change it
+ * afterwards to check other configurations.
+ *
+ * @partitions: Boot and root partitions of each slot, given by number or
+ *	by name, see CONFIG_BOOTMETH_RAUC_PARTITIONS
+ */
+struct distro_rauc_plat {
+	const char *partitions;
+};
+
+#endif

-- 
2.56.0

