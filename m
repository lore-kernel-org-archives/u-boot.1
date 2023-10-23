Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D348C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 08:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29085878AC;
	Mon, 23 Oct 2023 10:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jt4WUZpS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8004C87898; Mon, 23 Oct 2023 10:01:17 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F3A68789F
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 10:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39N816rK016296;
 Mon, 23 Oct 2023 03:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698048066;
 bh=a3fsbIthD6YzJZHsT77gu3xbZKRS1N2KNuGBgm/y11w=;
 h=From:To:CC:Subject:Date;
 b=jt4WUZpSHpdTiwheVOzg4k/g5jr+P59wILhkz9FAxD/qDPf5ioZtkRjxZe2pfqTvw
 hyKfcKZc8y0pgpXFCvVVwdAPpPdCbJ6uL5oM67902ihAgK07iAYAP7nDfVJXzdrS0j
 FJbOK+/oGhHpc4zFmFGB+KmaRkEKwtu4HlQhVMUM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39N816xN040827
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 23 Oct 2023 03:01:06 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Oct 2023 03:01:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Oct 2023 03:01:06 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39N813XP007311;
 Mon, 23 Oct 2023 03:01:04 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <a-nandan@ti.com>
Subject: [PATCH v4 0/2] Enable split mode in binman
Date: Mon, 23 Oct 2023 13:31:01 +0530
Message-ID: <20231023080103.3780998-1-n-francis@ti.com>
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

This series extends the functionality of ti-secure-rom entry type in
binman to support enabling of split mode vs. the default lockstep mode
via changing the field in the x509 certificate. A DONOTMERGE patch is
added to give an example of how this can be done via the binman.dtsi

Changes in v4:
	- Simon:
		- correct function comments for setting bit for split
		  and lockstep mode
Changes in v3:
	- Simon:
		- added entries.rst change
		- updated function comments
		- removed inconsistency in setting bootcore_opts to 32

Changes in v2:
	- Udit:
		- included TRM link in commit message
		- added DONOTMERGE patch showing example

Neha Malcom Francis (2):
  binman: openssl: x509: ti_secure_rom: Add support for bootcore_opts
  DONOTMERGE: arm: dts: k3-j7200-binman: Enable split mode for MCU R5

 arch/arm/dts/k3-j7200-binman.dtsi       |  3 +++
 tools/binman/btool/openssl.py           |  6 ++++--
 tools/binman/entries.rst                |  1 +
 tools/binman/etype/ti_secure_rom.py     | 11 +++++++++--
 tools/binman/etype/x509_cert.py         |  3 ++-
 tools/binman/test/297_ti_secure_rom.dts |  1 +
 6 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.34.1

