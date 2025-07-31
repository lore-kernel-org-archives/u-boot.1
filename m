Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C032C87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 08:20:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A51D28357D;
	Thu, 31 Jul 2025 10:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="edjh1/q5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82AC7833ED; Thu, 31 Jul 2025 10:02:00 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C38E833EC
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 10:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V81iOd2983946;
 Thu, 31 Jul 2025 03:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753948904;
 bh=npJvdKQXfhbUba7+IXschqgH0Q+vshcd3MjfsczECzM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=edjh1/q596Xl6W84l0uxIXvlTPmpW+LqnIuD7GFmoiK3Y0Uo15EjK4ws5qH0gsZ4L
 PnSe986o+s2Qw0yGxARPGVGFaQf3mTfjjhtUsnmrjMF4CTaXeugWiYHqfcrJTvpg7N
 tZyLCpPHyFI+mNH9qVMRoew2dnmYgsBVm2mplC3A=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V81ie93806362
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 31 Jul 2025 03:01:44 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 03:01:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 03:01:43 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V808xl2569544;
 Thu, 31 Jul 2025 03:00:09 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Richard Genoud <richard.genoud@bootlin.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Santhosh Kumar K <s-k6@ti.com>, "Jonathan
 Humphreys" <j-humphreys@ti.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bhavya Kapoor <b-kapoor@ti.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Moteen Shah <m-shah@ti.com>,
 "Beleswar Padhi" <b-padhi@ti.com>, Anshul Dalal <anshuld@ti.com>, Sughosh
 Ganu <sughosh.ganu@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 "Prasanth Babu Mantena" <p-mantena@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, "Simon Glass" <sjg@chromium.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Chintan Vankar <c-vankar@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v4 02/21] arch: mach-k3: common: Remove explicit probing of
 CPSW driver
Date: Thu, 31 Jul 2025 13:29:37 +0530
Message-ID: <20250731075956.605474-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250731075956.605474-1-c-vankar@ti.com>
References: <20250731075956.605474-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Thu, 31 Jul 2025 10:19:27 +0200
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

This reverts commit e58d9284850fa78d364d264087fe744717963675.

Bind method of am65_cpsw_nuss driver will ensure binding of it's child
driver am65_cpsw_nuss_ports, and there is no need to call CPSW driver
explicitly. Remove explicit probing of CPSW driver for AM62x.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is newly introduced in this series.

 arch/arm/mach-k3/common.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index f8c53b286eb..5483ac9906c 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -322,17 +322,6 @@ void spl_board_prepare_for_linux(void)
 
 int misc_init_r(void)
 {
-	if (IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS)) {
-		struct udevice *dev;
-		int ret;
-
-		ret = uclass_get_device_by_driver(UCLASS_MISC,
-						  DM_DRIVER_GET(am65_cpsw_nuss),
-						  &dev);
-		if (ret)
-			printf("Failed to probe am65_cpsw_nuss driver\n");
-	}
-
 	if (IS_ENABLED(CONFIG_TI_ICSSG_PRUETH)) {
 		struct udevice *dev;
 		int ret;
-- 
2.34.1

