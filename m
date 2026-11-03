Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B13606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HwJqB4H/;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0TJd0P0e
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E575180DB0;
	Tue,  3 Nov 2026 07:13:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YONhh6X1lDm9; Tue,  3 Nov 2026 07:13:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 17B6A80DBD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793690004;
	b=AYx/uoRiX02qU9tap/Ut0W+0NHvXU5899jiJ4oYx2sVuQIG2/QYC9Eo4/EKQBivd4bUF
	 rr1Ba6/jBC62KA144uNp0nURSN+dUbrTClr1E5wkpfzaFfhWgymHiG1eTJGury3GOXmVv
	 yW2ECjawCB8TqnqwTOgdsmWWNgFOvbshnSj/k72Pyw+awHBwr74Ysws38FWXq3FQbBC7d
	 NIhfr/QkmwcZy+txdeUAidiuz+fjPDxyjhSmkliNcl+fY//ASFrD58QYRfEuvKgsvyX48
	 7/9Y/m4ADsz8gT44m0o/sEGnFEoLcSAy5m3zE212HuOcgRJFlY6cEkCZvQB9foEfNig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793690004;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WLI3mBt99xmhG6lAwgTlBHdUquY4I/mHmUBB9gIlM/Y=;
	b=Pi62BDftBrTMY3XjG34vVB2bh15Wx3gZk+ZgYne19qJOHFwI1/+Pls6HrtZuINy4ZnCQ
	 oxJIZkDXhU+tpS2d+WqpkUEkudIa/uTQrN8XVHdEa4NRQFfOg/7HcFBIeVqOu1BRpT1lh
	 nFTIPKuDAR55EBSVorlqKdGRCghhXrvCamPSl0oz9MYFDz0WOwZOGZxpgaC6peSt1g4Rl
	 U1x1UvWlOE2bUpsMPhtLqPqmBrncwurSXrePbzUcJphC9+PbcyQMaDcI3ZcK7FUg2wkFw
	 Qv9VKWyWSf8/ux1dn/tC4bCvTZ6BzO+Fj4Y0HmcUlhUgVkiuI73EnsNZOtgAaJ2HcVg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0TJd0P0e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793690004;
	bh=WLI3mBt99xmhG6lAwgTlBHdUquY4I/mHmUBB9gIlM/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HwJqB4H/pV+tmqwVHor6/FXi7Nqp6pYgXxqtjJatJv1ZrMF737npCOe3R5eibq6gv
	 wcupT+UdNitlHwgwsjUC5SF2arackYk1Aip19aQYS/efkgITLvqeGMXRC2ZfSZfSd/
	 ovwONBVt+8tJRacAui+syLfXJ49J1H7BBVdKBkJXGNnGqY58Lx6IP6zi0TxS8kPw/G
	 WaBb0Gcs+9qVYCxm03GzvK2028RjOf6WfHqNPFAFjeNP47d0DB4eQvhgYUWHvhsJTg
	 Wq3BqV21xVw9L+QVM3JZch7xRMG6oEGI8skiPvOx+l6E7vlg22MHqIzfVfl0rM6AqO
	 Y48MMbV0MS6Zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17B6A80DBD;
	Tue,  3 Nov 2026 07:13:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DD872AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8DB9C80DBD
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xKng_-Mnwr7f for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:13:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8323680DB0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793690001;
 b=NIl0VIty3aCM0bzah556irrxATOfa44NdwFkX9iaAfSRM1bt1ATbR2QCBCSmz+wcJhcd
 75fOe/vKgBAFpXxA012G8ND5iBHIp0YZeTN9cI0TgRW8PPSk8qVTUdeXyd4ik+XkuZXMP
 Om3dLI7UdkcsQ5DhuAuzhZM+vxQjpXIReF4l55M6603M1SQSLJX86pGaQTEj/I7ihELOe
 a34hYZ9zd+viPXl6/2I75XJgoZ4GgWFlR/yrkjpgsSOwR70Sa8qMQYVrdZRKzeMbiLtc4
 CCDL0M0XD7thRRVAiI/vFB2LhgHd5KgBEpYhFSWxp24u+J3fcF2Mey7bN3tDoL/Js0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793690001;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=WLI3mBt99xmhG6lAwgTlBHdUquY4I/mHmUBB9gIlM/Y=;
 b=OTnxdH8XndfheOInS4U7SZeMyokdrDDiT7JeFVGfYwUu4F3xiV2UWtel0Tx0tAnyIV7H
 o/hK1BiJLYJzctZytIjeV4YjCN1nrm9uJSuhIFuAkvyiyjBOcN9N9Wm1bBvcRkbpzn4sR
 xgBbKYzXBiSChxOCx79lJexT2mAHqJoYLPKAIDPmqp1R66aHe5iQc8IAi37Gq2J/VOO1o
 hzEINSLWGAXASW6BpWNaeVdJMX+UXAsJZo8Ltm7Wvf0UZDwdluegRSNK7yH4F6mdbwp8Y
 CR9EcpkxTwQJtTII1PsJEBO0Z9azblGKy+0zSFGGgmgJm9hKZMsocIUtsk+eb3HYu7Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=0TJd0P0e; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=0TJd0P0e
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8323680DB0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:13:21 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso24958735e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 23:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793689999; x=1794294799;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WLI3mBt99xmhG6lAwgTlBHdUquY4I/mHmUBB9gIlM/Y=;
 b=0TJd0P0e/Z/lxXIaMM9PuiNIOYUfMgbmACyl9Ku/bUtJL5TaPKQCYf9iXZNQKhmBxe
 uCxQf44p6zl6jEAJ8XEQinU8a6OKbjWyeupFbgGw5XIdXHISBiwWVJRc5BGNEwtMWFQb
 PiTI9GJp0ZTzBp4dAhLz8a+zujFrzmdwip/7ZxmGMv6s6vDivJC1hJuRuLs7ywb+vxkQ
 WBI3gDo3+H3VBkafOHXT3yhekbzWfJnFnWPwSPbp8ZC1eX3sVrrPhFzb8utltuE5/wAx
 SlGDcnqf929Wcneklq8S9FH5psRCnbLWvzLQGt5HhmCl49wwJ3dOLLp6eXiVUr2YPurZ
 uapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793689999; x=1794294799;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WLI3mBt99xmhG6lAwgTlBHdUquY4I/mHmUBB9gIlM/Y=;
 b=IhAAyuRcS7PHNxzrfTYTPUev9M4agUfzXEWTwBjHCHuI07iesPLEEwEwGNJmPH2cLj
 fTuHQja/mtVydyzPUqpqfBqR3CqQOlOlTeRdh4NUPxq5Xr8eRaiOIaYheSAbrUY8sQcs
 AOq62IUi1bbXfJpppJKIgHDHyIKTByLF+40AbM9z+px0M22j8F+7Ded8J3eTfqifQW6G
 zvVief1fWA6tZJt4qptPeGLwzi1WkujnN11VfWyYgVF2ViF70I7SAmVl8JG26LfK76CH
 m28k95t4IFQT1onu/91SUuNRW3qRnA37EL4+52QUeSLzRSFMyjMyTYpqQUVgLPKeESP7
 K7Kw==
X-Gm-Message-State: APuU4Z+8yfeplCAp28HnyuNMjV/rUUwI8RrjjvZ74bUO82m2EnUPezdQ
 74SGVKMiN2iD8AWhaEgw+KixLRcHuhmdm4n79bgGQvCJKYIweDgxjm1a5L7A3x1Up4BGEMsV
X-Gm-Gg: AYBFou1RU2qoN62x6hV8k0WEwUKmhu+VuURVayfR+MZ8t8cMVZ7EwPuoSzguVAvE0nT
 Xoa35hhwAkUhWzsHvorYt35g3N2qvTW6pu/EV8Z/ncXGypJ+uYsUmyf/rxD7LXdB6umBOjbPlHx
 /6dc+tHD1oQkq40+QaRhWfee+kkGXCO2+Kv6LsHTHjUlfZYgPxLzoxdLAFIFzwX4KkklaQDODJu
 eURBqx4+W5oAcrRli7Zu0FF9epxTUCtIHAmF1FWZ0iNpO/ZvDHDCqtqlZcW5RBgcaqIQ/40jpq1
 kqH/O5NKAPzErc1lu3WxAJvpRm8Dyj/7/CwUDcahgHIZSEbRQxy4kbIvQsHqK9skmvi8RLh1hhj
 Isu4hLU9sphdBQqUL9N+Cgn7tL6COV9c6afhVIGEMt0Qq/r6vpAW7G/FuPWndVJQ5I3M6tZgKpk
 EAzX1ExHlKkhmVlB54xbhaGmQMd5bmpdvUFENPW72x1mMhTeHJQByAZ190ESjgjY6Bzf5CT46iO
 w1OY2SCAmIT7ZqJHQct3DJKB6vPMFYp2ZMw/JNJ3Yr/rsk/9bwea4zHhAC969o2LDDZgn37EhFi
 ejcfpI1/NGZnRVHrJIdsUqKWSN9nnMk=
X-Received: by 2002:a05:600c:1987:b0:4a1:6517:ccf1 with SMTP id
 5b1f17b1804b1-4ac16fa2edbmr282617685e9.9.1793689999158; 
 Mon, 02 Nov 2026 23:13:19 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a0a3495sm250888795e9.4.2026.11.02.23.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 23:13:18 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heiko Schocher <hs@nabladev.com>, Kyungmin Park <kmpark@infradead.org>,
 Tom Rini <trini@konsulko.com>, Benedikt Spranger <b.spranger@linutronix.de>
Subject: [PATCH 6/6] mtd: ubi: vtbl: check the size of a static volume's last
 LEB
Date: Tue, 03 Nov 2026 07:13:17 +0000
Message-ID: <7d019247-1a81-4685-a325-dcbb26c87509@gmail.com>
In-Reply-To: <151582f9-d68b-4fc9-9f07-1a8b9b1395dd@gmail.com>
References: <151582f9-d68b-4fc9-9f07-1a8b9b1395dd@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

check_av() checks what attaching found out about a volume against its
volume table record, but not how much data the last LEB of a static
volume holds. That size comes from the VID header of the last LEB when
UBI scans the device, where it is only checked against the LEB size,
not against the smaller usable LEB size of a volume with data padding.
When UBI attaches by fastmap, the size taken from the fastmap's volume
header is not checked at all.

init_volumes() adds this size to the volume's used_bytes. 'ubi read'
and ubi_volume_read(), which the UBI block device also uses, read up to
used_bytes, map each offset to a LEB and pass it to ubi_eba_read_leb(),
which looks it up in the volume's EBA table without a bounds check. So,
for a volume that uses all its reserved LEBs, a last LEB larger than
the usable LEB size makes the end of the volume map to an entry past
the end of the table, and a larger size from a fastmap moves that entry
further out.

Reject a static volume whose last LEB holds a negative amount of data or
more than the usable LEB size, the bounds self_check_volume() expects.
UBI writers, U-Boot's and Linux's as well as ubinize, stay within them.

Add a test which writes a static volume with data padding, filling its
one LEB to the usable LEB size, checks that it attaches and reads back,
then sets the data_size of that LEB one byte larger, which still fits
in the LEB, and checks that attaching fails.

Fixes: c91a719daa33 ("UBI: Add basic UBI support to U-Boot (Part 5/8)")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/mtd/ubi/vtbl.c |  6 ++++
 test/dm/ubi.c          | 70 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/mtd/ubi/vtbl.c b/drivers/mtd/ubi/vtbl.c
index a2b5352cb2d..4a2b6e7fa6f 100644
--- a/drivers/mtd/ubi/vtbl.c
+++ b/drivers/mtd/ubi/vtbl.c
@@ -693,6 +693,12 @@ static int check_av(const struct ubi_volume *vol,
 		err = 5;
 		goto bad;
 	}
+	if (vol->vol_type == UBI_STATIC_VOLUME &&
+	    (av->last_data_size < 0 ||
+	     av->last_data_size > vol->usable_leb_size)) {
+		err = 6;
+		goto bad;
+	}
 	return 0;
 
 bad:
diff --git a/test/dm/ubi.c b/test/dm/ubi.c
index 81654b33f1e..036189c5e54 100644
--- a/test/dm/ubi.c
+++ b/test/dm/ubi.c
@@ -135,3 +135,73 @@ static int dm_test_ubi_vid_hdr_data_size(struct unit_test_state *uts)
 	return ret;
 }
 DM_TEST(dm_test_ubi_vid_hdr_data_size, UTF_SCAN_FDT | UTF_LIVE_TREE);
+
+/*
+ * A static volume with data padding holds less than a LEB in each LEB, so the
+ * size of its last LEB is bounded by its usable LEB size, not the LEB size.
+ */
+static int ubi_test_static_last_leb_size(struct unit_test_state *uts)
+{
+	struct ubi_mkvol_req req;
+	struct ubi_device *ubi;
+	struct ubi_volume *vol;
+	struct mtd_info *mtd;
+	int usable;
+	u8 *buf;
+
+	ut_assertok(ubi_test_erase_mtd(uts, &mtd));
+
+	buf = malloc(mtd->erasesize);
+	ut_assertnonnull(buf);
+
+	/* One LEB, padded by one min. I/O unit, filled to its usable size */
+	ut_assertok(ubi_part(UBI_TEST_MTD, NULL));
+	ubi = ubi_devices[0];
+	memset(&req, 0, sizeof(req));
+	req.vol_id = 0;
+	req.vol_type = UBI_STATIC_VOLUME;
+	req.alignment = ubi->leb_size - ubi->min_io_size;
+	req.bytes = ubi->leb_size - ubi->min_io_size;
+	strcpy(req.name, "vol0");
+	req.name_len = strlen(req.name);
+	ut_assertok(ubi_create_volume(ubi, &req));
+	vol = ubi_find_volume("vol0");
+	ut_assertnonnull(vol);
+	ut_asserteq(ubi->min_io_size, vol->data_pad);
+	usable = vol->usable_leb_size;
+	ut_asserteq(req.bytes, usable);
+	memset(buf, 0xa5, usable);
+	ut_assertok(ubi_volume_write("vol0", buf, 0, usable));
+	ubi_detach();
+
+	/* It attaches again and reads back */
+	ut_assertok(ubi_part(UBI_TEST_MTD, NULL));
+	memset(buf, 0, usable);
+	ut_assertok(ubi_volume_read("vol0", buf, 0, usable));
+	ut_assertnull(memchr_inv(buf, 0xa5, usable));
+	ubi_detach();
+
+	/*
+	 * One byte more than the usable LEB size still fits in the LEB, so
+	 * the VID header is valid, but the volume is not.
+	 */
+	ut_assertok(ubi_test_set_data_size(uts, mtd, buf, usable + 1));
+	ut_asserteq(-EINVAL, ubi_part(UBI_TEST_MTD, NULL));
+
+	free(buf);
+
+	return 0;
+}
+
+static int dm_test_ubi_static_last_leb_size(struct unit_test_state *uts)
+{
+	int ret;
+
+	/* UBI holds the MTD device: release it before and after the test */
+	ubi_detach();
+	ret = ubi_test_static_last_leb_size(uts);
+	ubi_detach();
+
+	return ret;
+}
+DM_TEST(dm_test_ubi_static_last_leb_size, UTF_SCAN_FDT | UTF_LIVE_TREE);
