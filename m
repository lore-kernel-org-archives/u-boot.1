Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B251C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 13:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABE268756F;
	Tue,  2 Jan 2024 14:02:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pzABLsjP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50861877B3; Tue,  2 Jan 2024 14:02:36 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F0518747A
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 14:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsKhI56VwB+nxeZKA/BT74ivENANYbFRknH8m5hE6ICZiMOsSOubQvuN2J7tVQOoeXSytmRTJyRxkYHQzmwGaZ3AnUujxvez1VsMKraf72Alo/4sJh12CMM6MNnFD7iPFP5Gd7A7ADMC3NdHOn48Zrf9fLkLvDC+tG6JD4mnGbKPnK9/MCuh/PBTUQe4zKABZuzofscJm1rtVKF9aw3FA2IecaHggh2IbHtBeo28uAT/+i5o40nEi5f/X9sKQg4sqaLVTYgglB2SuJM0fsZdo+Vnr94Fg2jbu+GAR9EMuYcmGyITRR2vM5VKbnxYxbl+vM8ovbHNdmxWGGyCyQFN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPzj+OMlgWXNkQYagh9B03UHcbi9hGVyTTnLTxBsvRY=;
 b=jc8VjuGXjXoYHO8LsRA/3/z48HLHVOuHs9ehy4To9AexkxPPu8Mh+5sNcku7zpyblgSE15oyTsxBVU022w26QUuLQEWnslna4lyiHNfrRzG1qVAKxPc74f6pSodMc/d4NSMJ4p0e6SJwkP+ugHTQjbn54n8z+kxxHqwjn/lyzpdOScI9r9iRe10X6vkb3nzFmD5QQGhanfqqwgLXXf/0CrhtzvAKJAvaF7jeZasSRwENoQt2Bont9UaZKrDM6PPhEcV8U1LjXwfeTR2CebQA5jCizHv7Juh30b3+DZyolfCDlwfncGly3yJqFro7xM2nJ7W+YpvrgH5REzEnmwUm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPzj+OMlgWXNkQYagh9B03UHcbi9hGVyTTnLTxBsvRY=;
 b=pzABLsjP8vuD0U3OS92LkmY74hFTdFCm9kqitDiC1l28agPb0chc7upYLC9wldWT5/1JMlteQzXXx2xDxNXUnQXCez3TXR8JjomNy/8CZ+Zzc8IoIqAef/Vjk5AYviLOp3TMHuJZGc4j55B1lEXfg7BQ/ArlVwhVEgwmchNAGBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Tue, 2 Jan
 2024 13:01:27 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 13:01:27 +0000
Message-ID: <e49cfe4d-cb3c-4779-a906-223c82c1b60d@amd.com>
Date: Tue, 2 Jan 2024 14:01:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] microblaze: dts: Use the normal build rule
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, "Hatle, Mark" <mark.hatle@amd.com>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Michal Simek <monstr@monstr.eu>
References: <20231227082405.2202246-1-sjg@chromium.org>
 <20231227082405.2202246-2-sjg@chromium.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231227082405.2202246-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:802:2::24) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SJ1PR12MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: e3746d4e-7bc3-4e3f-9b64-08dc0b92edfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRLfmvKQ8rS2GbSgocn+y3BLDBlknmvL4ksBCC0uKaWUYtNHs5qHqH0QUB8s8rM4DdhtTLSOGLWJeuKRePXoVlfpST85YYuDaJ6NdNHbIZeb+dIDjN+5LeH37QbNza6xEw6wYYxbsjaLvrhasDMydNNclAsM3NNw1yXY7F3UubnN5KbUfR8aWVhnyaX/Hj6dNOE4fcxiIReRWdPWgsc7IDPbFagEvwPvjYjJhImWwHcWw0HuNLIY41hT70QBP6RsiFX64do3P6dgd9jFyeuuzeDisZ4PWuH0v7zZxdabi2Z72kRBm8cNAWjV1aPDvGC8CVeLRlJih6nlzKfHQVrgz/hm+E7BR/3KLwW8f1SI05hgMEyAbr1OeiXcnIyzyLmw2fIwNtdAzJAR6vRtYw7VczsrV/Hm4f5CEwCsSIJlzSwd9aXl9KVVqfc9idJX8CQO66HeXmKFa9awmlilfZY8c0inLsNHrEmtjy6bTgXgJiEzMgMrpne4xt19N1cyGijnv7tXHDzA8vvtrOZK18p2/8f//849C5O4agj1glVKh7YCEk1grc5okj8Y75932Vw9lwNYNPdlyyGdZwNVjHvx3XyfmcOpyPA1eS7ftz+0eHO0sNVsTusJbNuPbl7VEJN+4JiYmRv+HT1Nrd4BoOj2Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(36756003)(31686004)(66556008)(53546011)(6512007)(6506007)(66476007)(66946007)(6486002)(86362001)(31696002)(38100700002)(83380400001)(26005)(2616005)(41300700001)(2906002)(6666004)(5660300002)(4326008)(478600001)(44832011)(6636002)(54906003)(110136005)(316002)(8936002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWk0bWZ0eG1qaXZCVU9veUZJdUE5ZWdScTRFV2hJc3RiNnlsN2E4eGd3c2V6?=
 =?utf-8?B?a2NITkFEdFl5ZTI2Nk1VcFVRV1RIUTRSQ24xLy8xYndFZnJyZE5tSk5MRmE2?=
 =?utf-8?B?cFVMNDBLc25YVVc3U0N4eUNzeFFyRzV0b2tnRW1HMVJkOFFNUHRzNnVvYmF2?=
 =?utf-8?B?VEdxWTBsaFJTRVFCemI3Wm11bW5WR2tKVHRwOWdYMTQ4NGRaMnBNVXNxclRY?=
 =?utf-8?B?dERYbUwzSExVb2VldEt3c1dBVjJqLzJzaFJFMTZLWHE4VzMyK1NVWkEyS3Yy?=
 =?utf-8?B?cmZSOTMzQ3JITHhtTnl4ckdZNzdFbi9KaTdHS1VPdDNxTXlKMUVyT3RGZWxQ?=
 =?utf-8?B?UzZHWVBIT0FzSTdqSEZ4SGE2MGt6TWVwTjZZOG5KSjFWeVVveGwwN3dZUEJr?=
 =?utf-8?B?a3g2S2d2dmFxL3V6cHowR3dWenhYcjRMTkpHdnRhRVhsVmFvNVR5RkhVM3hl?=
 =?utf-8?B?TEN1ajV6M2RDTUtidHRqTDFDOUhZTWEwdHp2NHBQd2ZyMjFoNW1WL0dISzBS?=
 =?utf-8?B?TTFNREJSaHl4RVFWNTJsZVJTRU8yQ3N3cSs3KzRlOG5qSHNmdkRnc2lKT2d3?=
 =?utf-8?B?WnlOL0xYQ3pXM0tQQjd2QUE3a2xaWUtnaXh0Y2VkaVM2SkNUNUExckkxVzBO?=
 =?utf-8?B?aGdjMEdyczBEZ3c3ZkpFV3NFcUVaRGZROU1pcHdKNFU0WkxGckdpMTNlK05B?=
 =?utf-8?B?RlQzUVJ2K1Bhb1JJTlRMaVc4K08vSm1acUliNXhtSkVGbC9aSDI3eG9VK2Qw?=
 =?utf-8?B?T2JLV0tEc3hFNDdyZzZLUVg1T1AzSWtRWW1kR2RER0VzZytVR0JrL2E2cXMy?=
 =?utf-8?B?c3pKdTV3R0c4Y1BCWUhPa0l2Q084bmpxVCt1THlCcmRKOW5aOWZKMS82cVlo?=
 =?utf-8?B?bFpKSjdmRjJjR1pRVGRrRXNGYk13NUdHaVNrMmpKWjBJaC8rY2lZTkx1THVk?=
 =?utf-8?B?a09oQTJ0SDE5QlR2OE9WbCtLTWp1TUtxd291WGkrcFYySFdkalUzdldOc0Q2?=
 =?utf-8?B?enZsYldJRkhJeklJZW1Fcm1rdUFucFdhcysvYTcxWjJJaGlaS1N6RjRqRmxV?=
 =?utf-8?B?cnVkYSthYW5pWGRqdUFkZ2tyUFJzT2NNRHQ4TUFwdHkzNjRNUlFyMmd0d1ZI?=
 =?utf-8?B?cHJJZC9CTGxSWVhvazdHV0NJNm1qWndqVXJWb1ozTHdUV1VPN3Q4aGNlYWI2?=
 =?utf-8?B?SnhzdTVnNVNXTmF4TWZxak1hWUdrOHVqWWNpSndIMHJQMzhMdktNL3BxQ3Yx?=
 =?utf-8?B?UU9jVXBITGFIVCs4TWcreVh0MGI5bnhjZlFzVWNUSk5NVERhT2cyMWNIMXQ5?=
 =?utf-8?B?N2IrOElKVzVSaG5NZXNWaHNXUThISy8xeWl4NFFHVWNma3FTT0RYZ2N6TEF2?=
 =?utf-8?B?M2c4UlpGdjEvRlB2VE5Na0VMTWF1UFhOMENaOVVmUFZieXVoT2R2d3N1OTB6?=
 =?utf-8?B?Q09yWHJwSWR4N25OdHZVTUpJR1MzQ21vRlRiTTUwd1AxVnk0RklRSnZLMUFl?=
 =?utf-8?B?ZGpPNzNSS0FZeVd3dVdsVjFnbGo3UDZrT0x3bDFsM0xaaWlpRnA1R0RKODhk?=
 =?utf-8?B?dDhSejVkM2RLdzRENmtwNFcrR0VtcmY2eFhOMGFDYW1Ka0YyWWpFUE1pTlc5?=
 =?utf-8?B?bU1GRnRwdENvSHR6NWRLeHBIUmlINjVoS2VFa2dkeDBkRDJiTWg3Y1NaOU9R?=
 =?utf-8?B?ZUtDNTRyWlFSamNLUjU1Q0dYRDJrZVVOclBudTFGYnhGNzRGblZiNm12SEVX?=
 =?utf-8?B?M2FDR05HaXR5SmR4b1B6NmJvUW8zcldnbUdtZ1dVMGRldjlPOHNOMXhKOU5J?=
 =?utf-8?B?ODRJYTlobHpMblZHa0Uzd0kwVHo4UFBNTXdKcm0zclpBSDZJeGxFbGVXYVlV?=
 =?utf-8?B?N2dTTisyWVhqMVVzQmw3alYrR2tMMGFFQ050OGFVUWlzb1BwU0F3QzdSVUl4?=
 =?utf-8?B?a3JyTVFzVXc3dnBqbVdRb0JYczRpTi80OFNCVEFaQjFUeDNJY3cvaldOL2R0?=
 =?utf-8?B?NWJvWXhQNTEwa2NDenk0NTJMdVc3UFVLelEzQXBKbUJzZklWQ2h4RldWajVw?=
 =?utf-8?B?cmdSYzVCcUZkN0U2MGRjOXA5UTdzc0tVSmV0T0ZyMS9iSGdRQ1hnYXd3eUor?=
 =?utf-8?Q?4CSFzeGKWti1Cw1PfUg/605kY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3746d4e-7bc3-4e3f-9b64-08dc0b92edfd
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 13:01:26.8031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGLHfnYzzrKJcdTG5sfLA8kWEBypVz47K6afvcfvc9WDI7vFetPXuXls855P+DAP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073
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



On 12/27/23 09:23, Simon Glass wrote:
> Build devicetree files using the normal SoC-generic rule. For
> microblaze there is actually only one SoC and one board.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   arch/microblaze/dts/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/microblaze/dts/Makefile b/arch/microblaze/dts/Makefile
> index 427a8f9aaca..adc76ddf21f 100644
> --- a/arch/microblaze/dts/Makefile
> +++ b/arch/microblaze/dts/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   
> -dtb-y += $(shell echo $(CONFIG_DEFAULT_DEVICE_TREE)).dtb
> +dtb-$(CONFIG_MICROBLAZE) += microblaze-generic.dtb
>   
>   include $(srctree)/scripts/Makefile.dts
>   

This feature was added by Nathan likely for yocto purpose.

commit 41f59f6853915291c7451c9e38c196fd5a90bf6a
Author:     Michal Simek <michal.simek@amd.com>
AuthorDate: Wed Feb 15 08:22:04 2017 +0100
Commit:     Michal Simek <michal.simek@amd.com>
CommitDate: Mon Jun 19 15:52:39 2017 +0200

     microblaze: Build only DTBs for selected target

     Adding more targets to repository requires some additional
     changes not simply just adding config file, defconfig and dts.
     This patch makes this process easier by building only
     particular DTB which is selected via defconfig
     that Makefile doesn't need to contain all dts files in the repository.

     Reported-by: Nathan Rossi <nathan@nathanrossi.com>
     Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Mark: Can you please double check what Yocto is doing for supporting multiple 
microblaze based DTs? If you are copying dtses to u-boot source code and then 
using CONFIG_DEFAULT_DEVICE_TREE to select DT to build?

Thanks,
Michal
