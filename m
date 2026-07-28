Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF54C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9F40608AF;
	Tue, 28 Jul 2026 12:59:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aVdtdpKnRdo1; Tue, 28 Jul 2026 12:59:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5AE3608AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243596;
	bh=koYc3bzfM/+fc53dngKYzt2TYX9zVljTftQOT6MDVUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XMXvSQ6Be8vu8T2xaNHel387n5aACx6hmNg26UJJqOiTwUgZiH/M5hgXlv6fUwW7C
	 Hxj/8jVF/chTOPxR3NIggUCHp7WgBRlzcg5Kvk1qLCmxCdAxMlA+q0G+DmY9LjqeMT
	 mhigsFiDZ2nM4fmHn1oiWbodhU5YjnVOcfSBceHH3lw9IMIiOfXYwYPRd65+xk4cvx
	 0tVYV0wMZJl8qh/VOyLbb0BhURV+8U3yZYZn1bupQEFTaniax671an3xe3ZGpIuf+a
	 u46CNTsZF48ENnjFkq0K1uKqonchGyfd4EjOFXwi448od+XQi4rZnGPyq63f3E2Kue
	 RT5DxX3CYeNBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5AE3608AA;
	Tue, 28 Jul 2026 12:59:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DD990357
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D00B881236
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:55:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G8qlIAlXkUje for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:55:52 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 636EF80C93
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 636EF80C93
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 636EF80C93
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:55:51 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69ffb48d599so2690451a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221749; x=1785826549;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=koYc3bzfM/+fc53dngKYzt2TYX9zVljTftQOT6MDVUQ=;
 b=kNp5R3aoGos3ee3Wm0SBlFqIOU6tb4w/hbnCKlZ0Y4P66U3pVeWN0WtI84hO1SIM+m
 MyJgYScU5o6kf622qEs9FHffyUys84pVlNzKudkg/wAdpvGZH3azxhIiPyQ+ukut+i1j
 WMU95R+hz8iLEx80/qZxE/62sw1Y4rEX8M5YYEtDG/WbEbxtt6AlQvh+gGFaqa4FtNHn
 xk31UBejijhJqW/U2TeW9ZDEV3e0AwCBKN0LpOMQtRea9RBSSNrI+4smiEFgvc976KFe
 RbKfs+seAlZXVHDoBZL5IsdBHgN1cH6JNlQlWGrpGnHwvxR1nP3lDfA56bUnOPp7Hmiz
 kyCA==
X-Gm-Message-State: AOJu0YxkZ8Wsd2HJWBnUqhB1AlplKkDAGOA0Ekr2IVcNKl6HBli2RrIL
 7TG+tr+niGRC+IdvHDHsWnRAytQUadE2NLBcphVecPUVZz9lGkrweDiGoM8E9yMvL40=
X-Gm-Gg: AR+sD123plmbf2iuzapx6KAEryaqidQUh0Mqs6jYpjcEd8XErzj/7TIG6l3lU29vaYq
 Re3KT9KTX/udyEgiB+K4bqfW5iV2PLHzBrhIjh9kowsON0BJ4l2kr2PXlOMR9Duh3dZtwWBA7Z6
 rJ9duzqhg9iXsv0tYMTn5lOGHlJCT4dXNtFEEPde5oJxBQ57GEi+UcruSUad1X42MmefkCQ+cqd
 q2EFS5MtcUVXaVfYsBisPL/O83EV9uA09VK97gPW7k+SeAWHZac+hr09mf7tbhudsCyKUy48Rwm
 zN02JzkabOLC+P6BIGX/JKLLTSwkpPwKUuXMwY4uMj2Flg4Gi9P/71dLDL+l1MgHWJftcbjzvaR
 1h2aUQ+d1rMUmZoxDgO+OPWCzlyXff9+tut06/0xDYJM6NMZW9JJp3PznfRa2BJzu2Uz0Q3opmq
 NxPBekunwqGzMP4eCOv3t2X8HFloWcInEgfRzB9zcwdbB0LtuDU1/F+qSdW8ZqLG6rMjc=
X-Received: by 2002:a05:6402:4516:b0:699:6415:751b with SMTP id
 4fb4d7f45d1cf-6a034a6211dmr427948a12.24.1785221749436; 
 Mon, 27 Jul 2026 23:55:49 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00d97d5688120f3c08.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:d97d:5688:120f:3c08])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb5746e08sm3493586a12.23.2026.07.27.23.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 23:55:49 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Tue, 28 Jul 2026 08:55:39 +0200
Subject: [PATCH v2 1/2] fs/squashfs: fix integer overflow in directory
 table allocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-sqfs-oob-fix-v2-1-077d9f0e01c4@byteray.co.uk>
References: <20260728-sqfs-oob-fix-v2-0-077d9f0e01c4@byteray.co.uk>
In-Reply-To: <20260728-sqfs-oob-fix-v2-0-077d9f0e01c4@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>, u-boot@lists.denx.de
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Michael Zimmermann <sigmaepsilon92@gmail.com>, 
 Eric Kilmer <eric.kilmer@trailofbits.com>, Argus <argus@byteray.co.uk>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785221749; x=1785826549;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=koYc3bzfM/+fc53dngKYzt2TYX9zVljTftQOT6MDVUQ=;
 b=TdR5SI9x9+FwyztgUTUQEPWXvZ03+StrdNfl+Zp1k+cPgcPWK0AOx7JGGfGne50Wd7
 urTjo0qI1W5rmskRipaU0V5tDW3oRCwrjP1xR8yy/bCg9PH0hxk44XkbUUD9AKi8NmVT
 TGzZicIeRoLVd5PpFl/HChYpQOTla1GrWVys6ak5S70aVsGJnpxvbhQ1zbS//7YyO2eb
 8PrR9paWtu38dYMT1GLOuGhI8WCOrv7SCiP3bRE0TDrTfZSCTBxznEYToJ6Btxjd1rr7
 /s/c9RvSocSA2jstw/KOenC0h/m0x80fdtFF+BRZZKCrvjcXdSEn66w782fIow2CD4Z7
 WJrg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=TdR5SI9x
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

sqfs_read_directory_table() allocates the directory table with
malloc(metablks_count * SQFS_METADATA_BLOCK_SIZE). metablks_count is an
int and SQFS_METADATA_BLOCK_SIZE is 8192, so the multiply is evaluated in
int and wraps for metablks_count >= 2^19. metablks_count comes from the
attacker-controlled superblock (sqfs_count_metablks() grows it by one per
2-byte metadata header), so a crafted image under-allocates the buffer
while the fill loop still writes metablks_count metadata blocks into it,
a heap out-of-bounds write. It is reached by listing or reading the image
(sqfsls / sqfsload). The position list allocation on the next line has the
same unchecked-multiply shape.

Size both allocations with __builtin_mul_overflow() and reject the image
on overflow, as the disk-read buffers earlier in the same function already
do. Set the error return when either allocation fails so the caller does
not proceed with a NULL directory table.

Fixes: c51006130370 ("fs/squashfs: new filesystem")
Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 fs/squashfs/sqfs.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 0768fc4a7b2..3aadcdd36ec 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -852,13 +852,28 @@ static int sqfs_read_directory_table(unsigned char **dir_table, u32 **pos_list)
 	if (metablks_count < 1)
 		goto out;
 
-	*dir_table = malloc(metablks_count * SQFS_METADATA_BLOCK_SIZE);
-	if (!*dir_table)
+	if (__builtin_mul_overflow(metablks_count, SQFS_METADATA_BLOCK_SIZE,
+				   &buf_size)) {
+		metablks_count = -1;
+		goto out;
+	}
+
+	*dir_table = malloc(buf_size);
+	if (!*dir_table) {
+		metablks_count = -1;
+		goto out;
+	}
+
+	if (__builtin_mul_overflow(metablks_count, sizeof(u32), &buf_size)) {
+		metablks_count = -1;
 		goto out;
+	}
 
-	*pos_list = malloc(metablks_count * sizeof(u32));
-	if (!*pos_list)
+	*pos_list = malloc(buf_size);
+	if (!*pos_list) {
+		metablks_count = -1;
 		goto out;
+	}
 
 	ret = sqfs_get_metablk_pos(*pos_list, dtb, table_offset,
 				   metablks_count);

-- 
2.43.0

