Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3BAF513E1
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 21:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16FF883F61;
	Thu,  5 Mar 2026 22:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="dvu6gtAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D36C83F75; Thu,  5 Mar 2026 22:49:50 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 613DA839A8
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 22:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1772747385;
 bh=0hjjrOlKIKhpylAID6ZYApdkY6DknBcsUfuATu28GDI=;
 h=From:To:Cc:Subject:Date:From;
 b=dvu6gtAn4+fz625I0S+vsge0OWGbe7Mj6IrGEJRIZXG8hM+BtIGp1dOpW3qUgH6nP
 ukRWsJ9GMH4nUCYC0GHHGYpGM8e0FWgnYHqwF6MdooBS95wInyucBuL0EPBNULfakV
 1UlroJHCeOZ0BFAiQO3PDtOf2oLiL1uVQXF6w6RJF/1oMHcTmmcqw9qnIkmsLskTVr
 RirK0oNUjNynqrIdONUjzd6xbSvOiYPHRFh5j4wZLRvSLw9YcNmMnKYPdZroYKfSVj
 7ThTp8vUYiSzbRDeakXf8MmhERDQtuBr1DAGFoXOSvIILVhsR1z39qKbzVyVxriSwD
 0A1C+6wjdocBA==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id F3BEBB2202CA;
 Thu,  5 Mar 2026 22:49:43 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 E Shattow <e@freeshell.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH] doc: board: starfive: jh7110 common update OPENSBI build env
 reference
Date: Thu,  5 Mar 2026 13:49:14 -0800
Message-ID: <20260305214922.97337-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
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

Describe build with OpenSBI fw_dynamic.bin path as OPENSBI=<path> on the
same line instead of as an export. Also remedy a typo which had the wrong
directory path before the filename.

Fixes: 8304f3226700 ("doc: board: starfive: update jh7110 common description")
Signed-off-by: E Shattow <e@freeshell.de>
---

This patch depends on https://lore.kernel.org/u-boot/24982c23-3ee6-4e33-8608-5af6dd612297@freeshell.de

-E

---
 doc/board/starfive/jh7110_common.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive/jh7110_common.rst
index b0b60da0dc3..e9c0ed5b022 100644
--- a/doc/board/starfive/jh7110_common.rst
+++ b/doc/board/starfive/jh7110_common.rst
@@ -172,8 +172,7 @@ Build U-Boot
 
        git clone https://source.denx.de/u-boot/u-boot.git u-boot.git
        make -C u-boot.git O=u-boot starfive_visionfive2_defconfig
-       export OPENSBI=opensbi/build/platform/generic/firmware/fw_dynamic.bin
-       make -C u-boot.git O=u-boot
+       make -C u-boot.git O=u-boot OPENSBI=opensbi/platform/generic/firmware/fw_dynamic.bin
 
     This will generate the U-Boot SPL image object post-processed with StarFive
     SPL headers (u-boot/spl/u-boot-spl.bin.normal.out) as well as the FIT image
-- 
2.50.0

