Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB267606D488
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jrD4OtfX;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=oSgfKJAC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38FF040E08;
	Fri, 13 Nov 2026 17:50:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ipyqgeuX1lRR; Fri, 13 Nov 2026 17:50:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7A75240619
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794592236;
	b=ilDmU7nyKM5UzUkEtQYvR8EMvA8xUx4lp6H3DQs3n4QFdkyENUnuNSUfXR78O0e+bDgD
	 BgKkYuLCRqqBhSwTVlhbWTs59vcecFS77cy/Fwp6ZJXr/TXF9w4N1pnAIOgc5ouZm64+S
	 F9Akm57XdYs2I65huIA1kaG5O3rxwR83KPXNodnF/LvRzyAEH6JWID9tyGoGNBtbOQMb0
	 dGfEVOkMdLrHfJ+ZOMJdA9MSBzAlMQivwGR7XFD20GAz306TOQ5JkBybjRdkKKzvasjKu
	 smvsvTV2QzqTXVwdZTVji9xXj2JdTcrkMvdp4CR1CyzKl0x1yOno1UD4TGax7GsKjbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794592236;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SHVUgI8G7fVL2AQdNGikxSOBH5RSCTvsVSstNQfBr7E=;
	b=pOiefPkrJ7qgHel4509TM3l+DIMcojXpMoYd4qlWzn8VAAwMvxVDrvZ/axBCJQSQasNW
	 M8CpVHQHAuicT0DGwJKRK2Fsaei4akBsxu+WMYMMMMi2NsxKOHLracWG5oSHvg7k8zSDX
	 XjXCXe+MzjxfGZeSF9BfDkmG/TQbWBghJa75t5jq/nabeHc81lquzqj6ELUb2wowjNUJI
	 8zZuch3/8wyJkZh6CHxm3uOiCSyYWfxTH63+c9g3/A2P/8QNbt4EeNVAvxSBwnXxXjjez
	 HxkjjQnBOSp33vEQ48//Y+9x6fR84/mf881DsKYw3QJ9ydnZXfxc5aZ7AZlFJFXWW4w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794592236;
	bh=SHVUgI8G7fVL2AQdNGikxSOBH5RSCTvsVSstNQfBr7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jrD4OtfXzTS5cUO2rjkENMvYkg5X9OIrr2JAPvfwCzT8jyf5EmMJsK6L2hmS+F0M1
	 DY+iz+wD6vZEAWJCRf15sw/tXzRgi9/Bs0PsOMw+x5a3fvJfWPUyBWzuriIB0jkMKT
	 eQympZ4bcSZrw2ZO/COUwD9T9SFklkHRenLQt18CBG6isQfQtuZdQO9a5y7jMLHZF0
	 UtyABDLUy2ZwJOA98HDabx/g/iRMyBvTYOJyFlBooXhfJCISvW5q51VIx3P9UgbZiR
	 T6D96XGkncR2N1yvmHxRBH/m5k/N496FLoMAeGgYqrebElh2gV1eUnwM9WcltNhg67
	 O7p5uXepT6LIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A75240619;
	Fri, 13 Nov 2026 17:50:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B174F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80C834018D
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:50:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O49celJGQ6qD for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:50:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5441D4005E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=oSgfKJAC
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5441D4005E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHVUgI8G7fVL2AQdNGikxSOBH5RSCTvsVSstNQfBr7E=;
 b=oSgfKJACOgt2eQOrx0dy/iK11Kf92igUDqEYetvSWJNLCv5G2kEYzCW1baazfw44yzJghKTHr3cHJeiLnV37nVHkbiL0LHE5hUvi/sSnxAUZb/Ls1qj0XVes5gi/ZJwuWSu+BLNLGxuavhVbQqNuVhOsv0DM4nENQ4M95Uj/8Wo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GVXPR04MB9878.eurprd04.prod.outlook.com (2603:10a6:150:116::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:50:27 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:50:26 +0000
Message-ID: <8cd70f39-0ede-4d94-b9bb-ee4dc635a71a@cherry.de>
Date: Fri, 13 Nov 2026 18:50:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/37] clk: rockchip: rk3576: Use correct mode register
 for VPLL
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-20-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011222930.1085075-20-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0100.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::29) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GVXPR04MB9878:EE_
X-MS-Office365-Filtering-Correlation-Id: f577ac23-bb11-4404-ebda-08df41ae995c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|4143699003|56012099006|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uAxV0tRFiOzvXY43lFJM59dC+ZN0DXAW8Q7PPvoDubBxJ5efMG3GIGwlDl/BA5UTcJ50aCS52qfOHCFSRApARHZTmXQzy9x3/z1xdkX6icaFdayOVMoUqBq/xJFGN1gkTxxnDULhSSI4ki0UCijGlMOVseaJ1q3EntSGlmquAcyhBVCDGHIKYYHHO7mPSc2BwbIa2l4oLrtxp8Q84ftPDl5+EK7/L1hIOsa8nShuiaeNPV84WWIFYu2aCY33JKquh9m2RMz5BdS+SxfXBL+Mjc35f5qoSVryT7Y04ZT5oSQk7xMO1iJPR73ffojZb6DiWtAPDhruH9x9bVctQKJBAAUULNQq9swvFkQbqZJjBaxCZBrESELoY4j8WqoYM+6G4emfuPvqaB6EbHuJ3Nmag1uUMJlR7wti8GxNDevKMzEDH3qSPloH1FzKoCLKPnXy9W+4xEgXvCfLsox5KUlPvq31TPYSc4pzBB+OpHZgy3HtMfAN9RyfLpPs9CwXM0FmTXVcSyw6acn0J0LpwinwKLo5qVNjYYzzS3zjhPXRuI/sWzs3LqyPd8QOPfSC0XNGsSoYcWokcAFXW9b4tRrLsP+n1rJa8De2OVD0qWu1Xh83feHqkJl+WWxchxb0MaskAPTcFNV79amyM+te0J/07540A9gDj51Mez2E0Ty+T/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0tVOU8zRnAwTFNvSzFMb3hTeXg5b2JsY0RPWWhEVlV0ejNtWXZYOW5PeUtR?=
 =?utf-8?B?c1p4Tlc1Yzdud2hBTjVCbE50QUJEcUd2elNta2dMK0x0RElxb2RMWk1DQzA0?=
 =?utf-8?B?OHBuVmMvUWh6bnVRMDhUZDBoLzg0Vit4emE3UFl0NURmc2VvK2pqVkZycnBF?=
 =?utf-8?B?U2NIcEdBdm9TTWIxVkNmaUg5dCtiVlRoS0RmS3hocisyampyb0FqbnhtTWlm?=
 =?utf-8?B?UEJrbkhob2JqMU9qUUlHMzAvOXBHSDVtQzdvczNPVy9xVjlHcEhINERBeXd6?=
 =?utf-8?B?WldSTFIrcVE0SVQ0T0xnbjJBU0FDSFVVS2YvYVNWV3ZnU0d4Nm9IRGdGdGlO?=
 =?utf-8?B?N3kybUtJMkpIUGk2a2dQQjE0bVZaOXIyckoxNHBETGR2SCtEL29yUHVsd2hH?=
 =?utf-8?B?Q3BGS0paUXBJZHVzRnVkMUNSL3ZBN1kwMUYvUkhqOFpXWGhJK3VmNTd3anE1?=
 =?utf-8?B?SUtBNldweWh4R0IzMEYxalNQa2Z6V2JwdVVYN2dPWjVrd2U5TWV1TXZtZWg3?=
 =?utf-8?B?MC9YbjM5c1lrZHNkNHltZm11WGpCc2ZnYXo4U0wybHAzZjRsWnhWMFNxZmNL?=
 =?utf-8?B?dkVhUllRQ1dYL2NseWk1OG9yajVZN0VmU29YMERSTzNESmgyTk1LWUpkY3Zr?=
 =?utf-8?B?c2k2YzF5UUhISzRkT2xtd1RmOGZsbW5jM21PaC9tcElqbEpXUktha1dzUHNI?=
 =?utf-8?B?QjVKOTJFdTdqZzdxNXdxWkNqNEdJdHdHQjZpTHVWTzY1Y0xFM29FY0Ryd0h4?=
 =?utf-8?B?Q3JYa3lWVmxLRTdEdm1abGx1bHRPWjNTM29aS3Ayd1AxVzVRT2x5N0NMWFJy?=
 =?utf-8?B?WkNnSmxDcHJrZGtVOGNjRU0vRG9Zb0p6cUZqQXVWaGZOa1VyZmp6V2JKSCtl?=
 =?utf-8?B?dmk4VjczQTMvaTcydGRidHlYS2daeUY0WDdnbHMxVWlSckxwczVpN25GaHpi?=
 =?utf-8?B?UFJFZ21xTmtZSkp5TEI5Mko1amJQZmFJc2NMVi90bXRaeTY2UjV6blUwUXNK?=
 =?utf-8?B?VXlPWmtYcDdvZThOdFFMa3JPS2Z4QVY2bUt0UUx6eTFuVkJXRlZ1VW5Jc2hF?=
 =?utf-8?B?VUh0SVpuSnVBS0Yza3BHbzBlYWZEamVxOTJ6Q2dPUFZTcjA3OUcrUXRzZ2tX?=
 =?utf-8?B?V1hHMC9VMExsRFFoYjZyeHVSK3pYLytoMVBEbUhGbTRsSllhMm44WmsxSkNH?=
 =?utf-8?B?TjlSYmpSYnFBclY3VVk0N3BxWEN1RkdyQ0ZWaCtvb2NrdlEvMFR2QUxMMkxW?=
 =?utf-8?B?Qnh6dTRQYnpGS2dsUTBYM1Y4UGViZTJCM0RYYm5aTDhmVHB1VHphRVZUcHFx?=
 =?utf-8?B?WFhaaFNBSFZnYzFWWENCS2tXU2l4cUpBRVBFRTZPdjgwdDFVcDVNUngvZ2Zx?=
 =?utf-8?B?RE0wc2pHbjczZC9ITEtOSEdmdmFBRUEvN2MxeE04TVZ1cFRiTGFkNk9mL01p?=
 =?utf-8?B?YlRWeDFGbmhOcFBrZUJzL2dDYmVuemNhUUt6N203d1E5NjdSL2pKbXNwTHp2?=
 =?utf-8?B?L2pqSkhiRDZsUjJxUDdNUk5mVzFpMUxTdlNtdmtLSHc5YTYrckR2N0locUdD?=
 =?utf-8?B?d1owTS9DcTNhQWgvQmIvRGNoRUVEckY0VTlIZXFtamxqRjhKdytYU3N4TEpl?=
 =?utf-8?B?anc1WUFQSTd3aUdjNXZWTWRYTG82ek1vZXNvRmtZdlN2Y2hRN1FaMDV0Tito?=
 =?utf-8?B?ZytHeTNFSnZnRGdPMFUxd2szMXlFU3ZFU3cyalE1YTJtblZXN1ZjdEtCTCtT?=
 =?utf-8?B?ZkYwRjc3UjVTRVZRVURKK1lUOWw3Z2RpZkdkaVZaaTZ6RnVSeHlsb3VNVGpV?=
 =?utf-8?B?R3RkL0FJN29yNFE5T1Uvblo2VmtQNnpLZEVNZkdEb2E1akFHc1JhWEw4eld1?=
 =?utf-8?B?cEZGU3QrZ3U1RXNnZU1ocllMNVZ5UjN2anhZdklJbGR6aTJTaWZHN1dha1Ey?=
 =?utf-8?B?eGlnWFJPdjQ5bGNwUGt1QTFYaUk5RGVrNGtNaysxYlNzMFFScGZEMmVxdEVk?=
 =?utf-8?B?UHYyNVBGa1p2N3pSSi9GbVBOYzFxbUVuVFN1OTNNUUVxSmFRKysvNUtuRk10?=
 =?utf-8?B?ZWVTdUptTGlzcllhejNJSXZmWmtQcm1waUpCcmxJdWhROXBzdFpVUmdtUENF?=
 =?utf-8?B?ZjcvZUVqRTJLME1JbjJORnh3L3o0VEJwa0YvWmJZYUlWd0JiNERySm5ZTVcr?=
 =?utf-8?B?VUlnc3M4a3hiMUgrZEhVZnBzWE16NTRJdU1veTNhWkFGMkovODVWZjlQTXhy?=
 =?utf-8?B?VkVuaC9xNHpYZWgxb3c4eUs3Skhjbmx1dml6Mm42NWliWUt6SExoaDVid21z?=
 =?utf-8?B?UW40clBmUWN5aUxQWlROeWJaK0tUZTY3b2JKRFFmMjJNbHJTdHVhZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f577ac23-bb11-4404-ebda-08df41ae995c
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:50:26.5823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XE8lxY/2IVLGp46mD2DNbgxs2SjzX8f2M7haBzMooi4AhwmkG/+H/9Cn0z4+8emv69N9doNeAiqrZzou5iSVSTTgiMqRfov2b8dP2cN8l7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9878
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/12/26 12:28 AM, Jonas Karlman wrote:
> Change to use correct PLL mode register when VPLL rate is changed.
> 
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Looking at the other clocks, I **think** RK3576_BPLL_MODE_CON0 and 
RK3576_LPLL_MODE_CON0 are completely wrong?

The offsets should be

(0x27238000 - 0x27200000 + 0x280)
(0x27240000 - 0x27200000 + 0x280)

no? At the same time, I don't think it matters since we won't change the 
LPLL and BPLL (LITTLE and big cores PLL I believe?) in U-Boot. It seems 
that the kernel has it correct though and they have

#define RK3576_BIGCORE_CRU_BASE         0x38000
#define RK3576_LITCORE_CRU_BASE         0x40000

Thanks!
Quentin
