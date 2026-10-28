Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C387606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MHqzf/nL;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xt/l6lK3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AF7980DBC;
	Wed, 28 Oct 2026 05:52:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R-qrxQneriTI; Wed, 28 Oct 2026 05:52:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C0D5080DCD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166723;
	b=l8mBgJYaG/COEV02D+MbRDyc/qDo5QwZIMuvzUIEpqaoEGhjIXlACSx6ia0qYzIOsig5
	 hIGga7ZQ/F8En7xlB9sF8qtI4xG+N83bJ0cRHb3ksn40Q4UH53foz6v3NEjzMhf2jAgZb
	 ur0w76F3lWoiEXdt6gBn09edtmViHmdm4JzA+JjCS94qCfvSOE0xbLo8oci0iC7JWn++1
	 RT5WvXDdZjeYpK2yH/YmHG3H+bDFOOiWERteRTfWYHv6XhUhY2ZWwzBp8xJtqObp5t6/r
	 rh3GCuum7Hg8jG7YU0wQzKsbWiCs//icAYeZa4Qhgg6NtqeQvuHpVxg+dzzm6++yP3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166723;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=obJJ7mAwVaE7N4fjk2sNs/SEvc8DL1EMh/aCRe6lnso=;
	b=kPq/BsgGb9rMGvJES1mSdjgA7SVIbWoqMKDVlcHwITYGJhO9jY+70QTSATkUvdrxdmkG
	 51iZ8IMp2OjCYgzL8vNMWm++137/B/ebw3IKQBf1xrnBFgqfd07YesSEYB9nnQxrfe3Tv
	 gNZwMSCgQ4KlO/O3XHt9XKr8jMiiSXfnXsWGmWiwpdI2zQdDSMwAN6g3xqM4cwgHpAcBN
	 hZm+ge4/nCTfGzks5DtQVyL2bXx/D17DI8GERu5mDEkK3Cm1rls0kAfJFsepuevY7yUVw
	 T+93zFS4xEcypVsz36YPh0xbgiDzSJd+glx60xMt29qe+Zfv3njy7Mmuf4dKCz32Asg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Xt/l6lK3";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166723;
	bh=obJJ7mAwVaE7N4fjk2sNs/SEvc8DL1EMh/aCRe6lnso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MHqzf/nLsaPWAW8oMwc/T9gWOBOSvnIDmrr60IBIEzC6f0ltkDBz9F6nc00HSZAJ8
	 pudcVAXug4m3sQmGny4NQiAgN8qP18Du7YttbrL4kgDqD6IR2J+3qJxx45c7bXwGW8
	 xwPXLc87cMAC9AeTn31E1VrlOE0U60ZUZ9wTQFeyPItvlsyfJntWN74wDGUbMJVauA
	 JntmCcBHX86YicSllyQPE8EdZzJL8S7t0c9IIlQcxKS5cADdGvK9F7PjoSomBDZIzf
	 g/Vxw3ijNkeiyAq5JbPpGQ9SdgylD1v048jiiTgVTNdEL2MqIq/1WHmTyPz5A6Q9o3
	 GJbgO/G0CKkEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0D5080DCD;
	Wed, 28 Oct 2026 05:52:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F650D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:52:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 70EB180DB3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:52:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5-kMy1QvCXht for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:52:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8209680E21
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166721;
 b=NY2LiSbeAY0ERBkSX3W/UZHVLzmOHNTOYxlA+I24ydxK8+IA4KvoQuo8hdt50rraz6ts
 vKtpvWaePjJhGbThw91ckHaWxpnAt/eP9Lryn34TfnPVrIt1zgaLVT8Ty7zylKUXeb1O5
 b1/h7Dly0LLkHLR4mj7mQyE/Rbvd7HNb+NAA6mN5u4T/iCLI+Io8n3Xpd4TB5IYiyxuYq
 qUJK9qm8S9WL/sz7TITAn9td1s0MSVMNPmPDBDaHGTFL7F+THdblJEkRt3BvI8wOhJYKd
 1U3iaDKGsXhrDe+H9MtMUBMXi4V2r+ThIrxnMGRXSoGemfg55Jkgwg/0kF3p/yD74Pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166721;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=obJJ7mAwVaE7N4fjk2sNs/SEvc8DL1EMh/aCRe6lnso=;
 b=l1XvMJTLuVwvdZzB+w+tRp7v1eJVXKKIbQ5LNivMZrEQwRyl7wjkbDtVGIbzMqE1XvzB
 sRkNzde2MChG4P6k8XYnjSx1oRB8ukdbVQUx5VAAXJwz7AHqccaI0z397kptx6cuTJGN4
 9pWFiHNNxAWUweeDXVe0wAXS2xyvi741w3dROHlvAw+GTQodJLFvrxm6nGe8skdoLY29M
 9HVr2JCYjpcQSTTuMSOB+bKmqI8+fkLq8f+CjT4UzopV+mB+YBDIj0PmTdUDL32ewbhVH
 dRzKPX7MtDrZ3UlUlxQwe2zJlupeRQ34teskZp8L0Y5v703edUDlflXXPmhSUOSC8dw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="Xt/l6lK3"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Xt/l6lK3
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8209680E21
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:52:00 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso458377f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166718; x=1793771518;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=obJJ7mAwVaE7N4fjk2sNs/SEvc8DL1EMh/aCRe6lnso=;
 b=Xt/l6lK3vWC3DPxE93Vq22SIJQUAigK1UpaXWgt3mTE9BcmujBNd4Sdvu7MnT3PQov
 KbucbJgBopN7nB48aLV8KY3Z3x8dD1EchEf9mqoJ3qpKKmzTYBQBllqtsJu53KjoQwzm
 JE/RDiuVg9lAOtVo1UJKq1wXK/qrOGcRSOX+9kZIAxDtNzh1Mtvai5TBzZ/50fTMIkoo
 QFMPXzIlYaUf4UuRNJY9ojv6ytYn4yibeCEUaiU/VuPMF1D9qZcFxb+D5M0NiQm1cZ34
 OOhw9GtYw9imOEgEjQd4cBGBYhgIhg2jkGTYOjaD/WYRhpwuH7i9NbaSgYws8S5EIK77
 BLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166718; x=1793771518;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=obJJ7mAwVaE7N4fjk2sNs/SEvc8DL1EMh/aCRe6lnso=;
 b=ZB4AD1MC4nasU83mq0Gg0mJUWSegT091fcVvRcrH7uW8zCrZkxttjkd7+umK1X52tK
 FeWa9kPqzI8eWn7f8tb1q6MX0BC16N4VKSi3bo5yYfaJ5rs06K3EEwpO/A+3+Ser8T9b
 ZyKv5bxkK8d0+4kQ75YIZkXZgQzeD2KFiHXy77mPDomDnyg5GXAD6rPzdf9aKHoQYSe5
 CGFmQcQuWsUtpJ19myG/j68U9nDFFBY5Nxz7xD/Kw6PbtivO/El8dT2D2OvMM88z+hS7
 bbmpmGBOhl8YLg2iB+aQuZ4/XUg68UNX/3nI1uUpbNfLooanyzXN+Brc8/q24kLHv+bd
 rTVg==
X-Gm-Message-State: AFq9FYJtOt04eBRC/43ofxhDMMFGYLd/IfpHbgexXQPMtomfbPNsh3+q
 aYtWPfMUMS4uKdY+wDTsyO1dTGukxVFqKIuB+3JO+4QHb6rQl5+uphAB
X-Gm-Gg: AYBFou0TUEPg7R3YqCgL1xwh8yNQhulNwwEEMV9duzSLXrmKcwx4JOjuz94WrwhGZhL
 +lvLPiVPDArLK5Lbd/szI3P7l0Cy89crM+kiulUWqAAUKpC4Q7XcvDXRhaNjYYfa3DiRy1/VZUM
 sSa6StjVnChDDjxl9uj5WCSRbac+N2F8EbvRwt8euAtJ0moFKV3frSHnLlCwYzmII5AtCUtQdlH
 QqPXWUHfxJw8UdpWbVDWD8sF4V5Rr+yu+9b9NF7zC2jrQ4K713JzMOFtFdeL9xjr87jS8/Ej0f7
 4asy2tZeT0C0rlJ+Y1XPLxwtnPGfxFhZzYjzfyLGhzW24XAvAZbPywZ1+5ltNNQM94OV6GGsTdV
 DDcLM2pl6wmw34joWzqU0iKIo2E4r3OAl/rJm9qca1nvL9w322/ZrAPVMjZwXSkr60+04BZIu6L
 qJmYp1qWdi3HITKd9PD+P1TKQui49kJbaG7St/kMmyxzu0P9gNFyff1h+F/iLR7uRtVrSf4d04z
 8XExsAxPuES/ZHoH/mXI5k+T8KeZSvlAiFy8frMgyq0daxQJRl0JA8qWiftnNQm9aeGdSiHpNjA
 at+lr4b4T4JSFKnY+BY36xNqC67cEYM=
X-Received: by 2002:a05:6000:240f:b0:48e:60bf:4177 with SMTP id
 ffacd0b85a97d-48e60bf43demr331322f8f.9.1793166718190; 
 Tue, 27 Oct 2026 22:51:58 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f25fsm25620305f8f.2.2026.10.27.22.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:51:57 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 10/12] disk: part_dos: Walk the extended partition tables
 in a bounded loop
Date: Wed, 28 Oct 2026 05:51:56 +0000
Message-ID: <a8d9f8b4-c900-4706-8d4a-8c07da7d8cec@gmail.com>
In-Reply-To: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
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
---
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
