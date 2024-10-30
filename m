Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50ADD5CC8C
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 10:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B199891F8;
	Wed, 30 Oct 2024 11:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0974891FA; Wed, 30 Oct 2024 11:36:05 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 51F19891D2
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 11:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.11,244,1725289200"; d="scan'208";a="227420231"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 30 Oct 2024 19:36:00 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.45])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 93AA641D879F;
 Wed, 30 Oct 2024 19:35:49 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH] board: rzg2l: Update MAINTAINERS file to match dts/upstream
 paths
Date: Wed, 30 Oct 2024 10:35:43 +0000
Message-Id: <20241030103543.465-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
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

We are now using the dts/upstream subtree for the RZ/G2L SoC family, so
update the board MAINTAINERS file to match rz-smarc dtsi files in this
subtree.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 board/renesas/rzg2l/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/renesas/rzg2l/MAINTAINERS b/board/renesas/rzg2l/MAINTAINERS
index 0a51391c1fc9..0e656e2ef4f0 100644
--- a/board/renesas/rzg2l/MAINTAINERS
+++ b/board/renesas/rzg2l/MAINTAINERS
@@ -1,6 +1,6 @@
 RENESAS RZG2L BOARD FAMILY
 M:	Paul Barker <paul.barker.ct@bp.renesas.com>
 S:	Supported
-F:	arch/arm/dts/rz-smarc-common.dtsi
+N:	rz-smarc
 N:	rzg2l
 N:	r9a07g044
-- 
2.43.0

