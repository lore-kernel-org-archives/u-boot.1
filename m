Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B42C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF2508141A;
	Wed,  5 Mar 2025 14:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="i5A21MMu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC96681436; Wed,  5 Mar 2025 14:29:55 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDB498141A
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:29:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKaY/dgSMJmGScgbdufZuxXguRjwrK67tt3PbAYgnOLseZdDfafCF2iwqb0wn/ErejEn2K7OxEtbjBu9A0oqo3/MNRnTqj9fX8MpSRsCxvm9lRImq00LgSKa88Qm+Qe8Tu3FdZmA4VYR5FJs9sbSJuv7mmtkd7kwPAZllxFdznOwvG6b6xbrqXtDhRdaWFGC/scirDkgUg/iY6/4II0psa4ups8JEly/FIYsS4TFSUTQReMbwgPpaHMX4uekGkiyumUi10trjVDmkndSD/aQocRdRekLMIszBYWMO0rysgcSu0VECp5hFWuH6rDDJ7Al/l4D6B6wu0izZWjUn8+wHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHp/3lIY7rqSxyKKeTKIopiUmAylsN5nv5Zp+ILxs14=;
 b=gzQHetKTO4fdHnAZvDR053Ss1M6JkcE9O2Z03I25soNxJTbyFcYZTcYV/cxoVBW10UqftI3h+0+cPEiA9V60mCrMDIbx54hVtwU0XsalG4TE4hCRAZeN96X0F5ajaQf9DF/ZJ84BeYgJP+Xn6bG6/YKZINXBiYvU9vdiON5EoGJ7Fa61pGP8RB77a9djc6NTyO+9Hu468hcVduLNYFMtSNG+QfX5FMbNLf+WWlJGWd44GgK8xaXlGA0G3qQJOgiMukXeBAVViu5MGa8yDHoZIhgiLEHvJNWZzg1yFWE303xqQhwri953VWuysdRZefX8lZVvHWSYkD1o0icqi5HYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHp/3lIY7rqSxyKKeTKIopiUmAylsN5nv5Zp+ILxs14=;
 b=i5A21MMujvkXp/dOihTFK2DWtXyQ08csUMs2aHXja4nvIDr7EdnDT3vembDX321oPS8on+vyzygWeAJ8TqUory1qYx322e/R1D+kTLpPzmjw/t/KXMzKBJd4FDJNqQpTVgegKoPtG3KaDT0rd176aMZzr8w4ZlhzraVGMzMGc2JARlIMUDW+5P66nxolaL8oUz3j0pYeUL+vqiD4PTULKkiBUnudMeFRDl/8AlVKrUzqUuhJ1eJdj/9YIMiKuspAUloWXLhH8JtPQro+kX9BMbcjGcpiXzSWpZkUY0kvJ3h/jQ1sRbahkDfmWDwTqgdiR9qVswqWOssskOuGMYiEdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB7037.eurprd04.prod.outlook.com (2603:10a6:800:125::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 13:29:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:29:52 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:25 +0800
Subject: [PATCH v7 13/19] imx: Kconfig: IMX8_ROMAPI is not configured for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-13-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a295b5d-ff72-4d52-b0ef-08dd5be9cf4b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1JjRFo4WnVEOVUrdjJLZWdZY2p6TVhlNWxVcXlzZ2wrNXRQZ1VIMVIvQzJp?=
 =?utf-8?B?aE02WkppQmd4WkxGbExudzVTYjV4ZjBkNDF5SzdndmRjTG0xNE9xZyt2bFF4?=
 =?utf-8?B?aWxTaTFYTmNKeE1nZjFNSSsrUWdhVXpiNlVmSU5Fdk9GV1lLM0FmZGtBZnJ2?=
 =?utf-8?B?UHE2UWJHNkc1eGdVRTBIcjRzVTFHQ1RMcnlmT3VPRFZpdTNPVFRaVkg4bjBl?=
 =?utf-8?B?WWpQaUJoWVhsWGdIY3VQb2ZRM3V0MjJONzB5clMycUdGZEtjTXQwUkxyNnZL?=
 =?utf-8?B?eUd2U01MVEd4emhtejJETDA3OE40MDVLejdIc0NRTVIzQUxUMElSd094dkxy?=
 =?utf-8?B?UHRGVENaakx4ajRvajMvRksrNVBUbGFDZWw4ckxSQ3NMOGkrdHdxUy9McU1U?=
 =?utf-8?B?MGtYb2FZbFQ2SWowZTlKYTNQNnlDOXFiaFk2U05HVms4K3FMZzN2VEdNSEgr?=
 =?utf-8?B?Z3p5S0ZPSHQxbS9Kb0JXZjN2Uk5mc29LZVhKOVVleUdqZkt6SjV6SzZXWkVp?=
 =?utf-8?B?cVQ4Z3prV2tyemJLN0RJOWFhR2FVMFpQWHpKQ1ZVWFY3NFRIcGdQaGdWQVRu?=
 =?utf-8?B?Z3JZMVArYURsdURVWEFTb0ZzdVhYSldyVkxJRnorN0NlUllMcXdjeWs0YjB2?=
 =?utf-8?B?bElDRnlzWVd2b3pzZVBHUEhFRDRid01LWG52cDB2ODE5VHZ1NDl5dFJmY0cr?=
 =?utf-8?B?Z08xbUF2cGtKWHFpOHVieTRiQVZPQ2pBZHdkZEo0anFLeGQvekhCa2RNOFFC?=
 =?utf-8?B?ekFGVHZTNC9yUlE3a21SaFlTai8yejcwUnVsU1FyUVRIcFJublovaUFaZk8r?=
 =?utf-8?B?c1ZVNEdDYXZ2Z2hVMlc2bDRobjQvWTZRYU5XNkFMdm1zcFYyelBLNzQyTDU1?=
 =?utf-8?B?ODI3emVuZnVwT1U2cEpuRStJQTdhWTMxcnkrVmMzZHZrM0VSeTkzQXE0aWNn?=
 =?utf-8?B?clZTVXYxRjgybmQ3cFQvRXdKU3BpZFFTcFJucjJSZmtBZVV5UmFtOC9odWE0?=
 =?utf-8?B?RWdZaDhyblV2TEhUS1BQekVGb1k3cVJ0OHRtQ2pnZFJRME5GdUVhL0d2OXl2?=
 =?utf-8?B?eWpBWENVOTVTU2NZMlIzK1AvMlRWVTNWdy8yMURPOW9IZW81Sis0KzV5eVAv?=
 =?utf-8?B?d0c2ZVhqU1VBL2x2WXVqSnMyM3U3VkxvNHlzcE4wdmJtajJnTEh4c0NxeVI3?=
 =?utf-8?B?SDNaa2dMSlZPZXl4b094bFoxamc5WGxBZHduQitzUUlzVmdXdVhzTWg4STdh?=
 =?utf-8?B?anE4TmFYNENIQ25YQ1dCOEp5VDNEUFhrZXkvcWQvZWxZdkhOK1lDczhpWTFy?=
 =?utf-8?B?K0thSWdTUVpYNVVRaWNjbmNxMTVqN3NSTkYrRWJZUGRHMHBGalpkaE93YWJB?=
 =?utf-8?B?bmdlZmpmNW5oKytMWDVCY2RlQURCYmNGQzNwTDdPblZid2tlYlJWa2d2L0xP?=
 =?utf-8?B?UnZRUEp5WmFoN1ZMVVBrWUM5Ym4wN3hRc1BydnIvQk12ZWlOdUJvRis5azFT?=
 =?utf-8?B?QTU3U3ZHVUpUYkNlZ09Fd2RtWkp3OFBaQlplczY4Q1FZVUhxVGgxMmo5ZmhM?=
 =?utf-8?B?VDF5bExnZUEyZzQ2clRXN1BKeVZwTURtVWE1SUVwcEg2NENRb3p0Y01wZWdq?=
 =?utf-8?B?ek1MZjgrV0tiaVZyVWdRRWFUUFhpc1I2RVM4bFJ5bWU0dzFCTW1pT2d1SGNR?=
 =?utf-8?B?RytwbjJXMWRQV01CL0RpQTFXaEVaZWpzVTJKRHhWSisyNkswdWV4R0Q2bHAz?=
 =?utf-8?B?TXF1UE5vaW0rR0dabk5xeTF1cEpaalI4OXVIcFViZ0F1cWNyeklxV3Y1cjJW?=
 =?utf-8?B?N0hDbmxlVlFHUHRLNjIyVXVhS3FlZURGWUNQZnRNTjdpaVNjU2dUN2VOdnQr?=
 =?utf-8?B?aitjWFJrRXJUd0l6bjIwV0ZzS2dzVjdESXFpNU5IMHJmRnZVZEp2Z1RNZXpq?=
 =?utf-8?B?aS9CeTJhem92am80R0I0b1BlT1hlQnp1aHBDbVNtbWZBS3ZWZGZKaFVpUW5N?=
 =?utf-8?B?UkU1VDVDOXVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUdrLzhsZ1Y2K0xGVTBWYm5HblFRMnNHelFReUVUampPTXhod1pFOWJyaW9m?=
 =?utf-8?B?Z1ArYlozbXFtWUJyUFNqN2hZcXF5VUYwSmMvSUxUU0FrM243Q21EUWY1R2ZE?=
 =?utf-8?B?N0xTYjVMc29LVWxHQndESG9tOG9Rc2R6bHRlcmdnZTFlbFpTbEQxYWN6YUQ2?=
 =?utf-8?B?cDlINGJBREpHMFp3QXJneGxsMU9HUVd4NFVqMFcvaUlHYitNM2tSZ3NNaUE4?=
 =?utf-8?B?ajAyMS9DMXZJa0lLVW5LV2RKMytRaXc3OE1MOFBNWWxmZW1PL2xsZWx1SGF6?=
 =?utf-8?B?MFRGV2NsbnZmSFZrYTZYbWFSYzdJZm9QUktoOUIvbGI2YTI3ZXFLTFRCZi9q?=
 =?utf-8?B?amtUQXpzQWNoc1k5OThiTnBQYmN3TkRZZE9kZTZWQjZSMG1aZnI4RWtrZld5?=
 =?utf-8?B?aDhNSDBRWkRSWk42aTRETUlCM1JGbHBWUGtMZk1XWjBqTVhpL1JjS2s0Q1gx?=
 =?utf-8?B?VVBuQ3BMRVVaaEpKSHFBUm5CVXVNaXlKVHRqWEtURkNkckloM3lrTnQyUU52?=
 =?utf-8?B?Y1pkb1VjYTdyQnRPWGtJazByb2lQTGNWSkNIMkV5Z1M1UTBHdEI2a3ZkbUFR?=
 =?utf-8?B?bmhERTJxUDVCaUpna0lyR0pYb3ZnWGNSMUdaZVdFNFdlY3RSSGRvVThKc1Vh?=
 =?utf-8?B?Ui9SaUdrSDhHMUdtZVo0K2lFTktLUnY2MXFvNGxXTDd5a3gzMVhOLytFL1ov?=
 =?utf-8?B?MEQ5UDdrOHNoVzdXblpQbVRhYnNlT2U3UW5MWmdjWGZBdk1mcEY1cVQ5Q0w1?=
 =?utf-8?B?QzNtdUdML0QybFhhNlJFSk1EZUU3MWJmbmVkTVRlRUxFRTRobFlPbkRZUzJK?=
 =?utf-8?B?Q0E4L3E3WTdIamcvRDlxd0IzVDVqTFZjcVNTRGRTMHg1dXc4YzdIN29RVXB2?=
 =?utf-8?B?WEp2dlkvZWk4Tms3RDl2RERJZXdZWTNCWVNuaWl0YzFDWEtRQ3pYSGZrZlU0?=
 =?utf-8?B?MmZFSDNEZFhhU3hMa3Bnb3RYZm5LMFgzVXhXQ3doRVJvNHBEakpzQ1ZHU0R3?=
 =?utf-8?B?SEtGR1ZLaVpCTENwbjB0c3hmTGltZC9PNzJ5WHR2VHY4WVR2Vm03a1l5MDFp?=
 =?utf-8?B?OTU3OWNQR1JkRnJJUXdock44N09qcTVqanJXcG9WNGVJZG9CUmdMQUhKTzEw?=
 =?utf-8?B?eHJxOFR3bDdNUVRtM2NNLy9vNUtJSzMyL0doSm1uYVQ5eE55em5vUitsUTdW?=
 =?utf-8?B?dUZVNjdtYTcyNmpPSFBESjNqYzBDa0ZEcHA0N1JBVHZhV3pJbGVkaVR5NUxL?=
 =?utf-8?B?dlArMlV2RTJIdkxqdjV3b2xVdmNMemo0Q3VWVytXTC9kN2RMNnpFY2c4WThY?=
 =?utf-8?B?aWZhR3dZU0RJTkg2clphTW5wUnNCMFVESFNsYXpEbWROUnBhV0s2VEc2aEpF?=
 =?utf-8?B?RnFqQ01Ubmg0NlVWYlYyRUNEK3N1eXhSTGZlVUxNRW1zbkEvNEtTTWFuOXNx?=
 =?utf-8?B?cFNzdTdHY2NXMjdHOExjZlo3dEZZR0lYQytoTW1tRFBMakFhRlE5RGIyUXB0?=
 =?utf-8?B?UHlEdHpyVHgxck1lUDF2NjB0NWc2QnRrWjFVTnczR00rV0k4Skx4Ly9tOGtO?=
 =?utf-8?B?SHhJT05xeDNLOFpZdStMQ2RtRXg2SUJ5V29YMUwxWFQ2cno1ZUFDZm5oTVRI?=
 =?utf-8?B?UkZvL21HekhmbGsvcGQ1WGhxeVZzZGtrR2wxMlA3a01yMmlONFhHWG9jaENt?=
 =?utf-8?B?TU5LaHp5MU9HZ3Q2WHNPSklRN2xRMWVPK3ArcVpLTUlxdUhEVVFOUGsrdGVC?=
 =?utf-8?B?YllXSzUwMmNJa3duSXZ6bTFlTmlBaE41QlgwWFI1UGxpVHpJZlZkc0YzaG0x?=
 =?utf-8?B?dW9ya1pOcXR5WGtZUndNQkY2TEM2OWoxQXJHZE1uOHY2aHAxYk5KQVplYlFP?=
 =?utf-8?B?aXExUi8ydE5wTEJFUGxlbXpBL0RpREZSTjIwZEJoVGJDbFR2c2xoWTlHWmVV?=
 =?utf-8?B?a0dEaHQrb3BwODFJUkM3TGZMVG1jN2VUUzRWdHFreGg1WVlHNEpiN2JiZ1pN?=
 =?utf-8?B?bGNoS1UzN3hZS0RPbnh2cTJuZGpjUVB1M3AyRnhJSzNpOHVyeVh3djAxSVpz?=
 =?utf-8?B?czByUjVJZkY5SXd1Nm5RK21kSkFidjZwbWI4SGhqNzZpaGU0UjNlSWJSRHhy?=
 =?utf-8?Q?c8e0tiWtT8Pi+raV2Q2V0SHNt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a295b5d-ff72-4d52-b0ef-08dd5be9cf4b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:29:52.1428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdzyjH59TbNkCjF7W6NZbyRuPYXEsomlfg1hUbGQYA7hcwCMfEqB+Onxt4zgwUSZv32p6R95GELludwen87f7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7037
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 only supports low power boot, which means A55 is kicked by M33.
There is no ROM runs on A55 in such case so that deselect IMX8_ROMAPI
for i.MX95.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 134e42028c..f38f3b2d33 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -180,7 +180,7 @@ config DDRMC_VF610_CALIBRATION
 
 config IMX8_ROMAPI
 	def_bool y
-	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
+	depends on IMX8MN || IMX8MP || IMX8ULP || IMX93 || IMX91
 
 config SPL_IMX_ROMAPI_LOADADDR
 	hex "Default load address to load image through ROM API"

-- 
2.43.0

