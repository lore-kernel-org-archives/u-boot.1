Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC11CCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 09:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B6983303;
	Thu, 23 Oct 2025 11:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="ZxSlJJyo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E748835B0; Thu, 23 Oct 2025 11:47:36 +0200 (CEST)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [84.16.66.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4071B807C0
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 11:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4csh5y09BHzBTm;
 Thu, 23 Oct 2025 11:47:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1761212853;
 bh=ZjzX0AjrvPUxcP/0aGFv7Uu+K/MmWX7wVjGyjt7oAG8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZxSlJJyoLeglHsACHyGfPuq7wNFiJOd4VpTKjDquSj9kNUwny+3S8jfOHcq2/e6nv
 BEIZhI0gv1zE91PJvgsy1RsYKQUl6c/+JyhDIvFsFOo7udP33fw6MO4uk2IRM09l+6
 nZ1oP52QRodK9iaOlOs2abOsbnuLNu3+GrYi4lNo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4csh5x3sq2zFCy; Thu, 23 Oct 2025 11:47:33 +0200 (CEST)
From: Philippe Schenker <dev@pschenker.ch>
To: u-boot@lists.denx.de
Cc: stefan@embear.ch, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 3/6] soc: ti: pruss: Fix size ptr type in probe
Date: Thu, 23 Oct 2025 11:46:21 +0200
Message-ID: <20251023094631.16742-4-dev@pschenker.ch>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251023094631.16742-1-dev@pschenker.ch>
References: <20251023094631.16742-1-dev@pschenker.ch>
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
2.51.1

