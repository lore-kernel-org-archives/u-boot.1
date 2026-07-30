Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312C8C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 15:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C39B9810F1;
	Thu, 30 Jul 2026 15:43:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IfbAGAnKq4qd; Thu, 30 Jul 2026 15:43:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E80A480FEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785426231;
	bh=W3CpBppliaPOdOM1o2xL9vgZP+wOTyk2MdHPEK4hwdM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MmPRxO0fk4N1uSAVqCeD3MglG0bznxnUOQtVcR7EvojUysW54R9GKuBJYrv3u6E15
	 cA8CWUBfaz8o1e52RczagOsJifU9fdqN86/G7m2Mx201VTxWxWbbMAdFHa2ekGZp6s
	 tIlHuHztRKVPqifPkaGQhGACUNDghpltpyLvaCZul9KF9A8YpD1EZ0bdnd8etnzkFS
	 eI8CN+Lv9FcTuT4NfJJhVEfwCdejvE24rDwXvM3If2Cwb+Y8WYwhsqewAz6PKsdRFW
	 evoFkr7E6hB96RsPWIHzy+nI4QWVl5U7FfiGF/qsvG90QHQBmKpUDnmH2n19zBepjl
	 PCrKXOE8CuLqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E80A480FEF;
	Thu, 30 Jul 2026 15:43:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2325A2CE
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2061740289
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:43:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eaV-78BKAaHH for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 15:43:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 48FF840089
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48FF840089
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 48FF840089
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OynKiXz/WYOxf9waLERMENMZW9LYiL9PJlDEhI8+ffgD+I4mI4FFzycT78WAin6IxG5z++LmzvGBC+paEHDRdqamHGV8L5WEwedrv5S7GV5txPn0hVC5j1YCXUWAJ3luqkweKVzaZZHraiJ7dWhMIm3epQWvR+l4nLzMkiQE834rT8psVl9nkN7oc54VKeo0SPSHNhYnwT1Xov/TP857lkGHu69Aytiahfcef6rKx1UafPPdZDvRNRhFEQk8i/BEcVtmDTaPzxkAKIMgCJqIBIhWOTZmBAg4qK6btp3++vAiZPwlwbIkdWz0nbfXctxmGAwXqSMIEsfSRsXSMcfQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3CpBppliaPOdOM1o2xL9vgZP+wOTyk2MdHPEK4hwdM=;
 b=E7xX/7Hq3K1xb9uhwVqBGghMPtj9DYeueH52g/KDXhBgZigkmny46bhagVQ1khdldP96aIJIfs4m7D4huDMiecx3kLAQrEkoWmw9tRuLxmiK6H4YKAhWt3hBZohJKzoCsO1Zyyq6rag4OKJewIKh0tqMUKv2gSZ/PJ3O1gkDqUB17kyld0emKDKRnux3F0f9kshkEisA1qXn+FtkCFDpg0he2td0qBx+7o1jVZPYIevJ80laM0Kcl2v95if1Wvuh4bTK0ARSyc+9pKZ1ziMz32/eQ3+evFp74aevg/xXm+1IgjlVbGuSrFLTpRjkWk2ybS6abiJQc6/d1JVbXpq+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 15:43:42 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 15:43:42 +0000
Message-ID: <c2f82fc2-bc35-4d7e-b821-bcfcaf56ddec@cherry.de>
Date: Thu, 30 Jul 2026 17:43:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] rockchip: scripts: remove rkmux.py
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
 <29151ea2-7e8b-40f7-bf22-e487def1445f@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <29151ea2-7e8b-40f7-bf22-e487def1445f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0053.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::9) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|VI1PR04MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c55eba-79bf-4568-0cfb-08deee515511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: rlwYniVEKYXaWOw2uJVircfYC1oPSNIKF6kNdlgNBwyVrDmEmnxDgznaOXqC+fZicj6yJ1JqBOz/YPGnDC0VC8DE6I/wZLGudR78AbbsTgoCzZmOYERnVDQsfHC08P3q76tb4/opHEVAQEPJUclhxtHYh+zraCkIVzmPdPWMC+u8sw+h79WoojO4rVCryHOOWFZ+6xipUwA4l5Waak5w1lYrRhiukJ8I5uV4yOLf2dpfNvfRCufHkr4IwKPhVsXwPMg5O34nK8trrnljwDe1Ot8Vj6aGftxVuKGHycF3dns+x5bIyq5R3Joa5bk6klrqIYi+CzGwp44VhPue2YLRUXEQPRNo7UtXwkFe62Kx1Fz1OK2kFQN46c9SfMvFRMrC7ud+67hzSmwV34YP8U8KwwAmVK9mjV1pRBhJH4V2PeK/WoHi4HBkWQZBSJhSZRY7I/V0a+lf7mx7AaCY96RDtkKHDhPHRiUy6XSEZzO+2ABz8av1duopVwZdF9lVy6Odn7SZeaJKDaD/iJtcNHv8ZBOUUEELxStyNHVLHoi59dWPWbSmYmawNlhLZzjtztk0roqHUhSEFIZC1o1kRmziwG94VIICfCllwA0BmaJsrqk5iWb/iW6mJcuSeUUgs5Ufs0NDHdhxsjX7oPnt+mRyEzzYu5NvldwyqUt/phS+spQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3V3eTdFR2lmeG51K29xblRXMWsxdUJGV3FQUk5tcFkwam1ld1dHWHh3K0Np?=
 =?utf-8?B?V3ViQlUwSkRKczJLNUp0ZDVpdDVKbVR5VFlNVVFHbTdMUkFWV0JaS0xSZGho?=
 =?utf-8?B?bnA0S3dXRDBGV051RU1KMXU2MXFZOEx1MjJXQm91NmhpWGUxeDlNdC9vQjgr?=
 =?utf-8?B?WEJBSUlJOTNMYzFYZ0tQdVZlTTRLZWxrZVh5alZxVVpabEVNS2pTUG1pSjhp?=
 =?utf-8?B?ZVUrWDNTUjY3ZTIwUEVvZDZEOWZVVlFHMmhCYjZQUmY0MVZ2MksyVklVa2hC?=
 =?utf-8?B?L0pWT0djcDJ6Q2RHYzBsT2Zoc0wwZnZEZnRXcXVGN2lERWFhN1VtbU1INTNa?=
 =?utf-8?B?SDBzN3lLUXlnSjF2SHoxeWc0RERLTnZFdlVOcUhxcWN4VllEbW1QQmhPcUt3?=
 =?utf-8?B?OGRQYmlxODgxUTJYMHgzSnVpb21KUWd0S3RjbkpydDNJUm1JQlc0ZmtxUHF3?=
 =?utf-8?B?ekdURjhVV3VoMHdaWFVQNDRjTU1LUGhiZjRoQ1A2cUpSK0RuWXlVbitCZHhn?=
 =?utf-8?B?U09CVkVOS1ZRN3l0M1ZNMzZ1Z3RidzNLdFhFdjdYRnpxM3JjYUdTN2JYL0Qr?=
 =?utf-8?B?dGFYeE9YNmVxejNlVmYzR1d6U3BuQUs4SmdueHZQeEVzUy9OZ0U5UHJJclox?=
 =?utf-8?B?T01yNWhxd3ZCcCtyaWZzWndzc3lGYjZicE5LTjFpZFhqSEZmNHFqK1lmb00v?=
 =?utf-8?B?SjBIanRMNUNoTE1nMzhYR0xVSTRlT01Cb3RmYytRU2ZaNndjU0IyOXZtN2Ir?=
 =?utf-8?B?T3liNFRSdGhxQ25xV3psTzk2ZkZ3U1Z6bWI1QVRXZ2RKK1BObHM3UVlzVkdu?=
 =?utf-8?B?SUxFeEF5UTUrVEl1ZVk5UjloT1JrVUY3Z1JqWFRkMExHUW94WTViK1NxSGhD?=
 =?utf-8?B?cFBXV2tNTEpPR0xydHhPdnlJczhtMjBYWGF6ZXhwNFdqeHlPcmg1ODZ5L1hN?=
 =?utf-8?B?YWtzdnJTL2xJTXl5L3B3RWYzQmpoQVNpNGtSUXN5N1h3bHBXNnZjTGVJZXFW?=
 =?utf-8?B?cnRpaE5IOUhreG5JbC95cWh3YjkwRHJEdks5VUFFQUVFVEZsQ3hlKzk0UW8r?=
 =?utf-8?B?YkRnMHlQSTBHNTJIc2RpSk8xNWNmRjFwK01OamxkZjlMQVZXNnZrYUIrTXpx?=
 =?utf-8?B?SGxrdFRhbUVmOEZyekhuczE1ZGpxSFNNdndiVDU4MUJBNlB4eXN1RllTWUFk?=
 =?utf-8?B?ZEJxRCtuUnRORWFjVFZZSkQzQkNsRXFBWGVOcVRPVFhkNUtCQ01QTEFHZVF4?=
 =?utf-8?B?M3hCVlIxb0FQelc2UVFrZXJ2bTVycTFXUnhycGdsakR6MVV0bXVGb2J4UU9E?=
 =?utf-8?B?alRaUCtmYWw0a1R6bGJyem9QOHBhNjQ0Y0o1UGE1MWdXaThxUUt2ZUZWQzdr?=
 =?utf-8?B?WHFaVC9WMjUrelhWOGtIRTBZaUhsdEVBRnp6TFFlell3VGJtSXhadWtaQ0hC?=
 =?utf-8?B?VmVqdWt0WEJ1UW1LSGpzUmh4cys1eE8vbTB3Y2NoSFc2b1RoaEFyd0d5Rjdr?=
 =?utf-8?B?S2RtSFpjMnhCNDZ1VDllSlJDYWZnMk1xZUlQM0t2VVliWjhnMWtWVjYzWkFi?=
 =?utf-8?B?ZG9pdEtVRHByWTJwTlJzWU02TVdLaUh3ZVdSRERpYm8yUkVNYk5KL01CeGhq?=
 =?utf-8?B?OWRrdC9yN2dvUHRuVGRCZ29FL2QvQUUyTWdHUUtPcFBHK2RhTk5jYjhVL01h?=
 =?utf-8?B?T3IrdFFnMzN0dktMYytPM01NZm9yeTRUS2tqd3I1TWN5dGZYbkZaenh5VHhB?=
 =?utf-8?B?dE5QT2ZCRzFwc3E3ZVJORE51VjZ1dnBTRXJXdFFNZmRMdGo5NDhSbi9tN1FK?=
 =?utf-8?B?ZVM4ZC8wOVlQbmpoOGpuYm5NbjVKV3FQcFQ4M0Jxa3BMQkdVYTBhbnd0dU5N?=
 =?utf-8?B?T0V3SDlNdDdPMExjeDVBditxU2YwVXNZZXhYVmtGaGM3VUoxVWVtTEFyT2hB?=
 =?utf-8?B?SkJSN3BLbkx1ZEhmQmErcGlkaTBuNUtnVzZGbWZMbS9DSCtuQXBUWVY2K1lu?=
 =?utf-8?B?M2lNUVcrc1J0L1RORDBTb29QSnlKOE1weTdMZ2NUbkp3anVnZHBWbzBWMTE4?=
 =?utf-8?B?dFBuandSTXEvckJzcFhud0hRKzBWcnY1aEZLRHRGNCtCQjBwODUveEVxN2FV?=
 =?utf-8?B?TDN4aUtNekIvYXd4NG12Q2duRTBTT0ltQ3hxcjlkR00yRjNUVU5ZVWlEWklw?=
 =?utf-8?B?V051ejVKOUVqU0gybVZlK3JKZEJMVHJFbVRRTzQvWTJpVWNvUkJlZlNoWi9n?=
 =?utf-8?B?K3JVT3VWM0diWWI0dGlwTHJha1hSS3RZR2o4ZG5kOENtcXZoYTJvV0NyUUFT?=
 =?utf-8?B?NlN4ampMYUJWbFhXQ083QzdXUFNpcGV5Q2JpMTRpSVRhZ0luNXVudz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c55eba-79bf-4568-0cfb-08deee515511
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 15:43:42.2005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXbnJjDUdV5+xgbHspQsjVqX/zWlMzXvyPM34Rvyde41AiE4ziocI2AM0IjTxVhP9V/amK1m9ydVn1Y9KOCWInXX565GgHvaIte3DBH6OT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3CpBppliaPOdOM1o2xL9vgZP+wOTyk2MdHPEK4hwdM=;
 b=RCDhg/nDbgZbLdS4Dy9F8+oqHcmAYf4act68dk/4IsP5ocRtHR9p8uek2+qXLUE8QkT1QEP2krQJWIlWei3ym0piPU6aX04Qk48E4W8SEGeCKoLXgiNh/0Raj0cV+7d9wUUru6IYq/Jbjyihgh99++LIf59A8GF+LM/pS3rAEJs=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=RCDhg/nD
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 7/30/26 3:32 PM, Johan Jonker wrote:
> It's not U-Boot's core business to host a script
> to create enums from datasheets where it's unknown
> that it has ever been used for any Rockchip SoCs sold
> after rk3288. We don't need it to compile, so remove this
> relict from the past.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
