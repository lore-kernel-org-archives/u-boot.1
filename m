Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5994AC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 09:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51CF88835C;
	Tue, 16 Apr 2024 11:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FuDIfxEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D268832B; Tue, 16 Apr 2024 11:20:50 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11C0588337
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 11:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43G9KYtt063846;
 Tue, 16 Apr 2024 04:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713259234;
 bh=JiKZu01u3UCd21xy2N+92ZZesbvpAaUoy/lvvImzQJE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FuDIfxEeLOTvrQCKoQMFyiJNz8yocmpzmq2fVWJsYN7ULRnjw4hBNJJlu/Zt2SELp
 hgl5l3wN1iLbtAQ1YrCL2TVh3hdSFeZhgl2vGLA+yvpH1oabHTVZm+eKVfcyrgkNn0
 M7vKlKtA0p/K31pubWqbZt9uJ77HuZh1jAUkWX0M=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43G9KYeD104089
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 16 Apr 2024 04:20:34 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Apr 2024 04:20:33 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Apr 2024 04:20:33 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43G9KXAU100801;
 Tue, 16 Apr 2024 04:20:33 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 43G9KX5t011010;
 Tue, 16 Apr 2024 04:20:33 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Bryan Brattlof <bb@ti.com>, Sean Anderson <seanga2@gmail.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Nishanth Menon <nm@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass
 <sjg@chromium.org>, MD Danish Anwar <danishanwar@ti.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Tim Harvey <tharvey@gateworks.com>, Tony Dinh
 <mibodhi@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>, Sumit Garg <sumit.garg@linaro.org>, Michal Simek
 <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kever
 Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>, Roger
 Quadros <rogerq@kernel.org>
Subject: [PATCH v4 6/6] board: ti: am65x: Set fw_storage_interface and
 fw_dev_part ENVs
Date: Tue, 16 Apr 2024 14:50:18 +0530
Message-ID: <20240416092018.3593039-7-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416092018.3593039-1-danishanwar@ti.com>
References: <20240416092018.3593039-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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
storage_interface and fw_dev_part env variables.

These variables need be set appropriately in order to load differnet
ICSSG firmwares needed for ICSSG driver. By default the storage
interface is mmc and the partition is 1:2. User can modify this based on
their needs.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 board/ti/am65x/am65x.env | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/ti/am65x/am65x.env b/board/ti/am65x/am65x.env
index 814374d68c..631997e4c9 100644
--- a/board/ti/am65x/am65x.env
+++ b/board/ti/am65x/am65x.env
@@ -27,3 +27,7 @@ get_fdt_ubi=ubifsload ${fdtaddr} ${bootdir}/${name_fdt}
 args_ubi=setenv bootargs console=${console} ${optargs}
 rootfstype=ubifs root=ubi0:rootfs rw ubi.mtd=ospi.rootfs
 
+#if CONFIG_TI_ICSSG_PRUETH
+storage_interface=mmc
+fw_dev_part=1:2
+#endif
-- 
2.34.1

