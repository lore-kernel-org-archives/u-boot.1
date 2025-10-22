Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AA5CCD195
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 09:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0805832BC;
	Wed, 22 Oct 2025 11:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NQjCbRuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D6CD8334F; Wed, 22 Oct 2025 11:33:37 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A84D28323A
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 11:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsXFGpyBurVblTH+x+FpM/baizLU7gq4d81g/p8yA/JixynNUS850nQtrIWUwONOtzNXOD0dEc3xkPhr1bmpMF67W/Bce39+eYRQtqG+up9JIv27RS2vhCUHLgVEbxL2I6ooKkzKpiITmbzmwjdVnQagBJ2r62HurDEvDz1BMrRiNstrZPVPXTlIxPhygkdsABXB53aiyQlZpU4JSPsL/VVxqu3KcvQF0Cm0bis7EZa3IqRusq8aez8QD3+UbpZN2IHF6dw+zPFNOqy1xm1DM2UNobGrulGLDxUHLiuzJu3QnfGjUk5822hTwpxKGRGcM95VEeuI40dmoiXUYpWTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3N4uvPCayeDjNIviTlWivNpjQnMnrata4OogGuVQZjA=;
 b=MLS8YRA2NUlPJ0BxivQG71T9njPGlg96gWkIoUluK3iPk1aHz1ldxHRUAjW0C55QmfIPQAD8F+NMMPeaMjOusMfGHLXsT2F4oDIYA7a7RWp21HTSRlhXG/PdnHWhbijfvxVjn21wlC2M+94tbndZ/A5egJ/3sk8fPoYkOZPKxyAlEXE2zQ9wcFipN+UUyK5QwH/Hzg2UsCpemERBwI/GT3pd3RVlPX5Y9z80zq/k1KZ7luaN/ltMObHWPsFj5DPgUpK4p8S9rKTKHZNNKlJM2k5b5vjVblpZK18JZPUROK+FFE0g5Y3jVOcr4Q2j7k6YsjtglNvjyWxh4nPyegv54Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3N4uvPCayeDjNIviTlWivNpjQnMnrata4OogGuVQZjA=;
 b=NQjCbRuD2TpVprTHZuFu4mGw++AFeZX7Xf7i0WGuTRQzNd5KoluX24ThwTYoyTPWxZY0mwYrRDYr3BEqWcU6jM/z4NvvHmabZ3kUu25VFc52XNsLDemXrDKp2FVmE3cg9hKNb7KaG5NgAe3MGXOFV4OD/nOZwBDcUCOV6ADYMiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7762.eurprd04.prod.outlook.com (2603:10a6:20b:241::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 09:33:31 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 09:33:31 +0000
Message-ID: <40cc7900-f225-4d4c-b3e4-286b1ac4b954@cherry.de>
Date: Wed, 22 Oct 2025 11:33:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] doc: seama: Reword return value section
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251021202820.1272414-1-trini@konsulko.com>
 <20251021202820.1272414-4-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251021202820.1272414-4-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: e3df7e44-b902-43c3-b1b1-08de114e1087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TklYRmQyby9QdHZ3SzZRTWR6N1hwb3JqY1FCMlUxeGRsZkVIWXRWLzA5eis0?=
 =?utf-8?B?eXVFWG1wYjVSMEN4ZWFMd2dxSjlmYTcxb0RtV0VTbjdFaVFHdmd1bzhrRFJH?=
 =?utf-8?B?dld0RUJpaHNsUGQvV1I3QmtWZ01QMFBJVnY1NDI0NmlVYXlCQk5UakNEUDJN?=
 =?utf-8?B?Q3lMZTYrc0t1NHM3WUJvRU13akZ2NklkL3ppWENaNVZpc1dSODVRUUJ2bWl4?=
 =?utf-8?B?cXdJV21oRUdJY3l1d29JWlc4S0ZKYllLOXVZeTNlaExjNnZQK1pjUGx4bFgz?=
 =?utf-8?B?Z3BiamhNSU9kWklKZG03WnBSWVJVUDM5ME5zWExwWXErYkZBcURTN0VCL2N2?=
 =?utf-8?B?VVFLVmZUWUkyb2Y2ZGVDc25CQXZaQmlIUEdTTE5XcXlOUURvNWQ0VW9OSUxU?=
 =?utf-8?B?dzBmb3ZNN0JQYTkyN0x2eFo1RGk4clNuSmFrSCt0aUIrbkpFY1hsL1BFaXlM?=
 =?utf-8?B?ek92aHExK0g5RkY0QjB5L2I2QkdkWWZRcXlXRVQ2TzVuUXpCWjNnb3hSaEhO?=
 =?utf-8?B?ZytXV2hhc1JsbENOU2IyWEFNSXp6ZkdYY09MYmVrZW9rbm5Td2NBN3l6cEtq?=
 =?utf-8?B?ZWxzZnZHR0pocThkSUlXSlhxTlNDSWIzK3duN1l1SmI0OWVGNTRia2dlbjBB?=
 =?utf-8?B?M3BiWWJLVGtydkFZa1paeXJoMGxDeUsxOWhFa1ZGQmZDbkVuV1lQUU1MMHpz?=
 =?utf-8?B?YUdIUGRVOW5IU3lVSXl3bUtmOG5aN3ZLZFVMTlhSQlNWa0c0UXU2N3JqUWNJ?=
 =?utf-8?B?VS9uL3ByUGsvMUNUelBsY3c4b09xRTlzY0dvVnJjOUtYeDNybWpJWUxtTEN3?=
 =?utf-8?B?ZnVDUE12WGFaT3JENjB4YUhFNU5LekF2d09IT0d3M2pEbytQdFk1NldDdXhQ?=
 =?utf-8?B?SDcrdW85YlRub0xrQ0FFZTc3aEp4U2s5Nkl4SUhnTWkzaUpFSllYNDlsZXN0?=
 =?utf-8?B?R0ZQa2hpNE1vWTRDcStCS3kwZE1wdDl0QkFvTi9FeHAvay9YWFN1RzM2ckFp?=
 =?utf-8?B?VmVZSkIvd2p0UU9PMVFTZ0xPc04zaFlqUktmbjVHK3VYTVdLRVYzUGhkckht?=
 =?utf-8?B?M2NEL2JrVWRFZnczWENjT0h3ZWozcjNpbUFrVnhTM0trcFpXY05EUHdVOEtH?=
 =?utf-8?B?RkFjTUI5YnNFSUpnN21SRkNjeWJlblZ1Ny95T2JQYmgrcEVKY3ArNzZwOTA3?=
 =?utf-8?B?TFZ2KytSOWFrejlob2p1eXFvN0JlSERKSFMxYkN2VlJuWlV6TkFUTkQ5S2Fz?=
 =?utf-8?B?VmV0TGRkWVNkUTA5aGJuUlVLMHgzSVgvMklBNzFoTUZvS1JZTml5Tnl2SEpE?=
 =?utf-8?B?WDFPajVoNld3eTJuek1QSVVNZ1VFVFcvT0lRbXIzcjZKc0hNYjZXYnNyWWdt?=
 =?utf-8?B?SHo0NDFSeEtadTVKeWcvZnkwQUw4RDZRQmRXVzc0NGxVTENNZS9Zb1ZZSHFy?=
 =?utf-8?B?WEptdStZWGxSL3Q1V2srYkZmNFhhc2JFL1phTS9LQmFMSDFEdGJtdmgvSEd5?=
 =?utf-8?B?NUM5TDI4YUVTRU1HT1B0QzdhSWcxaFFnVGd5dEl0M0NpOHJSSVlUSUYwVENF?=
 =?utf-8?B?UndObGJXY3U1S0w3TTRETDZwM2JCRzEzZWFOOWhEdTZwTUJQMlJYMVZWYmVm?=
 =?utf-8?B?aXdHSHpCRVpnT2s1MHUzYWtpRVhrL2Fvc2NEUHVFS0l4SlplcHdkNDdoTGlw?=
 =?utf-8?B?OUQ0TVl6STdXb1hHN2tjODVxOHVRTXBxTklyZjlhdWNOSTU5NkRBc3JkMTZm?=
 =?utf-8?B?dThYVmp0R200aDBrRWpWR3h0ZitNZVhjSWlVSmQ0QUhIdXZnWUF3UEJEUEtI?=
 =?utf-8?B?U0FiL1JGcmk1MUxjelJlM3lCNVJXSnNMa1ZCZFBwUktBU01CNnlJSUxBQlg4?=
 =?utf-8?B?NzVoc1Q4d0RqYTlreXBVNCt1TnBGNzVZWGNuYzNWWmVTRWtEbTJERTRqSVhu?=
 =?utf-8?Q?W9dvL5sO+ZihQ7Ed/PjcwjwO9mLnEJW6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTlWblVxeFlUbTd1Rk1nWnp4cndUck05VnI2VFFjZG5QV3FxL09zTE5vK2Ry?=
 =?utf-8?B?RDBpNmp4QmFtazErb0dybUFwam5oYVlhM3M0R3VkNXdCWFZkVWxObW9YMVBz?=
 =?utf-8?B?NVJYQ3J0cG9HUmFnS0xFZmRIM2cvSHdJT09FTWd0d1FLRUdVaVdMVkp0YjdP?=
 =?utf-8?B?b1U1TFNxSTZMbkFxdC9zaHN0TUxWNURkbENMR2NGQURJUHZQaHNyT0F5cm9l?=
 =?utf-8?B?bUtVMFBsaWw5cCtaVkExNEpicVJhUFpNeXVhdzZ3YUhySW5laSt0Z29Vb1Rz?=
 =?utf-8?B?cDdMZzdkZW0wUHF3K3lMMHRHVFZBRURZUnYweDA0ZGdkNm1ZMUpERHgwR01s?=
 =?utf-8?B?TlluY1FSRm9ScHdMTThMUWJRZmhMaXhWNCtRL0ZLQzFhd1JmSkNlWm5WRlN1?=
 =?utf-8?B?WGEzejh2SSsveVEwb1FHd01KanpHT3hpZVRuY2pyNFJRcEp0MUhXN1NOU29x?=
 =?utf-8?B?amtYbmpxaWJVUXdzbkhqclErMm1zVGlPZ2puTWRESFlPTHVqY28vNWhtMkpP?=
 =?utf-8?B?TTJNSHdrcDdOT3dlTWlIelZNRkZaNzMyZ1lSTTNScWVzMGNweElDZWJUNEtF?=
 =?utf-8?B?SmJuQ3Y4Tko2d2pkODJ1ZVdYcXRlMmd0K1puWUJlS0E4dE5PWGk5SFNzQ0Fv?=
 =?utf-8?B?eVhEWkFQVVU3UnduMXVrVmJLb0tzcEt3M2dNREo3RFhkUGh1WStYRGtiekg2?=
 =?utf-8?B?akY1aU9OTHp2aS83d3JOV0NlTkJ2V3pGcFA3RlF4L1VyOVM0Q0owQTFqT3V1?=
 =?utf-8?B?dmxLbGNoOHo0OE9oL29nNzJnVk1ieUVsTjJWenRMVTNkUUpvc0VCYTB0alJv?=
 =?utf-8?B?RzcvVHZFSUZ5d1p6ZTBhb05NazR3V2ZCOU85RTlyY0o2Qko5SDcvL0RVTExJ?=
 =?utf-8?B?VGhoUXFGUjhxcmI4MGtCbUVZRVBqZ3ZVN0hBWEpJV002KzlYalRIQTFYNDFO?=
 =?utf-8?B?ZFA2b1RDdnN3aHNhY2ZVQm1YMEE3T1paZFkwNG5leHRvR0VxQURRVDlpajJJ?=
 =?utf-8?B?V0QvdEU1S1YvZFg5U0pqQ0MydVR1b0pMV0pOT25UaTB6ejExcG9GYlFGQTY0?=
 =?utf-8?B?NUxnTkxRdnU1VWk2SGdpenk2WWU5dHZxdUY4OHBjUGhXd1gyUHE0dXpxWXk3?=
 =?utf-8?B?c0RsUkVKK3lQSkxUYkxXRmk1SWtmazVpK09zR3gyWW5ibno3Nzlianh6QkVE?=
 =?utf-8?B?NWRnV2xDLzZQYnZMMy9hclV6UjIxUmxWUHJpMHlJYWlZQkhkdkNGNDMyV2NG?=
 =?utf-8?B?RmpZQlAwOUU4aklPREt3WHJ6aGQ1YXNkaE1DUkp2UDh4Yjl5TE91WjZIM2sr?=
 =?utf-8?B?VzQrTm9oNmthVVloSys3STJsNUdjZXZRNkV3M24wUUd0am1jTVc0aExYY0dt?=
 =?utf-8?B?cnFDZmtzb2puUXdxWUprYklKSmNNUmJtSmV4amtqSmQ3VndUWVNkeTU1YmxW?=
 =?utf-8?B?NFU2aFdjaDl3NnRHMjI3QklGazBsbG12eVhmanRnQlVyZ0JxT0JienBqNzhx?=
 =?utf-8?B?UDNXWmROMlZtNkpNRXdSYzBNc3l3RlNKMVhQYmd1VDF5L3pQTGFuNTUwUDU0?=
 =?utf-8?B?QnlHSEdUSjFiaytUeWRYY3V5TkFMakhPN01reW0ydGZ6NWd6aW96N01EM1A5?=
 =?utf-8?B?bTBTcDYvT242ZWJxNUh0TFYrSFJHVW1QMXFlOVIzUEJoUmd5L21yczFCY0Nm?=
 =?utf-8?B?amFKU2VoNWxpbE9mTUF4c01kaDBFVGx0SDJtbkhQOVVrNnozMXNQOWc5VEhS?=
 =?utf-8?B?Y1BTU2F0eFNHanliU3ZCYytXNVp3Z1ExUVQwQWdWaWU4MGRGWDRNMlliNHVv?=
 =?utf-8?B?VnBIS2tYaEJBNlRmWldiOURNY1diRCtTVStrZzBKRUJqa0JDenhad0p0STk1?=
 =?utf-8?B?cUdwaU9DOFJUR3NCUmlYRDl0NUJjVUJrNG1sd2RtTGE4MVkvQzJuMm1ETnAy?=
 =?utf-8?B?WnRRY0RXTzZyYTgrT1hRd0QxZUF6MWRnM0FtU3NhaUZwMmVvSW9FOHJGSkNQ?=
 =?utf-8?B?NVhXaXZRRU93eEtJWkd2VUFjcGV6SDJMSEZzL1B2MW9Ha2Y5aE9ZYy9NeXBC?=
 =?utf-8?B?VG1iRVVZK1FvbXB1dkRya2xrbzBnN0gwMzBjZUxDeDVpR1AxcklWMkxQMjFZ?=
 =?utf-8?B?L0tGYjFtamtVRG5uTGllNURKWEV3S1p0a0dscXZlb0YvcUZFdUZLb1p0MFRF?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e3df7e44-b902-43c3-b1b1-08de114e1087
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 09:33:31.7371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqFvFWGyg37dxnPTs5YSAZJbjYGxiwEwYDBnmqa00UthY+6ELcz9GltW8g2gNwlWlZpNNSSQV4ajuEGCuI+DQnrKzD1UxCILIaupjCGIyCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7762
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

Hi Tom,

On 10/21/25 10:25 PM, Tom Rini wrote:
> With the addition of general text about how the return value is handled,
> reference that while retaining the additional information about setting
> $seama_image_size
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>   doc/usage/cmd/seama.rst | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/usage/cmd/seama.rst b/doc/usage/cmd/seama.rst
> index 17fd559f4856..a6b00f32902e 100644
> --- a/doc/usage/cmd/seama.rst
> +++ b/doc/usage/cmd/seama.rst
> @@ -56,8 +56,5 @@ The command is available if CONFIG_CMD_SEAMA=y.
>   Return value
>   ------------
>   
> -The return value $? is set 0 (true) if the loading is succefull, and
> -is set to 1 (false) in case of error.
> -
> -The environment variable $seama_image_size is set to the size of the
> -loaded SEAMA image.
> +Along with the general rules for setting $?, the environment variable
> +$seama_image_size is set to the size of the loaded SEAMA image.

Maybe add "as reported by the SEAMA image header" as that seems to be 
what is reported in this variable reading cmd/seama.c?

Also wondering if this shouldn't be in a separate section like "Side 
effects" since it isn't really the return value. I'm thinking 
doc/usage/cmd/fatload.rst (and a few others) could benefit from 
something like that to explain filesize env variable is set automatically.

Cheers,
Quentin
