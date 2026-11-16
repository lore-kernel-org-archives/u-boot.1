Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470CE606A333
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 04:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QcdKr6sW;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=03kmQieL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23539605DA;
	Tue, 17 Nov 2026 04:34:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R_WjTz3a6FYU; Tue, 17 Nov 2026 04:34:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5735A605FF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794890090;
	b=H/GnlE18Cseapq7XyuZE3j+RKamEmWSElC3FB6MfAbaYMF/kHxQaPGLktC0ahsILHFJM
	 jGE1xaElJO14JMKfZt6jxI9623g2qfkbAiXtnOrb+KZHIhW7K7jtos0dBEgl5Zn41APbb
	 EFrleW6lYPSA1Knhyxi3KaQ+bwt8OKJBbG1RTLdYD/leoCAkzGdyeYnmisEleokDJJhz8
	 fmL33S9jjUOA69SUDXRXXbzsu9cKiVgf+lMs7zQ5fOXE3Y/LWO7KQ5uqgX0PG95fiF1Jg
	 Mi1kP6lA+2mn1oeVDsyG89iawGHUYgshibjPD3Lo2d1vr40/F9gej2hO3zHurk/yiLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794890090;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BJVfrYo/8kzPEiwrZkol/knSKexaW6h95r3S1lOu9AA=;
	b=EZYLgg/rF8suVXzmOQHVJeq477nNLWB1tW4jdvp+P1y6W/Y6ohmBhdkA6HLFD+x+11fE
	 Vp0XfgdFdm0B5ws+7CM7zfhXNjxABtKPytGfR+G63LYO4+oeuzPfhctRFb6VbfXgy97gq
	 TtS6O194hzU8XIF3IN6ne+ZI4gXFoefG4Jc5QuORw7dFoPzRQKYvIp28UNzDvbLK4ussc
	 OmzmVfK/WHhyX43A/LXDXh2wxLizs+xPOJ/6Mij1Q12kPWWI8ZrkY6HkasHc7P1eNCJM3
	 JzrT2/Z+1DRElXqUVmnyNKQPv94Kd0VK8qg2BV4cQrqYHoG4RbsyECiK23uUlh1amRQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794890090;
	bh=BJVfrYo/8kzPEiwrZkol/knSKexaW6h95r3S1lOu9AA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QcdKr6sW47pHSU3SToezNMejpaH8pTDmeryWoFnmJwSHzgRiXzK5GdtfO8OH+sJmy
	 W4Hc+dEyxzWB9QQgxsuNmwi26TftqRum9uqUduwDA5/A03Aka2aOQv47dQcMCBKJPJ
	 aVYd3yB1rKecAzeQpmi9DtVGZW6ucPNzmy/b7lasiuwLXfiZpjDLkos0PdwKMg0DIT
	 Vfx1osjq4W9AgwhQMTI+PgsnBnQwmXM9M72i0oLoMXSjRspORnZg3l6QMoELt3uw0A
	 GCdyMER5ezh5/sIJnOCy3gX3YLM8pcSBUW9xbB52SPRoyIraJpedvR/MlvRXhrvNUO
	 /1Q7ruLyPHotg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5735A605FF;
	Tue, 17 Nov 2026 04:34:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 09C1F1E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD561402CD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:01:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k1hmIOWAyq0K for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 21:01:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E98CC402CA
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com;
 envelope-from=dilipchowdary21@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=03kmQieL
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E98CC402CA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:01:58 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b360828905so37312567b3.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794862917; x=1795467717;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BJVfrYo/8kzPEiwrZkol/knSKexaW6h95r3S1lOu9AA=;
 b=03kmQieLAcK+y/dDOVGtqZIqCaTUwj1beqfE6jMjazNjH/2nWLFyfrFPkct6IDv2LQ
 yGw9xC/g5hCC1FuMDHcvX80nbl9zFpTV2DcfCCZD+4wi1l5C7N12ftqj4OVe2JeAdICC
 WrJchSEF1a19A8fCIz2kSYkxrqvTlJz+5x0vSscBPgGYjAbvlntrdflPz4VPJOVV5w88
 J/JJCj24g7tZQg2J61JILb6XYhj9jPEsBlj8WFCB4vfU/jH+Nw5ykyiRS/phoBRytLe8
 0lOE3Oy1qQH0REF8HUwZZ0EumDNBQw2plsR/Ky7SACj+rkNxIeYjdpJNJQHoOuvhXuwb
 iDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794862917; x=1795467717;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BJVfrYo/8kzPEiwrZkol/knSKexaW6h95r3S1lOu9AA=;
 b=YZGWOVT6+xJy2146aldTnAbuJkwyKmBHV6RnuC3mCJZkb/6+GSmHSJ86913KV/2lbB
 WB9NjHqr0hl1MnLUJtfhz7IhyAzANj7zrVy6Z4iIottWf6NpNx6780ChVan/MLqyVdl3
 U8aYjUlF7NDRp98J1HdclRGuCLHySuA2eeA7DIQ6a8YcfxD32PeBBZassS23/nmiYMRo
 WVzBKioESQBmWkd4ID0iO/nzRJ2mfdkK0kgqNYNRC2u3iAZHUz/SbZsyzDDUNMxYtcXQ
 12mX+KsY6KuUoWvfnTh6X/NIXlU6zTbOmZ+DDpnuP0cNKkNnqCG5X3y2yk0FfVlz5gkD
 ddsw==
X-Forwarded-Encrypted: i=1;
 AL+hErGUae+nCBXGmveSL2Jb/Xd/F+aVk9C1rI+fHAN/kzZCXW0zoh1tVdvJG3toZzSPGESnrlAnut8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+rHH7EEzrgc1RagMwhRxLQA90Jz6+zr/NQgDuSaZadRCpwtLAi
 w743t48yLJUFvnlTiLYd46MlR9jCPXhKzjvE7gH4WyUXs3uR8qBx9ixF
X-Gm-Gg: AZFdTZf/B3bVn4t8E1n7jHIh/yNuuoetygBQy7LS3dQ+UnKuQyNvDe7ZSgRarQ6efzj
 ASaV2zb/anmZg5vVTMUGwKe8GPtgVBzRetJUUI7+oLaQRPIQQzAZbTihEQv/aDYCtngJscD4ZY2
 KVA9P26vXjCLz9vJ11VV9BPiWl4auxxsT6YEuCvgM8RM/y5/OSv3a19cYfRj2qgEmZRTLwmaZBe
 N9SB3mWUg0JO5YPqBlvn+SuAWywqtAoCuFzTJ4SOBmhPbgzNIxDt4sOreTwh1jl+d1SJy9UIdC6
 kmG22vbG5Xde/HMQat8oJJpG92m/xk3awPCnzkPriuONNUl5VuvAiXFoQ2AfR9wRmCntmoUGxQM
 fxjOhiocfKNDOEZqIzdpQqm/5sWsY9Odrl/oOCiWozNLbNjedewtykUFJaNRpNuipvH4nxmxD7V
 gSn7br7UCKEeKL7ZEv4+9bo+EjdR+V4zkactvXn3SVWd828aC+cyr16/GkdUD5tLo2qIM7yLH9x
 R7PkOoCtnnTsSuLhQYzng5z8W4/UdPFm20tpd+7hbEGWZqjrg1F400v1pHf9svN5HLk2+Fdq0fH
 SlHFXjasXgo+Q8X7Bk1BUZ7SkFKSOnXLzUzuAb5nLYPxAt982NJtvXyyL4W2tcF5gdOuukcoqFZ
 4GaD7dzzMUREYrpMISAek0y31Xh7U
X-Received: by 2002:a05:690c:c4e5:b0:8b4:d8c6:4da7 with SMTP id
 00721157ae682-8b4d8c65098mr19016147b3.103.1794862917058; 
 Mon, 16 Nov 2026 13:01:57 -0800 (PST)
Received: from d3sec.localdomain ([216.170.66.174])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4eb7f2057sm8795767b3.5.2026.11.16.13.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:01:56 -0800 (PST)
From: Dilip Mallavarapu <dilipchowdary21@gmail.com>
To: Alexey Charkov <alchark@flipper.net>,
	Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Dilip Mallavarapu <dilipchowdary21@gmail.com>
Subject: [PATCH] disk: part_efi: fix two out-of-bounds reads on crafted GPT
Date: Mon, 16 Nov 2026 15:01:48 -0600
Message-ID: <20261116210148.15202-1-dilipchowdary21@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Nov 2026 04:34:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two attacker-controlled header fields are used without bounds when
parsing a GPT, which is done automatically while probing a block device:

1) alloc_read_gpt_entries(): count = num_partition_entries *
   sizeof_partition_entry is evaluated in 32-bit and wraps (even on
   64-bit), under-sizing the entry buffer while part_print_efi() /
   part_get_info_efi() iterate the full num_partition_entries with a
   sizeof(gpt_entry) stride -> heap OOB read and partition-name info
   leak (CWE-190/125). Compute in size_t so an oversized array fails
   allocation, and require sizeof_partition_entry == sizeof(gpt_entry)
   so the buffer and the iteration stride agree.

2) validate_gpt_header(): efi_crc32(gpt_h, header_size) runs over an
   attacker-controlled header_size on a single-block buffer -> OOB read
   of up to ~4 GiB before the CRC is even compared (CWE-125). Bound
   header_size to [sizeof(gpt_header), block_size] in is_gpt_valid().

Signed-off-by: Dilip Mallavarapu <dilipchowdary21@gmail.com>
---
 disk/part_efi.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index d8751297fbe..9f1d2953556 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -1095,6 +1095,17 @@ static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
 		return 2;
 	}
 
+	/*
+	 * header_size is used as the length for the header CRC. Bound it to the
+	 * block that was read so efi_crc32() cannot run off the buffer.
+	 */
+	if (le32_to_cpu(pgpt_head->header_size) < sizeof(gpt_header) ||
+	    le32_to_cpu(pgpt_head->header_size) > desc->blksz) {
+		log_debug("GPT: invalid header_size %u\n",
+			  le32_to_cpu(pgpt_head->header_size));
+		return 0;
+	}
+
 	if (validate_gpt_header(pgpt_head, (lbaint_t)lba, desc->lba))
 		return 0;
 
@@ -1177,7 +1188,24 @@ static gpt_entry *alloc_read_gpt_entries(struct blk_desc *desc,
 		return NULL;
 	}
 
-	count = le32_to_cpu(pgpt_head->num_partition_entries) *
+	/*
+	 * Both fields are u32, so the product is evaluated in 32-bit and can
+	 * wrap (even on 64-bit builds), under-sizing the allocation while the
+	 * callers still iterate the full num_partition_entries. Compute in
+	 * 64-bit so an oversized array fails allocation rather than overflowing.
+	 */
+	/*
+	 * The entry array is indexed as gpt_entry[i] (sizeof(gpt_entry) stride),
+	 * so the on-disk entry size must match or the buffer and the iteration
+	 * disagree. Reject anything else.
+	 */
+	if (le32_to_cpu(pgpt_head->sizeof_partition_entry) != sizeof(gpt_entry)) {
+		log_debug("GPT: unexpected sizeof_partition_entry %u\n",
+			  le32_to_cpu(pgpt_head->sizeof_partition_entry));
+		return NULL;
+	}
+
+	count = (size_t)le32_to_cpu(pgpt_head->num_partition_entries) *
 		le32_to_cpu(pgpt_head->sizeof_partition_entry);
 
 	log_debug("count = %u * %u = %lu\n",
-- 
2.53.0

