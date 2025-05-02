Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4163EC3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 09:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2B4D81E72;
	Fri,  2 May 2025 11:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="f0MRFuO9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B5B480F03; Fri,  2 May 2025 11:38:21 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5540281F7E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 11:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WllEzTwXmumQd2mOiX/xrzaAT46ifU418ZM8dXySha02Uor6a5qf/tq0gfLtBUSEQZD4efpodfiwSk2jrQsYHZq6MWkBzEhBo1qDv0ZbT8tFDcg71hqCDLnTCt4eau7FGk/xu/t/6pAhuD0F0Kk0NHEDerQdU/0GkV6eDRTculSHAcWYFeB24CwfLLjyEIvyrZuPjBHyQJIQwDmdtMexFQL6CCK7vSOXQjT3sxGVfP0j4BweqFQFBogPbigW4go6SBNJokMhgS18NdvWg0rQfDJRlmF0yAsMugnfxzeQOHjiPs9h+fEplBEPYOltlHvZ3rjdFKy6jzEzeByi2hJHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLeh6lcUXmhJ+KPNteMgP+IXuCWRl7scZSb6PeRX8mE=;
 b=edztEQ9oRm5L3LfHq0JZlfdimYa5CW+TLFrPQsHvBu96gaOGd34mbiz8Qvnn0QRgMb0eULApXeqNfTRU0BGV3h2NgmCTjk2gmrC/+jTwkEcx7f5lRYuZxfHHz15O231jqivxif94qthOKqSgubgkKClj/EE/P0WfSKrW9w1NM4syHvK9/qj3jD7pWvgmRC2Xl+BfR9hSGUGGY4etNTzaiDN1MiXH07z1cstrD6EdYqbboKhZMfa4DTYjoj37oJYgOXg9lbqp9FTcUB6FybMPrTbrYkCo/l9gJLvVi/hXVHdY+8wzoGdNB/9050lrp/GBV2dka4R9y0S26UpcA8VH7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLeh6lcUXmhJ+KPNteMgP+IXuCWRl7scZSb6PeRX8mE=;
 b=f0MRFuO9iGCM3/8MNWD/qtGwLgzyRIof1wJT0Waq3tIzoc9FSJ5pPkWJGfcBPXEyuj3PR8aVATkJGEVNAcT6YpWQWe2oAXrFTJ67UrYL4GOqitgkVeXECRQULuxfl+XCdnbK9eLIc/4s5jh/FTJpkziO65oQ90ouCDlpiVrRGy1xCzocsFnfwnmzv/b/nl6JZisoh0BO/IS7Ew4YAM+M2DSdZzOlkhzV9LwgA6Olx10v0J5mAMUOD+NFM3MKU3J9AMSss9TXFjbJnVj76T1TLlfzumd44GFOFs7IVAJoqRbvCQalpR0Xr4xHRZ6FB16xLdFIHHW0tvIc+WbZLWBLTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by PAVP195MB2309.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:2f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Fri, 2 May
 2025 09:38:17 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%4]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 09:38:17 +0000
Message-ID: <235f58b4-6c3e-49ea-9a16-4eb0582b472b@phytec.de>
Date: Fri, 2 May 2025 11:38:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm: mach-k3: am62a: Fixup CPU core, DSS, CAN-FD and
 Video-codec nodes in fdt
To: Nishanth Menon <nm@ti.com>, Aparna Patra <a-patra@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, afd@ti.com, d-gole@ti.com,
 vigneshr@ti.com, n-francis@ti.com, bb@ti.com
References: <20250430104236.2611089-1-a-patra@ti.com>
 <20250430104236.2611089-2-a-patra@ti.com>
 <20250501122848.jaun54umcun6ijs7@domain>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20250501122848.jaun54umcun6ijs7@domain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:303:b6::17) To VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:248::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2484:EE_|PAVP195MB2309:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b076a8-026a-412a-ae74-08dd895d1112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3pmclRDMWxDMUlCT2s5RDhHanBzV0ZVRFhxMTdoZzc5Mi83SWczZ2txTWt1?=
 =?utf-8?B?NWR2dnZKSjZURjlPaUh1UFExWHNReGN5VnhPU2FydjRhRWdRRlE3VExHYVVN?=
 =?utf-8?B?NFkzVTVjTUI3ak4xZVgycXNhWnVzbDRkREhrMkw1bDhSR2p4anRXbmZmM2hm?=
 =?utf-8?B?Q3dGZHpoVU5nakNET011eXQ2KzR2NTRoZW41SUs0WmNDRStoUVMzMUUrZmtn?=
 =?utf-8?B?RloyNWtSS2RnK3lXYVFFYk1nclBtblQ1VkFNS3BYWGlqUlhYT2wySVRVbTY5?=
 =?utf-8?B?UmVTcG9HaGJtLzZteEgvVDM4VXFJZmdyc3NiK1NnWmVLOGNZRDVMZUMycVls?=
 =?utf-8?B?bnhYbVdscHRIYk00a1ZTZnF6UnMyd294WGZRWTA0Z3I5YWg4emxuUmlybWZW?=
 =?utf-8?B?ZTl4TmhEWit5QkNZSC9qYmN4bkNQOHUxQ2lYM1J3TW5ncTluSEpJZmt6L3pa?=
 =?utf-8?B?a20rTW9VNHl4UVZnY3BLUnpXekdnbWt1YUN0NDc3N0JrR1pZSm81R1pxVVhl?=
 =?utf-8?B?UEdLVGs2dTdEWWRBRDFGV2oyckpuUTlXbGVMUlNzejlUR05sLy9GN0VHcTA3?=
 =?utf-8?B?RElKYldNLzdJR1pSZTVURHVOcFRjNm80WUhkNFhzZzlSdnY5dThlTlAwMmZx?=
 =?utf-8?B?ckVZL3lPanROU0MzSjc0YjhKMTIrMWNyZzBvOG82NlZnQ05zRHJnM0FqaUd2?=
 =?utf-8?B?RnN4OHRLTW9iK0h6R1lydEFBRTArMzMvZUV1L3dCaUhxdGhDK3RxN24wVWU0?=
 =?utf-8?B?bDNZdUMvOGdZc0FPRXA4RC9QV3ZNYkwyaXNPakxBSTlQUml3aWNXNjhab210?=
 =?utf-8?B?Mm5BRHJqT0NYbS9NTUc2bjdKUnZOeWIyc29tNVBvSEJMN3BQaDF1a2c5ZGlF?=
 =?utf-8?B?YkVyV052elQzRmlTeUs0M3M1YlYyQXlLNnZzeVp1a0grYmpLd3cwS3FnYWc0?=
 =?utf-8?B?b1ZTVE5FWndrckJYUlQxRVlrNU5xR3VETDU5TTVuYjJGcWdNL1pYS0hBNzhi?=
 =?utf-8?B?eDVuenFtMXZqaGhmdldPb2xBUmxyaWFPVy8zMG04QXNJTEFaN08rZU9vZUtE?=
 =?utf-8?B?eW05V21zVEVwajlEdEE2VWdPUjhEVDF4azBYWVYxMkdOcjBudnI4MjU2V1dJ?=
 =?utf-8?B?TVdMMHpDaU5FRjNhZ2hOVDRxQWlLalhBVjNwZ3NGWklOK1pWdDVxUXBqNitw?=
 =?utf-8?B?Vk0rTjdTOUYvak5hbFJ1QzVaRjZIem93VmxlQ3d3NHpxODJGdWxwYnF0SUxP?=
 =?utf-8?B?bFdrbHhaTEJtT2QxUWp3d2c5N3ZxaFE5NHFDdW9VaFVwZXlTYnJyTTNPZUdI?=
 =?utf-8?B?MXJLdjVUcGR3Y2FvN3IvWlo3aXVPUXRudWsxZkJTdG9yNHNZdTVXN1B3djQ5?=
 =?utf-8?B?QlJjUUlnWWNzcWVxOE56d2F1Smh0ZzQzWmpMaElYaWZicFpkODllS2xWVmow?=
 =?utf-8?B?NDJvb3pQSzVNZ0hGR1BTRnUxenV2MWNMSXpWQ0lOdHNNRTcxQ092b3ZNbXpp?=
 =?utf-8?B?Vlg5UmFYSWxjaGkvcTR4ZktsSnM2bUVwaExSK0h0aDJMdkkyL25PeDFWZm5o?=
 =?utf-8?B?TjlaMFZTR1JZNVJ1dHhMbzFrVHVPRlBpYi9udHh6QXhZZjl6SHBtdWFuTXJH?=
 =?utf-8?B?UXJMSXJTWnk0UlNnNEVuTDFOUXhod05iNGpOQ2l6cEFpM01OODhoUE8xOHVB?=
 =?utf-8?B?VyswWFNIdGxneHM2T3NNeVpPRk13ekRZTmhGN285RU9kcmhmQWxXUWxYME1J?=
 =?utf-8?B?d0VaT3FodnRyOXZJMVlrbmtRQXFrQXpLdzI5UFBFd1k0dzBjallrTk9aa1R3?=
 =?utf-8?B?QnJIZXZ5RjdDVEdraW9UM2ZHcjhwOVA5Q0hZcGdpR3NrZ3R1Mm94eWFWRDdK?=
 =?utf-8?B?aTFvQkJIc3A2U2pVUEhBVVpvOEJYRDRWdzRBUTdkQjRxOUFFdll2bTlRSkVn?=
 =?utf-8?Q?ZkFq76D9cZM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGUzNEtzbjJFQ1NlaTIzT1AyOTF2R2tlbkZHYWRJb2pRUzVreXFwa2J5ckUy?=
 =?utf-8?B?UFNiZXlxUE5FYXdKREZ5QVFSQ0l1TjQ3NU1YY2tzUXErMEFIQ2padnZ0OGFV?=
 =?utf-8?B?YW9RcEUwSzQzVWFPOUc0UEVra3B5bEdZRWNNNkRTS3JTbTJ4YllPek1Da2tV?=
 =?utf-8?B?dmtPdDJ5ZzBXWHdFd3dUQVpEblhpWGlTaUswRysrL0htQU1NWFE4bUxIeEh3?=
 =?utf-8?B?S0ZoN3U3ZzdVeVUvcEQrYktEcC90MkwzZFh1WVpydDNCMjFPVmRnT2Y2cXpR?=
 =?utf-8?B?M1pBOWpsSER1elVZRVUxQW1CaHpURVlqS1p0TGdHU1NSQWxLeEduODZPUmxx?=
 =?utf-8?B?TENYZ0UySnVxaXJ0dVlna0hpaHVhcHdwdEhyTEM5Y2N3UXZRUVZiYTI1cHh3?=
 =?utf-8?B?WXltRVUzdHE2RWhFbTJUSldlTGMzeFpVT1FrQ2FqSjdyc2VWRkkvbzZ6dnRO?=
 =?utf-8?B?Z21hRFNyN3hzSElvQ1hJTHJDQlNBWHAxNXZPTkpUQk1VbGw0dWtwTDhCeWdz?=
 =?utf-8?B?cVY3L3k0aTQ5M2Q3YUN3S244KzllSjhRdU85eEZkMm1RZTJCbjAwOHd4eS9q?=
 =?utf-8?B?VXhrNEVrT3BiekExc1liSitMSERWTGh4WHhHZ2RvRDBRWGxSTk5sRmt4TnVj?=
 =?utf-8?B?OUVjL0FVYXM5UWtEb0xINUduc1JnTVZ1QkduRVNjcWZUc1J2Tk16b3lWNFAr?=
 =?utf-8?B?Nkt1NEp5ZHNhdk0wMlZwV2lWWVhINDdwVjZOcGJWZlJwU0plTDhEOGpONXc0?=
 =?utf-8?B?ZEx2Qzk2QnRRUVVlTDBOblRtZmNzL3hacDNHb3BhbXpNMkVPOXJLc2RJYU9s?=
 =?utf-8?B?UDlkT1J2ZVBOeWZzWm1sbXNzcFJFZWk3OGh1dkFTT2ZUQ3ZGeUg0b0NLblBQ?=
 =?utf-8?B?MkFDbWJPeTdmSE9XV1N6VW4rQmNXWXpwQXBqSlpjQyt6SFFDTUEwKzJ2Q2xr?=
 =?utf-8?B?aTVLQXEvT1IvUTBISXFaaHEydCtRY0dQZnZYRGcvNkNNb3lsMFFVZmt5bm5H?=
 =?utf-8?B?UlJTUGNEdnRhV2pYV2JBQWlIaHlWallHZDdlckVOUVlENGdHYU5LSHhBaHNx?=
 =?utf-8?B?VkxaU2E4aHZablFTdnFKVzUvZW1mUS90UEg0T0QwYm1WN2o5dnlsY2RJSmE4?=
 =?utf-8?B?UHJhazd3cFFYOXFwSEJkS0ZqNzhMdlc0NUxXWW93VEtyRDZ3cDF2ajlYQ2l4?=
 =?utf-8?B?d1VhSHdyTE56b0Q3TUVLUlRhWmdEY1JtdFBVWlpQTnVYYjJOaSs3U25wQmFr?=
 =?utf-8?B?bTB2KzVsY0VZc1A0azA3R2VpUFRxR3pTRTFJUXlCRDRVNC9CQ3ZFQVVsYjRk?=
 =?utf-8?B?TGlBcHhxc2xvbmpjcXN6dDBYd1BmV2xETnVPVGd3VCtrWVJSZkx5MXV5Z3N4?=
 =?utf-8?B?cmdDblYwenppazJJRXVMai9Sc1NCY29TMjNleTQyVmptbloyN1pJekcvOTJT?=
 =?utf-8?B?Ny9TcjY0Y0V2RTZOSC9UQUdpeUFmU2NCVkpmb3M0VERYVUxqb0RsTVVUaGtT?=
 =?utf-8?B?MWtoQkk1WlptVUk2VTUrMkRKR1VLUms2V1J3NGtuVXN2SDJrbms5enNSbUgy?=
 =?utf-8?B?MWpQYjRZa2NTQnRkZDhoVEJyd1JINE9pd1A5ZWdwV1JZa1p0aXNnRzdUTHRK?=
 =?utf-8?B?TVFDZExGMGpZTGtsNTlRMko0MU10bVQ1UElTQUVKNzBkdDdIbGYrNHpwUnRo?=
 =?utf-8?B?dEdlbmF6QXRXSnRQaWdsOUVHQXJwTHpJZkNuanl1V3VRWUdpVnp6TStneDhB?=
 =?utf-8?B?d2pkcllrVG9NczZnenJ4NUE0UkZOdDlaejIxTlUvdGF4RTF4K1ErbU1LY1Vj?=
 =?utf-8?B?ZEN4a1VyNCt0M0xiZkRPcXQ0UkVRNlZEVFc3dEZIeFhMdjlxVEN3QW1iUUlt?=
 =?utf-8?B?ZThSZ24wY3ljNUZFbzVUc0lJWGpYdGREU1dkQXJxdEEzQ2tOYjRFUzR4cEdn?=
 =?utf-8?B?Uno2NXcrc2gwUFhwSTUzYThoc2lvU2grUXFPRGk4ZXVLdktvblVIdDlLb0xm?=
 =?utf-8?B?WUZsMHNpTTgwbkZ6bmJpNjdUV3hpa0laaWZsREYvNGNyS1hYZEV4S3FYNEk0?=
 =?utf-8?B?TUdVSjRGYUxhTmxmOU9VN1hYUDNXSlBjRURsUE5BMTQ1SnEzUlVtNDNMWk5j?=
 =?utf-8?B?M24xYmVpZDlkREJ1K3ZCdDRKY01FQ25mWkJENG9maDFlWSsyVWphL0xpRmtU?=
 =?utf-8?Q?w1d1Y0n555FM9i5GJB7eXiu4nvEYzISTvYTvWOxPU7ui?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b076a8-026a-412a-ae74-08dd895d1112
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:38:17.1315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QoM24sSMjOhPjZ+9FrRIPjt7Y1DEG5nSde3YMJZ4hb5vijkIiBlCqyEQGDJb98513etKfPj1YYAZKFX+jdStg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP195MB2309
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


On 5/1/25 14:28, Nishanth Menon wrote:
> On 16:12-20250430, Aparna Patra wrote:
>> AM62A SOC is available in multiple variants:
>> -CPU cores (Cortex-A) AM62Ax1 (1 core),
>>   AM62Ax2 (2 cores), AM62Ax4 (4 cores)
>> -With and without DSS, CAN-FD & Video-codec support
>>
>> Remove the relevant FDT nodes by reading the actual configuration
>> from the SoC registers, with that change it is possible to have a single
>> dts/dtb file handling the different variants at runtime.
>>
>> Signed-off-by: Aparna Patra <a-patra@ti.com>
>> ---
>>   arch/arm/mach-k3/am62ax/am62a7_fdt.c          | 41 +++++++++++++++++++
>>   .../arm/mach-k3/include/mach/am62a_hardware.h | 40 ++++++++++++++++++
>>   2 files changed, 81 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/am62ax/am62a7_fdt.c b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
>> index 7f764ab36b..56fd658202 100644
>> --- a/arch/arm/mach-k3/am62ax/am62a7_fdt.c
>> +++ b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
>> @@ -8,8 +8,49 @@
>>   
>>   #include "../common_fdt.h"
>>   
>> +static void fdt_fixup_cores_wdt_nodes_am62a(void *blob, int core_nr)
>> +{
>> +	char node_path[32];
>> +
>> +	if (core_nr < 1)
>> +		return;
>> +
>> +	for (; core_nr < 4; core_nr++) {
>> +		snprintf(node_path, sizeof(node_path), "/cpus/cpu@%d", core_nr);
>> +		fdt_del_node_path(blob, node_path);
>> +		snprintf(node_path, sizeof(node_path), "/cpus/cpu-map/cluster0/core%d", core_nr);
>> +		fdt_del_node_path(blob, node_path);
>> +		snprintf(node_path, sizeof(node_path), "/bus@f0000/watchdog@e0%d0000", core_nr);
>> +		fdt_del_node_path(blob, node_path);
>> +	}
>> +}
>> +
>> +static void fdt_fixup_dss_nodes_am62a(void *blob, bool has_dss)
>> +{
>> +	if (!has_dss) {
>> +		fdt_del_node_path(blob, "/bus@f0000/dss@30200000");
>> +		fdt_del_node_path(blob, "/bus@f0000/pinctrl@f4000/main-dss0-default-pins");
>> +	}
>> +}
>> +
>> +static void fdt_fixup_video_codec_nodes_am62a(void *blob, bool has_video_codec)
>> +{
>> +	if (!has_video_codec)
>> +		fdt_del_node_path(blob, "/bus@f0000/video-codec@30210000");
>> +}
>> +
>> +static void fdt_fixup_canfd_nodes_am62a(void *blob, bool has_canfd)
>> +{
>> +	if (!has_canfd)
>> +		fdt_del_node_path(blob, "/bus@f0000/can@20701000");
>> +}
>> +
>>   int ft_system_setup(void *blob, struct bd_info *bd)
>>   {
>> +	fdt_fixup_cores_wdt_nodes_am62a(blob, k3_get_core_nr());
>> +	fdt_fixup_dss_nodes_am62a(blob, k3_has_dss());
>> +	fdt_fixup_video_codec_nodes_am62a(blob, k3_has_video_codec());
>> +	fdt_fixup_canfd_nodes_am62a(blob, k3_has_canfd());
>>   	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
>>   	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
>>   
>> diff --git a/arch/arm/mach-k3/include/mach/am62a_hardware.h b/arch/arm/mach-k3/include/mach/am62a_hardware.h
>> index cd61abe018..ab281129d7 100644
>> --- a/arch/arm/mach-k3/include/mach/am62a_hardware.h
>> +++ b/arch/arm/mach-k3/include/mach/am62a_hardware.h
>> @@ -19,6 +19,18 @@
>>   #define MCU_CTRL_MMR0_BASE			0x04500000
>>   #define WKUP_CTRL_MMR0_BASE			0x43000000
>>   
>> +#define CTRLMMR_WKUP_JTAG_DEVICE_ID		(WKUP_CTRL_MMR0_BASE + 0x18)
>> +#define JTAG_DEV_CORE_NR_MASK			GENMASK(19, 18)
>> +#define JTAG_DEV_CORE_NR_SHIFT			18
>> +#define JTAG_DEV_CANFD_MASK			BIT(15)
>> +#define JTAG_DEV_CANFD_SHIFT			15
>> +#define JTAG_DEV_VIDEO_CODEC_MASK			BIT(14)
>> +#define JTAG_DEV_VIDEO_CODEC_SHIFT			14
>> +#define JTAG_DEV_DSS_MASK			GENMASK(16, 13)
>> +#define JTAG_DEV_DSS_SHIFT			13
>> +
>> +#define JTAG_DEV_HAS_DSS_VALUE			0xD
>> +
>>   #define CTRLMMR_MAIN_DEVSTAT			(WKUP_CTRL_MMR0_BASE + 0x30)
>>   #define MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK	GENMASK(6, 3)
>>   #define MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT	3
>> @@ -86,6 +98,34 @@
>>   #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x70000001
>>   #endif /* CONFIG_CPU_V7R */
>>   
>> +static inline int k3_get_core_nr(void)
>> +{
>> +	u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
>> +
>> +	return ((dev_id & JTAG_DEV_CORE_NR_MASK) >> JTAG_DEV_CORE_NR_SHIFT) + 1;
>> +}
>> +

I can see these three following components are optional but I don't see 
any silicon devices without them. The AM62A processor data sheet only 
lists devices with different A53 and C7 options.

BTW: C7x fixup is missing in this series ;)

>> +static inline int k3_has_dss(void)
>> +{
>> +	u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
>> +
>> +	return (JTAG_DEV_HAS_DSS_VALUE == ((dev_id & JTAG_DEV_DSS_MASK) >> JTAG_DEV_DSS_SHIFT));
>> +}
>> +
>> +static inline int k3_has_video_codec(void)
>> +{
>> +	u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
>> +
>> +	return !((dev_id & JTAG_DEV_VIDEO_CODEC_MASK) >> JTAG_DEV_VIDEO_CODEC_SHIFT);
>> +}
>> +
>> +static inline int k3_has_canfd(void)
>> +{
>> +	u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
>> +
>> +	return (dev_id & JTAG_DEV_CANFD_MASK) >> JTAG_DEV_CANFD_SHIFT;
>> +}
>> +
>>   #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
>>   
>>   static const u32 put_device_ids[] = {};
>> -- 
>> 2.34.1
>>
> We should do a proper framework for this that scales multiple devices.

I agree, this should be reworked afterwards and moved into a framework. 
We have literally the same logic for AM62 and AM62Ax. I also have 
temperature fixup patches for the AM64 which are identical again. Would 
be nice to move most of this logic into a common part.

Thanks for sending those patches!

- Daniel

>
>
