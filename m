Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CABCC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 10:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2278486F95;
	Mon, 13 Nov 2023 11:19:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lEB4Nr8Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 147A186DCE; Mon, 13 Nov 2023 11:19:11 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 425BC86F80
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 11:19:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADAJ4L9075328;
 Mon, 13 Nov 2023 04:19:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699870744;
 bh=FSHsyRsIytKHfn2rAY+5vYqP0TMBEsoizpYVBLarA5w=;
 h=From:Subject:Date:To:CC;
 b=lEB4Nr8Qc8rum2xoyvQOUpircu7aJ1CV1B0QqjPx0YS+Z4Y8MBbmyMGlG5Z7bmFbV
 iqLqoQh65BvbF8KFt6eKoT5lNYH78/uaoncoptufLBKmi+HrUbBxg8vR05gQ4Hvh9p
 PlkctlXcQvtKabe7YNkdMxhZfWvc/8+qRlLtkMwQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADAJ4vm075499
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 04:19:04 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 04:19:04 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 04:19:04 -0600
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADAJ066051156;
 Mon, 13 Nov 2023 04:19:01 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v5 0/8] ATF and OP-TEE Firewalling for K3 devices.
Date: Mon, 13 Nov 2023 15:48:59 +0530
Message-ID: <20231113-binman-firewalling-v5-0-b3ba6f839606@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABP4UWUC/23PTW7DIBAF4KtErEs1/Ni1u+o9qi4GPMQjxTgCl
 6aKfPfiVIoSycsHfPOGq8iUmLJ4P1xFosKZ51hD83IQfsR4JMlDzUKDNvCmrXQcJ4wycKIfPJ0
 4HmXbkB+cNuQBRYUOM0mXMPpxo9/nvCTCSUa6LNv9OVHgy63086vmkfMyp9/bDkVtp/91PTR7d
 UVJkKbrbaPBhdDhx8Kvfp7ENqvoB6/bXa+rdwqhs+RbY4cnb+5eAex+t5jqyaKqb7QlFZ68ffB
 K7XpbfW2HrhkMAPV3v67rH+xNumWRAQAA
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699870741; l=2498;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=gRtEzLrALkXH31pWFXEDc/cg0eKiGlpI9aHewECwJU4=;
 b=+af7Yjgoel9Tkmufbx8M5vbekoLSNs7iROc8EHs5UGyon7KyeyPqkPT9CnT7yYRAbMYZjXTYR
 asZO163mtNyAF38UswHHX0DxtChnOS6kpUzpDOJlPAp5Jx92b1V4AxJ
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
CICD Run: https://github.com/u-boot/u-boot/pull/442

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v5:

* Simon
- Change and improve the error message

- Fix the test case, wasn't working properly previously
- Rebase on top of master
- Link to v4: https://lore.kernel.org/r/20231011-binman-firewalling-v4-0-a08085d300e9@ti.com

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
 doc/board/ti/k3.rst                                | 315 ++++++++++++++-------
 tools/binman/btool/openssl.py                      |  16 +-
 tools/binman/etype/ti_secure.py                    |  95 +++++++
 tools/binman/etype/x509_cert.py                    |   4 +-
 tools/binman/ftest.py                              |  23 ++
 tools/binman/test/319_ti_secure_firewall.dts       |  28 ++
 .../320_ti_secure_firewall_missing_property.dts    |  28 ++
 12 files changed, 1005 insertions(+), 102 deletions(-)
---
base-commit: 17e9db18f17b6cad278694d4a61df95e96bdf4f5
change-id: 20230724-binman-firewalling-65ecdb23ec0a

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

