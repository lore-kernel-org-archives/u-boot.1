Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C9DC25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 15:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7771882AA;
	Sun, 19 May 2024 17:35:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f48HD1Qm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF892882B0; Sun, 19 May 2024 17:35:50 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15A0288291
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 17:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r.stratiienko@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4201986d60aso12842545e9.3
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716132948; x=1716737748; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7uLd1c1p0xOTrgYGj6ZEkGX76XS2olZzzjsWcEcgTqA=;
 b=f48HD1Qm6ZAgWuefBVLZ6wxqoCLss1q3M3mJIKhJX8LsOCVIjav8dzW5KsR8rQlAnS
 ECuhdtD3M5hiAKYynSfgfPp2kAe5VVhdPXe2zPTno9MU4T8NG34Wj6IvqHsM9h9CnCyr
 xCEnZzDs1aLh3Ii5o9IGtSD/VRiTep1KUP5RatJOYbwMLnqGlB3OtIQesVh6eDpPRH8O
 Hh/4xRFL+rnx7P/fug/ECZ2y9ZTQuHTBshuU+LIwuFNWHCdmGN8WjpmAlqpBd9h7lXfL
 xAdssgt4DsEZlxLc4xVVCPPEcdNs7nN87jp4ewdf8Gws2vZPxODN9Z+fNww0KsZ3OIp4
 OeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716132948; x=1716737748;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7uLd1c1p0xOTrgYGj6ZEkGX76XS2olZzzjsWcEcgTqA=;
 b=kHkVB4NrvkcneEaETpP9EakIxFgz6//UOlQVfrb0pbKTaVzNMYYk080qfleM5ieqyT
 b9KAJD0ixT7sIqSNqzmn1omoBCxO+O/T6NhmTVi5wxBG02+QCoTrrDYg7INeqFPSmm1g
 U+PDPiWZZ+HZLRZOnkH2bvotsUCS5fRSB65TDyiv/AiJW9siJgMMb8i3pm9qCqHlNeqd
 uL7yGwMEWsLhpWOixW1dQtYBE/C4+LUJyqdZ/sOu56F+cwrBjLO/9fnOn8YYARWwlqcv
 cNvUuOt2JJ/XtCeZu+XR99jduZyifL8spvSsyJRt3+3NzqCRSgp7BpSirYkWc/f9qS3y
 ORnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVwUZbHbk1Y25+oOTq9J9AsNYivb2RfCxBNC4XalnZezc28LfvjtI0jhKYHZiPnTtYfsxfwhTgUPNbJZkqctEzYwCeRQ==
X-Gm-Message-State: AOJu0Yxem8TdzJeamMIXguTTSc1usmQa6YDaT2SaOOBgWFiK0DGTz/pm
 szJHiwzbKfGCfk1Z1mb9s46vtbmAzL2DyGN3JIQARiMsAXxku0R7
X-Google-Smtp-Source: AGHT+IE5DZUMMy8YDlltCFQMgjglYIY2+kddvW6J0Pi6gNR+GDrBOCku0uXZdOC2zmY8OXE/xWQkGA==
X-Received: by 2002:a05:600c:5250:b0:420:1670:d5fb with SMTP id
 5b1f17b1804b1-4201670d916mr149524055e9.10.1716132948192; 
 Sun, 19 May 2024 08:35:48 -0700 (PDT)
Received: from roman-envy-fast.. ([46.172.77.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-420149b1c24sm277082425e9.41.2024.05.19.08.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 May 2024 08:35:47 -0700 (PDT)
From: Roman Stratiienko <r.stratiienko@gmail.com>
To: sjg@chromium.org, xypron.glpk@gmx.de, r.stratiienko@gmail.com,
 u-boot@lists.denx.de
Subject: [PATCH] part: efi: Rely on a definition to specify the primary GPT
 position
Date: Sun, 19 May 2024 15:35:42 +0000
Message-Id: <20240519153542.2572014-1-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Use GPT_PRIMARY_PARTITION_TABLE_LBA as the only source for a primary GPT
location instead of hardcoding it every time.

Sometimes, we need to shift the primary GPT location.
Having the location in the single place simplifies such shifting.

Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
---
 disk/part_efi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 4ce9243ef2..b55e251ea1 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -387,7 +387,7 @@ int write_gpt_table(struct blk_desc *desc, gpt_header *gpt_h, gpt_entry *gpt_e)
 	gpt_h->header_crc32 = cpu_to_le32(calc_crc32);
 
 	/* Write the First GPT to the block right after the Legacy MBR */
-	if (blk_dwrite(desc, 1, 1, gpt_h) != 1)
+	if (blk_dwrite(desc, (lbaint_t)le64_to_cpu(gpt_h->my_lba), 1, gpt_h) != 1)
 		goto err;
 
 	if (blk_dwrite(desc, le64_to_cpu(gpt_h->partition_entry_lba),
@@ -534,7 +534,7 @@ int gpt_fill_pte(struct blk_desc *desc,
 
 static uint32_t partition_entries_offset(struct blk_desc *desc)
 {
-	uint32_t offset_blks = 2;
+	uint32_t offset_blks = GPT_PRIMARY_PARTITION_TABLE_LBA + 1;
 	uint32_t __maybe_unused offset_bytes;
 	int __maybe_unused config_offset;
 
@@ -572,8 +572,8 @@ static uint32_t partition_entries_offset(struct blk_desc *desc)
 	 * The earliest LBA this can be at is LBA#2 (i.e. right behind
 	 * the (protective) MBR and the GPT header.
 	 */
-	if (offset_blks < 2)
-		offset_blks = 2;
+	if (offset_blks < (GPT_PRIMARY_PARTITION_TABLE_LBA + 1))
+		offset_blks = GPT_PRIMARY_PARTITION_TABLE_LBA + 1;
 
 	return offset_blks;
 }
@@ -584,7 +584,7 @@ int gpt_fill_header(struct blk_desc *desc, gpt_header *gpt_h, char *str_guid,
 	gpt_h->signature = cpu_to_le64(GPT_HEADER_SIGNATURE_UBOOT);
 	gpt_h->revision = cpu_to_le32(GPT_HEADER_REVISION_V1);
 	gpt_h->header_size = cpu_to_le32(sizeof(gpt_header));
-	gpt_h->my_lba = cpu_to_le64(1);
+	gpt_h->my_lba = cpu_to_le64(GPT_PRIMARY_PARTITION_TABLE_LBA);
 	gpt_h->alternate_lba = cpu_to_le64(desc->lba - 1);
 	gpt_h->last_usable_lba = cpu_to_le64(desc->lba - 34);
 	gpt_h->partition_entry_lba =
-- 
2.40.1

