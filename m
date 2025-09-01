Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D179ACA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 13:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E0F6839DD;
	Mon,  1 Sep 2025 15:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="zCfob1Jd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C4E7839DE; Mon,  1 Sep 2025 15:17:01 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A63E83965
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 15:16:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQ0ZPvJamwLPVfwQrQ9KsftLtmgOnc/vTfRVjLpDSQWhcf9/qZZnj+tacp66KKr5lCIAeqF8fJuQ89zeLkHLPGScBwaCK3c6rHhc5tlwGDoqdwIgsmS9YZNaat0RxTkMxSWhdSe3rNEAH788Gvo+VUzWKoMRSfy1FdwlapduQhjTZoaNRZlJ8t9GLYTUZ8KCeGz82w//K3mWp7P+9Q3fAZmACQWr520+9CmDJJi3AaGZKR9kHij/IcUNg4pQuHaYhGWOSZ2WrfI0LK3Unp1IqdSfK+m37MPqJB9PH/gciy79XZtZvqQ+20Pq9OOyN7AaD57ZZS61xnGMAQPBibdO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9DzqNUo91nImToyHa3Y8xL7nneyJlv+XPeWpbmomMY=;
 b=Pvzrtvs+0f9fVyY6khd5XgXhCyC3FK/zvYZEWsiNjoZ+BT+Irm4+TIlQ1hGUypXZPKtJ7mo0DHgLrvOhV/TCHPJ4yg1lzMwVGKNh0+z2UQr9VET4rCPDvcg+OmMAVTjtGdCejwlfMs02q/5kECvI+RBMu70XcAt996ehIewQx+Wb+edC6laYotgcEB2qhARg4yNTVI1ra/j2bh4V/n8+rBorUDgViQlw2lhwQx14zuaoOcgY8ItqwvFq/K0bxG+UEgnUwg7Xpzdv35pkm5//ly2q+4fWDGUcxi+hTyy89lVpYVOerJYvHL1R76t+ZSxg8V2Hh7VQT5zvddeVldceWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9DzqNUo91nImToyHa3Y8xL7nneyJlv+XPeWpbmomMY=;
 b=zCfob1JdqkGLX7WiSaNvl5YL9Umog76seuaN1ajM5h26greBl4hMNKp08jRudm+ACxC8CZM26BSfnkSN6oPNsyi0ozSo1ZmONPmdo4Kj7SXpcyEeKNKR7SUXsJLbh41zxhRdsoOtj4e7WqnY819uy4F/HE1H391busl6ElaaZWJckV5Q5JvstMqexZj9K++frqgvUdmbz5cmiR3K+5/B/Ykey5dQ+zpWKEYlClzZOI6Rnu/5pd4w51vGJw+So87skxPyKH5XKbpbIsLEMX/p5jJjjRF2ldHW2rZFbvxXkuVM+FGQWs0nPsSfExdHh9Dz4BVXaPABxtFloOZkSNtBOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5898.eurprd08.prod.outlook.com (2603:10a6:10:20c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 13:16:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 1 Sep 2025
 13:16:56 +0000
Message-ID: <c55c74fa-46eb-4082-955f-d570913a5e49@iopsys.eu>
Date: Mon, 1 Sep 2025 16:16:53 +0300
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
 <2c6a55c7-e4b0-4af9-ba66-ff5cada14de0@iopsys.eu>
 <68a9c171.5d0a0220.2720d2.b8b7@mx.google.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <68a9c171.5d0a0220.2720d2.b8b7@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0196.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 242741f6-e0af-4f10-9938-08dde959d2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3NQQUtJVE42cWd3a2pxK3NjQnVVQWxDK2EwNExhVDZiM2dHcUtXWGZJbTh3?=
 =?utf-8?B?bzdSN0NIeERnUklkWFJVY3JBU3V6dWdRWE9RRnRpMmd0NTlORkc5eEthOTEx?=
 =?utf-8?B?ZHd3NmtnMU1sQTdsUHVQTUlldUorNHFmNmhCUlROS3NjL3J1cmg0R0lZN2s1?=
 =?utf-8?B?MGp4bkZ4d3JIb1JOeUQvUGJJZmJZUWt5c0pSVUV5VWkxckVhaXVMT1EwejZv?=
 =?utf-8?B?M2s5Nm5iRkg1RFdZaTAvcmVNZyt1TmcrdGxxQmMxcysxTHFrT3JwbzNTRmFy?=
 =?utf-8?B?cWhEZWxtd1NIakhPb2JRYzFRUmMyb1F6eEFTN25oczlwVEN4Y0p5RDFVOGZH?=
 =?utf-8?B?OXE5c1YwdmFWeDRua2FFMUZmbENqbWYrM0RPWE8vZUROeURzZmZ3dXNYYnRQ?=
 =?utf-8?B?YjVlU1hFWllscVhTb1dqNi9jM0J4c29LSDhPVWVXT1BlWEdmMWlTT3BRVXNi?=
 =?utf-8?B?MHZDRStxWlc2akxFSXpaSDFsd1hXdTF0dTRVMHB0S0dkTGlyS2o4RFNHdEs2?=
 =?utf-8?B?ZjVRQnVhdUR3MFlDTW5CN3ZPRG1lM0tzakJnOFRFcFQ2cGp5VE5qNVVQdUQ1?=
 =?utf-8?B?Yk9nRzFybnFwOXI3Mmc2c2Y0L1dDZkM3Y2JreUd5RXZpVzc0TGFuZ2RwT21r?=
 =?utf-8?B?V3YxOUdRTGFmdndjK2ZxL01vY0pyUGI4OXZhUXdoZVo4WlJlaFowK1Q4MFVR?=
 =?utf-8?B?bi8vVWpTcytDaWtDaXpBZ2pidWRxS0Q5QmhvSld3UFU0TUxVSlR1V1JpL2hS?=
 =?utf-8?B?cTlscmgvdHpSQzVaZEh3T0NkbGJrQnhEcGZIM2lVaGhwbjNob1hONEhLWVVv?=
 =?utf-8?B?ZHJnSzRGRmE5T1dSUGpGeXdPcDYwK1VaTFpwU2I5ZlNTQStIU0pLM2Q3VDc3?=
 =?utf-8?B?NmxGYy9aampwOHBldy9JOW1BM1NOa0Jrd2dxNExwNlJjQk13eEs3WEp3UEJY?=
 =?utf-8?B?SXhyNnpHbDExVTB6dUNYUG9HK0w0ZFYvWmZidUg4TE1mejdDVnoxVGNSWURL?=
 =?utf-8?B?STVHYWc5RmZ1encvSDY1aEdPOHMwN2l0QTk4RGdMaGV6Rnl0WXBVOTdKUlp5?=
 =?utf-8?B?SmJjWDl2SEJwTUg2OURPTVJ4ZjBPeDFOY0VEQ2pmYkNIQTc5Zk9QZ0xyN2VK?=
 =?utf-8?B?WnJydkphSE5GdHNmTDI0a25KSkVjTkpzZlRGalRRSXJsbDl3SEdNRzNVYmU4?=
 =?utf-8?B?WnJOOUVmaEorWVIzZHBieWlYNFlraXpNTXBhL2laUzIwVFhOSVRyN0FwT3pY?=
 =?utf-8?B?eU81SkVLTVVJRE5QZFFVYWFqRGt3Y3dlMXlINU0weTNBblRKZmZkMXhaRGpy?=
 =?utf-8?B?WjllVnQ4S0NUWUFvWWowK3Rua3h5dHhmNkNUQUkxWVNvcEZxQjRVTVRkY29n?=
 =?utf-8?B?WXViT0JmQlptYnp2QU44QmtwZmswWUVRelA0STVId3c2UEJxbzdjTXV3YzFi?=
 =?utf-8?B?YUtERGgyZXF2RE9QcWp6TTZlN3BFN2pTYjlIait1WjJWamkwTHRVQkc5bVpy?=
 =?utf-8?B?cnUrZUs0V3ljME11Njh6bUorN3dDa294a0ttR1pQYXlLTDk2NWVQbHh1S3VP?=
 =?utf-8?B?Um15RjhBUkNvTkhhT1NrYnc2NU80SzFaL1c2OE1yUDVvcExwR0dESnlibnpD?=
 =?utf-8?B?dDRzaDZzQkVmY2xSRVlna2lta0NHcXN0MG1DVFc2alVITmQ2QURFVExXM3VC?=
 =?utf-8?B?NjRLK2J4ZnF1cS9uQTJOZTdNUytvbTVsWHh1SjI0UGFuclZ2azB3ajJjeTJW?=
 =?utf-8?B?bXIvSW9Db0hxMGlvSFJyUHA3ZktGR2Q3T2VUN3JLVWFyM1VhYmJIS0xqQzNw?=
 =?utf-8?Q?KN/kHrMXHI1PtuPWY+RKjagZj1ZXN0nHHV0no=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHpIbGJwVXpGRXJIdnNVK1kzb2dMRWJiWjRDS1NqRW9wK2xPeG5jTmlFZWcw?=
 =?utf-8?B?cWE1YTFmQ1ZMNTBUd0lEN2crMlF0VCtOK1J4YWI4aFRSb1lkU1FIYWRCbDY4?=
 =?utf-8?B?cjRVNnZGbW15eVJCRy9OUzlTN054VUpnak9vMlg2ZEV1TUVxb2NGZ2xqVVJ2?=
 =?utf-8?B?WTVucDRHVGc2d05lODZUbjlxUnUycGNjZUVwWk1nRVIvZkJXK3Q4SzdHUVdm?=
 =?utf-8?B?S2hsSUpwdWtDc1pxWGgxaUZzV1VkMUhuV2xRb0JRM1NRbFNKQXdndE9XQ05h?=
 =?utf-8?B?czNxcTRiTWtibHZoM0lrZEd6cEY2dDJZU3ppbUN1a3dnaWRCU0dwOUFzcyty?=
 =?utf-8?B?TjdvemhKNGJHbmVWTXNxR0R2SUxBUktmalRFVzZHOWtsOWZOM1cwWHdZaWgr?=
 =?utf-8?B?SXh1cTRFbmo0aWFmWXZnSzBJem1OeGs3YTZQV2xJaGw3c3lhL2RLOHd0bUdl?=
 =?utf-8?B?WmdGaEYwc2d4TUp3M3VsWTBhTW01ZDZsUnV3ci9lVmk5RDN4MC9ZYUs5MUpp?=
 =?utf-8?B?RERHTjVBdkhSNitLcEJaSjJmMHZGc1p1aVJXbjhwakhPVFh0bUdHZzBPVHhw?=
 =?utf-8?B?MjVQbG9wMElHZWw5TGFnSm9KVzVBaE4vR0lVbG1QSEZkcVpNQTFmQ0VmVldh?=
 =?utf-8?B?a0JUd1I0azIzcGZwdEROTitSWkt5Nnk3dWhleTZJbmQwbGF6NmNZalVpSEpJ?=
 =?utf-8?B?SUVkY0N5TkZkd0FQM0l5NjJ5K05NM3U5TXVqb0orZnV0aU8vckdlSEpZUFQw?=
 =?utf-8?B?bkZxSTcrZ1Y0Q2RWQ1lVOEFCWVhXc0V4ak9lUHFnTnJxZnZuSEw1YU9pSTk5?=
 =?utf-8?B?VmUwbXdnaFB6TDNJUGd0b3JZSWtncS9zN3dNaDNXRDUxVVk3T3FVcURsK2g1?=
 =?utf-8?B?LzVYaFZKYnVuZHkrTGUvZU0rUUs1UldYRnpzcHF3TU82cXgwTTZZdjc2a0p2?=
 =?utf-8?B?cjBFeTBqeXVOK1FYanpnQ3Qrb0lWdlhzaE9wS2ZOeEdpNzFQejNvQWVGdHFs?=
 =?utf-8?B?dS9qdC90K2lqVGtvMUlKdzlNbzVNYUxGV296Lys4VVhYNklWQWU2TXRPblJi?=
 =?utf-8?B?cG9sTnVMMXdOMVJpSHJ3K1NEZ0JZOU81djU5d2N2ckdudVZoOGovdElGTUl3?=
 =?utf-8?B?TWVkQStoWDR5UkQxREZnWVBsR3BpcjgxV0xLU3JkYUJhMElHaVNjVTdQbUhJ?=
 =?utf-8?B?MWdHM2c0ajVpSGM0OFFkNDgvOW4rUjNValZIM2Mwd3NoQWVDV2xPbG5oVEVz?=
 =?utf-8?B?K0NoUkk4QVhQbjNPVFNDNXVWTjBzV2FoS2pkem1OYTgweDc4bkdCa21lVnAr?=
 =?utf-8?B?MXdrZHU2SitYbFNzWFVQeDM2eVVXbTM1V0ZMZDc2VjQwQUV1NVFkU1R6T09K?=
 =?utf-8?B?Vi9PY1M2ZXZycXdvRyt3M0lmbUpkUzRGQVpiN1E5QjMxRE9aRmZmSzNyS0ZJ?=
 =?utf-8?B?VWxuRmJjU29Ub0w5N2o0T1BqckhBcTE1V09kQmpmM0JGWllaOWltbGJDMmw0?=
 =?utf-8?B?Q3NFN1ZTeUdqc0tFYzduWVJoNnU0L0kzM3pGK25Yb2dhS2VLclBRNURPQzNH?=
 =?utf-8?B?TWc3MStvYlhaN01zTjdZMnZkUjdMTStYWXc5SWttN2FTcU9JN0RJeFhuay9z?=
 =?utf-8?B?VmIxVUZHbjBPL2o2RTJyUUYyd1ZKd0Vtc2NQUkUxTnYxOFh6NkhBVlJqQzdJ?=
 =?utf-8?B?ckhZemVERTc0TjJ1YUpPeEoyTWV5YnpxNTR4R3YrVnpKWTdmRFhKTGh6eTA4?=
 =?utf-8?B?eTdManhQQUpFdm9SYVE5S3hNN2pNMU9RdVNnank1RnUvd21UR0tUY1NvSXJw?=
 =?utf-8?B?Ty9TT3lSVjRCN3pMTlFoYmJCV2ZuZ3FSMkQxQTNEbGhMeUs5eWZ5ekxpTXoy?=
 =?utf-8?B?SFppcEt2dm1DcFNBa2Y4YlM3Y1g1MVNUVzZwb3V0Wno0NEdOUG02cGxwSWlv?=
 =?utf-8?B?OGl3ZkNSenhGcWdDSE14bVA0ZldHRDhPODRYejhVSW1YOS83WXZsMjNZb0Qr?=
 =?utf-8?B?RjlGdGIxRVpMRVJXdFN5bS9MdWgvcFZzbDZSSVRqak5KeHNUS3BDYktFSEk0?=
 =?utf-8?B?WGVSWDhuaTFjWE15d0xFdGZiYVVacS92YjNOelpvc1g2Y051eEhJTGFxQTRV?=
 =?utf-8?B?aElmSXdXNTJXWURqVDdBTFVUUWdobERjZngrQVp6YjhmUkx5MkJ0N01BNlVk?=
 =?utf-8?Q?vqNOA9cRiqoyxYEdOdb9WIQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 242741f6-e0af-4f10-9938-08dde959d2be
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:16:55.7864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69KFNqjrV//M64YBf8OzEOAdr1typjN4I4ZpL/VoMyQqvj3qSRKXwnxFwKdMIVdhGRnqra+mK4BPj9W+tBcMz6ysL0s09l9ZjVEPu7e8VFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5898
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

I think to get an answer we need:
1) Physical address map of an7581 chips. Could you ask it from airoha?
2) Find out a list of devices that supports DMA with 32-bit addresses only.

If there are two (or more) memory regions (like in
https://developer.arm.com/documentation/100961/1100-00/Programming-Reference/ARMv8-A-Foundation-Platform-memory-map)
we need to configure them separately (see
arch/arm/mach-exynos/mmu-arm64.c file, exynos850_mem_map array).

If we have a single region started at 0x80000000, but there is a device
that supports 32-bit DMA only, then we should split this memory region
on 2 regions. The first will be limited by 2Gb, and the second will
cover rest of memory.

In both above cases we will need to restrict u-boot to use only first
memory region (not dig it yet).

Regards,
Mikhail Kshevetskiy


On 23.08.2025 16:26, Christian Marangi wrote:
> On Sun, Jul 27, 2025 at 03:03:30PM +0300, Mikhail Kshevetskiy wrote:
>> On 27.07.2025 14:58, Christian Marangi wrote:
>>> On Thu, Jul 24, 2025 at 01:30:45PM +0300, Mikhail Kshevetskiy wrote:
>>>> On 22.07.2025 21:44, Christian Marangi wrote:
>>>>> There are multiple version of the same reference board with different
>>>>> RAM size and it's not enough to base the RAM size entirely from DT. To
>>>>> better support it use the get_ram_size way to scan for the actual RAM
>>>>> size of Airoha SoC and increase the size of the memory map.
>>>>>
>>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>>>> ---
>>>>>  arch/arm/mach-airoha/an7581/init.c | 23 +++++++++++++++++++----
>>>>>  1 file changed, 19 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
>>>>> index d149e0ee3c8..0f72365c4ab 100644
>>>>> --- a/arch/arm/mach-airoha/an7581/init.c
>>>>> +++ b/arch/arm/mach-airoha/an7581/init.c
>>>>> @@ -2,10 +2,14 @@
>>>>>  
>>>>>  #include <fdtdec.h>
>>>>>  #include <init.h>
>>>>> +#include <linux/sizes.h>
>>>>>  #include <sysreset.h>
>>>>>  #include <asm/armv8/mmu.h>
>>>>> +#include <asm/global_data.h>
>>>>>  #include <asm/system.h>
>>>>>  
>>>>> +DECLARE_GLOBAL_DATA_PTR;
>>>>> +
>>>>>  int print_cpuinfo(void)
>>>>>  {
>>>>>  	printf("CPU:   Airoha AN7581\n");
>>>>> @@ -14,12 +18,23 @@ int print_cpuinfo(void)
>>>>>  
>>>>>  int dram_init(void)
>>>>>  {
>>>>> -	return fdtdec_setup_mem_size_base();
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = fdtdec_setup_mem_size_base();
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_8G);
>>>> Can we use a memory size passed by airoha trusted firmware instead of
>>>> playing with  get_ram_size()?
>>>>
>>> Hi I received some feedback from Airoha about this and sadly it's not
>>> possible. There are too much version of ATF and only some of them
>>> provide RAM size in some way or another. Also there isn't an exact HW
>>> trap to read to know the RAM size hence raw testing the ram and not
>>> depending externally is the only solution :(
>>>
>>> I will address all the other comments.
>> great.
>>>>> +
>>>>> +	return 0;
>>>>>  }
>>>>>  
>>>>>  int dram_init_banksize(void)
>>>>>  {
>>>>> -	return fdtdec_setup_memory_banksize();
>>>>> +	gd->bd->bi_dram[0].start = gd->ram_base;
>>>>> +	gd->bd->bi_dram[0].size = gd->ram_size;
>>>> as I know u-boot can safely use only 2Gb of memory, thus it's better
>>>>
>>>>         #define CFG_MAX_MEM_MAPPED  SZ_2G
>>>>
> Sorry for coming back on this but by declaring CFG_MAX_MEM_MAPPED 
> aren't we limiting the memory to 2gb? Also these info are passed to the
> kernel so we are limiting the RAM also there. Am I wrong?
>
> Also I notice the weak function dram_init_banksize is exactly the
> current one with the usage of effective ram so I guess I can drop it
> entirely?
>
> Can you help me understand the usage of MAX_MEM_MAPPED and confirm this
> doesn't limit the total RAM when loading the kernel? (we don't use ATAGS
> as we use FDT)
>
>>>> and replace above line with
>>>>
>>>>         gd->bd->bi_dram[0].size = get_effective_memsize();
>>>>
>>>>> +
>>>>> +	return 0;
>>>>>  }
>>>>>  
>>>>>  void reset_cpu(void)
>>>>> @@ -32,12 +47,12 @@ static struct mm_region an7581_mem_map[] = {
>>>>>  		/* DDR */
>>>>>  		.virt = 0x80000000UL,
>>>>>  		.phys = 0x80000000UL,
>>>>> -		.size = 0x80000000UL,
>>>>> +		.size = 0x200000000ULL,
>>>>>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
>>>>>  	}, {
>>>>>  		.virt = 0x00000000UL,
>>>>>  		.phys = 0x00000000UL,
>>>>> -		.size = 0x20000000UL,
>>>>> +		.size = 0x40000000UL,
>>>>>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>>>>>  			 PTE_BLOCK_NON_SHARE |
>>>>>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
