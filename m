Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7B4C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 12:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133EA88478;
	Wed, 17 Apr 2024 14:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PndLEvBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A42BE88451; Wed, 17 Apr 2024 09:47:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BA4D88447
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 09:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=boonkhai@ecsmtp.png.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713340026; x=1744876026;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gzvmAYN9Cd+xsKe5OM5aSQhRmXYC/FekfwB8cD3veUA=;
 b=PndLEvBVo3ir28j4NXRNTXYVEv8v/ftyOtqDm+rCA5ywKfMFzFtVy3IC
 GxsrNPWhsqrkworfOpYKYXEjxj87dLj8uWc5HAGdUhSLR8QgYPYjEri5m
 vlYeuRwmQgl0P6YHUGGxwJKGG6Dt91EmcrIg78PBDAPx53+HsoQQ2KM5Z
 EZema/O//BcIrIHLNYWhJNCBwjl9pRcXlZkvmD6naUUe5wS9TB7lCH6eE
 OtOV+JS9D44r+k3dj8MY4RwszTZc1Grh1Aa1+Wbu2Kr1qYmmMSzrt2MTJ
 3cUunqctOKU7I0rk6gX6RcA1NWSTPkdKNybMC0RoGoJ8akd8qb7ANa66k g==;
X-CSE-ConnectionGUID: Q9ehgzmwRl2hFMb5vF4mTw==
X-CSE-MsgGUID: OVAuKbFJT1qoYOkCMkdGSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="34203691"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; d="scan'208";a="34203691"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2024 00:47:04 -0700
X-CSE-ConnectionGUID: X11uLd+AQMCdl01Lbw93jA==
X-CSE-MsgGUID: 1W9M9SdEQlC5OzXwHj4WgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; d="scan'208";a="22946627"
Received: from pglmail07.png.intel.com ([10.126.73.9])
 by orviesa006.jf.intel.com with ESMTP; 17 Apr 2024 00:47:02 -0700
Received: from localhost (pglc00475.png.intel.com [10.221.239.158])
 by pglmail07.png.intel.com (Postfix) with ESMTP id 020E1167EF;
 Wed, 17 Apr 2024 15:47:01 +0800 (+08)
Received: by localhost (Postfix, from userid 11742525)
 id F2FCA35A07; Wed, 17 Apr 2024 15:47:00 +0800 (+08)
From: Boon Khai Ng <boon.khai.ng@intel.com>
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Tien Fong <tien.fong.chee@intel.com>,
 Kok Kiang <kok.kiang.hea@intel.com>, Boon Khai Ng <boon.khai.ng@intel.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/1] add driver for Synopsys Ethernet 10G device
Date: Wed, 17 Apr 2024 15:46:55 +0800
Message-Id: <20240417074656.5417-1-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 17 Apr 2024 14:36:56 +0200
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

This driver support the Synopsys Designware Ethernet 10G
IP block refer from the driver dwc_eth_qos.
    
The driver MAC register mapping is different between
Synopsys QoS IP and Synopsys 10G IP, and thus new file
is created meant for Sysnopsys 10G IP.
    
The dwc_eth_xgmac_socfpga.c is specific to a device family,
the driver support the specific configuration used in
Intel SoC FPGA Agilex5.
    
This driver is extensible for other device family to use.

Boon Khai Ng (1):
  net: Add drivers for Sysnopsys Ethernet 10G device

 drivers/net/Kconfig                 |   18 +
 drivers/net/Makefile                |    2 +
 drivers/net/dwc_eth_xgmac.c         | 1165 +++++++++++++++++++++++++++
 drivers/net/dwc_eth_xgmac.h         |  298 +++++++
 drivers/net/dwc_eth_xgmac_socfpga.c |  226 ++++++
 5 files changed, 1709 insertions(+)
 create mode 100644 drivers/net/dwc_eth_xgmac.c
 create mode 100644 drivers/net/dwc_eth_xgmac.h
 create mode 100644 drivers/net/dwc_eth_xgmac_socfpga.c

-- 
2.25.1

