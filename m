Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC64C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A642881D6;
	Mon, 15 Apr 2024 08:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51200881D6; Mon, 15 Apr 2024 08:08:11 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52AE088169
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4VHxYN72sqz9t1J;
 Mon, 15 Apr 2024 08:08:08 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h5-XSBbcruQy; Mon, 15 Apr 2024 08:08:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4VHxYK0VMDz9syj;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0D8858B775;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id CZIM8O9ewYTT; Mon, 15 Apr 2024 08:08:04 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E751E8B764;
 Mon, 15 Apr 2024 08:08:04 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>,
 DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>, florent.trinh-thai@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH v2 04/17] board: cssi: Initialise port F on MIAE
Date: Mon, 15 Apr 2024 08:07:17 +0200
Message-ID: <ac5d1185416029f918d28ed71ea6a9d22555a8cd.1713160866.git.christophe.leroy@csgroup.eu>
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

From: Hugo Dubois <hugo.dubois.ext@csgroup.eu>

When equipped with the SRSA audio board, MIAE equipment
has an additional port called port F.

Initialise that port just like other ports of the board, so
that it is already configured when starting Linux kernel.

Signed-off-by: Hugo Dubois <hugo.dubois.ext@csgroup.eu>
Reviewed-by: CASAUBON Jean Michel <jean-michel.casaubon@csgroup.eu>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 board/cssi/common/common.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/board/cssi/common/common.c b/board/cssi/common/common.c
index 7ecf772620..6848efd43b 100644
--- a/board/cssi/common/common.c
+++ b/board/cssi/common/common.c
@@ -208,12 +208,44 @@ void misc_init_r_common(void)
 	}
 }
 
+static void iop_setup_fpgam_common(void)
+{
+	u8 far_id = in_8(ADDR_FPGA_R_BASE + 0x43) >> 5;
+
+	if (far_id == FAR_CASRSA) {
+		/*
+		 * PFDIR[15]  = 0 [0x01]
+		 * PFDIR[14]  = 1 [0x02]
+		 * PFDIR[13]  = 1 [0x04]
+		 */
+		clrsetbits_8(ADDR_FPGA_R_BASE + 0x37, 0x01, 0x06);
+		/*
+		 * PFODR[15]  = 1 [0x01]
+		 * PFODR[14]  = 0 [0x02]
+		 * PFODR[13]  = 0 [0x04]
+		 */
+		clrsetbits_8(ADDR_FPGA_R_BASE + 0x39, 0x06, 0x01);
+		/*
+		 * PFDAT[15]  = 0 [0x01]
+		 * PFDAT[14]  = 1 [0x02]
+		 * PFDAT[13]  = 1 [0x04]
+		 * PFDAT[12]  = 1 [0x08]
+		 */
+		clrsetbits_8(ADDR_FPGA_R_BASE + 0x3B, 0x01, 0x0E);
+
+		/* Setup TOR_OUT */
+		out_8(ADDR_FPGA_R_BASE + 0x32, 0x2A);
+	}
+}
+
 void iop_setup_common(void)
 {
 	u8 type = in_8(ADDR_FPGA_R_BASE);
 
-	if (type == TYPE_MCR)
+	if (type == TYPE_MCR) {
 		iop_setup_mcr();
-	else if (type == TYPE_MIAE)
+	} else if (type == TYPE_MIAE) {
 		iop_setup_miae();
+		iop_setup_fpgam_common();
+	}
 }
-- 
2.43.0

