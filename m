Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F19C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 15:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D1282C44;
	Thu, 15 May 2025 17:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UWMuq759";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 761DF82C2F; Thu, 15 May 2025 17:13:37 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6299682BE4
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 17:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVtKcSdoZlWfyawLsHl7rd+Ppi9/psHrbY1z7mqLDEknRB2h2YX0Tv9U8ggZbVGm/aQXW0bMdt9bn6xS+FaNfws+5diASKTKSi47tmYmsTtKCtDhFQy9dDrGPPrcDRpM7f+rPEBqNeBWjxUxUZGDzIVntsSpp+j0ynf2YJA8jKjtfByorRDFHvbTRTlEjc3TidIl9vSwjqkfl0iJPdRuVAslTYPTeKNSe5iN+QUCZ+3M4hL7TjhZGFvo5B0sxYSNbGobs3uaaSxj5rKwJgGZ9UNR7zmd4CNquJiYO3dMkMQY0c/RPkaRWeFV9cLRrqByN7c8GXd6d4GjrG7Y7OYqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4v3rRfKBFSblLDv1prbZkKg5P5QjKQvddlaagmFew0=;
 b=ccNRvJPNxov65AoULbKqrxtBBatmBtKFfSjE9QE3RznRxg3n1unqsZHM64VsH2t1gANlQl7y29JEjsz0+tRP3Cn0s6AHHLD10BghQnxHZegmXWNbLojiSJ3DawDFOO0HV1D86EqMUSHLNxWV7ZnlPeMc9HqvHNmXxT9ZSi4FWINmM9KslfYSXF+B4AdHjMZ3ze9/mdhdPEWEnECebVFNsfOhN2dQ2u/GgmV2yeA3cKr743HHizFKfWn3Q7492UpK3G00Vn+4mnAT5SfV8iLDpOCFXD7Lv1Y8oWhMs7VO7CXnTdyKBhfigMk24HaeuYo0QG+r5xOMllin6zcCvxY/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4v3rRfKBFSblLDv1prbZkKg5P5QjKQvddlaagmFew0=;
 b=UWMuq759TePOVsNAZNR7bp/awSpDwuOlryhqjiLSWCKwiSP3Ie2bBbpgbNAeCGUByXuDQcQdb4SI52nMs6uJPWmV4FJJKH6FLT6Qzt9YocET0xwYPnRz+6BggdD4ZJ9KMsvyPDieQ9dUzhOUp1IogsT9N18RH81GxGW71MrbqeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VI1PR04MB9835.eurprd04.prod.outlook.com (2603:10a6:800:1e1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 15:13:31 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 15:13:31 +0000
Message-ID: <b2566f6f-e650-4541-9f52-8830bbba6159@cherry.de>
Date: Thu, 15 May 2025 17:13:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] sunxi: add "fake" FEL pin support
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de,
 Yixun Lan <dlan@gentoo.org>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
References: <20250417000539.3709-1-andre.przywara@arm.com>
 <20250417000539.3709-3-andre.przywara@arm.com>
 <b7ffc468-1970-4eba-85e1-47aaced0161a@cherry.de>
 <20250421222939.69832f73@minigeek.lan>
 <e2d354dd-4be6-45b0-b263-7112b9320692@cherry.de>
 <20250422131121.7a491909@donnerap.manchester.arm.com>
 <11fe3319-8a26-47b7-873e-774140c146f6@cherry.de>
 <20250512133941.23462a23@minigeek.lan>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250512133941.23462a23@minigeek.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VI1PR04MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9eb10c-089d-452f-db73-08dd93c30d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2JMNGtzV2RPaDVScTNKR2FOZDY4SlVZR0JiTyt5UjB1eVV0czBoQVB0cEpz?=
 =?utf-8?B?Myt6cWlMYmRwWHVqclJaaGFYNWRoZ2hRZFM5ZFJ1YWdDaVB5QU5HVUdmeUtx?=
 =?utf-8?B?WndUTVVaa01rN0lBdFpUNHQzSW1VTEE1MmhtTUE2TTNNb3cvSUJkQUZqTXNM?=
 =?utf-8?B?YXh0OHVRbnk1dk4wMEtCeHg2Tlo2MlhqUnJQUEpScExTdlowM0VhSTVLUW92?=
 =?utf-8?B?L1RUZ3U2N1dhMG55TzBHRVpOa05KaFdYYlEvVUxZUndBZ3dnSEFYQlBTbmdo?=
 =?utf-8?B?SHdrTDI3d2ZUVU5SYWRGUWtESzZnaGlVV3R6MDI2NVZyLzRhSnVuZ2ZLT2Nv?=
 =?utf-8?B?Y1l2VHVuRXpLWW5IY1NLNjVPcTM4WWNMZlprMzE5ZXdkekZiV2tIbGt5OENs?=
 =?utf-8?B?MkQ3V2JxYjJ0VVNyWGdsVGhLdEN1UWJhellOblNLUnZYbnZxT1pndTVTTkxI?=
 =?utf-8?B?VEJQRGx0d0RpV1dXS05WdmpZRjBSUS9GdkRRbkl1SUtuQTlwYXpZZWYwVkJx?=
 =?utf-8?B?UlBZZGJITWJGN1Mycm9kR3lNYitaNU1uZHlwdng4bGtnZDRyMDR2bUdBeG1G?=
 =?utf-8?B?UW1YcWcrMjE3ZDBleVVUb1dMMDdiYnlxTG1waGFmaUxSdU93YTJxRHNBc01M?=
 =?utf-8?B?QSt0dXd2UzF0dHlQeHBVR1NUcHIvOTY3VHp6bWdqK1k2bEo0am13ZkxuV0VG?=
 =?utf-8?B?NkNQRklGK2l4dVRxaHlFZ0pZSmtkNXlvcExvWC83c09qeUJrZkFJd2VxcUFp?=
 =?utf-8?B?Z1IrbEpLV2Z3disweHp6V2dLc0hnUC80d3hWdS9iaGw2cWwxZk1ab1NKMHBu?=
 =?utf-8?B?VGpzdFRWZXRVWEdVMjFMWFZZaGJNajByREcxSHlNUzkzM28xaGlMY0syZ1I3?=
 =?utf-8?B?dXNKNnpnc0ZSc0hCUVlCK2tpN2puVTFvQlV6c092cjgreCtFWElDQjQxaGha?=
 =?utf-8?B?dklET3BDaG5DOS9XUHVnZWJCVFFWRmtNM2hHTmVidEdDVGhmdWpjcFBNZkM3?=
 =?utf-8?B?c0duSlJDK294WEJXSjgyRlJNMkp4NHpPNVpHR2p3WU9xWElCVUNJcnJBdnRO?=
 =?utf-8?B?MndKTElhUE5ldXRKSGpIZE1sdHYzdDJFR09DQ3V3WTQwM0VPajljVUR6aFpp?=
 =?utf-8?B?TUlQeW5xY21jRDlHb0dac2hCbGxRMkpIME5Ma2pFTm1qcG80K3BnYytwbjVv?=
 =?utf-8?B?cDRZMXNwRjdDeHRnWWhjZ01waHM4aFdENGpsL3lIN0prRjJTSk5sRDN4amVn?=
 =?utf-8?B?Z1h3SUdHTW9lYXBpVWZQMjFpWWFPMC8wYXJZMEFlSmkzUTFTQWxrNTZCUmIr?=
 =?utf-8?B?TUdVTCtmWmEzek9FdTYxb2RhUTkya3Z0MzNiZGxnMGVBZEoyeFJzWkx3Q2sx?=
 =?utf-8?B?V2FqYk14MndEZmxIRkdoTmFKRXM3V2FENk1FcHZVRnE2Uko0SkxCT2pTdXB6?=
 =?utf-8?B?VGNlT0VNaEhDTm9HTVNzd21CUW1NVEw0QTRYd2lBaUZmZFpLa2pwK21vcmkr?=
 =?utf-8?B?eElYb1R3b0trNjNCdmM5NFRXTlpPNStodUZKVDNMTGNHQXRLVXNrS3kzV2kr?=
 =?utf-8?B?RVBVZmZaQ1ZwdHZWbDB4TXkzcDhWdTd2UWxZb3VrR3JIR0lkTDNXc2h0QTM4?=
 =?utf-8?B?d0tYMDA3QjNSWVVnaVBtYkdGTWFWaDBEeDFvRUpjZ0FueGxoaytJUHRRelY3?=
 =?utf-8?B?L0FqVkg0dnBoRVlUQmtKdWtxUDlMM3l1R0ZWckFERWprM2d2L0xObWErUk02?=
 =?utf-8?B?L0hIUUloNWorZUQ4Q2FVN0NvWjlQZEFPNmtoQ0d4cGhUMDJDVEIyQ1FtZ2Np?=
 =?utf-8?B?YUJWQVVtQzhJVWljTWJyU09FcytWaEJNbWk1SjRMdUJJMnY0ZlJpS1lrY0Er?=
 =?utf-8?B?TVRZbE5oRlF5cDVSd3FRbTJISkRBYkdMclBQMU1lTklvMWRFbUhUMG0zcEgz?=
 =?utf-8?Q?Re4uNPnyygs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEZtck1ZTE9xb0xXZmUvSk1OMlB1ZGlIUGY3WUVEM3JVLyt2UzE4SXRGNWZh?=
 =?utf-8?B?L1ZCZ3djVVhXODBzZGx1bS9URGFwdlBOTkYwMWVHaUFjSDQ4MVlTK1ZZNTJJ?=
 =?utf-8?B?WlFXT0JsWW41WWdwYXlTSlNLR2RRRk40a1pOZU42NmRsWC9UeDdFZy9nQ2Zr?=
 =?utf-8?B?bUtFcTBaemFnS09WK2x1RXI3NnpEZlM0dStXeHZQQzdyOG5zYW5HdDJ0SGFD?=
 =?utf-8?B?bmVHaFcrampDZUk0Q29XYkNpaFo1VWpnOUFzdkNDL3R0ZHoxaFJyaUgvS2x1?=
 =?utf-8?B?M0dabFRpYi9vS3RuUHh0UlYxK3BTMkFPazRTOWhydDZCR1hsUHd5OGU1YWc2?=
 =?utf-8?B?aVVlbGV3VndxVzM0eXZUTGR0S2phRUNMU1lBRUNMVk90eTFGUmsrVEwrMW9a?=
 =?utf-8?B?VmZJQW1XM1lwdHZoWjlpcXVBRkRnblloZzNaRTNNb0tSbHp2dVkrTlY5RmhO?=
 =?utf-8?B?WHRuUTdScUJYY2pUMDU5djlBZUxCVG0wdzJNelQ3MHN1M09yK1ozWjZ0TEYx?=
 =?utf-8?B?SFh3NHFFZXlZSm0xN0VNYkZ0WnFNN2ErM2xaQmZnQ2ZBcTFpMEp5N1VaU1po?=
 =?utf-8?B?bFVsdG9EVUhsSXltbWlETWZjcUNqRjdYRXplUnJzbFBoVmFJdDJrbkd2R2xI?=
 =?utf-8?B?NUhlZ0FMYmRPM2tQWlhxd29IcHdVaWVKU2lsTnBYaHZqN01sNllMUWpMOUNi?=
 =?utf-8?B?bzF1RUxnTld3eTZwbVQxQmJxTTAydlFDa3o2YjZXTEFlZXRLYlprcUNlQmNM?=
 =?utf-8?B?UU44d3lyZE5VaFdFelhpN2lOTFpuUUhxWm5vdng1NG4xbmtpNWdJRGlNKzNo?=
 =?utf-8?B?dnp1QkxORHh3UUQ5dzFzMU5IWlFVZmp4OTlNVFR1L21pcDRybzZLSGVGNzhG?=
 =?utf-8?B?OUtCSzVEdUk5Q2JiRWw2RktLb0NTMDhITHNVb2RqR1crc0RKaXV0N3dlcGhS?=
 =?utf-8?B?RmxvdkFPQ1FRMkt2Wm9XZFBoSitCazB1U2YzWjJmRHN5WVdBcUdqVHZzTXZD?=
 =?utf-8?B?U0J2U2VveTJ1ank2ZzViSFoydnk0bktvMnJxQVRtZTNhQkVwUU9zWTVSeGh1?=
 =?utf-8?B?SFpQTGpWMEFoNE9EOGNIcEpJOER0NmlDQmlDWnR2T2xWbUFzMTJwNEQ0VGpn?=
 =?utf-8?B?STF6c2k5dW05T1dVbGN5MkhwVnhBWHNsQ2NmU3pmbCtCeE52UmZqV0NjbDBm?=
 =?utf-8?B?QmJCYms4MjFFVmxFY1ZFTWxsdkI1a21RaU1lT3hoTmF6U0FVSnJqTlZsNjRu?=
 =?utf-8?B?T1phZUdSUTVhNjA4YnJKR21ibGV6bTh0Tkw0SEZpNGdLYjNHZHhqdWpqSEJk?=
 =?utf-8?B?T1pjVnpwYUM3b0d6ZFRDV0lITmNEb1ZNU3FHSHRaeHdVTTNQcWJrSi93S2th?=
 =?utf-8?B?ZXNUc1JmYVA2MXBxUWlMTC9QUU45RHQ5RXpRd3JaZjVzZFY0V3VpMWJwRHNU?=
 =?utf-8?B?YlM4dk9NM0tqaGJ3MTI4cWdjbHFxSzE1TVQrb1BjMDlBNWZLNnNnS3ZZY1ln?=
 =?utf-8?B?TU5xbnc2RGtNbkxvckVWKzlkdTZYMkJlNXd3Ny94OC9HTmF3UitIZFY0SzdM?=
 =?utf-8?B?SS9YNG8yVDNFMGwwVC9QUUQxdFZpY1pMcVRuWmFsN1RVUDB2cFIwdjl5Nndk?=
 =?utf-8?B?UVM1MVZvalVleSs1NWlMZGE2blhGeUEvaUJXYWc4d1NsN0hvMTZVK1BwN0VN?=
 =?utf-8?B?WGtPb0NSRHBTSStUUEIvYm9RbWZpU2FHeFlkVFJLRWdncHJ6K2FXdjJaZXBh?=
 =?utf-8?B?cFlMak4xL3d6cWZoSXFMMzIyN0E5UFA0dUl1NDFSczNzeTkxMGxUVExPWU84?=
 =?utf-8?B?ZW9hYjQwNUE0S1ZpNllzeGRDeGQzbEhCUVplRng2azNsZDM5cFpWbVVnNkZD?=
 =?utf-8?B?UGVxT2ZOdXJ2TlVMcjl6ZXcybXBmMmlRY0t3VFJBQ0NYSmRYUnF4aHlLWWZa?=
 =?utf-8?B?dEF6eW8zZGV6eXVmQ3VVTEFsUUhIS09UNFNHbEtMMVNLYWFVUnZxdWZpZ3Ir?=
 =?utf-8?B?U3QzRU4reFJQVnJoNEQ0T3QyQURuaUtLSUF0S1puTTZ4eElZMk9nMmxleDkr?=
 =?utf-8?B?TlIwL1NveVJHWHFKRnkxL0E2ZEIxK1BJb2tPa0lpWGY0Q2U3NzZWZTJpRFVB?=
 =?utf-8?B?ZHpnWVVsOS85emJOdTFyWmVSUFh4cmZIa2d6MkMzRlhRdXk0bkFsL1BQM2ZN?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9eb10c-089d-452f-db73-08dd93c30d73
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:13:31.3341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taUVp0dGeUYXVE0KAmuEggHz8Mi/CoN9Do1+s0JCwRagUOA+17t7vT/BY2c5eyT6iD3eHVsp1rr1ERkTFf4n+iCbI6ec7jQXUnerklwp36s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9835
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

Hi Andre,

On 5/12/25 2:39 PM, Andre Przywara wrote:
> On Tue, 22 Apr 2025 16:30:04 +0200
> Quentin Schulz <quentin.schulz@cherry.de> wrote:
> 
> Hi Quentin,
> 
> just found this in my draft folder. It's not really related to this
> patch anymore, but you seemed to be interested, and I am happy to
> explain some of the specialities for sunxi in U-Boot, since it differs
> in many things from other platforms.
> So see below...
> 

Thanks for taking the time to share this with me :)

[...]

>> Jonas has started to support "generic" images for Rockchip boards based
>> on the recommended hardware design specified by Rockchip themselves.
>> Most companies do mostly respect it, so that seems to be working quite
>> nicely.
> 
> I wouldn't be aware of a "recommended" board design for Allwinner, but
> as a matter of fact many companies copy their reference design -
> probably more out of laziness ;-). This brings the variation down to a
> manageable level, so we can define default values in Kconfig, so
> defconfigs stay small.
> 

Yeah I meant reference design and not recommended design :)

I assume it's not necessarily laziness, but also makes it less prone to 
HW issues and also hit "SW currently doesn't support that despite the 
datasheet saying the HW does".

>> Depending on what exactly you want to support with U-Boot, a DM-less SPL
>> may be difficult. e.g. if you want to support a fallback storage medium
>> for loading u-boot.itb (or proper, don't know what's being used on
>> Allwinner) that differs from the one used to load the SPL by the
>> BootROM, then you possibly cannot rely on the BootROM initializing the
>> PHYs, controllers, pinmuxes and pinconfs.
> 
> We do not rely on any of those bits being setup, actually, but we
> naturally follow the BootROM in its decision process. The BROM stores
> the boot media used in a byte in SRAM, so we know where we have been
> loaded from, so can continue loading from there. But this is just a
> decision between SD card, eMMC, NOR flash and FEL mode (maskROM in RK
> lingo). We know that SD card boot must have been from MMC0 on the PortF
> pins, and NOR flash is only SPI0 on PortC, on so on. The mux values and
> MMIO base addresses are per SoC, so those two values are easily stored
> in a header or in Kconfig, where we put them *once*, when we add
> support for a new SoC - and they are also quite stable across
> generations. So there is really not a strong case for DT here. In fact
> so far the mux *value* required isn't even stored in the DT, but in a
> table in the pinctrl driver.
> 

I meant if for example U-Boot proper stored on the eMMC (when the BROM 
loads SPL from eMMC) may be corrupted, and U-Boot should be able to try 
loading from other storage media, e.g. SD or SPI-NOR. If you don't have 
DT, you have to setup the controllers, PHYs, resets, etc... by hand in C 
files instead. Not very convenient when you have something that is made 
for that: DT :)

I'm often bringing this topic because I went through the pain of 
supporting this fallback mechanism on our RK3399 Puma board which has 9 
booting scenarios (TPL+SPL on eMMC/SD/SPI and U-Boot on eMMC/SD/SPI and 
you can boot proper from any of the TPL+SPL if the same medium as 
TPL+SPL somehow is corrupted). It could actually be more if/when there's 
support for USB loading mainline U-Boot.

>> KConfig may be usable for this
>> but that will make things cumbersome to support.
>>
>>> There is tons of work and cleanup to do on the sunxi side, and were
>>> already have quite some backlog, so I want to avoid introducing more
>>> construction sites.
>>
>> Fair, it also doesn't mean that what's currently added cannot be
>> migrated later on :)
> 
> Sure, but at the moment we are severely review limited, so unless that
> changes dramatically, I don't see that happening any time soon.
> 

"Later on" has no deadline :) It was also not a way to pressure you into 
doing it (now or later).

Cheers,
Quentin
