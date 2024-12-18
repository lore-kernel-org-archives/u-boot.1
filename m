Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E0CE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 15:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A9BF80241;
	Wed, 18 Dec 2024 16:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F365480269; Wed, 18 Dec 2024 16:48:03 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 697E58022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 16:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harrison.mutai@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8164497;
 Wed, 18 Dec 2024 07:48:28 -0800 (PST)
Received: from localhost.localdomain (F4CK67LV29.cambridge.arm.com
 [10.1.27.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF0963F7B4;
 Wed, 18 Dec 2024 07:47:59 -0800 (PST)
From: Harrison Mutai <harrison.mutai@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 Harrison Mutai <harrison.mutai@arm.com>, u-boot@lists.denx.de
Subject: [PATCH 0/4] Enable bloblist support on Vexpress64
Date: Wed, 18 Dec 2024 15:47:50 +0000
Message-ID: <20241218154751.41338-1-harrison.mutai@arm.com>
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

Harrison Mutai (4):
  bloblist: fix typo in code comments
  board: vexpress64: default to hardware device tree
  bloblist: add support for CONFIG_BLOBLIST_PASSAGE
  board: vexpress64: enable bloblist for SPL handoff

 board/armltd/vexpress64/Makefile        |  3 ++-
 board/armltd/vexpress64/vexpress64.c    |  4 ++++
 common/Kconfig                          |  9 ++++++++-
 common/bloblist.c                       |  5 ++++-
 configs/vexpress_fvp_bloblist_defconfig |  5 +++++
 doc/board/armltd/vexpress64.rst         | 16 ++++++++++++++++
 include/bloblist.h                      |  2 +-
 include/configs/vexpress_aemv8.h        |  6 ++++--
 8 files changed, 44 insertions(+), 6 deletions(-)
 create mode 100644 configs/vexpress_fvp_bloblist_defconfig

--
2.46.2

