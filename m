Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C88C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 07:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8504F888C1;
	Wed, 24 Jul 2024 09:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=weidmueller.com header.i=@weidmueller.com header.b="km1Cb/jz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CBB588896; Wed, 24 Jul 2024 09:35:13 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 055B488881
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 09:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxmJSPHoxOJ0FXWH8m5H2uKIlxSw9FsWvl/W8An05WIhP/5W+t7I6yxoJ+tdJPGBmYdDXn7D0GPtDwmz0eW5u+rMrUdma7CZsNmdiaiyR7t+4cuJEoRAQDGr3a7j6sgpOwl/Q1yvMa8Jsf/xvVDLZbNVtcmeq8oXPZxhO7aKOc3lSUPn5cb1Sdpk7c8CKwpBLjTEUhACJ6QkRsisORDOP9nLxqsp+aRa8IoW270FeIRD5OhZYbEMeTQ6ifyhX2LrKxPDAtVDuui4fm703RZ+qGsqrslMNDaCbL6P6Icb+M+3YrRsm7m/I/mYUN5B4UjTfcIHG78GNi+N/pNMkM/zyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNxj7TOorSxVvrTSjvTJ+JxcCPAFz20H4dqnh9fh8Lk=;
 b=X8SH5uwvkLcoP13LZ3MqizRcnLIvqEmPuIJ05UN7OganrgS0E1M9CZeV7HyGd1BBhu3EKYLgi7Dxxiajz02sYDIB8Xewh31qUX5k1zTUgedaHwI+Kl+1ssjWTub2REjVvcvkMVvzK5NxQalW3QQk5ZmwqAzYn7OFC0KqkfmJMFVcgLAw/h43UCg5wktHB7f3iNj72AUMbYbig0jogEVjFiJfV/cRw/vaK98cGuohzfgYOdIbE9Uzcrt0fl09pALFdAgtDRA81gPS3t0am1T2hiV3+M/cBErfoF6ENIlP4SeBYyKd6tKWDZkV/pYHkaJiRR/Z5PBKt9uMZ/9XOxEoqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNxj7TOorSxVvrTSjvTJ+JxcCPAFz20H4dqnh9fh8Lk=;
 b=km1Cb/jzeF9htAXY1fAtyo7mgqrVQJxGWQENqjMkr0s7HLCu5/UiLOsDlkMT2DOdq+Q9z+C3XRVtbsOoR6LD6Y78eYfpH8nzQQnB0zecirC+eS3vV7yUK+ixSAwVCxrW1E6YBNf6Tnbvg21KugULBV3goyDV5WlIwKV65UwwyNTPCS2Z0FiVdj0QHel1bwXZ3+V73ZGQFsubGOLRgUFNn1EYwrMEPjO2J9NaroHtEkooaKXYcSLS//MgiXt71pgQp3PJhKzRMJ9PPEFCt4MbOXAEdu8ADKIXE6TO+EBuPok05iNs1kHi0nKTLTbMGy2e3A77gGXFizNHG5vOTjm4xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GV2PR08MB8124.eurprd08.prod.outlook.com (2603:10a6:150:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 07:34:58 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%4]) with mapi id 15.20.7762.030; Wed, 24 Jul 2024
 07:34:57 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/1] tpm: fix uninitalized field access
Date: Wed, 24 Jul 2024 09:34:46 +0200
Message-Id: <20240724073448.710197-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::17) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GV2PR08MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 897bf6f7-dbf4-4140-8a4b-08dcabb31e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+RGJkCbtGtDsu8pGeLc5/fYVte0BcMiQ/CCUbtTUhpfNjZRNAOpjWddlywkp?=
 =?us-ascii?Q?642PBOX9ULbAASmtQbCBCjVk3LEqMaQv8SDWQc1wjKiizLSVkw/i47sNzHH8?=
 =?us-ascii?Q?McbHTHLL0vBgkeGj0E3RUmNIvKEBPjo0rrrIPWNqwYLsbtkmIwssR7V/m6Ah?=
 =?us-ascii?Q?HJs5r41DSsLpyRHa5IOpqljFEXzJaRflOXZ+CpNkq6ofmXRudMVfpBIWZNR+?=
 =?us-ascii?Q?uA9PdsaOM7GSWK5cXNdAmoEnvsangD3HZIFwgaSdOCvxwMvFCkxJ3K0xRCwU?=
 =?us-ascii?Q?RyVnIRBxFEKpKlUV8DdnjLBNpFiIFsAzatQiu6zGDNLwomq6jrFy1i1IzyQw?=
 =?us-ascii?Q?eieNhbrU3CdoOLv7apFLcowI62OonfFrMXLafd+0ruRS69dTb+WdU+Y5dHXb?=
 =?us-ascii?Q?yXBqb2Ewg/m8tqaZLKwTCfu0JfR/O1Pj+FIE6KyOnp2vngXXgyLNLapbfNlm?=
 =?us-ascii?Q?6eYCJdr0okWaGoRhi9p4GbX37JIKLq/gLfgNBJwOS1l7GHnbr3vNkfNWhvaA?=
 =?us-ascii?Q?1Whgr1FUBMiz3eJ9kDyQltts157oUelOzBbPjVuPmUvTBjGh33DNy6ffbOpa?=
 =?us-ascii?Q?Z/fGMpGwUAiAiH2y89seoawgN0Uxaoq9ckgzcZxZ0v1IwvzqTv7qlyaDTH3S?=
 =?us-ascii?Q?h10vA6Q232Zv4xi//TXguZqNt1KZdRAZXsAIW52vmGOBaqJQNKyh4S6orCc4?=
 =?us-ascii?Q?AaZVKHrhx7wwzNW4HI0MXQZ8aJCfDll9roKWDS5YD6tw+ZVneAbAzIuH6N0C?=
 =?us-ascii?Q?zKTQqY+7z+zp89PJzuf//Z75G/nj00/sa9lOZJyPWd/0vco4OF+voaJ3Yn/O?=
 =?us-ascii?Q?F/ZYOqe87T6FJMwxbXgzgnuD2FhJQLU92y0aK7bKM03K+/IDfhhexJ8qjlt+?=
 =?us-ascii?Q?skCLSt/aV9PmUyyn2pzBuwDg+tHbUneW07bF46EXagO9SvITHm69JrgqD/oT?=
 =?us-ascii?Q?cJfz6wtRDz65qcxRL+X0/2kyAzispsysQP3cDMefpMEN4Qbaemtm/A8ish0N?=
 =?us-ascii?Q?80r3jcSHv6f7n2O9mI68RtumTzsQKpxk2vGxfwd4QWFOYXwpUz8gm6wFo2Ap?=
 =?us-ascii?Q?xlaphYOFEY9zZ7WUxQ1FTBAtkaJI8bOnMB4ucwKTAN/4AZhtoV6R2br6iqw3?=
 =?us-ascii?Q?LsAOn6mbQPM0ASd+HZMVzgVwb37Lmr9fs/t+M56zdHD9yqLdDo1yQtO0i3MH?=
 =?us-ascii?Q?/gGMhCy8CMU/4fjhQoBpNme6nddRdztR/CrHl9uKCw5Aa1kLMacDaROi4yuq?=
 =?us-ascii?Q?6xJRwxqZdJYO1Iu2gkjdYkr6HSEc0f3M7vqYwepdhgdpbPGBUF/3zarSnW7q?=
 =?us-ascii?Q?KIbTemwfuXkJlEDeEGisA6AlOnPASjYd8UXNKRQocjDT6g1xuW59zo9tJfHL?=
 =?us-ascii?Q?UoDn3jwJZu1jmsMkYUGVHELS3tHtiGGhLbrLHwAIM3JG7mDo+A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jSZKLY4qf8sPMBG2luxxt5+FLjTRPu0u+wqnwVVDwuptcavcKcvoNtreTceR?=
 =?us-ascii?Q?t7LoIGU+QRzQtIMGE+ls/2ioCHGQI4amE3h8oN6VcgOvJw58RiY4qIX5mooj?=
 =?us-ascii?Q?ZjABX76gXjNgNYUvTCRnJBVGXtkUAT2Px1GiHhQBMAKEArnEwGjrJ9dYJP2H?=
 =?us-ascii?Q?scOI1GSVrA68A6gVTrfG2vBH2h+8oJgDEgS3SiKkzPPB5QD0T6Dgf3Qeb591?=
 =?us-ascii?Q?1zk/QIi7vdsE33dZtzpSoPN0dzUP0zRTWSb89KK5L/diViefP0BfqjgvYetz?=
 =?us-ascii?Q?zjeyF1/3R3VHQLBM0wGR/cbtUCmZhdzLKSA0Z1IlhFpN3pA0LjvGnXd8JRL3?=
 =?us-ascii?Q?Y3tkTRZcqVAnlMY5eqhSIdUxvR1B/DYWTDus5kVmQWfqsrn1K/GcZFmlo3Ft?=
 =?us-ascii?Q?AKJRs+Bvc/yt6Ymp3UHdk+2uRsTwjNUYsTX4dM2250orkepxKmTmA1ppiQD4?=
 =?us-ascii?Q?omlqoIIGty3gmhE5gRavEAol90Om+wWFEf3SpD8uua97DRLQyN54U/Z/7hxq?=
 =?us-ascii?Q?0aaFxildzPWrn50H6bnuzDXNbLJnts9uwM4SRNyarzCjDZeSaGigxIzGEqK8?=
 =?us-ascii?Q?ub4RQY3z1iqH8JxG+oTQh9fWx+uRWXVfL66G04M8qb8B/+WpAzV3CNYw8xSU?=
 =?us-ascii?Q?cQDOiwXL8EZyD1eteDnU63XzTNzd5/PADetB4ktyHjYxvyj3gCPNZ1NSLcP+?=
 =?us-ascii?Q?I2CsJHBjR0yO+QKPG8q47mj0NyN914fnC2ZN6K/AIdn64x7IPD8m0AeIKp4o?=
 =?us-ascii?Q?7ymFDTy1JixTe+WW9AM/UHS2CKVG4/UZ3VSATx14eEmdmFkpnyLvTl3sJOvr?=
 =?us-ascii?Q?g4+GSSKzfLqaipHS4LXERarQr80p8PJpBPt6l/6UuSTAraymAoiCJR+d4hgZ?=
 =?us-ascii?Q?ycS44g5HkM5A+ZWQ1wxW1D/LtwUKw7SuiQiQbCyCUwr6fPphziHUeUryVADJ?=
 =?us-ascii?Q?F5ChlvKq1/Xe6ztwhQSBMAY3fkfaU4b1q5arrxDOdwJGQ5ZWhy+pSwD5XI8d?=
 =?us-ascii?Q?IpoG3kUmJtyGTHkzY0nydNmBz35r8UkQgEOC5HAQ0N6ba331QhdHbW8PdzpN?=
 =?us-ascii?Q?BCPg8cG3Nk3LDl+DnEzqyZ6mBFTwebnjrc6mpGMKVaPl8fTkmMD5hjzHUcgI?=
 =?us-ascii?Q?2+n583gq5RoyPSISKlmAWD2GULZsx2fkcou5x19wFNvYAIw2L66icYeo38IC?=
 =?us-ascii?Q?fQvjTsoUdnK40dNEaBtH9bkI1tr/c/BMZFC7PFA4yHSLa9Kz8t2i9i3c08Kc?=
 =?us-ascii?Q?O7TCzJnP7I+zW4d3GROUQbbEvKoT3Q7lbX2pxTBSsVwET9xhUtdwziolN9ZD?=
 =?us-ascii?Q?OeACkDzpylYXDRP2UT7i84fpQCG2zD9ONT+9sBZPvaziuE1C1qeNrrX4mElr?=
 =?us-ascii?Q?pqQAwQpJ2ASGhEp3XeQExeECPmmlXdlSq41kiob+OEljf9OKcf/KIiCkYkW/?=
 =?us-ascii?Q?qkWP1BvFFbo2+42o9qkesMosZClxmWkdggo4P8cVGq3uCcOAcHhqc5HoAuaR?=
 =?us-ascii?Q?YFUlb5dLAX+VA2egYf1bAZtI7zvXKY1piNYXwpwdA9Y2wE8Ucyl913QJfNub?=
 =?us-ascii?Q?9G3w3MtcUrwuIDNRbuYQa2Pf1MNpaZ5jGcFYoNnmLu4OHC8K+7B1g9Bi9MIJ?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897bf6f7-dbf4-4140-8a4b-08dcabb31e1e
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 07:34:57.4309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPzSMTtCB9VOIbYrE8x6IiCMKwgGR8gQjzynoFszNWnHWhAaTKAVP4XxdcaZFA/cYhmRMKryI4XSoVhcXz0y2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8124
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

From: Lukas Funke <lukas.funke@weidmueller.com>


tpm_tis_wait_init() is using the 'chip->timeout_b' field which is
initialized in tpm_tis_init(). However, the init-function is called
*after* tpm_tis_wait_init() introducing an uninitalized field access.

This series/commit fixes the issue.


Changes in v2:
- Call tpm_tis_wait_init() from tpm_tis_init()
- Use phy_ops for bus access in tpm_tis_wait_init()

Lukas Funke (1):
  tpm: call tpm_tis_wait_init() after tpm_tis_init()

 drivers/tpm/tpm2_tis_core.c | 28 ++++++++++++++++++++++++++++
 drivers/tpm/tpm2_tis_spi.c  | 29 -----------------------------
 2 files changed, 28 insertions(+), 29 deletions(-)

-- 
2.30.2

