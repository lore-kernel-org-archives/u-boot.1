Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0301DCCF9EA
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 06:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 898D083971;
	Thu, 30 Oct 2025 07:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="G/kSUQtP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDD3383971; Thu, 30 Oct 2025 07:26:31 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23DE1838EC
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 07:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1761805482;
 bh=zQGzLxJrZp5rIrBH1Iy+D1vg7KrkJNFwptbeQA6I1Mo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G/kSUQtPBuii0LjGP+KHSQM04zF4ekv78kFW3Csoz3IWlASdxQuuNxHMKQMuwxoDc
 9aYfW5mc7WUcn4z/FWewiPnb2htPFCpA0O3O5iZ5vPwWfVERX29D/Vpjz9o0pEvrym
 N0sBKE8MHKudgts1yxhcrfRXpIqHngPXz2Qssg5UJ6BFItm0D8lFp98N7/25AH+Ty+
 e2PjqK17KHQh0VPU9/zLISXkA5Xoaomxrgp32xjQ+gggFSAcqBLaCXN5//0x7eYsD6
 +ydobWIuCzCZDSVAFvPcqYliO8grWaCZmJ/9CJkJFZdM/h1yseNnIY0p3jmQPO5EBP
 +coa4sCnIbAfw==
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 7F4C6B220339;
 Thu, 30 Oct 2025 07:24:40 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH v1 3/3] ram: starfive: fix typo for unsupported DDR size
Date: Wed, 29 Oct 2025 23:23:34 -0700
Message-ID: <20251030062354.35413-4-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251030062354.35413-1-e@freeshell.de>
References: <20251030062354.35413-1-e@freeshell.de>
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

Fix typo for "unsupport" size and improve description to Unknown DDR size.

Signed-off-by: E Shattow <e@freeshell.de>
---
 drivers/ram/starfive/starfive_ddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ram/starfive/starfive_ddr.c b/drivers/ram/starfive/starfive_ddr.c
index f030192f6f4..e151179398f 100644
--- a/drivers/ram/starfive/starfive_ddr.c
+++ b/drivers/ram/starfive/starfive_ddr.c
@@ -48,7 +48,7 @@ static int starfive_ddr_setup(struct udevice *dev, struct starfive_ddr_priv *pri
 		break;
 
 	default:
-		pr_err("unsupport size %lx\n", priv->info.size);
+		pr_err("Unknown DDR size %lx\n", priv->info.size);
 		return -EINVAL;
 	}
 
-- 
2.50.0

