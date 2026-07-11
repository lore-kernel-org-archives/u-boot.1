Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12515C43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 16:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6364F849BA;
	Sat, 11 Jul 2026 18:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="C35RxJvk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A1E849BA; Sat, 11 Jul 2026 18:08:27 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 419A38497A
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 18:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=28ca=FG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1783786101;
 bh=C4gZ33Xg19T6ZvFqLIjQkYYIJAoOUuAzM4a3fCTQoSc=;
 b=C35RxJvkIWKgy3Y/YIJE4b/G1RYyPGgQ1MQUrQePmSVGqcoY+vAe6jdHUPUwhfEQHeLR8LVvD
 PzZGvag7g6IAozGdkZ2QWX4huR0/3xFPPENIG/3prD3gUWepsUolj2Eg2UbZc0JvuyaL4uh13Z1
 JRJdCrrNlGJqeEiuizj6dBBeL+6Vc4rpLb6KxMDayH1FLR8zmMMMfL/nzRuwUa+3cb2aIJVUuo/
 rZRzHiu4AqsUgWtDtqITd9ondXdNu9uONkOjPs3yWAw0CHxb7yv5ApunxYnNpx+d5bO6bum6mDG
 pBhN+yMWbrHFTnyg9sXh3JVzdNsHVBYCROs27rdUrvOw==
X-Forward-Email-ID: 6a526a721b09fea89cb1247a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Marek Vasut <marex@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/8] usb: eth: Add CDC ECM/NCM support
Date: Sat, 11 Jul 2026 16:07:58 +0000
Message-ID: <20260711160808.2022242-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
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

This series adds support for CDC ECM and CDC NCM devices.

U-Boot currently only has support for automatic binding of the first
device configuration for devices, so this implementaion works by adding
bindings for VID/PID pairs and letting the drivers try to change active
configuration during probe.

The driver implementations was created based of the CDC ECM 1.2 and
CDC NCM 1.1 specifications and was tested on a few different USB
Ethernet adapters using ASIX or Realtek IC.

Patch 1-3 import headers and macros from Linux kernel.
Patch 4 export a helper that drivers can use to select a different
device configuration.
Patch 5-6 adds drivers for CDC ECM and CDC NCM.
Patch 7-8 allows ASIX and Realtek adapters to use CDC ECM and CDC NCM.

Jonas Karlman (8):
  usb: Import USB_DEVICE_VER() macro from Linux
  usb: Import USB_INTERFACE_INFO() macro from Linux
  usb: Sync linux/usb/cdc.h from Linux
  usb: Extract usb_select_configuration_no() helper
  usb: eth: Add CDC ECM support
  usb: eth: Add CDC NCM driver
  usb: eth: Bind ASIX AX88179A/AX88772D/AX88279 to CDC ECM/NCM driver
  usb: eth: Bind Realtek RTL815x to CDC ECM driver

 common/usb.c                 |  59 +++--
 doc/README.usb               |   2 +
 drivers/usb/eth/Kconfig      |  18 ++
 drivers/usb/eth/Makefile     |   2 +
 drivers/usb/eth/asix88179.c  |   5 +
 drivers/usb/eth/cdc_common.c | 265 +++++++++++++++++++
 drivers/usb/eth/cdc_common.h |  35 +++
 drivers/usb/eth/cdc_ecm.c    | 292 +++++++++++++++++++++
 drivers/usb/eth/cdc_ncm.c    | 483 +++++++++++++++++++++++++++++++++++
 include/linux/usb/cdc.h      | 233 ++++++++++++++++-
 include/usb.h                |  48 ++++
 11 files changed, 1417 insertions(+), 25 deletions(-)
 create mode 100644 drivers/usb/eth/cdc_common.c
 create mode 100644 drivers/usb/eth/cdc_common.h
 create mode 100644 drivers/usb/eth/cdc_ecm.c
 create mode 100644 drivers/usb/eth/cdc_ncm.c

-- 
2.54.0

