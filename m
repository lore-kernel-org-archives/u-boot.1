Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638BAC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 08:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9E7C879AF;
	Mon, 18 Mar 2024 09:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4WB1pGZC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6B3787CB1; Mon, 18 Mar 2024 09:26:33 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4CB3879AF
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 09:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GH4Xvxv+F81oiTnFIL8lHSsCdoh2AlgHIVASae3QEAuFSWFfvyJVBDESkrHRF13y2ARQwSaAiOKrlOybPhMeyGSEE1Wuwrn/BhACuGTSXl2RYbGwq6bcrx3cgnElkMPY8hkivNgh/7lvpeG+FDcXk97hpb7kM0uL1PwGnhmSKMb5DFInzT8mQSmm4k7OPUwRA7yYO6AifzC3n5vK33JVWJfI+Hvto+h30CXaHzfwJqaTTdaBe4g/gUtCTyAm2ohKoA33us6QzRMmiX1OKTuk+MikJeEV4QkdfyKSpi0mq1U5kgumHczFhkPfovmrjHVKv4xfd7jXiXBJdHYFxUbrpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVPljn/tA1tfmKFjy9CvlUQOZtQx9YRtEABKZk7OqA0=;
 b=oOdJtTlLnXspFQzc0/H1bNUxCoMpOfPr36bGW060vUaktRdpLdvtY4d5qnTrij6NnfpSk7skpnrYGm1NLx0dUdZlZWrn6vrYAVn5uMkkhn50TrIc6AOaZnjMOQR7ZUGkgFMh8nYVicCfKccTFVfatl98Hhj0BjVyEI5Nq4iMK4g5ujovAOKZKToTwe80Grs4bLASeXxgDPzn3qbbOq1lBie4lggLgtMS9ZrwGyVf4kaD+1StiuuhBQtAy8Wpr/2++wR1fRm/1v+gbD+EKXCpR2wVRwO3qSf1dubn4wzw9pIc4sAYpb7uP+UzJXOloav1uYLxof0DuMmGZxlwsftmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVPljn/tA1tfmKFjy9CvlUQOZtQx9YRtEABKZk7OqA0=;
 b=4WB1pGZClRfNaQVI44dyPm7WUEsZSGztzJn+Np3SzTbgbXkibnx1BZV1IsDNWOKZTivAkioHVevW0LmY8GeDYnbUNTh1erNXHTzBbjqfsynDLbdr8izPoz5lakKEYzuUyfzj3Er8fUPatp7olxpBhD2ouywS1HR9ANFHO4abWCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB6836.namprd12.prod.outlook.com (2603:10b6:510:1b6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 08:26:27 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 08:26:26 +0000
Message-ID: <03cf43b0-e9bc-4174-b9bf-3c380e388203@amd.com>
Date: Mon, 18 Mar 2024 09:26:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] xilinx: zynq: add FDT_FIXUP_PARTITIONS support
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Stefan Roese <sr@denx.de>,
 "Polak, Leszek" <LPolak@arri.de>
References: <20240315192528.464849-1-james.hilliard1@gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240315192528.464849-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0053.eurprd03.prod.outlook.com
 (2603:10a6:803:118::42) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: d476a383-f01a-4ce1-6e06-08dc47251a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfdX6zptmxtRlQFn8synniz9LxXV2VedNyspYEUeTG/HyXMQRR1XFuj+Z5qnCFwtT9HWvk/3quM+EbDzMcKjdNqLZv/BJn2ymy3mR5V4cFlUm+jvgZoMc2knU1+5hjmlew+XrCcunmtm1e4vJh0M0OIyEBbUCXHN8DLht0v6KWc9x920FEzhWqcyMK/0vndpzaHdxYo6ArInEdPr+69JQEf+T03nT1oIVanoiOyIIADhRi2q36M/V4cGFgJ4WSma8KRQENxNU5JxQkUuXEQxwHgwd8Rer1M2JgsEjra/d5n1eKNPE0nf6GsgB+MEBXnu9kZB9SimyvONRguuE5Cv0Uk2DQDfv+DoVqxZN7WOlfVDtg9lyb/rFci73AE4opxIYgzdZWqjZDoDG8YvIO242AWf6nBf5Z8EIxw6YH+5r24ICxUR1eWO0K+86vV/EvM4b3pCUTKALxzkNtjiHP9W6GhcG+NtaBWTVsYaTksBWdoCIOUQ3uXKNe6qbMldX5g5emtet88HlCrd39jwHxlUW3RR2CCXjgJHWNqsv/0QCitLqqCH7FNQr46IDsc9WzWVmJmG2uBLt1CZB4tkkf6SdIpTmbhSKSRoyuMrCkCTe3cLZwTdiaRF4LUMCuRnrxYOnGfUm9pzy89b1J6LABrWypZMCSt+zY+TaHME/3vNcbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2RpcWdCTXB0T0ViR25OVTNmcExLWDl4S0ZERjJmcW4vWTQ1Q28rMUlSN2Fo?=
 =?utf-8?B?WkdmUFA4dCtoK0I0VTduZTlGaUIwcVVmNlpPL0ovcEFlNUtxU1l1aVRiaWtP?=
 =?utf-8?B?Tkg1WDI5UWtwamphMURhUldYMzFqSUNPRzk1a2gwTk0zcTMwdVpzcWpiK01S?=
 =?utf-8?B?a1hLZm94Njh6bXNUcm5rbVQzVWpaL3kzbGZ3RzhEVDZKaWZaSGlqOGJZN2pr?=
 =?utf-8?B?Ty90aTczL1VHWW55WU1JSE9XbktVaGt4RFB5dFN0SVZMU2VjRUlsVU9BaXZC?=
 =?utf-8?B?eUtVaW5nUXYzOFA0dGJ5QUJGeUdIaUlWZU1DV2dpN1NGSXJMa3JJdGN4eDJm?=
 =?utf-8?B?MTltNXNOTU5TUStoWk4rTS9ydnozRU5YR2RLWVp5VFd4UGRSMnJESGk0azRs?=
 =?utf-8?B?b2wvM3dLbGVScDZSS3B4WWhsSkR6MmhiT3VLMm43VVNjUlozcjU4OXp5VWJp?=
 =?utf-8?B?aS9IZWs5QWJFOE1FNHJEdDVFM0VBR045Y1ArSzFaTFpGQ0d6cS9CVUlHcURT?=
 =?utf-8?B?TWpOVkg0ZGx2UWhDRXBwcHR5dzl2ZlArVEZsbE1PUUc2cDJyMHFNNXFkQ3I3?=
 =?utf-8?B?L2RHQ2NKeWJxY3V2QndiTUtmdmkrcUNLZ0srL3BqR3YrbVdSRlhGZ252bGkw?=
 =?utf-8?B?Z2VuTlVua3RZU0FTSzA3YlgwR1BRVUk4aDlmc202aHBreWEwa1BSbGhmdUhl?=
 =?utf-8?B?VXFBWGtmSnJpQWNrb0tzRjJSek9nUkp0NzFxNVlRT0crQmN2UVlYZWN6RFVN?=
 =?utf-8?B?RWtsL0lCaWFUR0JvZVQ2Y29jaFZ0VDhUSjJtRzRqb3lQRFZLWlI1MU5lMHhj?=
 =?utf-8?B?Sk1SVHNWY293MTJObHZBUXhHU0duZUt5TldWWkxaOWV3aW5EV2ZFZDhsbEpS?=
 =?utf-8?B?WXpGMmE4dzJFUmxpODFNemdmWGZONFhrZ2FaanpzWkFaZktuZ3dwUzJiWktN?=
 =?utf-8?B?eDFxdHVYUVF4OE40Q0ZWdHlxWVZhelRjNmc3NGRma0owMkI3Zzl1SExDOHM3?=
 =?utf-8?B?YW41MkJXNVk0MUdWR3U3R0E2ZmxpaHY5M1ZoRkhNOVNhSmtDNVp1SS9zZjhB?=
 =?utf-8?B?RE5SVmJZTjAycllnRE4vOTk4Szg0MitQWExoZ1NSY1dyeHlzWk5LQTg1ZWRl?=
 =?utf-8?B?aGoxcjNBQ1o4VXF2YVN1MEtZSXRxUy8vTmlCbGJWWER1SFhoSnhiajhWMk1j?=
 =?utf-8?B?SlpmQTkzTHdBZ0FtWjk1NkVRWlNjRk1YdGpsV0xDRWs0YkhFZnZCcTlML0VP?=
 =?utf-8?B?aStINE15ZHh2SVRqUkxGT2x4dTRrNVI4VlIvT1RjSUVpSlFUNno1UWlQYllI?=
 =?utf-8?B?Q29tbE12N29aTnV5aFJSbDBWc1lRS2FpRjV6NEJYZFlpczNadG15SlRyaTkx?=
 =?utf-8?B?WU1rM3hVTGxvcko4b3UwLzM0VGhnR0toY2RVRS92Zk1CZEtCbFhjejU2M3Rx?=
 =?utf-8?B?WmkxZFdPVWF6K2o3N3lWanFWUUcwNFBhZmdMUk5GQ1N2eHR1YXVuZWwyalJ5?=
 =?utf-8?B?anVNcXJCSTlQOEJ4YW5zc0xHQS85T1pRSEZwZEpBQU52Tmt3ZTh2L3VEUDBr?=
 =?utf-8?B?SUIvY3J5ZHJDcDdlT21mNUVOUVRPNTZ1ZGhLdUlLNmhlMUEvWEZsOGxjR25l?=
 =?utf-8?B?U3FPNitwbXZEcXpCZnJWclNFVjd1RWhrdkplYUVaZURXeG1laytjUVZRanNR?=
 =?utf-8?B?TWtYcCtQVDNrQzVOR29HWVVULys4MTF1UkYwWFBkMklMTUwrcDFTQ2hJcStO?=
 =?utf-8?B?emp1ZE9RMVBka29sb3YyRGVNeERzOURpSTR1dHdCZTRWdTRRcTRkakFxSHRG?=
 =?utf-8?B?VWhuUWNKeVM1WTYwY2x6OGFBZURZWW5Td1dwdHdtR0g0S3lsakV4SXFwWUVW?=
 =?utf-8?B?VUMzejQvVmdFK1RYbnNlY20yWkNiYmsyb3d1NmphdTVpMnZZblBaVDc0N2lS?=
 =?utf-8?B?QWs2eTJhd09wUnJ0WEpVd01IK203dnpkYXArdDBic2FWVkNhSUY2RkNibS8y?=
 =?utf-8?B?L0gvQzFySlN4WDhSL3JHdCs3Njc2SDZpYW1qTXEvM2NzN2FxNDY4Wk1xcWpi?=
 =?utf-8?B?cUJVNDJIaVJ2Nk16SVVkbmc0UTdLNEF4YXN4VFF5NHpjZGJKVTdBNXhlNG8v?=
 =?utf-8?Q?ZBPwtX1sbuqcjamG+mKIEH2EB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d476a383-f01a-4ce1-6e06-08dc47251a66
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 08:26:26.4461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oRZsAHYutDdgh8Q/tD1KlcRcevjhaEOjlYb59fd+9miQjmCP+Fh0wUrra5Se5kR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6836
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



On 3/15/24 20:25, James Hilliard wrote:
> There are situations where we may want to let U-Boot modify the FDT

please use imperative mood.

> nand partitions for the kernel, such as when supporting multiple
> sizes of NAND chips.
> 
> Lets also refactor xilinx common board support to have a
> ft_common_board_setup which gets called by the ft_board_setup for each
> specific board so that we can add non-common functionality to each
> ft_board_setup like FDT_FIXUP_PARTITIONS as needed.
> 
> This pattern is modeled after the one used by tdx-common.c.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   board/xilinx/common/board.c     |  2 +-
>   board/xilinx/common/board.h     |  2 ++
>   board/xilinx/mbv/board.c        |  9 +++++++++
>   board/xilinx/versal-net/board.c |  7 +++++++
>   board/xilinx/versal/board.c     |  7 +++++++
>   board/xilinx/zynq/board.c       | 17 +++++++++++++++++
>   board/xilinx/zynqmp/zynqmp.c    |  7 +++++++
>   board/xilinx/zynqmp_r5/board.c  |  8 ++++++++
>   8 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 9641ed307b..629ba2b902 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -686,7 +686,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   
>   #ifdef CONFIG_OF_BOARD_SETUP
>   #define MAX_RAND_SIZE 8
> -int ft_board_setup(void *blob, struct bd_info *bd)
> +int ft_common_board_setup(void *blob, struct bd_info *bd)
>   {
>   	size_t n = MAX_RAND_SIZE;
>   	struct udevice *dev;
> diff --git a/board/xilinx/common/board.h b/board/xilinx/common/board.h
> index 64d657673e..73f576952a 100644
> --- a/board/xilinx/common/board.h
> +++ b/board/xilinx/common/board.h
> @@ -18,4 +18,6 @@ bool board_detection(void);
>   char *soc_name_decode(void);
>   
>   bool soc_detection(void);
> +
> +int ft_common_board_setup(void *blob, struct bd_info *bd);
>   #endif /* BOARD_XILINX_COMMON_BOARD_H */
> diff --git a/board/xilinx/mbv/board.c b/board/xilinx/mbv/board.c
> index ccf4395d6a..d8af1eaa90 100644
> --- a/board/xilinx/mbv/board.c
> +++ b/board/xilinx/mbv/board.c
> @@ -5,7 +5,16 @@
>    * Michal Simek <michal.simek@amd.com>
>    */
>   
> +#include "../common/board.h"
> +
>   int board_init(void)
>   {
>   	return 0;
>   }
> +
> +#ifdef CONFIG_OF_BOARD_SETUP
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +	return ft_common_board_setup(blob, bd);
> +}
> +#endif

Any reason not to put directly to board/xilinx/common/board.c?
All xilinx boards are kept in sync from user perspective that's why generic 
pieces should be added to common location.


> diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
> index 990ca1650a..bd674e6739 100644
> --- a/board/xilinx/versal-net/board.c
> +++ b/board/xilinx/versal-net/board.c
> @@ -371,3 +371,10 @@ int dram_init(void)
>   void reset_cpu(void)
>   {
>   }
> +
> +#ifdef CONFIG_OF_BOARD_SETUP
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +	return ft_common_board_setup(blob, bd);
> +}
> +#endif
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index 8c2e614ad8..944ef2d822 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -320,3 +320,10 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   		return ENVL_NOWHERE;
>   	}
>   }
> +
> +#ifdef CONFIG_OF_BOARD_SETUP
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +	return ft_common_board_setup(blob, bd);
> +}
> +#endif
> diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
> index 6c36591001..1ca1984c49 100644
> --- a/board/xilinx/zynq/board.c
> +++ b/board/xilinx/zynq/board.c
> @@ -13,10 +13,12 @@
>   #include <env.h>
>   #include <env_internal.h>
>   #include <fdtdec.h>
> +#include <fdt_support.h>
>   #include <fpga.h>
>   #include <malloc.h>
>   #include <memalign.h>
>   #include <mmc.h>
> +#include <mtd_node.h>
>   #include <watchdog.h>
>   #include <wdt.h>
>   #include <zynqpl.h>
> @@ -201,3 +203,18 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   	puts("DFU alt info setting: done\n");
>   }
>   #endif
> +
> +#ifdef CONFIG_OF_BOARD_SETUP
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +#ifdef CONFIG_FDT_FIXUP_PARTITIONS
> +	static const struct node_info nodes[] = {
> +		{ "arm,pl353-nand-r2p1", MTD_DEV_TYPE_NAND, },

Very likely also depends on CONFIG_NAND_ZYNQ. It means pretty much you can move 
this code directly to common/board.c because only Zynq uses this symbol.

Thanks,
Michal
