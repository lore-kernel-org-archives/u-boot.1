Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D023C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 11:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0A5981F0D;
	Tue,  3 Jun 2025 13:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Flr36OZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00CC581FFC; Tue,  3 Jun 2025 13:54:58 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F58081E72
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 13:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zG9lOcsNVzK/Hmz4e0/RAIh3xMqCnBCPpNniTpKUhCOE8tIbVYD6sFpPgKcU2Qjnm0RYmcSihxDSD2UoXHJ4tQYEIyVyJG5jDN2g6pmxxlu/P0xKRqb96yDpRoP/hwC56txD3K+HdmTWJodG62oSc5bXC+GR5duA5wcFrR9rEsd2o/y+JQCPWdl4Us5OWRCTK1I3yk5nJOa6qT3TD3xhMxEU5NVFJi6wcuU+hXI2n+ezE8hxsr4+z38iBszpW6uaCDG2JPtM+oPIEyPEyjiwnTE9SHZG7NpuXKm+eAmNhmdDFs/icZEQD0PY4IGmrOGKqTbX9oBgKhqWcgl0FAYQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9v9/uS82nLO+T04YA/mzRnTVW43R7N+TOINTro/TQA=;
 b=Hjo6ANcgIcd9cOLDDiseySNwo8H4odUktv9SlwsuNOCeTBgLRphN1baLnU6FQLV5hIKhF3KWgvFTHA957nDDpU1x01+UMQ+JUShpRG2F75kdNconu7avypTUWenIKgO2Kf8F79hzBVssOUwrb3ssjzRorNP+leijmirE+DJdSduhy6XQHNu9Yzs77t2iEQuIPTk/vVljSZvZ8XhhO4lOUNIc+3QS7ibVlEyVsY7YtR1BoVZ1yceBrPD7+/Nt1OFu+PptZFzJp73X4ur9upScIquW2aV3cHoBf+cRHER20SwCqD7xRHxZ+ZHVW2tRwtHtDYHaw+xwqg+hhIor2OEKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9v9/uS82nLO+T04YA/mzRnTVW43R7N+TOINTro/TQA=;
 b=Flr36OZKI1NSnj0S6Eb3FnoTsAy6gsJzvfpXsjNw0QvWxRCe15n17wyv+xYPEY3Htepx5tsdHkSOlLWwn3kFZQOIcaZ72DKfLs2cmNGSBHSQN60E4YB32OXIKVcHU6zBiytff2rwSYl7j7XPeI3XgFGAtSnaPgpoIi/jk2Ok9EK1NtPhJWApjjgHJ2eTTGtgB6vjGNhukQdQTJaIQgnuvSps5v/uF0KI1vRKsRSn1dxAsdhArBaUxcqjVj5lzwXu6beQBIG7YPF1vHAOeRPa/K8paCQa+3Nw5s4I+RHlYLMDiEj4/z3vuIUypHbNAALm2+axykUa0fEVpKhkxOV79Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by BY5PR03MB5000.namprd03.prod.outlook.com (2603:10b6:a03:1ee::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 11:54:52 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 11:54:52 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 0/7] Enhance DDR support for Arria10 SoCFPGA
Date: Tue,  3 Jun 2025 04:54:35 -0700
Message-Id: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To SN6PR03MB4288.namprd03.prod.outlook.com
 (2603:10b6:805:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR03MB4288:EE_|BY5PR03MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2b2e64-b6cc-4d91-9626-08dda29572e8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cpJ6bADQu9N4ZmFaX9kLz6Y3QKIFL4aBOZa8QIygXEMY/nyRko+D8pTtdgtY?=
 =?us-ascii?Q?uDsqD9bINKRSwEG42jio0IevOITtmtiXcCBrzEsFHPILZM4aAaSfU9uKO2pX?=
 =?us-ascii?Q?1VjMuyvV70iD+4YvkTQFWS4aUDBmu5Gt9w168gsVGpQmunIOvQKPJDFqK9uI?=
 =?us-ascii?Q?EeIR+9q1tLtmbhj9rGlUok78lz192XiqZcPay+jEiy3dHQtdTl9VdcrrL/u2?=
 =?us-ascii?Q?jtQRtAsfJ5bCMOSlg7ItjUkI+cEnvgDGR5Hkqr0soNVPaM5E2dP1qn9FMkJm?=
 =?us-ascii?Q?sxdv+lPtd32nTyshZ9vxAq91C7IHeJiB8cIR0S5DkKju5nkXS8ZOQno852ok?=
 =?us-ascii?Q?IQrtcxZHwQKX1Yc2Dqntf/JyxTBM+NMSvUo6uF+SpEKkHlXX1hMFIfrOBeH8?=
 =?us-ascii?Q?g057uzFt+RtvJk3WkP1ZnWVIRcG8ZVCnuf0LNTM4z3tKy0lqoZDCWktr1+zM?=
 =?us-ascii?Q?1HcSbvviXE+cjz6Vqv48zio1hD/sacnFIyiYz14w+I+dAkExG2V9ZQE4F+vJ?=
 =?us-ascii?Q?MggFA94zJtex0oicw/Yul901qIrAycx3FQ7ez8w8f2pAI7dUUjgA9cdAcYlz?=
 =?us-ascii?Q?arulxfY3TyhENfU5mzym5lg/5czRpG7sT1nh/toEJUUA/FPB45gVp6vwXHIy?=
 =?us-ascii?Q?WPRxVKNWjFWBlzFdsvP9txC9hQY5OH6NI6DKWsICqnY9NTnjNqeDKEiv/pMz?=
 =?us-ascii?Q?glAqJSacdkpwcbJ3bnx1ufjAYpczDQgo9GGc5vfx+fqhMMpd6KiErkZhpJ19?=
 =?us-ascii?Q?dQWlL8r73N50CBbV/t9DNxBze/CyfwB3HM9fNGeozE9PUR+peo9eVRwYjA4f?=
 =?us-ascii?Q?MKuOObSEw6J7xOaykWus+MpN7bj5RX+n91d0GZgFodDTegGMfQdmydCCWuYm?=
 =?us-ascii?Q?Zeb9j+0h8rHRA0fPrz0hapUF6HMdTd5pPot2pC0ATU8wEsi3z4cWRvztz+mS?=
 =?us-ascii?Q?CuKSuRQWy8cZFYk1YU9JwB8Hf9FV7g4/l8sax3U6hq+sEziqLhbEAbu7tctw?=
 =?us-ascii?Q?IEt2aZDumS13sRoprEF5YFgEuP37ihpqBpY6tnv1Vskeam5qkWL0cHJwR8KP?=
 =?us-ascii?Q?gHQjEZTRZF/CeXqTy0KGd0v0XGTwjhqMOC6HOH39LPq46VE15OhzjWjrPPs9?=
 =?us-ascii?Q?rzmNYufVvp9AWiyyNsTxNsF5FN105M+L7bYhB89VEHReKPb/P9/oGDDoEXjg?=
 =?us-ascii?Q?mQMyJ1Xjtdh+m9t/MQXgmAKZVN18sSWhpOT06DxfVm7LOmo5SWdrM1VHj2Pg?=
 =?us-ascii?Q?4EEMknK8rGhwdyViAETt0WN4Ixmr5Gz7nkPwhegxPN+lbhL5ITXBdE7ZuWXm?=
 =?us-ascii?Q?7P+l5e2hodlMS8OALYsfcnPreknb9GdJTy+oDR5I1FJItGPgmGkHGuEfLA7v?=
 =?us-ascii?Q?r1XvOIraTX4hvYY56nd9qmpoOlvWZRYjs8IoUP7Lcg8gUB4vC47ED1owvhyR?=
 =?us-ascii?Q?bFaOCLP6lcw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bgsJcuPhWESpIHfqIU+5gh/H0j0FLgaMdXgxqPN8ebK197ZDfySSLwld2Kri?=
 =?us-ascii?Q?z/AulFT1YSnDGnpRIfMu58JNaJlXB5sbm11eUrImwLSvG/Y6rvxgD+IBxlRZ?=
 =?us-ascii?Q?dWf0pvz3TijM3VAc+3MgYEJ6aRV0IwnQbMVG0bUgvV5WphXN0/Wm0Tp8WAvG?=
 =?us-ascii?Q?CmKW8IlPZuMXuqECu12P/WYi2Sfryyr1L5j8JKtXMdK5VhHT33h9jwcxJlO3?=
 =?us-ascii?Q?frIm8vssyN18lvVuZWYqsq+jl5DGsHTnDutqHXGocbDIvOrFjypDxuflsOn5?=
 =?us-ascii?Q?GhFdKoFe44eyAKgJJ37XzUAB9yb/PFR/zWsMgPzN689AYBTeMNJ2DU6mlUxR?=
 =?us-ascii?Q?zaMMwWcXgRmbhwi8UgFkcyMR+k9pLyBeiJj7Dpm6aQ4kiyKb73dcWIX6BjXc?=
 =?us-ascii?Q?HyNUGBeV4KGRI62Nn+ylAqYZMKA0kbCsthYupMVTiGXdj4blW8ryXYa8Ydhx?=
 =?us-ascii?Q?oYyQSfHn1Wgk5ZvgITnK4HID2TSBZw/0mGLH327tInsnX8Lki3im6mmVrTxn?=
 =?us-ascii?Q?4grJj/cnIFixwKBxT0+IsK8jx8/mlQFpissAtv9xW5sdKB83X2a8sNjUsHyV?=
 =?us-ascii?Q?n4Qpdxy8QPQhzGejcTU8ix4vkLJ9nYzU9QQBzcV2YMn95MJDGpvj/alL/sai?=
 =?us-ascii?Q?BqaJQOtaz6Jw3CXIwdM9+bsjtrb5TSayG3OnPkFt6ualn7L7ydP4FcKZo5O8?=
 =?us-ascii?Q?12JTofG1PbDACSU0KqUXqNuYdZPiM2GXeY6enhW37ZhO3Y3HRKJnfqUSUU4Y?=
 =?us-ascii?Q?6BZSKuIZtauXv4WnH0s6pDTIMIm7flvKdRv5lBWgAgJ6dRqZ7xtsCEmolO4S?=
 =?us-ascii?Q?DMcrydEXZa8y7FBOLLAHtkOOUCAXIR7EWIWzZxs3trg/++VFlExANNSdUDLe?=
 =?us-ascii?Q?loYlRMGNhOmLyKzGW+2uoQ05rp5yDVauuiHcw5HgbD3p5LKbU1WDcotjwtR7?=
 =?us-ascii?Q?GZ1rB44gS1FX3ugd4w8nuVUZ6E+RjuiJLcJB/b/FE6SEM4CqhFwPTfSiDwVJ?=
 =?us-ascii?Q?9D8uKKo6u6437eq3hnxfBkvaOuQebt0jnGoCB3ueE0la1Z8T8khObJzlEpRJ?=
 =?us-ascii?Q?Nr1a55nRk+sHz2OQErs0dsALDkwxvwmDWyEBH0Ng8hhbT9C3Ub9hXDsa0JFO?=
 =?us-ascii?Q?SqIfj+LyQ3/XHeCiIGCPDmg/27ZZAD4UE3B0gYvZPLZk9lOhtsjzgTi9GI5R?=
 =?us-ascii?Q?VKE3Ldipx9M50jps6H7nNTnArx1PQNITzEgHTkaU4zjfusz4cTX0KhGJdh5y?=
 =?us-ascii?Q?hBEefb08OB2Ghgzxr7vuTE7t3iTO67SCTDnsrqL8C6j6sf7DiOI7V35U6hk6?=
 =?us-ascii?Q?RMVqG+GG0kN6AatIESZiM74WGxgh+Sg++FqMOQ+dOXpw9BzybyXteIx1LC9I?=
 =?us-ascii?Q?MaSdn6zXXJsTg3DD2svdxpYI6R3mVf97rkWKVH4He0+6eF9MjzG/3PIRP2ni?=
 =?us-ascii?Q?jdU+FqzstmTI6U5tY63YKITEfMhtwdh9jAFgg1IuwArierOfFfzsSinXVyZe?=
 =?us-ascii?Q?zqv+Ngn2KEqlG4NfTfb0k0K50FvX75uLTmP2+m+j1v1uG0q8ENlSy/FeY4ci?=
 =?us-ascii?Q?C28Wk5/AFab9V64fQyeMT5M7r3gdiGL4hAPQf1zpPJHkknAUkVcyDTEpc34f?=
 =?us-ascii?Q?q3jkYeauHwyQAAp24izShNo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2b2e64-b6cc-4d91-9626-08dda29572e8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 11:54:51.9957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SWIrt3z1WBfBhXSEii6K0YrSu4xtlIKLXCrHhhOrWjMBW4DaftrDUP6IEnTHD+iczzXgbt4JyYUugsSnVNcu+R29xWdARmmAODjP3iQTfaHaugbPy295pP66Ro82wuo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5000
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

DDR driver of Arria10 SoCFPGA is enhanced in below ways:
a) Check DRAM size from device tree and actual hardware,
   mismatch is notified to the user
b) In case DRAM size from device tree is greater than actual
   hardware, DRAM size is initialized to the hardware value
c) Fix a bug during computation of mpu1 address
d) Move common code specifically, initializing SDRAM ECC bits to a
   common sdram_soc32 file. This allows using the same code for
   future devices.
e) DRAM initialization is sped up by enabling Dcache
f) Fix hardware watchdog related boot issue

Changes in v3:
- Avoid hang if DRAM size from device tree is greater than
  actual hardware
- Correct ECC Scrubbing commit message to appropriate one
- Split Dcache patch into two, one explaining hardware watchdog
  issue in detail
- Address minor comments

Naresh Kumar Ravulapalli (7):
  drivers: ddr: altera: Add DRAM size checking for arria10
  drivers: ddr: altera: Add valid RAM size check for arria10
  drivers: ddr: altera: Fix incorrect address for arria10 mpu1
  drivers: ddr: altera: Clean common code for SoC32 devices
  drivers: ddr: altera: Correct code alignment in sdram file
  drivers: ddr: altera: Improve DRAM init with Dcache
  drivers: ddr: altera: Fix Cylcone5 SPL boot loop issue

 drivers/ddr/altera/Makefile        |   2 +-
 drivers/ddr/altera/sdram_arria10.c | 112 ++++++++++++++++-------------
 drivers/ddr/altera/sdram_soc32.c   |  88 +++++++++++++++++++++++
 drivers/ddr/altera/sdram_soc32.h   |  11 +++
 4 files changed, 163 insertions(+), 50 deletions(-)
 create mode 100644 drivers/ddr/altera/sdram_soc32.c
 create mode 100644 drivers/ddr/altera/sdram_soc32.h

-- 
2.35.3

