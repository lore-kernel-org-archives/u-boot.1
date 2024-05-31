Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBB1C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 13:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC4AB885F1;
	Fri, 31 May 2024 15:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o8LBXi2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBEB588783; Fri, 31 May 2024 15:11:55 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 436F588280
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 15:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VDBpe9104273;
 Fri, 31 May 2024 08:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717161111;
 bh=0kb6O1HAcUw3CxB2WUguJv39SCz/6IcoRfIgGxtS3es=;
 h=From:To:CC:Subject:Date;
 b=o8LBXi2tLMiJETDD/bD/+NTFCMYhK3DpctSuDSlrgw/3dRoS+uNE2ovAZZjwpLr1u
 Akfee8KlWxAUnHVLXCd7/wbdtxOfRIzUy4zJCbZB1D+wqVUVT6ijoMFgFhmNODOUyR
 jOkVWaK5HWY4M79oLYArzaewgsx77Rm3Mid6rcw8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VDBpQe094530
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 08:11:51 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 08:11:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 08:11:50 -0500
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VDBm6o063605;
 Fri, 31 May 2024 08:11:48 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH 0/6] Add ESM Support for J7200
Date: Fri, 31 May 2024 18:38:17 +0530
Message-ID: <20240531130823.646311-1-a-limaye@ti.com>
X-Mailer: git-send-email 2.34.1
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

This series adds the required nodes in the devicetree, and enables the
configs for the ESM and PMIC.

Test Logs AVS and ESM:
https://gist.github.com/aniket-l/96b85a25733095b4fd87f48f730518bf

---
Aniket Limaye (2):
  arm: dts: k3-j7200-r5: Add the pmic node in R5 dt
  arm: dts: k3-j7200-r5: Fix indentation to use tabs

Gowtham Tammana (2):
  arm: dts: k3-j7200-r5-common: Hook buckb1 to vtm supply
  arm: dts: k3-j7200: Add ESM PMIC support for tps659413

Neha Malcom Francis (2):
  configs: j7200_evm_r5: Add ESM config for J7200
  configs: j7200_evm_r5: Add ESM config for J7200

 .../arm/dts/k3-j7200-r5-common-proc-board.dts | 23 +++++++++++++++----
 configs/j7200_evm_r5_defconfig                |  2 ++
 2 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.34.1

