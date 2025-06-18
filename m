Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6C1C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 08:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4488782C55;
	Wed, 18 Jun 2025 10:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="iSsFMnfO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF3F82D18; Wed, 18 Jun 2025 10:01:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8343F82C55
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 10:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750233668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+aYfxZfVOqdJIYZF+R1Nd7N478lbbyFl0b8NjnOmj4=;
 b=iSsFMnfOqniq1Pv4artrjU97DNsQ5fZ8ln7TZIuBgopLfx+jZ2cktNUPP7qkUmGmYi4VBE
 OZGXr1BbXqbOGwwo3H/jgXEmZ1Zi6jO/nuzIOyk3m2Olziq2KVZg3QaXkNoQ5NckEYtWhC
 RxLalVOlrSZQOFMNbK+ZCCDrVfqtV40=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-SbbxX1ITOf22maa3E9vbTg-1; Wed, 18 Jun 2025 04:01:07 -0400
X-MC-Unique: SbbxX1ITOf22maa3E9vbTg-1
X-Mimecast-MFC-AGG-ID: SbbxX1ITOf22maa3E9vbTg_1750233666
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d30992bcso53493065e9.2
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 01:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750233665; x=1750838465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N+aYfxZfVOqdJIYZF+R1Nd7N478lbbyFl0b8NjnOmj4=;
 b=Hg6tLYAw21QT5Jq4A+v2lXAQCHcKu5HoP/MBG0iohsk5mNH0iglWX3UYmsIg2Dg45C
 MZGFFqswGao3Qt6PcE8usNQ+QpEODVqLMjSKg0cDEJBYukx4DXJVfLDEQI5NVmVhC+xF
 OEkXeYLtZph3ufcF1WiR7MqMqvlbtZF1ReEP5dETFEcYOMfd042Mq73gxInVuhrBFTwZ
 Mwz/2bgcFMn28CELBRUJRtsV6JONRovKsAqpfsD8M7DrENrTaTy2a6HvBELiyQWX6BwV
 ejor2FwcguatqjSYEfiRRshaW3CwXcbc+nUv+F2StoqnCKNsE+pa+amrPk9R+3UbLBAl
 F6BA==
X-Gm-Message-State: AOJu0YyZ89sZvfS33ro/V/noNSxh1+W5FExGMOZWecjUMyUiTLis8l9q
 35ZhsVkOGH924qQuvZBWldSzrqGM5/eKds+x07TNsXR9kkWT898HXj+sZH0kjg2oMS9ZO/O0TcA
 I+AmW0GIR8YPZsV1pvMwfXVR8IE+bEAMhI4nlNhG1nEani/Zu+rQSKA2mPHIlSdu/Hi3sUcNS2o
 52VQ1dRn1BuNkujt4tKee+yQq8VeW0c1KKtwIJ7Q==
X-Gm-Gg: ASbGncteHN6aA4hjYgs9xu8y9DNAE9SVQYFm+i6mTognEGw0NJxTlSK+FzwMIa/AWoL
 fyS10vmT7wCwPnMXsfcu0cCjwpO5f0M98xcaVD/pOCZI5yz/sMmDchqO084f0yDbkuY8Ld++9LZ
 3BzWcasN446FRquQlM5HnfcX495RJWaaI8zUkIxCQXEGqy4lPA7E2qk0H5i9nuqFNM4REDkmaOb
 XZ0ttMAjOxMB//7/J+wCauftVcSfHnayIRqyo6+kzu9TNrRzReXyVc1iOjSsmBswynkrzH9Bj2S
 4GEqjqKnBW28VaF8q25Yf86aIcugP6KZKo7fcweqeriJRqo=
X-Received: by 2002:a05:6000:4187:b0:3a5:7967:cdb9 with SMTP id
 ffacd0b85a97d-3a57967cff8mr9196527f8f.46.1750233664924; 
 Wed, 18 Jun 2025 01:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1y7MAJDhbcKgRwxzDKT9A62Rx99y2D9p3mhKlJP3V2Q9dV5xtAs1hl0iN5qs4RORaNwdOig==
X-Received: by 2002:a05:6000:4187:b0:3a5:7967:cdb9 with SMTP id
 ffacd0b85a97d-3a57967cff8mr9196494f8f.46.1750233664458; 
 Wed, 18 Jun 2025 01:01:04 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a7389bsm16244550f8f.37.2025.06.18.01.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 01:01:03 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, mripard@redhat.com,
 Tom Rini <trini@konsulko.com>, alexl@redhat.com, mkorpers@redhat.com,
 eballetb@redhat.com, mskrivan@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v2 1/4] disk: efi: Move logic to get a GPT entry into a helper
 function
Date: Wed, 18 Jun 2025 10:00:35 +0200
Message-ID: <20250618080056.1973311-2-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618080056.1973311-1-javierm@redhat.com>
References: <20250618080056.1973311-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OOUGewDmEwytGmlAWPfXuxTf2M3ssfMOwPlKYFG55VY_1750233666
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

