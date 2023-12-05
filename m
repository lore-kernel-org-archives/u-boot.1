Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056ADC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 09:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E97687075;
	Tue,  5 Dec 2023 10:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UYE0GZ1t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EF788788C; Tue,  5 Dec 2023 10:42:45 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CEE086FF7
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 10:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B59gb3l065253;
 Tue, 5 Dec 2023 03:42:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701769357;
 bh=sdJcpV18IKFu7NUcQA9TnRzMpcrLiwFyjSoZ/vOd9H8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=UYE0GZ1tNpDxG3Nl8gTlhAuQ9sf95wsU2ZRjDznM+J1nOiiPRhmM74angWsmYs8RJ
 +eUGJTIxl0xJWhvggG2NV3VRVyv2rbiAsXD3asNdozuiipVnP8+X/LMw5Z/e4hGnPm
 /x3C5A+C26NCItg2oO4vosKXcKJli6K3mTWzlrd0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B59gb2E087498
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Dec 2023 03:42:37 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 03:42:37 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 03:42:37 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B59gKlG018180;
 Tue, 5 Dec 2023 03:42:33 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <marcel.ziswiler@toradex.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <hs@denx.de>, <christophe.leroy@csgroup.eu>,
 <mr.bossman075@gmail.com>, <afd@ti.com>, <m-chawdhry@ti.com>,
 <kamlesh@ti.com>, <nm@ti.com>, <c-shilwant@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>
Subject: [PATCH v2 3/3] doc: board: ti: k3: Mention TI_DM argument
Date: Tue, 5 Dec 2023 15:12:20 +0530
Message-ID: <20231205094220.2301360-4-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205094220.2301360-1-n-francis@ti.com>
References: <20231205094220.2301360-1-n-francis@ti.com>
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

Mention TI_DM argument can be used to fetch a custom DM binary in the
A72 build instructions for K3 devices.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
---
 doc/board/ti/k3.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index a127215ce5..f19ee56f29 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -320,6 +320,13 @@ use the `lite` option.
  make CROSS_COMPILE=$CC64 BINMAN_INDIRS=$LNX_FW_PATH \
         BL31=$TFA_PATH/build/k3/$TFA_BOARD/release/bl31.bin \
         TEE=$OPTEE_PATH/out/arm-plat-k3/core/tee-raw.bin
+
+.. note::
+   It is also possible to pick up a custom DM binary by adding TI_DM argument
+   pointing to the file. If not provided, it defaults to picking up the DM
+   binary from BINMAN_INDIRS. This is only applicable to devices that utilize
+   split firmware.
+
 .. k3_rst_include_end_build_steps_uboot
 
 At this point you should have every binary needed initialize both the
-- 
2.34.1

