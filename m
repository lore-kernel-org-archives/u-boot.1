Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09F9C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 09:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAA6B88D92;
	Wed, 24 Apr 2024 11:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="gyK8xrqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B22FF88D92; Wed, 24 Apr 2024 11:12:07 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0700.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33FB888D0B
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 11:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNxeAO/hoqejD7IO+ukTevyCPzF7rfN1+NV7MJAD6anjynRwmW31DBzEfCBu4j2T19lNMLkRIEudGJyWzGoqluav6YnWI//GxxWmVUMcI+hwIdRoHlzX8Fh8UcjEl5iBbuyo74HOLYaCGE6ey9lGk+G9vG8N8rTSgHCeAtznbVets/n0vAXQDCvmvGbP7QDkZBaFREbdfjj6FCj9fbJcbaHNxE+sBjnbfDqX//Jidy1GCV3kyqvHplTytPh117G7vWczWY4ZTxvFwv/zmSPxuMg75fpvlbVlRWlpEtFwaryb7XwykNpImj/fTFQeWwEzgawL4qbZuvcmuenYgVh6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWt7BI6ZCdAGA8+3+zda/K87mwl5Lo1db5wskxri21Y=;
 b=biQmZlJknL9OFQDumqFRD2p65PrKVDoc8v5XTZq0CqzaLHM0UGwh0Ab77vOTYdoBjENFzHb+srbmXY6FiELqlZdKlpsOv/B0EThBfED7gEVIj67Lu2+oSAySAfyxlDuvUDd+9brENKIgW8YsadtMUzQ0yrOsFghBK/xFz0WqBPkKYRQ1uegn05j+3BDJ2EOops/T9tKF+SSL03KiavtR7KSEva9JPasjFU6MAZ4LtYm/NOPU1d4sP5F3d7nEiM9j5wFFLTQ9JbVkastWyFSXHNhGO5ehyslZR/yCJGfMmjeiyjt95JXfLc0rNT9FURTTF4TYY2ku07aejG3Ympr06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWt7BI6ZCdAGA8+3+zda/K87mwl5Lo1db5wskxri21Y=;
 b=gyK8xrqf6MEw/IoRs5JvkL6P3fg5rOslukFDXI3c0lRG9GPM3K3KcQP+7+cydpVEwQ6gBQWwwZCaHNOgZwDxToGxKqLiah/RwQt/dWfHYKlRmTeX03l+0ueaj99aJQh4jlqg/i5UJh9BkSXzKxQV+Wym/2RQAVXlbqklF+p7I97/Om7I6mZQlaVoTQY0j+T0og1mRkHHueWq+YrU56LrIhXd2lLpvGsv+/xOR2DrweoDYkKwsIiKFpBX1vNHb+2VHbCruA0Hf4rjBqQ+qUKiAGQjNGVr+dCeDRXzOOd0O1+0BJFr7g+ApBs0bViLx9gapyqinMOKcfWiGWtssp84Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR04MB4833.eurprd04.prod.outlook.com (2603:10a6:208:c2::30)
 by AS8PR04MB7847.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 09:11:58 +0000
Received: from AM0PR04MB4833.eurprd04.prod.outlook.com
 ([fe80::70be:f731:f7e6:a785]) by AM0PR04MB4833.eurprd04.prod.outlook.com
 ([fe80::70be:f731:f7e6:a785%5]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 09:11:58 +0000
Message-ID: <efeed0e2-3593-473c-b5b3-e2ceca78ddbd@theobroma-systems.com>
Date: Wed, 24 Apr 2024 11:11:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] rockchip: sdram: Support getting banks from TPL
 for rk3568 and rk3588
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Eugen Hristev <eugen.hristev@collabora.com>, Andy Yan <andyshrk@163.com>,
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jagan Teki <jagan@edgeble.ai>,
 Frank Wunderlich <frank-w@public-files.de>,
 Joseph Chen <chenjh@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Akash Gajjar <gajjar04akash@gmail.com>, u-boot@lists.denx.de,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240415-rk35xx-dram-atags-v3-0-5bc5475b3c0d@theobroma-systems.com>
 <20240415-rk35xx-dram-atags-v3-1-5bc5475b3c0d@theobroma-systems.com>
 <2dc654c5-2f03-4f69-9e5f-e4ad5091b844@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <2dc654c5-2f03-4f69-9e5f-e4ad5091b844@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::27) To AM0PR04MB4833.eurprd04.prod.outlook.com
 (2603:10a6:208:c2::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4833:EE_|AS8PR04MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: a056da10-98f7-4eab-1bb9-08dc643e97d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emtvdUNISUNmK3RFd1dWWlNtRG95SnVtNlJQdm5zM1lwK3ZuVWQ2b0QvOTNS?=
 =?utf-8?B?cWU4bCt3ck9iNXBBRFR6RFhqK1NvN0VMazcra29uVXRwVWIxY2RpcURIa1Fp?=
 =?utf-8?B?TDRTUzUrd2VYRHZpYVFaYU9peXZRS3EwSkVYa2dwMThWWUpTVjVoT3BGYS93?=
 =?utf-8?B?Ymt2RjZxaXhKSkhWaXl3ZldzZUs1WkFrVkNIeUhTT2VGNFRzTCtTNGZ6UnEv?=
 =?utf-8?B?ejFqNHFHQ2VaWnk1ZE5FZldJTUdRV3QydWtZamYzQ0xNMzFoTm1xcGRwUkFl?=
 =?utf-8?B?cVk3ODV0KzZDWjA5Nm13R0tmVjl5RTRBSzVQWm5VK0Y1Q3F6SHVFZlFZVTJO?=
 =?utf-8?B?Vmp0aitMVXVOVlB5SHZYdVpnbUNEYlczVDBldDdqT1p4UW1BSFBHUlNicFBC?=
 =?utf-8?B?a0V0dTM2dDBPTWtld2xKdEN5Q09JclJCbCtNdHNvSkR2NlZJR0hPTDU4am4y?=
 =?utf-8?B?M2RVUjBuUlEwZzhZZUVRT2dnazJyOUFWRmVsaHoyWlRrRXRlaGNMVlBhZWIx?=
 =?utf-8?B?WjNVakNtYVRBd2k3WVNIY2lVcUtoUG4zOUhkbVcyMlBwamZ4c2J1aVlKcGxi?=
 =?utf-8?B?aVdJMjBTODQxcW5sN3F0THppbkQxd3k3VWdsdXJ2clVzUVpwZVh4V1VtYTJr?=
 =?utf-8?B?SlkrdW9qakxrbGhWc0RNd1VQYXRFU05QaUg3YlNOTEFTVjlHbGdmY0puVlRV?=
 =?utf-8?B?SzhjeHNCeFJMUkhrY2NhemJiME91alQxVlB3cU1BaDBuRnQ3YVZyNjVKejVE?=
 =?utf-8?B?R2M3VjBvV0pNRWllUmFVaFhJZzRWZjltZHdSc3ZXNFdhV3haQU9rcnQyNXpI?=
 =?utf-8?B?dWRDNUFqei9SR3Z6T0ZCcGw2NEZ2S1lpY2lNZER5MUZzZG9hNEs2RTUzSTZy?=
 =?utf-8?B?dDNFMWNhNHRScTR5b05VTjh1UjluY0RpUmpxN3NNVEsyVFFHMERsOW8xVm51?=
 =?utf-8?B?bUpLY00vSmhpTmFHZEJNaXpvU1RiMzdnOU4vQi9ZTnpXY0ZnYnRGb0xQSnMy?=
 =?utf-8?B?VE9BQzhkZ0t2ZWVLZXF0Z0swSk1MR0MwZ2dMcjlFSStaellrbWNuSGJVVEJX?=
 =?utf-8?B?TzA5WVVUMzU5eG9MOGhudG1lQ1N5SXpIMUh3Y1ZzVjF0MWRsTVF4Q2lQeFov?=
 =?utf-8?B?dWVEeVZ4WHl5eHMzSjM1ZGVqTzZyQWlSVHlSYXB3bWNqbFJiSzYzT2FXODVw?=
 =?utf-8?B?U2NCQUwvTTUyN0hnTGc5TUR3TEhVd0d1TFJRc3JCREZxUXdKR3BMV2hvQW5t?=
 =?utf-8?B?cEJHQnpYaG81QmFZejhXcjNidDRGUVEvSXdiczRhdXBHcFBkZHRkMlRQV1pT?=
 =?utf-8?B?S3UzY3JYYTBQMDFEdGNQME1Xd3ZZa3ROTkNROGFtVjNuL2NPSDZsREFLQkg1?=
 =?utf-8?B?dCtMMkprWTBGTEJNYlcwRVgvakpYU3pKd2FPdzBHZFZVbEpxbmtiZlVlU003?=
 =?utf-8?B?UDIwbUhOYkJ4blFTRmtZOW1WSFFUYmx5aTRYZnlkVk91a1FpNjd5ZHd2TkNa?=
 =?utf-8?B?TGdIV2V2eHdRTGpKd2QvRWpBcGFQSEhwTW4wMDY4Y0RDYWk2TzZMUk9tYmFt?=
 =?utf-8?B?R21remUyanl6TjYzYk1aOGxad0ZyRUxnbUg1M3NsSEJ1ejBEWlozQm1xRldx?=
 =?utf-8?B?Q3VKTWZkYnhVSFFuQUhwSTdpbkRxNVd1ZWd6M0lRSmJqUlBZa3l2Q2t1c3dY?=
 =?utf-8?B?SG9vOENzaG1HYnRxZDUzRndLTDU2cktneUdnaWFkS3JWZmlHY2RiSHRnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4833.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkFvbmc5dmFvVGhXZVZTYUtaVERHUnBTN3NVeVgyc25PTm9pUm5xUTk5RmdZ?=
 =?utf-8?B?QjF5TlJFWVZjNVdFTWtEYU5jS0hBWUdGT1BQcUw1VnBpeTg5NXQwemx1MGZR?=
 =?utf-8?B?bSt6UVpIaG9HL2NjdWNDT2dTOWpqVkxoQm82Z05ORElpYlhtcWVRbHFrTzdz?=
 =?utf-8?B?VjFFUVl1TzNFbEphZDhucVNIQmtDYnd3Q1VaOXVsQzJJL3ZBNVg3TXNjWnRG?=
 =?utf-8?B?dTVsSG1ESm1JbndEWTRSVERWcTUwNlFiM25UUXA1QnFERTdMbWNqSzZyamZH?=
 =?utf-8?B?L0JqT244UEdqSGFWbDgrYWVVelAzTXJxOVA4STBJZWtBaUtOU1REWk84S3FO?=
 =?utf-8?B?bzNUMDZUeW5QWFpRRzAySjgrOWZHamU0QlVGekU0Y2E0cGVaV3BiN0dEdGlB?=
 =?utf-8?B?UHpQUEdsSVVhMGo3a2ZWelUwQ0JnZVJVNVVtVzErS0ZpQklNOGNmZFh1QjBz?=
 =?utf-8?B?MU54THErSG9tMEw3aTVOcEdCUmhFR3pCRmVyMnd0aW1JU1JWUXhnNmpWemVC?=
 =?utf-8?B?eTdOUTUzNHFZK1RFZEVXWHJEeFdBTFNCYzdVR2R0TytqcEl2cmNhM1VXMEJh?=
 =?utf-8?B?LzB5NzBvaExac2x1SHVMV081VGt0bHJwNVRGeFltSXQ3QUlveXd6NHRycFp5?=
 =?utf-8?B?S0djOXc2ZDNQV21NQjE3bWc4MDgxMTRhU1pGS20zR1JEckozQlFmOGNlZUZO?=
 =?utf-8?B?d1dNRVRJM0hSbmJlUEZLS0QvaVZWOUZLOXViZTlsZ0lkeXRIZFBWVFdMMVZZ?=
 =?utf-8?B?NFFHMFYwWnp3Nm1KMlgydjFEckJlbnQ4NkpMV2NXTkJHditwZk1udk4wME4r?=
 =?utf-8?B?RzNVcXkwbFM5WTFDcUwrdjRUcUZielB0QkszWXR1alowZ0FUU1FDdkhvQzd1?=
 =?utf-8?B?a0d2V1owZmlLZDB1WWtjbmlEQVpkQkx5QkNOSXZQckxGU3FVaU9oeUUwTFdW?=
 =?utf-8?B?VHBZZjVlWm5zMGF4QlY2WkpoeU5sTnpDLzRqeC9SK0RYcm5nM1Rqemw5aW9h?=
 =?utf-8?B?UEwvbkVmR1RSVkoycS95WkRPVmRUdGpURzhTUEExRkFOa3IxbDVXY3lDMTY0?=
 =?utf-8?B?cDIzNU5vUS9aMEpxNm5TUUovdUpqU0grWEl2b3l2eTVBQTlZaFgweGVSZjcr?=
 =?utf-8?B?dW5YQVppNW40clFlUnF0LzdLQUEyVG1zQ1dVeUhsRDUzZ081M2Y5UkFJQTNK?=
 =?utf-8?B?QVFzeVFXQjZKNlgrT001a2F3RDA3ZHhCYVBHUUc2VmsyTGlZdU03UjVKbkts?=
 =?utf-8?B?Q2ppSkRZejJoLzY1R0NKakZUb09BLzFYd21tSXV1YnNKQW9RRzlibWtsN1BQ?=
 =?utf-8?B?Uy9CTjh0TE1RNzBuYjZQRE02RzNCY25PeWErcDJnWDQyS1JJMnVacGkzZWly?=
 =?utf-8?B?RmZHQnBVajdZMVpEVW5HQzYwNGxEUVAxR1Q4VVJXOVZ4YmpqeXZrT0Noa3Mv?=
 =?utf-8?B?Q0JiWUt4RGY0RGR5aHdXV0xiQStFMXZORklBMjlzeTk3c1hTVEt1YUFTVU5Z?=
 =?utf-8?B?OXNBNWlsVlpiRHNnWGhMdXdZNnZtclRqcC9TZi9VNHBYN1MxQUhVMVVSdHkv?=
 =?utf-8?B?UTdJdjBMWmhSR3N3eHlYdkhqbnVpaFV2NHNjc3ZOUHZOdmRSd0xZRXBsRWF3?=
 =?utf-8?B?alAxS3cxNWlKZTFNLzltbitsbVBDV3JGT2lRUWoxcE1BU2ZDTTExcEd5cCtk?=
 =?utf-8?B?R2YycWxRbkR4eGMwVkVIRnExK2VGb1RKTGlBaXNkZ0ErdU1kWFM3cUlWbXR3?=
 =?utf-8?B?UHltQ2E0Y0ZRbTVXQ0F6aXUzazFCNnhmeTZTbUZUekxRdEtxYjY1aSs4VkNY?=
 =?utf-8?B?MlpDNk52eEJRaVZzZUZXcm5qSmxkMFR5SVFGRGZ0STNzeHY5YTlaWFFBQ3dQ?=
 =?utf-8?B?OFdWY0dPZmJIUlAydHJWUFNtOGM3Zloyd0ZQdHY5WngwaTFXSmZ4WEF4b0pZ?=
 =?utf-8?B?U21YZmdTcnRwczVCZ05Ic0NrWGxjam9QQUFSSFIzcWUxYldSblE2cWRRSWtz?=
 =?utf-8?B?aUNCOWtQR3lzZVM5bmNIdEh4TFlya1V4ZzhJemFMNEg4UFozQzRySExJcFE1?=
 =?utf-8?B?SzJIZktCMFN1eGZkTk1XN1FyZnoxV1pBS2xhY1dxbTQ2amhHUEszeSt4emFq?=
 =?utf-8?B?UTBxMklWWE5XczRrSE1DWHFYSExVcVQ5V0ZsZUtFaWRHTlJTckZqRTdNVHh5?=
 =?utf-8?B?dGk5Nm9SbjlPam14MWJVV0RKSW5kTkpaWi9JclFJNmtXNVNSM3NVSU80VFdU?=
 =?utf-8?B?UTZPWHN2REZYMThmd05XU2dPUWVnPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a056da10-98f7-4eab-1bb9-08dc643e97d8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 09:11:58.2930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HReND0w/2ExmRWoG8g62KxcIX2+e+7BvFBtuQnZGLNECWKu+RLv5/BGR7oMiSYGD3vi5eaVLbYvNEFTxZdGhf7L50xMvpCpg0FedAlJqsRCBjSXWmCwWgYbo3zWGgEb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7847
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

Hi Jonas,

On 4/24/24 00:40, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-04-15 16:16, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
[...]

>> +			if (!(tmp_mem_map->attrs & PTE_BLOCK_NON_SHARE)) {
> 
> This check does not seem to work because PTE_BLOCK_NON_SHARE evaluates
> to 0. Because of this the logic to split the 0-8 GiB bank reported on
> rk3568 is never split in two.
> 

Oof, that's a bit oversight, thanks for the catch.

Can you test the following please?

"""
diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 5b1ff1e5495..0492f9b9f41 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -196,7 +196,23 @@ static int rockchip_dram_init_banksize(void)
  			const phys_size_t rsrv_size = tmp_mem_map->size;
  			const phys_addr_t rsrv_end = rsrv_start + rsrv_size;

-			if (!(tmp_mem_map->attrs & PTE_BLOCK_NON_SHARE)) {
+			/*
+			 * DRAM memories are expected by Arm to be marked as
+			 * Normal Write-back cacheable, Inner shareable[1], so
+			 * let's filter on that to put holes in non-DRAM areas.
+			 *
+			 * [1] 
https://developer.arm.com/documentation/102376/0200/Cacheability-and-shareability-attributes
+			 */
+			const u64 dram_attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+				PTE_BLOCK_INNER_SHARE;
+			/*
+			 * (AttrIndx | SH) in Lower Attributes of Block
+			 * Descriptor[2].
+			 * [2] 
https://developer.arm.com/documentation/102376/0200/Describing-memory-in-AArch64
+			 */
+			const u64 attrs_mask = PMD_ATTRINDX_MASK | GENMASK(9, 8);
+
+			if ((tmp_mem_map->attrs & attrs_mask) == dram_attrs) {
  				tmp_mem_map++;
  				continue;
  			}
"""

The DRAM mem_map entry for Rockchip devices seems to have those 
attributes and no other non-DRAM entry seems to have 
PTE_BLOCK_MEMTYPE(MT_NORMAL).

We may have an issue in the future if we also want to mark SRAM, ROM or 
flash 
(https://developer.arm.com/documentation/102376/0200/Normal-memory) 
because it's likely those would also match the same attributes but we 
would need to put holes for those so that they aren't thought to be 
DRAM, but I guess we can tackle this the day this happens :)

Thanks again for the catch, let me know if this helps and makes sense 
and I'll send a v4 for it.

Cheers,
Quentin
