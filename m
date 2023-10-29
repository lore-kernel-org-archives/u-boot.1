Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3203DC4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 03:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B817787C75;
	Sun, 29 Oct 2023 04:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AXxIbugj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F72287C5D; Sun, 29 Oct 2023 04:49:01 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 149A887740
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 04:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-66d12b3b479so21964106d6.1
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 20:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698551337; x=1699156137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znPtt4Lt3TrrDmOEnrGnfGglc/BFZ4f7z19ngPmKdqU=;
 b=AXxIbugj2alRIDnkgViStKNva9QagXrmMYa4kHhngbhn/snWZmCuUlUUcoWGE8IdgE
 D3tG/D0vNcOuG891fHj/WgXUI3OM7Q4Z/NA0Bflp7sVoaZ9zM2Sim1Wh+AE4TShPPHbO
 1Jeu1k4SSGsFd+aCe1vqeGMS/Crq5WdloN+vS63ihLuLW02zGmwWbhUkgBawexKgd8Hp
 FIdxq4RjQ6SCuH620E1CGAKPYQJDsQ32VG5er76yBphyVIG+fM3DOVYqjYp9L5v2687q
 mPcq9QbzL2heoaWsTwF0cOe81UpmyCvRquohTmj/Ik6S/pvDtGpylv8SnIWSFGux8F1l
 LkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698551337; x=1699156137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=znPtt4Lt3TrrDmOEnrGnfGglc/BFZ4f7z19ngPmKdqU=;
 b=VAsLw9KMzfQT8bPx2KMjxpsAIzBX8C0ZVDTWKKMJiVVOXZoT9JwHx/IXP1XrxvWi8t
 Mtrs4o9l+cfOOhrYgHcYEdnprfWfr4RBUjIIVtdKx0Jch7i1N20pAIuu8N77Jz4KW/Eq
 MWt4VCuXARmzF9FE7feguvzcZBlDQ30ObDe56CMGLcCM53QeWpn6B0o9oMfJJZAhVRyV
 kY/EvGb1tnDdWN74Tjt7TL9kdjMwhgHtG/tTj0BJzfSxlPJ3OJqwGsh/Ac76cfaTqOfl
 difWzbhH1icRBurSCP43NyzL4edaFVtiYgjpwo3dZq3ziw5fIV0ykpzHybuqRSHkY+nH
 alIw==
X-Gm-Message-State: AOJu0YwUeXxaxKO79rLYzJEbp3rf+8uVO8qmHZqXVFiXAREUfF7kRgNX
 hRkYI86RrgNll2IGrZ2Wq1bDOVcNXHtv7w==
X-Google-Smtp-Source: AGHT+IFfo6x1C8gHX0mCkBw+YBzGNQbehqfYtEXTzsGFwcgvMpom4bZgCC5Ix82kL9sw3PXszrLftA==
X-Received: by 2002:a05:6214:daa:b0:671:e02a:8bfc with SMTP id
 h10-20020a0562140daa00b00671e02a8bfcmr1153998qvh.16.1698551337564; 
 Sat, 28 Oct 2023 20:48:57 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 r13-20020a0cf60d000000b0065b12c7a48dsm2161357qvm.133.2023.10.28.20.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 20:48:57 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 07/15] cmd: nand: Map memory before accessing it
Date: Sat, 28 Oct 2023 23:48:37 -0400
Message-Id: <20231029034845.1169614-8-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231029034845.1169614-1-seanga2@gmail.com>
References: <20231029034845.1169614-1-seanga2@gmail.com>
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

