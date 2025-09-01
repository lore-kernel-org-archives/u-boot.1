Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FC4CAC58E
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 23:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61B0A832F9;
	Thu, 11 Sep 2025 01:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AsJnecYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0102832F9; Thu, 11 Sep 2025 01:54:01 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B940831C2
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 01:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEP1sQZWnqGBRi3e6chadZOIE9e1FTXtJQ4kVv/CJJlOHIAuFxxczn5nZwpNts1lHzKghZvzIGINhBPiV8B2Bk8afCtR/rwkkCjaBtO11j47zp26VJAThusT6NkkuI7YXH+NgcecoDRoqxmcD00EvqPQcsJJLXnFNiFE1EZCP5/zBDAFjTjXVNsOQcknY69TegXnanBVm24/Qih6HzpjfL5Q1VgrlltJVEqD3idE4oWjWfdSkMuiklqyMCxPqrMWpl9rgsu3d5EGoifSqhtYkCZ7f0BaUSCBMnIYNljEjNclhToWyyIUJCvzIiEICJ+ZxILD2QykOpuRY9UcoDXsoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRCJAI/NUEEBdSwwnK1QX6raekQZK8syVeib1hdFi80=;
 b=uATbYZlxRy3/+q9IS1oroQtOYjAgC+/UOIa71mZYHXXrEDhaBKztXqicN9T4JK96WldwUsm2bQATgoBy/OIoM5exEPKEwV+nHyTlUyLPlIZuq/je3IpDVi3UcCsqX3pNVp/+/ltIBNSjlFClbnMAu57HYqS0CBzA8+aCu8Y2twcUe/26NWMwDviiiXK9Nv8KhcD6qySI7voWPS7t/3RJjaxS15EbLcZuW3YOjq+HbNlZaUUIp9RQ/D93C42aEsMt/K72fNIaKu9W+5t/eEn8ijJWghwaflIpVGxmVThf4F5B/80sR7kGwdPsCT3YibY98AbU9wxUgUVBrz1+5kG/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRCJAI/NUEEBdSwwnK1QX6raekQZK8syVeib1hdFi80=;
 b=AsJnecYxcy9dWB11Bs9U/LjvQK4cyzFBhKg7J7YmrkkwSa1waVASEYCRWt4rU0I6v7NLClnluCKZJS/wL2lEGheoP4rdDwdiOdmbbtfLhFcf6KlF4/koHJVP15xbFH3pG8QEQIPQMPwr9xMoKyzJhv2/L/1JD5E1G/GDMDgVvxDkGG7TbmKc+LK3lYYYiEKZaa4SoNqFf9ijgCuYoscuQaKZx9Oa5hedj3Jl7ilSIEvZEMT7enODL0o0p1b0LQtiFH2LaAPx5OZOXzyhzuJRerj8coxoZ7nAL5fD2VKUryWMo/BZwAu1ZFIuE+h/yjAjDd4xIr5hWV5Sv3IBO+kyDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 23:53:54 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 23:53:54 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 01 Sep 2025 18:48:02 +0800
Subject: [PATCH v1 3/8] imx9: scmi: Add i.MX94 support to
 get_reset_reason()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-imx94-v1-3-c85ae7cdd95c@oss.nxp.com>
References: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
In-Reply-To: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@oss.nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: MAXP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA2PR04MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: 82aef7d4-9fa0-42d8-6f74-08ddf0c54c88
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkdENEUrZDRPM0h0M1ZTTWdLQjRNOExiVVJXZG95ZG1WUGlxeFdWMkRFTkdC?=
 =?utf-8?B?UlJ4Z1kyR0gwQkhSY0JnZ2NVdTV1aHM5UTVVZ0R0bEJjM0VGRFROYkRqbWxV?=
 =?utf-8?B?ME0zajJQekRoV0grc01QQXNYQ3FDRXRaalNhbTIyUTA5S1YvUFlFMFlvTUVo?=
 =?utf-8?B?SEZvdjBTTXBTeWlVaVRNNDZLcUVDVXJYdE5rMXd2bUlacXMwZStFWnpyaWJv?=
 =?utf-8?B?SVJFcGpMOTBMZ3N2dWx1SkpLRmpKTkVuMTcwZURKNllJQXlNTjlPbEcxMi9k?=
 =?utf-8?B?UmV0Y3oyUS9nVTJ3dkY3MjlFNWRLY3pCem1QV011eitwemRkUlMybTAwUnNx?=
 =?utf-8?B?Q1A2UXg3cEtHdHhIbkpSdk02SERSZUJVLzUvcmpmcHExa3drREt6SEl4T3g2?=
 =?utf-8?B?RGRHdHNGZFF0Y2tSV1VhVE1tTHhZQVU0RVFScVAyS2FBTGl6cjV3VE9Hd3Ew?=
 =?utf-8?B?Rjk0NEJkbWhNV0t4WENJenVGdXExWk9HanU2aE05WGNQbklMZERaMzArVHl1?=
 =?utf-8?B?dkd6TVNtNEhjY3ZyVzZ3V255QkJjay90dzQ0TGFUaUEyYjFGMjltbDJNa3JI?=
 =?utf-8?B?SHVKMmpKZ3RUY2V2eXJqS1cweE5LaWljbXFTZFZva0ZxenA1Y29rMzR1ZkVO?=
 =?utf-8?B?NElpWndQbkpoUXhDWnl2am9OUzN6WStzdDM4MjdzTDBRMVY0ZC9TbWZXdDRC?=
 =?utf-8?B?NXBKSmhRdmhjK0JUSGFodXZmZjFMUmtNVXBCd3NGdzI0SnJIMVYrbHJMemFn?=
 =?utf-8?B?eWw5WkVUYm9ydkhSaU92cmViRnFVbkJtRHJham1UNmRMYVQ2WkFKS3kvb2h3?=
 =?utf-8?B?U3gxRGo5b1AwQkw0OGttMUlZbHVSWDdYcWVBME9xK0hPdEljUGxmaUJFbEtM?=
 =?utf-8?B?dXY1RkhsWVhmaDlhUWZRUlFEeTBPc1R5bHZ5SHp4ZXAxWCs3c0pUcnd5MUZm?=
 =?utf-8?B?TGtTdHRMdkdvY3ZjRzZhR2JRRGNDRVdoY0dsUzU4KzNKcEs4K0gzL29sTEtr?=
 =?utf-8?B?ZmtwMHhuWmNoWTRET2xsYVRxS2NqWHR2ZkxnVTZCTXFNVEEya3BDbktQUktv?=
 =?utf-8?B?TTZ3KzVqTThBWStRTStPWFp5OFppTWM3ZWxhcEpzTlBPaUxQelkydzVKWGhQ?=
 =?utf-8?B?UElnNEQzcEh1TVJzSFFnOGVqeXhkR2hXR1d6WDJXQ3h5ZWM0QTFaMytNOUNN?=
 =?utf-8?B?Tm4wSGZsOUR6VzlnUW11VGg4d1dWYTdVbHNQQncxb010Y0ZGd2NvVWtLWGs2?=
 =?utf-8?B?VVMybVIzVHY0WWVKWHQ5SUZ2dkIzNEpLaTZybHpVTnNZc05ZRDhUQjF2YXcz?=
 =?utf-8?B?bmZBQSsvd2RnZmpXOWNkeW5lTll5RjRUMWlSdDNhT2FGRmd2T3Q5aWlha0lt?=
 =?utf-8?B?Rmg3Nmx4OHdLTjdtcWVKcVI4b3Faa0VnV3VUbDVCVGNWYnhXSFhlZys2djFq?=
 =?utf-8?B?bGJ1OStMZ3RySE1WUWdOSHcvc0lDWWJNQnVuMGRSd3NIQVFuSFo4WndoakFS?=
 =?utf-8?B?Y05aL1VOQWQzK3E1dDlSVUk3SllvSmY2TDJnelFMZjBIeHNtaHltazF2Ritr?=
 =?utf-8?B?Vlg4RFV2ODJiWW5QaERFOGJMRVhqSEttSkJKSGs1MzlpYldlZndiM1VvZ05y?=
 =?utf-8?B?YkRwVjhOL2xmNTN1N0tjamZWQUF0TDZJMS9UNUt5ZFg1MTJ6cjRqQ2xudGVa?=
 =?utf-8?B?cHRzbzFVb3FydllmYXliSC9EU2hyRERYcHhXNUN5V2oyWlltL2hyMHFtbzh1?=
 =?utf-8?B?R1hHVVFtaHdBNWVkQkR4MUJmeTZYSXlPVW40K0xTWW5ZUEY3UGNNQlRURFNR?=
 =?utf-8?B?WW02Vk4weUgyOU4xbTNTUVkrZDVWU3A1VG1weWxZS00wSjZ0TnYvcTFteHdr?=
 =?utf-8?B?N0RiVXVjUGw0UHkrZWJWQjhvZnBnRDJlekNtcmxyRFNwVFhDa2gweDcrMzJJ?=
 =?utf-8?B?MVZVMTdQY2owZkN2SFljL2NNaE9ROVprRk0yeUJLVFlvbFZqaUdSRUhQdnhm?=
 =?utf-8?Q?m8tR2eBGBfWkl7sfb7TWOsXS8rrxJc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TndRUDN3UngyM0JPSkQyamhYcEw4TmE0OWloQnB6dnQ0ZE5WSnFndStpUzBv?=
 =?utf-8?B?bFppVTdzSHFIVjNwL3l6cmhUTkVzQlhqNnV0Tzk5a2U0bm00UDF3RDV2Q1dU?=
 =?utf-8?B?NTRXNjhrZFp2ajlVSWpqZE5vbzgxNndlRXBBbUo3a1IvZTlqdTMyeE1zMXdI?=
 =?utf-8?B?MGJGREwrc1FwYS85ZmtKQUVscWVhQ05Wbi9aMkpIc3Y3VEZ1V3JXZTVmZmpB?=
 =?utf-8?B?cWhEdTRrSlRsSEhTUlFWek9JK3IweDBFTXYzSVBudkErblRhRzhMNExVbG1y?=
 =?utf-8?B?WnpVa3RZOFZuVU9ZYy8rSjlKa0xvZ1pJOU5aMmhZczZvYkV1dFFzVkJMeU1I?=
 =?utf-8?B?Sko4eklDcWR4N3gxQU51VEFJZGQxV01wVjdub0VvMUdDcTVEejlOMDJMTkhn?=
 =?utf-8?B?YTFwNWJGK2FvUHZ4MEF1Mm5nbUFPaHZ5a3UxcnVDSklncmlxS0pZVUtENkNN?=
 =?utf-8?B?WXlFdmZLczk4TnVtQmlac0N5UVBYTWpsN01WU29qMDNaMHdKRWJGVDZYTDRa?=
 =?utf-8?B?VjZwV0loa2w5UzN0c1EyclhxblAwV0F5aWYvTndwUllyN1YxUUxuejZkMnd6?=
 =?utf-8?B?RkJPZ0xEdFNyOFpsR2dwNE9sSGljMlZUd0ZGSEdRQ0oxcFlJYmVZbFpyV3Uy?=
 =?utf-8?B?bXdWOU9XMG5Qb0lXTVQzZi8wQTA2aVZINnFzZGNhMm9hUjJSa2R3UnR3YlBr?=
 =?utf-8?B?a3U0YzJ6bWMyaWw2WWg1Z24vbnYxaFNITWxScC9PUzdoaHk1SjdlVXZqOFZs?=
 =?utf-8?B?MDgvcWthZmVvRW9JZy9tdmhURHhFWDFyTThLR1E0NW83djFiUURZakU3d09h?=
 =?utf-8?B?d01maVU3UUtHMkhmWkZGamxQWm5zZXR1WU8vSkVVWkJ0cmh3bmEyVHdzNzZO?=
 =?utf-8?B?a3FSdUEray9QR1BMdFZOaUFYc2l5anFLYmlDR0ExSzlkNTl6UjluTEZtTDVP?=
 =?utf-8?B?WnlKNHU2Q0pTSDlkcWt3U3JLdkFNMWg5bjBiWGkyaXRhT1JZS005UlJ0MTkr?=
 =?utf-8?B?Q0pQZjErWEVuNjNwMzVab2trUnUxTUtjL1EvVUhwSVM2Yy83UmQxOW45dlFz?=
 =?utf-8?B?bHpoUkZiNDBLT3ZaVzNsKzBkWW5NVVFGdHZNSFZoMGQ5YkdTaWk3VVhDTzYy?=
 =?utf-8?B?M3VueW1LUWREYWNHT2RlaXFSWFM0VXRSOUdJN0hSVmtGVmNpL0lKS2dVYnlJ?=
 =?utf-8?B?c20wd1pHOTdGWTBXaExUZEloSUtpN2RrSWFwcCtVa1ZIUk1YYXk4bk9lL1cy?=
 =?utf-8?B?eUJqNTdrR1prVlBJNmlmYjhLSXc1cklySXJiOWk4aDFFbTd1ckZ4dlUwZy9i?=
 =?utf-8?B?SWQyT1RlT0NqVjJ1WDh1R0Z6ZUcvWlpQZWZ4cEFPUlEyYXBLSS9ITjVSS0Ny?=
 =?utf-8?B?NUVBVDVncmFzdVNsbXJhUm9ZNk9YaC9uQ3FpV1RqcTFBTnBwcXdXSlBOTHJ3?=
 =?utf-8?B?bXpzYWZGN0pRdHdSMUVKcWdid255OVViT0p0NXFrTEttU0JST09MVlhmSkNP?=
 =?utf-8?B?bkFQcnkwdTVOTkJYVHZ3QjJveC9PS1ZxaHVTRG01bFIzNU51dW1ENVBETnQ4?=
 =?utf-8?B?UTNHUys2S3hZdGRDM3ViWDlDOGhiNWYyREtkanJRejBhbHQvTHhBR0lVanJI?=
 =?utf-8?B?bjlQM2pmVEhvZ1lubjNxYXFiMzdSZDhxS3FXR3R4eFlRN1FabHM5RU9mWTN0?=
 =?utf-8?B?NU5XMUZkM0RLRzg5UU82Uk5hWHNGSkFYUmlFMWk5WDhzU2JzVExvL09RWUtG?=
 =?utf-8?B?MklwQnhoVEZIdkFRMjh4RW1YUTg0ODdHd0hEcEtyZGw5dThEUHI4WWJ5S3d5?=
 =?utf-8?B?Y2Y5QWwvR3NRVGtiSnVMTk5UZ3RIZVRlNk1BS0pwN2NxWEVPcUhCZFlKdE0r?=
 =?utf-8?B?eG0wQmVkQjVaZnAvT0ZXcGJxYkdKb1Vxc0krL3BiMmFmc1Qyc244eTljQW5E?=
 =?utf-8?B?bU0ycXlpWWdvaUQ5K0RHcVRBNkpLd2Q1MGNxbElXSmFBd29BampZUFF0QWdp?=
 =?utf-8?B?TGdoVEhRV1ltS1E2NUtRWVVFWkZRZlM1WGM1Sy9rSE9CdWpwYXBkdkxNei8w?=
 =?utf-8?B?ZjJ5aDBsTjVyME4yV2wzbVcvZFdJdjM4cXRaVm5mZU9LL0FXWEhFNXFuUUta?=
 =?utf-8?Q?E816aoO4Dit1mFYjfTL1G1OJw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82aef7d4-9fa0-42d8-6f74-08ddf0c54c88
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 23:53:54.1007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ui861MdMjxW5nhQppCyoRnvXLy8THB73imRwKGNnHMpe5ZlPsI4fudDF7yLuEw6OXkfAenzhJCjDvQDcbt4XkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514
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

Update get_reset_reason() to support i.MX94 to send message to the
System Manager to retrieve the LM/system last booted/shutdown reasons.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 43f516d3d7f..f0b2aad8701 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -494,6 +494,31 @@ static char *rst_string[32] = {
 	"por"
 };
 
+static char *rst_string_imx94[32] = {
+	"cm33_lockup",
+	"cm33_swreq",
+	"cm70_lockup",
+	"cm70_swreq",
+	"fccu",
+	"jtag_sw",
+	"ele",
+	"tempsense",
+	"wdog1",
+	"wdog2",
+	"wdog3",
+	"wdog4",
+	"wdog5",
+	"jtag",
+	"wdog6",
+	"wdog7",
+	"wdog8",
+	"wo_netc", "cm33s_lockup", "cm33s_swreq", "cm71_lockup", "cm71_swreq", "cm33_exc",
+	"bbm", "sw", "sm_err", "fusa_sreco", "pmic", "unused",
+	"unused", "unused",
+	"por"
+};
+
+
 int get_reset_reason(bool sys, bool lm)
 {
 	struct scmi_imx_misc_reset_reason_in in = {
@@ -512,6 +537,12 @@ int get_reset_reason(bool sys, bool lm)
 	int ret;
 
 	struct udevice *dev;
+	char **rst;
+
+	if (is_imx94())
+		rst = rst_string_imx94;
+	else
+		rst = rst_string;
 
 	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
 	if (ret)
@@ -526,7 +557,7 @@ int get_reset_reason(bool sys, bool lm)
 
 		if (out.bootflags & MISC_BOOT_FLAG_VLD) {
 			printf("SYS Boot reason: %s, origin: %ld, errid: %ld\n",
-			       rst_string[out.bootflags & MISC_BOOT_FLAG_REASON],
+			       rst[out.bootflags & MISC_BOOT_FLAG_REASON],
 			       out.bootflags & MISC_BOOT_FLAG_ORG_VLD ?
 			       FIELD_GET(MISC_BOOT_FLAG_ORIGIN, out.bootflags) : -1,
 			       out.bootflags & MISC_BOOT_FLAG_ERR_VLD ?
@@ -535,7 +566,7 @@ int get_reset_reason(bool sys, bool lm)
 		}
 		if (out.shutdownflags & MISC_SHUTDOWN_FLAG_VLD) {
 			printf("SYS shutdown reason: %s, origin: %ld, errid: %ld\n",
-			       rst_string[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
+			       rst[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
 			       out.bootflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
 			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.bootflags) : -1,
 			       out.bootflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?
@@ -556,7 +587,7 @@ int get_reset_reason(bool sys, bool lm)
 
 		if (out.bootflags & MISC_BOOT_FLAG_VLD) {
 			printf("LM Boot reason: %s, origin: %ld, errid: %ld\n",
-			       rst_string[out.bootflags & MISC_BOOT_FLAG_REASON],
+			       rst[out.bootflags & MISC_BOOT_FLAG_REASON],
 			       out.bootflags & MISC_BOOT_FLAG_ORG_VLD ?
 			       FIELD_GET(MISC_BOOT_FLAG_ORIGIN, out.bootflags) : -1,
 			       out.bootflags & MISC_BOOT_FLAG_ERR_VLD ?
@@ -566,7 +597,7 @@ int get_reset_reason(bool sys, bool lm)
 
 		if (out.shutdownflags & MISC_SHUTDOWN_FLAG_VLD) {
 			printf("LM shutdown reason: %s, origin: %ld, errid: %ld\n",
-			       rst_string[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
+			       rst[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
 			       out.bootflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
 			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.bootflags) : -1,
 			       out.bootflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?

-- 
2.43.0

