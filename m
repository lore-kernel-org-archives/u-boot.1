Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E2ACA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 21:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CA7283A71;
	Thu, 14 Aug 2025 23:00:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="XWwcm8wt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67F6B83A25; Thu, 14 Aug 2025 20:07:20 +0200 (CEST)
Received: from mail-yw1-x1161.google.com (mail-yw1-x1161.google.com
 [IPv6:2607:f8b0:4864:20::1161])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D90D883A15
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-yw1-x1161.google.com with SMTP id
 00721157ae682-71d6051944dso1034577b3.2
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1755194837; x=1755799637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=amUHsvu0KUaNn8tOsLnwJF9WJAz8QKDvPF6hS8l+25w=;
 b=XWwcm8wt5zdcfSYdC8ZHYNoyMdHymmNn3I0S2woVplW6uPB1cq5y/psbkazi++NnlF
 cKVbScSB65QkKt7DJk8oGuELDJn1am5LRQ0JKSRDmlQUwqZxtMNQUCHYmbbRZwRF3rr/
 y5L8x1Ecxbav4GjrjfvXuAdQiaSd50PxLnD7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755194837; x=1755799637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amUHsvu0KUaNn8tOsLnwJF9WJAz8QKDvPF6hS8l+25w=;
 b=gaqh4hhd4/HzOofTO8WsUCJ7v0xOvHOcwFvgCfPqQAXX5MrpyfFe4U4H1lM+wamQLR
 sfRObaql1UOej2kGEsxaSYw++EeisEJIU4Dj2vMxwh/xDKgp0Er6K2lsRKUnaS7HE5B9
 ZcyYa1wLsZsJr1CHnIRB9kcceHQ0CbYjj9J/a544ZvZ6Hs2OUXLzRwloME7+09FF0SlM
 T0ggKJOKJFX6Z+KCumXQ9RAa7OxWvyL9rgxR9Y000tqxCStik/me7rDGboBVmtGgWLXS
 6L7NE5q4rCMnJhrzXTPQq/XLHXBctkkuXS56C+WNC6B9Ehi25ZBFMm+nQTYAqmdgtSf0
 WrHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO5NQK89j99Wt3PvRqvX2mZ2QYSdfS2/8BWLUbnnGkCMj64C1Qkx7ReC27DQ/8S+9r9snHGmY=@lists.denx.de
X-Gm-Message-State: AOJu0Yzcc4Atmbj1IqaDRtWftCUgXO0LECIfSDM4tX+2ZEOB8DWTc1Uw
 VeAAdPYFTQXlqUSaiIuQ8J+D8ufNCmCbG65ixDwe2CthSjDqng0lFru/7bd+ZmL3w1CdqDyT1iW
 1r77A5xnSj2d1KTjI9HlhMlaHsObba/gssg==
X-Gm-Gg: ASbGncsu0ZGaf/UFi7LAn3DDFIsxwBubKImGILPg96nRXOh/vIH6WotEHK7+qiyVmgn
 Za5lqXU7ROKA6dffTDIwpye9jUW6IGBlmDkN1RmaVqqzYWbvzI0XPVNnLjcgUW1v26nDVt1vyUW
 vMR7xmCqyoq+IZ3BGblJ9E4XLWsiDTCVQUWy92u/RvM0GNdCYV91nzAuQFLXL3+Ttg49rC3Yi5e
 clZBIyaBgR7fVszihCePEgKnoR7Vtd07xeaNBd4mE3XtjIz7Mcx7yUDveBs4VI8y7S5+vOLOl7q
 ng62uAGMfg1eFvi+jsA7zSgmyUp27EWndLY/FUb5GS3lWLhb/QeaUmyViWPN59qm7Il6OIRvvea
 vTt90jsAlSOE2iw==
X-Google-Smtp-Source: AGHT+IEIRTRJgm0yDrVmYJ7kKwRVrcHwZ1bNSRRsZunnXMyD0444Ob66Dqo4LY83EOsB6mIC79epowruZQM+
X-Received: by 2002:a05:690c:63c6:b0:71c:131f:8d62 with SMTP id
 00721157ae682-71d635b3b88mr30221637b3.3.1755194836746; 
 Thu, 14 Aug 2025 11:07:16 -0700 (PDT)
Received: from bcacpedev-irv-2.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-71d60d6b387sm1970937b3.5.2025.08.14.11.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:07:16 -0700 (PDT)
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
Subject: [PATCH v2 3/4] cmd: nand: nand dump display update
Date: Thu, 14 Aug 2025 11:04:57 -0700
Message-ID: <20250814180647.1805196-4-dregan@broadcom.com>
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

show characters with nand dump similar to md
along with offset into NAND

Signed-off-by: david regan <dregan@broadcom.com>
---
 v2: no change
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

