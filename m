Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0D5C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3990783A84;
	Thu, 10 Apr 2025 10:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="Umo0iXnl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBBD483A57; Thu, 10 Apr 2025 10:41:28 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C2E83A56
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:41:23 +0200 (CEST)
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
 bh=jWylBP2/iwM10W7gNPxjGHYHZAcpPX6p7ZCOALOUg98=; b=Umo0iXnlCNkchfU4n/cyRXJKZL
 vnSXYDZFAwmWqwAbTEPb3+n5qNOMOX0YFKPxWzPK6sreOgawwkRML5q1m1jL7ucESWT5134tTw2gO
 mqqsrxGAESXrdLJGTe5RYXQSDl49FZPjixAPBPspPNIu4/OcDMelfb+aGRDcMQRH6y/fS50b2clLI
 yUOJtslW0jVE9EkAkZy+/sGoNutuZ+ipZcTElkZofquwnZD/JIPoao6w5lLLCcWlNq8cvBvFiqWoo
 yg2FO35OnAa7dywouE3GR4hoJ3yvkFx+L3wFVwS2Tb/Wnjlp+VbvcklvUeqp03yDYcElkChlIJXi2
 PcuaO+FA==;
Received: from [89.212.21.243] (port=54584 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1u2nTQ-0007zv-09;
 Thu, 10 Apr 2025 10:41:23 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>
Cc: upstream@lists.phytec.de,
	u-boot@lists.denx.de
Subject: [PATCH 0/6] Update phyCORE-i.MX93 environment
Date: Thu, 10 Apr 2025 10:41:16 +0200
Message-Id: <20250410084122.1010297-1-primoz.fiser@norik.com>
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

Update PHYTEC phyCORE-i.MX93 environment in mainline U-Boot with changes
from the downstream fork to get back in sync.
 
Leonard Anderweit (1):
  board: phycore-imx93: env: Move bootcmd from defconfig to env

Martin Schwan (1):
  board: phycore-imx93: env: Add common RAUC boot logic

Primoz Fiser (4):
  board: phycore-imx93: env: Move fdt and bootenv addresses
  board: phycore-imx93: env: Add optargs to environment
  board: phycore-imx93: env: Add prepare_mcore to environment
  board: phycore-imx93: env: Add option to disable bootenv.txt import

 board/phytec/phycore_imx93/phycore_imx93.env | 36 +++++++++++++++-----
 configs/imx93-phycore_defconfig              |  1 -
 2 files changed, 27 insertions(+), 10 deletions(-)

-- 
2.34.1

