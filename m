Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18AE606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0DXB5Ub1;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pk5TYIPs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BFAF81773;
	Sat, 24 Oct 2026 12:17:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D9kk5eRxvSj4; Sat, 24 Oct 2026 12:17:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A291C81763
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792844238;
	b=r0aWkISd1UzoEz2sombwWzhKow8tsmgv0oyZibnaz/4GcXrYBE9pyARLwJUJd53YYSpW
	 MzJExgw4MEMd9zYl4168DWho/+nh8hMhHJ114l+y407bMavg4KuEAagiyAKDMwPu4KtFL
	 3r4H67IoOty4RBEOA55W1OzXvH/ORzReyNqbxlS8QDSgwp1tU1WblUNZ0PHHw1WD8oUIO
	 meyadT0dq2iwT0PdZ2WGUFTEunvUXIhMfsXcK9uoRj9R4HDkJbx03TOzoxssxAH6VWjoT
	 PBbdSaLd5PygufBspc208CV2MMLFYsu1v7bG1onFlkTB8z+Bxj3r+yx8v7fzoDhDd8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792844238;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wLw/m3UnYgl5iYq5RILoDB0ewYp8PI/zd5w49UlIQSg=;
	b=s3ofI/n1YoDyrWDh6CxS4ZyfvZq89Q3nQzwlZNUa4SDNZmFRyJfchnSsA+5Pe1ohrqat
	 eaFnRFt5b3UYohBR9sQEnXp9Oi70V0AGmgwKIY7+sjqHq6bJi974ic1RR06ucKvsqYnlP
	 Sx0Hc+w3WWhOiTGLnugod5WPDfwTRsfd8aYTTf/tBeHY91SahcWIHRNV76Lc7YyP6dili
	 3iQNrhUuU1yr67bJriP4auOWTixORSfmzmfTuRqgIHg48w589HVHqPcKPVakEG8RcsiD7
	 4kpzjxSKCntGyuJNEgtch+8tfClTWUB4ybbhaoSb2GFSRhuIfT53cRRLDY9GhBEeXJg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pk5TYIPs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792844238;
	bh=wLw/m3UnYgl5iYq5RILoDB0ewYp8PI/zd5w49UlIQSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0DXB5Ub14tLGfoXGkOEPCyDvm11opbj1zBkNOCqouqer2QAY5Zh2i2q55IUnFK1Hm
	 zDu2zpVj6Cm+lBufwkhvOOWrYwp5GPldctSzLx5Fgf4qm9mtEFRKPrmY0WzbjqIUiB
	 SC375lj7MwOj7Xnnsv65FDfiZul5h/EztV1JlqRjGffInoVv98v1fWhVB6VYwzDpmz
	 nMeraUyAHRY+SggwpOP3CRrg1bBBBBmqMydgDDvLYeBaQUl8lMyAMJir2eB3wDO8I7
	 4WXmkkKbCrl2rp/4FsEvaS29/8rQyNCc0bScON3SUZqApYVd1zyW7AZTDhesXr6MsU
	 6F3lq6SDmLzLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A291C81763;
	Sat, 24 Oct 2026 12:17:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 83CA2380
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 75F2F81763
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gaj6S7yp4tGY for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 12:17:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 53C268175A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792844236;
 b=Dk11sneWV73VvQFuaWtnvZoZJ/7qLXcZ9ACFjEdo/KZJf+vi2r/nY2NvVIGwUUL7ZmNf
 ni2gl9yxGURhooPrrjczt4617CKSWhQwn3Yhny5l/VNd+V7AFQAYqS10PyMiWRjSJNnKM
 6NoLaQy0ZjBoXN6IUBJGqmw6pCvexEuFZQJawvcy/tV4E1djRZqJiZDjEe4u49+3/6/Nr
 T7yEUkZlcH2uGFSqcvChu0da1flZDkuLHbclATt4ADfNuO5AiwU8J3EM3LJlVJdQiEDe1
 XI5eydvUyPG7pyyZRsKBt9WVAwVlubciolEkegaYVPfX/U0G06W3ns9wdjHmaNHBZ7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792844236;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=wLw/m3UnYgl5iYq5RILoDB0ewYp8PI/zd5w49UlIQSg=;
 b=NTAyY/A/v1WpsXVA/S2ZTaKf4+2ru6aXu21OxfX5zadLkJdIIi57rAr4Vo2OeP3SnMj/
 VH76DNM0p6aUlRx8Xi522p9FuRbExGXxiFnpT4K3I+sk8hbdr3yby5KYidYJ8SrY17T1x
 QKFNhAqDH1OT8jWEL8ySO9XNMEtWerlonGD86FHWEwT3KndVhH6aBmVNfj9xc0c2bZCLh
 DEcWjQGoNgyGeo6TPPI38wbw1i0eILWYii7wzfZOsBpNtGI+pnSI0oe0+1I4cEKYgKJTu
 1J6wOOgRVa2ERy4b3zmcojM0VBsIBSRphln/rfbm9/JpORneJ2DBaiUa+lBQiAW3Txg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pk5TYIPs; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pk5TYIPs
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 53C268175A
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:15 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so17745035e9.3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792844234; x=1793449034;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wLw/m3UnYgl5iYq5RILoDB0ewYp8PI/zd5w49UlIQSg=;
 b=pk5TYIPs9K9dMDX+SQj6TQeqcL48N+LfnrrfCkhWSqf4lCcCApN07IriscBg8pxW53
 VR1yeyHxPaihHnNHgrwRvSJpDJDYLEglez156V0lLg5nVwgDYI5FpMNUaIuAzWqvrA/Z
 p5iEOzL+N+pA8w3FvY84hmLKR7VeWH1nqsWWZCA+dX1rxGnW2HlwLfzOIP4LzYywWD4e
 9+Y6ChRTlFG6QDcYT214g16rJZ4KRoVKUiaR3g4rCX4cN3Gkju5/U1sVHfvnaKj8Dc0A
 Y4Cg4XYBO9/cUu4fjr4VrOfkMvJLUjTz0ABFUvCwQVqL7/X1Wn6KgByknqKYY9cp5L4a
 /mSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792844234; x=1793449034;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wLw/m3UnYgl5iYq5RILoDB0ewYp8PI/zd5w49UlIQSg=;
 b=HYSgnjwFDGT82uDKjrT4sTgwEIqdPDRkug+JTLZXQ67h8kZazrbnXh1vskWYjYDdoB
 s8x3RvSJ/ZiQy+C9kSFQBCa2fcucCQLykcRi1YvbgfhLAUAwTef3vhtvd2QmHfO2CV1E
 JU5uRCgpQYg5p49e1f5c+KMfzOqZ2RYn5DDNP7l6FJLJGbzofdndNSbfoJFvwGXBwZuL
 X1jI4kB+OceDeSl0KukiNhf3w4S2aBQzApujHiFD0wd4Y/I1iS1fyzSUNcv3FYqQ0vqv
 jqugSD3YZRJUCvvO6wQi+bb8oLD6DZebet+BWTE9mgoe/ZoWE1Vdyln0HQ0R9+6DqhEz
 fLGg==
X-Gm-Message-State: AFq9FYIthl5VPW+05nwm2v8ZeoX32mdpAi9J7lDSaDE+AtVyYakqGwEm
 ozoYPaWEkG1BecSfgZq+MEs/08L23OaLijN2qdMmp5+VQJMwsTbW/e9znXIyhajw
X-Gm-Gg: AYBFou0EFEGr0IlkEzj0rFVf7LBDVjhWBJcp5AI2hQ9Pp3rhKZ+0zKyy7X8TnpBfk2G
 MIdx9p22F4mFbi275UY1PaNH/bGEaO2NJ+MVai1V/Ncb//L5I2yQWIuoozRfoYco6tyYIeYA5Tz
 15BD1I+vtfFiMNW6hpvLE1GbyaizKpbekEoOg7xfDdy15g0a1H57FPUpu4y1LktTvlA7u/KW2fl
 nG5YDOQg2tFTUpx06+Hlc4thjTW/r4+QLv5eREph+wITEvJHT1kQQHIB9ZPrtsgD006ZOXSYsSN
 RhncVnPQFsP/njLrppFqeRyWYp2qxmPwWtSB4WF8Za/IUzRb4F9pr/MIvaRw1m6b7TklAeHftgj
 1JeCLTwguldrL0TzJY2S1uVvmWrek/0S8g5/0F70S2EcNXio7vU9iyz7BmzvjX62PUbSZFt5rjq
 fVeAEkYdGR8BLQYOyvLapDwvItLytGn1HtaZQKvSbQ/LoXSpkSe2PS4zGHHZH9AT6T/Id2/MHmD
 sv71Fc9WC/m5I+8Nzi6RH4HSbc5Ja7ehObejIy9KNmNNWKou9Ma2YLcSg==
X-Received: by 2002:a05:600c:19d4:b0:4a2:c2b:a91b with SMTP id
 5b1f17b1804b1-4a35ac9114dmr25147495e9.10.1792844233537; 
 Sat, 24 Oct 2026 05:17:13 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a574088sm45148335e9.9.2026.10.24.05.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 05:17:13 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH RESEND 7/9] disk: part_dos: Walk the extended partition tables
 in a bounded loop
Date: Sat, 24 Oct 2026 12:17:12 +0000
Message-ID: <720167ce-9e06-4425-b745-a1fde9954860@gmail.com>
In-Reply-To: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
References: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
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

part_get_info_extended() and print_partition_extended() follow the
links from one extended partition table to the next by recursing, and
stop at MAX_EXT_PARTS partitions, the limit added for CVE-2019-13103.
But a link adds no partition: an extended partition table holding only
a link back to itself does not advance part_num, so the recursion goes
on until the stack runs out, whenever a logical partition of the device
is looked up. Even within the limit, every level keeps a buffer of one
block on the stack, so a long chain of tables on a device with large
blocks needs megabytes of stack.

Follow the links in a loop instead, reusing the one buffer, and stop
after MAX_EXT_TABLES tables, as many as MAX_EXT_PARTS partitions need,
so that a disk with as many partitions as before still reads. Linux
bounds the same walk in parse_extended(), by the number of links
followed without finding a partition.

print_partition_extended() followed every link of a table, where
part_get_info_extended() follows only the first, so it could list
partitions that cannot be looked up, under numbers that clash, and its
walk was not a chain but a tree. Follow only the first link there too.

Add a test with a table that links only to itself, after two logical
partitions.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 disk/part_dos.c |  41 ++++++++++++++------
 test/dm/part.c  | 100 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 11 deletions(-)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index 4b560fde1fb..f451aef76a8 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -28,6 +28,13 @@
  * to use large numbers of partitions */
 #define MAX_EXT_PARTS 256
 
+/*
+ * A link to the next extended partition table adds no partition, so tables
+ * linking back to each other do not advance part_num. Bound the number of
+ * tables read along a chain as well, allowing as many as MAX_EXT_PARTS needs.
+ */
+#define MAX_EXT_TABLES MAX_EXT_PARTS
+
 static inline int is_extended(int part_type)
 {
     return (part_type == DOS_PART_TYPE_EXTENDED ||
@@ -135,10 +142,13 @@ static void print_partition_extended(struct blk_desc *desc,
 {
 	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, desc->blksz);
 	dos_partition_t *pt;
+	int tables = 0;
 	int i;
 
-	/* set a maximum recursion level */
-	if (part_num > MAX_EXT_PARTS)
+next_table:
+	/* bound the walk */
+	tables++;
+	if (part_num > MAX_EXT_PARTS || tables > MAX_EXT_TABLES)
 	{
 		printf("** Nested DOS partitions detected, stopping **\n");
 		return;
@@ -187,9 +197,14 @@ static void print_partition_extended(struct blk_desc *desc,
 			lbaint_t lba_start
 				= get_unaligned_le32 (&pt->start_sect) + relative;
 
-			print_partition_extended(desc, lba_start,
-						 !ext_part_sector ? lba_start :
-						 relative, part_num, disksig);
+			/*
+			 * Follow only the first link, as
+			 * part_get_info_extended() does, reusing the buffer
+			 */
+			if (ext_part_sector == 0)
+				relative = lba_start;
+			ext_part_sector = lba_start;
+			goto next_table;
 		}
 	}
 
@@ -220,11 +235,14 @@ static int part_get_info_extended(struct blk_desc *desc,
 	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, desc->blksz);
 	struct disk_partition wdinfo = { 0 };
 	dos_partition_t *pt;
+	int tables = 0;
 	int i, ret;
 	int dos_type;
 
-	/* set a maximum recursion level */
-	if (part_num > MAX_EXT_PARTS)
+next_table:
+	/* bound the walk */
+	tables++;
+	if (part_num > MAX_EXT_PARTS || tables > MAX_EXT_TABLES)
 	{
 		printf("** Nested DOS partitions detected, stopping **\n");
 		return -1;
@@ -302,10 +320,11 @@ static int part_get_info_extended(struct blk_desc *desc,
 			lbaint_t lba_start
 				= get_unaligned_le32 (&pt->start_sect) + relative;
 
-			return part_get_info_extended(desc, lba_start,
-				 ext_part_sector == 0 ? lba_start : relative,
-						      part_num, which_part, info,
-						      mbr, disksig);
+			/* follow the link, reusing the buffer */
+			if (ext_part_sector == 0)
+				relative = lba_start;
+			ext_part_sector = lba_start;
+			goto next_table;
 		}
 	}
 
diff --git a/test/dm/part.c b/test/dm/part.c
index ad37d7f406f..4e313e50752 100644
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
@@ -248,3 +251,100 @@ static int dm_test_part_get_info_by_uuid(struct unit_test_state *uts)
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
+ * partition and when listing them.
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
+	 * logical partitions 5 and 6, each in a table of its own; a link is
+	 * relative to the extended partition, a partition to its own table
+	 */
+	dos_set_entry(&pt[0], 0x83, 1, 4);
+	dos_set_entry(&pt[1], DOS_PART_TYPE_EXTENDED, 10, 10);
+	ut_assertok(dos_write_table(desc, 2, pt));
+	dos_set_entry(&pt[1], DOS_PART_TYPE_EXTENDED, 20, 10);
+	ut_assertok(dos_write_table(desc, 12, pt));
+
+	/* then a table with no partition, only links back to itself */
+	dos_set_entry(&pt[0], DOS_PART_TYPE_EXTENDED, 20, 10);
+	ut_assertok(dos_write_table(desc, 22, pt));
+
+	ut_assertok(part_get_info_by_type(desc, 5, PART_TYPE_DOS, &info));
+	ut_asserteq(3, info.start);
+	ut_asserteq(4, info.size);
+	ut_assertok(part_get_info_by_type(desc, 6, PART_TYPE_DOS, &info));
+	ut_asserteq(13, info.start);
+	ut_asserteq(4, info.size);
+
+	/* there is no partition 7, and looking for it has to end */
+	ut_asserteq(-ENOENT,
+		    part_get_info_by_type(desc, 7, PART_TYPE_DOS, &info));
+	ut_assert_nextline("** Nested DOS partitions detected, stopping **");
+	ut_assert_console_end();
+
+	/* and so does listing them */
+	desc->part_type = PART_TYPE_DOS;
+	part_print(desc);
+	ut_assert_skip_to_line("%3d\t%-10d\t%-10d\t%08x-%02x\t%02x", 6, 13, 4,
+			       0, 6, 0x83);
+	ut_assert_nextline("** Nested DOS partitions detected, stopping **");
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_part_dos_ext_loop, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
