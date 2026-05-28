Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A31CD5BD1
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 08:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F9BF846CE;
	Thu, 28 May 2026 10:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="m4rnh2G8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0655B846CE; Thu, 28 May 2026 10:19:23 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF72980087
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNTiaBZAmnr1M7PJYOBZBNcVN4Opd965DjwfEHKcfrxEruutVTYFhvJlV1BywZknq/w8EXQYcHrrAicZELQNIuiw/64rN6hpt4n5x2NAWG/hXVoOaObrt2Vzbwb5Y8DIWV3251TfB7NJRv4tw4obZEEDNEuL3VWlPRTELkSwJMlKqxvpAwlcn/kYMN+5yR5aRp2UBfwzJnBDNJlXFo7X7mkOp6GcWEBKUNJtR7bu9SmWynhOyNe1dM07PrpHDNOywDj9xb02eeosvLvOsDcgZNWt8uCNV7SDUlZEJy6je92vpjD4eV6wV+XI4UkmiHpcFjAMQEPtdYlQsTZYUGQr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NJ8jwbHRyyiDh5nLwwoLd47/ttujih+1RFCSFf4rl8=;
 b=rDDuV/0NQN3pQh1rQ91guIxHGu48ATL93LfXvuj8JVznSQjtU102G4d2hmUOfw7aBAsFGVACEgSWbSt/VfPwZmLW/4BICxW/8x7QuTl+eSc+p6P8rf6JhohwRVFFvg4Fu/VERuU8Vlt7yxkALoFx23/bT7p+3HqQbNjA6OYpe5s2cAMPyCc9KHLU2Uc4XYp8PX5mQFaRia2Kf+Z8t0VTBQeo3Hw2RGnWLPO2JC19DLyzuudhNbCu91Cv+hAM++dSDXNwwfe6JkSDFmK8qJqY+jqXUPvB2F/opl6zKLqPOsYYB4ccbzuN1EJZNUQjn73WSGxzaCiVkTVK6bfT3gp5Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NJ8jwbHRyyiDh5nLwwoLd47/ttujih+1RFCSFf4rl8=;
 b=m4rnh2G8Y/4PlhHjX4b8eOPkWCKFlutrD4kfwiXBFtQi8pvYjFLey7qMPdmWjRkkR6iktSqPEOsOb36ppSLmTaQj6KmSMdiF/tSRivqONToel49rbPe/HHTWf/TZl/rMyK0DQnSX8Iqn+O3VW8SCDFreixoUxeHeRaMJf4Rl08tjMVoO9TPF9A288f4oVAYvf0WQi9ntv8dVYFzkBZA2fr6EpbBT6RRU9mj/Kj9MRDFJECv7Iga+KGOZeMhnNxu0Vbqn0LbNQZhm6yjO+SeMON99A9s4NXXu59ZDLfTHrXa9iRrXaVTOXrXOZVMaZVTGR+ho/+zBDegkZF6C4gid1A==
Received: from MR1P264CA0160.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:55::11)
 by PA0P264MB7879.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:57e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:19:19 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55:cafe::76) by MR1P264CA0160.outlook.office365.com
 (2603:10a6:501:55::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 08:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D59.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 08:19:18 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 6216D20737;
 Thu, 28 May 2026 10:19:18 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v7 00/15] add software ecdsa support
Date: Thu, 28 May 2026 10:19:01 +0200
Message-ID: <20260528081916.11355-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|PA0P264MB7879:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6d58c4d9-ccb3-45a0-42cd-08debc91d080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: Uxw1nXIGb5f5fL/Ghl7DsgkLiVA1VMGIyDnUzhJeGiDgu2DyTfwm7nspKaX7PBqd0VM4cLS0K4A7u4MKHQhAHYUnf9+kH2sJeOMV4D29hb7YAmcMa7capidHddQ8xruOYcrFnFvoGJZKbNYf6hYjhZv/m4oSUUVRVt40WDbaW8e4HH8DqaYbNOyAdnU5HDyu6dUpCIqKAUkMTvSueeKcYH0LdwgeWNV6XntiIQj3eX56MJ1GYB9XaqCXpZTA86gYyIdFUar5W/6xqQpHW5BBa/qNJIdH+IYuCugnMRaCUqem/LScmFGOreuVnoK7LJb0+sgwIhyIP1sXx0Tg+Va+cY7+U+Qz0H7aEv2/cANnit9s8ysdRNWzUW8beUcNTyRS8GN6YL+j9pkmLswNglGnp8yKgrVlkbC3dcfepvdyYRHk5xQi3HQsOrAZ4NBJtJUUKVf6avPA6RsEh0VHXGVfqlt7G5s945b1qzuRDykig+i1ovA1zTKbV5UGB7buE9+EcosYg5M6xupKQS1IG+DRtNkyrvkAZmfnKBidRCcKyhBiJM1hLhn8RVyFLgCJELxDIUFgyf7TE7HnFhDV/zMEPHRKrGzD9SmoVpbAP894xu6NEC55Co95Xhr3lvm+JEu52zZ92EIu6lXsSzHxGBB3jCVa3GLM6tsVEnby0XUUTXTBErseIdjmSIc/e+Yr7r/gbso0QtvekAkGMQ7H7QT28KeFO7uV9WiRm0qQTj7Tgnc=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AfsXHe50aJHyZEoHEXTQ12YddZjIixwqlZYWyyH+Rl3CSjDTbfPGwpU7UYa/kHG+znrIR7JONB0z8hGQOblifQCwFdEIVk1ELCYgFV8EflzzlqbZja6hgAJOdVGh61BELbJKhp6x9HvXOaCJYlECo/tKFzit3eXrS/YXFKh8KnGod4TbyPpABz11jzbLMF856ZXXGr63HuMrihkiLOREa+xfHV31ig1KfrrRW0Fd+q6VL8v6LApDBqrdPCyeH5qOqFr7uU2vgIUz3pd4G34xepaCSKHKjLKPDMCjEmN46F8QFX8eOVgFVU20j5gtlL47x/nzFXCPi4JPW43FuxcvarhUQ9M5ZI38DMhqEPX6mgCydrBL4aie6ttVhZepgjf0r7yxVsb47iL/XPytg5iClt7XytRnlzYW40qjfoU+wvHE0UqjZqHL0h3357Bm6lK3
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:19:18.6848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d58c4d9-ccb3-45a0-42cd-08debc91d080
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA0P264MB7879
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
 lib/ecdsa/ecdsa-libcrypto.c                   |  94 +++-
 lib/ecdsa/ecdsa-verify.c                      |  67 ++-
 lib/fdt-libcrypto.c                           |   2 +-
 lib/mbedtls/Kconfig                           |  24 +
 lib/mbedtls/Makefile                          |  20 +-
 lib/mbedtls/ecdsa.c                           | 146 ++++++
 lib/mbedtls/mbedtls_def_config.h              |  41 +-
 test/dm/ecdsa.c                               | 109 ++++-
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
 57 files changed, 1873 insertions(+), 148 deletions(-)
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

