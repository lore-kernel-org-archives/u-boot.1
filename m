Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75101CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 02:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCD5835A2;
	Tue, 23 Sep 2025 04:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="F/xwF0iZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04039835A2; Tue, 23 Sep 2025 04:15:32 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D2383211
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 04:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mjd4w1KYauBZ5xvDh/m535rM8Lxo5jyPNhA+EPZ09/Yp5unejHGbQ64/hzQaAT5QOjd8XPznKPLFVGYHHvhm4oAEU6yzUxVC7G8SctQV6+NSQym9OW4j97BvA9rjltufNHY8Yw1qVOPNtyxsFOWVMP82cV29AvNYl39wmn9e+ZgImJAEM6vRuH9jEeIA2D18qKFhoAiGPKtS1W4SkBWe6GATuWvzHx7NxabR3lRidWya4N9vugYyTBrMEBB+1guNRr37+HYDEnZ1VsIvTjvyX4ttQsn/NH06vwK99sZFPiEJ7fasB88L2OXvQX1B3XfdC/GxiR1Rnh9GSuctcCn4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sn9GKGT+nscQyydekZplRKPItjgq2kyaVPTfj5ffT94=;
 b=wjmNibp32Bn1c8g3GYE/xAANDQLk/a+QkvWx6XmbWgQ1rLlh5fb1QofTjke7HoS3YwTdgEzf3EaYKWjadRk/HAizzPvCz1+qyg1U2X5fsYHNSoaAyjex6N/M5VyvdEzyAZbWDRX7BBQ46Zbp9kSNpFQZzM7Bev70s8LTNfv6I0MWC1EAS0TLCo/7FJBSr9puoRMF4kELze9I9gBvODkphD3ztaMmVDC3hQyiLdCuqcdwi3mwc4OzDCIOEZXskzCPrylMnLtZYdYOZLpfm/L22CZLMd6Zj9SIBlbQAHTm0y8rzGeKJIqi91cV41PGTvG+TTk3/1He9h855YTwVJ/m1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn9GKGT+nscQyydekZplRKPItjgq2kyaVPTfj5ffT94=;
 b=F/xwF0iZRB1wChrqEytrL4KXi+L8/y4W1JjT5Cq/67papsmQNBVqEaQ4OJ0iXoRDpIjGVU5aw7DOyCT+aj8awmglVY+4GaWL/TJJ4uoYk0JPlnO06M19POezxOmpdeEUEQLFs6XFzOjq8nQQ+r62XJqnuaDjFp4LM52GKRV4MZV0FW7xfQOWHzAsaLw+K+BgFXXBYE0NwD71eQ/BvExKkUyxwbq2dIX5PHslby2+7Wi/ov6SQDWIzYjpMO6PY3vweFgoye/Sz5TmbiH5ThAQdab8pbSPtReV5SK2nyEwMWWRunANKbGwHNPzemd31AKe6LwPa4HINv0cNoWze5fJPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AMDPR04MB11297.eurprd04.prod.outlook.com (2603:10a6:20b:6cb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 02:15:28 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 02:15:28 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 10:14:57 +0800
Subject: [PATCH v3 05/12] imx9: scmi: Update the files under
 arch/arm/mach-imx/imx9/scmi/ to support i.MX94
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-imx94-v1-5-cb3b65169048@oss.nxp.com>
References: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
In-Reply-To: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AMDPR04MB11297:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2e0fcb-8c16-4ae6-1f51-08ddfa471036
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akdjNEFvME1rdXhyQTBONGVWeU56NUNoRDZ6WTlTZit4NkkrMkVoV2NWeWo4?=
 =?utf-8?B?SzN6a0tNWWFKVUtwdHpxaFJjZTFZMGhaNnlDaHlHdEdUVUtaenRBSS8vVEZM?=
 =?utf-8?B?aXlHTFpjbDAyV2FJK1JEckl3WVozQXdvcVlQNG1tRWovSGlrS0ZCVG44dXFY?=
 =?utf-8?B?WmpRaTBubU9SeFdDbUlwZitpWnNnUGNKOUE4VndOc0E5QkdmWmxPMlhYQ2ZE?=
 =?utf-8?B?ZmIrRmZUMk5pcmJJZTNYdUN0NUhPdFdpellyZ0JqbWpjT0tiaU5sVi9XSFNZ?=
 =?utf-8?B?bDFXSkovTE0xSDNOYmRKUytTSjkzZUlISk0rV0JDajlsdWw3clNCaDY0NVZi?=
 =?utf-8?B?SUk0ajhTbnhIVDc1QThkaUpOb0lubHlwaUdLTU0weURlODlNek8vaWdHdGt3?=
 =?utf-8?B?U0FCcmtUUStNSE1vN09qK24ya3F4QXpISnhTWEM5aVQ3eVRwWlEzMms0VEZ0?=
 =?utf-8?B?dWVFSnhhN3VRTjJvelpxb1V4RXdmZ21SU0k4N2lBVE5vNHNnVzMyOUpXY0ll?=
 =?utf-8?B?WG0rV1Y1QlN0NjJudmVSeG9tUWxTK0h4V28yMVppdTJvaXdRVFJXYklkWUpj?=
 =?utf-8?B?OFRwOWU4NU94QUpCS3lGVnNIZzlSTmdjTjRkSzcvQU1yTzZRQ1FaaExjR2c0?=
 =?utf-8?B?UzFwLzg4cERwY0dRbG1UREx3RlRzc3N2b1J5Qzh3TnZBWkpVVEFQTXk4M2tm?=
 =?utf-8?B?aE0ydGRqd0JsL2FUb2dGZWs1d2Rub3dpTWxnbzduSnhwWkl6Y1RocDU1TUE4?=
 =?utf-8?B?d2Z1Y3pyeDZCRkVhRFpUaTFJbk9kZVdaS2YrRy96TXliU0FTZGZPM3pjazF6?=
 =?utf-8?B?M2RmTUVMRWc0cGNNdWpEbU0ydXdBR0pzN2NCQi9sVnROaVJ4NnFUWHNqT1VX?=
 =?utf-8?B?Wm05dkpFd2wwMnErS0YvSTFMcU1qSmdWaEhnNC9LK0J5OFRhTFhrdGJ5WVZK?=
 =?utf-8?B?d080ejREY3R1T3QxSmRhdlZkVW5xejk1ejgyblg5SStjWjNIc2hjN3NNV2c5?=
 =?utf-8?B?S2dIMWFsQzhzK21aN3VNZDVPSW9NUURPNVY3d2x4eW50UVBVMDRrMjRsOWt0?=
 =?utf-8?B?M1VwdzdRd2Z5Q2duNCtGdEVhbmY4SmVvcjY4b1NDRTZkZVlRbFQwSTg0bG95?=
 =?utf-8?B?NEU4MlVERHA3TUhFbVp4b0Jha3Q3eWt2RTNuVFJYczl5UjBLbkZCUmRTUFBT?=
 =?utf-8?B?RGYwK1hObkU4SVM0aVNObFE4MU9kL1pMT3VlaHdLMjZpaTE4b29Ga1ZMMjF2?=
 =?utf-8?B?VkYycFlVR3RSaU51bHVEZ3hKdnNpUFpraDF4UGVycmtyaDNvTjdpRjVHN0F5?=
 =?utf-8?B?dU13YUFsNXVRcGYybVB3WndpdzFtWEZRYVMxKzNwVXVXUUZqaElEQ24yazBz?=
 =?utf-8?B?VExZdmt0N2pKYWpZRTFLazBKeWhHMDBUUDUyVDVhTHYrQmZ2bmhJZEdvb2R3?=
 =?utf-8?B?VHJoNHVJYkFJWTFkV2NxZnRoRnZqcDlrRk5GVGFtWlpOWGhwOXljak5RQVQ5?=
 =?utf-8?B?OFlFZmRRdFRQWUtTMzZoNWlLbjdldXQwbzZKTkc2b3JCdUlEQy8vc1dWalEr?=
 =?utf-8?B?VnltVHRpTWhnaEg0SGYxRE1VaU9DWFFZRkJlQnFEYVR0a0ZjNFNWVmphRHBO?=
 =?utf-8?B?bks3TzZURDlHQWRub2pkNTlyZEVLb0g1WHpxcnVkUzVyODM3dDF4U0xWTHZT?=
 =?utf-8?B?RUVzQzB2SXVnZTVJY2hvQlNFbUpXcWplTG9LVzJkSWk4OWcyZ3Q5ZFJaOGV2?=
 =?utf-8?B?QmRrd0F0Y1JVT1Z1bzBZaWZ5SUxhL3RVeDJ0YU9OazFhQzBmT2dKK1djb1VJ?=
 =?utf-8?B?ekw1elF1OEhTVzBuamtzai8yeXU5WjRKQ3M2eForUVZ6UGVOZ1NKREFjaExt?=
 =?utf-8?B?M1F2RXNnb0Z3bjVEVnAzdGNBRGFHZ0J6VlgzTVB5UXoyd0tKSG80a0czc0FL?=
 =?utf-8?B?RjdZVzB1M2hvYW9xSWhDWHAzbFFIaVhpMjI2OFJ2SVF0SnZBK2lKTGVsMjVB?=
 =?utf-8?B?RHd6THlkZUtnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFBxaW1nckNJRzJFMHVzRTB3NEhOWGZaY2dzQXphNjVFbmYrNnVhTlJBUjVG?=
 =?utf-8?B?WnRDZVZJM2FRREFKNUtjZ2dtM1BHMXh4TTQ1Y09kWmt3YUxvNGJmZ2FaSWl5?=
 =?utf-8?B?S3VZQWI1MVNyZThSaTFoLytScnR1UlJsQjRWVEVEM1BVTVlXMDNPZFhQRWVN?=
 =?utf-8?B?Y1pydlhYT3NVQjRUckRIUUMwUkpHcnJNa3MraFJMZHR5cHlTTG5ZNkRqcEov?=
 =?utf-8?B?bW9lbmZnVmtweU5jQm9pU0txNWNLVHVnM2ozbTJBWVp6bEk5T090MCt5Q081?=
 =?utf-8?B?b0ZaUk1kSW9HMmRUcFJxL0JyN1NHZGpaaE9Bbk1OTVZwQjNMbVpiU3dwblZu?=
 =?utf-8?B?RVcwOFBuNFo0dmxpSkhUdlJlS1I4aDVONHJZOTdJbDROVEN0TlRYRzU1bVZJ?=
 =?utf-8?B?cmQ5SlVrczJtd2NCd0dEbGJ0bC95Z0kwUkRuTjBVOGt1S3dpNGE2Vk5qSWtw?=
 =?utf-8?B?MlRpR25FZG5yNlNXMXFvMnViNHVaQ2VEamJDM25mRTZUMEFucjhlaC84MHNp?=
 =?utf-8?B?UWF6RzNsZ0tlSHZvZDZVN2Z6MTZZWDZwYUF4MDBoaXFvWkpJNzRDbThGMDRZ?=
 =?utf-8?B?N3drdS9URFIyamM5VDQyNkRiM1BJbjQxeHZVM1NXNkljTmNhN0NpNU1lOUcy?=
 =?utf-8?B?L0FJbUMwVnZTcHV1Ynp2eG56NVBmeWgweWtoZ3JZUXJaV1pnQ2RZSllpeW0v?=
 =?utf-8?B?VVkwbjlLZVJxOUQvLzdqTC94UmR2ZFlJbktaNEtSd2hQTkxCMzZWMEl0OW1M?=
 =?utf-8?B?ZUtjSjdSOWQ3TmZEL2ZvR09LUXZoOS9rWDNtYXhEcngwbmdLWXNyT1IybXZL?=
 =?utf-8?B?NzFqV3Q2QVhHYUFkOStoNFROQzQzS3NFa28zWHFydkNKeTA4Y3BxaldIMGt0?=
 =?utf-8?B?OFo5bWFZdEZ1NHlzZWUyQVZqY05Paklha1NzME90bDF0dnRLZlZwNjBvYXQv?=
 =?utf-8?B?Z2ROYk5ldStma3hFZ2h2KzV2Y1RjQjMvL2FMWG8yWHFEN0NNTDZ4SVVSK1Vi?=
 =?utf-8?B?M3lqRVRmM0YyWFhWakJUQlo1T01mUHFZZ2VLS2pMV0lNcm9TL1hYVDRLSUlZ?=
 =?utf-8?B?R1RWZDA0SHdGTzJPMnNRb2dNUFo3VC94c1hPaEdiclo0dG1kZnFIY2tONTY5?=
 =?utf-8?B?Rkx5NVBFUDAwS0I4N0JuVkU1Sm1NTGlmVEgxZlFrUTR3cEV0eEZwZkJvUDhM?=
 =?utf-8?B?WG5qcnRYa25SK2p0amJuRko2UFEyRVVUZmVaNU1kZi83OWJWMGF5V2p6QW91?=
 =?utf-8?B?SW9KaDR1SkFxRDFDRys1WWt0UnFaMDh2UG5zakZBWDlLdEdQTnhRempuTnZk?=
 =?utf-8?B?RE9XR1YreGR1d3FBN3JseXZyQVZOWEhtckl4K2F4ODZTcU9ERyswVHZPRzRy?=
 =?utf-8?B?QktvdU4zRVROMWdTRjlvRmU3YzI3alJyVjRlSnN4UGxQSDg4MDJCanlKK1NJ?=
 =?utf-8?B?QTNKaUxQdUorMUdJS2J5UjZDRCtuQkJCVVo3UXlzMkdzcG51Z21TcVVIZFE2?=
 =?utf-8?B?N29jeG1EOHl3eC9VUks4Nk9qbFAyLzBkd2laTjBJeUp4OTJHVmZZTEZPK3pI?=
 =?utf-8?B?U29DQWcreFdxV3k4eE1qZ293Y01QN0hVYWFlSFlzN2lzZDNDYjExOXRmZTgx?=
 =?utf-8?B?Mi85WktLbUpsc3BzVW8rV3pTMStyWXNYTmhuVlRBWlNxcEFrcW1MMXhIekdl?=
 =?utf-8?B?bHVYbE5SbzJhOGszT1BrK0Z3cDhveE1iSXcvVVlpUUhOQTBRVXBKaUJSUnR5?=
 =?utf-8?B?K21CaHRrN1JNL3JYQXNLY3lOeWtOTUVRVVhKK1lNNlNBRVBuSk1NU0tuWm9X?=
 =?utf-8?B?dmJMV0NLbTJSa3RoTXVCdmt6Yk5IQTQvZDdDb0xUSVVRMlZjOEt3MVF0VjZP?=
 =?utf-8?B?ampoc25zWFpBMUdReU4zZHUyVTR4R1ZlcXZYYWgwdzVCSXAvZWVKeFVhWjRJ?=
 =?utf-8?B?Y2g1Tkd6ZURhcFdkRWNpalRkdUtNanppMWFLOUJPblVZRXhERjlFdW1GbmZR?=
 =?utf-8?B?TWk2a3B5U1JyblF1anpxY0pSYUVjR2l6TzM0L3dDZkxKSDEzYXhwZnpIZ3Zt?=
 =?utf-8?B?UVAyeUpxTFdLNWwzeHNiK1h6WnBCNmlObE1ISkgwd3U5Q2ZQdHp2eFdBMStR?=
 =?utf-8?Q?WySQjHzkOxRgqrj+wOilppCgk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2e0fcb-8c16-4ae6-1f51-08ddfa471036
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 02:15:28.1185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgVrs2OxTw3oq69lIIZNF3khT82YtFiLQcnPLtawx3nOcu8VFUmGU9zgPC2faf/CvOVb8M1/ZKyFwYMmdm2Lhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11297
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

From: Ye Li <ye.li@nxp.com>

- Add base addresses for WDG3, WDG4, GPIO6, and GPIO7 for i.MX94.
- Introduce common.h with macros of clock IDs, power domains, and CPU
  types for platform-specific replacement (e.g., i.MX94, i.MX95).
- Extend imx_get_mac_from_fuse() to support i.MX94.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h |  9 ++++++
 arch/arm/mach-imx/imx9/scmi/Makefile      |  3 ++
 arch/arm/mach-imx/imx9/scmi/clock.c       | 29 +++++++++---------
 arch/arm/mach-imx/imx9/scmi/common.h      | 41 +++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c         | 50 ++++++++++++++++++++++++-------
 5 files changed, 108 insertions(+), 24 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index 5127fe8f286..a44fa6663c3 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -17,14 +17,23 @@
 
 #define ANATOP_BASE_ADDR    0x44480000UL
 
+#ifdef CONFIG_IMX94
+#define WDG3_BASE_ADDR      0x49220000UL
+#define WDG4_BASE_ADDR      0x49230000UL
+#else
 #define WDG3_BASE_ADDR      0x42490000UL
 #define WDG4_BASE_ADDR      0x424a0000UL
+#endif
 #define WDG5_BASE_ADDR      0x424b0000UL
 
 #define GPIO2_BASE_ADDR	    0x43810000UL
 #define GPIO3_BASE_ADDR	    0x43820000UL
 #define GPIO4_BASE_ADDR	    0x43840000UL
 #define GPIO5_BASE_ADDR	    0x43850000UL
+#ifdef CONFIG_IMX94
+#define GPIO6_BASE_ADDR	    0x43860000UL
+#define GPIO7_BASE_ADDR	    0x43870000UL
+#endif
 
 #define FSB_BASE_ADDR       0x47510000UL
 
diff --git a/arch/arm/mach-imx/imx9/scmi/Makefile b/arch/arm/mach-imx/imx9/scmi/Makefile
index 4534db08d28..b98744e1ecb 100644
--- a/arch/arm/mach-imx/imx9/scmi/Makefile
+++ b/arch/arm/mach-imx/imx9/scmi/Makefile
@@ -2,5 +2,8 @@
 #
 # Copyright 2025 NXP
 
+# Add include path for NXP device tree header files from Linux.
+ccflags-y += -I$(srctree)/dts/upstream/src/arm64/freescale/
+
 obj-y += soc.o
 obj-y += clock_scmi.o clock.o
diff --git a/arch/arm/mach-imx/imx9/scmi/clock.c b/arch/arm/mach-imx/imx9/scmi/clock.c
index 6e6541eaa31..951d47bd9d7 100644
--- a/arch/arm/mach-imx/imx9/scmi/clock.c
+++ b/arch/arm/mach-imx/imx9/scmi/clock.c
@@ -6,16 +6,17 @@
 #include <asm/arch/clock.h>
 #include <dm/uclass.h>
 #include <scmi_agent.h>
-#include "../../../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
+#include <scmi_nxp_protocols.h>
+#include "common.h"
 
 u32 get_arm_core_clk(void)
 {
 	u32 val;
 
-	val = imx_clk_scmi_get_rate(IMX95_CLK_SEL_A55C0);
+	val = imx_clk_scmi_get_rate(SCMI_CLK(SEL_A55C0));
 	if (val)
 		return val;
-	return imx_clk_scmi_get_rate(IMX95_CLK_A55);
+	return imx_clk_scmi_get_rate(SCMI_CLK(A55));
 }
 
 void init_uart_clk(u32 index)
@@ -24,13 +25,13 @@ void init_uart_clk(u32 index)
 
 	switch (index) {
 	case 0:
-		clock_id = IMX95_CLK_LPUART1;
+		clock_id = SCMI_CLK(LPUART1);
 		break;
 	case 1:
-		clock_id = IMX95_CLK_LPUART2;
+		clock_id = SCMI_CLK(LPUART2);
 		break;
 	case 2:
-		clock_id = IMX95_CLK_LPUART3;
+		clock_id = SCMI_CLK(LPUART3);
 		break;
 	default:
 		return;
@@ -38,7 +39,7 @@ void init_uart_clk(u32 index)
 
 	/* 24MHz */
 	imx_clk_scmi_enable(clock_id, false);
-	imx_clk_scmi_set_parent(clock_id, IMX95_CLK_24M);
+	imx_clk_scmi_set_parent(clock_id, SCMI_CLK(24M));
 	imx_clk_scmi_set_rate(clock_id, 24000000);
 	imx_clk_scmi_enable(clock_id, true);
 }
@@ -49,19 +50,19 @@ unsigned int mxc_get_clock(enum mxc_clock clk)
 	case MXC_ARM_CLK:
 		return get_arm_core_clk();
 	case MXC_IPG_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_BUSWAKEUP);
+		return imx_clk_scmi_get_rate(SCMI_CLK(BUSWAKEUP));
 	case MXC_CSPI_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_LPSPI1);
+		return imx_clk_scmi_get_rate(SCMI_CLK(LPSPI1));
 	case MXC_ESDHC_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC1);
+		return imx_clk_scmi_get_rate(SCMI_CLK(USDHC1));
 	case MXC_ESDHC2_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC2);
+		return imx_clk_scmi_get_rate(SCMI_CLK(USDHC2));
 	case MXC_ESDHC3_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC3);
+		return imx_clk_scmi_get_rate(SCMI_CLK(USDHC3));
 	case MXC_UART_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_LPUART1);
+		return imx_clk_scmi_get_rate(SCMI_CLK(LPUART1));
 	case MXC_FLEXSPI_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_FLEXSPI1);
+		return imx_clk_scmi_get_rate(SCMI_CLK(FLEXSPI1));
 	default:
 		return -1;
 	};
diff --git a/arch/arm/mach-imx/imx9/scmi/common.h b/arch/arm/mach-imx/imx9/scmi/common.h
new file mode 100644
index 00000000000..dd4675402c7
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/common.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef _SCMI_CLOCK_COMMON_H_
+#define _SCMI_CLOCK_COMMON_H_
+
+#ifdef CONFIG_IMX94
+#define IMX_PLAT 94
+#include <imx94-clock.h>
+#include <imx94-power.h>
+
+#define IMX94_CLK_FLEXSPI1 IMX94_CLK_XSPI1
+#endif
+
+#ifdef CONFIG_IMX95
+#define IMX_PLAT 95
+#include <imx95-clock.h>
+#include <imx95-power.h>
+
+#define IMX95_PD_M70 IMX95_PD_M7
+#endif
+
+#define IMX_PLAT_STR__(plat) # plat
+#define IMX_PLAT_STR_(IMX_PLAT) IMX_PLAT_STR__(IMX_PLAT)
+#define IMX_PLAT_STR IMX_PLAT_STR_(IMX_PLAT)
+
+#define SCMI_CLK__(plat, clk) IMX ## plat ## _CLK_ ## clk
+#define SCMI_CLK_(plat, clk) SCMI_CLK__(plat, clk)
+#define SCMI_CLK(clk) SCMI_CLK_(IMX_PLAT, clk)
+
+#define SCMI_PD__(plat, pd) IMX ## plat ## _PD_ ## pd
+#define SCMI_PD_(plat, pd) SCMI_PD__(plat, pd)
+#define SCMI_PD(pd) SCMI_PD_(IMX_PLAT, pd)
+
+#define SCMI_CPU__(plat) MXC_CPU_IMX ## plat
+#define SCMI_CPU_(plat) SCMI_CPU__(plat)
+#define SCMI_CPU SCMI_CPU_(IMX_PLAT)
+
+#endif
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 07022c65b88..5c1e13c9842 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -21,6 +21,7 @@
 #include <linux/iopoll.h>
 #include <scmi_agent.h>
 #include <scmi_nxp_protocols.h>
+#include "common.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -176,7 +177,7 @@ u32 get_cpu_rev(void)
 {
 	u32 rev = (gd->arch.soc_rev >> 24) - 0xa0;
 
-	return (MXC_CPU_IMX95 << 12) | (CHIP_REV_1_0 + rev);
+	return (SCMI_CPU << 12) | (CHIP_REV_1_0 + rev);
 }
 
 #define UNLOCK_WORD 0xD928C520
@@ -437,12 +438,16 @@ void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
 {
 	u32 val[2] = {};
 	int ret, num_of_macs;
+	u32 bank = 40;
 
-	ret = fuse_read(40, 5, &val[0]);
+	if (is_imx94())
+		bank = 66;
+
+	ret = fuse_read(bank, 5, &val[0]);
 	if (ret)
 		goto err;
 
-	ret = fuse_read(40, 6, &val[1]);
+	ret = fuse_read(bank, 6, &val[1]);
 	if (ret)
 		goto err;
 
@@ -458,10 +463,32 @@ void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
 	mac[3] = (val[0] >> 24) & 0xff;
 	mac[4] = val[1] & 0xff;
 	mac[5] = (val[1] >> 8) & 0xff;
-	if (dev_id == 1)
-		mac[5] = mac[5] + 3;
-	if (dev_id == 2)
-		mac[5] = mac[5] + 6;
+
+	if (is_imx94()) {
+		/*
+		 * i.MX94 uses the following mac address offset list:
+		 * | No.    | Module      | Mac address user          |
+		 * |--------|-------------|---------------------------|
+		 * | 0 ~ 1  | ethercat    | port0/port1               |
+		 * | 2      | netc switch | internal enetc3 mac/swp0  |
+		 * | 3 ~ 6  |             | enetc3 vf1~3/swp1         |
+		 * | 7      | enetc mac   | enetc0 pf                 |
+		 * | 8      |             | enetc1 pf                 |
+		 * | 9      |             | enetc2 pf                 |
+		 * | 10     | netc switch | swp2                      |
+		 */
+		if (dev_id == 0)
+			mac[5] = mac[5] + 2; /* enetc3 mac/swp0 */
+		if (dev_id == 1)
+			mac[5] = mac[5] + 8; /* enetc1 */
+		if (dev_id == 2)
+			mac[5] = mac[5] + 9; /* enetc2 */
+	} else {
+		if (dev_id == 1)
+			mac[5] = mac[5] + 3;
+		if (dev_id == 2)
+			mac[5] = mac[5] + 6;
+	}
 
 	debug("%s: MAC%d: %pM\n", __func__, dev_id, mac);
 	return;
@@ -518,7 +545,6 @@ static char *rst_string_imx94[32] = {
 	"por"
 };
 
-
 int get_reset_reason(bool sys, bool lm)
 {
 	struct scmi_imx_misc_reset_reason_in in = {
@@ -612,8 +638,8 @@ int get_reset_reason(bool sys, bool lm)
 const char *get_imx_type(u32 imxtype)
 {
 	switch (imxtype) {
-	case MXC_CPU_IMX95:
-		return "95";/* iMX95 FULL */
+	case SCMI_CPU:
+		return IMX_PLAT_STR;
 	default:
 		return "??";
 	}
@@ -694,6 +720,10 @@ int arch_cpu_init(void)
 		gpio_reset(GPIO3_BASE_ADDR);
 		gpio_reset(GPIO4_BASE_ADDR);
 		gpio_reset(GPIO5_BASE_ADDR);
+#ifdef CONFIG_IMX94
+		gpio_reset(GPIO6_BASE_ADDR);
+		gpio_reset(GPIO7_BASE_ADDR);
+#endif
 	}
 
 	return 0;

-- 
2.43.0

