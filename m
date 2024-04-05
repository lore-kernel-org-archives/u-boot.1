Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5C5CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 06:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 639A88845C;
	Fri,  5 Apr 2024 08:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6052488456; Fri,  5 Apr 2024 08:54:06 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81CF188440
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 08:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4V9q2y4FdBz9sx4;
 Fri,  5 Apr 2024 08:54:02 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yblid7azmbFf; Fri,  5 Apr 2024 08:54:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4V9q2t73Jrz9syj;
 Fri,  5 Apr 2024 08:53:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EEDED8B766;
 Fri,  5 Apr 2024 08:53:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id XFgGZCkwwiil; Fri,  5 Apr 2024 08:53:58 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.100])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 952868B77A;
 Fri,  5 Apr 2024 08:53:58 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: jean-michel.casaubon@csgroup.eu, hugo.dubois.ext@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH 4/4] board: cssi: Properly initialise MAC address for fibre on
 CMPC885 board
Date: Fri,  5 Apr 2024 08:53:21 +0200
Message-ID: <d9052dbeab702f87980adb6839a381c9aed73b7e.1712299502.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712299502.git.christophe.leroy@csgroup.eu>
References: <cover.1712299502.git.christophe.leroy@csgroup.eu>
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

CMPC885 board can be pluged on a mother board with fibre interface, so
fibre interface MAC address must be initialised for that case.

Signed-off-by: Hugo Dubois <hugo.dubois.ext@csgroup.eu>
Reviewed-by: CASAUBON Jean Michel <jean-michel.casaubon@csgroup.eu>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 board/cssi/cmpc885/cmpc885.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/board/cssi/cmpc885/cmpc885.c b/board/cssi/cmpc885/cmpc885.c
index e11cfafaa5..49c13056ed 100644
--- a/board/cssi/cmpc885/cmpc885.c
+++ b/board/cssi/cmpc885/cmpc885.c
@@ -114,8 +114,10 @@ static int setup_mac(void)
 	if (memcmp(din + EE_OFF_MAC1, &ident, sizeof(ident)) == 0)
 		eth_env_set_enetaddr("ethaddr", din + EE_OFF_MAC1);
 
-	if (memcmp(din + EE_OFF_MAC2, &ident, sizeof(ident)) == 0)
+	if (memcmp(din + EE_OFF_MAC2, &ident, sizeof(ident)) == 0) {
 		eth_env_set_enetaddr("eth1addr", din + EE_OFF_MAC2);
+		eth_env_set_enetaddr("eth2addr", din + EE_OFF_MAC2);
+	}
 
 	return 0;
 }
-- 
2.43.0

