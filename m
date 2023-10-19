Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9ABCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71A9B87204;
	Thu, 19 Oct 2023 12:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UNYmzuO0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3879D86F8B; Thu, 19 Oct 2023 12:31:31 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B29DA87221
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0I8O/a2XTIbDnxG5rY+pB92gChqGZbd+8AKQsR2XHo57wozbeLo/6UFwvoNwgfSi8bdRXucJBTjaoy/+bH0gXTFFvm5h+kms9D7avl4iXaAmKgxnBk/TF+xdEm4hbDhyVGw90LZOS1XUfzWWoSLsuaA0vl0yQyFnmkaTq52xc9/G6tAfnqJ07Mhn7/uBwCWksBJEx2FDY0NhOJVzKsA+T7u+lmV/Whoqjudai7XBYmqHUa3M5GIegKzqr/7aYebf0dxhNahefS9UYnRBeEinc2d4OQslMtZu8FEJlyJ3AUhoVvfYJekThbp0TDUUe9dprz26TXgaafy4KdxIjTg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TIDkUHXT0MPICki5M5vn70J3/Ljk3sjm5lwq7x753I=;
 b=MNAbMyX+N0h7wyl5TjTx6u0nJpaqNRxtvZcnxgRodTrU90AW9QPNBVGyKzL2Rs9EJewDg1huQWgJz0pf0i5RZ4qHLuWyQ20E9cdbKysKtl8PmDsRT8F6Hr0kRGVOo6HhHuWEnSLE2v+/ZgQvv7hYtQbn5b11FYfPFaCCBj8Al1pODu9349+GG3kkbyTpX1aAyhttGT9CdOTGjhH6o5KVYIfEMVmmCS0CL4o2wq5YkOOth1uSfr8L8QADhSSYfFjeHwvbIqM3KIq8DpRYiTHeu8YqLIuBN1FXSGgoFX0wu969M7IktjxooWhKDcgxc2loKxrRv3OoOKnHJ2VpKXAS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TIDkUHXT0MPICki5M5vn70J3/Ljk3sjm5lwq7x753I=;
 b=UNYmzuO0OStr8IDfo2gvLACDOdMLbpUGilFXtZ2Cr0c2jZvys7To4H9E9vBW2uYxO27GqbaFIWcUdfHF2ZgdURe6TK2MRCOJn21MyPrW98CGyi5bEcxyq374LGxUa7/TC/WdFenNamOWK01FE6Q6FZq1/XY6q5pSTZnuvIrW/qw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 10:31:25 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 10:31:25 +0000
Message-ID: <22dc27ec-e754-4995-90e1-94699ec63c6f@amd.com>
Date: Thu, 19 Oct 2023 12:31:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Disable the lock option for mini qspi
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <374d6b3a46d19b7ee171dfe8071676098db93e25.1697117869.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <374d6b3a46d19b7ee171dfe8071676098db93e25.1697117869.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0066.eurprd03.prod.outlook.com
 (2603:10a6:803:50::37) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbc19d4-c5e4-452b-4e60-08dbd08e8b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IsQyLA8FLH/QV1+IqY2j4x9CAu5M9FDtIC60HykFOp05bWm4Gip0/o6A8DqOYoX9xVLyD5OZ/sN6AxQaI3Mv5IDlcruhZNh0kaYNsLI4MJnCaNMWQaCnakjZqM8wZAIP26boJgtbE6TBD93afkWHZgHJjHpF0sffQTHYjlnt8dW6XnnmEVM9I/N+TufiEheslgnjVKeigoV9X7MAdJDr51a+Dr8l57OuM3Ja6wDJHxBelWZi9EKTcFkQhTRsP0M84NWotkCvOz2WWKsNFfbsIX+hZ0EYceIY3FbStm6AdL8YYqnGYh/kxTmKDd8D2KlrDNkD4z8jZcu7Z+PbbbHa/LpuNJ/UDY9KwxjY0lDS+jfqjx70eKdy93Izfu5HvAXPZxwLunz12wBUkVJnjq3skmfXgeR8LgIfr+C9FvB4nRZiKKnOllayIv2F68PoahRNbupwE+viIujlqfaV5lZwy4znKC/SYEf5Fuyg4L+Xr2Q5p26iyXoiVEY9qSann2LA5Jrh4y1sCeSSDXRsZPpi8NN18+t0g0ZXpKzC1HC9VUQohLhqa2HcV4GOWixqJt2sdsnlocTbw+RnSwq0Nhf0Cn3yCmcKbjfumH209cX+huw/zmZjuQsRK2CfeSSdB969dbmcXuOUGP3XQ0ZaHJnUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(36756003)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(316002)(8936002)(2906002)(8676002)(31696002)(86362001)(66946007)(31686004)(83380400001)(38100700002)(478600001)(6666004)(6512007)(53546011)(6506007)(2616005)(26005)(966005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGRDRVZiWm15Rm9OK3lmc3ZBTXZkL1RPUGxWNkd6SU5UZDF5U2xkdlIvUkg4?=
 =?utf-8?B?N3FMQXFoa3prNGJWODMwYm1EazNHclJnUjRxd05rM2FsTm5DWjRlSEtreXh2?=
 =?utf-8?B?dlk5eGRTVithWThucUV4TkFyMTEzNmdESzY3UDc3c3l2M2NRblZhZTV6Z0hk?=
 =?utf-8?B?Yy9CWFJXb0VuUFd5a2doQ3dPNE0zM05PNytaTm9BTDNQRTE2RVY5eTFRejIw?=
 =?utf-8?B?b0prS2NtNTdsbUtQaS9idGdYNmJaV0dBNHFVeUlBOE0xSDZ0L21wNGpxc2Ur?=
 =?utf-8?B?eVdvZ29mUnlBUHZnNzJJc3RBcTh6cVA2RkplbmlscG1uVy91bzlpNE95aE0x?=
 =?utf-8?B?dVdYQWtrK011YmI3K01QNUJWcDRLcXNvVzFkZ2FkY3FSeTNtQTR0RmhucVhD?=
 =?utf-8?B?QTZ6ZTVzandJeEdUeHVNRElkNi9yam9MbnFQbFZMamJ3QWpWNlNBVHpibmRN?=
 =?utf-8?B?YkdKeGZzdzZ0eHU1NlRhNjZSNGpwVlNjTXcveVBjMkdRenNtcWJxM2VTUE94?=
 =?utf-8?B?SkFVWFZMZ3dmRjdDb05TSXdyQXVFY3NLTithbTRqcjNhRnFSTXI4Y2lMQ0dZ?=
 =?utf-8?B?U3A5anIyVHhkZ0IrZlZJajJJa2dFZ3RoYkhFMkdVMnNKcXg5ZFZHdnAzTzk3?=
 =?utf-8?B?ZllESkV3RkdFMnEvMEYwVStpbHV0RkljVGZlalJremloRTUvdXJISzZoQjRx?=
 =?utf-8?B?bzhTZWlwcE5sdzVWUGloQU9CMVBDaVdUOVhiTlFkbmFJV3VTS0p0ZWtyUzRa?=
 =?utf-8?B?b2FGMnRRVFN2KzJFY24vTDZNL3JRZVpoYWY4VWpCQ0lnUEtIL3NyRTBRVW1u?=
 =?utf-8?B?UGRxZnJzZ1l0djhBMm15UDVzSTNCcGIzWCtUaUxkbVgrZ2ZGQXU2RFp1ZWhC?=
 =?utf-8?B?MWlqSGc3ckR5ZDZyNnlabDJyN0VlQ3FrRDVRcWdDVmxOMHpmZFM1SDU3NGth?=
 =?utf-8?B?Z0VySnk2UjZreXZYYTVwbVF1Y1hWZ3BQMnlKK3VlYVlwUmM4b0hjU1JSUnhB?=
 =?utf-8?B?Yml1NXJxMGtXNU41Uk5mdzdmSGd0c3pPSlFYdExLeFJGUjRRNGErVjdpUmRa?=
 =?utf-8?B?Tm5xbU80cGVkL1ZGV3ltZmpxYXlWSzl3RCtaTlZYZ25MQy83ZDNtT0pmbnBm?=
 =?utf-8?B?R1dEV0VGUFY3dTJ2UTFLcjdvMEhBdWlyeW4rcSszZXFhV1ZRSWNNY3RPdk5P?=
 =?utf-8?B?V3FGeWE4OVgzK3IrVTFJL21zR1hjS05UQUVnVWJNSTY3elRDTzJJSy96ZmJP?=
 =?utf-8?B?WUFERCt1VEgwZ3RRYlVUd3ZwZEEwWXZvaW9qRXBma01WbVhQVHRjNDhGcHFz?=
 =?utf-8?B?Q05GdVBTVGdqYUF5WTNrV0RhYmtmZFFIY2hBZTVFWVByZ0NpbDA0eTRCTjho?=
 =?utf-8?B?YTNKT3BHZVg1VVRhNWJMdCtEZ01KZ1VIRzhPbUQ5NjhORzdpL0R4Vjc2ZExB?=
 =?utf-8?B?V2J0R2V0cXJ5S09lbUJIaHZLR2o4Q0JQdkdHV0JGeVo1dTl5NE5HS1NaT055?=
 =?utf-8?B?UDFselhlUWxPNHhxMDQrdTJrM1dvcFpaVjd1S0x6V1JzVGFadDFlSG5hVWRv?=
 =?utf-8?B?dU8vNFluRk16cUhGUDZyZDBFemlyb2QzV3B6YkNtYkYzUzA3SGl3ZmZzcHRh?=
 =?utf-8?B?eFJQb1JuN1ZSL2lhLzNLc2M4WTZSZ011WnNCbHpib1B4LzRRNGUrQmF2MzRF?=
 =?utf-8?B?U3ZzK3A0MUdZMXdDWFY0TjRuQk9CVklEeUFrcWRISVRPM0lhNVY5VWU2azN2?=
 =?utf-8?B?bEx1SWw5azdqc2NrU1dva2d3ZTFtSDErT0swSUE0bGovOVZGTjEwSjJQdUlv?=
 =?utf-8?B?emZzUE9RcjRPcnp4b0o3UU85TXE1cXdQcHRzRWdUSUY0TzMyM3ZTSW5KOUZD?=
 =?utf-8?B?YUQxUm5HQTNvbjJ5d3ZMOGFrdHA3SFcwd2dIM2U1UnJzSnZWUjNMZ0YrTU5s?=
 =?utf-8?B?bTdTNmpzRGNXdDJtWlNZNFZ0YWdWUW9pVnU5M0tWOXYxL3JnQ09nRXdGKzRz?=
 =?utf-8?B?b2hTL0hjYU9ORTNyVDhmNDlldmVUTTYyQ0FnbDd4UmZGSk9QYXZKYVVYQUND?=
 =?utf-8?B?dmpHaE9qTnJrWGk2b3Q0a2Vwcy80MEI0dU5PZzZ3bVVBUWJmV2xXanhudTdw?=
 =?utf-8?Q?GVgExMATMU4oRJfhaXPlG6IYA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbc19d4-c5e4-452b-4e60-08dbd08e8b94
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:31:25.1597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYKwmJy1ll2/Z24DJuHICW6RjcadlxnvzxIaGW/wFcRPWcYiw235JEG12/V6ayPI
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



On 10/12/23 15:37, Michal Simek wrote:
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> 
> As mini configs are required only for flashing the images, so
> disabling the lock config which will save nearly 6KB of memory.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Depends on
> https://lore.kernel.org/all/20230928034940.2220-2-venkatesh.abbarapu@amd.com/
> ---
>   configs/xilinx_zynqmp_mini_qspi_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
> index a1adfb9e5d14..4a74ca76a281 100644
> --- a/configs/xilinx_zynqmp_mini_qspi_defconfig
> +++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
> @@ -77,6 +77,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
>   # CONFIG_DM_MAILBOX is not set
>   # CONFIG_MMC is not set
>   # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
> +# CONFIG_SPI_FLASH_LOCK is not set
>   # CONFIG_SPI_FLASH_UNLOCK_ALL is not set
>   CONFIG_SPI_FLASH_GIGADEVICE=y
>   CONFIG_SPI_FLASH_ISSI=y

Applied.
M
