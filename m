Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5A6FF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 17:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EBD3848B6;
	Wed, 29 Apr 2026 19:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="xclaLhUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8916D848B6; Wed, 29 Apr 2026 19:09:58 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DABB884885
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 19:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxlrMFYj2AShIJ0SZBPAlw2upABKfLGDvnkbByykrG42DkV0ZAhDjU0rSup5qZelmLUeLLIqT8k4B8kCW7T19CTIDSZpdLU31KM0A5h/gvuPo45P5lsZBq8j5fCN5yvQ3LBkoV2u3vkSoG1X6uodiB6dJfJ4B6i9SbjPqdgbtzKCI/Y48IyqKOahj2RlIdN+gMi/Y68jBqTx7F8w87Ey92rJPCQJ7c07a2agZkvDjHW9e/Qa07TyWE0qpwX54UqiBkE703fWj5Q+EGECYmLPHUpLiml3E8aOQ3VqIEszUcJFW0/ZPmS3oagKdWtTb7MDwizmuXLagmuBCDfOxd1THw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a97UwUGQdGwuo3h48GhXX22Kd3t3l3Kux1fQbBaRmkQ=;
 b=k7qX+Gpo+PcvifljhoCvOwVUAiszKdRSz6dkUrVaHZZjJ+5kW6IUIMkhGLJp4BCFkIiFoNfAYyq8JiEEUbP2wrkU3OfF5kfSIroRWjBsqDAPXWgQ9yXtUtfFfuCdvimgc/WXY9BpLmdUC2j03RZaUZEoMTDAv4nrbENPRwNrLxxaZBgFZSgG/xErfz1jRPJyH1CDzS07SCoyH2/gliPcA6N8osuihOuoac1IWO+Z0gk0uOMudkERO97Nsdsi+0j4qIW5c9aALgGZCyFv2QgbfUb9llCs8l1qxHSoWgZgJ2Ci8yc5n7b5Wfyr1wpKL82ho5Vi+by9QBaYEKo2o9Ew5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a97UwUGQdGwuo3h48GhXX22Kd3t3l3Kux1fQbBaRmkQ=;
 b=xclaLhUHZY9YkIC5NCWEN+rIfOKFVU4Ika5VFp2x3BByLUORGqgc3wB5bNbsfYhLbETjr++06EbA49DlYBFbkpwwSvSb4e7qPIpDv0lmOKBm1DyI8tHGV4q8iwJwuDoPv+d2EGJqTMahEEi0K8KzVMAUMWb+H1+4IEMofwh38bVXGUNxEvbr20x0hj4srp6mko6QJQjdX0y2ftaV9tc7u40YSyUKDD3sgL6z//Y+YpGTu3uWp4I1qkI/4jSfw3IZbsHdUpbGA/lPH2nmdv86uTlgxGzcfeCRuHudUmOPSDaj2ygrGwvkhtHmYF6kwm/JsJj4FPupGZDNQc/ioKGGAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AM0PR08MB5362.eurprd08.prod.outlook.com (2603:10a6:208:180::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 17:09:51 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 17:09:51 +0000
Message-ID: <bb3d92fd-0ef4-468f-a3d7-f663f59b5251@iopsys.eu>
Date: Wed, 29 Apr 2026 20:09:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] pinctrl: airoha: add pin controller and gpio
 driver for AN7581 SoC
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Anis Chali <chalianis1@gmail.com>,
 u-boot@lists.denx.de, Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
References: <20260428153448.980150-1-mikhail.kshevetskiy@iopsys.eu>
 <20260428153448.980150-3-mikhail.kshevetskiy@iopsys.eu>
 <5f524c23-d21f-49f6-8b26-778654c41a42@baylibre.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <5f524c23-d21f-49f6-8b26-778654c41a42@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1PEPF000008D0.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::42d) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AM0PR08MB5362:EE_
X-MS-Office365-Filtering-Correlation-Id: b69883da-58a5-4a6e-2165-08dea6122034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: rVeRLGPp1HbWIwI6UeinZcDzmQM/I/wcerzGUl1CjYz7+C6ddyZYUp2W3yRXKxqNGcZynYib7KTAMJyGRZmNY0UvLJM7wwpbkrRbt/9fKWYLArSRwfwYzB1o9c8JkIT4yS59h4q8QIXNF4GckSFLhMyCxNR/9ZUVI6fSIdWwEF4XKmVsbXG1bZjgmYo9yiRTaTm9QHAYDIQvimP46HOWBfYC2SCPYJ2GS2jSdQOQiTPkc7EfpWVSVJVDJ96A+Gy+hC8YUiYqTET1eqrDPe2t+lNUhyA+sIzCgqMIeoZXIDpjls3NoLFpTiKuDiXcK248fd34yP5m6RxsXWilaq70SqZjeJ5d7sfXHmQVT+HwndYmbC6OCmvF2KvvpElfUaEEmChSnHzFk+fLZIvtJFFhtpmkp7TCuWkcVb/iETxRTWwXSccS4+1ftThXPiSabjXSZ48r1Q0zqVK7ZV9OKBkcFReOsTuXV4xZjQ0GFM1lc/e5Q7VQHsAWbD99kBknmI2wxR2Li+R32FnLKR/jX622RaW5H8iVWOBVCVYea6/Wi17Pro+T2sNPgWPrYwMyvUCs1ioB6lzZLlkHMfTLNbX3Js4nM5MZMUFpAZ8jsuA/R0XJB9y/cfl+44XlXr1mw4cBgwZC1ZIEyXgtMOnjobP3qnQ2TSO6OWsVuKdNEF/W2Ldshwl5MyUmhh8S2TN4M0GK0CD4OWPx3rZG2ZYUPjF0u8VPdWDOqHhR5xB/24GuxyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3YvWUdXYWZtb2xpdHU0d0lITWxTbnNxSnU5bnJtQXFjMWxWTVNJMDlqRkxt?=
 =?utf-8?B?VnJSVEJrMzNIMU01YTZmQmVEWktaMnhlbzdDWkFIRStoYzBNeWtkQ2FvOVlH?=
 =?utf-8?B?NEdpTW9yVFNoNHRyNnNKNnE2RkpqSG4wL2ZlVG5xYTMyRHhtemF6T3hnYVVI?=
 =?utf-8?B?T3Yvb0pwUkR1VlZIbGRIVUc5ZG5VbHZGTnV5Vmh3Z1dlSVBKUFJzbmZXakZy?=
 =?utf-8?B?ajd5dllWVStlOGU2YmhITlBvbXg0VWh5N3VqZ0hUTjNvQUtRZ0R6YjZ2YU9C?=
 =?utf-8?B?Q2ZqRTlCRW9qTUg1ZTMramJNdUt1SDlHUG0yQy91emU5Qi9BaU8xVzlTK0kz?=
 =?utf-8?B?NHB4eUdyaFhkV1VtNmpMZXVqWm1HRTM5QTBZcVplaDZiTDJyT016QlJSNUFh?=
 =?utf-8?B?TUk3aWI5UWEwdENvK1h3UHUyMlZxSWdiRVNvbzl3OWtsYm9TSDIramhhdzNZ?=
 =?utf-8?B?bEpFa3BtdWdMK0lYME5DeGEzY3ZDb21wNDJEYmpHSlFxdjgxd25YVUtvZkM1?=
 =?utf-8?B?SWw2YTJzWnZTT0d1SSt2aHorMUxmS29ZcWFjQ2MrTldwLzRBdVVFMWt6UmlB?=
 =?utf-8?B?UVVhaXJjaFoyRUFPUll6ZHFrRkxFNU95dDhsd2VYbDdsb1RSS2htM0JaaXdj?=
 =?utf-8?B?bWY2bVcveTNGZHpTai9IK2V0VkZ5R1dyeFNUUlVkWExUaFlkSExSemprTzRE?=
 =?utf-8?B?RnJWY2ZPYVhBcS9FWndHVWRheGlrY0xzRmlJZGYxVk5BbXRQQUlZVFJkWFFG?=
 =?utf-8?B?MTAyaG5PTndlRzhvQk5oNEJCSEhMQXNXSmJqMzluTklRTjB4dmdCT1c5ZTFR?=
 =?utf-8?B?cy9rODhadVVvTUN3RkFTMC9FZmpObzlYekpLZXZjSGJwRE1tdmVuZ1p5dXhC?=
 =?utf-8?B?MEdBd2c0dVhUNU9rTlF4ckxyUFlhVHlGYWFuZEU2azVRY0NDdVFqbFhMRDk0?=
 =?utf-8?B?ajNhOWJ1S2poeVJzYnIrUW5CU0FNN1BiWlp4TlRzSTZLOFpBVzRWZG1DdndT?=
 =?utf-8?B?SEtqUGtrUXlUUmlBOTQwNEllQUFRejFHNDF5VkpVU3VSTTNXSFovK0J6VDEv?=
 =?utf-8?B?UDl2dC9IbnBlOVRXcWQxZnd5eTE1NmxoVGFRWE5mOTA3eHRseHJWZUZEdjJ4?=
 =?utf-8?B?OG1PY0NRZ0dwZURxS1orSjROOEh3RldTK2dXblhDUGxSSWhGWnc2Wnd4NzA5?=
 =?utf-8?B?UTJ6enlFVGZwUFdGZlc4eXNxZ2I1L2ZlYjhLSXV3Z2FxbHFrVlQzbXIwb2Y4?=
 =?utf-8?B?Z09kc0tOMjB5QklqUEJKazlGVXRsZFM2dnl2TW5sNHhjUVNGSlQ5N3dzb2o2?=
 =?utf-8?B?VW1GZXpPRHptenJ2MEZjdzM5RENlSHA1QzBBcHFIcUZLY29NOTVGSXNXcjA2?=
 =?utf-8?B?VEkrMUhlKy9QNGdXeHNleE5BT3FBclVjUjM1TGJJN0ZNT243UUdmcHhpMWNm?=
 =?utf-8?B?MUJURFpsU0JURTJpRFRmajFCY0c2WFN3NkdSQ1pWVjBMMnFrVXdQRUxIakUy?=
 =?utf-8?B?K0c2QlJrb1ZyWVNCUWQ5Ny92bDBCcFB3bTFEOWlJNXlvM2VqZHNLNkR1OGZj?=
 =?utf-8?B?RnVYcnZTdUN1amIxbmhnVWY5elN2NjFNTWJocGNyWGF3M2lGbTMwOHkvVkQ3?=
 =?utf-8?B?NFZ0VnBUWnZGaVdrWG5qckdKeTNkSTdVSmg1MmNpOXFpaHNjcXIraGRXWW9P?=
 =?utf-8?B?MVk1YUVaNEJHUEdic2U4WnlncTdld1laNGpUWXJnWitWK0wyV0haSVQ3b1ZC?=
 =?utf-8?B?M3V3UGJhNEMvR0VaRkhSbzR3YXlpWnlzZ1V2V0dLVldaTXNCbGF6NmRyaURM?=
 =?utf-8?B?M1ZGUUh5cU1UR0F5RC9JMTVZUURKQWg2d2xPSXp0R1o0VURWaVR5ck13VVFm?=
 =?utf-8?B?aWpqSEpQcUVwUyt2YVFQbFh6Y3ZycjdFOEZMQ1dzenRiVThJRUY4TU80YjhS?=
 =?utf-8?B?bzB3VEtoZ2poalFSVWFaQ2tSYm55ZitwYUtmUDBTcC8yV2JVbVpHNWhsNStB?=
 =?utf-8?B?dmIrUVdvWGFPNm8zVTVYM3k4SFBxRm5XNHVTSTZQS0kyZG9ZVjEwYjMzNWN1?=
 =?utf-8?B?dlhEUnVZWGRhbWlBaDVCbEJDZEs3akFtVXpGRms0VzNWV0FiMzdjWDY4cHNV?=
 =?utf-8?B?U2FrVlVNQTJxVVBTOTJvKzMrczJsNk1qUGZGMGdYNEE4WXZZUmVONjlkc0FB?=
 =?utf-8?B?eEZuTWNhUi9Zcmx1S1pEUW84VkFCV3BMajdkcXUwN2FhZlNKU2ZZS2kvM29J?=
 =?utf-8?B?VnY1NEdDZ0hjOVRwYTF4UzVRaEhRb01YWUtkZXNMRXI0UTZxTDFORTRUNmF5?=
 =?utf-8?B?bjZpcmVpN3ZKWDJRREl6SzMxQkVxZ3VUL1hldEhnL1pwcy9jeUtlNmRyc2V1?=
 =?utf-8?Q?KGM9DZUwRJYoSnRM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b69883da-58a5-4a6e-2165-08dea6122034
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 17:09:51.5433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3cTIirpjIwANyG+ZwFX0JyoACgzcw7+UF3lMYvEtaVWw92pgFcMGO8NoUoIS07lGL9t7DLjaJ2fMqxubzVwsvlwopZYcJFWq+EBX7CGMmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5362
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


On 4/28/26 23:42, David Lechner wrote:
> On 4/28/26 10:34 AM, Mikhail Kshevetskiy wrote:
>> The driver based on official linux airoha pinctrl and gpio driver with
>> Matheus Sampaio Queiroga <srherobrine20@gmail.com> changes.
>> The changes:
>>  * Separate code for each SoC and keep some of the functions in
>>    common between them,
>>  * Add pinctrl driver for EN7523 SoC.
> These comments above seem more approiate for the cover letter.
> I can keep the cover letter in the git history when I pick this up if
> we think that is important.
ok
>> The original Matheus Sampaio Queiroga driver can be taken from the repo:
>>   https://sirherobrine23.com.br/airoha_an7523/kernel/commits/branch/airoha_an7523_pinctrl
>>
>> This patch adds U-Boot pin controller and gpio driver for Airoha AN7581 SoC.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/pinctrl/Kconfig                 |    1 +
>>  drivers/pinctrl/Makefile                |    1 +
>>  drivers/pinctrl/airoha/Kconfig          |   16 +
>>  drivers/pinctrl/airoha/Makefile         |    5 +
>>  drivers/pinctrl/airoha/airoha-common.h  |  513 +++++++++++
>>  drivers/pinctrl/airoha/pinctrl-airoha.c |  691 +++++++++++++++
>>  drivers/pinctrl/airoha/pinctrl-an7581.c | 1060 +++++++++++++++++++++++
> Let's split out an7581 support into a separate patch too and have
> this patch just be the core/shared code.
ok
>
>>  7 files changed, 2287 insertions(+)
>>  create mode 100644 drivers/pinctrl/airoha/Kconfig
>>  create mode 100644 drivers/pinctrl/airoha/Makefile
>>  create mode 100644 drivers/pinctrl/airoha/airoha-common.h
>>  create mode 100644 drivers/pinctrl/airoha/pinctrl-airoha.c
>>  create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c
>>
>> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
>> index 578edbf8168..46a95a1ab6b 100644
>> --- a/drivers/pinctrl/Kconfig
>> +++ b/drivers/pinctrl/Kconfig
>> @@ -405,6 +405,7 @@ config SPL_PINCTRL_ZYNQMP
>>  
>>  endif
>>  
>> +source "drivers/pinctrl/airoha/Kconfig"
>>  source "drivers/pinctrl/broadcom/Kconfig"
>>  source "drivers/pinctrl/exynos/Kconfig"
>>  source "drivers/pinctrl/intel/Kconfig"
>> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
>> index 29fb9b484d0..b03e838ab39 100644
>> --- a/drivers/pinctrl/Makefile
>> +++ b/drivers/pinctrl/Makefile
>> @@ -24,6 +24,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl_pic32.o
>>  obj-$(CONFIG_PINCTRL_EXYNOS)	+= exynos/
>>  obj-$(CONFIG_PINCTRL_K210)	+= pinctrl-k210.o
>>  obj-$(CONFIG_PINCTRL_MESON)	+= meson/
>> +obj-$(CONFIG_PINCTRL_AIROHA)	+= airoha/
> Alphabetical order?
Could you provide your vision or more details?
What is the best sorting strategy?

Should it be sorted by CONFIG_* usage or by corresponding filename?
Should be files and directories sorted repeatedly?
>
>>  obj-$(CONFIG_PINCTRL_MTK)	+= mediatek/
>>  obj-$(CONFIG_PINCTRL_MSCC)	+= mscc/
>>  obj-$(CONFIG_ARCH_MVEBU)	+= mvebu/
>> diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
>> new file mode 100644
>> index 00000000000..986d23c2e3d
>> --- /dev/null
>> +++ b/drivers/pinctrl/airoha/Kconfig
>> @@ -0,0 +1,16 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +config PINCTRL_AIROHA
>> +	depends on ARCH_AIROHA
>> +	select PINCTRL_FULL
>> +	select PINCTRL_GENERIC
>> +	select PINMUX
>> +	select PINCONF
>> +	select REGMAP
>> +	select SYSCON
>> +	bool
>> +
>> +config PINCTRL_AIROHA_AN7581
>> +	tristate "AN7581 pin controller and gpio driver"
>> +	depends on TARGET_AN7581
>> +	select PINCTRL_AIROHA
>> diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
>> new file mode 100644
>> index 00000000000..909bd9a04d9
>> --- /dev/null
>> +++ b/drivers/pinctrl/airoha/Makefile
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
>> +
>> +obj-$(CONFIG_PINCTRL_AIROHA_AN7581)	+= pinctrl-an7581.o
>> diff --git a/drivers/pinctrl/airoha/airoha-common.h b/drivers/pinctrl/airoha/airoha-common.h
>> new file mode 100644
>> index 00000000000..21bc9f50083
>> --- /dev/null
>> +++ b/drivers/pinctrl/airoha/airoha-common.h
>> @@ -0,0 +1,513 @@
>
> ...
>
>> +#define AIROHA_PINCTRL_PHY_LED0(variant, gpio, mux_val, map_mask, map_val)	\
> Might look nicer to just use space instead of tab before \ on this first line.
>
>> +	{								\
>> +		.name = (gpio),						\
>> +		.regmap[0] = {						\
>> +			AIROHA_FUNC_MUX,				\
>> +			variant##_REG_GPIO_2ND_I2C_MODE,				\
> Indent of \ seems off on this one.
>
>> +			(mux_val),					\
>> +			(mux_val),					\
>> +		},							\
>> +		.regmap[1] = {						\
>> +			AIROHA_FUNC_MUX,				\
>> +			REG_LAN_LED0_MAPPING,				\
>> +			(map_mask),					\
>> +			(map_val),					\
>> +		},							\
>> +		.regmap_size = 2,					\
>> +	}
>> +
>> +#define AIROHA_PINCTRL_PHY_LED1(variant, gpio, mux_val, map_mask, map_val)	\
>> +	{								\
>> +		.name = (gpio),						\
>> +		.regmap[0] = {						\
>> +			AIROHA_FUNC_MUX,				\
>> +			variant##_REG_GPIO_2ND_I2C_MODE,				\
> Same as 2 comments above.
>
>> +			(mux_val),					\
>> +			(mux_val),					\
>> +		},							\
>> +		.regmap[1] = {						\
>> +			AIROHA_FUNC_MUX,				\
>> +			REG_LAN_LED1_MAPPING,				\
>> +			(map_mask),					\
>> +			(map_val),					\
>> +		},							\
>> +		.regmap_size = 2,					\
>> +	}
>> +
> ...
>
>> +enum airoha_pinctrl_confs_type {
>> +	AIROHA_PINCTRL_CONFS_PULLUP,
>> +	AIROHA_PINCTRL_CONFS_PULLDOWN,
>> +	AIROHA_PINCTRL_CONFS_DRIVE_E2,
>> +	AIROHA_PINCTRL_CONFS_DRIVE_E4,
>> +	AIROHA_PINCTRL_CONFS_PCIE_RST_OD,
>> +
>> +	AIROHA_PINCTRL_CONFS_MAX,
> No comma on this one since it must always be last.
>
>> +};
>> +
>> +struct airoha_pinctrl {
>> +	struct udevice *dev;
>> +	struct airoha_pinctrl_match_data *data;
>> +
>> +	struct regmap *chip_scu;
>> +	struct regmap *regmap;
>> +
>> +	struct airoha_pinctrl_gpiochip gpiochip;
>> +};
>> +
>> +struct airoha_pinctrl_match_data {
>> +	const int gpio_offs;
>> +	const int gpio_pin_cnt;
>> +	const struct pinctrl_pin_desc *pins;
>> +	const unsigned int num_pins;
>> +	const struct pingroup *grps;
>> +	const unsigned int num_grps;
>> +	const struct airoha_pinctrl_func *funcs;
>> +	const unsigned int num_funcs;
>> +	const struct airoha_pinctrl_confs_info confs_info[AIROHA_PINCTRL_CONFS_MAX];
>> +};
>> +
>> +extern const struct pinctrl_ops airoha_pinctrl_ops;
>> +
>> +int airoha_pinctrl_probe(struct udevice *dev);
>> +int airoha_pinctrl_bind(struct udevice *dev);
>> +
>> +#endif
>> diff --git a/drivers/pinctrl/airoha/pinctrl-airoha.c b/drivers/pinctrl/airoha/pinctrl-airoha.c
>> new file mode 100644
>> index 00000000000..c8a22792d51
>> --- /dev/null
>> +++ b/drivers/pinctrl/airoha/pinctrl-airoha.c
>> @@ -0,0 +1,691 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Author: Lorenzo Bianconi <lorenzo@kernel.org>
>> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
>> + * Author: Markus Gothe <markus.gothe@genexis.eu>
>> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> + */
>> +#include <dm.h>
>> +#include <dm/device_compat.h>
>> +#include <dm/device-internal.h>
>> +#include <dm/lists.h>
>> +#include <dm/ofnode.h>
>> +#include <asm-generic/gpio.h>
>> +#include <dt-bindings/pinctrl/mt65xx.h>
>> +#include <regmap.h>
>> +
>> +#include <syscon.h>
>> +#include <asm/arch/scu-regmap.h>
>> +
>> +#include "airoha-common.h"
>> +
>> +//#define PINCTRL_GET_STATE
>> +
> Drop commented/dead code. If there is a good reason to keep
> airoha_pinctrl_get_conf(), the make a comment there, otherwise
> drop it.
>
This code allows reading current pinmux/pinconf settings out of hardware.
It might be very useful for debugging reasons, so I prefer keep it.  
>> +static int airoha_gpiochip_register(struct udevice *parent)
>> +{
>> +	struct airoha_pinctrl *pinctrl;
>> +	struct uclass_driver *drv;
>> +	struct udevice *dev;
>> +	int ret;
>> +	ofnode node;
>> +
>> +	drv = lists_uclass_lookup(UCLASS_GPIO);
>> +	if (!drv)
>> +		return -ENOENT;
>> +
>> +	/*
>> +	 * Support upstream linux DTSI that define gpio-controller
>> +	 * in the root node (instead of a dedicated subnode)
>> +	 */
>> +	if (dev_read_bool(parent, "gpio-controller")) {
>> +		node = dev_ofnode(parent);
>> +		goto bind;
> Why do we need goto instead of moving the code below into the if
> statement?
We need to support both upstream & legacy dtsi.
Will re-implement without goto.
>
>> +	}
>> +
>> +	ret = -ENOENT;
>> +	dev_for_each_subnode(node, parent)
>> +		if (ofnode_read_bool(node, "gpio-controller")) {
>> +			ret = 0;
>> +			break;
>> +		}
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +bind:
>> +	ret = device_bind_with_driver_data(parent, &airoha_pinctrl_gpio_driver,
>> +					   "airoha_pinctrl_gpio", 0, node,
>> +					   &dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pinctrl = dev_get_priv(parent);
>> +	pinctrl->gpiochip.dev = dev;
>> +
>> +	return 0;
>> +}
>> +
> ...
>
>> +#if defined(PINCTRL_GET_STATE)
>> +static int airoha_pinctrl_get_conf(struct airoha_pinctrl *pinctrl,
>> +				   enum airoha_pinctrl_confs_type conf_type,
>> +				   int pin, u32 *val)
>> +{
>> +	const struct airoha_pinctrl_confs_info *confs_info;
>> +	const struct airoha_pinctrl_reg *reg;
>> +
>> +	confs_info = &pinctrl->data->confs_info[conf_type];
>> +
>> +	reg = airoha_pinctrl_get_conf_reg(confs_info->confs,
>> +					  confs_info->num_confs,
>> +					  pin);
>> +	if (!reg)
>> +		return -EINVAL;
>> +
>> +	if (regmap_read(pinctrl->chip_scu, reg->offset, val))
>> +		return -EINVAL;
>> +
>> +	*val = (*val & reg->mask) >> __ffs(reg->mask);
> Linux recently got field_get() that is like FIELD_GET() but allows
> non-constant mask. Maybe time to bring that to U-Boot?
>
>
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static int airoha_pinctrl_set_conf(struct airoha_pinctrl *pinctrl,
>> +				   enum airoha_pinctrl_confs_type conf_type,
>> +				   int pin, u32 val)
>> +{
>> +	const struct airoha_pinctrl_confs_info *confs_info;
>> +	const struct airoha_pinctrl_reg *reg = NULL;
>> +
>> +	confs_info = &pinctrl->data->confs_info[conf_type];
>> +
>> +	reg = airoha_pinctrl_get_conf_reg(confs_info->confs,
>> +					  confs_info->num_confs,
>> +					  pin);
>> +	if (!reg)
>> +		return -EINVAL;
>> +
>> +	if (regmap_update_bits(pinctrl->chip_scu, reg->offset, reg->mask,
>> +			       val << __ffs(reg->mask)))
> Similar here, field_prep().
>
> There are already 2 other drivers that locally #define field_prep() that
> could benifit.
>
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>
>
>> +static int airoha_pinmux_group_set(struct udevice *dev, unsigned group_selector,
>> +				   unsigned func_selector)
>> +{
>> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
>> +
>> +	dev_info(dev, "enabling %s function for pin group %s\n",
> dev_info() seems a bit verbose for this. Should this (and all others) be
> dev_dbg() instead?
nice catch.
>
>> +		airoha_get_func_name(dev, func_selector),
>> +		airoha_get_group_name(dev, group_selector));
>> +
>> +	return airoha_pinmux_set_mux(pinctrl, func_selector, group_selector);
>> +}
>> +
>> +static int airoha_pinmux_set(struct udevice *dev, unsigned pin_selector,
>> +			     unsigned func_selector)
>> +{
>> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
>> +	const struct airoha_pinctrl_match_data *data = pinctrl->data;
>> +	const char *pin_name;
>> +	unsigned selector;
>> +
>> +	pin_name = data->pins[pin_selector].name;
>> +
>> +	/* find group matching the pin_name */
>> +	for (selector = 0; selector < data->num_grps; selector++) {
>> +		if (!strcmp(pin_name, data->grps[selector].name))
>> +			return airoha_pinmux_group_set(dev, selector,
>> +						       func_selector);
>> +	}
>> +
>> +	return -ENOENT;
>> +}
>> +
>> +static const struct pinconf_param airoha_pinconf_params[] = {
>> +	{ "bias-disable",     PIN_CONFIG_BIAS_DISABLE,     0 },
>> +	{ "bias-pull-up",     PIN_CONFIG_BIAS_PULL_UP,     1 },
>> +	{ "bias-pull-down",   PIN_CONFIG_BIAS_PULL_DOWN,   1 },
>> +	{ "drive-strength",   PIN_CONFIG_DRIVE_STRENGTH,   0 },
>> +	{ "drive-open-drain", PIN_CONFIG_DRIVE_OPEN_DRAIN, 0 },
>> +	{ "output-enable",    PIN_CONFIG_OUTPUT_ENABLE,    1 },
>> +	{ "input-enable",     PIN_CONFIG_INPUT_ENABLE,     1 },
>> +};
>> +
>> +static int airoha_pinconf_set_handler(struct udevice *dev, unsigned pin_selector,
>> +				      unsigned param, unsigned argument)
>> +{
>> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
>> +	unsigned long configs[1] = { param };
>> +	unsigned int pin = pinctrl->data->pins[pin_selector].number;
> Can we be sure that pin_selector is not out of bounds?
u-boot general pinctrl code will care of it.
>
>> +
>> +	dev_info(dev, "enabling %s=%d property for pin %s\n",
>> +		airoha_pinconf_params[param].property, argument,
>> +		airoha_get_pin_name(dev, pin_selector));
> Is this supposed to do something with `argument`? Strange to print it
> but not pass it to airoha_pinconf_set().
yeah, minor bug. Luckily in most cases argument is not needed.

>
>> +
>> +	return airoha_pinconf_set(pinctrl, pin, configs, 1);
> Better would be ARRAY_SIZE(configs) instead of 1.
>
> Or change the type of `param` and pass &param instead.
will fix
>
>> +}
>> +
>> +static int airoha_pinconf_group_set_handler(struct udevice *dev, unsigned group_selector,
>> +					    unsigned param, unsigned argument)
>> +{
>> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
>> +	unsigned long configs[1] = { param };
>> +
>> +	dev_info(dev, "enabling %s=%d property for pin group %s\n",
>> +		airoha_pinconf_params[param].property, argument,
>> +		airoha_get_group_name(dev, group_selector));
>> +
>> +	return airoha_pinconf_group_set(pinctrl, group_selector, configs, 1);
>> +}
>> +
>> +const struct pinctrl_ops airoha_pinctrl_ops = {
>> +	.get_pins_count		= airoha_get_pins_count,
>> +	.get_pin_name		= airoha_get_pin_name,
>> +	.get_groups_count	= airoha_get_groups_count,
>> +	.get_group_name		= airoha_get_group_name,
>> +	.get_functions_count	= airoha_get_funcs_count,
>> +	.get_function_name	= airoha_get_func_name,
>> +	.pinmux_set		= airoha_pinmux_set,
>> +	.pinmux_group_set	= airoha_pinmux_group_set,
>> +
>> +	.pinconf_num_params	= ARRAY_SIZE(airoha_pinconf_params),
>> +	.pinconf_params		= airoha_pinconf_params,
>> +	.pinconf_set		= airoha_pinconf_set_handler,
>> +	.pinconf_group_set	= airoha_pinconf_group_set_handler,
>> +
>> +	.set_state		= pinctrl_generic_set_state,
>> +};
>> +
>> +int airoha_pinctrl_probe(struct udevice *dev)
>> +{
>> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
>> +
>> +	pinctrl->dev = dev;
>> +	pinctrl->data = (struct airoha_pinctrl_match_data *)dev_get_driver_data(dev);
> nit: casting isn't needed here (leaving it out makes it more readable)

Yes, it will be a bit better readable. Unfortunately dev_get_driver_data() returns ulong,
but pinctrl->data is a pointer. The compiler might print warning.

>> +
>> +	pinctrl->regmap = syscon_node_to_regmap(dev_ofnode(dev->parent));
>> +	if (IS_ERR(pinctrl->regmap))
>> +		return PTR_ERR(pinctrl->regmap);
>> +
>> +	pinctrl->chip_scu = airoha_get_chip_scu_regmap();
>> +	if (IS_ERR(pinctrl->chip_scu))
>> +		return PTR_ERR(pinctrl->chip_scu);
>> +
>> +	pinctrl->gpiochip.data   = gpio_data_regs;
>> +	pinctrl->gpiochip.dir    = gpio_dir_regs;
>> +	pinctrl->gpiochip.out    = gpio_out_regs;
>> +	pinctrl->gpiochip.status = irq_status_regs;
>> +	pinctrl->gpiochip.level  = irq_level_regs;
>> +	pinctrl->gpiochip.edge   = irq_edge_regs;
>> +
>> +	return 0;
>> +}
>> +
>> +int airoha_pinctrl_bind(struct udevice *dev)
>> +{
>> +	/*
>> +	 * Make sure that the pinctrl driver gets probed after binding
>> +	 * as on EN7523/AN7581/AN7583 the pinctrl driver is the one that
>> +	 * is also registering the GPIO one during probe, so if its not
>> +	 * probed GPIO-s are not registered as well.
> s/GPIO-s/GPIOs/
will fix
>
>> +	 */
>> +	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>> +
>> +	return airoha_gpiochip_register(dev);
>> +}
>> diff --git a/drivers/pinctrl/airoha/pinctrl-an7581.c b/drivers/pinctrl/airoha/pinctrl-an7581.c
>> new file mode 100644
>> index 00000000000..c70952e9ba8
>> --- /dev/null
>> +++ b/drivers/pinctrl/airoha/pinctrl-an7581.c
>> @@ -0,0 +1,1060 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Author: Lorenzo Bianconi <lorenzo@kernel.org>
>> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
>> + * Author: Markus Gothe <markus.gothe@genexis.eu>
>> + */
>> +#include "airoha-common.h"
>> +
>> +static const int en7581_pon_pins[] = { 49, 50, 51, 52, 53, 54 };
>> +static const int en7581_pon_tod_1pps_pins[] = { 46 };
>> +static const int en7581_gsw_tod_1pps_pins[] = { 46 };
>> +static const int en7581_sipo_pins[] = { 16, 17 };
>> +static const int en7581_sipo_rclk_pins[] = { 16, 17, 43 };
>> +static const int en7581_mdio_pins[] = { 14, 15 };
>> +static const int en7581_uart2_pins[] = { 48, 55 };
>> +static const int en7581_uart2_cts_rts_pins[] = { 46, 47 };
>> +static const int en7581_hsuart_pins[] = { 28, 29 };
>> +static const int en7581_hsuart_cts_rts_pins[] = { 26, 27 };
>> +static const int en7581_uart4_pins[] = { 38, 39 };
>> +static const int en7581_uart5_pins[] = { 18, 19 };
>> +static const int en7581_i2c0_pins[] = { 2, 3 };
>> +static const int en7581_i2c1_pins[] = { 14, 15 };
>> +static const int en7581_jtag_udi_pins[] = { 16, 17, 18, 19, 20 };
>> +static const int en7581_jtag_dfd_pins[] = { 16, 17, 18, 19, 20 };
>> +static const int en7581_i2s_pins[] = { 26, 27, 28, 29 };
>> +static const int en7581_pcm1_pins[] = { 22, 23, 24, 25 };
>> +static const int en7581_pcm2_pins[] = { 18, 19, 20, 21 };
>> +static const int en7581_spi_quad_pins[] = { 32, 33 };
>> +static const int en7581_spi_pins[] = { 4, 5, 6, 7 };
>> +static const int en7581_spi_cs1_pins[] = { 34 };
>> +static const int en7581_pcm_spi_pins[] = { 18, 19, 20, 21, 22, 23, 24, 25 };
>> +static const int en7581_pcm_spi_int_pins[] = { 14 };
>> +static const int en7581_pcm_spi_rst_pins[] = { 15 };
>> +static const int en7581_pcm_spi_cs1_pins[] = { 43 };
>> +static const int en7581_pcm_spi_cs2_pins[] = { 40 };
>> +static const int en7581_pcm_spi_cs2_p128_pins[] = { 40 };
>> +static const int en7581_pcm_spi_cs2_p156_pins[] = { 40 };
>> +static const int en7581_pcm_spi_cs3_pins[] = { 41 };
>> +static const int en7581_pcm_spi_cs4_pins[] = { 42 };
>> +static const int en7581_emmc_pins[] = {
>> +	4, 5, 6, 30, 31, 32, 33, 34, 35, 36, 37
>> +};
>> +static const int en7581_pnand_pins[] = { 4,  5,	 6,  7,	 30, 31, 32, 33, 34,
>> +					 35, 36, 37, 38, 39, 40, 41, 42 };
> ...
>
>> +static const char *const pon_groups[] = { "pon" };
>> +static const char *const tod_1pps_groups[] = { "pon_tod_1pps", "gsw_tod_1pps" };
>> +static const char *const sipo_groups[] = { "sipo", "sipo_rclk" };
>> +static const char *const mdio_groups[] = { "mdio" };
>> +
>> +static const char *const uart_groups[] = { "uart2",  "uart2_cts_rts",
>> +					   "hsuart", "hsuart_cts_rts",
>> +					   "uart4",  "uart5" };
>> +static const char *const i2c_groups[] = { "i2c1" };
>> +static const char *const jtag_groups[] = { "jtag_udi", "jtag_dfd" };
>> +static const char *const pcm_groups[] = { "pcm1", "pcm2" };
>> +static const char *const spi_groups[] = { "spi_quad", "spi_cs1" };
>> +static const char *const pcm_spi_groups[] = {
>> +	"pcm_spi",	    "pcm_spi_int",	"pcm_spi_rst", "pcm_spi_cs1",
>> +	"pcm_spi_cs2_p156", "pcm_spi_cs2_p128", "pcm_spi_cs3", "pcm_spi_cs4"
>> +};
>> +
>> +static const char *const i2s_groups[] = { "i2s" };
>> +static const char *const emmc_groups[] = { "emmc" };
>> +static const char *const pnand_groups[] = { "pnand" };
>> +static const char *const pcie_reset_groups[] = { "pcie_reset0", "pcie_reset1",
>> +						 "pcie_reset2" };
>> +
>> +static const char *const pwm_groups[] = {
>> +	"gpio0",  "gpio1",  "gpio2",  "gpio3",	"gpio4",  "gpio5",  "gpio6",
>> +	"gpio7",  "gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13",
>> +	"gpio14", "gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20",
>> +	"gpio21", "gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27",
>> +	"gpio28", "gpio29", "gpio30", "gpio31", "gpio36", "gpio37", "gpio38",
>> +	"gpio39", "gpio40", "gpio41", "gpio42", "gpio43", "gpio44", "gpio45",
>> +	"gpio46", "gpio47"
>> +};
>> +static const char *const phy1_led0_groups[] = { "gpio33", "gpio34", "gpio35",
>> +						"gpio42", "gpio43", "gpio44", "gpio45", "gpio46" };
>> +static const char *const phy2_led0_groups[] = { "gpio33", "gpio34", "gpio35",
>> +						"gpio42", "gpio43", "gpio44", "gpio45", "gpio46" };
>> +static const char *const phy3_led0_groups[] = { "gpio33", "gpio34", "gpio35",
>> +						"gpio42", "gpio43", "gpio44", "gpio45", "gpio46" };
>> +static const char *const phy4_led0_groups[] = { "gpio33", "gpio34", "gpio35",
>> +						"gpio42", "gpio43", "gpio44", "gpio45", "gpio46" };
>> +static const char *const phy1_led1_groups[] = { "gpio43", "gpio44", "gpio45",
>> +						"gpio46" };
>> +static const char *const phy2_led1_groups[] = { "gpio43", "gpio44", "gpio45",
>> +						"gpio46" };
>> +static const char *const phy3_led1_groups[] = { "gpio43", "gpio44", "gpio45",
>> +						"gpio46" };
>> +static const char *const phy4_led1_groups[] = { "gpio43", "gpio44", "gpio45",
>> +						"gpio46" };
> I would wrap these like this to be more readable:
>
> static const char *const phy4_led1_groups[] = {
> 	"gpio43", "gpio44", "gpio45", "gpio46"
> };
>
> Same applies to other stuff above like uart_groups.
>
>> +
>> +static const struct airoha_pinctrl_conf en7581_pinctrl_drive_e2_conf[] = {
>> +	PINCTRL_CONF_DESC(0, REG_I2C_SDA_E2, UART1_TXD_E2_MASK),
>> +	PINCTRL_CONF_DESC(1, REG_I2C_SDA_E2, UART1_RXD_E2_MASK),
>> +	PINCTRL_CONF_DESC(2, REG_I2C_SDA_E2, I2C_SDA_E2_MASK),
>> +	PINCTRL_CONF_DESC(3, REG_I2C_SDA_E2, I2C_SCL_E2_MASK),
>> +	PINCTRL_CONF_DESC(4, REG_I2C_SDA_E2, SPI_CS0_E2_MASK),
>> +	PINCTRL_CONF_DESC(5, REG_I2C_SDA_E2, SPI_CLK_E2_MASK),
>> +	PINCTRL_CONF_DESC(6, REG_I2C_SDA_E2, SPI_MOSI_E2_MASK),
>> +	PINCTRL_CONF_DESC(7, REG_I2C_SDA_E2, SPI_MISO_E2_MASK),
>> +	PINCTRL_CONF_DESC(13, REG_GPIO_L_E2, BIT(0)),
>> +	PINCTRL_CONF_DESC(14, REG_GPIO_L_E2, BIT(1)),
>> +	PINCTRL_CONF_DESC(15, REG_GPIO_L_E2, BIT(2)),
>> +	PINCTRL_CONF_DESC(16, REG_GPIO_L_E2, BIT(3)),
>> +	PINCTRL_CONF_DESC(17, REG_GPIO_L_E2, BIT(4)),
>> +	PINCTRL_CONF_DESC(18, REG_GPIO_L_E2, BIT(5)),
>> +	PINCTRL_CONF_DESC(19, REG_GPIO_L_E2, BIT(6)),
>> +	PINCTRL_CONF_DESC(20, REG_GPIO_L_E2, BIT(7)),
>> +	PINCTRL_CONF_DESC(21, REG_GPIO_L_E2, BIT(8)),
>> +	PINCTRL_CONF_DESC(22, REG_GPIO_L_E2, BIT(9)),
>> +	PINCTRL_CONF_DESC(23, REG_GPIO_L_E2, BIT(10)),
>> +	PINCTRL_CONF_DESC(24, REG_GPIO_L_E2, BIT(11)),
>> +	PINCTRL_CONF_DESC(25, REG_GPIO_L_E2, BIT(12)),
>> +	PINCTRL_CONF_DESC(26, REG_GPIO_L_E2, BIT(13)),
>> +	PINCTRL_CONF_DESC(27, REG_GPIO_L_E2, BIT(14)),
>> +	PINCTRL_CONF_DESC(28, REG_GPIO_L_E2, BIT(15)),
>> +	PINCTRL_CONF_DESC(29, REG_GPIO_L_E2, BIT(16)),
>> +	PINCTRL_CONF_DESC(30, REG_GPIO_L_E2, BIT(17)),
>> +	PINCTRL_CONF_DESC(31, REG_GPIO_L_E2, BIT(18)),
>> +	PINCTRL_CONF_DESC(32, REG_GPIO_L_E2, BIT(18)),
> Is this supposed to be BIT(19)?
>
>> +	PINCTRL_CONF_DESC(33, REG_GPIO_L_E2, BIT(20)),
>> +	PINCTRL_CONF_DESC(34, REG_GPIO_L_E2, BIT(21)),
>> +	PINCTRL_CONF_DESC(35, REG_GPIO_L_E2, BIT(22)),
>> +	PINCTRL_CONF_DESC(36, REG_GPIO_L_E2, BIT(23)),
>> +	PINCTRL_CONF_DESC(37, REG_GPIO_L_E2, BIT(24)),
>> +	PINCTRL_CONF_DESC(38, REG_GPIO_L_E2, BIT(25)),
>> +	PINCTRL_CONF_DESC(39, REG_GPIO_L_E2, BIT(26)),
>> +	PINCTRL_CONF_DESC(40, REG_GPIO_L_E2, BIT(27)),
>> +	PINCTRL_CONF_DESC(41, REG_GPIO_L_E2, BIT(28)),
>> +	PINCTRL_CONF_DESC(42, REG_GPIO_L_E2, BIT(29)),
>> +	PINCTRL_CONF_DESC(43, REG_GPIO_L_E2, BIT(30)),
>> +	PINCTRL_CONF_DESC(44, REG_GPIO_L_E2, BIT(31)),
>> +	PINCTRL_CONF_DESC(45, REG_GPIO_H_E2, BIT(0)),
>> +	PINCTRL_CONF_DESC(46, REG_GPIO_H_E2, BIT(1)),
>> +	PINCTRL_CONF_DESC(47, REG_GPIO_H_E2, BIT(2)),
>> +	PINCTRL_CONF_DESC(48, REG_GPIO_H_E2, BIT(3)),
>> +	PINCTRL_CONF_DESC(49, REG_GPIO_H_E2, BIT(4)),
>> +	PINCTRL_CONF_DESC(50, REG_GPIO_H_E2, BIT(5)),
>> +	PINCTRL_CONF_DESC(51, REG_GPIO_H_E2, BIT(6)),
>> +	PINCTRL_CONF_DESC(52, REG_GPIO_H_E2, BIT(7)),
>> +	PINCTRL_CONF_DESC(53, REG_GPIO_H_E2, BIT(8)),
>> +	PINCTRL_CONF_DESC(54, REG_GPIO_H_E2, BIT(9)),
>> +	PINCTRL_CONF_DESC(55, REG_GPIO_H_E2, BIT(10)),
>> +	PINCTRL_CONF_DESC(56, REG_GPIO_H_E2, BIT(11)),
>> +	PINCTRL_CONF_DESC(57, REG_GPIO_H_E2, BIT(12)),
>> +	PINCTRL_CONF_DESC(58, REG_GPIO_H_E2, BIT(13)),
>> +	PINCTRL_CONF_DESC(59, REG_GPIO_H_E2, BIT(14)),
>> +	PINCTRL_CONF_DESC(61, REG_I2C_SDA_E2, PCIE0_RESET_E2_MASK),
>> +	PINCTRL_CONF_DESC(62, REG_I2C_SDA_E2, PCIE1_RESET_E2_MASK),
>> +	PINCTRL_CONF_DESC(63, REG_I2C_SDA_E2, PCIE2_RESET_E2_MASK),
>> +};
>> +
>> +static const struct airoha_pinctrl_conf en7581_pinctrl_drive_e4_conf[] = {
>> +	PINCTRL_CONF_DESC(0, REG_I2C_SDA_E4, UART1_TXD_E4_MASK),
>> +	PINCTRL_CONF_DESC(1, REG_I2C_SDA_E4, UART1_RXD_E4_MASK),
>> +	PINCTRL_CONF_DESC(2, REG_I2C_SDA_E4, I2C_SDA_E4_MASK),
>> +	PINCTRL_CONF_DESC(3, REG_I2C_SDA_E4, I2C_SCL_E4_MASK),
>> +	PINCTRL_CONF_DESC(4, REG_I2C_SDA_E4, SPI_CS0_E4_MASK),
>> +	PINCTRL_CONF_DESC(5, REG_I2C_SDA_E4, SPI_CLK_E4_MASK),
>> +	PINCTRL_CONF_DESC(6, REG_I2C_SDA_E4, SPI_MOSI_E4_MASK),
>> +	PINCTRL_CONF_DESC(7, REG_I2C_SDA_E4, SPI_MISO_E4_MASK),
>> +	PINCTRL_CONF_DESC(13, REG_GPIO_L_E4, BIT(0)),
>> +	PINCTRL_CONF_DESC(14, REG_GPIO_L_E4, BIT(1)),
>> +	PINCTRL_CONF_DESC(15, REG_GPIO_L_E4, BIT(2)),
>> +	PINCTRL_CONF_DESC(16, REG_GPIO_L_E4, BIT(3)),
>> +	PINCTRL_CONF_DESC(17, REG_GPIO_L_E4, BIT(4)),
>> +	PINCTRL_CONF_DESC(18, REG_GPIO_L_E4, BIT(5)),
>> +	PINCTRL_CONF_DESC(19, REG_GPIO_L_E4, BIT(6)),
>> +	PINCTRL_CONF_DESC(20, REG_GPIO_L_E4, BIT(7)),
>> +	PINCTRL_CONF_DESC(21, REG_GPIO_L_E4, BIT(8)),
>> +	PINCTRL_CONF_DESC(22, REG_GPIO_L_E4, BIT(9)),
>> +	PINCTRL_CONF_DESC(23, REG_GPIO_L_E4, BIT(10)),
>> +	PINCTRL_CONF_DESC(24, REG_GPIO_L_E4, BIT(11)),
>> +	PINCTRL_CONF_DESC(25, REG_GPIO_L_E4, BIT(12)),
>> +	PINCTRL_CONF_DESC(26, REG_GPIO_L_E4, BIT(13)),
>> +	PINCTRL_CONF_DESC(27, REG_GPIO_L_E4, BIT(14)),
>> +	PINCTRL_CONF_DESC(28, REG_GPIO_L_E4, BIT(15)),
>> +	PINCTRL_CONF_DESC(29, REG_GPIO_L_E4, BIT(16)),
>> +	PINCTRL_CONF_DESC(30, REG_GPIO_L_E4, BIT(17)),
>> +	PINCTRL_CONF_DESC(31, REG_GPIO_L_E4, BIT(18)),
>> +	PINCTRL_CONF_DESC(32, REG_GPIO_L_E4, BIT(18)),
> Is this supposed to be BIT(19)?
yes, it's a bug
>
>> +	PINCTRL_CONF_DESC(33, REG_GPIO_L_E4, BIT(20)),
>> +	PINCTRL_CONF_DESC(34, REG_GPIO_L_E4, BIT(21)),
>> +	PINCTRL_CONF_DESC(35, REG_GPIO_L_E4, BIT(22)),
>> +	PINCTRL_CONF_DESC(36, REG_GPIO_L_E4, BIT(23)),
>> +	PINCTRL_CONF_DESC(37, REG_GPIO_L_E4, BIT(24)),
>> +	PINCTRL_CONF_DESC(38, REG_GPIO_L_E4, BIT(25)),
>> +	PINCTRL_CONF_DESC(39, REG_GPIO_L_E4, BIT(26)),
>> +	PINCTRL_CONF_DESC(40, REG_GPIO_L_E4, BIT(27)),
>> +	PINCTRL_CONF_DESC(41, REG_GPIO_L_E4, BIT(28)),
>> +	PINCTRL_CONF_DESC(42, REG_GPIO_L_E4, BIT(29)),
>> +	PINCTRL_CONF_DESC(43, REG_GPIO_L_E4, BIT(30)),
>> +	PINCTRL_CONF_DESC(44, REG_GPIO_L_E4, BIT(31)),
>> +	PINCTRL_CONF_DESC(45, REG_GPIO_H_E4, BIT(0)),
>> +	PINCTRL_CONF_DESC(46, REG_GPIO_H_E4, BIT(1)),
>> +	PINCTRL_CONF_DESC(47, REG_GPIO_H_E4, BIT(2)),
>> +	PINCTRL_CONF_DESC(48, REG_GPIO_H_E4, BIT(3)),
>> +	PINCTRL_CONF_DESC(49, REG_GPIO_H_E4, BIT(4)),
>> +	PINCTRL_CONF_DESC(50, REG_GPIO_H_E4, BIT(5)),
>> +	PINCTRL_CONF_DESC(51, REG_GPIO_H_E4, BIT(6)),
>> +	PINCTRL_CONF_DESC(52, REG_GPIO_H_E4, BIT(7)),
>> +	PINCTRL_CONF_DESC(53, REG_GPIO_H_E4, BIT(8)),
>> +	PINCTRL_CONF_DESC(54, REG_GPIO_H_E4, BIT(9)),
>> +	PINCTRL_CONF_DESC(55, REG_GPIO_H_E4, BIT(10)),
>> +	PINCTRL_CONF_DESC(56, REG_GPIO_H_E4, BIT(11)),
>> +	PINCTRL_CONF_DESC(57, REG_GPIO_H_E4, BIT(12)),
>> +	PINCTRL_CONF_DESC(58, REG_GPIO_H_E4, BIT(13)),
>> +	PINCTRL_CONF_DESC(59, REG_GPIO_H_E4, BIT(14)),
>> +	PINCTRL_CONF_DESC(61, REG_I2C_SDA_E4, PCIE0_RESET_E4_MASK),
>> +	PINCTRL_CONF_DESC(62, REG_I2C_SDA_E4, PCIE1_RESET_E4_MASK),
>> +	PINCTRL_CONF_DESC(63, REG_I2C_SDA_E4, PCIE2_RESET_E4_MASK),
>> +};
>> +
> ...
>
>> +static const struct airoha_pinctrl_func_group phy4_led1_func_group[] = {
>> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio43", GPIO_LAN0_LED1_MODE_MASK,
>> +				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
>> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio44", GPIO_LAN1_LED1_MODE_MASK,
>> +				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
>> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio45", GPIO_LAN2_LED1_MODE_MASK,
>> +				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
>> +	AIROHA_PINCTRL_PHY_LED1(AN7581, "gpio46", GPIO_LAN3_LED1_MODE_MASK,
>> +				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),
>> +};
> Should these be LANX_PHY_LED_MAP(3) instead of 2?
bug again
>
>> +static const struct airoha_pinctrl_conf en7581_pinctrl_pullup_conf[] = {
>> +	PINCTRL_CONF_DESC(0, REG_I2C_SDA_PU, UART1_TXD_PU_MASK),
>> +	PINCTRL_CONF_DESC(1, REG_I2C_SDA_PU, UART1_RXD_PU_MASK),
>> +	PINCTRL_CONF_DESC(2, REG_I2C_SDA_PU, I2C_SDA_PU_MASK),
>> +	PINCTRL_CONF_DESC(3, REG_I2C_SDA_PU, I2C_SCL_PU_MASK),
>> +	PINCTRL_CONF_DESC(4, REG_I2C_SDA_PU, SPI_CS0_PU_MASK),
>> +	PINCTRL_CONF_DESC(5, REG_I2C_SDA_PU, SPI_CLK_PU_MASK),
>> +	PINCTRL_CONF_DESC(6, REG_I2C_SDA_PU, SPI_MOSI_PU_MASK),
>> +	PINCTRL_CONF_DESC(7, REG_I2C_SDA_PU, SPI_MISO_PU_MASK),
>> +	PINCTRL_CONF_DESC(13, REG_GPIO_L_PU, BIT(0)),
>> +	PINCTRL_CONF_DESC(14, REG_GPIO_L_PU, BIT(1)),
>> +	PINCTRL_CONF_DESC(15, REG_GPIO_L_PU, BIT(2)),
>> +	PINCTRL_CONF_DESC(16, REG_GPIO_L_PU, BIT(3)),
>> +	PINCTRL_CONF_DESC(17, REG_GPIO_L_PU, BIT(4)),
>> +	PINCTRL_CONF_DESC(18, REG_GPIO_L_PU, BIT(5)),
>> +	PINCTRL_CONF_DESC(19, REG_GPIO_L_PU, BIT(6)),
>> +	PINCTRL_CONF_DESC(20, REG_GPIO_L_PU, BIT(7)),
>> +	PINCTRL_CONF_DESC(21, REG_GPIO_L_PU, BIT(8)),
>> +	PINCTRL_CONF_DESC(22, REG_GPIO_L_PU, BIT(9)),
>> +	PINCTRL_CONF_DESC(23, REG_GPIO_L_PU, BIT(10)),
>> +	PINCTRL_CONF_DESC(24, REG_GPIO_L_PU, BIT(11)),
>> +	PINCTRL_CONF_DESC(25, REG_GPIO_L_PU, BIT(12)),
>> +	PINCTRL_CONF_DESC(26, REG_GPIO_L_PU, BIT(13)),
>> +	PINCTRL_CONF_DESC(27, REG_GPIO_L_PU, BIT(14)),
>> +	PINCTRL_CONF_DESC(28, REG_GPIO_L_PU, BIT(15)),
>> +	PINCTRL_CONF_DESC(29, REG_GPIO_L_PU, BIT(16)),
>> +	PINCTRL_CONF_DESC(30, REG_GPIO_L_PU, BIT(17)),
>> +	PINCTRL_CONF_DESC(31, REG_GPIO_L_PU, BIT(18)),
>> +	PINCTRL_CONF_DESC(32, REG_GPIO_L_PU, BIT(18)),
> Is this supposed to be BIT(19)?
>
>> +	PINCTRL_CONF_DESC(33, REG_GPIO_L_PU, BIT(20)),
>> +	PINCTRL_CONF_DESC(34, REG_GPIO_L_PU, BIT(21)),
>> +	PINCTRL_CONF_DESC(35, REG_GPIO_L_PU, BIT(22)),
>> +	PINCTRL_CONF_DESC(36, REG_GPIO_L_PU, BIT(23)),
>> +	PINCTRL_CONF_DESC(37, REG_GPIO_L_PU, BIT(24)),
>> +	PINCTRL_CONF_DESC(38, REG_GPIO_L_PU, BIT(25)),
>> +	PINCTRL_CONF_DESC(39, REG_GPIO_L_PU, BIT(26)),
>> +	PINCTRL_CONF_DESC(40, REG_GPIO_L_PU, BIT(27)),
>> +	PINCTRL_CONF_DESC(41, REG_GPIO_L_PU, BIT(28)),
>> +	PINCTRL_CONF_DESC(42, REG_GPIO_L_PU, BIT(29)),
>> +	PINCTRL_CONF_DESC(43, REG_GPIO_L_PU, BIT(30)),
>> +	PINCTRL_CONF_DESC(44, REG_GPIO_L_PU, BIT(31)),
>> +	PINCTRL_CONF_DESC(45, REG_GPIO_H_PU, BIT(0)),
>> +	PINCTRL_CONF_DESC(46, REG_GPIO_H_PU, BIT(1)),
>> +	PINCTRL_CONF_DESC(47, REG_GPIO_H_PU, BIT(2)),
>> +	PINCTRL_CONF_DESC(48, REG_GPIO_H_PU, BIT(3)),
>> +	PINCTRL_CONF_DESC(49, REG_GPIO_H_PU, BIT(4)),
>> +	PINCTRL_CONF_DESC(50, REG_GPIO_H_PU, BIT(5)),
>> +	PINCTRL_CONF_DESC(51, REG_GPIO_H_PU, BIT(6)),
>> +	PINCTRL_CONF_DESC(52, REG_GPIO_H_PU, BIT(7)),
>> +	PINCTRL_CONF_DESC(53, REG_GPIO_H_PU, BIT(8)),
>> +	PINCTRL_CONF_DESC(54, REG_GPIO_H_PU, BIT(9)),
>> +	PINCTRL_CONF_DESC(55, REG_GPIO_H_PU, BIT(10)),
>> +	PINCTRL_CONF_DESC(56, REG_GPIO_H_PU, BIT(11)),
>> +	PINCTRL_CONF_DESC(57, REG_GPIO_H_PU, BIT(12)),
>> +	PINCTRL_CONF_DESC(58, REG_GPIO_H_PU, BIT(13)),
>> +	PINCTRL_CONF_DESC(59, REG_GPIO_H_PU, BIT(14)),
>> +	PINCTRL_CONF_DESC(61, REG_I2C_SDA_PU, PCIE0_RESET_PU_MASK),
>> +	PINCTRL_CONF_DESC(62, REG_I2C_SDA_PU, PCIE1_RESET_PU_MASK),
>> +	PINCTRL_CONF_DESC(63, REG_I2C_SDA_PU, PCIE2_RESET_PU_MASK),
>> +};
>> +
>> +static const struct airoha_pinctrl_conf en7581_pinctrl_pulldown_conf[] = {
>> +	PINCTRL_CONF_DESC(0, REG_I2C_SDA_PD, UART1_TXD_PD_MASK),
>> +	PINCTRL_CONF_DESC(1, REG_I2C_SDA_PD, UART1_RXD_PD_MASK),
>> +	PINCTRL_CONF_DESC(2, REG_I2C_SDA_PD, I2C_SDA_PD_MASK),
>> +	PINCTRL_CONF_DESC(3, REG_I2C_SDA_PD, I2C_SCL_PD_MASK),
>> +	PINCTRL_CONF_DESC(4, REG_I2C_SDA_PD, SPI_CS0_PD_MASK),
>> +	PINCTRL_CONF_DESC(5, REG_I2C_SDA_PD, SPI_CLK_PD_MASK),
>> +	PINCTRL_CONF_DESC(6, REG_I2C_SDA_PD, SPI_MOSI_PD_MASK),
>> +	PINCTRL_CONF_DESC(7, REG_I2C_SDA_PD, SPI_MISO_PD_MASK),
>> +	PINCTRL_CONF_DESC(13, REG_GPIO_L_PD, BIT(0)),
>> +	PINCTRL_CONF_DESC(14, REG_GPIO_L_PD, BIT(1)),
>> +	PINCTRL_CONF_DESC(15, REG_GPIO_L_PD, BIT(2)),
>> +	PINCTRL_CONF_DESC(16, REG_GPIO_L_PD, BIT(3)),
>> +	PINCTRL_CONF_DESC(17, REG_GPIO_L_PD, BIT(4)),
>> +	PINCTRL_CONF_DESC(18, REG_GPIO_L_PD, BIT(5)),
>> +	PINCTRL_CONF_DESC(19, REG_GPIO_L_PD, BIT(6)),
>> +	PINCTRL_CONF_DESC(20, REG_GPIO_L_PD, BIT(7)),
>> +	PINCTRL_CONF_DESC(21, REG_GPIO_L_PD, BIT(8)),
>> +	PINCTRL_CONF_DESC(22, REG_GPIO_L_PD, BIT(9)),
>> +	PINCTRL_CONF_DESC(23, REG_GPIO_L_PD, BIT(10)),
>> +	PINCTRL_CONF_DESC(24, REG_GPIO_L_PD, BIT(11)),
>> +	PINCTRL_CONF_DESC(25, REG_GPIO_L_PD, BIT(12)),
>> +	PINCTRL_CONF_DESC(26, REG_GPIO_L_PD, BIT(13)),
>> +	PINCTRL_CONF_DESC(27, REG_GPIO_L_PD, BIT(14)),
>> +	PINCTRL_CONF_DESC(28, REG_GPIO_L_PD, BIT(15)),
>> +	PINCTRL_CONF_DESC(29, REG_GPIO_L_PD, BIT(16)),
>> +	PINCTRL_CONF_DESC(30, REG_GPIO_L_PD, BIT(17)),
>> +	PINCTRL_CONF_DESC(31, REG_GPIO_L_PD, BIT(18)),
>> +	PINCTRL_CONF_DESC(32, REG_GPIO_L_PD, BIT(18)),
> Is this supposed to be BIT(19)?
>
>> +	PINCTRL_CONF_DESC(33, REG_GPIO_L_PD, BIT(20)),
>> +	PINCTRL_CONF_DESC(34, REG_GPIO_L_PD, BIT(21)),
>> +	PINCTRL_CONF_DESC(35, REG_GPIO_L_PD, BIT(22)),
>
> ...
>
>> +U_BOOT_DRIVER(airoha_pinctrl) = {
> We are aiming to be able to compile all drivers at the same time for static
> analysis, so include an7581 in the driver identifier (airoha_an7581_pinctrl).
>
>> +	.name = "airoha-an7581-pinctrl",
>> +	.id = UCLASS_PINCTRL,
>> +	.of_match = of_match_ptr(airoha_pinctrl_of_match),
>> +	.probe = airoha_pinctrl_probe,
>> +	.bind = airoha_pinctrl_bind,
>> +	.priv_auto = sizeof(struct airoha_pinctrl),
>> +	.ops = &airoha_pinctrl_ops,
>> +};
