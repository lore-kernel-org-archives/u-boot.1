Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A8B606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 07:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fnoI6n07;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zI8Hwyab
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F59A80E30;
	Mon,  2 Nov 2026 07:04:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BqNlb-RNTa4Y; Mon,  2 Nov 2026 07:04:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 16DF780E0D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793603049;
	b=gCJmOGdrEeY183INmdtnN+MQ2tRcvy8DBx9Qmty2xXfm3pAZ4p+vDyekMYM7SGYRwJOz
	 HEV7equYYgNUdK5M0qUiq2rzOCPON9C7KSBGXsU5KMrzD5sDPwk9svehibqEN3qoZNMom
	 AM6Nui+EALEx6zAHVNG07Vcuv7ukgLiDTgjmgN/npBOmza1MR4whLmlS/S/P28QjSkmDo
	 r603QREZb+HGkuVLVurhgYjMTbf4KXLQAcnykwAwq8Bw2+O20gyZIfyf0/18WKztUefxx
	 tsPO8V2IIcriFPt5N+/kC7HA595IfPk2h2iWtmUEJRAfFlqBteJpZVbib4El3W1XgIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793603049;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Wvl1iSeTz2kGgbbww9Jsh0A6MWreu4l+mQhEirNTwnk=;
	b=HUOZn0gk4be/d89I4HfI3pr4ot4iGU5mrSNQeczMqUzPGYLSGVIawDZYilYXhJ775vVn
	 7l2UdBAj5NIL0Yu7eMAiW/tiZe5AtvJmBNJOpec9/0aTClz0fpkWJX+CnbO72Jqt2px6W
	 fzuV5GcQM28+N1unOeu/gFWKTA2lotKXIeLbG/ldPW0Z9d2dRedp3cWhItLmI47bQkI5j
	 AuUqRMv9Fma72t08bTp/4v9vcVANfhwXavBHXRuMw3FfD6qEzfrkTISgH/8YSf8il7M8J
	 KOth3l62LJdPRaQFTuA5JcOxlTClv69sGJwgH+OLRgOrFm2qDKfuy9EfF3QiQx6Tsmg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793603049;
	bh=Wvl1iSeTz2kGgbbww9Jsh0A6MWreu4l+mQhEirNTwnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fnoI6n07szpDILajkVPw6tQTPO9+szRnpk+qfHaiorGIzEquCKiXDbn9xJkEl/gc9
	 ZtiVe68r5TdvucWDp3zID03okIPK/OOWaG4aCA/FqkaPMOZj2hpc81T3wjlwzEvDsr
	 CkUVUwVJxAeCchSfGQ8CSkkLqAPP2qppZFvgFQXCsgyOBklaCMiEqqPInCnD7uanGr
	 2cm8JyvCEyBtE4hfK9EVOY6nDVsnpZeBJcJK+BggUDRkZBFDvouIfZJmwJmMw8Bqmi
	 2ZVeX1ajYyNDPyqFzC1YkLrvXXtlqiq3oi9CFuYc0rk1VDCBjJKpYtcL+yD+9ElTgl
	 sJOUMlSqW+BbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16DF780E0D;
	Mon,  2 Nov 2026 07:04:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E4CF9356
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C99EE40558
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:04:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lxou6s_IZ-H2 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 07:04:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7E78B4053E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793603046;
 b=Vw360tWSoydxMjLaMksG/jtFpSf7wiABP1q3cpNxIPfOwrDRcgl3gOIHbBxyc0KgmxQZ
 Hyn5NQaUBDNNAzji+iDxM5FXEIsGUwl27g4P1IhOnSaz3djtwJkzHJr3gmXN++1nPYRXT
 vk90wgmbWtKOo4WxTdg7JzYT3khjLOasFd5h1Ys82FxTS+jzvIMavNeDC724wa3ClGd/G
 I7y2+PVRO21W5lspIXQjxG9DYfys7KnauliMkj4nLBEUmjlzJmMbfpf2+D6oYUtBj6yFz
 jbol+MAjHuUemuwxSewn6JlP0r2LfyV/q2jx+/XG/k3YEBuF+bO5/rQ/60DzeRm0wPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793603046;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=Wvl1iSeTz2kGgbbww9Jsh0A6MWreu4l+mQhEirNTwnk=;
 b=Ke11rB4zeeCOb3Kt20AvoNVlY+km24kuAYyAI8eSVJGT9P0FyncM9OOO16rTvBVECi0c
 GIYUryO2RuUGgVYlvx4R94ol963irHVrGcMfH0Ru28VDuel2ss85422n3jBIVbwms4q61
 6QwxkCeeTH4ojQVr1RxmmUbUw3a5zNYwRPGqfOEAo9XHz6TZK5rthnL1nWDFguGxb6wXy
 yA4bOOoT8ebuutzwdaFvMCpI3doZMMKio6yp9rCaJgtfmEUpaKbyA+ruOTiyNvutgnOKI
 NFXPgLaEinpSuhvg2DmcOU5PYfzwRuXxh2xzFoaeYvyMmSJsfEGSrbxlXyuHh5GzAzg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=zI8Hwyab; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=zI8Hwyab
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E78B4053E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 07:04:04 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a218c463d1so16852945e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 23:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793603043; x=1794207843;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Wvl1iSeTz2kGgbbww9Jsh0A6MWreu4l+mQhEirNTwnk=;
 b=zI8HwyabZJ4QnuztXztjwCu/8/tnprgqO7AvwH3htAkPgL17pNx/UQ8g4hGsn5Pi7M
 SueR3XbFb09rFgc40C1r+zMJRuaTTm7Tgekv0F2QI1ZW8YgOtED6vm5QeVWmMM03BScV
 J43U7q5Q+JKgX96mqe8xcynSVrx7bGKjhLa98R4bKCfsq5aicczohBqvgH4q+56zbcpQ
 pKPzE1sLvNQfCFEdK4fUWHjuZPfmxM0Wj5eYN+pjhyHN7t09CTBzPSYxdN8TAowfejRJ
 /TaaU4XMuF9XeWwHUE6+jPnzKA0j0OmXlz4y7LXXnd5K7io7llP0z2W6fgVSnHGM3M1E
 0UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793603043; x=1794207843;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wvl1iSeTz2kGgbbww9Jsh0A6MWreu4l+mQhEirNTwnk=;
 b=VjSdyNK3cIA7+Eu5nPpOZXjvKZw1j7yxNEqyQdZ5MuGPsM3TMzC8tJu5dxueYqdMMB
 NyraBb1C7gq3ySYPIUYsPDrO0L6glHllCvm3TLLQZSQiABxRt34iXGNsJF9DBlhlBcl6
 lPBc4k7PmuIaUONsQFPgQgSmGOkcUe8TgTk/ad0HhJhIQnZ1MQWQfWX8Gz9fSNOXYfcn
 3lEkG27kR2zOkeUgmp90X09jnMgu7emohBAmC9ObVBCh+1RXmz9gWTJiFxAccs7iFKoS
 TLiR5cK6V3fTCQTcZ85hSvJJO3mmuIf8UoMFPXkUp0KeSSfZaQnXEYQucnGqLSxVpQQ1
 u83Q==
X-Gm-Message-State: AFq9FYII/jK7e4Oxu95fycH2KyRck+vwmBf/Y4FC3ImOF2m+6V+7ARb/
 GFWwaBesjB/JUJFNFfRgvKLkkRNE6OppvfP65jGRLbs3sp0nXvBtscJplUYxKx1bzQM=
X-Gm-Gg: AYBFou3UHdcXnaPltcVRCZfaEt0qPDM5N4weGlsv/YrX4Dv79cuybbe7y/1jdT8nH3I
 xzYptr9lWDQthkjW/IeOb4xKGYPgM9dOOju4+qynrjFm318NC9AU2uXNS+Hb2tIuFyGi6nmQvL9
 kVZ/PL26JyzpCwWhpdmfVLukIDJj65S4FoN/KSp24WWF5/zTNdV8O0YjryZGW+vuCHW6lObnd+3
 2ljPqVuFlHGOOYBBxQWFnctLN/j2pYs2MQMGhbyU8mjbjJ/tsBcLZ4lzOEXNJSduCeqkcOzBORU
 F8QzmrBlAjM2+ZLjrNLK3yA7cBHcjYRn0hv8RyMGK2ibPMwNq9tzHNrphkgIz3DcJCTIPvdnk5m
 3nB2EszkTmOTtkNztPERjT2Ap1hXCW3UESfrtneAi7cVM63lPKwZAio+XSXtLBwuOCF5UYOgUd9
 D0ghD++iI90fuD/EpqaZB4UMvEgZpJb30JJ+E/AC1pC7WoVzludgBrVNYvwTi2U3W000ih73Cdm
 UwCBEd3kVZNhfDzyRrrMixxNKP1kAQPPsXOR+bQ9nDRTqCYVJD7e3qHeK8A9bW6QZst3VQacGSC
 L8znW1tHpffdMFCaTl6PVEuJ+2kdvLy9uHA9qmYvZlsR5Dw4ZqiS
X-Received: by 2002:a05:600c:a41:b0:4a0:1c0e:b057 with SMTP id
 5b1f17b1804b1-4ac150b2136mr195764275e9.4.1793603042827; 
 Sun, 01 Nov 2026 23:04:02 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf5b289f7sm251960035e9.5.2026.11.01.23.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 23:04:02 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 3/4] bootstd: cros: Check where the preamble puts the
 bootloader
Date: Mon, 02 Nov 2026 07:04:01 +0000
Message-ID: <44540f89-7b47-47b8-9c47-2d82c10d1b98@gmail.com>
In-Reply-To: <a601d668-436a-4aa7-bb10-950a89d324ed@gmail.com>
References: <a601d668-436a-4aa7-bb10-950a89d324ed@gmail.com>
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

cros_read_info() reads the kernel command line, the x86 setup block and
the bootloader into a buffer of bootloader_size + 8KB bytes, from an
offset worked out from bootloader_address - body_load_address. All three
fields come from the kernel preamble on disk and nothing checks them, so:

- on 32-bit machines, bootloader_size + 8KB can wrap, leaving the buffer
  too small for the command line and setup block, which cros_read_buf()
  reads from it
- cros_read_kernel() later points the x86 setup block at an offset into
  the kernel body worked out from the same fields, which can be outside
  the body

Reject the partition unless the command line and setup block lie in the
kernel body before the bootloader, and the bootloader ends within the
body, as the ChromiumOS kernel layout has it.

cros_read_info() can now fail before it sets priv->info_buf, which
cros_read_bootflow() frees on failure. Since priv comes from malloc(),
that frees whatever the heap left there, as a read error already could.
Allocate priv with calloc() so that the pointer is NULL until it is set.

Extend the ChromiumOS test image with two kernel partitions whose
bootloader is too near the start of the body or ends past the end of the
body. Neither may produce a bootflow.

Fixes: f861b1ee70aa ("bootstd: cros: Add a function to read info from partition")
Fixes: 71f634b822ae ("bootstd: cros: Allow detection of any kernel partition")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 boot/bootmeth_cros.c     | 24 +++++++++++++++++++++++-
 test/boot/bootflow.c     |  7 ++++---
 test/py/tests/test_ut.py | 22 +++++++++++++++++-----
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index 685d5335e86..805680f71ad 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -272,6 +272,7 @@ static int cros_read_info(struct bootflow *bflow, const char *uuid,
 	struct udevice *blk = bflow->blk;
 	struct blk_desc *desc = dev_get_uclass_plat(blk);
 	ulong offset, size, before_base;
+	u64 bl_offset;
 	void *buf;
 	int ret;
 
@@ -285,6 +286,27 @@ static int cros_read_info(struct bootflow *bflow, const char *uuid,
 		  (ulong)preamble->bootloader_address,
 		  (ulong)preamble->bootloader_size);
 
+	/*
+	 * The command line and setup block come just before the bootloader,
+	 * all within the kernel body. These fields come from the disk and
+	 * cannot be trusted, so check that the regions are where they should be
+	 */
+	if (preamble->bootloader_address < preamble->body_load_address) {
+		log_debug("- invalid bootloader address\n");
+		return log_msg_ret("bla", -ERANGE);
+	}
+	bl_offset = preamble->bootloader_address -
+		preamble->body_load_address;
+	if (bl_offset < -CMDLINE_OFFSET ||
+	    bl_offset > preamble->body_signature.data_size ||
+	    preamble->bootloader_size >
+	    preamble->body_signature.data_size - bl_offset) {
+		log_debug("- invalid bootloader offset %llx size %x\n",
+			  (unsigned long long)bl_offset,
+			  preamble->bootloader_size);
+		return log_msg_ret("bls", -ERANGE);
+	}
+
 	priv->body_size = preamble->body_signature.data_size;
 	priv->body_load_address = preamble->body_load_address;
 	priv->bootloader_address = preamble->bootloader_address;
@@ -406,7 +428,7 @@ static int cros_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 		return log_msg_ret("bod", -ERANGE);
 	}
 
-	priv = malloc(sizeof(struct cros_priv));
+	priv = calloc(1, sizeof(struct cros_priv));
 	if (!priv) {
 		free(hdr);
 		return log_msg_ret("buf", -ENOMEM);
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index f24d79a34d9..e5b3e1fc665 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1488,9 +1488,10 @@ static int bootflow_cros(struct unit_test_state *uts)
 {
 	/*
 	 * mmc5 has valid kernels in partitions 2 and 4 and corrupt kernel
-	 * metadata in partitions 6, 13, 14 and 15 (oversized keyblock,
-	 * undersized body offset, wrapped body offset, undersized keyblock),
-	 * none of which may produce a bootflow
+	 * metadata in partitions 6, 13, 14, 15, 16 and 17 (oversized keyblock,
+	 * undersized body offset, wrapped body offset, undersized keyblock,
+	 * bootloader too near the start of the body, bootloader past the end
+	 * of the body), none of which may produce a bootflow
 	 */
 	ut_assertok(scan_mmc_bootdev(uts, "mmc5", true));
 	ut_assertok(run_command("bootflow list", 0));
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index a33f188d984..5e3b02bb100 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -408,6 +408,8 @@ def setup_cros_image(ubman):
         {'num': 0xd, 'label':'KERN_D', 'type': uuid_kern, 'size': '1'},
         {'num': 0xe, 'label':'KERN_E', 'type': uuid_kern, 'size': '1'},
         {'num': 0xf, 'label':'KERN_F', 'type': uuid_kern, 'size': '1'},
+        {'num': 0x10, 'label':'KERN_G', 'type': uuid_kern, 'size': '1'},
+        {'num': 0x11, 'label':'KERN_H', 'type': uuid_kern, 'size': '1'},
         ]
 
     for part in required_parts:
@@ -462,18 +464,21 @@ def setup_cros_image(ubman):
     set_part_data(2, pack_kernel(ubman, 'x86', kern, dummy))
     set_part_data(4, pack_kernel(ubman, 'arm', kern, dummy))
 
-    def bad_kernel_part(keyblock_size, preamble_size):
+    def bad_kernel_part(keyblock_size, preamble_size,
+                        bootloader_address=0x103000, bootloader_size=0x1000):
         """Build corrupt-kernel-partition data that U-Boot must reject
 
         The keyblock carries a valid magic and the given keyblock_size; a
-        preamble with the given preamble_size follows it. The bootloader
-        address/size fields are chosen so that, were the partition not
-        rejected, scanning it would succeed and produce a spurious ready
+        preamble with the given preamble_size follows it. The default
+        bootloader address/size fields are chosen so that, were the partition
+        not rejected, scanning it would succeed and produce a spurious ready
         bootflow, which the bootflow-list assertions would then catch.
 
         Args:
             keyblock_size (int): Value for the keyblock_size field
             preamble_size (int): Value for the preamble_size field
+            bootloader_address (int): Value for the bootloader_address field
+            bootloader_size (int): Value for the bootloader_size field
 
         Return:
             bytes: Data to place at the start of the partition
@@ -484,7 +489,8 @@ def setup_cros_image(ubman):
         # bootloader_size at offsets 48 / 56 / 64, body-signature data_size
         # at offset 88
         pre = struct.pack('<I', preamble_size).ljust(48, b'\0')
-        pre += struct.pack('<QQI', 0x100000, 0x103000, 0x1000)
+        pre += struct.pack('<QQI', 0x100000, bootloader_address,
+                           bootloader_size)
         pre = pre.ljust(88, b'\0') + struct.pack('<I', 0x4000)
         return kblock + pre
 
@@ -496,10 +502,16 @@ def setup_cros_image(ubman):
     # - partition 14 (KERN_E): preamble_size wrapping the 32-bit body offset
     # - partition 15 (KERN_F): keyblock_size smaller than the keyblock header,
     #   placing the claimed preamble inside the header
+    # - partition 16 (KERN_G): bootloader_address placing the command line
+    #   before the start of the kernel body
+    # - partition 17 (KERN_H): bootloader_size extending the bootloader past
+    #   the end of the kernel body
     set_part_data(6, bad_kernel_part(0xffffffff, 0x800))
     set_part_data(0xd, bad_kernel_part(0x100, 0x800))
     set_part_data(0xe, bad_kernel_part(0x100, 0xffffff10))
     set_part_data(0xf, bad_kernel_part(0x18, 0x1000))
+    set_part_data(0x10, bad_kernel_part(0x100, 0x1000, 0x101000))
+    set_part_data(0x11, bad_kernel_part(0x100, 0x1000, 0x103000, 0x10000))
 
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
