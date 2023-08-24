Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD73AC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 15:40:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD278667B;
	Thu, 24 Aug 2023 17:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BJT8BUnX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BCBC8056A; Thu, 24 Aug 2023 17:40:47 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6176686401
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 17:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37OFebNM066685;
 Thu, 24 Aug 2023 10:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692891637;
 bh=nSTD2K/yfxvjX1AYMHcT4DQA2J5bXvMOAsKOTLECWRs=;
 h=From:To:CC:Subject:Date;
 b=BJT8BUnXMSukPcRqsk3d92+YvxMLbNFVH3zN9lpPIE6W8Fvx/oEVYJs+6fMXNYsaX
 zUHCF80yp4P+eKGDmGanlSAz68U2QZAtwX59RsbbN6LTfrBoT8pfaTXXz2z2xE0Dkb
 rRN+rIYnZzIdxcleoZWbvP1jgxDOmzdaTE9dV4u8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37OFebhl021251
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Aug 2023 10:40:37 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 10:40:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 10:40:37 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37OFebQ3060700;
 Thu, 24 Aug 2023 10:40:37 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Neha Francis
 <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>
Subject: [RFC PATCH 0/2] doc: sphinx: Add sphinx-prompt
Date: Thu, 24 Aug 2023 10:40:34 -0500
Message-ID: <20230824154036.3650607-1-nm@ti.com>
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

Add Sphinx-prompt for more readable documentation and yet is
userfriendly for people to copy paste.

See https://lore.kernel.org/all/87fs48rgto.fsf@baylibre.com/

If this approach looks correct, please ack and I can convert the
doc/board/ti/*.rst segments off to prompt instead of code-block where
applicable.

Quick video to show the difference in experience: https://youtu.be/ylDrHXWGVgo

Nishanth Menon (2):
  doc: sphinx: Add sphinx-prompt
  doc: board: ti: k3: Convert to sphinx-prompt

 doc/board/ti/k3.rst         | 112 ++++++++++++++++++------------------
 doc/conf.py                 |   2 +-
 doc/sphinx/requirements.txt |   1 +
 3 files changed, 59 insertions(+), 56 deletions(-)

-- 
2.40.0

