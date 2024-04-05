Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240DFCD1284
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 06:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D0EF88236;
	Fri,  5 Apr 2024 08:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8399588420; Fri,  5 Apr 2024 08:54:01 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D388F87D8D
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 08:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4V9q2s4vjwz9sy4;
 Fri,  5 Apr 2024 08:53:57 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c2RaUJVYo9M7; Fri,  5 Apr 2024 08:53:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4V9q2s44fNz9sx4;
 Fri,  5 Apr 2024 08:53:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 886A58B779;
 Fri,  5 Apr 2024 08:53:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id MAqYlkdbVH1E; Fri,  5 Apr 2024 08:53:57 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.100])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 32E918B766;
 Fri,  5 Apr 2024 08:53:57 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: jean-michel.casaubon@csgroup.eu, hugo.dubois.ext@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH 0/4] Misc changes for CSSI boards
Date: Fri,  5 Apr 2024 08:53:17 +0200
Message-ID: <cover.1712299502.git.christophe.leroy@csgroup.eu>
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

This series contains misc fixes and changes for CSSI boards.

I will send a pull request later before close of the merge window.

Hugo Dubois (2):
  board: cssi: Initialise port F on MIAE
  board: cssi: Properly initialise MAC address for fibre on CMPC885
    board

Jean-Michel CASAUBON (2):
  board: cssi: Fix MCR3000 board environment
  board: cssi: Allow use without HUSH shell

 board/cssi/cmpc885/cmpc885.c   |  4 +++-
 board/cssi/cmpc885/cmpc885.env |  4 ++--
 board/cssi/cmpcpro/cmpcpro.env |  4 ++--
 board/cssi/common/common.c     | 36 ++++++++++++++++++++++++++++++++--
 board/cssi/mcr3000/mcr3000.env |  2 +-
 5 files changed, 42 insertions(+), 8 deletions(-)

-- 
2.43.0

