Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77228C44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 15:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4EE283015;
	Wed, 21 Jan 2026 16:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kROCh5hV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 714D980077; Wed, 21 Jan 2026 16:44:19 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F312B83A1E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 16:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXD5tJA9kMBtrXxEZqY/qgRpTjw2oFGizypwCja+GxS/KNcZO6at7Vp+tukleGpyAynoopFE+SLSvDzzVuUyKBvU01xXRYH4NhDkHl6ucYs9hqT5oYOdxvOFCOsIIxXthn/nMTo7rEzbdgcDdh1gPQoMKGCJQW+r1ij+Xxc2JexTdJkSkEqHHzJnsVFDNUEwNafAFgRaM+MQrjQewm28hh7D4d7v+Q0aYzOtxmPDByNztNt4IytWvXFxZy/p/NJ+DQcTNfKj0WjMfmeny7rkB6drjmTbIj1LOu7X9VPFY5uSHaNtQmTdnTfuHRRRGwuCTlHdcf4yksvYsTf/YCyvEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8mXrx94YuR6euKJKNFmwqJZxRwzkKVgTG0R/mIq07Y=;
 b=Wuk+GR1anNYBDatcOM2/tGeCPsRmPzOAYWy5sbG52PyNo0CaW36vJeo6Yv32Dd6iEyvk+k6gZs6rCy7YyS8H+uPWzjARWv9J8iW3/Hkn+Hss0uec17pSruJNz8HkaFeIqJy+xSRaCFdZ6R+KtY2geobUCLldKknXGOlDQNOsED1NO6NdLzqR6CuGXuUtpRPSLE36unvUXd96nQxPD54e9OSYkzD/Qh1yoccOmxPsrszoDY9C2tikv7CdDjgOB1+yP3Otvih41UYMcMxCA2k/kbraoJgQrJIsAHueHebaxVTWXexbKubUwFR4Eg0Sl5vaoXRkNZ/VSp7fFukSccM/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8mXrx94YuR6euKJKNFmwqJZxRwzkKVgTG0R/mIq07Y=;
 b=kROCh5hVHJC4iMHgsgtiRdwr4JFysyILbIy1mzRDUjM7PmISQYDrjDdxltiD5lIQpMci8NIhYNJepgwSeCNvbuaqrqDjDr+B+L5/xBhnLuVUtFzHyaQ0kwAO35zDEh1vZBElE/O847KwN6gB3zT/txb0ox8VuQXQ/XLX+5M8Fnc=
Received: from BL1PR13CA0346.namprd13.prod.outlook.com (2603:10b6:208:2c6::21)
 by MN2PR10MB4191.namprd10.prod.outlook.com (2603:10b6:208:1d1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 15:44:14 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::fa) by BL1PR13CA0346.outlook.office365.com
 (2603:10b6:208:2c6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 15:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Wed, 21 Jan 2026 15:44:12 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:44:11 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:44:11 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 09:44:11 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60LFiBwI3255987;
 Wed, 21 Jan 2026 09:44:11 -0600
Date: Wed, 21 Jan 2026 09:44:11 -0600
From: Bryan Brattlof <bb@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Suhaas Joshi <s-joshi@ti.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>, 
 <trini@konsulko.com>, <n-francis@ti.com>, <s-tripathi1@ti.com>,
 <k-malarvizhi@ti.com>, <kamlesh@ti.com>, <vishalm@ti.com>
Subject: Re: [PATCH v2 0/5] Firewall ATF and OP-TEE memory regions in Sitara
Message-ID: <20260121154411.l4buznbtw3xjrkqs@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260121054712.176939-1-s-joshi@ti.com>
 <20260121140747.GA112150@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260121140747.GA112150@francesco-nb>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|MN2PR10MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: 230e48c0-fffe-43c4-ffe7-08de5903ec9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1ZZblRjS2gyNUxhYkZhRXlYZVNzMFU4MVZTMUl6dWE1VC95dU0zWjhaWGl6?=
 =?utf-8?B?akI0WDc5SWlRcXRpMUJwTENGT3JOZ2NvSWZmYzAvSy9YTnRuajh4SFYrd2Vw?=
 =?utf-8?B?TkZJcFF4MW8vMjYwRWJHeEEzVlN6T0RjRkJTT1ZBSUNRM0pQekFSaldKZFM3?=
 =?utf-8?B?RUtMS3Y2TVMvMURtbkFWa1ZzZk41U2xkV1grU1d1Y05YNzB2UFJoMmdsbE9T?=
 =?utf-8?B?QncyelorTnFUT2QxVmF4Qk1pMk96Q3k5bTJJUkg4QkdJRG43WHFkMHEzK1F1?=
 =?utf-8?B?cGpORXpJY1BuQm5lV2trdnhpUkRmM1hvN3UyZDFZdnRHaUJLVm5HYmVkNmQ1?=
 =?utf-8?B?ZktERXRqMmVRN1VlS3d3SXdHd0dwMHl3bjNoc3NyQTEvc0kzU2lQT25QenZ0?=
 =?utf-8?B?YWthTzVUcmNhanE5b0ZERXVCa1F5bytKaktVV3k1Y2FTYUVUNkdxdVRxNWlG?=
 =?utf-8?B?K2F2OEU5VmYxdDBLZldrc09PTHlvVlF5Q2R2L2lzbTNWaTMzSjlMVGRsUWpq?=
 =?utf-8?B?TXRmK0Z2cW03NUpJcVdOWFl3czdDZXhPUDZVNUFlWFFsMGRXcFZqNGRKOUp2?=
 =?utf-8?B?VDIxSjJWc0oyd2MrblYwMVJJUFVWWmRYZTJqTzVGU05qN0xZTi8rNnJzWVNN?=
 =?utf-8?B?QXdpL0MvNFZYVXN0d3JmM21zdWtDUVNraEtMWkx3bTNFOHNBODk2cnczUWR2?=
 =?utf-8?B?bC9WaHV2SGtXdE9lRmNONFpySEpHeXNJc0hPUi9yMkFmQmZ6K2ZKYmlhb3dm?=
 =?utf-8?B?bVd3ZXlidzJFY3I4ZmJOang0Z2l3czB6Zk0yTjBTN2FCMFozc2RLNWt4LzZp?=
 =?utf-8?B?ckZEMjRPdmdCS3BrVm5VcXppdDM0Z3VKMVZYSnVJM28rMWtWMGRHSXVCNS8r?=
 =?utf-8?B?bXBKcUllRWEwYURSTEM5anFJU2VGVUxlYVdyQkdadFE1cE1BNlhONXlpdXVB?=
 =?utf-8?B?NlRETVBXbW1INit6YjFab09QcitCTkFQWktoSWlxQXJ1QVdCTDFHWGEwNlE3?=
 =?utf-8?B?TnBEQnlaV3hiMnB3UVpiU2k4dXhKd3YwamZFbjNLc0pFZ2xHV3crd0VOMEVJ?=
 =?utf-8?B?aHlENFRiRGZpYzBzczh3Mkp6OCtLQU9uTWRQY21OTjNtNmMvb2s0NDJlM0FX?=
 =?utf-8?B?bGJQTDVtVDJSQzhaS0lSeTBDejZjZkxsYmNpVU8yd05JQ2gzSmZmU3EyZVR1?=
 =?utf-8?B?cmYzcXByenM0NlUyNmxacVIxWUxRQzFNeVBSTWJNRVlBbGJtWGhpMUJLeEZa?=
 =?utf-8?B?WTQ1eTdhSVRJQWpiTU1TWXNNZyswU2MvWm1uZWY4d1BYSGdrL29GMld5TlNZ?=
 =?utf-8?B?UGxDeFQ5dFhueGMvclkySTZ6a2IwL0FkYkw1Rk5kbXRCd25CNGhZbU5QZDFT?=
 =?utf-8?B?K3hwbmtuemJYdm9pYmcxOERCYzlUUHdoTmZGdERBcEZWUFljN0MyczhrRVpM?=
 =?utf-8?B?SnBJOFpZRW1LQkd0QzA5dWJMYXhvYy9RZXhVRldOVUtqeFlxa2VxRS9rbHN0?=
 =?utf-8?B?UFQvRDZhQ3dVVmJNQnU2M1BNbFVtcjZYckpUVkEvZ0JObTVDN0JoRGpBejlD?=
 =?utf-8?B?SUl6U1g4SWFJQ20rNExXMTBHbms5SEcyZm5GdDBrQzFYczJxeE9vUmI2ZXky?=
 =?utf-8?B?dnB5aEhTTXFzbExxcmt3VTNmK3lXd3A1SlRqWnBmbXg2azZpeTBxV0lyNVVU?=
 =?utf-8?B?dTdCNHFmYzdtNGsrS24vam1CYzVnRFZ3UlNEM3VmM0hEU2JlbG91d09CV0pW?=
 =?utf-8?B?ZS9YUisxRWhnUk5lSi9zc0xYY2pNMU8wR2dlUmdEOG5kSFZRdzNMWEhrNHRZ?=
 =?utf-8?B?WDROaHRHR0xmMnN1K3l5dkxpS3F4ZVhyZklYZHEyM1ZkL1FGUFY5UllySUc4?=
 =?utf-8?B?cTJTS0FleDZBOVpYRWl5bnl2WmYwb3QwVVRxQmJMeGJ5WUc4cklad0p3T1RB?=
 =?utf-8?B?TVdhM2tQazd5OFEzN3FURU1tQ3lsaEsweXpkeU5rRmlSYkJ1bm95S2I5bUdJ?=
 =?utf-8?B?bzRJVzdaVTBYcmNMN1lWMkpzZDhna0RVSVBqL1NDWklpOEdHWkE3eXNKWlFu?=
 =?utf-8?B?ZTJjWmtFS2FVbmZBeGxaS3pVYWdNVWZzTDdFTTUyaU4xMnUzN2NJSklZeWt5?=
 =?utf-8?B?RTZMbXZrRTRid3pkZzlMN3phWXIvSzMreWhuaHU3aWE3dW1XYWlraXFDWFgr?=
 =?utf-8?B?Qm9zYjVveFRRK1dhNEhMaDVZNTQwSnlBeTV6dzdhY1psUnRDQXVOSERKTFA4?=
 =?utf-8?B?cnpxTHY2Qys4YXVBU1VkTmtBVFBnPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 15:44:12.1465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 230e48c0-fffe-43c4-ffe7-08de5903ec9c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4191
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

On January 21, 2026 thus sayeth Francesco Dolcini:
> Hello,
> thanks for your patch
> 
> On Wed, Jan 21, 2026 at 11:17:07AM +0530, Suhaas Joshi wrote:
> > This series starts by replacing the hard-coded addresses in firewall
> > templates that are defined in k3-binman.dtsi, by Kconfigs. Using
> > Kconfigs would make it easier for someone to move ATF and OP-TEE to
> > another location, since they wouldn't have to fiddle with the firewall
> > configs in the dtsi files.
> > 
> > The rest of the commits in this series add firewall configs to each
> > device's dtsi file.
> 
> If I understand correctly the change, you should change also the other
> k3 boards, not just the TI one.

Yeah we should try to add this to all Sitara platforms

~Bryan
