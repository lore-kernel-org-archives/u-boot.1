Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE665E83058
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 06:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD3783FB2;
	Tue,  3 Feb 2026 07:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BwyNENXa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AAD783FB5; Tue,  3 Feb 2026 07:08:35 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F8B83FA4
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 07:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIm54EPUNSG0UZqTdKdGT3Qnf7wIHtHhmhhhxcDGwNoFtNozXyOR2Iz5UrusTme7/eI+SwjQ4IbOrEg+1ygIQzp7uMkrM/QIjQWSPeNMqn0rUyHTFtrtNg/eanBsUxDf+mzGCpq66SP0+YqdndHu7Zjk0s04Ux/WZUedLLmeso9RUSmXNpJmUHCmyR394oPiGwvPYhvgNKN+8fw8Bf0JCrFf/jGQ6UQMwztVQ0OEnnrUlVJvLT07Pe+cYQ0LzozbM0UYRWQevVoLyr3A3T36nT9rDrOzzWl2r1zjA/AQVkSLePh43ZmJVDF5tXWGTIJYrBMA4n/C8QjLA5q5wjFyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVqUnpP0IlwWbak5CCVxDZXIaFciYHx1yNfyM0w67GY=;
 b=TfiyITWaubB6D10DUl65kmyLFTJ0iJ32zy0DG+ukEIow5FLYcCS9fZTE0itfwm6V/xIF8y/+L3PoamZoycSstsAKllH8eut5Dk9q+d7SsJJvXvA/T6kRlbQXecirAJmihCGIsM13HztZjB8FFXLz7xqsxE/2JTCdPaNyUQrNlgT51ZDWpSHWAYCHJr0iKkn4Zo7ZL29svJ8sjMEvjaJeLajaONvEouUpgqPdyI5PnOQTha9Zq/3Qno3B4hbjcVcaN/21Dmu+Agt19kPETlC2m5RNsd0eU0gtZWj1ZwjkfiqFxCNu3rTKk9A9iXemUgj/TgNFHHrq6B4ke8dAhkU5yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVqUnpP0IlwWbak5CCVxDZXIaFciYHx1yNfyM0w67GY=;
 b=BwyNENXalWyozx+VgAev1jywVywaxDnPNiDoRFXb9glJb/ue+bxKqQ/4jkj9dc6xnWtevEo2FrNxpI9bV1afeVAz2HhJJ9rlTsGbPpBIkaKjx/+ePHDwmLVFrLOHX59x9oKmU6FhIp+dbmDA+sMICmGL9YPuIqBsl4q5wcdt7e8=
Received: from SA9PR13CA0105.namprd13.prod.outlook.com (2603:10b6:806:24::20)
 by PH0PR10MB997781.namprd10.prod.outlook.com (2603:10b6:510:3b1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 06:08:14 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:24:cafe::29) by SA9PR13CA0105.outlook.office365.com
 (2603:10b6:806:24::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 06:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 06:08:13 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 00:08:13 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 00:08:12 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 00:08:12 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61368BSd3440226;
 Tue, 3 Feb 2026 00:08:12 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 3 Feb 2026 11:38:11 +0530
Message-ID: <DG53OSN3N49J.2M9OUUKKK410P@ti.com>
CC: <trini@konsulko.com>, <joe.hershberger@ni.com>, <afd@ti.com>,
 <n-francis@ti.com>, <b-padhi@ti.com>, <ilias.apalodimas@linaro.org>,
 <peng.fan@nxp.com>, <jerome@forissier.org>, <neil.armstrong@linaro.org>,
 <d-gole@ti.com>, <j-humphreys@ti.com>, <semen.protsenko@linaro.org>,
 <bb@ti.com>, <m-chawdhry@ti.com>, <mkorpershoek@kernel.org>,
 <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH] board: ti: j721e,j7200: fix do_main_cpsw0_qsgmii_phyinit
From: Anshul Dalal <anshuld@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260202141058.648965-1-s-vadapalli@ti.com>
 <DG52P91F2IJ0.13IQHK33CRF1E@ti.com>
 <68206f3ce6dffdf7c42d81d24091426497a5ab91.camel@ti.com>
In-Reply-To: <68206f3ce6dffdf7c42d81d24091426497a5ab91.camel@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH0PR10MB997781:EE_
X-MS-Office365-Filtering-Correlation-Id: eaccf08c-f6d5-4f90-4820-08de62ea9d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnJpK0E0YzkzdjBKSEp1b3hVQmgvTkJpUnV2aE1sNm1mYWp2SnVKMjdYZXRl?=
 =?utf-8?B?aFNPWVFTZUdqMDM3VE9QNnh5WmVSY2orSHdKYXVMaUw5eG5JcDNtazZ6bkk0?=
 =?utf-8?B?cHdtU3NaWHBDa0dJT09EUllXSStIWlNYYldlTzRBRENjRTNKdkhZVkpqTDI0?=
 =?utf-8?B?bFpNMmNVTlFqQm1FTGlBVDRjTFNSQkVGZEU1S2tNZ041bmd3eWtNYlJWb1FZ?=
 =?utf-8?B?S2NoUXJ5b29vd3JCZDlQRFRaYlBXNkt1TXNWOXVkSXViWUdyRmE4WTlLQi9P?=
 =?utf-8?B?b2NIbFlaUG8zZ0VZRFFZYlZGY3FTV3BCcmVYcEtZK2RnVllvQ0ZLRXdNZlJt?=
 =?utf-8?B?bS8zaWlMZWtETEh0TnpGUGJRVElqRWVZeVJ6UU9JdmI2aUNtMHkxcTRKQ0U2?=
 =?utf-8?B?c0xVYld3TmR3aWJUcmFzZFd2NkttYjIwaTRNcjVzczVZWEQ5Z3dBenI4SjZy?=
 =?utf-8?B?Q0pZYjZMYlRNY3VtU1JkdFVtbFRPL3JpQmJNYy84UEFTV1NsanJrTjNXdXJa?=
 =?utf-8?B?TWYzR1JiZ2RkTkUzZFMwbmVsM09lck0xNFF1T2Y1NVlodDdKY2ZobC94YUpK?=
 =?utf-8?B?VTg0Q2RpSzRpSjhsenZIbmJDUHBPcjVoZnVHRDlZNDdCRHJodTVUTG1Za2RG?=
 =?utf-8?B?aHREZjlJTjA3YzlraVBXbGRZRzZPSFBPUThpZ1U3SnNkdy9wdXl0R3BjNmpu?=
 =?utf-8?B?QWVHM0JCdk1WeEpkVmlIQ3ZmSHR0aWlkeC9ob2U1djg5K3dZUjBZcVNmSXVM?=
 =?utf-8?B?QmhKYXRVS0pWUGZoakcyeVJneU1zZXBIeHJVSmhxNFE2VVRHZGZ4MEJ5RUdr?=
 =?utf-8?B?K3c1L1pkVEtOZWcvMTFhWk1QSjdlNFArVmUyTlI0RmIrRFhzNHRWNW1pKzFF?=
 =?utf-8?B?eXROMnJvVFhmbGMxbkdPTFZHL3krVUdCQ3A3UUtWOVJrdnRTU0ovaDN4bzU0?=
 =?utf-8?B?alVRSWpWWUxsblkyaXBzNkR0RndiaDYvci9UK3NIeFZqLzN6c1FLVTBXS2NG?=
 =?utf-8?B?OGp5RExUOEU0MCt2MmVmclY1bmk4NE1vMDVuZ3NKcCszekh0UjhqR2hWVUt4?=
 =?utf-8?B?bFBHeTZPZDErV3dUeld3c2oxMVBNZzhNb245aGU2eFpyeWhJcHE5bDlIU2l5?=
 =?utf-8?B?U25rT1NkR21LQS9TeFdUVVJJRjg4OTA4VHdRakFOdEVDWjIzQlZSdGYxZ3Vh?=
 =?utf-8?B?SXpaOElrL3A3YWd1QXdPYXVRQnRrTlpPY3BlY2UvRXlDS1VPWlpPU05tTDhv?=
 =?utf-8?B?bVczaDgzT21peEt1b0hhZFhkUXZWa1g4MC9iRGRUSXVPM0VFdERkL0ovbTdW?=
 =?utf-8?B?L1cyVE02K1R2d05VOHhVUWNLWXhRdXVuRVpsTzBVYmVSb3NuelFrR3hBaEhW?=
 =?utf-8?B?bHNjdjVQNUJ6Q0pHdU10SFpQeTB0QlRNWG00ZGxtV2YvMkpSS1hBbEh2REty?=
 =?utf-8?B?UXFvOC9vNEJ4RFF0Wk85RTB3Y3dPSnJnU1VvZmh3bkdOV1hzTDRXQ2kvK3Fw?=
 =?utf-8?B?a0IzMkovZDBoVE5lZ2JQYkRNSGVDZlh6WDBvUW1EUmVDQkwzd0pYMkdKNnpM?=
 =?utf-8?B?VUtOZitxUzhVVDVwdGJWYmd0VHNNR0lZenA5cjNuRFVLNUQ1NHNMak1xWTEy?=
 =?utf-8?B?Nmw2N2hoR256SlZ1bURmeVIrYlFySnJaeTUxYm1QOGtKY29IeGs1UzdCTWUw?=
 =?utf-8?B?blZGOEUzdnV2YWZaOEFWSVZqZ3RFdUxEU1hldGYwS1RsM1o0RlRXQzU0anYv?=
 =?utf-8?B?b09vT0NRLzR3YmpJeEZBU2VDS0c1QUx0NU5QTUdIRG16dHI3aVVaUlRuMkFU?=
 =?utf-8?B?QWpocVJqY3dyVmRUSXlwcWprZDdNYXJMMGl3RzRhOG53eHhFT0FacURzTmtU?=
 =?utf-8?B?Tkg2TXZvZDZCc2hpTFJqL0pWMW9FV1Z4cU82WE5aOThvaXl6T2RXMmZpcmto?=
 =?utf-8?B?V3A0OGhVbC9wZUNPZG9KU21vRTFHUTRhR3NtRWUwWWh6b2kwbXgzK3BRSzFq?=
 =?utf-8?B?ank1NWVDMWtGTmVESkhEQXduRGxLVys2ZlppYk9aVCtKUE5Vc0gwc2o2ekFP?=
 =?utf-8?B?SUF4WUNydzYwS3JhK0xyTHNzT1A3WkJJMmY5WHVJVUdXMUROODVORmF3eFF4?=
 =?utf-8?B?ZzErYk41K0ZsZjUxWUtyRVR3aXBHaVZaZElpV2JpT0x0cnB6V0Z2RTh1Ykt6?=
 =?utf-8?Q?+KVXUUMc35FT4cba2Oykf0k=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HjUjfaSuNZaYN4yqmLx1nP0J5/5CUc786ABobBzc2Abi5hUT97pVE54KDhs4peJinOrEbQzqxltTA4wUnev85eCnO87zKtaRZcoxbXF4AzEIcpSWId4jrWAVx3wONTglHJ4D/eVEgaraC1hGyj3YOtG3iJ7qLI5lizNiMt+L59laG16mv2FgTc2ztxnVqmNXxUbAZrEdOBzCREEp7kqglWyXh1BAJU3dS7LTHTctQvy/8BthZn/9QJGwxsVbWsec4DeADTd2n60xdEjzskFOnJ1lq44TS8aIRCtbdPchB0YoOwalNeQwYC2cSassRHPahnSAh8Uo+aJcJDMPFny6HGmSMliTHRvfnK8khyAEQw723XYGYT/kDY5rPWTYowAm2KePXW+jlP3F3CgPfZFVv/W+3BCqVkuJDSHRSP5OPq5+UQRNr6Hh7oKyc52jwCAf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 06:08:13.7536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaccf08c-f6d5-4f90-4820-08de62ea9d8c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997781
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

On Tue Feb 3, 2026 at 11:11 AM IST, Siddharth Vadapalli wrote:
> On Tue, 2026-02-03 at 10:51 +0530, Anshul Dalal wrote:
>> On Mon Feb 2, 2026 at 7:40 PM IST, Siddharth Vadapalli wrote:
>> > Since commit 27cc5951c862 ("include: env: ti: add default for
>> > do_main_cpsw0_qsgmii_phyinit"), the value of the environment variable
>> > do_main_cpsw0_qsgmii_phyinit happened to remain '0' and couldn't be
>> > changed without user intervention. This behavior is due to the followi=
ng
>> > cyclic dependency:
>> > A) ti_common.env sets do_main_cpsw0_qsgmii_phyinit to '0' and its valu=
e
>> >    can only be updated automatically by main_cpsw0_qsgmii_phyinit.
>> > B) main_cpsw0_qsgmii_phyinit is defined in j721e.env and it can run on=
ly
>> >    if 'do_main_cpsw0_qsgmii_phyinit' is already '1' which isn't possib=
le
>> >    unless the user manually assigns the value.
>> >=20
>> > Fix the aforementioned cyclic dependency by using board_late_init() to
>> > detect the QSGMII Daughtercard and set do_main_cpsw0_qsgmii_phyinit.
>> >=20
>> > Additionally, to address the issue of do_main_cpsw0_qsgmii_phyinit bei=
ng
>> > 'undefined' for other platforms, replace:
>> > 	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
>> > with:
>> > 	if env exists do_main_cpsw0_qsgmii_phyinit;
>> > in ti_common.env.
>> >=20
>> > Fixes: 27cc5951c862 ("include: env: ti: add default for do_main_cpsw0_=
qsgmii_phyinit")
>> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> > ---
>> >=20
>
> [TRIMMED]
>
>> > diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.e=
nv
>> > index 03e3267ef8a..a0ed83f52ac 100644
>> > --- a/include/env/ti/ti_common.env
>> > +++ b/include/env/ti/ti_common.env
>> > @@ -22,11 +22,10 @@ get_fit_overlaystring=3D
>> >  	done;
>> >  get_fit_config=3Dsetexpr name_fit_config gsub / _ conf-${fdtfile}
>> >  run_fit=3Drun get_fit_config; bootm ${addr_fit}#${name_fit_config}${o=
verlaystring}
>> > -do_main_cpsw0_qsgmii_phyinit=3D0
>> >  bootcmd_ti_mmc=3D
>> >  	run init_${boot};
>> >  #if CONFIG_CMD_REMOTEPROC
>> > -	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
>> > +	if env exists do_main_cpsw0_qsgmii_phyinit;
>>=20
>> The patch looks good to me however I wonder if we should factor out
>> cpsw0_qsgmii related envs out of ti_common.env since as far as I can
>> tell we only seem to be using it for the j721e/j7200 devices.
>
> Please refer to the following commit from 22 July 2023:
> https://github.com/u-boot/u-boot/commit/4ae1a2470ce7895b747c85a140aaf8b64=
7ae6a32
> The commit added:
> 	run main_cpsw0_qsgmii_phyinit
> in include/environment/ti/ti_armv7_common.env and ti_armv7_common.env
> eventually got renamed to ti_common.env by:
> https://github.com/u-boot/u-boot/commit/bf9c61acb6caed97114029d2dc1e91b14=
8cd9b8a
>
> Although I agree with your feedback in that it will make more sense for
> do_main_cpsw0_qsgmii_phyinit to be present in the board specific env, giv=
en
> the background pointed out above, it seems to me that we are simply going
> in circles by undoing the changes that were previously made. Nevertheless=
,
> if you think that it should be moved to the board environment, I will do =
so
> in a future cleanup patch.

The patch that added main_cpsw0_qsgmii_phyinit was actually based on the
commit 14439cd71c1a ("configs: k3: make consistent bootcmd across all k3
socs") where main_cpsw0_qsgmii_phyinit was factored out form the
j721e/j7200 defconfigs to the common env. I think this could be better
handled by having a board level hook such as follows:

	--- a/include/env/ti/ti_common.env
	+++ b/include/env/ti/ti_common.env
	@@ -22,14 +22,10 @@ get_fit_overlaystring=3D
		done;
	 get_fit_config=3Dsetexpr name_fit_config gsub / _ conf-${fdtfile}
	 run_fit=3Drun get_fit_config; bootm ${addr_fit}#${name_fit_config}${overl=
aystring}
	+init_board=3D
	 bootcmd_ti_mmc=3D
		run init_${boot};
	-#if CONFIG_CMD_REMOTEPROC
	-       if env exists do_main_cpsw0_qsgmii_phyinit;
	-               then run main_cpsw0_qsgmii_phyinit;
	-       fi;
	-       run boot_rprocs;
	-#endif
	+       run init_board;
		if test ${boot_fit} -eq 1;
			then run get_fit_${boot}; run get_fit_overlaystring; run run_fit;
		else;

with init_board being used as required in the board's env as follows:

	--- a/board/ti/j7200/j7200.env
	+++ b/board/ti/j7200/j7200.env
	@@ -34,6 +34,13 @@ main_cpsw0_qsgmii_phyinit=3D
		fi;
	 #endif

	+#if CONFIG_CMD_REMOTEPROC
	+init_board=3D
	+       if env exists do_main_cpsw0_qsgmii_phyinit;
	+               then run main_cpsw0_qsgmii_phyinit;
	+       fi;
	+       run boot_rprocs;
	+#endif
	 #if CONFIG_TARGET_J7200_A72_EVM
	 rproc_fw_binaries=3D 1 /lib/firmware/j7200-mcu-r5f0_1-fw 2 /lib/firmware/=
j7200-main-r5f0_0-fw 3 /lib/firmware/j7200-main-r5f0_1-fw
	 #endif

Regards,
Anshul
