Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B1FCD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 115B38493E;
	Mon,  1 Jun 2026 15:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Bv61fc28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1F008491C; Mon,  1 Jun 2026 15:43:25 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E218984948
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhUzI0fqnLkmsHeByxYkLwv744aZKaLy3LCWdEExOiG5yq8wGKdYB19+BZfSxKfrfEqRpzA+LYlHLi977OOT2kt+CsGcKMOTdkxKpiozNDPc82B0Qfk4Z/cpDzQWPAkpa9qpSa/PsfS771zqb3KfVkDq3vHx8bE4qT2xeEK3pqwM4jWA22sPJj9QuSBNt7coZboo4A7LVGJ9nEgpNRm+i+cltQyZFxiDA2hd9kzQ3Yft1Bs6hxmYWPgv3rU9Z1nlM1yCJKYSZRTsYoRolJgyCIypWOZkUzVkayK8Kj1dFdVpq8vUmn1I2DKAU9eFTpPlcy63e1xQ3Lr1bUfP2NAnbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35pQ7MYqhqQCg//yLnYFg5R+qgPIT31OWUr9LQWv3Fk=;
 b=jpY//q8oaYpPCf3FHensdlLzFRosbt7RpHFx21/w/L0pPDZyvuGvZWQlPyZUriLlQlLrHTvGN3mmk+Cy5dYdMgFJS948qujuwa1XXkUAoZnmsfNV2R8Yc4e7XAOhJ+Nu4mzkGsVvKohapjBXIS7U3VZRP4ZrLIIYsphFmuocHm5mVetpzluKhPkciZBNtL1WHY24d/Rd6kaYaa/fTEalTSJNJKpqeQIp2ZFKjEcbJUM92GVBDK1WYKET6r1a4Wh8YGWEnKF5XW15vYEmqvIDLIAkv0IuqjPHgNgd+K83WHjfatH34uAPTlA4NI4jF69XOuIZF66BybD3lXxhCF83IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35pQ7MYqhqQCg//yLnYFg5R+qgPIT31OWUr9LQWv3Fk=;
 b=Bv61fc28vIapCZxuwfkkc1APd+mZernn4s0VuJCER7twK5dXhtDKYNnYUIoCHDY5brHXpNqyOQuVGff1frv1PSAEGfukZGjGjPsENuCKfc+4VQtQHe0tzqUfWsg5HcUezVpOYK7ubnf8UGpeTMt2E0+OBit9/3gaoS8Pt7xa9Yn17yz13lJ1IuT5zr7ULGAQlOWVDLiUgXnBd1Yg8MB45rDZ1U/rpj8k5F72KmAzlnCzP2pvri81xgh/7X0tbuLJLGxxueUjTjADv+NtvH2lDV9V4A8voSoESj8mTGy/EaI/F8IAuHvuNEKAJqdAfM3W9k4XvhowBXpbdOsQg4ypjg==
Received: from MR1P264CA0188.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:58::19)
 by MR1P264MB2658.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 13:43:16 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58:cafe::30) by MR1P264CA0188.outlook.office365.com
 (2603:10a6:501:58::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 13:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Mon, 1 Jun 2026 13:43:15 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id 56F712014C;
 Mon,  1 Jun 2026 15:43:15 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v8 00/15] add software ecdsa support
Date: Mon,  1 Jun 2026 15:42:55 +0200
Message-ID: <20260601134310.2452454-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|MR1P264MB2658:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: de63cf4f-7de3-4a05-8f82-08debfe3bb6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 7GCaLgGSG9U725Q2dEUUj3BEGD75kl1nwIPBD1RBbGzuBFtJ541Gbd7snnZZcbmceZUNJz53QSnR9LSI4Z9IApk3MR3OVSHM3HC6CSK3+IaSwIEBF8dlB140aRUtduhaTX+9nm/M3yMv6c3pBHIn2STBIpWHZf2qtW8UhZ7A9zqC/YH3+zhFLAz+QRUadUAGICbE1HZ2vQpaVr/j8IEhYDCg5RZRqzbP1ZTCkdvb36YratqkX1gfhXeHdy3cEvyW9cpItU2EIp7XuCjo3OdZK6vcWlfu5ByVBiXSwhkOAFY3IchwNUCvLjNUkljEe0HvDlkNl6KiD6Ia2yKjW2/tlZj3TuxoUdu3P+Gv9HCD/+gleviCjXNBJw/28fLu0AN5SWmQNX6nzqo0oyDAfgbIVeSpKXc2UmLzzKOptrt2+YL0GkLL0SWgqr6YYGpO5GOpOGgQfbRX5Sknkcqz6+Y6jUcokaQR2zv96gnGO5XrdJiRRsT5vfCoA8nC64wffTLRLgDKACsnrpUtjEXIEjv2AWYjS7RM9dxGhQrpoAQSvZAnX9UUg7CZSrhSnn7PkCveFfFroBDGbauFMH2ZfPZ1FeiTqdnj6wqBJOSwb7S6YaotC/Bd6n0S7lmmKDK2QnRehtT3uxHIsyviz9UNliYVxyVeELHuGgSughL0407KzMRayTe2yf4XsEE3n6uUpe7BBcbFgfkdYfuLiLZKde0UduT3DnloEJcM5rKJdHoFTQA=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ln4P3oK6cZetHM0b3yUCa57rhx+NdIC2MBCtrkM4CE67F0A3i3rq6WaRTgOwiAi9pcTSLpfOfP244dwtUUp+rOMomUXKwIUGQytv5Rv1t+lkdbWLUzB4YkgEwOB9Sz7OKnuUUMSzIsdR7H3wvwQY3bsbBLmMCMKUqj3NPAlaEYcGKAsoK+OSPXm9AWQAZncirfB6SzPhqo7M//MWvRUirov9wh35EovPK7f7xt4Eh9tOA7JoLFzxZgiJRB28gmZCfesdweKJGnK60O+g9QUiJYraA88hy1y4EYPMSnkekho3IJP729LsbFpfUtQO8IjSr2Ob/CsbaE+EfJM/HCqXXMnE2fHsa/BUxG/bT2gwDT3+NV0vIjy3Smdc7I0zOrPqzESXbBQNhcUhrqWzg5rtk4RZGg/nFOX4k7PwlWUBRe1Nxq74ZtyeWVyL7UnSZ67a
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:43:15.5626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de63cf4f-7de3-4a05-8f82-08debfe3bb6f
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2658
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

This series adds the support of ecdsa with software
using mbedtls. So boards without ecdsa hardware may
also use signature with ecdsa.

To add the support of ecdsa with mbedtls, I have:
- enabled ecdsa in mbedtls
- add a function sw_ecdsa_verify that uses mbedtls
- add a driver sw_ecdsa that call sw_ecdsa_verify

I have tested this code with sandbox, and I have
followed those steps:

0) build u-boot using sandbox_defconfig and adding those options:

CONFIG_ECDSA_MBEDTLS=y
CONFIG_ECDSA=y
CONFIG_ECDSA_VERIFY=y

1) add a signature node to an its file
	signature-256 {
		algo = "sha256,ecdsa256";
		key-name-hint = "private-key-256";
	};

2) generate an ecdsa key
openssl ecparam -name prime256v1 -genkey -noout -out private-key-256.pem

3) create the itb file
./tools/mkimage -f <file.its> -k . -K arch/sandbox/dts/test.dtb <file.itb>

4) launch sandbox u-boot

./u-boot -d arch/sandbox/dts/test.dtb

5) on sandbox u-boot prompt, load the itb and launch bootm on it

=> host load hostfs - 1000000 uboot-ecdsa.itb
4628674 bytes read in 1 ms (4.3 GiB/s)
=> bootm 1000000
...
...
   Verifying Hash Integrity ... sha256,ecdsa256:private-key-256+ OK





Changes in v2:
- move ECDSA_MBEDTLS to MBEDTLS_LIB_X509
- rename lib/mbedtls/sw_ecdsa.c to lib/mbedtls/ecdsa.c
- enhance dependencies for ECDSA_MBEDTLS
- fix support of ecdsa521/secp521r1
- add vboot test using ecdsa

Changes in v3:
- do not use _MBEDTLS in mbedtls_def_config.h
- check returns and remove mem leak in lib/mbedtls/ecdsa.c
- remove useless field  *k in struct ecdsa_test_vector_s
- check returns in test/lib/ecdsa.c
- fix third parameter when calling sha*_csum_wd()
- add support of ecdsa in pre-load header

Changes in v4:
- change some dependencies to enable ecc
- use ECDSA_MBEDTLS to build the ecdsa driver
- support ecdsa521 and secp521r1
- add a test calling ecdsa_verify for the ecdsa class
- merge patch 10 and 11 (support ecdsa pre-load for binman and tests)
- several code cleanup

Change in v5:
- fix ecdsa 521 in the first patch (instead of the 5th patch)
- mbedtls: ecdsa is only compiled when ECDSA_MBEDTLS is enabled
- fit_image_setup_sig: required_keynode is initiazed to -1 instead of 0
- avoid hardcoded value for ecdsa sig and point size
- check pointer before using them
- free ecdsa keys when key are not found/used

Change in v6:
- fix dependencies for ecdsa
- ecdsa is no more mandatory for tls
- remove include u-boot/ecdsa.h in ecdsa-sw.c
- do not use fdt_stderror with -1
- 

Change in v7:
- change uint8_t to u8 in test/dm/ecdsa.c
- change info->required_keynode >= 0 in lib/ecdsa/ecdsa-verify.c
- set required_keynode to -1 in test/dm/ecdsa.c

Change in v8:
- check exact size of data read in dtb in function fdt_get_key
- enhance commit message to explain patch 2 (enable ecc)
- no longer use macro CHECK with goto inside macro
- some code cleanup


Philippe Reynes (15):
  ecdsa: fix support of secp521r1
  mbedtls: enable support of ecc
  ecdsa: initial support of ecdsa using mbedtls
  test: lib: ecdsa: add initial test
  drivers: crypto: add software ecdsa support
  test: dm: ecdsa.c: clean this test as software ecdsa is now
    implemented
  test: py: vboot: prepare integration test for ecdsa
  test: vboot: add test for ecdsa
  tools: fit_image_setup_sig: set required_keynode to -1
  tools: mkimage: pre-load: add support of ecdsa
  tools: binman: pre-load: add support of ecdsa
  boot: pre-load: add support of ecdsa
  tools: preload_check_sign: add support of ecdsa
  test: py: vboot: prepare test for global signature with ecdsa
  test: py: vboot: add test for global signature with ecdsa

 boot/image-pre-load.c                         |  53 +-
 configs/sandbox_defconfig                     |   2 +
 drivers/crypto/Makefile                       |   1 +
 drivers/crypto/ecdsa/Makefile                 |   6 +
 drivers/crypto/ecdsa/ecdsa-sw.c               |  32 ++
 include/crypto/ecdsa-uclass.h                 |  15 +-
 include/crypto/internal/ecdsa.h               |  39 ++
 lib/ecdsa/Kconfig                             |   1 +
 lib/ecdsa/ecdsa-libcrypto.c                   | 104 +++-
 lib/ecdsa/ecdsa-verify.c                      |  73 ++-
 lib/fdt-libcrypto.c                           |   2 +-
 lib/mbedtls/Kconfig                           |  24 +
 lib/mbedtls/Makefile                          |  20 +-
 lib/mbedtls/ecdsa.c                           | 152 ++++++
 lib/mbedtls/mbedtls_def_config.h              |  41 +-
 test/dm/ecdsa.c                               | 107 +++-
 test/lib/Makefile                             |   1 +
 test/lib/ecdsa.c                              | 456 ++++++++++++++++++
 test/py/tests/test_fit_ecdsa.py               |   2 +-
 test/py/tests/test_vboot.py                   | 143 +++---
 .../tests/vboot/sandbox-binman-ecdsa256.dts   |  24 +
 .../tests/vboot/sandbox-binman-ecdsa384.dts   |  24 +
 .../tests/vboot/sandbox-binman-ecdsa521.dts   |  24 +
 ...pss.dts => sandbox-binman-rsa2048-pss.dts} |   0
 ...-binman.dts => sandbox-binman-rsa2048.dts} |   0
 .../vboot/sandbox-u-boot-global-ecdsa256.dts  |  27 ++
 .../vboot/sandbox-u-boot-global-ecdsa384.dts  |  27 ++
 .../vboot/sandbox-u-boot-global-ecdsa521.dts  |  27 ++
 ... => sandbox-u-boot-global-rsa2048-pss.dts} |   0
 ....dts => sandbox-u-boot-global-rsa2048.dts} |   0
 ....its => sign-configs-sha1-rsa2048-pss.its} |   0
 ...sha1.its => sign-configs-sha1-rsa2048.its} |   0
 .../vboot/sign-configs-sha256-ecdsa256.its    |  45 ++
 .../vboot/sign-configs-sha256-ecdsa384.its    |  45 ++
 .../vboot/sign-configs-sha256-ecdsa521.its    |  45 ++
 ... sign-configs-sha256-rsa2048-pss-prod.its} |   0
 ...ts => sign-configs-sha256-rsa2048-pss.its} |   0
 ...56.its => sign-configs-sha256-rsa2048.its} |   0
 ...84.its => sign-configs-sha384-rsa3072.its} |   0
 ...s.its => sign-images-sha1-rsa2048-pss.its} |   0
 ...-sha1.its => sign-images-sha1-rsa2048.its} |   0
 .../vboot/sign-images-sha256-ecdsa256.its     |  42 ++
 .../vboot/sign-images-sha256-ecdsa384.its     |  42 ++
 .../vboot/sign-images-sha256-ecdsa521.its     |  42 ++
 ...its => sign-images-sha256-rsa2048-pss.its} |   0
 ...256.its => sign-images-sha256-rsa2048.its} |   0
 ...384.its => sign-images-sha384-rsa3072.its} |   0
 tools/binman/etype/pre_load.py                |  78 ++-
 tools/binman/ftest.py                         |  50 ++
 tools/binman/test/ecdsa521.pem                |   7 +
 tools/binman/test/security/pre_load_ecdsa.dts |  22 +
 .../security/pre_load_ecdsa_invalid_algo.dts  |  22 +
 .../security/pre_load_ecdsa_invalid_key.dts   |  22 +
 .../security/pre_load_ecdsa_invalid_sha.dts   |  22 +
 tools/image-host.c                            |  93 +++-
 tools/image-sig-host.c                        |   7 +
 tools/preload_check_sign.c                    |  30 ++
 57 files changed, 1893 insertions(+), 148 deletions(-)
 create mode 100644 drivers/crypto/ecdsa/Makefile
 create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
 create mode 100644 include/crypto/internal/ecdsa.h
 create mode 100644 lib/mbedtls/ecdsa.c
 create mode 100644 test/lib/ecdsa.c
 create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa256.dts
 create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa384.dts
 create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa521.dts
 rename test/py/tests/vboot/{sandbox-binman-pss.dts => sandbox-binman-rsa2048-pss.dts} (100%)
 rename test/py/tests/vboot/{sandbox-binman.dts => sandbox-binman-rsa2048.dts} (100%)
 create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts
 create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts
 create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts
 rename test/py/tests/vboot/{sandbox-u-boot-global-pss.dts => sandbox-u-boot-global-rsa2048-pss.dts} (100%)
 rename test/py/tests/vboot/{sandbox-u-boot-global.dts => sandbox-u-boot-global-rsa2048.dts} (100%)
 rename test/py/tests/vboot/{sign-configs-sha1-pss.its => sign-configs-sha1-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha1.its => sign-configs-sha1-rsa2048.its} (100%)
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
 rename test/py/tests/vboot/{sign-configs-sha256-pss-prod.its => sign-configs-sha256-rsa2048-pss-prod.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256-pss.its => sign-configs-sha256-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256.its => sign-configs-sha256-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha384.its => sign-configs-sha384-rsa3072.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha1-pss.its => sign-images-sha1-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha1.its => sign-images-sha1-rsa2048.its} (100%)
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa256.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa384.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa521.its
 rename test/py/tests/vboot/{sign-images-sha256-pss.its => sign-images-sha256-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha256.its => sign-images-sha256-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha384.its => sign-images-sha384-rsa3072.its} (100%)
 create mode 100644 tools/binman/test/ecdsa521.pem
 create mode 100644 tools/binman/test/security/pre_load_ecdsa.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts

-- 
2.43.0

