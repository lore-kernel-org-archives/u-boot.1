Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D711BCFD376
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 05:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4983C83D9F;
	Tue,  2 Dec 2025 06:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="j/0o1vBp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6084D83DEA; Tue,  2 Dec 2025 06:36:35 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EB3583C64
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 06:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2h58GdyesGtvSrtK1JU+MaP6gHmXWwAZkyI7GDcXrb7ku5uM+nUiO6b9Y36eQGOiypTOgBQtRNVqDnWZB9J2ZIEswEqFEOiuEu2VwmCbO8CKKY+diNi+LoZS20bhr9WYW/EUboIJPczrkxCfj0L0qax/xjlZ2oWhifQYD59XS9S2gop9XijtiyTLQ3FfAZgwjZQmaiQXgRhClJyhSYjMaSKt1+j428E/1RT44KRNNBgq3i90+zdH5M3V2bflfvX8FLjfmjU8TpCjnkqeh3utkKo1KvDQJkGNN9GyuvVPHzdp2+mxNLKVI3XyviQSW1m/Pi+2eX729mmdIUNzotKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6hMDHDmJ6uON5dhmjQWt7W3FSSJcd9FjzsYnUYPiPA=;
 b=GPY7+XJ99B9mdKMevYEmRIENfRdrPAfTob16YrDPlWLhDXRwx+Pm/ur/NhWlrYlDZ0q3nTSJM/7ruWlmxpxFnY3H6MFxsYAEfPQ1jrFv2+Kr7iIlNNRJR9LaoKA5h/eL1la31x/mVRcljOml+7VhJSb4/asSihOvSMYmHJEtX0Y0p2fm1y81Gxx9zzZx0VXO2XlTYmskfB1EPG3bQRxKufUjDv54bsJ2woA4Bl2EYaQ6Smbe5APqQ04LyhrEYkb6KuDX65tBZQTcABzB/Io5AeLpLPEfoHK7eRQlWqjbR++57SAhPTJbE7Xrn6IQHF4/Szuo4mr8rugYFVvKLs6Naw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6hMDHDmJ6uON5dhmjQWt7W3FSSJcd9FjzsYnUYPiPA=;
 b=j/0o1vBpkBlKtSfvR2TGI0nEyWSywpoCNIpYvmPgfThPOBnoQQI1Vr7cl8ozK3KzG3WyleoxFCuintGpaenQHS4hW6cHQf2gRUcd9OgqswbSMzeSPyjkRrFRBzn7Pof7h/iaRzIdbKJVgNWJ4ZmQlb6zL/dTIDjvssxfZJV/XLUVNG8iuUwz/AazrVa2A0HO4e4Np6jxISP4k58rZm4MyDu1WTOQ/8mkYiP7cRjKe+wYit3nTTq0hp3biNGBSCs9S+M80mkY36FozzwlCBQnS5YZ3KKhQyxkjphTrUnBT4dwfFxgqyR2uPHvNSAykaCkie+suWC1cjTTZAmKbu7bdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by IA1PR03MB8240.namprd03.prod.outlook.com (2603:10b6:208:5b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 05:36:31 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 05:36:31 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Brian Sune <briansune@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [resend v2 1/1] configs: cyclone5: Enable random MAC address
Date: Mon,  1 Dec 2025 21:36:26 -0800
Message-ID: <20251202053626.6446-2-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251202053626.6446-1-alif.zakuan.yuslaimi@altera.com>
References: <20251202053626.6446-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0061.namprd02.prod.outlook.com
 (2603:10b6:a03:54::38) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|IA1PR03MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f88062a-c62e-4779-3c79-08de3164bf49
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JI/1OHAwwgmCmhxo5lgvslf12tMXjWDREdEvOPzfoH6qtrS/fqdPc17PBDx6?=
 =?us-ascii?Q?uTPt/zaL6e7mPVFYZemeIB6YoL7+bLxM0qfzYsVwZMYHnflq+RkfA1q+E4c8?=
 =?us-ascii?Q?NEOKotHpSpOKCaamY0j9LMkFABS2/pF+M6zQYBmf70PZA2yhRwC5BeEZLf4k?=
 =?us-ascii?Q?k6dpc44z+y0gLgocZb8VRwP+932Bx59v2IN9sZEPxlOe+dxLOGlm/oW8QkUU?=
 =?us-ascii?Q?sGs3M7eEQE1vMLDY9qaR1VPjg7LTv77/4Zotff6Zfes6Oj9aZaa/ZjD+rYAn?=
 =?us-ascii?Q?ffEoxljgU2AmU1Es5A7tjAiymTP8OzUi8te6CmErbK5oyFZ5fcSYJXD7yKAv?=
 =?us-ascii?Q?crujgEQDuwe0DmsO7oUzfjNzObH7EkezdxEHxtiIZpvODf1tcOr/CkiBQXPm?=
 =?us-ascii?Q?1bZLYFVwmZLPTi3p2TolI0YwE60FsGqaiFYNKP2Vm2rbigU7PmZTBLibLaQ1?=
 =?us-ascii?Q?bFjQo8iJH+bfdsBSMfxHHXk0ANvROvKSYYy1CDgALXRu9jcU69TdiqbC1cKD?=
 =?us-ascii?Q?MaKOOw6+bJwB6PUBad5DF53Bxv1CpNrS6UGrgy6FPYad7rRHL/2bbPw9c93Z?=
 =?us-ascii?Q?XEqWw6fMXt/u+TQFvQiRjEgy79S7bVupIldUGFIug0s6IErC975xINPOLeOS?=
 =?us-ascii?Q?VgDjaKJ2L0YhFc8TaBYqnS2Ck1RoDSaQJFU0/rCzynn7cKnxYa9hYiFZ9uGb?=
 =?us-ascii?Q?Yt1kUjuMtbnyqtoF/x1yndOfO9EcFniom0N9OwAk1LzlpLXcXtQ3pUmzgaky?=
 =?us-ascii?Q?MoCUj3oOfJAfG91VfjNQ/he2P5vWnoSZ4jHnytrbd1PBZxxPb/gS+KLStjjb?=
 =?us-ascii?Q?0vTi6MrbSiBxUe/BE6WLCp0lY4UaqLehCnQUR89cDHNL2I0pXHcKd69VpqyL?=
 =?us-ascii?Q?3wR3bc3Vx+B7JFl2LskVLgAMx4xPzL8IzSVEcvhuyWAd4UrlwK0BYqVyEpJh?=
 =?us-ascii?Q?a3rs3anbsYKnG0sII/fGvuJjMgwyTEcDIMdqxw0ed9VJmu3+/iwb31KINq81?=
 =?us-ascii?Q?g5UpoC7a/bXSvMUCfLyi2/1ROh+h95NuosyvuqaRJoZeow7o3l30atlXTxPi?=
 =?us-ascii?Q?KBj4K48Mqhnn5NcD7lqghPaqqG9In61RvVdGwaLDSqA78SQLDq2+PeP0hFTu?=
 =?us-ascii?Q?B6AWe33XyZfLKLs1gchwObZ4I1bjugdhQEv1PxEr+TtRRnE/M1iqVK8gGsji?=
 =?us-ascii?Q?deWtRxXE/+V/9d6pna3UIi9E1pqUrJ8tZdVjy04l2nKe4AKaWiDBdaiEEfsx?=
 =?us-ascii?Q?uMhTJVU4qqQHsFmeOzApI+ZUiNyNpP7tAUQI27plPMekzPXoQIT2vd992GWz?=
 =?us-ascii?Q?/hbPcQZizDy9wur9Qu0msj2cDx8JVZCVsB7ktCTjogcWv8a5mtJrbROpEnaC?=
 =?us-ascii?Q?PhDI4XQVvXPKbLIDIyg4qqttYGT1u43iK82MLkjxD2h22xX3M0mRlixQDF72?=
 =?us-ascii?Q?zr62BI+8gBRcXLs0eSLDuYCfLCVlOLvZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JaW7ROwtG3z9zy/isv83kCrvkkA1+tXAirneJ2Zd3edSr7FvGheHbKBH2Rru?=
 =?us-ascii?Q?K7N8vLjoJp+BfQkML7jCE4LghcQS7HaK7GziP8ldTvbywdKYnX0x2QeaEJXi?=
 =?us-ascii?Q?tzwtpaoeGXhUbSt5icBUCVwBA1Ylj9gutYw10CIKdxS19tzsD3Mwk3WNO+HY?=
 =?us-ascii?Q?p9uR3vYF9AGxksd8FoG3UbBMF5SMVy1EkEVuwhZvsgJ8Qg0szr81/GnETEOw?=
 =?us-ascii?Q?sdT82PqJTu+rR7NmGmDXWvq9612oRUXOggpi0tNfKdYsTVN4Zl85/tOsApjo?=
 =?us-ascii?Q?t4G9p6Ts0ftg8YdkBjAH1iYnFsda5xT6feiO17OFQLZSxzdpuWbsCS9ZGivc?=
 =?us-ascii?Q?OUfX7cTgD2z8/axVdYiNYerjq308kDXIyTTPQZhRX1dl5g1kWwHRJimwOGVP?=
 =?us-ascii?Q?9MqvXAshb+pJVUuG6d8HRL9pnejYlOajzNcJSsKLx18JbdyMEu86s4Qm0YG3?=
 =?us-ascii?Q?XVi6g8mpmlImlsgR8iDVM7cs0ddCJhjzKkaIJXwQ3LUSQ8a9oe87aDq4llsK?=
 =?us-ascii?Q?Ho99u/lLyNlJrGS7m4MTMEU5bnrf1IsZ5MGTTRdovHxz+wXpvGzGe/mgOhEi?=
 =?us-ascii?Q?4IrNy/zIeHvvmQOstnXw83ueRrR7c2Qa7/5SfIRsj6fPOU/Eo+mmyE4PrFGX?=
 =?us-ascii?Q?65PV51YwjFteS/sQ3nFFG+RTZbFFKBIegTnv1V4JOM7VgimHrvl7bQlKyhOc?=
 =?us-ascii?Q?h+jO1G822ZhFgq06CeBJfVBIuIa+HdQ9wefGmCLyeH6sJ16RdYs0Ql2TMiPK?=
 =?us-ascii?Q?mTZOJ2osU/nmL+AFsQV+KRERXwbEmF9peaWc32oPnH9GT4F3a9J7P/YwtO/u?=
 =?us-ascii?Q?xVC+YwQJoOgyhPljbTESeb+RFh17RQV3oXKvykjg9Mxrd34kGjkxy9fXP8md?=
 =?us-ascii?Q?OiQAo6pvoQy2kIGU/WtECke6Kr8oUbUD/y9QbblklyBvPC+V7jALncI7+4iG?=
 =?us-ascii?Q?FTkgA5VSnUePaWcR3da/pKrq3f9HNJZnMAfM3e9JW6l25B0R/BzZDkyiVVci?=
 =?us-ascii?Q?7Ns98OvwrRLdEQksrdV6fpCfrk0gkP+noePSfaO2IA7/ANaDy0Mzex9qpSzj?=
 =?us-ascii?Q?g8iqh0//RJrB+qznurjX+Nv5N5JnBBR49j19d8UANyiNU6ZPGFWzlRQfz2yY?=
 =?us-ascii?Q?3ivRdWEJKcMUpbbBH2MuNPELPm7+H+gRum1FBcNcJI9lp9HgO7AXHlwhz1WV?=
 =?us-ascii?Q?t8PEHpUA4qq8Oj+x0yZwvxPcsaanc/CAf/v3bC020JDNsTA1cReFigTE83im?=
 =?us-ascii?Q?x6Ms/ZDD5yIzlzcSA+tNsHBL6uP/frpDVixEvyiOf96YwYSWTWtD3+O/hgnq?=
 =?us-ascii?Q?5Ir8XSNiNJu+TubxFa+GZD1kVIfd51bShgFXF4CMdRF5ezQ5ccRTNDZQrL+3?=
 =?us-ascii?Q?D0qZc8hAmDwLVahNJ43aipnkyIUY7sTC4tokO9etD0sBKfTaIuviT01U5vCI?=
 =?us-ascii?Q?RqCwlu03JbknSYvrVe/I52qDemPl4JQhJV8cxmn8sSNbWrenxh01iZpx+w7g?=
 =?us-ascii?Q?FbovDEWhOC1w5WyI4fKSUy0uClYsCdmrKwaTv9gQ7SWif0F4OKU5zowtoiY2?=
 =?us-ascii?Q?4emSzNKGZw3fYrLFxPvDJomk9VUb09l0NyS1Ufv3udxvfiiHeDg/jSbDkkDE?=
 =?us-ascii?Q?AflSWKLucLqSM4l3I1l6g7M=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f88062a-c62e-4779-3c79-08de3164bf49
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 05:36:31.0459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TJm6hM7jhNZQL78EtDyEEqKBQ91N7SOvr7b/la2k8iDiB4Ch1bvXjDhlECQaZf/ZpPVyYpvtYlbORvFHT3brTPKImC0NtKUu4FRM8VeM/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8240
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Enable CONFIG_NET_RANDOM_ETHADDR to allow U-Boot to assign a random MAC
address during Ethernet initialization when a valid MAC is not programmed
in hardware.

This avoids network initialization failures and MAC address conflicts,
especially on boards used for development or shipped without a
factory-programmed MAC.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 configs/socfpga_cyclone5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
index f1bf0aec015..8b64c590e90 100644
--- a/configs/socfpga_cyclone5_defconfig
+++ b/configs/socfpga_cyclone5_defconfig
@@ -69,6 +69,7 @@ CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_MII=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPI=y
 CONFIG_CADENCE_QSPI=y
 CONFIG_DESIGNWARE_SPI=y
-- 
2.43.7

