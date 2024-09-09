Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90809ECE579
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 11:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8FF288D9C;
	Mon,  9 Sep 2024 13:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5056188D9A; Mon,  9 Sep 2024 13:20:37 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5079188CBD
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 13:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42453FEC;
 Mon,  9 Sep 2024 04:21:03 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 230A93F73B;
 Mon,  9 Sep 2024 04:20:32 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 0/6] Miscellaneous FWU fixes
Date: Mon,  9 Sep 2024 16:50:15 +0530
Message-Id: <20240909112021.1962801-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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


The following set of patches are miscellaneous fixes and some
hardening of the FWU update logic.


Changes since V1:
* Squash patch 1 and 2 in the earlier version into a single patch.
* Have a single check for image descriptor offset, and have a log
  message mention that image descriptor mandatory.
* Use a macro FWU_IMG_DESC_OFFSET for the image descriptor offset.
* Use the enum names for primary and secondary partitions from fwu.h
  instead of defining new macros.


Sughosh Ganu (6):
  fwu: v2: try reading both copies of metadata
  fwu: v1: do a version check for the metadata
  fwu: check all images for transitioning out of Trial State
  fwu: add dependency checks for selecting FWU metadata version
  fwu: do not allow capsule processing on exceeding Trial Counter
    threshold
  fwu: print a message if empty capsule checks fail

 include/fwu.h                | 11 +++++
 lib/efi_loader/efi_capsule.c | 11 +++--
 lib/fwu_updates/Kconfig      |  1 +
 lib/fwu_updates/fwu.c        | 31 +++++++++++++-
 lib/fwu_updates/fwu_v1.c     | 18 ++++++--
 lib/fwu_updates/fwu_v2.c     | 81 ++++++++++++++++++++----------------
 6 files changed, 108 insertions(+), 45 deletions(-)

-- 
2.34.1


