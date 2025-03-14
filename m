Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5152C28B30
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 13:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1C6081B5B;
	Fri, 14 Mar 2025 14:57:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PYr6146h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2C3981BC5; Fri, 14 Mar 2025 14:57:16 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AF1A80F9C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=f-akthar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52EDvCVn1695734
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 08:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741960632;
 bh=iJaR9BJ3jQO8tcOvD1RYCAg7Z29JbmKVK9+B7VGS/OE=;
 h=From:To:CC:Subject:Date;
 b=PYr6146h9gCQyE8YxMKj7W9VR4uQf51H1Tm9V17wmcfPLozpb2/ButPQI80q5iqST
 Wq0v3mKwza/tW2HMINlEd/SjGla9uq2vMen5o+LUmuKwvsbl+8a9h742xn5d74UGMs
 URIyDuUx9isByqsJZb36+CFJ/VTOHE6+6JfsijiI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52EDvCiA071989
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Mar 2025 08:57:12 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Mar 2025 08:57:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Mar 2025 08:57:12 -0500
Received: from localhost (fayaz-hp-z2-tower-g4-workstation.dhcp.ti.com
 [172.24.227.181] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52EDvBSq049109;
 Fri, 14 Mar 2025 08:57:12 -0500
From: Harsha Vardhan V M <h-vm@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>
Subject: [RFC PATCH v2 0/5] cmd: fuse: Introduce fuse writebuff sub-system and
 clean up
Date: Fri, 14 Mar 2025 19:27:01 +0530
Message-ID: <20250314135706.184807-1-h-vm@ti.com>
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
Patch 2 introduces fuse.rst documentation for fuse commands.
Patch 3 introduces the fuse writebuff sub-system command, allowing to
write a structured buffer in memory to fuses, and implementing the
necessary function calls.
Patch 4 enables the fuse sub-system in the K3 platform.
Patch 5 updates the fuse.rst documentation to include details about the
new fuse writebuff command.

These changes aim to improve the fuse sub-system by the removal of
custom string functions and the addition of the fuse writebuff
command improves fuse programming workflows by allowing to write a
structured buffer in memory to efuses.

Changes in v2:
  1.Convert doc/README.fuse to doc/usage/cmd/fuse.rst as patch #2,
  as requested by trini@konsulko.com.
  2.Add fuse writebuff documentation in fuse.rst in the final patch.

Harsha Vardhan V M (5):
  cmd: fuse: Remove custom string functions
  doc: cmd: add documentation for fuse command
  cmd: fuse: Add fuse writebuff sub-system command
  drivers: k3_fuse: Add fuse sub-system func calls
  doc: cmd: add fuse writebuff cmd documentation

 cmd/Kconfig            |   8 ++
 cmd/fuse.c             |  49 +++++++-----
 doc/usage/cmd/fuse.rst | 176 +++++++++++++++++++++++++++++++++++++++++
 drivers/misc/Kconfig   |   7 ++
 drivers/misc/Makefile  |   1 +
 drivers/misc/k3_fuse.c |  78 ++++++++++++++++++
 include/fuse.h         |   9 +++
 7 files changed, 307 insertions(+), 21 deletions(-)
 create mode 100644 doc/usage/cmd/fuse.rst
 create mode 100644 drivers/misc/k3_fuse.c

-- 
2.34.1

