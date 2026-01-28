Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D41CD35687
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 08:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAB628426E;
	Wed, 28 Jan 2026 09:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="jaSX08YE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DA0984285; Wed, 28 Jan 2026 09:05:30 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98FC583B87
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuK7Vmvi/FUX0EmuFvZkbIeitP3jUCRGo9zkXWn21v89Kj4Kgs3Jq1hQJZk2Tr+PW1vM1OXzqcdLIJe0e4zy3gm+mB2x2eo2gTI2rg59xholhQDZyFnl4CMgMRfpURzjeAFIhuIzKWqVa8EB8w4bZdIwmBj+NBw2aKZuJckz7Hp8+W8qqGHuNIyp91glCc3pEiJqdcjXO50mLz/8vwwSjS7liR5y1msvCbpMUQMhYo3pfugeafYAkB7Ykhrl3vNWOcIMRkbM0gaedgv+RKoY/HXN5dpx2waWJ+MQ+1W5cgdyg8QW6YQm1NWbZBIknDsJhVyFTifRvQ6yh1eyTn1vhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGikZuNaF0vXNR/5GSE7JGbjlKZ/mu+KFqRNaes6AQQ=;
 b=hQgMiPGVFq6jiJw1GKMpHFAE00zg17k1dMr8A8HN1tB6s1k9swh6ShP/fRO97vexoNmXefCVWIZsGJFpeGnSqQzqVuK7D6Ldre9IKePWBafUw9z8PEQ+y+ZER93/+hQTa5Da6mZJIwbgEpDxQZ9dS9uB/2d7PrPMfevWMMRFILyR9zprQt+wLjNWLBAtHXSSR3BOxLcJJRlCj12b+qdePJ3h18Xb/hlWPbp0rOUvf5A3nwwDfP/j+qN1E2f0GyLWMCvAgx4G4h4mZv6WzbdEdsCuypuMIVOZhJhebwA8DE5HxT9HXcGvqbZgMngw4XgfE/sC3F/1PIiyD968qZZKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGikZuNaF0vXNR/5GSE7JGbjlKZ/mu+KFqRNaes6AQQ=;
 b=jaSX08YEdm793Vt0klP4KFW7CNVhyQA/vLIOEoRU3BhjhAJiqyoSgab8DQxo7wc1JVn1gREibiRnd1v7iIYUHGIQt98ZvRoLnfX5AzeTGibvh4DMaaLlNihs1XpCtV7k00H0b/qDbVVbn18f+aODPr5LCI6NYD7Cc4PSRmLH5+7j5Ao1yhGAknq6LuNOnicFXEqJIexpyPl6V8Y8JLwgt9Kt7pxuvsSvXhGbsCHdSvx2j2hxq8Goyo1BAsDFG279szs+cpAD+ra9BzqBHiAl0uktfB+N4FvOjAWz8iBAGTSEudBn9U0FfNxeS+sFZCZZY1G9XnDAtVawwvYrvUzS7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DU4PR03MB10912.eurprd03.prod.outlook.com (2603:10a6:10:581::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 08:05:25 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 08:05:25 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v5 0/6] UEFI Capsule - PKCS11 Support
Date: Wed, 28 Jan 2026 09:05:07 +0100
Message-ID: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0001.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::9) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DU4PR03MB10912:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c811db5-0bf4-4f5e-60a5-08de5e43fe13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|7142099003|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xasydEm+tPTaQfQIOSLLWeXjGLrdPfg3VLpNqTZaA1jZrqmhT+GOwFUebU2k?=
 =?us-ascii?Q?FA9yN39FQWaLm7hOdH+QjcS6LcwhmpSu7T9KGgVrztYAERCoWAGnjqsAg0z8?=
 =?us-ascii?Q?LAp9jvB/Q1u+RX5jA+HWFLL8Z3JAyEmJFl4A8urNJuzYeAhNk/tLSn0FUZrf?=
 =?us-ascii?Q?3IFYmcD8pYUiBTeExIFqPrYN9xMKHb03Po2UtoHwlxXKORw07iWArqiahiVv?=
 =?us-ascii?Q?NBNmEIuMNMVKfP6p0XbiKcXBTO+FKfx1MLSwaQriyiino8rRTnCMEm9iNcUf?=
 =?us-ascii?Q?AbF38Qo/KTK//N8Zl3Wq2KVq/5F1XMERGjdX30kHtYs/zDWWdLL3HNY3uIIk?=
 =?us-ascii?Q?PfP91VvW0Hd33dr6UFOC+1XiG5dBopN5MyHvJY+/t3ltRvanUeVlvc/3E+Sm?=
 =?us-ascii?Q?kIRxwyzVeUQ9Z5OjkfwJ9cnPz+w3CLh5nhSiA4jcuNDufacME3ALTCzLitDo?=
 =?us-ascii?Q?c4aCY2oWCnAhcYKbtlfg03pERlp66ChyjpvLmSNlfvqmOjUtUGagdu/5xfI6?=
 =?us-ascii?Q?yrZbvxz+Qavj/BRGMQawQiofFEB4VEpMiTtJuyfneGi5iic8T1Syx4osZXYm?=
 =?us-ascii?Q?3V5i0tXk2LpaLoPhT8LfE7rjHFWgPSl5b+33EyGmmk4n6I+baf9xQwbFvCdi?=
 =?us-ascii?Q?JdwEkzlAC0+PDu4yxu7mIExiaSS3g+dLi0Ir3PL8UCCKd6zDIx92e0d8wlo2?=
 =?us-ascii?Q?hjaq+cakarQQyXcwCNEk8neNFB/cAJ1TVswV8cxNg/DzHpm7kx02qiZjiSVZ?=
 =?us-ascii?Q?46kU3P8AGKmiQVfMMlzANjQHu8fTbySXjfROtVsxupcUXqI2vV8ApIt6UbFy?=
 =?us-ascii?Q?Nt5C74TWKvBuo/18Z3pOPp8OXqY9VR+rWpQHPzoOWG2F/E9vkey/t7PptEyV?=
 =?us-ascii?Q?KrymXbf9YestIndmS+gzxZt6TFEOrjVLKIJmmUlwHMx3c5roe3il59ZTcFFV?=
 =?us-ascii?Q?fIKlyFlTzs0A6gytrqASZsamOHeB2yIaCACgbDMlCUQteXWKYj91o2i0gzx+?=
 =?us-ascii?Q?CYxkwi7tmXrOW1zvCsb5oL6vWo6lRb+fbBEVn47YnVJc7bW69HEymGcg+2Ps?=
 =?us-ascii?Q?mWftygPINbopzRLcjbtr2FSSj+efqqxZ1Til2DISYjo6tj7awUwx6bSgDUqT?=
 =?us-ascii?Q?FNfaleZcJhpVJslI9y/Pumam8o9vScLO2uz2i00ape/frLB0bNbeMhGFmrki?=
 =?us-ascii?Q?zQivpi8VODRc49QSB2vl07k0EwHpDNiFySn7OQA6XWZOUN3yTcsV4RSx7q2l?=
 =?us-ascii?Q?d9FjrwTwGOrhJD/cCbYVOJSjlRC/SHdRuKKSSZa0QbG3WGJAZdnKCLo+3TPX?=
 =?us-ascii?Q?TpO0fDhRfno/xVjM5wr+PXovnitjZVdX2xSpjqVDb014Fpr0j9BBbeUtZC6N?=
 =?us-ascii?Q?76SWZGaa/89Yjfnh3UUxy6qhbp8LC17WM8qmOwcczgjxX/pCs8QE9MhBBlmC?=
 =?us-ascii?Q?aInkdRsCQfBY5h+Jaq22hKH2RT1aI+LNJ79XYJSfDYhGHCRb5Fl9Np5WJRRf?=
 =?us-ascii?Q?b2U9JBKgSZpbJ4c/JKHEHE4wgQpX5kIZj8hbp2UJdSM4lNuJsL/v6rDYwsUD?=
 =?us-ascii?Q?cW888efM5JOvn4varXkDMbR0/+tcgOQy/W4UGKVpS7jpqB6Yq3mQovYTVCCl?=
 =?us-ascii?Q?ovwEz5jFqsDoE3owbgFSVIY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7142099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mxue9meWM2CqYQVZahDh7s89l9QXrB/H5zU/WTVzM7BGCA5mVoewez+NgiBS?=
 =?us-ascii?Q?tnFvYcW/BGe1EjsERSuAmK7KaEl8+3I/mgMj83gHNiKKC5kgOnp1HZILaD2v?=
 =?us-ascii?Q?fFgAUvtBSaO1/47pR8CPdz+yGF7umqdn2L7UoMXvhWVKQLYoNZQ3BS22Q4VH?=
 =?us-ascii?Q?oMfnyl6o8s3Ard6OYtNDsT3hfzzutYd928qdF57jjl1j9M0Yk0WIp0iMhwja?=
 =?us-ascii?Q?4o9/yg+qJ/8UJAa9WOl6vPg1bhrzpzSsBW4FZlNUxp+SEcFmU/18fW5wcnhP?=
 =?us-ascii?Q?AwIRJj/SeojCj8X94sLn+vsuHmqaDQByeEX2UpUsII5rtMRE0wTppTFvASR9?=
 =?us-ascii?Q?Q9UemjuFgAvSUJMjv6NnPbRyUDIBy79XxVzLb8OWHx/Tk9Wn2Yid2ERuo+na?=
 =?us-ascii?Q?GWgkmyU1po/P17jb5HM4VKHr/DAE8PsJf6IljTEP3YCaFJb70FaCbMpaeLV2?=
 =?us-ascii?Q?4ciCvJ42f6FYvS6+ap7TcZ4FFUxTXuCUzPF5SWCKEpPHQ9dkvXd9f/JCOAyb?=
 =?us-ascii?Q?TFlHMS7FGCzIq+oeh0A2bkk9hY7MHQHdeWXZGT5Wz7NK3EenaOFIh3HYYyIj?=
 =?us-ascii?Q?7rOB9I8az1STN3mzT7/nGqefks1D1yJRgLqLRATAMjys5OtL+VZhdgTSV06b?=
 =?us-ascii?Q?RcBvH7uHgDMeyCVB8XvqhQsKpp/tEJB36YA3Hvtxszf0EpqgKn/Q0BM/Jtgl?=
 =?us-ascii?Q?JbHfukUWECbOuYuYPeg8mSNOIMq4xZjEGfL3vGQc3s10kK6sa+4kJvHqMiuv?=
 =?us-ascii?Q?5VXUtAPhyOBNM63atT8wjIlfoSquOhuucl2gobkQ0dYtY3gyXfM+0HzPDTqZ?=
 =?us-ascii?Q?7dCwljR2/d6jiGtwC8+mJMJlyi5MM1SExbMwDibI6xvBPW5f/7y4OHkL38sT?=
 =?us-ascii?Q?W0x53INhRXweXDZNIxEFPUGdXwQVBBsAaip/ojQiYgBBKQ8bPgBJkSslijAf?=
 =?us-ascii?Q?fjYMA+2qWlntNvIw+kScsEXvTnPj4M1WrnaC6KNaaGZh9MphyNMAnfLu7Me6?=
 =?us-ascii?Q?aRGSfKR2xcMLbQmi6Tt/GVH+RfZccO6djS4CA2XS+LaIqZxMxhwOzwkoO6n8?=
 =?us-ascii?Q?mR5DKdWk+t7XOGf1IjeyB13bSL4znmY4axiI/fVvBFm2Z5FHzTx3aUVmplMp?=
 =?us-ascii?Q?7Ly/NZLJJ8i0sUQbVHuvefq5WsAB/1QkYdp1nAWE9mZL28ehhSj4ohMkpX8k?=
 =?us-ascii?Q?48O138/5k3kjw9RJP39l+3mVl6FTtu9MqfHZBRyOHJQwXXIziQ3Z7EQ237MU?=
 =?us-ascii?Q?BMIUNLKx/L3wIfhblBm2Az+dPWwQYAMh4q3wpFp1uTVBaUXpIuoBj2Uju8DE?=
 =?us-ascii?Q?3fDPc6Wwlhb6i2miRDLEIFhBEzK+7BUboJHJLeikFhyeNTwZ0w+PW0dgDo7q?=
 =?us-ascii?Q?qxra1qzJkICAPQrGFTJcKDn/xFR0Z/ByFaVS/jZH47pYVV/Z6cNNfrqJJgRj?=
 =?us-ascii?Q?wH7mZbr4EHYqZ1YD7yEzZYPtrpN+quyZDWYFq1tKcT33lV+rrk+Eo+qqQGV+?=
 =?us-ascii?Q?u2BLB8qNyaXHXFIw3z4p+QLkZ2K6lsoY0qlQ/3bfybmEjnTEuOMliUixpmUr?=
 =?us-ascii?Q?uKcMTbS8J/GE7IktnBQi263TrHB7+25UI9w8PlTk9F3lmIQyJEfahfyfEpYF?=
 =?us-ascii?Q?p6tqwXOM6hnE1FvHlb21xn9iGN1hgizqnjjyxd2mo4Co8Cn2NtjwuejXWe6a?=
 =?us-ascii?Q?LCP4jGT11P7CZtZpFTv9cfr/Xe9F3ET4r8vBDsS44VHG+yk9Qk+LejPzlFxo?=
 =?us-ascii?Q?CE6nY4FT/g=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c811db5-0bf4-4f5e-60a5-08de5e43fe13
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 08:05:25.3098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fpnCVRQROtgLlpqbDuxe2ZVg3Tj8/UF3fQ10fZEsFwgm3TqGLDR678gTaP07rfg1dhwjYTz4rdFf4Wtpu5Z6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR03MB10912
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

Add support for pkcs11 URI's when generating UEFI capsules and
accept URI's for certificate in dts capsule nodes.
Example:
export PKCS11_MODULE_PATH=<pkcs11 provider path>/libsofthsm2.so
tools/mkeficapsule --monotonic-count 1 \
 --private-key "pkcs11:token=EX;object=capsule;type=private;pin-source=pin.txt" \
 --certificate "pkcs11:token=EX;object=capsule;type=cert;pin-source=pin.txt" \
 --index 1 \
 --guid XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX \
 "capsule-payload" \
 "capsule.cap
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
Changes in v5:
* add bin wrappers in test for all external tools
* improve error handling in python test
* fix data types in python
* standardize option name in mkeficapsule
* fix typos
Changes in v4:
* adapt mkeficapsule python support to dump detached signature
  for authenticated capsules
* verify detached capsule signature with openssl after generation
* use p11-kit to figure out location of softhsm2 library
* fix missing long option for dumping signatures in mkeficapsule
Changes in v3:
* fix write file encoding, env setting and extra line in binman test
  after review
Changes in v2:
* allow mixed file/pkcs11 URI as key specification in mkeficapsule
* fix logic for accepting pkcs11 URI in binman device tree sections
* add binman test for UEFI capsule signature where private key comes
  from softHSM
---
Wojciech Dubowik (6):
  tools: mkeficapsule: Add support for pkcs11
  binman: Accept pkcs11 URI tokens for capsule updates
  tools: mkeficapsule: Fix dump signature long option
  binman: Add dump signature option to mkeficapsule
  binman: DTS: Add dump-signature option for capsules
  test: binman: Add test for pkcs11 signed capsule

 doc/mkeficapsule.1                            |   4 +-
 tools/binman/btool/mkeficapsule.py            |   8 +-
 tools/binman/btool/p11_kit.py                 |  21 ++++
 tools/binman/entries.rst                      |   4 +
 tools/binman/etype/efi_capsule.py             |  17 ++-
 tools/binman/ftest.py                         |  66 ++++++++++
 .../binman/test/351_capsule_signed_pkcs11.dts |  22 ++++
 tools/mkeficapsule.c                          | 113 +++++++++++++-----
 8 files changed, 221 insertions(+), 34 deletions(-)
 create mode 100644 tools/binman/btool/p11_kit.py
 create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts

-- 
2.47.3

