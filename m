Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6360C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 09:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3051180756;
	Thu, 13 Mar 2025 10:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Mqp1yWwo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E81680756; Thu, 13 Mar 2025 10:37:04 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F24F281760
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 10:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeFHAi4WyitutuaTLog4Exhm/P7GXPwb+ZRKr9INWFXqwN5p58tKoaqdVXr+fSmM8fiUL6erJvqcaC3wcOgF3HnOnYhEMw+tukGeYOQSj7HmUre1s/MrCYpCd7lXav3LYYekyW0zoSkr+cRi0qOMLOUKpzIIq0wvWSeMfGcgGpuAMDXICa/FoX7oK5stsiWnGBpYCzH0Cqf805lka1b2dpXxttcnPh1pP1fVePTU/AQDyN79kpy1PIO0SXXONA4r11jAS6vL6lX0jP0g13TLKFYy675Lf/fQ7qyWUNY4nPpFUoA6s2SsPMrCySazpQjiEEoVrjGtKKHi9Sy8nr2J9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZHscJwn9uxlVLsYBKA4F5Dm1ETLbRSW5Olneq2xTy4=;
 b=WbY0Oj6Ax1dU4g9H/TD+jhLiIH0Q9D2CTudWUwWlEezcMlu/17+kjATTrLFlu4JUpYbBa/DtXsMoSLQIPDmPN41Bz2NsvLzuetOMCSXvozRxrn8/FQe7YDWzj6wAAxCpdG91aoNfC7Om3B0unCt++xiY47M7fmfJq7wUVvWRRkfDRPyaUyK27x6hVzhEgE1n0MNEuvFeJ8XMIVhhxaykM4dT7j2WIwwRqejwUb3bT+7Nv65BaEYETbAEUZxOLb3zPuxkQ/piDq6npD0NrzsfdtkEpbDCVZndV+bosOaeO4Yqvx9ygD7ZMbPIxv03hUN5xQyHt0+kDxKYygtQWvuBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZHscJwn9uxlVLsYBKA4F5Dm1ETLbRSW5Olneq2xTy4=;
 b=Mqp1yWwor6KOc9s20qg7uhr3MqJFAUPWdi8CMWbL+2Z6EB5irbC6j8T0hnS+mXeJjY1A/jmT5oZUzuKRTzqtZdEJsDumEkuevx/FTFKG2xAYkbzHpdalH0QJw6PlW0mmseFGmZTBeSCXZuwQLvWVdnr4+XLr7QvocOFvwqhaTSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA3PR04MB11107.eurprd04.prod.outlook.com (2603:10a6:102:4b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 09:36:59 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 09:36:59 +0000
Message-ID: <4a07ae63-4f94-4caf-aef5-68db27d0967e@cherry.de>
Date: Thu, 13 Mar 2025 10:36:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] common: edid: update timing selection logic
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
References: <20250311073438.13428-1-clamor95@gmail.com>
 <20250311073438.13428-2-clamor95@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250311073438.13428-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::10) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA3PR04MB11107:EE_
X-MS-Office365-Filtering-Correlation-Id: 33171a9d-daf1-413d-de95-08dd62129a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHFGVkFGQU95aFRxSmJKUGxHZjcya0JpUE5Kai9PV2FVVGdVc3NrSHA3SkJ1?=
 =?utf-8?B?VkdRMk5DMm9aMlEzM1FPNFB4UWptTHVOcHhoQzF4RjFZZ1VOMHBQekh2dGlV?=
 =?utf-8?B?Wnh4OEIvTDQ4MC9MbTFQN293ZXlmaUNicXhDNjU1S2pWbEExZHFoTDlWTUc0?=
 =?utf-8?B?Q0xWSlpTdVdRL1NoMGdNUmR2QXVjTUsyb1dkSGRsZG1zRktneVFtWnlhejRK?=
 =?utf-8?B?dTBCS3FXSWx3QkZKU0JjUHhxMzNRVE1iUFBjL2VlazEyMGExNUpYNFJoNWpY?=
 =?utf-8?B?RytFK2NqMFZ5YjJsanlFZXFTVDZUVFJpV0FINTVlelQ5Ylc5RWlkMUVIa2xO?=
 =?utf-8?B?UExBZEVCQnZEcW1UWU9rck9xQXFlK3VUbTNrVFdndWdTZ0Q5TWJmelZTSXBi?=
 =?utf-8?B?alRYaWFOcWZSZE1NWXFkTDg4UllKQ0lvbmpXRWlUMGJTTGdFSkdKbHN6RTFS?=
 =?utf-8?B?WXAybHBKRDlGa0Jxa1N1ZXR0Y1BaUWpvdDN5Wk5BYUpjUkNNWVhiWkFjeUJG?=
 =?utf-8?B?WnA2Z21nMGpXSW9EZUZIK01pOHVybkRPeU1wcU9MVmZtNGsvZk9JSThwaERx?=
 =?utf-8?B?cHQzMzBEbGJIamg3Mjd5QUN3dGU3TEZHeWFmQjRwSmJMUE1iVUhIWkZiY1Rx?=
 =?utf-8?B?R2o1VXEzaGJzQ1RWTlBYSmRDSHFkU3F0bE1kVVZyZHJQS3k0RjJXcmRWd215?=
 =?utf-8?B?aWxLdGNOUjgxZU5vR0RubE9oQzMxTkNEM1NBSVdTOTRuSk0rOFdTUTJUakVX?=
 =?utf-8?B?Vi92dS9yNi9TaXkwYWhqYys4TlF4NUlOZTB0TG5sYWh1NjRBWHBjWlozVm1R?=
 =?utf-8?B?c0FIYlBzdTN5RXBVTTNsUzEzenNqMnRPQ0NMR0JRY3lpQ3BPQ0dna25vTFow?=
 =?utf-8?B?R2U1bVMreVFuUXVJOU1GSEZMOGlpTmpQdnYweTl0THdiL3kxVXNodm04NXBT?=
 =?utf-8?B?bmgrTDBlSFQ1N00vYzQrbEsvdGgwbCtQUG9Gd0EyN1BkeGtienN1RTdGRlJt?=
 =?utf-8?B?U05EZ0hCNTMyT1ZmcGkzNW1wM2xjM3V0d3BFMHdzMTNOdVdCd1FlMWZaelhy?=
 =?utf-8?B?bnJmTHhBa0lDSmhES2NvSFd6bjlDNXZ2M1pXa2VYVit6cU9IYStyV2tTVWkv?=
 =?utf-8?B?SHJGTUlYTEdBdjRaWU83dE02R1B3THN0amFhN1RlWVJNUEY5SDE4a0lCMkU4?=
 =?utf-8?B?Z0FmRDU0bWIvMXJIMGR1VkM2eHU3Y2NHSnU0VVl6bTk5N213NzYyQTVwT04x?=
 =?utf-8?B?S2QycjJueENvR2hjUE1wODJWeWVKUy9Yc2pwZnJ1VmNxOGQxQ1BEbGdiMWVX?=
 =?utf-8?B?S1dSWE1Gc1liK2swdllZZ2N2Qng4c2ViZkw5WTd4ZjkvNGk1RUlCTXRhZ1Q3?=
 =?utf-8?B?NlAzMkZlRHZVelFLYUdyQzFmN2VpbnhiUFJ5ckExNllpZ0RHakk0dHBQNVRO?=
 =?utf-8?B?MUVsbXowUUx2cmcrTUduejd5aWdyUEV6N042YUxOTnBTRmVKOUdYN2M0eGly?=
 =?utf-8?B?NlNzNURsR3pKa093a1RJdXNCVU8yWU5KUHhJeEdyS0pVS1BxaUVoUDQyakhY?=
 =?utf-8?B?UDk0SU1Wc2w1NHZoZ05tSTY0YlJSUHJxMzFKTjZZSU5JV1pwNDhIQnNHT2ts?=
 =?utf-8?B?TURRVFJJdWU5WU50YXdORm04Y05meFdMUHZ2TnFVVGk4Rk40ZjIvT1JFaXho?=
 =?utf-8?B?QU9QbnFaN3JZVUZmaDZrVXR0YjVXclV0dE5qSjcxYVFqUG1vUDVkL0tVZ1Np?=
 =?utf-8?B?a0tIVElwVUxPR3MxalVNRlZneHBKbzcxSGJaNTlHK21xZmtET3pMaW8xeW54?=
 =?utf-8?B?UTd2aVdwUWRDM3dTVG8vT29Ob0VGcW96VEdTblYxWlNnWGRTa24vckttVmlV?=
 =?utf-8?Q?x/YGmXhfFwSa7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTJsSStPSWgyY3FDQWsrWmlrYStLMlgxNHE1THAxVGVsTGo4dU9WMmFSUzhi?=
 =?utf-8?B?WkRQb0diaVMwWjNXRE0xNjVJaGJTbEpEbUxDaDdvRERDcTRGWTVTWGltbzV2?=
 =?utf-8?B?c04yVHBKam84Znd6bWVUSUVQQkZxOGxKYXZtYVFGVVkwMnB1QUZRZnlZeU9j?=
 =?utf-8?B?ZHljc2dmYTVuU3NJUWRtSWQzZ2lBNC9DbHVoQXBKcEp3ZGo3NEJ3MUo3cHhq?=
 =?utf-8?B?RUNQeUFSNXdhTVR2TU51dUZ1TzFOT0lKYzBvcGR6QnpJZjFEU1hQWHNjT3dr?=
 =?utf-8?B?Z01vRDFnbXU1azd1L253OFJGSmlUOEVkbE9kTnhudytaVkN1dTlLYWx0ZFE0?=
 =?utf-8?B?Q2RtTEpOeUd1eFhYd2JKRnVyaGZJZ2pOWTE4dEI1MVJERFZyRFVtQkJ1QVo2?=
 =?utf-8?B?WGV1MzNpVllJY0FsR0tBSE5MVjRDNjUzRW9oUVoxcTVwT0s2Vk8zRndOSkUw?=
 =?utf-8?B?TzFIemRWU0NlU3RqeXdQZi9zRWNBb3BZRlo3dDdyMGlIOGptZXFBa1dqWXRk?=
 =?utf-8?B?R0U1alN1bytKTjRCUVBrdzgzNE4wWWEvMWdpZnRQMlIvdDYzVUMzbW1CYzBV?=
 =?utf-8?B?NjNpMWVnTFFteXh3WGRLNEpLQjNmM2d3eVlzaEI2emhPbXo2N2FNemkwZUE2?=
 =?utf-8?B?dlNpYmZVSTc4aFAvK21zWTNkeDVIVCtrR2FHVlFBL1VNRFBBNmFrVStSRXR0?=
 =?utf-8?B?cVRXQ3h0c0NkT0tkMUxOTGlYVzdVQ3c4THdFeFRaUnpXYmRRbFVTZTNySU5S?=
 =?utf-8?B?WWlRRllGdnJ0WmlnbjdZZGtXWisxbkxRNmt4Yk1KTW81em9iVVhleE1XamNX?=
 =?utf-8?B?S1ArcEMxY0x3aGI1MzJVaE5nUXgvWlA0Mlh2SytoREZBNFpTNlh5ZzNYVEN4?=
 =?utf-8?B?cFVNS21LRW5ycS80bUswbTJWNWpHUWdqQ3hha1luT1hFdmpkN1o5RXV6dHBI?=
 =?utf-8?B?Z09UUUZmclpmdTl6RndoTjNHc2pHcWJ4YzFGczk5aDlyUHd6Y3Z3Mnp0QVNh?=
 =?utf-8?B?ZkxmeUNpeUpaYUhWQmZQVXkzUXI0TGNnTDJxMk0zbi9rMWhQMDBRZEdEclhk?=
 =?utf-8?B?Qkx6NW1iQU4vZ1lPMVBlYS9jRGNlcDZUYk9kTVREVTdKNkFDbEVlRU5DTlha?=
 =?utf-8?B?RjZaamw4ZUpyY2xrQ0FkSmhJM0lBM3d1NmVnWk9hSkR6TTQ3encrSi9hWVd2?=
 =?utf-8?B?TUFNcVFrVFpFbmVOY0dudTNWVW1wMVRzRlFIQUhvQkFXekFINzhYdGRrQTNP?=
 =?utf-8?B?OExYT1Z0Q3p6MjFXbGZIUUhIV1NpS2wwZ3FrR09jc1lwemN6Y3dwdThxZEhY?=
 =?utf-8?B?S2dnakNsa0xXWDBsWDBjcThGVmhoQlBtNDNUc3NwNUIvd1RuWnA2cHM5WGR6?=
 =?utf-8?B?UmdIRUppSzlWVkl0cEZ4Nk5PejJ3L21INUUzSE9nUFZnMkh4cEF1UjBFK3JL?=
 =?utf-8?B?TWJVLzVqL2RhMnViazBUUUxabWFjcTNXNU5ZOTBvUC9OdXhDMmFzMi9NRFF3?=
 =?utf-8?B?THNMV29vYTBTN01aSExpMmpkWHdGWU5iMzBwRTRIazhNY3ZRcldnMzlpQ2Vo?=
 =?utf-8?B?UlZaclkrZFpXSm5Wc3VBaWtvZTFsVFlUL21hdytlbjdGc3lBK3pZeVZLcFRX?=
 =?utf-8?B?TUNDdFB5emhxTFJjUnNqbzMyZHh4N2NBSDhmQVZYaWRMZjFpWjNQa0VuaWwy?=
 =?utf-8?B?cllaMmZod3ZNdW1CUm02djZoK0xZb1VWRFc5RXd0dytUdmNCNWV2MUtDNXAx?=
 =?utf-8?B?V0puYW9jMzBxdTVpQy9YaGd2UHF4dnUrUWVRa09lWVZRM2JCdzlnV3hpcWxR?=
 =?utf-8?B?N1I4TU5iOUpIL0FzV0pzWDBPYTlRSUJLbWUxeDUwL1FLWFg3TncyM0dlcHlR?=
 =?utf-8?B?UFRBWDh1aUkxVjV6V0t0OUpRSzBmV1ZoMFNFb04xTlhPVVBaNTVCNHJoUm8y?=
 =?utf-8?B?WlJwTmg1cTNnZ29jNG1xVG5JSCtpWGhLZ1phNFlSbHVkeGwyU1NYeC9jak9G?=
 =?utf-8?B?M3FOUHI5bXlRYWhicFRoalJleGZ5MDl6VTVkYjBnQkdaSmR0SmxLQXUzdGxT?=
 =?utf-8?B?NGZNdFhRSlVnaG9waEYzeC93M3dZdmRIOHhnWnA1cmdDQVk5SHhFd3cyNjhj?=
 =?utf-8?B?eGlRT3E0R2RTUHpWZkNObFFZS2hzcWd4YmdIT2o1Y3M4N3Q5ZmptK1VZOHcv?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 33171a9d-daf1-413d-de95-08dd62129a3a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:36:59.4231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNdWrv08PCr5n5kThF9VswbpQn8Py7tENWE9jrjbT9HHlQQGcq0gC/jURZMVJadG1nUcLyo3y6cZaCL6jm0APBCdHk3trr1Vpgf28qoIPtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11107
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

Hi Svyatoslav,

On 3/11/25 8:34 AM, Svyatoslav Ryhel wrote:
> From: Jonas Schwöbel <jonasschwoebel@yahoo.de>
> 
> Older EDID timing algorithms relied solely on detailed timings, typically
> optimized for a display's native resolution. This caused issues with newer
> 4K panels on older hardware, which couldn't handle those high resolutions.
> To address this, the algorithm now also considers standard timings, offering

Just a drive-by question here, "standard" as part of "from a standard"? 
 From which standard? Like where did you get this piece of information 
so we could verify, fix or update it later on?

Can you add that as a comment around the array in the code?

Cheers,
Quentin
