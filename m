Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AD9C52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 12:12:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5567B88842;
	Tue, 13 Aug 2024 14:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="fOuQpw9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B377688986; Tue, 13 Aug 2024 14:12:22 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEED88871A
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jDOKD0S2R8MCu2WOpe9OLL2S/UdXwW/1B6XSZTvZyE0=; b=fOuQpw9MwgXpxCAHgJT4SCp4xR
 E9hN1bktUuRUcm62O1mZhDFARr09KdlTof6mnWtKWrZENkmRQEyMxBKtsfbttFsnhCri5b+IwvZLS
 gGUmL0/1k8V8iv7b9W3gYQ9v3JLgzZofmQ4nkAVM0oQ+CW6Bf/pHfQGT3wKJ/Nz0e0KFsdExo/FkK
 Ls+fIm9VjSRJ+LR80xhjqeOw2b4v/+B5Di+T/tZcjVWDIrcaNx6QTC0Kb6fyn/AToWgs9eMNIdRii
 doDDj8B40LHKebKkFYpw0oS1afz3IaOlDo9br/5Dz8PVJB5Se+TmT5aiqAdDfSv8ctVyneFGIx2aG
 v1l5qFvA==;
Received: from [89.212.21.243] (port=46818 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1sdqNu-00Fkvz-0L;
 Tue, 13 Aug 2024 14:12:18 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, Primoz Fiser <primoz.fiser@norik.com>,
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Elena Popa <elena.popa@nxp.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: upstream@lists.phytec.de
Subject: [PATCH] imx: imx9: Set correct critical temperature
Date: Tue, 13 Aug 2024 14:12:17 +0200
Message-Id: <20240813121217.2279187-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Commit 3233349fa6e2 ("imx: imx9: fixup thermal trips from fuses")
wrongly set critical temperature to (maxc - 5) instead of maxc.

Fixes: 3233349fa6e2 ("imx: imx9: fixup thermal trips from fuses")
Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 arch/arm/mach-imx/imx9/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 32208220b207..f88e7a222dd4 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -536,7 +536,7 @@ static int fixup_thermal_trips(void *blob, const char *name)
 
 		temp = 0;
 		if (!strcmp(type, "critical"))
-			temp = 1000 * (maxc - 5);
+			temp = 1000 * maxc;
 		else if (!strcmp(type, "passive"))
 			temp = 1000 * (maxc - 10);
 		if (temp) {
-- 
2.34.1

