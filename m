Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E958CCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 13:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BF0483D3C;
	Fri,  7 Nov 2025 14:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="G1shr6xM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7872B83D90; Fri,  7 Nov 2025 14:03:09 +0100 (CET)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [83.166.143.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBFCC83D62
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 14:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d2zkb5bpwzf2D;
 Fri,  7 Nov 2025 14:03:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1762520583;
 bh=/DFTimXgtDUH0Lkw/vAsUoYMf975Z5cEJbe2DjZASo8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G1shr6xMYDWGLTmnXezJF/VEd1F9cD3RHbZUo9ivUtaPGPXMcJMXif+hyi8F1hQdl
 GWtWOf522Y0HAG+n2SgPjexIcpCpRsin70852ymFR51vwwRvRG1HUM2OI8uVSL+TAc
 3/FG9kOO/y5edZbvCndeA/F7+WeYKp1SdcnibMSU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d2zkb1VhmzSLq; Fri,  7 Nov 2025 14:03:03 +0100 (CET)
From: Philippe Schenker <dev@pschenker.ch>
To: u-boot@lists.denx.de
Cc: stefan@embear.ch, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/6] soc: ti: pruss: Fix size ptr type in probe
Date: Fri,  7 Nov 2025 14:01:02 +0100
Message-ID: <20251107130216.3084134-4-dev@pschenker.ch>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107130216.3084134-1-dev@pschenker.ch>
References: <20251107130216.3084134-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

From: Philippe Schenker <philippe.schenker@impulsing.ch>

When compiling for R5 with CONFIG_TI_PRUSS enabled, the
pruss_probe() function passed a u64* to ofnode_get_addr_size_index(),
which expects an fdt_size_t*. This caused a compiler error
about incompatible pointer types.

Cast the size pointer to fdt_size_t* to match the function
signature.

Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
---

(no changes since v1)

 drivers/soc/ti/pruss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index e3bb2ede554a..4bc0ff8c2c17 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -163,7 +163,7 @@ static int pruss_probe(struct udevice *dev)
 	for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
 		idx = ofnode_stringlist_search(memories, "reg-names", mem_names[i]);
 		priv->mem_regions[i].pa = ofnode_get_addr_size_index(memories, idx,
-						       (u64 *)&priv->mem_regions[i].size);
+						       (fdt_size_t *)&priv->mem_regions[i].size);
 	}
 
 	sub_node = ofnode_find_subnode(node, "cfg");
-- 
2.51.2

