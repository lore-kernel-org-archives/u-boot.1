Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72474C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 11:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870048842C;
	Wed, 12 Jun 2024 13:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="doV1vRdx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26222886E2; Wed, 12 Jun 2024 13:08:01 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C42E883D3
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 13:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CB7rv4041854;
 Wed, 12 Jun 2024 06:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718190473;
 bh=xU/Aw7dv4ywWyiRvSO7DoUg0d5oOuhaAT639tSOtQVE=;
 h=From:To:CC:Subject:Date;
 b=doV1vRdx5FFuzS9F4gT3XkxChb04pdZJKse66duJ3cRijgiv5fr/tQUu4Xdul2KXN
 uZBo+FyIQJyw7knOMmU4vcg9TVDIItggr/19UhJ+PBs6O+Uh+z/p7zkVYEBbjua6xc
 b5b6Yo3k57KC0/v3C1MQqppPnUTMakB+hH3K+nls=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CB7rqY117144
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Jun 2024 06:07:53 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 06:07:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 06:07:53 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CB7rYs111126;
 Wed, 12 Jun 2024 06:07:53 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 45CB7qSS031829;
 Wed, 12 Jun 2024 06:07:52 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Judith Mendez <jm@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Simon Glass <sjg@chromium.org>,
 Roger Quadros <rogerq@kernel.org>, Andrew Davis <afd@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Nishanth Menon <nm@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
Subject: [PATCH v2 0/2] Enable ICSSG Driver for AM64x
Date: Wed, 12 Jun 2024 16:37:47 +0530
Message-ID: <20240612110749.1699824-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
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

This series adds config changes and env changes to enable ICSSG Ethernet
Driver on AM64x.

Changes since v1:
*) Dropped the patch [0] as this needs to be fixed in driver as suggested
   by Andrew Davis <afd@ti.com>
*) Rebased on latest u-boot/next.

v1 https://lore.kernel.org/all/20240522063652.3759497-1-danishanwar@ti.com/
[0] https://lore.kernel.org/all/cb53651f-a823-41b8-81e5-c3939bd33764@ti.com/

Thanks and Regards,
MD Danish Anwar 

MD Danish Anwar (2):
  configs: am64x_evm_a53: Enable ICSSG Driver
  board: ti: am64x: Set storage_interface and fw_dev_part ENVs

 board/ti/am64x/am64x.env        | 5 +++++
 configs/am64x_evm_a53_defconfig | 5 +++++
 2 files changed, 10 insertions(+)


base-commit: 9cf83a7da95b70a37d0d2aba79439dc8a2944fe3
-- 
2.34.1

