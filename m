Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8BBCFB42C
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 19:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2342588970;
	Sat,  5 Oct 2024 21:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CowyTk0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08E3588B0A; Sat,  5 Oct 2024 21:14:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 490A388965
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 21:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728155641; x=1759691641;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=w53x4NZE698phaGtnxCqnOgBAScD7a6UcQoedAbUnaQ=;
 b=CowyTk0a35QSlJzlK/qnsRtEIjSZU4WY6svoJD3ps4F3ViQv4ra/lXrF
 zMeNT8OCNfQwIYpmnTwiRlYnGGwJmZMEdmRMPnTSEh3CjNX2YgaRt6Fw+
 QnG3kYuFFE9ExQXiplu7z0yN+DsuwEifL1C8nWjWHN+eQSfru14QgIgPv
 4IaoElsDnDxOoD7ty+otfsrr7siX1SGCUZY5VrasENcbOXF3LW+Qkz/HT
 pLBq0FdXcvgsoWII4IpUIB7TYGMMrMh3aCO1LhDqfF9Hgf6KA/a5UlqaE
 kDKLLspAyaWdRQphyixdmpxb4uM+X/5UYiXTMDWgRVDQaJlQBId1jppii g==;
X-CSE-ConnectionGUID: F54p0Y0DSPGCII6yxq/XzQ==
X-CSE-MsgGUID: FfAkoER+QxKcL3I9w/KRZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="38742267"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; d="scan'208";a="38742267"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2024 12:13:59 -0700
X-CSE-ConnectionGUID: 9Tsa9dBvSyCwiqb65MvIXg==
X-CSE-MsgGUID: Yw2C3s+RRCiFUWxVByE4QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; d="scan'208";a="79813921"
Received: from black.fi.intel.com ([10.237.72.28])
 by orviesa005.jf.intel.com with ESMTP; 05 Oct 2024 12:13:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id E13E7178; Sat, 05 Oct 2024 22:13:55 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tom Rini <trini@konsulko.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v1 0/4] x86: Clean up and fix to avoid compiler warnings
Date: Sat,  5 Oct 2024 22:11:56 +0300
Message-ID: <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Some fixes to avoid compiler warnings with `make W=1`. The idea to
continue this for at least some of the x86 related code.

Andy Shevchenko (4):
  x86: cpu: Use default print_cpuinfo() for all
  x86: cpu: Mark a few functions static
  x86: cpu: Add a few prototypes to the header file
  x86: cpu: Add missing header inclusion

 arch/x86/cpu/broadwell/cpu.c                 | 12 ------------
 arch/x86/cpu/coreboot/coreboot.c             |  5 -----
 arch/x86/cpu/cpu.c                           |  8 ++++++--
 arch/x86/cpu/cpu_x86.c                       |  1 +
 arch/x86/cpu/efi/app.c                       |  5 -----
 arch/x86/cpu/efi/payload.c                   |  5 -----
 arch/x86/cpu/i386/interrupt.c                |  2 +-
 arch/x86/cpu/ivybridge/cpu.c                 | 14 --------------
 arch/x86/cpu/mtrr.c                          |  2 +-
 arch/x86/cpu/qemu/qemu.c                     |  6 ------
 arch/x86/cpu/quark/quark.c                   |  6 ------
 arch/x86/cpu/slimbootloader/slimbootloader.c |  5 -----
 arch/x86/cpu/tangier/tangier.c               |  5 -----
 arch/x86/cpu/x86_64/misc.c                   |  5 -----
 arch/x86/include/asm/cpu.h                   |  7 +++++++
 arch/x86/include/asm/u-boot-x86.h            |  1 -
 arch/x86/lib/fsp/fsp_common.c                |  6 ------
 17 files changed, 16 insertions(+), 79 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac

