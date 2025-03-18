Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307D4C35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10D6081A04;
	Wed, 19 Mar 2025 04:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d6dJssE7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B09DD8129F; Tue, 18 Mar 2025 18:39:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB78781026
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremy.compostella@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742319561; x=1773855561;
 h=from:to:subject:date:message-id:mime-version;
 bh=DTv0rl7GE/F/EbXxVnGF0ZObGRZMzNPOk45vCSNMcoI=;
 b=d6dJssE7XJhz/F6hGV9+o7XjUeU/enQpzq+PSPKyXJXzxhT+8xhf1uxa
 lBACUr+qj1Sxqz34fhK9w3GP5//NF+4CJl6+sc6PEtwEAy76TzEzeRQJf
 yokX8ZZLwMhUohz2cLV2tL2EC7bh6kZtFjAd6OyQ6ZlnFfvkrP/4c5JYt
 5GHx4w925/bqhZpLdril4FmjQiPXS4GKwt1AkP2CEKlRm3BAgOiEuhmU6
 qSt3y2YShVPrgXfb4lWibvTqrJ/NWq9LpcJgiJM1FNiYBSduEpJCUhTlp
 +AE/OnZviYqDWcHlQqNV4jRTENMeT6tMrsMCBTNqbmGg0dGst4TIwuH24 w==;
X-CSE-ConnectionGUID: 0oH+SOuySpeICqPCQkiczg==
X-CSE-MsgGUID: 01Ysw7sjSdOIdNfbdW9NkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54859125"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="54859125"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:39:20 -0700
X-CSE-ConnectionGUID: InyViuZRRfauA0q7xa0gpQ==
X-CSE-MsgGUID: BC2lSYeQQLef0iyj7ZIyDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="122068270"
Received: from msatwood-mobl.amr.corp.intel.com (HELO
 jcompost-mobl.amr.corp.intel.com) ([10.125.109.226])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:39:19 -0700
From: Jeremy Compostella <jeremy.compostella@intel.com>
To: <u-boot@lists.denx.de>
Subject: [PATCH 0/5] 64-bit U-Boot configuration without SPL
Date: Tue, 18 Mar 2025 10:39:18 -0700
Message-ID: <87bjtyutkp.fsf@jcompost-mobl.amr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara, CA
 95052. USA
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 19 Mar 2025 04:16:48 +0100
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

Introduces a new configuration option X86_RUN_64BIT_NO_SPL to allow
building U-Boot as a 64-bit binary without using the SPL (Secondary
Program Loader). The motivation is to simplify the boot process for
specific x86-based platforms that do not require SPL, such as those
booting directly from a 64-bit coreboot firmware.

Jeremy Compostella (5):
  arch/x86: Add 64-bit U-Boot configuration without SPL
  arch/x86/cpu: Call x86_cpu_reinit_f for 64-bits
  arch/x86/lib: Fix CONFIG_X86_64 usage in zimage.c
  Fix EFI boot file name definition for 64-bit x86 architecture
  configs: Add coreboot64-no-spl_defconfig for 64-bit X86 without SPL

 arch/x86/Kconfig                    | 10 ++++-
 arch/x86/cpu/coreboot/Kconfig       |  2 +-
 arch/x86/cpu/coreboot/coreboot.c    |  2 +-
 arch/x86/lib/zimage.c               |  2 +-
 configs/coreboot64-no-spl_defconfig | 62 +++++++++++++++++++++++++++++
 include/config_distro_bootcmd.h     |  2 +-
 6 files changed, 75 insertions(+), 5 deletions(-)
 create mode 100644 configs/coreboot64-no-spl_defconfig

-- 
2.48.1

