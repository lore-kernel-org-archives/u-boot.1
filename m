Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3D4C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 08:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B7DE81A0C;
	Thu, 27 Mar 2025 09:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c7TKkNoq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D50F81951; Thu, 27 Mar 2025 09:06:56 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFC58806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 09:06:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52R86koX2424319
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 03:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743062806;
 bh=MaE6kqKUezKzEkVfsQzoiXYUWGYlZwTgC+NdFbWodk8=;
 h=From:To:CC:Subject:Date;
 b=c7TKkNoqIUqnXYdZRTKf959c/rCbDIy9o1mS33TmgcQKdGyys71lO7BrXLv+SuWL0
 bZROZNIj3eMNjUNPpSFHPxVEMehEYMd7NW0YGO4Y2u/4z8UAgEoQeyQdXst5ppFEvn
 1u4gGF6Nl7d6AMNma/7UVut9gXcSMg8xnmg7AFRo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52R86ktM011117
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Mar 2025 03:06:46 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Mar 2025 03:06:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Mar 2025 03:06:46 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52R86g7v078860;
 Thu, 27 Mar 2025 03:06:43 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <quentin.schulz@cherry.de>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>, <m-shah@ti.com>
Subject: [RFC PATCH 0/1 v2] Propagate bootph* property to all parent nodes
Date: Thu, 27 Mar 2025 13:36:40 +0530
Message-ID: <20250327080642.2269856-1-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

In the U-Boot pre-relocation stage, if the parent node lacks bootph*
property and the driver lacks a pre-reloc flag, all of its subsequent
subnodes gets skipped over from driver binding—even if they have a
bootph* property.

This series addresses the issue by scanning through all the nodes during
build time and adds the bootph-* property to all of its supernode.

Change since v1:
https://lore.kernel.org/u-boot/20250212091820.213895-1-m-shah@ti.com/
- Change of approach to do the bootph-* property addition during
build time instead of run time, saving boot time delays seen in V1.

Moteen Shah (2):
  tools: binman: control.py: Propagate bootph-* properties to supernodes
  tools: binman: ftest.py: Add testcase for bootph-* propagation

 tools/binman/control.py               | 35 ++++++++++++++++++++++++++-
 tools/binman/ftest.py                 | 17 +++++++++++++
 tools/binman/test/347_bootph_prop.dts | 19 +++++++++++++++
 3 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 tools/binman/test/347_bootph_prop.dts

-- 
2.34.1

