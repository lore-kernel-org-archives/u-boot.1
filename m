Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D39606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ovF++y0u;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+wNyMQu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42DCB607B0;
	Sun,  1 Nov 2026 07:02:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LWaZxWJgnfho; Sun,  1 Nov 2026 07:02:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B104C607E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793516570;
	b=FbBioGTueQGH1mgrZ8BNYhWVAaMcx5J/BaAdL9/5/wwkyLKMWj5AzfsvqAopYc9uUcie
	 7Q8Xg7ieOVql2ozcnhNREy2Y8gjaQuUzZca6qaGYvE8iQ15m7ZxP+AvrpSYUCS8UPvZur
	 YItBF2B5Mm5+8ZRe3H6W75MAVaQdT5qUxPfIegEbw0t+nxTvGOwIVrvx6LP99kC8O4yKC
	 I+UYm7rEKcBz5ODeEDIAudZKQFBYDzApN8bmppNlyn1VCzoUiWRbMMKBybJJ3PQ+h7j8m
	 BtE0agE5TTp/IV+8g/3j6g4FtgJcM/5GbefpaMNZu6Ax5i6Jgzx0ppO3kF+CnNFSnIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793516570;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7muImtPvkO5ilZWas0f0BFOCi7EeHlza0F29NoumSms=;
	b=ZN7EgqFIR+pJgAquawvFy7WxeIzBbm++uBiZkPI/Dv45lL4hlJB9SjRm/xucn2sMWxaF
	 qayh0tEdZ1tEONc8iOjVytxyrNHLbF7pxkWCpqTLJ+tpQTlING7KpLqobov4s2eog/+vp
	 azNiZcZ0EleD1HB9IqXiIJ7iU2OPTdrdPjvg67d0bmEpqt6d35suPGMPcZsW/EIOgLXHe
	 3GFtW6FPSpC0lF4IKp4f7LQSR5kwo2vD5DgMCty2LKx7P1TtntP0n/6KXfaJfLbOTG0+Q
	 Bz9wHIeqsJkYrQlZRDKlNDpMM0BWogTmZs1Hi94h8S3u0CoIospZoVVbfFDglznnVEQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793516570;
	bh=7muImtPvkO5ilZWas0f0BFOCi7EeHlza0F29NoumSms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ovF++y0u2DHBfZbhCW2tGXBiQ7SCBlaBa8E4/n8LrNjk4D/JsFpm5SxnAMVu07zMj
	 l2ludCn2hILMGoI9z+fGvffQok/vVpT4IHsU9C14IKv3r0ZpNmqv1Rd5zmc4fv5JFv
	 gZkm1eOwifUEEasE0CyUEiM0dwL0JFhlru9NodAWAW1DstL6joI4vGMs8lmzbohg6D
	 TjIS5A6mkOPrhKBaDjmxHM12xfFSUld8h0mjiwtdO9joehT4MJ0kwhXdEiram6cMoT
	 Eo1cyjClcz326BtJVvZptYEqZTBSx7+DbHLDkm7ws0y8xSYKyOOZkhUNu8hb7UCJad
	 KWL/3I8Zax88w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B104C607E8;
	Sun,  1 Nov 2026 07:02:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D8490380
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BDB3B407C7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qTlqhg3KoCZ0 for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:02:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 173ED407C5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793516568;
 b=Nhoaub/jTuuu+RlKC2VtAT9DrUy+VaqyftC8HtS4lRKe1g9uM/TKWobWVRDbwz5fXgy2
 zT534xA2XGpRuAsJIEOliqB3M36a7B41Y37okisYqcRob5Dmscm7xjvxyCcmX3KdnFDcv
 aF+qWT1CLZeqCpSlFtRehDAKHUpWXt2z1bkGakVHta+Ri8PzS1pgEmXxrYkz8y9SahtmE
 lOGo5m0Q9vAecBbAUR/EpwE2jv+Zf76sQ2XEarSbUjQU9A3eIslEuygaWZD3wAGmK7f01
 9NKw6Xmi7zqHZ6f6B62EtT83vZKcx2/DhOgJIbys8gTfYBdQERwp9ZiE0RfFS0uuT4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793516568;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=7muImtPvkO5ilZWas0f0BFOCi7EeHlza0F29NoumSms=;
 b=NStZVcyiBnCH5pzbPRfHSNHI/+5/oQruRh7+FbzE/tsZhabugMqo0z0inQ3yfFkv5t8W
 RrgpP/SAADboJAFjkwl1iACU1FrGOHEXzqD6JogJc0qqzs5Kl7WvehaiIMkHut8FjVfqw
 LiLQ2PMBrweSDKh63lgdu5qF0vVYOJW4MH0JtCUHq8SJ5e90QTZH11zrwkw+0G/162V2/
 g39HYjF/ZS1mUH/XXdiymfQhWFrgIFQ6XaGuPKu7+m6/sAOLg+epyRTGeSKh+3WE1U/gJ
 M/qbXc/tFsFabC1cwtbHDGct8zJ8f2d0DOQk/xTLeiP/Q3ioiI0Weh4Hhtn2nzAKidg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=T+wNyMQu; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=T+wNyMQu
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 173ED407C5
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:46 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so15635335e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 00:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793516565; x=1794121365;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7muImtPvkO5ilZWas0f0BFOCi7EeHlza0F29NoumSms=;
 b=T+wNyMQuqPHrruWdDmZ8aA1wXQlkb7x+mw+gw0F+zFZhnHm6ExqSY0lJoNGx/W1b+T
 lIju95JH7BEq24ycYfzm96ww1L72rGQ+BIlYehRGRMJvsLVgXW5zGukvu6sb9hkR5Xi8
 HczCYLfQy+1bdIfSnuZwnSA6KpdvgSihEtiibE1Vt9jE+2LnSRuXKj3TqaRpZU3ZWNTm
 LQfPsnc5FSt0zHcI7WNskNyYb6PIGO0JtGs4NSfV3SxEgtIlDHiNipaxeyHYXWwu73bb
 BO1CpncwJubnaUIuRhs5Cf2fhGT8ztmMk6cnxIipsBW+OiAdiJ83oZZhAIY68Ejo9kp5
 vK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793516565; x=1794121365;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7muImtPvkO5ilZWas0f0BFOCi7EeHlza0F29NoumSms=;
 b=zNwtpUNtvmDRIsVFR0oyhlalwBmSEDdKaku4tEfWMbdlSTxHV/S11wcYuIzk3OVN8d
 vNLcR8PhVjPyuuzqikTwqA8DWZ6FkIoJONbIr+OCTbdRZlzcaqot+6Q0ZFlUK/pcgCDl
 pp0q00sA2adIhDjCRNZ7QGVNgVJvailLhKhV7OBvbXBps8yjMJIvA5Cv93vidGCLKDk8
 pivufafwql+apPH0hWgdcm0TE0wNBLlx1BluWiYw4kAVYKo98HtdA9br4LPTro+R3aqa
 CpyMNDw0hSpmbrdWlm2GUTZL1B/6w3DVv3DCk+M2udiDteFSWADKNx42Zg4YxXTzJ6gR
 kldg==
X-Gm-Message-State: AFq9FYJoR95PWyhKWXXvaWAxNhLGZ8MvMgqQE0B94NXvYcwwhuBpSEsP
 e/vycPNLStX+nVkrelPznLioMZuHXHpewNGLg15jq/Oiyglr5iLf8yUx
X-Gm-Gg: AYBFou158P9zr0VK5RZXD7o/9eRfN7A8dcbvjsLluzVmkA4UcPyy82W/WAhghHlEY88
 VMumL1G2RLL0aCo1v2HPOyjNtQn/u8BUhuPDDQIrF4bjmJb+z5n1udNj6/kwiqXvXRxngre6szW
 +8tea3w16BAnWh4q6uKkVCFPR4bDKLCjQ8akn/UkbwgQLEXd88sCQQuHDQptEvHTf0OHLeqhhu9
 WpBKKaIbNXLQGxW5BRO3M5dSRo2ESydbRbUxrqkzIl+YhKDpGm/rtPfaSi19YzcSX23v0UqDl6t
 W3N7HHVuPAMVhnXGlG+LwZkkzgqoH9DmLE2bAAlzvLY05VYb9WqHMRd/0MPOXKLvJ+/HOOhh+1+
 80wTCzDbpmamEumg2ArMCgcGNP/0THmSLuuzcNU4E27sy0YH+c4PXW1YGwglToY9505B4qLZok1
 vIJE2ZJp/o6dcxRiIXgiYO5TUEr6vcl1wTJIGSmk/h6MCr8CazzL/ijBFWPjdILvvhWpkvgPyk4
 Ze8j2EJjLiHGL1dFYGCt8TeGYTwPxVWe6a4x3brzJHREi00946jleK1LVCsbmr4lcEw8Zh/gGAB
 l3KgIMvByCcrnVwX9/bAFsa3upQkOurL5VYC3jStwrp57Gn3AEWL
X-Received: by 2002:a05:600c:524c:b0:4a1:e6c5:e44c with SMTP id
 5b1f17b1804b1-4ac17470f97mr158613495e9.10.1793516564747; 
 Sun, 01 Nov 2026 00:02:44 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b81c74sm12162795f8f.36.2026.11.01.00.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 00:02:44 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 10/14] disk: part_dos: Walk the extended partition tables
 in a bounded loop
Date: Sun, 01 Nov 2026 07:02:43 +0000
Message-ID: <dad71a7c-5d81-4699-8ca8-571efbc4e8c2@gmail.com>
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
