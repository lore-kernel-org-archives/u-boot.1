Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C392C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 17:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0628805E2;
	Tue,  4 Feb 2025 18:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2B04805E7; Tue,  4 Feb 2025 18:58:52 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C4235801FD
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 18:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harrison.mutai@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18A3E11FB;
 Tue,  4 Feb 2025 09:59:14 -0800 (PST)
Received: from localhost.localdomain (unknown [10.1.31.150])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 410DD3F58B;
 Tue,  4 Feb 2025 09:58:49 -0800 (PST)
From: Harrison Mutai <harrison.mutai@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 Harrison Mutai <harrison.mutai@arm.com>, u-boot@lists.denx.de
Subject: [PATCH v3 0/4] Enable bloblist support on Vexpress64
Date: Tue,  4 Feb 2025 17:58:38 +0000
Message-ID: <20250204175844.19890-1-harrison.mutai@arm.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series of patches enhances the vexpress64 platform by enabling bloblist
support. It also introduces support for CONFIG_BLOBLIST_PASSAGE. This is
necessary to boot vexpress64 and other boards without manually specifying a
fixed address and size for the bloblist.

After this change, all the bloblist init modes are supported (i.e., fixed,
alloc, passage) and Vexpress64 boots with CONFIG_BLOBLIST_PASSAGE.

Changes in v2:

* The commit body for the typo fix was expanded.
* The default BLOBLIST_RELOC_SIZE was removed when CONFIG_BLOBLIST_PASSAGE is
  enabled, the relocation size depends on the size of bloblist received.

Changes in v3:

* Add constraint on call to xferlist_from_boot_args to avoid calling it when
  BLOBLIST_ALLOC is enabled.
* Minor clean-up in bloblist_init and bloblist_reloc.
* Fix typo in BLOBLIST_FIXED description.

Harrison Mutai (4):
  bloblist: fix typo in code comments
  board: vexpress64: default to hardware device tree
  bloblist: add support for CONFIG_BLOBLIST_PASSAGE
  board: vexpress64: enable bloblist for SPL handoff

 board/armltd/vexpress64/Kconfig         |  2 +-
 board/armltd/vexpress64/Makefile        |  5 ++++-
 board/armltd/vexpress64/vexpress64.c    |  4 ++++
 common/Kconfig                          | 14 ++++++++++----
 common/bloblist.c                       | 18 ++++++++++--------
 configs/vexpress_fvp_bloblist_defconfig |  5 +++++
 doc/board/armltd/vexpress64.rst         | 16 ++++++++++++++++
 include/bloblist.h                      |  2 +-
 include/configs/vexpress_aemv8.h        |  6 ++++--
 9 files changed, 55 insertions(+), 17 deletions(-)
 create mode 100644 configs/vexpress_fvp_bloblist_defconfig

-- 
2.46.2

