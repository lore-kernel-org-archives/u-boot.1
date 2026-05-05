Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495B3FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 08:25:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F01846D5;
	Tue,  5 May 2026 10:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="yBR1OU7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A86C9846F4; Tue,  5 May 2026 10:25:09 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85EEC846CE
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 10:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWoRm6uiohoe8XS+ncBuY3RXyytUuLgfQD0orMZkGL3jDmbxXcGczW5yRT+RHUB2C5AmMw+DjiL5RcxHdG1wSFPU10pVML1y3ghqFlTQmgL1Kkej+jiV3gqBMxIvFc17mcw56e4LqE3JlXIW7+XlpXvbuQIPjj73Fwvfvro/W1NM09RyUkP/eDyIHYxHO/ghqMspvwczP6KAdg9svkDlQxUzeCfYFH1EHG7KQskBaSEc5JZhAuXPJQimsbyjkPqG3tfFuy76rCLZQ7+5Pm5vmddkMip/YPvnFi4DS3gGn0oLNVTU8N0mOWfY8GRhuxXmUJ4WNhLiYw0XLXifsU9Xww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bWBK9C3BLfPDAdsaSlQxPSPl1ENRnL4n9keNhLzSoI=;
 b=KoB3eSRdBqBmmfLdjw2CqEYPQND+Dsfvo6RvT+2T7VCx3XXNqhHVjmoY7iAR72NLjLBbb40BdycuyUr+dBrA86D/MlrBIbUH5Dqc9a8sOLX72PWYM4ycGOvtNJvGoB6xJj3O5X0ycKl6BIU+HsLVSrEEKQ6d0ujPfUOEgHvHIfz9LDieBJuNkzHRCK3tS6M1iuYvp2nVFojic3b2nllS9trr9A3FRW7lgBMeDpj0StJk/I+BkshFg3xmKRSDK0cihPIjvM2x+x1mgFC6LLuPTHs8e3bdhIwv0BLVkHSXn89gnhUiNYKzT11JIupSZKezeu9i43bTqC5jgKHt7yFAzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bWBK9C3BLfPDAdsaSlQxPSPl1ENRnL4n9keNhLzSoI=;
 b=yBR1OU7/sHIvA2yd+m67/D3PlFDxGQ6sMPZs0g1VK3NcD2rcnRCLdMNiAgG03iTzZIDr8VDM/OGMxt2agqYkJsW211gCb7CGwKUa14wjK3oFINU5nXtUSrVNLPYahD7N3WV6mRt4GfEPfBliELd7DQtXLiTBiEwampWaLc9pqqL0JCZKoNcDw4Ff3r7pL4d0aD6PWKgWfEL2E71j1PXfEIl1JBWYtF0GllCXEpVcZozzL4C6Q/CrpOXD0a1oDwHLv0JbN/lAwl8Di1gDB1dlardlenrmDQ09TvTsRx8BoKgVCCKDe3iLL1ewGC380oXVmWXX9WiUCojmh2fQeevPnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by DU4PR10MB9806.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:62f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:25:05 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:25:05 +0000
Message-ID: <449bbab5-3451-4034-a643-771d9ddb0567@siemens.com>
Date: Tue, 5 May 2026 10:25:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] patman: fix use in worktree
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20260429141850.1.6f48ecca7f833b4f4b90ba78432475de1461e838@changeid>
 <CAFLszThHeODorsKtPCqFYmfSPuCJNGMTvdtUQ10yiHRhJnuCPA@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAFLszThHeODorsKtPCqFYmfSPuCJNGMTvdtUQ10yiHRhJnuCPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::16) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|DU4PR10MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: 91681939-665e-4d77-d6ee-08deaa7fcef7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 45TCkortnaJHaL/+9ACTJV7vnnxMztnEvUdSqkvPVCk8L2TvsdS4WoUezTf9bEinvzlKj49JiZdxqXSXZqZLoAJuZ+vzG/lYqxpeWowN7k88zbT5dwslOP8LlC6Vdq73Wf60tmcNyqKOxhywvELZqi5PunkLJl9tncDVtqw7duupGy3Of/JUsBjmt/t5HLXVgstYl9LeW1LpqAEjVMV+PaNjZLLWoJiQoK2NmJKqjifmkEBpa2Vbr4SsPUhcF+9leVTcc8kS0TCVsPZPqMx6mbm2/DQ1bZhCErxuQda10QA8kY1azp4Z6aEOzayblJeorMq3FFBtY5ijO7g7vxvyn01Nh3UwRCahQbgCOy274btGRC9EcjzWlUOcNwDaWyRR461cPjTzuhlmf5T4TMVtZD5ewA0+wjE5NPUhmHSI7bVdoLvcyrMHx/rZApOCAMwYz5P0e+PEhBhO+IZpyQOgeXGn24ajSiAU4c0PDz5t+Y65xS6zw4suUQnsgyRCk35K09hAM98jHNO4D1HXbNZgsM7VpFc0qUkwHTSF+sGUOp4Brv8RgQQUcmqDtt4DN4vR5Tl9Z87TzHP3f5Sr1+H8xbnNz3Nk9DM53gTbI8/nNPRU5HKtuJSafo3+bz+V4XISz8gNOkcyeMP+g/6WI9bf4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azFnN0l3NlNCV3Z0NjkzK0ZQbkVxSlVrR1VQek5LMXZOTzJtY0M5dmlLenA5?=
 =?utf-8?B?NFVOUlhlajZXZGlaNWRLZTcxZmM2VGdOTWlGdWIyS05TeE12dHRkMnMvZGNH?=
 =?utf-8?B?TnFTN0QzZjFvQTlxQ0YwazFub0svbEdnNkdsY1NWUGw2dTg0Q09JU1ZQQTdj?=
 =?utf-8?B?bzZ3UzhmbDlJRkZydTh4L1Mya1V1czRBQllvcTR5amFBQUNwbDdlS0JNZmRx?=
 =?utf-8?B?V0U5ck8raXgyTUlWQ1ZJTFIxM1kxcXg5K1hNd3JBTjh6YUpObHJPcTNPSkJB?=
 =?utf-8?B?WHBIbDNuS3JTaWdKU3QxTVlmOFkzT2crc3BSRUFBNlNEd0JMazVaV2lXTlg0?=
 =?utf-8?B?Wm1pZU9XengwcUpzaFZycWlEb1c4OVg4Y2FvMHJqMjBadkhZZzVKTUlERFpk?=
 =?utf-8?B?VVVaVEF6cHF5N2RpQURJOS84bWk5clJ1ak9DQlhLTDcxdDA2Wks4Y1F3TGVw?=
 =?utf-8?B?SUphQjMycGVpQXEzdktNVlRobG1kSUhkd3RBNk5GUXdRdTNnZmlxaFE0VmR1?=
 =?utf-8?B?N25wdjVUUGlLVDlVUi9WR1lmWE16cFpWbFBxdnJUQmlWLzg2Nmlic3FLNUxG?=
 =?utf-8?B?TUhhM1ZseHlHNEN2L0Z0MDFRSGNucm5BMUhwQVMydG1CbE5iL3B6d1Niai8y?=
 =?utf-8?B?R0JnYXBLYTZjZFYzK1FRalp3UWJqZE9zbXdmR3BOeE1uTEhwTkxBL1doczBa?=
 =?utf-8?B?YlJ6dlJXcWZReUZuRzNMSWNvYXU3Y241WGVSblZ2NUx1NHFQWlEzTUNaQmk3?=
 =?utf-8?B?WEJ5TTZjTmhsSGRKc2NlcmxkYm43S0prVzNSZXREUHNWZ2M4dEhzejcwUGRC?=
 =?utf-8?B?M1RFY0FoSlp4cTc1REdOUEFRbmFyeVlwUk0vZCtSOHFNR3dJa0gzS2hEaFIy?=
 =?utf-8?B?Y3Q1WXJoRC84UVNTekV3Vk9NN0NEUElsREd4b0EyUjRxRDF6a1BtSkZuK3M2?=
 =?utf-8?B?dzRxbUNKQk5oVFNqUVFYYzA0b3k5TEQxQUgrQlA5NGJWK1NkNGJMazRhSHdt?=
 =?utf-8?B?bFZ3YUJveTBidVJLQ0l4Z21tYWNzNE1sSE5Ud2pxTytFQ3VHV2N2NWREeXFN?=
 =?utf-8?B?K3JiWENOVXpFN2ZVbUM5SEhmZVA0UWRDMFM2T2VqVEZaWlgrUmF1cHA1OCtH?=
 =?utf-8?B?MWtxb3p6d2d2eGVRZERHUm0wamlGWGpBQmpGRTZPM1pSNjBmL2VNdmdsc0V6?=
 =?utf-8?B?dE0rUHM5NXJxS0JmWHc1MVVHSnJsQTdIRlcvWVFIeWFUWTNtN3Roc1RZbVVM?=
 =?utf-8?B?NS9LTXEwVWFMQkVkSWlSR2RQT002YklTMGt4NE5HZTlaK2EyY3N2dlNHUXFC?=
 =?utf-8?B?L09LWk1SRm5BczBvSWZqbzI0c1BzaVlxRG45TzlWd3ltblNsRVNzQ0VhalJ3?=
 =?utf-8?B?UldueDdibG9rRmx2VU1Tek5BcDZ4UmVjNmsvekx4Y3dGTEJndHA5eHdndnBr?=
 =?utf-8?B?Tk5LcTNIWnVGL05iM1B6VEFpNU1yNmhtMCtPamlqeXBVK1VhbzYrSEh3djkr?=
 =?utf-8?B?UWtYZ3dQZHcyVHBJTmN0UjZVZ1BvMjEvb2FzRkNkQ3VESFJTeW44bmN1UXl4?=
 =?utf-8?B?L1BGZjVtTVNjeUNjRFBIdm9taHJ1WS82Z0NKYUZ0dzZqRmQ3TFJodkI3SXZr?=
 =?utf-8?B?TXlraWlxRS93bkdzekRmMGd4dHhwbng5L3poZ3BsM3Q5cWkwbmtWN2FObG1L?=
 =?utf-8?B?SzI0S0dib0V5cXlRTmZ2L2dNMTBoN3JWNUlFSmFnM1luVmFKN1lxODJyalh0?=
 =?utf-8?B?SWVGWnNpUUhsejRrdVhyclhHNFN4TXc2dzhTM09ZY21ZSEx1N3JmeGQvOTVv?=
 =?utf-8?B?VDNBbmNFVmMzRWZaOEd4OTJFR1FGMU44TnVZVGpYWXdRTzRYaytWaEZoN0Q1?=
 =?utf-8?B?UCthK1AwY0lxQkFhTlJZL0RCeDJLVDYzU25HVXlFSkdMalFnVUlHcUZBalpP?=
 =?utf-8?B?YUVNNWNxdmY1a0d0WTBWMEhDbFF1cXh0MWljbEQ2SWdaY0hFQWdRZzlGUTM1?=
 =?utf-8?B?OXdiemEzSm1zZG0vbTJPTDQxNjFINHM3QVU1V0VHdkJaUHRuWllMcnBqdGln?=
 =?utf-8?B?WlRIak5lc2FtQTB0QjFxYms0RDRueDd6SGlNSE43VGh5TmRlL201QmtRWk5h?=
 =?utf-8?B?VzQxTit5QVhNOHFKckJtNVlvLzZHdzNJeVpRNmIyTDlLdDQxZDc2TkRoUk9o?=
 =?utf-8?B?NG1RMkZxaDhxcGEyOTNXUEhndkdIbGp3YW0weStpblBDOUR4K2NEejdtZUJr?=
 =?utf-8?B?K3h4Uk5iTGxRc0l5OEg3TzF5azk5a1VTQS9PU3k2MG1sa2U0ZjBBd0hUaXBx?=
 =?utf-8?B?NjBLME9CZ1lmVDN5T2REQ0UrdkV5Q1FxUmNXeWJ4eEpiOVY5Y0c5V0IyT0pY?=
 =?utf-8?Q?c/vHiLlkZ4TwOGb8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91681939-665e-4d77-d6ee-08deaa7fcef7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:25:05.3459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTsYD25j523ogsHmkWQIpla/ciqz4fv16ZCVdTkJ0w6325LvNb5xXIDbGiH1y1pk0BRJP14ij5wYsMLI36w9bv/nNoXCBz+lEUP699uhmiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9806
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

On 5/4/26 14:31, Simon Glass wrote:
> On 2026-04-29T12:18:51, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>> patman: fix use in worktree
>>
>> When using a worktree '.git' actually is a file and pygit2
>> init_repository() does not like that. The intention is not to create
>> a new git repo anyway so use normal constructor instead of
>> init_repository().
>>
>> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>>
>> tools/patman/cser_helper.py | 4 ++--
>>   tools/patman/cseries.py     | 6 +++---
>>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
>> diff --git a/tools/patman/cser_helper.py b/tools/patman/cser_helper.py
>> @@ -309,7 +309,7 @@ class CseriesHelper:
>>           self._copy_db_fields_to(series, ser)
>>           msg = None
>>           if end:
>> -            repo = pygit2.init_repository(self.gitdir)
>> +            repo = pygit2.Repository(self.gitdir)
> 
> Thanks for tracking this down.
> 
> There are more init_repository(self.gitdir) call sites have landed in
> cser_helper.py and cseries.py - please can you convert those too,
> otherwise the worktree case will still be broken on those paths.

In which branch? In master I can only see init_repository() references 
in tests.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
