Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA06C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 10:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7CD481273;
	Thu, 27 Mar 2025 11:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FIX4he6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B89281273; Thu, 27 Mar 2025 11:03:00 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FE4C8070C
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 11:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso5520985e9.3
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743069777; x=1743674577; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9l709vhBdQgq4QbeZu8X4MQ6CY7Ugf7pjlASjYZi/nk=;
 b=FIX4he6FZI7qBwr8tAZ9JojyUHD7nQPLH+8S8LCYbP+TTrXhEW8M4J2LoApLl/wJ31
 VtHcrctzulLyX7/sR8yV7T7H6O8zZ9pQM4GqioeeaAzeh3sFPwzCXsCrITSY7xQyjHDZ
 53C2m5VJaZftKTGZeepwwfRKhRUL5W3B4JIIhqPhZ5RCLdE7xcxvRMDbvnIyOWCJGSmo
 P1XppgSJ+rWec7LnCVndl8bhu9hWoixFoHmtmJjwd8J7BQaq02AWJ62MdqS8E8doKDoZ
 xYJUPU0pioZlAVN6NeH+ClPh2st09AotVb1wiWgym5a8LCO3UxfAkuLi4OzBA5YaNxp/
 X3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743069777; x=1743674577;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9l709vhBdQgq4QbeZu8X4MQ6CY7Ugf7pjlASjYZi/nk=;
 b=Q9HTZEHEEu0S9wWBIVIJ5tvqZR2wdXT4s6rBbej5nxPxJzNK8rlunZAiSJcC5r8MmP
 XOkgZs8fEPMKWJZWyLBjQCwlVQkPmkefm1q8FSTgiteqHxMHUTYbuyT8kb4pcC0N96b8
 /EvWOrZODr4btjruDZgcJYpWg5l7o8ahcYB9++2HSCMKZ3DOmqjmCVac05M0gLcz20Wm
 tn8VBtjjzwOO+kqTPYvx+2p/VzMog/tb0gxFObWi2CmM0AojhJin2DEtBjMDiiAnqfhD
 C0TrDAlZHi5hLcdO+GUwpkf1SiG+gOFcBx6EFNEWjCo0kZJVXU8mIcz/8JIwgJAYCT4l
 JuMQ==
X-Gm-Message-State: AOJu0YxTWVT0uS+wKK7sd7aZ8MlmGguVKZx+rYX5kiRJLqq23dANdJD+
 /aZ0pbGHnWN7aR1/Cq9bKfkNW1PkdE3U5j4yyD4HKwj2K448IFCpKXzBMaDffQ4=
X-Gm-Gg: ASbGncsFO4gjpEgr+g0A3t3nCaAwwDdpYrhun7DwXOr1Aw17oj/P9AZbpWL9irdX/6z
 PU/9MU6z7cO4A4N3jRDhDcx6u/k30fiuQqAtxpkcbdf9bisqb0WU4pGj6T1u+oS/T4LMNx4uia+
 +2esgHcACQQqQZsl7Osi7ODcLsv0lr5RbN3KZ7tbzM92n42G7CEbt0k2m0SHWcraEfyZDNRzt7a
 8UAY1x2iZduEL1pTSTo6SIZW7vI9+dWfyi6E3DMjxbs8LsL2xAc5jV4NJ/TnqD+pM4dK7qo4H9o
 ebcbYR0Nb/DCjjrFFV3yIGEuWZYhspAUUC+OxrAw5TupbIpSyUlkntShuutcZu1d+A==
X-Google-Smtp-Source: AGHT+IGvSw7KeghZ5sO+F7TSDkeAbTkJJmI4cyLv0RyFqLqTXF66J7yiXb1VJ/z9bE53kwW0gTG6hQ==
X-Received: by 2002:a05:600c:3d8c:b0:43d:649:4e50 with SMTP id
 5b1f17b1804b1-43d871ac058mr17855085e9.13.1743069776808; 
 Thu, 27 Mar 2025 03:02:56 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efeb11sm32263245e9.22.2025.03.27.03.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 03:02:56 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 27 Mar 2025 11:02:55 +0100
Subject: [PATCH] part_efi: cache last scanned GPT for next partition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-u-boot-efi-part-cache-v1-1-be6b69c0698b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAE4i5WcC/x2MywqAIBAAfyX23ILZi/qV6GDrWnvJ0IpA+vek4
 8DMJIgchCOMRYLAt0Txe4aqLIA2s6+MYjODVrpVte7xwsX7E9kJHiacSIY2RmupaoaBanYd5PY
 IWXj+7zS/7wdQztW3ZwAAAA==
X-Change-ID: 20250327-u-boot-efi-part-cache-ddc1499c3ef6
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8665;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=32aPY6bpjPtAWcCv7N3+dv1Yb9S7qh6HiqylTRQ1PbM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn5SJPWt/LpRExcGXjltjM9BlbSPy7WqR6BrGf+yeM
 ckSOqfiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ+UiTwAKCRB33NvayMhJ0bzBD/
 9VJJ6lHlsfAkj48SGHqQSi0PoAgLwYuRErwAj+1UdmayBK1aM4Dw9qyhm65nO3UL7/xkOlznUdeMBw
 86MWVSnnKtOvso2YePOsWrXQYN42abUQJxA5w0l3DsBkJOVkXf3ReDrZw6TZdP+e/vxNr0cS9hBYGc
 XJXwHwy5SXhogtXnp+EItAvduAF1pM2w6F5QxBPF1ypj0B4z7TyMaMCsojZteDwUfj5MXCzW9ZVEKI
 ERctBhhtbcH2Y625cz8rQVVjtkaRzYSICTouoZKDDxEk9WF6j/ZInisxCivJKGU20QuLZvzXjECZmt
 8dhYgTGkqzMPy+MjbxjZ/oK2N56/w7uVSaNaRc/wceQu+JtzJr1CAigqBxifcgGDchMK+bzairs4RS
 zQmbSkW0Vd2XvE+FUYxFjDaMXq5JW2HXH8w+9a1D19DIjaraI71rmizLMAyeYYMoxTJe7johdWDBNT
 1GEORhIkYGmFhVTms5KBrCuhjnaFyhAjUWUlMJdNWgBe+sMz7bsY+qiPvIta1/pfROnt2xANm6pYQI
 WV8hikyFhwIR4yEOvnGYN9Ld30kk2c4KUdcg3HBqXH7CWyWKLAeCtREBfitYk2eEbhTMdhVKBtIr7J
 Tm6sltkq1Kkp/hauF6PMSvudaoo2ZSwLEnY6df7BLX8igWESP0QkwE20Uj1Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The actual architecture of the EFI part parser means the
entire GPT partition table needs to be parsed for each
part_info() callback.

Since the default part scan code will always scan up to
128 partitions for a block, and devices with an UFS chip
with up to 8 LUNs are very common in the field, this means
a complete GPT parsing and validation will be done
up to 1024 times instead of 8 on such devices.

The GPT parsing can be cached between each part_info()
call speed up to 3x on the worse condition when the CPU
i-cache and d-cache are disabled, like in the SPL.

The implementation does caching each time a correct GPT
has been parsed and verified and will match the blk_desc
and LBA to serve the cached data or force a re-parsing.

In order to allow GPT manipulation, some of the calls
ignores the cache and some will discard the cached data.

On the SM8650 QRD platform with a KIOXIA THGJFJT1E45BATPC
configured with 8 LUNs, the scsi scan takes 0.2s with both
CPU caches enabled, but when disabling both CPU caches it
goes up to 4s to do the full scan of all 8 LUN partitions.

With this change the scan takes only 0.18s with both CPU
caches enabled running 1.1x times faster, and with both CPU
caches disabled the full scan takes only 1.27s running
3x faster.

While 20ms could look negligeable, it's still a 20ms gain
in the boot flow and a non negligeable reduction in
calculation and memory allocation since for each scan
it would allocate and free the gpt_pte table up to
1024 times, now it would only do 8 allocations, reducing
memory fragmentation.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 disk/part_efi.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 77 insertions(+), 16 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 932d058c184ce6946b7142e7c2d9637b28e4661e..4f02fabe265ce5ca4c8f55e41768a95582022e21 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -55,13 +55,59 @@ static inline u32 efi_crc32(const void *buf, u32 len)
 static int pmbr_part_valid(struct partition *part);
 static int is_pmbr_valid(legacy_mbr * mbr);
 static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
-			gpt_entry **pgpt_pte);
+			gpt_entry **pgpt_pte, bool cache);
 static gpt_entry *alloc_read_gpt_entries(struct blk_desc *desc,
 					 gpt_header *pgpt_head);
 static int is_pte_valid(gpt_entry * pte);
 static int find_valid_gpt(struct blk_desc *desc, gpt_header *gpt_head,
 			  gpt_entry **pgpt_pte);
 
+static struct gpt_pte_cache_data {
+	struct blk_desc *desc;
+	u64 lba;
+	gpt_entry *gpt_pte;
+	gpt_header gpt_head;
+} gpt_pte_cache;
+
+static void clear_gpt_pte_cache(void)
+{
+	if (gpt_pte_cache.desc) {
+		if (gpt_pte_cache.gpt_pte)
+			free(gpt_pte_cache.gpt_pte);
+
+		memset(&gpt_pte_cache, 0, sizeof(gpt_pte_cache));
+	}
+}
+
+static void cache_gpt_pte(struct blk_desc *desc, u64 lba,
+			  gpt_entry *gpt_pte, gpt_header *pgpt_head)
+{
+	if (gpt_pte_cache.gpt_pte)
+		free(gpt_pte_cache.gpt_pte);
+
+	gpt_pte_cache.desc = desc;
+	gpt_pte_cache.lba = lba;
+	gpt_pte_cache.gpt_pte = gpt_pte;
+	if (pgpt_head)
+		memcpy(&gpt_pte_cache.gpt_head, pgpt_head, sizeof(gpt_header));
+}
+
+static gpt_entry *get_cached_gpt_pte(struct blk_desc *desc, u64 lba,
+				     gpt_header *pgpt_head)
+{
+	if (gpt_pte_cache.desc && gpt_pte_cache.gpt_pte) {
+		if (gpt_pte_cache.desc == desc &&
+		    gpt_pte_cache.lba == lba) {
+			memcpy(pgpt_head, &gpt_pte_cache.gpt_head, sizeof(gpt_header));
+			return gpt_pte_cache.gpt_pte;
+		}
+
+		clear_gpt_pte_cache();
+	}
+
+	return NULL;
+}
+
 static char *print_efiname(gpt_entry *pte)
 {
 	static char name[PARTNAME_SZ + 1];
@@ -211,8 +257,6 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
 	guid_bin = gpt_head->disk_guid.b;
 	uuid_bin_to_str(guid_bin, guid, UUID_STR_FORMAT_GUID);
 
-	/* Remember to free pte */
-	free(gpt_pte);
 	return 0;
 }
 
@@ -252,9 +296,6 @@ static void __maybe_unused part_print_efi(struct blk_desc *desc)
 		uuid = (unsigned char *)gpt_pte[i].unique_partition_guid.b;
 		printf("\tguid:\t%pUl\n", uuid);
 	}
-
-	/* Remember to free pte */
-	free(gpt_pte);
 	return;
 }
 
@@ -277,7 +318,6 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
 	if (part > le32_to_cpu(gpt_head->num_partition_entries) ||
 	    !is_pte_valid(&gpt_pte[part - 1])) {
 		log_debug("Invalid partition number %d\n", part);
-		free(gpt_pte);
 		return -EPERM;
 	}
 
@@ -307,8 +347,6 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
 	log_debug("start 0x" LBAF ", size 0x" LBAF ", name %s\n", info->start,
 		  info->size, info->name);
 
-	/* Remember to free pte */
-	free(gpt_pte);
 	return 0;
 }
 
@@ -382,6 +420,9 @@ int write_gpt_table(struct blk_desc *desc, gpt_header *gpt_h, gpt_entry *gpt_e)
 					   * sizeof(gpt_entry)), desc);
 	u32 calc_crc32;
 
+	/* Clean cache */
+	clear_gpt_pte_cache();
+
 	debug("max lba: %x\n", (u32)desc->lba);
 	/* Setup the Protective MBR */
 	if (set_protective_mbr(desc) < 0)
@@ -620,6 +661,9 @@ int gpt_restore(struct blk_desc *desc, char *str_disk_guid,
 	gpt_entry *gpt_e;
 	int ret, size;
 
+	/* Clean cache */
+	clear_gpt_pte_cache();
+
 	size = PAD_TO_BLOCKSIZE(sizeof(gpt_header), desc);
 	gpt_h = malloc_cache_aligned(size);
 	if (gpt_h == NULL) {
@@ -689,7 +733,7 @@ int gpt_verify_headers(struct blk_desc *desc, gpt_header *gpt_head,
 	 */
 	if (is_gpt_valid(desc,
 			 GPT_PRIMARY_PARTITION_TABLE_LBA,
-			 gpt_head, gpt_pte) != 1) {
+			 gpt_head, gpt_pte, false) != 1) {
 		log_debug("Invalid GPT\n");
 		return -1;
 	}
@@ -706,7 +750,7 @@ int gpt_verify_headers(struct blk_desc *desc, gpt_header *gpt_head,
 	}
 
 	if (is_gpt_valid(desc, (desc->lba - 1),
-			 gpt_head, gpt_pte) != 1) {
+			 gpt_head, gpt_pte, false) != 1) {
 		log_debug("Invalid Backup GPT\n");
 		return -1;
 	}
@@ -764,10 +808,13 @@ int gpt_repair_headers(struct blk_desc *desc)
 	int is_gpt1_valid, is_gpt2_valid;
 	int ret = -1;
 
+	/* Clean cache */
+	clear_gpt_pte_cache();
+
 	is_gpt1_valid = is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA,
-				     gpt_h1, &gpt_e1);
+				     gpt_h1, &gpt_e1, false);
 	is_gpt2_valid = is_gpt_valid(desc, desc->lba - 1,
-				     gpt_h2, &gpt_e2);
+				     gpt_h2, &gpt_e2, false);
 
 	if (is_gpt1_valid && is_gpt2_valid) {
 		ret = 0;
@@ -906,6 +953,9 @@ int write_mbr_and_gpt_partitions(struct blk_desc *desc, void *buf)
 	lbaint_t lba;
 	int cnt;
 
+	/* Clean cache */
+	clear_gpt_pte_cache();
+
 	if (is_valid_gpt_buf(desc, buf))
 		return -1;
 
@@ -1023,12 +1073,13 @@ static int is_pmbr_valid(legacy_mbr *mbr)
  * lba is the logical block address of the GPT header to test
  * gpt is a GPT header ptr, filled on return.
  * ptes is a PTEs ptr, filled on return.
+ * cache is a bool, true to use the cached gpt_pte from previous call
  *
  * Description: returns 1 if valid,  0 on error, 2 if ignored header
  * If valid, returns pointers to PTEs.
  */
 static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
-			gpt_entry **pgpt_pte)
+			gpt_entry **pgpt_pte, bool cache)
 {
 	/* Confirm valid arguments prior to allocation. */
 	if (!desc || !pgpt_head) {
@@ -1036,6 +1087,12 @@ static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
 		return 0;
 	}
 
+	if (cache) {
+		*pgpt_pte = get_cached_gpt_pte(desc, lba, pgpt_head);
+		if (*pgpt_pte)
+			return 1;
+	}
+
 	ALLOC_CACHE_ALIGN_BUFFER_PAD(legacy_mbr, mbr, 1, desc->blksz);
 
 	/* Read MBR Header from device */
@@ -1081,6 +1138,9 @@ static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
 		return 0;
 	}
 
+	if (cache)
+		cache_gpt_pte(desc, lba, *pgpt_pte, pgpt_head);
+
 	/* We're done, all's well */
 	return 1;
 }
@@ -1100,13 +1160,14 @@ static int find_valid_gpt(struct blk_desc *desc, gpt_header *gpt_head,
 	int r;
 
 	r = is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, gpt_head,
-			 pgpt_pte);
+			 pgpt_pte, true);
 
 	if (r != 1) {
 		if (r != 2)
 			log_debug("Invalid GPT\n");
 
-		if (is_gpt_valid(desc, desc->lba - 1, gpt_head, pgpt_pte)
+		if (is_gpt_valid(desc, desc->lba - 1, gpt_head, pgpt_pte,
+				 true)
 		    != 1) {
 			log_debug("Invalid Backup GPT\n");
 			return 0;

---
base-commit: 4adbf64ff8d8c730223fd8ae299d770bebb6fe86
change-id: 20250327-u-boot-efi-part-cache-ddc1499c3ef6

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

