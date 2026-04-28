Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C20AFF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 16:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25FEE84692;
	Tue, 28 Apr 2026 18:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47298845E3; Tue, 28 Apr 2026 18:39:44 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7774B84612
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 18:39:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id CE7CB68D0A; Tue, 28 Apr 2026 18:39:40 +0200 (CEST)
Subject: [PATCH v2 7/9] pci: brcmstb: Fix iBAR size calculation
To: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>
Cc: Tom Rini <trini@konsulko.com>,"Jan Čermák" <sairon@sairon.cz>,Andrea della Porta <andrea.porta@suse.com>,"Ivan T. Ivanov" <iivanov@suse.de>, Stanimir Varbanov <stanimir.varbanov@suse.com>, Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Volodymyr Babchuk <volodymyr_babchuk@epam.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,Paul Barker <paul.barker.ct@bp.renesas.com>,Patrice Chotard <patrice.chotard@foss.st.com>,Christian Marangi <ansuelsmth@gmail.com>,Patrick Delaunay <patrick.delaunay@foss.st.com>,Huan Zhou <me@per1cycle.org>,Gabriel Fernandez <gabriel.fernandez@foss.st.com>,Kever Yang <kever.yang@rock-chips.com>,Jonas Karlman <jonas@kwiboo.se>,Joseph Chen <chenjh@rock-chips.com>,Elaine Zhang <zhangqing@rock-chips.com>, Pedro Falcato <pfalcato@suse.de>,u-boot@lists.denx.de
In-Reply-To: <20260428162319.99B4268B05@verein.lst.de>
Message-Id: <20260428163940.CE7CB68D0A@verein.lst.de>
Date: Tue, 28 Apr 2026 18:39:40 +0200 (CEST)
From: duwe@lst.de (Torsten Duwe)
X-Mailman-Approved-At: Tue, 28 Apr 2026 18:43:21 +0200
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

From: Torsten Duwe <duwe@suse.de>

Fix inbound window size calculation, like Linux commit 25a98c7270156.

Signed-off-by: Torsten Duwe <duwe@suse.de>
Tested-by: Pedro Falcato <pfalcato@suse.de>

---
 drivers/pci/pcie_brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
index 1f97cda5cc7..8a25fb04563 100644
--- a/drivers/pci/pcie_brcmstb.c
+++ b/drivers/pci/pcie_brcmstb.c
@@ -105,8 +105,8 @@ static int brcm_pcie_encode_ibar_size(u64 size)
 	if (log2_in >= 12 && log2_in <= 15)
 		/* Covers 4KB to 32KB (inclusive) */
 		return (log2_in - 12) + 0x1c;
-	else if (log2_in >= 16 && log2_in <= 37)
-		/* Covers 64KB to 32GB, (inclusive) */
+	else if (log2_in >= 16 && log2_in <= 36)
+		/* Covers 64KB to 64GB, (inclusive) */
 		return log2_in - 15;
 
 	/* Something is awry so disable */
-- 
2.54.0

