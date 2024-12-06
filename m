Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42221E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 12:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3EFA893E9;
	Fri,  6 Dec 2024 13:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="DCqMOoz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25056893E9; Fri,  6 Dec 2024 13:42:21 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A22989373
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 13:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQCLekfuiF/Pp72NUXp8nZKZS6r9Gh2QYcyG/kDcAWmayBKkmpcIwBEsUDkU4s0fzL+rOiMJEZle9I5zlzMZ/miXhAdXes6t0G6do1bmzvI92oQ7HABscKjbJGn54BklseUSeqJNdZvp925B87ZWkUNNIc2BMZtRu5iRXCvpGiNQXTRW0HmigZsbHXD4NqyAT424J2MHy9gGkcNxjSxLj5+kxWjrpmQ+ZQ+SL0JC6gl97eYrPBc+4jeHSZelFiHXyMEZpygt9LkfH6psNXF4GLGdliF4p0z5rs2Zk67nV/yx3jkelfza7P5PDojfsGk5I/05S25dU8Y4I9EbfACNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egB1na4GeS/f1xVPS68VqRTqcuYIW99mRAg5KJ2+T/A=;
 b=wzUgwBHcUP6YPEarq/VZC/v5ufYO3tNN1+mWApwGy3hhfZGAOLxA4bm275Lg9MAWQpo1i5ta3PujiqwjHBbzg5RWAB9DAyYIg7SfujTU9lVLTM+rJmoMp5C2qdf5/jQ6qUlVvcE0SlQMvp5RzeBRLBzMcCmgz7HK+s2eB3z+SkySHOHAK7ZeNr3DQd0OWtw19FNPlddWp4wpyf5TsfvKvlE1Gss+vyQWGFylj/HsmGY20ZtIiNNqzZP/iz3svV3Ybv0pdJSahzDmhVqVGXVozxYasdyyDSZzkx7KzwXM/X7iatPH0c4ld0Kxi22qf8B3VVHUOadjAt1c8edQNHXPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egB1na4GeS/f1xVPS68VqRTqcuYIW99mRAg5KJ2+T/A=;
 b=DCqMOoz/qqEE+Y0+F+JeTeDDnEk5I0YidULtARaj4J/0VW7AYNS4HF+DfiFepiC7iuXQaYToKZOF2ygqJCw6awrABcS2MiQ+wHnuPXV63kSsuvnrQ1l4H/rTVt7GGUIWEOKLrf26gTNWW4QkO/TlZUzfEGpS1FQ8r3Mzlq6Zpk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA4PR04MB9664.eurprd04.prod.outlook.com (2603:10a6:102:262::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 12:41:51 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 12:41:51 +0000
Message-ID: <6f50a397-7d46-4ed6-8f25-b06f1535b96f@cherry.de>
Date: Fri, 6 Dec 2024 13:41:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] net: phy: ksz90x1: Handle ksz9131 LED errata
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241120094903.94-1-paul.barker.ct@bp.renesas.com>
 <20241120094903.94-2-paul.barker.ct@bp.renesas.com>
 <3cc475db-8546-4855-991c-5e678bef0fef@cherry.de>
 <ce662fc7-da77-46a3-9f34-081b3377cac4@mailbox.org>
 <413c1e5d-8e8a-4d12-9e50-bc22816a89f1@bp.renesas.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <413c1e5d-8e8a-4d12-9e50-bc22816a89f1@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::17) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA4PR04MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: bbac74fb-058b-46f1-c846-08dd15f35b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXdndUVkZnQ0bzVoT1hhNlphWjhmL0htTXlBNGk1WGR2NlppbGRwYUpTczUv?=
 =?utf-8?B?RUh5MkRNZE9heStVWWpQdlVDcG1mZzBJQjJZOTM5TkxNWUZqeGNabWwyK24x?=
 =?utf-8?B?bTgzZG9hUk1ZekFyeS9yN1pRczQ4WnZoMlJSd3NqYUJRZEc4UFY1RC9sRVVK?=
 =?utf-8?B?ZHRVRVpvR0hzenhiZ2RoeVBzenhXWDNMUTBOSmRHZFVQN1Nvcnp6c0VEOG9G?=
 =?utf-8?B?b1YzdnhyWkZHTlZpeFZhbDRTajRlQmpYT1Z3dWp0NGsrZmNZaEovN2RUSUZI?=
 =?utf-8?B?WFlra0VrY0JvdXBLMHNWQUpFS2ZuNHBLTGNLSUNTRnRhbWMzSlJ0M1VybFVX?=
 =?utf-8?B?d0ZNTEgyTk5WY0NyMkdkQzRoekdEaDZUdGgweStJb1JSY3NadE1aQVNUbG5C?=
 =?utf-8?B?eko4TkpaRzZjbkk3RVUrMkRTeVI5MDRnQ3FJQUNyTXkvempNZERrdVlDbHFR?=
 =?utf-8?B?d05EaFdJREJEZWtnTnJTeURPTXNOckVTZGNKejdwb1J1enFNMWg2U3J4SUpR?=
 =?utf-8?B?TVMxb0NrSGdJelllVEtHaU42K3ZlMC9UMHg2dlNKcDJmQS9IOHNueFhDTHBa?=
 =?utf-8?B?ME1LblFUcEw1ZVFmYlFXK3NVQUtLME0xL2tYdC9EOGYzbER1TmNiU1ZneS8v?=
 =?utf-8?B?UHBXSHpSMUNERS84QzBDU3JCYnc3ek10N0U3YUswSHU5UThKWU5tbjIvSW5z?=
 =?utf-8?B?SFE1ZWdMbnNlenBzbWd0bC93Um5PR01WY0wxWmZScHNRWGhuOUJ4NjhWNkhv?=
 =?utf-8?B?NHZXRnlJaTQ2NFYybDZkU2VwQmUwd2k0RE1VNjdVQXFhY1ZNSEQvMXZ1MTFD?=
 =?utf-8?B?QlYwTno1VVJGUGNsaERaTmNxa2ZWQ0I4QTlES1RQbVN5eTc3ZUJjWGN5bjg3?=
 =?utf-8?B?Ym5yMHo1KzFPUXZodXRaTit1U2UzTGV1cFI1TkdnZlNCMENSR1QvYWNzS0ow?=
 =?utf-8?B?VGZuZTFKNjlYZkIzaXlRa3ZUdExmeUxUYVYwR2wvU0NPeGNZNDdWY3o5emcy?=
 =?utf-8?B?RnFhMElhY0Q5eENEZUF0UW5sR3llT29SWHR4ZG4vMG9NTUM5UktOZ3FmVGNO?=
 =?utf-8?B?bzNyc0lHRWJCQllFc0lSMGd2SzNaODgxWWpmUUs1TCtBdDRPOGZUcGpLbUNa?=
 =?utf-8?B?azRFekM2T21sRnJEczgwT2crNkM0WkJZTjZVMG55c21GOC8xSFUydllnTjB1?=
 =?utf-8?B?RDFJNWs4VisyTFRzZFliMVNPWmhPOS8wN05lRGw1eUtWZ3EwNjV3Z0hlWGo5?=
 =?utf-8?B?RGdiVTdBcG5ucld3VURMZzhVVXVtZ1dUc0wwUkNhZEl3VnQ3dmljYjB1S0Q1?=
 =?utf-8?B?Y3p0TFVONlZlT1AwTitGUSs0UTBuRURUa0xZS1E1c0NrTjMwSFBNZVQyVk9a?=
 =?utf-8?B?SDY2L2h6cm5zMnlMOEM5dHdDTjErTkVBYkpqQ0VMYkdBTmdYTDRobTlDNW5a?=
 =?utf-8?B?dVk1b3ZJcTRnWjVGeERyemtFdDZXQlJ2ZzQ3clRlQU9VQjFhWWgvbEVzWVk1?=
 =?utf-8?B?WFFrVkZBbXdrVlVjaTh0Q2dYT3FMeWllZDFJWkJCM283bzBlb1dBbnFUUkx3?=
 =?utf-8?B?VHdYUVlNM21wczkvTE9DbWd4eVBVZVVPVG96ZW14YTMvVzV6L0o1NCt6eXdB?=
 =?utf-8?B?WUpVSkxEMlJYYjlOMUZqaGF4ZWxWc1c2UGR5aVFwdlk0Vk1EY2k3TktndXV6?=
 =?utf-8?B?aUVOdVpuY051WHdPZDAvajdWSFl6ckJ1MTRTUWhVVGtpV2xtVzNwS2tKdW9o?=
 =?utf-8?B?cHp4N051emMyUkkyUUFJTWlRNENWRWpkMW5wR2RpSDlzZFFUKzdXZzVHdk1z?=
 =?utf-8?B?UmtROUgxbEtzdHAzNE15UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEtKMWlpYUM4RW5oc3NLVjVYZ3NJOE9kT1RCRC92ZGpYWGZPYzNyTUQyOWly?=
 =?utf-8?B?eitqNVAyMmhwRnQyUllyZnNsQjN5cXZ0ZVVhWG14VkRib1FWS3dkYzFEZzha?=
 =?utf-8?B?bzJUMTlNYWNRNnV6Y1NjdG9MMGdKN3ZNVzFWQkFVV0RvR282QTFxUVUvcVdi?=
 =?utf-8?B?NXRUSlNvd1V6VW5ML1loRHNpWGFNZnpqVVVJc0djQ2xranRyeHNndlI0TFF6?=
 =?utf-8?B?ZWx6Zk1EQnE2QU8rSTZrNUdGRjJsNURGbkVXOXlVTWFjSTdLczBtc2ZzaVhn?=
 =?utf-8?B?TDluaGRwd3JGSGtndmhkeUs5Ylp6ejgxcE1OVGlXMW1vOEplblpRTlYzdUxH?=
 =?utf-8?B?STFrbzJrY1pUVTBPenBBWDVoaHhrTjV0enZ5OVJtbHE5YjJjZkNneW1VU3JK?=
 =?utf-8?B?c1B5OTA1YjNESURLUUJMOWh5T05MMFM2b05YZnJWcGdESVdxblRxVGVwSHM2?=
 =?utf-8?B?SlVvRTlwbGx1aW9GWS93ZDlYVmtjbEQyY0I1enM3QU9Ea2NyTXpUK1FrOVZ0?=
 =?utf-8?B?TitTVUxnMWhyaTY3VVptV29uVGpxV09BbnBMRWkxdnN1Vm1yTHhyck9VYzFq?=
 =?utf-8?B?K1BtSmpzTlFvbmNCWUs4SGIzV0NscHNzR09sVDBlZVhHZnIyOGh5VHZOaEtD?=
 =?utf-8?B?UkFBcE4yVFhaRmxSZmtCOUxFL09qWTJJYmh0TTVRZlFhQTVrZGlrUXZKWjUz?=
 =?utf-8?B?NEhnb0hncC9DUTBCcWl6WktHVi9OZ2l3dnFnVGkrTzB5cVMxV2V0TmlnVEhm?=
 =?utf-8?B?STJQRlJwRGF4cFk5alB2b3pxcXFSTHFLUnZtK0hOUlRwd0pUQ3BmaTdLbVZj?=
 =?utf-8?B?T21LR3JFaGo5MXlISmY3V3ZhV2crT05qOHFTOXhaSTBUZHIxYjlvL091M0dj?=
 =?utf-8?B?OUZyL1NNOE5HRXB4OGxYSHZNUjYrZ2F1T0FpdkRhQXlYVENnSEtpMStyNHRB?=
 =?utf-8?B?QUFFRHVSNWpPSGRXYUkxQWNaSTdxOWpMZlJ3SkIxbThJNW9jR2Q1ZmI3Syti?=
 =?utf-8?B?aWdvQTdFeWFKYVdJKzQ4SldUR0FKVVRIcHlrdS9xSVZ6MkhHUWRvdncvQVZ5?=
 =?utf-8?B?RjV4dU9PSFZjUGlzc244MzBPazJRRS9sMDdGTGhWL08wd3NyaE1oSzN6OWwv?=
 =?utf-8?B?aVhkbXBibEY5T3FRaW9WTUFDOHlvV3c0eEUxT1RPU0NaYy8vRnlWUEJVQ3JJ?=
 =?utf-8?B?WDBsRnhLZm5INndyTXdEOU5HZUU0R0o3NTZMV0c3M0EveHlkc051TDVaT2hO?=
 =?utf-8?B?QitaUUdmeWhBK2QzaFVJTWM1VFhwYlZJUGVyby9MaFZ6VlRlSXc2TU50b3JC?=
 =?utf-8?B?MHhmSFZCQVNub1htcmRMKzFQeUI3ZEpDeU9NTHJIZnllNCt2Z3hyR1g3aXpn?=
 =?utf-8?B?eEs3YjNCamNHRnFob3owL1NwYllMeTJZeWhyK2FFSlhyZEQ3MWxvWXNERnYv?=
 =?utf-8?B?anlBem1CSEVFay9tUnZEbEc2V01YdXdBMVZOSnc5eXlwaE0zdU0xanBwUVhD?=
 =?utf-8?B?NFU2bUR4RWZMUVlIVmhIN3ZMWGlTeWJHQUxxZm1HNlBtTnNNb2U5QXl1NnlI?=
 =?utf-8?B?ZEUrekZzSU9NbDcrbXdxb2NGczNEZXRKaWRqT2hERi9EcTVHSUR1L3Zla1dj?=
 =?utf-8?B?dWxMOG9UNHE3SDhxek41VnNIU3ZmNGEwZm0rejZBT21NRmt6Nm9CbW12RFli?=
 =?utf-8?B?SzdNOW5XcU45VG9BYllrbWNXRThOT2RvbGRia1I1dm9JcmVRb1ZaRmR6UmNL?=
 =?utf-8?B?WkxjcWE0MDdBbUZiSzdSVDc4NWh1NlYvR2ZMUEo2dnpsT0pVM2xvc3RRcnRh?=
 =?utf-8?B?Q1FJWFp1SlE3K3NSUDhGVzJVQ1lKV1F3UWZtUG5qUjVkTEw4a0VxUTN0UWVD?=
 =?utf-8?B?UVhmN0hZTDlqMkc5TXI4bVJid3ZLWlFDNU43c09DTzByNzdsTTBWRm9zZVZy?=
 =?utf-8?B?QnF4ek9SclBUQlRHSzFObGtvMUtyZUdSL1NaeW81Q3FrSGwvQmdKR0NFSExY?=
 =?utf-8?B?L2FnVWlVSXYrWFdyOWJ6NEpUUSs4RnNSK0Vaa1RpK2U2bDdVRUI5dUgvV0hO?=
 =?utf-8?B?alMxQzBKcGdrN3JNQlR6MnIvNVlmcGZod29XbTAzU3VqUGVWWUdaK25paHpi?=
 =?utf-8?B?bEl6YmRIWFE4Y1lRa3FmU09QUWU0V0xVa29ncFRIeDdQVVFnNktKdTl6WHJo?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bbac74fb-058b-46f1-c846-08dd15f35b48
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 12:41:51.1601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKxKc6XCP/3ZyO0Tc5UG6x97cilk426+kEAmqYYpl0mU2rhkTIMqR9k3dBo6rwBsRtxLzdYhHUKqL4LTwunAqajGWJXDDlnp4Xoi/n7/UXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9664
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

Hi Paul,

On 12/5/24 7:58 PM, Paul Barker wrote:
> Hi Marek, Quentin,
> 
> On 01/12/2024 18:57, Marek Vasut wrote:
>> On 11/25/24 6:23 PM, Quentin Schulz wrote:
>>
>> [...]
>>
>>>> @@ -446,6 +474,10 @@ static int ksz9131_config(struct phy_device *phydev)
>>>>                return ret;
>>>>        }
>>>> +    ret = ksz9131_led_errata(phydev);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>
>>> This seems to work but is happening a bit late.
>>>
>>> Indeed, I need something to call the network stack for this to be
>>> happening. Meaning until I e.g. run `dhcp` in the CLI, the LED is still
>>> following the bad behavior.
>>>
>>> I assume we cannot use the probe() callback for writing to registers?
>> I'm afraid there is an inconsistency between U-Boot MAC drivers and when
>> they configure the PHY. This is well visible on MX8MP, which has both
>> FEC and EQoS/DWMAC MACs and they behave differently in this aspect. The
>> question is, whether it makes sense to initialize the PHY before the MAC
>> has been used, probably no, because that brings up hardware and adds to
>> boot time. But at least aligning the behavior of the various MAC drivers
>> would be nice.
> 
> Is there anything we can do in this driver to fix this?
> 
> Or should we merge this as-is and improve the MAC drivers later?
> 

This patch doesn't change anything or rely on some specific behavior so 
I'm of the opinion to merge it. Making the behavior of all MAC drivers 
consistent would be nice but has nothing to do with the PHY driver here 
I believe.

Cheers,
Quentin
