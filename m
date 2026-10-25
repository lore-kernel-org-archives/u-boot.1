Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1784D606A337
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rz7a2hre;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eJVk4gm7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB17380DF4;
	Sun, 25 Oct 2026 13:04:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gcncXbcWL5OI; Sun, 25 Oct 2026 13:04:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2CE7380DFA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792933463;
	b=FXmZ2LrhjMrEEPof2JoSxwguSkwAXslApotxFJW7AE00AaHAD/38k7UesjzdbMc+HLK9
	 r3tqT+aU+kCXsr5ONk7e6siDuk0WF2ZCzhRNTvQMVFco5fgnpOr3qBgmj5lIiDPbsPD39
	 VKus3bvONDS5lBwZ/XbhAzF9hhKwYKw8r5oQOGAmMC890I7mgqTmIXmcFQd0PGTBlC0mc
	 L0SYlD16r07sEiFLO6EOZLlGlMRdIhe9U2tNHgSnh5n5o61t+8LrsqJsxuUxHrNO3iPQN
	 xYy+4dJ0RqsMypW1Mb77lgzJnYxVhQM0LupNbjaeebwo7Nbvz+y4GJxMRSW0ZrHIaZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792933463;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=L8Vta3pDmPC4Ieeel+vjsEnJv0hIBrKpFqMW63AgL4M=;
	b=YSsqC/5f/Hec3/FkVTpqF3UzdSl+b4xxOQhoFOyTJM5nwOLVb+7MK8usC0pHbKkRQyYi
	 TDwbQBgdXJaJHByCNzl1zZSoJ7Ah1ZNrUpbBlEFYSJTjbAlaTLM9hQrNYsXFGs0pM8xyE
	 zpOe7LPyCyXEyaTorv91b8uLeA3sX0qW/tYq7HdpF+Trs+2u9zQTDoNoDRhnBuOSYmRP/
	 wii4+IQ3cug1MNswcbk2L7KZppoZSaW4jAY2qM9j7XAPq1QZfUekcSpRh/xWxqH1BZxbE
	 Pkljr2kUs8OZ8KsJre0lnDn6usht2zeWorRbCuRvfpkkrB0JDLCO5wE/LUW0fbuhWwQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792933463;
	bh=L8Vta3pDmPC4Ieeel+vjsEnJv0hIBrKpFqMW63AgL4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rz7a2hreGU4lC9+GHPu0ONZ/LV6h+bliT2bFDoPH6OQ5qOUGOnJB7poTZPMDoPrIg
	 jhwNl5xmVX0HsJTDaZPm4F1ffMicbDHlJRLI2qedx7yojrISdTPy/KWKpM0WoRr+Xg
	 lowQ5kPTvGnOyi/0lw6dKfG2BKZ2g1clcmBTwveLUCjt6GJFGJDTwxgna+lepkQJAo
	 ISIhhzNJyCnJC56AVZ3ITT/AFbp39v6vqmfLXGiKjUsfr+mDJ8uXcrEnCkS76jeX1+
	 9KfBdLWVjd7gRkrWuAqjnqVdZhuheYlFAgoSVUCHKuHRvs3UiM22HSrXGmPupBoMTm
	 0tEXO7EWR2GyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CE7380DFA;
	Sun, 25 Oct 2026 13:04:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 00642356
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D9DF060F30
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LmkNeWo91Vfc for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 13:04:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EAD3660782
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792933460;
 b=hlVVNZtYYP4LCaResDGP9zvHzQ3bTChYXM4doaboyV/Pivk9xNIJPjOO5m0PSQNSra0f
 vTL5WcAiCzZuX5diuTGPqTRazYUtn2dW7+LkR/Fa2bsN6AnyP9FowltfjGBbTnuBSpBs3
 dnlIhNecvVl6wjXf0Cc8gQ3wR1kySdY++hHNDNDNhJxtVKSyxNElsw+A/f2j/hRD73H6e
 Cpv2FR62kBfdvkVxg0uL4Eh7YK52bW2YON0HbPcvcgu9u5rudViNcwGGFlMai4X4MMSm2
 BiblTv9bBVKraPxABnTeptvlKcZi5BAaq4s8uBXmXlpZI5tLvUwLCe/Gs/jYovjle/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792933460;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=L8Vta3pDmPC4Ieeel+vjsEnJv0hIBrKpFqMW63AgL4M=;
 b=efJdUOSarFGoMTQeqV4G9meeNFYwi1B8+qFgZ+Xfj7rh70ymIvMNmyisY1ezZqy1LL7+
 7RWSfZB5NJqC1SSvPpE2DsLnS5jPl4AgQ4cE5Y6HiP4be1OyUh9gt64hjtcBbuqNWK6HW
 0oONv+Bh1tJIP2vjMxSXnCMhd1MrLBMSADyU/iJTP3fwsng+TNHQeyWCwNa7sfokxRm8N
 y0153s4/td5dTbsd2ueA1d0oN1vPWuWg/YUJkKVRY3mD0bhFUV2SREbr8xaZ7Dtsl/2Fr
 pKPqdAhMJ5Mg5OpnpvL2HcczlluQHbSdKoI/0ADxz6BDTkuS1vkPAKFcfWQKoGg7jpw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eJVk4gm7; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=eJVk4gm7
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EAD3660782
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:19 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so24690965e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792933457; x=1793538257;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=L8Vta3pDmPC4Ieeel+vjsEnJv0hIBrKpFqMW63AgL4M=;
 b=eJVk4gm77ZQyNSHftlknLiLxb9IZF0BcGpQM3rCD7MZeDzMqV9QVC+SFRpt/bCBlL8
 KYv4UVzO4QlkgpPEwtpDSPrsVUnj5OVdiAn83aUSH1XDgGDPZJTNKYo6zxZlbUMcHMhw
 B5XxsPLRnQ4dvrJiwmk/OYFgnV2iXp3CKQKthpYjRSYpkDTlEuMKfTUjfEbXwXElTLyd
 PrJCiKX4nWYsYbXoAfz4iHTwoSCTyfzPQhkrimcU0MPAbHiA87XiPWi6Csub4FSSZpA8
 QToisDxPP6oohuqGYq6ZUNB3JivJmYtP9FgMLFhIohSw4ZvBmu9nOCGm/LBPLj2Ob681
 9IQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792933457; x=1793538257;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L8Vta3pDmPC4Ieeel+vjsEnJv0hIBrKpFqMW63AgL4M=;
 b=GjpQU2KAdIc1qjg/iGaViGBb1ghPoqTtTaoV14xs5LZWOERGYSHdeMM7Nj4JTzaNAN
 07TLohXU7l05SP3Ftt4qivWeCnzVM3NOSibmahIhk3AWI9UAgshC6KDgl75ZC53tJD1D
 nSzxRC0Z+boSzC81BiK7lFNxSxFS+goIuHHhqpz+Od7MBfwKY3y9nQARJiWdL4r8XBWb
 metwm+vq2EWZ2ATu56gp6vIb1RBcEmKrMip+/7FVwQAooFdCHlyzNnuEJIGzYxDaW6Of
 N0YRluDW5hYRZNcpbQuKw0sOHfpZeJwBhqVWNKJpTsh7chY1RgJ8MAd7N/a7KK9n5IsN
 cg7w==
X-Gm-Message-State: AFq9FYJAg+r47FR8LxozKJFAqaGeJSII+UwRuNJ0gWwMi5UToK4zWYSU
 jmqdckV5hZ5cO5G2B8f8pr5+nJblYvAKkDtdQEUlALSU9Jd2bAMeslZJ
X-Gm-Gg: AYBFou0Okh1YfyGvwMli8mm6HtnemeVBZ08SvXDiXtmhmPsdwHDBpi/7m5qmqMPpgme
 C+pJex+kDI+1B0CJ0GFLWhbPdsOpk+NW0YrLIOsf3fghwRN54JRXdmUkw9gZ6pDT/kblQixzFWt
 6/Td1G2ZxGUTMMRiHI2KrwJ06e0e48DQ+QH2DiOyNOupjrp0BvJwB//dqR/4nDV8hxTDm7kAby+
 ldtQHB5G3GMVpWyq3P5VFSuLMBpZu150ubK+aAlUydGriwaYVEt1XvCDOMa/ZzX70J8/lzTcjwY
 QuV1TYtFodrAFsCqbPnzAu0liV2EFu9rFxZ+rnN5CuTMsTeUSJ3cbTmBv1SNHxatogaPRolhm/A
 iW09o46sNtxHM+hEk2OX4HQZBG02awpfQnMNBNX5gmHd9YodcG2sazqkoheEmLbNG8vogZBUCi4
 pHM73+Xw8dkuLebMcJQx+wf4EmmQfzrZnEUMAOfVBckgxA4/N4kMrNNqMmVOls77VvcGpxaYQKH
 ifvp4T0/zS+HO+0yIpqveJF+HOKYQApTel33wJzHdmOu0MIOdi+olB/5HYe4VNDM0hEVPwJDcI1
 yR0=
X-Received: by 2002:a05:600c:3b93:b0:4a2:fe3:121b with SMTP id
 5b1f17b1804b1-4a35acb0791mr77810285e9.28.1792933457305; 
 Sun, 25 Oct 2026 06:04:17 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3c32sm10351333f8f.47.2026.10.25.06.04.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 06:04:16 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH RESEND 2/6] fs: ext4: fix the triple indirect cache check in
 read_allocated_block()
Date: Sun, 25 Oct 2026 13:04:15 +0000
Message-ID: <a048c826-bda3-46d8-8abe-2b24e32d5b0f@gmail.com>
In-Reply-To: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
References: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
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

In the triple indirect branch, read_allocated_block() reads the third
level block from ext4fs_indir2_block[(rblock / perblock_child) %
(blksz / 4)] and records it in ext4fs_indir3_blkno, but it decides
whether that cached block can be reused by comparing against
ext4fs_indir2_block[rblock / perblock_child], without the modulo.

For a file block reached through the second or a later entry of the
triple indirect block (rblock >= (blksz / 4) * (blksz / 4)),
rblock / perblock_child is at least blksz / 4, so the compare reads
past the end of the blksz-byte ext4fs_indir2_block buffer and can
make the lookup reuse the wrong cached block.

Use the same index for the compare as for the read.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 fs/ext4/ext4_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index 3aab1c87233..cff112fb99b 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -2008,9 +2008,9 @@ long int read_allocated_block(struct ext2_inode *inode, int fileblock,
 			}
 			ext4fs_indir3_size = blksz;
 		}
-		if ((le32_to_cpu(ext4fs_indir2_block[rblock
-						       /
-						       perblock_child]) <<
+		if ((le32_to_cpu(ext4fs_indir2_block[(rblock /
+						      perblock_child) %
+						     (blksz / 4)]) <<
 		     log2_blksz) != ext4fs_indir3_blkno) {
 			status =
 			    ext4fs_devread((lbaint_t)le32_to_cpu
