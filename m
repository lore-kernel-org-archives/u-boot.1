Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D17CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 06:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 845458841D;
	Fri,  5 Apr 2024 08:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EE8788443; Fri,  5 Apr 2024 08:54:04 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B87B488432
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 08:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4V9q2v0fXCz9t0H;
 Fri,  5 Apr 2024 08:53:59 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qN8vgpjUGC0H; Fri,  5 Apr 2024 08:53:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4V9q2t1tf1z9syV;
 Fri,  5 Apr 2024 08:53:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D2808B779;
 Fri,  5 Apr 2024 08:53:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id fsKxdto5YbiL; Fri,  5 Apr 2024 08:53:58 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.100])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E1C468B766;
 Fri,  5 Apr 2024 08:53:57 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: jean-michel.casaubon@csgroup.eu, hugo.dubois.ext@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH 2/4] board: cssi: Allow use without HUSH shell
Date: Fri,  5 Apr 2024 08:53:19 +0200
Message-ID: <7049f6baa6d42dffea8e31ac312438a355593b06.1712299502.git.christophe.leroy@csgroup.eu>
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

HUSH shell is not always wanted/desirable.

Add missing braces in environment in order to allow use without
HUSH shell.

Signed-off-by: Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>
Cc: DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 board/cssi/cmpc885/cmpc885.env | 4 ++--
 board/cssi/cmpcpro/cmpcpro.env | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/board/cssi/cmpc885/cmpc885.env b/board/cssi/cmpc885/cmpc885.env
index 51ab5ce2cf..570117cd36 100644
--- a/board/cssi/cmpc885/cmpc885.env
+++ b/board/cssi/cmpc885/cmpc885.env
@@ -2,6 +2,6 @@ loadaddr=0x1a00000
 filename=cmpc885.itb
 console_args=console=ttyCPM0,115200N8
 loadkernel=ubi part nand0;ubifsmount ubi0;ubifsload ${loadaddr} /boot/${filename};ubifsumount; ubi detach
-flashboot=setenv bootargs ${console_args} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:eth0:off ${ofl_args}; run loadkernel; bootm $loadaddr#$config
-tftpboot=setenv bootargs ${console_args} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:eth0:off ${ofl_args}; tftp ${loadaddr} ${filename};bootm $loadaddr#$config
+flashboot=setenv bootargs ${console_args} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:eth0:off ${ofl_args}; run loadkernel; bootm ${loadaddr}#${config}
+tftpboot=setenv bootargs ${console_args} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:eth0:off ${ofl_args}; tftp ${loadaddr} ${filename};bootm ${loadaddr}#${config}
 update=echo 'Updating ubi image'; if tftp $loadaddr $ubifile; then nand erase.chip; nand write $loadaddr 0x00 $filesize; fi;
diff --git a/board/cssi/cmpcpro/cmpcpro.env b/board/cssi/cmpcpro/cmpcpro.env
index 7394b8386e..47b436ff6b 100644
--- a/board/cssi/cmpcpro/cmpcpro.env
+++ b/board/cssi/cmpcpro/cmpcpro.env
@@ -3,6 +3,6 @@ filename=cmpcpro.itb
 netdev=eth0
 console_args=console=ttyS0,115200N8
 loadkernel=ubi part nand0;ubifsmount ubi0; ubifsload ${loadaddr} /boot/${filename}; ubifsumount; ubi detach
-flashboot=mw.w 90000040 0x000E 1; setenv bootargs ${console_args} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:eth0:off ${ofl_args}; run loadkernel; bootm $loadaddr#$config
-tftpboot=mw.w 90000040 0x000E 1; setenv bootargs ${console_args} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:eth0:off ${ofl_args}; tftp ${loadaddr} ${filename}; bootm $loadaddr#$config
+flashboot=mw.w 90000040 0x000E 1; setenv bootargs ${console_args} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:eth0:off ${ofl_args}; run loadkernel; bootm ${loadaddr}#${config}
+tftpboot=mw.w 90000040 0x000E 1; setenv bootargs ${console_args} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:eth0:off ${ofl_args}; tftp ${loadaddr} ${filename}; bootm ${loadaddr}#${config}
 update=echo 'Updating ubi image'; mw.w 90000040 0x000E 1; if tftp $loadaddr $ubifile; then nand erase.chip; nand write $loadaddr 0x00 $filesize; fi;
-- 
2.43.0

