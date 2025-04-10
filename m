Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744B9C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A056383AAB;
	Thu, 10 Apr 2025 10:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="IPeHZYYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 739CA83A6A; Thu, 10 Apr 2025 10:41:29 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D666C83A64
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Um3PT8XYaspnoxcNvxLMMWs69DIYRqE0qb+hjy7X8IY=; b=IPeHZYYVbGUWnMN9sChm2JPPsH
 fl3rT3jFjY8m777AtJ0HmUPTV0o1D6+QN53iXtoRXLcgPCrm3Hr+/N5JgR0EX0vjjHy/H/0oGyZ48
 hq9zWsEe272LqiTjpHYTM++3tpEnMdIBajo46iWwcXWuJMzqLdBjPN72j5QiLKXQlSFIvlkkqfSUG
 r1SIiNfOzG2Xvn9xMvu3FSKkrmdgFuh/VYFt58OFOCy99Ti1MmXoxFyjJEyB9SDIo/l+wseLMSsAA
 C3/cAQRVKwkO/fLuhiym1UTlCdqQCv73GuJL51xvzy+dPW74LdHfR8hsls8HbS42fqZxa+Sdbhvo5
 cBzsCnFg==;
Received: from [89.212.21.243] (port=54584 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1u2nTQ-0007zv-1F;
 Thu, 10 Apr 2025 10:41:23 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>
Cc: upstream@lists.phytec.de,
	u-boot@lists.denx.de
Subject: [PATCH 6/6] board: phycore-imx93: env: Add common RAUC boot logic
Date: Thu, 10 Apr 2025 10:41:22 +0200
Message-Id: <20250410084122.1010297-7-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410084122.1010297-1-primoz.fiser@norik.com>
References: <20250410084122.1010297-1-primoz.fiser@norik.com>
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

From: Martin Schwan <m.schwan@phytec.de>

Add a common RAUC boot logic environment and make use of it in the
i.MX93 environment. The RAUC boot logic is deactivated by default and
can be activated by setting "doraucboot" to "1".

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
Reviewed-by: Leonard Anderweit <l.anderweit@phytec.de>
Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 board/phytec/phycore_imx93/phycore_imx93.env | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/phytec/phycore_imx93/phycore_imx93.env b/board/phytec/phycore_imx93/phycore_imx93.env
index 3a36597cae84..3b2f30118e76 100644
--- a/board/phytec/phycore_imx93/phycore_imx93.env
+++ b/board/phytec/phycore_imx93/phycore_imx93.env
@@ -1,10 +1,14 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 
+#include <env/phytec/rauc.env>
 #include <env/phytec/overlays.env>
 
 bootcmd=
 	mmc dev ${mmcdev};
 	if mmc rescan; then
+		if test ${doraucboot} = 1; then
+			run raucinit;
+		fi;
 		if run loadimage; then
 			run mmcboot;
 		else
-- 
2.34.1

