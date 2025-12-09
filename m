Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB3BD3B7E2
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 02:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5E9483B82;
	Tue,  9 Dec 2025 03:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W4/hP+zN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53B7183B82; Tue,  9 Dec 2025 03:48:11 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B372F83B6C
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 03:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHDrNtLUFT/L0n48YpnpTPdP15/Y3f2S9y3YOkBq4ttByMQo8UA9Cep0SMkeJkNMyXk+ZvP9LXLykaZA85LSH+7P0tJtWkAiG2Ws9XkWB77IwbRZsgFFPE2EsUfEHPDlMTK++UMo8iJLPkq56a6QbV0qnRu/L28k9m/Kr4tvKo/EoksaV3YuAmpS//K9q4jVU8RHQoaH88kDqmXVlphxknopN7bCOw4WPopLIOesPIWY8yINSuu8n9Vyd4XVKx7dcHBTix85igauZTH4fujRkiOGz0h2lzS/p8/aNiM6CWf5tQ8Tq5ZF8Qmw4ua7ZOZv46o/kPtrTNloDBqNnBVXiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jt/JO6YC2I9zQP9XpgsgVW7J3/CmOv93ntU2A2VZdvo=;
 b=FGtPks/OyMVd2ttiqBtNSBFRp6+pZq4EvHEHa93WKQakoWZ/ekKH8uEFczRfZqz7Rk99cyJ8RNEYPDmPJYARGWuRmn2osP3ZD/J+Q3EU4w8FMQFotXz9lWoUE+TZxm8SyCrN6jD3tv8Ak68dX9Wpql+uPpu+UgOdq5eAocxx6PHWzxR3bnw8jBupwaUBAT/bNwbiG3MBmdiAnItZ5hXpIKMc0PSnazYwCuTyJofnWF6LLIXWXZQMa+kcD4maG623bJB+1S1ysKPiOtNsI1i6UDCakmmkp7v2xkhH7HNE6oayc7JEeorSfvZyiqy0mSeFkxk7PMt4I825+vrVwPUtHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jt/JO6YC2I9zQP9XpgsgVW7J3/CmOv93ntU2A2VZdvo=;
 b=W4/hP+zNw2kIsIfcQv9nSlKq97S5Z0gqZb9+NvOcS/i/YtCCiHnGeIZgV+HUrJoB+cZUBakJ2+LKIwiKrwkEHRdjH3r7PhYRTzAk48GLjV0Ol6iHPEN0U4LpQnkhIJZ73qEdn0SEGaeFOP7CzbWYy/M/EC6TrXi5LfSyV8LhMBAU7q+lYlVxW/XW/4W2IyvXmPC0DNi21xeVxgN9//b9Zp3z0h4oOLOQoU6lmUxA2wg2COqCmEQc5er3eugGXbIiF4Q/EB3UyD7mLhgIDmB7ELxS120ex/rHT4mFQeGjhidkoMrTH2XyBN/gxvUbMjv1TJyvicS73UsTJOhp0h1lZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB8475.eurprd04.prod.outlook.com (2603:10a6:102:1de::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 9 Dec
 2025 02:48:05 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 02:48:05 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v2 0/5] Enable USB on i.MX8ULP EVK
Date: Tue, 09 Dec 2025 10:47:07 +0800
Message-Id: <20251209-imx8ulp-v1-0-97e76ed1d967@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKyNN2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwNL3czcCovSnALdtGQLC4sUEwMTUxNTJaDqgqLUtMwKsEnRSmVGSrG
 1tQAUvSX8XQAAAA==
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>, Marek Vasut <marek.vasut@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Stefano Babic <sbabic@nabladev.com>, Lukasz Majewski <lukma@denx.de>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAXPR04MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 8467351d-853a-4b81-7cfa-08de36cd60ab
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|19092799006|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ri9zTFU0MjhzMXVndWRGenV4OTV0c05FZWhCQk1mZmR1OUU0TGVKdVBibXVQ?=
 =?utf-8?B?K1d2YnhpVlBnMWNCeTZIQnNxUzJwQkhxK0hxNjl1ako5b2VDc2puMWYyTFhk?=
 =?utf-8?B?dkx4VHMrbGlUYzZVeG93cnBxa0VGaGdTdkZhWmJqOHdzTEZTZTZWZXkrUE9T?=
 =?utf-8?B?WEJIUVUrZ09Da29sb3dRMERwc1lseUJCcFEyVTRCZC9OTytXaldhUnYvU3dj?=
 =?utf-8?B?N1IrU0FVSE9YQ0ZQb2FkOXlaaS92M0pUeWlTMzkweS82aVlNYUZwekJKMVJi?=
 =?utf-8?B?WXV6S0dXYkUzdk1FdFRUeGJnalRBZTZFd3A0QjNmV2MrdmFVV3lUZDlzaWxx?=
 =?utf-8?B?ZEZLZWJZemc4cVZIMkJBemZnSXZzbTFuUEpuVk54MlI5NHVYOHRiRmVIR0h0?=
 =?utf-8?B?WVZscjlMamJPbWY2T0s1UTlieCs1MmlKajdPV3NSNEpFME5sekxHaUNadU0w?=
 =?utf-8?B?Z0hiRjJUVmxRYm9JUHMyUWl3T3pOc1gzUjl0U0NxV3lkU2J3bm1IdkdhY3NJ?=
 =?utf-8?B?QmJzZ0s4YmgzaHhuNWZDWHRRZDNZMVdhZG0zMFdGbElPRE1SK04xK2dRVWZk?=
 =?utf-8?B?OHpSM3Y3MFVpSmxwbEFadi8xUnd5RGNEQ2xXZFZnMTBVcitzbTlTRWh5T3pL?=
 =?utf-8?B?WFBTT3NPcTA0R0ZmbHR6TzlFRUJFNHpnODdGOTJHejlWRFQ3UU55S2FIR0M4?=
 =?utf-8?B?OFdJbnhjTnhuYk9pUUdFbkpscWtHdFhiOTFBM0cyS3FJWGl3Si8wS016Q0kr?=
 =?utf-8?B?OGZqbWF6NU1ERmE4T3B5ME4vVnRMRkVWUWkrZEg1UmtiVnVkWWxjNDE5U2Qy?=
 =?utf-8?B?RURqdFFNbndsblJJYVg1cVI3Q0NPSG5WSFoxRjBvbllPb1JsbFFVQnRDTWY2?=
 =?utf-8?B?REY2YXRWa3RmdWhibU1CTC9sZnAwb3REeXRKSEZsa3VOYUJzQ0publV0U3Zv?=
 =?utf-8?B?b3piaUw4d203NUJoT0MwYS9XMmhPc0ZNNXd0YjFSWG84eU1vMVVCK043SkJX?=
 =?utf-8?B?bTRLemJKNnlCWnArbyt1K3dNd2QzTUxGQ2hQekJYRjBiMTFocUkrckJ1MzdP?=
 =?utf-8?B?Q2FCaEYra2FrMWRxL09iRFRxcTc5aXVNc2tqb2t0RCtTWEFkV05GU2F5V1ZO?=
 =?utf-8?B?ejJLb05Ib1dDUFNya2hmVHFSckxsUjQzczM1UWdRVHN5VzhybjFYdTl2aUky?=
 =?utf-8?B?ZlNrV3h2a3hVbXlmUHNUbVo0bmNiQUZPYTkzYWZ3Y3Z3VGtsL0hsVGFycVJE?=
 =?utf-8?B?NFZJVkt2dUcxRkMvSFNqUUxOcWFKdC9BdlpnWHJwMXV6WDlNc1BxdCtQV3Jy?=
 =?utf-8?B?RGJITlgvVHlzNTRTdDVnWElzY0ZYUkdMekFaSnNHN2ZQU0M2cERPdVdydzdL?=
 =?utf-8?B?UGw4VEFzZVF1ZjlKalM5U2hzejdLOUJndnNSZnkwUW5GOUFXVkQ3VnpzNEwz?=
 =?utf-8?B?VFJVSkNtaFY0S29vM0xodndkd1ZyRWVPSzU2TkpwVXI1bVJiS0hlUTBmUXpr?=
 =?utf-8?B?Ykp1OStQYUFYa3pnTERIVHVtcE5ZOFByTnBTZk1kc2RZaGsremhmVFFPRUhu?=
 =?utf-8?B?dTdROXZ4SlBKM3JoYmtKcHhRNnNVMmFCQ283d1UyQUZueXhMNjR2RmVpVVM1?=
 =?utf-8?B?YnVmMDM4RXFhTXRGbi9ObENDL2laVDBGYk1Ka3kyeEN1UElheUE0NG9SWFky?=
 =?utf-8?B?VjBPLytGK29lUFRKQkpkU2dkMzJjYXgyQWlGM0Z6OUt5SVRrbE1seCtOWkds?=
 =?utf-8?B?OGZxT29EeDdTb284ZVJpTTFjOXUvRXFtZzdXK203U0NzL2EzZ2pUUE1Ub0lV?=
 =?utf-8?B?anZETndhUmJROW4ydExYMjdtRGhCeVQzaFA4YTNiQmFSKzBQeU1iN1JiOVhF?=
 =?utf-8?B?OWV6eXdMQld2T2c1WlRSVkc1K1VGT0ZjblZTcFR6ei83YVNsYkI0YzlsTWU3?=
 =?utf-8?B?VUJ1cURaWnR0eUpETXJQVkRGcjJCMElobXNtc0NOWm5oUmpGR1NTbnJ1OWdh?=
 =?utf-8?B?K2E4RzFxUTZ5bzVrWVc4UzExeUJSNDJBdXBvL2lRL2s3RXhCRHVuSzFEK1Mx?=
 =?utf-8?Q?0kV5r6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azlPc3g4RTdkOTd0MGRpQVJvV2UvazdxSS8yK213VnpnVWhHeHVoT0YrWEZq?=
 =?utf-8?B?bzZ0QnEyS3d4Q3FkbS9RMTVud0g1dmkwVUxTc0M2UUtaamJRRC9jbkhqb040?=
 =?utf-8?B?ejNKc0hsKzRmb3k4VFdmQmRWTFVnNWgyYmhuYmFpeWxOYlM3d0lOSU9wNnhR?=
 =?utf-8?B?cFpxMVE3djNCRVdVTURDT2g3MzlQY05FR0NlYVV2ZU5xVnpuaVViZXE0ejdk?=
 =?utf-8?B?ZGh4eWJCRThHVjFIWitjZ1ZSVjEwOWRQV3NxbHk1b01MRnlMMVFaME5URlFU?=
 =?utf-8?B?TFlGTmM3K0Q4UUYyU1RLQnN1QWZDLzhXYUlPV2J0dS9CSDBPT0VsR3ZoVzVa?=
 =?utf-8?B?ZVk2elIzVm5kZjNXMGlnbStMSThVV0lkaExBRm92aWZIS0JIdERyQ1kzRWcx?=
 =?utf-8?B?NVdyQlJuYzlVWkwyT05sWE1VOGlUTDNkSjVZWm1qQkpVREFRbjNGVDc4M0s1?=
 =?utf-8?B?eEttaS9JbzlxWFNZQ3piT0RPMDZxMVkvcE1Ua2FIVHZNbnB1NlRwV1FqbnJQ?=
 =?utf-8?B?R01Rb0s0a0ZDRXJMQ1ozWi91ZzVMTFNtbVlXNWdoMlZ0VUdZUUoxTUJYdnVK?=
 =?utf-8?B?dC9FM1lrL0F3TWVCeTVueDh5K3VyQ01FeTEyc0R4OEU5NUdjUzh5WUhDWFhz?=
 =?utf-8?B?clBTM0RpWnFlcW9wNHd2WE8rZHdMZ0J1cUs1U1ZNY2xBRkwvRXJBeElsOFpZ?=
 =?utf-8?B?RjZHcHVhcGV2Z1NxbGpmb3kwdDU3aW5zbUhZNVAxNTdyNXBYQnFKYlkxMzNk?=
 =?utf-8?B?d2pqS0wvaXI3QmJmUTd4S3NvM3Q0ckkyMHBxMStvSmRPM014RnN0OFRnL1Yy?=
 =?utf-8?B?aUd4Mm8rWGRHdTR4VllTbldTTzdDcUcwQURQRmduSTA0MHJWa2xvbWhFUlB3?=
 =?utf-8?B?a2F5VDk1VDBNYzBiTG12NnYyT1VTdkdOZWZET01zYUo2WW54WlBSSFpQaHBu?=
 =?utf-8?B?OWhIejFONUxmNnRETXVqWkhqMU1tMEIvSE90MzFONStsdGw3cVAwMGRUUkcz?=
 =?utf-8?B?UVYrK291N0ZEeDY3NzN1dEN3MXVqV25GVElBVE81bUJveVhsRlhUZDR4QWcx?=
 =?utf-8?B?M1hUeWFab1pXRlp4L21JM2N5eFRJSWZpREZSQXVLSlZPb2U2UnBVUWt1ZEg2?=
 =?utf-8?B?TDd3RlliTEZadG9uMEl0UElsY21UVTkxVVMvRUR2QUNYbTdDajIzZUJtbHA5?=
 =?utf-8?B?U1RMWVlML2J4aGlZZ1YvVTltdVRJY2U0Q1FUUXgvNWZlOE5zK0hhSjFHdTYz?=
 =?utf-8?B?em5FTzlMVTFFcFFiLzFjMVd5YUJVdENpaFdIcTJmd0taT1VqU3pjZ2UzL1Js?=
 =?utf-8?B?RGg5K0ErekVBTlFlZzZ0b0Q0T291NlV6a3E0akVUTG5EdHZrVDNjdWZZbmRl?=
 =?utf-8?B?eTdjc2k4M092Q3hnRzRKR2tzOXBDV2w1RjVpRXpaTjUwUkt1c0lnTnV4UDJm?=
 =?utf-8?B?dVNMekdyT2tmZWVuNGQzRDlCWi9yRXcrenJCTTd1Ynd3U2RQSGQwdWp5MEND?=
 =?utf-8?B?eWsyWU5JT0VSZmo5Mm4wcWFJSlBuaXVJM2xKMjgyZVJ2R0E1QmcvYnpJSGNR?=
 =?utf-8?B?cGM1ZFZaWXFFM2VxZkh2L3BCVit3bTZaZXp4emdMbUdVelhiSDZsRTBJbHNm?=
 =?utf-8?B?K09PcnR4a3ZVZUE1V1ZnVTRXNlcrRys2ejdHRHBoU1JaNEswMExKWDFaSXd5?=
 =?utf-8?B?blh5VEdLZFB6eG9WSFFWcHBjZi9RTFBGUFZLTlFKR2k5UlVRMnc0SkdvL09y?=
 =?utf-8?B?VkRqRXFER3pnRTF1aWFQaHJYalZ4bm1Yc29aakZWaXQrRFZkOVlWZXBqdncv?=
 =?utf-8?B?UFpDdVBjQkRFaXpJMS84aURqRDl1cDVKMnlJYXNqNGVOWmZlN2hOKzFqbmc2?=
 =?utf-8?B?RWhXSWZKNGZUS3JwV2NBS3FsUDM1dzFwMEhxOVM4MUVQdlV4ZEE0YnJ0YjFo?=
 =?utf-8?B?cExBc05XWEwyWmI0ckxyQjZGMHBLbSt6UnVibnBKN0lIMnovYVpLalRZOVU5?=
 =?utf-8?B?dzNWSXI3Ym5ubnJvcUNxSEZ2MThSRFlKbi9mdVd1b0RuTjNVZHlWR25RWWYv?=
 =?utf-8?B?bHRjZlNJdTZQelA2cGZzbzdmcVZ4SWtFZ0VjQ25XYlpMWUNMYmxScjhTMUc4?=
 =?utf-8?Q?2fGZmIUHH8yERcJHuS3+dgKhl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8467351d-853a-4b81-7cfa-08de36cd60ab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 02:48:05.3542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jFsVNBIN4kFkKd6eccxtv0ArU0xHsl8ETgjXEGLJ5/oy4pNZRhMwroizKqGktQxYmoCCG8g68oek3Dn5A9QUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8475
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

Changes for v1:
 - Enable the second USB controller (base address 0x29920000) on
   i.MX8ULP EVK in host mode.

Changes for v2:
 - Split the part that replaces fdtdec_get_addr with
   fdtdec_get_addr_size_auto_noparent from v1 patch 2/4 into a separate
   patch.
 - Use the USB node from the dts/upstream.

CI: https://github.com/u-boot/u-boot/pull/839/checks

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (3):
      usb: ehci-mx6: Replace fdtdec_get_addr() with fdtdec_get_addr_size_auto_noparent()
      usb: ehci-mx6: Add support for i.MX8ULP
      imx8ulp_evk: Enable USB controller at 0x29920000 in host mode

Ye Li (2):
      ehci-mx6: Add powerup_fixup implementation
      imx8ulp: clock: Drop CONFIG_USB_MAX_CONTROLLER_COUNT dependency

 arch/arm/dts/imx8ulp-evk-u-boot.dtsi |  4 ++
 arch/arm/mach-imx/imx8ulp/clock.c    | 12 ++----
 configs/imx8ulp_evk_defconfig        |  3 ++
 drivers/usb/host/Kconfig             |  2 +-
 drivers/usb/host/ehci-mx6.c          | 73 ++++++++++++++++++++++++++++--------
 5 files changed, 70 insertions(+), 24 deletions(-)
---
base-commit: 819a82c35354fee6680c4ccf1edc91a50802e4e9
change-id: 20251209-imx8ulp-fc888d404545

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>

