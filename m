Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51772C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 08:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D382782C87;
	Fri, 13 Jun 2025 10:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="OGYBuCRV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E1C582C2F; Fri, 13 Jun 2025 10:58:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1038782C44
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 10:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749805108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xwh/A0S6v+VSgkQY0/v/PGCHv1+LGUvLDbJk6apqEvw=;
 b=OGYBuCRVmm5Silf1uLb80Gq/9viSoJFILwcLizhnKPvUcfShOGhm+PEcJfC6Lgn7X9Y72j
 Gb/Ig58LcFABLS6ZxsdWwafmxXSzybuYFRdceEZ8rKhKLJ5pibtJ8RT4l7yoGaODK6bun/
 9KcMqJDeWZP3eeE12m2KnN8q8k8ixXE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-TDRHykNHNJWibreUkhV5WA-1; Fri, 13 Jun 2025 04:58:27 -0400
X-MC-Unique: TDRHykNHNJWibreUkhV5WA-1
X-Mimecast-MFC-AGG-ID: TDRHykNHNJWibreUkhV5WA_1749805107
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450de98b28eso17128585e9.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 01:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749805106; x=1750409906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xwh/A0S6v+VSgkQY0/v/PGCHv1+LGUvLDbJk6apqEvw=;
 b=Xa3iByUI175mj2asPqcin8MSfvudUn+wEe0m7xpNrEDWnMbZ01Op4wVI3tRT9JeGEw
 YxGKz9IrMFo07S2lq9F+RNLSrqy4vFY2fMcaiKybJAfboknhpbTHCDIASan7NncVvQ5n
 QnsQ6tTCmjIjJxjmac8iwdjXBQrgS9qakmkszz5pz0XPJkUpUbwgs921VopAcsv//ncj
 TJ0brIeppG+IUgXlx6lwfeSc9tM/zg8jNckA6JjduDsJqVkKrBoosYmVSPNzHlPiX0wR
 24KYoB8BxxUeniu+pBq3qnFgk4bQ5mpxtUkCPZYF83UwjEp33MGAxgkaNYTOBAaPrzs7
 YXfA==
X-Gm-Message-State: AOJu0YydgKxDaVaVGhyoLHBhNMTHKBgsPITxjvkufs/AUQIF2cu4QZXX
 9Uyd51TnNZdvFpb57TOrbXIeDF3BhtaNoR8lJeH+iZKJnsPMdMBlxLyiJx6V7rfF9wNWjxzqVaG
 yowqtG6KfHfCcrnlIn/ZOyp4hCnQH23qzhSJfGGbEyeq1FSaRV3C/gYgR2UZhR8TQXWepzn5vrV
 dzwNelPhf3mzpIWpMKCuPK/MbiZD35g09BHPqZtg==
X-Gm-Gg: ASbGncsCFNFZPfOz7hYmxdecj5qrBX3Eq3XCHCrcq0pSn7kSHh6L3yAkBWNGGNkwSPX
 bfeX/3C7kKyuQ+G+pVb2PW1vtnJerb4zJj0Ll8NnIIdEIsdcy9XQGIBhRstTmrcYqs9vMhWyOsP
 n6ITCBClmuwsw/DqP14prQzvIm5Kzu4WtrtxkcqCYTRb8Xov9yozbjrQsLuw7U9uUaGEG34pH5C
 N4ftPUUX9CMlx62R27Hu2pmOFCarW+DAn6pfElXpjOzgSa0Grwe1KR7X3aewoiSFGNJ4RcaUNhH
 2ImQkivNpLj7V049x3Ozwioq3pVpdkml+5WEgg5os5ASXJs=
X-Received: by 2002:a05:600c:a313:b0:453:84a:e8d6 with SMTP id
 5b1f17b1804b1-453371ef5bdmr12105645e9.1.1749805105986; 
 Fri, 13 Jun 2025 01:58:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMKvSEBDdd+hSUkMlR088TZq7z9Un/mhbb7ZYQTbYxJ4TP46pgOqbqtCoQQAC7Ho2I1h+2Xw==
X-Received: by 2002:a05:600c:a313:b0:453:84a:e8d6 with SMTP id
 5b1f17b1804b1-453371ef5bdmr12105255e9.1.1749805105393; 
 Fri, 13 Jun 2025 01:58:25 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e25fd3asm44658475e9.36.2025.06.13.01.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 01:58:24 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: mkorpers@redhat.com, mskrivan@redhat.com, eballetb@redhat.com,
 mripard@redhat.com, alexl@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] disk: efi: Move logic to get a GPT entry into a helper
 function
Date: Fri, 13 Jun 2025 10:57:36 +0200
Message-ID: <20250613085742.796015-2-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613085742.796015-1-javierm@redhat.com>
References: <20250613085742.796015-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kWQ9t5CvXvMY9c01yEiZ4eXv20ItmrYHlV6IQVfXxJc_1749805107
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Factor out the logic to get the Partition Table Entry (PTE) of a given
partition into a helper function, since it could be used by other code.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 disk/part_efi.c | 67 +++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 932d058c184c..c7d79e253958 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -216,6 +216,34 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
 	return 0;
 }
 
+static int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e)
+{
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
+	gpt_entry *gpt_pte = NULL;
+
+	/* "part" argument must be at least 1 */
+	if (part < 1) {
+		log_debug("Invalid Argument(s)\n");
+		return -EINVAL;
+	}
+
+	/* This function validates AND fills in the GPT header and PTE */
+	if (find_valid_gpt(desc, gpt_head, &gpt_pte) != 1)
+		return -EINVAL;
+
+	if (part > le32_to_cpu(gpt_head->num_partition_entries) ||
+	    !is_pte_valid(&gpt_pte[part - 1])) {
+		log_debug("Invalid partition number %d\n", part);
+		free(gpt_pte);
+		return -EPERM;
+	}
+
+	memcpy(gpt_e, &gpt_pte[part - 1], sizeof(*gpt_e));
+
+	free(gpt_pte);
+	return 0;
+}
+
 static void __maybe_unused part_print_efi(struct blk_desc *desc)
 {
 	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
@@ -261,45 +289,32 @@ static void __maybe_unused part_print_efi(struct blk_desc *desc)
 static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
 					    struct disk_partition *info)
 {
-	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
-	gpt_entry *gpt_pte = NULL;
-
-	/* "part" argument must be at least 1 */
-	if (part < 1) {
-		log_debug("Invalid Argument(s)\n");
-		return -EINVAL;
-	}
-
-	/* This function validates AND fills in the GPT header and PTE */
-	if (find_valid_gpt(desc, gpt_head, &gpt_pte) != 1)
-		return -EINVAL;
+	gpt_entry gpt_pte = {};
+	int ret;
 
-	if (part > le32_to_cpu(gpt_head->num_partition_entries) ||
-	    !is_pte_valid(&gpt_pte[part - 1])) {
-		log_debug("Invalid partition number %d\n", part);
-		free(gpt_pte);
-		return -EPERM;
-	}
+	ret = part_get_gpt_pte(desc, part, &gpt_pte);
+	if (ret)
+		return ret;
 
 	/* The 'lbaint_t' casting may limit the maximum disk size to 2 TB */
-	info->start = (lbaint_t)le64_to_cpu(gpt_pte[part - 1].starting_lba);
+	info->start = (lbaint_t)le64_to_cpu(gpt_pte.starting_lba);
 	/* The ending LBA is inclusive, to calculate size, add 1 to it */
-	info->size = (lbaint_t)le64_to_cpu(gpt_pte[part - 1].ending_lba) + 1
+	info->size = (lbaint_t)le64_to_cpu(gpt_pte.ending_lba) + 1
 		     - info->start;
 	info->blksz = desc->blksz;
 
 	snprintf((char *)info->name, sizeof(info->name), "%s",
-		 print_efiname(&gpt_pte[part - 1]));
+		 print_efiname(&gpt_pte));
 	strcpy((char *)info->type, "U-Boot");
-	info->bootable = get_bootable(&gpt_pte[part - 1]);
-	info->type_flags = gpt_pte[part - 1].attributes.fields.type_guid_specific;
+	info->bootable = get_bootable(&gpt_pte);
+	info->type_flags = gpt_pte.attributes.fields.type_guid_specific;
 	if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
-		uuid_bin_to_str(gpt_pte[part - 1].unique_partition_guid.b,
+		uuid_bin_to_str(gpt_pte.unique_partition_guid.b,
 				(char *)disk_partition_uuid(info),
 				UUID_STR_FORMAT_GUID);
 	}
 	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) {
-		uuid_bin_to_str(gpt_pte[part - 1].partition_type_guid.b,
+		uuid_bin_to_str(gpt_pte.partition_type_guid.b,
 				(char *)disk_partition_type_guid(info),
 				UUID_STR_FORMAT_GUID);
 	}
@@ -307,8 +322,6 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
 	log_debug("start 0x" LBAF ", size 0x" LBAF ", name %s\n", info->start,
 		  info->size, info->name);
 
-	/* Remember to free pte */
-	free(gpt_pte);
 	return 0;
 }
 
-- 
2.49.0

