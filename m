Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B1ACDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B00C87220;
	Thu, 19 Oct 2023 12:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t03xwuRu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BED6487224; Thu, 19 Oct 2023 12:31:42 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A116786F8B
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWba4tPgFDYd7ymgNJMJi3TPHr78rYEPc7EBhuExhsaJm40svZU8zP4s6ckuq4VGblIfXhbr+LLO4hYxc6m7IH4ZK7OlH0lb0TMoqFUfIaQ/gU2O+rtTf1P27BpLwLJgi+KGkfg9sbWRGAdQ/yk/KoHdFUBz6VqusJHIFTOl4orE8uGolXQPOBwZVYrbRklrK7tpfRetyKYjd1+gyELBrGTd0KDGD6AfJTpvyli6bgTbozkUyjnKT6zq+lZpYCTdOxPGBWfuOQ+VLPg3pVSLB3bUR0XEIKZE3S8iEy2ipZlhOGrX5/mNQEugHLsv4jDQIJ9LKUyd64JgBqYEJyl9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhNcLemENHcJvdf17ThdxgnXwjym/C2rfiDWI2zGefE=;
 b=PerP14ro9mSiWNTAjRp4K6qPH3Sgc13vMABT3wjQRfKrGMt/VZS7w2dRJvGVOUTewCBCHA6M7HZmhc3t7igqa32TtYZJz8cX129ZCibESKkotoGHMvLXMRvQAGmrka3gEs04UWHuyFQIQ1QhQ41Z6I9+K06hqWuEtSmIlXzSgyHggO70R4ZCq755y6DCVLlvY6MHqJQSSxK5C8NogtrjrCR1iQ/T/TfWclwGn6LZtTQ/mkRAuWIovL4+dzhbGQ92BfQXuxBpLyPfrtXs4/17aAh6onibmr7oDjAVB+miLwpbOiSX+0vDhNS7J8LNoLiGTMhJ5hayClY9F7Ab/P1hIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhNcLemENHcJvdf17ThdxgnXwjym/C2rfiDWI2zGefE=;
 b=t03xwuRu96XUZCjlP5iQSDjIvaqXujbrGMVp0RffLxv56a9Tn5SpBMYkHQTDFdIDkFhjGKuncnGPcM4EXuxg3o0cExTFxpJhSPKl+YLKiyIdhRY36ovesBPV69FyrdaqJF5bG9V43coXZGgARd/w/oNjqtDOVvQQgO6mh3/NjDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 10:31:37 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 10:31:37 +0000
Message-ID: <55a7b57b-ac79-4656-9129-088bebc92df0@amd.com>
Date: Thu, 19 Oct 2023 12:31:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: zynq: Disable the config
 CONFIG_SPI_FLASH_USE_4K_SECTORS
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <8e5c2bf3b7e5f366c4e261e8055ea254bda53aa9.1697117993.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <8e5c2bf3b7e5f366c4e261e8055ea254bda53aa9.1697117993.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0066.eurprd03.prod.outlook.com
 (2603:10a6:803:50::37) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a10821b-691a-4930-808f-08dbd08e92c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLfWcttOaeOnxNFJe3pXwOAvHijlTDq+4mTWFwx+znXU4UuFyPvBEe2dcnB6gOU4p7DCe9l9ehlPh/acxf+HbxkCiAI3pqTjC5HuoT76fUlwk602MmVSnh0JtOZAbpl+qPBeFhdsebbwBVPc7LHPyuWjJbaewE3Mu2S0xD16A6jdAMSwPheAKGZqbkog8+DrJTE9DsKVTDQVi6lFVOilwxgGcDesLIeapDIi9IZ27VAQOLLTJBn06g7zQsc9v0Z26f4g5qRO0Exh/eATs82/Pa3CDr7cR2rMU3pIl8VxsxWv6Euae2V/tKdyQt3tLLn0E/nNJQ6DfIuRjhT3c/nxGthnsJPjBl5ZWsPJXBVx/qINpKkZJuz/K25u8dQXylD6Ay8tH4AysPfiRE73A/gg+SXkqLcJsTqwQRXL7rBOtNR8oQ3e4dq3tYA4QmhPGWD6iM8rGl1UD0LuTFROCNw86LB4YDvSQnXV9TRPpbtCHhysdM0/D26aawt9gddhxBnWQJpOfnLY9knMMD+3ZDXXbEQTSDhS0l1tdox3H9iuHsbzsiEFAcY64VD1YDkdQTItwOkaREuqA4+GvEGObQ+pIQoTYFg+/E1L+PDX/3zO64R7JOu+7CpdBdCDy5QSdaEQM3DeqXvW/j4JDAE9+LQdNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(4744005)(36756003)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(316002)(8936002)(2906002)(8676002)(31696002)(86362001)(66946007)(31686004)(83380400001)(38100700002)(478600001)(6666004)(6512007)(53546011)(6506007)(2616005)(26005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1BDYmR0M1RFS1BIOG81UlVNV2RKRTBneFRud0RCbDBpM2hmb0dMRjR0ajNm?=
 =?utf-8?B?OW5uNFN3R1BPVEVKamxnMmVSM1ZnNlRrUWZKWGVsUlNRaE9VcXg2bUwxVnZw?=
 =?utf-8?B?Y0RkNmZhVktlMFBnbmZtbDlYaWc4OGJVM1V1MytKakZjYzZjTlhoR0tmWXpk?=
 =?utf-8?B?M1pLR1J1VTdWRFZmRXdRbVFsV1hZNEJ5ZHh0dU5sMHBXVDB3U2VBQ2QwUzJM?=
 =?utf-8?B?b0ZzWWlrcTJSVGwxZ2RUQVJ3S256c0Q1ZS96ekJDUGlib2RJUkp2U2FxcEVm?=
 =?utf-8?B?aHowRmRpY2tmRHhuUytocFNSMlAyKzVKQWQvK1EwU291by9LcmR4WUw4bnlG?=
 =?utf-8?B?SFozY3VFNXFyb29ZTWdXdlhEMUxIcVl4aDRNeVRsNXNNcjJaeTlvdmwwQzI0?=
 =?utf-8?B?cDJSUWVZNzEzbEROT1hWUFpoa00zVmh0alZheE8rbkFCZzBjZTBuZ1luSlZP?=
 =?utf-8?B?R2lKNmNYalFFUlpuTG5RUWVxemhFMWFZb3I1dDAzcTJTWWJ5ZEdLN2FzNnBp?=
 =?utf-8?B?VnlXNWczSHhHVjVmVlNaVzlRWjNYY1hhNDBhU0FYWDJtSXhzcjFaY2lsYjRJ?=
 =?utf-8?B?VHhtT2p0VDNGb05sNjVMbEwydGVpWkNBcFBqZWtOK25TS1J3T3lDUmpYR0o3?=
 =?utf-8?B?am9ZN1NrNFRRWEZ5aVFHdGtXMlBTRTRyODlMaE9rd0k5VXhqZlRiVXVqQksw?=
 =?utf-8?B?MFZwUnVtUlBrOW8wWlV0YnF3dHFKa0xQSnNCVmY5bFdEVU13eUxHMW5HUGJG?=
 =?utf-8?B?QWtFOE05dHRaRFdLQUJXeW9JcEMrVlZHbkdENkFmMmZJTFZLSU5aTDZScHZt?=
 =?utf-8?B?NnVrVXVrZ3lNbkgrSnZSTmc3dEJ3TWx2WW5UR0w5OERpbG0ra3N6QTNsUzda?=
 =?utf-8?B?WndCcHY5U1cybzZES3VaM3ZHRUExTXVnTkZLVXZpajJTcmRSYmJmR1h0R081?=
 =?utf-8?B?ZVFPbEYzdkVQZ3doajluVUZNWUp6c253cXBRa2k3MUp0RnNUZlUyVW9DSXg4?=
 =?utf-8?B?YXovSE1kL0RkYmpYVE5TakZrNVBaMUMvNEF3ZnpEbkM0aWhEN3o2dVljMWU5?=
 =?utf-8?B?dnNoS1RGbCs5Nnk2Zy8rQmc2SndQMzgwbS9GbGlyMzlTRDZsNERrbno0V1pC?=
 =?utf-8?B?dlhOMHBxQkdnbENJUDFMcTlaSmlSVFlCU1M1akZTRi9HSXNaYkFIcUpBT2Q1?=
 =?utf-8?B?ajUvYUgzQ1Vsc1dObkVIdkpQV3M1b3UwaTl0UGJoTUhkc3FPMUVPYnV0NlpL?=
 =?utf-8?B?SkEvOStxVDRZdjVvRlkxaytKaGdsaGVHMWNZaUhKZTZEMFVHZVZmNTdrYS9z?=
 =?utf-8?B?NGplSkpqekFxQ3M5eGlnQk1ySWpiR2doUEQrdjlqVVc5ajcrWXE3VWdGN004?=
 =?utf-8?B?cDByd0cxekMwSElzbmdMcTIvMENYWjgwcUFCOGpIb3AzTGlPdkc3WGc0MTk5?=
 =?utf-8?B?NmcvUDJPcnMrKzB2eEdJbERMOGk3Z1pyanZoL1QwNmdRVy8wY2hLTVVmVW9r?=
 =?utf-8?B?TDJ6T3NwRzVYVmVDZ2U4U1ZwSkprdmRoRUdmQzFwZEV1OVlzTVNFUDZjL0l2?=
 =?utf-8?B?c2Eva3E4YU1LTytDY2drNE5wZW9tUVI1N0pWemE4d1pqYkJ0ZWxlYjlxN0U3?=
 =?utf-8?B?N1BSbU9BTEdWVU50aDYwM0lUTFN6TjJzL3IxSmVNdE5GajNURXBaZEg3OEJi?=
 =?utf-8?B?MVpJdjI0Rm5TWFJxdkRoM0JWZllQdjU4L0lSdTVaa3pWTVF3RXoxV2htSkQv?=
 =?utf-8?B?UG9jekFkamFGbGxZZzVKdjZsT3N4SU1haVFIcUdFRE12eUlvLzZOeDJUbElD?=
 =?utf-8?B?LzRDUzhWV2diVUhJREdUZTNNZUx0RldQVGtXTlF6dURkaTVtUmtKNVZmb0s2?=
 =?utf-8?B?L3VIWENxTGVlSWcwdzBsYkJJRWZqM2tzUXV3bzE1ZkxtRjRwVjdzcVdKbXdT?=
 =?utf-8?B?UWVnWW9rT2ZUd2NhclpYanpVSXVDMFQzSTJyanp1QVBWWThXVVl1Z2lTdHUv?=
 =?utf-8?B?SmQrYjNoTHZmUVk1Z3M3R2ZoOGJodW5WY3AxaFgxdjRESnZWQXZaMDc1NVRE?=
 =?utf-8?B?MmR0TXJ1VGpjSWdxNm5XTlUyZUZSMEZUUlZ0azdpY0NaWGdQWjk1ZXRpMkpz?=
 =?utf-8?Q?VwDVUzIcvFEgCPNBqI/ivg88g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a10821b-691a-4930-808f-08dbd08e92c2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:31:37.1642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIWWnFLoylCHxNWG0cCCtnWeag9wt4nnQ27Dyt4DxWDSOqSAyCsxvexGJ5OJSLzn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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



On 10/12/23 15:39, Michal Simek wrote:
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> 
> Lock size for the flashes will be in terms of sector size, so
> disable the CONFIG_SPI_FLASH_USE_4K_SECTORS and read it from the
> flash itself.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_zynq_virt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
> index 817fb4142d18..6145af62b511 100644
> --- a/configs/xilinx_zynq_virt_defconfig
> +++ b/configs/xilinx_zynq_virt_defconfig
> @@ -126,6 +126,7 @@ CONFIG_SPI_FLASH_SPANSION=y
>   CONFIG_SPI_FLASH_STMICRO=y
>   CONFIG_SPI_FLASH_SST=y
>   CONFIG_SPI_FLASH_WINBOND=y
> +# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
>   CONFIG_PHY_MARVELL=y
>   CONFIG_PHY_MICREL=y
>   CONFIG_PHY_MICREL_KSZ90X1=y

Applied.
M
