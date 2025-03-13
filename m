Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC11C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 11:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5B2680756;
	Thu, 13 Mar 2025 12:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Pd/F/ToF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D54D0810F4; Thu, 13 Mar 2025 12:55:23 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E92F8007D
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 12:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=f-akthar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52DBtJqC1374129
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 06:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741866919;
 bh=nAzEFYbPjQs0DWnUxzj+wgszAjoSE4aXhMo0TYihuZQ=;
 h=From:To:CC:Subject:Date;
 b=Pd/F/ToFHBpOuY5MQaR9idg6HWiXxpkZmHnnxASliSYYptPJ8PS6NHpDZCJeNtUDC
 Aq1t6Y5Mw3CWaOf8mZqohLljVylf/IXe2tld+M3Y9Yxhp1usefgpeLLBc5WdVOlvVb
 dvMrq6oLpydW3+Nx/kn0Bt+BZU5wVOsELiwTdf1I=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52DBtJWg097063
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Mar 2025 06:55:19 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Mar 2025 06:55:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Mar 2025 06:55:19 -0500
Received: from localhost (fayaz-hp-z2-tower-g4-workstation.dhcp.ti.com
 [172.24.227.128])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52DBtIXC035184;
 Thu, 13 Mar 2025 06:55:18 -0500
From: Harsha Vardhan V M <h-vm@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>
Subject: [RFC PATCH 0/4] cmd: fuse: Introduce fuse writebuff sub-system and
 clean up
Date: Thu, 13 Mar 2025 17:25:13 +0530
Message-ID: <20250313115517.1181829-1-h-vm@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

This patch series introduces the fuse writebuff sub-system command and
makes improvements to the existing fuse implementation by removing the
custom string functions. The patches are required to be applied in
sequence.

The series consists of the following changes:
Patch 1 removes custom string functions and replaces them with standard
string functions.
Patch 2 introduces the fuse writebuff sub-system command, allowing to
write a structured buffer in memory to fuses, and implementing the
necessary function calls.
Patch 3 enables the fuse sub-system in the K3 platform.
Patch 4 updates the documentation to include details about the new fuse
writebuff command.

These changes aim to improve the fuse sub-system by the removal of
custom string functions and the addition of the fuse writebuff
command improves fuse programming workflows by allowing to write a
structured buffer in memory to efuses.

Harsha Vardhan V M (4):
  cmd: fuse: Remove custom string functions
  cmd: fuse: Add fuse writebuff sub-system command
  drivers: k3_fuse: Add fuse sub-system func calls
  docs: fuse: Add fuse writebuff cmd docs

 cmd/Kconfig            |  8 +++++
 cmd/fuse.c             | 49 ++++++++++++++------------
 doc/README.fuse        | 14 ++++++++
 drivers/misc/Kconfig   |  7 ++++
 drivers/misc/Makefile  |  1 +
 drivers/misc/k3_fuse.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 include/fuse.h         |  9 +++++
 7 files changed, 145 insertions(+), 21 deletions(-)
 create mode 100644 drivers/misc/k3_fuse.c

-- 
2.34.1

