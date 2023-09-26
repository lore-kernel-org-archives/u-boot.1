Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF31CE7D24B
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35C0B86B93;
	Tue, 26 Sep 2023 09:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m0jXES/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B5A386BCE; Tue, 26 Sep 2023 09:58:46 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFA3F86B4E
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38Q7wfbL056821;
 Tue, 26 Sep 2023 02:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695715121;
 bh=lAuUUxEbtRVFyfc/Z0z0R9Wzr9tOZe2DB/mLn/TQm9I=;
 h=From:Subject:Date:To:CC;
 b=m0jXES/yLV37WNXTDrJGKbthNsxrHS4kI4KfMR2j11MnyaMK77bVCLY3W5ifGNFYa
 bNMUOKYY/YlAh2jvvqNPBGJ1kC4v6UrHGjbuvP3eNmvWxFPKdLtgMHQO/l7Af8pL1E
 eKyMHRnvGfoQAztb8LStzk+TMsQm/T5GXuqbJxRo=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38Q7wfXx002725
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Sep 2023 02:58:41 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 02:58:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 02:58:41 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38Q7wauI019632;
 Tue, 26 Sep 2023 02:58:37 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [RFC PATCH v2 0/8] ATF and OP-TEE Firewalling for K3 devices.
Date: Tue, 26 Sep 2023 13:28:28 +0530
Message-ID: <20230926-binman-firewalling-v2-0-b1a084ec634d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACSPEmUC/22OQQ6CMBREr0L+2ppaQMGViYkHcGtYtOUDP4FC2
 ooYwt0tXbucmby8WcGhJXRwTVawOJOj0YQgDgnoTpoWGdUhg+Ai5ReRMUVmkIY1ZPEj+55My84
 56lqJFDWXEEAlHTJlpdHdjr4n5y3KgRlc/L5PFhtaovQFz8cdqlB25Pxov/HIfIpTdJY8/+ecT
 4yztCizXHDVNIW8eTrqcYBq27YfzKLFQNYAAAA=
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695715116; l=2581;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=QjuoQGz5KAcTvNmIN6t5jBZsNOqDsHrd7sxMFpXmtFI=;
 b=h/UO37cAJT6llJFuMxDV2ZEhLp0SA9ZQTS/oFCOsi/ZNXz4DgVVrcNPH0lRlIzBLoakGKyojG
 g5ONTgb2wDRDDDnLtxkzu6A6UfHwCrAL4H+FxcsVv3IC+N5JZiSndT+
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
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

AM62AX and AM64X are currently in hold due to some firewall
configurations that our System Controller (TIFS) needs to handle. 

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v2:

Andrew:
    - Make the firewall DTS more readable with CONSTANTS

Neha:
    - Move GetHexOctet to dtoc for common usage
    - Update the documentation in ti-secure
    - s/indentifier/identifier/
    - Add firewall binman test

- Remove slave firewall multiple background regions
  ( Single firewall region works fine )
- Add a check in the subnodes to check for the node.name 'firewall'
- Change firewall indexing with id and region number so that it is easy
  to purge out firewalls and we don't need to redo the numbering.
- Add information for all the firewalls.
- Link to v1: https://lore.kernel.org/u-boot/20230905-binman-firewalling-v1-0-3894520bff8a@ti.com/

---
Manorit Chawdhry (8):
      dtoc: openssl: Add GetHexOctet method
      binman: ti-secure: Add support for firewalling entities
      binman: ftest: Add test for ti-secure firewall node
      binman: k3: add k3-security.h and include it in k3-binman.dtsi
      binman: j721e: Add firewall configurations for atf
      binman: am62x: Add firewalling configurations
      binman: j721s2: Add firewall configurations
      binman: j7200: Add firewall configurations

 arch/arm/dts/k3-am625-sk-binman.dtsi         |  49 +++++++
 arch/arm/dts/k3-binman.dtsi                  |   2 +
 arch/arm/dts/k3-j7200-binman.dtsi            | 137 ++++++++++++++++++
 arch/arm/dts/k3-j721e-binman.dtsi            | 183 ++++++++++++++++++++++++
 arch/arm/dts/k3-j721s2-binman.dtsi           | 206 +++++++++++++++++++++++++++
 arch/arm/dts/k3-security.h                   |  58 ++++++++
 tools/binman/btool/openssl.py                |  16 ++-
 tools/binman/etype/ti_secure.py              |  85 +++++++++++
 tools/binman/etype/x509_cert.py              |   3 +-
 tools/binman/ftest.py                        |  12 ++
 tools/binman/test/311_ti_secure_firewall.dts |  28 ++++
 tools/dtoc/fdt_util.py                       |  20 +++
 12 files changed, 796 insertions(+), 3 deletions(-)
---
base-commit: 2fe4b54556ea6271237b35de68dc458bfceab94c
change-id: 20230724-binman-firewalling-65ecdb23ec0a

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

