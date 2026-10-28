Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B3B606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mQOMSLxD;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VVkVQJ78
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D89380DEA;
	Wed, 28 Oct 2026 05:51:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9AHTB9d3dG39; Wed, 28 Oct 2026 05:51:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 499AE80DE2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166675;
	b=qAc3v3oq5YiLiFRriKeL9u3yQo6+D4QI9uNyrHuvmG1ZmO2Pz5D5yEuhWJ4kjBqtE/sN
	 xwZ810q0CzXp/oOsOjyqbMC/tE32011g8O9LFcnROfzHgOdvj0qlHfP8POcbh2YF38Hhx
	 rAUg2+yhZz9uBy011tmCgNH+YP683lFub9/+QEpIWlOnx53Fg0AOei4sGwqUfi9/gfv8K
	 SilUqsbsQyuaR6FbCP4p0G59wt4lqV6iyMa2sWyX+MwzOTGjamlYXQg38ItkC7HQ/oLFf
	 WWaDY1ghLgtDAZMJjg2NnkizoChoLiq0iv3gpjACCQyS6/7J4KuI+g5yZnqn+eIpBPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166675;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fdbJe9zhToHKQ1oNxKm9Z0yncffPq+u+AsFuKPhZ6Zk=;
	b=fDLGFV5b4aBOFtWXIEwtExtwLvS9RekSIBcFtXpwg3kqrWLMnrtPpQHzKXOGso5Tgtgi
	 8n9yCdvZyu/EaHOcYgMPpsvczR68GbcBxQH4D0rgO8uiIupZFDL6MnYcAPLhCjYoGoBHM
	 rgQNfBFdFnIYPPg6pwHl6ifmLMzW7rK0PBh4tuuPA2RPYLCCaWqF21+lbX1HPweCjgLMQ
	 jpRJaf63/e/hx3iXH3jV4X4QPeDoottVP3domVONIECJd10XDvjPcax26wdYRxur5UhiL
	 jTN/SYn6gD0lBsqIVhczZ5CkMbWq3O0SuyY8O8TRImDOcRwEXB+oHLK2sEJDpev2/cg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166675;
	bh=fdbJe9zhToHKQ1oNxKm9Z0yncffPq+u+AsFuKPhZ6Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mQOMSLxDiVBEU4UGdZDjG5dq4U4Mare2sIMDd9240XD3u4FvtZYko7W4qs6GjI+FD
	 PALVKFH7tP1zFfmoulBRDF5kVM18+VXE9EJseAO9H/wLD+2Den74WCmtyPyEkRfMkU
	 6B6aC3t8vymt1lVLd7Ksu4eAlcTOVV+pTLgwUDwoCfqbxO7gRVq/W+mGcwAJBtdvbD
	 XqMps7LSjhVXfCjcNT4sIr+7GMutYcJsdsC7BQ72sogPfLMEFd3Mv4xcNMQrf6dmgY
	 vxKPaR9A/qR9rUv08FItG+FOl7k6/SRau0FmTvqFhgkNtIalO+sA5f5cAezLX3tEVf
	 +eDTTx+Tgurvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 499AE80DE2;
	Wed, 28 Oct 2026 05:51:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 17072473
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F0CB7401BE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LAKaN3JbBs4S for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org ED0094006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166670;
 b=VYIpOyI9Oa7Sbk6g/1hWANtlS0CrhXMAOq2Mnd5+TzrFfl7CLwQe6rfdKjn4bRVJ/kv9
 LjGj+ivw73viM4V3gwThOyQKmV1bk5AgjSFf6w0C4efCAFNPKSeErtw5e7j3RoXnSJYkk
 z2l/aLv9y54wMBRVE8jawvCOfsejqskQ5LIHO0thYjhfLeyxy4/SnMQvr+Wy8ciFDadgE
 57qBR0i1Ogtx2KWCCCT9/4ECz1ov3S9LuCnfF0X+mDehqEGcQbUgeqq4HgXqJtxQZVnyz
 iBd/4oHeoDmtbukHlyzawkimArWyv1X7djnlZU4/XjyxXzmyhrvJKuju1BKA0l/VqWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166670;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=fdbJe9zhToHKQ1oNxKm9Z0yncffPq+u+AsFuKPhZ6Zk=;
 b=Zrwr9bQDl+wv3WhePzrm5sYshk3h/ErvN+wMEAqsUpZhSpZwz3JUOTM+OkxabMmIuer6
 Vx/VEtEumGGDfYrpIuwlmfRW9esJCKoSL+EazeEOQq9CT4gybuD102HNPasUoCgHIPe1f
 6Tg0T2Zp/K7aLGI5Ng6/i75GV37Lvtz+wbM34RxvtrXlw24SVJX8SohCb3MjQrJI4XCZu
 wucDZYkuqnLDTS+Cz80RKKdMfy6G/lheRYnwwkSI+qB6aS84NGQc3EUznB8rJePjZLUJf
 XDXkMxBbD4sqW2ilEqiLdrGZ5iXlqnDpnKmcxHNXwMNesZfGGLIn+kajwoWuGF1+cXw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=VVkVQJ78; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=VVkVQJ78
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED0094006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:09 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so5351345e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166668; x=1793771468;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fdbJe9zhToHKQ1oNxKm9Z0yncffPq+u+AsFuKPhZ6Zk=;
 b=VVkVQJ78/9KM97mUyW/CmIHkxcaZsi4yX8mFe8Uue+3+9GIT7YbJUWvHQaCzEhFMdw
 b3ZjIkNFrIuiHwc6lAA+ln9gGBA+RLulcW/4vAVKjQr/rsXMVRSGGwNcuSZ2goBr+2y9
 Yjje25ecucBuc6XH4L/U9HmVpigvmZywiCBmlfkISurzbP6E8UaWXf7LxjCuQKvYFHq5
 tNyviTZAYBIw/rFwoGT4fII/xzB6F629uTK0SKJA9NMBLhcLYcFzr3mOoiOMUuMK5LWm
 xAVxWGGKElRrA2IhnAUH2Bfhrk0ybQrIpJHDAgxbyYFGvkHRCt4ALUsduPp4RotuMlei
 ei/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166668; x=1793771468;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fdbJe9zhToHKQ1oNxKm9Z0yncffPq+u+AsFuKPhZ6Zk=;
 b=zBg0N2r4tR8GNBcOZHMr+8tV6AipahzJDm4R0NxILmlOu2r6iERp5VR/VTAfUu2eAg
 KvBnHjalA1JTrOdpaewKIHI8A8XLSmpw0HKgJTEa0uYCzQky7lgye+amwk/euR1gfOKM
 Q2P9DCOxkMUgwSGk4ruOUxH5LOizNmDk0O6iKqEMVzn1N0ahDG+4Jqeq791rVi8Do0vY
 4WLDs4Un5G/JGFY2svCxvr9CRNom7EoPlbSwwMCcQm6pHZA/VIbhhKXHQvEy1Oc+XTQR
 oCjmk/QWPJCrFZIJiSnDBHIpustMQFq+9vvF2lJQ+KEENUtuecj2TB9ixP7eGefmWahh
 81CQ==
X-Gm-Message-State: AFq9FYK0olH+aD3gNTvzWRwikziUhETGKVx453TiBpaWc5X9wP6w3EPc
 UbaHWLrZOyTV1z2K2CskSZe65SbwmexAKu/7cAV9+XaOFvW9s+vRTNZa
X-Gm-Gg: AYBFou0p5ejxBA0c5TkmcV9cgX5trPF+7yte2LKzN3GCvEzC/1Mr5XyD4u/wS2mjrre
 3tllPru1f7ITZf9llDjclNQrgR1XPoABBRW5TZIcbjA1+eSUElrFd3J0ixQkZJJKK1SmX8m5hM+
 WdLwvhjqk0C93M2+B1LbbjFhmHlYIlqlhoM1xgOpFKqC9Cdpp3ndYCw6OGToI6wTswkWcQU1BRZ
 OnFqITilUiT9pt1EKy9YcRe/QXDxo5wBsLuC5Ht5EGCj+VM+lbfmqQA3Gj57Y5txamatOGUeKvg
 1gbE46RD0eT9mIeXbjJT5l3+cLm7dR7Ebxg0nh/scI/gm4bdA71hsixtHsYWQ0cgwc6nGo4245m
 5/jgUXC9X6p+HrV7Y/gkhlCdH1Uj0iJuLB337/L0murcn8Go4qr6eJv+3bO7EMmpnQ0QYmQ9puE
 B6ABajeAUMUpZuunN1kh0Hq96eHrNHSJo9LEHantjfNGR+3ZyfQifc1ZaOXXqN1keQyHQTKpsfy
 vmIrsBQSkTnWW8YQAZsB+Z1ra/eO1asvsxne9R4yz01kSpVqrB+7wPLIGu1M2jLeO84N9oc6eYH
 /tiHLldL+7kIJD7lVHR6PyDMzeEV39R/Im7106KN30vDLLS+UVu6
X-Received: by 2002:a05:6000:420d:b0:48e:2948:6fe3 with SMTP id
 ffacd0b85a97d-48e5d2f9907mr3734858f8f.39.1793166667469; 
 Tue, 27 Oct 2026 22:51:07 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e412cc164sm24838750f8f.7.2026.10.27.22.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:51:07 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 02/12] block: Add blk_valid_blksz() to check a block size
Date: Wed, 28 Oct 2026 05:51:06 +0000
Message-ID: <6043b488-de34-4505-8951-74f58cadc062@gmail.com>
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
---
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
index 404d9140cb2..ddc42a8543b 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -263,7 +263,7 @@ static int virtio_blk_probe(struct udevice *dev)
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
