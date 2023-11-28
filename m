Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AD7C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 07:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82DEE87655;
	Tue, 28 Nov 2023 08:20:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Prc2oRJG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 441A487627; Tue, 28 Nov 2023 08:20:25 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CB7B86F68
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 08:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AS7KHYZ086877;
 Tue, 28 Nov 2023 01:20:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701156017;
 bh=Q/aUTWaLN0zOAmiDGKNjDe8PMzIt0Shi/9r3ASHfDTc=;
 h=From:To:CC:Subject:Date;
 b=Prc2oRJGWuPyHH+hRJPfPZQVUozlWO7FjphH8PhI2hWsO/4AhNHPkiy2+zoFgW/eY
 yipzoNjFcmw0k1CX0JnQN9Z7uSWF+sqnJb74Dcnw+EsadsY+4gsa66VU0zDaI3I5sM
 mv4E6oz4hsk/XedPYI83NJlBMBLbDXJZIk3p4MmY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AS7KHN7023925
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 Nov 2023 01:20:17 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 01:20:17 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 01:20:17 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AS7KEsE002840;
 Tue, 28 Nov 2023 01:20:15 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <rogerq@kernel.org>, <n-francis@ti.com>,
 <u-kumar1@ti.com>
Subject: [PATCH 0/2] board: ti: j721s2: Switch to standard boot
Date: Tue, 28 Nov 2023 12:50:11 +0530
Message-ID: <20231128072013.440465-1-n-francis@ti.com>
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

This series switches J721S2 to standard boot flow.

Boot logs:
https://gist.github.com/nehamalcom/127019254d49057b5d342f66841bfd3c

Neha Malcom Francis (2):
  board: ti: j721s2: j721s2.env: Add explicit boot_targets
  configs: j721e_evm_a72_defconfig: Switch to bootstd

 board/ti/j721s2/j721s2.env       | 1 +
 configs/j721s2_evm_a72_defconfig | 5 +++--
 include/configs/j721s2_evm.h     | 1 -
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.34.1

