Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12851FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64388848C2;
	Wed, 29 Apr 2026 16:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aDrCQS16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65F02848C6; Wed, 29 Apr 2026 16:59:12 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FC10848BF
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJDUDmqjVa3QFnxA3b/OKjN9423XIBlxJpW+gi2qfSFiu816GfqBV0pQr4pRjKo+Cw7p2Hf3M5oIY6E7Kd1XnucyTcOqLidItoZOP2FHmapt67yTmXfMlBcemjhL2Wd8mLdBZgVhTSv/neUVlWn2GudUxOMb3d7CNAF/mycCGF4iaSLMscLuBHJLGDXAjbpbe6gHcQzoFgqgL322X2xUfzMUipfEVG7bYHs7PD+2wv/25WzdKv4TWr+SF4mFIloelJQIlzbWRFjyQsvwLIFb5SnbtIB+YpuuT37PDVexHjIHYwzMcCwlduDbfJu2oRBXGm46wIYNDVKXNImlFqCq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoYPlyHAvBQ1e1B7Q31VaJs5dB8d4+NBwOSDQf2dJFo=;
 b=Dwp4y+uFs6OaA79JTwUqJD75GomBpQfFuGdWUNZoi7/JjSYu1QVKVCAnzXr33EH4J9tOAxdNKwLubuCNhRxPA2g+xgNd0K3vUOlUh/lLNLlVyS6UicrLSygEtYuBPHG5a4YHXzNL4ppsyE94Qyjatgi+U2aKBvImWEuOy8JCP1zRYYdyZJfIHW/XFgmfpyE+JwwGKp/b7vJZXT5bNlhtRkZLzLHM/wqYzgE6BeTAikncpARZFMz+1uIaxqAJdXIij2GGcZfiXz1HKiUNjN33iVL1e2Z0/iKHHoSUSmjVvjfziFEKUxlbTLxgCQnDHxH9HJDUuDkgbm4JgHGjTFd3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoYPlyHAvBQ1e1B7Q31VaJs5dB8d4+NBwOSDQf2dJFo=;
 b=aDrCQS16LWjOTOWBcZSk/2C5USnDW9Eq7s8nBRjzKZynHgEGqvIjqxPMUoiIruHkFSV8LzNO5xqPfuCkNp0u2yU8lhHrmkZ0VAgbL9YYmcX/+biE2w9KT7lhAdT8LNL3sro23ICCq6wgDTnkVqPzvEQ/FDAdXs+YKqtlhEWCXyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by GVXPR04MB10995.eurprd04.prod.outlook.com (2603:10a6:150:215::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 14:59:06 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 14:59:05 +0000
Message-ID: <01c1fa30-6dcc-443d-a217-b032a0a8b53b@cherry.de>
Date: Wed, 29 Apr 2026 16:59:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/dtc: drop yaml in DT validation
To: =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 u-boot@lists.denx.de
Cc: thomas.petazzoni@bootlin.com, marek.vasut@mailbox.org
References: <20260429144615.142350-1-joaomarcos.costa@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260429144615.142350-1-joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::17) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|GVXPR04MB10995:EE_
X-MS-Office365-Filtering-Correlation-Id: 2309cfd1-bb31-48eb-a52f-08dea5ffdbd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MSz6Z4DEZje3bHEPcWK6fREbNjxaVGQhc3UQiuzKpVByIXDNwgglTCkha4DR6sHMK8uTgiIcOcIsfIKRph5dsi7eBAFpdRhkYPcIaEo/6gkksUAbrEBOiOieLPScfKcvrgvb+/j+fyzLODmUbXDXdzjfG462TaOQSGRj78c9hiPfmJtN6ayxVqvzEfxQwTtqnlHTiEFgxCxGKB++HdbX8dxWa0r/OoqyeWr40tQ9EEQK58u//Vwwurs2Q9MTVeeRMEyTuMqR+1KeMCIzfw8m8++IYxSLWKHiirmjAd2+FHeDa9Fjpb4ec2BoCVMqbO7ynuXOo/pyYnHZOJQCgqM/kY9F139FEB6e54wWAE/sQA9T8IlXV161dGNLad75EnQS1TnGtyY8ffBhRqGiOzsXxNNNcI2z7VtM9xLgzdOw7Kj4Y/0KKQM96l0sIcGhklrwXDsVHSx1X7R4qMNPzBb2ba0f5pfIhFXIlmJWsTHFnbcLg8NuX+xieqcX0TNqoZx9QR3j2wEPbEr37l0VEDL+/GIUs6LZP52QZyq7pYkC35iosDXEPuubjErinMOQknHpIntFRDRbUUBVTDcXuuEsG70JdCN0jaS43N9vLsgFoQW8d5OSnr1Xkny6U2el7KJ72Rir76eZ2dFfJd03l2j6JSPoz9dGDiEp5ZbbT5r9tki3rIDK9hKlwQR9bVAtbSoQ3pLCAuWfTFsMGpdOfellqf33+8sO0jDWNc6dNe7FA8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW5LdUhNbjdxcGdrY2RVQnJlOWtxaE5MSVpnY3MzQ09iSTBnemtsdFhpVW9q?=
 =?utf-8?B?WTBSZFpXRFJnS1AvT3hQL0NlcG5ZYzdXV3JXeDhTREQ1R0FjRTM0RzhnRFNJ?=
 =?utf-8?B?NC9MMU9iWWM3WXhhTHVZc1pQNTB4SlFlMFZHclpnRldmeHBtR3R6NjNnWW1i?=
 =?utf-8?B?WU53dnFYNXNiSUtvZFlBS0ZnNmphcVkrWlBwVmJuVTE0L3k3NWdrYm1GTWVP?=
 =?utf-8?B?cldnTzBrS2oxTnVQZEx3ekV5NFhJWmZnampXWHRjTHB0N0tnaDhSTDlKNUtZ?=
 =?utf-8?B?d0F6bXZ1THNwVkkxRWk2YXJYblNvMGo4VWpsT3NOUmo2alF1ajR6cnJscWNp?=
 =?utf-8?B?VW1xSUNQWWFvMENZejZxeUtzek5kZHlmQ3NJaHNOajBjQ2JwWmlXcmdzMWpV?=
 =?utf-8?B?cHp0S0p0T1JSMXpuMG1PNzVTcDdManBRaWpTamRSUWlEejdxakpXVXhXMTcx?=
 =?utf-8?B?VitqOC9OUGFZRjAyOUtvZlNuaEExK1ZYeExoNlAxRXZ2MnlLUmtNRGNQNHdi?=
 =?utf-8?B?MUxEZEdaMTVabmVOOFNyclZISnNKdlJiOWhOeWdreE1HeTM0MTM3dm84YkF6?=
 =?utf-8?B?MjErajh6SlVhcDBQRkRHLzhVclE2TjZMV2d3OGI1RWtvcENZV1Fabk9URGFz?=
 =?utf-8?B?RFVWZXoxQjNlbjhpM05xOTlWVTdjSUhBVXFKZ1pEOTJzUitHTlRvVk1sdFBC?=
 =?utf-8?B?S2NMY2pNbHpEeEtreHZ1L1MycHBCZ0hpS0g4QUlsaE5zRVVkMVI1dk95Rmc1?=
 =?utf-8?B?cUVtcVFLbjBFZ0kxT1lsSzd4YWR2NVlzOS9YMEg0MWdlUW5FTTBoOWE0ZHJ4?=
 =?utf-8?B?N0FCbmE3MXlvdzhiWWhEbFlqVk1OQUdFdktKYWZaU0ppKzlnbUYzTWh0aW5F?=
 =?utf-8?B?cTFlRUViYThPQzh6VFdjd2FRcCtVKzlIbXhoNFlKcjk4ZElzbHhsbGUxL25Z?=
 =?utf-8?B?ZUJvUDlRVUpWTFJFUHBTTDUvaWU1amV0aHFSamIvYVNnMS9GRnZxa1FYcDdC?=
 =?utf-8?B?YjBPYWNLcmdobHpuZE1DcXhNczU0T2pxVGdaT1lTNGRJY0NLaFVHOHo5UWpQ?=
 =?utf-8?B?R3ZzSjBiRGxlU3hta3ExUzdHeGFnMjc1R1p0L095eEpYVitQTG04ZFdPdXZ1?=
 =?utf-8?B?bzRoejNlay82ekY0M3hxeFlCZHRVaTFBZE92YTNtN2hCbVF0SVBBK2tnV2Ur?=
 =?utf-8?B?dkwrTFN5Y0RrT3FSeG9DVnBIWmwxNnRiMnErSllDTUdzMVRSL2pQeEZBNUZK?=
 =?utf-8?B?QjhldlRHZG5FUWpOQ3dQZVd0U0h2SE1wNFgrNEhSazN4QVNXMjVmdG4wV0Iy?=
 =?utf-8?B?WW9lUEtLWkoxTjFYTTFwNmV2NFFKNVRpeTI2STgyR3F3QjBGT0xnRDA3dFp4?=
 =?utf-8?B?SmpRSDVXK2VCbE9oeWQ2dmRiYUFsUjFSTjhnaitHSW16Y2k5RVNxMzhNN2Vi?=
 =?utf-8?B?eVJCbTlsY2U5b2dLUjg5RnBwb0t5ZU9BSDhGbkFmRTZDYUQ1N1czUVVPYUk2?=
 =?utf-8?B?bEtZc3o3bmJiOHFTK1RweDhSOXUrOFV6eGVyY0R6ZDRVeWwzVHpFY09jYU9o?=
 =?utf-8?B?amxMTVZNUnJpMG1UNW5QRTJVejZ4c2ZTTTdVWXpMNE1oSDZ6bFY2WkRhZU0y?=
 =?utf-8?B?T1RkVStkQXZwdEtJbnA3a2x5L1oxUHZsQ1FNbXJzWXhBVkhXcUJlY2NzZkVO?=
 =?utf-8?B?SVRSajU0U1hmUXdNUHRxK3FMNDlWRGRWK2o0WHpZdHFPM3NaWGo2STFoM0ZE?=
 =?utf-8?B?MnVuTStmM1cyTEZ5Nm5UY3Y1ZWVPdGJvRGhjdTUyWTExWXZ4aWtHdzJsVjFh?=
 =?utf-8?B?K2Y4UU1oanpKSHdGY3FEVER6QThsQjVUUWFZZEFJRnhsY3lCcXpuUjZTTEdL?=
 =?utf-8?B?WmwrODg2QyswaGFDTFFScGdhWUhhNWZuZjcrSlRqOXJTdmNsL2VLSklwUWEx?=
 =?utf-8?B?aG5GZitxWTJNQ05uY1Vnai80aXYzbElIcEEwM0NsQUMxcytzSmhlcnhoZUVi?=
 =?utf-8?B?b1RXbG5JbW1LeTd4Y0E1UHdVeEpvRWk2V2VYaHdjVHVEMVNuaXUrNHVwcHNQ?=
 =?utf-8?B?aFQzVzArYVBmSHpwTmRQRUF2NHFQOWtKYmQ4RmsvVHMvSENOOFU1VXZMdU94?=
 =?utf-8?B?S2crYlp5K2R5U0hBcTV4b2N4ekFCVFcrRlZLL051d3dhR0lRVjJhdVVFZDRI?=
 =?utf-8?B?c1c2RElMWEJJVUpLRTRQSGtkTk1IZE9CNnFUTmNXaWRMZEtnRTJoZVY0WlVT?=
 =?utf-8?B?endyQWNzYVJEdGRWbjBlMWhLak9iazlUUFlDK0JpQjJZVUJFU3hnQzFKbU51?=
 =?utf-8?B?VDlwWWttMUhPZURFWXVXaHMwVWYrNzlGcllDY09DWVdrQmU4UDU5WnZHOURN?=
 =?utf-8?Q?NRmCRfzJMAtNRYdHLYQ4kechsl/z6867UhwRa?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2309cfd1-bb31-48eb-a52f-08dea5ffdbd0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 14:59:05.8620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOxZ758spaHDkcZWXJRaBIXNm/xuxEAbeoDvc7PJG11YdB4uBS7wIDXqVw5OypIBtQi1yZdyaDoR6/LIHKsYqJC+KbRvWbQLjlppoifdN+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10995
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

Hi Joaõ,

On 4/29/26 4:46 PM, João Marcos Costa wrote:
> The build issues found in dtc/yamltree were partially mitigated by a
> previous commit (807bcd844a: "scripts/dtc: Fix pkg-config behavior under
> sysroot"), but upstream dtc simply disabled yaml, and the same should be
> done here in order to permanently avoid those issues.
> 
> Backport the change below from Linux v5.18 [1]:
> 

I'm kinda worried we've been missing other patches since our last sync 
claims we bumped to 6.1 so we should have had this commit.

It'd be nice to know which (if any) issues you encountered when 
backporting the patch (e.g. things you didn't backport on purpose and why).

The few missing pieces in this backport don't seem to be relevant to 
U-Boot, so

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
