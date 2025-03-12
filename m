Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5A1C28B2F
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 16:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 106EC800B6;
	Wed, 12 Mar 2025 17:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DEBE8056A; Wed, 12 Mar 2025 16:37:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B81B5800B6
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 16:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=muhammad.hazim.izzat.zamri@altera.com
X-CSE-ConnectionGUID: WmUtu4r7T2Cdq2km8ZQi+w==
X-CSE-MsgGUID: rUjfavbNQY6SXlwO7XvvZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42046485"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="42046485"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 08:37:26 -0700
X-CSE-ConnectionGUID: 0iVanF5uRzy0+HsN4JVAvQ==
X-CSE-MsgGUID: lDR5E3uATKOrdSfCmxOUZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="157844442"
Received: from apgcp0d540107.png.altera.com ([10.244.77.29])
 by orviesa001.jf.intel.com with ESMTP; 12 Mar 2025 08:37:23 -0700
From: muhammad.hazim.izzat.zamri@altera.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Tingting Meng <tingting.meng@altera.com>
Subject: [PATCH v1 0/2] Add FPGA configuration when booting Linux
Date: Wed, 12 Mar 2025 23:37:15 +0800
Message-Id: <20250312153717.28514-1-muhammad.hazim.izzat.zamri@altera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Mar 2025 17:01:06 +0100
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

From: Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>

This patchset enable the capability to automatically perform
FPGA configuration when booting Linux FIT image via bootm command.
The FPGA configuration bitstream shall be packed within the
FIT image.

Second patch is to add additional flag to check whether an FPGA
driver is able to load a particular FPGA bitstream image.

Both patch have been tested and able to boot U-boot using
debugger and QSPI boot.

Muhammad Hazim Izzat Zamri (2):
  drivers: fpga: Add FPGA configuration during bootm for Intel SOCFPGA
  drivers: fpga: Follow mainline to pass compatible flags to fpga_load

 drivers/fpga/altera.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

--
2.25.1

