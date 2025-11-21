Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AE2CFC275
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 13:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 824DC837F2;
	Fri, 21 Nov 2025 14:24:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vRx8rVon";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C0F18382A; Fri, 21 Nov 2025 14:24:35 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C5480433
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 14:24:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jq1gP0gGckFEOUt5MpuqGIFiSdnOgjj3xS1WGRa1WDAGWnzWsX/IAluXdPiKDeaPFLC98J6e9MpcV0fNspWxea+ptZmRYlb1MpPCWwemOPVqJwI4oE0dpapx/ekz8pRoC9GjXcLXXXpKIOO7YRP3PC/mbmPfXqU10afqALkE0YwuR0MHYkb76NphzVdQIgTNknqYSblzO2LRnSEwRs1ujNZVgRNNlOJ7elNZvdBq48ulSpQiEUGnNu9iNtpivPTU4w1s7q2SZWKbZtAS1NWf36hM6pgO/leqGOHx+6103ko/YhHJRgujHk2aWMM8bURpk3Rq9ioQOWuOlEv/FBSwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bz4o+mhFzK4NOw1yRJOnHXeTxTLERy4Y8HMnqSaPY+U=;
 b=DdDa7AYSJD9X7xd3NDF67hLb10JbKR9kqsvyO15FNOUL64bI9is7jPtG7kPRrKZ2PKRoHo0PIfYKel4EyIMgU/NHTvvQ8yHBtjxczcpKYncbBqRHukCuufrv9eNx2NE/ueQr4N52woGV5MXVL9CTFqa1g3IKOBnKwZCe+NoJRSONpG88NnZ24LP7iUMAdLGrcUuIihUxe5r91sPEjuJvzqu4Tnkf6cEaNrtMf07zJkwjO38oEfhgAugaAhWycfQXVw8vSlmP/O89Ih1pur8PpyCMjUAYknrRlLwPGaXjXGQyo95BRC9QjME/8/K6dATs7IOsgosqxeiuguoSFwyBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz4o+mhFzK4NOw1yRJOnHXeTxTLERy4Y8HMnqSaPY+U=;
 b=vRx8rVonhDqP5HDZnbFWngAnL6tsnwDiKNB8lWkLkxZwksIhxwAq9y4F9fMBufogdZOI1F96vFYNycac2i1ckNkkWLJRSFrlTK3A4zfa0fnjOcgjRhy1jxo+Bl2Rf5D5fh5cbgsDu2iGmQvnbjC4mTZv3Yg6tSd6W5yiLYYEK0k=
Received: from SJ0PR13CA0226.namprd13.prod.outlook.com (2603:10b6:a03:2c1::21)
 by MW4PR10MB6511.namprd10.prod.outlook.com (2603:10b6:303:225::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.12; Fri, 21 Nov
 2025 13:24:29 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::2d) by SJ0PR13CA0226.outlook.office365.com
 (2603:10b6:a03:2c1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.5 via Frontend Transport; Fri,
 21 Nov 2025 13:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 13:24:28 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 07:24:18 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 07:23:54 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 21 Nov 2025 07:23:54 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ALDNld71283850;
 Fri, 21 Nov 2025 07:23:48 -0600
Message-ID: <3217be04f95adf2f5813fd726a964adb338e68eb.camel@ti.com>
Subject: Re: [PATCH v4 01/21] net: ti: am65-cpsw-nuss: Define bind method
 for CPSW driver
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: Chintan Vankar <c-vankar@ti.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Santhosh Kumar K <s-k6@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Bhavya Kapoor <b-kapoor@ti.com>, "Parth
 Pancholi" <parth.pancholi@toradex.com>, Andreas Dannenberg
 <dannenberg@ti.com>, Moteen Shah <m-shah@ti.com>, Beleswar Padhi
 <b-padhi@ti.com>, Anshul Dalal <anshuld@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Neha Malcom Francis <n-francis@ti.com>, "Prasanth
 Babu Mantena" <p-mantena@ti.com>, Simon Glass <sjg@chromium.org>, "Alexander
 Sverdlin" <alexander.sverdlin@siemens.com>, Kishon Vijay Abraham I
 <kishon@ti.com>, Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Jayesh Choudhary <j-choudhary@ti.com>, "Vaishnav
 Achath" <vaishnav.a@ti.com>, Bryan Brattlof <bb@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <s-vadapalli@ti.com>
Date: Fri, 21 Nov 2025 18:54:06 +0530
In-Reply-To: <8b4ac072-125c-493b-b12a-f0a4e9d56e7e@phytec.de>
References: <20250731075956.605474-1-c-vankar@ti.com>
 <20250731075956.605474-2-c-vankar@ti.com>
 <8b4ac072-125c-493b-b12a-f0a4e9d56e7e@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|MW4PR10MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: c244878f-aafa-4e6e-d478-08de29014c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z09UeWErdmNNc3dzYUN1UWgwdGsvZzVqSXJjZnFDeFBQSWVsVUJ5SVoxcTUr?=
 =?utf-8?B?cW5RVHBmTzltTlRMb21yZURZM3liMHlKMFRSSkdINXplaUhzWFQrbjZFL0xS?=
 =?utf-8?B?VVgwR3lueDlmT2pDTGVlT2xyL3FZbURad1B6WmJRd3lQaXpFeG1vMjZaSW16?=
 =?utf-8?B?UXFCWlZDNTVLNGNyK0RVTGZNUXkzRGhnQkFZWTFJUUdoY2N1dXJiWFFRVnFp?=
 =?utf-8?B?SU5aMGVnM2V1WVRVYTdzQ2p5VDZMNnRqYVJOMy9aSE54OStHQVkvQ1g3K3g4?=
 =?utf-8?B?Y2h4a080UEwrNWpyWWRsN1pTMnk5NWpRL0FlWE9GM21yN1ZmcEVadGJOOTd1?=
 =?utf-8?B?bEt5ZlZ5Zmdzb1pqVUlpcjdNS1NoNjRhL3JZZHFwcFhOQkU1bUMvM2VFYkJ4?=
 =?utf-8?B?QkRpdU1teFRaanFSd2xia0w2Vkd3TzRnd21NbkNoVU0vb05UTEtEQUM5a0s2?=
 =?utf-8?B?RVp1WGVZcWcyd3NSaGhHWmlqVTdNUlBENVErQzQwVjJsRUxYaFFFeVhoTUFN?=
 =?utf-8?B?YXo2cDkxNWhyMXFoT3BUWFE2TFJGV1NRS3ZaVVh5T2xrbGpKN0lnNW9oZVJp?=
 =?utf-8?B?bER6OVBZb01YZncvcWZsR3hqZlFIMjF0STJ5MzFMTkVOY2YyS0JGaWpGa1cw?=
 =?utf-8?B?dGRnL2REMGx3TWc1N2d2SHYrcWhZQ0hha2tvSWhod2c3eFhGdnlHaUhIcGdj?=
 =?utf-8?B?RnB1TENwVit2c3lGcmlIUVg0alJSamgyL0d2WHJiaVlMYVZ3OGpneVE1ODNt?=
 =?utf-8?B?UUVKV2VoL2ZtSGV4ZEZTY3pCTVFFcVhZbDd0QndKTTR3ejV5R1BEamVvTUJl?=
 =?utf-8?B?UzlKUUNCYmVwWDgwdHcxZ3dHQitBUjBtWENLUmlQTWVVc0QweUdhVC9CTTFZ?=
 =?utf-8?B?NXVJMzB5L0hKbHluS0FNM21NRjVqcVF5QWtZSVk5VGNPQmIvRVh6R1FSakVz?=
 =?utf-8?B?S2RsQmhlS1F5Z2xCVEx6aS9OTVp5ZjdNZHFsWTNZbDF4dVZiS2MwMkROWkJy?=
 =?utf-8?B?RitTcGhoL0FaYnVFR3NxM1k0bU04eVBiOTYzNERtay9sZGxqVm9lZ0pnMEFT?=
 =?utf-8?B?RkxnR0JqZnV4UmhCRzIveUxvZmJqTGdTSEJlTTRwQi82YzlheG85a3BTTjFK?=
 =?utf-8?B?VEhwYlNlVERwSW56aTVVTURzdGQ1YjU3TnFEUGltbWRXcnl0eS9tUGdJb3h3?=
 =?utf-8?B?K2h1VzhsVkxaTFlPaTZWNm1rU1dTTkhMUlptWW1NOVFIUkVnYmQ4Rm1TZ0Ir?=
 =?utf-8?B?c3VhTUNjRWg3UFNNVWZ5dzI3dW1BcWpIU0FCdFFGTlVSM245cWpiOXNjaEJn?=
 =?utf-8?B?blNnK29URXJJUVlhMVU1N2VTS1JnaE1vOTlxd000VVpsZTgvRnM1NW9BVUcw?=
 =?utf-8?B?K2VOT1ZURm5zOHNLbXpnbGQ1cFVNYTlGeU55V2R0dGRzeWhjcWF1bXkvS3dY?=
 =?utf-8?B?SkkyaHZWOEtHbk13aW43WFFxKzdhUS9QM1BKUmEwaGg1NHFvWDhRWVA0T1E3?=
 =?utf-8?B?MzByempNSCtKOG85MFNGcXNhQU8yY1FrZlhhR0NJazlkTzFUSzhwQms4QllP?=
 =?utf-8?B?ZmZ1OWg4VFZJZDhyU1FBdDdaOFJSdk9PdHpGc1hSTU5TN1JmWGtHdTY4eTNt?=
 =?utf-8?B?NjdveHRvZGJZR3pPZm44NGN4SEFZeTd2bzZWYmp2MTdNMWplWTNUTFFYaVI0?=
 =?utf-8?B?UU9DOWFqTXhacnBiTlk0dmtnTmVIb1QxTjJKTUlxT1BmVDczKzUyWlRyTTZz?=
 =?utf-8?B?UzB3bWJwa0N3azdhOUpTZ1BqSXc0TDFLTkFuOGR1WkJlQk9QcHJDMFgwdEpT?=
 =?utf-8?B?R1Nsa3lVTm5nN2l6dzVPOEdBYnUvRmFzZnU2cDA3NjVaQkpBcTVXUHFUejRw?=
 =?utf-8?B?TUJObFVMUllrekZZdVliMjhkSlVSS2FMaDU5Yzl5Zk5pMENjSkNMVCsvY0Zn?=
 =?utf-8?B?U3NLOGF2S25CQTZRWVIwaHphZGNBY083ejFYNWhxNktPK2gyeVBiQit0NXhN?=
 =?utf-8?B?Lzc0WU9hclRvZUpLWUNxNVozS0RTU0ZmYzJSK0xpd2R6Z0l2WnBIUW9xWjUr?=
 =?utf-8?Q?dOItFp?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 13:24:28.3541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c244878f-aafa-4e6e-d478-08de29014c41
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6511
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

On Fri, 2025-11-21 at 14:55 +0200, Wadim Egorov wrote:
> Hi,

Hello Wadim,
>=20
>=20
> On 7/31/25 10:59 AM, Chintan Vankar wrote:
> > CPSW driver is defined as UCLASS_MISC driver which needs to be probed
> > explicitly. Define bind method for CPSW driver to scan and bind
> > ethernet-ports with UCLASS_ETH driver which will eventually probe CPSW
> > driver and avoid probing CPSW driver explicitly.
>=20
>=20
> I just noticed a new error message with this patch.
>=20
> On the phycore-am64x we can see that the 2nd cpsw port is getting probed=
=20
> but fails. This is not really an Issue because we are not making use of=
=20
> the 2nd port. But the error message does not look nice.
>=20
> Why is this even probed? The soc-level device tree disables the ports=20
> per default. And we do not activate it in our device tree.

Thank you for reporting this. I have just posted the fix at:
https://patch.msgid.link/20251121132156.3987128-1-s-vadapalli@ti.com

Regards,
Siddharth.
