Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1315FC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 08:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B5578129F;
	Wed, 19 Mar 2025 09:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DrTiuEoF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B62008141E; Wed, 19 Mar 2025 09:47:26 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1420581101
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 09:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=f-akthar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52J8lLJA254886
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 19 Mar 2025 03:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742374041;
 bh=jn6edIjybm+WYHOTdGbzmqSYNDzrx93nzwzOYdoOjVc=;
 h=From:To:CC:Subject:Date;
 b=DrTiuEoFmwWUsEOYFZizKo5IVJGuoYe+CyPBOk5Cvpb84EPjUqhal6Zla64OgI4IG
 qu+88AMFKAL0p/ZkMzC8Dmxi1o0eYQUDTPBTiiHFd992+Tl1TKetRNdNd8N2SmpMuJ
 N/jqSzvN/zv2fQBYEp2mEcEFn+LqFjakO3JMcI2Q=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52J8lLQK016008;
 Wed, 19 Mar 2025 03:47:21 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 03:47:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 03:47:21 -0500
Received: from localhost (fayaz-hp-z2-tower-g4-workstation.dhcp.ti.com
 [172.24.227.181] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52J8lKUL021830;
 Wed, 19 Mar 2025 03:47:20 -0500
From: Harsha Vardhan V M <h-vm@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>
Subject: [PATCH 0/5] cmd: fuse: Introduce fuse writebuff sub-system and clean
 up
Date: Wed, 19 Mar 2025 14:17:09 +0530
Message-ID: <20250319084714.335777-1-h-vm@ti.com>
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

Changes in non-RFC patch series:
  Drop the explicit u32 typecast throughout in patch #1.
  Link to RFC v3 patch series: https://lore.kernel.org/u-boot/20250318140932.GY2640854@bill-the-cat/T/#m79236044732c410b0281973ef03c11e4d3e31991

Harsha Vardhan V M (5):
  cmd: fuse: Remove custom string functions
  doc: cmd: Add documentation for fuse command
  cmd: fuse: Add fuse writebuff sub-system command
  drivers: k3_fuse: Add fuse sub-system func calls
  doc: cmd: Add fuse writebuff cmd documentation

 cmd/Kconfig            |   8 ++
 cmd/fuse.c             |  63 +++++++++------
 doc/README.fuse        |  67 ----------------
 doc/usage/cmd/fuse.rst | 176 +++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst    |   1 +
 drivers/misc/Kconfig   |   7 ++
 drivers/misc/Makefile  |   1 +
 drivers/misc/k3_fuse.c |  78 ++++++++++++++++++
 include/fuse.h         |   9 +++
 9 files changed, 320 insertions(+), 90 deletions(-)
 delete mode 100644 doc/README.fuse
 create mode 100644 doc/usage/cmd/fuse.rst
 create mode 100644 drivers/misc/k3_fuse.c

-- 
2.34.1

