Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32177CD4F54
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 16:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F8D846AA;
	Fri, 29 May 2026 18:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="QP11RI96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE92C846AA; Fri, 29 May 2026 18:59:36 +0200 (CEST)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A656846A3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 18:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202605291659332dd52dc752000207c7 for <u-boot@lists.denx.de>;
 Fri, 29 May 2026 18:59:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=rts/YaN3g7xNp1ZVvL973FGaex5RU6eVXgoFhkCEvJQ=;
 b=QP11RI961YG4pzIrVXf7BpCeLjN3av/5qwV1uz1Fkvi8r8WlGJ7mdJLh3jhWSVzkczN+bh
 e09wUEzDlUWFeZlaskHV5K7O4nvWA2IoBBBHeTPc7ILiWvY5fN/eWXdFjLrsCixpD1s9Be6N
 ISwWk8JPklFZ1hr6CMlNLuk+++XTRbNEbjNDhGO+boIXy8igdnh5JQptNuQWmUUa+gwBbJoi
 a6MPL5airVG5UiTinoMmfIwWCDJuNHf6rylTn5kNLx9XpqLf30Fo9U9PLG2pgMw6YvFtUeLQ
 xsOOCHd+3BENw/tyLfW5D2M+U473/0/ZwYsBjXWcrqqh9wA/45Wben0A==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: Fabio Estevam <festevam@gmail.com>,
	u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3] clk: imx: don't build i.MX/RTxxxx code for all users of CCF
Date: Fri, 29 May 2026 18:39:36 +0200
Message-ID: <20260529163938.1703601-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

When commit 1d7993d1d0ef
("clk: Port Linux common clock framework [CCF] for imx6q to U-boot (tag: v5.1.12)")
introduced the parts of Linux Common Clock Framework, it was done for i.MX6
only and even had "depends on SPL_CLK_IMX6Q" conditions. Since commit
ccab06689aa2 ("clk: imx: expose CCF entry for all") the framework can be
reused with SoCs of other vendors (say, TI), but NXP SoC-specific code is
still being build. It is especially problematic for size-constrained SPL
images on TI AM62x.

Make the build of the i.MX/RTxxxx code not only dependent on
CONFIG_$(PHASE_)CLK_CCF, but also on CONFIG_MACH_IMX options which shall
cover the i.MX platform users.

This saves 2264 bytes on 32-bit ARM platforms [using CCF].

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v3:
- Fixed couple of typos
v2:
- CONFIG_MACH_IMX instead of (CONFIG_ARCH_MX6 | CONFIG_ARCH_IMXRT)
v1:
- https://lore.kernel.org/all/20260501162706.543779-1-alexander.sverdlin@siemens.com/

 drivers/clk/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 5f0c0d8a5c2..c37ef75d420 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
 obj-y += adi/
 obj-y += airoha/
 obj-y += analogbits/
-obj-y += imx/
+obj-$(CONFIG_MACH_IMX) += imx/
 obj-$(CONFIG_CLK_JH7110) += starfive/
 obj-y += tegra/
 obj-y += ti/
-- 
2.52.0

