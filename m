Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D57AC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04482812F1;
	Fri,  7 Aug 2026 16:07:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L_y6gZ11ICjZ; Fri,  7 Aug 2026 16:07:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 37AF481301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786118857;
	bh=7FbSzA65qhpC2T97m+/4UCsSluHW1/pvac8Loa/VjNY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tiWxMt0ilOusvE/a1WHaGCBPLdOPNoqSEB0M1LSgX4jVRkOsLInH7IYJvexE6XpMn
	 /O2RtTIE286/ivM6yGE45cazQYj6ivQ5XuRAbpecwRAR/PfOyUrJK04ckOQcJkx9cR
	 oYkz2lpiyMrSPEeCBNdmxzmPlwQWLlOrPdX62VWd6IUIQK51gG8r7xm5eii7tVbX/j
	 1eVinObiFSBFX9GyzGtua99luTyt1IOKYnbHxx65j+rXsd6iSiOb0uBNO8q6x1Vd8a
	 ZScVDuMbhxk55cBGAKPl/wO9H9O7tx14GFboTg3FoH1AxEidpngNf1J8POug2nRnlI
	 1xGdHp93H5QXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37AF481301;
	Fri,  7 Aug 2026 16:07:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F0F702F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EAAD4607E4
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:07:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U0Z6mSh-sILi for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:07:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 18F3760685
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 18F3760685
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18F3760685
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:07:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HO33heabLQmTfIi76AsDPx7i7n3DzrwhpcSfrFdFwiully+Q20qTr0Ayg5kTyxKX/R5igrpR+aqaVMmxElr7ZU2wc8ex1RyOkfHucAIyU2eW/3myuo3gyeCrsp50+0bYKF1lPDzXqYzI0b4cgEEz1AIF1HLvg7SaBAzEOt8MDjipm3RUgj+Wu8T/yJxK/UMtik97Faks2fPwO70JI0QsfB6B4nBscZQlQOafpdTnJFwrw1VHIMzoeBsDeWmV2s/CdHVmVSa8wEnUPV0B86f0mt5gyepQmVjsLgi5CFWwKpQLaXV1gpVoNs5/MV1koTzTPmCRMkTzcBkgWEtw695W9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FbSzA65qhpC2T97m+/4UCsSluHW1/pvac8Loa/VjNY=;
 b=YLMPrjaTRTyuDEkqWOaXbODc/y9Pf9qmoCFtOJAXvZ1TtHaVfWLWU+4wEibA2qFs3kUSUmmYMW0sWaQS1c/K3YIl9CpWUXVqMIC5ajMRn9Hh2MJO5E7BY27i9pXPduYDC3Rw+MnS9cbBaHYgobhfJRKvNh1Gq3SMuFyDfVlQ0tFLBL8ahFctKk4Ri8+Mwo3ZUpWS5FCCfDu2kmzOGqtNvRyZHUcygYc3My9qizymq2BX9a9XWtKu5QB1X1JuD5inK2E2jE2Ec8ln1ByXkfZY5fnigKKWxBY1rr3dHtDtaS9kPEm980ff2srQzIZIrhTuwtFmGmk5Qvl77DWHbutbQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AM0PR04MB7028.eurprd04.prod.outlook.com (2603:10a6:208:19a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 16:07:29 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 16:07:29 +0000
Message-ID: <17437a38-6c72-4e2d-82dd-fc2259dad976@cherry.de>
Date: Fri, 7 Aug 2026 18:07:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] clk: rockchip: rk3528: Fix trivial clock
 configuration errors
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-13-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730141308.1218014-13-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0125.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::23) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AM0PR04MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 271e48ce-539a-4927-ee44-08def49dfad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|1800799024|376014|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: tUz8oV0KuPaJxX8Kpdfs4aZS3/WMQzN83SmrRWuAAOield2vsNFQjfQMMzv+HZv6jthJtCmZ3/6Rs7RmzSRvbQzCCd8RM4ZLYewY+DwL6jeh/qmeqI+6FjXMyDGTy2ZIE86e7hjsVVTDFoIwgWnl3nZm8PMRZNrlNo3podS38tAepvNZsROVtHP07T1b5qO8YQjLEcr9Aq/SkXCyn6PsTTINGowBq+hNhJMlUH+Fu7SIGS8yjl6k5HySxBvGokWK5Ix40zEVrdwY6ZNT55EP/2WI6ZlVnZCgJyM3CnniFkdHRK3PSxeeVt82N2qNRSYIMkGnDu944Gu0MrQyOqxBNffh+1/lIYkuznwMXqssW37NiEOV38qpiipBqV1J6DMRTYN5BEvqeFQeRYbq1TZovRe4nRT/Q6nkojIx5qXNdBkvqrZmWsgwxsOw3KSKahmGE5jpZVFbMsJ4F4wfDW8BUYTQAkwLb4ICSQNbIY/+HmYAWv0/+1alGI/WJHgIiUuQqBtLvlNICjREl5+r2DRMSnmoRDwQFkspi8IBZbAAluFCD2Vl6rsxWttXXtTf7a6jVXppmHeFscNrYkpeyyY8j9FOCRI79xiJVxI5+gXdp+dScld2z7Ex/spTZkoPHJfWInvzEC/s1iw8I8rSDCpcxLBX3c2kA14zulg0fEwyzPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2tUVTMvQXRmVmRMTzdpRlViRFpFYUQ0dkJpVGlIb3BWcFhQTnp6S0VjVndX?=
 =?utf-8?B?Qk9uRDliOE1KQkpIazd5aE9XOFZ5THExUU9odXpyc3F2enV1eHhIbGhBdmQz?=
 =?utf-8?B?SlZkRnJ3SE1zVDJxTytPdmVQVHVkcktlSHVyaTFaK2V5Z2NOY2dCR2pKWWlN?=
 =?utf-8?B?NXBnVm1rS2xjaUdnRWlsd0NzWXN4MXNjcVRiNjZSd0dxaUlkUFJsNEFPTSt3?=
 =?utf-8?B?UXMxUmlnazUzbzdVRTVJSWVUVHJCNHpWbUpYRGFhR2xrU0FENTVDNnhTNUZS?=
 =?utf-8?B?eFNXZzFEUnVhTzg0UFp6b2JJbWhMUTFtbkVBbGdVVkYwWDBuN2dMZDVNNUpa?=
 =?utf-8?B?SE95OTBNcHpHQy84akZuTVN2SExRaHpKUC9QMGsxa2FnRkYxQjdnRjVSWS84?=
 =?utf-8?B?alV4a201TmFMS3pTSWlGcm1qeGNMbzNUSU1XTnVSOHVCUWNnY0ZVSnZDS1Q1?=
 =?utf-8?B?Q0dvck1HNElFT25Bb002aVRUQ3NSM01abzV3aFR0V29vRGk2VlRTVzBSVU1a?=
 =?utf-8?B?K0MvTURyQm5JMVhwVkJ6Y3B3STRKbGlGbGxhZHZrNzhZQ2hKTWVySS9hMkk1?=
 =?utf-8?B?c3REZ2gzZ09iK2t0bklBa1JhTFprT0c2Tjd2eDFRQ0dOcWFIYjhKMzVGaEpp?=
 =?utf-8?B?WmlFK0c3ZEFpS1hoNXhvSDh3U05XTnpScHFzeisxellsbUg5TU5mcFdCakZP?=
 =?utf-8?B?NFZ1V1NJSHZkYXdQS1BWa0NqaFF4eXh4ZEpWUDNLaDlQaEpGM1pTL3ArU21q?=
 =?utf-8?B?WjBaWlV3YWdhU09jU1NQU1dycDNvWHlBSndTempVUUFlK0tQdXhVTS9IaC8w?=
 =?utf-8?B?dXVndFg4Rm5DNUhWMS85eEswaGNPVkdXZ0hSaytlWFFhZzBQUW5xZ05iUlJu?=
 =?utf-8?B?UTh1WkFNSThzeFArdE5GY0ZySmxmekJGWWFkZ1psNzA0ZDdZMHVKVnp4NUFl?=
 =?utf-8?B?a0xBYmhtTktMbUovbmdwWjBQL0s4dkZ4UTR0dTg4ZkoyVmdFcVk5ZWd1LzNu?=
 =?utf-8?B?VWZPdWwvbVc4RG0yb29pQkNyUUtFQVU2dGpoYzdudVlZL01UOCttTUtZc1NQ?=
 =?utf-8?B?YnF6SjlObmJyY1V1b3E1bis1ZmkvRWVKSVpCaUlKTTdzNUdhblR4ZWo1Sm0r?=
 =?utf-8?B?VGlNWk11YWcvMlBDZ1lQRkdFTDVER2RIdi92ZktuQzV5eTdCV2p4YzJLWFVa?=
 =?utf-8?B?MmIzanVLemwyWDNsVTBhSFRhd2M0MnYrVHZLYXdBa2NNU1dlMVBVU2kzcFIr?=
 =?utf-8?B?azR3WWZMdFIwSlR3SXhndXFKZHlKREdTa042VW02RU4yWWpyUkQxNFJ6L0dN?=
 =?utf-8?B?RHhwcDg2SkY4N2pkVHM2LzI5WVI5WVE0ZE56RHdPbnNoRW5xczVKRlUwVmxh?=
 =?utf-8?B?dFNGOWZrUTZtR0xzQy9sK1djRnJRYWNGd2dNWWNQK0ltbmJJNDdFTVovcUY4?=
 =?utf-8?B?SmpjaGtXejh2OER2REV4Y3U5WU1MandxbmVzZDc5QytOYnhMZUIrUWROZURj?=
 =?utf-8?B?TGxhTnNlMmM3eXdYQVVBREMxcDZUUHNsSEkwOGpDQkZWMlhMT214UmEvU1oy?=
 =?utf-8?B?eG9sa0piaTJpSTNOSjhLZjNZOVNVYUt2cXJCWVQxYjNtZzY3TkpEbFBpQ3cr?=
 =?utf-8?B?RXk2bTQ2UmxqbmJibXhKZUpMdzB5WlNpNDZuTUFXUmovYkhPODBUZ0lnamdH?=
 =?utf-8?B?dGxEV2tRZ1Z1aUVQU2JwRzVNSytSdDhVQXNLMFZnaHRhTWhkdEpZMXorQjQ0?=
 =?utf-8?B?aXBiNVh6U2tJUEpxZjloVmR4RUI2OERYUzg4UEVCK0hDNVVBcHlpUkRHTUJO?=
 =?utf-8?B?Sld1cXp4bGl2dmMzZlhYSGRZd3lSOStpTTZFblpDL3hmL25aaGJTSzFPUWlJ?=
 =?utf-8?B?S2IyVG14TldHcE9JWlRIQkJkZEIvMTRYTGIxcjI4Z1M1VjJXMU55Wkx6bm9N?=
 =?utf-8?B?dVdoWnVBeUdpcGJXbFhhVGNuRzZlb0hEaE5MMWlkQkhJbVpYQjZVV1cwdTIw?=
 =?utf-8?B?bjREK29tV29qbFVSSTlTNmlxWW5reEdFRFZhRTZGV0xqdGFrdjUvREFRWVo3?=
 =?utf-8?B?NWM5RnRwaktjL0d0Y0grYzVaeDN5OTk5REtsL0xadFVWRlBBcDVpYlpMYUhl?=
 =?utf-8?B?cFlCOHpmbE9WaFVYVEluZTVhUDZENUNNSEp4Z1VwczhxSjFHUUtxY2c0M3ZS?=
 =?utf-8?B?NUE0blVMNitYWFNGWmo4ZWxadG1JZW9jSVkvbURNQzIvTWVmSUw2Qk52eGhq?=
 =?utf-8?B?MXVweHp3T3UyVVI3MWtIcDFNMHN2emJDeEl3S01ERHpEUUU3eG5EeS8wcWxO?=
 =?utf-8?B?d0krZ2J0RGRxNFdNTnA1TWpZWFdRalhNN2N5a3h1SHJkcGIwTTVWbWd5YVI2?=
 =?utf-8?Q?OqGXVLv1FnMHaKRinpWVEuCIQi7TQiTey6wD23hlC5jQV?=
X-MS-Exchange-AntiSpam-MessageData-1: rPir2nPTyIrXo0fDA0ihd5+h1H/X1n9J618=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 271e48ce-539a-4927-ee44-08def49dfad8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 16:07:29.1394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zP1GKpOg5k4hiResHa2Hc0tzL1hj1dKsT6KLogQBsnhq3jEkVGDTJTmAq04WESR4gvLe9q7RNQwnT7ATfhvw4qMLkhCVogDTeSzSHB3bY9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7028
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FbSzA65qhpC2T97m+/4UCsSluHW1/pvac8Loa/VjNY=;
 b=YLdDqCSd2kvC15lM0w7ubHHsXRHqwWr5zY8nVlu3snhJY51O0Tc9LjXteL0+PM0pGz3GQBjOspH0K4T20mKWWykGFFlFX9LgxqrWIyHL3cFL+ztzEqaPIk7Z76lWAEtmCqLvRfiqA7/AlYIIW3A/tAgue+lnGHbXE1M28Tzv/i8=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=YLdDqCSd
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

Hi Jonas,

On 7/30/26 4:13 PM, Jonas Karlman wrote:
> The RK3528 clock driver has a few trivial copy-paste mistakes in its
> clock handling.
> 
> Fix the trivial clock configuration errors:
> - avoid reporting incorrect PWM clock rate
> - use correct mask and value for VOP clocks
> - align PPLL configuration to match other PLLs
> 

Individual commits please.

Fixes: 5a7a856b132f ("clk: rockchip: Add support for RK3528")

Once split, you can add my:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

for each commit.

Thanks!
Quentin
