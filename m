Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FBAC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 14:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 215C78784D;
	Thu, 21 Dec 2023 15:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SLq7oz9A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 823868784F; Thu, 21 Dec 2023 15:17:51 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0496D876C9
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 15:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcOvugh95vV/amzE2F6ZAIb/M+12MQ5IvqUTDV5bmJICdw71yrpDPXtjhNePx+h8wwkXDIPaRJKNSCHzhqDfm9Girxa7D2PLYuwE5oRSedrVecL2NAtvNqzUPg6I63SR4aSU5VWYICwe53q7MtYEPsMM2FXbYav+/ngweEEReMcfflgWZvc2rePgGndFVijALk8XGMGEQClAsn2p9zQQHO4I++IGQUXXntQ3JxUnqVbW54TyfcaXM9sqhY+CWkT7uKnBcvRBQFwUXGXskCw/UYPCocb32GTLOL6AgL0jK8+pz+koLmJGC9PtyjOPW0VUwLe5ni1jGU84N8g+EZJ0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V8LHTfHkbt317TLBELqD6bulYVJ+ISRWsJlreZaDuM=;
 b=MInJRLbkI8zqVYimoYTrSAPw/N4X/8WPVsZ7NUZtsvEcPcc03t1bVaMcW+Ll4/P5oZFlTWLaiHCCqfnCPZahPTFX4cJxuZwsfmi2spp8GVPZpHHYKkmC4jZLFDuwcIYFin3ieC+zZA4fCZr9d6BeB515Q8tQq9v4Oz8Wo98hFdlIUJqPuyXp1sJoF3ua5TSrR+YCDMFl2AO4KOyyttBLAUXR8ZKakvNDPFPHRRO6MWYLG0PcdLOpRiVJS5HZiL3dF0HAHNjmoDr/OkLD9kUSFXdJ663a8MOFc9LZvX1+ip2kLuAu/ADv8hALWbpsWnPyRl3QU9Uj8/YmXx5Lu1lAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6V8LHTfHkbt317TLBELqD6bulYVJ+ISRWsJlreZaDuM=;
 b=SLq7oz9A4dkErfMNyw42Dn6ZXjze/8tp/1yqIK6T5+ElEtq9A1QBIwBbnK9/DJBtoHJMevLzia4WnhMFSwXcX2dLt8TvB4TwdPIa2HMVqu19C3M17Zw6Ar+Lx4by3QqN29zN9zGj8YOfCtyXddABoj4IvWbbMqh1JXSAQv/FR8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 14:17:45 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 14:17:45 +0000
Message-ID: <db848c1f-d7c7-44b4-a591-e800b152d519@amd.com>
Date: Thu, 21 Dec 2023 15:17:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Enable DNS/WGET and BLKMAP for http boot
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
References: <4fa9b425459947e6424c8ce27376fdc7a14bf839.1696592702.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <4fa9b425459947e6424c8ce27376fdc7a14bf839.1696592702.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::24) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: d23fa5f4-40e4-4e9a-91fb-08dc022f9a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdPrIgXTEKWIsQz8jVDstDSEkgPZRZSfRKzdSWSydGy40HZEXSOW8AxiY0Fp92mq0xnXrw3qwOREOyvKEbAIOoTFc7tgTyxo0/zfjAykG6+V9neG2LZwux5baB3yXGdocUox4+Ty0baQzT128rn0F5hkL7OdBR3xWgbqJmu0C0J21CXH8+S7gLuj4hD4RoPPW6bMT1MfsWuxooYa1fej4+/SblZvoSDBnAfBXOwihXJMrQp5OUK6Fgik5vwDWQNiyubQ2eDIXiBawIJZp0VzwMDC3SU3wsG6slLr+N/6oA32Pwu5VDtg8RsXtiBsfN3TJyTbISV1q4UNkOJ8QIP4hYJT2sd4pBuxYu3wGknyBQLpl/eYBwkMoLyU5A+iw+51YnyY1jtQqXOADL1LAnLENgq+XYekIOuB/qIVmV5OPYxCP9i7CzaJl4i6JBVlwi+6Avf7hpJEWo8nfewEW+S1jtlxT6tPKW/Er40YGU5bwLiReaNX3fuMJWc5Jrn3k0gACCLaX2/S5iK93BKlpOPUZJXifAqxHq2BvdS0Flvo8ieIbEd7V5A+I6MKSnt2iX0wHwmON3xapATuJ+2LOp6Xyi01mV00wdU1uGJkkO1chdOnAHQ+r7hjncy6e3FoN0WgW9n1sr3/sbpSP4ERgXM22Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(44832011)(2906002)(66946007)(8936002)(8676002)(5660300002)(66476007)(66556008)(6512007)(6506007)(6666004)(316002)(86362001)(31696002)(26005)(6486002)(41300700001)(53546011)(2616005)(83380400001)(478600001)(966005)(36756003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0k1WFFNYmxHblE2RHcwVW9kVkxaUTg2SG5ITHRvSjIrTTc3RGlZdlYyWDNJ?=
 =?utf-8?B?ajlza096aThhY1NIYURVK0tJVTE1Q3ZuTGdtMHZvWGt6N2JxdkhteVFUYmpj?=
 =?utf-8?B?aFBHcHV3dVlMQWZxTU9DekhHYjY2UDMrbVc1Nnk5enl1eVMyZnlnaXJCTTBt?=
 =?utf-8?B?YzJETncxSVJQNkV5NHh0YzNaN2tjbEhzUEpZK0pBY3djTlQ2a25HaWRjUXdq?=
 =?utf-8?B?UllyaHF3QWNTR1QydGZLTHZ1dndTRXpreGMrbU9nWGtubFdJRlpObGt2aU9z?=
 =?utf-8?B?UkF2THE2SnZlVEM5Zkt6T1h4NEhWbXF2cDM4MWltQWJRT0o0cDk4MmN0RW1k?=
 =?utf-8?B?c3ZzSGcwbERKeFVHMnNHOG1xOU1xbXJ3VzI3dUpRaytWZERaSU5pWkxqSFQ5?=
 =?utf-8?B?RkdWdXdrZVFERjlwSGNlNkJ0ZWN1RjZhYnloaTZ6WVQxVlAvZy9nM094Ymsr?=
 =?utf-8?B?SkF1WWtGb0J5NFlIV2xEbk15dHRiRzJnUVJ5S0g3Tm0xVEVuWG9XVktNNXFB?=
 =?utf-8?B?Vy9tajIzbXM1OGU4ZlNzaDFPRTA3bXFBcjkxYk1tSGlCaEMrN3VUY090YmR0?=
 =?utf-8?B?RWlWdjFQVWQ2ZVFpWk9sTDk1Z1p2cjNyL1lMc2RLUWJUY2FyLzUzbHFHbHh4?=
 =?utf-8?B?aVd1NmwwMmJ6MEJ5R2lNTDdscTUwRVBWb2RKTnNNREdBYWVwQm9pNFRpZG5Q?=
 =?utf-8?B?Y0FQUnh5MTFLR2tEVEF1RUtIMW1pUTBCNDhCb0U4VEM3MG1PSVJpRXZHRURF?=
 =?utf-8?B?akxUWURPTWhETDloMS9idkNDSGhZSWFrRzZDRUdhT3RTTllLdnN1RCs3WVpu?=
 =?utf-8?B?YmJaYVl5KzhDdGtuVzJodWF0VzVCOUNCejY4d201QVprS1ZGaEhtRDZJanRx?=
 =?utf-8?B?YW1tR1VlTkZIVEJER01GY2pocURta3ZsT1Z2b1ZpVzNwc25mNXZvaExsUWE5?=
 =?utf-8?B?WDRNK251RnRNUmZ6T0NyVU1janhKNTJQMVloRmxqQS9Mbm1SaFRFemtqdlZO?=
 =?utf-8?B?cnNtMGI0UWZKL0RpZ283cXZLeTJPdUlaQlBrenlwYUNtRHRQYXo1RWRsZXNy?=
 =?utf-8?B?dUhiUmhUMzlOTjEwelpvYms1Vy83d0Q5Q0p2a2RYQlh2YzlxenpKdlNkdlFq?=
 =?utf-8?B?RnkvbmViTmRKbktPajJXTlJzMVB1WndQQUZ0RndIUnFiTXpaUEJIODNycE9k?=
 =?utf-8?B?NDFkbHVLVW5nT2o2V09CczhOY0I2VmpFYWszdHllOHRrc2pnTzdsU0lqUGxa?=
 =?utf-8?B?RDlMWWJQSExvWTRsd0FhMUNKOG92bHJrY1ZBZGkyRDdVOXIybHlCTUsvUzZr?=
 =?utf-8?B?dHJPUUdvYUFkUktscW4zSVBGM0JxS0FOMUZCR2laL2F1bWQvZWg3VXh5SDRI?=
 =?utf-8?B?UzlndDRqNlhURWUzdDFSbEY4aW02RFRKNjA2MzFuN0tyalBNNWpDa0xodUtD?=
 =?utf-8?B?VWxJVWdjMVF0QnBhalZpQUk3V1Y3eEh3ZEZLTXpSdEpxQ2pjWHdpUFZkWDhP?=
 =?utf-8?B?eTJMMllETVoxcVlORjlyR3hWdVNJYWJWaEF2TU5TcEVSRFp6NTBhdFZQRHZ5?=
 =?utf-8?B?MGhTQ0NCbDFxVy9yTlc5QnNsQS9HY094V1NSeDR5OFVVNUhldjgvUEZDd0Yr?=
 =?utf-8?B?OG1tVXJCa3ZNa2szeS92U0hveTM5WHcxc0Zxd3ZRZll4SUhGNFRCT25wSjh6?=
 =?utf-8?B?YjdGQ3p1UVF5QmJ5SnRUTDd3dUZKMVZ0RkhkbjQyeHZ0MlJwSlJ6VVdDKzY5?=
 =?utf-8?B?ZGxHTGtHRzFiclduaDZkY0NOM3gydzZINWQwVUQvM3ZaSzY5MXV5c0ZNV3hq?=
 =?utf-8?B?NVNYSDNQN1hjQzEvR28reC9Sa0dmc21vS3lxL09UWGhWRGllNWRNSkJzWnBK?=
 =?utf-8?B?UXlEWlNBdjBtbFBYTVdaSkRMNjFBQU1GOFJyYWRsLzREQTVQZU5ST3YyYkQ0?=
 =?utf-8?B?OWRJZW5wRHZnSHcwOXM1NzZRZElpQ1ZtQ0x3MVRCQzlHcEcrZ1IyQU1ic3R3?=
 =?utf-8?B?UEJGc2gvMFNlMG9BZFF2dkJmUGJWYzFEVThnT1hWNDNRck9oQ3ZRVzhDcncy?=
 =?utf-8?B?YVJjYVJmSlp6dlhlWS9HMWtzamlnNG16UUkzVEowYTZTL3cwak5IQWlnYkVV?=
 =?utf-8?Q?ImCala0OOOllHn/c1Cx+XMFVC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23fa5f4-40e4-4e9a-91fb-08dc022f9a0c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 14:17:45.2275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVVrC/qIMqsnD3/bm5kh0aHSVUOEn6z9aYpXZrQYgG6VBiRbbDFqzEZZlwdOxqJh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213
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



On 10/6/23 13:45, Michal Simek wrote:
> Enable DNS/WGET and BLKMAP to be able to download images over HTTP and map
> them.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Can be applied on v5 version of this when this is fixed
> https://lore.kernel.org/all/cc0cff36-359a-4c3b-9ba6-bce0834358bf@amd.com/
> ---
>   configs/xilinx_versal_net_virt_defconfig | 3 +++
>   configs/xilinx_versal_virt_defconfig     | 3 +++
>   configs/xilinx_zynqmp_virt_defconfig     | 4 ++++
>   3 files changed, 10 insertions(+)
> 
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 62322af458d6..c190bf532705 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -46,6 +46,8 @@ CONFIG_CMD_USB=y
>   CONFIG_BOOTP_MAY_FAIL=y
>   CONFIG_BOOTP_BOOTFILESIZE=y
>   CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_WGET=y
> +CONFIG_CMD_DNS=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_TIME=y
> @@ -69,6 +71,7 @@ CONFIG_NETCONSOLE=y
>   CONFIG_IP_DEFRAG=y
>   CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
>   CONFIG_TFTP_BLOCKSIZE=4096
> +CONFIG_BLKMAP=y
>   CONFIG_CLK_VERSAL=y
>   CONFIG_DFU_RAM=y
>   CONFIG_ZYNQ_GPIO=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index 89566c7d52c0..5ee694a4ff73 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -47,6 +47,8 @@ CONFIG_CMD_USB=y
>   CONFIG_BOOTP_MAY_FAIL=y
>   CONFIG_BOOTP_BOOTFILESIZE=y
>   CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_WGET=y
> +CONFIG_CMD_DNS=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_TIME=y
> @@ -71,6 +73,7 @@ CONFIG_NETCONSOLE=y
>   CONFIG_IP_DEFRAG=y
>   CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
>   CONFIG_TFTP_BLOCKSIZE=4096
> +CONFIG_BLKMAP=y
>   CONFIG_CLK_VERSAL=y
>   CONFIG_DFU_TIMEOUT=y
>   CONFIG_DFU_RAM=y
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index 30e420951dad..d1bdea09ebab 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -82,6 +82,8 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_BOOTP_MAY_FAIL=y
>   CONFIG_BOOTP_BOOTFILESIZE=y
>   CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_WGET=y
> +CONFIG_CMD_DNS=y
>   CONFIG_CMD_BMP=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EFIDEBUG=y
> @@ -119,6 +121,8 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SATA=y
>   CONFIG_SCSI_AHCI=y
>   CONFIG_SATA_CEVA=y
> +# CONFIG_SPL_BLK is not set
> +CONFIG_BLKMAP=y
>   CONFIG_BUTTON=y
>   CONFIG_BUTTON_GPIO=y
>   CONFIG_CLK_ZYNQMP=y


Applied.
M
