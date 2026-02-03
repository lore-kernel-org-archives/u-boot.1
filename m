Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDA4E87830
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8EE984262;
	Tue,  3 Feb 2026 14:58:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UXLxMckw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEF7B84277; Tue,  3 Feb 2026 14:58:25 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C3F28423E
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGaEzy/hmAK8IjvJVOvaV8Uh1PNn/trE0qsdYfCFvSTKsEOxl0lGmoKgrHoAbnZXwsUHbRNvcK4sEE3GydriKyqU22y5jYhIh4ai5s19ETlPSMxwhhc5/RWkT1qvwiuiabValBrBI7ApTBWWDdsS4yuKbST8fTyk6oZ+DUzBWGPBeWmIndkvnKAKvSqJujQNIx2L7Thz/2qNCUTlT8zbWhASQwg/5kX5KObvbnu2wO6Z8K627cIBQHMudqxgYWWUfBk7158kiKw9Pf1Ty+o958YL8MNfQkU2JEVF4zHf235y2HHNCAVtUF6pzeDkjq3Hjs8BDh3aqJk8/8u4/COtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5bX/kYWSgxZFsDS6f0lGJIX5+rnAAoS5JpND9wdp20=;
 b=uSFDMcYhj6/BxxaHf0v5RB+tNWrAnTf8PRi7C8z2AyDJKnCGNHAAlPT+1bG8X7f26Wbtrra3BnXdEZ8u4600nGCTbPuXYV4Wz9bmn/GM39CNOicFs846mYnQTyL4DQWbzwz+9dPdh9fB2jvuQgHTJ3QI/GLpTgMJ4RngsbKYyiGjHwtqxMS8c2xX0h+V3gW/8II58MwZoTldZg/qLGkZli1PC1/CM/uluYsukaN1SgnVr7mT0K0BBoPpMEGEMTFzChzziRhRqlxRvMG+j3Z02qIa3o0Hoxbpl8ncHLFJGHEFtc7C59HCkGtans0YZ8czd/WUZRyOzYo6YvlKaIPxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5bX/kYWSgxZFsDS6f0lGJIX5+rnAAoS5JpND9wdp20=;
 b=UXLxMckwLz5hfYWuNEVR0/cmHRZdZsbC8RRwQKvzMEl8JVzSXvFC8rL+adZpAucVWR7/uSxleC50WGJA5iiXwEE8wT/QQL7HmV91wCNHM/F+LnZexi2dvojclpWwZWuCnkDDCjMkgIKexAo27gASRxMtkmp5w+gH9p2LZTpkU8g=
Received: from BN1PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:e0::13)
 by PH8PR10MB6574.namprd10.prod.outlook.com (2603:10b6:510:226::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 13:58:19 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::1c) by BN1PR10CA0008.outlook.office365.com
 (2603:10b6:408:e0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 13:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 3 Feb 2026 13:58:19 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 07:58:18 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 07:58:18 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 07:58:18 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 613DwIKO4040137;
 Tue, 3 Feb 2026 07:58:18 -0600
Date: Tue, 3 Feb 2026 07:58:18 -0600
From: Bryan Brattlof <bb@ti.com>
To: Santhosh Kumar K <s-k6@ti.com>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <u-boot@lists.denx.de>,
 <n-francis@ti.com>
Subject: Re: [PATCH 0/5] Update DDR Configurations
Message-ID: <20260203135818.llt32rrd2krutq6h@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260203063529.1551907-1-s-k6@ti.com>
 <20260203134108.ub26t3pnf3rxeocb@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260203134108.ub26t3pnf3rxeocb@bryanbrattlof.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|PH8PR10MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af56f01-5c5b-4bf8-de13-08de632c495d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGRFZ1A1QzZ1NHp2cklpeDdudnUzdmh5UkEwMStPNVJCSSttSXZubEs5bzB4?=
 =?utf-8?B?STZxVTlUeWRoTjIvU2U4RkRYcktXS0lwSjdpbWlWYWNtbWU4UUY5MWFhTGRm?=
 =?utf-8?B?SGxwc3RpVFBSOWdRWlN5ekRWbHJYYk44OE9HOHVob0w2VlR0NmFUY21vQkNY?=
 =?utf-8?B?WngrenVLQ1RWVWlNYUthWUxLYnFwOFRnazRWYVNNNzBMbUlTRzgxd3N5R2Jh?=
 =?utf-8?B?RFBXa0Z3VHEwY242cnMxR09NVjE3SklWTU9KdmQzU04yWVFWdDJEOTJCNjh5?=
 =?utf-8?B?N2RDR29nM1JRUFRZTkdFRkNCd2J0WE9GZ1NhVXErZWpHdGVyUmZ6d2l5WlNB?=
 =?utf-8?B?T2ZHU2t2U3Y0QU1yVjd3d0pQUXQrZ1E2TmVBRmtaVkpORHNNWHI4Wm5HNUNE?=
 =?utf-8?B?cmRwSllzSmFDcUswcmRhTjhySUpwUWhXZnJZbEo4NjB5L0NpN2lJemt4RVI5?=
 =?utf-8?B?cVJYM1ZpN3VWVUt2VFdrREpWOXBnQXd5b2l0UmZqdFZId0o0L2Y2aDJYdHZY?=
 =?utf-8?B?RTczWVJFOWhaN3orNjUydDRaQVcvQzhoVGI0OFB6aWxvNXhlQWtmZzNMNFds?=
 =?utf-8?B?RU1xTTRLQTAvaklFdUFlZU1oc0pqREh0WGxNNjJhUmdUUEFGRkFyakJtVkZU?=
 =?utf-8?B?WG5VakZUUVRNaU1sYytNS1krd1VTOVdoZ1NoVjR4Nm0xTG1zT1JrQ1MwdnRB?=
 =?utf-8?B?c0lzSytOVEFyMWxiQjliVG9JaEFvSmFBTzVzbGlYL21CZWpvZWhSOVFLOHZ1?=
 =?utf-8?B?MkZNS1MzamJQWGVMRXNjMzJmU1FIZ3U3cTNQVkVNZ3psMEIyaGQ2Z3RnVnZ3?=
 =?utf-8?B?Q1RxVUI0S1JXL0g1NlRDSFpINy9aRkFUK3V1cWY2cWg1anNZNS9XbHQ0ckFv?=
 =?utf-8?B?SW5uMmhRRFFZeDlucXlONDRXYjlrRVRJUzA2SXhCL2phVXl5UWY3d0o1UDZM?=
 =?utf-8?B?TXBWaXVYeVErejdtVkx1MXF3U3BGMDlCc0lFS3VSRHpOWTAvUC9HSWh2UjFu?=
 =?utf-8?B?K3J6RXFCYUt5aXViaDVOQ2RHTUNnZjVwV0RqSlBYbGF5T1Fpa295MUN6bXpP?=
 =?utf-8?B?d2tKcDdCSERSUTJoa0N3Tko5d3NNcmNFZVVqZ213MlhSTHVqTWgzWkh5RFRw?=
 =?utf-8?B?amREdDh1MCt2cFJ6SUpZalJHSUpnTWphS3FKSGJ4RUZ2TFk5emxXVXdGYVh5?=
 =?utf-8?B?RGNFc1poaUY5Qi9vQTJLYUdXT3hwTVNSMTVvUmd0VkdiTWVCdHFvbDVtZ2NI?=
 =?utf-8?B?V3RpMTBzazNUOEVtZFYvd2R0SWVIMnptVjRDY0FsaG1wcWU0UGxNV0JNV1Zh?=
 =?utf-8?B?bXVkUDNqWTZOZ3Fzc0VnK3kvS2hZOGd5V1NJYmhlTUlqM1lIS2MyZTdoS3Iw?=
 =?utf-8?B?cmhyTlpTM3VHL09sdWd5M2lTOTNHNDl4Q2hzT0RKelViY0dPMnhXQTNlVENC?=
 =?utf-8?B?OG9URXVYWW42LzhiUjJkQkp1ZGU2d3F4Z2YwM1lVVzhqQ3JwZzhna05vTWIv?=
 =?utf-8?B?K21tSk5zRHNpZ3Q2OEJVWVRHVjVyeDQ5a3h3eU1RbGM5SDNWTm56KzhlZkMr?=
 =?utf-8?B?ZXJUdjRMRnJxSHpIU2FNbFBCNHhwNklkRTBoM3JFcEhMcFU3NTNmRzZ0MDBn?=
 =?utf-8?B?NzVyejg3d3VWVzZKeGVsdFhNVFRBNHB4ZENPMmtJaCtBTkF5U0FlNlhTWS9s?=
 =?utf-8?B?RXJhQkdpVVY1UFl1aUIrZU9pcldZdERmTUs0MndoOXkySWYxNldaUklMNHBh?=
 =?utf-8?B?b1haQVROTkhZbDhQcWJRQjluam44bkFnMkl3Zy9uZDVzSXBvZUpQVDdEYndM?=
 =?utf-8?B?MHhCR0ZBck52WE9FcEh0RWlLNVFJYkYxZEc0c21RZm1waEpQNDJqVVJNQzN5?=
 =?utf-8?B?MXYxMXEycmI1NExLMHQyL0tLdVl0ZnRTOEc3a09Ha0J2RmhhT2pGT2tnN0Fi?=
 =?utf-8?B?NDhuMEZpV2V4allBZThsdmJaTi9JMlVxaEpHNWpPT1d4U3U4Zkc1M0tFbzNp?=
 =?utf-8?B?Q3NkY1lnanh4QTJUVzM4TURFSVBnYW1BQkZRakxlVFRKL1pISEMvam5VS29S?=
 =?utf-8?B?dWswODhHeHlnK21qaW12eWRPaGg4YlVTUWxaY2Z1Rm9UZ3QxUWtvOWMvRkd0?=
 =?utf-8?B?bERVVmk3NEl5VVFvVnFLRHhDL1ZaekFMZkxPa2UwTW0vRFhxUFV3dU5acnRj?=
 =?utf-8?B?bWRIaEJIT0E1dCtDQk5qL05vRzJCQkhWWDk5UDRwUlhxRWVXWnh6aHcrTG56?=
 =?utf-8?B?UlYyajRVQXh1RUVjaUswK3l5Q1pBPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EYpckY/Fu2JPN7Qu4whbwOFM5TP38x26tNOL55n49WR19TSgFMRhRA17+3AfNiAe7ZHjGt3hWYHHBR5OZ0hAZptJleAnLvaCLaAle+AMbSoFY+MdMlGb9ai5JnWtq0SJkcfNyHc5N6W+cBVLHqnjBJm09IvjRrv55UBvbDDePipodVUN191j2zc74+IOuuUue0Jz6bk7jdS5uhlRGYkLyrENTudpuFQXFuMHkC8pIYEORiU0IPM9nWtu04CuIFh4IQ1hCakZlmuY0h23H40YpgB9eoGZB0eqeQBe1UwXZhjqj6HPRfhg5fTL73j7MKtchXis3pUmbNkDld8f+zUg1RPS5kaF6oS2GZaC5CqoB6umCmM3GrV4VJh01GrHvNCosxylqPtm6N5YPF5ydPfCdjRq030O0tmSo60104c0eCspMUOxaBeX676EMH5YG80y
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:58:19.2594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af56f01-5c5b-4bf8-de13-08de632c495d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6574
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

On February  3, 2026 thus sayeth Bryan Brattlof:
> On February  3, 2026 thus sayeth Santhosh Kumar K:
> > This series updates the DDR Configurations according to the SysConfig DDR
> > Configuration tool v0.10.32 for the following devices [1]
> >  - AM64x EVM
> >  - AM62x SK
> >  - AM62x LP SK
> >  - AM62Ax SK
> >  - AM62Px SK
> > 
> > Testing:
> > memtester - 50% of memory for 10 loops - PASSED
> > 
> > [1] https://dev.ti.com/tirex/content/Processor_DDR_Config_0.10.32.0000/docs/REVISION_HISTORY.html
> > 
> > Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> > 
> > Santhosh Kumar K (5):
> >   arm: dts: k3-am64: Update DDR Configurations
> >   arm: dts: k3-am62x: Update DDR Configurations
> >   arm: dts: k3-am62-lp: Update DDR Configurations
> >   arm: dts: k3-am62a: Update DDR Configurations
> >   arm: dts: k3-am62p: Update DDR Configurations
> > 
> >  arch/arm/dts/k3-am62-lp4-50-800-800.dtsi     |  13 +-
> >  arch/arm/dts/k3-am62a-ddr-1866mhz-32bit.dtsi |  25 ++--
> >  arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi   |  25 ++--
> >  arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi   | 119 ++++++++++---------
> >  arch/arm/dts/k3-am64-evm-ddr4-1600MTs.dtsi   | 117 +++++++++---------
> 
> Was there an issue with the DDR on the 62D board?

Ah my bad it's already on v0.10.32 

Thanks Santhosh!

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
