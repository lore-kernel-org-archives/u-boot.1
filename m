Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CF5E7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FE1C8901D;
	Thu,  5 Dec 2024 14:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DnbgIrRO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F9E89265; Thu,  5 Dec 2024 04:56:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85C0189335
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 04:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=muhammad.hazim.izzat.zamri@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733371000; x=1764907000;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nxwLProWCzWF4dqOtKWf4ryyPj0u+kaUu1MYlyNU394=;
 b=DnbgIrROQ7NXPxWPr5031JlfVNKi23sJDsHs15ygBJNeQXf25n7bBnSM
 WT0VVfyN7GIqm//a8FmbgG25SVnUxgCgHXlSmwXtVhVFEHfDX2WfXGYz2
 EfmYCEAwLyZz+ihvUqHk6nIh5sc62zGTiHraKU+j6j4AYPNxaUsALdR6b
 oeA6SHSIPrnuz7VDegffldHY0FHSF3MDnH3JPlYfHXaqD0zL+lpadZuLn
 P9QF2zYEm43/ucVlobcdLrycFfdG9EzUepvaDOeQFJzNwdl3FEhyMwXdz
 uDERT4TfhB3HGT+pvAwIG1B/n/f3oHfJoe5k6e+xBUeqBAVkZsMdixzZf g==;
X-CSE-ConnectionGUID: uhRXuD2kRwKWEhJWYup1IQ==
X-CSE-MsgGUID: TW1RKUXpQEOBXFTd8aTW9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="51080285"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="51080285"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 19:56:37 -0800
X-CSE-ConnectionGUID: l5GcJ6+pTyqj8tGo8QLQ+Q==
X-CSE-MsgGUID: 9y/JrDV0TaSruQX8WGhddA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94154076"
Received: from apgcp0d540112.png.altera.com ([10.244.77.34])
 by fmviesa008.fm.intel.com with ESMTP; 04 Dec 2024 19:56:33 -0800
From: muhammad.hazim.izzat.zamri@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong <tien.fong.chee@intel.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Kok Kiang <kok.kiang.hea@intel.com>, Dinesh <dinesh.maniyam@intel.com>,
 Boon Khai <boon.khai.ng@intel.com>, Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH v1 0/1] SoCFPGA: Add watchdog mode setting for Agilex 5
Date: Thu,  5 Dec 2024 11:55:59 +0800
Message-Id: <20241205035600.10545-1-muhammad.hazim.izzat.zamri@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 05 Dec 2024 14:07:50 +0100
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

From: Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@intel.com>

This patch is to introduce another watchdog mode setting in Agilex 5
as additional watchdog4 has been introduced. This is to enable
the debug mode when the CPU is paused by the user.

This patch has been tested on Agilex 5 devkit with QSPI boot (UBI/UBIFS)
and RAM boot (TFTP & ARM DS debugger).

Muhammad Hazim Izzat Zamri (1):
  arm: socfpga:agilex5: Fix system manager watchdog mode setting

 arch/arm/mach-socfpga/include/mach/system_manager_soc64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1

