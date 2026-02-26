Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709C9FD4609
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 03:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADAE883C54;
	Thu, 26 Feb 2026 04:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="k1yDBt0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DCD383E61; Thu, 26 Feb 2026 04:10:34 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EF3A83AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 04:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIW6D3LS/Dfjgb9XHL5gkQk/tjPF9IZvHYNreX4mPapBJFhUhX4GObH7XqySiuE2inBbdO6x9Li9k31kpoX5APtk4hf4ENbYrORMsaORxF2RJiCIEHJwKXXWil+AY3frA2jSQIFQE/hczjJpG2/2E72tnzUtHFvar73zGwKJgk0g5ddHoJ2W1jN75aPxQf9au8YOCxGsorosBUgf1rMtkOVN0ZPbg/zc6Ovq8CuIl6GdIq2V3aMBjv+YOhUNgOxjklT0Q/5xstlMzMRl1eVwoNbtwB+dyvmBr1PEOvNxi88Hqma2CNA7RO7Wmts4cd4WtfyEfrY0ahKC8vWhTvGUWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ld++hyKH/f0XZ7qJWnHh71c1iLsbUUvBHeqrfVzyoMc=;
 b=BvXTo8fLdGVFLU8fbFU313LF2WhjLl4hMIbKlVzNiOnxXbh3VbbeDfbHD+6Nat4hfkZn2wtX2Y49XQgVt/90YNblcNX7V/7x1VZuys4BxzYqZjqnwBwxP4gxV35mKcZ9MZ2PgtCreSJKoK4pMfK4D+E1YqDSuTgF1WsvEgwzajX87rUX5uecP7NcBVpih2n25qqT6fUQ0imD36zqS6FMqYCpDDLjcAlnieGlNIeDTSShxph9SQ3Mv6A/gDlhk954May099NKfXpvHSohEVbYDbXXlpi01V6dKvdXKA3viT1DIXscIa4JJBBCYEAVB8Kn5kNU64gZIA86H3TImoB4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld++hyKH/f0XZ7qJWnHh71c1iLsbUUvBHeqrfVzyoMc=;
 b=k1yDBt0j77nVqb4ygea7D6/YO2F6aSxYgwG4ZY5pR8TOKe5c7q2et0nzm+O88AQia3vp+Dq4ZQ5MMWcpcPr6SOvQZMZtfNJiq/2RHBBvcP4x6sfKScJsYJBqFb/zGxL9oMiVpbKeYerF0+YTLn1TJzJGOHvJ/GP6Z551AzDrjaUaQpC7JYizFI4bQe/It9XaUqNhovk8fhHHbUIZvMRrm/NGI9f0qmruOf6QxDNk0m/R7DNHbhX7NQ1c2kQmb//RLilCSc8FLpU9dBtFg1T9HohTnRWG00v9Z/ER7bQTlkziZ0hlhDBSBomyplbjF86J3x+wgUPmmtg9ZODr9O4TxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB11013.eurprd04.prod.outlook.com (2603:10a6:150:20a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 03:10:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 03:10:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 David Lechner <dlechner@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH] mmc: mtk-sd: add mediatek,mt8189-mmc compatible
Date: Thu, 26 Feb 2026 12:25:27 +0800
Message-ID: <177207977393.1460793.3429615791227597285.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206-mtk-mmc-add-mt8189-compatible-v1-1-5243eb8b7e2b@baylibre.com>
References: <20260206-mtk-mmc-add-mt8189-compatible-v1-1-5243eb8b7e2b@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB11013:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4f93ca-2271-4bbb-a876-08de74e49868
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: gbVPI9rzvZU/lHqEx360ZZ0Dwref7/OWfJ4EpSr6Sn0KkpHxuEyTX4Bs3Ox/3gnfxcGmoJwBQ4CNtLLjomvTiJ4zCf6X6bLPigl6aA3fqc3Dqe3KOsbYlj/Zrvh/7w8zDTs4TCU+5msQi9bOYsh5knGm/fylNUKp+xYIwQOtf2A034tQHsouoYDFySr5CQ/rlRD6+wxhvuT8lUykiikwtq6uNh5rQGn2jSlN4PDEBT+sLwiptY6mLS9vz3yWNOE4o7/L8rnuixGzrY4KxWpvniEAr4LC5deD4RWNJoQN17DZtaPy3/3O67Z9cSmrGgW51qpeYET1vDjbu1NBthJB4csUw78eo+rq5S3p0DFlygdhoa684zCOpvfDi44ktgbo9XE57DEXeX9Ow/Xs7+NwUR4Iz9dBJwgwnufMOLXZrXsE8J/6mI7Z/l7+ZFul3nrDf49w7qLc/blAlErqGcSOZA/VCcveiasNdhQUjuRYGZGRnhoPFhAxkO/1vJhiertE3hD6qiRqyLgjNJ3NlfjDSUhFrJh8H6hllNh9dYkDX8325C6RxjjnuvL8euh8bfrCCYZ81jZvF52gZ442wRGVfLpnsxi2yUeUCSORxGaItobU13xPHSXh9z9/OEhvaFTQNj9DaEKuVw5xPFZU5wJm2G1Gnnb14TDnwVen5Ra1Zn6ctxflFQb7yqxJMrpJdBNPoOllxlGAyNwc0T9xNP7p10W5i08zOKc8OcczfBMiRFry5uCpMTYI55XerUbdJEJuUbZUbezGAfks96JxQHVl73jlgkjwBQnmWalbvvEa2nA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzZWNEpQRzE3aFFNNFpZQWZrN3d2bFZ5K1Uvblc5YnUyazJWR0pTV29hOThM?=
 =?utf-8?B?Y1ZLVHFwYklpN25KcXVZbUxjQ1gxQ2NobkVIbk93SkJSc0FRV1Fad3NSdTlt?=
 =?utf-8?B?ZTUyVmtnV2tFQmoveC9MK0EweWhtaHVKZXVlcDdIMGVoUTBzbk9NUlduRWJp?=
 =?utf-8?B?TDVRQk42b3M1Z2Z1ZDFqdi9yMzMzWFlaUDNqdjRsSGpLb0VGUjBSVFBzMTRB?=
 =?utf-8?B?ank3T0dyTmdqMG1nOTdHZE43RmhDM3oxTi9TUVo4c0o1VnlYZDVtR1ZxMzQ3?=
 =?utf-8?B?d3YweVVzVjE4OVpPaklkbkk4bzdMSGdKMk44Y3V2MmcrSDJ4cW8xVTVPcmxM?=
 =?utf-8?B?UzczaWdpWkZOR1VuWDA4aTVTR1FpZFBlQzJsV0ZYSVRpWXRQUTBjWTF1Z2dQ?=
 =?utf-8?B?aDhKKzhMUTdYVXoyQUxuQ3RXREdIaFAvc1ZEaVVOZENBY3oyQ3pUV0tEVjV6?=
 =?utf-8?B?VC9PaExsUm92NDJ6SlBCR25pL3VxeXE5R0F0aUtiTnh2OWo1MzYzRTMzbzdG?=
 =?utf-8?B?Z1Flc08vS1RQeWNCeVJXV0szaGM5b3NXT2xjaHJidm83WTdpeVo2S1N4d2l4?=
 =?utf-8?B?WjA4c3BLYlpqbUFZRlR2cWRraWhYYzE1eWhvbzVGWEpvMDBYYWtYNkZpNEpv?=
 =?utf-8?B?OG95TWpvUVU2RXVERkhjMmVVeHh1Q3ZUVXFxWGpMcGtMYkVMczROWURmQUN1?=
 =?utf-8?B?M2poOVVYTDJYU1l6RkRuZmZibnF4ZmdMMXNKTkt2SWc5S1JUR0o3elZRaC9j?=
 =?utf-8?B?WWdyNmNLUmhoM3pyTHpaZWJYa25yYlVwWHVTTGYrNENFak9JNGozbm05K1M1?=
 =?utf-8?B?bW5ReEhqTkh6a3R5NUdLQTUrdkEvSUlldjdRQzUzbkJueDBmNnIvcTRJdkNz?=
 =?utf-8?B?OG1DQlB4L2FNdkpOeExxSFJISDAyWmh6Y3JNWnRTT3gxMUt2RWhGTEJwL05H?=
 =?utf-8?B?cmE1b2o4ZW9QNVFUMnM5MUxIV0JvcFJzOTZLemlKNGt6T05nUjl2SHFuRkJE?=
 =?utf-8?B?ZHhsV2N6cHJUQlo4M2VSTk9lSzdaQ2VTbGZhMVdaWTUybzVGbkI3SkxiVU16?=
 =?utf-8?B?bGg3Mkg2bGpTaElVYk5DM0pjL3JvY0puMmZYenI3OTNMR3p4RkVLa05qb1hh?=
 =?utf-8?B?UllHOUhqNko1SmxhVzlUWWZrYmZ2aEVLdUZ5cWc1MmV2NFZ5bWUvdThpTDh6?=
 =?utf-8?B?NmFBS1QwazJYRnd5QVdPSHk1UDJiQStsS1o4K3B5TllTb21uVlFtM1pGV1Ay?=
 =?utf-8?B?d04wSHIzdWVmSVVRcUdKTjJqUjk0dnJsSEtUcEJ1eXZTdzBCU3pJRXplK3V6?=
 =?utf-8?B?T1hoSVppc21Ga1JrMWN0a2d5Mk4xUjlUb1lib0p4ZEI3L3JxdUJHOE52RzAw?=
 =?utf-8?B?NGxoUVQxa0l2ZFVOVHE3bC9wTjhqOUtKUW8vZHN5cEZXM3lndW9PMEVDWjRG?=
 =?utf-8?B?a3J4K2NadjNvVkxpMytTUHRTY1V4akRSWWVvODNMSlNkY3pDZUV5ZERuMU1H?=
 =?utf-8?B?d1ByY1FPc0VqKzA2UTdrTzdYb2tjUFhTdHdZT2gvdmxOTzFzVlRpbDkxWUEw?=
 =?utf-8?B?NHRzVGdDZzN6aHVUS1ZSNk5IaHc1TUxPcE9LdWQvaXEycUxFNEwxNU9la1Er?=
 =?utf-8?B?OHh0RS9HcXJmd1lmeng4TWJya1V4ME5iSlhJaDF6M1d0YXV5d0crM2hwYjZx?=
 =?utf-8?B?MnRDSlJNU1dlOXI2dUE4SlFiTmRVcDg1Ti9ZNEdmVmNLU1p5YmVkY21wdUpK?=
 =?utf-8?B?dGZ2TzRucldzU2xIZ0VIV0puaWlpSzVzMU1XUGkzTGNmZHlyRWZVZVJxalNZ?=
 =?utf-8?B?R1AwSG9jMEJMcGJVYk5RYkJ1ZjRpWVRieHhjMndOWkV1Nnhaby9WbUZDTDJO?=
 =?utf-8?B?OGMwdjkzQytQbXljU1NNczRRTWx0TTdzTVJ5ZnJ4ZFN2RUI0TWtMb3dETkRX?=
 =?utf-8?B?cEU1ZmhLS1dOM20yaU9YblZiQ1lvZmxSZDJ4TkFSekErelVITWxEQkdCam9H?=
 =?utf-8?B?ZVp6Vnc2TDVMZjJBbTR2QnJXTk9WQU0yYVRMVjFVUVc1dUlVdXJpSEN2TVRU?=
 =?utf-8?B?RDJzb2xwR2xZUlM2VWtjVnljdEk3eFNTbUZ0VEtia2JVTDdPWDRLMzhQRll5?=
 =?utf-8?B?d0E1SWdZVWtYckowQUxQR04yK3krckxlWVVmLzRmZG5LMERuelR1bDdKUTNy?=
 =?utf-8?B?cXg2cFJSUU9sd21kK1EzNHE3Qjc3VGxVVElBditIQ3pTWkNESGdicHdxeURa?=
 =?utf-8?B?aWkvWHBGT1cxTU9OOEpFUUNLWjBvRWhIcVZQTmFXb1dCYksrTGJLYWk5VWNQ?=
 =?utf-8?B?T1JSQVZXUEVucGNIUEhrRG5TcHEvR0d4Ulh0SU5tanI5dkIyMmNiUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4f93ca-2271-4bbb-a876-08de74e49868
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 03:10:29.6024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Bi5uJd/VUERD9kRmZweJbgVyEWAoCmHxYnW1EAUK9d4bqtomuvhmjYS/6VbkCuaEXiaakiWO5q7jKG52ZpcGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11013
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

From: Peng Fan <peng.fan@nxp.com>


On Fri, 06 Feb 2026 14:50:06 -0600, David Lechner wrote:
> Add support for MediaTek MT8189 MMC controller.
> 
> According to [1], this is similar to, but not quite the same as
> mediatek,mt8196-mmc.
> 
> 

Applied to mmc-next-2026-02-26, thanks!

[1/1] mmc: mtk-sd: add mediatek,mt8189-mmc compatible
      commit: b3d16267b5095746888927478a0973fa810a0826

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
