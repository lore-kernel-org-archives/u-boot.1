Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3DCC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3CC287F1F;
	Tue, 12 Mar 2024 10:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ugrkgmHA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48CFB87D9D; Tue, 12 Mar 2024 10:44:45 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7388887F34
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:44:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42C9ieml065497;
 Tue, 12 Mar 2024 04:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710236680;
 bh=sKjyTH306b4eTe2wKhtR6iEGK6YvraAmQmCYA7On/RY=;
 h=From:To:Subject:Date;
 b=ugrkgmHAo86nzge5KUjJpz+pSMGd1TVZ2pEkniGcDqXFqufxcL7GHMAriiyN7aVJv
 qTD1GuZyAEaLZn81I5P6TWAz5kWTDDBF2MAntJWt6rNBQiyrfs8FrBVOEJrBTk4lQs
 Xycf+Y9aNMxYhXF+XU75A8Q0PWrlUvCuztmmJbew=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42C9ieiJ019372
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Mar 2024 04:44:40 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 04:44:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 04:44:39 -0500
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.69.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42C9ibb1063791;
 Tue, 12 Mar 2024 04:44:38 -0500
From: Apurva Nandan <a-nandan@ti.com>
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>, Manorit
 Chawdhry <m-chawdhry@ti.com>, Udit Kumar <u-kumar1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 0/2] Add remoteproc driver support for J721S2 SoC
Date: Tue, 12 Mar 2024 15:14:34 +0530
Message-ID: <20240312094436.2959542-1-a-nandan@ti.com>
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

This series adds relevant ip data in remoteproc driver for j721s2 compatible.

Logs: https://gist.githubusercontent.com/apurvanandan1997/276098af439e11105ab9f809159fcc98/raw/

Changes in v3:
- Removed j721s2.env patch from the series

Link to v2:
https://lore.kernel.org/all/20231127-b4-upstream-j721e-rproc-support-v2-0-22ee7c8ef53c@ti.com/

Changes in v2:
- Update the signoff

Hari Nagalla (2):
  remoteproc: k3-r5: Extend support for R5F clusters on J721S2 SoCs
  remoteproc: k3-dsp: Extend support for C71x DSPs on J721S2 SoCs

 drivers/remoteproc/ti_k3_dsp_rproc.c | 4 +++-
 drivers/remoteproc/ti_k3_r5f_rproc.c | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.34.1

