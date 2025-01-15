Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04D9C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 11:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A76800C2;
	Wed, 15 Jan 2025 12:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fy8NLSr4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B04BD80214; Wed, 15 Jan 2025 12:59:39 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93CBE80040
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 12:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0K34IlR2A+z1ot3pKrJ6Rmb+x7SC4jQpVj1jB0Wzr284aeTU38F2/q6NLKoBHIq/VkrZyGjGCLNCV01wCjT2UYYOyCw23gnm0vPbRuDEO73jSihyVmLoWwLBtVwMZTPEEzHJJMQCOb++l4Gh4Wyw2E5XFDKC7xKY3SSo7xvJDOX59uyau3P826jM+FeVpzMt76EopleyWIHedshzKe5UL5fZN9sXW6dElRS413hu4J/0tHnsPyr9z6fZmMc1Q14dzFnck9OursMNMwE2ZPW9lGCTe9poX7BzLJB8QXUl2ca0p0SCCVeWogOyQqfFsLQJQW3nWhMTypbIvug5V0riQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjOZFtIV6+cxhrPuCpurQ6TDFRfqdaVfXE8KhAgvJSo=;
 b=TCm5WTuNi2pYrRN/5xXZvn6MhOkI/U9pqEGLOoI5eRkA4Z4Ev2YsFFUQB4Fq76b3ZPUERZYetzE5ZfJFWN2yCkcPFC6IP82rTebze3YmXzZt/7v54o6WXAes68pL3w7R/cDp1CqV0m4qlY0Q3OrhPmEWzzD8IKCrNxyJBI2TnXZW8aHTwWa3wTfTU+2C0ZfMP5EyFUcpUKHSuurXqCAYY0lKrbp3FO5qLIczRuCO1pkS6iuyYPZrgzKm8VtnwKVzuwlT19g+aSi3EVbo/euK4O6m/7XPpipP6DUcsg7ao4TdPudJZkcWSfTuYJ2FroYQkRTSZsKHPg12qo8ArEwx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjOZFtIV6+cxhrPuCpurQ6TDFRfqdaVfXE8KhAgvJSo=;
 b=fy8NLSr4ktJR5EqoJIIQdPun9fTq46W6xo6Su8XYE692t/jH2TTWcJo3IJRmtGAu+m56bZETD6V6V7y/zHfJbi+NKkpx1ORtnft/JgnZaaghNI+Ifnr1keoAhum0y3uM9G7I3O49lxQ/zod30p3tPz2FUorn/DO6ovzlc1taD3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7345.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 11:59:35 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 11:59:35 +0000
Message-ID: <c2c5dee2-a8a7-4a1d-bd62-208c39db3b15@cherry.de>
Date: Wed, 15 Jan 2025 12:59:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] pxe_utils: Allow the FDT to be missing
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-4-sjg@chromium.org>
 <a1572755-9853-4941-ac0f-3a30bce768a3@cherry.de>
 <CAFLszTi0CToKb8zLC1tRXW0XabQTAEQeT3PUZbR9YRybr9R9DA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTi0CToKb8zLC1tRXW0XabQTAEQeT3PUZbR9YRybr9R9DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0105.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::34) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: e40afc27-08fc-45b9-02fd-08dd355c143b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUt6K21XQ29HekR3UlBZdVZVQlBqOHJnQTRSVkhnN1FyRjV6Q1lGQmFXRnZl?=
 =?utf-8?B?WWtGb2kyOG5XZzd4UzJnUEtWMEZRZ2FiYnpyUXVaUkhzbVAzUjdadUw0emtH?=
 =?utf-8?B?b2NadG5VWHhqMFFuazN6QmF2bFdiQ0p1NzQ4UGFHU3hwcXZRL0VFVXA2L2Z6?=
 =?utf-8?B?Ny83NU54R25qejJNbDE4VDBhWnR2cEFoTEw2N2hSYXYwdEVwcER3N2tWdFZU?=
 =?utf-8?B?WDNxTG96cVBRd2dTWDc2MElPRklGVzVpV3F0QnBuVWxqbEpEeG5EbkgzOGpD?=
 =?utf-8?B?aUV1b2dnSm42QjY3aFhYSFdQV2VKMXVJczhIaHlWbm5GbzJTMldPdEZRbDdV?=
 =?utf-8?B?QzlIQ0wxT2hjRktibWhENUFRMG9lemRLT0xieHFjQitKMW9xNERRekpEUkFq?=
 =?utf-8?B?UVh1VGRiRWlNU3FLU3k5ZlNBMWNaMUZHMW14eGpoc3pGTG5WRUxLVzFFN3A3?=
 =?utf-8?B?dU1RdFpRZzlzOGhUWW1pMk9VYjh3UEw5MWFCMCtWcXlzSEh1TllkTXBscEh2?=
 =?utf-8?B?elJxcjJZbDdWV0p3c3IzQU9EZkY1ZlozTXNMZEc2TzZOZTNPc3RnVkpPTlU4?=
 =?utf-8?B?QUl4SW96QUFCRUtHa1pCVjRDa3pucEkzZ1JSeWdHY2t1RVdaVmY4d2pueSsy?=
 =?utf-8?B?dE0zSm9TTUt0cmpJd2tqK3ZzblJBZjE3ckFmT05vNWplYzlXeUprUkJDZGJY?=
 =?utf-8?B?anVRVzVmbHhVemhaWCtTVkQ4dFVsWjczV2tySEtaTmZxVWdWdUUwQS9hSSsw?=
 =?utf-8?B?bjZNUTZGUi83cXZJWFlVOHNDYThvL2I4NWF6WnJsazZEd1VTdzZtNUdGeTJ2?=
 =?utf-8?B?bUEwT0ZZR1Q3M3NDTHFkdC9zQjdmQUsxZG9McEd6YVZ0VWhpc1RnWUdjWldP?=
 =?utf-8?B?K1hrSWpIT2VXRTRwaE15VlNDaFVMcDFna1E2R0dWdGNYUWUzQVNmQXExN0JB?=
 =?utf-8?B?a25jRGtvVy9sSUE4YjNVdEhON1gxRXdncWFnRGYycHJzbmcxUUxXSUR6enJt?=
 =?utf-8?B?dzRxOUxxY3h3aWNocEhUdGN6MC85WXpiZ2RWbDRTSXI4K1c5R1NyVS9FZ0dz?=
 =?utf-8?B?RzBmUElyU0x2MmRmWXBNTVdzRCtlWDJtZkxHRW92L1VCS01hT0ZZL0syNWtE?=
 =?utf-8?B?THpMOFhkVldvczVuOEU4RDFzMGgyMW01V2xtOWN4OW1oQWxYSzg0RDBkelJq?=
 =?utf-8?B?KytYVkZtK0FDU21JTWZTcG5YTmR0eGp4cDdVRE5qcmRWeTBLb1ZLU1JHOW5R?=
 =?utf-8?B?bFptYTR2V1doNnpFR3RueWFVQmdDQmpnVzJVN1NYQ1pIL0NvV0pKaTlDaGJj?=
 =?utf-8?B?MXpPcUliRno2OU1HeUJudTNSZVUwRktiSkpUS1pvaVNvY1BmSWc0YWFKWVJN?=
 =?utf-8?B?UlBjeXBlWDdnMzFISFJZMmNKeWpLdWp0aGhGcjlWZ3ZxckMwWnFVeE8yY3Ew?=
 =?utf-8?B?a3huY2U2MjFCRmp3YWpsdXpNQ1BxS3NDUExydnVqQVVheTBHZWlKNUNoVDVQ?=
 =?utf-8?B?ZkdQWnFSV3NPMktBRzhsMngzOXdlK3IxU3EvZlZyQnpFL05qKytGcE9qTFpw?=
 =?utf-8?B?NmdSNjJheWJ6bytWUU9EejdCT01aQTdaQUwzbVZtd2JyaXhCTHI5allmN2tL?=
 =?utf-8?B?NkJCL2FrdlAxaUkvTFVhdWdETWJzVDhBMnBvN1BjbVF3endBTVdDY1dGc2ho?=
 =?utf-8?B?Y01kQkdhVjBGM204QUd6eG1udFkvZUpZVWwyVWdBelNKYmhTQWgyU3hMSkFD?=
 =?utf-8?B?cjV3aW9SUEpEN20zbXBWZEdPc3ZOdXJaWXVOa20vaTk3UXBiejZmMXBGT1ZT?=
 =?utf-8?B?NkVsWmhLMHp2OXd5R3RPdVE4ODVrYWN0SnNvK3ZvQ0JNbXluOHd3UE9UVjNG?=
 =?utf-8?Q?v9n+h9wcr6spb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHBMTGx2QUhacFNQN0RKUE0rNUgyTS95bi9qa0lITk9SNGNHeURQNkxIMkwy?=
 =?utf-8?B?bGh4dnpiVUFyeUk2ZndNTkhrUDFTUGN2d1M1UWlDUmQ1VHltQXZUaXhkZUl3?=
 =?utf-8?B?eEVWTUhhTUZyRE13NWZwcldqYkdDV3JFZU9VL1p6S3UvSjlkS210VGdvU3Nu?=
 =?utf-8?B?aVVZNE55SXhPOU01WDI3Y3JpVndyR3dBVmEyQW1COWpSOG13bGJaMjlnS2Ry?=
 =?utf-8?B?M0lvSFJ5QjFEM3JSTytveHpQZkR3NmNkY2dqTmVlK2YyUXJwUkFwYzNUSGx2?=
 =?utf-8?B?aFhsNHZIdmg4R1IySTUwdTFOM0JVcm9icytaWDZLdW9KbDNCSVJPeElJUS9F?=
 =?utf-8?B?aWE5U0NZaWNMU3Ura0JMQTZXWjQzazdGMWo4MEJtaVB4K0w2Ym1NT1d1Z2ZC?=
 =?utf-8?B?NWd6NVZ1cTZGR3VHdSt3K2Y1eXZYSm9PbHVPSDZMd2ozSU8zN3o0ZVU2WVpu?=
 =?utf-8?B?RVROYXVMUzB1ZHJVSFNrcFZHd0xsclAzYmhYdTQyMXJoRnpIK0t1Wjh2cHBz?=
 =?utf-8?B?OVEyQzVzSmJYZEUyNVgyOW5lUTM0RjJ0enVFVHZUT3czTEtXcFV5ZFRVcmwy?=
 =?utf-8?B?N05LQ2F6REVoT1RMTGEwY0dsd1YwSnhwUXRsbnRSOHJVeXBIbjB2UVp2Z3c0?=
 =?utf-8?B?bmlFbGdNQ09BVzBJS2NxYzBIWEQrYlFac2NGbE5FVkNHZkswOVN5akExQThM?=
 =?utf-8?B?ekhXY1I1QjVlSVNlcXc0Y0hmVklKMWpDMFRzMFRoNzlIOGx4YTV1d3Y5U1lr?=
 =?utf-8?B?cHVTVktBTmE2ZWZDbXQ2Nmo3L0hsK3J4OVc3UDh5bUk3WnhINUJoSnd5ZWRB?=
 =?utf-8?B?dnJ4OWtXdzFwZTFaT1IzbW9rUmU2cElVQ2ZoTzFTaG1KdDI5NnNhUk95b2dq?=
 =?utf-8?B?VmhacjlLWHV3VW5TV1BqNFRUbVd5ZytOT0krd0dRZ0VyV0lidUlyYWhWUCtW?=
 =?utf-8?B?NTNrWXROSWJUbDBxUDFGcGg3MVVCZHBtaE42SE5PRDJUSlI0ZTBRendiOVJC?=
 =?utf-8?B?c0FnNFdVUXBQb1lUcjhndUhHanFyYmFDWmgzcUY1UG0xUXlOZ2ZWZWdvV0VT?=
 =?utf-8?B?SGJ4YU4zaTBETDZEQzhTcXhrc25tV1lUWmtmZm1iV1UxYXQ0NXdGQU9MMk8y?=
 =?utf-8?B?dzhJbllVbyt5T3ZXaVMyM0diNFhmSlp2NDFxbGZmSUZ4ZHBpMExkR3VrQm5m?=
 =?utf-8?B?YUVPZjI0TkJ3bFh3TkVIbXdJV2V0SjArd29JUWhzQWxTVGR6N3JpeDFBK1Nj?=
 =?utf-8?B?UDA5UEJHTWV4Vnhia0VuK0x0ei9JUXNTZFN3QXkxQVh5VXppQk9UTW40K3Fs?=
 =?utf-8?B?Ykt2ZzhnWDd2cmhkNHRnM0pjM1VqalVFNjhwaWFvMzdsakxEakhFa1diN2tm?=
 =?utf-8?B?Y0V3SDlDTS82MzlGdTN1dER3a09RSGRLTk5ocFd2MmlyeS84Qm92TnN2VjhL?=
 =?utf-8?B?MWRJYnZ4QmRrUjkvQTduZ1Zkb3Z3c25yYzNzbnpvSzVtY0JCdXB4N3RVYktt?=
 =?utf-8?B?ckpFdWNVTkxHVkdkbmlUeTQ2ZHhnNlVOMVJCYXJOQWo3NU5TT3NzOE0wNWpI?=
 =?utf-8?B?RWFQLzgva1VoODAwRVZZTnpJRi9uRU1wUm5FWDNFaGtUZDBVSUdYbDJkTHI4?=
 =?utf-8?B?OTlsTkNUTEkxSVZXTkVURmNNeVgwRnhOZEl3T0V3NHhsb1F3QWJ5c0dXUzI3?=
 =?utf-8?B?MUZ5a05EdUIvZkZLeVBmUXlES1hUUjdIMUJ6RDh0OFk5YXZWUUlLMUh5eDBl?=
 =?utf-8?B?M0tXMGg0bnVtY0xIbzRBeHBFZVpqMnJrT0pKUnAyU1FXNmwweEhNcEN4YTE4?=
 =?utf-8?B?YlcwOUoyeENxWGhtVGMxSmdPaldScGx1V2c0OFVoOEV5OTcxc0FPbkpIeW5a?=
 =?utf-8?B?dmV6a3U4VmVQYkZCMXpGbDFaQm9MME1CK0M4WXk0eTk5M3A3OXo4N2JZU25w?=
 =?utf-8?B?bDBBRDJPOGR1Qm14Tks0Q1l0VXVIUkVFWEkyVVgrMEphZDFwektFSUI5UDRL?=
 =?utf-8?B?a2hVclEvRmRCcTdic2RGV2FJMy9Rd0hDMUdHem1PRkEyTGswdENhNDZNV1pI?=
 =?utf-8?B?eHZZWCtQa3UyMnpsL2lrYW5TRkRGVjFkbnUvc0duTWwzVXJ3OUY0Ykh5bVVS?=
 =?utf-8?B?QlhVdFlLdkdGakdEYzZCcFh3a1V4aG9tc05EdUtRSi8vZjBodGhCM0UwcTRq?=
 =?utf-8?Q?iRiARm5Uo9M6RO1ovkQ4aR4=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e40afc27-08fc-45b9-02fd-08dd355c143b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 11:59:35.0656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2vr07t9BLN4QAeMURGogKAj7+L0gev79pa1mrMqu/4gquhlOVuiV5QPvMUSZxQprKFhwyESUFVv4NkA92XZN+YsamaGNHKZEeexGYT8J5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7345
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

On 1/15/25 2:16 AM, Simon Glass wrote:
> Hi Quentin,
> 
> On Tue, 14 Jan 2025 at 08:13, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 12/20/24 5:01 AM, Simon Glass wrote:
>>> The devicetree file may not be provided, so avoid a failure in that
>>> case.
>>>
>>
>> Can you provide a bit more information on when/why this shouldn't be a
>> failure? I assume likely x86? or Aarch64 with ACPI instead of OF?
> 
> Yes, either of those, but also, even on platforms which use a
> devicetree, some don't have it in the extlinux file. For example rpi
> passes it through to U-Boot from its own closed-source firmware.
> 

Ah yes, I had forgotten about platforms using one DTB and passing it 
through stages, I believe Qualcomm does this as well?

Could you please add what you just said to the commit log so that we 
have an idea which scenario this intends to support (for future 
reference if this introduces a regression or we want to do refactoring 
in the future).

I'm wondering if this isn't going to allow booting FDT systems without 
an FDT at all, which really isn't great? Is there something we 
could/should do to prevent that from happening (or at least notify the 
user of such a scenario so it's easier to debug)?

> Somewhat related: my opinion with extlinux (and EFI for that matter)
> is that we should be using FIT.
> 

FIT images are not really developer-friendly though :/ I've been asked 
to ditch FIT images to allow easy replacement of customer Device 
Trees/kernel images. Much easier to say "copy your file there, modify 
extlinux.conf to point at the new filepath for the FDT" rather than "so 
this is the ITS, change the path here, and there, don't forget to have 
those binaries in the current path, use mkimage, then copy this itb file 
there".

In any case, I don't believe we could remove non-FIT support, so here we 
are :)

Cheers,
Quentin
