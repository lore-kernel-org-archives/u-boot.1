Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589CCC87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 18:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A883843A9;
	Wed,  6 Aug 2025 20:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="elU/W2L7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6221084366; Wed,  6 Aug 2025 20:15:14 +0200 (CEST)
Received: from mail-il1-x164.google.com (mail-il1-x164.google.com
 [IPv6:2607:f8b0:4864:20::164])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90A2D843B6
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 20:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-il1-x164.google.com with SMTP id
 e9e14a558f8ab-3e3e6fba91bso198265ab.2
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1754504105; x=1755108905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lc9IcYpTaCjAVhOSKmb8ARINjdOAVVICgJdTGM6pwlw=;
 b=elU/W2L7Sq9W4G9kJ6iadahzHQW5TC9syVh4DGuOuhGihM519HVYKYeWzxNSar9Pnj
 oqeoJnSQPqC3+8fIy+u6U2HBp29cJFdJF23Anql6quP47TWg7RQSszGwko7k5r5B0gWB
 pMYKRG9X+vRViVW9nZksappjqhflHJKOyOuYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754504105; x=1755108905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lc9IcYpTaCjAVhOSKmb8ARINjdOAVVICgJdTGM6pwlw=;
 b=vgIWUV93d4QP2B8i/k7My8mDxxzitHpA/hxuD15mV4dY+HHteKp2LBFxY85POrwabm
 FCd4gRDzqqtBRQQFj4q38LsPm3aG0ONXClUzJiTB3/3y87+WtRl2k0EjDPWKVHJY7Szx
 gnT/18m0i29ShWaPRFwU+1qAvAH5dZnokfTUPvXVdOmMpsE7sgso76i+feyp0txyhcG9
 RJCBgQlv0D/fKw/tcekz4IklcDJ43ZYo7Ef/3lp0dj7C6FIdQsQ/dRIJ4p97m6pU8ust
 j8EUyR7eN6VfqLOMcHLBHb+vYQSWN27hbwAQR4pqqpE+UIrril4dGTarJJ8rV607mkp5
 FOog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHYC0vxKb/DI/cozLJq800nBsApYHMsgp80L1c30SLdcYVmokJTPPycCOhgRwGhtQ0Q3qeBtk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/Znmmwl9wkkkPHdO5idltomaFiTk2hcqVyK6UQEY59j4ET6gd
 +1t78AuSGw+kUEt4hDL3Nw2HOW6VcuwBPz0xyLujoY4+mZoDB05gtYwisDExiPgl6JMFzAzNu2g
 1YLfE8iPMneXVWzSixsctVT1Xtb4gCDQuSQ==
X-Gm-Gg: ASbGncukjFPU6yL0cADmfRxgZqnwH3ATtHxBN9UPlPhOeKCGCUWOiXvJInBJTGkYjB7
 TuAX/1K60rK/y05dUZ6SYFRg7P8httuBfTK90STCO49EvrKECDpRKuIXvA6VB//1orlPIVZYahz
 vnFqd2W3egjPU+r3HLGrS1rVUjJ5QQopkaJI9Ikn2qASoYAU8loGGbfMmIYcA73oePAAc08x2Ru
 4y2P+Mz/cKHXTXat3iV9uIhC2mEa5GZueOMeGlRm5v4TS3xgt2REhVRwaX9fik6YIecj+29S4Jd
 89hMnmgu8ByF+1emIlG4yy26jOZNfMXShkR4VIrqKMWnAbQkKSI3ifGzzTHiYM6NxdPb0/tvBde
 RJ7jumxbz7hbTlw==
X-Google-Smtp-Source: AGHT+IHrgAH7psmm9dhNZU+Uhv2SigKOg5l85Y7zIQ4RuIqXm1o1z3XK34nrTqwVb3VhKADKaEyZS15Al4+O
X-Received: by 2002:a05:6e02:12e7:b0:3e3:d517:d29d with SMTP id
 e9e14a558f8ab-3e51b92f87amr18367185ab.5.1754504105524; 
 Wed, 06 Aug 2025 11:15:05 -0700 (PDT)
Received: from bcacpedev-irv-2.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-50a7e17fbfasm434156173.50.2025.08.06.11.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 11:15:05 -0700 (PDT)
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
Subject: [PATCH 3/4] cmd: nand: nand dump display update
Date: Wed,  6 Aug 2025 11:14:02 -0700
Message-ID: <20250806181450.2324488-4-dregan@broadcom.com>
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

show characters with nand dump similar to md
along with offset into NAND

Signed-off-by: david regan <dregan@broadcom.com>
---
 cmd/nand.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/cmd/nand.c b/cmd/nand.c
index cb2a61a2e57c..832e990108c5 100644
--- a/cmd/nand.c
+++ b/cmd/nand.c
@@ -37,6 +37,7 @@
 #include <asm/byteorder.h>
 #include <jffs2/jffs2.h>
 #include <nand.h>
+#include <display_options.h>
 
 #include "legacy-mtd-utils.h"
 
@@ -198,30 +199,18 @@ static int nand_dump(struct mtd_info *mtd, ulong off, int only_oob,
 		ret = 1;
 		goto free_all;
 	}
-	printf("Page %08lx dump:\n", off);
+	printf("\nPage at offset %08lx dump:\n", off);
 
 	if (!only_oob) {
-		i = mtd->writesize >> 4;
+		i = mtd->writesize;
 		p = datbuf;
-
-		while (i--) {
-			printf("\t%02x %02x %02x %02x %02x %02x %02x %02x"
-			       "  %02x %02x %02x %02x %02x %02x %02x %02x\n",
-			       p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7],
-			       p[8], p[9], p[10], p[11], p[12], p[13], p[14],
-			       p[15]);
-			p += 16;
-		}
+		print_buffer(off, p, 1, i, 16);
 	}
 
-	puts("OOB:\n");
-	i = mtd->oobsize >> 3;
+	puts("\nOOB:\n");
+	i = mtd->oobsize;
 	p = oobbuf;
-	while (i--) {
-		printf("\t%02x %02x %02x %02x %02x %02x %02x %02x\n",
-		       p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]);
-		p += 8;
-	}
+	print_buffer(0, p, 1, i, 8);
 
 free_all:
 	free(oobbuf);
-- 
2.43.5

