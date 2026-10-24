Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14996606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IKhVqRlc;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P1V9hEyi
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E97A960ABE;
	Sat, 24 Oct 2026 12:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 813mWhD3Ax1j; Sat, 24 Oct 2026 12:17:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 31F0660AAA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792844242;
	b=RReKTj17UxmxKCaUfwWyJCIPEeMXSb5SAw3iDd5IzF6fx7gXHG9gRbNZbv0oczDp1OMh
	 eDVdM/tlCJdFKbt4OGCIfU+18svWWwl2+BgqOF4WUFwHY2W4SoMQEHGyhceS2NHy9IV5f
	 MsRt12J88w8QogoaKMMAqPsQ2VqLNREFhro1acUMP0gFo7bII9BLkXZp8E+3yM+pfCKR4
	 7yO/07EYzT8vQErTuDM7JnMOV1kdm4/7nylCSgZFU2otpkuCuYhd+EhCJqivepmF4Mx2c
	 mKV9RHv2gNRPkzucxCjJoZ38Ns61gP7wz2eWQKGyqD5tzZBER7UccQzANYlUkknz+MA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792844242;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=oj1rbzDwc9w0ppG7YyjvAW0+fgdSmRhj4yu9ONi3UuU=;
	b=h36jufdDEwRBDWiSfWhKCkPcrj6edlTyAPARysjCaHBaEHw0Z+IUQZ+MVBE3MtrM0D3Z
	 Hlb/buXygqoqjk0zvPLZNmeVB2ub62Dtya8X1yOrU9xD55GiZU5oKg6cnoOMUGMHVjSAw
	 1diE1f1ykAFRQqFTsLvmcmFrQ0ncjViFN2mazL8o05n2yzy2aKxJlrQ7BTuLtBDZgJ8wd
	 AJbqH9wH1U3ygdhK+p8XaNLOIrZ2Gm5EYeFqqJxYKv2yMVRo88i9zoIeZ+JHLPsm9Mlcw
	 zj67FijPkrrCO04U3m2yXFppN1l5PLgVJfy5TR+x6Ynxvfd7k9EQ9dzY3qWDnLcaJng==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P1V9hEyi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792844242;
	bh=oj1rbzDwc9w0ppG7YyjvAW0+fgdSmRhj4yu9ONi3UuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IKhVqRlcKgwpzsDGN9xnsM40b4RdScszFUWk5h2oFy/wt3M+BVeCJat1n0DDFTQk5
	 VjRFulXeFq+NGEpYim09DPExQd/96UNbcwZHQP3SgrsmzFJUKac9SL0vyJSHZd0Xgc
	 nbZJG91znN+ppLsO2e+yGMj9vFNYuuJTzD+K32A3qes5xhHf2kE0lfRDSjzQ1Zc5X5
	 D2AJEPUxzWHKgXTcG6bKWxJCM95a2h1VhRJXa6ysMokqFApET8e/o82GHfl66oE6eA
	 hJyOWi2f0R+PWk9Y7p3uIAR5k9I+3r3cad8PNoagXg1HHg62drIBirMD1M1QImQcBi
	 LDopzhT45LwAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31F0660AAA;
	Sat, 24 Oct 2026 12:17:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BE7E9765
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A3DA160AE4
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YUgnd7x_RWbl for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 12:17:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AAFD760ADC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792844239;
 b=D34OlhvUhfr1r40sUPgrd7iF9mJehw4JI43P1yuhlls17eB5sxAgg041nqBWF17rkQlU
 S4E5n2budaZ74xMJfW0nidjZmSJDB8D0xN5QazYk01GaTe4NIH4HCwfH3krlND8l5VtSn
 i4YntZGggCEMDbDS89wsizD9/+WzczItDMSy5IWqFLqfbFreptxvI2Qy5TvZ/rdqSHN10
 wH/Q9BbhZ3jnaR/4DqeSJsWuXvYj6V1byrjSDzOXhgz+4NM7/Gq6vVyn7TKsDJC4E71vl
 iNySd3HOB9OFdGmWVRw2t/SMEneqewNPXepAVf3wgsA2ipQtdSG8xrtvS7fCPX1HrSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792844239;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=oj1rbzDwc9w0ppG7YyjvAW0+fgdSmRhj4yu9ONi3UuU=;
 b=G6kepNPj19jbIs7na1B0DnV7WoPg6s3Bgb5sHrVSdWuMruxasv5+6EViPpZDl8aoTl+2
 ECay71aRlZolHaSYfsMTUoDk02jFaoToCOIxhHPnvwl9EK5Nh1YYruIw+/Qasw9O/5ajF
 lhoQweSqDvrNmFDuuBG9044hQC4pUHt1/q5l/AwGKckFmJ/DAytzLqPLGTSqYGq2m8wX2
 QsiqKgrkd8p39DN9a8ZbD/oFonl+xKs53l3ivMy2NMrHSMvT95Xz2mcJ/QOFbVYVi4Dq5
 HC4ZJVTJ62mKhqkFLM4BpOSPFKC0Z8Pqf00X+QcJWWoQd8wAU2c0dv7VmuEAIRKT8Yw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=P1V9hEyi; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=P1V9hEyi
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AAFD760ADC
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:18 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so970764f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792844236; x=1793449036;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oj1rbzDwc9w0ppG7YyjvAW0+fgdSmRhj4yu9ONi3UuU=;
 b=P1V9hEyivNBfIuNEwfFNKvQ9EICF0t8IYdyH+jw0GtFS3XBkvRj1NXj7aH5sKXPZFb
 7j17htiCcwR9DxkMg+gygcM+1G0wiA7Ly3BHuRDlvf60vD8/8y+q5RnLdDcvDIH9P2Un
 ToKY042uJ7U5YvYEkZKVApbZ9avRkHNi/1WiUCEXuXLrGjZl+q2oAqocrmUqUi8qgKkM
 EekQeRlKSHT+dZTlnLS9GaMC51wX021s0XLVAXa35/C8CJGHUTjYHvTOpdXexWWlbiAu
 iZ5dqq0dLj3OJIt7TnqVE7ncLwL+cUcbgBrRloJjmgBf6zfTZkQYg5iEwDB8RKCNAkG9
 M0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792844236; x=1793449036;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oj1rbzDwc9w0ppG7YyjvAW0+fgdSmRhj4yu9ONi3UuU=;
 b=bKzrUhfyZ/9aZeyS2MewIkpwO9ah1myL++C8V2mky2xhRvfbdREWIuPKTdP3bNZhM2
 mkyDpe7osXINAfiZgPiZaJVdQQstzjUD5DzgxAWGOl+fBs5cgLRRKniZfk4nm52u2cJd
 iPjz+pN7fgrBg5hx/waYT5CkgfmvabGfo7fsGfI6aVPu7tnnT8f8mKNvpRwZpOf2G8Ob
 SODYRKen4n6qx+ayBuRgHltMPr91l3WMhBT1ApjLw03DoigcdLyVUmOML+bPL3OppGWP
 fq4hu/yJjLy0lSw/7l214vK7QivULyG6D3vH2eBTrr7eYc2FVabd7gymTlmReu5y8OQ1
 wvNg==
X-Gm-Message-State: AFq9FYLgCEXVx154UTafQJh49YSN9qXjP8X+noThli8Oa7L9JLs8/F5T
 AqIqpt6fxsIrPyFFJ6bzGTo1LrSTaCIB7igBnjxTwPZgDwcq4gzRMylUZt52SXbd
X-Gm-Gg: AYBFou1eijkYrkXZ95g5jI8RXhOKzEIO7WVxbMK9p5+62GIBQbJkDd1dprZibZ7JcV/
 iU8wJPnT+wHg0erV45AkBUOx8wwsAkx8SfTR1mLEczYfD2slY1culHY4hIWl5U1qJSTNHgBhtrJ
 nqrXvIZxCJMANMmKU8CIC1MQJjYwFS9UO5uUZrli0fyX397qlrtuqMd1guXyp7EQBInDCF+OGW0
 NUnXR2xnWPZe1/SGQsph+OQ3lPvgnAlYgE/dZgvn+VB1svAmvse3cPVdQzq+CCewWO6kRl4AZzW
 zNN/CUYW/mTgNSMkDwQ2+zkMbm1AAcKrgK3u2ymE/DRqha/JswfG146k9zkerRFa1ojPk0/St6A
 77Gramd8toAXPaRtoycSaKNeFjnEH/CTBGFzGhR/p7XlXu3TzvougkRXJXbfDDXkUmEzkN3Khn8
 qPr8tAG52TSOrlU1pS2ybTMGuEMRv/uTzpCA3NyxZPLtVakorwapibCu/7iBuvzPNXcyaVf9GcR
 eTZzI8uoIBkpsyaAXXKEZyXE/2D09oWENT/ytj6k9PTNBo3DNNcc562dQ==
X-Received: by 2002:a05:600c:8b72:b0:4a1:e11f:b2d5 with SMTP id
 5b1f17b1804b1-4a35ac3948emr24875895e9.2.1792844236232; 
 Sat, 24 Oct 2026 05:17:16 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a55e786sm61600145e9.3.2026.10.24.05.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 05:17:15 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH RESEND 8/9] disk: part_dos: Make room for a three-digit
 partition number in the UUID
Date: Sat, 24 Oct 2026 12:17:14 +0000
Message-ID: <e6e3595f-6d68-4162-8df2-ef100d952749@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
---
 disk/part_dos.c |  6 ++++--
 test/dm/part.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/disk/part_dos.c b/disk/part_dos.c
index f451aef76a8..04a68ca6478 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -294,9 +294,11 @@ next_table:
 				snprintf(info->type, sizeof(info->type), "0x%x", pt->sys_ind);
 				info->bootable = get_bootable(pt);
 				if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
-					char str[12];
+					/* part_num may take three digits */
+					char str[UUID_STR_LEN + 1];
 
-					sprintf(str, "%08x-%02x", disksig, part_num);
+					snprintf(str, sizeof(str), "%08x-%02x",
+						 disksig, part_num);
 					disk_partition_set_uuid(info, str);
 				}
 				info->sys_ind = pt->sys_ind;
diff --git a/test/dm/part.c b/test/dm/part.c
index 4e313e50752..d44e9941ba7 100644
--- a/test/dm/part.c
+++ b/test/dm/part.c
@@ -348,3 +348,49 @@ static int dm_test_part_dos_ext_loop(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_part_dos_ext_loop, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
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
