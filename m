Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDD7CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F78C84B52;
	Thu,  7 May 2026 11:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="F3LHP9Mw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D07284B73; Thu,  7 May 2026 11:31:38 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E5A84A6D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iey0g+wIp7qlUK1PRntvkpUHnVLNfCKJBOFJCqJSPVUuWKnbqfxTeMnG+Qxf83arn5tVVXx9AyLZhUo9Ph5N97QChVJDUcH6stYkqE10lJ7HVQDW+anEyi6VUoF8IHlq47gNJnMIUa60zx7fjwNAl0V5DfzJY12aagafJvHseDSyA2w5MF3/s8QDik3y8qpq3EOtxbgavjhgs+E758YECYiNqafzGhzffXPesK7HAfhlKL/RdLpcuiupxtwTwVyEZz3ii+/jMjLf6VjfwOeBI4aZUOLUqPKqARCNq3Mn8iGjMOouwjIUakhjY0tqza5+WNhJuY7SBAsyJ72ueAs0Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qjbs6uMsL/RHtZspDz8h3qbOB/g92WTbZSYHLUgdkJ0=;
 b=wZCFxFpc+CBT6wxXbWGlocDxdGpLPdoXPasV+YYQGojVXN+mc0ffpus1EwVq9rbXS31j3+7cpd9a0Q33kc8V5lL8smf0nhmrUG9INeHuIQYzsiEnRIN+QLyvpbYk9ylrb3F+wBUYr8n3xjuwSri3ev+n3ml7NttxMdn+BduJFN0LSdgCuX8kTd+J1Xp/w24Gjtw134SbPghkeb+vw03Wydqo5Oy6+2tLDiZvcbfU0rE/Vn7DcaqqBKAPnoScUV5WJ5Vo56Uy0AaORmK1A+k1kmN7mz9U2M6cEoXj59G/CM0+qOEAhUyyvzlaTp25Nc2c0pp4ij8DrOnHXT8SkwH0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qjbs6uMsL/RHtZspDz8h3qbOB/g92WTbZSYHLUgdkJ0=;
 b=F3LHP9Mw6hlNjN5lXmD/wQJtqc0OwhlCR4rgiuqoIrQtKKhO/fcxnINC4atS0Dq1EKDb55yf+1biRQWHsflbSokoWcj0IyWOBok0TmLS+PS4XzyBi0g5wyR8EGo4tDoUf4/spaYV6FHgtksP1igY0NECokxJg4Zq8cYWskjxAXcMppxmg6WcnLKQMwOdO1dR2JWF0RvijXopYjLfej8vnysoo+MUSHiSqN980Uo746rdSbh/dK0eQleW7JU2pWAlehECyrsKs4mSlry5qslq9ef1x+XRDv223DM5vPZMPB2rbN9ndLdv3yl6+cMmWPUFN6C+qd6HnuDjsA8v7x+5Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CO1PR03MB7916.namprd03.prod.outlook.com (2603:10b6:303:276::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 09:31:27 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 09:31:27 +0000
Message-ID: <c569f03b-1383-4771-8169-99eb611d3f5d@altera.com>
Date: Thu, 7 May 2026 17:31:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] configs: stratix10: Combine defconfig for all boot
 flashes
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
 <20260428034822.23756-3-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260428034822.23756-3-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|CO1PR03MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8b2f73-252c-468f-2389-08deac1b68d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: ZnkB1e44NNlXkhj/oh6qPtNtxcrBzxVk/v7hij9zzLS7crz0IGXIO2ZjVqOuNuVqtHs6kfe5GA3upF/zj2Y0Zu0TjhrhpC+SqUmEdeJvY2Cv1YOhJAFfxaFYisp+aBnI9h+C1lirbuMA6C6qH6b2xSX3MW6M6FXQNwPikdzgcGmelnl609lYdWicXRjmO49lANLZd5/z83JGt1nC/qBQqLWEikE7TBd12XfK0ktZmXRWf2nkUlwgRvRlpVFCyBSvFOnAIfOrXUWSQ9RIHqFJwhpm+I1CvF2RiICVNBueQgEgMFhiAh1pxkfiH7eV2YBvD2o6j9381fbx2KQ6h7vC5ftz8H/xHlbEsy0635GxL2RR7dvYG1iinZ+mZrTxiquWu9tYXQEMc7Sj+wZ+DJbOqmqCz/pbqB/DTLmyIrBFhrIdlxPOcfh3D+e+SkVI40awm6STtcjiYbNJtMHxyLrvGfKtx1bxXmfFoaenh945jB9U2IKa7oOF6D2oCV5lqJ0HEOEtgeUuQXQXDA8z/KvyG4Wmj4+x4bFjc+4nDZ8f1Q5QG6/C7uIPRkxB734n6Rv3wZ2cBui+I7KtMelKr8UOFRJL3u3mr7SX9sfho1DBPWaHdDn6esWsxyHx2JzJxHLupnIQxEiRT4kwca+mr5hxmRJdDeC0gLc9p/voFCwmuPpCdL1cSuZZxrp3EhAQrRhf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUoyeG9IWWN5ejN6clo5REhLZkRsVmJaY1dnb0dxMFdXYlZLK3ZLZEtRYnNB?=
 =?utf-8?B?NHdXem1ORDJ3aVEyU08rd2R3VFRneW0wenhkN2k1Y3V2YXBUZlNsUjA3Mkta?=
 =?utf-8?B?YXkrSmd2UW1FNmxDNlp3cGF3ZUVxbVcrdys0cjZNQTNWaldweWJvckxtN2s2?=
 =?utf-8?B?aFo1WjRFd2psZE1HcjBRay9LU2thU0JGS2tvU1FJRC9JZlVvR2tUWERvU2tI?=
 =?utf-8?B?QnBUc215RUE5SWs0OUVwZWdOSTNUOVN6STcyK2Z1aVJ0ZDYxMy81NmkyTkcv?=
 =?utf-8?B?eHdQQ1JoUzFrSEJESUNXMmZuZ3B1UHF0clNDTWt5N1ZGN3M0V3lxN3lOV1Z2?=
 =?utf-8?B?bUpjMHlUNmtKUHpBcEU1NVVaMlBmM0xsWHN5SHkxMmxUNWN5OWx6emRHMTNl?=
 =?utf-8?B?UWwzTzFZVEl4Mm5FYjc5VjZENm9RTTZVejdvSjdhWHNnK3B6ZGp3a0MvZ05o?=
 =?utf-8?B?WWFMVDRpeWVKSk15S2RGQzRMNHdNSTZ5eERsbXh3Ky9kSDdRWUY0cDRITGRl?=
 =?utf-8?B?V0Yxbko2cFh0OStlWEt1dlZScDJyK0I1RjlrOHVtZXJQaWFFYjVKSWRwVkpK?=
 =?utf-8?B?ZnpVYzFqVG1RbVkxMHJHMGhUdUwwMjRUaDBFY3lLT3JlbmF0YjJ5aTk1Uk1M?=
 =?utf-8?B?VlJONlR2bktXKzV0MzFvdjdDSXJybVlUbms5M3ppTmZyMi9NbkZvN1pjS1Yz?=
 =?utf-8?B?amJKM1VFeEhqZUFVanZhdzcycHlPd1VhMjlvbER2S2Jka2FVVk45Vm0rL0Nr?=
 =?utf-8?B?YXE3dWQ3eDRRYVB0cldxVlpuMC9OSFFiem15Vld2cWkrWFdUNGE2U0RiWm43?=
 =?utf-8?B?TXRCbG5tMHo3VnhIYlNDK2F4dEdHYnNadVIyUlQreXAxM2lYWnVxN3Bua1c4?=
 =?utf-8?B?bitQdVc0VVY3ZURpYkJxbzlGRXB5ak16V05Ub0d6R01vTnNoWVkvM2cxMmJj?=
 =?utf-8?B?VFdOWnJpaUtiUjVINk9tUWg4NnR4dm92OE12aDEySW9MTHpjVjNibTNKeVJv?=
 =?utf-8?B?cGtEUGlOMmRocjdQME5qMVJDRmtpbEFUVjhaakNpcTdnNXU0SW8vSkxnZXBP?=
 =?utf-8?B?VnR3OS9YNWhqWitvTkM1c211V0czMFArV0RFTFZLQ1VCSGJubkVMUnhIZFE2?=
 =?utf-8?B?QVJiNzMrUFFlWGUvS0UwenBqeWh2QXFDRnE3YmxtR0pqQ2ptMWNmVXlnZk1l?=
 =?utf-8?B?WmNmbUlCMTJLK1ZIeTZMeWtWOFFrQTlzY3pZbnhSc3RjUEE0ZWhtMUg5ZEFQ?=
 =?utf-8?B?MGl3azZ3SUhxSGF2VjRCQlA5OElINWhuNmVDb0IwWWVOVU4wbUxCeGxBY3Zq?=
 =?utf-8?B?V2lHaUxUdmJQQldZODkzSlNEcDZjemtpVm5XZ3pmWkp6MU5MSHA2dUhZS3F5?=
 =?utf-8?B?VnJ3aTdqd1dtb3dJUSs2ZlU5amFRRFNUa05Ia1NnbGhsbnVuTkFBT1piOEIz?=
 =?utf-8?B?ZXlNTmtJSVdvVUdJR25EamxjbkV4M1lhYnpZbHU5ck41VTVsQlZRenJPSlBp?=
 =?utf-8?B?d2t5QlFuWHRnTU1lTkhGWHdWRXY4Wkg5U29vd0NMWnlrUG9DRDdtOGNTTHNn?=
 =?utf-8?B?ejY2eTV4N29FVEJKZXZJb2YxcTEveE4wMk5OY0RCdVBFV3lBZUVPQS9WSitm?=
 =?utf-8?B?QkhISWhlMWRHUWoxVmErRnBlVXY1TmhLSUF3N1ZLc0hUOVIyeVZBMG5iZDFS?=
 =?utf-8?B?bnJXK0ZSOFVXYzU5cEdFbmg2cUR3NzBSbksrcGRWOGVuSlVhckxvR3pEazdI?=
 =?utf-8?B?Y2cwcEpYSXFkdFhIUmkyc3lHZVN1LzBxMWExaDYwY25hZCtJc1dYS0RFQmpC?=
 =?utf-8?B?ZC90cDJXSDIybXo0YmhxR2lQLzR4T0FGaEZEM241SE5Qdm1pMW92WjlENlBB?=
 =?utf-8?B?YlhJODk1dWFWVnRvZ0xoanpQeWNjVlczTFUzekU5RTJhZ3k3d3VZNkZ4eVRl?=
 =?utf-8?B?eFU0Y3A3NlpkTzh4VTlabXhDbk5YelBULzczdk01RnRzUys2N0dDRmJmK2Vh?=
 =?utf-8?B?UWwvS0pONTJ6WEhyaWxkdlJ2aFdOdWEremRyb0xkQ1VVTmo3VEZNWTd1bjNh?=
 =?utf-8?B?Z1luenlsYWt0TEZUNEQ0ZGc2amduYksvbWNXT255ZGM4WEFvOG5XT2p1YnhD?=
 =?utf-8?B?bHVpQ2JqckdETU1GTFlDS1VSNWNlUmx1TnlJcmFqWS82TGZUb2s2K1Z5Vncx?=
 =?utf-8?B?bVBGTi9YZjlTVjlzZnJ4KzR5a1N0cXo2VWZ2TC90WmlPdG9YVzVISXBVOUI5?=
 =?utf-8?B?cE8vQnFLQW1jUkJJay9ESnQzRm1CMDVkS1NPNUVqTWhlS3h0MjhUTlp2Qnln?=
 =?utf-8?B?dVpxKzNnMExKMVUvR0p6YkhueGFPVXRBc2Rqd0NFa0RBYWl0M2JNdGRjb0pm?=
 =?utf-8?Q?Tl86+spBoECd8MAY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8b2f73-252c-468f-2389-08deac1b68d2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:31:26.8737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: td501m3b1LO7/yomM0xB47zJd70X7L4wehVFaojC0IgBopLe0e0U7fChlEm9VGbR6hNDRqvyXQRim6JsYfWdqVcTyXfaYIKblmBYs4vW228=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7916
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


On 28/4/2026 11:48 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Combine all MMC and QSPI configs into single defconfig which is named
> as "socfpga_stratix10_defconfig". This will be the default defconfig to
> use.
>
> This will support booting from all three flashes using ARM Trusted Firmware
> (ATF) as the secure runtime monitor.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   configs/socfpga_stratix10_atf_defconfig | 90 ----------------------
>   configs/socfpga_stratix10_defconfig     | 99 +++++++++++++++----------
>   2 files changed, 58 insertions(+), 131 deletions(-)
>   delete mode 100644 configs/socfpga_stratix10_atf_defconfig
>
> diff --git a/configs/socfpga_stratix10_atf_defconfig b/configs/socfpga_stratix10_atf_defconfig
> deleted file mode 100644
> index 206343885d9..00000000000
> --- a/configs/socfpga_stratix10_atf_defconfig
> +++ /dev/null
> @@ -1,90 +0,0 @@
> -CONFIG_ARM=y
> -CONFIG_COUNTER_FREQUENCY=400000000
> -CONFIG_ARCH_SOCFPGA=y
> -CONFIG_TEXT_BASE=0x200000
> -CONFIG_SYS_MALLOC_LEN=0x500000
> -CONFIG_NR_DRAM_BANKS=2
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
> -CONFIG_SF_DEFAULT_MODE=0x2003
> -CONFIG_ENV_SIZE=0x1000
> -CONFIG_ENV_OFFSET=0x200
> -CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="socfpga_stratix10_socdk"
> -CONFIG_DM_RESET=y
> -CONFIG_SPL_STACK=0xffe3f000
> -CONFIG_SPL_TEXT_BASE=0xFFE00000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x3ff00000
> -CONFIG_SPL_BSS_MAX_SIZE=0x100000
> -CONFIG_SYS_BOOTM_LEN=0x2000000
> -CONFIG_SYS_LOAD_ADDR=0x02000000
> -CONFIG_TARGET_SOCFPGA_STRATIX10_SOCDK=y
> -CONFIG_IDENT_STRING="socfpga_stratix10"
> -CONFIG_SPL_FS_FAT=y
> -CONFIG_REMAKE_ELF=y
> -CONFIG_FIT=y
> -CONFIG_SPL_FIT_SIGNATURE=y
> -CONFIG_SPL_LOAD_FIT=y
> -CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
> -CONFIG_BOOTDELAY=5
> -CONFIG_USE_BOOTARGS=y
> -CONFIG_BOOTARGS="earlycon"
> -CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="run fatscript; run mmcfitload; run mmcfitboot"
> -CONFIG_SYS_PBSIZE=2085
> -CONFIG_SPL_MAX_SIZE=0x40000
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_HAVE_INIT_STACK=y
> -CONFIG_SPL_SYS_MALLOC=y
> -CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
> -CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
> -CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
> -CONFIG_SPL_SPI_LOAD=y
> -CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
> -CONFIG_SPL_ATF=y
> -CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> -CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
> -CONFIG_HUSH_PARSER=y
> -CONFIG_SYS_PROMPT="SOCFPGA_STRATIX10 # "
> -CONFIG_CMD_MEMTEST=y
> -CONFIG_CMD_GPIO=y
> -CONFIG_CMD_I2C=y
> -CONFIG_CMD_MMC=y
> -CONFIG_CMD_SPI=y
> -CONFIG_CMD_USB=y
> -CONFIG_CMD_DHCP=y
> -CONFIG_CMD_MII=y
> -CONFIG_CMD_PING=y
> -CONFIG_CMD_CACHE=y
> -CONFIG_CMD_EXT4=y
> -CONFIG_CMD_FAT=y
> -CONFIG_CMD_FS_GENERIC=y
> -CONFIG_ENV_IS_IN_MMC=y
> -CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> -CONFIG_NET_RANDOM_ETHADDR=y
> -CONFIG_SPL_DM_SEQ_ALIAS=y
> -CONFIG_SPL_ALTERA_SDRAM=y
> -CONFIG_DWAPB_GPIO=y
> -CONFIG_DM_I2C=y
> -CONFIG_SYS_I2C_DW=y
> -CONFIG_SYS_MMC_MAX_BLK_COUNT=256
> -CONFIG_MMC_DW=y
> -CONFIG_SPI_FLASH_SPANSION=y
> -CONFIG_SPI_FLASH_STMICRO=y
> -CONFIG_PHY_MICREL=y
> -CONFIG_PHY_MICREL_KSZ90X1=y
> -CONFIG_ETH_DESIGNWARE=y
> -CONFIG_MII=y
> -CONFIG_SYS_NS16550_MEM32=y
> -CONFIG_SPI=y
> -CONFIG_CADENCE_QSPI=y
> -CONFIG_DESIGNWARE_SPI=y
> -CONFIG_USB=y
> -CONFIG_USB_DWC2=y
> -CONFIG_USB_STORAGE=y
> -CONFIG_DESIGNWARE_WATCHDOG=y
> -CONFIG_WDT=y
> -# CONFIG_SPL_USE_TINY_PRINTF is not set
> -CONFIG_PANIC_HANG=y
> -CONFIG_SPL_CRC32=y
> diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
> index ef21dc92493..02a1875a72e 100644
> --- a/configs/socfpga_stratix10_defconfig
> +++ b/configs/socfpga_stratix10_defconfig
> @@ -1,93 +1,110 @@
>   CONFIG_ARM=y
>   CONFIG_COUNTER_FREQUENCY=400000000
> +CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
>   CONFIG_ARCH_SOCFPGA=y
> -CONFIG_TEXT_BASE=0x1000
> -CONFIG_SYS_MALLOC_LEN=0x500000
> +CONFIG_TEXT_BASE=0x200000
> +CONFIG_SYS_MALLOC_F_LEN=0x2000
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x101000
> -CONFIG_SF_DEFAULT_MODE=0x2003
> -CONFIG_ENV_SIZE=0x1000
> -CONFIG_ENV_OFFSET=0x200
> +CONFIG_ENV_SIZE=0x2000
> +CONFIG_ENV_OFFSET=0x04100000
> +CONFIG_ENV_SECT_SIZE=0x20000
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x04000000
>   CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="altera/socfpga_stratix10_socdk"
>   CONFIG_OF_UPSTREAM=y
> -CONFIG_DM_RESET=y
> -CONFIG_SPL_STACK=0xffe3f000
>   CONFIG_SPL_TEXT_BASE=0xFFE00000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x3ff00000
> -CONFIG_SPL_BSS_MAX_SIZE=0x100000
> -CONFIG_SYS_BOOTM_LEN=0x2000000
> -CONFIG_SYS_LOAD_ADDR=0x02000000
>   CONFIG_TARGET_SOCFPGA_STRATIX10_SOCDK=y
>   CONFIG_IDENT_STRING="socfpga_stratix10"
>   CONFIG_SPL_FS_FAT=y
> -# CONFIG_PSCI_RESET is not set
> -CONFIG_SYS_MEMTEST_START=0x00000000
> -CONFIG_SYS_MEMTEST_END=0x3fe00000
> -CONFIG_OPTIMIZE_INLINING=y
> -CONFIG_SPL_OPTIMIZE_INLINING=y
> -CONFIG_REMAKE_ELF=y
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_FIT=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
> +# CONFIG_USE_SPL_FIT_GENERATOR is not set
> +CONFIG_QSPI_BOOT=y
>   CONFIG_BOOTDELAY=5
>   CONFIG_USE_BOOTARGS=y
> -CONFIG_BOOTARGS="earlycon"
> -CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="run fatscript; run mmcload; run linux_qspi_enable; run mmcboot"
> -CONFIG_SYS_PBSIZE=2085
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x3ff00000
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_HAVE_INIT_STACK=y
> +CONFIG_SPL_STACK=0xffe3f000
>   CONFIG_SPL_SYS_MALLOC=y
>   CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
>   CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
>   CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
> +CONFIG_SPL_BSS_MAX_SIZE=0x100000
> +CONFIG_BOOTARGS="earlycon panic=-1"
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set


Remove one of the two identical # CONFIG_SPL_RAW_IMAGE_SUPPORT lines. 
Regenerate defconfig with make savedefconfig


> +CONFIG_SPL_CRC32=y
> +CONFIG_SPL_MTD=y
> +CONFIG_SPL_MTD_SUPPORT=y
>   CONFIG_SPL_SPI_LOAD=y
> -CONFIG_SYS_SPI_U_BOOT_OFFS=0x3C00000
> -CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
> -CONFIG_HUSH_PARSER=y
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_SYS_PROMPT="SOCFPGA_STRATIX10 # "
> +CONFIG_CMD_NVEDIT_SELECT=y
>   CONFIG_CMD_MEMTEST=y
> +# CONFIG_CMD_FLASH is not set
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_MTD=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
> -CONFIG_CMD_WDT=y
> -CONFIG_CMD_DHCP=y
> -CONFIG_CMD_MII=y
> -CONFIG_CMD_PING=y
>   CONFIG_CMD_CACHE=y
> -CONFIG_CMD_EXT4=y
> -CONFIG_CMD_FAT=y
> -CONFIG_CMD_FS_GENERIC=y
> -CONFIG_ENV_IS_IN_MMC=y
> -CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> -CONFIG_USE_BOOTFILE=y
> -CONFIG_BOOTFILE="Image"
> +CONFIG_SPL_SPI_FLASH_MTD=y
> +CONFIG_SPI_FLASH_MTD=y
> +# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
> +CONFIG_CMD_UBI=y
> +CONFIG_CMD_UBIFS=y
> +CONFIG_MTD_UBI=y
> +CONFIG_MTD_UBI_WL_THRESHOLD=4096
> +CONFIG_MTD_UBI_BEB_LIMIT=20
> +# CONFIG_ISO_PARTITION is not set
> +# CONFIG_EFI_PARTITION is not set
> +CONFIG_OF_LIST=""
> +CONFIG_ENV_IS_IN_FAT=y
> +CONFIG_ENV_IS_IN_UBI=y
> +CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
> +CONFIG_ENV_UBI_PART="root"
> +CONFIG_ENV_UBI_VOLUME="env"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_ALTERA_SDRAM=y
> +CONFIG_FPGA_INTEL_PR=y
>   CONFIG_DWAPB_GPIO=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_DW=y
> -CONFIG_SYS_MMC_MAX_BLK_COUNT=256
> +CONFIG_MISC=y
>   CONFIG_MMC_DW=y
> +CONFIG_SYS_MMC_MAX_BLK_COUNT=256
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_SF_DEFAULT_MODE=0x2003
>   CONFIG_SPI_FLASH_SPANSION=y
>   CONFIG_SPI_FLASH_STMICRO=y
>   CONFIG_PHY_MICREL=y
>   CONFIG_PHY_MICREL_KSZ90X1=y
> +CONFIG_DM_ETH=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_MII=y
> +CONFIG_DM_RESET=y
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SPI=y
>   CONFIG_CADENCE_QSPI=y
>   CONFIG_DESIGNWARE_SPI=y
>   CONFIG_USB=y
> +CONFIG_DM_USB=y
>   CONFIG_USB_DWC2=y
> -CONFIG_USB_STORAGE=y


missing vs ATF defconfig, why dropping this?


Best regards,

Tien Fong

