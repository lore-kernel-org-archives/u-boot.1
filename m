Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F380D35691
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 08:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77F1A83B97;
	Wed, 28 Jan 2026 09:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="i4DDf1gM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB74883E0F; Wed, 28 Jan 2026 09:37:39 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2A9A83B91
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9cpY0F6ovQ3ZC/RKTqBR9KEPQaOFyZ0f66Dr4QauQ8p849JwhE3pVkvOMf4shOuhKVl4kJKzAwGgEgJCtESnyc3Ss03PZdcwi+8ZO5rAXFihlTHO7Bw6qio0//cHcGI0IkWATdkutFEqaAfqCBm2CnmPKjz29m1Ge3YeMT+2S058t+qcGCAmzo4t/z/0As/6R2Sb/rTgVzjGlm6K5znPW/f22ut3XHtAleKLkKVT4tCQ5dS07dmtTWvFhkID8yG4Xog7agfq4TqLM5qztTtMccdJbylOSju0CxZAonUjdQDn7J14bu5DshSA34WDbLx0csZAa5Elqb9rC7gb4K/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rIDxdIPfMOc4795PF5jfGVOVkvX78OBWkfwdnY/MAc=;
 b=AIt1ahPeyLEvmrS8euUkEzH4bxtlvZRnOuvThsAGwiHlCwxiwj1WNwEo2f26P9pgYb8lcNUgQhToY/fib5ZCjdT05eJ8dT6HTg6GEvfEDLB4/hbKKJ9NDNfN2gB8L+ljO5Uh7Z08gwX5+nDTU2BHR3k5tTYbrt1nMi5+IfZzTtCQIBOtUyTG9VmFHcs2p6jGzOhpnmQty65WNyNbDOI7EGurHJp290zMFPzOWuJ2UXnOFVkPdTI9zNL5Y/485TD+1v4C2rUMzLeWI2TgNiRsDC2YtOysZflBotTKSDsn385gAu4rNPuxpy2T5SfYdxDsaeylpKMFW5NKPuAW9ocGFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rIDxdIPfMOc4795PF5jfGVOVkvX78OBWkfwdnY/MAc=;
 b=i4DDf1gMYAgJgUO/WtxjFQsUyGhMxD6yWO+/x6mNwAb1/Ovr0PgwVZP4RY7Z/ONNctlYsRXiHAA6F+PQnjdHz1055gWgDhAmZuAiik8xCI+Nom0GZBP9bmVsH0gpT4cIhRrKBTGFpGGmo7GtWzVvhTEeNQsSEVkcsEnjodokP/eRmMaj1gnTWFW7RUxHhIwvqcy8k2duSEWZqQNtKpQcPe+UJtu8BFvsIfAnKLBDFFJWcbvV0uZ/z7PyDMYI3w/ndv07K8+iETtumJYRgIxd7oqLmJFYRCGKIjxqjwOghpYxwkCjP2dV66klAqvJshHkBC+9NGjka0aGzufxKunp9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BY1PR03MB7216.namprd03.prod.outlook.com (2603:10b6:a03:533::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 08:37:33 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 08:37:33 +0000
Message-ID: <90244945-f90d-4589-92b9-787e0d3109b8@altera.com>
Date: Wed, 28 Jan 2026 16:37:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] arm: agilex5: Enable eMMC HS200 and HS400 mode
 support
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com
References: <20260125202329.12738-1-tanmay.kathpalia@altera.com>
 <20260125202329.12738-4-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20260125202329.12738-4-tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SG2PR06CA0182.apcprd06.prod.outlook.com (2603:1096:4:1::14)
 To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BY1PR03MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 3220ac05-eeba-42cf-5293-08de5e487b40
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eG1BaWNGaVRzTWQ5YVU1a01tM2lLNHVkTHpGMFJUaFhmc1ZXMTlKODlDM1p2?=
 =?utf-8?B?VU1FellBOVZ6azBBTGd2R3RBS1dlTXRGU0RGRENjU0pmT3JvbkE5c25EaW9N?=
 =?utf-8?B?OVdINkJqNExoY2liQm9vN1hsNnUzSUpPZFBjR09DZFZ1U1lmUHhjTjdGejdj?=
 =?utf-8?B?Q0pwaGx1bEg1WHl2TXM0MXRndDBKKzVEWGp5elJhTTlZeEhCdXJmcm9oclR5?=
 =?utf-8?B?MmxVZEtVeVdIbkNZTHAza1FITERIOUVSVFJjMjRCaEprd0JKclV2cW94K0hO?=
 =?utf-8?B?TFI3VThBV0cyRmpCMTJZUlkzQ0RPTGtnSXdEOVZoL1MzeE9LdG1ZdTNFNWRU?=
 =?utf-8?B?aThYaUZoRlQxRVkyYnduYzlwcFhnSTdQU1ZvRitzRnRPNmxKcktVWWhKMU1a?=
 =?utf-8?B?TVJ1d25nWTBOekJWdVZ3cTRqcnV6ZEtyQmVlOENEd2dOSHRkNHlmVWV2RnJ5?=
 =?utf-8?B?KzhQZmhGNlZQRzFRNlI4b1J4WTFDQzNaTGFhTVl2U3o5TS9aalhZVUt6ZFlJ?=
 =?utf-8?B?NTBSNlhUcWpPbE8yRnB4cnJndSsyZG1QSWpvRU9sZW81eVhKR3pDcVZCa2Z3?=
 =?utf-8?B?N3Z6Y0dFdUJaTEN0OHdRQU5VaXlQRUFubFNmVWJuNHFFeXVCMjd1MG5iYmV3?=
 =?utf-8?B?NUx5NE1sdlAwbkFzcHM3aWgwOHgyWTRWcmQ5RDdWK085MzRLbEVDYy9sY2Rn?=
 =?utf-8?B?OTYra01hNmYyUXBCSmhBUXpPRWRuZUNjM0pTUkFPMDZjUXpoYS8xNGVoZ3Ix?=
 =?utf-8?B?VDN0ZURLMTc1Q2tSbUcrckgrVkgxaDFiSnNyZ0JzclZXdlgzUW9PWHZzemhh?=
 =?utf-8?B?RWhvQmpaV3hkYjhWaTVlNzFYMk5Ka3JSeGxLVDJpbk5nbldZNUlUYUxjUlEr?=
 =?utf-8?B?VytOa0xydG4wc1FlajNjSHI1eGxITXBhS2FlNnJYeUhLTEpET0Y1TjBpS29a?=
 =?utf-8?B?RXR0Y0g2L2hCSWgrNG9idDRjcDE5aFFPdWk4SVNzVjhyRGlYa2JoM0ZiM21r?=
 =?utf-8?B?MWg5djM2dm1JazFUL2JxY290L2lCeXhuTXJDQ3UrMnlJRlZpVllxMXJDQkwz?=
 =?utf-8?B?OGtIbTVKMGltdnFweGNLa1o1L2NpSCs3OCtwUFAvM1FaSlBLRk51T1BidFdR?=
 =?utf-8?B?bTlaQ3pINXZiOEpCL2JzeFJEZ1h3eGIvcTV3c3NQSFpmMFB3d25HZXdBMzhO?=
 =?utf-8?B?RlF0cWJXK0huSk5Dc3ZNdWhkR3Y5Y01mbXUxT2RPaTRMbEVxWkxVejdkTEw2?=
 =?utf-8?B?aXJWV2lSZzE1REgxbkMvQ1B3WTRNU0Z2ZVJwRzhJcm9oZktDelNQMEVCVk8r?=
 =?utf-8?B?UHpVL3ZwU09heHZUa1VyR215bUcrUjlHWGlwQzY2cFpJY3h3S2FHOXVoR29u?=
 =?utf-8?B?cktjZDRLZExUc0NVaDRUUWt1bzVNbGVveGI5dXBRTXU3aHQ4SVNJOFZFV3N2?=
 =?utf-8?B?Uk1taHJGWU1kcTVjYW0zK3I2ZWRyTzQrWEM3VVp0Q2w3VDhVekJHZ29aSm9P?=
 =?utf-8?B?Qk5DcjJkSlRsRWRpTXh5dlpVUU5jUGJNWko4MkVrSU9ydmszU013aVFVWEtw?=
 =?utf-8?B?aWZ3WnhyOEtMa0xxQ2NrcFQrUVB2SEZVZGFiS3NxeDF1MWNoazBHQ3ZHQnkv?=
 =?utf-8?B?aENVNTN1ZS9yU2k3TVNaVk82UW1MVERMTFE1dDVsYTZ3ZDE5RXUzTEY5eW1s?=
 =?utf-8?B?U2xYdGREVS95OWZveW5TMmM0SWxUenhBNmtpanQ0alhqTFMvdVhGUW1QT0No?=
 =?utf-8?B?NjRidkY4QmRGWWtLRmx1UkRDZHgwQ3dhZHlCem9UdUw5OURiL2QxVTR2QVN5?=
 =?utf-8?B?OGoxRnhqUmdDdWdjMDdibTE5emYwWFVQUGU0aHVVemM1OEgwV3NHa24zWW1Q?=
 =?utf-8?B?dHVJNXBBTk1OYzU4RlFQR1N1bjJVK0U2STVBR3B0Z1pSeEQ1bnQxRERlZHR5?=
 =?utf-8?B?Um1FOStRVDJ2NmhDa0lPcSsranZGVUlQbEoxck1jVkRSWXp2Zm1nTGRIcDZm?=
 =?utf-8?B?UmpFL3RCNDI1K3Z4dXJWNzhZbGoxNUdWeHdYRnZLTHdiMjFnRGR6WUhEWkI3?=
 =?utf-8?Q?g2d/x5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWduSjI0dEpwcVl1b0cveGRnd1NPY2E3WUxjSTY2M1U4N1R2U3ovU3FCZith?=
 =?utf-8?B?RlU1YTdUUXM4RCtHUDdQNGt5MWNpSVlyRnRXOWpWVGMva2dYZFNMMWkvRU9V?=
 =?utf-8?B?WFNBQkZ2Tktacjh2ZHVHVDUrU3R5VnkyQm85S1g4RmdEMndwUWdlazBhYVVU?=
 =?utf-8?B?K3JwQmtwbW5vc0UydFJqWDh4bUdMbEpiZWlOcWFITjJGaVUydkh2eGR0eFhw?=
 =?utf-8?B?UnVxcGNBWGprQXR4aVY2ZTdUNzAzVFJYa3RRK0xtb3FVRytTdlhBZ3BwRHJ3?=
 =?utf-8?B?aXdKVXcwQ2VrQVdDUkZVRitWbTd5bXJ2VjZTU1JzSFhROXlMZ0lGSjZmamRp?=
 =?utf-8?B?TXhhRlE1SDE1VVkzSmxDcmRkMHBiYlNwTkR2ZmJPMm1xNUVDMlc4QnN2RUF1?=
 =?utf-8?B?MERueEE2MUovNVR1RTJ3VUFFZjgvNGRXWGIyNDV2UTFaZlhYRHlJV3pKdm1M?=
 =?utf-8?B?ZzRReTRrTUNjY1FDOFBFMUduQkIvWG9FYTQ1cHZINzVNb1dpbk5mRXlKOENw?=
 =?utf-8?B?VjNuZyttV2ZuS3l6Wld0WEdUOEZvNkV3UFZyWmRvNVUrMmtWNnQvaHZpNmY2?=
 =?utf-8?B?OENGR3h6bXRZd0J3cjVqSmdEUTBQQVJ2N3pQN0ZqRFg4ZWN1VHBDL1JiQjdj?=
 =?utf-8?B?ZU04V1ErNTFiQVU3TkRmaUdFWi9jdmtQY2lFV29aODFLZ3BNZk5CT1BmUkxQ?=
 =?utf-8?B?VEdFaDBGTHJtL0JxeDkxV2tIK0JHRGZvRHNCWXQ1ZkVXZGZKNXlYSlVzUmlY?=
 =?utf-8?B?WmdQVEkxOGJ0VkZJckhRdHQ4Zjl4RE5MVWJyb3pka2twYm1kQ2NsZFI3OVhy?=
 =?utf-8?B?ZXZITjdxKzRQKzgxeDVOS2xCdzRDa3I1dnhxU25jMFFwb1FsR29VVnEwbXRa?=
 =?utf-8?B?UExMdVdsdHFzYmRsNmdSRXh0SXpNSi9uNlc3aEtuMDdwNzkyNUVib09lNmtI?=
 =?utf-8?B?TGI4VUlvVkRxTGlmT2U4dXRhSlhwQXl2dmc1S2U3SlBuZjlCSU8xZGJTNkxE?=
 =?utf-8?B?bkdjMWtBZVk5UW03SmhUcGZMZ1hFcXlyejQwdFAreGp4LzVtZnFQK1AzTzlr?=
 =?utf-8?B?MWtKeVV1L2FsTE0vTzNVSmVyY0Z5NnF2bkNxVUZpbHUzcHJrMzFHZjhwUzZX?=
 =?utf-8?B?dmQwYkRFdzk2ZEp1TEUyQzBHZ2R3MmdIeGM1OE5jemI4d293ay9mSUdpeDZU?=
 =?utf-8?B?OTkyNTB0Nkc0ZUJXekR1Z0xhVmxwZTliTlpaWW9yVTZxdkFUN200bkxlMkxJ?=
 =?utf-8?B?bzh2YmwyTTA4L0NzdzBXeWlqd3pqdWFMR3dxaUdYYUNFRUs1a1UzQnVwTklp?=
 =?utf-8?B?ZTl5d0FQY09KM09hZkYxZlB4c0tWbUcxYy9PYmttRXhpTDJNY2diVkFFdlU4?=
 =?utf-8?B?M1FlVzNOMHMxK0dIeFRuZHMzbWNrK1VDZDFBaUxFQjY5UUNxUTBXWDFMNnRY?=
 =?utf-8?B?SkNzSzBlSlprZ09mUG0yUjNNUk5DSXlPOCs5SmZERW9kVGpkRmVubWVLWjk5?=
 =?utf-8?B?Y0h2OEUwUWdvb2Q1U2hIa2RMOFZ2VE9zZVVvTlQzaERwRzFUVTJUejhnbFlk?=
 =?utf-8?B?dzdTSmM2RWVJdFFzTFR2WGllcXNGMXlneVRUUmE0WWg4eDdiWlIvVDQzcXU1?=
 =?utf-8?B?ZVNZTjdaVm5xN1VSQmRaS3h4NlVWbk5GcUpEUkZtaGhqN3JKaXRiQmdudEkz?=
 =?utf-8?B?ekxpR3RTc1k2K09Yblg0OVRzT0hZRUtDaTdWK3VZWS9kR1lid3NrV0xSUHpn?=
 =?utf-8?B?a0YxM2FOdzRROERtNXhmMFhXNUJndkRDYVRkb0REUHRUQ3B5ZW5YQSsxNWZw?=
 =?utf-8?B?cVBiZk5pbXB0eVRhWTdabS9wN3JmNElVWnlKQnRoWDFNWnBPKytmM0gwVyty?=
 =?utf-8?B?Wkt5NjRuSktlSVlidHgzVnBTVWxZdmlSZmZ3Tk5aOVl3ZVBxT05BbmJMRHR0?=
 =?utf-8?B?RGoxejZzRzdwc2swMXRHM2FVZ3FTZk1RZXZCS2dvZy80Z0hndEZhakZoSjla?=
 =?utf-8?B?NHFvWDV2TEZyTGgwUW83TFlxSHM3dGkzWnRETDRoZkRFZ0NpRS9RK3ZvMHdZ?=
 =?utf-8?B?OEVqTHZhMWg5bGdMeUo1Ym82TG1IQWhYWkt4OWlWc3QvWnZEaitySVZWOTBD?=
 =?utf-8?B?RXlCNkFCTVQxWTJzR0JybVgxL3dZajdLbjF3bUlEN3FxbmNHRGlhSWlnYWJD?=
 =?utf-8?B?SitRWFF4Sm5STXVFOHVXS0lnYWlXRCt6bHVGaHdzVXBMVlNPV2FxRkUxTENl?=
 =?utf-8?B?UUk1dXh6eExUcGladm5xbk1pWmhwUGh2eEM5M3hvZDNyTzB0WnVSY0ZmanhC?=
 =?utf-8?B?Wk1pZTlpTGVST3dZa1BWYUg3eWZWSG1OelJxdTFmTnF3dHAySTAwa0pVRk9i?=
 =?utf-8?Q?KJBac0viphXFB+1I=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3220ac05-eeba-42cf-5293-08de5e487b40
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 08:37:33.5143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsKgkS1E0vpXDU5C4gVBYkhbOzvzF6FRou/l1aRCdGz+2L6iaOdutrfpmhYuLda1yU3wYiH2xZ+h1LuGKlqKY8MPu03LbLgxiF4Jb0xXznk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7216
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tanmay,

On 26/1/2026 4:23 am, Tanmay Kathpalia wrote:
> Enable high-speed eMMC modes on Agilex5 SoC development kit for
> improved storage performance.
>
> Defconfig changes:
> - Enable CONFIG_MMC_HS400_SUPPORT and CONFIG_SPL_MMC_HS400_SUPPORT
>
> Device tree changes:
> - Add mmc-hs200-1_8v and mmc-hs400-1_8v capabilities
> - Add sdhci-caps-mask to mask SDHCI_CLOCK_V3_BASE_MASK bits
> - Add sdhci-caps to set 200MHz base clock and 8-bit bus width
> - Add PHY and controller timing configuration for HS200 mode
> - Add PHY and controller timing configuration for HS400 mode
>
> Signed-off-by: Tanmay Kathpalia<tanmay.kathpalia@altera.com>
> ---
>   arch/arm/dts/socfpga_agilex5_socdk_emmc.dts | 28 ++++++++++++++++++++-
>   configs/socfpga_agilex5_emmc_defconfig      |  2 ++
>   2 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> index f6848c373cd..49b4a85783c 100644
> --- a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> +++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier:     GPL-2.0
>   /*
> - * Copyright (C) 2025 Altera Corporation <www.altera.com>
> + * Copyright (C) 2025-2026 Altera Corporation <www.altera.com>


Please don’t change copyright notices when making minor code changes.

Copyright statements reflect authorship and do not need to be updated 
year-to-year or for small modifications.

Even if the file still reads “Copyright (c) 2025 …”, it remains valid 
and does not require adjustment for this patch.


>    */
>   
>   #include "socfpga_agilex5_socdk.dts"
> @@ -25,11 +25,15 @@
>   	disable-wp;
>   	non-removable;
>   	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
>   
>   	bus-width = <8>;
>   	vmmc-supply = <&sd_emmc_power>;
>   	vqmmc-supply = <&emmc_io_1v8_reg>;
>   	max-frequency = <200000000>;
> +	sdhci-caps = <0x00000000 0x0004c800>;	/* SDHCI_CAN_DO_8BIT */
> +	sdhci-caps-mask = <0x00000000 0x0000ff00>;
>   
>   	/* eMMC legacy mode timing configuration */
>   	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
> @@ -46,4 +50,26 @@
>   	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x30000>;
>   	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
>   	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0xA0001>;
> +
> +	/* eMMC HS200 mode timing configuration */
> +	cdns,phy-dq-timing-delay-emmc-hs200 = <0x10000001>;
> +	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
> +	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
> +	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
> +	cdns,phy-dll-master-ctrl-emmc-hs200 = <0x4>;
> +	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
> +	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
> +	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
> +	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
> +
> +	/* eMMC HS400 mode timing configuration */
> +	cdns,phy-dq-timing-delay-emmc-hs400 = <0x10000001>;
> +	cdns,phy-dqs-timing-delay-emmc-hs400 = <0x680004>;
> +	cdns,phy-dll-slave-ctrl-emmc-hs400 = <0x4d4b40>;
> +	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs400 = <0x81a40040>;
> +	cdns,phy-dll-master-ctrl-emmc-hs400 = <0x4>;
> +	cdns,ctrl-hrs09-timing-delay-emmc-hs400 = <0xf1c18000>;
> +	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs400 = <0x80000>;
> +	cdns,ctrl-hrs16-slave-ctrl-emmc-hs400 = <0x11000001>;
> +	cdns,ctrl-hrs07-timing-delay-emmc-hs400 = <0x90001>;
>   };
> diff --git a/configs/socfpga_agilex5_emmc_defconfig b/configs/socfpga_agilex5_emmc_defconfig
> index 9254ab92e0c..d2d359cd1d4 100644
> --- a/configs/socfpga_agilex5_emmc_defconfig
> +++ b/configs/socfpga_agilex5_emmc_defconfig
> @@ -4,3 +4,5 @@ CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_emmc"
>   # CONFIG_SPL_DM_REGULATOR_GPIO is not set
>   # CONFIG_DM_REGULATOR_GPIO is not set
>   # CONFIG_SPL_DWAPB_GPIO is not set
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_SPL_MMC_HS400_SUPPORT=y
> \ No newline at end of file


Please add newline, defconfig files should end with a newline.


Thank.


Best regards,

Tien Fong
