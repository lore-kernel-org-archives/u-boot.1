Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9F5D3C52B
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 18:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3367E8900A;
	Thu, 17 Oct 2024 20:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="R62jLnvQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC9C38901D; Thu, 17 Oct 2024 20:16:58 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C114188DD1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CCDE13F10F; 
 Thu, 17 Oct 2024 18:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729189012;
 bh=u38wuEHFZNHXCaVioQ82uuDYehIVmI+sQs/Hi8Z1Qf4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=R62jLnvQ1ITsyjf76WYPuKyNan4mrda9qAfs4qpBbkAsLy6phI6Z0Qt+fVuhGEqoZ
 d4TqmkUjmeTDRj5V5sOwaULJo+ukXave6uJc5RPCOi7mA0wTlXL24vzCIPDJrdSY+0
 9SX88kBg6j+PW+PR39H0MHMDDVUmTfRBmPcDVS9qJcAHLHVq8I2A4fF6b2rbexkFub
 /e8lxUrAtsodlKeBe5nACT7iIyaWt2DcJdv8gZl79kCsRzqWZRemwvydLuEMBlPkIA
 IJosbZSJ3LuiGYAEFJofmSTMscSCJrZAFy1Vw7mVUs4bTjdRrml2Y7AAmTrPoG99uK
 xDTswZSi1h8Cw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: add missing linefeed in error message
Date: Thu, 17 Oct 2024 20:16:49 +0200
Message-ID: <20241017181649.6822-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

* Messages written with log_err() should be terminated with linefeed.
* Spell device-tree with hyphen as elsewhere in U-Boot.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/lib/fdt_fixup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/lib/fdt_fixup.c b/arch/riscv/lib/fdt_fixup.c
index c658e72bd39..3a3a3f9e9f0 100644
--- a/arch/riscv/lib/fdt_fixup.c
+++ b/arch/riscv/lib/fdt_fixup.c
@@ -142,7 +142,7 @@ int arch_fixup_fdt(void *blob)
 	size = fdt_totalsize(blob);
 	err  = fdt_open_into(blob, blob, size + 32);
 	if (err < 0) {
-		log_err("Device Tree can't be expanded to accommodate new node");
+		log_err("Device-tree can't be expanded to accommodate new node\n");
 		return err;
 	}
 	chosen_offset = fdt_path_offset(blob, "/chosen");
-- 
2.45.2

