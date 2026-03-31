Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A800FF60FF
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 10:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCD838414B;
	Tue, 31 Mar 2026 12:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="m97Un7I2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C76384056; Tue, 31 Mar 2026 12:01:10 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0DB4840F1
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCHf0IGRJ+fRLbKdFNolTIM2jdpROMA/CP9ZASQX0dcTsTM0eupzWJp9/mwJpDpIzJbUDFeW2ich9qpiJ1WMDYjMXSThYg0w4ubGjs/79wKqB18oSXdneaMCGHlfImPBhfWksfZpQfmufbWF/f9daAbbFyWLZTX9fE8u3ImNWOz0+KNGR4t2luRf0pWAWQNpNzpomoLGN2biregLHgJk29fylF9fCvHWAJB4sCFFwIQAQKxl/IAiLIEKJ3FK5nLU8FtX2NNy55273vNGDv3cBrk5hbSXGYGEssPjNrSRkDi+7QtuuZ6TsunoslnLccjjmYgXbi+TrzPwDlXBHUlHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aexOa5j5EiUDPg/ldeSYyROkE0N5xQiKrfl9vZOApL0=;
 b=KIE522gr16eHLhLIHT9W7PkFfQCZQd3K9wL+P4E7k7qkApifTza/8X+YY98Vb+P884s1PBHmOSbXzRa+2OtEpjBxqOVD1PooP+qTpWK874/QZWDgKZUGHjO/Wl2tsaroSvgO7JNlGbz8ExkurwPtqHk47le2QxuoLaJ8rA2/Nt6kffHhADy61+9cpgRemHcrsfyE/J9LC5lR8Cn9rOEX//7/2eaa8Aaw+7MlG0oiedb0nICYRFyyjXb60l3evw5xTZSfy+BQMnrIQj6F+/K7BvYDX5/SDZPew9CaA1vEKtYmhUYCMvkM6wT7y6mB/FfnjGucQDBpYfavMxb3cp2d0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aexOa5j5EiUDPg/ldeSYyROkE0N5xQiKrfl9vZOApL0=;
 b=m97Un7I2zzMRyonopvhJ0wvuVrz6dnUs81nQTICRxbyKn1UN1hO+weriK5tdOTBb5SH0PvuJ5lgh4nHOCoNjAQei3ZnSHo9jdKkoDrIZsGpnXXCGyD2WjJxE4V25MTAdX/KVWKBjcF/FXtfAhROCmiB+FeAmeJgLc/SPyDMlx8dvjqQMhPU9+A9zE7Lvcy5bU528Utn+qXO9WtAF00MTroaslsr0Nb/IjPeguEMxnWUukSjFZ0pMVt8ZgRVZiPK+DbidmC7vTenz+Q3oR0HGhzkrn6HqlkhP/V6WvljZXNnGU7Etzht+iy4jXOkjlvslqGXK/koWbRNE4q2hcXbcPQ==
Received: from PR1P264CA0025.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::12)
 by MRZP264MB1575.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:17::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:00:52 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f:cafe::3) by PR1P264CA0025.outlook.office365.com
 (2603:10a6:102:19f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 10:00:52 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 5D47F201AE;
 Tue, 31 Mar 2026 12:00:52 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 00/15] add software ecdsa support
Date: Tue, 31 Mar 2026 12:00:32 +0200
Message-ID: <20260331100047.34618-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|MRZP264MB1575:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bba008f0-e591-4fcf-1513-08de8f0c64c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: CI72rCADrIPfkj1816aQ9X2PdjvuNOUDDFWvDs5GR8EJBRFdFmPp3YaqxEZ3DsQMurHgsBRziwf7sYDrsE8IHNoi7wX2OGvc5vEL/rIt3jikN91kkL2PIXOiljmzdASml+xz53teNcNJ+A7AMpMgYyaooFsneGTDoL+R4ijiCnu9vA+TRmjdhYat1HQiqTZr1c34jvqVQdu+omtyWu0Y8YmQMQqbWE7BTNvuFeKhWGsn71ng7C9aRmRhiO9dLk9e7WFJrcZ9xmGmlx5ycry0YXT0ofnzhFrn33Q/3twIQ3aopuSjthQ7UfrT4jtYgLBswQNFjbimn6nI4WViRpJln4wt9xxTYO4d70CvyMDjkLFU3V3OnH1r++vNJmUjHlMVYXIvrf/2J/Pg8ALHrLi5hf714lia+MK0S8rkBRTK8LDORk4s94WSFAaxKVTp3QauqWNZWi00PlbhMwoJ9Qjbi7tGcLBI2xpgQEguF2oS2/HbtKJSLrQWhYFOwSyYQLB/Kf0oY5jqXOXETV72ER8cyRmPZ1APptNs+lSditsLO7Kj5k6UHXSzvCJM+lXb8ofv6EeClqgqfEcFik6ekdudKdoEbcNRqEFbV9ooAREA6q3PYsPxiw2OoFCzq7ldIeC0NpAnoy5+C2y6jIzD2W8yAedioIxq2tp50GMO2jaxg2KI64AieNt0f7JBwuTB8mCTY+Cr/Uj1vHB/BwndE6NY410XXxI2rQKMKJ1zQCw4syV9kw9W54hgBE/6xj8dyuHiEp46MXgSJr+X8H3qhvFgLw==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pofKFcgv7N+nGmvhUCxFn6F5kql1vQ/jXBDbNmsFG4TbWmT1ODBD3Fb1NXhNYBU0MSStZcEB1fGnNXXoRsQZ8QZxa7yyohM4hNCL8VbKEYOqHUj9L8hNOn2jsb81Ng3BH4zHgfXiRnz2eeUb4EFRglXX7g/pZpxx52X/5wI0GzvWamE+HwE0zd86tOVIK4r7A/GIhnOTMAgPlAvUclfyef0uzoYBAZGy1MBGPiBhA+oJp/Nvhn5L2kWqlGTGXaNEFtgOyDCr8j+fl2ygsv0EmnrlqX3qF161y899CgR6Stw7P4x4UwLcWdLkaoBBkcBzsQGkP19wJe2bl+96tg7p0pkMhinl3soaFPwVumHQ4RMJEEZ/p9acOHipULoMwjtSrrhQLWfaBWmIzhBnxpFszJwCfhpLFjsz3vEiL7KfaGS0IWZxPxwBcRlr/z9Fzmlo
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:00:52.5535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bba008f0-e591-4fcf-1513-08de8f0c64c2
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1575
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

This serie adds the support of ecdsa with software
using mbedtls. So boards without ecdsa hardware may
also use signature with ecdsa.

To add the support of ecdsa with mbedtls, I have:
- enabled ecdsa in mbedtls
- add a function sw_ecdsa_verify that uses mbedtls
- add a driver sw_ecdsa that call sw_ecdsa_verify

I have tested this code with sandbox, and I have
followed those steps:

0) build u-boot using sandbox_defconfig and adding those options:
CONFIG_ECDSA_SW=y
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


I have tested with success ecdsa256 and ecdsa384,
but there is an issue with secp521r1. 

Changes in v2:
- move ECDSA_MBEDTLS to MBEDTLS_LIB_X509
- rename lib/mbedtls/sw_ecdsa.c to lib/mbedtls/ecdsa.c
- enhance dependancies for ECDSA_MBEDTLS
- fix support of ecdsa521/secp521r1
- add vboot test using ecdsa

Changes in v3:
- do not use _MBEDTLS in mbedtls_def_config.h
- check returns and remove mem leak in lib/mbedtls/ecdsa.c
- remove useless field  *k in struct ecdsa_test_vector_s
- check returns in test/lib/ecdsa.c
- fix third parameter when calling sha*_csum_wd()
- add support of ecdsa in pre-load header


Philippe Reynes (15):
  mbedtls: enable support of ecc
  ecdsa: initial support of ecdsa using mbedtls
  test: lib: ecdsa: add initial test
  drivers: crypto: add software ecdsa support
  ecdsa: fix support of secp521r1
  test: dm: ecdsa.c: clean this test as software ecdsa is now
    implemented
  test: py: vboot: prepare integration test for ecdsa
  test: vboot: add test for ecdsa
  tools: mkimage: pre-load: add support of ecdsa
  tools: binman: pre-load: add support of ecdsa
  tools: binman: pre-load: add test for ecdsa
  boot: pre-load: add support of ecdsa
  tools: preload_check_sign: add support of ecdsa
  test: py: vboot: prepare test for glocal signature with ecdsa
  test: py: vboot: add test for global signature with ecdsa

 boot/image-pre-load.c                         |  48 +-
 configs/amd_versal2_virt_defconfig            |   1 +
 configs/qemu_arm64_lwip_defconfig             |   1 +
 configs/starfive_visionfive2_defconfig        |   1 +
 configs/xilinx_versal_net_virt_defconfig      |   1 +
 configs/xilinx_versal_virt_defconfig          |   1 +
 configs/xilinx_zynqmp_kria_defconfig          |   1 +
 configs/xilinx_zynqmp_virt_defconfig          |   1 +
 drivers/crypto/Kconfig                        |   2 +
 drivers/crypto/Makefile                       |   1 +
 drivers/crypto/ecdsa/Kconfig                  |   8 +
 drivers/crypto/ecdsa/Makefile                 |   6 +
 drivers/crypto/ecdsa/ecdsa-sw.c               |  33 ++
 include/crypto/internal/ecdsa.h               |  14 +
 lib/ecdsa/ecdsa-libcrypto.c                   |  50 +-
 lib/ecdsa/ecdsa-verify.c                      |  24 +-
 lib/fdt-libcrypto.c                           |   2 +-
 lib/mbedtls/Kconfig                           |  16 +
 lib/mbedtls/Makefile                          |  19 +-
 lib/mbedtls/ecdsa.c                           | 141 ++++++
 lib/mbedtls/mbedtls_def_config.h              |  18 +
 test/dm/ecdsa.c                               |  18 +-
 test/lib/Makefile                             |   1 +
 test/lib/ecdsa.c                              | 447 ++++++++++++++++++
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
 tools/binman/ftest.py                         |  31 ++
 tools/binman/test/351_pre_load_ecdsa.dts      |  22 +
 .../test/352_pre_load_ecdsa_invalid_sha.dts   |  22 +
 .../test/353_pre_load_ecdsa_invalid_algo.dts  |  22 +
 tools/binman/test/ecdsa521.pem                |   7 +
 tools/image-host.c                            |  78 ++-
 tools/image-sig-host.c                        |   2 +-
 tools/preload_check_sign.c                    |  24 +
 62 files changed, 1577 insertions(+), 123 deletions(-)
 create mode 100644 drivers/crypto/ecdsa/Kconfig
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
 create mode 100644 tools/binman/test/351_pre_load_ecdsa.dts
 create mode 100644 tools/binman/test/352_pre_load_ecdsa_invalid_sha.dts
 create mode 100644 tools/binman/test/353_pre_load_ecdsa_invalid_algo.dts
 create mode 100644 tools/binman/test/ecdsa521.pem

-- 
2.43.0

