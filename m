Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D0EC3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 11:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE31480079;
	Fri, 16 May 2025 13:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jCAxvdTg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E35E580107; Fri, 16 May 2025 13:42:01 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A07C8006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 13:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54GBfrod286059;
 Fri, 16 May 2025 06:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747395713;
 bh=4IhW0Yl+6oSYLRXw/of/O1DnAMPUdVRqaa8N5nCfDm8=;
 h=From:To:CC:Subject:Date;
 b=jCAxvdTgqXEKEqYMLCBV//ezs2k1/WbZFM53KGqMcwNxvV1ljXSZmNoZHUxTn32hb
 PFa5AGaqv+Rnm2TNdMwqCxzYDzosmuEpptwpxMTXsXHeQNtx2BHI7hH2tVXUDgfrMJ
 UIPO31ZeEQBPSXCC1TWMRajokfJ/Az9vzkt3fE94=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54GBfrH94150536
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 16 May 2025 06:41:53 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 May 2025 06:41:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 May 2025 06:41:52 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54GBfnh7063026;
 Fri, 16 May 2025 06:41:50 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <quentin.schulz@cherry.de>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <m-shah@ti.com>
Subject: [PATCH 0/2 v2] Propagate bootph-all and bootph-some-ram property to
 all supernodes
Date: Fri, 16 May 2025 17:11:46 +0530
Message-ID: <20250516114148.3862114-1-m-shah@ti.com>
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

In the U-Boot pre-relocation stage, if the parent node lacks
bootph-all/bootph-some-ram property and the driver lacks a pre-reloc
flag, all of its subsequent subnodes gets skipped over from driver
binding—even if they have a bootph* property.

This series addresses the issue by scanning through all the nodes during
build time and propagating the applicable  property to all of its supernode.

Changes since v1: 
- Carry reviewed-by from Simon
- Add a subnode-4 in testcase
- Change commit message and comments in control.py

Link to v1:
https://lore.kernel.org/u-boot/20250512115028.1783305-1-m-shah@ti.com/

Moteen Shah (2):
  tools: binman: control.py: Propagate bootph-all/bootph-some-ram properties to supernodes
  tools: binman: ftest.py: Add testcase for bootph-* propagation

 tools/binman/control.py               | 54 +++++++++++++++++++++++++++
 tools/binman/ftest.py                 | 24 ++++++++++++
 tools/binman/test/347_bootph_prop.dts | 21 +++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 tools/binman/test/347_bootph_prop.dts

-- 
2.34.1

