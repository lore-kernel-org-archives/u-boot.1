Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC6ED72361
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 09:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C24B3839DF;
	Fri, 23 Jan 2026 10:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WRcjnfee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A61783A6A; Fri, 23 Jan 2026 10:39:17 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E7208397D
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 10:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiAJNhXPdGSUqS7cQDHE0xm5wWh4ZNUH7UABvaZS8lpF0ncquHb4A/SlfXP0lVPy58Kd7ADZ6rWBcEKmViw0DqOxecL3soSHiQOxACBfW9TUEF71szkKH3b7SMdPAGWJS3milru+cIy1e76m0gtHq4J6EJKqlJwYB/Gh5HDypue44UnUiPjRLTdE4YGPu6EK0yPn/fouZ1S8EmbWLUB/dxYWcfEBuFkmr5RUdc3UVlQJWQR6JTUdiyG9mv/AhB6o4V/h7dlbuOA3l5/R4MHgBrV9IKyaUr33/QDJvVqLdw4g7x04Spk4txQ9q11FJrkrNqIEE6mOMm5RGmOB0nF1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cGzq58yL5uKPbB+RLtXTEjiSFlpGpRalYX62Oy3HzM=;
 b=XimjanZECGFjDJUJyvkDlJg8kDTYyUydZq/wxga2JR8XO5Z303bfRXfJNMT1TYZ2rTL6W/zwFcDhK3I0vAQ1R+ddozzQHMpuxQPbzGlFqJmAPCCiXPUDX5mQ2DK3XHUM6ufvi41s26NU1gF1McfPwk+Pv4HjrlwT5F17K3WtYHmmiNM8plzDrFqpwjklS5h72VUR2YXXLPn0/A1PTl8ELbl6oGwr68bBt3b5BcvfalqUDTtlqsWwfhhqnp1aQ7UFniiokzjb6STIdGA0rEdA4WwI7Zfn96zR2cYDzVWqcxZGuOlrtX4xeOg0visUQWYTSwzcqTBX8pSxJst7qUzIvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cGzq58yL5uKPbB+RLtXTEjiSFlpGpRalYX62Oy3HzM=;
 b=WRcjnfeeJtNnRlA5LnO3nouCy7YT3hfnxoY7mrwRgWhOUEhvgl7riD+Vld4/IG7ZjDGu9sdKI0eaFUaAu4mWLwrjEErj5c4mBFGuy8UYOjXlUmgVLT3NYZ5Ok1tI2R5vVBAar+OwlKEps/gcIP5RthOsmGpspoNExozRQ+NcNHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB7877.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 09:39:13 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 09:39:13 +0000
Message-ID: <d9cd19b3-388b-4321-a81c-340c2add8b43@cherry.de>
Date: Fri, 23 Jan 2026 10:38:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: Regenerate expired test certificate
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
References: <20260122224420.2679336-1-simon.glass@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260122224420.2679336-1-simon.glass@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8P251CA0014.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c47e474-00e0-4d7c-e3a6-08de5a63448d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHY4YzFMZXBKQy9qTWlIT3BvN3I4NG1tRS9VeGFDOE5RaC9RTmFza2MyVGlp?=
 =?utf-8?B?OE1DZUdHK2YxeXZ0MVFBUkQ4Z21CZFo5dGZnUmdxT0hvbXJOaWpYTUVBSmla?=
 =?utf-8?B?cGQ3OGtuN3h3eDV5LzZiUlNwd3A1WkJXL0JSclQ5ZGU3TWMwcjluRWcvSk1E?=
 =?utf-8?B?WGNFbGFwNnpKVUE4VGdwaU1JeVpjUnozTk1lS0FVcTFROVVneVJBUzRKMms1?=
 =?utf-8?B?OTcwd1FxdXRPYUV3Q0k1MzBINDBJdEhReHBCZk8vMC9BU3hsR1lWWmZjVG9X?=
 =?utf-8?B?SGdEb052L00xQ3VmL0RzaDAwZWVXU2l4ekdOdnNYWkRoVEY5bVZNV2lMV2Zz?=
 =?utf-8?B?cGtKS05NeThRdDVIUTBUZlNBYmRoMTRac2JHcDNmSTRZRE5Na1REZXdrcnQ4?=
 =?utf-8?B?YWlaRzNMbUdpcHU2NHFHVTBKN0h6MW11UTRhb3ZoenNuTWVGNjZrUUR5WGsv?=
 =?utf-8?B?cXdPSElkbkNPUzlKZlczSVdHZTFHZXdhdWIwMzlFQ2orWTlIbzE1a3Q5bkRH?=
 =?utf-8?B?QW9naldCY3NkQkU5SnFLTDBaWWxyVjcyaE1RYytJb2N3bkFDNlVMVXNVMXBV?=
 =?utf-8?B?WmFmbjdvZE96UW5zR3FkNzVXKzVmdnpZbndGalRxeEIyOGozcEQ4SkZ4Qjkr?=
 =?utf-8?B?SmszSXI0U1RJSXcwMlhpRE5mM3Yrc1I3MkpCR21xbWxKRXpMVDNETSt3QzZM?=
 =?utf-8?B?czh3c0FTd2Z1SC9yRldGWFJvalFWZGxLcDRKR1Z4Wm95V1FGa3pmNTY0VmtQ?=
 =?utf-8?B?Nm5IcFo4M1FvWXRUUFBpRlpOSTQyYlVqRTVJdTlHSzd4cDNLUVFhZXk4ZlJT?=
 =?utf-8?B?cjhYY2o4T21BTWZtWGlLVDF2S3JEM1kzSmczSFM5TmZKN29ocFhpZ3FWcURV?=
 =?utf-8?B?VVN4NmdpV0JvM2hQYWlPbXF0TmU3MTBHTGFiMW5KbUdaZEduN0x4WlJGcU5G?=
 =?utf-8?B?VnAwN1RWeGExakNUREV6cE1XTHRMSzEza1VSVUY3b0ptODBKaG1lQm1MTy8y?=
 =?utf-8?B?SC9PMENHYkZQTzZpRFNsYll0eElJNHlZMDZKMzNUZGE2ckZoMzNOSXpDaG4v?=
 =?utf-8?B?WGNKbEpZaGtybGxxaGZidmw4amYwV1NXRGJNVlBhQThidnpZYkhSZ3BjQzJo?=
 =?utf-8?B?bytYSnE5OTFiYnB6REdYM3ljTGk0dWNXNE10bFlnQWRHT00zWVpZbW9MbFlR?=
 =?utf-8?B?L0Z3bzAzL1lrVXpTZVcvZHp6dUVFY1lQVFhUT1RnWlFSVTF6S1d2d3Q1UEg3?=
 =?utf-8?B?VzZxakdzcEh2S3U0U0R2VWgxUENROWh4RE5TUnhreE1rTTdqWWtXNG1lMFpD?=
 =?utf-8?B?T0E1a1dhMm8yUG1HWGN5OGsrME9SWGJQTTduR1ZUbTRZQ2ozeWhyR05jTU9C?=
 =?utf-8?B?OUN0aVBqbW9GcU9TRVB4eVJyOXlvd0xwNHduN3poODNydFpha05EbFp2bWtQ?=
 =?utf-8?B?bEx3NVZmaHZOT0JYbWhJTE9Xbk5DYmFENFp5YjAvV0VOY0taQWViUVI2MVpW?=
 =?utf-8?B?Vkk3QUJJdVhnOTRjcy9aZ1orK2NYQllocTVzaWY3UjQxOThFQ2VJZ3NkR3dv?=
 =?utf-8?B?OTZWVWFiOWs2eTgrSlo4TDZYb0xycmduL3FJUmxiMEpiakpsRjJTd2pzNTYv?=
 =?utf-8?B?SzdCUXFhNTd3dXJLOWZvL3QraG5JUUl4akZhRkpTNUlBR3Q5NVo5dG9qR1RQ?=
 =?utf-8?B?RmJ0M3FQemhJL3RYczBSVE1tS1NOUVpvNHI3a1U0SFpHVTgrdzFjc0cvSC9u?=
 =?utf-8?B?Uy9aWmJSTHFMRTNPUGloUU50eE5YTUJhS2NyblhCaGZ0WVR3V2E3cFpwcWd0?=
 =?utf-8?B?MFFSMW0zOHdpSkEzWVRNSDFjTUJUYXVrWDJXM2ZwMG5JRFNSTDZXY3NrVFpy?=
 =?utf-8?B?VUIwVXdyVXpRdEMvcUI5R1dMMWhRY1YzWTIxSmRaZ1F4dW9jQ2krTEdXSXE2?=
 =?utf-8?B?MEVyQnk0RWJ3L3R2SHZQVjNsV3owZVRlWGluOVcwdkhUNlQySEJiUklsdVFQ?=
 =?utf-8?B?N2RtWEV4c1ZTYmR4Qy9DK3JGbUxLZFdXWEVrMWhLQUE2YVdoZHd5M0x5T2M0?=
 =?utf-8?B?UmhoeHN3K0xZZFFEcE1sN1UrRy9lK3kwRTl5akQzN2RlbmM4WC9HSDVqR3Bl?=
 =?utf-8?Q?Eimo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdVaklhYnB4ZVRIMVp0S3FwS3MvTUFqbit1ZkFKSzBwaTRuc05xNDBsWFQ1?=
 =?utf-8?B?VEhyc25PaW5sUW9LNkoyVGtiOFBLVU04MTEwM0tFUUd4RHBzNEIyRjhGR1pu?=
 =?utf-8?B?enE2bExMVFdvV0lQWllMZ1FTN1IwS1A0eHBZVjc2UmRCV2RLTDhOTEF0SVVa?=
 =?utf-8?B?RTVtMnJ3ajY1Ny94VUR2NmhxaktiSDhjRVEwTDJ4Z05wckszVEZtVzNScmdD?=
 =?utf-8?B?RjV0WkxTUGFRYWVoUzkvVW51QW9MZy84SW9NV1g1ZnpBZ2oxbVhYQ25JSFFB?=
 =?utf-8?B?MEF4aXdFeFdCaXN0ZHBVdFhiVW5yYXB1VWZnTVpqQVpDNE40LzdNQkRaT3FS?=
 =?utf-8?B?STlIeVNUTmE4djZwaHRSMTh6K3NqUkx2RXFVM3dSdUdMNnZjaDl6Zk5NbjIv?=
 =?utf-8?B?NTIrUHVJN2lSMjVqM2FTQ0g4ZzhITzdlU2loaG9FYWRwU1k4aDRXSHZuOGI0?=
 =?utf-8?B?blR4TUdGdzBMdGJ2eVV5MVVBeG15Wmx4N1VCUnhRM3ZPOWRlOWN4YU5jZmRL?=
 =?utf-8?B?cTR2RUV4emc3bS9pZFF3Z0xjUjdRaWlFVW9qTzZXbGgzQjJ6SEw1NkRCcXlN?=
 =?utf-8?B?WDZzK3RnM0dYb3RiS3N1VjBWOEppTEF6NmRDSVhja1I5S3VMdTdMMFlFc3Jh?=
 =?utf-8?B?Qi9ZOWIwN2lwQmhhQjQwNkN3a0ZJcjNJaDh6WjdBUFVCQmUxS2xFRlJzZnJ0?=
 =?utf-8?B?UDZYRmxXNlAvVXdXK0Rpd2dGS1ZNQ1BBNlErWVFLc1dJejBobWNLbWhBOVB3?=
 =?utf-8?B?dXJKS0xDTDYwU2xPVVJJOVZJd0NwVVROZEtqSU1jN0hTd205M05mbWJhVExZ?=
 =?utf-8?B?THdjcHRzMzZQOXNhWGJYWkJlMHlvenh1SzBSZkdVTU1kUUJWQ2tzMDlTbXVq?=
 =?utf-8?B?R1JTZ2pkYjFpUlAyalRHdGZVRnU2cUxlYitieS9IdTVEbkxVU3JYM3VmZ1ZO?=
 =?utf-8?B?dmkvTlJZYTVpMGJPQ1kvYVFkMHdTTWJvNmNaQWh3MDJ1TmF3QkI5czZsdE8y?=
 =?utf-8?B?a2JaRU5ncUJSV2lQLzB5cGE1L3ExNnpLWTE2ZndaeUM5UFFXdHVJbVhlUElm?=
 =?utf-8?B?cVBWejlLSDFVOFpwdCtEOU41Rzd0VWlhQU1Ua0k4eHRLYUt6VXNMV2Rxanky?=
 =?utf-8?B?cE0zelJNSGV0MlZiRUx3RXdzY1pGWTFWWUg1amgzcDhuRS96bWYwMzdWV0hL?=
 =?utf-8?B?YmU2b3pmM05xWFloQkxiL2c3ekNDb0xXdDQ1M1BzcDIyUFpOcVhSMjExMTIx?=
 =?utf-8?B?aEowakVhZml3ZUszcXZuN2xvMjZudGxqK2pzcmxSWU9sSlM3SXljZmtBVlVP?=
 =?utf-8?B?aWxyd2R3R0huU3VpakpZRzVQOWhvUGZDWThlMUpDcjNSTVdsdmVsbll0UjZu?=
 =?utf-8?B?TzdmZFFreTlEeDBkOEIxQVlJR05vV296aTVWVk5ydkVMaDYvVFNYT0NmZmpu?=
 =?utf-8?B?WTYzNVRuVzJKNVNBQ3NBT21kRGloQk9yUU5HdWJFNENIeHlnMEJxODE1Ry9w?=
 =?utf-8?B?QTg0TmdDQ2lwYmQwa3l2bjNkOE12RzNSNHRXOS90OGZObkJHNk16VlhtSHJK?=
 =?utf-8?B?c2tPWW9ySGVqNFlJejQyVDQzWVA2QVlVaEltSVhZMDk1bXo2QmpETkxjeHo0?=
 =?utf-8?B?VmxxQm0zNk9HcloxY1Arak10SVFZSnBpVE54MWZCWFE5d014cEZKM256NEEv?=
 =?utf-8?B?M1h5WWltdGhIQUhyUVhGdnpyWDZqcGJHMkVDT1Z6VitNM3dWQm83ZEZQOVNW?=
 =?utf-8?B?WHpJZ242SVBDaW1Pbzc4bmkwSlhKL2Y0aVUwWEVuRm16djZaSk9qZlhSNkdk?=
 =?utf-8?B?NzdINmpONWNQcGpqVE0zV2g4emoxOUpZNG9aZXZxZTBTUlVrOGVZSFZTdDhC?=
 =?utf-8?B?TjlwTlYxazJrWEdzTU4vemN6K0xqOGk5VXFNN010Y3MwMEFGRU9ZTFZoQm9C?=
 =?utf-8?B?Y2VQRmVUZG1FU2lEb01lRGV0cHFZT2JMRHM2dlhXY3JiSW1ETHFnaDQ5OGFC?=
 =?utf-8?B?ZzBYcjIvOEZPNFdESzkxTXBCS09LaG5EV0ZkVmRxRlMrQ0dqb3hHV3pIT0JE?=
 =?utf-8?B?SnNLWENVaGY3UjlxVGtPWTlpWDFJMTNhOXgySW9TV0I1a2xaWTVQYjVhZ3hB?=
 =?utf-8?B?N3VCSmRWa3FMb05pREVycDcxNDAvTXhkd2J3RzkyV25WNEZkbUFka3ZnbkJ2?=
 =?utf-8?B?V2hxVVZNaDViWEtTSHVHalowekpMSkljNkpOcDRwMkVBSHJxMDdqRXNLZnpQ?=
 =?utf-8?B?OFM3d0dQMmRhRENhbzZIMW5meDZZNEZRRjdyb1c4Mlhzck9URUdTOWxVWWx6?=
 =?utf-8?B?ZVZkblRRQXlocXpnWVgzbzE4eE9DVHVOZ0JsUFQvVkhGTkJacU5pdFRsNGcr?=
 =?utf-8?Q?4JuNqYi8J8CT4PNfnupy1Yr02puznTkLreYCW?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c47e474-00e0-4d7c-e3a6-08de5a63448d
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 09:39:13.2762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nODGIkZoParFPfQhjxnlLJ/DbGdeNWIzWGoxZ4FEXi4UpZA5fwWJfnpwFroRrTi9C+3uEqVxEJZmLaXP6fk7UkMtrm0teQFNZxyuxtR8yf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7877
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

Hi Simon,

On 1/22/26 11:44 PM, Simon Glass wrote:
> The test certificate expired on Feb 13, 2024. This just used for
> testing, so regenerate it with a 100-year validity period.
> 
> Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>

Modulus of the private key and certificate are identical.

I can decrypt with key.key openssl a file I encrypted with a pubkey from 
the cert, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
