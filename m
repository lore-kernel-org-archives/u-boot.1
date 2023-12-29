Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBBEC46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 10:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C00968788D;
	Fri, 29 Dec 2023 11:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UugqRTfO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75F9887A27; Fri, 29 Dec 2023 11:46:43 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366DD876B2
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 11:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkXTV075590;
 Fri, 29 Dec 2023 04:46:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703846793;
 bh=ebigwehaD3RfwLmN+/4zDLpScEwNr++VFy4+uE1TeWo=;
 h=From:Subject:Date:To:CC;
 b=UugqRTfOdtMY29S/DMPuUIifr4affSYcstHNCot8c+VXyK6MGqqjVbDD0Qz9ZK9Xv
 Jr8pJFVG0GVknEUn9q61/H7xT6VvpVLxxTRc/+29dOBbjUu6cW7RTDT4UaKf9NMUt9
 ZnuOyCeFaBaWX0mjm8j2jue1uPluCWdMmnsXw0R0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTAkXPV065681
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 04:46:33 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 04:46:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 04:46:33 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.69.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkT7e072641;
 Fri, 29 Dec 2023 04:46:30 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v7 0/9] ATF and OP-TEE Firewalling for K3 devices.
Date: Fri, 29 Dec 2023 16:16:24 +0530
Message-ID: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAICjjmUC/23PTW7DIBAF4KtErEs1/NrOqveougA8xEgxjsB1U
 0W+eyGVkljycoCP9+ZGMqaAmRwPN5JwCTlMsQzN24G4wcQT0tCXmXDgAhouqQ1xNJH6kPDHnM8
 hnqhW6HrLBTowpEBrMlKbTHRDpd+XPCc0I414nev9JaEP13vo51eZh5DnKf3eOyysnv7HdaD24
 hZGgYq2k4qD9b41H3N4d9NI6l8Lf/Fc73pevGUGWolOC9lvvHh4BrC77iKKR2lYecMlMr/x8sU
 ztutl8SUdWtULAOw2Xj09Y2LXq9pfWKN9KzoNeuP103PY31/X/o13yITRvWMPv67rH8YW0eARA
 gAA
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703846789; l=2991;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=xE/J+ENCO3rhkn95a1nNbKUlri5yBSby20C2TJG9oL4=;
 b=NpfzIFqu9YtMbXnYRtjtk7f91VU4OrRHwRC5gNPYKQYrTY/wWtjos9VwZwml0PE8mEJTe1hnR
 mTl+ZJJaNKwCMUQVlpWOnbBpZZw2u2iQWp9F8ujVEpLX+g7LD52SCAm
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

Test Logs: https://gist.github.com/manorit2001/4cead2fb3a19eb5d19005b3f54682627
CICD Run: https://github.com/u-boot/u-boot/pull/442

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v7:

* Andrew
- Update documentation
- Incorporate templating 

* Simon
- Change the prefix for -binman.dtsi files

* Jon
- Remove the unintentional dependency on python3.9+
  (https://lore.kernel.org/all/CADL8D3ZWoZpMidBTy+iSs-KOB6+LRAFVcDa-n_fVqvd00Z0=nw@mail.gmail.com/)

- Add another patch to fix templating inclusion log
- Change headings level for secure boot documentation
- Populate 3 priv id slots for the background firewalls that require it
- Link to v6: https://lore.kernel.org/r/20231206-binman-firewalling-v6-0-e7fce13a6dc1@ti.com

---
Manorit Chawdhry (9):
      dtoc: Change dst to self in debug message
      binman: ti-secure: Add support for firewalling entities
      binman: ftest: Add test for ti-secure firewall node
      arm: dts: k3-binman: Add k3-security.h and include it in k3-binman.dtsi
      arm: dts: k3-j721e-binman: Add firewall configurations
      arm: dts: k3-j721s2-binman: Add firewall configurations
      arm: dts: k3-j7200-binman: Add firewall configurations
      docs: board: ti: k3: Cleanup FIT signature documentation
      docs: board: ti: k3: Add secure booting documentation

 arch/arm/dts/k3-binman.dtsi                        |  49 ++++
 arch/arm/dts/k3-j7200-binman.dtsi                  |  90 ++++++
 arch/arm/dts/k3-j721e-binman.dtsi                  | 116 ++++++++
 arch/arm/dts/k3-j721s2-binman.dtsi                 | 123 ++++++++
 arch/arm/dts/k3-security.h                         |  58 ++++
 doc/board/ti/k3.rst                                | 313 ++++++++++++++-------
 tools/binman/btool/openssl.py                      |  16 +-
 tools/binman/etype/ti_secure.py                    |  95 +++++++
 tools/binman/etype/x509_cert.py                    |   4 +-
 tools/binman/ftest.py                              |  23 ++
 tools/binman/test/324_ti_secure_firewall.dts       |  28 ++
 .../325_ti_secure_firewall_missing_property.dts    |  28 ++
 tools/dtoc/fdt.py                                  |   2 +-
 13 files changed, 842 insertions(+), 103 deletions(-)
---
base-commit: 2b28c3b871cd5d55b19f0a86cef970139f8ab952
change-id: 20230724-binman-firewalling-65ecdb23ec0a

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

