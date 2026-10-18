Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58FCCCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 08:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 600BA40856;
	Sun, 18 Oct 2026 08:35:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MyirMbWx0Ooq; Sun, 18 Oct 2026 08:35:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 90C3840949
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792312529;
	b=Os/ztQh7gCCBKUK76EG7XQBdRnRbMiThkvEPXWGD7pYsviJQwBDCJGrBZsAVv/4R2Puw
	 scIgJHQy8Shv5Vlx4OxY6VWIqtHw1ntM3mvjdHC9tq8NilrDEhvW8vrdEFZpmdScbVudB
	 Cqu4HgkVsuLhT0uv307uVGy/RKldRAX6AaTgcVKxaKWGJXmlo/CaeHfYqVy413ZgLPTxc
	 wNrE4lYiwJdYUIG/ivaVLgEzSGHwXe8ErFqxtCXsLjQtwyCB4ov7VH8sBPlMZUjrsj9k2
	 88xeD4H5ZF0+lo9wXUet0oLoztYDizSU41Fo6mqWEjkcI1NBIW/6ZOJlNeb90qftRUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792312529;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=i4oBiLqGrQ+kyiFcWXfUMjmcxmvmaMmfFtbDbzyY818=;
	b=jFD6CX4bAw2xU7Gj2IE1xIUDj350cWQaI0bE0iVYur4ljRcsU8Hm+rqIZ7UqEO18jk20
	 atQjPfmgCruwKEDuoCT+mnygW2udyzSVRS/4egH0fuyIrfwpcBakwQm5P1S55XffJtiMo
	 22rHUF+tblx1+m9dfCiE7/+copqQsdZlUmF7RTT9Zg49VyKM0YQ2yxRq5nZmAXYrCotQY
	 t4iRbpWrGz4ckQWuM4Oc7egKeJy+i1oqI1Z35iyiL/Fyvqo3Rz2b+lYke1Ra45AL890qs
	 0et9dfHp5zg9qnfMHulDvR8bsG+4iuZaNYKhdw1VnFEiXcMtXRgEOBWc/Bdk2GkbulQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792312529;
	bh=i4oBiLqGrQ+kyiFcWXfUMjmcxmvmaMmfFtbDbzyY818=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cMeYxgkwzYPOPMsPRjzKrFobKorA48O4DUBpbbQn+WnnuCPX2F2iZSC2wTka/Ah4a
	 RUOjkSFhTrubrwubze+ll6GIfylLfSn6O36MBxK+68veSzWjASekCGQaXKgeuGBaTi
	 dKdG+meqQFZIIjOZLtQIjgjcb1woWrahlWpDqdyY5QjN0i/zWK0fb7dl865D9Tc3og
	 IOP+OBfTwRUQZbuO2/wUI0ytARkZh5YBnGQoeeK1EEuQ1aaBVRsYXqobJ/jhzm7idI
	 uJmMTwrzmqlCNTULPHSdcmNxEyZBhNf80vFWjoM1Yahl/YndMonwtScJJQPj5fu/zL
	 kSJgZ5jo/jJ7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90C3840949;
	Sun, 18 Oct 2026 08:35:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 019FC75
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E7130400D8
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Ipy-QaaLC0u for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 08:35:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D0A894008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792312526;
 b=ZeazPKv78o7xJsH/7y54xG5vbb7ZeXzLrQLDN97h6ynWAXANnfHcMpROy7psFouCF/oG
 MNNNtDdfil1O66QjFLELbQpVJpRu2caNpFk0HGPNeWBV5AV8EsMfclvLNU8c6SGCajUUY
 W+Qg3w15DZSQv49b77KMHnZ8GpneNrw/zFOWa5mNDe/MZODkN8hI1dOrmuPhmu5J/hHoi
 4puRARbui2JIFAZdCYrgGh2lVjkdoPX2rcyLUomaI+34UCnpL9uUNzuHsi1HnjeX2ElP1
 1ly9KunYnnKHphw0pdG+OwAHKqbBybMXtZYuZnC5voKU2kwh+rpoHFQDSj9fCGW8W2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792312526;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=i4oBiLqGrQ+kyiFcWXfUMjmcxmvmaMmfFtbDbzyY818=;
 b=k1TE+CLAn+aW72TcVbVAl4aRJxFomp18CIgB8lAhu28+TJxeusrui6yJP7YbRxuzYSjv
 e7yWeChmzh+wbKgJIWQJzj6nwpVbN0hzcos42LEWSa7EiTh+cgOVZffixJxPQ/AhBUxBO
 viHyY6v8HXKTSum1PUzIoCYOWZPPHWJaQHTfcuQct/2RKL+h3EQAZC5yW4i9as9TNTWm6
 jCthrlzSL/YlprWfbtYnfI4RK88hTn7P14ALFxtnFWmEsn8UKb1mSmcS6619BkndZfY0t
 q/qcUuFzbVsWVGdPZTHigsZZvvyR678KybrEOK3L6l5WwsKJ2lnJfc2uTmFcjn678cg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CxpYNAmM; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CxpYNAmM
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0A894008E
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:25 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so14792075e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792312523; x=1792917323;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i4oBiLqGrQ+kyiFcWXfUMjmcxmvmaMmfFtbDbzyY818=;
 b=CxpYNAmMl0NzfCW2vej0Kzs4ONPB+h7x27L5ydBxNLQATY5h+XKOBqWJrX+msON63f
 tWJq7+E/DuQNptFH61UuimnA49X1Ma0CxfwTbWTAFSg3T9flJgiT/CstlIkI7Plv1/DP
 FdrAQ/jqRH1vlfp4ORy+tim/K8beXMg/IuuPtKPp1iYXuJfZ0Deh0MFGxaYTTOl22czB
 u0MrpXqZ0O4M7zYNWJ68OhZE+cpAQozxQTQILjOUfekWLVbeoGfcInHRpwwLpNFnsSUY
 e8GfSv1ZHwh+Xn0D1pczx5QCFBPTdZzVnNaqryHNO+4tUQOqon/vDTzUOIfwDdbsEsQO
 5RDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792312523; x=1792917323;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i4oBiLqGrQ+kyiFcWXfUMjmcxmvmaMmfFtbDbzyY818=;
 b=JRY4OoHSbRQS8GAtaABw0qM9Dx+1mNsA74GExeZe8PasFJ3hrkJPGOLRY48Xb2+e0U
 326KEtRpO8Zw9iqFpoALC5SnkU/RpAD31D5T8EZSH497Emog/dr5/aheoLjRY9zdk/vv
 LW/YkxqpQBmSsuk0SJm39JPcei/0c2QbIQ5eTp/3u07gDyeC+PgHFPdrieB8RBNhpGAq
 4IwBkB15e66gRfRKJPHu5abaxe8vW60b0dQJ4mkrb0cpAeF4obRTOUY+OSN+foHiXkO+
 /bHnJ1g6Hk00Vgg7IZe3gCZCsNmsVElvWpIjUOOVWSu2KeL57Gts4MpqZ4sJ19GGT88H
 mx+A==
X-Gm-Message-State: AFq9FYL435+L0P90rStx/VN8BiuY5ew4oA94ekiiyTMcW/OZe1qYfHMa
 eJsm1xyvJi7z+rzgiRc2COoPwC8z0kYByglhUCDORJQhIkbVB25RzvfclM5PYKfJ
X-Gm-Gg: AYBFou1/EZ/Jipnb2604iyKNCu8kbDqwQEeWkCKnEYRAoT+EXKAchae7E2af8KFNiv7
 F4wOe5tJFRRvTWPGdxar+hjEbXSbEB4VCQvQlAJ/hyrtaIDKhx7tolX9uBL7Lcr13VS47A23tYR
 wrEY4+yADgm1qUYmZnrwsB6xFOZE/24zLFEL+LGfDNixYW94ScpJIg01LgROTMg92SXVKaOQF4G
 ugW/HS4bOuQxAWk6NHyFLEGk0imrJMa/K6jGKiy3CjQsnnpJnMOzHVbR9UJxFOG3bfFQ8qTWMsL
 WvOtrAflAV/lBKHQTfBVn7A+u6mNHZD35Nmvzx2VZ9kuQHTTpsQQzqlbJrUwX90EPr/vl6lptU0
 x1SRgOo8qvYHWEpvytkSDDoqP1Zx69fLZwB9Mr3YxX64/jpV+oDa72NT2EcEDVP0B5+wZaVah3+
 EQuijbFwfbnZ9MGS+kQSl1RBMj9JOIp3Y/bKguskuki2w322u4uh1dbJvahKBGdO6yY0FyCn2+s
 HK5PGIoqSAGKTANykoBO/laRnTQokFb0BvkFKfFUUmb9mDOAzN3wUgkgrO0LQeLR/mFif4iSurr
 Jeo01XD12k46Hlz8BNtK7gWzYRJrpCHpRUnfL0Zqa8ceWtaEotvxD8SSTP/BtyYUd9y5J8XNgjn
 pXELWGM8o9/yeHE4/uymo/7A=
X-Received: by 2002:a05:600c:4fd4:b0:4a1:cedc:ab49 with SMTP id
 5b1f17b1804b1-4a1d7633b40mr89439235e9.31.1792312522940; 
 Sun, 18 Oct 2026 01:35:22 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz.
 [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e3ebb3aasm43589595e9.0.2026.10.18.01.35.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 01:35:22 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 01/14] board: nxp: p1_p2_rdb_pc,
 p1010rdb: Drop unused SPL gd copy
Date: Sun, 18 Oct 2026 10:35:03 +0200
Message-ID: <20261018083516.49229-2-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
References: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The SPL board_init_r() of these boards points its gd parameter, which
shadows the global gd, at CONFIG_VAL(GD_ADDR), clears that area and
stores bd, the full malloc flag and, in the NAND TPLs, the location of
the loaded environment there. The SPL keeps running on the global data
that cpu_init_early_f() set up in the initial RAM, so nothing reads
this copy.

The next patch makes gd LTO safe, and gd can then no longer be the name
of a parameter. Drop the copy and the stores to it instead of moving
the global data to CONFIG_VAL(GD_ADDR): on the P1/P2 RDB SD card SPLs
that address is 4 KiB below the stack top, and the 8 KiB environment
buffer of env_mmc_load_singular() would overwrite it.

No functional change: the SPLs and TPLs lose only the stores to the
copy.

Tested on CZ.NIC Turris 1.1 (SD boot, with the LTO build of this
series).

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
Cc: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Marek Behún <kabel@kernel.org>
Cc: Marek Mojík <marek.mojik@nic.cz>
---
(no changes since v1)
---
 board/nxp/p1010rdb/spl.c     | 9 +--------
 board/nxp/p1_p2_rdb_pc/spl.c | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/board/nxp/p1010rdb/spl.c b/board/nxp/p1010rdb/spl.c
index fc26cef2cc8..7c36026a55a 100644
--- a/board/nxp/p1010rdb/spl.c
+++ b/board/nxp/p1010rdb/spl.c
@@ -60,22 +60,17 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_VAL(RELOC_STACK), 0, CONFIG_SPL_RELOC_TEXT_BASE);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
-	/* Pointer is writable since we allocated a register for it */
-	gd = (gd_t *)CONFIG_VAL(GD_ADDR);
 	struct bd_info *bd;
 
-	memset(gd, 0, sizeof(gd_t));
 	bd = (struct bd_info *)(CONFIG_VAL(GD_ADDR) + sizeof(gd_t));
 	memset(bd, 0, sizeof(struct bd_info));
-	gd->bd = bd;
 
 	arch_cpu_init();
 	get_clocks();
 	mem_malloc_init(CONFIG_VAL(RELOC_MALLOC_ADDR),
 			CONFIG_VAL(RELOC_MALLOC_SIZE));
-	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
 
 #ifndef CONFIG_SPL_NAND_BOOT
 	env_init();
@@ -88,8 +83,6 @@ void board_init_r(gd_t *gd, ulong dest_addr)
 #ifdef CONFIG_SPL_NAND_BOOT
 	nand_spl_load_image(CONFIG_ENV_OFFSET, CONFIG_ENV_SIZE,
 			    (uchar *)SPL_ENV_ADDR);
-			    gd->env_addr  = (ulong)(SPL_ENV_ADDR);
-	gd->env_valid = ENV_VALID;
 #else
 	env_relocate();
 #endif
diff --git a/board/nxp/p1_p2_rdb_pc/spl.c b/board/nxp/p1_p2_rdb_pc/spl.c
index b07f481fbf9..6db77682e3c 100644
--- a/board/nxp/p1_p2_rdb_pc/spl.c
+++ b/board/nxp/p1_p2_rdb_pc/spl.c
@@ -72,22 +72,17 @@ void board_init_f(ulong bootflag)
 	relocate_code(CONFIG_VAL(RELOC_STACK), 0, CONFIG_SPL_RELOC_TEXT_BASE);
 }
 
-void board_init_r(gd_t *gd, ulong dest_addr)
+void board_init_r(gd_t *dummy, ulong dest_addr)
 {
-	/* Pointer is writable since we allocated a register for it */
-	gd = (gd_t *)CONFIG_VAL(GD_ADDR);
 	struct bd_info *bd;
 
-	memset(gd, 0, sizeof(gd_t));
 	bd = (struct bd_info *)(CONFIG_VAL(GD_ADDR) + sizeof(gd_t));
 	memset(bd, 0, sizeof(struct bd_info));
-	gd->bd = bd;
 
 	arch_cpu_init();
 	get_clocks();
 	mem_malloc_init(CONFIG_VAL(RELOC_MALLOC_ADDR),
 			CONFIG_VAL(RELOC_MALLOC_SIZE));
-	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
 
 #ifdef CONFIG_SPL_ENV_SUPPORT
 #ifndef CONFIG_SPL_NAND_BOOT
@@ -102,8 +97,6 @@ void board_init_r(gd_t *gd, ulong dest_addr)
 #ifdef CONFIG_SPL_NAND_BOOT
 	nand_spl_load_image(CONFIG_ENV_OFFSET, CONFIG_ENV_SIZE,
 			    (uchar *)SPL_ENV_ADDR);
-	gd->env_addr  = (ulong)(SPL_ENV_ADDR);
-	gd->env_valid = ENV_VALID;
 #else
 	env_relocate();
 #endif
-- 
2.54.0 (Apple Git-157)

