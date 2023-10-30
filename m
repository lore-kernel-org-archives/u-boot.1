Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9DDC4167D
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 11:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AB2787A6B;
	Mon, 30 Oct 2023 12:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wdHsN1Nb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C49187A4C; Mon, 30 Oct 2023 12:01:51 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A07D287A56
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 12:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39UB1ltk050077;
 Mon, 30 Oct 2023 06:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698663707;
 bh=uDTvqnIkhzesrhRvwVFXvzFzigJ+P21K6/s79I6SPPs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=wdHsN1NbZR8gigbnCsZRIKBd0rZtVx8wvbmdbmdSsrepG7fIFoG4sNJC5Qn5oKt/q
 JlCfJNTTKiq6L+oyp+hDMFm2Ak4hR2AvmHH72iZPWq4gz1QouRjJ7R7Xa/NEro0XyU
 ew17/H4HI7Tm3BjNUlIyRSqNHwqLLI1e/4DXE6Ps=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39UB1kFI032186
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 30 Oct 2023 06:01:46 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Oct 2023 06:01:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Oct 2023 06:01:45 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39UB1i40029555;
 Mon, 30 Oct 2023 06:01:45 -0500
From: Nitin Yadav <n-yadav@ti.com>
To: <nm@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 4/4] doc: ti: Add AM62x LP SK Board information
Date: Mon, 30 Oct 2023 16:31:38 +0530
Message-ID: <20231030110138.1347603-5-n-yadav@ti.com>
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

Add link for AM62x LP SK in platform information. AM62x LP SK
has config fragments to build U-boot, Adding information to
update UBOOT_CFG_CORTEXR with lpsk fragments over am62x defconfig.

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
---
 doc/board/ti/am62x_sk.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index d7437c6d22..9d7ce1fd54 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -41,6 +41,7 @@ https://www.ti.com/lit/pdf/spruiv7
 Platform information:
 
 * https://www.ti.com/tool/SK-AM62B
+* https://www.ti.com/tool/SK-AM62-LP
 
 Boot Flow:
 ----------
@@ -86,6 +87,13 @@ Set the variables corresponding to this platform:
  $ export OPTEE_PLATFORM=k3-am62x
  $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
 
+For SK-AM62x-LP, set the UBOOT_CFG_CORTEXR variable as shown below:
+
+.. code-block:: bash
+
+ $ export UBOOT_CFG_CORTEXR=am62x_evm_r5_defconfig am62x_lpsk_r5.config
+ $ export UBOOT_CFG_CORTEXA=am62x_evm_a53_defconfig am62x_lpsk_a53.config
+
 .. am62x_evm_rst_include_start_build_steps
 
 1. Trusted Firmware-A:
-- 
2.25.1

