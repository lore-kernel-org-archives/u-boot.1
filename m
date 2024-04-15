Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408FCC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E966588247;
	Mon, 15 Apr 2024 08:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9497B88254; Mon, 15 Apr 2024 08:08:25 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A86A088220
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4VHxYf111Fz9t0H;
 Mon, 15 Apr 2024 08:08:22 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dAs2zR2IZ4HH; Mon, 15 Apr 2024 08:08:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4VHxYL1FhWz9tFS;
 Mon, 15 Apr 2024 08:08:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 276688B770;
 Mon, 15 Apr 2024 08:08:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id s9U6e3Yftgi1; Mon, 15 Apr 2024 08:08:06 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 061298B764;
 Mon, 15 Apr 2024 08:08:06 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>,
 DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>, florent.trinh-thai@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH v2 17/17] board: cssi: Read and display MCR board address
Date: Mon, 15 Apr 2024 08:07:30 +0200
Message-ID: <f19550f49c2dc75d02225518ba9ae4f50d6eb295.1713160866.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713160866.git.christophe.leroy@csgroup.eu>
References: <cover.1713160866.git.christophe.leroy@csgroup.eu>
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

MCR boards are plugged in racks. The position in the rack can be read
in a register.

For MCR3000, that's provided by the FPGA so check it is loaded before
reading the address.

For the other boards, the FPGA is loaded by hardware so it can be
read inconditionnaly.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 board/cssi/common/common.c   | 6 +++++-
 board/cssi/mcr3000/mcr3000.c | 7 ++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/board/cssi/common/common.c b/board/cssi/common/common.c
index 6848efd43b..0292a9016e 100644
--- a/board/cssi/common/common.c
+++ b/board/cssi/common/common.c
@@ -164,7 +164,7 @@ int checkboard_common(void)
 
 void misc_init_r_common(void)
 {
-	u8 tmp, far_id;
+	u8 tmp, far_id, addr;
 	int count = 3;
 
 	switch (in_8(ADDR_FPGA_R_BASE)) {
@@ -173,6 +173,10 @@ void misc_init_r_common(void)
 		if ((in_8(ADDR_FPGA_R_BASE + 0x31) & FPGA_R_ACQ_AL_FAV) == 0)
 			env_set("bootdelay", "60");
 
+		addr = in_8(ADDR_FPGA_R_BASE + 0x43);
+		printf("Board address: 0x%2.2x (System %d Rack %d Slot %d)\n",
+		       addr, addr >> 7, (addr >> 4) & 7, addr & 15);
+
 		env_set("config", CFG_BOARD_MCR3000_2G);
 		env_set("hostname", CFG_BOARD_MCR3000_2G);
 		break;
diff --git a/board/cssi/mcr3000/mcr3000.c b/board/cssi/mcr3000/mcr3000.c
index 15a2d0d946..48e82a902d 100644
--- a/board/cssi/mcr3000/mcr3000.c
+++ b/board/cssi/mcr3000/mcr3000.c
@@ -167,7 +167,12 @@ int misc_init_r(void)
 	setbits_be32(&immr->im_cpm.cp_pbdir, 0xf);
 	clrbits_be32(&immr->im_cpm.cp_pbdat, 0x1);
 
-	load_fpga();
+	if (!load_fpga()) {
+		u8 addr = in_be16((void *)0x1400009c);
+
+		printf("Board address: 0x%2.2x (System %d Rack %d Slot %d)\n",
+		       addr, addr >> 7, (addr >> 4) & 7, addr & 15);
+	}
 
 	/* if BTN_ACQ_AL is pressed then bootdelay is changed to 60 second */
 	if ((in_be16(&iop->iop_pcdat) & 0x0004) == 0)
-- 
2.43.0

