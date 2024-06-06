Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC084C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF621881DB;
	Thu,  6 Jun 2024 16:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="O99vXiOb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16276883AA; Thu,  6 Jun 2024 16:54:07 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0717.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A9D881D3
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5THcRbqByjjsYQ2ORMQTs4GLRjNMy5WUCwrzbqoZ5plLUTX9def8EI8Yi/Gz1dyphQdJ7Rzp++8NMZ85l8LboaAl3IPiPcL9/VR9eDVCnh4NyevJ0tpEGbF5ilkIBe9OCfpzWgHD9CEfuJIHO7agKkNbwEj2w5h9kq7AHhXw3E+LkWlu3v/yRcYzZmjdOD9DrCHEEdq5QEixnuakqCk4V+dcfgAiMI2on/j8u/fiUCSD2CWH9tBO6/U4R4tuJRkmrblCdtkuoSIf944GqvVsxJ1EGJBRcgk0xmG3UrBrkhlSYWtCtb5uRopSusbydCAttwjDHYYZHj8mCEuv5qJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJy1F8/zjBRCN5rm3nkkprYHBYjV7t8KNAp4aVhcxr0=;
 b=ockwEK9vQU/f9/Iwfr8XVv4bvArJQ1ZbvkbGawdUDCsJLUXBvtVVqV9OqDYxczfoGC3XZf/oa9kWECJPTwJ1cX7WsCAfE98fXGePjnWY/2SmiP7F/2qxRAZ1jOU0WdQIjv1I0HteXE6D1XE/sDZYYtuDZkqe+FYpTuscXSg5+heDVhaO+vs5l+8bdiJoghnFxbEQRuIxeqVKUoQEVJwHVutJdQq0Nu3rJRocYD0n0Gmepe/zAFQXsKFsXdKjBEPLREZxZF+ARjXi1JVHZLhcO/iQvj4wYtjR+eMZP+Cag4SVjxj1iw48mdlyRP+p0PeILxgV1aRRCYzalqOy5gYFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJy1F8/zjBRCN5rm3nkkprYHBYjV7t8KNAp4aVhcxr0=;
 b=O99vXiObxgPxD+OCtfQJduFMLdzYgVi/OWaeL7tnvzsj22civgjdPEBBl7fvsh3RqL0SHUhdysHiwQ6OZ7Q0c9P08CTxhc67Rg3EW2m2HHuwydLoLlenxYqvS4siA1rITGD067GOKFcU0ZT0iWiMwqBrxdgdZRGnPnpEmCgP2nw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA1PR04MB10367.eurprd04.prod.outlook.com (2603:10a6:102:441::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 14:54:02 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 14:54:02 +0000
Message-ID: <3c422e9f-3cd8-4b24-83f1-d4ad6e7641eb@cherry.de>
Date: Thu, 6 Jun 2024 16:53:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add FriendlyElec NanoPi R6C
To: Sebastian Kropatsch <seb-dev@mail.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240605155413.226629-1-seb-dev@mail.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240605155413.226629-1-seb-dev@mail.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0013.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::8)
 To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA1PR04MB10367:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a223c6-5e0c-45b7-11a0-08dc8638812e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VThrQnFnc1B5NGovd0pkOTJiYUdINnhXUzVUWDVuRFFsYnU0SEJmU1laYW5F?=
 =?utf-8?B?N3J1ZUFHZEZ6bEZ3RStBZFJiUFhqWVdERVMrK0NnWjVCT3dUeWN0d3VVcjhM?=
 =?utf-8?B?dW9zSFd0SVZKVUc2N01EWU8zM0tPUVlwZ01jVHl6ZC90bklaQUZWKzdxVVpt?=
 =?utf-8?B?eWl5VDd3amlKSUhKYWZwOUpJN0doblZLMGNYSUxUMGE0ZW1QU1Y3a05xZ1Fo?=
 =?utf-8?B?NzZNREJOcVNsb0graEU5ZmxVcFIrNjlPTGxzWmtvV1p5SW5Fb2dJTHdWcXlB?=
 =?utf-8?B?My9uT1VncnBZeDRvbGVsck1DLzF1bmVwdlBzS08yWHRhOE5mODBaYksyYk8y?=
 =?utf-8?B?blRSRWdLY1liakN5T3FKeTgyM1hqdGNpby9FWEw3ZW9IU1JMVzNBdWtyN0lO?=
 =?utf-8?B?cXZaSmJxL0RYbjNyc3FZdU96dFJzYkZ6eDlwR2wvdVZqWFpMZFFmU1VrZy9Y?=
 =?utf-8?B?MkptcUFURFdERG1SOE9FU1daNG1ld1pLVkh1dnFZcTk4eU1UdXhBMlFVTkFN?=
 =?utf-8?B?aEs4djBCT3JGQTlOejZoUUxrRWp6TWJyZWlIODFVcXRvQmlmbThVbDVOSlI4?=
 =?utf-8?B?ZC82dm41eXZ6SEMvMkdqT1Q0ZVNFY05reThXcnFtN3FTWVN5a1crdmVNK1JM?=
 =?utf-8?B?aGwyVWNnaGE5S0lodStjN0xXcDVZeTJTWTk1SU9XSVNhRXNRcWNMaGFEK2x0?=
 =?utf-8?B?d1E0aEhnMFBva3pNTC84a29VVHJ2UnVQTzhaVVRMUGNwcy9JVXpxM1lBbC8y?=
 =?utf-8?B?Yk1SbkM3SGwvbVYyOWgrUEpRalROVDIxNmNTSFZ6N0h4OUVQSlFLQkNIaUI1?=
 =?utf-8?B?ckFLOHIwKyt3OXJqMnFpVlVWRHVJNkNkNFlVLzNoeGJaTE5zbG9OOTlJcFRn?=
 =?utf-8?B?WXAzQ3Rob0RMbGxRVlAwM3VIcG5tMFhWZ0pGWHR1YTRiSUtNNW9FOEQwMlZV?=
 =?utf-8?B?K2p4c1lTbG9LTXhqSC9SN0FJSFBHdDVYbkJiZkh1d0puY0sxem8vZ1RENlE4?=
 =?utf-8?B?dEZIaGVLSFhsck9lUlNnY1FRV201TjBVTzlkTzFidlpTTnlVTzNoR0lKTGdt?=
 =?utf-8?B?Z1lkMS9QM1hSWmVVZWlQaHZjN3VCdFRKcHRqYmFpTGVNWDBrLzA3WHBDODBY?=
 =?utf-8?B?V2Zza1RMMHdDNFdrNTB3WjgzUC9OMHI0Q1krc3crK0xFUDhhNmVQc3VHd2Fs?=
 =?utf-8?B?SlBETjd5Z3hGZHVGZWV5WWhZMzJDS2E5VENJMkJKYlgxQ1hzUkM2MWJDL3p5?=
 =?utf-8?B?R21SeVg5QXpla0hWQ01XNkJoQmYxdDNHK0ZGbFJxczRCZ0tmZEVaUGNGUWo1?=
 =?utf-8?B?ZjJObDZBRFprNE9MQlUxU2xrRHpNQ1VJaU4yKytlendrMTY0eEk0NitlVFBZ?=
 =?utf-8?B?L2ZTSVRYVVppV3hnZGhPQWtCTmJ1YkxTQVgyMzMxYURLOTc3Q2xHb0FUR050?=
 =?utf-8?B?NW1hVDVSS2l3Y1h1Um1Jc1oyRE50MEd6ZjRTbUw0REt5dHo0aEZCUTRWaE0y?=
 =?utf-8?B?dkxNK0x5dUJlb0xiTVdBbko3T0xyYmlGSVh2elNOVThBaGNUaGJmM3VaUWw4?=
 =?utf-8?B?VDZlMi9DY2V0SktCdXJTS2tzQmxNZ3FycUt3MG1LNmFiaU1nQThPeFA2ZU9h?=
 =?utf-8?B?UWp2ZWNzbWpIbUxKaE9IYUNmcG03aldYZ2kzV0I5RzNMZmgxaE51ODFSdldY?=
 =?utf-8?B?OVRTZkxPdXUzMmFHcWtRY2J2MWk4MXN2YnhQM0ZqeWRhRExvSklTV0ZXWVdi?=
 =?utf-8?Q?4qllu1OYSx7qFWkyGPYNyF8AJj9N6M9IqjqZw4g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MThiZVBlWE5LNXdlNzhKTk8rOVFuZmE4ZVRVZUpCSG5ZMU40dDBpbUdaRzdZ?=
 =?utf-8?B?clY1Q0lpdk1EQU4zQ1k0U3NpSXg2SmFMREIwRktVU3VhMkhWd21yK0NNVzVa?=
 =?utf-8?B?OWFVaFZzcVpKRHhGeVZJaXp1ei9uTDBQSm1MT1F5RDZvZjZuTnlJSEpZV2RJ?=
 =?utf-8?B?MXZQdU80eDhBTmV3SDd1cmVXSi9JdUt4aWhtSkZWUXRLMWVES1dHTkZxS0di?=
 =?utf-8?B?U2pDYmtGdUFIV3RvYTc4ZkRUc2xYT2Q0czRKeHFHS3pSOE42WUNpVCtmeFJw?=
 =?utf-8?B?RHpGeS9DNzA5S1p4bnF6SzB4RFVROXI2aVJXMDNyZFRZMWJha1VpeWVTMWlI?=
 =?utf-8?B?dlRIaWFPRTVsa3F3dk0yWEtkbXdqWFhmdU50c1hpaHZhUzZYbjNXbituWkVq?=
 =?utf-8?B?YTZtQWh6UDB3WlEvNmYvRE5UcjdGcnBrelBNbFQvRmEzWnNVaU9RYVNPckQ1?=
 =?utf-8?B?Rk44aFRiTGNVQ3hzUE1uVUlralRhbkZ6L2NDZTBpd0hHb1dLUnZjVDhZLyty?=
 =?utf-8?B?WElycFg3ZTBXRWIrL0liR21yeE9RaG1iMGpSSUZwTUhYcGZyeUE5ampXSDA4?=
 =?utf-8?B?dmh1TkpRZkhHM2R1U0hFdXpTYkw2SHdlREhCdHJWbFAxbXY1ZnZvVm4xdjZm?=
 =?utf-8?B?Sm95TW5yUHJaNEhNK3NOSUVMUWI4d1JVc0lVUmtCN2JvK3pxUlZBanpWWU9Y?=
 =?utf-8?B?eExMV0wrKzlmSDNkdGp1MVhQRkRCRHZ3bEtFVTlra3RGY1A5WTc1Mit2U3hi?=
 =?utf-8?B?NEhiNXdTNFRoMHI3VFdEa21EQTFlOFN6NFR0UzBvL3EzaXEzRDlyZVVTN3gv?=
 =?utf-8?B?WFBaZmRSTFRINUY3NnA5RVdneEk4VUZ0ZWxNR3A5cFZqaVVKOHNBVWlQMklN?=
 =?utf-8?B?dTBDWHF1NWgwS01NM3RUOGlVQzh0SUpkN2V0b3A5aE5aRW9wZWdOVnkrWjQ1?=
 =?utf-8?B?RVgxdHJmbHpsbVdjV1dLbWc0KzNQbUxZeWJBU3hORFVGYXdXcEtmZUJhd1No?=
 =?utf-8?B?cVdxNGErRmdyYWhoc3d0b3ZNbWl3a3Y4ZlRBWlZjSG8xS1hjUXJrQVVjM1do?=
 =?utf-8?B?Qlp0ejhiUmJ2Y3JqVy96YmxqNkFNSlliZFFEbTVicEsrbWZjb0tFMDM2ZVZy?=
 =?utf-8?B?RUVDY0RzRkhxd2RDczFWOWphcUNPRHBBYkJLUXFxYlcxczcycWhBditXcmJT?=
 =?utf-8?B?b1orVnRWY0NLeTJ0YU1hVTMyNG85NzNlekErUENOZ1FvUzVrN1BxM1Vsa2Nk?=
 =?utf-8?B?cjF6M3NaZUhIM21aL3N5WGxlK2dFNVZlc1NRMFplbTFkNWZzZndadkF1MjNs?=
 =?utf-8?B?RHRIa0VUeU9Dai9rN1p2aGtVSjI0SGN1c0tscHBzazVCMUZ3SGxsSlQ0NVB4?=
 =?utf-8?B?elZqREt2eWdBUXNvc1ZnYmNNdkZDVDYxTFBUbmdSOXRPbmd0c2lsVHBwMzZ1?=
 =?utf-8?B?M1JUOUdud2RkOHRwdGR2Y1N0cjVwc2VSeVBxNmppMkd4YXpHc3U3SmpCQ3B3?=
 =?utf-8?B?T0ZDd29pRDcvUmJUUmZCL2dkZlR0VEkxb3JpNnFHT01GRllBem9iWkp5Ym1L?=
 =?utf-8?B?T2R3VG5KWEhmNEpKRkY3ZlVvNHczK2cyREVNVGt2MFQzYjc0dHJXcDlma1Rm?=
 =?utf-8?B?SjBpc3Nxb2g3bzVCWmdqVE0wK05mSitPVzk5RHNndWl4ZlZseWF5dVZIYVZ3?=
 =?utf-8?B?OU5SVU12b1hhK2dzelJOU2hiUEN4UUNWY0FhVlBGMVU2RGVVeGkxWUpLMmU5?=
 =?utf-8?B?bFV3NHp5Nk82TFM3RDFrbk5BWHVoOExvclAwUnNRMGNnbEl6RERCKy9pY1B0?=
 =?utf-8?B?Z3c3OWVCeGg2alR3ckNOT08waGk2bURvSjVyRGFZRTMycElub3hUNERvRHJV?=
 =?utf-8?B?TUM2ajRHS1pUeS9qNkUrMXRJUXdPN2ZpaCtEVm5qNkZsQ0EvRVhpTDdSTTgv?=
 =?utf-8?B?cjI0alJNaDk0V1dlOXhNbU1IMjlhSHNMMUdzQkdSUnBqZnlGSmdneEloaFNG?=
 =?utf-8?B?Q3hIRE91bHgwc1RRajE0VGFZQWZtVXY3UlU5bmxSbHlMNmpQUHRnU3ZJTW8z?=
 =?utf-8?B?VDFmMHovS0N6SGtvd0gwN1Q1T2ZxWTNTZWhKcGY2WXdWN0JsSisyWkp1UlFB?=
 =?utf-8?B?TGdvaHhVd0JjUVhMc2FsN1RKS3NpZ2tvcFkrSlJyS25LYjVsUmt6cFZxUFJ2?=
 =?utf-8?Q?4S6Ei7bTTjX9ggeiTlR2pPE=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a223c6-5e0c-45b7-11a0-08dc8638812e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:54:02.4225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdewaAHnPbUvEPmaTy2Ikhqr+2CJ7j/8tuVW4p9Y5eeXRzolEgf/dyO4mEpHHJ5yeBRyTBy4jxyx023Eh25fafJuT2oLo+Mb52oCVWXWDZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10367
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

Hi Sebastian,

On 6/5/24 5:36 PM, Sebastian Kropatsch wrote:
> [You don't often get email from seb-dev@mail.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The NanoPi R6C is a SBC by FriendlyElec based on the Rockchip RK3588s.
> It comes with 4GB or 8GB of RAM, a microSD card slot, optional 32GB eMMC
> storage, one M.2 M-Key connector, one RTL8211F 1GbE and one RTL8125
> 2.5GbE Ethernet port, one USB 2.0 Type-A and one USB 3.0 Type-A port, a
> HDMI port, a 30-pin GPIO header as well as multiple buttons and LEDs.
> 
> Add initial support for this board using the upstream devicetree sources.
> 
> Tests in U-Boot proper:
> - Booting from eMMC works
> - 1GbE Ethernet works using the eth_eqos driver (tested by ping)
> - 2.5GbE Ethernet works using the eth_rtl8169 driver (tested by ping),
>    but the status LEDs on this specific port currently aren't working
> - NVMe SSD in M.2 socket does get recognized (tested with `nvme scan`
>    followed by `nvme details`)
> 
> Kernel commit:
> d5f1d7437451 ("arm64: dts: rockchip: Add support for NanoPi R6C")
> 
> Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
> ---
> 
> Hello!
> 
> The Ethernet status LEDs which sit directly on the 2.5GbE port using the
> RTL8169 driver don't light up when connected and I couldn't figure out
> why. The other port with a RTL8211F has no problems with the LEDs.
> Have there been occurrences like this in combination with the RTL8125?
> I'm trying to figure out if this is something that could be solved in
> the devicetree or if this is a potential driver bug.
> 
> Secondly, the default active network device in U-Boot is the 1GbE one.
> I believe it would make sense to make the 2.5GbE device the default
> active one since this one is labeled "LAN", whereas the 1GbE is labeled
> "WAN". However, since the 2.5GbE device is PCIe-based, it only shows up
> in U-Boot proper after using the `pci enum` command (shows up as in gets
> listed in `net list` and `dm tree`).
> Do you have any tips on the preferred approach to handle this switch of
> the default active net device? Is this even a sensible thing to include
> in U-Boot in your opinion?
> 
> Thanks for your feedback!
> 
> Best regards,
> Sebastian
> 
> ---
>   arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi   |  3 +
>   arch/arm/mach-rockchip/rk3588/Kconfig         | 13 +++
>   board/friendlyelec/nanopi-r6c-rk3588s/Kconfig | 12 +++
>   .../nanopi-r6c-rk3588s/MAINTAINERS            |  7 ++
>   configs/nanopi-r6c-rk3588s_defconfig          | 83 +++++++++++++++++++
>   doc/board/rockchip/rockchip.rst               |  1 +
>   include/configs/nanopi-r6c-rk3588s.h          | 12 +++
>   7 files changed, 131 insertions(+)
>   create mode 100644 arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi
>   create mode 100644 board/friendlyelec/nanopi-r6c-rk3588s/Kconfig
>   create mode 100644 board/friendlyelec/nanopi-r6c-rk3588s/MAINTAINERS
>   create mode 100644 configs/nanopi-r6c-rk3588s_defconfig
>   create mode 100644 include/configs/nanopi-r6c-rk3588s.h
> 
> diff --git a/arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi b/arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi
> new file mode 100644
> index 0000000000..853ed58cfe
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-nanopi-r6c-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588s-u-boot.dtsi"
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index 820e979abb..0e232ddfb9 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -78,6 +78,18 @@ config TARGET_NANOPCT6_RK3588
>            Power: 5.5*2.1mm DC Jack, 12VDC input
>            Dimensions: 110x80x1.6mm (without case) / 86x114.5x30mm (with case)
> 
> +config TARGET_NANOPI_R6C_RK3588

Please add the S at the end of the symbol.

Otherwise looking good to me. I'm wondering if we shouldn't do something 
for boards which do not need a -u-boot.dtsi. Here it's needed because 
U-Boot would include rk3588-u-boot.dtsi automatically (because of 
CONFIG_SYS_SOC being rk3588) instead of rk3588s-u-boot.dtsi. Maybe it's 
too much headache for the benefit :)

Cheers,
Quentin
