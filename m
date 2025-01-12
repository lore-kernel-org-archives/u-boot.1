Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8036E77188
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 15:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 943BD801B6;
	Sun, 12 Jan 2025 16:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BkiPm4M3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 023C6801DB; Sun, 12 Jan 2025 16:44:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3755C800D2
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 16:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=muhammad.hazim.izzat.zamri@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736696676; x=1768232676;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gCpgbu7cx9WFvchmOPpX8b71mdewf4c7+V0yNlgB90A=;
 b=BkiPm4M3cjwYEeTW78btF9U0/Rr9vdXCzlFdISPRpVnlZIzh6Qhr2MXC
 TP7xR3ph3937cOKCYRiSxpI4WuL7U3a88jKaUf+wGdDzC631RHZrbq7iM
 TOTdN1kjivl6dl52AjPUpg6c9Dbq/qrBLIi8QxdWfSfehZU6jzxHDbtsf
 Esg0pKD+qbJD2Elz+iHoYgaSuZoM/bDut5o588BtXqxlEN20iwlvLybWF
 CaGzXGMespj9gZV3wh4ZF9/qkNVtCqwfljmz4A7dD511i9SF1iSOgDcvE
 3zn7cqibJi+1GiqJZYudJXE1hZtjSjP5j5WNq32jCEx4ocOZB80wKxmx2 g==;
X-CSE-ConnectionGUID: d129hxoKQ6e6cshfemBJyg==
X-CSE-MsgGUID: vBaj+nL9QEyJxkpOmu7A4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40868171"
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; d="scan'208";a="40868171"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2025 07:44:34 -0800
X-CSE-ConnectionGUID: HBnFLvDKQuCizOpKgCdcSA==
X-CSE-MsgGUID: 9DWnOZ4aTK+9gKKpRSfdWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; d="scan'208";a="109198953"
Received: from apgcp0d540107.png.altera.com ([10.244.77.29])
 by orviesa004.jf.intel.com with ESMTP; 12 Jan 2025 07:44:32 -0800
From: muhammad.hazim.izzat.zamri@intel.com
To: Tien Fong <tien.fong.chee@intel.com>
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tingting Meng <tingting.meng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>, u-boot@lists.denx.de
Subject: [PATCH v2 0/1] SoCFPGA: Add watchdog mode setting for Agilex 5
Date: Sun, 12 Jan 2025 23:44:05 +0800
Message-Id: <20250112154406.1556-1-muhammad.hazim.izzat.zamri@intel.com>
X-Mailer: git-send-email 2.26.2
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
2.26.2

