Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A77C5516D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 12:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56E70410ED;
	Fri, 31 Jul 2026 12:40:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fxKIjCE1A7AP; Fri, 31 Jul 2026 12:40:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8424A4109E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785501640;
	bh=2RP6uE4OF3H+9ZCyi7POZTWcG7NafS5Iq/IlroZl/94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=deVC1UpPUAPBUdaKhKLzjs38xaUjR5jf/WlMMC/5RGZi3d8KX6Bb2tS8EPiwhspOO
	 SvLXtZSFVXzYFVc2Z6zBXxUvNazL3CZaT4VmP9GmVZqVS8fo8UOR3HVXB35iYaHbLS
	 R5i34Lffx9Sou34mVXaWehxsNlQpd63uakf6lpcw+l6gFUbPJ0rGZ2MgBox8fswPAf
	 a7UrOHWbqyvIvf1RwJlBd1D3CzAKQOo721yXFyEh935IrdRH6vFJRoogrtIi9XPjB7
	 4Yi+2KD8ikui4cor19zvV6VePNXXMUCllNDOJukpBArDUV13vYmkNq6wuJXTsVmiFF
	 UWS/u6fiYwqIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8424A4109E;
	Fri, 31 Jul 2026 12:40:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 50D1837F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3706F4047C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yVmTRzvp4mrb for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 12:40:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3768540471
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3768540471
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3768540471
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:38 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47f7872abb6so675071f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 05:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501636; x=1786106436;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2RP6uE4OF3H+9ZCyi7POZTWcG7NafS5Iq/IlroZl/94=;
 b=ZlgA5idOF4NazElTDQ9kspAmGOJRTrgSwWeMhlfiZT+GOZ7cBxw7iV9pqv88w+NiS3
 6+7PLSUvoxzlWNHZyunLFsthOlS1VpMuw71kTO8vSYV+dXjGhD3IcqAiLfEhFVGEAXTV
 yho4A1jWAnnZq0X8wqt29vqVr2j9ErX+IEUxfK0pZzrbsZ7Rwc18lf6BuuT5fmK2kTdp
 C/t5aBwMY/rf4EQQ2GEfKQ02L1zQitlcIz4n3X8zD9wthlXCXxFSYNRPwIKk3lXnaL5Y
 Z0bMbgaaDcklLBtuzIL01SlWHNAq9I0Dk/xvgmrLb1vmX+gvdyngPAI7TDYbZbX+nRmQ
 Bl1w==
X-Gm-Message-State: AOJu0Yw+jlZ3q3ruDVUGKYDgVvdB2D9q6dcCwNavQ45q8LALtScSAjOM
 Q8Jkio3tsI3M3gizYebuxk/7KX62sbzC/PmsrVbCP+2SOQ0YSe4GIdk49uE9UC85GWY=
X-Gm-Gg: AR+sD138cYZeBJtNqftxCfV1Zv4nkAOmpbbeRo7u9vAwGu5sIsJeBoLQROmJ1cU6Udg
 6PVQRRyVndooq7EPN/ZDNpDRjPu6G68DqkD/EPonNloSp4E1x9mYLG7D3XYNNamSPIBjmnlQNU9
 pnRdJxJEPbmabUz1gSd+0OySgflpg7KzWScR6ONwkghIx60rxPnySvOoP7GYg+kwWM1pxoFxv/t
 vD4QYYKSoI8jlJFNDyz7/shBrWkGX6bj3GHmnvuE9j+Hs+3RYYeFHsEWsPlCOObYItg65afsnkN
 k4ADGnk4EZshGkX0jNNd2VCGpE0mRQQTOi6hx30/5MvOSWszBmCF9ujpdhkigmxgvx8GpJib1IT
 Xovy30uNT5HulEo+rojN5fD1TMMzG38mi5Fyt0ovM8QdS4xmJWz7rXvV7PqLXrACf+X8WMFT/sH
 gkdWyqzummAipWWePtTxvFE0QdJnZ0GRa77yGrVy8mrp/gOONYQxZ4smwUVO1nPDrkpFrlIV1XT
 RJdPtUPZcH/WUxjIXvNbXFWdnDubhXgIFd0XpuwCQ==
X-Received: by 2002:a05:6000:184b:b0:47f:853d:4768 with SMTP id
 ffacd0b85a97d-47fd2acb828mr4258295f8f.20.1785501636112; 
 Fri, 31 Jul 2026 05:40:36 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e296csm4493682f8f.12.2026.07.31.05.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:40:35 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 16:40:00 +0400
Subject: [PATCH 1/6] disk: part_efi: Size the partition entry array from
 the block size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-gpt-4k-v1-1-a3f1f16b53ae@flipper.net>
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>, Anton Burticica <mouse@ya.ru>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6368; i=alchark@flipper.net;
 h=from:subject:message-id; bh=RCdV+jpxr2/+Eo6jh8TGCsxQ9dsRHKF3rBpoXhXWmDM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlTN9Vk3xlx+ZZAiYHj/XeEdCtjk1TNt1b5TphvrSIb
 SxLVjFnx0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFN94Bgjw76ALZ57Tvy23rwv9K3RzhM6t2fX3lO6Ha2XUv/L7GCkyxqGfzqJ9u9
 3u9cLO+y/cT+F87LdOt0zM26bT8wp2pD89/OUI6wA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785501636; x=1786106436;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2RP6uE4OF3H+9ZCyi7POZTWcG7NafS5Iq/IlroZl/94=;
 b=gyxmwdUj/d8BmE3h+doraIeKY857/OGgbSSdsTRw/GQmLjwVpXYQfUV9tWNeNLJr2/
 cf+LMjtxWZlts5QUdOehyTzyrGPB/QfCME7t4KlCODYSyEpGP5maSVtG9t5HXh2dEc/T
 TcAmoDimDSM6V1JGq5egI6Ef+u++ZbnSGZshIJjVH5TkDuJ7MhC+aIZR7a+79+1qDKHr
 zvlFkSajUFIMh0+SudeTfWSvAsoIYn/9obCtSRsWGgaOGG0uXiOb0y6glOzvVnuU/XnJ
 s+bT1VcqhpV/+uiHk3V2rQXiqhVrhfox6/2lfl7f4TOYygQGxQTvK0qvkJwgq+NmCsfi
 Agzw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=gyxmwdUj
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

gpt_fill_header() computes last_usable_lba and first_usable_lba from
hardcoded block counts that silently assumes 512-byte sectors and the
default number of partition entries.

The partition entry array holds GPT_ENTRY_NUMBERS entries of 128 bytes
each, so the number of blocks it needs depends on both the entry count
and the block size. write_gpt_table() derives that count correctly and
writes the backup array at last_usable_lba + 1, so whenever the two
disagree the backup array no longer immediately precedes the backup GPT
header. Furthermore, on a device with 4096-byte native sectors, such as
UFS flash, and the default 128 entries, the array is 4 blocks rather than
32. Current code reserves 34 blocks at each end of the disk for any block
size and wastes about 114 KiB at each end.

Add a new helper gpt_pte_blocks() and use it in all four places which
currently calculate the number of blocks each in its own way, so the
layout written by gpt_fill_header() and the extent written by
write_gpt_table() cannot drift apart again. With this, first_usable_lba
on 4096-byte sectors is 6, last_usable_lba is lba - 6, and the backup
array occupies lba - 5 .. lba - 2, immediately preceding the backup
header, as the UEFI specification describes.

Note that this changes the 512-byte layout too for boards that do not use
the default entry count. CONFIG_EFI_PARTITION_ENTRIES_NUMBERS is
"default 56 if ARCH_SUNXI" and is set to 64 by a number of Rockchip
defconfigs:

  entries  array blocks  first_usable_lba  last_usable_lba
       56            14        34 -> 16    lba - 34 -> lba - 16
       64            16        34 -> 18    lba - 34 -> lba - 18
      128            32        34 -> 34    lba - 34 -> lba - 34

Existing partition tables stay readable either way, since is_gpt_valid()
locates the entry array from the on-disk partition_entry_lba. Only newly
written tables change. Partitions given without an explicit start= will
now be placed lower on those boards; on sunxi first_usable_lba lands on
the 8 KiB SPL offset, so such boards should keep specifying start=
explicitly.

While here, report both LBAs when the requested layout does not fit, since
the existing "Partitions layout exceeds disk size" debug message gives no
clue as to by how much, making it less helpful in debugging.

Co-developed-by: Anton Burticica <mouse@ya.ru>
Signed-off-by: Anton Burticica <mouse@ya.ru>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 disk/part_efi.c | 47 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index d8b17ec2e91a..af311867a285 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -388,10 +388,23 @@ static int set_protective_mbr(struct blk_desc *desc)
 	return 0;
 }
 
+/**
+ * gpt_pte_blocks() - number of blocks taken up by a partition entry array
+ *
+ * @desc:	block device descriptor
+ * @gpt_h:	GPT header describing the array
+ * Return: number of blocks the array occupies on @desc
+ */
+static u32 gpt_pte_blocks(struct blk_desc *desc, const gpt_header *gpt_h)
+{
+	return DIV_ROUND_UP(le32_to_cpu(gpt_h->num_partition_entries) *
+			    le32_to_cpu(gpt_h->sizeof_partition_entry),
+			    desc->blksz);
+}
+
 int write_gpt_table(struct blk_desc *desc, gpt_header *gpt_h, gpt_entry *gpt_e)
 {
-	const int pte_blk_cnt = BLOCK_CNT((gpt_h->num_partition_entries
-					   * sizeof(gpt_entry)), desc);
+	const int pte_blk_cnt = gpt_pte_blocks(desc, gpt_h);
 	u32 calc_crc32;
 
 	debug("max lba: %x\n", (u32)desc->lba);
@@ -453,9 +466,7 @@ int gpt_fill_pte(struct blk_desc *desc,
 	size_t hdr_end = hdr_start + 1;
 
 	size_t pte_start = gpt_h->partition_entry_lba;
-	size_t pte_end = pte_start +
-		gpt_h->num_partition_entries * gpt_h->sizeof_partition_entry /
-		desc->blksz;
+	size_t pte_end = pte_start + gpt_pte_blocks(desc, gpt_h);
 
 	for (i = 0; i < parts; i++) {
 		/* partition starting lba */
@@ -482,7 +493,9 @@ int gpt_fill_pte(struct blk_desc *desc,
 		gpt_e[i].starting_lba = cpu_to_le64(start);
 
 		if (offset > (last_usable_lba + 1)) {
-			log_debug("Partitions layout exceeds disk size\n");
+			log_debug("Partitions layout exceeds disk size: "
+				  LBAFU " > " LBAFU "\n",
+				  offset, last_usable_lba + 1);
 			return -E2BIG;
 		}
 		/* partition ending lba */
@@ -604,18 +617,29 @@ static uint32_t partition_entries_offset(struct blk_desc *desc)
 int gpt_fill_header(struct blk_desc *desc, gpt_header *gpt_h, char *str_guid,
 		    int parts_count)
 {
+	u32 pte_sectors;
+
 	gpt_h->signature = cpu_to_le64(GPT_HEADER_SIGNATURE_UBOOT);
 	gpt_h->revision = cpu_to_le32(GPT_HEADER_REVISION_V1);
 	gpt_h->header_size = cpu_to_le32(sizeof(gpt_header));
+	gpt_h->num_partition_entries = cpu_to_le32(GPT_ENTRY_NUMBERS);
+	gpt_h->sizeof_partition_entry = cpu_to_le32(sizeof(gpt_entry));
+
+	/*
+	 * Number of blocks occupied by the partition entry array. For the
+	 * default of 128 entries that is 32 blocks on 512-byte sectors, but
+	 * only 4 blocks on 4096-byte sectors.
+	 */
+	pte_sectors = gpt_pte_blocks(desc, gpt_h);
+
 	gpt_h->my_lba = cpu_to_le64(1);
 	gpt_h->alternate_lba = cpu_to_le64(desc->lba - 1);
-	gpt_h->last_usable_lba = cpu_to_le64(desc->lba - 34);
+	/* Reserve space for backup GPT header (1) + backup partition entries */
+	gpt_h->last_usable_lba = cpu_to_le64(desc->lba - pte_sectors - 2);
 	gpt_h->partition_entry_lba =
 		cpu_to_le64(partition_entries_offset(desc));
 	gpt_h->first_usable_lba =
-		cpu_to_le64(le64_to_cpu(gpt_h->partition_entry_lba) + 32);
-	gpt_h->num_partition_entries = cpu_to_le32(GPT_ENTRY_NUMBERS);
-	gpt_h->sizeof_partition_entry = cpu_to_le32(sizeof(gpt_entry));
+		cpu_to_le64(le64_to_cpu(gpt_h->partition_entry_lba) + pte_sectors);
 	gpt_h->header_crc32 = 0;
 	gpt_h->partition_entry_array_crc32 = 0;
 
@@ -747,8 +771,7 @@ static void restore_primary_gpt_header(gpt_header *gpt_h, struct blk_desc *desc)
 static int write_one_gpt_table(struct blk_desc *desc, gpt_header *gpt_h,
 			       gpt_entry *gpt_e)
 {
-	const int pte_blk_cnt = BLOCK_CNT((gpt_h->num_partition_entries
-					   * sizeof(gpt_entry)), desc);
+	const int pte_blk_cnt = gpt_pte_blocks(desc, gpt_h);
 	lbaint_t start;
 	int ret = 0;
 

-- 
2.54.0

