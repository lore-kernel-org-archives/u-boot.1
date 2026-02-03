Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1E1E8305D
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 08:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F34138401A;
	Tue,  3 Feb 2026 09:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W7c9Luh+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63DA984047; Tue,  3 Feb 2026 09:06:11 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14A8583FFA
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 09:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwkGEuLKA+Qjq6US9b+qXMMVNpLsBwbMV1a+/9g7LJNha2ufelI7vRsreVnFQaM4KFNYbqTm4erHGZSfta8HTY2102ZKJ5EqMTASCBuTwGK2jKtacgFTw/1lImALW17qc6eafaJhBmo+WYOv1LNPQZJT2VLo0stUiqd47BfKNXh1MVBPtus/KNR+30U7FIwV24j2lGf03NN5w1yFMOmKgN8Xoc/NE8CEWKbjzI/jLTHa2jnt8Pf6OGp2gKKFVg8tE6KIJv8JjDTzMWjWGM0mQhS+ylX/XAchLNkgfVKZKpoehBBoFaApuaPxC8iFsjMiFNVR+5WdFOC3a/MLw+pvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=og5nUVMlj1aYn3mDdD2By4jPtW+3HqUhjxFQSnDwNqA=;
 b=yrozOHUAIS6m3Lv8Gb4coAunnootBYOI7KPN4gYDzrgSo4o4iN0D23Xhy2wkwd29OOPE7lapd+W9AjgABgYfXTn8LG7S3Lrds1PJjNlx/AS5tCMRY7Uy6t79QiStIzF9jEz0BJOVlDrfAxFwK5Sh9+hDnnZKSKM62w0RM0MLh29fKOCuDyVKcrXsuL5qh0s0toJLPVZ4oISl56RoOG/N0RvlnZJlUA+tfGrbQYdsLVK4mWEuP39qy4aiUB6P3ahXvN3LML5Jds6SOvF+MyUbjDOby3UwStvOeqv2HX2oKC613d5cluWypWh8d34TilcHgO+HqREf5v1vb974y/FywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=og5nUVMlj1aYn3mDdD2By4jPtW+3HqUhjxFQSnDwNqA=;
 b=W7c9Luh+wmtdYllTpnueH8IsfB3iLlsLgLRmdOoFoeUaoM64KN7hSK43ZF/5z8t3cWJsVy+JM67Hvy60l4ODjVnwxe9tyQOJxT9TtYTY4q6HeeegDU+2w9PwdN9wj3HDy0sHRRH8Pse66xs7ScjkmbuU+lxNwatQXED1mCNAHuY=
Received: from CY5PR17CA0006.namprd17.prod.outlook.com (2603:10b6:930:17::30)
 by IA3PR10MB8186.namprd10.prod.outlook.com (2603:10b6:208:511::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 08:06:04 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::9b) by CY5PR17CA0006.outlook.office365.com
 (2603:10b6:930:17::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 08:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 08:06:03 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 02:05:31 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 02:05:30 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 02:05:30 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61385TTK3597554;
 Tue, 3 Feb 2026 02:05:30 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 3 Feb 2026 13:35:29 +0530
Message-ID: <DG566LV3E2YH.KI3ZNJP0ZL1Q@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Anshul Dalal <anshuld@ti.com>
CC: <trini@konsulko.com>, <joe.hershberger@ni.com>, <afd@ti.com>,
 <n-francis@ti.com>, <b-padhi@ti.com>, <ilias.apalodimas@linaro.org>,
 <peng.fan@nxp.com>, <jerome@forissier.org>, <neil.armstrong@linaro.org>,
 <d-gole@ti.com>, <j-humphreys@ti.com>, <semen.protsenko@linaro.org>,
 <bb@ti.com>, <m-chawdhry@ti.com>, <mkorpershoek@kernel.org>,
 <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH] board: ti: j721e,j7200: fix do_main_cpsw0_qsgmii_phyinit
From: Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260202141058.648965-1-s-vadapalli@ti.com>
 <DG52P91F2IJ0.13IQHK33CRF1E@ti.com>
 <68206f3ce6dffdf7c42d81d24091426497a5ab91.camel@ti.com>
 <DG53OSN3N49J.2M9OUUKKK410P@ti.com>
 <395d53ef43d07361c96422050f3293770ad77f1e.camel@ti.com>
In-Reply-To: <395d53ef43d07361c96422050f3293770ad77f1e.camel@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|IA3PR10MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebe9913-dcaa-4b6e-1380-08de62fb134a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTRyZjVaUXpXK3FtaEZDV0JPaVJvRjFYUmdzTmh1aFozanlhK21YcFk3YWJj?=
 =?utf-8?B?SlhVR2RReHhKV0FlOFhxUzVRV1FVdHNpQjRSNzFVTzR4MnV4bWg2NkVNVVV6?=
 =?utf-8?B?b1AweEF0a0hBUEhlNGNybXVPbSt2MjU3ZGpCZmlCTDdmVzRHYlJLa3M2ZGhh?=
 =?utf-8?B?b0ZBQjRUNUdFcnd0N2VING1uUVB6WVhKckltWm9UTWE5VDUxd1F4Z2orQ3hy?=
 =?utf-8?B?cUJrWllmRCtNaXhzaTF3cHMwcWZJVTZTbzZFUENkZFMwVER4eGpxVGwwQlBu?=
 =?utf-8?B?cVY1R0kzYlRXaFY4YUZFM1U5R0hCUFFPV2d1Qmx5N1lBZEtGNW83OEJrRWR2?=
 =?utf-8?B?d2U4TmdYK1RjL3pHZGRFR0pwY0ltamdMQmM3U1pjYWxlUE9FN1FleCtoQ3l1?=
 =?utf-8?B?NFh3QldQbFc0UGJubmJDcEJieXJhTytMOVF3cDdsbWo5VndVQmJXL2k1Ky9j?=
 =?utf-8?B?ajFySHRVdzQ5T1VSM3BxeXBscEJJekRibTY4dUE0VitpV1g3Q3dKNTI2U25s?=
 =?utf-8?B?RVUrYU1OMkV0SjVuMFM0OHdQU1o2SVBSZk4rbEFhUmg3UFdWaVVsa2V3T1d4?=
 =?utf-8?B?TWdEK3g1V1lWYnNFaGFqNVdnaWFOWnJPOVl3aVBIUUt2QkgvNFhvOXl1NFpI?=
 =?utf-8?B?QlVyS3J0bzFUbzFhMzhMZk1xRmpnTHJsYWtIWm9KSWNhOHZRVzlrZjNwTnNu?=
 =?utf-8?B?REFVWmtiYXhLUDlDeklQeFJRS0F0bFc0ZUhndTdCczVZRTY5QlBXRWZzZDVP?=
 =?utf-8?B?RVJzMUl5RXRYMG8veDA0bU1MYXNKVnN3Zi9qR1J2dTVVbWgxMWVBRzFZUEVl?=
 =?utf-8?B?MmlUTGltNVk3OWNyVXRvWmpxb21zZlFod2hlMTBPNlI5RzgvRnd3M1dHeFVY?=
 =?utf-8?B?SzNxTUFGTEVpdG55Q0FTVXMzZGlYalFsT3UxR0Zac283V1B2T1hKaUh1ODNa?=
 =?utf-8?B?b3FCRE9iK2c0VGRHZXlhVTBIc3lNYlVYVzY1TXdvRHNrRFk4RmNZR2NuM0xG?=
 =?utf-8?B?dXI3TWZPZnUrTFJrZmNpQnp6Qk9JL2NGUGN0T0t2aENMd1d2bTBlS0NNSldr?=
 =?utf-8?B?M2NSWnBlN0hOa25ZSTlPZCtKbmJNYTZSZ0lkUlFKTGtJcGtXYjZReFl0Uk5m?=
 =?utf-8?B?dEZEWno4RG5hNjFMRkZVcmFGUDYyQmtVaU1QWS85QVNvQzQzTUpxTzRtaSsz?=
 =?utf-8?B?bkhPRDRGV3M3M1M2QWVZY1h2dm9TampzeHNiRURmVnpCenIwL2luanNDQmE4?=
 =?utf-8?B?R253YStpYjJJNmpHdG9VS1FLTW5NTVFHY3I0c1gxanVYWi9uSDBoQ1VUVWNo?=
 =?utf-8?B?cjlhRXVoNVZjSER3RUxBYmpmZVhQTStmS0lSS2Z0aURSbHhDOU44WFVIL1JV?=
 =?utf-8?B?ckRnWHcwaWlsWUhGT1ZkQVhDQWdzRVlZNUYvenZsZFFWZ3BaUDdoOHlud2tC?=
 =?utf-8?B?cFBqS2pRSi8xZ0FRNEdocDhDZ1dTK3R1eFpyUUJ1RjVUbTBFNUlVSjdjUjha?=
 =?utf-8?B?dmZnUXB2RkRmeXlKaWdDV1U4U3libG9UOHBucjE2TkE3VFZVYk4yVUlKbDNM?=
 =?utf-8?B?YUxFWXcvM1BYaHFIWXhBZWRiRUVsS2VBWnAvb0VOakdnZFNxYWdWN1o4RGhQ?=
 =?utf-8?B?aVZGUkU3RzA3WmVkdnJ5V3hkTnY0cTArMVVHTjlQemtNeGVDZXJZVHBqN1JZ?=
 =?utf-8?B?SXJlZGxMcTF4T1pUYWdIbXVhV3Axd1dGZzJENHV3K2ZkMmt6bXZjbW1JS2h6?=
 =?utf-8?B?ajZFN0JOaUVQTXg1cW5tM2E3cnZiY0xGZzBScTNpckVDdHdqTktYOG5qd0Rq?=
 =?utf-8?B?ZDNuNkZuOGZ1cTVLMlpqYjBqWFYxYWxIYjljQ3NNVVVINkQrWjhxUlEyM1dj?=
 =?utf-8?B?TFVnNU1MendqK3pCNVhoblRQYXVCTm9Za0hhdVlldVJ2bmhKcDJabHU3aG4y?=
 =?utf-8?B?dzlCQTczbHBDMlo5alFveGhTYUlkcTA5SGgzbElKSnE0ZnAxQ0piaFBmNVg3?=
 =?utf-8?B?NVRBMUF0TjUra1VUSWk3UnJJeHM2N1pONDFoR01qR2FOcFo2ZXZnVlMrN0hu?=
 =?utf-8?B?VnUwUVlrNDZ2RmJDYm53aFBIVkRqVTlWRnZYTFA1am42am1TU3NSQlVFaUZr?=
 =?utf-8?B?Ukdxczh3a3BFcnFLL3NSQ1dUeGpUOVNUUVN3SFNvYThRL3lVeVYvWkgyelB3?=
 =?utf-8?Q?XhZZlLYVqXTeDjTXrdCyEKs=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QwTC4mQBJfRBjwxFU2KR5Cy80QgjXDvJfomeY3G2Tcbxdxyv5/SImR2On67uBovz1K7xH+V6p4GEgAp/jRNNbQHZRc/7y7JNaYHh7LDceVb9rM18VmmWRE0nv9iAp9dEuedJb4+YsUkVG/l+iNs3IHFH+eqvDazQ0JA0ASZb7ZyqRqmfwiUNhHuQ8GTmpzVBdZtD58uxMQVyNgNU9hMtqGK/paiJ6RY9nhBWXg2znWalysDKfJXx3YfRH/pHlMetP6dxPMwHkjnc17CIxg3y0E9OGp+czwXpK/aawny3e47FAe5BtTXPqrjNucFvBckQHqEpeAP54oMWhI4przZlT5p4VaF8oxTgbi3+UDfg7Dypxr0WItII59G0Io98HxUlTdemJYJONYd0mt8fsgWHyIjiDdYKeNCOUaI5spz5PA6NX8LRprGnvPMO9u4kAfGm
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 08:06:03.2208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebe9913-dcaa-4b6e-1380-08de62fb134a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8186
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

On Tue Feb 3, 2026 at 12:06 PM IST, Siddharth Vadapalli wrote:
> On Tue, 2026-02-03 at 11:38 +0530, Anshul Dalal wrote:
>> On Tue Feb 3, 2026 at 11:11 AM IST, Siddharth Vadapalli wrote:
>> > On Tue, 2026-02-03 at 10:51 +0530, Anshul Dalal wrote:
>> > > On Mon Feb 2, 2026 at 7:40 PM IST, Siddharth Vadapalli wrote:
>> > > > Since commit 27cc5951c862 ("include: env: ti: add default for
>> > > > do_main_cpsw0_qsgmii_phyinit"), the value of the environment varia=
ble
>> > > > do_main_cpsw0_qsgmii_phyinit happened to remain '0' and couldn't b=
e
>> > > > changed without user intervention. This behavior is due to the fol=
lowing
>> > > > cyclic dependency:
>> > > > A) ti_common.env sets do_main_cpsw0_qsgmii_phyinit to '0' and its =
value
>> > > >    can only be updated automatically by main_cpsw0_qsgmii_phyinit.
>> > > > B) main_cpsw0_qsgmii_phyinit is defined in j721e.env and it can ru=
n only
>> > > >    if 'do_main_cpsw0_qsgmii_phyinit' is already '1' which isn't po=
ssible
>> > > >    unless the user manually assigns the value.
>> > > >=20
>> > > > Fix the aforementioned cyclic dependency by using board_late_init(=
) to
>> > > > detect the QSGMII Daughtercard and set do_main_cpsw0_qsgmii_phyini=
t.
>> > > >=20
>> > > > Additionally, to address the issue of do_main_cpsw0_qsgmii_phyinit=
 being
>> > > > 'undefined' for other platforms, replace:
>> > > > 	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
>> > > > with:
>> > > > 	if env exists do_main_cpsw0_qsgmii_phyinit;
>> > > > in ti_common.env.
>> > > >=20
>> > > > Fixes: 27cc5951c862 ("include: env: ti: add default for do_main_cp=
sw0_qsgmii_phyinit")
>> > > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> > > > ---
>> > > >=20
>> >=20
>> > [TRIMMED]
>> >=20
>> > > > diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_comm=
on.env
>> > > > index 03e3267ef8a..a0ed83f52ac 100644
>> > > > --- a/include/env/ti/ti_common.env
>> > > > +++ b/include/env/ti/ti_common.env
>> > > > @@ -22,11 +22,10 @@ get_fit_overlaystring=3D
>> > > >  	done;
>> > > >  get_fit_config=3Dsetexpr name_fit_config gsub / _ conf-${fdtfile}
>> > > >  run_fit=3Drun get_fit_config; bootm ${addr_fit}#${name_fit_config=
}${overlaystring}
>> > > > -do_main_cpsw0_qsgmii_phyinit=3D0
>> > > >  bootcmd_ti_mmc=3D
>> > > >  	run init_${boot};
>> > > >  #if CONFIG_CMD_REMOTEPROC
>> > > > -	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
>> > > > +	if env exists do_main_cpsw0_qsgmii_phyinit;
>> > >=20
>> > > The patch looks good to me however I wonder if we should factor out
>> > > cpsw0_qsgmii related envs out of ti_common.env since as far as I can
>> > > tell we only seem to be using it for the j721e/j7200 devices.
>> >=20
>> > Please refer to the following commit from 22 July 2023:
>> > https://github.com/u-boot/u-boot/commit/4ae1a2470ce7895b747c85a140aaf8=
b647ae6a32
>> > The commit added:
>> > 	run main_cpsw0_qsgmii_phyinit
>> > in include/environment/ti/ti_armv7_common.env and ti_armv7_common.env
>> > eventually got renamed to ti_common.env by:
>> > https://github.com/u-boot/u-boot/commit/bf9c61acb6caed97114029d2dc1e91=
b148cd9b8a
>> >=20
>> > Although I agree with your feedback in that it will make more sense fo=
r
>> > do_main_cpsw0_qsgmii_phyinit to be present in the board specific env, =
given
>> > the background pointed out above, it seems to me that we are simply go=
ing
>> > in circles by undoing the changes that were previously made. Neverthel=
ess,
>> > if you think that it should be moved to the board environment, I will =
do so
>> > in a future cleanup patch.
>>=20
>> The patch that added main_cpsw0_qsgmii_phyinit was actually based on the
>> commit 14439cd71c1a ("configs: k3: make consistent bootcmd across all k3
>> socs") where main_cpsw0_qsgmii_phyinit was factored out form the
>> j721e/j7200 defconfigs to the common env. I think this could be better
>> handled by having a board level hook such as follows:
>>=20
>> 	--- a/include/env/ti/ti_common.env
>> 	+++ b/include/env/ti/ti_common.env
>> 	@@ -22,14 +22,10 @@ get_fit_overlaystring=3D
>> 		done;
>> 	 get_fit_config=3Dsetexpr name_fit_config gsub / _ conf-${fdtfile}
>> 	 run_fit=3Drun get_fit_config; bootm ${addr_fit}#${name_fit_config}${ov=
erlaystring}
>> 	+init_board=3D
>> 	 bootcmd_ti_mmc=3D
>> 		run init_${boot};
>> 	-#if CONFIG_CMD_REMOTEPROC
>> 	-       if env exists do_main_cpsw0_qsgmii_phyinit;
>> 	-               then run main_cpsw0_qsgmii_phyinit;
>> 	-       fi;
>> 	-       run boot_rprocs;
>> 	-#endif
>> 	+       run init_board;
>
> This assumes that it is defined for all boards and we will run into the
> following error for those boards which don't have it in their env:
> 	## Error: "init_board" not defined
> So it needs to be updated to:
> 	if env exists init_board;
> 		then run init_board;
> 	fi;
>

I thought setting init_board to empty string above would've taken care
of that but I can incorporate your suggestion as well, thanks :)

>> 		if test ${boot_fit} -eq 1;
>> 			then run get_fit_${boot}; run get_fit_overlaystring; run run_fit;
>> 		else;
>>=20
>> with init_board being used as required in the board's env as follows:
>>=20
>> 	--- a/board/ti/j7200/j7200.env
>> 	+++ b/board/ti/j7200/j7200.env
>> 	@@ -34,6 +34,13 @@ main_cpsw0_qsgmii_phyinit=3D
>> 		fi;
>> 	 #endif
>>=20
>> 	+#if CONFIG_CMD_REMOTEPROC
>> 	+init_board=3D
>> 	+       if env exists do_main_cpsw0_qsgmii_phyinit;
>> 	+               then run main_cpsw0_qsgmii_phyinit;
>> 	+       fi;
>> 	+       run boot_rprocs;
>> 	+#endif
>> 	 #if CONFIG_TARGET_J7200_A72_EVM
>> 	 rproc_fw_binaries=3D 1 /lib/firmware/j7200-mcu-r5f0_1-fw 2 /lib/firmwa=
re/j7200-main-r5f0_0-fw 3 /lib/firmware/j7200-main-r5f0_1-fw
>> 	 #endif
>
> With the minor comment above, this diff looks good to me. Please let me
> know if you plan on posting the patch for it.
>
> Additionally, since this is unrelated to the current patch, please
> acknowledge that you have no concerns with the current patch.
>

Yeah, I can post the refactor once your patch is merged to which I have
no objections to.

Reviewed-by: Anshul Dalal <anshuld@ti.com>
