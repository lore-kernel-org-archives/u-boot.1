Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03FFC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 19:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DBC088788;
	Tue, 30 Apr 2024 21:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lsS7Vsi7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B703488781; Tue, 30 Apr 2024 21:58:00 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83064880D5
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 21:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43UJvsTB019831;
 Tue, 30 Apr 2024 14:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714507074;
 bh=jv/muK9TmdDm5Ipyi7Oo3WNfdj7LV7wxvdvb9SzfLoU=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=lsS7Vsi7+WYSvg2iqSeFIJ9F8rsJ4Yrtlvfd/pV4paCjr23eQNrGMY8sscO2l8Me8
 aqrP6ShnjhQLTEyI6pe/uR1gXXptwwx1LVzD2uYL7nrMeXF18mh4/SWCvPliF//4Qt
 Tbe/bHLaZnVlpM3loZau2NJrE2BTBmPBWxbpitVc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43UJvsNU057696
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Apr 2024 14:57:54 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 14:57:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 14:57:54 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43UJvsFQ075990;
 Tue, 30 Apr 2024 14:57:54 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 30 Apr 2024 14:57:46 -0500
Subject: [PATCH 2/2] configs: add defconfigs for the am625-lp-sk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240429-am62q-wip-v1-2-927fd2e0a53b@ti.com>
References: <20240429-am62q-wip-v1-0-927fd2e0a53b@ti.com>
In-Reply-To: <20240429-am62q-wip-v1-0-927fd2e0a53b@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nitin Yadav <n-yadav@ti.com>, Bryan Brattlof
 <bb@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=bb@ti.com;
 h=from:subject:message-id; bh=/0T1DoxcuHFVwznZzTxdoYMUXNqSmzkhLySL9lUNMio=;
 b=owNCWmg5MUFZJlNZgc1RfgAAZv///v7td3vn6vL+r5Z7dXT6evz/7z973erD6L1c9/Xs7GywA
 RmwIeo0aMygANANPSAAMg9Q000GgAaaaDRpoaA0ANANMmgaaADJo0aPUG0JmmJEDI00GQ0GmjTT
 JpkMhoYjNRiNMjTAgwIZNAADJp6gGjJkDQNGgDTQBk00wQZIaBkBk0yaNDQZDJiZGAQ0aGhkaA0
 BgEDRoaaYgZGTQDTQBpkaAaBieowKFrgyOTWSU1zBxs7sY6oqDVVAf6TL4U4LEgON21iA+AR2z5
 cap8TPwENXNgwuuPJhb9JbRqAbmlgIZ930Uvz+fwPkjVUas4XmE+EzGZhKhZSsBiAXYandfIngY
 TrTACNzCLsM9JJPr0FFq2jeu+JStyZCzRvamnPJqxgD05QN3UHWnu1zADrFDt810FE3J3+YOI74
 1jq96mYsilYTnjniw+JgRlf2HizswLVMeaY31m4+ke5q0L3GV3yeopKZwFIN58TEI14dIqtoWXI
 lUUqFeH3W1QwyRha24Kh0h5JJeBykNvmy7RqKtKgXCAync+97IM2zhaea6IdpT/S036zpvnXEnD
 X2Zep00K6ZMwehu7A/JdIA8Lo/FuhBWxBQ3D6bChupRWBJQBIg+mgq1IeYJbBvDARCU4MUOjekJ
 QCDRL58sE1/8XckU4UJCBzVF+A=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

The am62x-lp-sk is a package and reference board spin of the am62x-sk to
showcase the low-power features of the am62x SoC family. Because it so
closely resembles the am62x-sk board, us the preprocessor to inherit its
configuration making the needed changes for this board.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 configs/am62x_lp_sk_a53_defconfig | 3 +++
 configs/am62x_lp_sk_r5_defconfig  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/configs/am62x_lp_sk_a53_defconfig b/configs/am62x_lp_sk_a53_defconfig
new file mode 100644
index 0000000000000..904b2142b2f53
--- /dev/null
+++ b/configs/am62x_lp_sk_a53_defconfig
@@ -0,0 +1,3 @@
+#include <configs/am62x_evm_a53_defconfig>
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62-lp-sk"
+CONFIG_OF_UPSTREAM=y
diff --git a/configs/am62x_lp_sk_r5_defconfig b/configs/am62x_lp_sk_r5_defconfig
new file mode 100644
index 0000000000000..93b3922e6fec5
--- /dev/null
+++ b/configs/am62x_lp_sk_r5_defconfig
@@ -0,0 +1,2 @@
+#include <configs/am62x_evm_r5_defconfig>
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62-r5-lp-sk"

-- 
2.43.2

