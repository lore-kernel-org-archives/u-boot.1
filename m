Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F88BE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D1E80288;
	Thu, 12 Dec 2024 14:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="XGyGtSVp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 617B080212; Thu, 12 Dec 2024 14:37:20 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68C9180217
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 12 Dec 2024 14:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M43cEYKjkHstMwXjXeQZQBTRRSdBgNB51efRS2ynQpOgTwobPCCzxG+b8IEeYzbw5sneOJuORIrW+zhHWUOinSgiVmnKnDJi6EwPR8sfhNXvZ21Fg8HTo0yadi9YPqrBCELfwjtUi3VQn+/AXO1CmdG4sGSqdWiqdS11bw5b/TaWEn4fNcVDltGCsO7HNnDdykOT/vKQM0F+lAjHxRlwfKsCh9jINeqLingT0rIlGvtidebynL3C2gdBgGrMtwWeLJ0NbN0lH+tjyp1vL2UUnnwfxHFhBtDn1qXBnTfixePSLOj49sWl8S83YihqigMFMtSzVRfW/6BfNLZg+g9IAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXjkqBs6jfmcldrLiYVxrCW2rGB1qbtSBrzK8DTNYug=;
 b=pRrvtaWTcwTS4CYQWYyDtli9pm11PZMUEUY9sQ9d+QqjkR0aAuKpd/HdB6ZJmN2kb+DUpOgi8/wG7zI/HlkWjk+tfibHJ0U3477RM46UTDAii6jrM0/O608t1N2D+wLKzhMymOgvSMvaiXYhHpflTvku9NF4ZHb4Igpq2S53BOVhS+OGx43QFMeMEauTDcHMiRbID0zuUF/kYDxKorlf8PPMgk0dAKDHniHBB+j8nMv8z/0d3+zKveAanrcWfhm0UZxbxkUsPyGOhR72wO9pROoTUPdx5ZA5fU13B8IIOZQNBJsAh9p1LAmouBv+VEOPxaqO6cKvg5XuMPKgDUEIOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXjkqBs6jfmcldrLiYVxrCW2rGB1qbtSBrzK8DTNYug=;
 b=XGyGtSVpGHqLt56Y6Ozdaq79Y+gffIa1cpPIJPD7Vp5KiONWudqagTYSDLuFXzo9z+JGKI2kJCOF0XuUlU+nJr+8DXgJJFZyVjRuex4F0MPEtH7mhmdJasuLnvZZqrFiPTw/lgPq1gEC5WodSdnWpW0i/WZykYP0/1dAYZ5UQ0JXma0rkcEiLO8R6qUoF8aPRjd3sl6QDW3zZ/u/dh7HOCnzaNkBgJb87Po+5FKzWlt0gUCBGh+rC6NyCOOQrWHJ79ml3zp1MPGz+V7JIWbbm7PGoOwn8DuOVnUYWNsxtfqd0s4apcBOk0AeuLn8C0nmIH51uf7BmTtJPV+yuCSzTw==
Received: from PA7P264CA0038.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34b::14)
 by PR1P264MB3480.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:142::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 13:37:13 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b:cafe::9a) by PA7P264CA0038.outlook.office365.com
 (2603:10a6:102:34b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 13:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 12 Dec 2024 13:37:13 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 08B1D1FE96;
 Thu, 12 Dec 2024 14:37:13 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 0/8] add the support of sha256_hmac and sha256_hkdf
Date: Thu, 12 Dec 2024 14:37:02 +0100
Message-Id: <20241212133710.172404-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|PR1P264MB3480:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c8ef5538-5b8b-4387-aa30-08dd1ab21600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bF2ToUCpRwBgODKex3tQvoxmKobhhU7w7hP4TZn2HZ+bmt9GMeCHQUF5bOF1?=
 =?us-ascii?Q?J8qJt2mHOFyYLR+Al8pYFys4QA7Bha6cdteQVojtJPDXsOKpQ8kS2v/YZUHV?=
 =?us-ascii?Q?jJOjz/Q65NLFWJhB2DwLT8G4GOoCJ8A65CfBRPsdvPW6VURXGQSPrp0ZjwdH?=
 =?us-ascii?Q?OBlPRll6qux3Kw8Kbpm5zFNA5xXJMv+ZtzuQekZUGoFuiOVNS0VEusVJKNay?=
 =?us-ascii?Q?3Gh7h4/bW0Us6Z8y7Aje5dHvxcLW7VwMpFpklMAe3Ypf3U1lSH89CAXJ4Ih/?=
 =?us-ascii?Q?TqUsC7OBR55jCCgvInr6idFzXP5VjalZIbMqyYQ2jGzcuNOTO4NpIDRLXEtY?=
 =?us-ascii?Q?k+odCvpQAsgruDMyPDuvv01gY+jnH924EZnZ/zy2MmtnRfz0oLrjmZtSnXTY?=
 =?us-ascii?Q?NFiZ2Lr0aSIQHdHozAyYOWIthoQpaWq/ZIugtqG21hUJ9EfPXNqOip4kSoyt?=
 =?us-ascii?Q?IjUrw3KdgX/WlWzzkiyeN3EMThBBu0He2xeZYbBLHLy722Vmg7PZ4imncinx?=
 =?us-ascii?Q?t7OMRVhQ8uQzAnPCTSiybsoSicZS4sScvwpasj/220iQDTkCysZEGFYeEnIB?=
 =?us-ascii?Q?4exm1ThZTmEZooojqXewSRYIzyE75TurPJtHKHfufL8lVThCxLkr31/CWsDm?=
 =?us-ascii?Q?rqGUUsnhpZGhNU9LbzoHgXeSW9fXOkETWX0aLGK1lRk0sW7UTAeWrEgvpGso?=
 =?us-ascii?Q?W8IOEwF96Im36KXiDP82FQ372qifbiqoDRHMNE5eK3H2oVgebIx4IOW6+fuo?=
 =?us-ascii?Q?bvsecJyGktfbQAm8u7hJUShNotjGKkwhhw12s5SslehiVS/2fBQPJVC0PgTb?=
 =?us-ascii?Q?xrB7rz+q8M7lQ7KQyMnMEOndqVEDLH4lKGtHNFl++6JLiVPArZlLF5VluDN5?=
 =?us-ascii?Q?MA5hRwYoLuBw+0dxsgMnY6oHQwPHzVo2tawaQ0UYphx09bndomO7ppcca38e?=
 =?us-ascii?Q?VjmCe5WN0PDThZLBbYmuN4YedCIHykaN34IpL8AX4RHzTNFxZ+g9hzZuDC7E?=
 =?us-ascii?Q?o26AqMO2qHgXupfLXj0WU3frEFdmUHb6ZMaJMOUizv5aBMV+8d00UB0gSYIY?=
 =?us-ascii?Q?N1S5Zz4G2Fq93SqnAo7InRBVYVw8Lka05RfDTpm/GYT6N4nKIo2/XHrJeHNR?=
 =?us-ascii?Q?GK4VeF3s+aUFKzwJ+4X128dYjG4usYLnVVzprz2w/4QKc/twwcV/0xCogmaC?=
 =?us-ascii?Q?/KjIPE7WGWgms4fYRK6dja1vdQUeIuhurXbOduOk9Ass5XfZp2k0DeibJZq/?=
 =?us-ascii?Q?SSXpi7UHSVf4yfyuuW8e8ikYMjDwUWoBy2RLFx3H6OEcWLCfbLE+FWUGIoyN?=
 =?us-ascii?Q?W18lw50iEzKgKuIdTkwe3RwiA2yeY/VftdZy1Lt07jYLluCkdEFKwhyP8t4I?=
 =?us-ascii?Q?bH5tSHUeIPnTKwaM0GOIMBeqrEQMPX8ycuY4ZH5085eF4P+KC6nmGDohUUDB?=
 =?us-ascii?Q?zZxZnPGiYXGDHqbpvtOmoTArGi9CshKE?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 13:37:13.1652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ef5538-5b8b-4387-aa30-08dd1ab21600
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3480
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

This serie adds the support of sha256_hmac and sha256_hkdf.
A first version was sent several months ago just before the 
integration of mbedtls. This new version is based on mbedtls.

The first patch of this serie add the support of hkdf
using mbedtls.

v4:
- fix computation of the hmac
- add more test for hmac
- move sha256 common functions to sha256_common.c
- some cleanup

v3:
- also define sha256_hmac for legacy sha256
- add some #if to define function only when needed

Philippe Reynes (8):
  tools: kwbimage.h: use linux/compiler_attributes.h
  tools: renesas_spkgimage.h: use linux/compiler_attributes.h
  mbedtls: enable support of hkdf
  lib: sha256: move common function to sha256_common.c
  lib: sha256: add feature sha256_hmac
  test: lib: add test for sha256_hmac
  lib: mbedtls: sha256: add support of key derivation
  test: lib: add test for key derivation

 include/u-boot/sha256.h          |  24 +++
 lib/Makefile                     |   1 +
 lib/mbedtls/Kconfig              |  14 ++
 lib/mbedtls/Makefile             |   2 +
 lib/mbedtls/mbedtls_def_config.h |   4 +
 lib/mbedtls/sha256.c             |  43 ++---
 lib/sha256.c                     |  36 ----
 lib/sha256_common.c              |  98 ++++++++++
 test/lib/Makefile                |   2 +
 test/lib/test_sha256_hkdf.c      | 107 +++++++++++
 test/lib/test_sha256_hmac.c      | 296 +++++++++++++++++++++++++++++++
 tools/Makefile                   |   1 +
 tools/kwbimage.h                 |   6 +-
 tools/renesas_spkgimage.h        |   6 +-
 14 files changed, 570 insertions(+), 70 deletions(-)
 create mode 100644 lib/sha256_common.c
 create mode 100644 test/lib/test_sha256_hkdf.c
 create mode 100644 test/lib/test_sha256_hmac.c

-- 
2.25.1

