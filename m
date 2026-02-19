Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D73E9A049
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2754A83DEA;
	Thu, 19 Feb 2026 14:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="gup00rRb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CD4D83E36; Thu, 19 Feb 2026 14:26:17 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EBA983D5D
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHIedyOBZSKhttii9E7I3ng31GEcRksa/JD8SlltPTpaHbNirj1E5dTnX0D8yXEu3FCURnOM8wAkMmSSUqbTrY/Mvff4Y/6dzZG2DrxGyBgqy1q8PdkhN3h4oz1WacWfRrx7LWXPRLOJQ5QziJbCHEvGYqtI/2JMel6rBefj28ga/6RW3bGMZy/7S3WEPJIY3oFUrckUypk3xtm/83PayQD/5ul40vv4/GPwMxrsVIDlJP8Y3OqQntxGW5yK/iBuW/nj6+UpQ5nDcTrEA5DsBeGapMFq06Syyx6IrhQa7sXyV+jZWAalTkn0gj4E0ksRwu709D7+iitxVHrjgatmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmtiK97zc5lFaB9jso96mUdiXjD6q/S1RVqdmLQTGFw=;
 b=N4TeMpKWaVslh2+2AK550zDcMnLU2aFDHMOiOujihfwKC3Yvmv15HC/xzavDA7iOXpSlUwHVeJMTc1SmGVZcodkwi5REOnRnpL6FPfTFKd9qxnj0cEuLFqfUsLGj4JraET/8ZZuXjhaLdfIyJCgpSufT4AG80UnoZ8t06jgniHpZO5joS+JXGMFunef9+iIFg96U72GVVfKgA4dcNmqvHISOqwSEdELvSYk/hKlkGHG4EP52OCH1AUI8pERb8HhtDlT2RPl8ms1qLn8sTFgVFeE/KezoW4Vj7B8hyt7XKufx47I5uhBhmA8ftaPFLrNfmHrhS5dThncRLEaJ4Bso8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=gmail.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmtiK97zc5lFaB9jso96mUdiXjD6q/S1RVqdmLQTGFw=;
 b=gup00rRbg5Pjg2LArn/BOklWGKS5bzvseotXmQ36bkG4mVk9bTsRQhMZsppYNoang7N4JHnzOxgY820LUbZCLoq/h13Wg33UCoCc1D0zqnSZwfBuVr64GoD/aYH75JteE3QxBt83tPogGTAzufa10wZccO95wk7MB1hLvW7q0aWJCJRHWVu+Ah0eVpjRKvb24OKh/Jd/CNRrPmx2czrRyLcwtTYHUr38aBXKuuXW3VXWe4+qvMQsxtO+pmjAL3dr/F02Vfe98TBgRxyQK1GUhTT8L2ff3irMgDSdLG07OwVDze9IKgoyG6/po2veUDR8cJIf5P9YkM7C9kpXTk6TMA==
Received: from PAZP264CA0043.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fc::9)
 by MRZP264MB2699.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:18::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 13:26:09 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc:cafe::8f) by PAZP264CA0043.outlook.office365.com
 (2603:10a6:102:1fc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 13:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 19 Feb 2026 13:26:09 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 8C90820143;
 Thu, 19 Feb 2026 14:26:09 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [RFC PATCH v2 0/9] add software ecdsa support
Date: Thu, 19 Feb 2026 14:25:43 +0100
Message-ID: <20260219132552.1499698-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|MRZP264MB2699:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f024d866-13d3-4710-cbd7-08de6fba71d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xb572yya25utvgBFVYo3rjT+E77eEGkTi+/Op7yxtsPWP3BxrVfp2iYbpSAJ?=
 =?us-ascii?Q?Y5swe1ibHJrryL59qjzS2YP+dkTF7RAB7UWtyl0hRrPz6eDqhgCf0q/Cvw3l?=
 =?us-ascii?Q?321wjTZwXOMbkj/kThtwdeusFYkhjh7quFFjTkkE1mpPSS/JipHMNqBwMJWS?=
 =?us-ascii?Q?Qs4/AwBS5SCNnR4XUZrUOYfEs1idSFdSQ4Jq5MYLAiIdqA0+w88x+o6Q+/Bt?=
 =?us-ascii?Q?zrJ8m0Dh60u2Ja0C71+b2854d6xU881puG2utlID5tZOmiaRI9V0v7pqAv/V?=
 =?us-ascii?Q?kjD9yHw+4UgbHtfvkKNalEsrqxgkI9YAGkJ5umRXG5bxWxZBtNdKiJZ+60Dc?=
 =?us-ascii?Q?NWUg2T7btS2Ko+eapp4ZQNYELidGgLvQg78dgcYV5xFQFXZwz++a64CEClO1?=
 =?us-ascii?Q?LxZsWxFs9IpDlmLzkE9A6+ZqUWoErHgX4wWdnFiWcy2jq2pZjzmKfE4l7D3q?=
 =?us-ascii?Q?Gmto4qRblP4UYhqdU1hxji/3Vialgj74B6j9G6NNb8iCl/EmYeDyVVVzzjX3?=
 =?us-ascii?Q?tmdZJRyrKU6HlGZIdRSvDGlJwzyd8LkMnbnmIqx1PLoILCk5UlIlImMw+Xea?=
 =?us-ascii?Q?La/4i2CPY2aCwEeZLyqj1IcsTiaZDvYfm/dQMrOmBHuBd3XJGHFWtGskU0pn?=
 =?us-ascii?Q?lJBxDRkfQ1BuGsGZfvlHNCm3YZ4CsNTJq7nLrn//ZwDq2Bjcl6oInjuM8bAB?=
 =?us-ascii?Q?jkkvjHaSimq9P1xjQ+yHsFGE3tVmOtjrFZjxlbtJYW9iNVJQ/frF8Kym1DWB?=
 =?us-ascii?Q?XpzbjASbFG29MaM9Av7UqidB8LnSocYgUVpcjbDXo1ApefYviNC8SrJKgPX7?=
 =?us-ascii?Q?vUmJrCTyNIGDFq2W36rn00IvGzfXjlahoi0Ow+pIkbWobR7xfuwiO7jxq5fY?=
 =?us-ascii?Q?ZxDYuJ2aWws+5NgH2g3CDmMQrHBU/OZsOmiyJVvktuqC27OJxqVUX+UKyit0?=
 =?us-ascii?Q?aCpY8BC/RwXQmggijPWtED3bThqPGOHs0JQHieIwEaAT1l4FSGDxU3uUb+OD?=
 =?us-ascii?Q?QlKf/EOVyC9/LPMnUdShYtVL3k5HT0iGLD/ilq/UQNh7bS04jSpFpxm+Jlts?=
 =?us-ascii?Q?Y3MXION1BNEdP7UAoScECPj9BqnSgIimqfJJnoRIo8NYW6sn1r3uhKyKy2v2?=
 =?us-ascii?Q?Fwcu5h/XMvheZeDg5m6SG8yBCbNcY3w5gtHR7IikJY5jrI21sGGXv3jAPUDo?=
 =?us-ascii?Q?OSLTeSvedxWYS9+aQJiNIaqMbBBQO8F5N4KpevFRSbWi4t29d6p95xUmrE7n?=
 =?us-ascii?Q?vJncPVGaHzUVcfrKB1mtILjz0EbKuPI4S/RS83os4M0Qfu3Dz+7lMN6u4P7Z?=
 =?us-ascii?Q?yX7E84TDAJO/49XfGJsMzPqcf8Zbx+4N3F4NuTuLFewm5hV4uIGxbTHiay4q?=
 =?us-ascii?Q?j17ZhpTFhqwBfaBeCtAPr+dG+TOZwnjlTRVjh+emnJCiGr7dhY63LGaA4RHH?=
 =?us-ascii?Q?Mx/B6e/WCjyT+O9oRDe7aG2nA9m4kuAFxa4eZk/43xQCCRhoAeDl2RhHCBMU?=
 =?us-ascii?Q?/AEHfrcIT27ZD0OWkFBm+BPFqwXzw03lYX7zPeDUCTOGKqCI+qnftNjQIVBL?=
 =?us-ascii?Q?nKH+M8QW12LDHe+qvFn4ln3vI0HlplVy3ldbZPLfB1o6jIPfc1GLU6UigaFR?=
 =?us-ascii?Q?dU9gP+tKCSSUU7AxMmmbnHfw25C2TDcotArwHGvPcvNrWhQZRs9qxKXXW4OU?=
 =?us-ascii?Q?u9Q3kA=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fMTOeeefzkWqqi2Kk6b6q5yKiQ5pNJZVv5XWBWuA/PZrgTvhH9A5mVw7r2IKeSGVDbGpa/nnCXTJnlCjpPCGiwc73om0JbVKdTLNlJTLodxKp7jhLlIUJO0AUFqY/LjIvZjVUoh93AshniJ2UTMoQ5e2VF87wyhNJuZpwGlWaSiBmbWFTSfujC+hsTfzeA1BeE/KyFtaWQpUvzvq9dcCFCFAwgXhGQ48JZhbTSIbfgLEsGlqFNxagvef4oN2ttP1nrLx5iNqLTgBxel3tr7ahShcRUGJPHFX56wUOdPLfote6qVxdBrCGVj7uGgOUruxX4mlxxwKpadiaKfYELwaWTzxhMQXlAUX8R8RMyv3TDnBRiX6m0JBEFCeVMajwSm9aTKxQvDj8Id6YraBExEWKFXn06Zvp7/ZTpfZbUa+AbgOkcjxwhwz8U8hMy7SsV/l
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:26:09.7125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f024d866-13d3-4710-cbd7-08de6fba71d5
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2699
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


Philippe Reynes (9):
  mbedtls: enable support of ecc
  ecdsa: initial support of ecdsa using mbedtls
  test: lib: sw_ecdsa: add initial test
  drivers: crypto: add software ecdsa support
  ecdsa: fix support of secp521r1
  test: dm: ecdsa.c: clean this test as software ecdsa is now
    implemented
  configs: sandbox: enable the software ecdsa driver
  test: py: vboot: prepare integration test for ecdsa
  test: vboot: add test for ecdsa

 configs/amd_versal2_virt_defconfig            |   1 +
 configs/qemu_arm64_lwip_defconfig             |   1 +
 configs/sandbox_defconfig                     |   1 +
 configs/starfive_visionfive2_defconfig        |   1 +
 configs/xilinx_versal_net_virt_defconfig      |   1 +
 configs/xilinx_versal_virt_defconfig          |   1 +
 configs/xilinx_zynqmp_kria_defconfig          |   1 +
 configs/xilinx_zynqmp_virt_defconfig          |   1 +
 drivers/crypto/Kconfig                        |   2 +
 drivers/crypto/Makefile                       |   1 +
 drivers/crypto/ecdsa/Kconfig                  |   6 +
 drivers/crypto/ecdsa/Makefile                 |   6 +
 drivers/crypto/ecdsa/ecdsa-sw.c               |  33 ++
 include/crypto/internal/sw_ecdsa.h            |  14 +
 lib/ecdsa/ecdsa-libcrypto.c                   |  21 +-
 lib/ecdsa/ecdsa-verify.c                      |  24 +-
 lib/fdt-libcrypto.c                           |   2 +-
 lib/mbedtls/Kconfig                           |  16 +
 lib/mbedtls/Makefile                          |  19 +-
 lib/mbedtls/ecdsa.c                           |  94 ++++
 lib/mbedtls/mbedtls_def_config.h              |  18 +
 test/dm/ecdsa.c                               |  18 +-
 test/lib/Makefile                             |   1 +
 test/lib/sw_ecdsa.c                           | 465 ++++++++++++++++++
 test/py/tests/test_fit_ecdsa.py               |   2 +-
 test/py/tests/test_vboot.py                   | 128 +++--
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
 tools/image-sig-host.c                        |   2 +-
 44 files changed, 1062 insertions(+), 79 deletions(-)
 create mode 100644 drivers/crypto/ecdsa/Kconfig
 create mode 100644 drivers/crypto/ecdsa/Makefile
 create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
 create mode 100644 include/crypto/internal/sw_ecdsa.h
 create mode 100644 lib/mbedtls/ecdsa.c
 create mode 100644 test/lib/sw_ecdsa.c
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

-- 
2.43.0

