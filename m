Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F86ECA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 16:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B42D83990;
	Mon,  1 Sep 2025 18:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="d3sYa7JI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CF7383A1A; Mon,  1 Sep 2025 18:58:22 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E74FA838C1
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 18:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmEAwbvKWumHgK6DnOhTxArdnsSJaQ++AlzIfxBZ8001POPsctSyvZvsVnoaRTbGBaSE3YCZ3ymzo9CONbrKaCRTrArntQKg7GKgLrh+k8QybklYGhX8aezCav+JPDhp3wbVstDqW2PtjRR/yD8CcN2b3hRywCuYjSVmoijUZomSlQXeqhK07p6Q2TRAe5zMzMD76qoC7v2i3JhKsscgjvbRnFo/EJEBJBlsBEUAuv1bLmcj8ucJZG+NX8XnOCjW/uLBfTVQv4Mr8qPAQn2WKUQl/PjUOmJIQRpaoy/ID4beBwbn/gTZeTbCXP2FyClvODxi2mUVZxfolPKVxjrEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzWPI/3/1otgIjj4rptjPvS+pQ42MnlhALAihfS+y8E=;
 b=CG7DuCj9ZrQgJFH0hjLKs1ukW7HfVCtuW9NjzD9Hcb3IVJu2veSU63CZDsYFPalUd+shg6Ab7bzeGnScARmnDsnA03MP3sOi15SyT0w3St131GC1YX8see970INS0vwjPRjHWXtAq/TJMkeNtIt2y3hXjAz6fuju0vuU76tsmc9Ct0SWdUMHCLrqjlB7QxebTLPafVhJfieUtTgqBlqTsVTQs9gTA2oeJaecSDf6adX0aZCBwkvxeDe8wk6Q4S6PVIPOTzPg66Gju2dhtbJocqlaqnP6TMh4HiPAIels2W5ELZAzj+LunSzjt/aUZ+RFmSYASfPVqsWBuSEra22nTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzWPI/3/1otgIjj4rptjPvS+pQ42MnlhALAihfS+y8E=;
 b=d3sYa7JIjZDX5jPUs0xIVuZ1cyJ9O2C+y5RJYeDmVOabVlZM2d4aEMy7PFw911H8pIHolGcTaCuhzJMZ9gBWc8/JC+d0C+eNLAJUx/ig+Ap0N+z4U87ZQ8HqDqCtLyEt8OwCmMB+1NfoHVUSTwSUWyuQIygaim3l7yYFSQNzHDj/q1GRY35N7J+fKTUzr+kwpADxzdKoNcAOR7/aPMbQnHC43gkkjVASnPqSb4McPsOOK/GLbeGb4FK63T3DyaTJ/Sy1BaSxbFyNfY6hgrCISJBh5LpvPbKqNNgtoNOwrTnvGZzWGbDa6IizAIf20YQBnTgBN8vsE2V4iOzqVjm35Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PA4PR10MB5561.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:272::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 16:58:17 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Mon, 1 Sep 2025
 16:58:16 +0000
Message-ID: <d320ef0e-2711-4f86-9881-6aabdf6766c2@kontron.de>
Date: Mon, 1 Sep 2025 18:58:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] power: regulator: tps65910: Cannot test unsigned for
 being negative
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Paul Barker
 <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
 <20250807-pwr_regulator-v1-5-42a4105336ec@linaro.org>
 <78a0767b-2508-4602-a37a-eb4e72b37120@kontron.de>
 <b44654c2-de9e-4bd6-96a8-aa338435048a@linaro.org>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <b44654c2-de9e-4bd6-96a8-aa338435048a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::6) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PA4PR10MB5561:EE_
X-MS-Office365-Filtering-Correlation-Id: ba13c279-cd47-4cb7-f0b6-08dde978be97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzlRVUcvZWkxNkhFK003VlFLU1I5UzhaOGQrcXdacUZ2OERjK0VadE50NjhL?=
 =?utf-8?B?a2s2ZFdUdFRFWi9ZS042WmNUTlFqQWhlRURBdU8ydWJ1bHh6dG1rcDFwc0No?=
 =?utf-8?B?ZDQ1SU9PWjFvRDYwY1ZDdWFTdDVRUUtGVFB5TWNhbmE5WWdFdWU2TGplUlp6?=
 =?utf-8?B?SEZsT2pMVHVTejhLRE1xcEdCMmhIVXNMaWJtaTl2OE1zRTRjbmEvTjRMZ2p1?=
 =?utf-8?B?RmxwNmk3TVRXSGMvNm9OaHJRbHFiNWR4MUxCd2x6T2xjYXFaOVZZZTl4a3RS?=
 =?utf-8?B?MUoycHo2ZXJqSWpJdUhTSFJ0U0prQ3VhL3REU2laK2VWSEdzc1pQWVpQMlNE?=
 =?utf-8?B?Nzc3RGViczBaTmhKWkZqcmFweVdJQTJtbEZpYnA5ZE5aSHpXelk0YzBLdkJI?=
 =?utf-8?B?b1RBc0xkNGczck80T1lsSGQ2cHNiTmhFbjVJdzF1Tis3N2UycStoUnU4Tzk1?=
 =?utf-8?B?ancreGVwYkdTczJ4Zmgzeks2UkVQbEtsSlVSUUNGMWZNdi9qUHNZRmVhOVpv?=
 =?utf-8?B?czF5L29zRExSTlhTZlpwbzllbEZ0Y1RZY2c2UTUrTXF5dXFCUDdOd1BvM0Vl?=
 =?utf-8?B?eFRUS0ZpaUNGQUlraEZ0b2RYNHFFQXVvUEdvcUpUcHY2d1U2ZjAvYUpGb0Rr?=
 =?utf-8?B?NkRRQlU3alhoWlhVY2I4dWhBL2QwS1N4M3NaZHAreXVVN1hEOEhOVmYzb1BF?=
 =?utf-8?B?anJrU1pnVTRjTDdVSSttQitRTGJobXpWbEhzNWd2R1owWG1zUkd2SXBxNWdZ?=
 =?utf-8?B?L1BPMUVVZmlZczZtZmhwOUpidHdHUzFScUVoVjZtSkdCUlRTVG1BL0FHdUpy?=
 =?utf-8?B?VDlocHRMUjcyTzFsY25YNDVyTlhDQjNKMmJ5b1U0OW5JV2VQRXlrak9yVW5s?=
 =?utf-8?B?aE8xWmNOSlZheXViM0xqRUlOck1VUXJUdHNqOVFXYU5wTDR0VmV3UEhaNFdM?=
 =?utf-8?B?YUIya0dhWWU1NVMzRVZQbzJpU3dLWE1oKzlwaW1WUjlhYVNkNDBzV3Nnc0lx?=
 =?utf-8?B?QTZIUDhCT0VLQXRoNGNtTjV5QThwaHF4NmVDd2taWUhCVWZ4U2UrRHczUWpk?=
 =?utf-8?B?djRXakFZSjg2cERUSkhSNW13Vjd0VHpTcjNzTUlQYitmYzZldGpzTm9Bbm1E?=
 =?utf-8?B?QVhHUGk0WnFYOFJrdCtDV3VieTN5RWcrK0VqRXZCaVZpNzZLUVpZKzdBWHNx?=
 =?utf-8?B?WVY3Mjcvd2NCWk9kMTZIL0xVTEVlYk1iYUR1VWdWTzNCY2RKeXdVRmh2aEUy?=
 =?utf-8?B?RDdqOU9CUjJSUGRPV0tHbnlKVnlZUFpXd0cvSitXRzRyOXBnOGdueGxZZHZy?=
 =?utf-8?B?bTB1Wk5WUXBBeCtNR1hWUXI0TTdFbGVjSEZMM2FCczJQdW9sZmtsZm9kaEpJ?=
 =?utf-8?B?bjE1NWpuTW82eDFPS2VvekhYRU5tK3VNVkhibnZoNTkvdVZFSlpseDVOb2g5?=
 =?utf-8?B?TThTUFROMGc3cTJsY2IxWU9lNFpIN3FmamMrb2wvYWRvRlJ4cGkxaENDVVVi?=
 =?utf-8?B?NjBWYTdheSt2V0tIUXEvQ1FoOFJ4OXFobkJZSFJYOW81Qlg4enl6K00zbGxy?=
 =?utf-8?B?eXhWdEc2TEFuNVdhR21BaDdNSkNiTncrNHRDYVJIVUR3aXltaGhwUGpocGtr?=
 =?utf-8?B?NW41TVdQRFI2QkdJQVlvZ2t2aWg3Ryt2WTJHdDdnaS9kcEJmeTJsY2xPcDZW?=
 =?utf-8?B?aVRIZ3ZtMUR1eDZ6STVMcHlJVTJhNEtxL042VDdKUGYvWUtDZU9xUU4zalZI?=
 =?utf-8?B?VDIzQTRKVkdhZ3h5TlBrblZQSkMwQVhXNFdqK1Y2OWNaZWZ1akRObGpYYUl1?=
 =?utf-8?B?aHhMYWFqSkZ6c1VxUnQrN2MwM0V0TUMwWG9kNnBJTjZyZ1F2UnltZ0tSL2E1?=
 =?utf-8?B?bUpneTZlOUdmNXgxUStLNWVsaW82ai92VDRoYWpyNjlucHByYzNHZWtzbGRh?=
 =?utf-8?Q?yAbe4DcEpnA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFpaS0kyREdVOTBZWkR1Wmt4ZlVUM2NGbmVDOTRFcFZUazZMb25ZRGhrakhU?=
 =?utf-8?B?ZVU0cG1JZ1lQeEYrMG1SUnNFTUNnNWVvaXNyOTI2THZQbHlxNVNUQkdUSXBa?=
 =?utf-8?B?ZEtxRW9CMnJaa3pzejB2cEpxbzF2em5Fd2hXWVdNT25YZlZqd29leUh0ZWoy?=
 =?utf-8?B?R0U2cFVVVVdSUUhsaVFRZ2t0ZWlyaE1MRm05M21UdHRCQVVaYkZBalJhUU5n?=
 =?utf-8?B?c1lNSXpLYldvYW5OZmJkUWFwZVBhaGwwRmVDdzFUbkpsanBmMzdvR3VCN1VC?=
 =?utf-8?B?blRRaVhyYWRkbk55TEF0b1Y0aWo2cXdzemlMUnpsakoxVXdSWFViNldSSmF6?=
 =?utf-8?B?Q0RUR243c3REeUhZK0d4RFRWdWpHRytqVk9WbTU0by9pRFZDTlZtcGpWZ2Ev?=
 =?utf-8?B?UFBKeG5GK2crS3Rvd0dZdGN5eXIvTDNERWVnMTViRjgxNFk0clA1cE5qaVFO?=
 =?utf-8?B?RWowdVNLdEh6ZXJISFV4YlBQMndtcWJUK0V5LzRWQ2pGbWNaTGNSYlJwdzlx?=
 =?utf-8?B?ODRLOXhURDROQXRkdHpBVXE1N3Z3c1U5ZVJwdUxqUjNyUWxUZ1B2QXZ2QlhN?=
 =?utf-8?B?M01JTW5JTGVXRGJXYzVZRWpTQWZrY2RBd3ZURmgwOGVXQ3hEM2NMTHI3Z0hL?=
 =?utf-8?B?bnlyWXdGVmFyaFdBbGpOdlZ3dlhJQk90TjRROGRVRmZlZ2YrWFZLeThweW1w?=
 =?utf-8?B?QTc5U1FseGdtMFQzZkRscndISXhiTi9MRFQ2a3ROYlBWNE9vSUtaNDJuVXdI?=
 =?utf-8?B?K1RhZFJOZC9iZHZSUndsSm9ySmN2eThURytEU01GVXR1WjRERHk3K2kvK2pq?=
 =?utf-8?B?cktKRkRLWGNMVzdwT1dOb3ZKSG9Ca3hRZFVEUk1pU3lSSyswVE9la0tIWThP?=
 =?utf-8?B?QjF2OElKSUltalNVYkVDakpnMUY5d1VRRDlOWlo2MGg3VHJURXJNUHZXS1B5?=
 =?utf-8?B?ei9ndTN4eTZvY1J1SGQ2TkU4WlRIejJkbDdUdW03b3cvWHA2UEo2a0k2OEMx?=
 =?utf-8?B?MXh0YUZ1U2g5WEhMbWN4Y0t4bTZldnB2TkkwWXNkRVlyNW56RFU2dVF3U0Za?=
 =?utf-8?B?bkw0aTRtTWUvUUUvUmpjWGdBbjIyU1AzRWdCOGtuNkEvbGx1ek1tNXYrbXVj?=
 =?utf-8?B?TTJlcE9sVS9sSzJiT3ZTejdHb1Vrdlo3a09YMGgzeXpOUUJuenY5UEZ6VDV5?=
 =?utf-8?B?aWRWdmNPc3lSZHN3LzkrQ3Zaa0lOM05CdWtZNkh1MEV1dE9WM0lHYzZyc2VB?=
 =?utf-8?B?aFVvOUlwZG5OMStQcnZtUnp3Vi9oc2VvT3RoVkZPWG5oQllnSHlmcVE3M3M5?=
 =?utf-8?B?Uk82ajVZWm9ubzFwRU1wS1hDN2MrTTI1Y2t6NzJXQTRVYk5JMGlkcEV1azY2?=
 =?utf-8?B?ZWNJRXE0NTZ1dWhMVzFZSnJlbEM4K05mTS9abGZtYVF5LzFobVpnVzFGUGtO?=
 =?utf-8?B?bUl1SG1lRFhxWWptdStUVGlLMkduTjZVS2IxY3RoU2JtbWtDUS9yMlNOdllo?=
 =?utf-8?B?OU1Zb29YbnZJVWgxZ3U4TWFUWDY0Rkx6cjNjT2pwaTFMalBlYmtyenlhVVZl?=
 =?utf-8?B?UlQrU0FHMW5NclhBVlBicGFSMGNXYm5Lb2RqQmdjZ1NFcUJseDZLL2ZPUWpS?=
 =?utf-8?B?UXdQbmlIRS9vOFBBTmNyMk9YOVZ1blVnL1JUWDRybEpINXFjODdhWnY4a0Zt?=
 =?utf-8?B?eGwrVWNqbThLcTJQV1crYlBMZGVZVzB3NGtKeEtjRjBWUllZTytWYy9VMmZU?=
 =?utf-8?B?aXhERnduaEVlNlkxKzNERkwwVFpYWEtXaGxHT0x3eW5YbHF4c0g4eGFWdnM0?=
 =?utf-8?B?ZkViNmxiMFNRdC9STU4yVi9QTDBzdmZYa1ppZXRIUDFEak9WaEloU0I3R3hF?=
 =?utf-8?B?QnIwNjVKQ3FzSVF2WExIM2VBaHo0RGVZQjUyaGJkcFhXVVdUVHRVQWhqeU1u?=
 =?utf-8?B?YklMMkRCQUlkUTJMcVJjTkdaa3BTcFNRTkl3OTNuVlpHTUlvMFdEdG1WZnRT?=
 =?utf-8?B?cU9ZVzVNYWxyaDhSczd1RmMvUDhXcXlxSGdRUmtwVzJ0ZkFwMDlScEN5Wldo?=
 =?utf-8?B?UUt4K1o2STVLWHhUU2p5SEIwall3dnpMMU4vM3pqaEhMVStiZ2ZQNExXcDY0?=
 =?utf-8?B?UEVnZUZFcFM2MVlwRzlWOGQ1VmhqN3hGQ0U5NlFxb3lhbHRtbEt2UVFQdDBr?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ba13c279-cd47-4cb7-f0b6-08dde978be97
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 16:58:16.1641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rwP28G1iu2FkmLviBu0oEDO1QQgWyB3ReSLtrrsZYtT1f+aY2R9j05MhVXZHr61Hu3LrkrCPY0tuD/TSMnPLMMW4TOhngZaGXc7zXA8ZRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5561
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

Hi Andrew,

Am 01.09.25 um 18:26 schrieb Andrew Goodbody:
> On 27/08/2025 08:54, Frieder Schrempf wrote:
>> Am 07.08.25 um 18:35 schrieb Andrew Goodbody:
>>> The code in tps65910_regulator.c treats the field supply in struct
>>> tps65910_regulator_pdata as an int and even tests the value for being
>>> negative so change it from a u32 to int so that the code all works as
>>> expected.
>>
>> I'm not sure if this is the best solution. The supply field holds a
>> voltage value in uV and u32 seems like a reasonable type to use.
>>
>> I would argue that the driver should be changed to not use int and
>> remove the negative value check.
> 
> Hi Frieder,
> 
> I would offer the counter argument that the TPS65910 has an absolute
> maximum rating of 7V so any advantage of being able to use all 32 bits
> vs 'only' 31 bits to hold a value in uV, when 23 bits would be enough,
> is somewhat lost.
> 
> As I say in the commit message all the rest of the code in this driver
> treats this field as an int and declares int variables to hold its value
> so using a u32 throughout this driver would just mean changes being made
> with no benefit. Removing the negative value check leaves the code open
> to unexpected behaviour and hard to find bugs.
> 
> More than that the field is being assigned to from the function
> regulator_get_value() which is in the regulator uclass and returns an
> int. So following your suggestion to its logical conclusion would mean
> changing the uclass and then that would lead to changes also being made
> to all other clients. This would turn into a major project which I am
> not very keen to take on as I do not see any benefit to it.
> 
> So yes, simply changing one field in a struct from u32 to int does seem
> to me to be the best solution. It achieves the aim of fixing the code
> with the minimum of effort and I see no downside to it.

Thanks for the reply. I totally missed the fact that
regulator_get_value() returns an int. When I was looking at the code, I
assumed that there are only positive values ever used.

You are right. Sorry for the noise. The patch is fine.

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Thanks
Frieder
