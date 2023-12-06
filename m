Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A6EC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBB0F876A6;
	Wed,  6 Dec 2023 10:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QD/VvLgO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 796B8876C0; Wed,  6 Dec 2023 10:51:40 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9CE386590
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B69pUmO053147;
 Wed, 6 Dec 2023 03:51:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701856290;
 bh=wug6cx0P2M4cXrk2C4u3Cmx7tEFYbU9Wb9pcaz5ZrbE=;
 h=From:Subject:Date:To:CC;
 b=QD/VvLgObPmIuHQc5bSooOTzDMSKgTm+xiX+8zpdyQT6kq8gAW1dyAQqvN5gbWVI5
 SXYNPrd5v7mW0SVeumpcM/Oc+eoi6/wpSI/9Qucp5GPFD7jWdfqb9VaC9i6cjfK3XY
 C1ulI9ZvQH6bCVdpiUhQjdzjy9PFU1qGtlVW6Dug=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B69pUk4013127
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Dec 2023 03:51:30 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 03:51:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 03:51:30 -0600
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B69pQBW039003;
 Wed, 6 Dec 2023 03:51:27 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v6 0/8] ATF and OP-TEE Firewalling for K3 devices.
Date: Wed, 6 Dec 2023 15:21:22 +0530
Message-ID: <20231206-binman-firewalling-v6-0-e7fce13a6dc1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABpEcGUC/23PTW7DIBAF4KtErEs1/NbOqveouhjwECPFOALXT
 RX57sWplMaSlw/m4w03VihHKux4uLFMcyxxTDXYlwPzPaYT8djVzCRIBW9ScxfTgImHmOkbz+e
 YTtwa8p2Tijwgq9BhIe4yJt+v9OtSpkw48ETXab2/ZArxei/9+Ky5j2Ua8899h1msp391LZi9u
 llw4KpptZHgQmjwfYqvfhzY+tYsn7y0u15W7wRCo8lbpbuNVw8vAHa/O6vqSaOoM1KTCBuvn7w
 Qu15XX9uhMZ0CoHbjzb8XQu16s+6vHNrQqNaCffhlWX4BywabAtEBAAA=
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701856286; l=2381;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=U3kqEhDLF0AzpUtXAgUegv+qQhMl1Tzx50XCSh63/o8=;
 b=ELpvsfe4uBTQz83SKny6Tsq6hOy+mGI+6aIBDWiCHuEmwyNQcp4sq0paJ9vGiV40sA2TvClOQ
 m+C5UOGsfiqDwyHvlzSqTj7mu05o+gYXrUg5K0JB35yXggMmHuPoJg2
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

K3 devices have firewalls that are used to prevent illegal accesses to
memory regions that are deemed secure. The series prevents the illegal
accesses to ATF and OP-TEE regions that are present in different K3
devices. 

AM62X, AM62AX and AM64X are currently in hold due to some firewall
configurations that our System Controller (TIFS) needs to handle. 
The devices that are not configured with the firewalling nodes will not
be affected and can continue to work fine until the firewall nodes are
added so will be a non-blocking merge. 

Test Logs: https://gist.github.com/manorit2001/c929e6ccab03f55b3828896fbd04184b
CICD Run: https://github.com/u-boot/u-boot/pull/442

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v6:
- Rebase on -next
- Link to v5: https://lore.kernel.org/r/20231113-binman-firewalling-v5-0-b3ba6f839606@ti.com

---
Manorit Chawdhry (8):
      binman: ti-secure: Add support for firewalling entities
      binman: ftest: Add test for ti-secure firewall node
      binman: k3: Add k3-security.h and include it in k3-binman.dtsi
      binman: j721e: Add firewall configurations
      binman: j721s2: Add firewall configurations
      binman: j7200: Add firewall configurations
      docs: k3: Cleanup FIT signature documentation
      docs: k3: Add secure booting documentation

 arch/arm/dts/k3-binman.dtsi                        |   2 +
 arch/arm/dts/k3-j7200-binman.dtsi                  | 152 ++++++++++
 arch/arm/dts/k3-j721e-binman.dtsi                  | 196 +++++++++++++
 arch/arm/dts/k3-j721s2-binman.dtsi                 | 217 ++++++++++++++
 arch/arm/dts/k3-security.h                         |  58 ++++
 doc/board/ti/k3.rst                                | 315 ++++++++++++++-------
 tools/binman/btool/openssl.py                      |  16 +-
 tools/binman/etype/ti_secure.py                    |  95 +++++++
 tools/binman/etype/x509_cert.py                    |   4 +-
 tools/binman/ftest.py                              |  23 ++
 tools/binman/test/324_ti_secure_firewall.dts       |  28 ++
 .../325_ti_secure_firewall_missing_property.dts    |  28 ++
 12 files changed, 1032 insertions(+), 102 deletions(-)
---
base-commit: d379150621a5dbe7929b43d184cb51bb8c3ec4cb
change-id: 20230724-binman-firewalling-65ecdb23ec0a

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

