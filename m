Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87179C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 05:17:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22433879DB;
	Fri, 23 Feb 2024 06:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WJBU8NgR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76F8E879F2; Fri, 23 Feb 2024 05:58:24 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E21D2876BA
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 05:58:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41N4wCSc068062;
 Thu, 22 Feb 2024 22:58:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708664292;
 bh=fBwjrJHf4YVX9eEoY9kaSLFbR766RgE+aRiaKb2anjg=;
 h=From:To:CC:Subject:Date;
 b=WJBU8NgRI0s9HfV+WfYBewjCeaIeCjcwGAu7u1HgrY0XDOVQOsoyPQMGgv8V6zGII
 HAVHgbrBwDZWADbbIvbWoPESjU0Pdj2bg8rCdH244aOXf6/QhupSCVLVLCFDN+8E1/
 udAik0Q7saPmZ0zxIr7LPWuxG8vgEzbYrxkECvaY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41N4wCG5118544
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Feb 2024 22:58:12 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 22:58:12 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 22:58:12 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41N4wCxc077002;
 Thu, 22 Feb 2024 22:58:12 -0600
From: Jonathan Humphreys <j-humphreys@ti.com>
To: <trini@konsulko.com>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH 0/2] Enable OSPI on j721e
Date: Thu, 22 Feb 2024 22:57:23 -0600
Message-ID: <20240223045725.2010498-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 23 Feb 2024 06:16:36 +0100
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

This series enables OSPI storage and boot.

fixes: 58d61fb5a77ef31f6aa5973b3ef9650c92edf5ed ("arm: dts: k3-j721e-sk: Add initial A72 specific dts support")

Jonathan Humphreys (2):
  configs: j721e: Enable OSPI memory
  arm: mach-k3: j721e: Enable OSPI boot

 arch/arm/mach-k3/include/mach/j721e_spl.h | 5 +++--
 arch/arm/mach-k3/j721e_init.c             | 3 ++-
 configs/j721e_evm_a72_defconfig           | 7 +++++++
 configs/j721e_evm_r5_defconfig            | 6 ++++++
 4 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.34.1

