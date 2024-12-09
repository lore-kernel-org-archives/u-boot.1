Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA95E77173
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 09:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE38089624;
	Mon,  9 Dec 2024 10:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="q8odIRhn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 999558961E; Mon,  9 Dec 2024 10:42:07 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A253389367
 for <u-boot+nodisclaimer@lists.denx.de>; Mon,  9 Dec 2024 10:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXwt5eVtHUJ6U+1P5i1lYat7v60+eacDJZJ2TC83dkLfsF++JODRXKwdrRRWr4QfBMjymk6xWoU+4RqPaczRXlEkarHF6cL9ndpLG39UWKHLbOFtQzUm82jXrAFwcq04DHZn6y2IEmLZySD6s+OjjMWGq/aqkIxBy/yh8tF7rJhYguHPqUMxYcPChVxnUYvxbfbXdHRpiBdwPEyi2/SiTJHRCEaqGw44pxjlnZB3Tew27ki5fwx2VoRmDc2afNHLw6P/kKdkUyGAGkZ3aHVRYNfLgE5xeuocdVXPH1K0CTzCGPYzq4a2KkxOqXZGGPHzBgasQx5SVz+6ZD4OmdAwJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPRsao+PwRNAFOr1W/h3hwdswumkTQZ8oI8UDV/gJWw=;
 b=wcOdBzUSjTGhUbeHLZaKA9cNANz97I5VmmvM4OuobQvq3i5yhEhwQo34ObHVigpCKBvqgCx2ehT++0JyxLdl2n0820oU6kFPGXqrukqogT7gAMArHTLPbGjjxHifD7SQr6/RXJ681KriDHWiKxRJ1Qbu7u6uuvNLArG4WL+6+i0uqZIzvopqneYziQ6YgdEX0yUsvs+ar10gL1qn2bUQLmtDOs+PSUfHhs22vMSY+nHfJPh4gGSbEy4aaMJMopmlrTHzMZ/JiiY4s0c/H1bFPttaaE71Heg7O6X6t+URL66eJNhWhU6xAsPWO9O3VCeTZ5zNo7AxtcQGAcs/kneLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPRsao+PwRNAFOr1W/h3hwdswumkTQZ8oI8UDV/gJWw=;
 b=q8odIRhn33GGVBL6D9giqSMKK4NHfxMnsA/Mgxg0wGzzPL4koOscOH+clX0Fg72ryH7LObmcAxa7GxyUEwcKmuSs3E/euclvI1aYf+6UI+35gqn6CnEZx7qQ2zAv6rlmzTPB/51cMjsSI1dcerLTSuSPxy+UcpnU0haWUbbDskB0Egna9C2Yy7Rkke1WaUGlElTO3/5914X0pYvZ60CvkwT+6NOObaedQV9YGKpiUoSlsBBNIDuYK49DsylT15OYejtQsfcwJpIc1Q6mpZWSlfhTWrH9DNq8IalEFPxnA1UyhvB3g8LeWl4SlXmcQwvDZVOzsstGBgf1JGy1/x1kyg==
Received: from GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2b::23)
 by MR1PPFF7C90AD46.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::2e2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:42:01 +0000
Received: from PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:2b:cafe::b3) by GV0P278CA0090.outlook.office365.com
 (2603:10a6:710:2b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Mon,
 9 Dec 2024 09:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019230.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Mon, 9 Dec 2024 09:42:01 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 3CCC51FD5E;
 Mon,  9 Dec 2024 10:42:01 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: raymond.mao+nodisclaimer@linaro.org,
	sjg+nodisclaimer@chromium.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 0/5] add the support of sha256_hmac and sha256_hkdf
Date: Mon,  9 Dec 2024 10:41:54 +0100
Message-Id: <20241209094159.8355-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019230:EE_|MR1PPFF7C90AD46:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3d96200f-c6c0-47c9-867a-08dd1835bb79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lulrux9LI3tR8zXuUxp/Me6cfn2+7LoOsfvLe6saK5I+zjSLQgvVdxH2Vd7k?=
 =?us-ascii?Q?eyPterDhgEIASlcj8FjW2rqMm1CpF1NIeZ9psbMFkgVLilVhpSiHNWSQJL51?=
 =?us-ascii?Q?p3UtcmAobx4lwJXK4+PVCKzEnrs61FLjZ45eBW1652DJLYcqh0kSIoKOSOMW?=
 =?us-ascii?Q?zgdiBKYKUR8XhridvNuz/bbJrI8/bTUlzdT/HyzcoSMhRSXrvPYDpW0cJxKc?=
 =?us-ascii?Q?q95oOjTe3b0A2jF9N7EN91Dm1i+wYY4i71pOvhwaIKwPjCgOBRjBVFfSz6mD?=
 =?us-ascii?Q?Hnu3eBwvzZ0dAuxVzgFXWMfKzoUsXxvE0na+bF3KdkVwdrQTriddnUqL/9Wu?=
 =?us-ascii?Q?2foVR/R/bDgUbpPezkA/BLew0ymIQurbWBvX9TuCczm3JfwDKDim6nm2lbDQ?=
 =?us-ascii?Q?Pqph6abcXoukqaZ9iXI+AduBOsRasrX8TAwaWs/mE/Ig9KivbnTQKBEckbqa?=
 =?us-ascii?Q?SRN/Zo2PTKTXHbr1RKgGxcUX9F3ppwmCBHLzyS+mDKDUPRuppQGEC5GLpKt8?=
 =?us-ascii?Q?yPXG8Ayw821PtLFbCU35s8Nwm5UtzjGoeeXcJRLhbbVy01jawcuCRhA6BxUU?=
 =?us-ascii?Q?woB7BkJ9vOdciJUeCXfgFq9lD7Fi1KisuuSaEoQVOO3s2BXnlur1yG6G/qbO?=
 =?us-ascii?Q?m04BfTjG46zVfTLJ0gpbAtuP0xtcClk5eM30eIiyCQlASQCOkmkz2XvygIuA?=
 =?us-ascii?Q?8I1N/cwrZzeiVmlNfiI0F4X7dZjjmhwBn6CGRQaWSdifMiy/EfcB80Nbu9ol?=
 =?us-ascii?Q?6isSmnVug+8vHjb28tQbl2n7YvDAQyjugeqW7GRWXjVtXL1pJoJetLr0mUSW?=
 =?us-ascii?Q?fXXQcMIXZjTdeaCATjLJja1YVXubyAP/PzZLpYOwcwjoE7DkRBNci1RXCycX?=
 =?us-ascii?Q?ECkkhdP4ty1+TOFBwwL9KZIcc8OBZOzI4v4SP4Qn8m6G6dMw2UMFZAYFzsTt?=
 =?us-ascii?Q?yrnhY1myOfweB+zgkyZ0qON0Stk4Z2YmkxgpUyjttAZOxx8XXjGbEbAriCjB?=
 =?us-ascii?Q?tmV8XN1Aek4NQeO1RiB3UcVSZG44yhkk++B5bTxiZgOPVDEnlwsUFJ31KwDd?=
 =?us-ascii?Q?EvvLluTHMMzqMtwumvRZTXDaah4HMejl1GlGhGucnLjYLwHsZnzqF92rLydp?=
 =?us-ascii?Q?zkq9cefjYa3JfyMWxydm4yrlEHV2Exwr0/W0urn3Q0RsIMpM2UKVwdv69Wr3?=
 =?us-ascii?Q?odabd3ydHU8Zl0THiIEX6XnOyd/8MZDuxXqcwrlwrP+6mGeQ4Issm2wZOTp+?=
 =?us-ascii?Q?tDVMesbIu8FhncPiGf4DG4PgXGFZK4EOF76LaskOkLzbhTiM3sSQlIfYcy2Y?=
 =?us-ascii?Q?rZhBTi+ibbWOzdsJLgOKV3gBebg3fXmWxdW7v/KEzFQpjfqBfYATtcZbpbwA?=
 =?us-ascii?Q?uKPym7IjsiL8NW+6FytPGqnLek1ys5WGXq7XPeH2LEQpF2iF76/yqQdUxK1I?=
 =?us-ascii?Q?N5rwGqhHowUs+FCI3tZ/GeLf6wq3CLzg?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:42:01.3802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d96200f-c6c0-47c9-867a-08dd1835bb79
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPFF7C90AD46
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

v3:
- also define sha256_hmac for legacy sha256
- add some #if to define function only when needed

Philippe Reynes (5):
  mbedtls: enable support of hkdf
  lib: sha256: add feature sha256_hmac
  test: lib: add test for sha256_hmac
  lib: mbedtls: sha256: add support of key derivation
  test: lib: add test for key derivation

 include/u-boot/sha256.h          |  11 ++++
 lib/mbedtls/Kconfig              |  14 ++++
 lib/mbedtls/Makefile             |   2 +
 lib/mbedtls/mbedtls_def_config.h |   4 ++
 lib/mbedtls/sha256.c             |  60 +++++++++++++++++
 lib/sha256.c                     |  37 +++++++++++
 test/lib/Makefile                |   2 +
 test/lib/test_sha256_hkdf.c      | 104 +++++++++++++++++++++++++++++
 test/lib/test_sha256_hmac.c      | 108 +++++++++++++++++++++++++++++++
 9 files changed, 342 insertions(+)
 create mode 100644 test/lib/test_sha256_hkdf.c
 create mode 100644 test/lib/test_sha256_hmac.c

-- 
2.25.1

