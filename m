Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D93C87FCE
	for <u-boot@archiver.kernel.org>; Sun, 27 Jul 2025 12:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30AF082F00;
	Sun, 27 Jul 2025 14:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="GRq2WZoF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73FC782F00; Sun, 27 Jul 2025 14:03:47 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B86882E26
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 14:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siXwyX71BznRQxQW6mCjvYHeqwDCyRCrB4nPn7zbgHe50U/DR4v/zVnLR+GrBlbLh/rligCG6cMJA/4/XTuWw7kqOP91fPWyoehHvD54tN0WoN5rHafa0x7yNX1gvrOS2IDeS+3aX+xX5NbXXNfF4a7I/DrvXM3dk+jR53GaQzOSnUc32TUHy/GjyinVvg4tNEXnxC3RggGKcZHdGD7k7SC4bjb4Ssk0Ju6ofFUX+3mtxE8tKlmCNOt4eMPr2VULYjbvlqFALO9uThN8E2BeIzFXL07+0/a4DS/mQonp94Z4Ho7Ijw8B1IUu8+bGgOQMHZDX4SrUFFkBAKrlQZp04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voswd/6cO/ucgcOSM7dT0oABa8U3Ks11jBEbJ21p9Lc=;
 b=aJJsAD4eXNY387fE2jtxq+1gQASNxrnMQEwjSNRfhhB0aznB6a7K0Z1D57xb6+gm37IX7mSLGsOs0QJFPHUtxe8H2p9pEWMXlwPOFdL+XYgMW4go2SNAdOlWplj3RfPWHOQ7DON99hitl0mNbfW/mc9DWaZA5v5NbMlwlSTjncsrrJwjG5vUX8SoG45QuVd33/fQBGza+aeVA1pUQScCn4nTIS0xjen74pOb0TSTfJk5Hs3qRisMq8Uuu00di6SZnmPtcJ2pwrZ3VQ8jOY0QiE+iJcS6xs470jaEUVA9Kr6BwQmNDHgiuHVrVMKG7+zHQoeIwrzK1sdO6HcKOjttgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voswd/6cO/ucgcOSM7dT0oABa8U3Ks11jBEbJ21p9Lc=;
 b=GRq2WZoFf2DfN11p2iV0odbmKiUPqmHY9lpMLScAEVCYBj27KJ5tLHcu7U83DAHmbQzuvUlNBXqbpYExIXTw3n+LXJw7LAEadgJE2PsGNb4kUREmgZhmr9/e+ztrwpkdVgrBH1FcMDPnu12LItTpSh2RUoe/lbanmvtZX81d0uYbEgTNAHEGN/7fMNA4iduFvrDGCP0WLIE41v3XuUoQ3BF9GXai/43HOFil7lZkfQFNWG/ztMRuHd0qzMzPHymdSCAPhVb5olD8A/fkRpJ0OZvALejMssiTIrc9dQix6fJ/BocRePxubOiuRKg+NFOFpsql/takphWx5TVJnoC7PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB5374.eurprd08.prod.outlook.com (2603:10a6:803:12f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Sun, 27 Jul
 2025 12:03:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8964.024; Sun, 27 Jul 2025
 12:03:41 +0000
Message-ID: <2c6a55c7-e4b0-4af9-ba66-ff5cada14de0@iopsys.eu>
Date: Sun, 27 Jul 2025 15:03:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] airoha: rework RAM size handling to support multiple RAM
 size
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
References: <20250722184426.6964-1-ansuelsmth@gmail.com>
 <a374f7d9-b658-456c-bcce-30fa501f505e@iopsys.eu>
 <68861451.050a0220.a546a.2ace@mx.google.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <68861451.050a0220.a546a.2ace@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P189CA0033.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::46) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB5374:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f46ed3-e65b-4d7f-d9a9-08ddcd05a09c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1VXd3dURFdvMFNZdkdWNExrN0NwMXRHYURDN1NKSzZwN1pxTjNKNGhoRWly?=
 =?utf-8?B?R2MycWZSYmNIWWxmSHg0YkxBcTVrQzBFZWF6RUpBK2tsUFlTNGE4S1VXVlRa?=
 =?utf-8?B?QUg1WWJkdDRsd1N6MEgvMFBQYXAvOFVkSHUwSHZqOFJuVlFjM2x0WmNhelQr?=
 =?utf-8?B?R2djY09aSExrb0lGb0RZUXdVY2s1dXAwbE9SMXgxMmRSMGNpYXJlTUVkQ3R3?=
 =?utf-8?B?RWJwTVoybUtkeHJEWTVuY013MTJrM3V2Uk54SWFiSDRkSmNlcnN1aWVWUWN6?=
 =?utf-8?B?b3g2M28rWWwySXRpNi9yWWcrUU5mL2YyUE1Pc2NiVDVLWjdUMG0wdzBtQjBE?=
 =?utf-8?B?R0cyQ0pWUnd0V253NEVESC9DbisrUGR6a2VXZ1RzMHBoemdBaUV6ZCs5cFR6?=
 =?utf-8?B?Qk55cXZsVExWdDhWWmxSd21BL0MwMzMvOVJGOVVQc25QRFR1bElQazZIdTdr?=
 =?utf-8?B?RHRVUTlOcnZzUVRnc3NMODlkY0V0YVVBSUliTFM0S0VMTDNZRHBxSzBCMWpK?=
 =?utf-8?B?OGZUTlhGK2tsM3Jua1hHR2ZhMnNHUmZrYUxGdXg3cCtobnFtY2ZyaThwdlVl?=
 =?utf-8?B?U0tYa0owS1NWeFB4c2JLRmcyeTI1c3FPS3hkRTVBZldMS2doY0doZEJKcUZl?=
 =?utf-8?B?VkRIUGNSR3h4dktmYlZ3Tlc5RHBRMlFnbTl1S2NGNDd6SDV3WFBHaS9Zd2R6?=
 =?utf-8?B?alVBVHloYmdXSzdtMW9NbUR3NUdRZHg2SEx1R0VsMjJyQnBSTXd3VlZYaENu?=
 =?utf-8?B?TG1aZG0wVkFpdWFVWi9JTi9NWXlaZ0h0ZmxXa2R5NjBiVlNxUGN6Qmc2djVF?=
 =?utf-8?B?N2I3K0twenBIZzBYVUd2ZFdZYU1Kb1lEOEZWMEZmekxHUDdIcjdrSzRGZWVY?=
 =?utf-8?B?R3NaNlNtSkZKUlFWeXVpYysxTWptZDE2dFU0anJiN1RzeDN2V1NPRnVTWWRS?=
 =?utf-8?B?cDNPUHNyckcvQ3lwVXQ4NGd4aFhVRWVRd0MrT2ZvZ25xSXZMTkZnNlVrSVZJ?=
 =?utf-8?B?WXByWGo0UkRQcHpra0xEQU1VMDFqeTFtOHBnNGFROXdINjBndzRLZUhpdHg0?=
 =?utf-8?B?cEpWMTJtRGRmUGhrL1oxaTcxelRhOTAwVjMxMzhYNGZPOXhEVmh1Z044eDBQ?=
 =?utf-8?B?RWl6blR1NFNBTGF1VmhONFhLUE93aDYrL05JTCs0TVRiRG9YWXlPYm9SalpO?=
 =?utf-8?B?M0NSMHMwaTAwTjBmY3daTDBsZE1CSnlweHlDZGUwazUvMm03R3RvYzZNMWlp?=
 =?utf-8?B?amM1TllrbmF5RWU4dmVybjdJb01aWVd0cmtsVko2NXlaWGRvSkZJbHZsNUU1?=
 =?utf-8?B?NTdWM2kxeU1XVXQ3MkZ2V2p0S2kyUTYzZzdFUkxGNGxhTThWZ0VsTnlOVkN2?=
 =?utf-8?B?V3hqN1BRVnlFcFpBajJOUWVBbWljNzJvZUdsU0Z1UC9hN2NEYTFscUc5blZt?=
 =?utf-8?B?WlVVdkVrMVlldDllaEhXMzdBSmY0YmZIRTFBZWFTRmVLM0cya1ZCdzdWWEF6?=
 =?utf-8?B?T1BONUozSGxscVRQT2U0dzZOd2NVZGYwM0o0Um03QkNQK1JvWmcyR2F5UHN5?=
 =?utf-8?B?TnpHdE01M09RWkNxK2ZsUTVBRk9RMVdpN1N6V1EvMlRzekIwTnV1bkxTRDFN?=
 =?utf-8?B?ektJTDFVZkNERDkyT1Q4QmhTT25HSHYvRm5tQlV3Nm1Dd1BVNUVCa0lyWGIz?=
 =?utf-8?B?RkU4WGM3djFsOEZPRUNHZStIeWxOT2RTQlg5ZUFnMHUwVVRBSjdkWk50SHho?=
 =?utf-8?B?S0V4ZW9YZGFtV2NkZyt4YWowMTZEbVg0WmV1MzZEVUZaVUZHdFd1cFZSbGRh?=
 =?utf-8?B?NTdjUUhZV0l3ODcySWp0eHE3UGJCVDFldGx0US9xUG1VclVTamJxT1c5bEc5?=
 =?utf-8?B?Yi93R2xBQ1p3VEZvbEtzRms3dU1ONG54U3dNOFhqWnExQ28xUStaRkV0eGJr?=
 =?utf-8?Q?k8gke9QbG/s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE03dVREQ3lEQng1VEhqSGx0bjBxUWNUbVQ4MzJhRGtocXF4TEowOVRnOGZX?=
 =?utf-8?B?dTJjRmpjdjRVYzlQNS9MT2RpNDNxSGZVWVNaVER6M1N5eHRhM0pTSk9VeDlY?=
 =?utf-8?B?Rm51clJMbGhMbzZKOVJBa2x1MjJacUJUOUN1S0ZoYTdzNG92dklodGFCWklT?=
 =?utf-8?B?VzZFdTdrTm4ybnhoVUxBUzVPZVhjeGF0YmRsREZtUDNCZ0FRUkwrbkhhWGYx?=
 =?utf-8?B?N1hGRHdIamFCNThWdjBVZXN6YkJZQWFCY1d1NG16RGhnRE15QjJVcE9lZW90?=
 =?utf-8?B?V1NnZkJrallLY0RaajN3NGVQVlp6KzhYMEJvanN2eFp3bXV4VGhCdTJrd0ps?=
 =?utf-8?B?NThTVXR6L0ppamlBSmptTDFzY1RiWHRBYk5UZ1hJWi9JV25PYzl3RHlzeWdh?=
 =?utf-8?B?OW9FZTY4Uk1RdWltR0xEeXV5WVllclFrOFY5YnlXUm9pTHZXdmt0bGgyd3FB?=
 =?utf-8?B?VllrcUxodEM5akc3dzZlcGEyU3VuNGVmOWR1dzJMejVhaktyOGJ0N3poSE5k?=
 =?utf-8?B?UTljTmx4SlQ3a2F3ZE9zMk5IVzkyd1FwWjlRK2oxKzJRaFpNYmRab0NFTXpl?=
 =?utf-8?B?M2Jtd2U0TjFwUWtpUENlM0V4R3pERFFKbGthNmhYUUF5a3llSmhsWHlEY0Ux?=
 =?utf-8?B?VUVDc1J5YnNrQ3F5OHFSVGN6SjFzSmZrQ200eTFiRTV6R1p0YlFSeDdGVTNL?=
 =?utf-8?B?dmZSQXNUdjdpbVgrakhTMUVFNWVNdFNud0FvRjZIelE3bUQzbVc2MFY1d0c2?=
 =?utf-8?B?WUJya1pxb09sTXMzd3hvOXVFNHlGdVFRWkpkaE9XMDZDb2FXL1lrUFFmNVZ4?=
 =?utf-8?B?bTVJbXVvSGErK0FmSXFUVWthTjc3Z1ZycndkUHBwVTJuOFRPVHdCOElFVkJi?=
 =?utf-8?B?QUp4bEN0ZHllLzhKWU1zZGNxbTFiSWp1NFBaaHJRbUxWQ3dPNTBnaVhWUXFx?=
 =?utf-8?B?WDdhMlRuaGNnVUltYXFraXVQSmNaSW81NElDMkIwNDZid3NKTms4R2tUbDZE?=
 =?utf-8?B?Y0tQOFVtMVJpUW53cWdkbUcwR3E3VDFlTko0U0RVRjFXc1dNazUzQ3FHZWo2?=
 =?utf-8?B?TlRtd0VTYi84bE1ZTmxmeXp2QVE0K0VMaEEvcWVBWUNYZzdpN214WlVWbTRB?=
 =?utf-8?B?aHVJVnNmYTJlWWhLV3B6TVl6T2kvUDhzSXBTblVuN0VqRDVwM2ZkT2gzVGV5?=
 =?utf-8?B?d1pMcTJrbzIrZnJnUHhCRUp5b3VYNWxnZXB4cmFXMHNHTlRlZThEaFJNRytE?=
 =?utf-8?B?MDcyTjAxcVRKeWZ5cVlaRmJ0Y2Z4UDJFZGlEQXpLWFIxdEFCQTlZdnRRVHdS?=
 =?utf-8?B?aEF4bU5wVnNQU1hGV2J6NW5HMlplREN4Z1R2bDNmbHBISll2WkVrR1RyaVJ2?=
 =?utf-8?B?T1FKK0hDOVZQWEVoNGdzUGV3TEdLTDk2RmFjZHM1WkFCM25pUFdOeFFIcTlS?=
 =?utf-8?B?T3NqM2hiTTV3Y0o5TVdnRjQ5R1JnSzZ4WjIwMUVTZ2VJdDZvcEpXK3M2MWE3?=
 =?utf-8?B?eDVtSVRRazBLMWRyYllJV0Zabi8rTU9zVHR2djhWYThrYWUybVhkaFhGaGll?=
 =?utf-8?B?LzljZnBLZFZMS3BKcjVianFuL08weVZGSzdmMTcrVm9ZTHZCWUdXK2p4Rnkx?=
 =?utf-8?B?ZUNXNXl5L2VTbk13eWVCbUprdnA0Nit2Ly9UTHB1bXhCK1B3WExDb3NDVURX?=
 =?utf-8?B?TXFkY1ZibkMyYTFXcElKMVBIWStpRG1jalZxZ2NOYVdDRHE4c3JVQTlDdkNB?=
 =?utf-8?B?d0NIa2JjS2ZqbWM2dXoweEMrVVRIWTMxUGJJdmpBaW5GY2JpcmdMeXVpdVY2?=
 =?utf-8?B?OFZoSnd5RWczTEN4ZDVMMGtBdFNPZDVaTSt4VUpMWU1CSTBLTnBlcjJZdTRz?=
 =?utf-8?B?MW1iRTJOZ2ppak5mUkVEVzlYRkJ6ejIvUkxzdEVGN1pvc2JwK0ViZlFNbmlo?=
 =?utf-8?B?a0dHakM1UTVGSmIwT3VRc3dxNE9mYWQ5VzdacGlzSDNQWHVKcy9WVXpxaEgx?=
 =?utf-8?B?N00vK2duM1ZnbERoT2tMbWhhVlNRUTd6dUVmek9CU3NSN25sQmJ1ZzlYMElR?=
 =?utf-8?B?aWZXMlFoVk96OWVKcUdVMjgyOHV0UmRUQVpvc3phV2hjU2ppaHVXS21rWXNh?=
 =?utf-8?B?UzRzRTRxZ0I2eC9tTkdRU2E3K21lcytLbjN1OVpaMlJjd0cxcnExejlSK1RN?=
 =?utf-8?Q?2UkyTAEafpqFZ7CLtqnpZEI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f46ed3-e65b-4d7f-d9a9-08ddcd05a09c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2025 12:03:41.1542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujBX4K1DLjPJzMBrxqkODO2K0GEEDrmW8V8pd8LA1k4rHMZoGYIrDE2s6DPrEXNckKCbjFRAJ+ILZzYm6yRRQ0NCalSWKifyG1L4KZf+tU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5374
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


On 27.07.2025 14:58, Christian Marangi wrote:
> On Thu, Jul 24, 2025 at 01:30:45PM +0300, Mikhail Kshevetskiy wrote:
>> On 22.07.2025 21:44, Christian Marangi wrote:
>>> There are multiple version of the same reference board with different
>>> RAM size and it's not enough to base the RAM size entirely from DT. To
>>> better support it use the get_ram_size way to scan for the actual RAM
>>> size of Airoha SoC and increase the size of the memory map.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>>  arch/arm/mach-airoha/an7581/init.c | 23 +++++++++++++++++++----
>>>  1 file changed, 19 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
>>> index d149e0ee3c8..0f72365c4ab 100644
>>> --- a/arch/arm/mach-airoha/an7581/init.c
>>> +++ b/arch/arm/mach-airoha/an7581/init.c
>>> @@ -2,10 +2,14 @@
>>>  
>>>  #include <fdtdec.h>
>>>  #include <init.h>
>>> +#include <linux/sizes.h>
>>>  #include <sysreset.h>
>>>  #include <asm/armv8/mmu.h>
>>> +#include <asm/global_data.h>
>>>  #include <asm/system.h>
>>>  
>>> +DECLARE_GLOBAL_DATA_PTR;
>>> +
>>>  int print_cpuinfo(void)
>>>  {
>>>  	printf("CPU:   Airoha AN7581\n");
>>> @@ -14,12 +18,23 @@ int print_cpuinfo(void)
>>>  
>>>  int dram_init(void)
>>>  {
>>> -	return fdtdec_setup_mem_size_base();
>>> +	int ret;
>>> +
>>> +	ret = fdtdec_setup_mem_size_base();
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_8G);
>> Can we use a memory size passed by airoha trusted firmware instead of
>> playing with  get_ram_size()?
>>
> Hi I received some feedback from Airoha about this and sadly it's not
> possible. There are too much version of ATF and only some of them
> provide RAM size in some way or another. Also there isn't an exact HW
> trap to read to know the RAM size hence raw testing the ram and not
> depending externally is the only solution :(
>
> I will address all the other comments.
great.
>>> +
>>> +	return 0;
>>>  }
>>>  
>>>  int dram_init_banksize(void)
>>>  {
>>> -	return fdtdec_setup_memory_banksize();
>>> +	gd->bd->bi_dram[0].start = gd->ram_base;
>>> +	gd->bd->bi_dram[0].size = gd->ram_size;
>> as I know u-boot can safely use only 2Gb of memory, thus it's better
>>
>>         #define CFG_MAX_MEM_MAPPED  SZ_2G
>>
>> and replace above line with
>>
>>         gd->bd->bi_dram[0].size = get_effective_memsize();
>>
>>> +
>>> +	return 0;
>>>  }
>>>  
>>>  void reset_cpu(void)
>>> @@ -32,12 +47,12 @@ static struct mm_region an7581_mem_map[] = {
>>>  		/* DDR */
>>>  		.virt = 0x80000000UL,
>>>  		.phys = 0x80000000UL,
>>> -		.size = 0x80000000UL,
>>> +		.size = 0x200000000ULL,
>>>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
>>>  	}, {
>>>  		.virt = 0x00000000UL,
>>>  		.phys = 0x00000000UL,
>>> -		.size = 0x20000000UL,
>>> +		.size = 0x40000000UL,
>>>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>>>  			 PTE_BLOCK_NON_SHARE |
>>>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
