Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD72C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 18:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6F9B843D0;
	Wed,  6 Aug 2025 20:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="ZuOlQAy4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0216580C83; Wed,  6 Aug 2025 20:15:18 +0200 (CEST)
Received: from mail-io1-xd64.google.com (mail-io1-xd64.google.com
 [IPv6:2607:f8b0:4864:20::d64])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B663843B7
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 20:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-io1-xd64.google.com with SMTP id
 ca18e2360f4ac-881a13ac0b8so1329439f.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 11:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1754504107; x=1755108907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CMh8WlbFtok6hW6wfV/ysHFTZX6BHP1W6XJaCbU2sf4=;
 b=ZuOlQAy442U2ymlxmvAdWecdDTimIM3ha7+biN/i9Ijv29xA+16vBjlagM0R92EZsJ
 /z6rUzAN/02Dk6TmKa9MQCNY7Dl60ThLAccVQ338aWHKvVSa6XAWIEOhcKgSQfgYSt8O
 UjQUGx5QGvLV/TPlw83B0hkWBC8ixdWyHnsDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754504107; x=1755108907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CMh8WlbFtok6hW6wfV/ysHFTZX6BHP1W6XJaCbU2sf4=;
 b=EjOKRVTTV5xXRZ3WBGvB5c21kn4qa2pdyHCXqwmSfrEEsvZ3UXCvq89jJW6Fgtgk3a
 OXLUf5ikzmq0g1U4yXMngoNFomJiXzeSjUnL9d/KRIIMm/ZwfZA1SIMbqqW01YcngIa4
 MMfDTTt7mTopQZBoSsvdJ/JeBr99TyrWFala0lpR79/dHUUY/hypX9QlAiSncC8Gj7MA
 GxHQotWPYvlqr5Gaq+alKdJC/RscgenCrGKyJPT7o4lr0sG557vCGFJuCu63tAhh9ow+
 9vLr9acrFsM5f3rhknq+bovluORlniakUhO+R6UFwD/0NXNR/9+rWCVYXWMxhFkUsZss
 za5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRhcrgeMmiWVOcwVVcRqy/L6gt2mYyhL4dPUGsHRWH2DZDBuvFZjxTiRBeOqPnzSz1bT9pBYo=@lists.denx.de
X-Gm-Message-State: AOJu0YyBS4z1fQMhtfj8GgYl214pV38u28SmZ38mf9MHaN918h0MNQPU
 1Erjjzdr6VU25KcMkCmNuEP0BQ5h3eKl+bMrWmSDG3txVSBBFt51Bfy3KKJxn4tn1pZfMfyUOby
 pFS0bFfuFNCatu2MIj+jlVkOPt5x2vob+Sw==
X-Gm-Gg: ASbGnctjUcLn9PEO/Y2jPyebsp6fbhp3XZuHJU8WWBb6Nb1BKq+eD4h8uHBqtg+KVNj
 41ItRsW2IL06Iw/NjxLG4kEs+/77GgJlTmhYkxPPOJGJJ4NUvqidm6hHp5bL+TYG1aw4ubvksw9
 my7PEi7fAfTuQVhBF1Vs7Z2Hsz3ibhVcbUKtpmYLDnkXNlTgppPL5hCDzjidHqmNgdWP+LGOnhc
 ov0J8pIl6s2wMG89tVwtyXEQ4h8pjhISww81dka58xg7pb2k1/Hi8lahX1PaCcrHjKyphdQTjVO
 bteYR7Tm0sa0zeK/WXv8JxLDWaETPzeCQXLuqbCiH6mEjmj+zPNBMpZUyodDeVvnDhFt2T6j/Eb
 jEnYD//nTZ4POjg==
X-Google-Smtp-Source: AGHT+IEBMGCEi8xuA1xIshhCYI708mN3rLoyr1EyB47SE2rfCDgfSy6GTql2hFpoib2b7WemMZ4qjOdY2ud2
X-Received: by 2002:a05:6e02:3a07:b0:3e2:9030:47f7 with SMTP id
 e9e14a558f8ab-3e51b92f587mr17216885ab.6.1754504106718; 
 Wed, 06 Aug 2025 11:15:06 -0700 (PDT)
Received: from bcacpedev-irv-2.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-50a7e17fbfasm434156173.50.2025.08.06.11.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 11:15:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: dregan@broadcom.com, dregan@mail.com,
 William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH 4/4] cmd: nand: nand dump with ecc option
Date: Wed,  6 Aug 2025 11:14:03 -0700
Message-ID: <20250806181450.2324488-5-dregan@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250806181450.2324488-1-dregan@broadcom.com>
References: <20250806181450.2324488-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 06 Aug 2025 20:44:29 +0200
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

option to show nand dump data ecc corrected as opposed to just raw

Signed-off-by: david regan <dregan@broadcom.com>
---
 cmd/nand.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/cmd/nand.c b/cmd/nand.c
index 832e990108c5..b5678b0a0085 100644
--- a/cmd/nand.c
+++ b/cmd/nand.c
@@ -160,7 +160,7 @@ free_memory:
 }
 
 static int nand_dump(struct mtd_info *mtd, ulong off, int only_oob,
-		     int repeat)
+		     int ecc, int repeat)
 {
 	int i;
 	u_char *datbuf, *oobbuf, *p;
@@ -192,12 +192,16 @@ static int nand_dump(struct mtd_info *mtd, ulong off, int only_oob,
 	ops.oobbuf = oobbuf;
 	ops.len = mtd->writesize;
 	ops.ooblen = mtd->oobsize;
-	ops.mode = MTD_OPS_RAW;
+	if (ecc)
+		ops.mode = MTD_OPS_PLACE_OOB;
+	else
+		ops.mode = MTD_OPS_RAW;
 	i = mtd_read_oob(mtd, addr, &ops);
 	if (i < 0) {
-		printf("Error (%d) reading page %08lx\n", i, off);
+		printf("Error reading page at offset %08lx, %d %s\n",
+		       off, i, i == -EUCLEAN ? "correctable" :
+		       "uncorrectable, dumping raw data");
 		ret = 1;
-		goto free_all;
 	}
 	printf("\nPage at offset %08lx dump:\n", off);
 
@@ -212,7 +216,6 @@ static int nand_dump(struct mtd_info *mtd, ulong off, int only_oob,
 	p = oobbuf;
 	print_buffer(0, p, 1, i, 8);
 
-free_all:
 	free(oobbuf);
 free_dat:
 	free(datbuf);
@@ -697,11 +700,19 @@ static int do_nand(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 
 	if (strncmp(cmd, "dump", 4) == 0) {
+		int only_oob, ecc;
+
 		if (argc < 3)
 			goto usage;
 
+		only_oob = !strcmp(&cmd[4], ".oob") || !strcmp(&cmd[4], ".ecc.oob") ||
+			!strcmp(&cmd[4], ".oob.ecc");
+
+		ecc = !strcmp(&cmd[4], ".ecc") || !strcmp(&cmd[4], ".ecc.oob") ||
+			!strcmp(&cmd[4], ".oob.ecc");
+
 		off = (int)hextoul(argv[2], NULL);
-		ret = nand_dump(mtd, off, !strcmp(&cmd[4], ".oob"), repeat);
+		ret = nand_dump(mtd, off, only_oob, ecc, repeat);
 
 		return ret == 0 ? 1 : 0;
 	}
@@ -1031,7 +1042,7 @@ U_BOOT_LONGHELP(nand,
 	"nand erase.part [clean] partition - erase entire mtd partition'\n"
 	"nand erase.chip [clean] - erase entire chip'\n"
 	"nand bad - show bad blocks\n"
-	"nand dump[.oob] off - dump page\n"
+	"nand dump[.oob][.ecc] off - dump raw (default) or ecc corrected page at offset\n"
 #ifdef CONFIG_CMD_NAND_WATCH
 	"nand watch <off> <size> - check an area for bitflips\n"
 	"nand watch.part <part> - check a partition for bitflips\n"
-- 
2.43.5

