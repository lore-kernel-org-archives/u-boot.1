Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8819BCA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 05:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C0AE82A9E;
	Tue,  9 Sep 2025 07:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="EpAtTtUI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 521F8830B4; Tue,  9 Sep 2025 07:36:46 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F02880422
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 07:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THmp52oOcAUB8e1gW0KDNSBUxz22lGCaWwZiiYzVJ4Ij9i0feLVK4sbDgstyvG08bJh6XxLRayKvTsnrjyg84HhxKwkCTyDIOLyCH6jER6UU+5/hkHUW/XPuzkf/gX0Gjhs4M/857QHpsqE6kXbHrGvsjvvtahnXIuQIsdAMP4cdfLVa/ulOgeun3z645dl1s8uuISVGOMvfiaGabyTj62LLRRqtzaAOGzusr7+L5PV1F8n7Nw0g5LABc0f3xdNzdRcOUKSd3WifeWCviauS73UopfqzLwh6c/bUBqHUwTUa36sDyQuq6yMNk4jIGSsRqpQUEKm9Chrr9eiTXnE/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTT8Jyt70bXOZ8jQa6pMto71eEsPRzAmGZ2SiHhyuWo=;
 b=iR/bGqICgduMtPCifm1GnyDpJ93tSIIHHMPv6DWncG+hsx+/AhnPDjqrDPj4hNe4en+hVihyI3nz8z2UiI4ZxQ7JqTpnJrQlX0t6yli6Qdy0Mmx3UMeZ95igy2D0FwAg8Uf6pqhc1QDEhBgwYqPdDc9de+WQN2x1PtCcD5HlGgdkD9H5mvbOpVsJPjmQB1sNUCOk7PYG/aMoNBzPttaU3yMNsMgTliSbqZTaUpHMYIjTYCy7oa41a17WE5gFfdPStj7JECWv/A1iPr8l9jiqqosxVXvMiRSAMbJnc7DAL04fAuDj3cbXnE+eUmCyVghRVlI87TKgPaTzXFd71ZXJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTT8Jyt70bXOZ8jQa6pMto71eEsPRzAmGZ2SiHhyuWo=;
 b=EpAtTtUIGJb8jN3/f/se8ZoZ6gcVJ7JOBZRevDmPHPchFENgzxUsrqydT4JEHIgKBC32jUX2BaH5pnIkkChNTqOk9HF0dnmxjb6yLY7Bwb+FYCbKEHTBtsuKKaFkxgpAiJcBu4Ft3MUWaEXsoojeYbil9Dbgt8nIZ/uHIZc0A+E/1rI32ileebdBO8rOTVAhvaMwOUBOqy8OS5lekc/eWlpL+50t+64ZKy+myhuG8cAtJqlXCFKztvr69ILHkDxjm91AcHjp2w4OliJ96m4JcIqJSM8Wir9sEM9Z6Fo8nPvGn3irTFXHPIpvFKWSLBIhovxH9+GMKZ9oZQsaar+YzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by IA3PR03MB7667.namprd03.prod.outlook.com (2603:10b6:208:503::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 05:36:39 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 05:36:39 +0000
Message-ID: <a294b873-1002-45d7-a9df-dff81a1a5675@altera.com>
Date: Tue, 9 Sep 2025 11:06:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] configs: Increase USB Hub debounce timeout in Agilex5
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
 <20250808100412.9320-4-nareshkumar.ravulapalli@altera.com>
 <7cfaf6cb-38b9-4932-8904-ce7be12a5098@mailbox.org>
 <69597595-6c7e-441a-952b-16b80fd60aca@altera.com>
 <e3107726-6980-4330-aabf-aef1ec9f5562@mailbox.org>
 <bff0c320-35bd-4129-9e19-4ef4103ba923@altera.com>
 <ea637053-8f40-40c5-b257-e582dbbc3c1b@mailbox.org>
 <3168323f-8cd4-45a9-914e-fb79cd346d67@altera.com>
 <c5b7a8b4-2674-4857-a9f0-0576c1602f86@mailbox.org>
 <0c103ea7-07af-4d01-a1e4-3d4d4819657c@altera.com>
 <74c4935c-1f8e-4fbd-a595-37fdc5c6ac3a@mailbox.org>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <74c4935c-1f8e-4fbd-a595-37fdc5c6ac3a@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::6) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|IA3PR03MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c339a80-eb0d-41c7-bd33-08ddef62d941
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sy95YmxLeVg3eXpETjdnS3J5ajNxakExTjVXR1UyalIzdEhueXplRVV2T25Z?=
 =?utf-8?B?SzRMMmQ5bWUxR29QRTEwMEMyOUgxOGRrQXF6aUIvZGc1a2lZNGMyaFVITzFM?=
 =?utf-8?B?RE9DTENjU2I3NmpXNWtWSDhwL00xWWpTQkhRcFNxcFg3Q0thMUFBTkhTaTZO?=
 =?utf-8?B?bHRJd2lsMHpJdlJ4djZGYjR6ZzVrV1dpTzFxWDRBZ1pnNk5DRXNCVHk4Q1Jw?=
 =?utf-8?B?SDN4Ymg4a2MrZmYvRVlFT0JWTmRqRHJQUVI5bDB2a2hqVXRNNklncGNBcENF?=
 =?utf-8?B?M01MS1VyeXI2MDFDSmNRdTVlbzVTMzc5STFVMm1FYlRFam9iL3VsYkF1RlhW?=
 =?utf-8?B?MWxOUWQ4aWFwYm9kcW5ua1BpOWRlSm5uVURSRkp6VEhDUklkVUJvSkpFSUF3?=
 =?utf-8?B?WElGNFk1cjY1bnpUankzZitFVE9ER2c0SWJTRFRGUUF5VUJybXRXWHZsMGpP?=
 =?utf-8?B?dGVwRXZxY3hHRzlrVFJOR2t3MUFwcDRBN0JYZFFJeS9NaXhmSVdNYkY2MGxL?=
 =?utf-8?B?YXl3OGVHZlZrc3NxZUhQNElianJIWldZV1JPVXlJOG5YMVI2OGNJZTdKY1Vp?=
 =?utf-8?B?V05FRm90RElGYlVrNFlHU1JKNGFKWDVRMWY1SXlUdGtPU3RjSHhMVjBjRVhP?=
 =?utf-8?B?ZGVTa0MyWlNrSGUvQkVtNWt3dWM5WmJpVnAycXVrWmowMStvMTNzVUFQZThP?=
 =?utf-8?B?dUNweU9EOGxMSU8xdW9KUjkrWmJwMWxFL2NQZjNXWEZOZ3VPcXdTQUk0dUd4?=
 =?utf-8?B?SjBKRGZEWDhTalJQQllmcUNXU2VTVlU2UzRXaTdDV1Q3ckF1M0dJK2x1UmY5?=
 =?utf-8?B?bFdlaUNuZmlwNVBYbkhFMHJNYjMycUpBVDZ0cXJxL2txbWYybXkvbkl4RFFW?=
 =?utf-8?B?VVVta0dyZzkzRVgwZlVpM3lXMlFEMFZpMzVybHlKOTJET2FYcE00NVFDWHJJ?=
 =?utf-8?B?aGo1eDRUU3phZWxQeklQSlIycEp2bkp2azdDRC9VVlpjL1hwN1BXb1gvMkJV?=
 =?utf-8?B?RElDZGpxN2dDRmp3c1JYV2V3S2Z5UTJTRjN4clMyRDVNNXN2WmIvQXhtN2dN?=
 =?utf-8?B?U0ppUnhHcndablp4eE81M0lsVUFaSFVVTXllZnk1TmNNbVpCSWZ1ZjliVlMw?=
 =?utf-8?B?cDhyMXNSTGxnMUl2VTVxTmtjY1FIMmRHdnpDNlBZdHNsRVFJemJJSElEN1or?=
 =?utf-8?B?aGwwLzVYOG9JSHJONmZlNlNLc1BJR3RxYlRVSHlMSnJEb082SHBWRnRvajl0?=
 =?utf-8?B?SDhNZE1GK00zMUowYVM3LzFBME1xVm9ZNlRsSDgwR0lpeDFMVEc2b1AvcDlX?=
 =?utf-8?B?Zno5c1hqd285d1d0cTI4UjcvZGtwbTBrL2w3OFV6ZjhXcU9NaDI2b245MWNw?=
 =?utf-8?B?SHRaUmlIWU1aeXNsbXVRUzFGNHpicEdHbEREVDFxRVltbGs0WXU3amVKbERX?=
 =?utf-8?B?eDB1N3VxbTNzZC92QmRYN0x1ZlFjaThnSFdIWlpPaGZYOWh4QkExL2NKZ1Bi?=
 =?utf-8?B?ZCtXNzJXYnNwbXNseHIvWkNtVGxqNVN5a3RzYWhtVmt2VXBkMTNYODR2NEY0?=
 =?utf-8?B?VTgrZzBZeURsREp1dzkxMVY5TStSTVh4bEVHMUh0ei92K1J6SkVkN2xESmxa?=
 =?utf-8?B?TkxHME9jRGlsUDVmV2Q1Wm9sTkF4UURwSlFIcU16VTlNNUF6ODlMTjdiU2RX?=
 =?utf-8?B?UjdzNVVva0N4amtMQzFrS1VDOGpOR1FXVWFkdzd3T3NjM3ZueUxOeFBmdnRJ?=
 =?utf-8?B?QUhMUnpSbEZqM3RFNTl0TTN5ZzBNRjVTWHQ5QnNMbXhzaGNkNXBpVlRHYngv?=
 =?utf-8?Q?ATKevf45DFESBWSAH2SARt/XqDJc8xi97Y1e4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnRaUmNZWGpMeHUxWTV5YncxNnNGajNOTm9QWFMyMXhPS2puWVJKY000czJ6?=
 =?utf-8?B?OG5NZHdlL01OcmFJVHMzcTgxTklwbjBVS2IvZEZyOExzMnFVak1xaWlzb1dN?=
 =?utf-8?B?VUhUTThLeVRjMnFXVWtZYklaTFAra01MUEhIejVnMTJzbnNabHRJdy9KOWhN?=
 =?utf-8?B?djd4blRiOUgvV2h1UjBycUw0a0J0bWNPQzgvZ0FYaFlhTEIwVnlKVlFGaHZL?=
 =?utf-8?B?Qm4xbytlYzFGQWpQdk4zaEVmRzdZdzhCeUNZRXVudHg3VzJGK1ViME4xYnIy?=
 =?utf-8?B?VzNDRDNtVFRWREJFSlY1ZklIdUZWVlZldEtxc3B1Q2l6L0tiYUFhYnMvV3M1?=
 =?utf-8?B?bzRsUC9rVURmcUpBdEordm5FcW1tT25LalRCdzBIM201cHpUNUVCOVJ6V2Qz?=
 =?utf-8?B?Sjh4amtWb3JIMFVkbnBrdk1XQlB3L0hGaHFPVkpwK09Xcm1ZMGMyc3ZEY1VL?=
 =?utf-8?B?VHFUQVU2b25LOEdFaCs5UWdqeTh0ZWc5L3B1cUV0RDRCNTJlRnhaVFFac3N4?=
 =?utf-8?B?UHhQOXRrVGdZdG4xMTExWVErOUszNThvSDBpd2JBdmZMa3l0R3JjOU9rV3h3?=
 =?utf-8?B?aXE2THBVbXJoTThNRWQvWmpVTGdQWEpJV01MWmxncCtoZ28vcWhGV3pHL3Rh?=
 =?utf-8?B?dzlha3FXN1dLL1QvbEM0NElJM3grYVFtREpKczFiVy84L3k0RW5BMHM4eU52?=
 =?utf-8?B?ZXN5TEhGTmxHN2VmWEFVckQzUkZ2c3VNU1YyVnFSdVZQckJEYzYrbXU2M083?=
 =?utf-8?B?RlNqSUJXR0VmT0JZQ1BId24wYVZiaUUzZ2J5WFdraUNBV2lsbnZXanVQdzZp?=
 =?utf-8?B?cnZGcXdHMXFTbXc0UWdjcW5EdnlyRzQ2alZRNnNDRkdzZjRDWCtYNzJETlhO?=
 =?utf-8?B?TUMyVTVML2ZOWFN5V2ZrVVVoUXR1STZYMm1HbjA5bVN1bFN4MHhQemk5MkU2?=
 =?utf-8?B?UnZxVUZ0UWNEVE1xS014bEJTbG9aNjI3SFVoZ2RmeXMzNE5zdjllTGlreGVB?=
 =?utf-8?B?ZTFhYW5aQmd0NlFQdUwyZ1c3NnJEZEwzSXRZdG41L1ZRYjZvSkQ5R05YcDJL?=
 =?utf-8?B?K3B5a3p2QUhIVXUwYmFDRWxYSTlxTEh0bWNqVUFPYmJORzNLSW1sVlVSZTYr?=
 =?utf-8?B?WFBNMHZsbUpxSVZWTHp5cEFGWEpUUGhVMFFRTVlXRjNtVFRqd0xiS1hJUlVH?=
 =?utf-8?B?azNiWXBlaWx1SXlEU1hmWCtpUGM0VVBZRGtRa1k1UHpuWGd6dGorNlBjNyt6?=
 =?utf-8?B?WUoxWWFFbWNzSlhiR2loL0o4eW1QVStQMnVNUVVUWDhKT01LOXpDUjlKN0I3?=
 =?utf-8?B?V3d3TWU3dVhpb0ljQ2ZhZ0IwMkJHUS9mTmJmRkNBbGtoZnBlTVRYSkdhU2Qz?=
 =?utf-8?B?S0JpSW5pc3MyTVZOTnVzUThCb2tBN2pVOVp6YWpBTXRXTkVyRzI2Y3ZKYWNw?=
 =?utf-8?B?ZE9QWE1FdXZOeGVCZVR6U3hGTFFKRWdJUW4vaFBtYTZxTnIzM0NnOXNNRkxJ?=
 =?utf-8?B?cTc1Wk80c09NY2FPV1lIVE43RWF5bVlNaS9BbTRZR2RWQkdzRm5hMFo3ai9k?=
 =?utf-8?B?ZXpLSm96OG90NUVqdU81eENmcnVIYkt1MElUeHVjdVBudFBEYmY3MnQ0MS9U?=
 =?utf-8?B?NzlLYkwxVGNBTDFRQ1NkaGc3aUxLV0cxWnZadWczaE1vcDlIYTlyUGExNHFy?=
 =?utf-8?B?TWNMVnZiUjVjYmhMOStQTVhpOVRXaGJPSFcxaExxNzVNZXVqNUt0ZVFvM3gx?=
 =?utf-8?B?cjBEVDdUdlZBdFVxUzZsdHlOdThJVTB0RUwvSldKL2hIQ1VqWDlJTDVvTEtE?=
 =?utf-8?B?T3FkcjU1c0JscGhmbTJyenJtRzEzM1htcGpobDVOSnZMK3V5T2w2U0t6NHl3?=
 =?utf-8?B?SU9TYWZ6NmV2bXE0a2dlQ01DT2NUVzZPMlpsb09tMUloVEJGQWNiNUVpUU1m?=
 =?utf-8?B?Z3FNMWd6WTJLZUlBbEV0SHpXcDhKM2NnWHJhbmdBQmd4R0tOckZWZ25keEdo?=
 =?utf-8?B?UlJwelBaL3BzSXo5cFJWTEJoRFJQNERTa3J6cnI0TUFoQk9xWHUrQVJiS2pa?=
 =?utf-8?B?RGlTb1BlcldmVnZ3SFVWaXJ0SWJVZDFnUHkydG9CTmQ3dFNVb3lEUE4wOVF6?=
 =?utf-8?B?WkY1SHJpbTJwVDhjTmJtR1YwVnRGUG1BTGFObHRDeENMUEZDcVViY01TMmIr?=
 =?utf-8?Q?5CtEBCTmR+TvK5n23pjYt5E=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c339a80-eb0d-41c7-bd33-08ddef62d941
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:36:39.2455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpPdbLp/ry/sTR5C3Mu+uZtWwOdF6Bfdz5YsPWMqwhzqY9Lau2CRlD7A28AX56MQZPiUklrQPaQP1o9XfLpHvYVx6hYtAb/+BWUmqctNSGfPNelXniSATW9AODBaQ2Rs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB7667
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

Hi Marek

On 09-Sep-25 4:32 AM, Marek Vasut wrote:
> 
> On 9/8/25 3:41 PM, Ravulapalli, Naresh Kumar wrote:
>>
>>
>> On 08-Sep-25 6:32 PM, Marek Vasut wrote:
>>>
>>> On 9/8/25 10:44 AM, Ravulapalli, Naresh Kumar wrote:
>>>> Hi Marek
>>>>
>>>> On 02-Sep-25 11:48 PM, Marek Vasut wrote:
>>>>> [CAUTION: This email is from outside your organization. Unless you
>>>>> trust the sender, do not click on links or open attachments as it may
>>>>> be a fraudulent email attempting to steal your information and/or
>>>>> compromise your computer.]
>>>>>
>>>>> On 9/2/25 9:52 AM, Ravulapalli, Naresh Kumar wrote:
>>>>>>
>>>>>>
>>>>>> On 30-Aug-25 5:30 AM, Marek Vasut wrote:
>>>>>>>
>>>>>>> On 8/29/25 6:19 PM, Ravulapalli, Naresh Kumar wrote:
>>>>>>>> Hi Marek
>>>>>>>>
>>>>>>>> On 29-Aug-25 2:11 PM, Marek Vasut wrote:
>>>>>>>>>
>>>>>>>>> On 8/8/25 12:04 PM, Naresh Kumar Ravulapalli wrote:
>>>>>>>>>> Some USB devices need more time to be initialized. Hence,
>>>>>>>>>> increasing the default USB Hub debounce timeout value for
>>>>>>>>>> devices to be discovered, connected to Agilex5 boards.
>>>>>>>>> Is this really hub debounce timeout or usb_pgood_delay ?
>>>>>>>>>
>>>>>>>>> Which devices are those, include that in the commit message.
>>>>>>>>
>>>>>>>> Yes, timeout is related to USB connect/disconnect signal bounces 
>>>>>>>> not
>>>>>>>> about bus stability during init.
>>>>>>>>
>>>>>>>> Issue was mainly observed with legacy flash drives. Maybe I will
>>>>>>>> change
>>>>>>>> commit text from "Some USB devices need more time to be
>>>>>>>> initialized..."
>>>>>>>> to "Some old USB flash drives need more time to be initialized
>>>>>>>> during
>>>>>>>> connect or disconnect events ..."?
>>>>>>>>
>>>>>>>> Note that I am not modifying the default Kconfig value in general;
>>>>>>>> change is only made for an SoCFPGA devkit we tested.
>>>>>>> Does this same issue go away if you set usb_pgood_delay to 2000 or
>>>>>>> higher too ?
>>>>>>
>>>>>> No, changing USB HUB debounce timeout is working for us.
>>>>> Look at this code:
>>>>>
>>>>> https://source.denx.de/u-boot/u-boot/-/blob/master/common/usb_hub.c?
>>>>> ref_type=heads#L199
>>>>>
>>>>> "
>>>>> #if CONFIG_IS_ENABLED(ENV_SUPPORT)
>>>>>         env = env_get("usb_pgood_delay");
>>>>>         if (env)
>>>>>                 pgood_delay = max(pgood_delay,
>>>>>                                   (unsigned)simple_strtol(env, NULL,
>>>>> 0));
>>>>> #endif
>>>>>         debug("pgood_delay=%dms\n", pgood_delay);
>>>>>
>>>>>         /*
>>>>>          * Do a minimum delay of the larger value of 100ms or
>>>>> pgood_delay
>>>>>          * so that the power can stablize before the devices are
>>>>> queried
>>>>>          */
>>>>>         hub->query_delay = get_timer(0) + max(100, (int)pgood_delay);
>>>>>
>>>>>         /*
>>>>>          * Record the power-on timeout here. The max. delay (timeout)
>>>>>          * will be done based on this value in the USB port loop in
>>>>>          * usb_hub_configure() later.
>>>>>          */
>>>>>         hub->connect_timeout = hub->query_delay + 
>>>>> HUB_DEBOUNCE_TIMEOUT;
>>>>>         debug("devnum=%d poweron: query_delay=%d 
>>>>> connect_timeout=%d\n",
>>>>>               dev->devnum, max(100, (int)pgood_delay),
>>>>>               max(100, (int)pgood_delay) + HUB_DEBOUNCE_TIMEOUT);
>>>>> "
>>>>>
>>>>> Changing both usb_pgood_delay or (CONFIG_USB_)HUB_DEBOUNCE_TIMEOUT
>>>>> should have the same effect. How come it does not ?
>>>>
>>>> CONFIG_USB_HUB_DEBOUNCE_TIMEOUT and pgood_delay are used for different
>>>> purposes. If I am not mistaken I think I explained this in my earlier
>>>> comments.
>>>>
>>>> Anyway, to further elaborate, CONFIG_USB_HUB_DEBOUNCE_TIMEOUT is used
>>>> for debounce timeouts during device connect events and pgood_delay is
>>>> used during initial VBus stabilization.
>>>>
>>>> You would be able to see this difference in the link below, where
>>>> pgood_delay which is populated into "hub->query_delay" is used for
>>>> voltages to stabilize before initiating communication and "hub-
>>>>  >connect_timeout" where "HUB_DEBOUNCE_TIMEOUT" is populated is used
>>>> after getting the port status.
>>>>
>>>> https://github.com/u-boot/u-boot/
>>>> blob/328747974a0620d0996113fe2b3906b06e96de00/common/usb_hub.c#L455
>>>>
>>>> Also, the change made as part of the comment is not applicable to the
>>>> USB stack in general; it is only for our devkit defconfig.
>>> But none of this answers my question, looking at the aforementioned code
>>> -- Changing both usb_pgood_delay or (CONFIG_USB_)HUB_DEBOUNCE_TIMEOUT
>>> should have the same effect. How come it does not in your case ?
>>
>> Maybe I wasn't explicit in my earlier comment, "No, changing USB HUB
>> debounce timeout is working for us."
> 
> USB_HUB_DEBOUNCE_TIMEOUT is basically the hard-coded-into-U-Boot-binary
> version of "usb_pgood_delay" . The upside of "usb_pgood_delay" is that
> users can change the value at runtime, which helps in case users need to
> use some broken USB storage device which takes more than
> "usb_pgood_delay" ms to start up. You cannot do that with
> USB_HUB_DEBOUNCE_TIMEOUT .
> 
> Since the commit description talks about "Some USB devices need more
> time to be initialized." , this looks more like "usb_pgood_delay" type
> of issue.

It is a debounce issue, I will modify the commit message to state this.

>> What I meant is I didn't want to modify usb_pgood_delay as my issue was
>> with HUB_DEBOUNCE_TIMEOUT, so modifying this value worked for us.
> 
> Does it also work if you modify usb_pgood_delay instead ?

