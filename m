Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FABAC2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 13:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5BEF82B0E;
	Mon, 19 May 2025 15:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D233B82B32; Mon, 19 May 2025 15:32:45 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 36BE081FEE
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 15:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: gCVWDfbSSRCccGzVr678FQ==
X-CSE-MsgGUID: KAcV611nTc+xWjotPL1ssA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 19 May 2025 22:32:39 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.44])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6C2A7427AA7D;
 Mon, 19 May 2025 22:32:37 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Barker <paul@pbarker.dev>, u-boot@lists.denx.de
Subject: [PATCH] board: rzg2l: Drop myself to reviewer for RZ/G2L boards
Date: Mon, 19 May 2025 13:32:07 +0000
Message-ID: <20250519133208.6352-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
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

I still intend to review patches, and will be using my own email address
going forward.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 board/renesas/rzg2l/MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/renesas/rzg2l/MAINTAINERS b/board/renesas/rzg2l/MAINTAINERS
index 0e656e2ef4f0..b3547e39e77a 100644
--- a/board/renesas/rzg2l/MAINTAINERS
+++ b/board/renesas/rzg2l/MAINTAINERS
@@ -1,6 +1,6 @@
 RENESAS RZG2L BOARD FAMILY
-M:	Paul Barker <paul.barker.ct@bp.renesas.com>
-S:	Supported
+R:	Paul Barker <paul@pbarker.dev>
+S:	Orphan
 N:	rz-smarc
 N:	rzg2l
 N:	r9a07g044
-- 
2.43.0

