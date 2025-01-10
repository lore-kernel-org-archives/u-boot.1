Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C62E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 08:44:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99FA8801F5;
	Fri, 10 Jan 2025 09:43:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kekI+EKD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87BE4800C2; Fri, 10 Jan 2025 09:43:57 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E8EF80655
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 09:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyUu8vGns3clL63/VHwyjrYOFMpnrSMIMVzMu5H1CYBL2A8VrZCGrglvezoF3q0WiUHkDJR/t+5EVEpXKw1Se3+1hFEP6TQX/rAWqeGNi3FQaZynY87X3PjptZcl/xGHOn3EZaxGjIlQESCK+Jtsxw7X5HbQ/WXtkAruQP7wF3AFttE70GAYLE8mFsuMr6rOLNna1TwSnfuX3uXj8fYiF0SE4n4JC6ioN+dWC14pXIjMBB/5G3BrGzRj8Uwaon/BDrPH+Mcrhi/d9P/WGEQ6NcG5+dEViBVMZIrvS1cSTidRoOPTl+X0sBcaWtF1WJV8gD6EtdL8bk6aOYrINRdsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpuPpAaEbVey4EsnHZvzhLp+HtBtWuQOZuqX78Dmpjo=;
 b=cTcl7xTB0HuM0jhfuRFhG18WpjtfNNNEnoIwSQEPN3Vhpx5+6DPD+9YiIQ0zUfg2bje1I+UhGIsa+WmQ6FEjqYOFPxGPqf7ErzaN644GoVoGs9sKV7LTl0K4aWF6L9QglurAbL1Yn5yG+kUl6HKQaUlrde17l7z1vw/9NjSqICebszK9yrkBdpLpPqeFtm+qOc1TD4RQu1NWboKcU5EKvNRqA8OpgnbrThIdXikylamuB6fYSXomelXixDk5RXEyOdT4hngqUUYG9zXU5lYtYrR9FRyjxFmcFepmAKcchA029x8QhjHtY46Wn8HpuEPPu9jb2OQbBVDjH/4RAENyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpuPpAaEbVey4EsnHZvzhLp+HtBtWuQOZuqX78Dmpjo=;
 b=kekI+EKD1RS2tfJOfAlFwOP2Xh58qio/kLaMgsFqZQM60HLHhoTjpLltt5/W2jbB1/YPxLiCo4Lc7P1yUH4oqGtZfSSoS5r9NYYEkZmszeMluSjCSxVBB7xo7jIhRuewu88zXq+SnUsA2XHuNGwHjmcDUPz/eFUstiWIQycaNpyM8uRLT4ZH5XSebvGALRFbLZUVqWM7WMX0gaM1fDPOM72bZzC/JT2upOMaSUzjw76PMDCgXUak3g2XuKCT0tcYoFKQ/2T0w736eNlph6fO3KmvFZ/ouv/4bnFQlTEDT1GF4i9oDTImWe7g9wLc+vcFxAS4OjjgbnKrNteFnKdK5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7993.eurprd04.prod.outlook.com (2603:10a6:10:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 08:43:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 08:43:51 +0000
Date: Fri, 10 Jan 2025 17:49:41 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@denx.de>
Cc: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, u-boot@lists.denx.de,
 tharvey@gateworks.com, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 11/17] imx9: scmi: soc: Override h_spl_load_read with
 trampoline buffer
Message-ID: <20250110094941.GA23168@localhost.localdomain>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-11-6744df5dc020@oss.nxp.com>
 <e7f2e938-e6a1-4927-91d7-682ca9d683f9@denx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f2e938-e6a1-4927-91d7-682ca9d683f9@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b789dcc-9c23-4f3a-15e0-08dd3152e866
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ip2LVAWzYKxsgRR0CQbnWX9nJJkvGWLNaq6+G28jJ13Cz62vQeIpyWKB8emD?=
 =?us-ascii?Q?BJ0ey5SqVirlIrsWLomG3fIVyByL61xlfVuP+cJgVOI2ZjUHF1h7wPaTa/cG?=
 =?us-ascii?Q?TOgrNA9wiSJO/65gyZTpkggHbWAwlAqVTmu5NxzEGT40AyXDdI1oe9APccYa?=
 =?us-ascii?Q?QltQcNMtqOxBBwU/OoD/YWvYO+MFJMVqLdE/eOcUUtlJviEUPm4gQUs5x133?=
 =?us-ascii?Q?s+PI2cykxAF7qT0/40Dm7vH9tifEE5KL5uQl7D4rx+SBnXU5Jk6ur12j0LIm?=
 =?us-ascii?Q?Jng3JxGVd7kxUFAcHFE8LSnXj122uGflTpYMab0xMdPd08AtTwtxyDL1CdOP?=
 =?us-ascii?Q?KTSnnJTjZKeJPFR5/HHoanFLj/wFZiBhxICL+dlx9b2c/3cKbfNggUT1NIeS?=
 =?us-ascii?Q?8brU3Z3Y0QL71DCGpI79hm8mGoL7IDqsrxsnQjPvR/CBEJEuXoG2KYE0Etxy?=
 =?us-ascii?Q?M2vvlsscm30KE1yF0iYjzVwk8+Et2IEESnMkjLk7lWXl1X9Fqaqct38O849r?=
 =?us-ascii?Q?+BtA8CLENgUwGXI8/+32LNFQccS3IxqrcRp/1fvr0wphN84J36HnaSlcVobc?=
 =?us-ascii?Q?+VqE9LQTh53XawkDbQHBpfN3vbvtX6tdR74C/7LpEZj9iD5DSbz6fVZtUw+n?=
 =?us-ascii?Q?HnnDhEFhlr0TBoKWQZZF9bPm9AGMHy7rnlXK4mefmV6U9Ba1oOP6xA5Dbpbl?=
 =?us-ascii?Q?8Zb8pDk0e/PQ1eV8AMgqMzwEEeLZafH31AcqhwnpWSL0bR6IvT/f6mpgWmPg?=
 =?us-ascii?Q?/E5+Hn7sABFdEPleMvXg0E8CmpfT8FJCcQ6FQCf3KVYmZEweHS35UcB8f2l2?=
 =?us-ascii?Q?DfVkMPZCAd7aRSzkzVZzcIrOr9IHt/IUWpROHciyb3ZcYtHZh5YLB2jJCQCT?=
 =?us-ascii?Q?gvnixokMP2aFyMp8mZD25+bNQXXKDofz1qsaiLeFoak67E5XTnrp8jOlF7JT?=
 =?us-ascii?Q?su61EQAZ+XSQtok73UbIHSLgLvjxF4RZ3vUqJJqTOlIicv/C1x4m4/k9p2cd?=
 =?us-ascii?Q?EJosEMPNPMFbqGtG2p8Q4oRfXsVW1j4Z1uxeh23rKbY7kE3CUgsdWnncl5AS?=
 =?us-ascii?Q?sqooOa8Vfa7r+O0vyQsWfZIr0iBb/70n2FQRG1EkdUUCi4kJnz4lxFBpk1uB?=
 =?us-ascii?Q?6Gz6L1QxDaz9x1pcWRsvMcVl3IlsrePi/A1y0otGWgAir1zzL34C7rmgpONV?=
 =?us-ascii?Q?/4ZbqUSUQPPD1Pr48+ENgBQjaKIJkKfj2+Z13lQQsO6MpHYlcl7Sm2gVpDwO?=
 =?us-ascii?Q?wrvP2Id5/rhWLHv25M5/o4twOpRgUst1Mh45Is0hPisupaSBfXVqm6EYChsZ?=
 =?us-ascii?Q?0vMVMPPYNIWn+WfCl5KIl7uB8MlHA2hpQhcyvodmGXevMlTDCf203JFyJiti?=
 =?us-ascii?Q?2c3edfg+/fUiYS1fdGXwNI/ijng2XYaaPsYHrRN0pE3gRsfuPmLaOlXQkyiA?=
 =?us-ascii?Q?d8eg3+fFWT6z+Au5cb30ytrnb5lRoI5j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l0RsGbIMjaQtqZpS3R3Xt470PanNQpImtnl+HCwLl7o1edGeMexjhra3t1IW?=
 =?us-ascii?Q?Sa1ww+QSSK3Y1aItaqL48/tvH1U/xTI8or19k38vPLzv5MiNNQyspRpFndyb?=
 =?us-ascii?Q?sMU5AReek+G9e+L06g1UPb6MtXYHLHBHJdFJV9z6ORw4pgpL1HAJzlQlZ2wb?=
 =?us-ascii?Q?JLpQ43UsFL86P2gIWQG5aeKjeEiXLv/wuqKhlMGwfJVgk8lUfA0VbBKfaRs8?=
 =?us-ascii?Q?jgCAHrly2VtAzr5VYLULSCaoZZAffXDYgGGa3VmjAymnm26Pd/KluVliSxyz?=
 =?us-ascii?Q?84OoT8nS4n4dkg9Y6lQ+v3BZ3ewLNBTTypmgNI49GHYg0+XbKjeb6gNM4gqA?=
 =?us-ascii?Q?PZ88rKW22JRyalxpSoCXItKdORlVOa4uvqNGjRObCTzii/GUNaCOkNfHHjOh?=
 =?us-ascii?Q?RiEe6pGKc8VC6dv7tBkQV32mQa5iOI9v2mDMVzuH4m9lRaWOWssrGSG6uEoe?=
 =?us-ascii?Q?vDdINkO9ZkU3MXB7jIgaNprCztdHG87KrayK/r3XpG1/l52lUhZnhyXq5SRP?=
 =?us-ascii?Q?8/hrbwy7dqLlfOLcnu8WzscTIC7L61swCebHXhh2JrUSeWpYacmI+zWZeLsG?=
 =?us-ascii?Q?h2X9SfrZRfPEBKCzDtkLrZN465LwptJi5KGe65UiYue5NVRBPlu45DvWdBnI?=
 =?us-ascii?Q?SDpS9i59s1kqXDH84DQ1sd3NbMQcexJ9RJxYl2yZTUUGQEd8I/uou/FY2cNO?=
 =?us-ascii?Q?7eGtBSOm4hre7cds7c30bR8Mv27kohwPSu/5hl+X0hXR4ERK730xzLiW6r46?=
 =?us-ascii?Q?oj5m6M7FG1PBJaF6dHUpsjvQS2056AuVLaHg45wO1XlEhlZFTVAegBfGyQpI?=
 =?us-ascii?Q?/QYdcdYRW5d2d3o6TBawoAmLs/V6cfj7g8lfK8l/yjcPUPrMqZwKeKY35fjR?=
 =?us-ascii?Q?iqoZFkTRORCLqD3yP55v6CkMQ0HoyDd3lhSTnbQ7Rk8Ydlf6mtqXGjSDanN0?=
 =?us-ascii?Q?wdzzMJWDvWZlHaJdH7QWs5hMZDMYZFNH5g6eUbhOuDZRYFj++fQKUW+4SThA?=
 =?us-ascii?Q?5/WoIZV8Y8okPB3lvl/Pz4N6s5FBEQmn3+apItdd8c4JHRqivVCB1fFlcwa8?=
 =?us-ascii?Q?UowrfAtwDruhzxljrWU7pAKsgbBCHYxZU730+M24jTYbFXxojYjlezivCI4z?=
 =?us-ascii?Q?T2wMLKRf15aV7SPUtr7nL84nyKc/QaXfGlG279ghcZbsQJwADdE+kZ6HAfKo?=
 =?us-ascii?Q?7it5M4OOkb7g27ungzZ88s4AuHUYnMFb9evmcOvoesNfOPqJDf7LSiCXuYn5?=
 =?us-ascii?Q?yhLatWXLphSQjSvP5at1OiRKmEDadeM/Ic5zaZ6/9X/Cn+pfmXol+kuwGVfJ?=
 =?us-ascii?Q?BPwQcmPmMMTBImMmTVFrPPnAGY+/KA0GQxAFDaxxzgo9QBTzAOn5O3e8809B?=
 =?us-ascii?Q?bTiz9IJqUL9BmE0norqtIpgvsu4GKUvzi30XBoRQN3a9jjGj8BDDrUBSw6ie?=
 =?us-ascii?Q?kPB4k3DuxnhWgVQBK1vXK10Jm3ijHu/z+kllvn5OQK3I/TF7Ab5yZrs6WzQQ?=
 =?us-ascii?Q?zYUYsSZr/9ckEj2P4arPYEiBscUypLMRIgn5DCe85tT3sE27Knwap8Vx7tP0?=
 =?us-ascii?Q?b2PSH6bhcyEnpF7hLZoYgvtlUQzBKQvMb6fnjL5/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b789dcc-9c23-4f3a-15e0-08dd3152e866
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 08:43:51.5498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: og0cYy/dKkHOsqYTkiVccSQOJqTN6Y1x7orYEmpoUFkm3uiMGnK6b4sDdSR2pHxxPq/M2grTfCp5QpraQEFjOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7993
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

On Sun, Jan 05, 2025 at 10:56:29PM +0100, Marek Vasut wrote:
>On 1/3/25 7:45 AM, Alice Guo wrote:
>> From: Ye Li <ye.li@nxp.com>
>> 
>> When SPL loading image to secure region, for example, ATF and tee to
>> DDR secure region. Because the USDHC controller is non-secure master,
>> it can't access this region and will cause loading issue.
>> 
>> So override h_spl_load_read to use a trampoline buffer in nonsecure
>> region, then use CPU to copy the image from trampoline buffer to
>> destination secure region.
>> 
>> Signed-off-by: Ye Li <ye.li@nxp.com>
>> Signed-off-by: Alice Guo <alice.guo@nxp.com>
>> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   arch/arm/mach-imx/imx9/scmi/soc.c | 40 +++++++++++++++++++++++++++++++++++++++
>>   common/spl/spl_mmc.c              |  2 +-
>>   2 files changed, 41 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
>> index fefb1a6f4ca58722a5d93c39e4f6a7aaf85aa177..8a7df24afecc1d6d77b7162be639b56af95fd975 100644
>> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
>> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
>> @@ -41,6 +41,8 @@
>>   #include <scmi_agent.h>
>>   #include <scmi_protocols.h>
>>   #endif
>> +#include <spl.h>
>> +#include <mmc.h>
>>   DECLARE_GLOBAL_DATA_PTR;
>> @@ -830,3 +832,41 @@ enum boot_device get_boot_device(void)
>>   	return boot_dev;
>>   }
>>   #endif
>> +
>> +ulong h_spl_load_read(struct spl_load_info *load, ulong off,
>> +		      ulong size, void *buf)
>
>Can you simply define spl_get_load_buffer() instead to make sure SPL loads
>your stuff into the correct location ?

spl_get_load_buffer does not help here, unless do a big change to spl_mmc.c
h_spl_load_read is set to info->read, info->read is not just for reading
headers, it also needs to read container image data.

>
>This hack in generic code is a NAK.

This is set it as __weak, and overwrite in soc code, there are many
similar code

Regards,
Peng
