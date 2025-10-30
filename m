Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0A5CCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 17:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6207E83887;
	Thu, 30 Oct 2025 18:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="N9ZKU8Z5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F4883893; Thu, 30 Oct 2025 18:06:59 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6277B836D1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 18:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK8dCSFA65Shn8eu4OiYkIh48KHSXr7vSwqZ1L1zst23o2DBPrfUIjyRuJgPfFMWYmWrlydP3dyaQWTcDrOTByS4+u7TD7d4rpFW29psQKCJ8jGBRocNohippigWdh5wrPb3yebhbSFbazQ1IgE+J9qj2KZSeytnfRGSdZIaPJEJUbmb/ihdewXKjblYPE5KPih2Btn8ds9A3WtYc8DvG3UdZuJaXdqNAEqQcNy8EXUCKErAFN5idjYUbtwynLGKYp2cn+9EyVQnQH+UBYk44RiPMPLRu6fg+C8qPpmVVOVd7cKR63oTbzHA8eIlYMqRzwJU25q6yXjtJvmsgMGCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LifTvf1mVEUVolZwwW5yKVhCmex0Yv/5N5fghJCciUI=;
 b=tskiczYboU+ZAKGN+lN/ssxZx4e+GHmHfHjg8PDTDryZK6TyI1EeAzE65cFIQ299TFJ5ltPtxsFBTgCk+s2T8gUtfN0L5zAxZnC+4UQHMxGyB+8F56wVhmH4RJ2LLMfq1YUPRmnGNNkLstsr+dYwXtWqT0BLla/PMZjGXTp/3H2bZ0lzRebzKzKUGa1pu2r684BnaOlLJ+0BtShoCJPrPW+lVaRb6muJeuDTozCXSCWGzVCsgXXG/Z3dDfloYbYK6p/9AvChF9zIJ/gYF9tLgE9E1APqI944eUBom1wbSMDVuScJZgMkW2TTWjygylzFMZdwwPc+AWYoBcQeoygWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LifTvf1mVEUVolZwwW5yKVhCmex0Yv/5N5fghJCciUI=;
 b=N9ZKU8Z5RMj4r8MVeEkB60OSlo/8KCifKpoyWj2YZCx+3c7hxvceVeTAOX6QkV3zREBZpgtv6tBJ6gJL6rlThVo3X9MZWFBz5/G3Pm7HxQ82uPMqtgAKvgyqJedCuWxEYRqHBzyBESgs6cz064wGNm492Z5eeeHS+AukrEFRsUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10112.eurprd04.prod.outlook.com (2603:10a6:150:1c0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 17:06:53 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9253.017; Thu, 30 Oct 2025
 17:06:53 +0000
Message-ID: <c0ecedd9-a07e-49e4-9c76-b854dd3fff96@cherry.de>
Date: Thu, 30 Oct 2025 18:06:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rsa: always build pss padding
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Martin Schwan <m.schwan@phytec.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Alexander Graf <agraf@csgraf.de>,
 Loic Poulain <loic.poulain@linaro.org>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>, E Shattow <e@freeshell.de>
References: <20251029-rsa-pss-always-v1-1-ad2b652e75aa@cherry.de>
 <20251029222032.GP6688@bill-the-cat>
 <320655db-d362-43ba-83ab-d79eb6e58559@cherry.de>
Content-Language: en-US
In-Reply-To: <320655db-d362-43ba-83ab-d79eb6e58559@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10112:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c25b66-a470-4ffc-809b-08de17d6b92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDNTTERpeE1qVnN3RlgxWEdxS0VQVFZEdHpCaXRpdVE5dnRkRWwrbWtqUjE3?=
 =?utf-8?B?TUJ4b0J3ZUVlVUJYQmExNDNMejhYK0xMUEtPZmdiekFJZkI2bkRkSm1OMFRO?=
 =?utf-8?B?Y2hmVzIydWFTVUdDWW4zTS9maElPZ213T1c1TjNHb1B4bVhTVFZ0cTBrMkhs?=
 =?utf-8?B?K2pDcWMxRFNObjNhN3hhZGV2cXpGL3dmMnpQNWNnQ000T2hvdFIzL3RPYVY3?=
 =?utf-8?B?aVJWUmNWMlRZVEN5cXQ4NnoweG1penF4cHArTUdvQWVvRktJUGFpajNsUGps?=
 =?utf-8?B?VXMxSTQvUXJMV2lubDJKS0J0bG9mdmdqMmhHOENHTG4vR01rOTU0elhwcFdO?=
 =?utf-8?B?UW1TaStHYlJEcVhQZHI1aFB1eFJZY2d4OVhOeVQ4ZTkrUm9DUjJia0hIb2pS?=
 =?utf-8?B?SzlZa2dkek1SbEpEQWx4bUNEYXF2UFdZczRMRWUzREJDN3JwZlBFbTk2cmND?=
 =?utf-8?B?WVpyMTF3QjhyN1NMbzhidmxzdmhTWmZpOWJVYzJDWUNDemFoSEFZb1BKRkRS?=
 =?utf-8?B?TzFpOVhqSzMvNXZPYlgxRTQzeFpYMi9OSjlRbUhpVzFxcldvZWFWbDRscDZF?=
 =?utf-8?B?QVdvREhjTjNHTUg3S09vZVRnc00xdjFpYTduSGdlNWlaMnM3azYvbnRLVW94?=
 =?utf-8?B?djJCKzNaVDQydkE3dXB2SW1zSUxzSWhVaHc1a2VMYzFHemZDSmhDWklON1Zh?=
 =?utf-8?B?UlgzaGFGd2hCQWRZd0hqRy9CWjQxOHl6OVhMaVhmaGZWSEx4Y0s2dDA0SXNt?=
 =?utf-8?B?Vkx0WEphb0RyenlrMUtGSVZXdHFNbEJ1VnN2Q0QxbGRRYjBQQk12NEx5OENN?=
 =?utf-8?B?cEdXWW1sWk4wM3ZsOTJWcTV5dDllZGtRdEw3YUIyNFJ0Ym5TWXd4Smx5bjVB?=
 =?utf-8?B?TVhYNzNHZFVFUFlZZnRkTFJLMDVZYkVKc1JQcURGTzFmL3k4ZkJ3UFVSL0Zm?=
 =?utf-8?B?Umhwc1EzckF5ekdhSTAxa0tKZGRZajVVUFNCZjdSRGZVYkxicE0yaHZaTWxF?=
 =?utf-8?B?MFkrRk1SRlUxTUxnZTlWUjdkaDN3bEhjMGRrbEFXTEIxOFFDRWpBMHlXUXN3?=
 =?utf-8?B?dE1MMStNVThRT25ZMEZVQVV5ZEgrRDdGRmw0ZFJ6bGxDUzcwdGtEYzc0Qm1w?=
 =?utf-8?B?Qmd1ckF4VlFuZldpb2JLVEo3ZlJoM25uSmxSQThGNVlDYUhqa0poRUJyQlBP?=
 =?utf-8?B?bXA3WlJScC9UeUIxVkI3RW5mbGV6YjFFOGdrMXhvMVlCa1VhVC9PSE5vaGdj?=
 =?utf-8?B?b3lFRHU3dHE3QnAxN1p3clU5alJsb25tNndQOWU0bUIzdHdXUVowWHZ3TGVG?=
 =?utf-8?B?ZTg2Tkp4V0pqYWF4STNMUGZIVFpNOEtlZjFhQ3dRMy9sMzJzTlE3L1NDM0pu?=
 =?utf-8?B?UHNsZEUzdXFGckZzVFJpS0pwL0lhM2QxODR2TjB2MUZmcHNhV3gyYkRscE9H?=
 =?utf-8?B?azRNUXBPNDZOOEVjK0dFOUxLZnRXTm8wSG5jQjdPMzdQVXJDS0gzR0o2Ynp6?=
 =?utf-8?B?VW9xNVRqS2NGVmx3eHYvYjcxckR5aVhGYkdEamNHRnduRGp3bmRMOTNVVzM3?=
 =?utf-8?B?OWpHNFIvSGtzWFZERTBLNnZ1eE1uNUQ1dzRJR01idFhRWFRwOENqNzZvb2FS?=
 =?utf-8?B?cG9TNDBDNVJtSCt2My8wTGFjOTdNbXZmK3pCSmdlY1cwMkhWaERTZU9OTk82?=
 =?utf-8?B?ajQvZmhkN3daalZ0ZlBUUVRWRSthUERYZVVxM2p0NkpwM01BalRDOHFmYlhk?=
 =?utf-8?B?R0Q4M2ZjZ3ZKZjVhdmdqd2dFSUF4R084OE5ZemlOcXpQdWNGdzduMHBQMTlY?=
 =?utf-8?B?RlBCRlk0b1JXRElOWm5qWnN6NXJ1R0tCbjkyNDI1U05Nd3dtanJ0QVo5SUwr?=
 =?utf-8?B?MUZMOHZGYlZic0x0ckJKbS9zSDQwaTJPZ0pZMTl6Si90REhObDNBbDZQU3px?=
 =?utf-8?Q?DgAyb82mzcHuwiptza7a4rrywaoQpUKp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDRHUjcyTVo3NjBlaUZvMEFsRTBaS1FTR1Vlcklpd0RZVEhNZUFQYThkcVBW?=
 =?utf-8?B?NWZMVkhPNFZ4bEFYVU9DZzdndWR1Sjg1RFdLUTlBMUFNdVI3WlVkVmF5clFD?=
 =?utf-8?B?bzQrSnNVOEk1VU1ZaW5XcHdBUGc1cEc5WnBJQlhHQ0s3SElHLzA2WG9rQmJy?=
 =?utf-8?B?Z0N0UEpkeDg0ckV0SmdKcEUyMHNITUhFalZHSy9ma1pRV3ZmcUN2WGJlbzB5?=
 =?utf-8?B?ZHlIT2lPME8yK1doL0VWY1hZWjZxb2llNmtyenY4VEZjanR4SmRrT24xVDA4?=
 =?utf-8?B?UmlydVR0VHhPd29WNmJHT2p5WUFjbGNjT1ZCdlRNVVVBYU1WcjRlYkFLcm1l?=
 =?utf-8?B?MlVXNG9GVFVPQVg3U0JNcnV4Ti85bURaNTI1RFlQVUlNTkMxTEwvL0JYZXlk?=
 =?utf-8?B?cklFcjdBSS9yUVd4ZmJWU3A0TGJ2RjBQZGE3Q0l4NjZQZXV5U0d1LzV2MlpB?=
 =?utf-8?B?UG03dzg3ZDRuMDFzUmhtV3JEUG5HcndKak9TUDZjMHI3OWJ0My9nTDREZlhr?=
 =?utf-8?B?QlQ5aEx3QjFWN2phSzN1RlZwMHkvM1lnekh0WFdYUnd0c1R5RnRBeUUzN2xL?=
 =?utf-8?B?dUd1MHJ5NEE4NWc0V2pCRXlyK0tZUDhMWmdXMFpDZFI2VlFVUVlFMjBFZGNF?=
 =?utf-8?B?VXdXTWJ1VGI1bU1Vd1dmQldlUmsrL0JpZmE2RU9rNGFhbFU4SDhtZUxwdEMy?=
 =?utf-8?B?R08rdTdSSC8wSkxYV0VzaU52YkZPS3AxVDNVbC9ITW5OQy9iTDFaZm01OUVD?=
 =?utf-8?B?bExrdVQ3UVRGS0JGUno1SWFMajlJcjB3VWFFamR1bjlUNzkzVXRLbGRpakdW?=
 =?utf-8?B?TUFtREVydnBBbzR1WjQ3UkZoN2s5R3FWMFZ0TUppSGcwTXNJYzFpbzBaU0FK?=
 =?utf-8?B?NEM1U3F1WklEWHN0elhCM1NxUDBwMnRWVnZDZ09hcXNWbHYvejNmQlUySnV4?=
 =?utf-8?B?TGk2ZXI2RzFXQ2RlQmlNMzlXVkpEbllSb1VwZUpVMCtzOEtmakJZZU9lcU4x?=
 =?utf-8?B?M3R0TEREdldMR2E5RW9raTdVWWtybWhqME82ZThjNmlvaU1Scms2a0FZMkRR?=
 =?utf-8?B?clBxWG1RV3JWYlVITnViRWtmQUVNOFVLT1NHb1BJdStncGdMbURPOFRHVGha?=
 =?utf-8?B?aTFTUm0xVjg2djhpb0pYSzV3N25ZVmNJUEp5NGM5YmtiWG43cHg0TEE1WFBR?=
 =?utf-8?B?cFVSZHpWNFc5L2NFNHk4TGliQjVqR1BOSExKSlpydjF2UnU0ajMwYU51ODBh?=
 =?utf-8?B?R3hjcUMwdjVFdmJENDVnNXN2alJ1M2JTMVkvRktKM09zUW9iY3dLb0RJNUVP?=
 =?utf-8?B?MzByWnFxRHFSYU44T0pzYWxKbXdjZEtTY2I4WXA1eUwxTEk0ZkxjWlhqUEhI?=
 =?utf-8?B?TXpzU0JLVVRXdUhSd3hVNlp5QlF2d3NTa3ErZDllZ291cG9zYlJvcWJ4WDJh?=
 =?utf-8?B?aUhSRGxGN2VVNkFqdVFiTWNvZXFiTUdXWmFTNXc5clJzZWtGUlpJSXVnN0cr?=
 =?utf-8?B?WWJvdVVPaTkwRWU0Y3NoT3ZlbDNBd0RNWk1zNmkwRmNvaEJoSkFYeWRXMkVo?=
 =?utf-8?B?UEVQL0hnajJzOUN2Mm1XSkpCWjBXcHVobGNrRjY1MUlGbVJiK1lObG0zRVNF?=
 =?utf-8?B?NWdRQUNzRnFxMS9BY1hGTjdwdEN3OGJMZW1HN0VoN3MvbG80R3VHYmpYaG9w?=
 =?utf-8?B?dEoxQWhmcjJkdktqbEZNM0lsd3BhVDdDYURPS1hndDViMG9YT2FCdWtxMHhF?=
 =?utf-8?B?dktjK3N0bUNtMlNVdW14RVV2Y1hHZE82L2pBb3lhTEdDa0FEREZzdytNb1RO?=
 =?utf-8?B?U1h3ZjN4TDhBSFczZDI1U2FFMDRqcFI2NkRqcWFjYnV0dXJaSXhiTkZPVXBn?=
 =?utf-8?B?L1RqbzVBMWk4TW5ZblR6SnJrNGNZOFM4bGFBY1NTazVNbWVQY3czSVdhVjAz?=
 =?utf-8?B?SjhsdkJLVG9XTU82aXB0MHV3NC9QMDY2a21xNEJJMEcwZTA3dXZmaWxKNWR6?=
 =?utf-8?B?L3paSVJlYnJrYU0vRGxZYnVVUGZOUTVGbTJTRUNZeFBOQUQyZnNCcVplTE1O?=
 =?utf-8?B?U1FLNkx5OG9mRVNYK29SM21uYXVBdGkxYUc1T29qdlJhYVdFSzQzUzRwU1hv?=
 =?utf-8?B?UXVuemwwWnd0MzFVZW42bElIdW1BTVNoZkFYbVpKaUpwa2lNcXE3UHFnbkJL?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c25b66-a470-4ffc-809b-08de17d6b92a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:06:53.2053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdzsP3MSBKQVV8hE1yj+lGNnWiz21v5I06JJc05pTdLpgWQhbgYz3sf8n7+shEl3WXF2urHDk8jjHV+uSAJUnb4OBBORa2CajBMFzugDfiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10112
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



On 10/30/25 11:21 AM, Quentin Schulz wrote:
> Hi Tom.
> 
> On 10/29/25 11:20 PM, Tom Rini wrote:
>> On Wed, Oct 29, 2025 at 12:28:53PM +0100, Quentin Schulz wrote:
>>
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> One could very well want to verify signed files which aren't a FIT
>>> image (e.g. via rsa_verify_hash() when $(PHASE_)RSA_VERIFY_WITH_PKEY=y)
>>> but that is currently only possible if the FIT_SIGNATURE symbol is
>>> enabled for the stage this signed file needs to be verified.
>>>
>>> While we could remove the dependency on FIT_SIGNATURE and find a better
>>> name for the symbol, let's simply always build support for PSS padding
>>> when RSA is enabled, like we currently do for pkcs-1.5 padding.
>>>
>>> When $(PHASE_)RSA_VERIFY is enabled on PX30 Ringneck, the difference is
>>> an additional 904B for the SPL (spl/u-boot-spl.bin) and 1000B for U-Boot
>>> proper (u-boot-nodtb.bin).
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> ---
>>> Another option is to remove the FIT_SIGNATURE dependency. For context, I
>>> have a system where U-Boot proper verifies the signature of a few
>>> binaries thanks to rsa_verify_hash() (see CONFIG_RSA_VERIFY_WITH_PKEY)
>>> with an embedded public key. We do not use FIT images in proper and I
>>> would like to avoid building code we don't use to limit the attack
>>> surface, so I was looking at ways to remove the FIT support in proper
>>> and this dependency makes it impossible as we use PSS padding.
>>>
>>> The cost of always building all RSA paddings may be too high though, I
>>> don't know where we should draw the line.
>>
>> I think the cost of ~900 bytes in SPL for 120 platforms is on the high
>> side. How about a different symbol? Or would you want this enabled by
> 
> Yeah that was my assumption as well.
> 
> I think will go with renaming the symbol to RSASSA_PSS (and 
> SPL_RSASSA_PSS) and only make it depend on RSA (and SPL_RSA), then move 
> the symbol to lib/rsa/Kconfig.
> 
> How does that sound?
> 
> I'm not sure to understand why we made PSS padding an option for the 
> tools though... I'm thinking about removing the TOOLS_RSASSA_PSS symbol 

Answering myself: the option is actually `def_bool y` so always built 
in. It's there so that CONFIG_IS_ENABLED(FIT_RSASSA_PSS) can be resolved 
when building for tools.

Meanwhile, I'm looking into getting rid of FIT support in proper but 
still have it in SPL, but that I'm hitting issues with symbols all 
around. Let's see what I can do :)

Cheers,
Quentin
