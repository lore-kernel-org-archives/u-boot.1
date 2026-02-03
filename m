Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7644E83059
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 06:35:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA46383FB2;
	Tue,  3 Feb 2026 07:35:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QOSz+CSm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADF1083FBE; Tue,  3 Feb 2026 07:35:32 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4922883FA4
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 07:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvrAi7lhNensglD407r+OCkH1KqSjsf0mZ0JYwHkhP/VhvwZNDBJzcLymDiqGaeXEyjWCmVfDD/E4GIqWqlX4AQMd6xiohi3J/2+RX8uBLR4k6p2REMSHfrKzCO6OPsQTMX9kkMzkSk9QPMCSFIYsbRUsyuYtNKTuAq0N6rr/fGS9Vsjp3az3t/32McxrprMqm7+JeA5cICBoiIlfIjDXL7CT/e2JGCs46TDnhVzBVPbxRuWJey4fTD1z61yLv1Ko3Wcn3WuvgF2ovj0y6dolwD+VvGCZSB3dGpMoS91goeeH9rGROLNKFQwZCm+U9fpneM8vusvJ9R6JcQjmfVT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jo/i2kQFdZlCjYlXcJQ2wgDB8uxwD9oEvglkJBsay5E=;
 b=jF+JIUoyZUcfObx4xO/WnubItSIfdDYsWzcElfXB87Ukz0wTEXZ6+iw0W0guFlqVeRx+dY44yTZdnBuyRh3hcyUNgTydfNAb79z+S+QoOEfVIh1ye701R9HS3ay/ZtkOIpzpJjpfm3pBPze3YDhuT9J4fH9PpcKXI19xqdp/XM9bQLzwjmgqDroBUvGmGdTa5yyJx1ePpYW2MrwL81SPgpeuiHrfnezipkuQScW7HP4eAfDZcwFtdZJIxMQ4AYlZsxFPFl1KdQ60DDUCxTgQLd99JDp7Sy5h0wvlJorSfT7k/QLJswW2MbhLViJqGNm8PcGjQK7279QqS+EYNjBoPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo/i2kQFdZlCjYlXcJQ2wgDB8uxwD9oEvglkJBsay5E=;
 b=QOSz+CSmKy5ODbu+lzOLFQ9fAKmRxvwnV34M9VdBO5ex4p1TOSNIIcSoZEDfhCWIHnmCHgCH15gehEst6ypDeYG5mLLt1QQzPeIG8MZaIZHbjhdzWev/LRAeZTUyV7cedgiOA0988WDrtQOstqynbPR4TJH6TQCktWwfDi6PMo8=
Received: from BN9PR03CA0946.namprd03.prod.outlook.com (2603:10b6:408:108::21)
 by SN7PR10MB6524.namprd10.prod.outlook.com (2603:10b6:806:2a7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Tue, 3 Feb
 2026 06:35:21 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::32) by BN9PR03CA0946.outlook.office365.com
 (2603:10b6:408:108::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 06:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 3 Feb 2026 06:35:20 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 00:35:16 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 00:35:16 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 00:35:15 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6136Z9Ej3058492;
 Tue, 3 Feb 2026 00:35:11 -0600
Message-ID: <395d53ef43d07361c96422050f3293770ad77f1e.camel@ti.com>
Subject: Re: [PATCH] board: ti: j721e,j7200: fix do_main_cpsw0_qsgmii_phyinit
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <trini@konsulko.com>, <joe.hershberger@ni.com>, <afd@ti.com>,
 <n-francis@ti.com>, <b-padhi@ti.com>, <ilias.apalodimas@linaro.org>,
 <peng.fan@nxp.com>, <jerome@forissier.org>, <neil.armstrong@linaro.org>,
 <d-gole@ti.com>, <j-humphreys@ti.com>, <semen.protsenko@linaro.org>,
 <bb@ti.com>, <m-chawdhry@ti.com>, <mkorpershoek@kernel.org>,
 <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Date: Tue, 3 Feb 2026 12:06:34 +0530
In-Reply-To: <DG53OSN3N49J.2M9OUUKKK410P@ti.com>
References: <20260202141058.648965-1-s-vadapalli@ti.com>
 <DG52P91F2IJ0.13IQHK33CRF1E@ti.com>
 <68206f3ce6dffdf7c42d81d24091426497a5ab91.camel@ti.com>
 <DG53OSN3N49J.2M9OUUKKK410P@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SN7PR10MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: f066982f-26f4-4f63-8d1b-08de62ee6741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVlFQkFhcGJ6QndLb2U0WnphNGtaTVZ4ajlMUEFOcmlTYlBGVi9yVDhXSGkx?=
 =?utf-8?B?Mmw2K2JadnQxd1pIWFlUYkMwWXRXMlVDZUJERVFWU3lyUGpXb2RGYWc2blZT?=
 =?utf-8?B?bHFEV0MyZER2RlpCdDFNQVBOZDBlbzZjSmpCRUp1Um9BNnhyckZEWmlWUlMw?=
 =?utf-8?B?cFgrNlJQajhETC9TRUdMQ3pVTVdRZU5xYzZDekdSK042bENBYk9FUTBXWVpM?=
 =?utf-8?B?dHNCcnlHbWdRR3ppL3BUQ1U3Mkx4UXgzZjVrczNxWlQ0b0dKMC9uYkdSNENk?=
 =?utf-8?B?bVQxcDQ1TmVPelhCRjN0TWZEVXpScTVtZ0tSSk1jYjNpMGRVazE0Q1VxalJY?=
 =?utf-8?B?NSsyUVROalBPMFVSSVFKWndsZ3B6MTRaamtWOEJhTHZvN1ViNE05RldvNEF1?=
 =?utf-8?B?UE9NQTE2Q0dCVEkxREp5RzYvLzZ4VGowRnNiZldRN1hiVUV2blFOUFYvZlEx?=
 =?utf-8?B?SDZ5NklzbE1ZU1FpNXJSZFN3Vy92UDZtbXFGY3dFcXY1bjIrNHZtTkQzc1Ix?=
 =?utf-8?B?NnZOTTBvOXV0bFNBWThwQm1VVWVGa2FVbTNIMEhSMXpIaXZma2JGMHJONlUz?=
 =?utf-8?B?UVE2cXJ0bjk1UTEzNzdEMUhuUHJYck5wMEV6VXc4TmExbjBXcnlUdTd3Wk1s?=
 =?utf-8?B?WnJXOVpaZjdsclNLbTNQQmVuQWVwZXN3VmhaQUpnSlVkbmJMMXljR0xtNHRl?=
 =?utf-8?B?Q3VldnBoRVN3V0tXeFAyTDdyb21MKzl3K3hrZmorVFVEY1FHZkZ4VThQd0hQ?=
 =?utf-8?B?b3hwWWx5VEVJN1dBOFlwcjJCMEtkcTVtcDBzWHVKUlNsVlJFN3c0Mmd5Y1Q1?=
 =?utf-8?B?WDNFb1BXajV6TzVscUFGL3g2QTZmYXpXRW9DRUdWY2VZNExwcE00MzFrOHNL?=
 =?utf-8?B?LzBlenFzcGFlSmhWSGpWRzhnS2VMUUp6di9rMnZIUWI1b1J2U0Q3WG9KTDhF?=
 =?utf-8?B?MTdJR2hhZHhTdWhIQmRMeWllK3dNWmxtSGhzRys5MytVQ2N4UGRyVHZjN3RV?=
 =?utf-8?B?cUFYNEN6YTB3SVN6ekRiVHB2bXdKS0RpVnFpUTlibDhXb0tIS2t2QUhadkpH?=
 =?utf-8?B?RGN2eGcvaVZkd2FSc3pFakIvQ290RXJ5NmcxeG9RdWxVazZKL1QxdU9CSmE5?=
 =?utf-8?B?WW1qbWppT2tuTjY2ODBXUjF2cUltSGNoWVpRbGZKdWJ1WmlSeC9KTzV0N09M?=
 =?utf-8?B?VExUUmY3anBGd1JQUFVUelB1bmRHVVRzZE5GRGZSNCt0R1lVQ3B4MmFweGZE?=
 =?utf-8?B?WFFkUzhvV3JoZllHeXRIOHgraUhBamFyV0tDWUcxaHJPVzl4Ty9tR3V2dE5q?=
 =?utf-8?B?NEozOXZGdnJqRUhwejMzaDV4MHRuNzZKc1VjWVloai9xOGZBUFZLSDlHSWtm?=
 =?utf-8?B?U3piS2g3blFVUkNFN1RqMlk3RTNPSHMvV0V0MWZBeTRLeC9QdklGRUVLK1l5?=
 =?utf-8?B?WjNuM3IzOWswd3lXSDJGU3dESjErL1pEcG5kWk1JM1NnVkswVE10MEZLSVpz?=
 =?utf-8?B?RVdOUFB4T0hMaG9nL3MrZzlHQUY4MUhYRnNoeVNOdHNBd05DdDh4dDJXaExs?=
 =?utf-8?B?Yk9tcm1malRLOHE0SlVWSTZlVVdGU1l1T3JQcVNTMHlXY0dVWUpwRTBWS09L?=
 =?utf-8?B?ZXcxZ3VsMVN6QXYzMHV1RDdtZEZwY3pidG9GbjY5T0V3REc1QmJ3OFAwK0Jj?=
 =?utf-8?B?ejVrVnFBRCszVkpCZnVvS3UyVGdCdFk1ZFpSTDkxZE9yVnlvWHBYSjZGbFVK?=
 =?utf-8?B?Nm13eTFnRFhMWm1vRjlENlEzcEp5TVVwR3JaOXUrY3lFdUJLME5VaGxvNXVW?=
 =?utf-8?B?ZU1QLzdzTllFT0JjelZ0ZTBkb2Z5L0NLd1lPeStLcmRvZUhtT3VjZ2VlR2pv?=
 =?utf-8?B?UTBDaGVxZmtjWGxHc3FQdlk4SzVBcFFEdERGUzZMbFFmT3pSSi9TSzVxbDBt?=
 =?utf-8?B?d3FuVEhPUElEZ2E3QjhTeTNXSmdsQXU1TGVrMzBxTXQyN09Mcm0rMEZmOE9N?=
 =?utf-8?B?MlpEZ3hCZWF1cUJIZUlKSXl2WXZ5NC95UVc2WVZKWDdTMFBhbVd0OUt5MDlz?=
 =?utf-8?B?eUZJS3NLVzBMWkI5dFVOUE9zcjNsV0NCRldYelkrTU03TjdEbkFuNDRYZ09o?=
 =?utf-8?B?cnVCckY2aHNXY2RIck1nV3owazUyVG1SbUhXS1lzR2EzaEFBNytaNUJuQW9I?=
 =?utf-8?Q?TfdKPaomC6h7KJI4pZIOgHc=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NiXGPtN78gxtSDqPit/mVdjXUxdwpu2hIxNyHmUzWkHPyyl5ADr6J2U8VYohfaoMzVa6IDNV5DedpcoUZNUVVOkb0U0csDTbpdgstxePtMGhWviUGdkFsGTRDMZhwpiAOFSYaUz8QVGdkgfAxkYzJtk/tlLjgFqQi9QsC7mw6g4QLjsMCFDiR6yHJ1zmkcRKKmGsmBEMCpaHm/cfn3I7SVR35cdPUGoTa3BLGO8F2tYt1119qvc2Mj26auMLlN/mdQwRrmbb6VWSGnAfp7wC2IDoZy9hWsmtHIrE+o7aCvUm7T2pBvzqletrB++uvVXLObAtgLasQMBlc91fG85PskFHrNuvai0VnJUXuT1HT1wUSjKQGAWk9ZhJNK5tUjsE+cTc14Fhsg18qmoKHl9eyjEoODs45D5Kz3YRfyFErbeM6l3bZyRVWMAMiqmc5aRA
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 06:35:20.6019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f066982f-26f4-4f63-8d1b-08de62ee6741
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6524
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

On Tue, 2026-02-03 at 11:38 +0530, Anshul Dalal wrote:
> On Tue Feb 3, 2026 at 11:11 AM IST, Siddharth Vadapalli wrote:
> > On Tue, 2026-02-03 at 10:51 +0530, Anshul Dalal wrote:
> > > On Mon Feb 2, 2026 at 7:40 PM IST, Siddharth Vadapalli wrote:
> > > > Since commit 27cc5951c862 ("include: env: ti: add default for
> > > > do_main_cpsw0_qsgmii_phyinit"), the value of the environment variab=
le
> > > > do_main_cpsw0_qsgmii_phyinit happened to remain '0' and couldn't be
> > > > changed without user intervention. This behavior is due to the foll=
owing
> > > > cyclic dependency:
> > > > A) ti_common.env sets do_main_cpsw0_qsgmii_phyinit to '0' and its v=
alue
> > > >    can only be updated automatically by main_cpsw0_qsgmii_phyinit.
> > > > B) main_cpsw0_qsgmii_phyinit is defined in j721e.env and it can run=
 only
> > > >    if 'do_main_cpsw0_qsgmii_phyinit' is already '1' which isn't pos=
sible
> > > >    unless the user manually assigns the value.
> > > >=20
> > > > Fix the aforementioned cyclic dependency by using board_late_init()=
 to
> > > > detect the QSGMII Daughtercard and set do_main_cpsw0_qsgmii_phyinit=
.
> > > >=20
> > > > Additionally, to address the issue of do_main_cpsw0_qsgmii_phyinit =
being
> > > > 'undefined' for other platforms, replace:
> > > > 	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
> > > > with:
> > > > 	if env exists do_main_cpsw0_qsgmii_phyinit;
> > > > in ti_common.env.
> > > >=20
> > > > Fixes: 27cc5951c862 ("include: env: ti: add default for do_main_cps=
w0_qsgmii_phyinit")
> > > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > ---
> > > >=20
> >=20
> > [TRIMMED]
> >=20
> > > > diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_commo=
n.env
> > > > index 03e3267ef8a..a0ed83f52ac 100644
> > > > --- a/include/env/ti/ti_common.env
> > > > +++ b/include/env/ti/ti_common.env
> > > > @@ -22,11 +22,10 @@ get_fit_overlaystring=3D
> > > >  	done;
> > > >  get_fit_config=3Dsetexpr name_fit_config gsub / _ conf-${fdtfile}
> > > >  run_fit=3Drun get_fit_config; bootm ${addr_fit}#${name_fit_config}=
${overlaystring}
> > > > -do_main_cpsw0_qsgmii_phyinit=3D0
> > > >  bootcmd_ti_mmc=3D
> > > >  	run init_${boot};
> > > >  #if CONFIG_CMD_REMOTEPROC
> > > > -	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
> > > > +	if env exists do_main_cpsw0_qsgmii_phyinit;
> > >=20
> > > The patch looks good to me however I wonder if we should factor out
> > > cpsw0_qsgmii related envs out of ti_common.env since as far as I can
> > > tell we only seem to be using it for the j721e/j7200 devices.
> >=20
> > Please refer to the following commit from 22 July 2023:
> > https://github.com/u-boot/u-boot/commit/4ae1a2470ce7895b747c85a140aaf8b=
647ae6a32
> > The commit added:
> > 	run main_cpsw0_qsgmii_phyinit
> > in include/environment/ti/ti_armv7_common.env and ti_armv7_common.env
> > eventually got renamed to ti_common.env by:
> > https://github.com/u-boot/u-boot/commit/bf9c61acb6caed97114029d2dc1e91b=
148cd9b8a
> >=20
> > Although I agree with your feedback in that it will make more sense for
> > do_main_cpsw0_qsgmii_phyinit to be present in the board specific env, g=
iven
> > the background pointed out above, it seems to me that we are simply goi=
ng
> > in circles by undoing the changes that were previously made. Neverthele=
ss,
> > if you think that it should be moved to the board environment, I will d=
o so
> > in a future cleanup patch.
>=20
> The patch that added main_cpsw0_qsgmii_phyinit was actually based on the
> commit 14439cd71c1a ("configs: k3: make consistent bootcmd across all k3
> socs") where main_cpsw0_qsgmii_phyinit was factored out form the
> j721e/j7200 defconfigs to the common env. I think this could be better
> handled by having a board level hook such as follows:
>=20
> 	--- a/include/env/ti/ti_common.env
> 	+++ b/include/env/ti/ti_common.env
> 	@@ -22,14 +22,10 @@ get_fit_overlaystring=3D
> 		done;
> 	 get_fit_config=3Dsetexpr name_fit_config gsub / _ conf-${fdtfile}
> 	 run_fit=3Drun get_fit_config; bootm ${addr_fit}#${name_fit_config}${ove=
rlaystring}
> 	+init_board=3D
> 	 bootcmd_ti_mmc=3D
> 		run init_${boot};
> 	-#if CONFIG_CMD_REMOTEPROC
> 	-       if env exists do_main_cpsw0_qsgmii_phyinit;
> 	-               then run main_cpsw0_qsgmii_phyinit;
> 	-       fi;
> 	-       run boot_rprocs;
> 	-#endif
> 	+       run init_board;

This assumes that it is defined for all boards and we will run into the
following error for those boards which don't have it in their env:
	## Error: "init_board" not defined
So it needs to be updated to:
	if env exists init_board;
		then run init_board;
	fi;

> 		if test ${boot_fit} -eq 1;
> 			then run get_fit_${boot}; run get_fit_overlaystring; run run_fit;
> 		else;
>=20
> with init_board being used as required in the board's env as follows:
>=20
> 	--- a/board/ti/j7200/j7200.env
> 	+++ b/board/ti/j7200/j7200.env
> 	@@ -34,6 +34,13 @@ main_cpsw0_qsgmii_phyinit=3D
> 		fi;
> 	 #endif
>=20
> 	+#if CONFIG_CMD_REMOTEPROC
> 	+init_board=3D
> 	+       if env exists do_main_cpsw0_qsgmii_phyinit;
> 	+               then run main_cpsw0_qsgmii_phyinit;
> 	+       fi;
> 	+       run boot_rprocs;
> 	+#endif
> 	 #if CONFIG_TARGET_J7200_A72_EVM
> 	 rproc_fw_binaries=3D 1 /lib/firmware/j7200-mcu-r5f0_1-fw 2 /lib/firmwar=
e/j7200-main-r5f0_0-fw 3 /lib/firmware/j7200-main-r5f0_1-fw
> 	 #endif

With the minor comment above, this diff looks good to me. Please let me
know if you plan on posting the patch for it.

Additionally, since this is unrelated to the current patch, please
acknowledge that you have no concerns with the current patch.

Regards,
Siddharth.
