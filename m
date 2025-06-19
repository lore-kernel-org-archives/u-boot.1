Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3393CC7115E
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 08:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3516782CDF;
	Thu, 19 Jun 2025 10:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="c9cY46wG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6FFC82BA1; Thu, 19 Jun 2025 10:34:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD6FD82CBB
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 10:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750322061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SSYUvX/KxGpr1sETht514oBf6P6fhIgWE9gMkzdE9sU=;
 b=c9cY46wGVBo1l2itDIQgRtyMx6iWVa5kUyvU2W1yizX2WhxeXTiPT6xYaDq3owkmyzLbnp
 9241MoqS8AO88Iiq6ENZEGdN7XEXbjhoLtAZEpYQe6z1cX5GoKkAxqDVRaxnZBZFkh/i06
 6E7u0l7nrqFQWp0hIVQvQxf8UA8hVts=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-BzUyw3npP1OtuqE9jTByaA-1; Thu, 19 Jun 2025 04:34:20 -0400
X-MC-Unique: BzUyw3npP1OtuqE9jTByaA-1
X-Mimecast-MFC-AGG-ID: BzUyw3npP1OtuqE9jTByaA_1750322059
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45311704d22so3201945e9.2
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 01:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750322058; x=1750926858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SSYUvX/KxGpr1sETht514oBf6P6fhIgWE9gMkzdE9sU=;
 b=KueShnzQLWSb2hA+nIYg18v+PuKUy7JGJNix/N6ztj5kvIlrPFCpJ1xzIMSmI3TXOA
 K0SHzlMD9BEhHeGctNA/cjqkAMI+jog/8O6On3Cb86FYlX6Wh4NlMunTILK2pf6obdrD
 +r56y6UEP0k061hS1Mc71/l45tNu4o8YwT9ePgNMS6Zzq8WkplAgbn9dwJTJh/dt09nl
 FiSvfa8BZfnjmL9Lr/0ynBJii451tfYUBYCeuY7gcms7VQnarbn1XAsmuiMof6VCiTC5
 H8D7pDt5hBfaStaxrU+jKO8V7NA7d/9iu+Ll47ZzyOWoslF+ptll3ZtGvrcig1UhaXRV
 JGyg==
X-Gm-Message-State: AOJu0YyqzJlLZ5AXPtYtJ05ihHWIPKXBPEBJ2+Rl5pESz5JFKYU1oOLO
 DW9KsC0weYUss5pno4/kmpwtbesc56VRKuoVT/NIpcCPS9rfGmePnadMsrfhYfPBVvr90weR9Vu
 k/0dLsd8aXS1M1fcqMIw/d2/MsUKVI9ucCYaiW0rEh5xgS+JvE01Lsk6lWf+/sSKQ9hqvz915YC
 EIxWZbcWA5Nc03dyY5M8EO6DLnYiwaue/qz1TS6Q==
X-Gm-Gg: ASbGncvi5BwsUQCMoq10cbqLOUsGYsdQKF6hV5TxCVB9qUlS3n7PUzHPVd0RRLeXLgf
 NmH+g1si6K1aqJ5b0HsCwM1Ny4rYvuSmAOcPuEaoL7ndMJ9llweJtLZ/7KSspMvFkS74R6MhJgc
 DCc9hEcrbfyT0vb+qbLw9REmHzV+GvTe5ZOugLVlN1EQpa12wHGFbRoFzdHExgKcZ14dTmf3K36
 NPJpSrwBJUjUKKZd8LhR1tDvrwimj1vAaiGyDWBSSWKr1d3JcCwrdC6oJfDuhvU65Bz5YGnPhK1
 J4B6xQ7Xk6gn/PlfY4E3HITG7Kqj6yxlc5x4uuxEn7tTByRFbBWX
X-Received: by 2002:a05:600c:c0d4:b0:450:d204:34ca with SMTP id
 5b1f17b1804b1-4533cb488dcmr157768145e9.18.1750322058504; 
 Thu, 19 Jun 2025 01:34:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3YSPkJlMYzKtdOxmPdxJOPIU/zi8jW6TXcTneddaKDqWSNVn3eqtbEu3iGkire4HgbptzWA==
X-Received: by 2002:a05:600c:c0d4:b0:450:d204:34ca with SMTP id
 5b1f17b1804b1-4533cb488dcmr157767775e9.18.1750322058015; 
 Thu, 19 Jun 2025 01:34:18 -0700 (PDT)
Received: from localhost (35.pool90-77-212.dynamic.orange.es. [90.77.212.35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e97ab73sm22017805e9.6.2025.06.19.01.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 01:34:17 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: mripard@redhat.com, mskrivan@redhat.com, Tom Rini <trini@konsulko.com>,
 eballetb@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 alexl@redhat.com, mkorpers@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v3 1/4] disk: efi: Move logic to get a GPT entry into a helper
 function
Date: Thu, 19 Jun 2025 10:33:59 +0200
Message-ID: <20250619083411.2214491-2-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619083411.2214491-1-javierm@redhat.com>
References: <20250619083411.2214491-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RFFS8dRxeFyWqHPZP01Tl1chvXvKZ0e1W1BIjvT_jcw_1750322059
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 disk/part_efi.c | 67 +++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 68ba1d11e7b6..d0b1f96adff2 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -215,6 +215,34 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
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
@@ -260,45 +288,32 @@ static void __maybe_unused part_print_efi(struct blk_desc *desc)
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
@@ -306,8 +321,6 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
 	log_debug("start 0x" LBAF ", size 0x" LBAF ", name %s\n", info->start,
 		  info->size, info->name);
 
-	/* Remember to free pte */
-	free(gpt_pte);
 	return 0;
 }
 
-- 
2.49.0

