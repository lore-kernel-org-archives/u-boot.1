Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A505BCD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 06:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 096F188437;
	Fri,  5 Apr 2024 08:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBA2A88435; Fri,  5 Apr 2024 08:54:02 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 063CA88413
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 08:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4V9q2t222yz9syd;
 Fri,  5 Apr 2024 08:53:58 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yJn9tCVtXebC; Fri,  5 Apr 2024 08:53:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4V9q2s6Xcwz9sx4;
 Fri,  5 Apr 2024 08:53:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DD8878B779;
 Fri,  5 Apr 2024 08:53:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id uZ1fHLS3AXvp; Fri,  5 Apr 2024 08:53:57 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.100])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8EC3B8B766;
 Fri,  5 Apr 2024 08:53:57 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: jean-michel.casaubon@csgroup.eu, hugo.dubois.ext@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH 1/4] board: cssi: Fix MCR3000 board environment
Date: Fri,  5 Apr 2024 08:53:18 +0200
Message-ID: <b22aed7550f121feadca5c98e78d0ffa3ebcecee.1712299502.git.christophe.leroy@csgroup.eu>
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

From: Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>

Remove a stray semicolon in MCR3000 board environment.

Signed-off-by: Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>
Reviewed-by: DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 board/cssi/mcr3000/mcr3000.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/cssi/mcr3000/mcr3000.env b/board/cssi/mcr3000/mcr3000.env
index 372ab09094..380c10c4ce 100644
--- a/board/cssi/mcr3000/mcr3000.env
+++ b/board/cssi/mcr3000/mcr3000.env
@@ -8,7 +8,7 @@ dhcp_ip=ip=:::::eth0:dhcp
 console_args=console=ttyCPM0,115200N8
 loadkernel=ubi part nand0;ubifsmount ubi0;ubifsload ${loadaddr} /boot/${filename};ubifsumount; ubi detach
 bootcmd=run flashboot
-flashboot=setenv bootargs ${console_args} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:mcr3k:eth0:off;${ofl_args}; run loadkernel; bootm ${loadaddr}
+flashboot=setenv bootargs ${console_args} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:mcr3k:eth0:off ${ofl_args}; run loadkernel; bootm ${loadaddr}
 tftpboot=setenv bootargs ${console_args} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:mcr3k:eth0:off ${ofl_args}; tftp ${loadaddr} ${filename}; bootm ${loadaddr}
 dhcpboot=dhcp ${loadaddr} ${filename};setenv bootargs ${console_args} ${dhcp_ip} ${ofl_args}; bootm ${loadaddr}
 update=echo 'Updating ubi image'; if tftp 0x2000 $ubifile; then nand erase.chip; nand write 0x2000 0x00 $filesize; fi
-- 
2.43.0

