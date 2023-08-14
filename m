Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2812C001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 19:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 379088696C;
	Mon, 14 Aug 2023 21:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D68D86958; Mon, 14 Aug 2023 21:13:55 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 1802A807F9
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 21:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.01,173,1684767600"; d="scan'208";a="172931871"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 15 Aug 2023 04:13:49 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.4])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7E4EF4002944;
 Tue, 15 Aug 2023 04:13:48 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 1/2] clk: Fix typo in header comment
Date: Mon, 14 Aug 2023 20:13:34 +0100
Message-Id: <20230814191335.28401-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Aug 2023 21:14:14 +0200
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

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 include/clk-uclass.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/clk-uclass.h b/include/clk-uclass.h
index 65ebff9ed27b..a22f1a5d8489 100644
--- a/include/clk-uclass.h
+++ b/include/clk-uclass.h
@@ -64,7 +64,7 @@ int of_xlate(struct clk *clock, struct ofnode_phandle_args *args);
 
 /**
  * request() - Request a translated clock.
- * @clock:	The clock struct to request; this has been fille in by
+ * @clock:	The clock struct to request; this has been filled in by
  *		a previoux xxx_xlate() function call, or by the caller
  *		of clk_request().
  *
-- 
2.34.1

