Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEEFC47258
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F2687B4D;
	Thu, 11 Jan 2024 14:08:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k043thoY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D2DF8792C; Thu, 11 Jan 2024 08:07:14 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8189876EA
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 08:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40B76uDN127291;
 Thu, 11 Jan 2024 01:06:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704956817;
 bh=xolAsSVEw4wDwHrX6y8AXxWTvqain4wJl3wkGTPVRK4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=k043thoYQ20hBjYYpwo2AAjS79DMUjtUcbPTPzNcOXWy6hVQkZZ2DEsHCgWJ71tK6
 o164qeqb7lb3sUYcDNFlVNbi3BSmCFjPMp8/GnGCQMXMuB7lxMI+m4RSeRC6vCmh7U
 Fh3k0fcdIYHfXgW788DG5BvUWlNOqvd4OXtgC53k=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40B76uc6039399
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 11 Jan 2024 01:06:56 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Jan 2024 01:06:56 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Jan 2024 01:06:56 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40B76ut5086576;
 Thu, 11 Jan 2024 01:06:56 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 40B76sFA017729;
 Thu, 11 Jan 2024 01:06:55 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Maxime Ripard <mripard@kernel.org>, Roger Quadros
 <rogerq@kernel.org>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>, Sean Anderson
 <seanga2@gmail.com>, Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Nikhil M Jain
 <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis
 <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Simon Glass
 <sjg@chromium.org>, MD Danish Anwar <danishanwar@ti.com>, FUKAUMI Naoki
 <naoki@radxa.com>, Christian Hewitt <christianshewitt@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Kever Yang <kever.yang@rock-chips.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH v2 15/15] board: ti: am65x: Set fw_storage_interface and
 fw_dev_part ENVs
Date: Thu, 11 Jan 2024 12:36:11 +0530
Message-ID: <20240111070611.342701-16-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111070611.342701-1-danishanwar@ti.com>
References: <20240111070611.342701-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 11 Jan 2024 14:08:34 +0100
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

When ICSSG driver is enabled (CONFIG_TI_ICSSG_PRUETH=y) set
fw_storage_interface and fw_dev_part env variables.

These variables need be set appropriately in order to load differnet
ICSSG firmwares needed for ICSSG driver. By default the storage
interface is mmc and the partition is 1:2. User can modify this based on
their needs.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 board/ti/am65x/am65x.env | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/ti/am65x/am65x.env b/board/ti/am65x/am65x.env
index 286b9c300c..5d6b98b87c 100644
--- a/board/ti/am65x/am65x.env
+++ b/board/ti/am65x/am65x.env
@@ -30,3 +30,7 @@ get_fdt_ubi=ubifsload ${fdtaddr} ${bootdir}/${name_fdt}
 args_ubi=setenv bootargs console=${console} ${optargs}
 rootfstype=ubifs root=ubi0:rootfs rw ubi.mtd=ospi.rootfs
 
+#if CONFIG_TI_ICSSG_PRUETH
+fw_storage_interface=mmc
+fw_dev_part=1:2
+#endif
-- 
2.34.1

