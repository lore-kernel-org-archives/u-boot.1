Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C06C4829A
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 11:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB92D87C45;
	Tue,  6 Feb 2024 12:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uj98NRAJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D83087C56; Tue,  6 Feb 2024 12:31:40 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F28DE87968
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 12:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVKFVrWPgHmFf0ELQx1gM8m/IEB4oEePqnIUD0FC8HlAWz8T1wBkkzOjSSW6rL/LKeiOZEh2/jwGO4DwScUns03U6NcMhKg96sNosoG0IJC78Pt37KwTfXWqb4499GeeG3rHepnRuc6PxVhMGpMZR1NeBm6jl3hTiGdvrxJhZeUyZH58FfZga1JKoThzxYF3vHhg2BNlxipoGFBxgwuUjmb7qFFcSFYehddCqDa+uuZTmjfZBawPZ8ZgAAB7AdOueDI16m7gTtuMz+uyAJW4mm0jEj58UnJ9dkqeDiHyez4CyUWK7eYGDTbIqEQxcoOlo+kdXQ4ZCNW9cLhIPWyQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqW9L0U0RFPHi0NlEbnzUNhLGf5ao2izs+oVFETY8Ts=;
 b=KehlM34KWvPHyBrPaGquhEEXQO6o+buaLc0wPSVGMUoe2h/fN1cCnteTyDOYwAf6PnMMAagUtSxcIeyHUo30HeRlrgKJ9jbTEup1han6EpMBSxumn66NuvXaZwWh3627N8y7aclFP67WNUQ8nRz4XRT8NMoIwVElPeGvSyOYpNwO7XKx3Lo9GlBf4gW5hOqdxfW20ZtJKJbHtBUabcHRvYarPwWVRpcAmJyO7UDtJ3eGYFr39ievLONVZr9YujNxylV9lyIzZYUYe+FDDk6sc6cIc33LT7CMSTRzAO6OjMwbLP3i3D5AZ8T2P88rR0jQH/gNfN8sxChUrz/ksNBliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqW9L0U0RFPHi0NlEbnzUNhLGf5ao2izs+oVFETY8Ts=;
 b=Uj98NRAJo+ab57BRobhYbdKdmiQERwGG6FArAu+0IslVUjuXXBzXY853yMPWLt6jK31Rx00Cj7rG58fgZh1hVzidcyH0PsXiNxM1xJa/XkoP9VZlfDZzhwg9PfMzgnl769zs695M73DMWE0vhYIxCU9WfJQG8O3A6IqUu6gIpOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 11:31:35 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 11:31:35 +0000
Message-ID: <a392053b-0c99-4eb5-83ce-da68dcd59013@amd.com>
Date: Tue, 6 Feb 2024 12:31:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: xilinx: Enable EFI_HTTP_BOOT by default
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <b78a7d8b0100c724f657c0997b273e073cf31a14.1706093917.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <b78a7d8b0100c724f657c0997b273e073cf31a14.1706093917.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0018.eurprd08.prod.outlook.com
 (2603:10a6:803:104::31) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ba0afa-6cce-4719-3d5b-08dc27072cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTG6gq12GrpE1mRq4MVC0MBp8+a9cFg48mJgLQ86uu99E2g8yNubZPOa1n1oqDTOPqU6DwQKbgCz4G37JJYNKYYm7qTBrjXNYce2KD/rCiztOkGnMj8F6KW/ensPQFPSnKFJHpkrWkAmT1aGRhkR9iI5yLDxTsitP2LZv84wXdH9u6VQlARWjJ1ACKMZg7rftIUJNOCEAQT1Tvpf/h9k75BUnripfddPh9sFW+mCHm15hKgRmKUdYC0g29LRKrIZhBubJ6sHGDEMVAnG59s5EroFScB99H7sGRk8PBaxQAY2hAVXwPuEjfA93w0/wvERKs1uqOqBS9df2sOjrNksXBMoD2RgWk348WZUREk6RiKptB03nAxC/TPFOR7juZr4hP2TMZAnshkCuQJisOxQ/zSlr4TzkGM8wz9agJa031DkAjsXFtmFJQDDSG9gmUlaykTuHcJLASyrOVLXbwOuiADBlzQje29RTUl9WYJK7PBVkIh7s/P8NKtA9hoOl1u3zC77o4DqDktPDL78I8ha5mNuZ1BahW2bRTm4jg6qHaC7QIgRS3nuNsJTL+4Wcb6xrojUmPmg98cngYdOXz/ycd8PknfpTMO2tO0zXxs2DDXdfAyCN5exF6IL7cp4VAkbzQPVx5OXmINGO/hNwuVuyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(316002)(66946007)(66556008)(8936002)(4326008)(44832011)(8676002)(5660300002)(66476007)(54906003)(86362001)(36756003)(41300700001)(6486002)(38100700002)(6506007)(53546011)(26005)(83380400001)(6512007)(6666004)(31696002)(478600001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rkh0M3AwMWRMZ0JRSzB0My9ML3ZORUhHZ3hDM01PUFpSV1h6T3pzdms4UUNE?=
 =?utf-8?B?aS9LWEIvbHV0dCtsaWFXSktmZjNvRW9xcTZMUElzdElRRjltV3lVdE9wMG5N?=
 =?utf-8?B?NCtsUDNvVnNlZE1scjY1NHY2N1g5cEZEYzJHTlpXbVN3eXd4VlhiaXQrRkFx?=
 =?utf-8?B?QU1UekxiaHA5NWtNOWlKZ1ZpWFloMmlEZ05wM2ZjaVRrUlRrQlRiOXhMMXBC?=
 =?utf-8?B?cFdZYWpjUVhtc2xHN3JLZkw4Tk83MnhobmxYbERENjZ1aDYzdVlvSEJiNUpS?=
 =?utf-8?B?Nk9OV3VjTXlDajFRcVhYQ2JtWXV3b2lJeTREbytROG9qTmcxaUtCczJFRzZF?=
 =?utf-8?B?TG8xajZCelZZRllLTW1TU2ZlVnZHdTRLSG1WQXF1YWNQalpPTVdwbEoyREEz?=
 =?utf-8?B?NEd4L05NVWo5MkJyUWpNNVdUamtmaG01UWw1Qk1ORWRIUndGWDUrNE80eHIy?=
 =?utf-8?B?aEVSdy9JVkptSmttMVNzSjhDMXJsa2R3UUZLc3pmcEJxT3pJNnp6MFQ4YzdQ?=
 =?utf-8?B?MTE4Tm1oUG1uODNUeE9ncjlMd1U1NjRJUjNtdHhQUGkzV1NWbU04S0U5WWZx?=
 =?utf-8?B?UFV0SWtjdXhpYThCeTJNdUROeGptdGtQT2FieHdQVXZ2MmpiQVhyaTNlZTgw?=
 =?utf-8?B?S1ZMSGN3bEp4YUl2QmMwZTlJZjU3SDV3dmNKdTJVa3d2MGkxMURnSlhhS2t1?=
 =?utf-8?B?L0ROQy92clA4L0pacm1BbXBEMTg1WmZCOUV6TzNqM3QyM1QzWXZzNG1RWnNy?=
 =?utf-8?B?RnFCVC81TzNhUGNZMURyOXVvM1VsZDdZNmc4dnBYZmRwWkhjWCtLV1F5d2p1?=
 =?utf-8?B?c21XV0JLMmFLRFhNNmNncXVQSTVzSnlNbkNqWElnY0V0bGY2U1hqTFpUUTBO?=
 =?utf-8?B?Nkt5M1ZqRHJxNmVvajNBeFFMSllDOUpVUURZUk9MWFE5WExqRUdDdXFLSm9C?=
 =?utf-8?B?TEdHL0JNWUFramtYdDlGWjV3dEVKbzlEMlU5SVBDbVl3eDdlbWNOVlF1aHI2?=
 =?utf-8?B?bUVVME9CcFZ2dUZaMmNvM1ZjYndmNE9heHR3VEQ0cXJGdWt0L3VIekpGRUcz?=
 =?utf-8?B?Z3ZYcUJmZi9PVnhFTkY3S2NFYldaWlNkRTViTXdZYm5aTFN2WWV2cHJSeWEx?=
 =?utf-8?B?bzlkaHcyempkZjRsbFh2Ri9oU2w4clBFdzkxZlNNQ3dTdHA3TE5aaWtPay8y?=
 =?utf-8?B?QWRodEJyODJwTnE2QlcwWmROSVd5MTFWVmUrU3owZnA0eC9zT3o5SlNlZlJW?=
 =?utf-8?B?QXVJWUNKOXp6VWYzb1FnM0dyQlpRMmo0dFpnZytOM0FMYmpPaFVYcWlOVWdu?=
 =?utf-8?B?U1dYNjhOT0tpelVLZFk4WlBmcDlaZlk2YlJscEZvdytlbW9sSFJyUUdIK0ow?=
 =?utf-8?B?TmFLQU9FWDVNU0t3Nnp3Wmx5bFZzaG9BWFhJbjRxcHhHR0hRZUZqb2FYM0U1?=
 =?utf-8?B?RUdXMlBUZW9RemxFMTB5TEtzeHlXS1EwalFlNlNVNGRRMmpFUDhhdk9Kem9I?=
 =?utf-8?B?cDhuTzZFckljb3pjaktIV0l4OUZ5R2pTL1FreEErNmRqY0hIYWY0RDJvZUYz?=
 =?utf-8?B?dXZqSFAySkJHQVJOaHljWHRtZDVDYmJ3V3dQSHVTUnRUS0hQcHNzb1pDSEpE?=
 =?utf-8?B?UnBPakE0M1FWMXoycFNwdWoxalc3ZHIrRG1WaG1maHRHcjU0NmVGdlUxQ2dO?=
 =?utf-8?B?UXV3RDhteTFaSUZTVHE0SXNjTTlveVRzelNiY0w2bXJPb292NGNjcjJ5WlZ3?=
 =?utf-8?B?NVBTL2RLTTkyd2pWL0ZSbDVVYW5WQnBJT0drY0s2RHJnazg2a0hWYXRoTkxJ?=
 =?utf-8?B?NzB5L1BHRmQ5bGczM0lZMTNqU21hU1dZOCtrdUtiSSs2d2JVR1dOZEJOYkN6?=
 =?utf-8?B?eitRZjY2N3RSL28zWm5XQjVWeHIvL3kyQm8wc1lLQmxsQUtlREk4NFRDRTQy?=
 =?utf-8?B?TVZvSlF6Q2hSRy81UnpsaXR4TmFmNDZ2aEo5MUNUMmJ1aVEwY1orRHdhVTFW?=
 =?utf-8?B?R1UvNytsU1BSRi9OYld2N0dNcWpraDdQcVI1U0hRTEhyUWx1VVYvUGhhSGZy?=
 =?utf-8?B?cWxwTUpiZ0hNZ3FkbTVvZWQ4cVR0SGtYV0svRUo3d2xkN2grcGRscitodXk4?=
 =?utf-8?Q?WQJqArqL4Vocq4htP94tW6cxh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ba0afa-6cce-4719-3d5b-08dc27072cbb
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:31:35.0468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieieai/E0itKndlBfRAxg2qOMybIB4Q6YZGU8occAHjA9kiTOy19NhCV97XDk409
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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



On 1/24/24 11:58, Michal Simek wrote:
> Enable EFI_HTTP_BOOT to be able to booting OS via http.
> In case of that dhcp server is not providing dns server IP set it up via
> setenv dnsip <ip addr>.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> I am ignoring defconfig sync because it needs to done because of
> cda3f81b06f5 ("cmd/flash: Make this default y for CFI and NOR only")
> anyway that's why I will just enable feature and Tom will run resync at
> some point to remove automatically selected options.
> ---
>   configs/xilinx_versal_net_virt_defconfig | 1 +
>   configs/xilinx_versal_virt_defconfig     | 1 +
>   configs/xilinx_zynqmp_kria_defconfig     | 1 +
>   configs/xilinx_zynqmp_virt_defconfig     | 1 +
>   4 files changed, 4 insertions(+)
> 
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 371d14eb89b7..0f1d990936f3 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -146,3 +146,4 @@ CONFIG_VIRTIO_MMIO=y
>   CONFIG_VIRTIO_NET=y
>   CONFIG_VIRTIO_BLK=y
>   CONFIG_TPM=y
> +CONFIG_EFI_HTTP_BOOT=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index 5f76a305ab32..3c55dd8dcde9 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -153,3 +153,4 @@ CONFIG_VIRTIO_MMIO=y
>   CONFIG_VIRTIO_NET=y
>   CONFIG_VIRTIO_BLK=y
>   CONFIG_TPM=y
> +CONFIG_EFI_HTTP_BOOT=y
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index 0dc6c5b6877f..28b28f68411f 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -224,3 +224,4 @@ CONFIG_EFI_SET_TIME=y
>   CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>   CONFIG_EFI_CAPSULE_ON_DISK=y
>   CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> +CONFIG_EFI_HTTP_BOOT=y
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index 2742e38b599e..1fcae45e95db 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -242,3 +242,4 @@ CONFIG_EFI_SET_TIME=y
>   CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>   CONFIG_EFI_CAPSULE_ON_DISK=y
>   CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> +CONFIG_EFI_HTTP_BOOT=y

Applied.
M
