Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685AAC4167B
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 11:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1C5086ECF;
	Mon, 30 Oct 2023 12:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hhMmJb5/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F1CC87A69; Mon, 30 Oct 2023 12:01:49 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD35887A40
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 12:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39UB1iA5009461;
 Mon, 30 Oct 2023 06:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698663704;
 bh=yVNoi3A0AoCWF9VtcT0XHtajBddpb+v/Yd+3ctUf+bM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=hhMmJb5/rPj0hlgnnTp4iE2GLDS5oCfrrHz8hklsjXMr7hwJDSTpM/ZzkwuKmj6tu
 AtDdGHArh1hqDEPt1JkS9uNjzRRDcJmMsLvRVt5/qxcs/tedVqd9RrF/zjGJoEjDGC
 swCRi7d8+GV4vV9Ql33JXx+pxoj/udzOT6urOeUw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39UB1i7b067292
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 30 Oct 2023 06:01:44 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Oct 2023 06:01:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Oct 2023 06:01:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39UB1h5j004757;
 Mon, 30 Oct 2023 06:01:43 -0500
From: Nitin Yadav <n-yadav@ti.com>
To: <nm@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 3/4] board: ti: am62x: add am62x_lpsk_*_defconfigs fragments
Date: Mon, 30 Oct 2023 16:31:37 +0530
Message-ID: <20231030110138.1347603-4-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231030110138.1347603-1-n-yadav@ti.com>
References: <20231030110138.1347603-1-n-yadav@ti.com>
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

Add defconfig fragments for AM62x LP SK for for AM62x LP SK.

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
---
 board/ti/am62x/am62x_lpsk_a53.config | 5 +++++
 board/ti/am62x/am62x_lpsk_r5.config  | 5 +++++
 2 files changed, 10 insertions(+)
 create mode 100644 board/ti/am62x/am62x_lpsk_a53.config
 create mode 100644 board/ti/am62x/am62x_lpsk_r5.config

diff --git a/board/ti/am62x/am62x_lpsk_a53.config b/board/ti/am62x/am62x_lpsk_a53.config
new file mode 100644
index 0000000000..a568324997
--- /dev/null
+++ b/board/ti/am62x/am62x_lpsk_a53.config
@@ -0,0 +1,5 @@
+# Defconfig fragment to apply on top of am62x_evm_a53_defconfig
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62-lp-sk"
+CONFIG_SPL_OF_LIST="k3-am62-lp-sk"
+CONFIG_OF_LIST="k3-am62-lp-sk"
diff --git a/board/ti/am62x/am62x_lpsk_r5.config b/board/ti/am62x/am62x_lpsk_r5.config
new file mode 100644
index 0000000000..1532f4e336
--- /dev/null
+++ b/board/ti/am62x/am62x_lpsk_r5.config
@@ -0,0 +1,5 @@
+# Defconfig fragment to apply on top of am62x_evm_r5_defconfig
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62-r5-lp-sk"
+CONFIG_SPL_OF_LIST="k3-am62-r5-lp-sk"
+CONFIG_OF_LIST="k3-am62-r5-lp-sk"
-- 
2.25.1

