Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8001AC02199
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 16:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1718080104;
	Wed,  5 Feb 2025 17:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="glbf59x7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A711805E7; Wed,  5 Feb 2025 16:38:01 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 580DD80104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 16:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCp2ZzxxdtmqT/yVE/Kqbf5ICAncVIYAuaMToOOWrmC9JUtiUKirU9H9mH9VrdMHU2c5fNbK9zjIM0h+bqzTECQIBh3t4V0kxscXOAahbTQDjydbvovFCZORqrCeTJPPe8/JtM9aXbGjfpTGvGbRPeTN/UFAEYlKe8Eb37aYMhw8HCxZb5BOv3gZog+Ix/rPyYiP9dOWHGZru84pDlTx9RXPcDuHgr8ZH6EZpZY9odekU8NTcdTrylbeoc5QPy6dOPjX86ovCJkIHDF4+Lt+CSrMgAXiNgBqAHVhSiOeRfdVAaq4eLufSXT1WR6uzAvOsyLyD0/wGAk9Zh2crTidpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/gngO+4MhAtyqy/vm2nJB9vH+6LDp/2lEjlZ10AIs4=;
 b=hbGKw6NGBt2GvTo2AXrA49arm40xpqw2Y825rrLjqofrTFSHBhEFXjNqGBR2Y4mStyJ6Zoz7XN13TghLiAN35cJ3NhxIJdg+hm/SZvKaao8bUplTMprVLa3UXpGHxK5GFgEWD4sQtOK3K7yUjrE97klckgdLzJcwCeAxwaXEOaJDDQm7zMCHZHVL2c/PRtEUXQ5NWRVKQj/477zKn0LIDH8H3dszU0NpGoZsP5Avba4JBbYWM/yu97HPCstdQ6J/PZ3h1O1kJpziB9VieUoUOF4Aru0OHl+hltVP4+Bhr4VMl3zoFLI+ryKCMpC8RKhytN5dkHVVyiREylf6AXpPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/gngO+4MhAtyqy/vm2nJB9vH+6LDp/2lEjlZ10AIs4=;
 b=glbf59x7QnCzuEQ7g6/UYs33ULuGrnHNWStUVeCLs/cUlmzzPkVupMotlyyNWopkaxnTL86Smqa7Xn5yFSI/BPxP2c5+EM2J2qe9zEcSvAWhcXQhN4Ax+7grPwzsqu5WB+d4ZzedxIevPyBLgzl937zKbptXHWhdZKBH415QVrLlkSGEVvxznVJBcEZI/yOoZEHKqp3zcAm70yoXUHZB7rvdaFffkg3C8Kh/Y01U2SLMEE0s96Q/Ujf2rcA3pH0TZ23T7JWlVm4RORU43eB6hPdMr8jn7nAM9qXuQxILr4tcPMsqlym+bAPkTpbuIZj01InCVhFHydUbSoIumR8JBw==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB8933.eurprd03.prod.outlook.com (2603:10a6:10:475::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 15:37:57 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 15:37:57 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Volodymyr Babchuk
 <Volodymyr_Babchuk@epam.com>
Subject: Re: [RFC PATCH v1 01/20] include: dt-bindings: clk: introduce
 bindings for rp1 clock
Thread-Topic: [RFC PATCH v1 01/20] include: dt-bindings: clk: introduce
 bindings for rp1 clock
Thread-Index: AQHbd7bpD0KJdoQLqEOfnUnOXvc65LM409uAgAAEbIA=
Date: Wed, 5 Feb 2025 15:37:57 +0000
Message-ID: <5920447d-f3c3-41bb-8e1d-499907bc2399@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <e6caf0dbfa861eb12e6298efa784a7184e2769c5.1738749764.git.oleksii_moisieiev@epam.com>
 <20250205152135.GV1233568@bill-the-cat>
In-Reply-To: <20250205152135.GV1233568@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|DU0PR03MB8933:EE_
x-ms-office365-filtering-correlation-id: bbdda569-cb8a-4f2c-8677-08dd45fb108f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TGVadHlxeTY5Y0lrNFRBZFFydDdISTgzZkxiOWZKb2V1SnNXZ1RuVi9RNDhF?=
 =?utf-8?B?YzhvRVBQQnp3TWxLcTg1Z1ZBM25wYWwzTjZCSElRYmUrN0tNTHgvMFZyNU8v?=
 =?utf-8?B?dEd4Y0lwL1FkMmd5RVE3WGc5ZE15cE9yTTJKUkQzdGNLMXYxeE41MW92RytX?=
 =?utf-8?B?YW9ScjVxYXVtbjh1QVZkbFRQQjNoR0lkclhRQ0x0eC9CMmVyWHlYTkpXZnRL?=
 =?utf-8?B?eHJ1ckE4MEFqOHNDeENnVkZLb1c5eDA0L0dFR1pqY3V5L0dYdCtUcXJvOGtF?=
 =?utf-8?B?NUtULzJ1K1pCKzdCUkZWckJzSjFnQkpQWkZ2NEJnSU5XQ0ZpaStQQU0wMSs4?=
 =?utf-8?B?N1NnRDhmcE1oYmZSVTE3MGJhMXkyZS92YUVXWkFKdHhmcWdrUWdVM09hcDRK?=
 =?utf-8?B?ZnBBREdNYUNPbEw2ZmRrbUI0THhlNmJZV3ZxdnlQejdvRkh2OE1lRnFybzVp?=
 =?utf-8?B?WnRRUkhZQ1FvZWxuQ2xoQ1RCMXN6SVQ0R1ZZWW5neWxtd2w4WEpzUG9FRzVa?=
 =?utf-8?B?bDNQUGpGcUpVaHdleWRRaVVHWldudjl5cGZZc004dmMwR2lMVlJQWk5QcWZV?=
 =?utf-8?B?bFd5S0FlUDRiZCtPM29FWGpWdS9IcWFYZGdCQzZkcm4yMkV2TkVsam1laG43?=
 =?utf-8?B?SE16MVNBUHpKWGdBckEwNktxWGJnOXAyeVJYRlg1UWZKRnkzblV3R3g1V29s?=
 =?utf-8?B?cklWQVpuWi9DUjBiZTZ2aC9wdUJNWEJ3TzlKdHhIc2VsQS93bzVqQ3g5akdQ?=
 =?utf-8?B?SHRWYzV5WWFnRVZCaUpnWFlUUlY0bnlnVkY5WU9wQklveXl2K0xwdWU3QkVt?=
 =?utf-8?B?MENUTUFGMlRVYkRlSlRuK1krS3lPbjRMRUxrSnQ2bnVDNDEwYWM3dXlDdmRT?=
 =?utf-8?B?bGtxOUhSM0M3TE1VcjU2cVlRb0dmSWJLMnNyREliZ1ppc29RV1BPMzdmTU1V?=
 =?utf-8?B?QnlVMGY3RnN3WCtTeWRSU1d3clBzaDBXVEg4bThhUElyenk4MVNmTEs1UTh6?=
 =?utf-8?B?SGl4VDZ0ZjhZV0RQNVRkTzNSMTB1a1NIZzlIVGpQMmFzRm5qQ0NPaFp6MWNL?=
 =?utf-8?B?SDFObm8vVnc5Mk5pMitvTFRMZjY4VUExeGMyWHo2L05DWjFoL3lyM1JxbG9s?=
 =?utf-8?B?VUFRQUV5T1ZFSUZkNHRITzNVSWFxL2NWVHcxWm5jTFA1cXFuVnphSkoxTVpv?=
 =?utf-8?B?M0NnVU9wcE5LV1h6bW5tQS93NHh2UHoxWXZ0eHZMZE40VlBDL3VCSWdJdTlV?=
 =?utf-8?B?TFA3azZiT2RaZWFHdFJOWVB2S3lSeWdPV2xRa3diWG9LVXFvTDAxdG1JMUlP?=
 =?utf-8?B?MHp5eWZ1UUYyTXZtaWpvQXVBNnNvdWRVWWQ3SGQ1M2RTNE5JZjhBRDZMUWMv?=
 =?utf-8?B?cCtvbnd3V2IzM0pIYkNDbGZNTVNzcXBhK1dLb2JZQitHNlNJemF6Z0w5ZHF5?=
 =?utf-8?B?NjYvRFJ3TkVoSDVrNlo2MkhYZHh0eFZlQ0gva0xOdkpkeDl0NHZUTjF6Y2hh?=
 =?utf-8?B?eFN4UTNBV0JPUHNRREc3M0Vja0tZajRBN2FPcTllN0tHdElaUk1KMTZ4MnZU?=
 =?utf-8?B?ajloaUdPQkREL2oydzJlMUJ3aVdZdXpkZVJ4WWhsS2E5cmxkTUpPUUtpeDEz?=
 =?utf-8?B?emtMcTBkeUFWK21oL0FManJVQSsvUXBzZFBBY0hJMTV4UFA0ZHBUQnVwTTBB?=
 =?utf-8?B?YUVGdDZWbW9wSWxCaEloMWtBZjF4cld3eklYbkMzWWRDeDNYd2VHOWpKWlNz?=
 =?utf-8?B?TkRYMzNmdTVic0tBV2paOE1LLzFvRDhVeHdXYXNqOTBtRHdyY1NTWlpOVEF5?=
 =?utf-8?B?Q2VQekZXVlRZOVBVcVR1QWNjejdDb2R2QXljcVhsa2NNOGRTTnlMWkl4Rm5q?=
 =?utf-8?B?d0lubjkvODUrbzNKQW1GYVdsYVdiR3QvZGFNSFA3emY1NllzcFZpTXk5V28w?=
 =?utf-8?Q?AaZ0HINiQgHZzGP44CI9Cr12oI68+7CQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEZIYTFMdkxwR2lSclVEbnVibkJQL2JwVkszdDhoZjBHT3VqL0RuWmg1Uk4r?=
 =?utf-8?B?eVcxTEx2OTMxdjBocFI3ZGNONHhSWElTZCs2clR0SWhkQW51V0E1SjdvcGxI?=
 =?utf-8?B?SlUvbCsxN3plVXJ0dHRibndHQVhqRWhrTUdSS2Y1TUlWS0R1Q1gwSmxxY3dn?=
 =?utf-8?B?MUlRZVprVHVyZEQyZkhmS2tzYzRoNVhHZVFCd2hKVVJOdnFvQlpUYno0Rkk5?=
 =?utf-8?B?cEhqckZSZjFRSVJWVGkzc0FSaklXcFZjOHZ2SGlwQXBWaERLaW92aklmTFpW?=
 =?utf-8?B?OFVPSFVTamwvNHRub3puRTl6SEVLeTVUdlBLNU13eEFtVlFvbWFuWWYyNUR4?=
 =?utf-8?B?SlNURkc5N1cwVUM4QWZiSEV1STRqZ1RJdzYvcWlvam4zVDhGV2NHdGxsUXpo?=
 =?utf-8?B?Y2U5c25KaUV6VkgwWndwVVRaSGk4K3FhSjJrZ3I3REdKMjl1ek9YTUVuSXgx?=
 =?utf-8?B?R1kyZFMxdER2UFFlWDdZTGxZMVhzOGFXbUo3S0Q4c2pNdHNhdWQ4Wit6VFBW?=
 =?utf-8?B?MXlvZHpuRzhvcVhMcFVCK2V1dXE1TzQ5d2tkSitOWHJBdjBFMm9QdHpRS0Y4?=
 =?utf-8?B?a1VKbnIvY1RSWnRoWnBkNTBrUnFZWkhXaHhsZ3drSmw4bFU5L1N4NjFuQWs3?=
 =?utf-8?B?bjdITFhwZWN4Q3FYUVpDNzJYc3hENnd6SnV6ZkdUaWx3NjNSRkY3Uk00bngz?=
 =?utf-8?B?MGx5dklUSHdST21MY3RJTlZRN2ovVzN3dG85NnFFeG54VkF1VENaY3c1RlRj?=
 =?utf-8?B?ekRhUGlsQmlaZmlPUUZQSDF1dE5KK3AzVEM3UXZaMmtieXNlSDZINjk0MjZI?=
 =?utf-8?B?MDl3WEU0TzF0alRmbFNBTXlmaDRQZ3c3b1ZTSWl6bmZoTVhvZW9pSWxvRDdR?=
 =?utf-8?B?OVpFTE8zMnlXdkxMYncxdXN4VWhLTHNxMmV3ZkQ5eXAzL3dpbnR1QWdZaGtt?=
 =?utf-8?B?MU42RFdWM1FtZmtla3NHY2RITngzajJBR2N6Q2JoUk5KUFRIaW1tQjJZMGVU?=
 =?utf-8?B?N0RzTXpxTk0xM00xVmlzdkZxb2wxZ1FBWFoxdFY4QTlKTHpXNG1nYm9MY09z?=
 =?utf-8?B?aFJOMk42a0tjUnJGMXV4UVlXUVJSTWtXRWZ2WkNBWGxSM3FjYTFaN1VZSi84?=
 =?utf-8?B?WDJ2TVdCdTIrRUFKTzZtaS9Pc2gyU0Juc21Nb2x4cVJldGFuSXdwNzdKS3Ry?=
 =?utf-8?B?ZTA1VDVaSzI2SjIxZHJERmg1eEIvOGdKWHhTKzFURkRhMUU2aGc1WGdFTkMv?=
 =?utf-8?B?Nk1BK25RZXZOMllRSkRiOWlLSTgyeFhZN0hTR2pBclI5d1VHVlFKeGNGY0NK?=
 =?utf-8?B?Y0NFdnQ3dDRhYXBucHZ5bEpiWFk5TTNra0lCVXA0U2cyKzJUNmVaUDd1eXJp?=
 =?utf-8?B?blFPT1BEcUdHMzFHV2JlczJzRHlpR2FTaU5JUEtQc0E5SWpaQi9FQU9nc0xu?=
 =?utf-8?B?WEFtekVZSDBhVk1uQnZqUUJSNklkY01KQnA4RWdwTnZoK2szU2ZhYXpveGZK?=
 =?utf-8?B?cW5yYzdoK3ZDUzZZTHl3RU51QUg2aGduNlJXN0RaYW16cFNieVBIcTc1WW9D?=
 =?utf-8?B?dENpMjB6MmN1eDFheVBJUTJ4bjRBWTMrS1Jkb2R2TDM1LzZxNUNSM1Nxb2xk?=
 =?utf-8?B?eHFqMHZ3R2NtbXpmOXh3RlJXM3hlYStJUFdXb1hLcVlaMlBHT3FzWDZzaHBQ?=
 =?utf-8?B?bVZ4Wjcva2pubG5YMm02Q3JIRk4yR2tDWnQ5SDJiYUFwcTBncjVLRFJUaWZz?=
 =?utf-8?B?L3d1UGcrSTNjT1QydkllVkxuUlVYUnZsSDNYYVFNSURSVmZJbUN2Y3VsQXQr?=
 =?utf-8?B?N1lQd1l2WlRmdkdIcytWWUhybDI1UGdFdG1YbmhKYTFtay9KVm9XeXF1bzB5?=
 =?utf-8?B?ejFic0t6TTlVY3dUOXRCOCtkcXh2UElKUXJ2MExPNElWWDE1Y0JPeUt6bTdM?=
 =?utf-8?B?ZnprdFhvdHpFaS9qcVhXdDd4ZlRkNTFDTW1WSWZWVXJ2a3V3ZDNvS2NTTUlT?=
 =?utf-8?B?Y0F2am11alYrR3pNMENqb1h1c1FVRWlueWVTTU5zWThqMDFuNndDR3hHKzJz?=
 =?utf-8?B?d1d3STdpTVBLVFBXcGtJUU15L1gydkl4ck51MTY5TTlzZUtLSEtoRlBoTjBR?=
 =?utf-8?B?VTZJSzVBb3BwWVkvbHJ4bnFWc0svZ0RYVWZHOWNPSmZ0MUl0WGV3bCt3bDRv?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE648A52CC0520498A75A1E145AF16A2@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdda569-cb8a-4f2c-8677-08dd45fb108f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 15:37:57.2988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVaVO0yZRsbU1z4EQjX19uXSOsB69gk1XJBJFm+xcJq0gYnXv1wgCD01oZEiPVTqnDT1R7XDKTgh8JyVlKiiqsGe0fIdMlRUL4dHzu+TCr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8933
X-Mailman-Approved-At: Wed, 05 Feb 2025 17:17:50 +0100
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

SGkgVG9tLA0KDQpBcyBmYXIgYXMgSSBrbm93IHRoZXkgZGlkIG5vdC4gQW5kIEknbSBub3Qgc3Vy
ZSB0aGV5IHdpbGwuDQoNClRoYXQncyB3aHkgSSd2ZSBwb3N0ZWQgdGhpcyBhcyBSRkMuDQoNCkFu
b3RoZXIgcHJvYmxlbSBpcyB0aGF0IFJQMSBkcml2ZXIgaW4gUlBJIGtlcm5lbCBpcyBzdGlsbCB0
byBiZSBmaW5pc2hlZC4NCg0KSSB3YXMgaG9waW5nIHRoYXQgc29tZWJvZHkgZnJvbSBSYXNwYmVy
cnkgd2lsbCBiZSBpbnRlcmVzdGVkIGluIHRoaXMgDQpwYXRjaCBzZXJpZXMgYW5kIHNoYXJlIHNv
bWUgcGxhbnMuDQoNCi0tDQoNCk9sZWtzaWkNCg0KT24gMDUvMDIvMjAyNSAxNzoyMSwgVG9tIFJp
bmkgd3JvdGU6DQo+IE9uIFdlZCwgRmViIDA1LCAyMDI1IGF0IDEwOjE1OjQxQU0gKzAwMDAsIE9s
ZWtzaWkgTW9pc2llaWV2IHdyb3RlOg0KPg0KPj4gSW50cm9kdWNpbmcgZGV2aWNlLXRyZWUgYmlu
ZGluZ3MgZm9yIHRoZSBSUDEgY2xvY2tzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWkg
TW9pc2llaWV2IDxvbGVrc2lpX21vaXNpZWlldkBlcGFtLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBW
b2xvZHlteXIgQmFiY2h1ayA8dm9sb2R5bXlyX2JhYmNodWtAZXBhbS5jb20+DQo+PiAtLS0NCj4+
DQo+PiAgIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xrL3JwMS5oIHwgNTYgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDU2IGluc2VydGlvbnMo
KykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvY2xrL3JwMS5o
DQo+IEhhcyB1cHN0cmVhbSBQaSBzZW50IHRoZXNlIGJpbmRpbmdzIHVwc3RyZWFtIHRoZW1zZWx2
ZXMsIG9yIGFyZSB3ZSBzdHVjaw0KPiBpbiBhIGJhZCBzcG90IGhlcmU/IFRoYW5rcyENCj4=
