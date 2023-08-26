Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBA3C83F13
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 12:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3E73808E6;
	Sat, 26 Aug 2023 14:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dRURXa/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FAC584702; Sat, 26 Aug 2023 14:17:21 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0507F805C9
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 14:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fe61ae020bso2667816e87.2
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693052238; x=1693657038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ezlZWGbIBIT82GLvyxt67STY91AYA42Vv18TsWG1hok=;
 b=dRURXa/8TeB96QTyL4GmFqEQ1x4IYfZu0zjnGlYFP9K5EnamUX/3VwUnf0M34Wj3DO
 I9boorEDhDWHZCHW8h8WKmwhb3lXlnE2WAeEnHbQ3cg+LwQdC7EjueO7/5WgBSZRc+py
 TVa8GAbTQuIC1JgxQLrb0lqL7ok74ki3t09jkiLcePnlyaSoQtpvfPPSz0ECO3RlqbV9
 6m/pQJmDwZzcBcGICqTSi6cmN7TUsSVvs7vJvv6XWTeqnjpRFxy7gvrB7mBfSg8Ll6r5
 EdzZ+QGq2Uvg2VibLyaqYun4wCsm/bJSbdSG1fWlgw2qCT0UpqoWUV/Vh5bmcacEmLMV
 tJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693052238; x=1693657038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ezlZWGbIBIT82GLvyxt67STY91AYA42Vv18TsWG1hok=;
 b=BPSXVA6lx4k9tgHNzpIgFXeOK9BK5eN2N6+E7mqVddvTKXPjcve4fbjt40Iwt4Opf5
 r4jO1Ne28Np3wqxHrqrZLYWtu9pjjsbNaFxCMWf7efoOLc/hknbFDSnzOeT7/2sL2LGz
 sva9AjKcJmsb9KC8w/76H3T1j5kwp0zGux0RvZnRTD2VJcCKHgYUK34Nt47sqxOs8mIe
 FllVLNozPLX0CLtM2F8p1Z/P8Wd9Y5KJyjWOb8v3tLXfqudOPVO3wvhKI2pswnGRphlW
 T+/zUczNJpaUBAbRyb6D4F6KeZUnYbHQWRiX2FtI2er++51uRd21UJrn2EQVvmHcapbQ
 jyhQ==
X-Gm-Message-State: AOJu0YzsUP9ekGv6DJf+oHGL2Hdn+7VFmBkK+v2gCAUtHmrFJQ1/oBxh
 hwJK0FAIgezxI5cchhBdyEk=
X-Google-Smtp-Source: AGHT+IE5A4l7Eqw8c91oJYzRrsZFtIapwkWIuKwaWttPf9cEB9hdXoEfNY3s5Vsh5r+5TZZNdy9PqA==
X-Received: by 2002:ac2:4eca:0:b0:4ff:8d9e:d36f with SMTP id
 p10-20020ac24eca000000b004ff8d9ed36fmr14818306lfr.39.1693052237852; 
 Sat, 26 Aug 2023 05:17:17 -0700 (PDT)
Received: from localhost.localdomain
 ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
 by smtp.gmail.com with ESMTPSA id
 b4-20020ac247e4000000b004ff89fc80aasm696642lfp.233.2023.08.26.05.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Aug 2023 05:17:17 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Jarrah Gosbell <kernel@undef.tools>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Pavel Machek <pavel@ucw.cz>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Detlev Casanova <detlev.casanova@collabora.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] pstore: Use root address-cells/size-cells as defaults for
 reserved-memory
Date: Sat, 26 Aug 2023 15:16:52 +0300
Message-Id: <20230826121652.2487643-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.40.1
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

u-boot adds reserve-memory node, if it's missing, with following
properties:

```
    reserved-memory {
         #address-cells = <2>;
         #size-cells = <2>;
         ranges;
    }
```

But with these default address-cells and size-cells values, pstore
isn't working on A64. Root node for A64 defines 'address-cells' and
'size-cells' as 1.

dtc complains if reserved-memory has different address-cells and
size-cells.

```
     Warning (ranges_format): /reserved-memory:ranges: empty "ranges"
     property but its #address-cells (2) differs from / (1)
```

This patch takes into account address-cells and size-cells of the root
node and uses them as values for new reserved-memory node.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 cmd/pstore.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/cmd/pstore.c b/cmd/pstore.c
index cd6f6feb2f..9795eea2db 100644
--- a/cmd/pstore.c
+++ b/cmd/pstore.c
@@ -486,6 +486,8 @@ void fdt_fixup_pstore(void *blob)
 {
 	char node[32];
 	int  nodeoffset;	/* node offset from libfdt */
+	u32 addr_cells_root;
+	u32 size_cells_root;
 	u32 addr_cells;
 	u32 size_cells;
 
@@ -495,6 +497,8 @@ void fdt_fixup_pstore(void *blob)
 		log_err("fdt_path_offset() returned %s\n", fdt_strerror(nodeoffset));
 		return;
 	}
+	addr_cells_root = fdt_getprop_u32_default_node(blob, nodeoffset, 0, "#address-cells", 2);
+	size_cells_root = fdt_getprop_u32_default_node(blob, nodeoffset, 0, "#size-cells", 2);
 
 	nodeoffset = fdt_find_or_add_subnode(blob, nodeoffset, "reserved-memory");
 	if (nodeoffset < 0) {
@@ -503,8 +507,10 @@ void fdt_fixup_pstore(void *blob)
 		return;
 	}
 
-	addr_cells = fdt_getprop_u32_default_node(blob, nodeoffset, 0, "#address-cells", 2);
-	size_cells = fdt_getprop_u32_default_node(blob, nodeoffset, 0, "#size-cells", 2);
+	addr_cells = fdt_getprop_u32_default_node(blob, nodeoffset, 0,
+						  "#address-cells", addr_cells_root);
+	size_cells = fdt_getprop_u32_default_node(blob, nodeoffset, 0,
+						  "#size-cells", size_cells_root);
 	fdt_setprop_u32(blob, nodeoffset, "#address-cells", addr_cells);
 	fdt_setprop_u32(blob, nodeoffset, "#size-cells", size_cells);
 
-- 
2.40.1

