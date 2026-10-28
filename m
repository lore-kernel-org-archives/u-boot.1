Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DA8606A31E
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ny+oltUf;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w9krQqlN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6165180F67;
	Wed, 28 Oct 2026 05:51:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iJTHEJCpqRh8; Wed, 28 Oct 2026 05:51:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A5D8B80F71
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166697;
	b=FnureyCpAh/e/lp4uqZ7hKWlYo6EJ7gHTOezVgaSNOoQXvmwZjaBiNAshtm9fkB+qMZ9
	 rL/6KFW3/c4BgtkI6+PwvDZuSPBjiOMzWV8Gp88tSIDr2Mq+jkUhCaTcWqy7YdG6/P2KD
	 yMvxI4q98UNUGcKyp60sgYt2GsfkFejiq0evyMJcRcWB22BEwOaAe48z4IJGW0xtSJ50s
	 IePstVkT0T6AGNSEJlQOPElLOcT8YD1UhlKl2TmJldR3vNQIB2qcNdrWoVK+ZRSlGXtPW
	 y9/D0YAS+FAzO+7FIbXwCw0f80ByYQ40tuhqQwyUwyM2rTc9u2PRZAgC3cRAz05W0sA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166697;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=r2cth1WFVH+DGDUfMTKhtcrrQskM1zG1gVpfOt3fe4w=;
	b=Gl9e+gsQD04C6Qh7L9emIq/bxfCHXM69JIv3YUDeUYVOj/Dk3LRTcV38iXav/7EC+zkB
	 HLiey6qQ9NqXB//K1mcox8fBXW6RobuO6x5ON6OUf8qjkWWjKaj6pfN3vKLVGz2Gesvqd
	 iAYxd0gP7TU/ZTcNMFPdRsfII3Q5RiQofpEU1reEaSm55UQy0pBoKXIrKnfHP/sDPjdgn
	 y6OvolZs+aBAH6sLPC0AQ/zgiRIc4NZep28nqkVOl9mngrXk38LEXJztC5jKhw4rKmxj+
	 2BeZm47+JlxySVa/sFidIvRUZibiXps0W8dmazBCjFo6hyjRfjARqQJOrWeZJxWgLTg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166697;
	bh=r2cth1WFVH+DGDUfMTKhtcrrQskM1zG1gVpfOt3fe4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ny+oltUfRgekN1xjca6DrspZMRHOrLY+gl+TEqi7IcwJJv4WE7FTKaK3+DcQWyN//
	 Rn3YkO07+gs+ZVAyuV8Oc/HPNnudWUwM2E6mquWCbx10Ug0E2lk7p7GKuoUqCEbQUy
	 Xvd6tl4q+l480dCK7JIgBeKlbTE3/nS+MrUOp6y6jgoRfWwl22vyluKRAI7kIPkS1O
	 T9FNSeClaXcj3vSHBKmMmIK8il2LQNNJUTq7ZscSc15AMSAON5XYrE0lU5uBkvAKS0
	 4sRCLTGkHDkoeJV7VBzyId3fDy+X/t7rbwEn1FzfqBg5nCH/WSeyrUn6H4BgSdDafx
	 KIZSAzu9cVkpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5D8B80F71;
	Wed, 28 Oct 2026 05:51:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F9A2473
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 459744016B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LPAu21QboC1p for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:51:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 60F314006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166695;
 b=J1TN9Hhj3P6PBqIdW0uX8Toe2ddvJa6p+KQpsSgUmBsEGP4mlZJgd42QKQ6ntlXEe6qZ
 Mmb4Vqi29lNj6WWQqhZmcakUdGHFkGuLlR5xGfSUFUbUsvQxERt3OUxMby83d8prcKFLi
 oA6V7DJwQK7x4fBi2ha2ObZW0u18JjVnCmoG1AEvgNAEIt9jQz+DaR+svBXHrmffDjllu
 fPEIclidMMfmiwk7x6upwpaZOWkYYUDbGsvVll12Prj3txMVRMDH3ArT7Dj6lrfFmQbQV
 61zc4OycsUep6aQgQXalPUOxqjiRTcjZvM0gF8VDz82TG09qolu0OUoU7leqzPVDC8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166695;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=r2cth1WFVH+DGDUfMTKhtcrrQskM1zG1gVpfOt3fe4w=;
 b=XTqJy6WpheUya5JpMnia6vaBagFXvPJUBkc+hF1ACN4u7hMY/vWu/HjPv0HXUBmTF632
 aE9PcJDea5ilsC/571GyPGVYdaq3EC+T6boIkmAfwU0P0TwblresapishxmfGAF9Be55b
 RnjBzLzUGTwiuYCNbZgcnJA8NyLWe7JrXLqfXiHQ9N+F7wci/t00W2KzyPJiJKuQha/u/
 wxF5CrS/FR5YN7evrRl4GtX8ZwbK3OPqD+SCjGx1Lb+B/xyRqkSRJI/oZ/lYLs1Ys1dnd
 /Hu/8Hhr8i9I/MBaHVAoFtzYQlHTImKXVKtN/doBiZ9WKjojMcUDN8rD6H3Pce+yWvg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=w9krQqlN; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=w9krQqlN
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 60F314006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:35 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so4241055e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166693; x=1793771493;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=r2cth1WFVH+DGDUfMTKhtcrrQskM1zG1gVpfOt3fe4w=;
 b=w9krQqlNoCtAMwC04p3e/ytg3tKVZJMpHbtdosJxkedxAvjSmpdPZ2EvAb7yAxcZb/
 PzXxThcslGPifrjiVjaSFGqCkvRoTnn6SE+1HlgwaqYJe+Trm9hEuAKpWfXjFip2H7ai
 Bpe4Nlp+T3BRQoNjEhymu6+03qQUe+E7M1NKIzHJylzyXERanR4wCk4HZP0ouRfxqn4Y
 FO7scys/6lBH3Rv0fDJbxHS6NeBPuJkFWFgUBlzs9HEUDR4FbuvHivxcLFwdLpxRFHm8
 iMcwzhsxWfh+0iH17wPpQYMG06B+m4P65DUl0jvrV/4rOBg702/fgLiIOhMSuJsh+L/M
 vUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166693; x=1793771493;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r2cth1WFVH+DGDUfMTKhtcrrQskM1zG1gVpfOt3fe4w=;
 b=czakb1+TDXOTqIOmEXfvbIsDNfgLR5g1bRfAP+oCYxM3gWJx1mYMxMy4pDV7uvmn6B
 mLwChwGzib/x0MCNDqLb8aOM/xVn5WSJ0i/rmxpnNB5GAYmJp8+KbzqtghRq9KSz05zO
 Wo8wLuT3I9pxWde+I3dUGkGI46dzAAgCGSTBnCGTZtP+rKzIjdSRSMDhfLBoBm0oJ+Ka
 f87VAt7C57o+OQLCpN39dxy4VI+RhYVgb2hQpDgSebUqholgObWtzNEjJmZaRny3HcY+
 nt20epOEyUwqrfrh55ecFXfW2xyTECUH6i3RkCQtxnSbXeiWNu1k4y52dHyhLYYDFMcC
 tzKg==
X-Gm-Message-State: AFq9FYLhg8HQJvGvZsUqAk7Her/+OYBYrWKh5O/Y/C0Yg2X6BYr0rjie
 Yktys7D5S16PsmBWEjpWmsa7DkeiNYXiKwb5YdX2/FZSbIwfbJkYjlFo
X-Gm-Gg: AYBFou2mDphIxaxGauHvkhzD8wMIGA9lOJE/prNIhPD9L6I0RW69tx1HsxwpAKYOI6G
 RD9uyZTYnrHt09h9n+f8+U92gisFM3jHWiiOMqwxKLc0I4B2vzNs0w9okTjaFXp2kc1dq7tWV5s
 p9M32RegwRlBNdVMROkiuKhivnakboGwkBLghzMn0mzf4g4gcaQBUOdDhoakJf12n19Qz2ASYkD
 iOT9nfQ00f+0QSUgkK8UgAS6bq0MPAI8Z3Iu7qFbh6frTN9p2Tuuf4nh7sBPl4nbYltcxGad+4S
 3v2mD93DEChrFk/Ka2aXqFEzErtFvLqJQ1wpCyzm+ZNYn59ctgQR4rNmll1X5lDHTKjSgblrLo5
 syEfso5uCAUwDebSlFBuJvyIrHRHkz4Ua+Mc8uRTELJmFy0lGvtb5sQgRbqKwfbND1t2E6kNXLi
 smlMfPey3Mf/RSRMiffO5sDyKZ6z/nx7HqZInpcF/q3zbg92sROytdYYtHyJKSN4C/daU6BSYTr
 Bgs3I9yLzFoYfHsFnFqt0OAwBsE0yJ6KHdwBBz/tF5mhk9ubRhkEldDePFuCFuSvMgkkg91S2nw
 Sw5CrAvepkSS17nO+BJ6VhsP5oMPKUQ=
X-Received: by 2002:a05:600c:8a85:b0:4a2:40:7f35 with SMTP id
 5b1f17b1804b1-4a9672f9936mr17914465e9.31.1793166693278; 
 Tue, 27 Oct 2026 22:51:33 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a9733d48b4sm22666355e9.0.2026.10.27.22.51.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:51:32 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 06/12] ide: Refuse an ATAPI block size atapi_read() cannot
 read
Date: Wed, 28 Oct 2026 05:51:31 +0000
Message-ID: <a1bf0bae-f3b9-431d-9ebb-cd82fc1f294b@gmail.com>
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
---
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
