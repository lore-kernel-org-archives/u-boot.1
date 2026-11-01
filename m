Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF48606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=El2EK5UF;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s9Xnu17a
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5974C60748;
	Sun,  1 Nov 2026 07:01:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8PjRJY8vnXl8; Sun,  1 Nov 2026 07:01:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 823FB607D1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793516511;
	b=Qz/AGDBOabKi1C7GFRI0zA0YSJGZkzrQ7JWzFAPdOyZRcyxnB7/a8p2jF4GpVdvSYFyV
	 X5RnYS9lCDnVshIZjO8SlPtfmwap/typp8zYpSD9J5Lld/Ypttj72pwsgMtdsgqfftUeJ
	 dqnMcq22puOsv2WnU3Wp+p9mE8RZltRKHl99IQn+r6SOoQdOsKYjsY2fwH0ksbmvjOXXv
	 OCZjfRQH8GFSuK2FG2uO6EV+aMbvH3+GdtBIbs3K2pGw7CLxeoC/uuu0Zx6A7WOMkPznr
	 cYl9RElZIWSvqnhOXb3FeY4jfQ4z0TGjBMP+MQwmn7AgMoHbPY2qdowA0oOf5c1G2vg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793516511;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zi7GfIeLNnW6vD3KW2mtZtE78zBVih0F6mWWKOZiQIA=;
	b=Kf4G5xct2PinFs17o2p9vAhbNlJ8jpzxfIX50RoipfH+aMwZj6WAi6JaeGrNOk3xfYUx
	 MBsFQ8QYqpJBAREP54gRCTnWpXqfvjENioJm1ivkujmdBcCmvpy8HWkf05dBNZLA5WFIE
	 5eutlYNZxqHbW01D7Ls8GQlQZvCMFoaroHceiFY6+OFTlAPUHsxBQK29F0jdWojUJW3AZ
	 PRZd7x7tg3/fCq0dTNW2kc4GtovCa4sIVBmZ1Z40A//pWvXzjokq3Mo6XvjzNW6nf4nai
	 8ozsaOzE/BXj0aMMvFqtYSyEMrEXOvwsw+GXwPwEx6ZN5n9lfwVA2GKgDmwTyNluybA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793516511;
	bh=zi7GfIeLNnW6vD3KW2mtZtE78zBVih0F6mWWKOZiQIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=El2EK5UFTWsyl7uWHmxtZy31JydkAnY3wWrtEy4pCOcaizlyDbYup6wkdSS6FNCzS
	 5UMGycs8FP8CGthGqRqs0/SWOTUpCTmBRwVZQj5IhvlTMX2NSyLWRcqOPKhK6NBrVf
	 PMnhy4dDWEjxGoBSHXRhTPShr93EBuOqqI0iErEpQA45LanZZiceLahZKu+KmLF3co
	 gSPpkV885w4AeUYq6QFDQ5IRIgoInFSGhb9hlNkD64/kDReNWSACzmR4n/bvC7Vem9
	 ErqbRfED0Y3/s9q3q8NDzqSYhr2Wn0+SBY18YseaerR0q83egnuDcQK3nSeqhg5S5a
	 RThQhuFON2Bzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 823FB607D1;
	Sun,  1 Nov 2026 07:01:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A8A314E0
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E9FF810E0
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:01:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0fUNKEKLF663 for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:01:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 82A3780EBA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793516510;
 b=gcP/X06nFtniyaOmHF7I8MPg5eJapbE5wQ9NqbatGA/9QEiXhQGDrxKJ6CZsX2egX2F4
 wE0HkbA2rKH21WNtRNw+CYPXb+D1mXqWc7GCc+DTHppNNReJMBRrzw6bqb9wRiCsx+Um5
 fnW7JCzOVE041OgHQPfGmKti4u7F6AjwtpRiu3q6mrK+W9Ps9DhjBNzVchCSlUbpo1OJQ
 vQUas6t5YKRn2ToecWtA18Cx61C6STiPIFSU1eQ3KxHL2ldlvmCV7qd8wUQdPB6F6b+yX
 7X/z4lR70BE+Ll0BrU73YAinSFHijQnnBerTJi9cKk2YqF/H2zgBTBcCxW6vZZKDmog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793516510;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=zi7GfIeLNnW6vD3KW2mtZtE78zBVih0F6mWWKOZiQIA=;
 b=OS1HlwIc3yjNhF6zAi70M9MNyZ4J+0biTPXLl5tlvEmRgYTQiwzfAPp3HtJKhMYg0uZj
 fRZCkH9akORDwR4FENfydGQtTxoZg/tMBmgeOQz2MoQU4Hsng24YgeHcbglhA9wxHSMte
 xheJ1OeBNbfzVRb1YR3KZ9ulEA72bZebDYozgu5Y/yPUq4QLwJ0LwzF7znuX2OoJ8uZjA
 +GjZJUxL2JkI9O4wf+DrqN9JiEyeTXSymnOP0atmKdrllRuLVBxk1H+Xfaan93kHQ6Jru
 lAqfveRarb6znQzTQoeQH2dd11gnDK1/Fijj5geYbyGXIyxoJA9sF9Cm11lcf8YhqRQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=s9Xnu17a; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=s9Xnu17a
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 82A3780EBA
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:01:48 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48e20edd106so1558994f8f.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 00:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793516506; x=1794121306;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zi7GfIeLNnW6vD3KW2mtZtE78zBVih0F6mWWKOZiQIA=;
 b=s9Xnu17amBhqEg0i9YDQfoOlPt2DTTN9ZRPaMi9zA9OviaihCLoVcUrku9IO1LAONL
 Qi62d6H6OldClylR4fNdkS3ETsXJe8nYLrbF6cKFAUVN6PoMkZpPudHTAR2R3aQuShWc
 DwAsVRz0BfqVfy4H/EUrcVlw+9mmxRcY5C7orv5WIerp0pK73R/+OPQ4WVutibQTskta
 3BZSrgRbo43oVm87s5iBs/qkw19JrS6pSwLdYC14UhagQh/ERx4tbrWd+ft9jui2qKkF
 Ao2Y92LypgFIwqAgSx2PpWbZFe8Nnj2FIW+rqImWgXDy7hcZBJq3MOZx5gPobQ0pyT/L
 2Z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793516506; x=1794121306;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zi7GfIeLNnW6vD3KW2mtZtE78zBVih0F6mWWKOZiQIA=;
 b=hOA+ahfwERTqoA+WmRgX/6T4sA1xqOnJjrv6GtfeiE+yjLZwBf2jRcCULCoV36uMOP
 Zjj95+cIkXv61BbgEE1jGqXcpEPlFjdFZ63/IvfMLvPwrZZVdtYcscChf8GDmJra9zJs
 4P5beOPa9fuz2GuEr4q6QEWauYYpsVxT4zthAvatknQmCMIQ/an5EHyvZqGE/7ERuadN
 Lob30DGA1fXw85YmhHWf1jtYYfn6VS++KZ689TZGWeElhfp20uWUtWIdcsrFJYcJoRNr
 5Em4i9HnxzOVZ6iMV2H0ByD0AbnS59zwEimUnfl9FVSoHP7HjsDl8HHbmTKlQsj3PMK4
 pw4w==
X-Gm-Message-State: APuU4Z/XQcQ8yo4eg53dwXmYAnteQwtJf77kB7Uc0oM5b86TvQ5dOKXX
 A7K0AlRGv1gHoZM7VlAbnearylOOqBxhO/nbPnsnYxjtwuWlifPNCEs5
X-Gm-Gg: AYBFou2PtqbpE+jQ0cnnMj5E638/nLegwQaOZ4xdsrraaZlh0BaD4yLYlvlTsx5KX/j
 jvPAXATvO6qdkNHGOppqVqAypZJSvkUDbePUc83RG/PocKY0+z59kaaTGKYFTXn8sBZa1c0lisQ
 m5tiCFGun07vItjxouZgEF7WXKQhkkLFm436T6y/ufXxTeGI1SU/XWklMLjKOyFYT0zXwuhYWKZ
 sh7WgHkEv7GoNToxL6vBds/d5gS1rx7I58+z5zxYaT4igJcPxVwxH5ZnEIQ2N03ZndZ1F6x9zGI
 YIzj9DIrF0qj08xvpSudn0mGO21gaTve/Y5qGsZOeE3IAVz1h/jWsVTJN9bINLlWfNpWArfYqSY
 auykAuHHfPOR2gSHtGA9Rkbwh9nn7I1yl3aUCMmAnoZQabJone3wXcX8wCQ4U5go72Kc0lNegDW
 WbocySXrMQNeU4bYgWoHGOJ0l2nQ103s2TZ+BSdJy2+Fy/30zI19uTytvWeW5n1unlgsnDW9H/n
 Fnl9RwASRe6Wi20iy+lmbm8kM1BFMOV0dmTuZKcn9wxDraPVBCjZD2S4R2acNqrek7JQDhePwvS
 xFgai4MgKZWBXT4aluafMaUBMJrSevs=
X-Received: by 2002:a05:6000:4710:b0:48e:eb5:4976 with SMTP id
 ffacd0b85a97d-48e6e306dedmr14680151f8f.53.1793516505939; 
 Sun, 01 Nov 2026 00:01:45 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b81c74sm12158739f8f.36.2026.11.01.00.01.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 00:01:45 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 02/14] block: Add blk_valid_blksz() to check a block size
Date: Sun, 01 Nov 2026 07:01:44 +0000
Message-ID: <2c0dcc87-63ee-469d-89bc-fcc34acac819@gmail.com>
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
