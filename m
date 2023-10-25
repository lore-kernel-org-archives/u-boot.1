Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B646AC0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 07:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E748286FE2;
	Wed, 25 Oct 2023 09:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t+qEHb8p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60DE687A2A; Wed, 25 Oct 2023 09:29:27 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13C3586FA7
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 09:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehU+I/64tP39Z+0DQM4IxZa0MyVoMG/Uuw5z0zEt0WJSMrCCY9sErkLB/54nznP3OOAsL5kSlNT8gzmFNtUzmaZQPbt1AUqebkPbviZazZLuZWw/DbxHQdPfndou/bUO4pwsZxlKKIjzFjBolRPzP08+7qo8Z3MzwUSxJ6nVdYIbOYbQSHmXPJ1Mk5QZLFyML5+A6bv6sM4TA6ZdvjUGInPBJ6CzI7Fiqyzy8nXtflcWHQXPDqd6gmvY9JuUAZ+cAV1Mz1rV25C9LnZUF+ONYC9c28/MRq4ZLl/9q95e+9UUS99XWsuMRxZEInG0EgOI3r6F9IslH4fqaANrlt11RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhxyuJgsPBRSdU5NojGZFKKhe2OduCgyFw51eeso/Hs=;
 b=OFWlGIpnpYsSR5m89q86yoJs34qfgYcYQ5ys3hjQhoS4pS8drpxCPr5awWIMmIyTcM+3NA9Po18wbVq+WtvYh8KLx/LcAWydkocfGThZUbnsda5ro4CLiWCOHhKBAVM6isaS9Sx9lGcAKVD7Djhopx+6FY0+UbKEw71Sqz5EkCNeVLd+h8DTQVLMLARqAQtiD9i9pOnxWOHpupCLahEIWWcCfzpRGGkn5K6rIoVPcFBnHeFjIFA07JER0rJ55VB691bEaH2/J0kjEAgMJOOippclsMGvI55eU/YiKV8W3aAOvyMAWFX95iclH1rqbUWOrsu1+4WUNfvXRO8sJ4sScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhxyuJgsPBRSdU5NojGZFKKhe2OduCgyFw51eeso/Hs=;
 b=t+qEHb8pKw5O8HGE1qXipptn0YJEHL6Fen3ryRCbw7ZNxEZ43Z1KtOLMgPzF+qfVzknrfyhebsTfiw1vg7Dpmo0x6tAEbyStUoiD5wWntOrJzOHcfCy5xeuhKiQu1TIPxJjUnkCxHWFDwbT9W4XYTXVU3NArPjd1SysQ6UcQN0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 07:29:18 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::8d67:59bd:9a19:5323]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::8d67:59bd:9a19:5323%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 07:29:18 +0000
Message-ID: <cc22d995-1234-477c-bd0f-6ca1946103ff@amd.com>
Date: Wed, 25 Oct 2023 09:29:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] cmd: add scmi command for SCMI firmware
Content-Language: en-US
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, trini@konsulko.com,
 sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 Etienne Carriere <etienne.carriere@foss.st.com>
References: <20231025051427.509602-1-takahiro.akashi@linaro.org>
 <20231025051427.509602-4-takahiro.akashi@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231025051427.509602-4-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:802:2::18) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: b4997091-9b09-46d7-7e56-08dbd52c18a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGj/Jy8Qgh4oBkUqyAwosaNevatDVhgT70arStxpLBkcczUczPu4d5d4UU/h+WNhUBB0bkW1z7EVnd9Q86s3zoHJF3gZpHahmQPwmirbLOH2od2cfQoa+FEOocDiQwxcjpWCTWR5olsDPkI6kwsSmAnsZduXDBA49ylwcKSWZW2dG0vm23IYlexoriCt9VvJl51dDwkn8J+BmxaVbeQSGyx68ldAFJydrQDgk92fNljVEXVmJ8hwEsdqegT7eP1z0rTh9on8mMcDA2ENB732XCjkhFullPzewrs378d/hoKuDTWNEOHjvAGYWQkYE4Q5SVU6Zqlrl4UGLdJsnx6ub8HOl+6ftXVCOuluXRERoYCFAIoMSEhfe0Glg6m1hTQNXIEwSPVHizcvZgwO4yPOa76FNMw01UHmNFUy878aG0LB8Q89KSjDWg7DG5jrpzpnHSosCZtkKC+YmT6/ie3EzMR8s0e/LE14FugYeZEKk+b5pHZZJhpLmv90wEGP9AwX/bHKXnDRrTlu9ckV0YRiWkGjuj1+SFeJ/63ItWl7eNn4ARFK9HgnRbSTvgM0cCfkJKD8D5+NkFT0DA17SJc+uQCm9QEMmeh8dlSHxS0Nu1lZW8Jz5UhBEn/XUguhGlmmqWmlvf1AGPIM73ky7XMfoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(31686004)(2906002)(31696002)(36756003)(5660300002)(86362001)(41300700001)(8936002)(4326008)(8676002)(478600001)(2616005)(6666004)(6506007)(53546011)(38100700002)(316002)(66946007)(66476007)(44832011)(66556008)(83380400001)(6512007)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3RHcURyNzJRMzUzbVZ1cmpwNzRHczlSUUgrbHdGTFh4WXdkU0M2UWpFUVdn?=
 =?utf-8?B?WGpVS1g5bHJJMWUwSnlNRlRaTU9DSG1LTUhsejhQWkQ1aWs5WVdZQUtSR1V5?=
 =?utf-8?B?SGNpa3FodFo3c2FFTEh3a0d0TitDL2RicDBLaXJCSFYrWHR4VXZ5Q2hkeGNL?=
 =?utf-8?B?ZGd2cCs3dmJKa1FnQlFtb0ZjaHQzQU1rVlRSbEdWWnBNV2R4Y0V6N3NSazJw?=
 =?utf-8?B?K1gwUVlZU1FhSFJMTkFoVUFlQ2ozY21BTVdhYTN0eWpNdWVRcnlWVmRyL2t0?=
 =?utf-8?B?WFl0WWR3ckg5amthVURJTkhoOWEvclcybjdkbnB5S3E3YVhUazZqaHhaTVRs?=
 =?utf-8?B?UzVreTZPVTI5OEtJYUVKM2dxQXlJY3BqSWc5QTJWeFdxVlFuS3NXWDZncFZE?=
 =?utf-8?B?cHhWQU9abEs3bGRBUEhFMU1ZNE9iaDJWKzc0YTZIaC9uT25HWHQ3WE1ScUsv?=
 =?utf-8?B?L0VrN1hZZ3JaTVRGTzVuN2lCV1ltRTRDb3g4RUg2bksvZ25HTHZNNnVCcCtI?=
 =?utf-8?B?L3VlRWdYRHdybVlyNmVJUnYremFTbWJ2MVdvWEpMRWFQdXJ4OHlJQXNMZjND?=
 =?utf-8?B?TDVpU1FaV3hEeVkxaHJtbHpRYUpqazIxbEpISFdQSlZleGRrdFRIOHhZZzFL?=
 =?utf-8?B?R1ZFdkNnd29sZ0lCVXVVVVp0SStVVVErVy8rRmtLL2ZIWnJEcmh3UHZFemtv?=
 =?utf-8?B?aHl4TUt5cGwyakF2ZitaU095OWVRMlNic3RvcUNaajMyQ1MzdGNzN3hJN29R?=
 =?utf-8?B?SDIwd3Z3eVB4UmYrMzFpYUIvYllpVFZJd1RUTXRPS1dETUhNbTNRQ2R1N21E?=
 =?utf-8?B?b1JiZ2ZTaGZmUlRnKzJFU1Juei8rVStYV1hEdzNhSk5ZZTRMMFYrajgwaThC?=
 =?utf-8?B?elh4aFZpczR2RjJqeWZhTmU3TnVPVHV5WE80cCtZRHV4OGlOMlhMc3B5Visr?=
 =?utf-8?B?UHVBSHUwM0NISjZ2SHREeUdSdHNTLzBzZTBPSitaaDZRdmFwZzRkbjQ5RDVZ?=
 =?utf-8?B?WlpPbkFoNHdoZ09GdGNHS0tlT2RISUxKekpLSmdiSFJTN092d2ExM3M2RDZE?=
 =?utf-8?B?T3pFcGRKQXFicDVzOEhCSEN2NnMreVRrRVg0NXVHQ1lOM3VGOGhYOU8rRWlE?=
 =?utf-8?B?R0FZcWxwbllWMmt5MkNCQzR2ZVp4TFBNbmlxV3NkQkdWT1VjbEx3TjFad05z?=
 =?utf-8?B?U0pBUjRKc1VMbjFRenFxcXFoek41Qnlob3dySk9UMHlvSXlBaDBEdHlJV1g1?=
 =?utf-8?B?dVBBcWo0QjN5b0t4OStkWS9tVWNPQ3JBQm5PRVZnZ20vMVRyUWFpblVxTlRm?=
 =?utf-8?B?MUh6cnl1M1JuWnM3UG5lWFdWb2RQQ2pKNmNxZW8yRHBVanJGaG5nd1phMnhh?=
 =?utf-8?B?V3NJOXJpVS8yajZSN0JCUmZSQThYRmMrZlE0YjVpVTFqa3E5YXYvTTFDb2R5?=
 =?utf-8?B?UklONVJMcE9qQjVkM1BFaXEySU5wWXUyZ3l0azBtZ1c2VmVSeVo5YWgwcGI2?=
 =?utf-8?B?elVpOHAzakRDQ01pSkZEU056YnhzcGVOOEtBZ1RKNnkwZU14Z1VXV1k2eFZq?=
 =?utf-8?B?Ry81amcrdk5TVFVJMmdhejBvclZ2ZUlpZ3BJN2NQUDFkdFlXYndhWitqSXJN?=
 =?utf-8?B?NEl2K3V1UUZzaWo1NVZZVGo5ekdFT3RWTW5jNHlMZm8rY2QrV3hlSXJIZVFv?=
 =?utf-8?B?c1VQR2hsOURHT0NKZGJYckM5eTRBbVlaVERDRnJlL2tZNWxHNjVJazBYS1pT?=
 =?utf-8?B?MSt2c0NMZ1NZSm5OZGFHb3o5VnZVTEtXd09tWWkwY0lrRzF3M1BHYnNBTXQ4?=
 =?utf-8?B?REhxNjMvbDZ1UnBUR04zL1R3c2JXcTFzR3VTbEtEcEt5WHVjZ1B3Q2c3ZXJt?=
 =?utf-8?B?QmV3ckdyTVJmRnR6Z2xpVDNmd29oUytoQ0hiczJvcThqbDVhYlpCUm5Fcm81?=
 =?utf-8?B?SWJNSzFZeFFPUHYzamtNM212SnI5USsxSTRRZTNyOEpXeDBMc0dOaXUxU24w?=
 =?utf-8?B?NitWOGdiRUhLQUQ2RzBoaWg4RmlFclNKNHJybEJITmZFVjRhZWQzYTR0bHVz?=
 =?utf-8?B?T2R0OHh4ODg3STVqQUhZVVh3ZEJDMFJwaUY0aDdnUkJRdElBS1I5akYvb3Br?=
 =?utf-8?Q?80sCHcPelTtIFK+5jNtwCg8XL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4997091-9b09-46d7-7e56-08dbd52c18a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:29:17.2973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4crDfrxih7XrSsDkC1rDOTMds5lCz0H0Ky7t0dtA7XlH6NJF3NmLKu8UgvQqQzvP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428
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



On 10/25/23 07:14, AKASHI Takahiro wrote:
> This command, "scmi", may provide a command line interface to various SCMI
> protocols. It supports at least initially SCMI base protocol and is
> intended mainly for debug purpose.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
> v3
> * describe that arguments are in hex at a help message
> * modify the code for dynamically allocated agent names
> v2
> * remove sub command category, 'scmi base', for simplicity
> ---
>   cmd/Kconfig  |   9 ++
>   cmd/Makefile |   1 +
>   cmd/scmi.c   | 335 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 345 insertions(+)
>   create mode 100644 cmd/scmi.c
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 205df2f1fb65..c940051eba91 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2550,6 +2550,15 @@ config CMD_CROS_EC
>   	  a number of sub-commands for performing EC tasks such as
>   	  updating its flash, accessing a small saved context area
>   	  and talking to the I2C bus behind the EC (if there is one).
> +
> +config CMD_SCMI
> +	bool "Enable scmi command"
> +	depends on SCMI_FIRMWARE
> +	default n

As I said in previous email. default n should be removed.
It is default option.

You can take a look at least on this commit.

commit b4c2c151b14b59a2403675526adf666710cade67
Author:     Michal Simek <michal.simek@amd.com>
AuthorDate: Fri Aug 27 08:48:10 2021 +0200
Commit:     Tom Rini <trini@konsulko.com>
CommitDate: Tue Aug 31 17:47:49 2021 -0400

     Kconfig: Remove all default n/no options

     default n/no doesn't need to be specified. It is default option anyway.

     Signed-off-by: Michal Simek <michal.simek@xilinx.com>
     [trini: Rework FSP_USE_UPD portion]
     Signed-off-by: Tom Rini <trini@konsulko.com>

I have also sent one more resync patch and CC you there too.

Thanks,
Michal




