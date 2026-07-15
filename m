Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CD0C44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 01:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1924A84D63;
	Thu, 16 Jul 2026 03:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="TUmVLM9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5626984C42; Thu, 16 Jul 2026 01:30:08 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E412384C03
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 01:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6494bd2e8=Romain.Caritey@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1784158208; x=1815694208;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=q9rWUxibqR6r7KW47eBesO0qUQvnytBxp9AyFluctO0=;
 b=TUmVLM9NCU1BhirLilkS/gAtQcPOvrzJbvv9cfmXR6ZV9hq7lz1rjViR
 ODcrpS03fqf0fisYxV12WX5xUSOjjiN8SJSXhB387G1Bv9UIbm+TLA7fY
 F+j11gyr9kW6vgNmzbW77AuX9icxK1L0fK2CXqeJe0+mhE/T+zRw/IRjI
 Vug40egv1NaRgN0jTrovgCbG2lvl4hk5Z7KhUPxO6S8a1ZBPbJgntg1G3
 jx+ZvDTUAw1L/l/7GOgEHryKXnN141/dxkJ0DcaOMmRWDKoI4hEkfxy2i
 wvpUVwRrIg0ZHruv2d0Dd9KciW6AtK+PHStw/I/UFfQvih7Fuol+NEZtt w==;
X-CSE-ConnectionGUID: /NCIb6jkSWmu40Q39k7OUg==
X-CSE-MsgGUID: GGyRCM51ScCWiawUBNvmpg==
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; d="scan'208";a="61007415"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 16:30:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Wed, 15 Jul 2026 16:30:03 -0700
Received: from bby-cbu-c71245.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 15 Jul 2026 16:30:02 -0700
From: <romain.caritey@microchip.com>
To: <u-boot@lists.denx.de>
CC: <charles.perry@microchip.com>, <mamemaria.mbaye@microchip.com>,
 <romain.caritey@microchip.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd/mtd.c: fix do_mtd_io doesn't support 64bit user address
Date: Wed, 15 Jul 2026 16:28:54 -0700
Message-ID: <20260715232921.1182646-1-romain.caritey@microchip.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 16 Jul 2026 03:03:52 +0200
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

From: Romain Caritey <romain.caritey@microchip.com>

Signed-off-by: Romain Caritey <romain.caritey@microchip.com>
---
 cmd/mtd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 7f25144098b..ed827accfb5 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -470,10 +470,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
 	bool dump, read, raw, woob, benchmark, write_empty_pages, has_pages = false;
-	u64 start_off, off, len, remaining, default_len, speed;
+	u64 start_off, off, len, remaining, default_len, speed, user_addr = 0;
 	unsigned long bench_start, bench_end;
 	struct mtd_oob_ops io_op = {};
-	uint user_addr = 0, npages;
+	uint npages;
 	const char *cmd = argv[0];
 	struct mtd_info *mtd;
 	u32 oob_len;
-- 
2.47.3

