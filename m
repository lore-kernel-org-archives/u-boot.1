Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C5A606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W1VTqDr1;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gsOjTa9U
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 014526078D;
	Sun,  1 Nov 2026 07:02:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QzUOXBA8Mu19; Sun,  1 Nov 2026 07:02:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 33C7D607B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793516557;
	b=R+jUKwZZF8JP57aup9tHmPXTWUsnupKuXItY/zZQQRhGDpT9kqyKvRdLMSZ/mltJJG81
	 sN2wOBrReRjyKXWWMpTC6s+QhFJuUDULUn0BjhBliSx805pkS0d++LG5kJ5TDI986xzyy
	 iRb6a2ojCS2wtZ/05nOlP3KM33yWZrM0WntduI2bxAN6cn+IcSP98np4R98ApQhQzZu5K
	 v7pxKgTfGhGxVFM1Zb1BM+mUbEovaIsScCWkQEMqPQq7ChGJJHQpL3t7ixDqg629BsHxq
	 26HxsEvlTjau3iIALFBD+84igu36rBH/Q1rLYU00VKzzK0avPVZIlzKgtyR2T3HlavA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793516557;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cwR/r6GVJ0RAZxzh7WcfYqG4+INLg0T4fvAzAV0UpXE=;
	b=d97MD7WHTzTShKSDgRfMniuyxV5F+//B3TmOORVbJFLcfyADrwOadbg8OmrXvFxMfyO8
	 d2bv6xQeItPIMqHkyWNriWTj2o1DeXbUAZsgXfDoxZ9IgYPhEIvJTgL48gcKfMDG230iY
	 Cy5bXzSzbw5oCUiJAlPnDFRfkh0PWW3tbvz8JBf1mXUCAABw3wDIy3TlS+aNCUrBzVn6x
	 fBT9CYLEwxqnrlHq5KL4nGT3zqVOP6sY6UwiVK5hyZvYtpMO7SPdFAothKXX8wGkqSMk1
	 KtzGowehRrsTuayYJgFxHCRtfdH6OlLnQAftfqp8U24NkLwWl6LCY7nqi9ta7/0PBkQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793516557;
	bh=cwR/r6GVJ0RAZxzh7WcfYqG4+INLg0T4fvAzAV0UpXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W1VTqDr1B1mTbRqImPfnfpygUPig6cWeYJip3VHGcLLdXN0RykjhyqPCJp8f0GMlm
	 PwH1Rb4Xt2oTaPpM3mnBrUVYKvl1voYI3eBk5wz11FvAx11+dykDi06hE5IlSEDlYJ
	 pO8IrrTYLD4ud8QU1yM8jV+COmykMWvZiXe4pTQJqJS9KMkFjBQaMgYn5NRNasevQi
	 jCf9suNOyy5gKtbekW/a0W6rOXJ7EqCv7LQg/f+djN7IEWcGZXPny4ga0aELFtL3wX
	 58cy8nF2m9Xn1CTPgIOD7Y//55vMrYB/XCtj8eQmvexaI5fwzzhKgnRLvkxbkkSB1W
	 8uNF+ngrjftTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33C7D607B0;
	Sun,  1 Nov 2026 07:02:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 62379D3A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 470FB80EBA
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VmbfP_IRbCXh for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:02:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4BDF681112
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793516554;
 b=jqt+EbiJZa9O2IC7l5dLQpdAqOjtCZR/XbepI5SYiyIPasja9LKv8LNuImkyPDcR3xUB
 8CkqgmqKShS/G+SxNRE5ad+p8OahxTAmtkiiu3CZ9p2LmB4x4AIyKmASxeUtBJXNvcSdt
 u4kHQJ/zqs5PNhszXqo+MYPz5ui06OhawJnDpxIO+LXTfPRgRd86LAWW8H2AweV7WWtNE
 fBbhL+2q87BuaDPBddE86ft7vKzJ63E7cJbxnUm5MjuaF7oBAtU1pwSd7RMgI2PHsxTWQ
 UvOsGAeu0UCr1m0Fgf1GP+rxBPGNV14bVvHAkilKbY6RMNrkYrj03tzi3hZXOZBHvGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793516554;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=cwR/r6GVJ0RAZxzh7WcfYqG4+INLg0T4fvAzAV0UpXE=;
 b=eERWOab4XT2O3KC6auAhfaJv6MDZDxlHI0stty8hMGjZksSVSO3+0FZz0TLcUXGaYsRC
 EQR952cHk3EHxMjlE9w4q06Fs0Y3Hp80Dyvs9C6cikKh0TUlXV+YF2/l4QgIKCdSUM2Gx
 KdgktkTJXwixhiOLaSs67VXwSl6IHHONGZ0M74cJDtMPjsm7Kg7/9KrziTkKVQ0oOJZJ0
 64UAkDwYGF5mvUNSzD8rDN0ZbJuTkgdcTkW5Ftm+GUr9n3iKU/Wajyai7Tm65u2CNsfHr
 JSmGYzNp3iDA9Ie1FVe8qZn1dqH6dVqtwBScyfu0z6DhMcpqC5M6hYO0ZR87ErpXLPg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=gsOjTa9U; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=gsOjTa9U
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4BDF681112
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:32 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so955837f8f.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 00:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793516551; x=1794121351;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cwR/r6GVJ0RAZxzh7WcfYqG4+INLg0T4fvAzAV0UpXE=;
 b=gsOjTa9UbgKEmKfXejEHT3HA02itQe740GCJ/qK1uvC+8d/yt/GvNOxeFWuUsAkXtY
 x3imGBUhl5bTXGL69eO3ObwfXGbzGKtMa9c/izjJi07P0oMucoK63mHkKNIR2bZsLS2J
 R6FTTSmhU/xCv3tgpQk6aXHNy8+rKegnN7IlIRGhf36iQ1A+BnBj/TBOqAUdjWNGnAx5
 B3/BrLErGdFF5pJPkMevzs40tpMWl7qSj0Jb+eMBHntBFhBip6Hf+zpTCrcjcytutw8d
 1Fy8F8OcE7GOv+W+J+wqWeVVF/1fogCH+SnP7263l03vtDjjjxTQ48qvsfFakREwBulj
 8+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793516551; x=1794121351;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cwR/r6GVJ0RAZxzh7WcfYqG4+INLg0T4fvAzAV0UpXE=;
 b=FLDjI8TmD/n/x7pax0CaROOjgRu0U5fjB1MmDOnKmiOWnXDSwJFOjikb975jabA4ad
 H/NojPd9JZ5puxa0b6VoxVflyjlflTEbb3bn+WUPvBQOexU5vBdaMZqluJSB8BHLkJpd
 y0KFYvkSSf3x+IrA0D5i5TZAclzj8wfhpLO9Vdfr3ZLElfd7SHhTaL3GQjIlMTiwrRM0
 9ZRemUuSK1q/UtHP00/Y7O9mlYbFA3lhQ2qJ4urVCR6Dq41bo+Cb6UFVWDHWkVpC1qZu
 AEi/V+3SFX33z7r73jNVeScmjgltG69zsiF+Z0kORhfGFw0Mg+Mm8PqXVQTzPYFyWMvN
 Znyw==
X-Gm-Message-State: APuU4Z8YuE67ysRAhyFs3nhC+dBgh8fHr+X6/xO/w4v5w6CNIiCTJk4j
 KRtzcj09As2OIHGYmhTPfCiFiPme34fyePG0wy/r9jwu1awHwdYEA9aw
X-Gm-Gg: AYBFou0Fx23M06bQ8V1Vbhp+naVztbDcG9r8zTNxR2EJ7jpmpKz2Ii2zRxnZ8ft1dMQ
 xSNoVxIj7IgAUQ+Mxw8XeKPx8IQirzjFu7YlEu4QfFs0ZJZVADa9kSqXw6kFUgCjAOKWqK6gMEu
 wM67cvM6zAmTWwpvpX81mZ6E7mzgQH750BocxU380Y4bVUH9tDpU3KRza/tXm3N/HBcy5hsrfHB
 LE5xOV4GeWx81FpJdGBG0l5yyV2sNnOqC91gYAq/Q1Og/HFa297+02j8/C5nIEtS/ljyviTjR6B
 3LImXUDdeHAbm6PXurrWebKxM6PNbs32kCC9ploM7MpqNqSBbUXMm/+RxDSuy2tUpP8j8zCFx+x
 nJKt/cNScldc+XsMWP7cWSlWPb6scQfYcppOmSDjxjs+Ngxt/2knKKXJh4nB9c8z7KoRlEDwgBV
 sX/AZayfPiYP/DyVDR+DnpQI2GCb3xVptzmWRUCW1YFOedx5IyqTFPdZ6DGE9QnW/5tf8wk6ikv
 mRBN0FhkbDFpa3wbnJBb0JNuB7aG8OyigLIaA9MBVgfg/ry6BrxP6+6M31tE4ZrND0UTTXMzwcT
 NBQXfJKyXlE1M0iawHYnAE4u4Pm3MUI=
X-Received: by 2002:a05:6000:2305:b0:48e:6c3c:c836 with SMTP id
 ffacd0b85a97d-48e6e2ff994mr16725512f8f.38.1793516550547; 
 Sun, 01 Nov 2026 00:02:30 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b9eaeesm12716959f8f.49.2026.11.01.00.02.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 00:02:29 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 08/14] block: Refuse a device with an unsupported block size
Date: Sun, 01 Nov 2026 07:02:27 +0000
Message-ID: <c17d17ca-a9db-40bc-914d-80f1a610d7aa@gmail.com>
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

blk_post_probe() scans a block device for partitions with the block size
its driver set from what the device reports, and nothing checks it in
between. The USB storage, SCSI, IDE, NVMe and virtio block drivers and the
host command now check it where they read it, but other drivers do not,
such as the Xen PV block driver, and the partition and filesystem code
relies on it, as the patch adding blk_valid_blksz() describes.

Refuse to probe a block device whose block size blk_valid_blksz()
rejects, or whose log2blksz does not match its blksz, before its
partitions are scanned. This covers every block driver in one place
when its device is probed.

The check does not depend on PARTITIONS, since the filesystem code and
raw reads rely on the block size too. It is left out of SPL and TPL,
though: there it adds some 180 bytes, which takes the SPL of imx28_btt3
and popmetal-rk3288 over their size limits, and its message needs a
putc() that the SPL of evb-rk3036 does not have. In SPL the USB storage,
SCSI, IDE, NVMe and virtio block drivers still check the block size
where they read it.

A device with neither a size nor a block size, which is how the SCSI
code leaves a removable drive without a medium, is still probed, but
outside SPL and TPL its partitions are no longer scanned: part_test_dos()
could otherwise parse 512 bytes of a zero-sized buffer.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v2)

Changes in v2:
- Split out of v1 patch 1 and moved after the driver patches, so that
  each step is bisectable (Simon)
- Leave the check out of SPL and TPL, and say why in the commit message,
  along with why it is outside the PARTITIONS condition (Simon). On the
  code size: in SPL the v1 check and its message added 184 bytes to
  imx28_btt3, taking it over its SPL size limit, and 176 bytes to
  popmetal-rk3288, over its limit too, and the SPL of evb-rk3036 no
  longer linked (its tiny printf has no putc()). With the check left
  out, the SPL of these boards is the same size as without the series

 drivers/block/blk-uclass.c | 15 ++++++++++++++
 test/dm/blk.c              | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 37d87be3a57..0c45a57f75f 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -828,6 +828,21 @@ static int part_create_block_devices(struct udevice *blk_dev)
 
 static int blk_post_probe(struct udevice *dev)
 {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
+		struct blk_desc *desc = dev_get_uclass_plat(dev);
+
+		/* A removable device without a medium has no size yet */
+		if (!desc->blksz && !desc->lba)
+			return 0;
+
+		if (!blk_valid_blksz(desc->blksz) ||
+		    desc->log2blksz != LOG2(desc->blksz)) {
+			log_err("%s: unsupported block size %lu (log2 %d)\n",
+				dev->name, desc->blksz, desc->log2blksz);
+			return -EINVAL;
+		}
+	}
+
 	if (CONFIG_IS_ENABLED(PARTITIONS) && blk_enabled()) {
 		struct blk_desc *desc = dev_get_uclass_plat(dev);
 
diff --git a/test/dm/blk.c b/test/dm/blk.c
index f67869107da..80441f723c7 100644
--- a/test/dm/blk.c
+++ b/test/dm/blk.c
@@ -9,6 +9,7 @@
 #include <sandbox_host.h>
 #include <usb.h>
 #include <asm/state.h>
+#include <dm/device-internal.h>
 #include <dm/test.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -113,6 +114,46 @@ static int dm_test_blk_find(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_blk_find, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
+/* Test that a block device with an unsupported block size is refused */
+static int dm_test_blk_blksz(struct unit_test_state *uts)
+{
+	static const ulong good[] = { DEFAULT_BLKSZ, SZ_4K, BLK_MAX_BLKSZ };
+	static const ulong bad[] = { 256, 520, 3 * DEFAULT_BLKSZ,
+				     2 * BLK_MAX_BLKSZ };
+	struct udevice *blk, *dev;
+	struct blk_desc *desc;
+	char label[10];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(good); i++) {
+		snprintf(label, sizeof(label), "good%d", i);
+		ut_assertok(host_create_device(label, false, good[i], &dev));
+		ut_assertok(blk_get_from_parent(dev, &blk));
+		desc = dev_get_uclass_plat(blk);
+		ut_asserteq(good[i], desc->blksz);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(bad); i++) {
+		snprintf(label, sizeof(label), "bad%d", i);
+		ut_assertok(host_create_device(label, false, bad[i], &dev));
+		ut_asserteq(-EINVAL, blk_get_from_parent(dev, &blk));
+	}
+
+	/* A device without a medium has no block size yet */
+	ut_assertok(host_create_device("none", false, 0, &dev));
+	ut_assertok(blk_get_from_parent(dev, &blk));
+
+	/* The block size and its log2 must agree */
+	ut_assertok(host_create_device("log2", false, DEFAULT_BLKSZ, &dev));
+	ut_assertok(blk_find_from_parent(dev, &blk));
+	desc = dev_get_uclass_plat(blk);
+	desc->log2blksz = 10;
+	ut_asserteq(-EINVAL, device_probe(blk));
+
+	return 0;
+}
+DM_TEST(dm_test_blk_blksz, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
 /* Test that block device numbering works as expected */
 static int dm_test_blk_devnum(struct unit_test_state *uts)
 {
