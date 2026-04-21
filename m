Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D28F94CA7
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 015FC84353;
	Tue, 21 Apr 2026 23:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="F8OXYeqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CDE1842B7; Tue, 21 Apr 2026 23:10:18 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 311F9842BF
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgwBc1d9XTZhn4bAl/Rp3uG16u0jsZ5cGnAsls9qeIkaGYpWrz6RVqanRjF9pR4SlBJBt9XnGMfQeeH/dVS2yOtrd0YwFqncnGqqBlj4syOcPDwyLy11tQ9Afd20ZnlcRsgLXXiDOdEpSyROtioT8t0boXXu7ffa4x+W8dF1NANtdRigEhK1Z7G8wQGsYgZIRDDP1cdNWtPSjbdasUpT5ULm+F276euNVqyPWhagM4Sreynos8AIyTDSClM81KGR/u2Wtwnq9byYJ4ut312T2GyiDiIScAkU7nFX96MM/d6b7a2F9M5CDLsfUZhnX6dLbmSwfTriI30vUfyuNHhaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9+nwOWr2hu/uZXK0FgkREIrjNAc9OOwdA8md2bzlVc=;
 b=cEW65kjSAeRDc3Rpa81oEl9YZ7Qn3HB+dahwxiR92lGRdj9YuwzL7AfogB2a1sPUHmsfk8G23pzB/SKl5N/CxPFj/mp1EGrrENf3ic/zjQInSsqY1UvU3AupSN034rMATjBRel1l+RD9HLRLy202ybJ5RNZTNMfSMB7yBUTu+KRd3sCN0YVU6hl1OGSgpNJUtnuOMLg5iPhTGlVWiXDbymkPsc39nYdES8CR1S+na+sUsG5Ccni8YQRUzYeSN4T+CRj642LhrgJax4jSttJVRZQJjPLvHhieRvckPDi+Bm9jA8DbRjmXxRPDSgwq37Q8aGjDoh1GOSO0kKcpVZa69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9+nwOWr2hu/uZXK0FgkREIrjNAc9OOwdA8md2bzlVc=;
 b=F8OXYeqaEwtACsdOkeGheDwhxeS8r3QB9HQAs+voTSAlgdCT5ddVmDZLMIRaAsXVWDLd31izibRw/a1WqiX0IGzyx7nn/RgSr91TfzrfzSG3oq34vrShDR+LXXO7ly5zRwMVLEt3fzKkR2KZHlVQY35qvNohHzltJsNw24TIn18QfPoBd5+qho2hYDHHZaWqEJLBpezXFIEr21UovB63tklmqphIc7nq4z082cGSJWcrKm0e0Qc/NhNJDF3hVYKK07vLVr7ounbsoaZeE1aZkeqPG2g0sUv9uphb/JO1wrpmdTFDmSlLgpx+ynpjwmvJ/ogkBoxHZUC9152MH5QF4w==
Received: from PR1P264CA0045.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cb::9)
 by MR1PPFBA07BFAE9.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::684) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Tue, 21 Apr
 2026 21:09:57 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb:cafe::ab) by PR1P264CA0045.outlook.office365.com
 (2603:10a6:102:2cb::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 21:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Tue, 21 Apr 2026 21:09:56 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id A161D202C3;
 Tue, 21 Apr 2026 23:09:56 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 00/15] add software ecdsa support
Date: Tue, 21 Apr 2026 23:09:39 +0200
Message-ID: <20260421210954.1170437-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|MR1PPFBA07BFAE9:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3617829a-c63b-46be-bca4-08de9fea5748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: BT1kCMEvML/EGI8hmsahrivxCLfvsBsrHcqKohAfJuuE5rgDpKdGMArIvLHeVHJZA0tqHPeMT3Ccq3L/6igXuFutgrpd9E7D9+kMopiSwOjbOcdmOIaVPhaHchvAq8PFzZh8E9uatvvCgVpdYtFurcUaBTtXxYV7CBZe/QR4xde593NkFy517MUciDwnu9CyDKaSepdkKYNSCXDbzuc8Ie/k1LR6ivUXtl+q90xM0xqvbFSbq9eWGU/JOtzCAuXPdrOJuK1OsVRHHCwl8OLKyt2CseIRVJyyDKWe313ETk943XK+xBkEWplair2aHN1DjlDpvF00LX4Y9S9h2wAWbW5aDx0swtO+G58dwupBocp0bZRzJHNDOo2BBVqgEmLQO0Y/TzYe2FVGYIZmBtsYCePU0xpr70iA9pfvqUlI5TUwphnIP1Lpf7RX8wcD9JFwp/XfGyO5VHlsT7V/KUP6+4OWzOlUT0FneZhOXdZVAJB6jrN7QQNag7qMApVpOKDFbdNVE9GqclfvebjhW+wSW44h5Uwhfvh+ELzzARZphSbRVg6vVUeaDSPKN9CQfQG++EeIyM8SMwQXdphE9/w5gMXXFueY59d8Rqv8MjkNvSOmPpSobrmewzQeBQdL+SbjjyUV7XRlKw0AHL+MaOaATcduAJRQg2S3cCtaI+envhvMqYtpvU4ZV0tJghBvY6jEH5SW1qAwdRR3bQl5FzW31shRGLvKzCLIYJkGXSvneQLxAup869DyYEH/dQljpFN6KbpRbaC9gDWmRSxtxU8cCA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BhQnXFQmBmOPiMvIkhh2AU93BWZAus36Q9rBTGj0hTJTjQk7O2HY3Zmeq6MhnW9qWinGu3j5qX09VYxnqtQ1cotG34uJnIjgLm7/Fh8OfjH7M7DQccJ3xD2nzSmHCMzuTFFtQsBLSzh9dxb1b7YYamBePYU24n7USssvmrNF8WJdTu8ksUr1TqKlUpQ2A0MHLz4cW0qhyhvsumye9YpCtOHk5BXdzM5mH2wUuDJGsp75gFfkpJPnXERY/QwN9rYGSnnW3Cm10xfnasiZ/QCDfJ2G6khzWARjbZZvDLH4AOIw3tzhSuiI5LdJa1VMkdNxg/SNzqqOWm9ENCn8ck2hex11upjlhfzixsttcqRVBok7L1luS5y0QIfzUDDbCKNHQLGVmnEES+sxscmQdazkwAkXasO7e+eL5XdSvrtK/yOQOerhG8v3alpxwww2Vc4o
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:09:56.8259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3617829a-c63b-46be-bca4-08de9fea5748
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPFBA07BFAE9
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
 configs/amd_versal2_virt_defconfig            |   3 +
 configs/qemu_arm64_lwip_defconfig             |   3 +
 configs/sandbox_defconfig                     |   1 +
 configs/starfive_visionfive2_defconfig        |   3 +
 configs/xilinx_versal_net_virt_defconfig      |   3 +
 configs/xilinx_versal_virt_defconfig          |   3 +
 configs/xilinx_zynqmp_kria_defconfig          |   3 +
 configs/xilinx_zynqmp_virt_defconfig          |   3 +
 drivers/crypto/Makefile                       |   1 +
 drivers/crypto/ecdsa/Makefile                 |   6 +
 drivers/crypto/ecdsa/ecdsa-sw.c               |  33 ++
 include/crypto/ecdsa-uclass.h                 |  15 +-
 include/crypto/internal/ecdsa.h               |  39 ++
 lib/ecdsa/Kconfig                             |   1 +
 lib/ecdsa/ecdsa-libcrypto.c                   |  92 +++-
 lib/ecdsa/ecdsa-verify.c                      |  75 ++-
 lib/fdt-libcrypto.c                           |   2 +-
 lib/mbedtls/Kconfig                           |  14 +
 lib/mbedtls/Makefile                          |  19 +-
 lib/mbedtls/ecdsa.c                           | 146 ++++++
 lib/mbedtls/mbedtls_def_config.h              |  17 +
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
 tools/binman/ftest.py                         |  52 ++
 tools/binman/test/ecdsa521.pem                |   7 +
 tools/binman/test/security/pre_load_ecdsa.dts |  22 +
 .../security/pre_load_ecdsa_invalid_algo.dts  |  22 +
 .../security/pre_load_ecdsa_invalid_key.dts   |  22 +
 .../security/pre_load_ecdsa_invalid_sha.dts   |  22 +
 tools/image-host.c                            |  93 +++-
 tools/image-sig-host.c                        |   7 +
 tools/preload_check_sign.c                    |  30 ++
 64 files changed, 1877 insertions(+), 136 deletions(-)
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

