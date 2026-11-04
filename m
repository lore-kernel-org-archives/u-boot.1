Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F2B606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NXm1Qj9H;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TaL+Znlo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 584598108C;
	Wed,  4 Nov 2026 12:51:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mTNcW3EMvIqP; Wed,  4 Nov 2026 12:51:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 73E9980FAD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793796680;
	b=jG/5/wnJDb8LCdVs8PkjQ0egMdrz1TR4/DbC33bhHAD9FZNvbocs50Qgif04U7N9W1pC
	 NTCd7jujOQExwbtW5ZJoXanQPIm+/xkFI5EqPU+VTLWESa/KMjK+scRSCfjz8aL35Di2U
	 ZtODCO7Vy/S80DhRAFR0DnsEpBz7rADjeQ5z6YoChdVQ3BCmZkEzg3+ImkZYgUMcBYmHV
	 LCXB/71vpLIA9Pd9Uox+klZ5edUSUYhnxguUsA1RFagmaJfjJkadLqRLIfLVutvVTK9lV
	 fNKDa9crNkx50LU+hOJ46G9lYJxOVM9CKctT0LRamA5ggitsZBWyNq0Kg2TU72pbtxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796680;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cwR/r6GVJ0RAZxzh7WcfYqG4+INLg0T4fvAzAV0UpXE=;
	b=TZHuNIoNQvSEA8Y3cGOwTzor6kuekUe6mVwar8oyPeaGbtHvMXlFnR7IK9KOGUNIcz8H
	 HjDeNPuBB56ietM5rveViyvd+Vr+t9Tax5UPYKS84T84b7KfKXYZTXoa7/2V829wgnJbn
	 WpkzHK/21EeeE3eU28PwxJ6ixCVMnaCciufyK/Okvfva5U0j+GQxwInGM+31I1xAgHxeo
	 Kp20yTBJAg0rTHiEAcedPukWdX/4kADVOZ25Xvsu0BX0WSUi0vcJeM2ydIm4HFahQLk1y
	 Q9J9oLwex04gmJY60kw9nPAKmqJs5J8D9hcQ70vqcafqetOFy0KPdN6TPg/9HM7FW9w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793796680;
	bh=cwR/r6GVJ0RAZxzh7WcfYqG4+INLg0T4fvAzAV0UpXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NXm1Qj9HQyMPvNSnOuiIMEajuiMMhlADJ9/91ESdsTMnJuRfBqaK1nZCXuhN6R/j/
	 CoyKjmSWVgs8I50KAajGNbvQMUOrk6ekLYZBJ/u+xlBnefABSr/pD4YFJpPao6tBZl
	 tLxv/MUYMoam0e2lgT5uv5/23/QHGJamrfFpMc2cMulWPnoyQeVUkJ+C45c2CmBjD8
	 8n/NaALLyK5yTAMOW0GsWOpJkYcZFXAN9ByVXB2GJksdQZnKgpRBB2GEe6ryMy+vuK
	 dic+xRlfG1lwAyO90Jhr7s3kyOoQcnTK0tr+qKnEeWaGvTIO50C/ppUdgjz/qDnabg
	 8WtZbEz0FpQdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73E9980FAD;
	Wed,  4 Nov 2026 12:51:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B6FEB341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9CD0460755
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xbE0Qevz8KEm for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:51:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9498C6070E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793796678;
 b=drjJqU6Rza9YBEDOoTmfmgQDYBG8kEu1fNO1JGMo44q3HP+WUIky4XzKFMyltOyERtvb
 +6AnUtH90kP6MGZ8oaLaFvgsQBROjFQgvJ+7wO1FLU5PATuPkYiEMA5RbWmv4TrZVvShO
 odxYbTLddS+YENHL1z9NuNS4PSXscY3z48bG+NU/HSyXdMajnqH1RUGsCIqfljdQ7P2xV
 h0qIJGN/6COaoADIcss4g8+JB28Gfsxm04EFE1x4Y9vRvRPIjkZNXgojzpjJwCdbdRx/N
 nkAwIgE21ZOloA08KCx1nfj5fOUBElYWi+ctavuqZ9TWpAQRgV9NTY5BgVh/8g+PK5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793796678;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=cwR/r6GVJ0RAZxzh7WcfYqG4+INLg0T4fvAzAV0UpXE=;
 b=rViMLltqq1zAVtEVC9u+7GLJ/cAXCK/XSNnCL/qQFeYEY+faNIABJhuJY8/Y9OrK17NI
 gz0vqRwNIxuJfmMd4SzkK3pHwU22T8v+MMM+6sLTFTnMjLbBKLbgkDQEgsB3JnE12fF5a
 +KVFSeh+hl8OQHayPlQrEASttQIu5FqXjzUxcVvkq2LXSR1r/wOakNATEI/UxKEJoNvUV
 E90HfL8n0yiiaeBLdgi+OlcNmSwU6xKFXA/GHamr/qilomP+KGMAi9Qhde7bFqwsHl+im
 TamQB5vKeG7TvMV1T2LkhhrNch+2/s/o4zsJh8IZnUwqCCV8/mNcdPwvlAWKd00D7ug==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=TaL+Znlo; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=TaL+Znlo
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9498C6070E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:17 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso5924795e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 04:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793796675; x=1794401475;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cwR/r6GVJ0RAZxzh7WcfYqG4+INLg0T4fvAzAV0UpXE=;
 b=TaL+Znlopyt69eFQ9W+qdsQdL2pefiLzGIVI149CjrvJ27zdlTOyJWaiDC33BddIFN
 xarMiO5rTVftx2Lp2gzW/WjX0OKTtBg8tD01ryro+w/Tak8V7K2+m05qXiQe5CiGSA5c
 k73toUwEF3DicCyNCpmPK0Qu1fI/jgTjOr18X8EME/R6JP1MuNYAapMabE/YCrcARYw8
 sII0G5pL2K0JrRxPBBtrJfuR07n4JOvWs8Mo0Xxy2y+r3oZ6pbVGpw37BW06jRLmLbkM
 Vhrw7V5nGHKjBPI8+Tw/CV3uYrw7R7E5aXaVpi4Cn1QfS8eG5bXXzUwqpxV3TcprdQ8A
 Noww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796675; x=1794401475;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cwR/r6GVJ0RAZxzh7WcfYqG4+INLg0T4fvAzAV0UpXE=;
 b=F/tSYk2M/Zsv4ePHT3M4+soPF/Xyvhuv/pkGJQY96PfHF4faXmuqQ7b/nT3qf/u1OC
 l7XgVAdQhOI8TwecLOzT3IJIPf+2fBU7LxsFaR3yCWqE1cOC89MHzvugOa8kjpcBDO+X
 6/xPD8azdzvrJnAM4aSRxZwNkd5q4YYMAsKx7o9uNr8jp3NetFA6s3ZhdUHfXS66D/Gs
 No5uCWRA+ZLfRiPjQRN7SDQoKXJmRG8B1qZnUuCsCEraRDGzL75r02X8WqsaiEnaQMHQ
 cD0QFWN0Xd+uubGyunbvULtzclnCS25hbXIyNn8yx82PXxneXNIr/+A6sMqiNQUfu0wX
 TGDg==
X-Gm-Message-State: APuU4Z8MvWwDsVVi9DoWMjTaSgd849KkoHBAD6zKNdwZ+FLTii/txOzB
 lDSqd0uy2OVd23JmIuO0jGAAyqHnQiInIqTdmmUneZbGupOHJh/WQxlr
X-Gm-Gg: AYBFou0GldZV0sqDO2y+vhBGUvb7hRm0TniG+WtlE6vubs9Mz2+Q+7mSzzBN7fxORHY
 blcy0JMe2ROncm1JPTBd0fXyI4qtVDnc6fhoupQGS7uzn2zeP1B021ftHMvgWwV6jjH4Zrof91X
 uih0cb1zkcAoHuZZ2VWLwGBN8Sw328IL7N6/ionsRMVbXcQ2AS6pb2EqHLd1b4Wopj6X7txF4Rm
 +pa341UB7YH/x9r2yytNzRbtxDrAoUOcEvY7SySI/pHKp+GUEguGWReLHsG+/LtjFJnPXjwqrCi
 pUioaWxDIgr1xbl9dmebcyrJVeere4O6Xi93d/Ibyh/qW/jRRHzn2l0wH0EVX1Kdr0kldhQFtsC
 w6NWQO2nA12rT6KTt7fpQtIXoY9uoU1AqQWsazCpdR6fMZC9zuOsPIX/aR8Z13x9ZbBkqGyIyGy
 OpkzRB9bDlqvSc0KC851qvQ/t7g+vQIcwBr/r67MtnyM7bGVC0wkHKmp6S1CeSM79/PQoTizbWP
 brqZNF0uigQtdS7yqQ80qMelOx3L1XIn9hsl3DP69hZEkRp3LSi018IQT8EDBunLLETKbHl36CG
 ljOi71S/YdP1MJYZ0Mk+/dVulWwRoSE=
X-Received: by 2002:a05:600c:8b66:b0:4a3:5a91:5f61 with SMTP id
 5b1f17b1804b1-4ac1793f8ddmr380549745e9.14.1793796675227; 
 Wed, 04 Nov 2026 04:51:15 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea18175bsm3653800f8f.7.2026.11.04.04.51.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 04:51:14 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 08/14] block: Refuse a device with an unsupported block size
Date: Wed, 04 Nov 2026 12:51:13 +0000
Message-ID: <a506f031-4997-4c20-a07a-0a404a4ef122@gmail.com>
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
