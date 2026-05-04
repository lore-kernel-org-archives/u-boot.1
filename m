Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6095FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5949C8460C;
	Mon,  4 May 2026 15:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="DXe4FnNa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A2F88464D; Mon,  4 May 2026 15:10:47 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 264D283EF9
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLSUFQYzwmHrDhpHAehDYZAvJS6e5V12033y2fIifGrnv8Jmz9x7TUucLqkYCJlSt3g0cy21g5H9dAoS2EToZN881OwNIrVg5iLAjDETLh+wMaQozfUSYCsb2CnBHB1swAA6pyZtWbBbR9MRb23ON0O7j3xK+Xqx7SXCKvpqtdtyWiTSQTqpq2wCgNSglk3UzkVtRk25FTdvFrshjFyorNimkssqKoRo7F9o3LcjD0+bakdWq/ZFVBoS0hN8od5b0F/hhvR6J8MRpzvn/J6LfgYp9pkrX0sf9an3wjmW7ijetzge9X6Xb49NYrDU40qgdna7T9awu1pLpkNgq5fm/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7c1HRDtAdt4QH7t+w+Xkl8ohB/23H/M8XwPpjWhkkg=;
 b=TFNTFX2Dh7QPN9xglb3nmfowWyiBN1OP5xOj/BtKkT1VRYEpsiE05Hw5cKCNElkabxClDhcKFSki4/rxipvVdWg1Gnc026QLQI+exvBHD+Uq/rUZ/Y4ZuzwJjqgFlYwtFH9VG1vCdQgQK6PXDWvPN3aOMRuGEfOw0rBAf5aDL0xEZHR0tzR9tVMoP5+5bReoOyiimqTlMNSQwTEr6Vr8WRlCqnLU0jHct6qicnRLJJOPNiml6QHHUSc5ewV3ORAG85CqGzUi+ROvUTOE4dJSFNRR05NYBVaSOePeUb46c+/jsDpa0rMCXAtOFFjZEw4TDnS7jfVu18pKX8UpXmPHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7c1HRDtAdt4QH7t+w+Xkl8ohB/23H/M8XwPpjWhkkg=;
 b=DXe4FnNa2wHXQgubDMl+S9h8KyuIz28x7vdhRHs8/J02Umy+p5Iv08U8BM7lJi6dRmKare6SzdhZZnprLUSevr765tLPLx+R/G2MdL4beqpdrfTmk/WkzPcFleWj0fDHMHgBGutsnPi92MD4HOm63pNkGxiSN4Gf0dYuekEoWIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV1PR04MB10199.eurprd04.prod.outlook.com (2603:10a6:150:1a8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 13:10:39 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 13:10:39 +0000
Message-ID: <f385e21f-8fae-4df3-93da-35f136c806ad@cherry.de>
Date: Mon, 4 May 2026 15:10:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fdtgrep: Add option to reserve free space in the output
 FDT
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260422023131.2813748-1-sjg@chromium.org>
 <04536c1e-c732-4d55-a98d-c14acf2d8336@cherry.de>
 <CAFLszTgQxCEYrCTyLkFiEtoDJKPBJKUJqGHFpUK0chb-wCV+DA@mail.gmail.com>
 <6980d77d-b0d6-4b77-9ade-4201bb88cb87@cherry.de>
 <CAFLszTis91k0xp6DaiV6aW2OgLYyRhHLEwpTk1jeWv0sD8gXpQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTis91k0xp6DaiV6aW2OgLYyRhHLEwpTk1jeWv0sD8gXpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::14) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV1PR04MB10199:EE_
X-MS-Office365-Filtering-Correlation-Id: cacf5eea-3f51-41fc-b9cc-08dea9de89c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 92aaZNk6gCrYZj8wmopvDZU/06bpgjQumT88rCj2/as53ogBCJSLOcsIISXWu9drOUxlGufOD7WYnVAWM9zcXbTu1tZ9lfiWhjydF6m12uSKiX3kwnSGfcQO5zt9pkkL/WhpiXKmikfqR5ZM4Wn0GUtWqkjReIxU26OBuLqiIzSUwlhmQ9KDEJigfrSqijgJgZG4MqgtQ7g4CiUqX01h2oL9lQqq7iwWCp6RdvyLdoBfO8JuLgFUKNxk5v27RczakZjJKCtjUIMiakJYwrsOH2otljBy6Pxri1JlefN33m5X/nbqxBOlHQXHF5phU8qomPKbmB0ic8HcpiOoUiJhzkxW6qFtepGfGhUycjvsPRtZakgv7csS/Za++aeTViogIF0lFReqYT4b2EmMapEqh7GBsq5Dba3SlyauMpALAtoVWCE9mUb2cGGU61R74RzV8Y0Ap++aQH2CUCDB4+lTc1c9nFoEPQc9DsvdBPLdC4Ind99pgfAcFmrsnoVkuBeykIvUe9o5fhtRqYhPrc7B/e6Por2trvKf6wO+Hjf9z1r0w8rrV+zAzxSUyGH7lgW0BSLFMfgQqxECTiCcdapaqde8ICh2SgvJMwZqhKE6QCyVSS1AkxwHtsU3jOh3K4o6PltIfw3gyOSv7uvhADre6G8zf0/TyMNK7laYG6I3UlcKPMZF7KnQfz+rKHlA4pmQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFY4SnJtY21jS3lSR05ILzY4dExqUlQwNmgwbVRDbTJrUG82eE54Z1A4YmZx?=
 =?utf-8?B?ODVyMGp3cEwxYkVUK1Y1ditXUi9HRHhCSHN5dXBER1RyK3lWK1ZHc2lzdUsr?=
 =?utf-8?B?ckxpY3JRY2VqOGdjZS9MdEdxNUljMi9vUnJHMkw3TUo2dVR3QkFwUm50Nzlk?=
 =?utf-8?B?K3RrM2hiclZ0U1pFbXJ3U0JKV0tpRHdoZGtRcDA5TlRoOThOU0pVK1RlNkZz?=
 =?utf-8?B?a0VKRmJCS1F3czdIMjBtd2pDckhmaERJTFBHdjgvQmVqeEthUThUcVdnUnps?=
 =?utf-8?B?bEdHbm5GWm5vdTNVYVRjU1ZqUDBLa2t5emZwUEQwUVB6VERjTmREY0p2Sklv?=
 =?utf-8?B?c0NOUlRhZW5Oa1AxeUxxWlZEcjdOTFlmL3BzVGxqSEZLNjNaSkw0ZWc4UTMv?=
 =?utf-8?B?ckh5M1RkaVBCZndLSUFiaURtRmxNc2MxNWl5VENxcURmTUFUVTVpRlhpdGF1?=
 =?utf-8?B?OWRlempTN3ZmN3VOd0MvZTVhTUZsVzNteGh2L0FWZDVUMFFuaTd4c3ovSG9R?=
 =?utf-8?B?TktQNDdWYkIySXQwakZxUjVGalhmM3dvbTlaR2dqenB5c1kwMXFkRzFROWxt?=
 =?utf-8?B?MVVhNDdSbDV4K1NveSt1UzBQMEdRdEl6d3k1VlczNU04eGhIV3FXdnlMY280?=
 =?utf-8?B?K0Y5SXlUUXJtck5zZm1ucURBNXI3TTFzaXJzUWRVT2svZVJGdWJMSk54N3l2?=
 =?utf-8?B?MGV3YzVQdTZGS2hmekV0Qk9JdUlLT3dhWHVOOEp4ZVZXQmdIVEx6dVdmaU9J?=
 =?utf-8?B?UEUzOUtSeEtnbW9FN0laUFFVb3h4ZWt0ZDc3SUM4cnRzbjhFOUkvQ0ZNeFlK?=
 =?utf-8?B?R3lWVVZZOERaK01kZ0lGbFV4dlBnY2E2ejhIQ0JaYmtvTjRHOVRHU0VucGR5?=
 =?utf-8?B?VEtSR2VEaGo3cGNJeTM0cEFLbWRVRDFiTFRNZ3FBRXRoWVNXK1l2WEF0V2V1?=
 =?utf-8?B?S2dBRDRGVXIvaWsydGpEanYxRFFpTmViVVpGRTNHT0VRRk92ZTVNWGFUcHFi?=
 =?utf-8?B?cEZWcmRkeEhxVnorSTMzSVNMY2dhOXQ0THV3Si9NMHZHYjc2YnBZYU5aYXh6?=
 =?utf-8?B?ODRnUlpEVnVrN0hjUjIweXhURVNLQVYycTdPZ3lnZ3dqdngrb2JxaUlvSENG?=
 =?utf-8?B?R1MxS01QYmZ3bnh0WnZ0TnREQ2lJdkI1UHo5aDJwM1ZiYzZXTHFSZzRDVVhN?=
 =?utf-8?B?WWNKQzJpYmZLNzAwZmo5M0Yzc3RUQklFVFhPWmZiQUsyZ0hvNzlFOVhkTEIx?=
 =?utf-8?B?SEFqTTFJdXBVMVh4UXY1OFRQekxvNDYxSVp5aTdXd2x0UjVLV2lYTTBGWnN2?=
 =?utf-8?B?N0pmMkhpa3lnY3BjU3BIY2dMTSt5RTVnNkhZbndFdTZWdHYwdEhFTlJkeE50?=
 =?utf-8?B?bmtrTUFRVXdYVXNxQkdZc1ZwYVI3ZWhZUTZkMm5QdlFNeFR6UXBNcmZqbEFk?=
 =?utf-8?B?ZHpXTXJGeHUydWp0S2o4TGFkNGFuMDdzcU81OVFmTWZIOTdPVlBadTlmeTNF?=
 =?utf-8?B?Qk95VmpLSXBPR3dMR2JjNGw4WFlFWHJTUGZkTzhpWkRCSjNWQlNkQ1V5MllS?=
 =?utf-8?B?dWxWcE10anJVV2VPcnNvUm9ERFJDcUpZY1QveVJSdXhkS3lOaG5qdHB1ZzZT?=
 =?utf-8?B?WFkxd24zVVRMbVExNmtYcDZKemdRUVpPcmRsdk1XMlVvKzk4REk1NzR6S1k5?=
 =?utf-8?B?UHIyb2JGNzhMYlh3Rk1MNjBJRXU1RGJtMU1lTnZ5emhOSDJMTUdEMWZPeFI3?=
 =?utf-8?B?VWsrVGoxTHIvS0lDZ0xsTDdteHhRcVBJdnpTdUNyWmZ5YzRBSjc4SmtvWlFN?=
 =?utf-8?B?dFp1MDlsZXJuK1EzVzJrMGd2dE54YVNISnhxUitpdG9yQitlR1BSVXR6S1pH?=
 =?utf-8?B?Y0RadzVCQXI1U3ErUnVWQ3N2b3pyUUZVbi9WVFYybEpzbTUxbTEwWDN6UDMr?=
 =?utf-8?B?bWZ2aS8vTE1MZnZyd3l0L09zZDlCMys1aGlhNWRGQjVkak0vZ2JyRzF2RVIw?=
 =?utf-8?B?UkRoYjFHVXc4YVFpYnB0RFdVcWNuNWYzQ3BiZHpZbFRNTVZ3clUxMElSUDZo?=
 =?utf-8?B?ekN3aldpU3NvNThJSVNDR0xXM3R5VFNGMmVPKzF2aXM2dmZHWkJOdFA2OXFh?=
 =?utf-8?B?dG0rcmhUdmZCWncrNE04WTc4RUY1RnVNdnNtMU8yZXo3Nnl5bnhHN09VOVBJ?=
 =?utf-8?B?aFAvT2w4YklSTFJzMmZCblMzZUhpN1p1d2EzUXJkZU0xZ01tcC9rbHVRNzJU?=
 =?utf-8?B?dld2NmVSZFZvV3U3YTVaRk9YWURpZGFpTkMyR1h3MVBpN3JqcWwzaUpKSnZY?=
 =?utf-8?B?aWR1RlY4UWR0ZDI5eG51TVc0dWJhb1BQWStiZDlpOVVnak5HSXcyWnY4aTM5?=
 =?utf-8?Q?eAHGUoFxuoMHY/rd8Gc9JJLmUbtz1PFESH6EmtvnJWgnn?=
X-MS-Exchange-AntiSpam-MessageData-1: MP0J6IwA0VQdfJblgKq0QacQ1+APKUdRMcY=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cacf5eea-3f51-41fc-b9cc-08dea9de89c4
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 13:10:39.3241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JA95TR/TiCOObRgCN/IIf4XA0fA5XmgTEZp5V1l5fHLhWVQivlSXsPlISpj9vBsVsdte16m3zcTGF5OhrvWStStlJsJgEdrWhLv23/f6SD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10199
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

On 5/4/26 3:02 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Mon, 4 May 2026 at 06:59, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 5/4/26 2:49 PM, Simon Glass wrote:
>>> Hi Quentin,
>>>
>>> On Mon, 27 Apr 2026 at 03:14, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi Simon, Marek,
>>>>
>>>> On 4/22/26 4:31 AM, Simon Glass wrote:
>>>>> When producing a DTB from fdtgrep, there is no way to reserve extra
>>>>> space so that more nodes/properties can be added at runtime without
>>>>> growing totalsize first.
>>>>>
>>>>
>>>> Ok but why is that an issue? What is the actual usecase? What I'm afraid
>>>> of is that you pad enough and you hit random bugs because you forget
>>>> that adding enough properties can now hit the size limit and you forgot
>>>> to add the logic to resize/grow the fdt when it's too small to fit new
>>>> properties.
>>>
>>> I'm going to leave this question to Marek :-)
>>>
>>>>
>>>>> Add a -B/--pad option that appends a caller-specified number of free
>>>>> bytes after the strings section and grows totalsize accordingly. The
>>>>> padding is applied after fdt_pack(), so it is not reclaimed when -r is
>>>>> used.
>>>>>
>>>>> Suggested-by: Marek Vasut <marek.vasut@mailbox.org>
>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>> ---
>>>>>
>>>>>     tools/binman/btool/fdtgrep.py |  3 ++-
>>>>>     tools/fdtgrep.c               | 31 ++++++++++++++++++++++++++++++-
>>>>>     2 files changed, 32 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/tools/binman/btool/fdtgrep.py b/tools/binman/btool/fdtgrep.py
>>>>> index 446b2f4144b..7b393241878 100644
>>>>> --- a/tools/binman/btool/fdtgrep.py
>>>>> +++ b/tools/binman/btool/fdtgrep.py
>>>>> @@ -16,9 +16,10 @@ Output formats are:
>>>>>         dtb - device tree blob (sets -Hmt automatically)
>>>>>         bin - device tree fragment (may not be a valid .dtb)
>>>>>
>>>>> -Options: -[haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
>>>>> +Options: -[haAB:c:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
>>>>>       -a, --show-address                 Display address
>>>>>       -A, --colour                       Show all nodes/tags, colour those that match
>>>>> +  -B, --pad <arg>                    Append free space to the output FDT, for later growth
>>>>>       -b, --include-node-with-prop <arg> Include contains containing property
>>>>>       -c, --include-compat <arg>         Compatible nodes to include in grep
>>>>>       -C, --exclude-compat <arg>         Compatible nodes to exclude in grep
>>>>
>>>> I'm tempted to remove this and just tell people to look at the
>>>> documentation in tools/fdtgrep.c. Especially since we don't actually
>>>> allow the user to pass any of those parameters themselves via the
>>>> bintool, so it isn't actually useful.
>>>
>>> I would like fdtgrep to give useful help, though. It is a tool which
>>> can stand alone.
>>>
>>
>> Yes, but this here is docstring for the fdtgrep *Bintool* module which
>> actually doesn't support most of the arguments specified here. So I
>> would say it's more confusing to have it there than not have anything.
>> For sure we want to keep documentation of fdtgrep, the tool as in
>> tools/fdtgrep.c, complete and up-to-date!
> 
> Ah yes, I just generated it directly from fdtgrep. So perhaps we
> should have no argument docs here and just mention what the bintool
> actually supports / uses?
> 

It only matters what the bintool exposes as API, create_for_phase() is 
one for example. I'm assuming you *could* call run_cmd() on the bintool 
and provide a list of arguments yourself but then there's no point 
documenting this in the bintool as it'll only be a thin wrapper around 
fdtgrep itself? See what we have for mkimage bintool for example?

Cheers,
Quentin
