Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD8BC47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 08:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C77878AD;
	Thu,  4 Jan 2024 09:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ftE//35G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 621AB8795C; Thu,  4 Jan 2024 09:53:19 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5098B876B2
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 09:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=newPA5oRt/p2xmEbXCB3ab+SBmcVMIQoD3kqMGpESwZRNxgcJg/2ZV3/kc5ChDoOXPcv4RRM9rsIqqwHkN6s3Usk9C6aQFtI+oueHo7F8MXIuYozTOthGPHc7wVk2mtUUsFWonqKssgStO/U7laAeIHfRoduIegk58vtFmaF7QDXCPgOsj4JKhgDDp4O3HoTGv5/BJfKbmO/vSc6wTV/r4F4zjJkeIRZyUT8dO+xOwCAsMVDsRCgzOyFydIzZv6Tg8hAInsNGoqB4HA3phm1z+KCALSiYfbm61Be9hHhNddtdhfdmbLL++oXpK2ZlQdj8AHfuhyY1UXZpM9Risb4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uec1E9Xx/y8YwXypkWcz27BwwFJaodmX8b5vGoP78UY=;
 b=NtsdOl1hfjINBxO83Z2upercr/CV0Df8wnEcl8Ljm6vNhyYxFqkPV0i8L7mp0IAsYMn8TfEYr7UjX01h7bQyZSkLcEZ17sLGtlRqy6oc/E1ot2w8FnFQP3FGlvxNSpMfuOCMFmlgDhQnDQiQf22J9WlMcIop+eOP93Ld+limxkS/T1rOMOLAtNUqgTlUKuP9K9DuDRMfud+PYCFq1SlJbbShWlxnd6p25ZTN1hIluln9aksTnJrO0cZhjm2wja3+nvj/SBW86HcxtYMCS2nkqzB2oQT7Ux+JXNetRKUU84abgVHVw7s3+tXHxH9d9TrKOb0cNyyVBqTSef1Lhk9zYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uec1E9Xx/y8YwXypkWcz27BwwFJaodmX8b5vGoP78UY=;
 b=ftE//35GJi5P1kFm2gH7GAYKX7TJ9kSOw9FlqJfqEkzipjHUuTUAGpKW8CEpqssWEJtaM8pdbjmKlZkgZB/Nvy4UpVMFdwvTvHn8FJEUIhNxcoa9M0nzQdl5/ySpIoGCJgL4k3/l+fM33AKlWSViOsTW4chQY4pIsI16c3AKGks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 08:53:15 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 08:53:14 +0000
Message-ID: <e30cb72e-68b7-4f25-a281-20217a02cc3a@amd.com>
Date: Thu, 4 Jan 2024 09:53:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64: zymqmp: DT alignments
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
References: <cover.1703002605.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1703002605.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0078.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::31) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BN9PR12MB5367:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bffb0f5-9710-4fa1-8dff-08dc0d029691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cR++5BRlAhmzbTA/3szWVXZ/dLQ0foGLuZASxsNxQtrXWKYvNqyRsdDKU3cFp8brraJYt73x/n5OG1KMMuLK4c5eb/fHngBoPP6/5Ctq84BUiefMDv7nJ/hCXgfg8SZ9coXXOC7jKRDX1XU0soDODzosgbhWXTaVoLAQZJYsBtK9MOIljpcrtMBYTzMYUxqD6KnH2op32nWV4HydUcTJxZ9mheI08gSbbgNmnSSkaOAANk5U4ag74ap32E4xAcfY1eisv9IlWR8Uwflwg0wHL+rGJANVY6OidQZA0S/BzyoVnchrxlN0exxmIMD041f2OqIrG/TRKP/zqbOnFhkDmRjak3JLKTphPZkRfjhfglrf3bLhp6O/AdGQERjIeAH0ArbGxUtSJZTDwxrxmkrn1EVMcRPo1eMTdZxTvCAgIkIdnxrvc8sesWHPiIRx2AHjBM+Q/PUKPCiEmf+ezrFPWMyMWyMo2lXd3p+4dhm6MzqAQooKYnvqHJecYs/opGV/D1ohxHzX5dGmtWbKpEjRhYM6tzZEn/QHuqKqdQZt6JhDagd7KfStFjTkv+OhyvhIET5wOpEglrhj+RaRKw0B3s2oYmkWxE4O4ce4/EcBIHMxhsIuLl/1JDmDzKMdPmihjlnoJ0EMZWR9r/4LFR5hLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(86362001)(31696002)(36756003)(6486002)(478600001)(6506007)(53546011)(66476007)(66556008)(31686004)(66946007)(6512007)(26005)(2616005)(44832011)(2906002)(5660300002)(8676002)(8936002)(316002)(38100700002)(83380400001)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUZ4T1VISzRua3J2MXoyOW82ZmR1ODFyRVhZYTk5eWpKeG9BL3laaTdjYTZn?=
 =?utf-8?B?R2FnWGpJUEQveWIxWlM1cU5QMmZvRmovbnY2ODZSMWZGVXRkTkhKTkQ1aXlt?=
 =?utf-8?B?VVB5WllwZTFQMzBwdkhlUlFXK2IyZUJuWXdSa0RWa0VNYXJ2U0dFRXczK29G?=
 =?utf-8?B?elBsVGVCeGhqQjRBQ0lWMmo5SzNMRHJyTjh1emc5UkRlb3JDY1R0citMRGtZ?=
 =?utf-8?B?RVZtRGJlcVBNNEpYTVFnajRBV3VBZ2ZLQThBc3ZMVFk2RkIvNUhiY3c1SjB3?=
 =?utf-8?B?SDhlUnJrTDd3TGtqVUZRZ0ZtMm14ZGRaZmQ0a25SZmhsK3hBWTNYUnZEcDJY?=
 =?utf-8?B?R09wR0R2MXpjdjdUMFgydnZhRUVBRll0L0lkRGVKM1RlWkg2dEs1dHNqSk1I?=
 =?utf-8?B?L045UWF1TDRTelRzbWVKUFJNL3ZXMFgyTmIvTmNhZnBOOE1kK2Eya2tVeGVx?=
 =?utf-8?B?VnBOUEsxVnpGT2ZQSU43VjByWnRCYmxUZkpJOTRRYWk5NWh5cmxocjF6a05j?=
 =?utf-8?B?aEZXVDJIUkp5RlRkN0lxVWRabmFocUY0M2Uzb3FKRnA1Q2ptVXRlWVhCeGZt?=
 =?utf-8?B?ZHRwWnBpNnNEaDUyK0g4dzdtUXIrU2R5eXA4OE5MeDVoQVp4RUlZMEcvMTFs?=
 =?utf-8?B?ZTZQeUNxUHp0SUVBd2FMeUV5L2dpU05mQURYNnhyd2NndFpXQlh0bElLR3lN?=
 =?utf-8?B?VnJEVm9YQk42M295NnBoTlh0TzRaVGFVZVIybnMzc0NZa3h1MkdMZHVCRS9h?=
 =?utf-8?B?TWdGb2RLVUxQNDZhUjJCcXlzY1lpTi9EVTYzZm1yeVpLTDg4L3RzQzZ5QnlL?=
 =?utf-8?B?dDhnOU5jZXgzd2I5amRHTUI3WWNIMXVORHNQUWQvdU45Z0k5aElyWEo3Zkhu?=
 =?utf-8?B?L3pSMSt6K0NhOUhtdDVRYUtMTExjSjJQY3ZZbHdCT3UxSlc4SmZ5ZU9EanFh?=
 =?utf-8?B?aFRrNldJVm1FTkpJQVp0SVZNZE9aMGsvc2tjM0I5WTF1aFAzMGpNL1p0TStz?=
 =?utf-8?B?TzkxeEVLRnU5UEdqUEFKa2JQcnI5eGFyNjYyY1A0WHQxYW14SThKbUZ1SDdN?=
 =?utf-8?B?NW85R0ZWR3VTemU4V0o1T255djR1YW9GUDA0R1BobGJycEI2cmRLa01DVXJZ?=
 =?utf-8?B?TE5LVk4vaUZPN3M5VURZcVRrdW1Pb3JwRTN0bGZnUkJEYy9xakJTMUd3emJ2?=
 =?utf-8?B?T29jOXZhOVRzOHh2MVhTMXQ0Uy8vdXIrZ3VCd3hjaWtsVDU2a3V6TXJOZTE2?=
 =?utf-8?B?WkpsSzA5T0ZZMnJucFlITmxzaS9SMHF5MXA2R05NTDFkRVUzK3V4OXR0U2FK?=
 =?utf-8?B?TytHWlFWc25zSTRON1pmeG1vNXUwQ29VVkdVSjA4UmJzV1BtbVpid1o4RjB1?=
 =?utf-8?B?dkdPSlN3NjYvUlpNY05xbEFQOCtuZ1lkdUt0cUFsR2pSUW1weFkwNUVYN00y?=
 =?utf-8?B?am9qaTg1d3RTNmFUMGptdWVYR1Z5UVhmT0FZUlRCUHMwV2F0UHJaa0VFa1FD?=
 =?utf-8?B?T3A0ZndOWkEvMmprQjIwY3lFSkt3MG9rbFFDc0tKU1hYdlRHUTlOSDhsbUt4?=
 =?utf-8?B?SXp1WU9QajV2UHBpTVVRZ0N6enJDYzhXdlY0Yi8xVmVjNi90ekcvaWFGQVpH?=
 =?utf-8?B?Y1hWWmdScFNQVWM2QjJuK1dCbSs5Qmw0MzFsSW53dW40Q2NsN2NOOGljUzQv?=
 =?utf-8?B?OGxDM0M4Nnl3N2oxUjJyV3JnVkduYzlRaEovV2pLUnVxb2ZXeko0OU1QOG9U?=
 =?utf-8?B?L3NNbkpHZnVhTFVpbkZoQ05FeDBzWlF4Y012cGpheUpSN1h0eWlxRWt6U1Bu?=
 =?utf-8?B?dFF1MVpONjBHUGNNdEd6d0RrRDEvM2JUdU9CZ1VBaGdIWG9GTzQ0NmJGcEZL?=
 =?utf-8?B?dWZXY0pMM0NNU2p5UFhDTWZybGpIOUExNnlRalZiZFBsdzhKcUJjNTZuUkxJ?=
 =?utf-8?B?NUY0QXhkTDdvRTM2djlpNzBIV2pZaXNOYzFsUUt5MG5lQ3o1Q3dvbTJlZHlR?=
 =?utf-8?B?RWZOVE5SQ01FUVlqdGdicEVRRm02VjVBWUpsWCt2Y3ZzN1RwNTBNRDRWVlow?=
 =?utf-8?B?TERTQlJPa01iQ0pldUcxeW8xQmlIaUIramRZM2c2WVNlcE1IK1FQS1c5K0Rz?=
 =?utf-8?Q?MatJJxDw+t9XBlDMQ576AGEbH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bffb0f5-9710-4fa1-8dff-08dc0d029691
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 08:53:14.9249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Hy0MDz0zgl0/sKKdixAf9+MBW8PVIc+hblogEZjuSGbAXoVZglojymyJDmh/XII
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5367
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



On 12/19/23 17:16, Michal Simek wrote:
> Hi,
> 
> sending couple of patches to get in sync with Linux kernel and they are
> already in linux-next.
> The last patch is based on the latest proposed update in dt binding.
> When dt binding is reviewed this patch can be merged to U-Boot too but I
> want to make it available earlier.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (4):
>    arm64: zynqmp: Move fixed clock to / for kv260
>    arm64: zynqmp: Fix clock node name in kv260 cards
>    arm64: zynqmp: Remove mt25qu512a compatible string from SOM
>    arm64: zynqmp: Rename i2c?-gpio to i2c?-gpio-grp
> 
>   arch/arm/dts/zynq-zc702.dts                |  2 +-
>   arch/arm/dts/zynqmp-sc-revB.dts            |  4 +-
>   arch/arm/dts/zynqmp-sck-kd-g-revA.dtso     |  2 +-
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso     |  2 +-
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso     |  2 +-
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso     | 52 ++++++++++-----------
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso     | 54 +++++++++++-----------
>   arch/arm/dts/zynqmp-sm-k26-revA.dts        |  2 +-
>   arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts |  4 +-
>   arch/arm/dts/zynqmp-vpk120-revA.dts        |  4 +-
>   arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts   |  2 +-
>   arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts   |  2 +-
>   arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts   |  4 +-
>   arch/arm/dts/zynqmp-zcu100-revC.dts        |  2 +-
>   arch/arm/dts/zynqmp-zcu102-revA.dts        |  4 +-
>   arch/arm/dts/zynqmp-zcu104-revA.dts        |  2 +-
>   arch/arm/dts/zynqmp-zcu104-revC.dts        |  2 +-
>   arch/arm/dts/zynqmp-zcu106-revA.dts        |  4 +-
>   arch/arm/dts/zynqmp-zcu111-revA.dts        |  4 +-
>   arch/arm/dts/zynqmp-zcu208-revA.dts        |  4 +-
>   arch/arm/dts/zynqmp-zcu216-revA.dts        |  4 +-
>   arch/arm/dts/zynqmp-zcu670-revA.dts        |  4 +-
>   arch/arm/dts/zynqmp-zcu670-revB.dts        |  4 +-
>   23 files changed, 83 insertions(+), 87 deletions(-)
> 

Applied.
M
