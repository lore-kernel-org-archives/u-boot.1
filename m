Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A6CC87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 11:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA57383121;
	Tue, 29 Jul 2025 13:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NbT0jXB0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A42D683145; Tue, 29 Jul 2025 13:20:17 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95767801DD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 13:20:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypzLgNpaJLIhcfFlUI3iyRqXBb/FaPvJHN0pepWRkESyWYH9oeZ6s2ILW7gtDrWb2M5DXx/rFxlryx2LAkkEwVr3MVKr5Q2Gnl+FAEgJNp90ZVNDOFuNXUkmXkNP12Z1SAhDstIQCQpC6rUU8AMEUb6cOxg8lR82chrbaExvut7w2+o6i7XVwKmgqVZZchs+WaD5/lb6zVa9o7puxqvahh9Hxip64cF4IO9OiJVaefas9stFrMPjfQsOLW2wCfi0GmfVW0cbmxhx0+4nuF2PiOV0LKA6qpWlQGnQ0rZ6CtNSBSvltLdSV7Cj//TAVdL4/ZyDsLsEQmH/D+rKHRbKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nK7CKpJSZL8W+wCTZBZpwXIJBA3dUWTHs8zxmYCaRdo=;
 b=lYwSOcqXRQpfiYowrRwnjusZ87VNcKqxbeb3PZpo5Morjs7hrniOjFPMzmyJBs6DleifbtrlWY56p76Th/w2bFIO1Rs1nLtYCh483j+Hqdk9yEOZukGHcw4BxGUbB682L4k3KSiM2pK5fL7WxcG0F1QVuB08p8QJvWgBCSgcNGsyXxrKM8EKVsjTU7XSwBnN5m9AQIEZpdMzFvZVtnB5kgWDp2HKYKU/la+AoE/JFIrqU6QCaEVfXEuuUwoYPBrwnhbxHw/vpuiggylAzl6XECJHknoXD5pfTq3UeBaOAersbqD5wRo6lmnF16+FUuE6hUYot7XptBOldGJWPqdNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK7CKpJSZL8W+wCTZBZpwXIJBA3dUWTHs8zxmYCaRdo=;
 b=NbT0jXB0fdC4KQZOLTEIGtSSZdBCbsvx7piNMc55J7OB4n6168+DAt74cjq/5sJpR7gN2uaTVxBmB88bp6QwdycVwhVk3XURpM682fp/lUh96Ey5UbAlFM8HsnYghqtPHws7ZVrhosggqHIO9vjb3YelpYWvy+kprqAZnvnAWTqZk8jCdt/NvUcxFNWMneCl7wwXaH/Nl/CoKp9/lGBUPRuu7qoISEvIVDgIMrlSwNf48o0ImvPwIUmVO5zJ3ADzdprbHLHfedfG3sfsBs0hgubZzz6KsdkA1I08G94896XlfG49Zi1Bw6+XaAG4sd5aFLnnwMYYpMKAk5Yw3QF9zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB9977.eurprd04.prod.outlook.com (2603:10a6:800:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Tue, 29 Jul
 2025 11:20:09 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 11:20:09 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Sun, 20 Jul 2025 06:13:57 +0800
Subject: [PATCH 6/6] imx95: Add support for booting from USB SDP on USB3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-imx95-v1-6-759619b47b1f@oss.nxp.com>
References: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
In-Reply-To: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Troy Kisky <troy.kisky@boundarydevices.com>, 
 Adrian Alonso <adrian.alonso@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB9977:EE_
X-MS-Office365-Filtering-Correlation-Id: ca9093ed-b1c0-4c3d-d52c-08ddce91e0ef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eG5ZU0pya3V2WG9WVXdZc1IyaitnNnVIYVB6ZHlpQkk4dUEzbk91WTAyRlBl?=
 =?utf-8?B?dkFNNUt5NnhQUnJ2RHR1UWdiTStGSHVTTmpMYnc1YzZpM01Ub3dzWnNxVUtk?=
 =?utf-8?B?aTBaaVp6ZUJpa3RXc1lhUmxLaDNGaFF0Z01FRG5VYmxZczlSRFFHTFQ2b2R1?=
 =?utf-8?B?d0lJM1dZRWRWeG9nQUMwKzdTaXhMdUZQamk3UjRHemFpN3I5N2s3NExCeWhp?=
 =?utf-8?B?RytQRTB4b1NXQVFsTkU3aWljNk5DZUljNWpIQ25za1FHbWwvL0hBNlhNcEhP?=
 =?utf-8?B?bU9XS0wyMmtLRDZHY0tMdFVMUE5MNjJianVUZjhwSWlKSEdJNWpTT0ROY0Qz?=
 =?utf-8?B?QmVKMkgzekJDRTdmaHJ0TVJ3dmlkK0pLNllPZ1g2MFhjSmxXUitXYUtuTnA1?=
 =?utf-8?B?dXAvd2I1RWRnTERRanF3bG1BMUhPMG1saWVzbTRrdFBLcjYzUFFnYUVGZmpM?=
 =?utf-8?B?UHN1eWhMVThtckZoT0JEbm0rdnRkZ09hOEZKRkRqVDJIbEZlOTNhcGNFcWxu?=
 =?utf-8?B?VFdIYmJZNW9QUlVNVEdTT2R0alU1SVlWLzFSVC9KMXZxTWJ4bm1ZdGR5YlVa?=
 =?utf-8?B?eFZOKzd1YnBNUXFBZE9HeFZXOEJScDlBU0ZlT20wU0lpSkgybytFMGM4My9W?=
 =?utf-8?B?Rk1JQXpQVW9VQ3pBUi9xbzBpVHJVRm5hb2FjU05SMmErZ2ZCMThlUXNQRlBQ?=
 =?utf-8?B?RVRaTExWRHVzOUxGZ3hEaGlVMW5MSDF6ejdJd2VyQ3JjZEo1YmYvZjdQamw2?=
 =?utf-8?B?TVhwc1VVdytGUjltTWZIT2dKMTd2M3lEYnJOSkk4UkRlMGRyS3V0ZzdOZnkr?=
 =?utf-8?B?TTVveTNRQi9PVnBOYXg5aWs1QjBFNWU2MWFTL0lvTEFNUXdFd3BmbmVzak1X?=
 =?utf-8?B?OHVpTm50Tm5qa3U3VFJqbitRbjBLdTJaUjJGaEdLaW5MMlFRZEdEeGVEWU5s?=
 =?utf-8?B?Z3FLckRNK2ZMaXZQTG1iZXZjc3ZPTXBFbU9ERFhwY2ZSMDJoQXFtenBjbXNF?=
 =?utf-8?B?SDIzd3RxV0N3eXh4aUpIWENON3ByTjRnK1NvN3h0S1c1VlJsT2ZIc3NGWWhE?=
 =?utf-8?B?QjRJTWNaa3BEYm9QbFE0dTMrdlgvUE9LaUxSRWFoZTlmUkEydjJtTEZIN2RX?=
 =?utf-8?B?THBvV1gwUkpmcEltalFvSDdaRHY5UEFka1JnSmNXZVR3aUtHMFdPRjc0WnRH?=
 =?utf-8?B?WUFXR1RDSEMwU2ZkSXpPdXlqRmVQNVhvUDFPazIzT0ltY1ZVYk9haHI1MTEx?=
 =?utf-8?B?M1FYRm10MmpSYlVxYlluTmFHYVE3MXlRZDZJdHhqK082dVBTL0lNQTVvSXZM?=
 =?utf-8?B?b3dQeHNWaUt5ckNScW1DTXF6SzZSMGdIcldKbFJUNENjNkVXM1lJdy8yaWFl?=
 =?utf-8?B?YlJwT1dvSkpuMVZZYTlMbWdJalUycklhdldRUDlNNkxqUXkvVmZHLys3ZnpM?=
 =?utf-8?B?MDNzMHVGVkdQSUR3TTBieGZ4Qm0xUUhGZDR3aWlWQkVaVXFVOHpOS3dkdWZK?=
 =?utf-8?B?WlM4bGRVRkVsa3hDNDBzMG5oRTBWZUdnb0lHZDVVMWR0QzJXWW11cWtOQkpE?=
 =?utf-8?B?YnJNekE3aDV1RWdxT0EzYWlFTDhZb3JxVzg0eWdKWHVEM2VoMnpWYUE4ak5H?=
 =?utf-8?B?Y2htRzRzb1BldlE1UUIyMlpaUnFkaS9UelNFYWY3MldIU1l3MTJqTW8xZjZ3?=
 =?utf-8?B?cDQ5ODRVcmJUQ1pWRUZkMGZ2UVNSTCtOUmdXaHZYSU9EOXh5dmsySDgyVUo3?=
 =?utf-8?B?WWwwRjhHVjR3TzJWdFRkWVhTU29UYTFMZGVKU2svdzVERTIvT3JCRVk1clZN?=
 =?utf-8?B?R09IQWt5QUgvajY3SDQyVXk0enRqa0t0ZjZ0M3NnRXEza1lGUW81TzVpWUpy?=
 =?utf-8?B?anR6NDdJaTBSa21mRk9MK0x3eEw4eHkzVFVoUTc2bFBDamQwY1hiZTVwenVy?=
 =?utf-8?B?dFVFRGh2bUlnNUpCbGFKZVg0b0xvaFhjdTU5YjJaZWpBVlJzcWk5WFJjTlVq?=
 =?utf-8?Q?NvfXxBVJoqjqWKzpSXe0U6tgPUxVbs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzRjSVYvY0FFcmJadW9KQjFqMU1oN3dSZXdkdmdJbDRubDBhL3VmRStxZENL?=
 =?utf-8?B?OHRHTG5jc0xJNFhUSk8ybThiTXRnVGx5QmNoWFFxdWUzNFRIclM2MmhmWmlX?=
 =?utf-8?B?UmpyZUhURTYyY3E2NWt6TFIxbmhPVFlZTXhqYmJjeERRazdhamRSa1ZQbENQ?=
 =?utf-8?B?M1RoRlgwL1plSmdEclVLWk13dHNoc3J1YTM1OG92ZTFlREJMVnhnSFM5S3hM?=
 =?utf-8?B?b1RpU2ZDdlVvOVVxQkFoWTR0WGFubVowbHIyQ2NWbkQ0N1lycU1Bc0UrWlU5?=
 =?utf-8?B?SUptVjNDVDJINCszaXFsQWt1NlFMWU1KZllNQzlnWWVRdWkwU2VDelFmOGhk?=
 =?utf-8?B?aFFibWVEZGJDMW8zV0FvQ3lUcG43QldUc2xmWFV4eXFVRnNDc205cFdSU1VR?=
 =?utf-8?B?NENYSWxNYWFWdU5rZlF2MkhhclFLQW9EWnQ4WWhFWTB3QUQyV3pxamZrTFZX?=
 =?utf-8?B?OEovbm5kcVRaTUZSMjI5RlNWbytsMlBXazFUOVcrbVZCZjlON1pjamo3N1Ju?=
 =?utf-8?B?MUNRVGE5aTYxcTAxOXBqb0ptR2dZc3AzZXRHNnZEa0VEelRiblVzU2RablJq?=
 =?utf-8?B?UllUcE1mT3U5Z0daN1p1UjkrVUpFZXBqY1ZvVmxXc0dqc050NUtYWHNwWXh4?=
 =?utf-8?B?N3ZSdmJWUW9BNWh6N0ZYM1ZmODVKYXZud0h0ODhON2dYT3h4UDE0K0Q2bnJo?=
 =?utf-8?B?Vk5EblhBSDBsUnpDMUl3dHVUYnZCV1dLVFE3QVJyVzVYUTRPTmtlalhWRlV3?=
 =?utf-8?B?WEx4dm1CRTlBYVFNbnRSSkN3cndtczM2U3p5ODA2M01sSm1rWU9UTFhlMG5U?=
 =?utf-8?B?QTVSUXBQc2xiODZRdzVBaUZkU3lrVFVlL2V4NVJmQXZFNFJFTC8yVEQrWHdh?=
 =?utf-8?B?SDN5ZkNidVBjRkxmUC9MQzNibzdzODhWVXIrWTRobGR6M3U5T0Z4STZDOWtV?=
 =?utf-8?B?UXZQRkYxOU9VeVNlaEUvZlNPWVlHWjJ5VkVwcjZ5RzZ0Q3FSYlcwN0V0WTVa?=
 =?utf-8?B?dm5sa2U2Ym5OY2wvNEFtclptU1V0MnBoQWR0NlVFUFV5L21TZ3RmS1BMVy8x?=
 =?utf-8?B?ZnJlZnFaYjVsSXcyd0FnNThlUTFrNHc1T0VJOFpmQmFGWlJHUm9IYkVtektk?=
 =?utf-8?B?SkJRakF1Vm1sZUtHY1NoMlR0eWZ4R1dYOEhOQVQxdkRaNEg5NktDcENpeGN3?=
 =?utf-8?B?VmUzVEcwUnpyTlNnREhRU0sxaG9aUkFRUGl0TTcrSlZqcWh4SUFxWjh4anlZ?=
 =?utf-8?B?N3ZEOGFUMmxURTB5eno0dUV6LzJVRXZvbXJJZmcvSXB1eFBIRHpXV0J5cUpL?=
 =?utf-8?B?V1J3Q0U5V2szMFZNRm5jdHhaNkl3M0l5c2lhNFN0WVQzSFFibW1HN2RGQzFD?=
 =?utf-8?B?aE5FckVDQWFUcEs4Rmk4WnJrWVdrOVV4WlNiYUt3N1RVemVNcTVrVEVDWHlk?=
 =?utf-8?B?M09XL3RnUk9GR1F0SFEvZjhBYXduRzJIYlU1NlFtYjFtZlYyN29leGp1Snd5?=
 =?utf-8?B?SDRTZGI1ZXRHcmhRdGF6dksrS0NnQmk0TXhWQmI3RlhmaktnbzlsRk5FWkV0?=
 =?utf-8?B?SWhCVGxNMjI2YURMSEN2TVp4KzdlNVNUdjRvaFJJenhsazVDRDBFOHB3dXdD?=
 =?utf-8?B?akd1Z2ZNaU4vRE9zYm9oZm9GdzZDb1BVdXFsVEhGWG85L1F0dFNLNmowdG85?=
 =?utf-8?B?Nmh2UmdlU0FuNEJzcThQK0c0SVg1bmRYbUhQMy9mNS9lMFJiNmh1RWN4U2Ri?=
 =?utf-8?B?eVh4YjRmcEVHZW9sM2hlejhhaGg4bWlFY3o2YjdLVTRQQW1ZaGtpQlpXd2lF?=
 =?utf-8?B?cFpWWFNBa2dpRzByTFdJTzB4THpIRWlyd1RjU1dEV1hoR0gvVjdsUDd4MmND?=
 =?utf-8?B?akV2NzZYcVlQT3FIWmE3Sm03UzZtL1BLZjF4eEhLOS9lZEd1ZmpYNkJOTDln?=
 =?utf-8?B?ckNqOXFHVzB3SDU5VCtxazdTZWFQZERWcW16Uy9lMDEyNnF1RmhzRHdKeDRS?=
 =?utf-8?B?cnJBZDNmZWo4emE0WUcxNU9ieFAzSUYyUHJMa2ZRQkpaQmk1SVVxbnltTzNT?=
 =?utf-8?B?Q2R5N3pwNWRNUHc1ZGpRbHRtS2tRbWhHRFl0NzdoYkxtVWk3U21DemdtS0lV?=
 =?utf-8?Q?ZtK+PtJT4fVI0zKxZF/7LAtA7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9093ed-b1c0-4c3d-d52c-08ddce91e0ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 11:20:09.7962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4fuWXtgtfWVyh4sCoYuFIiswcw+VfBRP/zl/La/yc9V8S79qO6oc4K9mU46xToGC4efza5frU+QerAsJt/2NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9977
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

USB3 nodes have been added to dts files in dts/upstream now. This patch
is used to enable USB Gadget in SPL to make i.MX95 19x19 evk board can
use SDP on USB3 interface.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi |  8 ++++++++
 configs/imx95_19x19_evk_defconfig        | 13 ++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
index 2d1f02baa5f..f60ca4b9346 100644
--- a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
@@ -13,6 +13,14 @@
 	bootph-pre-ram;
 };
 
+&usb3 {
+	bootph-pre-ram;
+};
+
+&usb3_dwc3 {
+	bootph-pre-ram;
+};
+
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/configs/imx95_19x19_evk_defconfig b/configs/imx95_19x19_evk_defconfig
index 73818a82627..306611a9169 100644
--- a/configs/imx95_19x19_evk_defconfig
+++ b/configs/imx95_19x19_evk_defconfig
@@ -42,7 +42,7 @@ CONFIG_BOARD_EARLY_INIT_F=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_PCI_INIT_R=y
-CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_MAX_SIZE=0x30000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
 CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
@@ -147,6 +147,17 @@ CONFIG_FSL_LPUART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_NXP_FSPI=y
+CONFIG_USB=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_DWC3=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
+CONFIG_SDP_LOADADDR=0x90400000
+CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_ULP_WATCHDOG=y
 CONFIG_LZO=y
 CONFIG_BZIP2=y

-- 
2.43.0

