Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382D9C27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 08:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D11087FA1;
	Fri,  7 Jun 2024 10:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K5vyEMsX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4FF98827B; Fri,  7 Jun 2024 10:58:21 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13E368780E
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 10:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4578wG8a050690;
 Fri, 7 Jun 2024 03:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717750696;
 bh=zmIxqmhrCcj0rtJQYJoX67uLYf2JTINl4SC0BNAlmj0=;
 h=From:To:CC:Subject:Date;
 b=K5vyEMsXpT0A397QETl7KtAchavnMKsl4TwJLywytjDw81NjxfX6f6LRrfRYbq+AQ
 8BLH4TIVU2MoT70ovFG6HPHUU9Q0u6gg1VH4oTAiADfXc7ncuSniWPlLqXo8+V8xpY
 HMZMeHaqeq+uZkPKOMTV18DdMLWd9qluM/T2DJSs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4578wGHX055603
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Jun 2024 03:58:16 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 03:58:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 03:58:16 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4578wDDI073875;
 Fri, 7 Jun 2024 03:58:14 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Vibhore Vardhan <vibhore@ti.com>, Neha Malcom
 Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Dhruva Gole
 <d-gole@ti.com>
Subject: [PATCH 0/2] binman: am62a/62p: add support for signing TIFSStub
Date: Fri, 7 Jun 2024 14:26:39 +0530
Message-ID: <20240607085640.2900395-1-d-gole@ti.com>
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

Add support for signing of TIFSSTUB images for HSSE, HSFS and GP devices
and include them in tispl.bin and tispl.bin_unsigned in AM62A.

AM62P doesn't have any GP support, hence not applicable.

These changes are required for Low Power Mode features to work on these
SoCs as this TIFS Stub gets used in the Low Power Exit sequences.

Boot tested on both platforms that are being touched:

[0] AM62A, [1] AM62P

[0] https://gist.github.com/DhruvaG2000/d5f2a46818d8025a540efe9289feacb4
[1] https://gist.github.com/DhruvaG2000/ce29f6e9315a78d3e9e5810f55f17f43

Dhruva Gole (2):
  arm: dts: k3: binman: am62a: add support for signing TIFSStub Images
  arm: dts: k3: binman: am62p: add support for signing TIFSStub images

 arch/arm/dts/k3-am62a-sk-binman.dtsi | 138 ++++++++++++++++++++++++++-
 arch/arm/dts/k3-am62p-sk-binman.dtsi |  65 ++++++++++++-
 2 files changed, 200 insertions(+), 3 deletions(-)


base-commit: 1ebd659cf020843fd8e8ef90d85a66941cbab6ec
-- 
2.34.1

