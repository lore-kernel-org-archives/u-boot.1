Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4E8CD98C7
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 06:25:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC5686B57;
	Wed, 11 Oct 2023 08:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="owwNG8NR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A46B86BA3; Wed, 11 Oct 2023 08:25:17 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D1F7864E7
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 08:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39B6P6EP110111;
 Wed, 11 Oct 2023 01:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697005506;
 bh=9yacJnUadf+4hmfpUKwlTwRgJDQSwsvFI7zfJuDZiIE=;
 h=From:Subject:Date:To:CC;
 b=owwNG8NRx2Fe3DEbkPDdKBlPy2E3e1A+81FbZvfnnxOpm5OLCkxLAyeJg9+B1wSl8
 PJ7dVAG02K7TSflpsvNlc43yCtAOzV6MMfiEqDZs2O+DPbZH75ERnPSX6Ph6wyKiN3
 artKupTdJj94Q0fT7GYkIW+7ahVDyJNeIlNM6m/o=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39B6P6U2024342
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 11 Oct 2023 01:25:06 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Oct 2023 01:25:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Oct 2023 01:25:06 -0500
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39B6P2l2005599;
 Wed, 11 Oct 2023 01:25:02 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v4 0/8] ATF and OP-TEE Firewalling for K3 devices.
Date: Wed, 11 Oct 2023 11:54:57 +0530
Message-ID: <20231011-binman-firewalling-v4-0-a08085d300e9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALk/JmUC/23PQW7DIBAF0KtErEMFA3acrnqPqosBD/FIMY7Ap
 aki3704laJE8vIDb/5wE5kSUxbvu5tIVDjzFGuw+53wA8YTSe5rFqDAqANY6TiOGGXgRD94PnM
 8ybYh3zsw5BWKCh1mki5h9MNKvy95ToSjjHSd1/tLosDXe+nnV80D53lKv/cdil5P/+uOqtmqK
 1oqabqjbUC5EDr8mPnNT6NYZxV48tBueqjeaVSdJd8a27948/Baqc3vFlM9WdT1DVjS4eGXZfk
 DhTzJQVEBAAA=
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697005502; l=2731;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=Z3pko7wCs5bNn0JP9khIn0HA3/RYn6NyOilKUA2lEVo=;
 b=jac7skGfgTL4GhFJqDtVS/o1SeNlcOSa5KJJ4Rf5+bDvAEhwSpo13OZjD7RKu1U4ykYHPOqG9
 yaHKqtmF1bbBd93CP3mt/bdzHowmKX9H9B0HuncJP7wIdSo2DKRhnp2
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

AM62X, AM62AX and AM64X are currently in hold due to some firewall
configurations that our System Controller (TIFS) needs to handle. 
The devices that are not configured with the firewalling nodes will not
be affected and can continue to work fine until the firewall nodes are
added so will be a non-blocking merge. 

Test Logs: https://gist.github.com/manorit2001/c929e6ccab03f55b3828896fbd04184b

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v4:

* Nishanth
- Add documentation
  (https://lore.kernel.org/u-boot/20231009050838.eo5f62fo36kxsaer@ula0497581/)

* Simon
- Change auth_in_place to auth-in-place
- Change double quotes to single quotes
- Handle exception when firewall property is missing and add a test

- Dropped the test Reviewed-by due to a changes in test commit
- Cleanup FIT Image documentation also as that is also a part of secure
  boot.
- Link to v3: https://lore.kernel.org/r/20231004-binman-firewalling-v3-0-e4a102324e1f@ti.com

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
 arch/arm/dts/k3-j7200-binman.dtsi                  | 143 ++++++++++
 arch/arm/dts/k3-j721e-binman.dtsi                  | 187 ++++++++++++
 arch/arm/dts/k3-j721s2-binman.dtsi                 | 208 ++++++++++++++
 arch/arm/dts/k3-security.h                         |  58 ++++
 doc/board/ti/k3.rst                                | 316 ++++++++++++++-------
 tools/binman/btool/openssl.py                      |  16 +-
 tools/binman/etype/ti_secure.py                    |  90 ++++++
 tools/binman/etype/x509_cert.py                    |   3 +-
 tools/binman/ftest.py                              |  22 ++
 tools/binman/test/319_ti_secure_firewall.dts       |  28 ++
 .../320_ti_secure_firewall_missing_property.dts    |  28 ++
 12 files changed, 999 insertions(+), 102 deletions(-)
---
base-commit: b05a184379631d13c4a49e423aa1324dc1ae6158
change-id: 20230724-binman-firewalling-65ecdb23ec0a

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

