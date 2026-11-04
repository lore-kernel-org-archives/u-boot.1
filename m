Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02C4606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=esQ3goCJ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQyQWYvS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CF87405AD;
	Wed,  4 Nov 2026 12:51:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SnWNzGoW54mT; Wed,  4 Nov 2026 12:51:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EFF8A405C9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793796694;
	b=hpOjwFfx4Ba/dklOEEDHZnC17Km8el0qMDDVAYZdL519SgVw3fKoQqcxKIMYsfBpNYm7
	 096PMnzt4GOo0KhLeZmE+pg1jSo+YYh7OSSGNre6X0cZO1W70/apAyQ2bFpdRWHEqrgYT
	 1bHM0mQQbYsJ8rimgSPKG0YolPKkII3FdZ/kThCoPppbLTLIE3Kdm6b+/hOSNfp5wfBOR
	 acA3dxu7kdAbJBPEOvVFBfxJXaXrUEE3wN9uxW1Yw+oLkmJkhw6WrhF7XDxwRWFWpI0xl
	 TYOAXN9OsuuxHaphsI1xN38fagMRIvUKsLOyInk2Zj0w6xxFwTphGf9ZymKXnOZpc7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796694;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7muImtPvkO5ilZWas0f0BFOCi7EeHlza0F29NoumSms=;
	b=dZLYhW6yeJvNZoKbRrfR2Jov7vJZkey0+auuDGWNTvYRa0t+8tp1YlqICEvWGvypnhOP
	 l8ro+eIVzNMmjJhqMAnTw69S0TiCOXidXMaJTKV+4FJX58YiJKLj/gwvwlHTy80rgM1SY
	 8Ze5VoR/6LE/mpJ/vX6nyPMkhzVVqToYbt1wdwasy8kWJgOsnPoLHbAq60qdO+QP6ltBc
	 3H1jK0I3k1MoKwvlvbk4ktNoYJSQJP1AopEg6R4pxaBn7iNgfRD5xzR7YTtkcrXAhO8xH
	 qQbq2Dt0/GX24uqF+AENYEKFfVP61Zw3GJJulBASRuWjdzFGoi5gPD/wlic3wFzYB1g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793796694;
	bh=7muImtPvkO5ilZWas0f0BFOCi7EeHlza0F29NoumSms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=esQ3goCJRDPgnsevoLFn/eqwkzm14bcW56oii+YI2smEx8YQqBnnup7qBygbHTWkL
	 wJ9ShQNC2xVz6vEkTqawYpSpJ9+FjOGx+Pb3zMVOF6fUdyK/QfF2nIM0qs7KpjIafv
	 E9hSuNlhdJyqQlV7HzRzE7+iWhL1oJ5QQve1B4yoNP+xqMot1F32QwtD9dFSj8jbw1
	 RBLiVzJMuBrmskdPbE/ohcfB87D4yQFti221eWVy9x5gVGHP4thFychggR8dQw5mmx
	 CncGkK1J+2qxIFXJz8AdJDDj7402O5paAe4OZz/pNqE4Nnmw+qVUoDFmeta3lYaoRG
	 xlQrlfkZpRE8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFF8A405C9;
	Wed,  4 Nov 2026 12:51:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CEDF435
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E2E48101F
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5IcXGOUPhqFM for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:51:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 715A180FA9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793796692;
 b=Io26uptIzirnHXRFjO9W1LHjcAsmX8BgDyCLMtooCIdq9+wx4udXYPaSjDH8RI9rcfJa
 2t4bWSVqso4pFDBp9h4ctdUmkyF24jxMRDGlqm10aqdzD3ceCFGkW2VkNqqpY8mn3MvbJ
 BjxarvvVoOqRfsEMMNorlS0QG027/ZDGwjLid/d1YjK6nW7wZZqIEwsyEpY7uKWa+emyK
 ieV7tvjSuMoBUKV6WW4qVcF5iOQLKlazO6sCVxrEzqk7ZaNUqtQGNKeltUlSjNOnMmiar
 hH72SDnUln9XxS6LRtntmLN2x4d5UZNaJ7Za3Ry3bfkpSEqcaHqo1vbUFY/bnR6KYIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793796692;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=7muImtPvkO5ilZWas0f0BFOCi7EeHlza0F29NoumSms=;
 b=Xh10wCZ6G7BAlwsnxBRbrP3sjPpkGqpI3tQ/rfGOb+zQ+J5inKgbRy2n+gPt7QBUAJVD
 LaKNiZFHWo3V5BZaYq6gg+ZJ1W/4g7ntzgIZO1csB6lmRGACdUuoTBdJPPeHj5yKKZ1A6
 pe5r7kL4CgafDJhzp+9qaq2KapQDRK/eJk2OuypYfDy9SeMgdQYG4Lmks28lgRzdNwwID
 iib15kAwu8h12+IXrWq72Ffi/J+/0TfIpPvNEfz/OW24PmUMsPrR88KQXn5IBVjIG2km+
 XPXylGhW7Z3Yj9Fc8hqC/vC25xFAAkHYNjsr8upJyKPgTSkvjH5SfBUZErgQ4OPdb6w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=EQyQWYvS; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=EQyQWYvS
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 715A180FA9
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:30 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso26488f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 04:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793796688; x=1794401488;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7muImtPvkO5ilZWas0f0BFOCi7EeHlza0F29NoumSms=;
 b=EQyQWYvSJ2myxXQV2dwI5QQtH8b3ReBbysGLGO/Xmi1a3HdNm9sb9BTRrOOnNliCEN
 ++GyzX7tr1ig/OmB1aSDCogV4mnSDMwVZNlhUEg/lDKILgQ7PUk8kHlQSDHMXWpt00xM
 Nse7LW/9F7zp6MfJOBF0v9M18qvKJ94oU6NBNq/bpJnXNxTQta3YX5EkJfkph1v/LM/b
 M+qHA+8AdLJSGTpH94k4wZL6U46ilSsrwinDGAdwv367wx9Hqnm73+Xm6rysD3EraqAk
 6kL/4rPyJdaD298ecVSymIfDIj3pLdJSOie6g1v+M6PkXpDbRw9RnRlbZvP5fmR2HIKV
 fjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796688; x=1794401488;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7muImtPvkO5ilZWas0f0BFOCi7EeHlza0F29NoumSms=;
 b=IVhrLQqo94wISZ7gsuaOSbulr6Nl9t2Flo6CsAKhbdhzjFl/xg1lhY+m9+lTZrRnKx
 LNKwAy0DWKQH346gnjxPqo9a7Ld7rihqhvlBX22m8pWgkLj9lqsVu1Ts3eOVQ6xNvlbS
 crTwYB2MKPf/02fM45d2Xc/JyZHtKqVfbaCFrj4UwEPiH0YuI0Xe6zLXZWXHFQWX7iof
 IB8WxPRibRPl0/uaTU5lusl5Qs35ob3/KXYlF5M0J72g+k+ztTs45VgqXYbndRmQMcu5
 c39UcBUtjuSS7gPkUOsE3CiKosq2+mlkg8OYR+Ub9tTeQ81AjU4OcOjkrjQhYUE/xH3/
 5MUQ==
X-Gm-Message-State: APuU4Z8RtarYmdo1E6hwMJ4hPyEhr7Z1gi0ZKLvOdjzaGtYaLGaE9Zc1
 nuGm+iCBNZqyBjCnLGq1cmhs2n7d+kdUWJ9eKDnG5kN9b4Jkk5aktYCr
X-Gm-Gg: AYBFou2WTmy+z4U6WTVYy6S0JFankpZ6mHOS3Cw6akqsaszqzGwziG/RPlMA03s+586
 vp+h1l0E1FOdSjkGKQTgkAwUrcWqXYIUoeGPym5hIZZYWfwars1ikpwT1VRRTIYIlLpyG/hxGgZ
 xr5V0NfV5B2Z1ZWc3dGHmJs0Pe7KDk9n10HYdjHAHEZqR8PQutj3QTcDyOA5Qs/WesUBho47Djm
 KmqH6E7VGH3n6IIWS+V9EOHUytaQNCd32Wt/G9m59z/cAgiCiHtN9k234/rPILWD7ZSjBw6bRCu
 PIs6GJRitt073QOBJ8ixBQEjW9tYjkKXLIT6c73tM24trul2llXoNcl2hVFtlT0Ahc1YHLy2cgk
 +UaB626PRemxwkM5ig/CjwMTN8xz2s5DieIqNRPWzzJcw9rZpthxMlJjSVn8SFVwBSJdma9arkY
 HE7+SelLj4ZlPeLigQn8/cYHZF0/4yt1EFdib/4pUVR1W1DxtVs4QztajZOOsRPQcMrs3QKFcce
 B4C9x0FMPyDkSbWF5ckwHF6WUVPLHxbF627qTGr1bTEDB5UbglSVxDHpgRvn6AbKTV5xBWet5aN
 AAjyo+w57lfw7kJLMuNitHMWBRem3HY=
X-Received: by 2002:a05:6000:4010:b0:48e:55bd:9cdf with SMTP id
 ffacd0b85a97d-48e6e2dd3a4mr39430621f8f.21.1793796687723; 
 Wed, 04 Nov 2026 04:51:27 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed551dc5sm3840224f8f.34.2026.11.04.04.51.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 04:51:27 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 10/14] disk: part_dos: Walk the extended partition tables
 in a bounded loop
Date: Wed, 04 Nov 2026 12:51:26 +0000
Message-ID: <196d159e-9bf1-491f-9668-ae3f38f6b446@gmail.com>
In-Reply-To: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
References: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

part_get_info_extended() and print_partition_extended() follow the
links from one extended partition table to the next by recursing, and
stop at MAX_EXT_PARTS partitions, the limit added for CVE-2019-13103.
But a link adds no partition: an extended partition table holding only
a link back to itself does not advance part_num, so the recursion goes
on until the stack runs out, whenever a logical partition of the device
is looked up. Even within the limit, every level keeps a buffer of one
block on the stack, so a long chain of tables on a device with large
blocks needs megabytes of stack.

Follow the links in a loop instead, reusing the one buffer, with the
code that finds the next link in a helper, dos_next_table(), which both
functions use. As Linux does in parse_extended(), stop after
MAX_EXT_EMPTY (16) tables in a row that hold no partition: tables
linking back to each other are then given up after a few reads. Also
stop after MAX_EXT_TABLES tables in all, as many as MAX_EXT_PARTS
partitions need when each table holds one, so that no walk reads more
than that. A chain that also holds tables without a partition then
reads fewer than MAX_EXT_PARTS partitions; partitioning tools write one
logical partition per table.

print_partition_extended() follows every link of a table, where
part_get_info_extended() follows only the first, so it can list
partitions that cannot be looked up, under numbers that clash, and its
walk is not a chain but a tree. Follow only the first link there too.

Add tests with a table holding only a link between two logical
partitions and then a table that links only to itself, and with 15 and
16 such tables in a row before a logical partition.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v2)

Changes in v2:
- Use a for loop rather than a backward goto, and move the code that
  follows a link into a helper used by both functions (Simon)
- Also stop after 16 tables in a row without a partition, as Linux does,
  so that the table in the test costs about 20 reads per lookup at probe
  rather than 256 (Simon)
- Tidy the style of the lines the loop re-indents
- Use the present tense in the commit message (Simon)
- Call part_init() in the test rather than setting part_type (Simon)
- Add a table holding only a link to the test, and a test of the limit
  of 16 tables in a row without a partition

 disk/part_dos.c | 289 +++++++++++++++++++++++++++---------------------
 test/dm/part.c  | 175 +++++++++++++++++++++++++++++
 2 files changed, 340 insertions(+), 124 deletions(-)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index 4b560fde1fb..bc40d9d2829 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -28,6 +28,18 @@
  * to use large numbers of partitions */
 #define MAX_EXT_PARTS 256
 
+/*
+ * A link to the next extended partition table adds no partition, so tables
+ * linking back to each other do not advance part_num. As Linux does in
+ * parse_extended(), stop after MAX_EXT_EMPTY tables in a row that hold no
+ * partition, so that such a loop ends after a few reads. Also stop after
+ * MAX_EXT_TABLES tables in all, as many as MAX_EXT_PARTS partitions need,
+ * so that tables with and without partitions in turn cannot make a walk
+ * read more.
+ */
+#define MAX_EXT_EMPTY	16
+#define MAX_EXT_TABLES	MAX_EXT_PARTS
+
 static inline int is_extended(int part_type)
 {
     return (part_type == DOS_PART_TYPE_EXTENDED ||
@@ -126,6 +138,42 @@ static int part_test_dos(struct blk_desc *desc)
 	return 0;
 }
 
+/**
+ * dos_next_table() - Follow the link from a partition table to the next one
+ *
+ * Only the first link of a table is followed: fdisk numbers the logical
+ * partitions along that chain.
+ *
+ * @buffer:		Partition table just read
+ * @ext_part_sector:	Sector of that table (0 for the MBR), updated to the
+ *			sector of the next table
+ * @relative:		Start of the extended partition, which the links of
+ *			its tables are relative to, set from the link in the
+ *			MBR
+ * Return:		true if the table links to a next one, false if not
+ */
+static bool dos_next_table(unsigned char *buffer, lbaint_t *ext_part_sector,
+			   lbaint_t *relative)
+{
+	dos_partition_t *pt;
+	int i;
+
+	pt = (dos_partition_t *)(buffer + DOS_PART_TBL_OFFSET);
+	for (i = 0; i < 4; i++, pt++) {
+		if (is_extended(pt->sys_ind)) {
+			lbaint_t lba_start = get_unaligned_le32(&pt->start_sect) +
+					     *relative;
+
+			if (!*ext_part_sector)
+				*relative = lba_start;
+			*ext_part_sector = lba_start;
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /*  Print a partition that is relative to its Extended partition table
  */
 static void print_partition_extended(struct blk_desc *desc,
@@ -135,65 +183,61 @@ static void print_partition_extended(struct blk_desc *desc,
 {
 	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, desc->blksz);
 	dos_partition_t *pt;
+	int tables, empty = 0;
 	int i;
 
-	/* set a maximum recursion level */
-	if (part_num > MAX_EXT_PARTS)
-	{
-		printf("** Nested DOS partitions detected, stopping **\n");
-		return;
-    }
-
-	if (blk_dread(desc, ext_part_sector, 1, (ulong *)buffer) != 1) {
-		printf ("** Can't read partition table on %d:" LBAFU " **\n",
-			desc->devnum, ext_part_sector);
-		return;
-	}
-	i=test_block_type(buffer);
-	if (i != DOS_MBR) {
-		printf ("bad MBR sector signature 0x%02x%02x\n",
-			buffer[DOS_PART_MAGIC_OFFSET],
-			buffer[DOS_PART_MAGIC_OFFSET + 1]);
-		return;
-	}
-
-	if (!ext_part_sector)
-		disksig = get_unaligned_le32(&buffer[DOS_PART_DISKSIG_OFFSET]);
+	for (tables = 0; ; tables++) {
+		int prev_num = part_num;
 
-	/* Print all primary/logical partitions */
-	pt = (dos_partition_t *) (buffer + DOS_PART_TBL_OFFSET);
-	for (i = 0; i < 4; i++, pt++) {
-		/*
-		 * fdisk does not show the extended partitions that
-		 * are not in the MBR
-		 */
-
-		if ((pt->sys_ind != 0) &&
-		    (ext_part_sector == 0 || !is_extended (pt->sys_ind)) ) {
-			print_one_part(pt, ext_part_sector, part_num, disksig);
+		/* bound the walk */
+		if (part_num > MAX_EXT_PARTS || tables >= MAX_EXT_TABLES ||
+		    empty >= MAX_EXT_EMPTY) {
+			printf("** Nested DOS partitions detected, stopping **\n");
+			return;
 		}
 
-		/* Reverse engr the fdisk part# assignment rule! */
-		if ((ext_part_sector == 0) ||
-		    (pt->sys_ind != 0 && !is_extended (pt->sys_ind)) ) {
-			part_num++;
+		if (blk_dread(desc, ext_part_sector, 1, (ulong *)buffer) != 1) {
+			printf("** Can't read partition table on %d:" LBAFU " **\n",
+			       desc->devnum, ext_part_sector);
+			return;
+		}
+		i = test_block_type(buffer);
+		if (i != DOS_MBR) {
+			printf("bad MBR sector signature 0x%02x%02x\n",
+			       buffer[DOS_PART_MAGIC_OFFSET],
+			       buffer[DOS_PART_MAGIC_OFFSET + 1]);
+			return;
 		}
-	}
 
-	/* Follows the extended partitions */
-	pt = (dos_partition_t *) (buffer + DOS_PART_TBL_OFFSET);
-	for (i = 0; i < 4; i++, pt++) {
-		if (is_extended (pt->sys_ind)) {
-			lbaint_t lba_start
-				= get_unaligned_le32 (&pt->start_sect) + relative;
+		if (!ext_part_sector)
+			disksig = get_unaligned_le32(&buffer[DOS_PART_DISKSIG_OFFSET]);
+
+		/* Print all primary/logical partitions */
+		pt = (dos_partition_t *)(buffer + DOS_PART_TBL_OFFSET);
+		for (i = 0; i < 4; i++, pt++) {
+			/*
+			 * fdisk does not show the extended partitions that
+			 * are not in the MBR
+			 */
+
+			if ((pt->sys_ind != 0) &&
+			    (ext_part_sector == 0 || !is_extended(pt->sys_ind))) {
+				print_one_part(pt, ext_part_sector, part_num,
+					       disksig);
+			}
 
-			print_partition_extended(desc, lba_start,
-						 !ext_part_sector ? lba_start :
-						 relative, part_num, disksig);
+			/* Reverse engr the fdisk part# assignment rule! */
+			if ((ext_part_sector == 0) ||
+			    (pt->sys_ind != 0 && !is_extended(pt->sys_ind))) {
+				part_num++;
+			}
 		}
-	}
+		empty = part_num > prev_num ? 0 : empty + 1;
 
-	return;
+		/* Follows the extended partitions */
+		if (!dos_next_table(buffer, &ext_part_sector, &relative))
+			break;
+	}
 }
 
 /**
@@ -220,93 +264,90 @@ static int part_get_info_extended(struct blk_desc *desc,
 	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, desc->blksz);
 	struct disk_partition wdinfo = { 0 };
 	dos_partition_t *pt;
+	int tables, empty = 0;
 	int i, ret;
 	int dos_type;
 
-	/* set a maximum recursion level */
-	if (part_num > MAX_EXT_PARTS)
-	{
-		printf("** Nested DOS partitions detected, stopping **\n");
-		return -1;
-    }
+	for (tables = 0; ; tables++) {
+		int prev_num = part_num;
 
-	if (blk_dread(desc, ext_part_sector, 1, (ulong *)buffer) != 1) {
-		printf ("** Can't read partition table on %d:" LBAFU " **\n",
-			desc->devnum, ext_part_sector);
-		return -1;
-	}
-	if (buffer[DOS_PART_MAGIC_OFFSET] != 0x55 ||
-		buffer[DOS_PART_MAGIC_OFFSET + 1] != 0xaa) {
-		printf ("bad MBR sector signature 0x%02x%02x\n",
-			buffer[DOS_PART_MAGIC_OFFSET],
-			buffer[DOS_PART_MAGIC_OFFSET + 1]);
-		return -1;
-	}
+		/* bound the walk */
+		if (part_num > MAX_EXT_PARTS || tables >= MAX_EXT_TABLES ||
+		    empty >= MAX_EXT_EMPTY) {
+			printf("** Nested DOS partitions detected, stopping **\n");
+			return -1;
+		}
 
-	if (CONFIG_IS_ENABLED(PARTITION_UUIDS) && !ext_part_sector)
-		disksig = get_unaligned_le32(&buffer[DOS_PART_DISKSIG_OFFSET]);
+		if (blk_dread(desc, ext_part_sector, 1, (ulong *)buffer) != 1) {
+			printf("** Can't read partition table on %d:" LBAFU " **\n",
+			       desc->devnum, ext_part_sector);
+			return -1;
+		}
+		if (buffer[DOS_PART_MAGIC_OFFSET] != 0x55 ||
+		    buffer[DOS_PART_MAGIC_OFFSET + 1] != 0xaa) {
+			printf("bad MBR sector signature 0x%02x%02x\n",
+			       buffer[DOS_PART_MAGIC_OFFSET],
+			       buffer[DOS_PART_MAGIC_OFFSET + 1]);
+			return -1;
+		}
 
-	if (info) {
-		ret = part_get_info_whole_disk(desc, &wdinfo);
-		if (ret)
-			return ret;
-	}
+		if (CONFIG_IS_ENABLED(PARTITION_UUIDS) && !ext_part_sector)
+			disksig = get_unaligned_le32(&buffer[DOS_PART_DISKSIG_OFFSET]);
 
-	/* Print all primary/logical partitions */
-	pt = (dos_partition_t *) (buffer + DOS_PART_TBL_OFFSET);
-	for (i = 0; i < 4; i++, pt++) {
-		/*
-		 * fdisk does not show the extended partitions that
-		 * are not in the MBR
-		 */
-		if (((pt->boot_ind & ~0x80) == 0) &&
-		    (pt->sys_ind != 0) &&
-		    (part_num == which_part) &&
-		    (ext_part_sector == 0 || is_extended(pt->sys_ind) == 0)) {
-			if (info) {
-				if (wdinfo.blksz > DOS_PART_DEFAULT_SECTOR)
-					info->blksz = wdinfo.blksz;
-				else
-					info->blksz = DOS_PART_DEFAULT_SECTOR;
-				info->start = (lbaint_t)(ext_part_sector +
-							 get_unaligned_le32(&pt->start_sect));
-				info->size  = (lbaint_t)get_unaligned_le32(&pt->nr_sects);
-				part_set_generic_name(desc, part_num,
-						      (char *)info->name);
-				snprintf(info->type, sizeof(info->type), "0x%x", pt->sys_ind);
-				info->bootable = get_bootable(pt);
-				if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
-					char str[12];
-
-					sprintf(str, "%08x-%02x", disksig, part_num);
-					disk_partition_set_uuid(info, str);
+		if (info) {
+			ret = part_get_info_whole_disk(desc, &wdinfo);
+			if (ret)
+				return ret;
+		}
+
+		/* Print all primary/logical partitions */
+		pt = (dos_partition_t *)(buffer + DOS_PART_TBL_OFFSET);
+		for (i = 0; i < 4; i++, pt++) {
+			/*
+			 * fdisk does not show the extended partitions that
+			 * are not in the MBR
+			 */
+			if (((pt->boot_ind & ~0x80) == 0) &&
+			    (pt->sys_ind != 0) &&
+			    (part_num == which_part) &&
+			    (ext_part_sector == 0 || is_extended(pt->sys_ind) == 0)) {
+				if (info) {
+					if (wdinfo.blksz > DOS_PART_DEFAULT_SECTOR)
+						info->blksz = wdinfo.blksz;
+					else
+						info->blksz = DOS_PART_DEFAULT_SECTOR;
+					info->start = ext_part_sector +
+						get_unaligned_le32(&pt->start_sect);
+					info->size = get_unaligned_le32(&pt->nr_sects);
+					part_set_generic_name(desc, part_num,
+							      (char *)info->name);
+					snprintf(info->type, sizeof(info->type),
+						 "0x%x", pt->sys_ind);
+					info->bootable = get_bootable(pt);
+					if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
+						char str[12];
+
+						sprintf(str, "%08x-%02x", disksig, part_num);
+						disk_partition_set_uuid(info, str);
+					}
+					info->sys_ind = pt->sys_ind;
 				}
-				info->sys_ind = pt->sys_ind;
+				if (mbr)
+					memcpy(mbr, pt, sizeof(*mbr));
+				return 0;
 			}
-			if (mbr)
-				memcpy(mbr, pt, sizeof(*mbr));
-			return 0;
-		}
 
-		/* Reverse engr the fdisk part# assignment rule! */
-		if ((ext_part_sector == 0) ||
-		    (pt->sys_ind != 0 && !is_extended (pt->sys_ind)) ) {
-			part_num++;
+			/* Reverse engr the fdisk part# assignment rule! */
+			if ((ext_part_sector == 0) ||
+			    (pt->sys_ind != 0 && !is_extended(pt->sys_ind))) {
+				part_num++;
+			}
 		}
-	}
+		empty = part_num > prev_num ? 0 : empty + 1;
 
-	/* Follows the extended partitions */
-	pt = (dos_partition_t *) (buffer + DOS_PART_TBL_OFFSET);
-	for (i = 0; i < 4; i++, pt++) {
-		if (is_extended (pt->sys_ind)) {
-			lbaint_t lba_start
-				= get_unaligned_le32 (&pt->start_sect) + relative;
-
-			return part_get_info_extended(desc, lba_start,
-				 ext_part_sector == 0 ? lba_start : relative,
-						      part_num, which_part, info,
-						      mbr, disksig);
-		}
+		/* Follows the extended partitions */
+		if (!dos_next_table(buffer, &ext_part_sector, &relative))
+			break;
 	}
 
 	/* Check for DOS PBR if no partition is found */
diff --git a/test/dm/part.c b/test/dm/part.c
index ad37d7f406f..4938d962144 100644
--- a/test/dm/part.c
+++ b/test/dm/part.c
@@ -3,10 +3,13 @@
  * Copyright (C) 2020 Sean Anderson <sean.anderson@seco.com>
  */
 
+#include <blk.h>
 #include <dm.h>
 #include <env.h>
+#include <memalign.h>
 #include <mmc.h>
 #include <part.h>
+#include <part_dos.h>
 #include <part_efi.h>
 #include <dm/test.h>
 #include <test/ut.h>
@@ -248,3 +251,175 @@ static int dm_test_part_get_info_by_uuid(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_part_get_info_by_uuid, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/**
+ * dos_set_entry() - fill in one entry of a DOS partition table
+ *
+ * @pt:		entry to fill in
+ * @sys_ind:	partition type
+ * @start:	first sector, relative to what the table type says
+ * @size:	number of sectors
+ */
+static void dos_set_entry(dos_partition_t *pt, u8 sys_ind, u32 start,
+			  u32 size)
+{
+	memset(pt, '\0', sizeof(*pt));
+	pt->sys_ind = sys_ind;
+	pt->start_sect = cpu_to_le32(start);
+	pt->nr_sects = cpu_to_le32(size);
+}
+
+/**
+ * dos_write_table() - write a DOS partition table to a sector
+ *
+ * @desc:	block device to write to, with 512-byte blocks
+ * @lba:	sector to write the table to
+ * @pt:		the four entries of the table
+ * Return: 0 if OK, -EIO if the sector could not be written
+ */
+static int dos_write_table(struct blk_desc *desc, lbaint_t lba,
+			   const dos_partition_t pt[4])
+{
+	ALLOC_CACHE_ALIGN_BUFFER(u8, buf, 512);
+
+	memset(buf, '\0', 512);
+	memcpy(buf + DOS_PART_TBL_OFFSET, pt, 4 * sizeof(*pt));
+	buf[DOS_PART_MAGIC_OFFSET] = 0x55;
+	buf[DOS_PART_MAGIC_OFFSET + 1] = 0xaa;
+
+	return blk_dwrite(desc, lba, 1, buf) == 1 ? 0 : -EIO;
+}
+
+/*
+ * A link from one extended partition table to the next adds no partition,
+ * so a walk through tables that link to each other in a loop finds no more
+ * partitions as it goes. Check that it ends anyway, both when looking for a
+ * partition and when listing them, and that a table holding only a link is
+ * still followed.
+ */
+static int dm_test_part_dos_ext_loop(struct unit_test_state *uts)
+{
+	struct disk_partition info;
+	dos_partition_t pt[4];
+	struct blk_desc *desc;
+
+	ut_asserteq(2, blk_get_device_by_str("mmc", "2", &desc));
+	ut_asserteq(512, desc->blksz);
+
+	/* an MBR with one extended partition, from sector 2 */
+	memset(pt, '\0', sizeof(pt));
+	dos_set_entry(&pt[0], DOS_PART_TYPE_EXTENDED, 2, 100);
+	ut_assertok(dos_write_table(desc, 0, pt));
+
+	/*
+	 * logical partition 5 in a table of its own, then a table holding only
+	 * a link, then logical partition 6; a link is relative to the extended
+	 * partition, a partition to its own table
+	 */
+	dos_set_entry(&pt[0], 0x83, 1, 4);
+	dos_set_entry(&pt[1], DOS_PART_TYPE_EXTENDED, 10, 10);
+	ut_assertok(dos_write_table(desc, 2, pt));
+	memset(pt, '\0', sizeof(pt));
+	dos_set_entry(&pt[0], DOS_PART_TYPE_EXTENDED, 20, 10);
+	ut_assertok(dos_write_table(desc, 12, pt));
+	dos_set_entry(&pt[0], 0x83, 1, 4);
+	dos_set_entry(&pt[1], DOS_PART_TYPE_EXTENDED, 30, 10);
+	ut_assertok(dos_write_table(desc, 22, pt));
+
+	/* then a table with no partition, only a link back to itself */
+	memset(pt, '\0', sizeof(pt));
+	dos_set_entry(&pt[0], DOS_PART_TYPE_EXTENDED, 30, 10);
+	ut_assertok(dos_write_table(desc, 32, pt));
+
+	ut_assertok(part_get_info_by_type(desc, 5, PART_TYPE_DOS, &info));
+	ut_asserteq(3, info.start);
+	ut_asserteq(4, info.size);
+	ut_assertok(part_get_info_by_type(desc, 6, PART_TYPE_DOS, &info));
+	ut_asserteq(23, info.start);
+	ut_asserteq(4, info.size);
+
+	/* there is no partition 7, and looking for it has to end */
+	ut_asserteq(-ENOENT,
+		    part_get_info_by_type(desc, 7, PART_TYPE_DOS, &info));
+	ut_assert_nextline("** Nested DOS partitions detected, stopping **");
+	ut_assert_console_end();
+
+	/* and so does listing them, once the table is detected as DOS */
+	part_init(desc);
+	ut_asserteq(PART_TYPE_DOS, desc->part_type);
+	part_print(desc);
+	ut_assert_skip_to_line("%3d\t%-10d\t%-10d\t%08x-%02x\t%02x", 6, 23, 4,
+			       0, 6, 0x83);
+	ut_assert_nextline("** Nested DOS partitions detected, stopping **");
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_part_dos_ext_loop, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
+
+/**
+ * dos_write_chain() - write a chain of extended partition tables
+ *
+ * The MBR holds an extended partition from sector 2, whose first table
+ * holds logical partition 5 and a link, then come @empty tables holding only
+ * a link, and then a table holding logical partition 6.
+ *
+ * @desc:	block device to write to, with 512-byte blocks
+ * @empty:	number of tables holding only a link
+ * Return: sector where partition 6 starts, or -EIO on error
+ */
+static int dos_write_chain(struct blk_desc *desc, int empty)
+{
+	dos_partition_t pt[4];
+	int i;
+
+	memset(pt, '\0', sizeof(pt));
+	dos_set_entry(&pt[0], DOS_PART_TYPE_EXTENDED, 2, 1000);
+	if (dos_write_table(desc, 0, pt))
+		return -EIO;
+
+	/* table n is at sector 2 + 10 * n, its link 10 * (n + 1) */
+	for (i = 0; i <= empty + 1; i++) {
+		memset(pt, '\0', sizeof(pt));
+		if (i == 0 || i == empty + 1)
+			dos_set_entry(&pt[0], 0x83, 1, 4);
+		if (i <= empty)
+			dos_set_entry(&pt[1], DOS_PART_TYPE_EXTENDED,
+				      10 * (i + 1), 10);
+		if (dos_write_table(desc, 2 + 10 * i, pt))
+			return -EIO;
+	}
+
+	return 2 + 10 * (empty + 1) + 1;
+}
+
+/*
+ * Check that a walk through the extended partition tables follows up to 15
+ * tables in a row holding no partition, as a damaged but valid chain may
+ * have, but gives up at the 16th
+ */
+static int dm_test_part_dos_ext_empty(struct unit_test_state *uts)
+{
+	struct disk_partition info;
+	struct blk_desc *desc;
+	int start;
+
+	ut_asserteq(2, blk_get_device_by_str("mmc", "2", &desc));
+	ut_asserteq(512, desc->blksz);
+
+	start = dos_write_chain(desc, 15);
+	ut_assert(start > 0);
+	ut_assertok(part_get_info_by_type(desc, 6, PART_TYPE_DOS, &info));
+	ut_asserteq(start, info.start);
+	ut_assert_console_end();
+
+	ut_assert(dos_write_chain(desc, 16) > 0);
+	ut_assertok(part_get_info_by_type(desc, 5, PART_TYPE_DOS, &info));
+	ut_asserteq(-ENOENT,
+		    part_get_info_by_type(desc, 6, PART_TYPE_DOS, &info));
+	ut_assert_nextline("** Nested DOS partitions detected, stopping **");
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_part_dos_ext_empty, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
