Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416CEC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 05:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADCA080BA8;
	Tue, 18 Feb 2025 06:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=baocheng.su@siemens.com header.b="DjNKzLNg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41215807F1; Tue, 18 Feb 2025 03:36:31 +0100 (CET)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A04080017
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=baocheng.su@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20250218023628ac4a5dc069d07f5115 for <u-boot@lists.denx.de>;
 Tue, 18 Feb 2025 03:36:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=baocheng.su@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=cpXwRoUfBuz24DEOi/HgE5GTJfZRbqpRU/e4y0LTwo8=;
 b=DjNKzLNgLL+HrtsO/qDNSj6X+NzvlpKL7eqVRZ1F0lpHXdWPJCo9/s3c7vej2nuSPeUQOi
 bCqcrusPt3Kf83izCKVlmSXZV4SypxXeVY84U6myijfZScTWrjHDDyPSBtxMgdQZtk9v4jtg
 iPDGs9B27jIJo2P77giUXjv5NNgzWxZ24PaYkwbOSfXH3yzQ8Fu5/gB+7q/vcFGZpqgJBHqO
 heZheJ5S8GBwrAmrs+swe1CTqBMrzz1NmCQ+sI7pSqfiOeRJog9qK1v7xY30bMW+DjaICh+T
 xx9Si7fWZrpzIKuop6zEZpEhlKFvnkJGRQt5KokNehsXBJYWIkfnU1Gg==;
From: Baocheng Su <baocheng.su@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>,
 Li Hua Qian <huaqian.li@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Baocheng Su <baocheng.su@siemens.com>
Subject: [PATCH v4 0/5] boards: siemens: iot2050: SM variant, sysinfo support,
 fixes & cleanups
Date: Tue, 18 Feb 2025 10:36:09 +0800
Message-Id: <20250218023614.52574-1-baocheng.su@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-909155:519-21489:flowmailer
X-Mailman-Approved-At: Tue, 18 Feb 2025 06:35:12 +0100
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

This introduces a sysinfo driver which also permits SMBIOS support.

The first 10 patches of v2 have already been applied. The remaining is
solely the sysinfo driver. To maintain consistency and ease of searching
through the history, the series title remains unchanged.

Baocheng

Changes in v4:
- rebased over master
- Drop the SYSINFO in iot2050_defconfig

Changes in v3:
- rebased over master
- UUID is filled into SMBios as binary, not string
- add new sysinfo API to get data by index
- add new sysinfo API to get RAM size in MB
- iot2050 sysinfo driver rework

Changes in v2:
- rebased over master, adding the missing 6.12 cherry-picks from
  devicetree-rebasing

Baocheng Su (5):
  smbios: Fill UUID from sysinfo when available
  sysinfo: Add API for accessing data elements
  sysinfo: Add SYSID_BOARD_RAM_SIZE_MB
  sysinfo: Add driver for IOT2050 boards
  board: siemens: iot2050: Use sysinfo for board initialization

 .../dts/k3-am65-iot2050-common-u-boot.dtsi    |  18 ++
 arch/arm/mach-k3/am65x/Kconfig                |   2 +
 board/siemens/iot2050/board.c                 | 142 ++++++------
 drivers/sysinfo/Kconfig                       |   7 +
 drivers/sysinfo/Makefile                      |   1 +
 drivers/sysinfo/iot2050.c                     | 202 ++++++++++++++++++
 drivers/sysinfo/iot2050.h                     |  14 ++
 drivers/sysinfo/sysinfo-uclass.c              |  29 +++
 include/sysinfo.h                             |  65 ++++++
 lib/smbios.c                                  |   6 +
 10 files changed, 424 insertions(+), 62 deletions(-)
 create mode 100644 drivers/sysinfo/iot2050.c
 create mode 100644 drivers/sysinfo/iot2050.h

-- 
2.39.5

