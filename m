Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2404AE92FDE
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 10:07:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7399286E2C;
	Fri,  6 Oct 2023 12:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YKpBdPbk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9803986E2C; Fri,  6 Oct 2023 12:07:47 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B75D86D19
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 12:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 396A7fXX051595;
 Fri, 6 Oct 2023 05:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696586861;
 bh=J7Cz8CAX0tdyZ+GBn+Nniser18mI+rBZZ8ZfPH1JrQc=;
 h=From:To:CC:Subject:Date;
 b=YKpBdPbk7YVDWAq1T5J1+uvcS0kmtR9OhSHPl3DSfzVYfAm9gRnT8DZ/yNoUS8FLJ
 9TpGDwqqkAiqBF8APGwKiLtES6if3MlJmJtFsJvqr2mK32Y/GxXipJqfHZL2SlfBrx
 cxfHwwLAf+sd+a2j+u7mgyD+4I94bv+BcGfy4Ktg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 396A7fbe103631
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 6 Oct 2023 05:07:41 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Oct 2023 05:07:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Oct 2023 05:07:40 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 396A7c6w105951;
 Fri, 6 Oct 2023 05:07:38 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <a-nandan@ti.com>
Subject: [PATCH v3 0/2] Enable split mode in binman
Date: Fri, 6 Oct 2023 15:37:35 +0530
Message-ID: <20231006100737.343745-1-n-francis@ti.com>
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

Changes in v3:
	- Simon
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

