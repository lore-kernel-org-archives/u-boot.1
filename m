Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9720C606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X9ekY1In;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d5IncQOH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7499660810;
	Sun,  1 Nov 2026 07:02:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S0yNmHGaxDBz; Sun,  1 Nov 2026 07:02:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 88EC8607F0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793516577;
	b=fU+BM65Mf4VmIBJVPkubbWi4Z8ywfMcv/I6b2tdX/L5o9jXlp7rmcA3v7Be96HeO6Psl
	 TPzpJ/w74lx5uiOabFC/t9OdUxnBE3IG5CDgnPJhJE4rExHoXUSWsQUcwNCX2RUcWMmPR
	 6FXUESt3bDbq2DorNJeGjGHwZiaLdQ9yaG7SdaWmFkMwj5CBLdiAkIBSRX1bdz1TSz620
	 Y2ypldm4t2XHy1GRHG1OKfFHSK1iQ6gGnWnVvNN3pahRE/L1cxMafljNpKJJwVlc3sb6n
	 vjVNQoopozNON9zSfT6YCI7DL6LXkT+/INfXHVjwNJfS3hOvXY4eaYF9ynA8BLyS48A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793516577;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0Ai2JBk3kZH0doAyt7A1XLJy//FC92/zpCxqSze2jEs=;
	b=ebIO+B2IAfZNQD6n78ttJS4lgSt1FWcyarlZHxHPvB7H3aUnY6mG7N2WMPz6ShV2gxn3
	 qR2w0JxtFy1833E+fZDmnUkg9neUTlWYu0+S0t0wobGiWyB9YfBwo4+YTQ8eS6GruuaEk
	 iHhjK6nkp12Bm7qFtEAwJFU7At1WBMKZ3R0tWCfV9sebLqEIj/caTS9JF0aINUam2fFfO
	 4AshrYAW73tgCtOT05TSHonuEUr7MgljJlztLPfPem623r3JzvIhi+eDAEUunJ8+Czi9s
	 9UnOwx7cHIJVVtL7+feVrc982zoS4vrWBVrH7OUXIbrvbUHOf9C8q6m8vXKs9bKfNvA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793516577;
	bh=0Ai2JBk3kZH0doAyt7A1XLJy//FC92/zpCxqSze2jEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X9ekY1Inkm2cyHvZsayHNjnOah7UpNsLVXRqTvHGmWc6M7+oH06EeP9ufYPINxbtM
	 jaG/Sh97h/jxGr6mAolvLmRZ7Ei+qOq6I26qEHwocNm8QT16+GrxR4FLSBJCSvdJqh
	 lNPzWgLAYzxBnCede55XJV8GDiMj5UCrbgOdYVGYe3UZg/NHKptCe8gSgB1WeaWau0
	 rE2eEo1F3qNypwsH8sRrHpPv/Vo0WPRloWwfP+oMn0qNls381Lw2gQH7h2csVfFNXR
	 cGqm8Je7TINdCuZIlzyRYWwkP40sgExj4SXgP7+pCzcmjTSkL2bhg08ANPoKvYZ8W2
	 wa6mzSO9K+DAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88EC8607F0;
	Sun,  1 Nov 2026 07:02:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D01E411
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5EBBF407C7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l2BlFh-pOqvG for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:02:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 69B99407C5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793516574;
 b=ExbWgUr6rQpxBfCgLm+XP40lDflVDgyqULS8sKow+qG9Ycak1N4EBu9Bd0xdCexSxiZ4
 AqaX1tbegFTl3rA48l7fhG5RMSqHoK7YySFM4YGyD/u/L295s2MNprglApXVNt+brl0m8
 DfXM+JIYrHeut98TAoMZUYMPtboOa/wH4gE9kwYPdjhR4pzIyocO4WGnedwmb2fgnT1Qt
 Tis7GcPCoYCNBA0Awo99mug0mmVq9IBXd0dSGsz3m65GpeFJNwPA8iyADXPK6s6GuSY0l
 pHarRL42jbT+h4C6IdI342ag2Zi5L8C1wwsEaUqGH4eRl56fUVOPdWTEdwybkqIj5pA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793516574;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=0Ai2JBk3kZH0doAyt7A1XLJy//FC92/zpCxqSze2jEs=;
 b=dpRZu7KzblRe+EPMf8TRdC3R3JA01oyGh1oZfhj0bw0/0Z9z2l6us4LvkAWXX53hFer/
 ncwFWJml95jtGP6LjcYp6Ezp6Q8xHM4u87LLGaOZPD36pacJoGpA51zwALm87Pqkp8M5v
 5J8EGOEF+PhxKy3ziiwVAVNqJQZBHa+59ZxqJkXHNa+gyle/+B4aaFpabAfdH4b/4QD0C
 ZjvXx7Kv4LDWiAXtCLMAmXUrelo6aXzDNvCfXmJG7fsYHdvmDTXDT7zMiKMV+1Ssf7mFy
 ZDUPkgTdDgbe/D+/Tq2EJH8Nsv9WDpd+ZxMHjfJokm+ixHjO+uaaI8d2aVAEW16vjcQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=d5IncQOH; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=d5IncQOH
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 69B99407C5
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:54 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so20384705e9.2
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 00:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793516572; x=1794121372;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0Ai2JBk3kZH0doAyt7A1XLJy//FC92/zpCxqSze2jEs=;
 b=d5IncQOHhbWXFT3gHWPiB97chwy/AVtlDh084PDqAuFdSCzJTXv8lsh1tZEhdskbCH
 X6zl2451fDXh51bYAtaHxHk6QLaHvyHbzPvmRyLWfL/PBkeK4NAeepAfkKY2XPFWhzfA
 XedqndCO1DE1VjelmuKdIDTHD932XNBJacawplX7IVIT8yOIyDXtZuVL2o3eO78SkesE
 Xu5bAJty6y/bfaBfgOX5HuhYWU1lkFOPXFGurMIQWumYmUqFJEQNyg4VctheLr5aXE0p
 cQxLJYQbbz9oKgBWV3mZe4agUp7Ip2ZiQ55yODsW+EnThCCpTfZDZXN/EVo+9Or+wugT
 hR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793516572; x=1794121372;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0Ai2JBk3kZH0doAyt7A1XLJy//FC92/zpCxqSze2jEs=;
 b=L0DAhNjorl96e2FqcYWU5/kjJGXPIDJlr4yapDWZqUtDm+OPEtoxJ1ft6tbqBYQX5H
 EDmjuruPtfdoG1ZGjUpQVNJc50AovewYPVaBb3WWSlY9kGBY+bv2vksKBPhGxk4GPIqr
 8M1i6ujDNe7ya6FByOhkMRbMdeipJFK5Azk2B5sRH1QJc0MUurABmKeZtFm369qS9G+1
 MsJowMQUfWyEL4IzlpV1KO5bEkPak8rO/f9lgjQhnyQfuk4GqaNvd8OtZDnJ4PRCoteD
 cK17JXh5wNaUnwWI412krQCBPwOzSoLR7VAJVnWtlWWDQTfOWCFjg+fZK0elzJGZ+p7n
 vQxw==
X-Gm-Message-State: AFq9FYKZZTnz3CH/1TUaAfgvakRjtOYwE2h5xdSS9sPEY57JZpql6bZv
 R67VLQO+Xd3ri1CasRvZMLXnTuynNkTnH58IvXF3/z0SeJsJMWrPeQv+
X-Gm-Gg: AYBFou0kJJJu1bvrdWswv/huTZHssXTYDQ8DfMl7H09uPQS+cJUeoUHOOI8boUv4cbE
 v5Zg4jtCnw/DdZFA/c5c06/+kRTQDVBUE3v0W33zBMeyIMFfi2u2r8BFHtPXm2o56kxcA4ZZDCL
 VzA16B5EklE9DypHn1++hzrJHz1trCcMEndTVbmHDUD4j0ZVMKaSNkeUPIMI9zHnvlxNySnm9yP
 BmTKSY2Pvprza02A93EycfhgZvXM1S/VVxh3i+C2bzpDEkSS/FryMnJZmi2J2ZZR5EVWwqtPV8W
 EjKO2IkjSkFk/NS6zMfERPu62SuMi+CtqbkJZYX3RYF5guTDjEnOPrUuh1u1AizM63XRB1GeMly
 +bO5VdUx5zPgbb6r36AcMBAWdFFnyyH7QSPBukOQ3op55KhxPSBeO9RDDITHFkrJTfZVHLfaav0
 u8XXhVAjVFnc6NY/2+qCw0He4xax1L8v9O12FJ+iHi2C5ZwhacK7KT8EEquWYJZhXgPvDb+1tcD
 uEVK+F7V+fPfU3jb9lJDBcAdFSNF88xFSMQEGD6L4HiNY7V7p0TkJILsejQIU5MZfsjl/jAJLd2
 DA19wlza3vZO1BDIgBP9/dnA5M7NNcA=
X-Received: by 2002:a05:600c:468c:b0:4a3:59c9:a750 with SMTP id
 5b1f17b1804b1-4ac17d168bcmr155659675e9.9.1793516572067; 
 Sun, 01 Nov 2026 00:02:52 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a0a3495sm141871845e9.4.2026.11.01.00.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 00:02:51 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 11/14] disk: part_dos: Make room for a three-digit
 partition number in the UUID
Date: Sun, 01 Nov 2026 07:02:50 +0000
Message-ID: <6de0ac6c-e5b2-4776-9c6e-3ebd371dbfa3@gmail.com>
In-Reply-To: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
References: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

part_get_info_extended() makes up the UUID of a DOS partition as
"%08x-%02x" from the disk signature and the partition number, into a
buffer of 12 bytes. That is enough up to partition 255, but
MAX_EXT_PARTS lets the number reach 256, whose three digits make
sprintf() write the terminating NUL past the end of the buffer.

Size the buffer like the UUID it is copied into, and use snprintf().

Add a test with 256 partitions, which catches the overflow on sandbox
with CONFIG_ASAN.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v1)

 disk/part_dos.c |  6 ++++--
 test/dm/part.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index bc40d9d2829..3029ee0c31a 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -325,9 +325,11 @@ static int part_get_info_extended(struct blk_desc *desc,
 						 "0x%x", pt->sys_ind);
 					info->bootable = get_bootable(pt);
 					if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
-						char str[12];
+						/* part_num may take three digits */
+						char str[UUID_STR_LEN + 1];
 
-						sprintf(str, "%08x-%02x", disksig, part_num);
+						snprintf(str, sizeof(str), "%08x-%02x",
+							 disksig, part_num);
 						disk_partition_set_uuid(info, str);
 					}
 					info->sys_ind = pt->sys_ind;
diff --git a/test/dm/part.c b/test/dm/part.c
index 4938d962144..f8a0fa974c1 100644
--- a/test/dm/part.c
+++ b/test/dm/part.c
@@ -423,3 +423,49 @@ static int dm_test_part_dos_ext_empty(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_part_dos_ext_empty, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
+
+/*
+ * Partition numbers above 255 take three digits in the UUID made up for a
+ * DOS partition, from the disk signature and the partition number
+ */
+static int dm_test_part_dos_uuid(struct unit_test_state *uts)
+{
+	struct disk_partition info;
+	dos_partition_t pt[4];
+	struct blk_desc *desc;
+	int part;
+
+	if (!CONFIG_IS_ENABLED(PARTITION_UUIDS))
+		return -EAGAIN;
+
+	ut_asserteq(2, blk_get_device_by_str("mmc", "2", &desc));
+	ut_asserteq(512, desc->blksz);
+
+	/* an extended partition from sector 2 */
+	memset(pt, '\0', sizeof(pt));
+	dos_set_entry(&pt[0], DOS_PART_TYPE_EXTENDED, 2, 512);
+	ut_assertok(dos_write_table(desc, 0, pt));
+
+	/*
+	 * holding logical partitions 5 to 256, each of one sector after its
+	 * table, with the tables two sectors apart from sector 2 on
+	 */
+	for (part = 5; part <= 256; part++) {
+		memset(pt, '\0', sizeof(pt));
+		dos_set_entry(&pt[0], 0x83, 1, 1);
+		if (part < 256)
+			dos_set_entry(&pt[1], DOS_PART_TYPE_EXTENDED,
+				      (part - 4) * 2, 2);
+		ut_assertok(dos_write_table(desc, 2 + (part - 5) * 2, pt));
+	}
+
+	ut_assertok(part_get_info_by_type(desc, 255, PART_TYPE_DOS, &info));
+	ut_asserteq(2 + 250 * 2 + 1, info.start);
+	ut_asserteq_str("00000000-ff", disk_partition_uuid(&info));
+	ut_assertok(part_get_info_by_type(desc, 256, PART_TYPE_DOS, &info));
+	ut_asserteq(2 + 251 * 2 + 1, info.start);
+	ut_asserteq_str("00000000-100", disk_partition_uuid(&info));
+
+	return 0;
+}
+DM_TEST(dm_test_part_dos_uuid, UTF_SCAN_PDATA | UTF_SCAN_FDT);
