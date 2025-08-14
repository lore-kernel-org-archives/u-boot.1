Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BB4CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 21:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A3D783A8D;
	Thu, 14 Aug 2025 23:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="WZELu7fB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB51183A13; Thu, 14 Aug 2025 20:07:21 +0200 (CEST)
Received: from mail-yw1-x1162.google.com (mail-yw1-x1162.google.com
 [IPv6:2607:f8b0:4864:20::1162])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 933418399D
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-yw1-x1162.google.com with SMTP id
 00721157ae682-71d603c1006so1968087b3.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1755194838; x=1755799638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gciOZC9LClHBOsWu1dBWHhjAlr6sSJyptOHdglYvScw=;
 b=WZELu7fB+aFggmAFT6X+o+G33XCEe7xBDAHAp7Pl5h59ZXgkGAd/jw7bUve6+R+x93
 xkPLpCtbzzRusKEZMPUHvYV9J5MM39VSLffq2XThoiRbgXMirv1wJ125TUcmYwnpb91l
 72Y+GfLdBicZeIP7tkZoXMBo6zNvkP0kR9Vx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755194838; x=1755799638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gciOZC9LClHBOsWu1dBWHhjAlr6sSJyptOHdglYvScw=;
 b=TMSZgdLHOjuKhjPkrJ8Z4LW+n81ubOYv8cddXAEHlCAjQ/w/VOYeD9phVyWoKvOF6Q
 xLlWw+V7Aoyf/ThHZvXkBHbqeJfxl8jzgGUlU85tyHqwAXlh1U516BGVxjQAwEFFd0/t
 qUOJcn0JYS0PGiirIT5ki076QwiSagH2HnVuqklL9Pist8Y0thu9yguoOxkA0EkOFmGQ
 BSi7ClOhv8Wk/lxC3AtTC+aEJK8btAjEhlHkHrgyDviuymRdF3PW8KTrNSbbM/6i1XxQ
 944OSBpbMFBV2AL/bmK+hggoHVufZ0TxYcRE3LqB5fWu5log5CH1DklDDsOAXqM6/MPa
 HJFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzIaNtnzjaB7oX6xF5VW3ussZu7Oo0W2ZzLMfaAB4KYc87mXPB8Kazkjuh8gJ4ZUuh0ZT3Nkw=@lists.denx.de
X-Gm-Message-State: AOJu0YyAXQ5269lOC7Kk8XFfjZ+qbf/2bf2cp3cZ9Sy1Csv24tylUtb/
 EeRIRYuzfjQ3575H/ItB3e+NCkaKt45lupaAuxmLkqdGzkRL+r7o/lfU1L6NCHhtSiHGQWq1iLa
 HnO6o/6euv7ToH13uceC6VTA+J4VaD/VytQ==
X-Gm-Gg: ASbGncvk5ydIupQfrti3/AeZu0abqzVyQNUy/Mjra9chYgUc8Jf/DNxtu2cU4mnOWX1
 UJhBKreT0K44BMmd4URvaHMheKqs2gWkUMEdL3p0xH01Q2pEiGhDdXntAZ00UzN/G4N5CrnsT2p
 N3r+UDooYFL6MCfhVwGRA8d6dHYNf38qi7rw16rL9y0Oq919MgUqlmp+iTX/6Zfu8UxkPMMkb3L
 sUsk4UOO7PjCjT6XQNlT6dW+odaMhr7i25wbEuHDP6cLDJJ4NAatMHRleHIiAj8r2fy/igiSaXD
 eHgv+8+c3xCbJMnaEkonBWdm40JCZFU4C9O3mAw53EUzB2r3X8DfnRMvQVI5M5TRrE0YCGv8NRG
 T2b0VI2xDe5ZznQ==
X-Google-Smtp-Source: AGHT+IHDnTbSfQzkjmXxTDCmgTnAYfdFt7YGTCo8h00JVgeJpqsDEVnCn1V/+4aeN+vzw+uIXehqy1zWEzbD
X-Received: by 2002:a05:690c:dd5:b0:719:dd9e:aea3 with SMTP id
 00721157ae682-71d633f0eeemr28710987b3.1.1755194838349; 
 Thu, 14 Aug 2025 11:07:18 -0700 (PDT)
Received: from bcacpedev-irv-2.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-71d60d6b387sm1970937b3.5.2025.08.14.11.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:07:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: dregan@broadcom.com, dregan@mail.com,
 Quentin Schulz <quentin.schulz@cherry.de>,
 William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH v2 4/4] cmd: nand: nand dump with ecc option
Date: Thu, 14 Aug 2025 11:04:58 -0700
Message-ID: <20250814180647.1805196-5-dregan@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250814180647.1805196-1-dregan@broadcom.com>
References: <20250814180647.1805196-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 Aug 2025 23:00:20 +0200
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
 v2: no change
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

