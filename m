Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1690FC02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 17:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CE51800B3;
	Tue,  4 Feb 2025 18:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="D4euAfKf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03E00801FD; Tue,  4 Feb 2025 18:49:18 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B50B980040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 18:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiyilBmuv1PVaSVmmb/mHo5lSfnfOunfD8ywpcynrEgB07V/K6zb6l4mfssASl0WqmUjFQ+tqx2Q6Z4RiRk90bmpaYQbsvtwlJXrwhmlLkHkoQIYPyP4DQKdpRHTXZRyd/AESRFXN4dHrq36HCTx/rQ/FjO9UmtFVIVcr7m63LuJWW1PzKt7EOlPhgbL4hKIXc6kss6uNm71GhfSFP4KwpVTmRW2KtJRBSLBwS8aRnHRgUDf9xVkDHkrVQ12oKzazpzBeGeKZiVJcrFl9QM9fH8FfCdOOuIVKlY++NKm/R03lG8vjJ9eZN7N5Cphfaos01kU6a/YgJ6apzkPe1VnSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZO/7fodsTo2mQ3NxNBXgdgu9QGppkLEaXEW4vyF5uU=;
 b=mNtihcIHFJ64YJ0eDJ7kllXmJ9lxmZBUE7/wZ00Pj4QEq5St16NsWqkW3rQnU29lk7uglA6XDMPHahbJNDUt7aeF/6x7fzUV9bAt5FKynAg6ShGTUQiHBwN5u4QLvZnWK0PU9uIvNoxKRRtO9o6nLWAU7RBIAKkuthokclQpe9MpDSK4w0pApmP98/O2PTSZB/kSKX8LQH11jIWxGZ1mAQF/GraK5Mfcmf/k0oeKKZdoIhWFRTxjjem/whFCvoeVByZgJpY9aNgpcIcOsE/NuI9gNtDLsoMw57+GEiZqxS9l8Suse6sEHW6GOiXfjfvQ98q0ELWHhsIQn34MrOue2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZO/7fodsTo2mQ3NxNBXgdgu9QGppkLEaXEW4vyF5uU=;
 b=D4euAfKfk5Pcu53AHJRArGMLQxTJME3lV5QFelwjID13W848vvPvzTU+7xzNkRVkG3wnjIAN32rgfc7s643Z8G/eH8aMdgw+7VvMca42K8gqftsGJ1Fot+eLWOjrKJaZoO4cBu9yeMYGVgiEtjA4yh5ra5Lg+h51qZupOCBtjI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA2PR04MB10309.eurprd04.prod.outlook.com (2603:10a6:102:41f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 17:49:13 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 17:49:13 +0000
Message-ID: <87c853a6-2eed-4bcf-a32b-021966d10f71@cherry.de>
Date: Tue, 4 Feb 2025 18:49:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: Enable OF_LIBFDT_OVERLAY by default
To: Chen-Yu Tsai <wens@kernel.org>, u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Caleb Connolly <caleb.connolly@linaro.org>, 
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250204172151.3361714-1-wens@kernel.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250204172151.3361714-1-wens@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0141.eurprd07.prod.outlook.com
 (2603:10a6:802:16::28) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA2PR04MB10309:EE_
X-MS-Office365-Filtering-Correlation-Id: 08eea77f-25ba-43d7-8256-08dd45443cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkIvVnhuaVoyKzFzSDVVWlJ5N0d5SnhtaUUvOFF3RGxQbFlzUkRRYzVXZHBT?=
 =?utf-8?B?WFFvTHNNTjJnNWhtTDcyK24vZHE5Kzk3TnpJWTllRkdpT2ord2dOeERsUkhv?=
 =?utf-8?B?alpEaGdjWHhSMkduQjNrYWQzaUUvMnJnYzJoMTZYZG93WVdRYm9ab1JhNGov?=
 =?utf-8?B?MXBDU0dRNjNuYnVxVE41TjdEdVNEc2NIRHZFWTI2bXpsM2lUNlR3dnJhMWp2?=
 =?utf-8?B?TXVDRUdEWWs0d1BUZUVXNXA5bS9yaFV1cUJZRXloaHR4U2MybWlUaUVKMmZO?=
 =?utf-8?B?a0ZFaG1wLzRBREFqdGhyZk14clNrMUczeE5sa0dKM2Q4VnB0Rzlrc2lFQTFV?=
 =?utf-8?B?OXNMU3hUTXY0d2ovK3RJVXRmalRic2RJc01CY1NWYnFNcmZDZ2pnUVlJQzlX?=
 =?utf-8?B?RUJqKzF5ZU1Fc3hjTzdndTl1VGVjekZKSVhaT1RUZTdwdVNXM0o1MzZwZ281?=
 =?utf-8?B?dUtTeG5kaWFNR1ZybjI3eFllYk1TUVhib1Y2NHBIZEtHN1lCM2NicFhScG9q?=
 =?utf-8?B?ZXRZVVQwZk53U1d3OGhmczZiVE91MXY2YU1CU0oyTDhjYlNsWit2M3ZtbWpx?=
 =?utf-8?B?ZnVFQUJHQTVhS0ZpS2NEZEJ2WGhobVRPUU1vNUt4TXU2a2tKVmlrSG53dlNQ?=
 =?utf-8?B?V3J6SnVjcGlEVXRIRmw0anBoenZBZU45a1MrcU1paHBRSFRvZW1hY2NRYmpW?=
 =?utf-8?B?UXpiR2FqZldIcThnU2wrN013UStPK1pQaHRjYWM5UGo0MlFmbW5lRDNacE43?=
 =?utf-8?B?RVJtRFpWRWlGRHpnb1JzQWJWWVVDZ2xrTkZNT2thVkdrTmpFbDJvOWdST0xo?=
 =?utf-8?B?OHBZN2Vvc0MwbVUrYTBwVGVWa09LQmxSRlZHcmt2MGlLT0lsQmtvQUpUK1Rx?=
 =?utf-8?B?emlWMVVxaUxxZmttWHk0STZrUG82MjlJR2ZZOGZtcWF4NUhtVTUvZEc3MEVs?=
 =?utf-8?B?RWFMbS9tM2VKY3Y3dnpZd2FRanFIVEhIOUNXYnduUzhQZHhvRXdVZE1jQ1dG?=
 =?utf-8?B?R3RNN1B6NHFENnV3QnN3LzNqaE9ZWHRCeXJYcU0zRGR1dGplWmlCTHBHcHBO?=
 =?utf-8?B?OUtUYnRkV0NPdVBPNGpFM1Vvc01zQUdMOU9hOXpCd0Z4TGI1NFMzQnoyczVJ?=
 =?utf-8?B?VzhxSHlXQjdVbnd5bTVLZGgzMW55RE5CRlpjVjZFNWxaaE02blVXNWZiZ2Qv?=
 =?utf-8?B?MTlCUlV1LytFWGhEalFqMXhEZitLUXlaUVMzUEtGODY1MDdiTjVkL0xrb3dB?=
 =?utf-8?B?Um9oZSs1anJJK2lPUnJway9MZEtwNWRoWFBFbll3UHh4M3pmK2ZOL1NzWW5R?=
 =?utf-8?B?d1R0S3BabE1NYi9UWCtpL28rZ0dsakNqWG9YTUlCTm84RzFZS216dTgyNUdC?=
 =?utf-8?B?aFVscTJEZTFGTkUwK1hGKzk1UXZDbS93d013OE1uN1BQUUQ1WE43Z2ZSRFRU?=
 =?utf-8?B?dnlDeDlTdTJaUTVmZ3RWc3ZGYVhmUGRSNVk1SktEWlJ1QlYzZ1FQTjdBSHhO?=
 =?utf-8?B?RVk2Tm1Hb3FtSTlTZDU4SmRrUlVFZE90ZURVc0s5M3cxOVZsSjNCVE84UnNG?=
 =?utf-8?B?dzVjcEZwQ1diWHJzY3VuTmNjUGFiQk1mUHN2SXhkdktBYndwTmd2aUpyb3hU?=
 =?utf-8?B?ZlN5NFpXS000NGNGL1k3bkdCK2JnS2dreUF1ZFRlLzNhU0lZckFrVW5mbmxV?=
 =?utf-8?B?T1l6VlA1V3RkUTRKcFh6T2dsR2t1NXhSMkhqQkhlcmM1bFVBS0kxUk1kUkM1?=
 =?utf-8?B?cHBnbVhSaWFjdU1LWkdGNnRwaWxCa0tOcXRJcVgxd2tUdzdoSnQzaXk5MGNZ?=
 =?utf-8?B?b25IRGkyTXJMUWJ5UmhWZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUJsN05BWjd2TU5Dd1QySnJ3UnhkSHpWYnpCbEpCZ1VvZ3dXQkJ3dU9kUGZm?=
 =?utf-8?B?d3VNZUdmMVkzTTIxSDVLNDlYdFU4YW85V3hSTUF0R0tBelRhWTh3VVBpdWl4?=
 =?utf-8?B?WS92NXlLeVoxSjNEeEZ5RXRTbmhuSVVaZVVQRUU5MWlOb09zTTdocWhnYzdm?=
 =?utf-8?B?b2xyYzEwUWlYSDQvMEs1NmtDQ3NSUTRTVzVmNzFZMjNlZzFRWGZjMHl6Rkdi?=
 =?utf-8?B?aVcwYndtTDhna2RaU09xRlF1TTA1ZXQwdGtSS1hwZ29kVzh1Q1l6QnFZK0JR?=
 =?utf-8?B?T0U0UngvNVN6ZkZuR1hRd2xITHlPbXZLUnZaaW5PemRnUndlN1NOOUJYdTJa?=
 =?utf-8?B?MEJLTUxVU3RnUHVFelpScDJzdnFQd1FGMlliTE5FZ0dra3kyc09wU1lFTFQ0?=
 =?utf-8?B?UTFzRkE5UU80TWVxcFVOVFkvRDNKUm5oOWIvdU9KSGw4YjZzT0R6NFRzQ2xp?=
 =?utf-8?B?VVdDNGxkYkZ5MVZYTStHZ3MwQWV5YjVjZ2xwQ0t4TVBhT0JrdWlwQkFRNys3?=
 =?utf-8?B?VXN6YjlnbEQwQjBBdGEvd3lCWE5wUjRYcit5elFidHBSTXVlU0I2UVU2R0tD?=
 =?utf-8?B?V2tuTlVJSXZodVEwZUJaTGcwYjJsOVFkdWM4V2VMUEZZOHdIVWo0TmpjY2Vz?=
 =?utf-8?B?VTJRWDZqS1JXRVdURmk5RDZDb0Y1WEhIKzlYN1Z3bFlDQ2hZNnlJV3JLV0xS?=
 =?utf-8?B?cktna2pGajBPTm10RzBjdjNEOWxtc2U4elBkVVhKaXJyNzZteWJXSlJvbS9r?=
 =?utf-8?B?clhLL3o3WTNUbWh2VVNieWVjdnR5ekIzc1VLb1VtOGpjcHNMejk5a2wreitr?=
 =?utf-8?B?Tk5Qb0JaTFBuNk52YU9ML2RaY2x0QVd4UTM2eDhhYTVoL3AweCtiMVowRmdy?=
 =?utf-8?B?ci9YbUg3NlhnRytDK3FOY0RIOXFXVnczYWxZQ0JjaXpVSDBQMEk0OEp4dGZJ?=
 =?utf-8?B?ZXB3enduMHYySUhpaWwrbzZ2RG03Lzg3OUhIZUc2SGdYQ1JPOEM3NW8yekNG?=
 =?utf-8?B?bzhoYSsvN1UyOEsxWWFjdUFXalliaFVJK1d6bk4zcDdyOTMwMzY1KzlKZXc1?=
 =?utf-8?B?dm9pY2FsQ3dSNVNIa2lhcVBCeUNLRlpCdjJMZjVWRWxnUzBYd0RWOFpyTk5E?=
 =?utf-8?B?bWExSFVzeUtnd2FlVG5vc0RmRVVDQ01EMERyVk92MUxJb0JObU9Cb0tuYmp0?=
 =?utf-8?B?cU8rcTcwa09qWGFxNExiSklzcU45aWhMVlcyMFRjUUFPaWhNKzBXVlcwQUJJ?=
 =?utf-8?B?dkl5cUZtekRUdnVKZDdTNDh4c0txM2dFaUZVOEZwdHpVS05MdGhCVG80S3Vl?=
 =?utf-8?B?M3hQeXF1Y0ZscEJwTnVhakRQU1RXdmtsRlJ2aDBXV0FTZHBsWEtBbW12enpz?=
 =?utf-8?B?bzB3THV5cm9OWXVXNmxwbzArV0V5eDZscXMxM0hnR0lvcnl2QnVJRG1paFg0?=
 =?utf-8?B?UXB6SjI1THVaaGMrU0VaL2U5dldGRStTZmhBdDRuOFJydUNZZWtETE9IUXZO?=
 =?utf-8?B?Y0lyNTBvSkVBaG1pMjljYnB2ODAzSFVKaTFCWkZJbnpHeXVnU0ZsZTVEdEE3?=
 =?utf-8?B?N0pFY1FZWXkxMERkTzBQeWp1Yk1OMGhDY2ppRHR2TVZHZkUyVjdKTDVLY2p6?=
 =?utf-8?B?azVDenduMStsYXlDRlM1MTBZemNsMk1NTVY4SWpnSjl1UVhZTzhGc01ETmJz?=
 =?utf-8?B?d0FNMkF3bmR6QzVNNTlxUUsyOU1hYVVpV0xNSWlaNHA1Q2MzWXJlNWFkdTNl?=
 =?utf-8?B?aDNoNDRjbXA2bGtCWnk3aFErSlVxSWsvMytxUW0zNU1jeHdnN3c1bEY2SUVT?=
 =?utf-8?B?bUZ3Z2RscXNBN0xjNlVZRUR3Ymg0Sk1TMUNOY0NBUTBuckh2b3FOWm1rdk5x?=
 =?utf-8?B?V2E4RTlCQ0ZHdXhCL1luc25zamdjR01LNkYwRkE4WnY1TXVraHZJZUQxeTMy?=
 =?utf-8?B?M25UWlJXejR1TXFZYk1uTGFDMy9rQllpdWU0YzYrbnBLb3dQck1oS2U0bDVk?=
 =?utf-8?B?RUFvdFdONFNoYU95SEV2QjhMNnNpdlgvS1dMb0ROR0dQYmsybEV4MHpIUjN2?=
 =?utf-8?B?c2ZUanNOSWNGek5NN3BYc1RKNXNlNTZtOHNxZFNrMnlxSlppcGdtcCt3UDgx?=
 =?utf-8?B?a1hSOC8rWVlCclJhc0FadlQ5WVpHNnAwWXp3emtoK3d3UDZRNU4va1RCZjlT?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 08eea77f-25ba-43d7-8256-08dd45443cb7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 17:49:13.6662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8u6iiwdrQgO9yIGcNDyMC38f182gN6Kr6l5VM27opWb4PhIxIJMaWK7EJ0+ywy9EOpQ5cGda4pEEYHMxpYKgJQ0iRqQhlVm6sa/vDIsRtRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10309
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

Hi Chen-Yu,

On 2/4/25 6:21 PM, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Device tree overlays are immensely useful.
> 
> Enable it by default by implying it from ARCH_ROCKCHIP.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
>   arch/arm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f504d7d07601..2797030d3501 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2061,6 +2061,7 @@ config ARCH_ROCKCHIP
>   	imply DEBUG_UART_BOARD_INIT
>   	imply BOOTSTD_DEFAULTS
>   	imply FAT_WRITE
> +	imply OF_LIBFDT_OVERLAY
>   	imply SARADC_ROCKCHIP
>   	imply SPL_SYSRESET
>   	imply SPL_SYS_MALLOC_SIMPLE

Yes but not entirely enough right now.

See: 
https://lore.kernel.org/u-boot/20250129-px30-overlay-v1-0-4729b3fcb4c0@cherry.de/T/#t

At least it still boots even if fdtoverlay_addr_r isn't set so that's 
not too much of an issue.

Would be nice to check which SoCs do not have this fdtoverlay_addr_r set 
and actually set it as well, otherwise enabling this doesn't help much 
:) (at least with pxe/extlinux)

Cheers,
Quentin
