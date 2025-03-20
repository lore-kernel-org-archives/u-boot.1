Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B25C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB93E8003E;
	Thu, 20 Mar 2025 15:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="N6C8gQj6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7336B8001F; Thu, 20 Mar 2025 15:00:24 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 076E38001F
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFFgmxPPk/LFb1Tz70Y7useP6q491b+dMWVPC7x1kfO9jUJBZGT1X5gxWFBwVOmx1OwdaObE5aOcKQN+pj1tDgRZAaFvf2gFSHdXB4SfAenWQSkTfARu/EO24ZYE4/KcIo+awuUmZGBIusFA8DgvbZHIpZp7rMI4cpEZnM+eL7GSxd2xVrXvwjU2zBW3reh5NaYITyxvW7fI5zer648IKzqChKYlacC7qxdv9RJnqWi+iVd8b90u3WBQTlIEMZ6KsyE3L2YUZ9V1+xixJTaRHjiXKqkdrstG8a+F556h8EdWF7Arl2NMAI6Pt1uDHpB4vcGX/BPTDykp51mcsxO7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cegcIQlbdz8OQQXwisL93xsNqG7VstxlIiSM8fRFp4=;
 b=jykCrRvWfc4WErZ99zgMIk4V3YKJ91yuHskM3ySNbELbl7pBksNpz9PZh68RhwNkrtCfQ/O/pgqybncpHG0zvuqjboUaspivIMs/hFfls8l5yWO9f9nnIPB4jdAyl4OpRGmnf1gzpWma/YrMJzLK4gHa4j7l7fb7d2uvcFHN1sC9OED13xdfzOxSknuRXCHTok4MuDAABtIUkOMyZoTqlZQ7uu3fQWe1NoOBCcraMu5GvCApQlD0DbENGJV2RWoY5zb1Adc93CZjti23aSY+JUUcudEp8UmSMNlSi/THoFNZC+eFwMAHhpe/m5JobJ3UefftTUZKt9WNhqEWH9SGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cegcIQlbdz8OQQXwisL93xsNqG7VstxlIiSM8fRFp4=;
 b=N6C8gQj6YjzUPbIArsO4q1ODx4lBiQtwIiLZSNgunMC/spo0P8kpTSu3q2NaaKVpW6rvDDD2VHfRUSzhZxxdZouyiU4Wt1vbBowXMKEohHZhK5gTxWhGcdFNIoLIkD9rio2jsbWSGtO7iWUeTUQ1Gp4NpxEWAsU1aDDce6DRS+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8512.eurprd04.prod.outlook.com (2603:10a6:102:213::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 14:00:20 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 14:00:19 +0000
Message-ID: <ab32ace5-efc0-41b9-8d13-292f6f87835d@cherry.de>
Date: Thu, 20 Mar 2025 15:00:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tiny-printf: Add support for upper case hex values
To: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Benedikt Spranger <b.spranger@linutronix.de>, Simon Glass
 <sjg@chromium.org>, John Ogness <john.ogness@linutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
 <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee96f0b-ff2f-4aab-783a-08dd67b78cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGJyMWR6MGRqUFFmR215MmcxQ3E4Yi95RmU3UlNBSnM2Mk5IdVpJSTQ1cDBr?=
 =?utf-8?B?bVJMak9nVW4xYmd4L1hmQm5yNTFSTXprOXN2U3JtMFJtMlRsQlk5dGdScDAw?=
 =?utf-8?B?MnY0b2RNNmFkWCtuNVlSM1hKS1VIQWpWaCtOWTA1VDhLZ3p4WXFqSFhBU2dN?=
 =?utf-8?B?S25ZeHRGU204MURlOU1SdklmSkdhTzhpaktoN2J4aGZkTDM0TmcxVnJCV2Q2?=
 =?utf-8?B?K0JINkp0NjVUSkt3d0dQQ29MYnBpMWJTSG1lejBuT0Y5SUpuWFlPbGt0MkFX?=
 =?utf-8?B?WENlQUxEdmlPTmx1TGpFWlI4bTFDZnAwM3g0bkdjM1poY2lRTUhnTEViK3Y5?=
 =?utf-8?B?b25uY0hraGhLV21WM3dpK0tSWEZ0cmtmS2VUdE9kOUpFcXFXdWxZdi9jV1l5?=
 =?utf-8?B?aGl0K1FodG9lckdIZFVzVXFqNG4vQmtGZit2ZXkzdUJFRHoycTNsdHJNYk9p?=
 =?utf-8?B?N0V0Q3RSaTh5TTRlZlRpS3dZMTZGYm5BbHRiU1M3RlFOQTNmT0gyTjlaaDll?=
 =?utf-8?B?TEgxY1N0ejd6a0VVT1U2Sy9ma0QxSC83bEtSenVwNnRrQlNQbW92MHhnVU10?=
 =?utf-8?B?UDhLSCtUTDFlWUtuNWRlRUZlUEJxSDJtamtnK1lQZFU5WkVtUXZGVVVXOWwz?=
 =?utf-8?B?cTVXckx6blVtMDFLdWhaWXlobE02YXNyNWtndmNvVXUyZCs3QlNocVk0bEsv?=
 =?utf-8?B?Mm1uOVd6Tm9KTUNXd2ZyS3JsNWlDWkJoNFB1UUx6bWJPQ2doRnFwd21OWTNU?=
 =?utf-8?B?M25NNDBpbi82ejM2cHJyYWh0N3pYVmc4UGE1T0oxWEZrMkxkUUZjK01ZVDhi?=
 =?utf-8?B?WnQ0dWdDczJJbUhBenZnelR6c2d5cmU4dnFIUUZCdlFOMm9DN1drcm9GczJI?=
 =?utf-8?B?T0lXeDlPWjY1aHpSWUtmUWw5dnhaWldJMHRQczdJY0RDRHdMenlXY0dLeU1V?=
 =?utf-8?B?a2lFdmU3QlhSOHlSOEl5NXl1bU9qSE4vZTlGSVJVbkFlWlJPQlFSdkhXcitV?=
 =?utf-8?B?K1ROUzFZWklTcUpMWDB2MXFFZGhUVUdRdXMxN2xxb2J0eUMvRlMwUkpnUkxo?=
 =?utf-8?B?U2tmLzYzRGJCL2tkb21la2Z2dkdZVGVaeWJoV1ZHY2FpQU95SjVFa2toOW50?=
 =?utf-8?B?cU0zMWd2OG5qamYrbkExZmdEWHF0cGMzYWE0bXdkUjRuUUplSUZhcmpqVEFm?=
 =?utf-8?B?UDBhSTI2TW52WWJPZ3pwZXk3VkZVbE1JV1BxUGxFNUc0RlBVTU1IZjUyNEJk?=
 =?utf-8?B?RncyQjhockF3VXh0ZjN2OFIvMlM1U21sRy85QmRRdnJzb1NGWHI0Q0o5QkE3?=
 =?utf-8?B?NHZ5SnNYTXk1cU8ydFVNVHUvL0N2WittL1ZkZ0NpdHhUeFhJSGlQMFNqcHBX?=
 =?utf-8?B?TnlVSlUyNkgxejRYamszcTdDOGZ5bmRkbTlSWlZNTUxibTNVbkhYWVk4Rkxr?=
 =?utf-8?B?UXovL0ZtbHJzclVSU1FUSkJXRWxqbWRpWkV3Z1QrQWc0VURvVnQxaGVDUmlm?=
 =?utf-8?B?SEF0YUdmOURuY25vZDJaL3lMZkZBQVVKRW15OHBEWU5ta1RjNnFXQ3dzUm4r?=
 =?utf-8?B?UHlGWnVOeDZWUGVROXp6cjRLak5PK0RTemF6RW9saVdUSll3Q2ZjbG5UaW1k?=
 =?utf-8?B?S3pJVXcyK2Jrb1J6ZXJrbVJ4UzhQZWllUlhtMXpqUmFrYklwTzdLQ3NzVkFn?=
 =?utf-8?B?ZS81UWpXMmo5WDZmcDRleFNRVHhNaEZUcVpuL0JqZ3NQalpoSGtDd2lKbGhl?=
 =?utf-8?B?WkgveDJpQWV6Zm1tRG43MlVQZHZhMEZ5ZWRUS2Uva2JWMkI1YTVzcDI1dVp6?=
 =?utf-8?B?NTBxMUJCRms1TnlMNVl3VnNOSmJ1ZmNydkljOHBOdTlRN0JqYXhwTy9ySzdi?=
 =?utf-8?Q?Rj6gvhL8nBo9a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW1ZSFFUZGhmUXZsUGZwMmlkbVVDTmlSZ3FJVGcxM1ZsLzhXS0NzYnFRQnJp?=
 =?utf-8?B?V251Yi80OTB5enR4cUdUT1o2WmRzcDlPMFFtTUkwOXl2MzhIYnNUcGFUY1ZI?=
 =?utf-8?B?Qkh2NmdZOERQckxXTlRsYjFWU0ZBTzU3elVQaEFXdXJUUS85bFM0RXlVQmRH?=
 =?utf-8?B?clVmQ3NWZHZmVFQ4M01CVWZjWXpVOFlEYkNncWpsWnZ2TTlLbjhFYkFqOUwr?=
 =?utf-8?B?TC9GVERjVUFlUkVIdSs5RXBJczcrNGN1d3I3emFDNzBGOGtQczZBbVIxVDk2?=
 =?utf-8?B?RTR2czVjb0pPWDlsMWVFb0dvMHNqNkZmLzc1NWxmRDAxQUErMUpUTWlKNlFJ?=
 =?utf-8?B?Nm5JaG54aW1DaEp4d1BxS3RMM0VVSlN4Y1NBQ3R1MlpEY0NtQTc0c2xXaE5Q?=
 =?utf-8?B?aTR2SDhCeWM0VXFHb1ExZXR4R1ZPRUZzVHNUYzJiQmdUNmtlT2I2N2ExZm9s?=
 =?utf-8?B?QUJvenNoZjJGYjhKdktXMkdvcGk5UXgydk9Pc1NlSVdmTUEwdU5aeFpOdnlI?=
 =?utf-8?B?K2xnTS83Tkx6N2VHWkU2RVF4WDk0ZUhlTGU1TldZdytxbUp0NTcrODB0Y3Nk?=
 =?utf-8?B?YngvTXQ1VFI0RSt2RFYxOWNhTmpWQ0FseXpYbmdrMENhRFk0NHZLTFNOM05O?=
 =?utf-8?B?ejBQd3lsY3FZZlNKQjVGL0tBd1ZGNHlPaEE4ZDgyNkhZUmxiSTdMcXVEckdq?=
 =?utf-8?B?bFdQc1NjNFhLaWJ6cnVhTndObFFIT1JMZHp1T0FDMmljSTlvUTl1SFRDTDZZ?=
 =?utf-8?B?SklDcnYxa1BlME1GVXhxbGU0bG1UMDFaMTEvUnlLU1V2c1lxc1FjY3BtMU5F?=
 =?utf-8?B?ZXpzNHNEeTVaaVFHMS95TUtGYVJTY1E5WDVGMDZVdE0rOU1BQWdUNEVSWkZG?=
 =?utf-8?B?UjhGOGpUR1NhUGtQb1ZmdHgwRjc1K2ZvdFZCT1plTDlMVFN6UXBoOWgzaTB2?=
 =?utf-8?B?bU5DZW10TkxwdkRQSjRVTDlhR2tsdkNmNUZYM2txaUJVZ3BQVHRCQTUrTVJD?=
 =?utf-8?B?Nm96Vmk3em5Tb1NEU3RJU2N3R0ZkSHJPamxlSUdrMEZFSHFmVnJlcEQ2L1FC?=
 =?utf-8?B?TUduSXhWaDFIS21WUXlBT1MwN0ROc1JFelB4VCtZeGo2ZTQxNlE1Q0Z1bHp2?=
 =?utf-8?B?N2Q0WVNNbWNKQzloM2J3dllIUm5wYkdVTDFzcHJUU2l6TEErZWozMXJ0eUF1?=
 =?utf-8?B?a2lIczE5V3NzYldoVU84OW44RGNrZzVWVTlVRVh5OEZlTVR5SCthbFYzSmhR?=
 =?utf-8?B?Q1hFM3FrTGNZYm12QnMrNEZPZDBsVExhRFJTSHFwUG94VXIwclBiRWprS01K?=
 =?utf-8?B?RldOb0RDY1pDSUdtd3o5VnF3MTZEblRtTktOMVBLU3dIM1Nycjhsak5LTkNL?=
 =?utf-8?B?WDdlWGtlVlNNY3FNZGEwNlpvRDk1OXVwZEZ5elRjNDE4OS9ZUXpHR2ROOSth?=
 =?utf-8?B?M3lCaHZNeUtxeUx5eFVwQkRqNVhES0EzekU0UmNyekF2NVp5WDFyUTFQYW12?=
 =?utf-8?B?WlpWalM4aTBpa3hxQzRwNitma0ZBSHJmZFdieUVzRlByVUkxZUlrTld5YUFM?=
 =?utf-8?B?TmZNc0l3eGthQWdBZjdTWThacnMvbS9lM0NTUnFjZ0lCSHBEc05rUkU2OGYx?=
 =?utf-8?B?aS9yWU1xM1NQN1FidDVoakc3VllwQWYyandGOGlxR3lpZDN5KzlIdXhRK2hl?=
 =?utf-8?B?cHJyVk1JQWp2UGllb2Fma0V6bUxFTlRLMTZkYkZoOTRkR2t4YzVuSk5vQWty?=
 =?utf-8?B?NW1mUGl2NDFRd2pIdUFrRVQ5UnBFU2RzTEdPUTg1OWI4TDZCSElqbllMVDJF?=
 =?utf-8?B?MDNHKy9hKzRUcWVoMTlDWTZjMHYvSXRYTXJqZU00VGxzbTFJZlUzRk9hWURu?=
 =?utf-8?B?S2lIaE04aGkvVDBVK1Y5RkZLWnVLeHd0aE05OTZpS0JXbjhnZklveHBYL05k?=
 =?utf-8?B?VTh5bk5EcjIzYllnRkd3OUJwaEd3MUp4aGhmY0k4Sy9rYUQvUWlBWmVjcFVa?=
 =?utf-8?B?cDU4NTBueTJuNXpVUCtiMy9mbGJ3Y2hZTEVCY2REakNxaFdXb0EzN1o1Zzlr?=
 =?utf-8?B?bGZ4QXZXOUVpbEZCdkVpaG9wcnNMZGU0WDdSLzBJb09SRHFxRmtRTWdRbyt3?=
 =?utf-8?B?akZyenZRSE9EM1FWQkFlYUxQSUZydFZ5eWkzc01OR282cm1McTViNTJ3cGh1?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee96f0b-ff2f-4aab-783a-08dd67b78cf1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 14:00:19.9303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cyi9fAdIN5DGIctNQkImgTRB05lCFp5zSPahC+0iTvldoDxCPGH/3NNjkMd8fjHwTMmmfFnviK8AzC9tUo/bWXfZonMVs69y+377Mxt0JVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8512
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

Hi Marek,

On 3/20/25 12:49 PM, Marek Vasut wrote:
> On 3/20/25 11:23 AM, Christoph Niedermaier wrote:
>> If tiny printf is used with 0x%08X (upper case X) the output is
>> always 0x00000000. It could be confusing if upper case instead
>> of lower case is used intentionally or accidentally because the
>> actual value is not output. To avoid this confusion, tiny printf
>> is extended to support also the formatting with %X.
>>
>> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> TINY_PRINTF is meant to be tiny, i.e. not consume a lot of space, at the 
> expense of functionality. This is meant to be used in size constrained 
> environments, like the SPL. If you need full vsprintf() formatting 
> support, disable TINY_PRINTF in your config and use the regular 
> vsprintf() implementation.

The issue is that disabling TINY_PRINTF may not be possible (size 
constraints) and some code is compiled for different stages and people 
typically don't check whether the format used in printf is valid with 
tiny_printf. I've had this issue already in the past, I vaguely recall 
"complaining" about it on IRC.

Maybe there's something we can do to verify that the code is working how 
we expect it to work, regardless of tiny_printf/full printf selection? 
checkpatch or a compile-time check for the formats maybe?

But yeah, essentially the whole thing is... if we continue like this, 
we'll just end up getting closer and closer to the full printf which is 
not something we want :)

Cheers,
Quentin
