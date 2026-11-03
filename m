Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B28606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Cn3toyad;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rjk89HT7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 666296070C;
	Tue,  3 Nov 2026 07:13:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uxrziBzkN633; Tue,  3 Nov 2026 07:13:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 70BE0605E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689991;
	b=RLSy83h8kVZDKGz/vyxfJMczJOT0GDtkdim82E4okHL7HI5wm/s5EQj3C7KzQpM/QoLj
	 mF4XagvC0Fto7nr+tdupZr10x01XKncQryv8JNtIWVdeQFRCRXCEpVTeXekdIzQRb0nkz
	 MUbiSQF5JYnfmISL9Df7rsvKb5Bwztjlf7a2NU1dPoPbPX08K19c9M5+x4sl48UIHJH02
	 BoHC/AVxlQaplWxwFHHlV0tqQ5wtuliyGPWLxPSquxetOXY8nPUCuxam3g8vni73X2LhV
	 uQaNRSSeZnUwZpSE+pfAZTQYEnm7+eqztbu7FBzEJXoOxEy19WYFM433fKSVCQ2CEOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689991;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UE1LJEtAV6tlU7gE6uuMnQBj8vZhms01jBFJ/smofz0=;
	b=Az/KDGBG/mTgFNRMNSjuf7VpcoCCuADmT/yQynyB6GKV3dU5IWp/SL6atT6qlAj9wv3/
	 NkRnWvXdtQORuPjS/VvMj1WjKSq1p+GtrwKp0k42ChBysK8fTx9I8mouDsHa0ZhzHDULH
	 Qz9/4HUqKAa3C1CqOyHttsUWPi8q/6WX8pxeeJxVLKeIlZAXh2ReTgJATqqEevuvumWBX
	 ortQeJGVO637WWffWBVmq0DZ9X9FFvZr7XxJzTilu64n/4Y1tkxJAftquL4md2+NMD1CT
	 H+8lEh3raX964aTdEzc5S211DNJrzVWvAiiC/Lry7ZSiLq5+WguUw80j+uel2O/o0jQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689991;
	bh=UE1LJEtAV6tlU7gE6uuMnQBj8vZhms01jBFJ/smofz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cn3toyadquVsD43B5JEXrAGzcpGE+uHpiA0xOk+WQ8Uwzk41274NozmVMzGvjozHr
	 XpXNKMwE+9vu1pmUFhMWvXUDqTulSsBoGYzsJdq+4c8t1EJuk2AySkqBZk52ehV1Zv
	 URYsbDUk4wKuDxYDJRoetISb3ZKyLyGlcBXj2HBOHxpeWYB53aE9486VMKjSZBSmgT
	 c54MwuedYMm2KzXSNYgzYbyeTjan111rscf6todA66PZUiDI5CoeMSV8qpFgDVFski
	 6qy3mOdkOztaHweyfFFRbWU7SNt5IoLurHujdEj1VXmuJQFmU7CNevWBM46PKUwvt0
	 JIKkc9wxI+KqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70BE0605E9;
	Tue,  3 Nov 2026 07:13:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D26632AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFE6380DBD
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:13:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VGhqqCGTHJDZ for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:13:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B5F1E80D81
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793689988;
 b=lDSjGLk+nlfPeoFpXlrQSbpzTE+bogX6emU5ej385ihG9KG4rMcKIuM9Ze4Yqk+F2r6v
 0oXl8dU6hnE7IrYwpf53U4+IrndCfDsMwyy1Yecagh6443TuT2zN80X1uPQyZc/4vYOek
 4rAxUaSuBoiLU+oB1NPsugG8zCEZNlVEgW0WFcB6wtSuKE5U/lDTan8y/ZEUhXP/+uBFf
 KjML90EgkCRDwg7xRpB+EtKHqullSJW8SJTTmqyoSJ2JFCBlhX0sik7GZHraoVglB1Zr+
 TyN9FgFGfqGW5R+6J1aix7Z2pgson9EdN6aY5UejK+MQKRY8f1InFM/2qOfG+uialeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689988;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=UE1LJEtAV6tlU7gE6uuMnQBj8vZhms01jBFJ/smofz0=;
 b=DjVVWvUMV8yO7tc2nI39/NDqlSE9LXhu47J1lFdZyuVkZFKR+dRgRhylfuI9bWpAbwYR
 noQcRs8+ros1r045La9gCcRegkc77x2B7Fl0bQbI54SlrnbMKdGYZPuK22X1gGlHQHcPd
 e1ijNdhOVH9FG1ahAxN9Tfdn7wl+M2pvra3ns0z26Dw/KafD4qrGezOy1CNPzP3CrwK7J
 nqwUw/4HqxhxF2UKvZo2aiBn2cChGBeeG7Wg28W+rX+IOTKClNKLwsGsH95DD0/vYs/n/
 +Fmh76RoOKAt4yMf58oHLCWlUnRQJL1GXGIEFKiQvM654dKJGjOP24QBKdKrg1pDCaQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=rjk89HT7; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=rjk89HT7
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B5F1E80D81
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:13:07 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48e04773687so1135431f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 23:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793689985; x=1794294785;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UE1LJEtAV6tlU7gE6uuMnQBj8vZhms01jBFJ/smofz0=;
 b=rjk89HT7KB+VIH+B/V1NPfOzY6/9+iKqOMUKhqNmc+v+P2NR64Wlw0JhLFiWXmbPs4
 z5i+FAgc/HdNB4dCaKYd+p/k/a0fvGQeirNPp2N3WAxPYxJZfqsPjl+VpQjuUPiA/F0g
 ijZCphF7hNPLfbK/Hnmq55e+XRSqq2XP4ISArH78bGRkfVfTKkOxc4ahRUpQEeTP2sv4
 s2Q8w56RiPuJOM3oNweL8MxjGe6ZOJ/pzOEpBHNZjmIae8rpAQM6hLTQ04CAJkzkpTwT
 CWLaoui2xvsl9ouYkCtQdPpaAQlJ5CMWdfpMgu75Eaopo06iif6IPhFbx7gk0mecLNNz
 +I3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793689985; x=1794294785;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UE1LJEtAV6tlU7gE6uuMnQBj8vZhms01jBFJ/smofz0=;
 b=dDUyJOyUjpr+uayeazzDFcSxRKHaHyp/j3XfzJOrAgEI5MIAvfE5XajpVoFNAJUjP8
 6bcEnUaU4NgF/OCwzmehQewVs5cWccosgHPbyspmfYMrTY20X/lSSjDU6kf9taoaWsZS
 1KTPikEM4xSD0OfmLMNr1JdKn8rekyU9gSpKFtx/6qfqm++x4SbCd2xj2wJ/UA+VuIye
 1Wumb15ArScyqy4VTI2ZelBP0cEtT4bmfYZgVz3J7CvXUwjQxS82P4qcNCzFP1Oxk21b
 YrwsVtll2vXV6n2M9O03HxSbwmmPGal1yzwltIChXq/7vpEzUOndBZTGRHDe+Ji8lFtZ
 3Jjw==
X-Gm-Message-State: APuU4Z9JvJ+RuUmRMujBsc9eknL1V3SC5MzGpPEglZxFcqzlTc6Udh7u
 VmN5iNTi+iqDFIDs1RDqh9U/mMSpWQ1eyCtW9MLzr6pXvA4STLMs3isyJwsp1eXPYSuKkJfe
X-Gm-Gg: AYBFou13NSYz7yZqcEEJT3Kw63FEGR8ybgoq9D+Q0a+e13g521s2NqnqpPYZKEh/v9P
 QzEEW+bCz1FLFf0bIQu1GyN7CWkESTq4W42lA//sk3hgR8cGCwvs9zuFhf3liEWIaTCgPtqa/M9
 KCqNCs6ezzIcbA4/k7J87HdR0dCiqc0/a6Q06yn2mN4qrNWzBAvWxaiOMHr73CUEzLsBsLlIJJ6
 /xCkIfN3eW78GMGSKgNmZ12NJsWpCzuMU1Kjj2yShNpvRzJupKBgUYtLe8rLg6Om240Q5P7hrcS
 g4T/zr1xf6N6ipT+3NJdno1xiBq4qeI/+Vyxm+WFfrGihNSR2bgtiVxLPfuiyJEntDxGW2RnjLZ
 1OI3NJ96aZy3b+xgoBXmRs4AoQyWxjlGIW8kcayf/LCM4uuOC5J2RlV2dBV9HbKTq2S1I3vRSv4
 FClHYkhSSt4suf9v8+q7p8NpzjV/g2beVejaEuTjbHcH3DLJGXwdDDLifQBfLc9ceKqtQgb1lAD
 3N/UE20Zk/bNO+C3khlPADeQrRl/+MkpzUrm9iZUwXnRYiN18vPVfyWUKGoWTA9/duIJyNdT9p9
 x6MxapC4v4fjnKXujK0BJCX31vSo1mkh
X-Received: by 2002:a05:6000:4b08:b0:48e:7508:bc20 with SMTP id
 ffacd0b85a97d-48e7508be83mr21891818f8f.2.1793689985426; 
 Mon, 02 Nov 2026 23:13:05 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80ecbsm24072857f8f.35.2026.11.02.23.13.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 23:13:04 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heiko Schocher <hs@nabladev.com>, Kyungmin Park <kmpark@infradead.org>,
 Tom Rini <trini@konsulko.com>, Benedikt Spranger <b.spranger@linutronix.de>
Subject: [PATCH 4/6] mtd: ubi: fastmap: check PEB numbers read from the fastmap
Date: Tue, 03 Nov 2026 07:13:03 +0000
Message-ID: <ff585b11-bca3-419e-aef3-08db9d292200@gmail.com>
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

The fastmap lists the PEBs of the device with their erase counters, and
ubi_attach_fastmap() passes the numbers in its free, used, scrub and
erase lists to add_aeb() as they are on flash. ubi_wl_init() then uses
each of them as an index into ubi->lookuptbl, which has room for
ubi->peb_count entries, and stores a pointer there. So a fastmap with a
PEB number outside the device makes UBI write past the end of the
table, or before its start for a negative number. The CRC over the
fastmap doesn't protect against a fastmap that was written that way.

Check every PEB number taken from the fastmap with one helper that
accepts only 0 to peb_count - 1, and treat the fastmap as bad otherwise,
so UBI falls back to a full scan. Besides the four lists, this covers
the pools and the locations of the fastmap blocks. An out-of-range
number there is otherwise first passed to ubi_io_is_bad(), whose range
assert is compiled out unless DEBUG is defined: on NAND it reaches the
driver's bad block check through mtd_block_isbad(), which lets an offset
equal to the device size through, and on flash without bad blocks, such
as NOR, it returns 0 without looking at it. Where that lets it through,
the read that follows fails the attach instead of falling back to a
scan. Also, ubi_scan_fastmap() takes the block locations it keeps for
wear leveling from the copy of the fastmap superblock at the start of
the fastmap data, not from the anchor's copy checked first, and
ubi_wl_init() indexes ubi->lookuptbl with them too, so check that copy
as well. The EBA table needs no check of its own, as its PEB numbers are
only looked up in the used list.

Linux has the same code, and the same check of the four lists has been
proposed there.

Fixes: ff94bc40af34 ("mtd, ubi, ubifs: resync with Linux-3.14")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/mtd/ubi/fastmap.c | 73 ++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 9c6b15b8cb5..bbf4247d1f4 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -105,6 +105,31 @@ size_t ubi_calc_fm_size(struct ubi_device *ubi)
 	return roundup(size, ubi->leb_size);
 }
 
+/**
+ * read_pnum - read a PEB number from the fastmap and check it.
+ * @ubi: UBI device description object
+ * @pnum_be: the PEB number as stored on flash
+ * @out_pnum: the PEB number is stored here if it is valid
+ *
+ * The fastmap is read from flash, so a PEB number in it may be outside the
+ * device, and such a number must not be used as an index into UBI's tables.
+ *
+ * Returns %true and stores the PEB number in @out_pnum if it is valid,
+ * %false otherwise.
+ */
+static bool read_pnum(struct ubi_device *ubi, __be32 pnum_be, int *out_pnum)
+{
+	int pnum = be32_to_cpu(pnum_be);
+
+	if (pnum < 0 || pnum >= ubi->peb_count) {
+		ubi_err(ubi, "fastmap references PEB out of range: %i", pnum);
+		return false;
+	}
+
+	*out_pnum = pnum;
+	return true;
+}
+
 /**
  * new_fm_vhdr - allocate a new volume header for fastmap usage.
  * @ubi: UBI device description object
@@ -489,7 +514,10 @@ static int scan_pool(struct ubi_device *ubi, struct ubi_attach_info *ai,
 		int scrub = 0;
 		int image_seq;
 
-		pnum = be32_to_cpu(pebs[i]);
+		if (!read_pnum(ubi, pebs[i], &pnum)) {
+			ret = UBI_BAD_FASTMAP;
+			goto out;
+		}
 
 		if (ubi_io_is_bad(ubi, pnum)) {
 			ubi_err(ubi, "bad PEB in fastmap pool!");
@@ -616,7 +644,7 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 	struct ubi_fm_ec *fmec;
 	struct ubi_fm_volhdr *fmvhdr;
 	struct ubi_fm_eba *fm_eba;
-	int ret, i, j, pool_size, wl_pool_size;
+	int ret, i, j, pool_size, wl_pool_size, pnum;
 	size_t fm_pos = 0, fm_size = ubi->fm_size;
 	unsigned long long max_sqnum = 0;
 	void *fm_raw = ubi->fm_buf;
@@ -697,8 +725,10 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &ai->free, be32_to_cpu(fmec->pnum),
-			be32_to_cpu(fmec->ec), 0);
+		if (!read_pnum(ubi, fmec->pnum, &pnum))
+			goto fail_bad;
+
+		add_aeb(ai, &ai->free, pnum, be32_to_cpu(fmec->ec), 0);
 	}
 
 	/* read EC values from used list */
@@ -708,8 +738,10 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &used, be32_to_cpu(fmec->pnum),
-			be32_to_cpu(fmec->ec), 0);
+		if (!read_pnum(ubi, fmec->pnum, &pnum))
+			goto fail_bad;
+
+		add_aeb(ai, &used, pnum, be32_to_cpu(fmec->ec), 0);
 	}
 
 	/* read EC values from scrub list */
@@ -719,8 +751,10 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &used, be32_to_cpu(fmec->pnum),
-			be32_to_cpu(fmec->ec), 1);
+		if (!read_pnum(ubi, fmec->pnum, &pnum))
+			goto fail_bad;
+
+		add_aeb(ai, &used, pnum, be32_to_cpu(fmec->ec), 1);
 	}
 
 	/* read EC values from erase list */
@@ -730,8 +764,10 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &ai->erase, be32_to_cpu(fmec->pnum),
-			be32_to_cpu(fmec->ec), 1);
+		if (!read_pnum(ubi, fmec->pnum, &pnum))
+			goto fail_bad;
+
+		add_aeb(ai, &ai->erase, pnum, be32_to_cpu(fmec->ec), 1);
 	}
 
 	ai->mean_ec = div_u64(ai->ec_sum, ai->ec_count);
@@ -781,7 +817,7 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		}
 
 		for (j = 0; j < be32_to_cpu(fm_eba->reserved_pebs); j++) {
-			int pnum = be32_to_cpu(fm_eba->pnum[j]);
+			pnum = be32_to_cpu(fm_eba->pnum[j]);
 
 			if ((int)be32_to_cpu(fm_eba->pnum[j]) < 0)
 				continue;
@@ -954,7 +990,10 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 	for (i = 0; i < used_blocks; i++) {
 		int image_seq;
 
-		pnum = be32_to_cpu(fmsb->block_loc[i]);
+		if (!read_pnum(ubi, fmsb->block_loc[i], &pnum)) {
+			ret = UBI_BAD_FASTMAP;
+			goto free_hdr;
+		}
 
 		if (ubi_io_is_bad(ubi, pnum)) {
 			ret = UBI_BAD_FASTMAP;
@@ -1052,6 +1091,14 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 	for (i = 0; i < used_blocks; i++) {
 		struct ubi_wl_entry *e;
 
+		if (!read_pnum(ubi, fmsb2->block_loc[i], &pnum)) {
+			while (i--)
+				kfree(fm->e[i]);
+
+			ret = UBI_BAD_FASTMAP;
+			goto free_hdr;
+		}
+
 		e = kmem_cache_alloc(ubi_wl_entry_slab, GFP_KERNEL);
 		if (!e) {
 			while (i--)
@@ -1061,7 +1108,7 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 			goto free_hdr;
 		}
 
-		e->pnum = be32_to_cpu(fmsb2->block_loc[i]);
+		e->pnum = pnum;
 		e->ec = be32_to_cpu(fmsb2->block_ec[i]);
 		fm->e[i] = e;
 	}
