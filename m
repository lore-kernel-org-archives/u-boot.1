Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97923C369A6
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:58:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8141A83C6D;
	Thu, 10 Apr 2025 14:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=couthit.com header.i=@couthit.com header.b="Z8RPRB7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F4FA8398B; Thu, 10 Apr 2025 09:00:54 +0200 (CEST)
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me
 [162.240.238.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19E0183957
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=parvathi@couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
 ; s=default;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3I6UhbHmQqWnAv08vDNkRelkwutK2sqszXEqDIDnVAI=; b=Z8RPRB7w22feTC9V3xAqo5Brwx
 1AcVBHqADR+R7RswbluFWUHudaxMjodCaNjPZBtvrmKya7om6Sjj690vf/TarQh2wuDQbzAxe9fZ9
 ukUUC/wmKowgX2ZdpMizFc0cTkjCpfRuL4EpezHLsdCSwtlh0vqISJzJxCj8SHs53loDrr4izOUMp
 IzOQ23k8uju3lTuYDdolM7NpkVlJjsu9qj8xNeNnnA0+H2+a4+j3p7Y2/5mGkyuZvnQODlj7l/M2n
 OxALHame+sxnw6Dip5ZWibI+MLCDiZdM6bkDClBoxToAcjA69fWYdZaFo3WJPTclNskJ/lNIKOWhE
 K6/J/p3A==;
Received: from [122.175.9.182] (port=56142 helo=bulbasaur.couthit.local)
 by server.wki.vra.mybluehostin.me with esmtpa (Exim 4.98.1)
 (envelope-from <parvathi@couthit.com>) id 1u2lu5-0000000035o-33hT;
 Thu, 10 Apr 2025 12:30:49 +0530
From: Parvathi Pudi <parvathi@couthit.com>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	sjg@chromium.org
Cc: pratheesh@ti.com, prajith@ti.com, vigneshr@ti.com, danishanwar@ti.com,
 praneeth@ti.com, srk@ti.com, rogerq@ti.com, afd@ti.com,
 krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com,
 parvathi@couthit.com, basharath@couthit.com
Subject: [PATCH v1 1/1] include: configs: Adds support for AM335x ICE PRUSS
 mode
Date: Thu, 10 Apr 2025 12:29:55 +0530
Message-Id: <20250410065955.9770-2-parvathi@couthit.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250410065955.9770-1-parvathi@couthit.com>
References: <20250410065955.9770-1-parvathi@couthit.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.wki.vra.mybluehostin.me
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.wki.vra.mybluehostin.me: authenticated_id:
 parvathi@couthit.com
X-Authenticated-Sender: server.wki.vra.mybluehostin.me: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Mailman-Approved-At: Thu, 10 Apr 2025 14:58:33 +0200
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

On the AM3359 ICE we have two modes of operation CPSW mode or PRU-ICSS
mode.

For PRU-ICSS mode, connect Pin2 and Pin3 of J18 and J19 and for CPSW mode,
connect Pin1 and Pin2 of J18 and J19.

This patch adds support for PRUSS mode boot strapping from uboot.

Co-developed-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 include/configs/am335x_evm.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/configs/am335x_evm.h b/include/configs/am335x_evm.h
index 19d3c72a6f1..cf43fc05025 100644
--- a/include/configs/am335x_evm.h
+++ b/include/configs/am335x_evm.h
@@ -138,11 +138,10 @@
 			"setenv fdtfile am335x-evm.dtb; fi; " \
 		"if test $board_name = A335X_SK; then " \
 			"setenv fdtfile am335x-evmsk.dtb; fi; " \
-		"if test $board_name = A335_ICE; then " \
-			"setenv fdtfile am335x-icev2.dtb; " \
-			"if test $ice_mii = mii; then " \
-				"setenv pxe_label_override Pruss; fi;" \
-		"fi; " \
+		"if test $board_name = A335_ICE && test $ice_mii = rmii; then " \
+			"setenv fdtfile am335x-icev2.dtb; fi; " \
+		"if test $board_name = A335_ICE && test $ice_mii = mii; then " \
+			"setenv fdtfile am335x-icev2-prueth.dtb; fi; " \
 		"if test $fdtfile = undefined; then " \
 			"echo WARNING: Could not determine device tree to use; fi; \0" \
 	"init_console=" \
-- 
2.17.1

