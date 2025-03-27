Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E87C36013
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 19:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67CBE8070C;
	Thu, 27 Mar 2025 20:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rbxEDH96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63678809A4; Thu, 27 Mar 2025 20:01:36 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21059806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 20:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1743102093; x=1743706893; i=xypron.glpk@gmx.de;
 bh=tVBYFETql8tbGMSO/mikDt0dL0Lc6qUxk0C/5emeGgw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=rbxEDH96iB8rC/+/EWT6appXicjmFDwnbbWHQpeAJMd7A1JTAcqxAoAVmxo0ITJ6
 Lam8goSYXCaV3mD7X+vfA6MJqVgJUxReD38+/Ra5H4hccP5QyWq69azS1OwtxRG69
 Ry+WQIxP6OP2loxuTryZSc48usivSDJeocQcgZNgl1TM3QFGupPFN/VZJAesi2RE1
 4QZQEw/i76jMXnDK816/+zrli79vLiucz/YthwstiYHcEZGUP4X5KRzEC0LDor7+D
 uRx/ck4Mgwbwg080q0vGENRRCdNNOOC/0J7QWbpMKVs+uOJwCHJM629RXH0iPqD8g
 rzzVlJQDdlPimsJTyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybKf-1tCGfo1akn-00u8XB; Thu, 27
 Mar 2025 20:01:33 +0100
Date: Thu, 27 Mar 2025 20:01:31 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH] part_efi: cache last scanned GPT for next partition
User-Agent: Thunderbird for Android
In-Reply-To: <20250327-u-boot-efi-part-cache-v1-1-be6b69c0698b@linaro.org>
References: <20250327-u-boot-efi-part-cache-v1-1-be6b69c0698b@linaro.org>
Message-ID: <53E9363D-6499-4512-B204-83729DF88BD7@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vV+wLxQOcaD+rj0C70J+ZVbb0vgNKIXqBgilnzZ+tjgWs2OsbaL
 h6pzNqB4c4FtUDiPGOwyfWTRRDGHgMx4EZOGHxsd6RtMg3K7Yn97d79oqpbp9DfYK8FFUyb
 XKEJReOHboqR+FPbij75upMnfjicnOWHiFlax3CpJlCpaMVSeFZSCuB+84eVxC6I5e8tPf3
 VGpN/HJvLmKCar0xvg3RA==
UI-OutboundReport: notjunk:1;M01:P0:7ztnWDkyPVo=;pUXMurc5s9oWFMPNP98gM5SYPP9
 tdJjNPkuMZN7UNE6RVMbA09VUR11s1I6aTpQIUEV5rsiWfVC68zXIbwOeR20pVchSpBFL8icG
 JEsetgT0A3X1e78XMB5CTaxYYYM91+JugjwKLgqbCx2ZZotPNP7r5ut1fdESaAXeNTUdmU8uY
 JDFAEAIpCZRAO0ahR9+NxUFVnR+0MiJfn9exfyx/PwFNvmo0+vMBszHLUcFDVeDRxBWLbc59J
 IlN8SO5Pg6LE5jUqvA/7EkOQkGYyDiFCc7vS/mv4mxhpEl/8wCn2brjsLUhfVJPTWif81W68j
 lwsIg8+ejs7myMq3PWEtLi7ojJiXG8OKO4asOWh6aO7JTtzorLIJWXTO2cNjV4ylMsGkdYosq
 vdjQ3s5XDKOgfEAXqg8eUpHKL+Hr3UH1+QjPHxpRnhUpIT6Yu/DBUht6Q1xNLJAfXXOCenEO9
 oBHqNhtN503ofwXF4eQiRHKCaUQ6ZxmiHFDIAcMhpxzsJzcCSrn/bwtdjjN7IUHgG6NQHwEJR
 fYBKN0e0xSx53M393r1Aj8qE6F1fmVwpJgOBPZnQnH/52lk3PyMDbV8Rdmy93Ah08jb9M/icP
 InpixQ0kRSEaP9XyAbEWUDXBEQLU4rvkGFp/702QMveUafKxNpm4YReEf/NOhDc+D+Wtj7uYO
 kXmy0MzK3dFC4xnBlwNhdU2kY/7g021WPsnO+U8JrRGicNkJSFqt1a4zXVPpaHfP68zAwraWN
 aou8DgQzv4+TigYeDqqVlJFntuqyojfnhXvsYW/TJshXZWp5+b7JPgq+pV4BlDDwldrn4UjUy
 aP7dPGy4Ipg56muQHmhlgKEnww8zM/DYtzQOc8Qzd/CczFJbo45i0RviUG/j5Yf5/N8ryyFff
 V3rKm+30GLDWXVT7vcaWpFEYjkOpe9ngvveFrrHn3abZ4nh9AHQLgaw/1IqGjdSj1GLFDdjmF
 6s6MFrkvER9nMRTHy1+S9XtYCpeIN1HoMAYFZK8+la1+Fwa1PDyfjxgZYymSNh0m9MAB06pu7
 w2QLx+rfhuSYJzdiB7Jph070BsYUC9R6mUxAylTtU39VqM9yWZK5mTzlAGZuSNMQmVr9d2uz6
 aliPMUkZvfYliuqTOj/lTd70w86Ytp0Uv54zd2PdTdWjDV82JNC+cG7klikVR1S2Daj03+KgJ
 BYya76k3yWDHw56K70crrGmDefWid4WBUkraxVAabcVoDZU2PqZH43hUuhOjbYktfM4zeKLHn
 AWbbozXOOFPmlagwjBD1o7wng+bkkrAVpD6VHId3Ce+VfZmYRWGqpDpJ8vZx8Gdf9n0/MYLiu
 BvVt2XQ6kRCN81Y5U0A2gg1C8bYv7fiY6l6SVti9yMrTKZwQiKRhY9VuKnhgeuVAsLPMdRWH6
 hPj3RnM95KY1NjxCLm9TKAfjSlWIB+nnx+H//A6oOWyyxe6Gs/qMkszfAEAzXq2GE2WMP6C0f
 QTEQ+3K5F1XLDrjKp0R6A4Q2PndI=
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

Am 27=2E M=C3=A4rz 2025 11:02:55 MEZ schrieb Neil Armstrong <neil=2Earmstro=
ng@linaro=2Eorg>:
>The actual architecture of the EFI part parser means the
>entire GPT partition table needs to be parsed for each
>part_info() callback=2E
>
>Since the default part scan code will always scan up to
>128 partitions for a block, and devices with an UFS chip
>with up to 8 LUNs are very common in the field, this means
>a complete GPT parsing and validation will be done
>up to 1024 times instead of 8 on such devices=2E
>
>The GPT parsing can be cached between each part_info()
>call speed up to 3x on the worse condition when the CPU
>i-cache and d-cache are disabled, like in the SPL=2E
>
>The implementation does caching each time a correct GPT
>has been parsed and verified and will match the blk_desc
>and LBA to serve the cached data or force a re-parsing=2E
>
>In order to allow GPT manipulation, some of the calls
>ignores the cache and some will discard the cached data=2E
>
>On the SM8650 QRD platform with a KIOXIA THGJFJT1E45BATPC
>configured with 8 LUNs, the scsi scan takes 0=2E2s with both
>CPU caches enabled, but when disabling both CPU caches it
>goes up to 4s to do the full scan of all 8 LUN partitions=2E
>
>With this change the scan takes only 0=2E18s with both CPU
>caches enabled running 1=2E1x times faster, and with both CPU
>caches disabled the full scan takes only 1=2E27s running
>3x faster=2E
>
>While 20ms could look negligeable, it's still a 20ms gain
>in the boot flow and a non negligeable reduction in
>calculation and memory allocation since for each scan
>it would allocate and free the gpt_pte table up to
>1024 times, now it would only do 8 allocations, reducing
>memory fragmentation=2E

Could you, please, describe when you clear the cache=2E I would think of:

* Media change
* Updating partition table (mbr and gpt commands)
* Any raw write to sector < 35

I cannot see any of this implemented=2E

>
>Signed-off-by: Neil Armstrong <neil=2Earmstrong@linaro=2Eorg>
>---
> disk/part_efi=2Ec | 93 +++++++++++++++++++++++++++++++++++++++++++++++--=
--------
> 1 file changed, 77 insertions(+), 16 deletions(-)
>
>diff --git a/disk/part_efi=2Ec b/disk/part_efi=2Ec
>index 932d058c184ce6946b7142e7c2d9637b28e4661e=2E=2E4f02fabe265ce5ca4c8f5=
5e41768a95582022e21 100644
>--- a/disk/part_efi=2Ec
>+++ b/disk/part_efi=2Ec
>@@ -55,13 +55,59 @@ static inline u32 efi_crc32(const void *buf, u32 len)
> static int pmbr_part_valid(struct partition *part);
> static int is_pmbr_valid(legacy_mbr * mbr);
> static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt=
_head,
>-			gpt_entry **pgpt_pte);
>+			gpt_entry **pgpt_pte, bool cache);

Please, provide Sphinx style function documentation describing all paramet=
ers=2E

> static gpt_entry *alloc_read_gpt_entries(struct blk_desc *desc,
> 					 gpt_header *pgpt_head);
> static int is_pte_valid(gpt_entry * pte);
> static int find_valid_gpt(struct blk_desc *desc, gpt_header *gpt_head,
> 			  gpt_entry **pgpt_pte);
>=20
>+static struct gpt_pte_cache_data {

Please, provide Sphinx style documentation for the structure and its eleme=
nts=2E=20


>+	struct blk_desc *desc;
>+	u64 lba;
>+	gpt_entry *gpt_pte;
>+	gpt_header gpt_head;
>+} gpt_pte_cache;
>+
>+static void clear_gpt_pte_cache(void)
>+{

Add function documentation for all changed function interfaces=2E

Besr regards

Heinrich=20

>+	if (gpt_pte_cache=2Edesc) {
>+		if (gpt_pte_cache=2Egpt_pte)
>+			free(gpt_pte_cache=2Egpt_pte);
>+
>+		memset(&gpt_pte_cache, 0, sizeof(gpt_pte_cache));
>+	}
>+}
>+
>+static void cache_gpt_pte(struct blk_desc *desc, u64 lba,
>+			  gpt_entry *gpt_pte, gpt_header *pgpt_head)
>+{
>+	if (gpt_pte_cache=2Egpt_pte)
>+		free(gpt_pte_cache=2Egpt_pte);
>+
>+	gpt_pte_cache=2Edesc =3D desc;
>+	gpt_pte_cache=2Elba =3D lba;
>+	gpt_pte_cache=2Egpt_pte =3D gpt_pte;
>+	if (pgpt_head)
>+		memcpy(&gpt_pte_cache=2Egpt_head, pgpt_head, sizeof(gpt_header));
>+}
>+
>+static gpt_entry *get_cached_gpt_pte(struct blk_desc *desc, u64 lba,
>+				     gpt_header *pgpt_head)
>+{
>+	if (gpt_pte_cache=2Edesc && gpt_pte_cache=2Egpt_pte) {
>+		if (gpt_pte_cache=2Edesc =3D=3D desc &&
>+		    gpt_pte_cache=2Elba =3D=3D lba) {
>+			memcpy(pgpt_head, &gpt_pte_cache=2Egpt_head, sizeof(gpt_header));
>+			return gpt_pte_cache=2Egpt_pte;
>+		}
>+
>+		clear_gpt_pte_cache();
>+	}
>+
>+	return NULL;
>+}
>+
> static char *print_efiname(gpt_entry *pte)
> {
> 	static char name[PARTNAME_SZ + 1];
>@@ -211,8 +257,6 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
> 	guid_bin =3D gpt_head->disk_guid=2Eb;
> 	uuid_bin_to_str(guid_bin, guid, UUID_STR_FORMAT_GUID);
>=20
>-	/* Remember to free pte */
>-	free(gpt_pte);
> 	return 0;
> }
>=20
>@@ -252,9 +296,6 @@ static void __maybe_unused part_print_efi(struct blk_=
desc *desc)
> 		uuid =3D (unsigned char *)gpt_pte[i]=2Eunique_partition_guid=2Eb;
> 		printf("\tguid:\t%pUl\n", uuid);
> 	}
>-
>-	/* Remember to free pte */
>-	free(gpt_pte);
> 	return;
> }
>=20
>@@ -277,7 +318,6 @@ static int __maybe_unused part_get_info_efi(struct bl=
k_desc *desc, int part,
> 	if (part > le32_to_cpu(gpt_head->num_partition_entries) ||
> 	    !is_pte_valid(&gpt_pte[part - 1])) {
> 		log_debug("Invalid partition number %d\n", part);
>-		free(gpt_pte);
> 		return -EPERM;
> 	}
>=20
>@@ -307,8 +347,6 @@ static int __maybe_unused part_get_info_efi(struct bl=
k_desc *desc, int part,
> 	log_debug("start 0x" LBAF ", size 0x" LBAF ", name %s\n", info->start,
> 		  info->size, info->name);
>=20
>-	/* Remember to free pte */
>-	free(gpt_pte);
> 	return 0;
> }
>=20
>@@ -382,6 +420,9 @@ int write_gpt_table(struct blk_desc *desc, gpt_header=
 *gpt_h, gpt_entry *gpt_e)
> 					   * sizeof(gpt_entry)), desc);
> 	u32 calc_crc32;
>=20
>+	/* Clean cache */
>+	clear_gpt_pte_cache();
>+
> 	debug("max lba: %x\n", (u32)desc->lba);
> 	/* Setup the Protective MBR */
> 	if (set_protective_mbr(desc) < 0)
>@@ -620,6 +661,9 @@ int gpt_restore(struct blk_desc *desc, char *str_disk=
_guid,
> 	gpt_entry *gpt_e;
> 	int ret, size;
>=20
>+	/* Clean cache */
>+	clear_gpt_pte_cache();
>+
> 	size =3D PAD_TO_BLOCKSIZE(sizeof(gpt_header), desc);
> 	gpt_h =3D malloc_cache_aligned(size);
> 	if (gpt_h =3D=3D NULL) {
>@@ -689,7 +733,7 @@ int gpt_verify_headers(struct blk_desc *desc, gpt_hea=
der *gpt_head,
> 	 */
> 	if (is_gpt_valid(desc,
> 			 GPT_PRIMARY_PARTITION_TABLE_LBA,
>-			 gpt_head, gpt_pte) !=3D 1) {
>+			 gpt_head, gpt_pte, false) !=3D 1) {
> 		log_debug("Invalid GPT\n");
> 		return -1;
> 	}
>@@ -706,7 +750,7 @@ int gpt_verify_headers(struct blk_desc *desc, gpt_hea=
der *gpt_head,
> 	}
>=20
> 	if (is_gpt_valid(desc, (desc->lba - 1),
>-			 gpt_head, gpt_pte) !=3D 1) {
>+			 gpt_head, gpt_pte, false) !=3D 1) {
> 		log_debug("Invalid Backup GPT\n");
> 		return -1;
> 	}
>@@ -764,10 +808,13 @@ int gpt_repair_headers(struct blk_desc *desc)
> 	int is_gpt1_valid, is_gpt2_valid;
> 	int ret =3D -1;
>=20
>+	/* Clean cache */
>+	clear_gpt_pte_cache();
>+
> 	is_gpt1_valid =3D is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA,
>-				     gpt_h1, &gpt_e1);
>+				     gpt_h1, &gpt_e1, false);
> 	is_gpt2_valid =3D is_gpt_valid(desc, desc->lba - 1,
>-				     gpt_h2, &gpt_e2);
>+				     gpt_h2, &gpt_e2, false);
>=20
> 	if (is_gpt1_valid && is_gpt2_valid) {
> 		ret =3D 0;
>@@ -906,6 +953,9 @@ int write_mbr_and_gpt_partitions(struct blk_desc *des=
c, void *buf)
> 	lbaint_t lba;
> 	int cnt;
>=20
>+	/* Clean cache */
>+	clear_gpt_pte_cache();
>+
> 	if (is_valid_gpt_buf(desc, buf))
> 		return -1;
>=20
>@@ -1023,12 +1073,13 @@ static int is_pmbr_valid(legacy_mbr *mbr)
>  * lba is the logical block address of the GPT header to test
>  * gpt is a GPT header ptr, filled on return=2E
>  * ptes is a PTEs ptr, filled on return=2E
>+ * cache is a bool, true to use the cached gpt_pte from previous call
>  *
>  * Description: returns 1 if valid,  0 on error, 2 if ignored header
>  * If valid, returns pointers to PTEs=2E
>  */
> static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt=
_head,
>-			gpt_entry **pgpt_pte)
>+			gpt_entry **pgpt_pte, bool cache)
> {
> 	/* Confirm valid arguments prior to allocation=2E */
> 	if (!desc || !pgpt_head) {
>@@ -1036,6 +1087,12 @@ static int is_gpt_valid(struct blk_desc *desc, u64=
 lba, gpt_header *pgpt_head,
> 		return 0;
> 	}
>=20
>+	if (cache) {
>+		*pgpt_pte =3D get_cached_gpt_pte(desc, lba, pgpt_head);
>+		if (*pgpt_pte)
>+			return 1;
>+	}
>+
> 	ALLOC_CACHE_ALIGN_BUFFER_PAD(legacy_mbr, mbr, 1, desc->blksz);
>=20
> 	/* Read MBR Header from device */
>@@ -1081,6 +1138,9 @@ static int is_gpt_valid(struct blk_desc *desc, u64 =
lba, gpt_header *pgpt_head,
> 		return 0;
> 	}
>=20
>+	if (cache)
>+		cache_gpt_pte(desc, lba, *pgpt_pte, pgpt_head);
>+
> 	/* We're done, all's well */
> 	return 1;
> }
>@@ -1100,13 +1160,14 @@ static int find_valid_gpt(struct blk_desc *desc, =
gpt_header *gpt_head,
> 	int r;
>=20
> 	r =3D is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, gpt_head,
>-			 pgpt_pte);
>+			 pgpt_pte, true);
>=20
> 	if (r !=3D 1) {
> 		if (r !=3D 2)
> 			log_debug("Invalid GPT\n");
>=20
>-		if (is_gpt_valid(desc, desc->lba - 1, gpt_head, pgpt_pte)
>+		if (is_gpt_valid(desc, desc->lba - 1, gpt_head, pgpt_pte,
>+				 true)
> 		    !=3D 1) {
> 			log_debug("Invalid Backup GPT\n");
> 			return 0;
>
>---
>base-commit: 4adbf64ff8d8c730223fd8ae299d770bebb6fe86
>change-id: 20250327-u-boot-efi-part-cache-ddc1499c3ef6
>
>Best regards,

