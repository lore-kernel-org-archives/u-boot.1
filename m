Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D76CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 06:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D11D8846C3;
	Mon, 11 May 2026 08:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PQho/fc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2626F846CA; Mon, 11 May 2026 08:31:29 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D03BA846C0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 08:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsiAI8fM8bAjIkfoRyElQ5fIUu2+pxzfBfE2pAIXzHXIkOMWJCaj8CxR1eBsg+koZPCfHtQA/JDQEqsCZN86UHoAwqpvhlKr7W3B0uVn9kpnckN4/y1pPHlNOFDEjQbB2MzVCxQZVt9K3hSxef2uw4UXPC05QPzbwJEWpK7tWKEzde4RAiS8xuwjJlIzXcsk4VJyUd7tSe9++NryDbqUQU3qZUrVghm53fO5bxlDjgUfoH1y9N/5vQihs2TDLKhpSXfzHQS6ujgr+1GFa64Uh3r7EPQjw4xTRcWPjKaydM1Ryryybm0zMDsKabvDm7J9dVgj+N4IfHjj6+mqtBZS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWEoMDT+coFvSTQlrQndir6PACptbzzoVs8KnfWvEFE=;
 b=usmHea3k4dI9MEEFJCDYuw0Vr3GU/7WKntDVruU1ZGvkHi09NXRosq2nNUhbiiYCbpuYUDAtJThYw39pFYCRdaGkFCjim405R0FyCezv9wHai64FAYBVUdPWV+8wSiUNm8ZxeSOzESqp9DYvD2NvdXDgALFwEK+iWszI66lqwr3BlY76S/Xk5N/VJF12//eke6Iqp8PfAaQV+gfLvUPhyIhtKk4PD0jGHnrgfiwv6AcSJQ6e/5r4o5WDHMFWT2P8DD43O1UUk24WvU3hhcNIxMVurbYb/KtpqZRzlb6X2J09sWy1PUrNiafjLxs7Sl3Tn8QvxM6xfW8vzEL4NaIHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWEoMDT+coFvSTQlrQndir6PACptbzzoVs8KnfWvEFE=;
 b=PQho/fc8Obwuq7UoJ9zO37T1tSgGrM403Ynqhf6Si5lKp6+1W7OjlWZiwc5qkhkqVTp4AgGuoP8mdwSWOQUiwi5dDFsfp+BxUogKdoDKPkylcSyYVrteArivq1+ZQnagrJ6Lka9rD6ZWBvNkzjR6NbF9N9xQbzupJiveayXfCwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 06:31:19 +0000
Received: from IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db]) by IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 06:31:18 +0000
Message-ID: <3dfd103f-3a1d-4887-b64d-727900fd9b6b@amd.com>
Date: Mon, 11 May 2026 08:31:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/64] drivers: usb: dwc3: sync code with Linux
 v6.16-rc7
To: Simon Glass <sjg@chromium.org>, Jens Wiklander <jens.wiklander@linaro.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes
 <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <CAFLszTgdhUO4nTd57atF__z_ox2VSROdxFKP93kr+f4FyW=5Jw@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAFLszTgdhUO4nTd57atF__z_ox2VSROdxFKP93kr+f4FyW=5Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:180::19) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB9788:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7d7edb-9322-43f8-d79b-08deaf26e8ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: g/igcbph29726UuO+28eiupJDVmhshFPKuNBBE2a8z9ZVtTeKlSGgc3H6a+cb4r43TbDitC89VzHu6p8aaJ4WDi1yBuraG3XpMaVO6mmRFMV1ucRUIHD7Nyvuv1dRq2mvmjry4M9HyQFhb+M8M02LXmhSkaXG7Ytb26kZA6ehVTP7nzcF81K5pO8IkCkK5+t86hqz+izv3m2Q04owUtdGerGunsrOklOrQGpAwEr7tXeEw4PRKSDCHJEEhjHGbczRzKeo2RliTTQSoGX2KzGmjBHACLR2khdNypTDlUSkZjkK3A4kD5/OdjHLhh3/fpdEEr9kSuJ/9mvFQ6JZQMZ11D4pJQkZOwjFNiHGNFKR7AHI8vpLcwnFCQfZE17nvbSJn8Pd0deWwju/+mm1nbOz6L43xK6J3Oq2VT1Jkxm9mmDZGPZvWpnnwsTTFSkNfqMwvwHmbYtIQ66b8Q2dY12mnsyT0d73SLQ1QuI9YTJVX5nhO4ajdkytUUWukUlWIaW/UGjKgjVg5Ldu37PQCIfWLeK0kNg5QQ0JikzGGxcux/zqvH0Ptg3K1N01N73UE5KqhrQ8kj7/Sm+qLyCqtipuA3tlgDSiiPNHu8qG6TvdahyDzYVPRwv0H1Oy11FsrMDzyvgmmysewqZVf4HzNvsFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9788.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1FaSkttUzVYUjJ0YmZsYXc3R3FyRGNPSW8yMUtySTJtS2dZekcyZERMbzVO?=
 =?utf-8?B?azRnZXF1T21ZTkdUWWJGQnN5ZTFIano2WnlQZm51REdxc01oQ0cwY0VvMTVn?=
 =?utf-8?B?S2NKQ0ZxakVhVmNaczc0MTlRc0lmVzhMUHdiWEU1alhVZ1VFRlNzT0d2Y3ZQ?=
 =?utf-8?B?dHdoSGw0TTF6ZThOVXZJSHFWZU9VNjlZaDhNZzc3eWV6V2VFYjYyMXJkbXVM?=
 =?utf-8?B?RjQ3TEUvL2lkMi9IaTlUQkg0UUpFakpKRThCMFI5eVdDVUpUcTRvN0hMdWNN?=
 =?utf-8?B?WTNtOWh2NnhLSnJDS0MrR0FTdm0vUThvVmVpUWFCTjlPZHQ4RDQ2QjBRMmVC?=
 =?utf-8?B?b1lPdnBTa2VUSzJWaTdMSEZzS1c4am5YZUpDQSs5NFBEdWtWTDBsZU80UUFR?=
 =?utf-8?B?Tlp4blU2eFQwZlRVUGxSRFRWYk9VY2s0UFNSSFpFekRxZFNMYXdMWFg5OXNi?=
 =?utf-8?B?a1YwNU1UQUdrT3RkWkpRY1QybEtUV05vSmlsdk9xOUxCK0M1dmZtTUZ3TGNI?=
 =?utf-8?B?aFFDREdSeWRBeEJ5TFpxWE9mQVR5QzBQclJIVEl6RGJseHRXVHJ6ZWJMZHpu?=
 =?utf-8?B?Y2JWelprZCthUDlST05Wd2RHUDdDbnBLQTdVWDZYYkJaOXp3d1Q3RXNPRzBO?=
 =?utf-8?B?ZXkrWVZxWHdSSnRDQzZUMjVpTGZlaFpTU3AxN3AycnRKTFdEOUFDT2ZuWFNa?=
 =?utf-8?B?aWhyeFhoUUp3di9oMGI1NnFXVXkwd1ZXaG1mQnhjd1dwZVo0V0Z6UWlaVGJw?=
 =?utf-8?B?dTNlVFNHVFNUbGtqUTV4eUk1UFpqNUlnLzh3eXNlT1M5c204aG1UQTdZNity?=
 =?utf-8?B?TTB5ekRTWDZqbER3NXBOYUthZnVEZmt2Ykg4WUZlaDJvZ0syTUZpR1FHY0gr?=
 =?utf-8?B?Mm5uWmo0Y2g3eXRzTWJualM2WFhia3B4bkNaTUk4SUNrNHdOa212ZUthRFEy?=
 =?utf-8?B?K2wxQ09hOWtWWWN3QitYM0ZRb2hZTWlVc0NGaVlldmxvek1rRTdhQVhQVHBi?=
 =?utf-8?B?YlY1OG9YY2dmREJoVTQrVTZHcmxiMnIxQmYvQW8zbitTL0t4S3Z2emJrZWQ2?=
 =?utf-8?B?aWs1ZWxhMlp2MXFnZnliMUtLdUdaZmRmTSt2Njg3S0NFOHVWMXVnNTJVUmlp?=
 =?utf-8?B?SmUvYTZRWXgxb0Z3WmY4Qm1TQTluMXNLQm15NFN1Yjcyc05DTHFjK2hhd0FT?=
 =?utf-8?B?NUpMZ29zZm5TR3pzRFJnQUZEWVZUZmxCbkZnNytiOUVsVVhyQzRvdHoyUXd4?=
 =?utf-8?B?cGJjQWZBSFhaSXUyMkJOZURUOURKMGxrSWxTaER5TWNuRHdmUjVLUndUNGJq?=
 =?utf-8?B?UkFNWlFvVW5mUk5ZdEtjQ2l5cm1hOVVQTDdqd3A1SzhyTERoa3lSTDhKOUlX?=
 =?utf-8?B?REdIY2hPdDdCWVo0dkt2cWhGR1YzWEVsdUNjM2Jyc01rWmlwYVRpMDRSbmNw?=
 =?utf-8?B?ZGdOS1k4STZlTC92ZnZkL0lnc1Q4WnNBK0NqYzJWOWpuMDlYRkVFVXh4bmV4?=
 =?utf-8?B?bExDUFZZQnlEZmltQWUyTFhqeVdEcUpyNW5YUkwreXVnOFpCcDc1SFRScnRy?=
 =?utf-8?B?cm93MFJHUUVibmhmd3hsQllkdjEvenRxZlRaYmxqTFZDN0I3ZTFHQ1lSSGVJ?=
 =?utf-8?B?Y09STlhucVFVUzFBa0pPZC96eFJrQjF2OUNmZi82ZXRzVFdsN0dxU3VPTU02?=
 =?utf-8?B?b05XNDkrcFk0ak43ZzF2Mm1Fd2kxMEFQKzJUaThZakM0Z1gzMlVVRXNVWDEv?=
 =?utf-8?B?LysxdHBUL1hZelRQeUd1K2RyT0tJSlBoa1NJMkovSGw2Rm5obGdUbVdwcDA4?=
 =?utf-8?B?YXp5czBzNDJReXRmWmJNOGEva2lGNVkvR05UQkZmVFBibHlZT0liTWtCSUsx?=
 =?utf-8?B?QTFHVGEybVpJc25OSVVLNUVKQTBmeFFQaFJ2R1JaMlRsckpaV3pvT2ZtVFBw?=
 =?utf-8?B?ZU5kWU1KWlJsN0lJZkJGZ0NPaXpjM09lVXJLOGVCak9SbzV1eSt4U2Z1VWll?=
 =?utf-8?B?NUFndGs2dFM3NDlPdVRzT2hXc0M1Z3ZDb3Y4WkFndHpqa1NXVkQzQUNVZCtp?=
 =?utf-8?B?OTlEclFoNG9XYVlzSmhNOEVOVDhVSWZWbFpUQ2U5N3U2K3NtYm5DUFdwTksv?=
 =?utf-8?B?a1h1ZElpc3ZrdlBnK0I1ODJaSHRYK0lES1BmVy96SkxWcTdKRFZHRUxKSDND?=
 =?utf-8?B?TjRiU0N0RWJIcmt3RmtXVFEwYjFhbkFVZFBiUHYvODNFUVY3aFBGOFVMK2Zs?=
 =?utf-8?B?dXl4UUZoR1JnbDFqQk9PekdzditNeXRETzNMblNlRUhqc3ErcGlOd0d6OXNC?=
 =?utf-8?Q?uT/3rxit7KQg7PmhHB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7d7edb-9322-43f8-d79b-08deaf26e8ab
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 06:31:18.8409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WxEixhg+jXpocVIrHjyjQIxncFvbSHD69Wbn5itz+apn6HHxiinRKxDeYJQn+++
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692
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



On 5/8/26 17:42, Simon Glass wrote:
> Hi Jens,
> 
> On Thu, 7 May 2026 at 03:28, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>>
>> Hi,
>>
>> This is a follow-up to Jerome's patchset [1], addressing previous feedback
>> regarding the monolithic nature of the driver update.
>>
>> The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven years
>> ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel
>> to u-boot"). Since then, not many kernel changes have been ported back into
>> U-Boot.
>>
>> This series synchronizes the DWC3 core with Linux v6.16-rc7. To provide
>> a clear audit trail and maintain bisectability, I have structured the
>> series as follows:
>>
>> 1. Restore to Baseline: The first commit reverts U-Boot-specific changes
>>     to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 state.
>> 2. Milestone Imports: A sequence of 50+ commits follows, each performing
>>     a "snapshot" import of the drivers/usb/dwc3 directory for every major
>>     kernel version (v3.19 through v6.16-rc7).
>> 3. U-Boot Adaptation: The final commits (based on Jerome's original work)
>>     re-introduce the necessary glue code, XHCI/UDC updates, and build fixes
>>     required for U-Boot integration.
>>
>> The final diff is identical to [1]. I decided to stick with that for now to
>> focus on the method of how we import or update the code.
>>
>> Note that this is compile-tested only. The CI pipeline on source.denx.de
>> was used as an OK/NOK indicator [2].
>>
>> The previous patchset was tested on xilinx_zynqmp_kria_defconfig and since
>> this diff is identical to the previous, it should still work on that
>> platform. With the help of a custom build script [3] and with an additional
>> patch [4], I could boot the Kria KV260 board and make it detect a USB SSD
>> plugged into one of its USB 3.0 ports. It certainly doesn't mean all
>> platforms using the DWC3 driver are still OK, but at least there is some
>> hope. If this breaks your platform I'd like to know, and if you can send a
>> fix it's even better.
>>
>> I tried cherry-picking all the 1000+ patches in v3.19-rc1..v6.16-rc7. There
>> were a few conflicts, even when backing out the original U-Boot patches on
>> top of the original v3.19-rc1 import. However, the resulting state still
>> diverged significantly from [1].
>>
>> Instead, I've imported each new kernel in a separate commit. That way it's
>> very clear which kernel patches are included. Since there aren't too many
>> patches for each kernel I'm listing the relevant commits in the U-Boot
>> commit message for easier reference. I did this with a script so it's easy
>> to make changes, if the approach is OK but we need to tune it. With this
>> approach it should be easy to tell if a Fixes patch for the kernel might
>> also be needed here.
>>
>> Thanks,
>> Jens
>>
>> [1] https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
>> [2] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30004
>> [3] https://source.denx.de/u-boot/u-boot-extras/-/raw/master/contrib/jforissier/zynqmp_kv260_build.sh
>> [4] https://gitlab.com/Linaro/trustedsubstrate/meta-ts/-/raw/master/meta-trustedsubstrate/recipes-bsp/u-boot/u-boot/zynqmp-kria-starter/0001-kv260-fix-usb.patch
>>
>> RFC v1 -> RFC v2:
>> - Split the v1 ("usb: dwc3: re-import from kernel v6.16-rc7") into ("usb:
>>    dwc3: restore to original v3.19-rc1 kernel import"),  ("usb: dwc3: import
>>    from kernel v3.19)..("usb: dwc3: import from kernel v6.16-rc7")
>>
>> Jens Wiklander (60):
>>    usb: dwc3: restore to original v3.19-rc1 kernel import
>>    usb: dwc3: import from kernel v3.19
>>    usb: dwc3: import from kernel v4.0
>>    usb: dwc3: import from kernel v4.1
>>    usb: dwc3: import from kernel v4.2
>>    usb: dwc3: import from kernel v4.3
>>    usb: dwc3: import from kernel v4.4
>>    usb: dwc3: import from kernel v4.5
>>    usb: dwc3: import from kernel v4.6
>>    usb: dwc3: import from kernel v4.7
>>    usb: dwc3: import from kernel v4.8
>>    usb: dwc3: import from kernel v4.9
>>    usb: dwc3: import from kernel v4.10
>>    usb: dwc3: import from kernel v4.11
>>    usb: dwc3: import from kernel v4.12
>>    usb: dwc3: import from kernel v4.13
>>    usb: dwc3: import from kernel v4.14
>>    usb: dwc3: import from kernel v4.15
>>    usb: dwc3: import from kernel v4.16
>>    usb: dwc3: import from kernel v4.17
>>    usb: dwc3: import from kernel v4.18
>>    usb: dwc3: import from kernel v4.19
>>    usb: dwc3: import from kernel v4.20
>>    usb: dwc3: import from kernel v5.0
>>    usb: dwc3: import from kernel v5.1
>>    usb: dwc3: import from kernel v5.2
>>    usb: dwc3: import from kernel v5.3
>>    usb: dwc3: import from kernel v5.4
>>    usb: dwc3: import from kernel v5.5
>>    usb: dwc3: import from kernel v5.6
>>    usb: dwc3: import from kernel v5.7
>>    usb: dwc3: import from kernel v5.8
>>    usb: dwc3: import from kernel v5.9
>>    usb: dwc3: import from kernel v5.10
>>    usb: dwc3: import from kernel v5.11
>>    usb: dwc3: import from kernel v5.12
>>    usb: dwc3: import from kernel v5.13
>>    usb: dwc3: import from kernel v5.14
>>    usb: dwc3: import from kernel v5.15
>>    usb: dwc3: import from kernel v5.16
>>    usb: dwc3: import from kernel v5.17
>>    usb: dwc3: import from kernel v5.18
>>    usb: dwc3: import from kernel v5.19
>>    usb: dwc3: import from kernel v6.0
>>    usb: dwc3: import from kernel v6.1
>>    usb: dwc3: import from kernel v6.2
>>    usb: dwc3: import from kernel v6.3
>>    usb: dwc3: import from kernel v6.4
>>    usb: dwc3: import from kernel v6.5
>>    usb: dwc3: import from kernel v6.6
>>    usb: dwc3: import from kernel v6.7
>>    usb: dwc3: import from kernel v6.8
>>    usb: dwc3: import from kernel v6.9
>>    usb: dwc3: import from kernel v6.10
>>    usb: dwc3: import from kernel v6.11
>>    usb: dwc3: import from kernel v6.12
>>    usb: dwc3: import from kernel v6.13
>>    usb: dwc3: import from kernel v6.14
>>    usb: dwc3: import from kernel v6.15
>>    usb: dwc3: import from kernel v6.16-rc7
>>
>> Jerome Forissier (4):
>>    usb: host: re-import xhci-ext-caps.h from kernel v6.16-rc7
>>    usb: gadget: re-import epautoconf.c from kernel v6.16-rc7
>>    usb: udc: re-import udc-core.c from kernel v6.16-rc7
>>    usb: fix build after resync of DWC3 with kernel v6.16-rc7
>>
>>   drivers/usb/cdns3/ep0.c                |    8 +-
>>   drivers/usb/common/common.c            |   23 +
>>   drivers/usb/dwc3/Makefile              |   57 +-
>>   drivers/usb/dwc3/core.c                | 1780 ++++++----
>>   drivers/usb/dwc3/core.h                | 1120 +++++--
>>   drivers/usb/dwc3/debug.h               |  432 +++
>>   drivers/usb/dwc3/dwc3-omap.c           |    2 -
>>   drivers/usb/dwc3/ep0.c                 |  737 +++--
>>   drivers/usb/dwc3/gadget.c              | 4152 ++++++++++++++++--------
>>   drivers/usb/dwc3/gadget.h              |  124 +-
>>   drivers/usb/dwc3/glue.h                |   36 +
>>   drivers/usb/dwc3/io.h                  |   29 +-
>>   drivers/usb/dwc3/linux-compat.h        |   16 -
>>   drivers/usb/dwc3/samsung_usb_phy.c     |   77 -
>>   drivers/usb/dwc3/ti_usb_phy.c          |    2 -
>>   drivers/usb/gadget/at91_udc.c          |   46 -
>>   drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
>>   drivers/usb/gadget/ci_udc.c            |  419 ---
>>   drivers/usb/gadget/composite.c         |    2 +-
>>   drivers/usb/gadget/dwc2_udc_otg.c      |  174 +-
>>   drivers/usb/gadget/epautoconf.c        |  289 +-
>>   drivers/usb/gadget/ether.c             |   21 +-
>>   drivers/usb/gadget/f_acm.c             |   20 +-
>>   drivers/usb/gadget/f_fastboot.c        |   10 +-
>>   drivers/usb/gadget/f_mass_storage.c    |    5 +-
>>   drivers/usb/gadget/f_rockusb.c         |   11 +-
>>   drivers/usb/gadget/f_sdp.c             |   12 +-
>>   drivers/usb/gadget/f_thor.c            |   19 +-
>>   drivers/usb/gadget/udc/Makefile        |    1 +
>>   drivers/usb/gadget/udc/udc-core.c      | 1096 ++++++-
>>   drivers/usb/host/xhci-dwc3.c           |    4 +-
>>   drivers/usb/host/xhci-ext-caps.h       |  158 +
>>   drivers/usb/host/xhci-exynos5.c        |    2 +-
>>   drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
>>   drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
>>   drivers/usb/musb-new/musb_uboot.c      |   39 -
>>   include/dm/device_compat.h             |   13 +
>>   include/dm/read.h                      |   46 +
>>   include/linux/compat.h                 |   15 +
>>   include/linux/usb/ch9.h                |   25 +-
>>   include/linux/usb/gadget.h             |  520 +--
>>   include/linux/usb/otg.h                |   10 +
>>   include/linux/usb/phy.h                |   56 +
>>   43 files changed, 7659 insertions(+), 4091 deletions(-)
>>   create mode 100644 drivers/usb/dwc3/debug.h
>>   create mode 100644 drivers/usb/dwc3/glue.h
>>   delete mode 100644 drivers/usb/dwc3/linux-compat.h
>>   delete mode 100644 drivers/usb/dwc3/samsung_usb_phy.c
>>   create mode 100644 drivers/usb/host/xhci-ext-caps.h
>>
>>
>> base-commit: 0f865ab5d68484b4dc1724809de1be06edc85df1

Why is it based on such a old commit ID?

Thanks,
Michal

commit 0f865ab5d68484b4dc1724809de1be06edc85df1
Author:     Tom Rini <trini@konsulko.com>
AuthorDate: Mon Oct 20 13:55:08 2025 -0600
Commit:     Tom Rini <trini@konsulko.com>
CommitDate: Mon Oct 20 13:55:37 2025 -0600

     spl: Restore args file being default in falcon mode

     When falcon mode is enabled and SPL_OS_BOOT_SECURE is not enabled,
     restore the previous default behavior of having an args file be
     expected. Platforms which are using a FIT image here and do not need
     this can update at their convenience to disable this option now.

     Fixes: b1a3ed068869 ("spl: make args file optional in falcon mode")
     Signed-off-by: Tom Rini <trini@konsulko.com>


