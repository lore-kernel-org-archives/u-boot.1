Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3375C48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 12:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C67C487E60;
	Thu,  8 Feb 2024 13:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="ZhdGbq+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B04AA87E2D; Thu,  8 Feb 2024 10:45:49 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01E3287E01
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 10:45:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rY0yV-0003p2-Gw; Thu, 08 Feb 2024 04:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=owHdwHlk8zmfw0szkEgMbETbTZc+U9rXz1f++4T/wBE=; b=ZhdGbq+B1EIbNDj0MA8n
 ZRcosFpZbzpe0PTFTHPeI/JvKax0zRJUhYH6WGgk7lE722xbDchPJuef3GjPAmWOeZ3Ceqymypm/E
 Vio9apRoIU4wo8R6LcIWOYubP2UAJKNSMOsnbsoAwD5xCQ3gLxB7hge1ffMeYVdNwa04tU3G+yN+Y
 mufvClKmlIlXNa/h19Y2bc1ElOsWqcMwYilSSNZ8lcfc2u4q+3UvBfGcLlzCZVEW38DL0Ok85a1hS
 MYB0o6prr4tIES0+BaNLwyPn7h+/BjqNQuXv10ci2krqaUb8rUbKN7pTqgABIHRlfCvlDTOIrfkfn
 Ve0X0ovpv2YOkw==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH 1/2] board: imx93_var_som: Probe ELE MU
Date: Thu,  8 Feb 2024 10:45:17 +0100
Message-ID: <20240208094518.391-2-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240208094518.391-1-othacehe@gnu.org>
References: <20240208094518.391-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 Feb 2024 13:10:31 +0100
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

Probing the MU is needed to prevent this error in the SPL:

ele dev is not initialized
Authenticate container hdr failed, return -19, resp 0x0
IND = INVALID

ele dev is not initialized
Error: release container failed, resp 0x0!
IND = INVALID

SPL: failed to boot from all boot devices

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 board/variscite/imx93_var_som/spl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/board/variscite/imx93_var_som/spl.c b/board/variscite/imx93_var_som/spl.c
index 502e599b91a..0965a2de996 100644
--- a/board/variscite/imx93_var_som/spl.c
+++ b/board/variscite/imx93_var_som/spl.c
@@ -97,6 +97,7 @@ int power_init_board(void)
 	return 0;
 }
 
+extern int imx9_probe_mu(void *ctx, struct event *event);
 void board_init_f(ulong dummy)
 {
 	int ret;
@@ -114,9 +115,9 @@ void board_init_f(ulong dummy)
 
 	preloader_console_init();
 
-	ret = arch_cpu_init();
+	ret = imx9_probe_mu(NULL, NULL);
 	if (ret) {
-		printf("Fail to init Sentinel API\n");
+		printf("Fail to init ELE API\n");
 	} else {
 		printf("SOC: 0x%x\n", gd->arch.soc_rev);
 		printf("LC: 0x%x\n", gd->arch.lifecycle);
-- 
2.41.0

