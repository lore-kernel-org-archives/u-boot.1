Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B268CC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 458F187F65;
	Tue, 12 Mar 2024 15:30:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="cEA+msR0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6AD287F74; Tue, 12 Mar 2024 15:30:46 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53F8E87F4F
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710253843; x=1712845843;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XN0yif/PyY2MqrANE0wvY/5RZRA6RHLHSCq9a+SqqRQ=;
 b=cEA+msR0oiSR4jznP8gTMFGjtnlMZ8PxO9/PSUBQlHakfMN9I86Kkb/vNZd2qJQd
 ygToIdFbZhLnPgfxEwyMOQBY58ii8Lo2bX3sMVweWo28mnLM19tl1vNGlu5CzSqM
 7h5u/k7SoFHlcrWeNT9u5YSHNK5WkPrdNInT1qRwpCM=;
X-AuditID: ac14000a-fadff7000000290d-9a-65f067133e96
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 5A.0A.10509.31760F56;
 Tue, 12 Mar 2024 15:30:43 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Mar
 2024 15:30:42 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH v3 2/5] phycore_imx8mp: Move default bootcmd to board env
Date: Tue, 12 Mar 2024 15:30:30 +0100
Message-ID: <20240312143033.3336-3-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312143033.3336-1-l.anderweit@phytec.de>
References: <20240312143033.3336-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWyRpKBR1c4/UOqwft1/BYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgy9jbeYSto
 46lYumQNcwPjXK4uRk4OCQETiWfn7rJ3MXJxCAksZpKYu+kFK4TzmFFiya9+RpAqNgF9iZUv
 F7GA2CICLhK/lu4Bsjk4mAXMJCZ8TgYJCwt4Slxq7wArYRFQlfg+exsziM0rYCmx4eBmZohl
 8hIzL31nB7E5Bawktr3bBWYLAdXM7n3ECFEvKHFy5hOwOcxA9c1bZzND2BISB1+8YIaoV5K4
 c+oXG8zMaedeQ80PlTiyaTXTBEahWUhGzUIyahaSUQsYmVcxCuVmJmenFmVm6xVkVJakJuul
 pG5iBAW5CAPXDsa+OR6HGJk4GA8xSnAwK4nwvtZ5myrEm5JYWZValB9fVJqTWnyIUZqDRUmc
 d3VHcKqQQHpiSWp2ampBahFMlomDU6qB0WdKvvyyn9EVpl+qY+drxv/Z+rxTITTahT/rxsE3
 02fvndGw2W/j8dMHFju1BrBOs37y48ieFKHMqFsPdZO0n77ws1GYoHu7L+1nz0fFa7GT707U
 il8ybZ6Lu/K2aYFbYxpNHmv+1Nwu+mFjYVPp11NtU7s8b9/xEf8ne3EDzyemdbMexb7jvKzE
 UpyRaKjFXFScCACPMA9jYAIAAA==
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

Move the default bootcmd from the defconfig to the board environment.
No change in functionality.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
Tested-by: Teresa Remmet <t.remmet@phytec.de>
---
 board/phytec/phycore_imx8mp/phycore_imx8mp.env | 12 ++++++++++++
 configs/phycore-imx8mp_defconfig               |  2 --
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index 32513e70fec2..dc9ad0fe9d15 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -1,3 +1,15 @@
+bootcmd=
+	if test ${dofastboot} = 1; then
+		fastboot 0;
+	fi;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadimage; then
+			run mmcboot;
+		else
+			run netboot;
+		fi;
+	fi;
 console=ttymxc0,115200
 dofastboot=0
 emmc_dev=2
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index b3a7bbd79bb6..fd492eba3c10 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -25,8 +25,6 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="if test ${dofastboot} = 1; then fastboot 0; fi; mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run mmcboot; else run netboot; fi; fi;"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
-- 
2.25.1

