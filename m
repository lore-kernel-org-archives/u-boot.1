Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783C8C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 089F88721A;
	Sat,  4 Nov 2023 21:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OIBwnqs9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE6C87154; Sat,  4 Nov 2023 21:38:13 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D42D8701C
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-41e3e77e675so20495101cf.1
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699130285; x=1699735085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ic6RF5bBruWdmn1D3Q+sQcYtyqw5MryOKXQ57kn8rzw=;
 b=OIBwnqs9FNoxwbKoVSyLUAPT54SIGUp8GbkrJ2140xO9CTu948Vt++kL9AKRrr/DeY
 DwvP4gc/85RqlRaT0ctnJYleR8wgvwSnTsJv2VMJTdIBizhB3CJkoIU8GwDy9FEr6N45
 hIK17hQZXX6h0/VJdiNXoa6kjuJk8eFn9r4xdmIG6ufr8Msb/t546Oq6EhHBmLwy3XqX
 LaS3WL6Uv8fo+/IlBRgeN9rUSprKvjJJvrDy5Y0oBES7ESeiJJ1KYHN0Eaa7ElcLUpUR
 apX7GkbZwOuhiBDh+S8LWFK/qsAgcZXsyr9y1ELnhf0FhgQoxCC4Lj0UwnqOlHsz3NFN
 j+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699130285; x=1699735085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ic6RF5bBruWdmn1D3Q+sQcYtyqw5MryOKXQ57kn8rzw=;
 b=ToUCArPMK9sFtW1DzS7CVp1okbjVN+whiPxWG71MuaPNErOZ2gnHpYsUjqmLWcbuje
 b3I+/ONDRX6ITBGa+htAphVZti6dTehXawLEb5hLChIsiA35BHEKz5wP8frCHlhzROW2
 gx8itgkkHty/dWUj+JY3w57Ks/ZAS5HAtAy7NxZqQCub3dPpESmnrnRfT3KCpjFY8ek6
 7ofaxXAVoofjnFET3LFEK7V51Iebvj5pTFhFNRC1e2gNAbFnASDW9yFizAnqunjwm4Nu
 QgUVD/TpEhv85OeVE+5HmtGIjl1nB55yLCN33kEqOVXDZIQ77JmmSTwOfIGquKT3kbr5
 ktYQ==
X-Gm-Message-State: AOJu0YxVSFm552CDhOgPXXvlw9p5c9N/rUmpDGAL6E4GrjpispCtVUNG
 kYy/wgvlw1NeMcp7runiQiUIY6bLTiKSXA==
X-Google-Smtp-Source: AGHT+IF58wqTv+5XmxGVOlomyfyzDa4659O69DX2N2gWjc7J1M9t6kt9ioe/ytqkzTQe7t+Rwjgajw==
X-Received: by 2002:a05:622a:1a05:b0:41e:26a1:7b3e with SMTP id
 f5-20020a05622a1a0500b0041e26a17b3emr31310877qtb.29.1699130284718; 
 Sat, 04 Nov 2023 13:38:04 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 ga6-20020a05622a590600b0041eadf108aasm602185qtb.75.2023.11.04.13.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 13:38:04 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 07/15] cmd: nand: Map memory before accessing it
Date: Sat,  4 Nov 2023 16:37:45 -0400
Message-Id: <20231104203753.1579217-8-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231104203753.1579217-1-seanga2@gmail.com>
References: <20231104203753.1579217-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In sandbox, all memory must be mapped before accessing it. Do so for the
nand command.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

(no changes since v1)

 cmd/nand.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/cmd/nand.c b/cmd/nand.c
index 71b8f964429..fe834c4ac5c 100644
--- a/cmd/nand.c
+++ b/cmd/nand.c
@@ -34,6 +34,7 @@
 #include <env.h>
 #include <watchdog.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <asm/byteorder.h>
 #include <jffs2/jffs2.h>
 #include <nand.h>
@@ -432,7 +433,7 @@ static void nand_print_and_set_info(int idx)
 	env_set_hex("nand_erasesize", mtd->erasesize);
 }
 
-static int raw_access(struct mtd_info *mtd, ulong addr, loff_t off,
+static int raw_access(struct mtd_info *mtd, void *buf, loff_t off,
 		      ulong count, int read, int no_verify)
 {
 	int ret = 0;
@@ -440,8 +441,8 @@ static int raw_access(struct mtd_info *mtd, ulong addr, loff_t off,
 	while (count--) {
 		/* Raw access */
 		mtd_oob_ops_t ops = {
-			.datbuf = (u8 *)addr,
-			.oobbuf = ((u8 *)addr) + mtd->writesize,
+			.datbuf = buf,
+			.oobbuf = buf + mtd->writesize,
 			.len = mtd->writesize,
 			.ooblen = mtd->oobsize,
 			.mode = MTD_OPS_RAW
@@ -461,7 +462,7 @@ static int raw_access(struct mtd_info *mtd, ulong addr, loff_t off,
 			break;
 		}
 
-		addr += mtd->writesize + mtd->oobsize;
+		buf += mtd->writesize + mtd->oobsize;
 		off += mtd->writesize;
 	}
 
@@ -675,6 +676,7 @@ static int do_nand(struct cmd_tbl *cmdtp, int flag, int argc,
 		int read;
 		int raw = 0;
 		int no_verify = 0;
+		void *buf;
 
 		if (argc < 4)
 			goto usage;
@@ -730,32 +732,32 @@ static int do_nand(struct cmd_tbl *cmdtp, int flag, int argc,
 		}
 
 		mtd = get_nand_dev_by_index(dev);
+		buf = map_sysmem(addr, maxsize);
 
 		if (!s || !strcmp(s, ".jffs2") ||
 		    !strcmp(s, ".e") || !strcmp(s, ".i")) {
 			if (read)
 				ret = nand_read_skip_bad(mtd, off, &rwsize,
-							 NULL, maxsize,
-							 (u_char *)addr);
+							 NULL, maxsize, buf);
 			else
 				ret = nand_write_skip_bad(mtd, off, &rwsize,
-							  NULL, maxsize,
-							  (u_char *)addr,
+							  NULL, maxsize, buf,
 							  WITH_WR_VERIFY);
 #ifdef CONFIG_CMD_NAND_TRIMFFS
 		} else if (!strcmp(s, ".trimffs")) {
 			if (read) {
 				printf("Unknown nand command suffix '%s'\n", s);
+				unmap_sysmem(buf);
 				return 1;
 			}
 			ret = nand_write_skip_bad(mtd, off, &rwsize, NULL,
-						maxsize, (u_char *)addr,
+						maxsize, buf,
 						WITH_DROP_FFS | WITH_WR_VERIFY);
 #endif
 		} else if (!strcmp(s, ".oob")) {
 			/* out-of-band data */
 			mtd_oob_ops_t ops = {
-				.oobbuf = (u8 *)addr,
+				.oobbuf = buf,
 				.ooblen = rwsize,
 				.mode = MTD_OPS_RAW
 			};
@@ -765,13 +767,15 @@ static int do_nand(struct cmd_tbl *cmdtp, int flag, int argc,
 			else
 				ret = mtd_write_oob(mtd, off, &ops);
 		} else if (raw) {
-			ret = raw_access(mtd, addr, off, pagecount, read,
+			ret = raw_access(mtd, buf, off, pagecount, read,
 					 no_verify);
 		} else {
 			printf("Unknown nand command suffix '%s'.\n", s);
+			unmap_sysmem(buf);
 			return 1;
 		}
 
+		unmap_sysmem(buf);
 		printf(" %zu bytes %s: %s\n", rwsize,
 		       read ? "read" : "written", ret ? "ERROR" : "OK");
 
-- 
2.37.1

