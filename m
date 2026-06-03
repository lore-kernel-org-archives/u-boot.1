Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16EACD6E64
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 09:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ACA383FF5;
	Wed,  3 Jun 2026 11:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="sTyEnRGZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5E0E8486B; Wed,  3 Jun 2026 11:03:35 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D17E83EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 11:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyng9zz9w4IQQhZWVzXp0Js9GHSpoJREsxDJtVAVc2hZN5Paw4qqQI2eX4knic7pTvLaE87j8FYzpMLgmJOct6AMT22MNFNoIovsdLIz3l54/aHzgnQ75mTD6gXS0HAxpxnZMXoPQ1Ny8rnHwq1thdPTDFQIU7wRckTv1OQq3tezqfbhURbaeQabpYDU/30/SJ/44b7/g8RQl4b0Wxg4d6vBVWBZIlLWbUQrdOgpma0GOn6XDGqhRju4+7sFb/v7rxXuzP8jKTJzdtEAoUedUinE1hg3PvbLIanJr4167bvJyDhUkiXadJVgTg0/3AvjgB5sYCWWvhzo29lswz9OWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHUOL0rZ7XIU0RgYPIvrmaOE6R0EUnBBywnDlN+9rPM=;
 b=QVJXdrWgHLEEEClbFnMNk9GIpmVjxxWOdM7PQ/AU1Jso77OmJAnb9u+HJl+liBmKlAineqQI0HXfv/NrfuTXjl2fGYOCd8siQW+7AYQoyUK+58XXzGk7DYu6TOysLuT0pO0g0WVG2sVXLTcgG8T/BXxoa6NBfg7T7bbs6ye1Gj/WIdYwANkTzHOEdxbLH+qjxttjpe8kM08YY70PeZms9nQIeQRe6BDnooLaReTdcqI0EnLSmBZb+imOc08/VABGLNqU8dJZq9zYFB6dPeBXhAN3tYJ/wwsEl3kB6uO8N7QQ1DRx/Yk76zcHH3URVi3I6hvFiZbABBYmwzHiRIvLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHUOL0rZ7XIU0RgYPIvrmaOE6R0EUnBBywnDlN+9rPM=;
 b=sTyEnRGZpd61gbDTYKTLm3qwFdqfLjCnQQd4e+qWlIbzy9NyhX1F3hepoI4tM6oZWlzpa3VmscQ/uI5fGEIW2TZmvRw2wJQD0q4xelEn2jKQ3dr8uAGp7QistawU77MA7YpdEjazd/urTvMb+IHnOMfaC5xOcVG28lrJE5yljBAuJudiCDQgS+j/0yQUijicxQUvgmMwPiQXk7L4A5ERoPEXu53dqDfeSngdLkhpuqKM5RKdqnVqqjftkJfmmIleKyvHpgrqo2AH/WPZP3+qMMShWztHBHFovd3T7AGmgZ73sW3DyMy5UDS7WjVCU1o5V26hwGhOkDS/xcbGkHngmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by PH0PR03MB6429.namprd03.prod.outlook.com (2603:10b6:510:b4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 09:03:26 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 09:03:25 +0000
Message-ID: <3126232b-ee1e-4571-a068-3b02274b3833@altera.com>
Date: Wed, 3 Jun 2026 17:03:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: socfpga: Add MDK support with external GPIO
 expander
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>, Tze Yee Ng <tze.yee.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
References: <20260521015313.19663-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260521015313.19663-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|PH0PR03MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 2938b1c1-d849-42ca-26b1-08dec14ef88b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|6133799003|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: i4k4xz3Uz0Axc3Hm/RFdpqy2VqYO8CHeRBzZWbnRsa96nCBtDfJFlj8TltSWBx3PWjaHTXifV11w7BwZHK2J8GOA+2kUvNgmE0MHQFoOWz7dLxU5YIA14l28P47AYMlvcODO6MFtrrKAFZamIHC0492QvmPKh+cZ2tQSyo44N0Q3ZJCfqBJtv8HgdoT9OHDrA12sCXTtvaufESNgp++TqvxXEO/CAbxhFkem8IjqW6F+bL9S3QbZykNkm32owUqlPeN9kHMxypSCRBB06a7mkHb99fVciM8Dl6CSUNIOh8wp5I8cFify/QKIoNgQ5/HblKacNpo5gjPFEza052xiNRraZSbwZcUGfgyemAZQ3yB/kuCExmZ4BTcXW4H97w2ISzPZI2o3/60TPf5AGMjtxmtJRuf2V/f532HWtsgE/amvWc2X89AZAnsJXWbQsQ+uuzkzZUxwiH2YZLgt+keMPQUFT7/mrOdDFcgH2NHejjlelq8MkjK2wNdUhv6J9yx7thjN3CEGETP0Vq4EhGxDcLpMgyRRtuBvPwQxwRYqrs69ozSqmzZ/BSUb7JLZUZNxxSCtcYwuZXZdJ2lRR3h+PGZPg9bMWEFztzqR687Mi7JsPXM9tM488oFvrCCJ8MOniRDFgk1lHWhMqwKGpMFmeKEzgOWSKW2sXzu+SPFeARpJYY+E/ekEVnSGHS06nqPJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(6133799003)(18002099003)(55112099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHI1NjFXSzBtTDVTNjg5bkYzT0Z4MXpubUEwOWIyeHpmcGMwSFNXRXBMZHVj?=
 =?utf-8?B?RUpVTHgvdkxDT2MwK1pPRkc5b2Mxa0VNeTk5LzRvN1EyYlZBdExtMnU0aGZG?=
 =?utf-8?B?VFlsR1dSdVpPOVFCMElzeHp3UjNpWVF4UUplOE9ra2QxTlkvN09qeWZJVkZa?=
 =?utf-8?B?OE5rYm1VU25QRDN3L3JGaHdRRDc0QlJKajRMaE15MTJQVml2TmYvcjZUdkxo?=
 =?utf-8?B?QlRjd0tNRm5uVXFxMklYZ1E0b2k4d3VITEYxbDZmRmIxR2hOc0VXOTU3NXpz?=
 =?utf-8?B?UmtrekxQc1pQbEJKSkI1VngrTDdRc3NhNC9hQUFTMjJITnk2VHFSRDZ1LzdH?=
 =?utf-8?B?eGFXRXpZL0lMU3ZBSWt0RjlnZ1kxWldGRDlWZ0xpOHAzTTZLbVdlS3lmVG1z?=
 =?utf-8?B?OWNSRlFlbDBLL3ZBNVBnYklVY2lUdEJQbDgyd2kyMnJadEdOWVdOZGdreURt?=
 =?utf-8?B?STRKa0ovUnJ2V0pWVzhrdTJEYS90VDJXTEN0NFBuZGNHK3JRMkRFWE8yVjVv?=
 =?utf-8?B?RnEzQXM2YVh6UkNBbUxxZ3VhbHY5M3hwbE9QUXpjeWt2L3hmakFBcS85Wis1?=
 =?utf-8?B?MlNWVk5TTTZJUnRKVHlRZUhYblBrNHJhUEQ5UWJJeC9YWG82U2dkWUY1NGJs?=
 =?utf-8?B?bjJzWVdGeE9EeGNiZzR4ZWFWTXp6RE5ISm1zdTVGTkNsYWFhSk1nVzJucm5J?=
 =?utf-8?B?VU01aDQvT0pFTjJVdGk0YUZSaGVteTEyNkM5ZUZlMkhCd3NFZ2xYTHhVdG5C?=
 =?utf-8?B?OXhNNXd3K1F2TFF1ZkxHWDh6YkVrSWVmbzRZajBld1NOQ0s5d1gySW9pS3hY?=
 =?utf-8?B?bmtZb3R0WlhXOTJQNnNMdU9adDNhK1NMZ2pSVFJZSTZRVlhKMUY2S1hoWlox?=
 =?utf-8?B?ZEJnN0lqZGx3UXF3cGsvVEpUaGF1T2syVHo1MGlMZjlhUE56Ui9sbkU2TVMy?=
 =?utf-8?B?TmRZZFZucmQ3TzUwMHpCMXJLSG5YVnlRN1dJdXlPZjRORGxCYzVhTXR6Wml6?=
 =?utf-8?B?TVNMcGpCdnVmVTI3VE1GclRHWnQ5Zkd3Ni9RSmJld0hjT3NOSmZFclRQMGI1?=
 =?utf-8?B?N21KOG0ySFUrVkhUS290Q05WYlRzdnk5Mis0OUhxcnVrZ1JVRWNvUmRqaStU?=
 =?utf-8?B?TFIxeG1DTGdkdmthMEZYZVoxM3V1T1p2bXFYZVlPK1JjU3RlM2JiNWQ3bUdP?=
 =?utf-8?B?Rm9LSkhIWlNWcHFBamVXK0tGTEZRV0hacDRWNE1UZnJERUpmeHl0VE9RWXVQ?=
 =?utf-8?B?WXRSU0sxUUFkSUJjRTBxcDRvMjZqV2FEWmJkMnZQQnJOMWNmWlY5emtSVlFz?=
 =?utf-8?B?OEE5UHdEaXllZ3BhdmtXdUQ4S3ViWmxLSWNtYStRVzRmVUhSYWtaVkR3aHFP?=
 =?utf-8?B?K0htVHNxNjM3M0RzbVdQamlYMmtyblBSdlpKQ1BpRHBpVDBWZVFXNTFLckVp?=
 =?utf-8?B?NlJvUEpOeHdXWW5ISEx2aW9Bc0JMQVVnckY1eGo4WG92V29oWHZaditaNlZI?=
 =?utf-8?B?U3U3M0Q2d3JxNVQxa0Fjc2NFMTE5SHlxRkc3ZFplWmlxNW5rYWpRRHk5aGs5?=
 =?utf-8?B?RWJBYi83V1U0WHF0Q2RiOHdaTEViWXBUVGNPTXlxbUdyRkUwdGpkNmJINkp2?=
 =?utf-8?B?R1BTVXJEenZlMmNaeFhYSjJwNDVmQzdUSGo1Nmd2S3lXQU1zQUo4Q1Q0cU9a?=
 =?utf-8?B?RHZMZnhMTE9CWkxFbzB1ZlpyeUN0TlQrT3poN1Z5UEJqdm15ZjdTRWJ5R1Jm?=
 =?utf-8?B?d2FUVHNsa2pQQWFLZHlBWHpQbEZmZDhGNkhxb0d2dkdoOHZJNFhYb2VYT3FY?=
 =?utf-8?B?K3ZYL0ZqOWI5ZUdzKy96Z0Vza0NFOGVTMkxnb0RwenRjZ3UvbWh2dVdqczdp?=
 =?utf-8?B?MUJJL210MW9hYVo4eW92QWZFU3RuelFlZGRjM1NwUEY1bGFtcmdZaXY3Mk1X?=
 =?utf-8?B?NWtQOUovTDEvVlJHNXl5ODg2TFNNQmpWbGNDOVVpRGtoaTU3NjVRRkVSUGNy?=
 =?utf-8?B?alVMTUpPWWxscmhiZW9scTkxM3JKcU1ua25NWStESGovYTl0K2lad0tjV1Ni?=
 =?utf-8?B?TkJiMXhTSUJjN2MxSHhsbUhkMGhLRmp2YVpYYm01cjBha2ZtWGwyNThGNVhm?=
 =?utf-8?B?Umdra0hadmorVEl4Q1RTQ3dYSG92QnJkN0llVzFhd083ZTJ1ZWo4SE84NnQ3?=
 =?utf-8?B?akVPVE9lWlhoWGh0cXREU2VFWUY4SVV4YldORU41eTNoSDlUd0YydTA1Uysw?=
 =?utf-8?B?aVJsL01IYXRzS2JSL0JFU0NVUnd1Zk9aeEVnRFppQ2pTSytSKzVNQnpaQnNH?=
 =?utf-8?B?Sm44UjZyM2Z5NWZDWC93eEJtZ0d5cFpxY1grd0hVdS9PMVIxVy9hT3RXMk53?=
 =?utf-8?Q?Ok/vXWqbkVtUBy6A=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2938b1c1-d849-42ca-26b1-08dec14ef88b
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 09:03:25.7123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgApXofUcdLH7XvJSMnhVv/dYNvJkQH+L+ix7QSiV6qBF37VvujoumFA/q9GYacgjL+I8lQCaJd+/8q7IcoahQq6KHYpFnM8MHVEOgb91d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6429
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

Hi Alif,


On 21/5/2026 9:53 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>
> Add dedicated device tree and configuration support for Agilex5 Modular
> DevKit which uses an external GPIO expander for 1.8V signaling control
> instead of the onboard GPIO used in the Premium DevKit variant.
>
> New files added:
> - socfpga_agilex5_socdk_modular.dts: Main device tree for modular board
> - socfpga_agilex5_socdk_modular-u-boot.dtsi: U-Boot specific additions
> - configs/socfpga_agilex5_modular_defconfig: Modular board configuration
>
> Key differences from Premium DevKit:
> - Uses PCA9535 GPIO expander (I2C address 0x27) for voltage switching
> - GPIO expander pin 1 controls the level shifter for SD I/O voltage
> - Requires I2C3 and PCA953X driver support in SPL and main U-Boot
> - Same SD timing configurations but different GPIO control mechanism
>
> Configuration changes:
> - Enable CONFIG_SPL_I2C and CONFIG_SPL_SYS_I2C_DW for SPL I2C support
> - Enable CONFIG_DM_PCA953X and CONFIG_SPL_DM_PCA953X for GPIO expander
> - Enable CONFIG_DM_REGULATOR_GPIO and CONFIG_SPL_DM_REGULATOR_GPIO
> - Add TARGET_SOCFPGA_AGILEX5_MODULAR Kconfig option


commit message must not claim TARGET_SOCFPGA_AGILEX5_MODULAR, not in the 
diff

[...]


> diff --git a/configs/socfpga_agilex5_modular_defconfig b/configs/socfpga_agilex5_modular_defconfig
> new file mode 100644
> index 00000000000..3f3a47f02ab
> --- /dev/null
> +++ b/configs/socfpga_agilex5_modular_defconfig
> @@ -0,0 +1,9 @@
> +#include <configs/socfpga_agilex5_defconfig>
> +
> +CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_modular"


configs/socfpga_agilex5_modular_defconfig sets 
CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_modular", but 
arch/arm/dts/Makefile does not list socfpga_agilex5_socdk_modular.dtb

make socfpga_agilex5_modular_defconfig
make arch/arm/dts/socfpga_agilex5_socdk_modular.dtb
→ No rule to make target 'arch/arm/dts/socfpga_agilex5_socdk_modular.dtb'


Best regards,

Tien Fong

