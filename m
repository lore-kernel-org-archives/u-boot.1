Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6689C54798
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 22:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1BCD87D65;
	Sat,  2 Mar 2024 23:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Bl/T+For";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="x7qrdkRg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EF5C87D74; Sat,  2 Mar 2024 23:55:47 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B68C787D5E
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 23:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TnL0J2nW4z9t3m;
 Sat,  2 Mar 2024 23:55:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709420144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DnbM8RxYdQAl3XQ7pmyWxw7N9+oLBjfFqL8dREJxSfs=;
 b=Bl/T+For6D81hjYY5NwUXEYZtIXx2lXEqx0yG4p6Lqcu3hLHJA8D5lRAT0Q8Ub+mKElRrA
 ueZFsWDpEUahzYzxpBzfP2NsFIww7y/0S1E7fII84qJOCYEDi6ccLfGvZKJPnFvtAWpDe7
 tg7kn+bDON3lQeMG09vw9J7LiqdGP7/SczOsFxuXvU4kCt1xdLDKdwwM6gOr7Gy8zqSgwb
 mQJZ9BGe/hCeK9IVj2aZXPR//fOOPfM1Rls3RcDWXE7zqTHeDUnkft3BGuyGFXlAyMMIrl
 HwQh+wzq+tx/rWKKxZcrcBjVNQCTdKoHoS1NxBagO9y9HRx9IgHbAHsgU/9oUA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709420142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DnbM8RxYdQAl3XQ7pmyWxw7N9+oLBjfFqL8dREJxSfs=;
 b=x7qrdkRggsBd3fxqDd9kF7bIED4mE94l+jpSXmy+kgNZm9CrUhsqylv9cCaVAN6x97Ouem
 vLlJcu6h8CyFr2Sl0oLrsYTHuD1W6NJ9Nn/lPfexo3zANiup3SFG1zA7yIHE8JeAB76YNi
 wqLeK52xwNHunczBGBca/hq1MgDBQZQDd0/71nkE5QNxkVN8hhvMglFiIEnEWW5N0khsv4
 8LWha/EjiXXs8/fS/2J0pwy0HRWupsSjl1hUOs/V7VVe7DB/52UxMEziEKaFtePykTj4R5
 NS3VzqRjMT59Zks/pNpzFdvSmu2ZVNOQX+DzqaF21hihsIpRYIIb3WBs1s5Dfw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Wolfram Sang <wsa@kernel.org>
Subject: [PATCH] fdt: Fix bootm_low handling
Date: Sat,  2 Mar 2024 23:54:02 +0100
Message-ID: <20240302225527.179601-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fi7gufjquf9resfit9p4pcc3gbddqx65
X-MBO-RS-ID: 43b70a76d72cb120a9a
X-Rspamd-Queue-Id: 4TnL0J2nW4z9t3m
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

According to README CFG_SYS_BOOTMAPSZ section, in case both "bootm_low" and
"bootm_size" variables are defined, "bootm_mapsize" variable is not defined
and CFG_SYS_BOOTMAPSZ macro is not defined, all data for the Linux kernel
must be between "bootm_low" and "bootm_low" + "bootm_size".

Currently, for systems with DRAM between 0x4000_0000..0x7fff_ffff and with
e.g. bootm_low=0x60000000 and bootm_size=0x10000000, the code will attempt
to reserve memory from 0x4000_0000..0x4fff_ffff, which is incorrect. This
is because "bootm_low" is not taken into consideration correctly.

The last parameter of lmb_alloc_base() is the maximum physical address of
the to be reserved LMB area. Currently this is the start of DRAM bank that
is considered for LMB area reservation + min(DRAM bank size, bootm_size).
In case bootm_low is set to non-zero, this maximum physical address has to
be shifted upward, to min(DRAM bank start + size, bootm_low + bootm_size),
otherwise the reserved memory may be below bootm_low address.

In case of multiple DRAM banks, the current change reserves top part of
the first bank, and reserves the rest of memory in the follow up banks.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Niklas Söderlund <niklas.soderlund@ragnatech.se>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Wolfram Sang <wsa@kernel.org>
---
 boot/image-fdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 75bdd55f326..5e4aa9de0d2 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -217,14 +217,14 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
 			if (start + size < low)
 				continue;
 
-			usable = min(size, (u64)mapsize);
+			usable = min(start + size, (u64)(low + mapsize));
 
 			/*
 			 * At least part of this DRAM bank is usable, try
 			 * using it for LMB allocation.
 			 */
 			of_start = map_sysmem((ulong)lmb_alloc_base(lmb,
-				    of_len, 0x1000, start + usable), of_len);
+				    of_len, 0x1000, usable), of_len);
 			/* Allocation succeeded, use this block. */
 			if (of_start != NULL)
 				break;
-- 
2.43.0

