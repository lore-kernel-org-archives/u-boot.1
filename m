Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E47AC3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 11:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3364987956;
	Fri,  5 Jan 2024 12:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vA9fHQfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C634D87956; Fri,  5 Jan 2024 12:39:33 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B58D887720
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 12:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 405BdMuW043989;
 Fri, 5 Jan 2024 05:39:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704454762;
 bh=05jMCBrt3Cgeuu9mfJmioTE8ECXzgWVTFOKWEjWmBlk=;
 h=From:To:CC:Subject:Date;
 b=vA9fHQfI3sO+FxW29RhzMm+3l/L8VU+qKTozNzIVrsj7W59ARx3oO2rOOLzpDntZ5
 qQS0ZrC23aZOUU+6Py4rG8VNXmZFYuhwrTPG4xuTmskL+hgqVzgf/mXHJxscXsjk2M
 jV0c3WA4mcTgb1HsPXn0KS02hDkb2hW014ce1pPg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 405BdMjs013944
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 5 Jan 2024 05:39:22 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jan 2024 05:39:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jan 2024 05:39:21 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 405BdHEG095665;
 Fri, 5 Jan 2024 05:39:18 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <sjg@chromium.org>, <vigneshr@ti.com>, <bb@ti.com>, <m-chawdhry@ti.com>,
 <alpernebiyasak@gmail.com>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vishalm@ti.com>, <jonas@kwiboo.se>,
 <sughosh.ganu@linaro.org>, <lukas.funke@weidmueller.com>,
 <fr0st61te@gmail.com>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2 0/2] binman: ti_board_cfg: Add yamllint support
Date: Fri, 5 Jan 2024 17:09:15 +0530
Message-ID: <20240105113917.1117945-1-n-francis@ti.com>
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

This series adds support for checking and raising an error if a
configuration file does not adhere to the default yamllint rules. This is
based on the mailing-list suggestion [1].

Boot logs:
https://gist.github.com/nehamalcom/9f98d7d17dd19b61a0ad27fdea3bc18e

[1]: https://lore.kernel.org/all/20240103173637.fdhfwgmsmqrfpzdp@manmade/

Changes since v1:
https://patchwork.ozlabs.org/project/uboot/cover/20240104075357.638983-1-n-francis@ti.com/
	- add yamllint to requirements.txt (Nishanth)
	- boot logs unchanged since no affecting change

Neha Malcom Francis (2):
  board: ti: *-cfg.yaml: Adhere to yamllint rules
  tools: binman: ti_board_cfg: Check for linting problems

 board/ti/am62ax/board-cfg.yaml               |   20 +-
 board/ti/am62ax/pm-cfg.yaml                  |    4 +-
 board/ti/am62ax/rm-cfg.yaml                  | 1664 +++----
 board/ti/am62ax/sec-cfg.yaml                 |  212 +-
 board/ti/am62ax/tifs-rm-cfg.yaml             | 1484 +++----
 board/ti/am62x/board-cfg.yaml                |   20 +-
 board/ti/am62x/pm-cfg.yaml                   |    4 +-
 board/ti/am62x/rm-cfg.yaml                   | 1532 +++----
 board/ti/am62x/sec-cfg.yaml                  |  212 +-
 board/ti/am64x/board-cfg.yaml                |   20 +-
 board/ti/am64x/pm-cfg.yaml                   |    4 +-
 board/ti/am64x/rm-cfg.yaml                   | 2386 +++++-----
 board/ti/am64x/sec-cfg.yaml                  |  216 +-
 board/ti/am65x/board-cfg.yaml                |   20 +-
 board/ti/am65x/pm-cfg.yaml                   |    4 +-
 board/ti/am65x/rm-cfg.yaml                   | 2994 ++++++-------
 board/ti/am65x/sec-cfg.yaml                  |  212 +-
 board/ti/j721e/board-cfg_j7200.yaml          |   20 +-
 board/ti/j721e/pm-cfg_j7200.yaml             |    4 +-
 board/ti/j721e/rm-cfg.yaml                   |   64 +-
 board/ti/j721e/rm-cfg_j7200.yaml             |  134 +-
 board/ti/j721e/sec-cfg.yaml                  |  192 +-
 board/ti/j721e/sec-cfg_j7200.yaml            |  216 +-
 board/ti/j721s2/board-cfg.yaml               |   20 +-
 board/ti/j721s2/pm-cfg.yaml                  |    4 +-
 board/ti/j721s2/rm-cfg.yaml                  | 4184 +++++++++---------
 board/ti/j721s2/sec-cfg.yaml                 |  212 +-
 tools/binman/etype/ti_board_config.py        |    5 +
 tools/binman/ftest.py                        |    6 +
 tools/binman/test/323_ti_board_cfg_phony.dts |   14 +
 tools/binman/test/yaml/config.yaml           |    4 +-
 tools/binman/test/yaml/config_phony.yaml     |   18 +
 tools/buildman/requirements.txt              |    1 +
 33 files changed, 8075 insertions(+), 8031 deletions(-)
 create mode 100644 tools/binman/test/323_ti_board_cfg_phony.dts
 create mode 100644 tools/binman/test/yaml/config_phony.yaml

-- 
2.34.1

