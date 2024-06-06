Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB3FC27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52467881D3;
	Thu,  6 Jun 2024 16:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p/YmPpoA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7431F881CE; Thu,  6 Jun 2024 16:11:45 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 775E3881D3
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maRTlkcwGbDVhNY9msmIK2v8u4px7Wz6x8f1WzHmMe2G7RnYPHM0h5cUuzM1u3udskbXys5+1kQQlHumSE/lcOSSsXH5fzS5pfP5LFvPTfO3/7o1YRtag1s/RAgbaIUEr+iYkWjG0lHnlAxCJ7hhpWRcpOUK0WKlUUhyfT1IVkdx5dXiJtfpco65NB1+Fz8fUmsa6kK9yyr+BqjtfTAFyXiXZ2EoUK+wloX7U2rAUuciKTblYS15W9asrH2d6PYwnIe46yWUPu58JmCuferEKNZzWUA7g+HxP1jetxND6r/yqFaL023lMtviLM/AB0C0seoWK3hofTK8cUH1z3hgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVCxDzDSpJikKM8pBxRChzI+0X6Lkz+M0Z+Tam81UKo=;
 b=bHxW5iZv5tciSXmZquJfwvlcwBnTdWeAKAbIhRRx2DgbjIF81X2mmoNx57zNzXEEU31rmFwDrHpEQve4bCmx9WUSOhveZnreiB416D/ar+jqdVIUtjAA6cFwQzPNxqSTNXIxytYSovU6NxUR5RGZKfGIvPxShKofgsMxvTWXu6ej1qJgWMgWQfxs1Ito/bvV3CtMV3K5ORqYFH7UTH+/dVm2lSBNNkWAdQ43RcK2bWF8WcI71iSUWPg+mw5Dn/arC8DyxPwrfMWZS5JGEathusSouMmR4yrqISkx+nPvFH/GYoZfbv6+ebCDeaa7c+26sh5dwVbVkFBYJkZpfiXnOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVCxDzDSpJikKM8pBxRChzI+0X6Lkz+M0Z+Tam81UKo=;
 b=p/YmPpoA9/XlEP+Noua2rvJ4emTI5uPk1rYkv75z6Zg2UYub99kTr7HBq9gMD3z+5HQP5dwr9wo3d/v6hAMGE3iTjkObPC987eAaFpXxin5YfNGR/JnB7VmojIxuxhbm8Dqzg4DIXIMAtVpEbpQ5qBjlQHloLQaKHBRD98mzgc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 6 Jun
 2024 14:11:40 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7611.016; Thu, 6 Jun 2024
 14:11:40 +0000
Message-ID: <e06e7100-1dad-4917-87b7-1795d28e8469@amd.com>
Date: Thu, 6 Jun 2024 16:11:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] soc: xilinx: versal: Use zynqmp_pm_get_chipid() to
 get chip revision
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Stefan Roese
 <sr@denx.de>, Lukas Funke <lukas.funke@weidmueller.com>,
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>
References: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
 <20240604142741.425307-4-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240604142741.425307-4-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 7477e7eb-3d75-44ec-fb5d-08dc863295c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVpxYU1WODNxakRvcEFqUTlKRDBjTEJhRFFTb2l0ei9ET3VYVG5kM3NmVFV2?=
 =?utf-8?B?ZDZZMk5ZdWFobEZWRjkrZlBOYUVWVGFvQkJaS1hmdG1PT2FwcEV4d0pSNGt1?=
 =?utf-8?B?aHFBN00yQ3BFT21Hb1cvZjlMVUJoRkw5UGFYRlZFTUQwRHBBUmRic1EwT203?=
 =?utf-8?B?QnB6NVk4eHJ0Slp1TzF2TEMvd1BYQkVFcldXVnBlWTVyUEJVY1dxdmt5aksv?=
 =?utf-8?B?WCtZMXFndGJRYm5TWTVscEtXUHRiTUZNV2c5anFHbE82NkJYSCt2cTRxeXJh?=
 =?utf-8?B?dGNMc3Zrc2lOTDJtUGNaazlxUnJvOTlTY2Zab1c0K0czeTR0dzNqUW94NGlZ?=
 =?utf-8?B?ZkFrdGRsSVZvY2Z2ZDQ4OTRUMU9lZVhFWEVVK080NkpFOFFHbW5WYWtUYk1n?=
 =?utf-8?B?S3EyNXFybmZHeTZaZVV5YkVVYkE3YjNLdFJWQjdUUzFOQ240YUpvWGtWdldL?=
 =?utf-8?B?bCtCTnRuc08wWE1ETy90d1VmZGZ2M0xqK2NwaWlSaFJ6TitGckx6MWVQYThR?=
 =?utf-8?B?Wld4aC9XSmR3blhtOFFwQ2pwUVMvVEtlK3F4NzV2ZWlobS85REg1dW4zVHpx?=
 =?utf-8?B?eGcwNFZVRjk5OGRpaTJPYjNYckgxOUpaKzRkOWNWN2ZqV3FLeXloSStJRXd6?=
 =?utf-8?B?SlpaNlR5MWlmU2U3WjQ5ZkZ5eElZNFhXUWVScC9JRmVqcGVCa1h5THRGK1dl?=
 =?utf-8?B?eHhtNDVZaGZtTHk5alliWmhoa3ZqV2VIUmorN1c5dDJVWEV5WG5jSFZKbUEz?=
 =?utf-8?B?OEZJeHhrUk9PRUppWjI5SkZNaUJxYkMxTWtkbEpUS1UxY1huWmIwenk3eFd1?=
 =?utf-8?B?TjlEbDRVN0RiU1d5WVNGc3MveG9qZjVRbXNHZlN4S2NFZkUzUGNKVkh5SVY1?=
 =?utf-8?B?Zks1aWdKUDJwNmlGMnZZMDRBaDlwZEdaUWhMN3VQRlpWR2MxQnZjUWlHcXIv?=
 =?utf-8?B?WTd0c28xQWtBK2t5MnVia2cyb1MzSWlCdk1QWllaeU9Obm5ic2xsd3ZMcGFM?=
 =?utf-8?B?K0dObXdFd3hqbG55MWYrdlZCaXJJZVpOU2hEUG1JS0dXSGd3VVVJc3R2QjN3?=
 =?utf-8?B?VmxRdGROZC9NOFdFcDhRN3BFZlpHRmhXNTVKZmVFZ2xTcmdwSHArN0YxZGlX?=
 =?utf-8?B?UmkvOTBldHVnVm5RZjMvbkFkRzhwWk10NzViVEpncU80Y29ZN2dROWRrT1hu?=
 =?utf-8?B?V1lid1JPSkNTZnRsd041a2Z1cjMydmx2MUtyZmh1UFBWajZNeG40SXdLM0Iv?=
 =?utf-8?B?ZmozQjNzNHc5eDFyZmxxcXpVVnFTUDdwL0xjTlN2M0xzTGJ5ZTlaczRnbTE2?=
 =?utf-8?B?ZTg3YkZ5Um5VSFdoZUkzSm03MWdWRzZQTGVXRFBnSFFrUkk2MGxETm0rcm1m?=
 =?utf-8?B?bGQwZlA1QWMzSU1RZkxELyszdlVsdTdrdG1NRW1QSjFMWDc3Q3hmL0E0Wm1y?=
 =?utf-8?B?aE90ay9wMEwyTlorV1NBSEgzWEZuM2d2aEVsMlY4MkgyYVV3MVpsb0h3cGtk?=
 =?utf-8?B?NThoKzFBZlBDMDFrR0owV3JyMVJ4amMxTitweUl5TDNCcHhWL0tiLzN5bVdE?=
 =?utf-8?B?eEpsRnlQSXJ2QzFMT2MzSFVXQ0hESG0yUzl3MHF3T1hPSGhwVDR3ZWVDM001?=
 =?utf-8?B?VFNVbHF3OW85TkdoaXZ2M2pOZ1NyZFpJc1c1LzJleE16RVlZZVdUSFkrZ0tE?=
 =?utf-8?B?cUZ1RVdIVmo3UDQzZmJRUmMvSjArd1ZRQ2xPWmxGWUh2UXRESlJZaU5jTWpy?=
 =?utf-8?Q?nC+JCwvDB8Ij+yngwoRuHwlI64CMghN2QsRqHtn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzNEdTd4ZnZhRmFUajNOYVUxTlNybUN4WXVVUEFwT1c1MU1OSGZNbjJqTnV3?=
 =?utf-8?B?NEdxWmZpZU5JOUxiZEVINDFONHI3R1J5RkVsUFQ1YXFsZXV5SDVZbWdqOFAy?=
 =?utf-8?B?UzljSC9QNG5hWDNvZEFvMFpBRVM5UDZaVWtEcy95WnlEbkZsN2poQzM4Wjdx?=
 =?utf-8?B?d1gvaldBOGpmdlZaVkxQT1ovc2pyS0E1a2V6dkp5ZlNjRTM4WDh3UHYzaE1j?=
 =?utf-8?B?MkwvNlA3aXpMMVBDNDIrbGRUT0RreDVGaC9VbFpHWTdFd2JEZEkwb0tham5O?=
 =?utf-8?B?M2lBa1JESXFBRnVOWnBZcU4vVlFwZzN2UC9xd2F3VTFJNmQ4VHhsN0szK1Zu?=
 =?utf-8?B?WFh6WUlQUUJhQVllNXJueHBPL3F6aGljZE5tNVdEVzVLOHBEanlUcmZISmo4?=
 =?utf-8?B?Q0U4UHBxMXc1eEh5OXBnbkNqWkZwa3RtUHNONjUzcHZXQTRBVkIvVTV6VVZV?=
 =?utf-8?B?VkJRMVY3b1VQVDN1Y0VFL0pWM3hQMWJlUDhhME01ZVRLM2FqT2hDbGl3TUZW?=
 =?utf-8?B?Z0tGRVBDaXpiWHJWVjVOTXR1ZHpFZjRVYnUyYnZkaVZaZituVGlxMEVrY0J5?=
 =?utf-8?B?NUZ2cjdqakF2WWRnelBiUUNjTXhxd1FaMFVxRkZ1aTZJbVBDZ0xvaXE4RlhT?=
 =?utf-8?B?bDNNZGpNQ1BFWnpTWjNpdUVFMTZWNjFiaUFmOXBUeXRSRHRJRE1PSk8xOXk3?=
 =?utf-8?B?OFpmbjdMZXFpK21uM0Zta3RXcUZ4UytNS01nbUdLb09tTkQySUZPMXdCQ29L?=
 =?utf-8?B?K0dWSndWWG5PSjlOUnlrM1NWWjJRK3dtUTVrdFFWRFBuYXRRWkoyS1hxc3Ja?=
 =?utf-8?B?NkJkTW5SL05ZN1VxaUNycFg2WnhMSVlrSHNJVjkwV2dUcy9GTXVQRXl1K0Iv?=
 =?utf-8?B?NHQxM2cwbHhtaEZDbk05dDQzbHpWdG9XZVUwTWhpc0xYNVVWbnRXNllwV3VH?=
 =?utf-8?B?M093Yjd2Rk1jazhqN20xWkQyZGdaUU1nV3k1enFNU3dlKytSVlBWWlRxRW1K?=
 =?utf-8?B?Uk1HRVZkOGY0T1FBYlplRytJaVphbHhVTm8vckZaRnBSN0RrSVpmcUcyeUdU?=
 =?utf-8?B?ZUQrcWlzaSttY0MvN3FSaSs1Sm82d0R6RmYwNzloM2VDQ0txUU9KQlFWSEJF?=
 =?utf-8?B?SXJOeW9jY0dEc1BIUlh4UFoxVjJQRCtvSWpHZ3JNelJVWTZ6NVJMMVhTdlNj?=
 =?utf-8?B?WUJsTHNQSmwzTmxNQlBqMVAvS2EvTXpCUVFhRHFxWSt5aGhPOXlCNERmbjcz?=
 =?utf-8?B?ZC9xZ2NKVm9EOFdtcE5RSVNYaTFsaVFsdU1sdWtuUGw3TEk4cWc0VnB0RTV5?=
 =?utf-8?B?ekEreHpRU3hqMysvb04yclhZNk9iM0NudlVpRmFKeFI0eENBNk5aQU9uRVQr?=
 =?utf-8?B?SURZYTZhYW1UMjJvY1BHVVpmVW5HREo1NmtuTytjaW9uZkk5TzNQWDRMQlRG?=
 =?utf-8?B?dCsyU3BRNHFHUTRtcmZuTUc2TERGSGszbU5tbDJoK2RmYmtJVjVoSGYwQXlM?=
 =?utf-8?B?a2lYblVjV0VFOE43Smk5TUY1RDNBRXNKSHBkNGFSdG55c2Y5Vkk3MDJvOEVO?=
 =?utf-8?B?a3MyUVVOOU1wUnlkYkhjaHhKbHNmc1Jod0ZURm11S0VGRFZ0QmZEdmFSRDFZ?=
 =?utf-8?B?VVZLakdqb3RrZXpQK1ZrVGhxY01wT2VuMVR4MWF1dTRBSGQ1a1I3Zm0wdDMx?=
 =?utf-8?B?ckY3Z09zUWFaZU50NUFUTVlXS0h2MnlkSDBSbjZGaWZ4bmVmRFpJOEJWaFhC?=
 =?utf-8?B?cmIxVEZ5cXZuTmg0Sk1YWUR3NTBYL1NSM2pWZGNhYmQ5NndINTFaOHp0ZzIv?=
 =?utf-8?B?SE5lc3loQWpEb2dOZ2R0NkdMK3Q0WG5hSkNxeG44UDVsbDM4YW9seEN5Vmdy?=
 =?utf-8?B?RmRCWngxVGcyOEoxQU0ySVJIR2pEQTNVNFM5b2Fob2xPT3pHdmU5bHJWeE5z?=
 =?utf-8?B?TkZGSkhreElLSWkxQnUrQW15TG1yRFFlQmE3L21KOVVma1FNaDNlcFRJYXZI?=
 =?utf-8?B?NTVnVEFiOGxMVWxCUmdVUUVrNE1tWGFMQUJ0YkVYK1BrbzcyL0V5Z0dyVW1N?=
 =?utf-8?B?aVZkUmJZQ2FkM0ZTb1RacE85bGthRG44MllLV05xUWk3Q2VXMEZDYzZQS2FB?=
 =?utf-8?Q?YckVxXneN5nVfoOKmAf/LxJrS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7477e7eb-3d75-44ec-fb5d-08dc863295c8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:11:40.1722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsqI7ZHyQuZOvIqrycNbSnxWaMVJyHBKSbpkOl7F7Ba6WdDwr9k838ejl0qSxlC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836
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



On 6/4/24 16:27, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> Use common zynqmp_pm_get_chipid() function to get the chip revision
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
> (no changes since v1)
> 
>   drivers/soc/soc_xilinx_versal.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soc/soc_xilinx_versal.c b/drivers/soc/soc_xilinx_versal.c
> index 3d8c25c19bb..3d949c4e612 100644
> --- a/drivers/soc/soc_xilinx_versal.c
> +++ b/drivers/soc/soc_xilinx_versal.c
> @@ -45,23 +45,22 @@ static const struct soc_ops soc_xilinx_versal_ops = {
>   static int soc_xilinx_versal_probe(struct udevice *dev)
>   {
>   	struct soc_xilinx_versal_priv *priv = dev_get_priv(dev);
> -	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	u32 idcode, version;
>   	int ret;
>   
>   	priv->family = versal_family;
>   
> -	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
> -		ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
> -					ret_payload);
> +	if (CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)) {
> +		ret = zynqmp_pm_get_chipid(&idcode, &version);

This function is defined in 6/7 that's why this will fail when it compiles which 
end up in non bisectable tree.

>   		if (ret)
>   			return ret;
>   	} else {
> -		ret_payload[2] = readl(VERSAL_PS_PMC_VERSION);
> -		if (!ret_payload[2])
> +		version = readl(VERSAL_PS_PMC_VERSION);
> +		if (!version)
>   			return -EINVAL;
>   	}
>   
> -	priv->revision = ret_payload[2] >> VERSAL_PS_VER_SHIFT;
> +	priv->revision = version >> VERSAL_PS_VER_SHIFT;
>   
>   	return 0;
>   }

But code is ok.

M
