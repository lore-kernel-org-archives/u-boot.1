Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C16606A33A
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=axrKpy9N;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oYxklcLM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71D3C40AA1;
	Wed, 11 Nov 2026 13:14:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cP-6YnVsRJxT; Wed, 11 Nov 2026 13:14:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 42A4A40AAA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794402872;
	b=hImp85657CFZz7uiWTWoCGQYSdilvt/XOg1FoqLfnhCkG6Z5xNY3gY/Ucs4TvaVmX5ql
	 wPn319etofGH1qEiI1K7JrsAVhuZG/6uuLBRhqEuSJGAYb6eEBs4R8j/cU46mj794aGWV
	 zhe5A1j9CK5MRygDzT21QbhBYxAPiIkAxVnONsVSgTpbaGENyyNJnUWPs0VRkapVgZCaI
	 1Ol3T7c9gvw6IzHZctuduDAedozAWnwcE0fd1g3O4UoyYu63UVTNPqKTDw6MVRa7oJsVR
	 RdCeVJJtSTCA1C+clv0DJd9c907uFoalzrOflo7BBjwlo5TD8xQ1/kRQhbrYVSSeDgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794402872;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lV2703t6IMnDKV737dvb/NwU1gULeQi2mRhYGABPH94=;
	b=dFT4MHPTC+wTylJJHIV/wzrK4DYWiBko3wQVFbtlGovEe5Glr0yV/mz+fIjNE2eVQ0E2
	 ucDG5pP4QK/i2EN/qAsWvIiqorKzNyoNWJt/D23/TfC0Gd0ESA2SkXwp7FFAab5wMTes7
	 NgIXT6ju34I9U2s8avXKqsmrrCKN12jtt1GlLpgfPwpZ3LH5seTeFCJn4YsFqLxRvxMVi
	 3m8KU1HJbEC6Z6h8OcdJqX1MVkvv+9OYezLhk7oQjoBJUtGECw/zSrvvkumfKZK2fseSR
	 xuhp2mloeGh2ggF5GCoZ+fprLpXOrPvHHxt0aiJxOUD4Ins/w+LnFQJ3GhrXaZE8fjA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794402872;
	bh=lV2703t6IMnDKV737dvb/NwU1gULeQi2mRhYGABPH94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=axrKpy9NYkq1ZMwjImQg3CuxueqfxcEsyWzgHun0SCpQxsFOBX5772nxlQI8Vi5Ku
	 HhRVZKMsAIopJQXu2/qMctL/XweV9Qgwn9mcmRb6RUMvRrSZnM5SU6jhtp9lYoMoB9
	 cN1QtlwaC7vNgNQb8uQcsWGFccYvrnk/DwTcqEXtV4UvEmONdm/NEIOp9WQdU1wa3q
	 VmM1ZfUaG9ESAwAVFtXOc4KAPDwWV6kFfDdKUupvijygkxQnJDML2QYDDa4hvuqlRU
	 V13377oopv8OzG5Ii/y8SN6oIQyoREihObFjaVraOauzN6jhos2hLyZSWyljq8O21L
	 2RgQagft8v+Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42A4A40AAA;
	Wed, 11 Nov 2026 13:14:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D1E5417CC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3CA081270
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:13:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iAoNLy_2lsSn for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 09:13:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5F65A811F5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=igor.opaniuk@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=oYxklcLM
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F65A811F5
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:13:39 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b408f2d936so4556495a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794388418; x=1794993218;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lV2703t6IMnDKV737dvb/NwU1gULeQi2mRhYGABPH94=;
 b=oYxklcLMdJurYVeOEjWAJiamS4PBZ4N1Lnf58j9LdO5WUcOnB8sn3ZAPOdlvjX7jhj
 Fu/BfZpgPtqbieBgJC6/CDj4IETGRHeYh/YzctWPtzLBmUspOCafCAdP7eOBqLQwcRdE
 ZcQrhgu0zTkYcgGy49j9kgcuqmaK5dzwghZJu7ZytTU96VbbuIKFBl2oO2Cn4DyXrEf3
 +Q8aM55Ml0Z5km5hfyp5Fvrgb92UbGMbu+8BlCQYPsyKbWpDg3wsERZYoSPVgFTpoHfh
 8pCblJqH4St7rlwMJSqAF5yzzYmOcFk2tVt2aQjsiZONt4G01KQ5aPNnN9uqvSMQKIR5
 6PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794388418; x=1794993218;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lV2703t6IMnDKV737dvb/NwU1gULeQi2mRhYGABPH94=;
 b=ES9GpWel9MehMOAuLLwKQb2sX0XUMdkGDk6i0IR9yovfWjB+QmErhJISyNSCRrSScl
 q/HO3xeEW/1d5+sQMQZjc5RyZ81ULFlOpCGV4AFdsE8pIAa6vq76OsDBr3Khhv/9mmmt
 xy3+4PV++uG4/Sr5DTiYbklZS6qglabDL457736S+UQGbGWp/r1yQLwUywO0aoGtRbzE
 i8GrhEKV66O9jU/89wVwO0+1Ypl9iXzNsc1fIDkfrK7GoVtlIDwlrQQg2C5g7VPq6JME
 DI47YYp9KRkTiYcxang/ZuzwJGN8ZE99FBa1gdUuf1bTXySTX4YsUHY0n/TsKPpPBbdt
 xHxA==
X-Forwarded-Encrypted: i=1;
 AL+hErE4GV2Riq2EvWInr6/qW8jirQi0NEU698A0Bl6ym3W4uF0u0zefhGOOc3ts1CUo24CvGOq7/b4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+AV74Qd08VKG90XgRdmX24ieaBIJeTg3V5/yrKWh9NgmrW6Yht
 CJHEqV5IeF2nikaM4FtvNkhE8DfpoSTIJMDINKt0TE/tiz3/VrlJ4I3g
X-Gm-Gg: AYBFou1zHWMeOCGOfssP2Nh7iQW70n1SLc1viwy3uhY4AqJFiW+JW5JsZm0/U+aJTPZ
 H7kr8FDTNg/vnmrpHz3HSPSgWLOHnk6DnnAlumQHMFNRtlpwEfGmurSxQ70E2OfbQ9fN6R97oqF
 ibMxo7cwEYtQRFBtEHpEbr1tLJHzkYxYsxOTmtCC27p1Ya8AGzJ3XEddsK169wD18njyxs5MNtE
 GtS8sRvn8Ko7TfqfiAvszLACOzy/QJ3hXZT/dc/0Ob21mZ6Wpa6k4Vpj8t9ib172eAmNR0mk5HB
 fnL7ZELqgkeoAdrEITEZN/J2NUdK9CF2F77d0Y/ZoEufNVmNk4OHI+acqaSduFFxTDyhQW+Tjl/
 N2W7b6a6iZz2iM1JnCbtzrzcGLuizvZOab8yFEBttGMtqrlynjd+NZgkJObA4rnPWTL5fw1o3h3
 nPIXdXBJNWPoWDAG/XtWS29HRY2ISxiBwx+Lp8cfIVYVkDtEbz3lUDETBeH8b+EwJiiwG0F1EZa
 1pRxUzMuJegk+vcdsrbs3N/haI9jhHpkxn2q3oAybbol3IvJ2hWrj4dSJCFny/e+a/6Lq+7haYg
 xpKj7rbGb9gay+Z7vyocDpWec3qze+Wl71nJPAODObxAJ84NEqJYyZqwL36gE/fQ1v3xV/NRslV
 VCSnp7Wus+06iG4k=
X-Received: by 2002:a05:6402:1e93:b0:6b7:8bce:d2c3 with SMTP id
 4fb4d7f45d1cf-6b78bced8fdmr372340a12.25.1794388417329; 
 Wed, 11 Nov 2026 01:13:37 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7579047c9sm2155257a12.33.2026.11.11.01.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:13:36 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Wed, 11 Nov 2026 10:13:32 +0100
Subject: [PATCH 1/3] bootstd: android: update the rollback indexes of a
 known-good slot
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-upstream-android_rollback_misc_b4-v1-1-47d17e8a5d92@gmail.com>
References: <20261111-upstream-android_rollback_misc_b4-v1-0-47d17e8a5d92@gmail.com>
In-Reply-To: <20261111-upstream-android_rollback_misc_b4-v1-0-47d17e8a5d92@gmail.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:14:06 +0000
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

libavb only checks the rollback indexes of the images against the stored
ones. Storing the new values is left to the bootloader [1], and the
Android bootmeth never did it, so the stored indexes never advanced and
older, vulnerable images kept verifying.

Raise the stored indexes to those of the verified slot before booting
it. With A/B, wait until Android has marked the slot successful, so a
failed update can still fall back to the previous slot. Without the
OP-TEE AVB TA there is nowhere to store them and nothing is written.

[1] https://android.googlesource.com/platform/external/avb/+/refs/tags/android-17.0.0_r1/README.md#updating-stored-rollback-indexes

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---
 boot/android_ab.c       | 34 ++++++++++++++++++++++++++++++++++
 boot/bootmeth_android.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 common/avb_verify.c     | 35 +++++++++++++++++++++++++++++++++++
 include/android_ab.h    | 19 +++++++++++++++++++
 include/avb_verify.h    | 16 ++++++++++++++++
 5 files changed, 152 insertions(+)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index f2b1110aa24..48745f2c2d2 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -376,6 +376,40 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 	return slot;
 }
 
+int ab_get_control(struct blk_desc *dev_desc,
+		   const struct disk_partition *part_info,
+		   struct bootloader_control *abc)
+{
+	struct bootloader_control *disk_abc;
+	int ret;
+
+	if (!dev_desc || !part_info || !abc)
+		return -EINVAL;
+
+	ret = ab_control_create_from_disk(dev_desc, part_info, &disk_abc, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = -ENODATA;
+	if (disk_abc->crc32_le != ab_control_compute_crc(disk_abc))
+		log_debug("ANDROID: Invalid A/B metadata CRC-32\n");
+	else if (disk_abc->magic != BOOT_CTRL_MAGIC)
+		log_debug("ANDROID: Unknown A/B metadata: %.8x\n", disk_abc->magic);
+	else if (disk_abc->version > BOOT_CTRL_VERSION)
+		log_debug("ANDROID: Unsupported A/B metadata version: %u\n",
+			  disk_abc->version);
+	else if (disk_abc->nb_slot > ARRAY_SIZE(disk_abc->slot_info))
+		log_debug("ANDROID: Wrong number of slots %u\n", disk_abc->nb_slot);
+	else
+		ret = 0;
+
+	if (!ret)
+		memcpy(abc, disk_abc, sizeof(*abc));
+	free(disk_abc);
+
+	return ret;
+}
+
 int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info)
 {
 	struct bootloader_control *abc;
diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 6f7e232d2c3..3d1e64aa2b4 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -8,6 +8,7 @@
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
 #include <android_ab.h>
+#include <android_bootloader_message.h>
 #include <android_image.h>
 #if CONFIG_IS_ENABLED(AVB_VERIFY)
 #include <avb_verify.h>
@@ -438,6 +439,38 @@ static int avb_append_commandline(struct bootflow *bflow, char *cmdline)
 	return 0;
 }
 
+/**
+ * slot_is_known_good() - Whether the selected slot has booted successfully
+ *
+ * With A/B, Android marks a slot successful (boot control HAL) once it has
+ * booted far enough; until then a new update is still on probation. Without
+ * A/B there is no such signal and the slot counts as good.
+ *
+ * @bflow: Bootflow being booted
+ * Return: true if the slot is known good
+ */
+static bool slot_is_known_good(struct bootflow *bflow)
+{
+	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
+	struct android_priv *priv = bflow->bootmeth_priv;
+	struct disk_partition misc;
+	struct bootloader_control abc;
+	int slot;
+
+	if (!IS_ENABLED(CONFIG_ANDROID_AB) || !priv->slot)
+		return true;
+
+	slot = priv->slot[0] - 'a';
+	if (part_get_info_by_name(desc, BCB_PART_NAME, &misc) < 0)
+		return false;
+	if (ab_get_control(desc, &misc, &abc) < 0)
+		return false;
+	if (slot < 0 || slot >= abc.nb_slot)
+		return false;
+
+	return abc.slot_info[slot].successful_boot;
+}
+
 static int run_avb_verification(struct bootflow *bflow)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
@@ -539,6 +572,21 @@ static int run_avb_verification(struct bootflow *bflow)
 		}
 	}
 
+	/*
+	 * Rollback protection: libavb only compares the rollback indexes, the
+	 * bootloader stores them. Raise the stored indexes to those of the
+	 * verified images once the slot is known good, so that a bad update
+	 * which never boots cannot lock out the images it replaced.
+	 */
+	if (result == AVB_SLOT_VERIFY_RESULT_OK && slot_is_known_good(bflow)) {
+		AvbIOResult rc;
+
+		rc = avb_update_rollback_indexes(avb_ops, out_data);
+		if (rc != AVB_IO_RESULT_OK)
+			log_warning("rollback indexes not updated: %s\n",
+				    str_avb_io_error(rc));
+	}
+
 	ret = 0;
 
  out:
diff --git a/common/avb_verify.c b/common/avb_verify.c
index 4168b2434b6..c61cc5ef244 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -1233,6 +1233,41 @@ __weak AvbIOResult avb_read_root_key_digest(AvbOps *ops, uint8_t *digest)
 }
 #endif
 
+AvbIOResult avb_update_rollback_indexes(AvbOps *ops,
+					const AvbSlotVerifyData *data)
+{
+	AvbIOResult rc;
+	u64 stored;
+	int i;
+
+	/* without the TA there is no store for the indexes (reads give 0) */
+	if (!IS_ENABLED(CONFIG_OPTEE_TA_AVB))
+		return AVB_IO_RESULT_OK;
+
+	if (!ops->read_rollback_index || !ops->write_rollback_index)
+		return AVB_IO_RESULT_ERROR_IO;
+
+	for (i = 0; i < AVB_MAX_NUMBER_OF_ROLLBACK_INDEX_LOCATIONS; i++) {
+		/* unused locations stay 0 and never need an update */
+		if (!data->rollback_indexes[i])
+			continue;
+
+		rc = ops->read_rollback_index(ops, i, &stored);
+		if (rc != AVB_IO_RESULT_OK)
+			return rc;
+		if (stored >= data->rollback_indexes[i])
+			continue;
+
+		printf("Rollback index %d: %llu -> %llu\n", i, stored,
+		       data->rollback_indexes[i]);
+		rc = ops->write_rollback_index(ops, i, data->rollback_indexes[i]);
+		if (rc != AVB_IO_RESULT_OK)
+			return rc;
+	}
+
+	return AVB_IO_RESULT_OK;
+}
+
 /**
  * ============================================================================
  * AVB2.0 AvbOps alloc/initialisation/free
diff --git a/include/android_ab.h b/include/android_ab.h
index 838230e06f8..6cfc62b824c 100644
--- a/include/android_ab.h
+++ b/include/android_ab.h
@@ -9,6 +9,7 @@
 #include <stdbool.h>
 
 struct blk_desc;
+struct bootloader_control;
 struct disk_partition;
 
 /* Android standard boot slot names are 'a', 'b', 'c', ... */
@@ -36,6 +37,24 @@ struct disk_partition;
 int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
                    bool dec_tries);
 
+/**
+ * ab_get_control() - Read and validate the bootloader control block.
+ *
+ * @dev_desc: Device description pointer
+ * @part_info: Partition information (normally "misc")
+ * @abc: Where to store the bootloader_control (sizeof(struct
+ *	bootloader_control) bytes)
+ *
+ * Reads the A/B metadata without modifying it, for callers that only need
+ * to look at it (slot flags, active slot). A bad CRC, magic or version is
+ * an error, the metadata is not re-initialized.
+ *
+ * Return: 0 on success, or a negative on error
+ */
+int ab_get_control(struct blk_desc *dev_desc,
+		   const struct disk_partition *part_info,
+		   struct bootloader_control *abc);
+
 /**
  * ab_dump_abc() - Dump ABC information for specific partition.
  *
diff --git a/include/avb_verify.h b/include/avb_verify.h
index 2b5b24958ae..8479e327559 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -83,7 +83,23 @@ int avb_ops_add_preloaded(AvbOps *ops, const char *partition, void *addr,
 			  size_t size, size_t max_size);
 #ifdef CONFIG_OPTEE_TA_AVB
 AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked);
+
 #endif
+
+/**
+ * avb_update_rollback_indexes() - Store the rollback indexes of a verified slot
+ *
+ * libavb never writes the rollback indexes: once the bootloader knows the
+ * slot is good (it verified and, with A/B, booted successfully before), it
+ * raises every stored index that is below the one in the slot's vbmeta
+ * images, so that older images are refused from then on.
+ *
+ * @ops: AvbOps from avb_ops_alloc()
+ * @data: result of a successful avb_slot_verify()
+ * Return: AVB_IO_RESULT_OK, or the error of the first failed read or write
+ */
+AvbIOResult avb_update_rollback_indexes(AvbOps *ops,
+					const AvbSlotVerifyData *data);
 void avb_ops_free(AvbOps *ops);
 
 /**

-- 
2.53.0

