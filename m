Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2FB606A31D
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K5fl9alT;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UDwH/5rR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C2FE81751;
	Sat, 24 Oct 2026 12:17:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sw_DC868qgUb; Sat, 24 Oct 2026 12:17:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BB8B28175A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792844223;
	b=n30NGwTO14621Fw7GQfkVbvfzxVRB904exDQr1t1ZAzcW2V/GrPYqy6NioXXQvu0xuVq
	 s0qdPy6Rapfej9XtddGmI9rlLls1Ma5k7tPn5Fvkr+kidZNxFCOaX6nby+nLdFZPlEEsL
	 A2MvRkEzmkzUIYIVJQT2wF1dEUEV19wBtnog/0OA9J3te9XO1L5snERrJps2eYgs1ienV
	 pI/TM3Zutm/wQ9TzFqv4cpH+JMMpWSViQcj2o/tPslvupF0uNJP7lzfzQqDX1o9ZqT+GF
	 1o4APwNFabJzk7Rc15ehuQ53Z5BvUsPYTZF9+Z34yFSO24P6ZhcSIYmrQ0rE8fKBRMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792844223;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=R9ESQrSeBPjLODpitqH4NO8w7F3BmaplZki+DGssNPY=;
	b=CK5LCUQeWGg/fs1BwYAVx/ot8fLFeuNTzh03K7okjLotOQSYIYtJv8/YITdUmgkcwxAz
	 Tajxxqd6MXupxISdtFQ/V1AQln2dr+SEzvbmmzpaUPLYo6CIANDo5vteTDx+62fjswqJP
	 /HB4I9jT7wsXxWre8XeqoXtylikEThdRAUjLOBXSPEUPg71qPcNKqa9RJEiqZEhGXW5tr
	 oIbUnpCgaAkm+4+4j0leC4tllkYGxeNJI4dQZkkALhrS9HMgXRROKRpAZ4HO21jl9x4Mr
	 GyjD4erFlqJd3blYz+I+qj3hkrmCTamy877+RdSldbO7NNKKP0AaRkONH3gK00TqUSw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792844223;
	bh=R9ESQrSeBPjLODpitqH4NO8w7F3BmaplZki+DGssNPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K5fl9alTvnFRoMLK7dWUK496FUJ+JNqYZlZr+qufPa7D01qZis2ChPuhGX0JEPIdN
	 iTD+I782ZUhbBEGlK15RBPRdeL9qxBCLWAUTA5rcsakwwE91iartkg/yhO0qf6hmKy
	 JbW+2UErSv1qKZspO3m03QRQtp0WRm1XVTA3msA7h+f7QV//SyM5iEfaJKzAeRUQ4w
	 07FlLVzSZgrkMk61Tdk33pbBzhwODafKOrbM7tLb/o7/ehosK1RKWchrVHYJTu/rUB
	 2/xT6oPAJoI68rK3CFlw21fi72BaWeoS9cmfUGk6IF4M9xMjUVXcPyUlYTYyLUsU2M
	 lUDNoYyztZZoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB8B28175A;
	Sat, 24 Oct 2026 12:17:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 13A22380
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EDEE340182
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ve32phdWfBBi for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 12:17:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 16AC0400E0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792844221;
 b=aAPbE/EpA+trXjHBrB2JqZdZM92hsEIoHSo4NXJzNL3GFGBAxXTY5O2acBDp0KHDsbgE
 /PxzKrklkl1DRM0iW47ZIfRuei8p4k6zZ5DsDu1zVa0WqqN2ojpcoV0jUpbD2/9OSnd+8
 gi1AGMzO8Kg1ipKRUCZbBTC2M3lrUk9Z3Wc5bNefYMTpeiOB6djJRrwEr7+UYBRMAFLTg
 ZOkt4bDcVrF3JYV9Odnx39YLV6Bx5UtSg+UgEtbmQz1Ibk04U7OrOxZx2/KWY0eH2e7PQ
 0+L0vKRkyVNNyPEqdeAr7WfGjO8dc/vG1WfK9IEDfefgKesKpbAC8Vonq5E0CSO1gpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792844221;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=R9ESQrSeBPjLODpitqH4NO8w7F3BmaplZki+DGssNPY=;
 b=jcmlHs9K8cGDRKybXs9iCmbXtdBudihbgkXBFWVMwAJ2D9NksdLPVb1vEgsWzbELnl55
 00pjGGwCgeekZcO3Bgig7/mCPlJiuOiC57VQbPoeWMEcqvF8ipVPQl2qCTM1k6w3DpxcJ
 mqIcqSaPbX84c0EhyV5hnr4OMoNi+N/csTlnjYf/gNM2tQZM9OOF/yDVgHpYxiJZwJ07N
 yj/MjAmOyWzNLetOocQa6A9M+NwU3m4nfjO3+PyCVRltMKxQKPmin9ZlNDBh6k6hb929I
 vG+b2G3WhGaD39AM1q+jc1Gnrm64RZkq/1DMgVweHJhgCm2jgJt33rILr6tvyYlilTQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="UDwH/5rR"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=UDwH/5rR
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 16AC0400E0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:17:00 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1e477fe16so12994545e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 05:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792844219; x=1793449019;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=R9ESQrSeBPjLODpitqH4NO8w7F3BmaplZki+DGssNPY=;
 b=UDwH/5rRjb6r9/mGIMI4Gvb18uVwVDcqQFCNSN+/NbeukWC08nJNiNGA34kWF/HItE
 0TsueCeHMPSSc33zTR5y8iKamGcy54SuFEumEgBQBplrWNyb1uhCPMlkCC1gvvRgSUmN
 KiHMpzgD5q4Fzsny+nxtxTZ4g7CezsUKjGB4jR5QW8+0C31vzMbV3ui62BRwBeMFdRWR
 niMPT4fGki0mIE/jKEkjSTVXwO+v8iB710BP24Om2leheWbmzMCTkZjGBb9sQTNCKWdo
 q28AU3YsIaxeaiJtdtN0N3BYowbezZ+xRKWMw7xb4b+1+kClLt+hIQ1nnYRkrstpVhdV
 GgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792844219; x=1793449019;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R9ESQrSeBPjLODpitqH4NO8w7F3BmaplZki+DGssNPY=;
 b=F5TnRxeN9vCoYLwgI0a71PhnEfgRkeK0Ohdin9XctppkL5QV83fZcM87EtX+dmGOGH
 BiuCvOF6RMCWTuO7pSJPgPOCmYCFavURy9sZpa3Sn5wQSV+xDaVWX+P016craZo/nVo7
 2/Nk4UvxZR3pIcva//bY4zL4O2m5emZ8/o0REX3en40MIi1fZXI838wQhQ2TCefuPjVV
 w5aZuiQSHGSaL4TEYToGPTFGyEXX4vRn6uimCDBswHCduF0lUG1bjOnXGi9/r9dveEAA
 15wlwKTkBHdGqO4aLProtjJERliV18sl4YKahBG3GPuUZI0oNvfGhS/JT6FVkEE6BPn8
 G0Gw==
X-Gm-Message-State: AFq9FYKUrsJ0/RDLWFw3YqPJdNQsL9UiFp0ICPqUgUcBTnzSmFFduuO8
 CJkQF/ALUY2K/5FDeW5GzuKq90rObGbTxLT3/DJniNTEJqdvSBL7Z1eG81DjFqgS
X-Gm-Gg: AYBFou0uT1WqzqNUHPYtOBq98L35V0b5pLamS61j1p6yIMKceDj0kkozjYi3Us/sThG
 +Z+s/H/t3PsxhDg6Y0XEaLatd2tgzwEOG1Efpu+WRcHczKwV3ssXUbVIdNDYN58OiIzYT5G1Rtb
 RgR1pW/AM0dZ5xhXPw3AEWqOtWdozNqFIwxKP0yqtO9WMK0y/7gpbZ5BGHJkAntmfFwZVC03hwG
 WbVTc7qDy7ez8YNllQ9dA1RKkNi9XNY+kpgjhjx+ZS/WYES7Tjxp36Dq/pQo8P6/OISdwSRDrP6
 eQp1YJLfvrGYbUgJ9KBYIUglEq1BGmLYrdzvaUuFp9VwordA17knylCvTEZBn8KksUfnLVAj8+i
 yX5W3kS/QOX8BiWH25h/Q4CSTS2IoPR+VdW7fgJo45rn0sPTlz3xhEXTOE3N+fS1CzdLMFfZg9S
 3oHs85khPho0TPVcfJFXy8Sc8ugHumYYEIhpQEkdwLLU7naA4wlfHZ+2qpVfUK0Vfc5loVqwkoy
 u8mP7zeBE/cb+OoY6rL53v9cDp2pozdo26icYSkoytSu+HbFyYORxY/4Wo9yqSNyqddTL+ZfZYS
 lBE=
X-Received: by 2002:a05:600c:4583:b0:4a2:1197:1de0 with SMTP id
 5b1f17b1804b1-4a35ac963edmr30175705e9.19.1792844218616; 
 Sat, 24 Oct 2026 05:16:58 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc39b3sm4101078f8f.10.2026.10.24.05.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 05:16:58 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH RESEND 4/9] ide: Refuse an ATAPI block size atapi_read()
 cannot read
Date: Sat, 24 Oct 2026 12:16:57 +0000
Message-ID: <fc361b34-765b-44a5-a594-a6f095b03ad1@gmail.com>
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

atapi_inquiry() takes the block size from the READ CAPACITY reply of an
ATAPI device as it is, while atapi_read() asks the device for, and moves
the buffer on by, ATAPI_READ_BLOCK_SIZE (2048) bytes for every block.
With any other block size the callers' buffers, which are sized by
blksz, do not match what atapi_read() writes into them: a 512-byte block
size makes a read of several blocks write past the end of the buffer.

Only accept ATAPI_READ_BLOCK_SIZE. A device reporting anything else is
left with a zero block size, which ide_probe() already skips, as for a
drive without a medium. This refuses drives with 512-byte blocks, such
as ZIP drives, whose reads of more than one block already overran the
buffer; supporting them needs atapi_read() to use the block size of the
device.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/block/ide.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ide.c b/drivers/block/ide.c
index 44ce054bdf5..035bbf2ed84 100644
--- a/drivers/block/ide.c
+++ b/drivers/block/ide.c
@@ -450,6 +450,7 @@ static void atapi_inquiry(struct blk_desc *desc)
 {
 	u8 ccb[12];	/* Command descriptor block */
 	u8 iobuf[64];	/* temp buf */
+	ulong blksz;
 	u8 c;
 	int device;
 
@@ -514,10 +515,16 @@ static void atapi_inquiry(struct blk_desc *desc)
 		  iobuf[0], iobuf[1], iobuf[2], iobuf[3],
 		  iobuf[4], iobuf[5], iobuf[6], iobuf[7]);
 
+	blksz = (ulong)iobuf[4] << 24 | (ulong)iobuf[5] << 16 |
+		(ulong)iobuf[6] << 8 | (ulong)iobuf[7];
+	/* atapi_read() transfers ATAPI_READ_BLOCK_SIZE bytes per block */
+	if (blksz != ATAPI_READ_BLOCK_SIZE) {
+		printf("Unsupported block size %lu\n", blksz);
+		return;
+	}
 	desc->lba = (ulong)iobuf[0] << 24 | (ulong)iobuf[1] << 16 |
 		(ulong)iobuf[2] << 8 | (ulong)iobuf[3];
-	desc->blksz = (ulong)iobuf[4] << 24 | (ulong)iobuf[5] << 16 |
-		(ulong)iobuf[6] << 8 | (ulong)iobuf[7];
+	desc->blksz = blksz;
 	desc->log2blksz = LOG2(desc->blksz);
 
 	/* ATAPI devices cannot use 48bit addressing (ATA/ATAPI v7) */
