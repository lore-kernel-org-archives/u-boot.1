Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04648C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BB89888B7;
	Sat, 13 Jul 2024 15:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="aY0Wy7HT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pzLso7KY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03ACD888C7; Sat, 13 Jul 2024 15:21:38 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F144E888BF
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WLpyR4xKSz9spD;
 Sat, 13 Jul 2024 15:21:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YVSaCH4uPeckULe6najWpvrKjIyhMCJI6h7Ub9kM4Tc=;
 b=aY0Wy7HTRgP91BZBBKJvtlR0JIPqPPZhAYacpGSpPMiWh2QB+5IkpyKRFT+wgT0ElfDOnv
 JpC1nnp0Dloyd9toGyg+kX85qoUoBDh7GcOC0Fez/zjT7NHwhds2yeZh8qGLlSifASzOqV
 Uq7LW9JQSEhoGT2mwqzOcGvyMso+/iwdxVP2rFMy3JZp5ORkQcntknIRH1heIkoHX4mIpb
 wEvnkuRW+vOPgCjvjDIkn1z6nbm7fna6n/x/WGdsKTdHVrHWH31kTPL30wldEfwFSO44Yq
 imOWfjj4RSGWShzKAbS1azc9Iyo9D7406e+UpsDr+8YLiSSgYKuHe/WZK3OIZA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YVSaCH4uPeckULe6najWpvrKjIyhMCJI6h7Ub9kM4Tc=;
 b=pzLso7KYv40ucsOwT8pDN2TjUaOFTgOCnQ32h4z/Vcuno3L9/3mzp/+xQ3kw0qSdTTkCNQ
 Cv+zb9S0/yjOh7stzvdoqapc2TCfpestMYujHZGIpvm0GkgUyXc23v8MNBh6n0CeirMYsf
 cHq+szefRD8FIeAzWQ1GPgewSQTbuqZnMoCM/kuuXHlMM8Lr6CiGbIUBrE97czjOuTEQG6
 0aNZfRTIt1Gf8ymk9UWrrBgMhk4NOAQgmVnad2CXb/eiTAVTdBtUXR320mDZ4q89qZg9Wh
 jpUTldp/ftyFmboRiq9ZVK7F7azYGBzltZ97T9eSprZ3M77i9IRZGcJxClmYCw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 27/45] disk: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:18 +0200
Message-ID: <20240713132021.57650-27-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1cdecd59448d503ea99
X-MBO-RS-META: 7owab8y9krdw6nebp96rxh45rjymeuka
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 disk/part_amiga.c | 1 -
 disk/part_amiga.h | 2 --
 disk/part_dos.c   | 1 -
 disk/part_iso.h   | 5 -----
 disk/part_mac.c   | 3 ---
 disk/part_mac.h   | 1 -
 6 files changed, 13 deletions(-)

diff --git a/disk/part_amiga.c b/disk/part_amiga.c
index 9b0f2fe7498..5b8ae5762d3 100644
--- a/disk/part_amiga.c
+++ b/disk/part_amiga.c
@@ -304,7 +304,6 @@ static int part_get_info_amiga(struct blk_desc *desc, int part,
     info->blksz = rdb.block_bytes;
     bcpl_strcpy((char *)info->name, p->drive_name);
 
-
     disk_type = g->dos_type;
 
     info->type[0] = (disk_type & 0xFF000000)>>24;
diff --git a/disk/part_amiga.h b/disk/part_amiga.h
index dfa70bdb8a8..3c27bfe8fde 100644
--- a/disk/part_amiga.h
+++ b/disk/part_amiga.h
@@ -16,7 +16,6 @@
 #define DEFAULT_SECTOR_SIZE	512
 #endif
 
-
 #define AMIGA_BLOCK_LIMIT 16
 
 /*
@@ -102,7 +101,6 @@ struct bootcode_block
     u32   load_data[123];
 };
 
-
 #define AMIGA_ID_RDISK                  0x5244534B
 #define AMIGA_ID_PART                   0x50415254
 #define AMIGA_ID_BOOT                   0x424f4f54
diff --git a/disk/part_dos.c b/disk/part_dos.c
index e6b5295e0ec..09af2aeeb99 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -197,7 +197,6 @@ static void print_partition_extended(struct blk_desc *desc,
 	return;
 }
 
-
 /*  Print a partition that is relative to its Extended partition table
  */
 static int part_get_info_extended(struct blk_desc *desc,
diff --git a/disk/part_iso.h b/disk/part_iso.h
index eb2c3ab66f4..6973a2943e1 100644
--- a/disk/part_iso.h
+++ b/disk/part_iso.h
@@ -9,7 +9,6 @@
 #define BRVD	0x11
 #define PVD_OFFSET 0x10
 
-
 typedef struct iso_boot_rec {
 	unsigned char desctype;			/* type of Volume descriptor: 0 = boot record, 1 = primary, 2 = Supplement, 3 = volume part 0xff trminator */
 	unsigned char stand_ident[5]; /* "CD001" */
@@ -19,7 +18,6 @@ typedef struct iso_boot_rec {
 	unsigned char pointer[4];		/* absolute pointer to Boot Catalog */
 } iso_boot_rec_t;
 
-
 typedef struct iso_pri_rec {
 	unsigned char desctype;			/* type of Volume descriptor: 0 = boot record, 1 = primary, 2 = Supplement, 3 = volume part 0xff trminator */
 	unsigned char stand_ident[5]; /* "CD001" */
@@ -109,7 +107,6 @@ typedef struct iso_part_rec {
 	unsigned int partsiz_BE;		/* volume partition size BE */
 }iso_part_rec_t;
 
-
 typedef struct iso_val_entry {
 	unsigned char	header_id;		/* Header ID must be 0x01 */
 	unsigned char	platform;			/* Platform: 0=x86, 1=PowerPC, 2=MAC */
@@ -126,7 +123,6 @@ typedef struct iso_header_entry {
 	char					id_str[0x1C]; /* Ident String of sectionr */
 } iso_header_entry_t;
 
-
 typedef struct iso_init_def_entry {
 	unsigned char	boot_ind;			/* Boot indicator 0x88=bootable 0=not bootable */
 	unsigned char	boot_media;		/* boot Media Type: 0=no Emulation, 1=1.2MB floppy, 2=1.44MB floppy, 3=2.88MB floppy 4=hd (0x80) */
@@ -137,7 +133,6 @@ typedef struct iso_init_def_entry {
 	unsigned char rel_block_addr[4];	/* relative Block address */
 } iso_init_def_entry_t;
 
-
 void print_partition_cd(int dev);
 
 #endif /* _PART_CD_H */
diff --git a/disk/part_mac.c b/disk/part_mac.c
index 81a65823be9..21c85942fd8 100644
--- a/disk/part_mac.c
+++ b/disk/part_mac.c
@@ -29,7 +29,6 @@ extern ldiv_t ldiv (long int __numer, long int __denom);
 # define __ldiv_t_defined	1
 #endif
 
-
 static int part_mac_read_ddb(struct blk_desc *desc, mac_driver_desc_t *ddb_p);
 static int part_mac_read_pdb(struct blk_desc *desc, int part,
 			     mac_partition_t *pdb_p);
@@ -90,7 +89,6 @@ static void part_print_mac(struct blk_desc *desc)
 	gb.rem += 512;
 	gb.rem /= 1024;
 
-
 	printf ("Block Size=%d, Number of Blocks=%d, "
 		"Total Capacity: %ld.%ld MB = %ld.%ld GB\n"
 		"DeviceType=0x%x, DeviceId=0x%x\n\n"
@@ -148,7 +146,6 @@ static void part_print_mac(struct blk_desc *desc)
 	return;
 }
 
-
 /*
  * Read Device Descriptor Block
  */
diff --git a/disk/part_mac.h b/disk/part_mac.h
index 5f396c94089..b2ee086bb6f 100644
--- a/disk/part_mac.h
+++ b/disk/part_mac.h
@@ -43,7 +43,6 @@ typedef struct mac_driver_entry {
 	__u16	type;		/* OS Type				*/
 } mac_driver_entry_t;
 
-
 #define MAC_PARTITION_MAGIC	0x504d
 
 /* type field value for A/UX or other Unix partitions */
-- 
2.43.0

