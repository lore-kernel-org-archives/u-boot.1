Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1158606A330
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mo+D1up8;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xaY0wCxL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8498605DA;
	Wed,  4 Nov 2026 12:51:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id umwoplCI5UTB; Wed,  4 Nov 2026 12:51:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0EECC6070E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793796667;
	b=b7Kfk8ldLP6907UyjVnClc8RjqyE/nqZgzmoi7EPy7H8z/XAUsSAf9+2WwGvcXGhWtLO
	 3/C56ebl3+DFESUa27/uWJdoREBNl5iwGX8S3WZfhiknZQ4Ij77xaUx709q/0/BSztNQF
	 nfoby4cPyn1ctNwlWagPabT43TIeMNJWaMdJn0qPSxHZieAK7+REqnIIt58dgJze5Rfkv
	 IEeYcAX53SXmyhzYOheM7lDlQNcuYabYrc1Ax8nT09P0dUA9QgFXGZW/daeY7RLUJmeT3
	 rhofIVbF2RLK/6DL+iIXnQnJn3MML/AAcxxWFy9zG9hnoWL0V34b/wbQDQfZ9rx6tjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=L1CznMWH3B4wyUTp4/Td1n6u+MSKkpzPbFFHbWmJcNo=;
	b=HjK7FYCTsG3Rix3KxO6KVhLjM15vNPK7wqOji7DPTEAkDPAzUzOOaCY79wBekH69P+C6
	 EzT6KaxU63V75jjcocwiYm0U864kUMb0HuQi32/nLg2nJ+S6Fg+BT++huexYcCGIZdeHW
	 /90nLIG6VqxUlbsVEGX9/GAxtJah5TFeSnxaWw98QjPytFPEDzLjxV8JFwD7AfEasaznx
	 ycduAAXrWNGpPVvCJ+9Cx2mnndSQB4chEJjd8FJB25VZg07qoq6PqyikLUT3vEHn64ckP
	 6RSugdcaqHIaJM/HhErNhVO17/fnQodt9c0f8+9z0TNUXqXLbWWPxgOcHCCyB9NUySQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xaY0wCxL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793796667;
	bh=L1CznMWH3B4wyUTp4/Td1n6u+MSKkpzPbFFHbWmJcNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mo+D1up8RVfkyf8iH2CTBJw8HAVzqxUDWWghyJF4u4BTEGSkNWk1WjYzkcooTY77c
	 /K77bEs2XFwWcnNKaGzxA8Y2Bn0CrQsBW1Rm77kZMUTlzqtgJlBRu1m1qMnBO7h8f8
	 Bnnj2GtEYQ6M4+Qe64IW3EzRFPIvvCTjrDZn2jsnf+JA42e1CQTmOc+87RlsH9kpxD
	 bQmBFM5ZdaTsKfn/I+BIZFvTHgJi8IA7OViN+Q4AKGQIngU1CMH41TD4556rfRVDlA
	 Q84j1lrJZEeTGFrQ+Zf8hzLgfg6FK1PHO89KZ12nxD9u0aWHbKeC9qoNTpoRSTKzOG
	 fSn+2YHNrZTOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EECC6070E;
	Wed,  4 Nov 2026 12:51:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BF8EA10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8DF3D60755
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id db9v5EPZ5ZAA for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:51:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A33246070E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793796665;
 b=sybeIUf09X1wXKfVC3LaIHblpUN6fBqEQDttyvCGEX1YS7NsYCyVKKKCgirJ6oOx4Lts
 kMiQsdPhe+lyLonRIQ7sjiD8Qz1TAS2NBs4owK/b+oZSuRenZk5CX08VQQbBmz04vWErd
 Wp3ikb6gcfJqTgjhPyBNOX8hCscts/XRfvJpnwmYFWd52PT502EvlBPSy8K9IUZM87/qh
 BRoHNsEcH60REqbUuyvrV1EfVy3udsnRZUxWHCeLE8pUChdiu3nAcIkmb5HcYex9D5WOP
 YH9xbPaCCuUJqpTMJfw7Spk3aD90q0pf1wJxpk2GvRtLAJLjNIiCt4nuuEjkg9Ndt2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793796665;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=L1CznMWH3B4wyUTp4/Td1n6u+MSKkpzPbFFHbWmJcNo=;
 b=IJAaGQFkzn1g6mN8nZPOsXnqWjeMR3ypvpmz9dn7nY6vpJPzUgmYMEmNY8igG+om2BK7
 KqREGewStA8/ZiG7xB9zOfSFQD362E8pjfjdKR+2zuk70ZVBnyXGDVTbdGXMznKBPDGFu
 lCaibsDRt/BKMMxauz8cgcK3GevCrmmQvn/4Vh+uX7emwdZQL1ux2OvKEFBAdNa51XNhl
 fBchvoPlOIvau0ePUNNf1hkxiJPCyAl1vILCWmYBOp5VPuHabWFTCv907pAbSTcWF48/K
 zKno915OgrQzF9nZbXbrX7RlBQhkI7Ar12rKp2O8VgSKRNG+wcLvsl8rplrd6+5Lnmg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=xaY0wCxL; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=xaY0wCxL
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A33246070E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:04 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso4254335e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 04:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793796662; x=1794401462;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=L1CznMWH3B4wyUTp4/Td1n6u+MSKkpzPbFFHbWmJcNo=;
 b=xaY0wCxLEU86hSRSPhWRBgOVBpgRoyD6j5cWbkS19YYvvzcf8bA/sifsoHSwrocP0F
 CHDYs65IQO3CpmFyk2yxR4DcDQToWtZk3AKgwQlNtgP422ihHekWWykcL5y/bGFUdUrn
 X1UR0OKPepqEedwotavkzTwsx9U3ytQRLj5Md6pRmScA2Nk+jRoyMswmkHo7V8OzHVZc
 TYGnyuaf/EQyZmccx0znKuXfUZU8E1X2dKbwFvg0FG1ZZlsDd8jX0kt1IrHNmDhEgfps
 ekB2cDJzmuXULQr2l63ptLVX3NhciywXWfzXe/HZSzKU/pn0eqrQM9fh6EF+VpAGKcpc
 EBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796662; x=1794401462;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L1CznMWH3B4wyUTp4/Td1n6u+MSKkpzPbFFHbWmJcNo=;
 b=MVesxSvhibf0c0vpd48uKqiHjHuRjHjcYa6jMOvzw+HBs53U1ayQ8YOKVlLqZJkt/g
 ADeu2dqk0CaVMaJa6Uz10lkmMIQhUsGEov7m4Cok2IADNH4KOkYkCNJXv2LERQob1j/z
 zdys6vnsIkS43O7mJ0+VnO/nXj/cYOsmIXKE2bA6l9usVbgY6jSpwIOJDwFoWJYQ0Wf+
 T5HOkeBQUbfm1IHcSwcI/TXcV/FQy46PCHPgdqxJwKPhRWX1uzynv+M6PP1J20C6sLtx
 jQyYLtwzZD7XKSL0a9Uezk1h1ArCGkcl+fsH3eb033jccEugsRBis2kLOYk9g7hYFjR2
 nLGQ==
X-Gm-Message-State: APuU4Z/fawShV7r44sPrRKb1+vlSivt3onjru9MLFkxocrTguu2iJMuF
 8BenhCoqrNZOxL2dLEY8FyshL4geS56lJpH2ZtcGOyw0BRygYzo1eqaB
X-Gm-Gg: AYBFou36IfwW+hW5HAhnCPWhA/s1lqUWWSudp1XTIYcVW3G6HzBr6MkvLG2paieNM64
 xYFjev2jeLDbKqz1FS4Q0DkD2o6mJN4HOAXg9LflowwBKozoQA2MdxHlwufPdLa6pzRegshyfM4
 DX92S2vF1Xx+TWPbA1m38Ej2rwWQQmKTmnWNO43jyG8DaWnTwBq1Uumn+5u1UugPW0O9vs6SleH
 mSG52LcEoAibKT5LV5jtk4han8lJxxjiO28oiAtoHB4PIRYerXaox7tO+d2Hvm+WctMPwzT/Fsk
 hrP3Gmh0YG7FeYLk5iPv5go2GetnAfHH9ZSeBJMVXriD5RN54x4EqlhgYzZs4yMEvd2+OWqBqSl
 9yAbN5GoXM4ynVd3XuG/YNb7wg+QW0IG9BG8zMjT749QwMeHuipUrYUq1GWx2z8/d16kM3l7+NI
 st/Ki5zwQ6t7w16AliB6UPHGL7DMNfipghXU19dlo6ktxgis/ZWjLrHMVbkPJDloNhEt3fuYZRa
 CDg9MRfOt8SZFkeqfwoiKJQyLBTkEdGu8xUmEDOn1PM0cV4db4coPairZ3Lch+43mrkpCfwnzUJ
 KMP3Afw5lbGLB/EPLhp2og6b3+1DWm4=
X-Received: by 2002:a05:600c:1f93:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-4ac180f2fd3mr383356995e9.30.1793796662168; 
 Wed, 04 Nov 2026 04:51:02 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa38bb4asm139693115e9.6.2026.11.04.04.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 04:51:01 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 06/14] ide: Refuse an ATAPI block size atapi_read() cannot
 read
Date: Wed, 04 Nov 2026 12:51:00 +0000
Message-ID: <0140a193-dd11-45b1-a779-7b2b94d1eb63@gmail.com>
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

atapi_inquiry() takes the block size from the READ CAPACITY reply of an
ATAPI device as it is, while atapi_read() asks the device for, and moves
the buffer on by, ATAPI_READ_BLOCK_SIZE (2048) bytes for every block.
With any other block size the callers' buffers, which are sized by
blksz, do not match what atapi_read() writes into them: a 512-byte block
size makes a read of several blocks write past the end of the buffer.

Some CD drives report another block size although they read 2048-byte
blocks: 2340 (HP 4020i CD-Recorder), 2352 (Philips CD-Writers) or 0.
Take these as ATAPI_READ_BLOCK_SIZE, as Linux does in get_sectorsize(),
so that a drive reporting 0, which ide_probe() skipped until now, is
read with 2048-byte blocks too. Refuse any other value: a device
reporting one is left with a zero block size, which ide_probe() skips,
as for a drive without a medium. This refuses drives with 512-byte
blocks, such as ZIP drives, whose reads of more than one block already
overran the buffer; supporting them needs atapi_read() to use the block
size of the device.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v2)

Changes in v2:
- Take 0, 2340 and 2352 as 2048, as Linux get_sectorsize() does (Simon)
- Say what is skipped in the message (Simon)

 drivers/block/ide.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ide.c b/drivers/block/ide.c
index 44ce054bdf5..56e55bc8bc1 100644
--- a/drivers/block/ide.c
+++ b/drivers/block/ide.c
@@ -450,6 +450,7 @@ static void atapi_inquiry(struct blk_desc *desc)
 {
 	u8 ccb[12];	/* Command descriptor block */
 	u8 iobuf[64];	/* temp buf */
+	ulong blksz;
 	u8 c;
 	int device;
 
@@ -514,10 +515,28 @@ static void atapi_inquiry(struct blk_desc *desc)
 		  iobuf[0], iobuf[1], iobuf[2], iobuf[3],
 		  iobuf[4], iobuf[5], iobuf[6], iobuf[7]);
 
+	blksz = (ulong)iobuf[4] << 24 | (ulong)iobuf[5] << 16 |
+		(ulong)iobuf[6] << 8 | (ulong)iobuf[7];
+	/*
+	 * atapi_read() transfers ATAPI_READ_BLOCK_SIZE bytes per block. Some
+	 * CD drives report another size although they read 2048-byte blocks,
+	 * which Linux takes as 2048 in get_sectorsize(): do the same.
+	 */
+	switch (blksz) {
+	case 0:
+	case 2340:	/* HP 4020i CD-Recorder */
+	case 2352:	/* Philips CD-Writers */
+		blksz = ATAPI_READ_BLOCK_SIZE;
+		break;
+	case ATAPI_READ_BLOCK_SIZE:
+		break;
+	default:
+		printf("ATAPI block size %lu not supported, skipping\n", blksz);
+		return;
+	}
 	desc->lba = (ulong)iobuf[0] << 24 | (ulong)iobuf[1] << 16 |
 		(ulong)iobuf[2] << 8 | (ulong)iobuf[3];
-	desc->blksz = (ulong)iobuf[4] << 24 | (ulong)iobuf[5] << 16 |
-		(ulong)iobuf[6] << 8 | (ulong)iobuf[7];
+	desc->blksz = blksz;
 	desc->log2blksz = LOG2(desc->blksz);
 
 	/* ATAPI devices cannot use 48bit addressing (ATA/ATAPI v7) */
