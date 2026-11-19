Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB60606A335
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=URAKdfoW;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UbkEybWN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAD0960D7F;
	Thu, 19 Nov 2026 13:33:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yCiKQvDDwkCw; Thu, 19 Nov 2026 13:33:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DDAAF60D7C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795095201;
	b=gIKFaS2n+4BMbG4skZRKwwHPNzY8uv9GL11hPKkwEiwMMGDZNp9Z0AdcZhq9Cug4WH0F
	 61pVSZv4RUfRtF4OlVibf/zdyuEbQ8HW0u0tUYILT04TBT73I+2jCUwc0xHBGF5VgsbWa
	 nrQ1+JhnY2FeUL1Nk9jE2Td/LqTvlscRo2NikBIcqZtLtiEKnRuYVNQrzQO3wmvONkYsk
	 WpW8RZEBweMndRTAyj3nwaVq5r8izJPV99wNKxKRu0zFcBSGBuDFD0+GCwb7V7yVXYQqL
	 Se4LInKByPhZvvZlnmx4TLOgaWFmZ7AC0X2FngrcH3+2reUd9PGik+NLJqEniwGWUTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795095201;
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
	b=YLPD0+2glQFs9YKuBRLZKcpYnqi7bF8Xi34IWazejmapvXcA+ucKVOndvPH3pkca1fHl
	 6D14rH3UVJ0Fzd4Dsb6cCQ2N9o4gaeKFfEr013yNfTubARgZFl9JwAc2uJrXez1XBvNtV
	 WCmB8yxkbskg6WeUPHEbr46BlDAwPGzR0b4PSXkGl7wKreLZeG14tQsYCGhPENN5ID3x/
	 hWfFt+v6HpZYGbU5w0s8ytZ+BM6aQG9/Cl51eghG+PEtTf9fqKjCoLZRLq7eLHuwUaLE9
	 qEr1dUSYCa1zjg18QlGKXZ/rkdLEfMmbcjD8+GXPQq5SWjn7blo+kGsUj9iIAq+hymw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795095201;
	bh=i4oBiLqGrQ+kyiFcWXfUMjmcxmvmaMmfFtbDbzyY818=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=URAKdfoWZI5cfEGTGzYdAcvi+gY4+VOBRbSJe9zn54FP1sjYOH9RTZPWvrfvqvUUs
	 RvY2A/eRxRkH5mWJsIMGG/T84cO7bEPKx9xg0lDQvAxxye+I3wmBThi5ozFnUPQ3WS
	 gOzoA5Nw/+y9oZO9Iy7W+G59Mkghq4kqwyhzePOwRJSOlukezuzmfngO2loX8KyjFA
	 dSBluh0FWgadEt6Y1fZKj0m+czQwiipfpO+UaH8GydpVCdOKu0tGMnfMGjrqKZZTO9
	 jYjuGRQh5jyRuQlY5OQ8X6O5V5gRkNOQ7oYg3unbVm4puIP9fny66Ewrm+AhOgJCyt
	 VAsWAJYGkU4jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDAAF60D7C;
	Thu, 19 Nov 2026 13:33:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C98A022B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C6C4280D4A
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MmpAqkTNWCH0 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:33:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C97C080D62
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=UbkEybWN
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C97C080D62
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:16 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4a68190a2a7so1982854f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 05:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095194; x=1795699994;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i4oBiLqGrQ+kyiFcWXfUMjmcxmvmaMmfFtbDbzyY818=;
 b=UbkEybWN9jafwidYDHue5TUei18BuSXoAFRi/PYv880QdQ24asrEu1P97OvpMcK3sB
 abJiYvMmJqlCoxI8I4WVrUvi8ke3aZEbrmxEoUAy2iKiu1ssVacSjR6Z6J6AEDSt7+7d
 bPffd5vekYBUqLK3ICzEZMFr1MeZ+2wFXoMfzIGsEtf0nGHXyPidARGysmZ3N0fS/c7v
 L8DwEx3aTEMjxP9jVrkxJBrHkomTMypdCxdiiEtES1otUsz7GJNvkxK8e/EqNBnMrjVe
 yRV5MRp2JFhpJEbe0FU82DMxmNJPmjDxnRkGVHEXtQ/vGNc1I9Vi4nIvQltB98uIOtC1
 4+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095194; x=1795699994;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i4oBiLqGrQ+kyiFcWXfUMjmcxmvmaMmfFtbDbzyY818=;
 b=spEtZBVoY3X3UcafgPigRCzEzdxU/gr/bZqqq2ha8R1UGCalm7/fZl8pBhUwt7LCOD
 rIBqA7vh08cpljSCBIrrnRR/yCyd49gDTatOG/nNG+V6/g1ekw+cMM9hbIZbTfZ4OON+
 sUyn6cQiQ0CxZ5ApCZLKaKOJ/YFtnRaA60SEW5TPkQht0qTkpPATx7LA3G5PSCETkxRB
 7OJ5LuGy5n42kzZvqIuFvjcBHIOLnwryArjNq78KGJxO/FUfAkfcRglSCnZJGsx0FXjZ
 9gxJghBW+sJZSoYDAym51jmFh9ADw54XjgEHl2xzot3PXu+izHdNdM9W4LTv9Jx/1lEz
 WN5Q==
X-Gm-Message-State: APuU4Z9DyuL/OGSHnfpGkgWTtbc2HFpHWMjSgvuqKOHJxwS8olUJi/7f
 splcxBBG75dJxiwA2mgRYJhpcLEKPBnvFL8Ug+3Ph8VU0SIKWjPyZjOvfrLKMeNF
X-Gm-Gg: AZFdTZfBwAcxmEXRveFsiECj2FYDq+M4qK56YDWrmDON5HHqBd4q7qghb/BTRoa4NKg
 WxlFf0QfIv0KjI6OZzZEwKENvrE1S5W+DMrLhxRziGLF2kyL0TopFS38GO/Ij22ke6kbGa93izz
 fxdEmcWo+7TiV58AuBXzwNWOIYA0udv/0BztBNyzUdsx+BXqCCDQJrfqqm+sufwdaaTpJUwul28
 i/VEuZhutITesKk5FRZXzBxv+dd7En6pUt9vjIP7BiHCOwxQOqJc9ZiAp6nB15mkrH9WA2B2pTu
 Hqy49LKHVoOIZNilNzQMRsB+BeeE7FxBnnZYPGoXYByJskFpByHyycyxTCBof9WjOBVNNW6BeKS
 eMdXUNNgb5NHIZMyvIXGa0oUpZe70xFFLYLBLTtVK5zh/u25D4F1wRIgwlGCDPGvZeb0fVCNKFX
 a3NA78Tl6C1Mg35ge6PF9zuaYvNDDUjD8IUBqKI+hKD4FtoEzHXz1cXGWrLVqprZjwyNneH6P+o
 PjBgJvDKumQG4fcokHSX1XwyBZMXkLVH5P6TDL1BmJZdh5oAlYLLx1ZXB09SEw87hu53bY5RyeQ
 n3LS1QiAO78+1TntZHSzHPy07lanNguG1blcYobpCp7RlQhVpsUAxl3S+J1h1fCsta3y7Xgb4I/
 TJZzONvhJW17Y0EeB0glNN6m1tU3Hs0zQPm+2X4Fk5HGEhAaYYS6h64b3a/DkUp0DgYOi4VdHA+
 mTLWOZ2ER5rNtYIeE6evLQl8pYWOEZ2/Tz88zKL+PacVZ6k08wVsbIQBf4ANTiPeA2JmzaMB5dK
 w==
X-Received: by 2002:a05:6000:4b0c:b0:48c:4442:54e with SMTP id
 ffacd0b85a97d-4a63b50e9a2mr12212751f8f.30.1795095194494; 
 Thu, 19 Nov 2026 05:33:14 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-0199-55e2-7041-f103.ipv6.o2.cz.
 [2a00:1028:8388:a84e:199:55e2:7041:f103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm11278889f8f.9.2026.11.19.05.33.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 05:33:14 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 01/14] board: nxp: p1_p2_rdb_pc,
 p1010rdb: Drop unused SPL gd copy
Date: Thu, 19 Nov 2026 14:32:57 +0100
Message-ID: <20261119133310.22732-2-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
References: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

