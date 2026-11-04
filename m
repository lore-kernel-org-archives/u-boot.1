Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD70606A33C
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a/VYHtJa;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PLu/eJNX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 997D980CA6;
	Wed,  4 Nov 2026 12:50:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QmBlihw-5XEh; Wed,  4 Nov 2026 12:50:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C72F380D66
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793796642;
	b=j34Ahkqj6F5YJbiiaqKWWVULq5wNe4qvcqmvLDXbgGmL0/bRTqHI+uFTedRzk93Li+hm
	 O89vk1abu2I4vck8ANFCLwIqOxe7KPS5aNjswnl3kbEQiy5jk/iBTXfjX1fYrO9Cl8qwf
	 buiwzDLjpF16RerLAVOg4P1gYMEGYXZSx/uOmm08tt2hLvNCg7oLGGaCBd+RARqsjkueI
	 nAtgqzkNjjQzDlXkb1w9lEdXf//U//hei7RsGVCC8vSKMZxbB6LMk0+anj6i7MyQAXDWr
	 cutezD9aoAscSYbTeyAeCG0bMmOWrj1IP7o0RPLREpEFWfrmfT/lKGYGDWcAx6Ft9jA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796642;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zi7GfIeLNnW6vD3KW2mtZtE78zBVih0F6mWWKOZiQIA=;
	b=lF/752aZfPyzqUFufEhzBqovx/7nRRihX1cEWMuk5uO43hwXAm1JxDFLSSgfj760PZaX
	 u0A+H0cPodfZ+LKTxR7GbUx59TtjQC1smrlmmUyPQRI0f1wZgfVRQ8cdZJ1dV2hnwMl1T
	 oseibsW7n7lQH6s6TcuTjsNGMAPnOVwIZ1Yfn4l1vEET1qEjylQ+OdyABMx+UcI0bd59x
	 F+5+DnASvOq6PgeCB8KqomrPcTrQg4z3iD3yXFqTbCVhgxF6wc9X44WLIxWKucFfz1++f
	 Axipdz5wR//n0Ga4pP1Plos3gHB9Us/Zx+LucuRUSl80aCuuvBsrxkYgtTkeepj8Vhw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793796641;
	bh=zi7GfIeLNnW6vD3KW2mtZtE78zBVih0F6mWWKOZiQIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a/VYHtJacsLOj2RfbwbouMueH5O0BWz0LAB06cuqpq63/Yx9cyb0JMF+xfeVn/YD/
	 Z2u4DonoP4e1L7M84/vlguMXQtII33d+Hv9oNojxGSA+uAGKJ72SYc0PgAWR7FhwHH
	 gvMx/YzZnP1AhfO3b+WF1QMDWpTpylY1Jl5aB/Ur0SrQIFtUVJhdJZdW/6rJUoc+7a
	 NJwf5lLK9UZ59QJEKhvTjYBTIMYqpwOyz0ChE2/SWzm0WkAAFTMYS6/IM7ZsW/wUwT
	 6tlaRKYGg+B+F833Fim6Q+GG+uLV9kNhzZnnTt3UywqdL7180S3JKkITl5+wreVjCo
	 EQsBEt7/H93qQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C72F380D66;
	Wed,  4 Nov 2026 12:50:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 96CAC34D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 948AA400B0
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TYDBUqX3hSG8 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:50:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9F80B40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793796640;
 b=j6gD9FK7ncP47F6T6rqrvGpF20OHWcWsfocF7wqic63toI2K+L5lYGmX5uHwu1nYSjnb
 E5gSeAAqKjjHoB29EWxKgkvyJhkLYVQ7HXDhRPXBdlmGJOoitLuniZi0bYN+otZQIPwKd
 OQlEShYVssczclgWJH0AzKt5a9LScgB6fKCQnONwliCCLyctZ2IvbAiny/ppBrzx0cpg+
 vVioc+MLHHHGel89NQzLQhD4K5r2lkebM4n+JBszN1YyJ4JIgJZuU20L+MuCx3DUr+Zs7
 dXe3mrKI3nBsl+XauBGs0vq3lqkdiddoNCVYluxCD4z5DY0MVZx64SSYMXOnT4Tm3pw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793796640;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=zi7GfIeLNnW6vD3KW2mtZtE78zBVih0F6mWWKOZiQIA=;
 b=nfm7DMjrUvmEf1/JjU0aDWj0XhVwrqapErzSW8lS7f72urXTs1Fd/prw3s3YQ3zeo8Ba
 TaZetEkUbKxwzuRXX4G0GZ3ybWa8BpNiS+89ZbhCDIIClEaNdpsAam5Yhx8AUHFLb6+bX
 bT03iK91mJOlpV5p/yOgqRqNFE/8c0EFIcrbmcSiYGh7pUxuIn7z+SY6e5SWt4IuQItfo
 vueFnNgWfwJfte5UQxs1pldJ0nBrd7JoO4txfq/Wao1xzSM29y8N/zcupb22bjgc8h1uX
 MtXsPLRiN2LFzENzPZkEZ6IlJX2j1a9qFlsWNtgkFU8vafCiGfQrgWxbrDqViAL+rrQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="PLu/eJNX"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=PLu/eJNX
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F80B40068
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:39 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b47c1a3c74so780357a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 04:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793796637; x=1794401437;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zi7GfIeLNnW6vD3KW2mtZtE78zBVih0F6mWWKOZiQIA=;
 b=PLu/eJNX4/QH9534Xrn4ayHR06Gk7X7tn9qiP5P+vFpozXrmxvjUUdFDeJLY2rIHNH
 lGqo6Dg8bOnEA+withU2+c05fzd4fGOPF31tr791VF5o9hUWTib0aFK83lV8h/w9D7rX
 zf91Ltay8NWG0s+QxLXxSrt1o/y01UYjblZPWCstAVzL9oduTtKMueZuHKynTj8WDAr/
 WstUWvPs5joD+TBCGlKPEcv14Hr1eKs29z9Y6mwYRDCloFnAz5pJQrQKF8WLjWk9uhIe
 q51dQGhMZAZkx0byi7NkCKMUgFZzT0+vSxrpWPzrqzmei0RiN3lTTRog885BVhiDDuiP
 D/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796637; x=1794401437;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zi7GfIeLNnW6vD3KW2mtZtE78zBVih0F6mWWKOZiQIA=;
 b=OsRvBD77SN5kMAFuK+ShL1Szy0Kvws94pxImGXO+LAzoTOl7jxsT0Of83mivXS5N2e
 9HrTiV80e1j+Qd1RRlK0jWSiHRBIWIYdKfx+ROd2qvrTCd+kpx1skzbTYrmFUjsJi9Na
 Rn628SXScBvqhAFz2l8X1V5gyYA0tNcVwGNfS9PIge1MKLMDA6aCPT+WB8lWohMmIWhy
 8ANrDzKLli3GeaZ/J/g98oTSLGCRtO+89452oF3lq2CCPY2jHBv5RC3bi8MObFwioIWs
 gUQycsL++2gAjkHb9Yz5KDTdrKWsNqNJYpFvUpj2nMmnRTEan5TbSGEa4N2sk7hQiFw8
 0xvg==
X-Gm-Message-State: APuU4Z8B9OVr5NJBRcLEXhwdfuGY53Kx58uacUhFriqQs6d+W7I5lkT8
 0TXPbLSLECxR93t8iaDbwfHpwjSRF0vceFxoasnY7ivrZi1gsNzslHbL
X-Gm-Gg: AYBFou0xSVqExHjfe0aXOIQpBgrBW/P1qtQJbFeHtj21rZuaujopTdf0IU5W7r5Z8fZ
 QKYzROEViamyhxOgR8mvfYORXESFHdDciLK3vz5TyGk+ypBCEOCr8gLCa0EeeiUOTqRFJsVlrTZ
 eUZJ6XIBKjQk8XfBVri0rIzbI6yRKfm5TPrSxngz2jJsJTsL9szBEUfiMhy5RiGgr014x+bWLdM
 dlOhcMsVZEA+c4E/Kl17Q2z3xBQyY4SLgBOolr5avMLDpSVYLYa+4gD/4QcYUHe8vHxgmmKmUuy
 cS9CFxi7LUXnQbSViOs36JEPpYDYSOpS0iuI+vcjgCpOQtknZNFD773WMH+tTd9F/AdCS/fGnrH
 vNaRo1Zbk7WhP9NNBPLAWUXaE6b3yJGfMB7FUWTSDWMNdd2goSA2lmGQzcRPT6yrGjmgHt3y6Bi
 +HwQvMRSzMsItBT8wZV8OGiPxWN5pr7ESIFSj15yMBnupBnt5DXWJ+6QzsjodKeiNZj+FsIzct9
 Vii160gJbHO0WClpampJlCbtf2djnYZlaU9CKo7tupa6l1Ue/l5XGnGPvNiVgZ3Mmu6lBTTI1Yd
 CQuuQLW1L0OUNhSCTl4teCQlsVNvvjs2Dg9N0RYgF9offqJIwDRN
X-Received: by 2002:a05:6402:4006:b0:6b5:709e:2196 with SMTP id
 4fb4d7f45d1cf-6b5709e2891mr216048a12.40.1793796637360; 
 Wed, 04 Nov 2026 04:50:37 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b55abd3da7sm756439a12.1.2026.11.04.04.50.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 04:50:36 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 02/14] block: Add blk_valid_blksz() to check a block size
Date: Wed, 04 Nov 2026 12:50:35 +0000
Message-ID: <38bbb35a-da18-47b5-aa4c-40f2f57387ec@gmail.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

A block driver sets blksz and log2blksz from what the device reports: the
READ CAPACITY reply of a USB stick or a SCSI disk, the LBA format of an
NVMe namespace, the sector size of a Xen backend. Apart from the virtio
block driver and the host command, none of these drivers checks the
value, yet the partition and filesystem code relies on it:

- part_get_info_extended() and print_partition_extended() read one block
  into a buffer of blksz bytes and parse the partition table at offset
  0x1be, past the end of a block smaller than 512 bytes
- fs_devread() converts bytes to blocks with shifts by log2blksz, masks
  by blksz - 1 and divisions by blksz, which only agree when blksz is a
  power of two; with any other value it reads more bytes into the
  caller's buffer than the caller asked for
- buffers of blksz bytes go on the stack, so a block size in the
  gigabytes overruns it

Add blk_valid_blksz(), which accepts a power of two from 512 bytes up to
BLK_MAX_BLKSZ (64KiB, the largest logical block size Linux accepts), so
that the block drivers can check what their devices report. Use it in
the virtio block driver and the host command, which then also refuse a
block size above 64KiB.

The next patches check the block size in the USB storage, SCSI, IDE and
NVMe drivers, and the last one in blk_post_probe() for every block
device.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v2)

Changes in v2:
- Split out of v1 patch 1: the helper comes first, and blk_post_probe()
  checks the block size only at the end of the series (Simon)
- Use is_power_of_2() and leave the linux/log2.h includes alone (Simon)

 cmd/host.c                  |  5 +++--
 drivers/virtio/virtio_blk.c |  2 +-
 include/blk.h               | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/cmd/host.c b/cmd/host.c
index 51f2b1e3f6e..7a94ea1fa27 100644
--- a/cmd/host.c
+++ b/cmd/host.c
@@ -67,8 +67,9 @@ static int do_host_bind(struct cmd_tbl *cmdtp, int flag, int argc,
 	file = argv[1];
 	if (argc > 2) {
 		blksz = dectoul(argv[2], NULL);
-		if (blksz < DEFAULT_BLKSZ || !is_power_of_2(blksz)) {
-			printf("blksz must be >= 512 and power of 2\n");
+		if (!blk_valid_blksz(blksz)) {
+			printf("blksz must be a power of 2 from %d to %d\n",
+			       DEFAULT_BLKSZ, BLK_MAX_BLKSZ);
 			return CMD_RET_FAILURE;
 		}
 	}
diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index 3d5d29f00df..8587605d100 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -258,7 +258,7 @@ static int virtio_blk_probe(struct udevice *dev)
 	if (virtio_has_feature(dev, VIRTIO_BLK_F_BLK_SIZE)) {
 		virtio_cread(dev, struct virtio_blk_config, blk_size, &blk_size);
 		desc->blksz = blk_size;
-		if (!is_power_of_2(blk_size) || desc->blksz < 512)
+		if (!blk_valid_blksz(blk_size))
 			return -EIO;
 	} else {
 		desc->blksz = 512;
diff --git a/include/blk.h b/include/blk.h
index 5ef9129b3e6..07e0448f65e 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -10,6 +10,8 @@
 #include <bouncebuf.h>
 #include <dm/uclass-id.h>
 #include <efi.h>
+#include <linux/log2.h>
+#include <linux/sizes.h>
 
 #ifdef CONFIG_SYS_64BIT_LBA
 typedef uint64_t lbaint_t;
@@ -22,9 +24,28 @@ typedef ulong lbaint_t;
 #define LBAFU "%" LBAFlength "u"
 
 #define DEFAULT_BLKSZ		512
+/* Largest block size supported, as in Linux */
+#define BLK_MAX_BLKSZ		SZ_64K
 
 struct udevice;
 
+/**
+ * blk_valid_blksz() - Check that a block size is supported
+ *
+ * The block, partition and filesystem code size buffers by the block size,
+ * expect a block to hold at least a 512-byte boot sector and convert between
+ * bytes and blocks with log2(block size), so a device is only usable with a
+ * block size that is a power of two from DEFAULT_BLKSZ to BLK_MAX_BLKSZ.
+ *
+ * @blksz: Block size in bytes
+ * Return: true if @blksz is supported, false if not
+ */
+static inline bool blk_valid_blksz(unsigned long blksz)
+{
+	return blksz >= DEFAULT_BLKSZ && blksz <= BLK_MAX_BLKSZ &&
+	       is_power_of_2(blksz);
+}
+
 static inline bool blk_enabled(void)
 {
 	return CONFIG_IS_ENABLED(BLK) || IS_ENABLED(CONFIG_SPL_LEGACY_BLOCK);
