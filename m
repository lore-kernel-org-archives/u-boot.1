Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9EAC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 21:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5745088A73;
	Mon, 22 Apr 2024 23:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wC0UaocA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 594A188A7D; Mon, 22 Apr 2024 23:41:03 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3440B88A74
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 23:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43MLerBq123120;
 Mon, 22 Apr 2024 16:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713822053;
 bh=PP4oeQ+Gv6alGsAEDLnYsCmNEyCETLFMD48/j1i2vek=;
 h=From:To:CC:Subject:Date;
 b=wC0UaocAJKpimhrg/kfu0C7d5osLVTKG67JmFxLagcV0gxmd3+tBqUkjAWUYbezIR
 RTDGUX4Dg3GApBwfcanL4MyM1oHgNK27hR/Gt3ln/yuMf5U0lzBnHZxUpI5FvzXf20
 tgO2oXioUETotoEKA1p4YJYNyECya3h2MUdvAzPc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43MLerEv030843
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 22 Apr 2024 16:40:53 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Apr 2024 16:40:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Apr 2024 16:40:52 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43MLenlB051404;
 Mon, 22 Apr 2024 16:40:49 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <bsheraw@ti.com>, <s-anna@ti.com>, <a-limaye@ti.com>
Subject: [PATCH 0/2] Generate all SR boot binaries
Date: Tue, 23 Apr 2024 03:10:46 +0530
Message-ID: <20240422214048.1292713-1-n-francis@ti.com>
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

Add support for missing HS SRs in the build for J721E and J7200.

Boot logs:
https://gist.github.com/nehamalcom/e652752623537aced8cf31308015d7c9

Neha Malcom Francis (2):
  arm: dts: k3-j721e-binman: Add support for HSSE2.0 and HSFS1.1
  arm: dts: k3-j7200-binman: Add support for HSSE1.0 and HSFS1.0

 arch/arm/dts/k3-j7200-binman.dtsi |  95 +++++++++++++-
 arch/arm/dts/k3-j721e-binman.dtsi | 201 +++++++++++++++++++++++++++++-
 2 files changed, 294 insertions(+), 2 deletions(-)

-- 
2.34.1

