Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740D3FF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 16:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E03B883BC4;
	Mon, 27 Apr 2026 18:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iDWyTsNl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD0578416F; Mon, 27 Apr 2026 18:03:04 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E29E83AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 18:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BouHnIisEjaQzpXGLzmsGn3tvh7MY+35OS1bH4FV+WzfNZ/SG3n9+bvvOUXRND+cVr342Ku1JL+yxypK910Zfab40/h3GSKOhv4AJ3NG5ipPHDAzLPpYto3IxTp1ut2XVJuMfD7jm7+IfWfoXcJimJxjJwcr0MA1eGA+bDudHlZh73wlhYlGoPwXHNk3lF4buBw59XYDWs0BM1sXuE37UF4QEqxRjIMVumpC5LRLHmAAMFp1xsXZZXx7RQTXtSJRpofxqtnIaIz4mkxd50YmlSRITKOr44Ag8a5UJJCq/arfGtRpu74MeEn8LsteXfZkBdIuzkzY5cEZK+MEWGyT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jJXRDCVPVPzrW6UYru4uae2OQof+DBiUK743LuFxQE=;
 b=BMMzU28kX36P86tTbJJjdsmCkRSu1cvrjPJDJpUkSI3A1x5rKDbSQjLo7RguljBxepxyHcJuWx9eAWbTU/pOiulOvAVZHmNdyMYXZ+3d5OfRTdTgbSaBt0eN6QOL2IaxwRwiybot0PotK8CqWC2XKhI+fYOX9LCdUxnAyUOH0RFtbn5dL+WNCZ+Ku5C3damCr5qLPhzBwLD2T4HWe5rrb6Ha7aU1gLWfxl223bAYI8vdvVqF8aPbQgYkIgjqKhVXm3fRqemOems38EH9dtaqfWir/+3jVKVD1UTvGEleqJdVN1a3EcP+UhEJOIA5/gJ1PMt5uM/WouWVEnmdGv40hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jJXRDCVPVPzrW6UYru4uae2OQof+DBiUK743LuFxQE=;
 b=iDWyTsNlCSa7X1PIj8laAYKd0lpVGJDbm9UI0glPJVtmGYb6pzeAYv7WBpmtNWGHBMAW3iHLYsjhoLxkmCgizV1NV3+0nl23uhcraFSwBJoui8zjaXU7S9JSkzAAq0ChOplEOOOAzhx3oVuINAd7z3Gj7rdIHULFXWMFBcEzFgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 16:03:00 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Mon, 27 Apr 2026
 16:03:00 +0000
Message-ID: <a8d658e4-68b0-46d7-9b00-34155ddb5c0f@cherry.de>
Date: Mon, 27 Apr 2026 18:02:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] image-fit-sig: require signatures
To: Ludwig Nussel <ludwig.nussel@siemens.com>, u-boot@lists.denx.de
Cc: Simon Glass <simon.glass@canonical.com>, Tom Rini <trini@konsulko.com>
References: <20260427150409.400914-1-ludwig.nussel@siemens.com>
 <20260427150409.400914-4-ludwig.nussel@siemens.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260427150409.400914-4-ludwig.nussel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::25) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AS8PR04MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f06a95-a927-41a0-3496-08dea4767401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4I5VX32ItIgAAlDL4PF8FylI52gW8IHEgw/bwaiIqjg9ctXXw4wilXPxEEZlLTXQ/CMr5mZF5o9GLEICs5kfMXGBpTnFUsfAlraS/c5YeHRK/ddyVDiXapgBQ5G9j8tMY4IKJzWRLxo2c0HS9ve44iS7YgpOO3duIwMc1l4TZQFtOY0ewrH92Uk7pX5PwG9Xup5mOpmTd/KEQKLi+aKCpM+Q6PrquurcR2tSfAuj1nsi7iJh6iEthopOqOFvgtHlNuux834WmZQYkzYZN3Ol/KA75314LdfR5+A+tZulMGWG5vGf2JFmImg2fLfNDUX+xFao6BK+BTTE7KzszObxs9flxGEC0P1TB5YnMnvHZZRUDmIO8ZcOp9ZaA7ZmBmmDsk8B7YEY5S8Ep5BKg7QWI4/m95XSFl1dOfcZqyaYc98Zz4LicHQ4k3MZuug/4xLbOxHJ1DyNHT40w9yXGIiy20vrMPIa8/Sdopu4YD++oxvQxayZDUlSxIvKxHTIy6I04P1DT7gxQNGVRk3QuFOUGqYbVIxRpYiWzq2tAJ1Yh7FQzgK2ej6aHrQ5Iz9XY6b6d6Unfpm4T1gkDKG0BP+6jyR+LZh812578DVP0rTVDN9M4NBJ8cXHW6R1OGfvxSYynWCxRFQlrN1yGXyUo9/sascLp4qSKL5dFCvBPE/l6k4/X/JQ8t5tU5ifgBift4vtGyhVNH8OM480y9lK89N/7r/OpF5M/oyKt3/ekWmr/pA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXUvTTc2RXpnMWVlVUFkZ3hUcWtGWWFsYUJKcC9DVHcrYWFLc2tIVFI0U3Ba?=
 =?utf-8?B?UHhYVUd5bHNPNHRBT1J1Nk1Pc3RyZlFrOENHTW5FSXpGRUpLVnZNZkd5dEVx?=
 =?utf-8?B?VmREL2NBYzVqcUVsUHNaQ3lwaVZUK3U5eUFUN0Fkc3FZSEZQWXo5TnJtd25m?=
 =?utf-8?B?TlVleDJzMnF3aWU3Z2Z2WmxDN24vcUk3N241UXhocFNwZ3QyZ2dlVzNUaEhj?=
 =?utf-8?B?eTJjUDUzU2ZuVTh4c3BrTVQ3aFJ4cnlWTGpDK3dLNDYrTSt3ZllOY0dyVGlR?=
 =?utf-8?B?NG1IWGxZcnJncXZpWDdJRDB6V0hyWFdKSVlRVXhMZW52clgvdGJzMUJlaUI3?=
 =?utf-8?B?VHdueUtEN1ptWnJlNytoZkhFSkJHdGdteGdQUWk3VlVQeFRKU3ZZVnpvcDls?=
 =?utf-8?B?aE8reUpFVkY2ZWVhLzA2YUZpUktuL1d3MGozeDFHaURHZEszQ1hSbW94enpM?=
 =?utf-8?B?Yk55ZGI0WXZWb0xvVFRRRWFGMFNXUGI4SHRVL3FJRGpqNk50d3pCZ0FyUlFv?=
 =?utf-8?B?NGRsVVYxUFo1S2Z2UFd6MjhISkVkUlRsVkNmTktHRHBHSXRldXQzUW8raHJq?=
 =?utf-8?B?czRhVXJZTG5vb0E0OGdjSXo1M3BMTWhSbTIyekFqbEl4ZStlNVp4bWZvMjVB?=
 =?utf-8?B?U2ovdHMxRkl0RVMwNXFxU2twMUZ1Zy9jeGhiRHBJVnNERFJwbmF4bGRuZVA0?=
 =?utf-8?B?UEtyVlNPZDVESWorVGxrS0VYaE8xaG9lQ2h6bEZQTk4xbEMzUjdvVityM0Jx?=
 =?utf-8?B?RUREUEN6SVdaRythNE51RGtrdUtxR3FabjN6UHhTMytwUUt4Ty9EUHpaeENo?=
 =?utf-8?B?VWR2cStiV3JkaUd0Tmg2NjFONXF2OEVuYUlzOFZ6VVRiaDFSZ04xb0M0bVor?=
 =?utf-8?B?enltS1I0VjR2MlA1VU5kTnRFd1phRHVJUHZvR2p6MzRIRjZNQ1ZzbUZZQ3FO?=
 =?utf-8?B?RE1KSkJQbHdTa01SNmJXd09NNEFRL0dHZXFoazNEaFB3QVllUTdCZ3lsclJ2?=
 =?utf-8?B?SWZKM3FwRXo2QTNtbE1iTGhzZ1VyNmxKTFI4N3IvTU1XK0tkL0Q0a3ZiR0tG?=
 =?utf-8?B?NUNERi9obHJHU0dYbjFqenUzTVlPSVRmYnNoVkVkR21jbmRrZk83aTNsRytm?=
 =?utf-8?B?aFNLN1Z1UjEzclZjT2hwcGJNOHk1SU0wUERwN3Fwck5tcFNWMFhOa3Ixcmd2?=
 =?utf-8?B?UmxwTXcwZUpJMVB3dWxNVzIzQllXQ251c2RlOVhSamZjUkNsT0xOYlRHM1Jk?=
 =?utf-8?B?S05KNFo5YStKOUdRYkgrV1dUT2RqcUxGbHVWTTA1YytwUkV4M283ZWo5aCtl?=
 =?utf-8?B?R2dnb3pYZUJzRy9EbVd3MTZleHllWUU1dks0OThTK1ViOUl1cTdBclhBVTg3?=
 =?utf-8?B?NDZadmJ4Ni83QUxIaURoZVBscmg1WFVVOC9TMXlTaGJmNmkyQ2laZUdKa2ZP?=
 =?utf-8?B?Ujc0M3RWV1FBbE9Icnk2TFN2MG8zQUdqSXZuZUUyZGxjVGlSbFJWbjI2bUha?=
 =?utf-8?B?Nlhyc3A3RnNadEpJS2wwVTczeDAzZXhsSldpSldoc2hXQ0ZHdjZIc2FaUFVV?=
 =?utf-8?B?MTN5OHhPVVBHUUVwMjYvZmVKZ2pKRXRFWDU1S1Nycm4wYUNicTFsODFCRysw?=
 =?utf-8?B?RHVmb3JzMkhraDJ4ekRMTWpOQVdVVm4xeUZzdWUwTE1RcHR1am0xdnhBeVpy?=
 =?utf-8?B?cHduT0EwQmRad2hYd2FqcHVRQnpXNms4ajdyWmYyLzIrMGhCSTA5ZEdhdVF6?=
 =?utf-8?B?MVdLWTZUZkovRjdRWG83bXdIR3dSOWJxcDl6cXNscHZENVVuekV0T2VqUDM3?=
 =?utf-8?B?NlpVcXRJTnZ4V2JVcGlJV1JuNlFNNzF1dlhjT0xEZ2h2MDBmR2ZodkZXcGhT?=
 =?utf-8?B?QW5kU0hkZHg5MTNmVlp1YkxmQmpoWjhkMGNjVks2ZEtKREJKR2ZKWkxiazVF?=
 =?utf-8?B?UFBzU1JxRktwTUJiM1lmNTF3SHZSVFlvU0hoSDJTZFlYMHVCMjczQ3M1ZnN3?=
 =?utf-8?B?VGpBdFM3bnFKZFZoRkEyemhDbzkxMGd4UFQ1TEhPYXhIWTNKUUZZYUFibUY2?=
 =?utf-8?B?KzlkcjVYZlRjejR1aUtkQlFaQjBzZ0R3NVFIeXN2OHBMSGJwejBhYS9nMGMz?=
 =?utf-8?B?ZithSW5uZmJKY3dOLytETjBDa0NRcnkzRk5DYXUzSDdEcE5hS0RMeFFnTTFJ?=
 =?utf-8?B?eDA0RG9xNHc5M09tSVNvRjJ3TXYxQi9Rbm40Yk44MXNVNjFDREcxSmZkRG1o?=
 =?utf-8?B?YkdHTGhyTzZNR1RmZVVTTHM3d29rM3VYRzFBOFN2bUQ2YndQMnRSdEIxWjFY?=
 =?utf-8?B?WUpjcU4yaCt2eHRFOWVXUS81cGZTaGtkK0J2MkZDd0h6ZWhqaithbnltY0p4?=
 =?utf-8?Q?JgMT9aG5R4mdW5U2szWjSs0U8cPVwLUw3koPY?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f06a95-a927-41a0-3496-08dea4767401
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:03:00.0421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMtqRxq9YQv6RiFYAKO8oGIiwESLRaxpca4+30m/EkmmRa/IJtA7DqRRfr69THNOTdlYR/siblPCyeNafu68qW+1xnUOGqzz4O6sQpk5pkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8897
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

Hi Ludwig,

On 4/27/26 5:03 PM, Ludwig Nussel wrote:
> Signature nodes in the device tree are mandatory if u-boot is compiled
> with signature verification. Allowing signature verification to pass

First, it's not enforced at build time and cannot, as it depends on the 
binman FDT node to be properly configured. But we cannot do that, 
because we don't know the user setup.

You can (mis)configure U-Boot to do signature verification but forget to 
add the signature to the SPL/proper DTB. Then it'll do nothing of 
course. To be fair, I got bit by that very mistake recently so maybe 
there's something to improve there indeed.

> if those nodes are missing would leave the system fail open.
> 

Yeah but why would they be missing in the first place? It's not like 
this is something you can modify if part of a secure boot. The DTB of 
stage 1 is used to verify FIT from stage 2. You need to trust DTB of 
stage 1 (by verifying it with stage 0, etc.) otherwise I can also simply 
just change the public key in there.

Also, this isn't actually handling fit image signature, only conf. Yes, 
image signature is mostly security theater but at least we would have 
consistent behavior here.

We very much need additional tests as well.

Cheers,
Quentin
