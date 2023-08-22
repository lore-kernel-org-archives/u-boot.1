Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC369EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C3B9864D7;
	Tue, 22 Aug 2023 18:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aBUxC91B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D678864D5; Tue, 22 Aug 2023 18:41:17 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFAEB86474
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfBJV048828;
 Tue, 22 Aug 2023 11:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692722471;
 bh=PCN4tN38DDuKpW541H8OukUjDYydsTAFrfXtTTxB7aU=;
 h=From:To:CC:Subject:Date;
 b=aBUxC91B7tqotJvIKjY3p0y9N5sZaRMSxL5TiFm1M6VRN+4lpPwf//sAwXZtFdEfw
 XpZPRNUrUhuS46+lX5etMarPGkQd1z8/xZ067dpR59WP384C/TBUdDdL9Mig4jg8bZ
 XFMwaqf/CUs2ji4ip/muZUGdoplDn1Zq2BxUWmbI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MGfA5S007417
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 11:41:11 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 11:41:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 11:41:10 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfA99028352;
 Tue, 22 Aug 2023 11:41:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Neha Malcom Francis
 <n-francis@ti.com>, <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 00/13] doc: board; ti: Misc fixups
Date: Tue, 22 Aug 2023 11:40:54 -0500
Message-ID: <20230822164107.2272231-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

A series of fixups based on next

7e6e40c57233 (origin/next) Merge tag 'v2023.10-rc3' into next

This consists of Henrich's patches that I have updated (details in the
patches) + a few misc items seen in documentation.

Heinrich Schuchardt (3):
  doc: board: ti: k3: image alt texts
  doc: board: ti: am62x: provide image alt texts
  doc: board: ti: am65x: provide image alt text

Nishanth Menon (10):
  doc: board: ti: k3: Fixup alt text for openocd sequence
  doc: board: ti: am64x: provide image alt text
  doc: board: ti: j7200: provide image alt text
  doc: board: ti: j721e: provide image alt text
  doc: board: ti: am62x: Fix build step numbering
  doc: board: ti: am64x: Fix build step numbering
  doc: board: ti: am65x: Fix build step numbering
  doc: board: ti: j7200: Fix build step numbering
  doc: board: ti: j721e: Fix build step numbering
  doc: board: ti: k3: Elaborate on various firmware

 doc/board/ti/am62x_sk.rst  |  7 +++++--
 doc/board/ti/am64x_evm.rst |  7 +++++--
 doc/board/ti/am65x_evm.rst | 18 ++++++++++++------
 doc/board/ti/j7200_evm.rst | 23 +++++++++++++----------
 doc/board/ti/j721e_evm.rst | 21 +++++++++++++--------
 doc/board/ti/k3.rst        | 25 ++++++++++++++++++++++++-
 6 files changed, 72 insertions(+), 29 deletions(-)

-- 
2.40.0

