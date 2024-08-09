Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4534BC531DB
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 23:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2057B88C5D;
	Sat, 10 Aug 2024 01:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aIJi14yL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA49288C29; Sat, 10 Aug 2024 01:02:07 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE74688C44
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 01:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 479N20AX110851;
 Fri, 9 Aug 2024 18:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723244520;
 bh=mqjhtlqSodRrIVQX1AYNe8iM5iIG7WS/SdBwWZJfu6o=;
 h=From:To:CC:Subject:Date;
 b=aIJi14yL0v1JHF06yqDa1pJEC0GME8jmWhIc3OIBv94pDeG32MNOCWY9bZ1XE/55h
 wzFcx851HbuiPzEq+wFahY/3sCzmu14myEZtEyY4xorZtkmRx98Czn08iif4IYpX+4
 RVE/QZkB19FGW2Z9hu1D3y6SWlkKD2ADetv6R4Cw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 479N20KW107788
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 9 Aug 2024 18:02:00 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Aug 2024 18:02:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Aug 2024 18:02:00 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 479N20Cf063761;
 Fri, 9 Aug 2024 18:02:00 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Nishanth Menon <nm@ti.com>, Reid Tonking <reidt@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Hari Nagalla <hnagalla@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>, <afd@ti.com>, <eballetb@redhat.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v3 0/5] arch: arm: dts: ti: Add missing fss range
Date: Fri, 9 Aug 2024 18:01:52 -0500
Message-ID: <20240809230157.3935118-1-j-humphreys@ti.com>
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

Upstream DTS added explicit ranges to the fss node. It did not include
the 32 bit memory space needed by the R5 to access OSPI. With the
upstream DTS sync, OSPI boot no longer works.

Adding the missing range here. It is also being added in the upstream DTS,
so after the next upstream DTS sync, these patches can be removed.

Fixes: 5024a96db8e ("Subtree merge tag 'v6.10-dts' of devicetree-rebasing repo [1] into dts/upstream")

Changes from v1:
- Fixup tab whitespace alignment
Link to v1: https://lore.kernel.org/r/20240808212926.3790223-1-j-humphreys@ti.com

Changes from v2:
- Correct fixes tag format
- Uppercase FSS in comment
Link to v2: https://lore.kernel.org/r/20240809211717.3887859-1-j-humphreys@ti.com

Jonathan Humphreys (5):
  arch: arm: dts: k3-j784s4-r5-evm: Add missing fss range
  arch: arm: dts: k3-am69-r5-sk: Add missing fss range
  arch: arm: dts: k3-j7200-r5-evm: Add missing fss range
  arch: arm: dts: k3-j721e-r5-evm: Add missing fss range
  arch: arm: dts: k3-j721e-r5-sk: Add missing fss range

 arch/arm/dts/k3-am69-r5-sk.dts                 | 6 ++++++
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 6 ++++++
 arch/arm/dts/k3-j721e-r5-common-proc-board.dts | 6 ++++++
 arch/arm/dts/k3-j721e-r5-sk.dts                | 6 ++++++
 arch/arm/dts/k3-j784s4-r5-evm.dts              | 6 ++++++
 5 files changed, 30 insertions(+)

-- 
2.34.1

