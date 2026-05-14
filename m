Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE60CD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 03:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C6B484683;
	Thu, 14 May 2026 05:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="mFn+6xX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B13E58469F; Thu, 14 May 2026 05:00:44 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9EC8839D9
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 05:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/JQ/NE275tRifW63Ysfv3Md/D3lDZFJUZJoLU3Ov3Nm3oxOijM/H0CUJD0oaQbBpo4b3XKN/+uvYOpu7pZ+nBmCBYncyaIwa7cmR03vIF9hd7Yy/rb2fKBxORi3D1sshcdj575kiMS0FzPQUdN8vwopDc1T85B+fVp6fi/MW7NMATzv+ZorXH/6P0YH2UWcxVEpjlBz5YElvKtcNzqxGOR6lIidMj4yOUwsljgfbm8xaZ0/J62NpztF5/bUsOcSfpZ+Ib2775cGOMJCo7sz65c6PygHiwgp9cwr9o/RkZEyUDiNp9yj0F9KCh0wW2dVlgHOsczatzZYRTjLn577yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WBSaQzvpc2qCmLBB+yjzUmBnMWAw2u6dt8gtuS1ZEw=;
 b=g4kGA1833nxywPK83Ika26ijG3ed1lQAUQKWXXwk7XTQAMPch43UprJZP0iPbjAMQOdVJd8BEFOVASfA71TA+CwkVRuMsmTY6HrmxjFpJzvusra5u6ecvUCHWnYhtnVpvY9NGpWbonXTqDYZPlK6NSeb+/Ij2sdaEuW0buQkAVK25miPw9Va4kKyjdj83en/jE0rU1qcAhLbOFFkZ0tbXHaFw5oawfN21w9282CrWRNWCY0l+3+jqjiuj9sxvlhSuTDjwVNQK5HeLGWzPDa/lIMHlyxPT8p68S/KPkTv4EP4MSwe11mJFyjpNKqkTBlYzdh6es+xCDZ2L8gYjehw1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WBSaQzvpc2qCmLBB+yjzUmBnMWAw2u6dt8gtuS1ZEw=;
 b=mFn+6xX7FnmhyK4x7TM2WVbOTWEK50ArUitxn1PbBtqZbpeEJtjmJdiRfmY9B4SwSrG/EV/Ik8yxy07WJMu+dPP5+SYcUbcxCZj3o8fTsP+TLEJfXrTKF1ZVIcbvKtnIrAndxnAHCTcdEi64xpOd1ydvBhZtWBja+L7qfekmgKKTxmbMsb5PzvLZPPCtuvJ8VRe6Ay/BrwK9biM5eEbKQ7MeT9mHYwmvBZ5MzNGUdYrbG/F8I7QFrpSUrbqNeCa1XQY4J1ck8p49vAi7p1OBZR6gcEE7XeXcur1Gnt/ud0VvmRLf4X4T/7uAAusuq08eHpIi+pAdtaphBJuzJz+jFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SJ0PR03MB7025.namprd03.prod.outlook.com (2603:10b6:a03:4e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 03:00:39 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 03:00:38 +0000
Message-ID: <807f736d-bd47-4c57-84f8-98b509f27a34@altera.com>
Date: Thu, 14 May 2026 11:00:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] configs: socfpga: n5x: enable CMD_MTD and SPL
 SDRAM support
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260428070017.16807-1-chen.huei.lok@altera.com>
 <20260428070017.16807-4-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260428070017.16807-4-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SJ0PR03MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6604d8-fe8d-4b70-b871-08deb164fa14
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799003|56012099003|22082099003|55112099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: 4K/9B5BG+/vweimjaXDfesqNtfPqWhZKTrbMiiFsileb4IM3RUMY2PvlgPQSNTSuWXXNQxxPb/bR3saChd8YjYGy/vkq7ibp/IwTFRBYmNhUp5xKlcIIHtelPeow5EHmaAINfsaz/Z2L43pQC4TIz4861MbWZiRBjJN5Ujimtf0yZFg3mRNL8/kUrQ/V/sFs6cP9V1vVVfaZQfgkiPFTFsv38hL1y1v8cok2GiLeUy+e/mpFWAjztKy6D/u2wMxvoU5+myfItAMTBB1vnvq33d88TIeiMi0KfECrs+V4i9zLZc4neyzyeAJXwiJfbGP41nI87F79niaWI0tc1l01NYpaI9D/iEk+Zthci0NX1cZ7RzkRhMTfIkmwUUOGz4X4zOnQMexfLk3z/N4sjhC4uhA6yxh3zwHNYKRN5Ke9QAFHztOLRaXn54hBXhmkJBYrF5L36IEDbMWyT/EWsDySLSBCjKssflT/GdR5r5AsbaOYQ2BcppFoqEmJ0AkTyFw9uG4jHY3wK9uhM9UHKUBLFJD29chUUiXGYH1vPAafxWMhRNFX+jupy3tT2fI1ZIlWcXGBZyWuOPXAikSaqGfwREfFAGHSY8B2Vpf7j69wNvzpFuQXpBDjU4JQ9ZEVIDYHH1rXoKGFkX0RdAZRLPfMrIJxhvF6QV/nUqT+Dev2QknDvOU6/LZ/5HcW/WGhye5Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799003)(56012099003)(22082099003)(55112099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm9aM2tXRi9GTTZ1YWF1UGJzaWNZQm4vTURBNyt3OUlKZ1NLbm9MRTlweXN3?=
 =?utf-8?B?M09WYWh6RWVyQ2hxY096NzRzNWVrUCtEdWF5dS9IQTJUK3VTcld3eFdNL3Jm?=
 =?utf-8?B?OExYaFMvZ1prNWNGN28zTWlUSnNpM1kxZFY3SGlMVUtpUDBoYkt4dXZJeW1w?=
 =?utf-8?B?QmdBYzFoUmNXVTcvNmNnQVV6RnZlVVdvOEpSWTNzc3dtQVJuV0hiWktRTXoy?=
 =?utf-8?B?a2pyOE1XRWxyQUo2bm9CSjNHTndLRzZmSG9tSEpMZnNMZm1aTm9hTDBzTGha?=
 =?utf-8?B?K0xFbms0U0RKeDBsVEZlSkxjM0F3NWZtRkVXK2Zvb3VaYkczVVY0M2l5WldL?=
 =?utf-8?B?cTRGU29WNS9pZmgwMmtzYTg5NHNPbEtwMXY0djJHUS9mWm1RbVhpemR4b01Y?=
 =?utf-8?B?U2NJcExWeE5WQ1dackxZbHFIRkhLbks5dDNxUk5WZ2pYMzl4WDc3bENJNkJS?=
 =?utf-8?B?akZGd0s1Yi9PWkEwMFJTMTZkenRIUGFtVUFNbXJKaWZYYzduZUpLVi9sYTBF?=
 =?utf-8?B?WTk3MklxQjRROGl3WjhmMThranZYRVFuL2N5TzFYZTNMN01WaHdvTzdRVjlt?=
 =?utf-8?B?TEl4c0kvQ0c1SDdWdS9pNlBTY29nay9ySU8vS3ZvbHNSdHhuVGdFQ2xNV2VR?=
 =?utf-8?B?Nm9rem5NMURDUE9GVVFCVzFkTHpNcGlkcW5qYm5rdmloU2VDVXhxSytEcUdi?=
 =?utf-8?B?SVNsemp5V0dkZUtneHkvbjVsZ2pWV21VMEdSS0ZsUWhrZ1FSdXpqSE9iYXVO?=
 =?utf-8?B?YmZFRkZMSHkxeFhDMDZnemdoOS9vR2pjNGZka1ZRdzV6Y0FZNTltYXo3Zzc1?=
 =?utf-8?B?cG1EcEJZNEhBck90VFNrcFlxQThIZWxveFcrMHkwWlRBVlR4ckxhemNhaVBG?=
 =?utf-8?B?dFRrN2t4a2JtRmFpVk1TT3dCZmt3SWgyODBFajZnN08xcGlZbk8xU3duVmUv?=
 =?utf-8?B?Wmk1OWJaV09KY052dHlqbzhnTktpWHg1Nkc3cy9LenVFTG9KMG4valRvdTN3?=
 =?utf-8?B?YVVlajArM3cyT3E4TThES05EekwvRUlHaFBmQ3g1andYRVQ3eWZzS0w3TjY3?=
 =?utf-8?B?Yi9VSDM5NWwvQm5Xb3BMWThRNW5pd2wzRExqbzBGdW94VFdTWjFiTFArV2ds?=
 =?utf-8?B?Vk5oRmVFc3cyR0dMR1Bnd3RaejFuQU10bHVIc1NIZ1NOVmM1SHR5VTcvbmh0?=
 =?utf-8?B?akgwQjJ4Q1dqY1pOUDlITEVUVldLS1FEbmZyNVFRc01tNlhJZ3N6ZmVYYVlP?=
 =?utf-8?B?VVNxQ3UwejIyaSswaS91T1hDQ1Y4dHczSzJMTHNoTWxCSW04TlE4ZDIydnZv?=
 =?utf-8?B?RlI0RUg0TnEyaXdrbFQ2N2t1Z2pEaTZIb1V2RkxuT1BBRHhySXR3T1g5TW4z?=
 =?utf-8?B?Ym5ZU3M1Uk5tUUZSNVNDS1Q4N1lmQmhQb3ZoczBqSEVpQ2czbWNaanIwSDg2?=
 =?utf-8?B?OHdJTWF2eG1qZTFUREwxbTdSVzRVdmpvTEl4WEMydEVzV21hWm9Fcms4dnIr?=
 =?utf-8?B?TlhLVWxaUEptWUFPdE1vT014ZndzNm1KTVpyN1JNaEovMjZEaWd3R2hBQXhw?=
 =?utf-8?B?S3Q2ZG8ra0V4NWVEdHFnYm0vWXRySWdnSTFCT0N6MzR5OWxQcjZkbjkrUm9V?=
 =?utf-8?B?b1J1Tmc5dnlIQnlmRHRJYmZ4OTE2Q1FyRnBBc1k3WlNUczZNc3h4UURGMXhP?=
 =?utf-8?B?NUw1SGtPa3ZvZlRxZFVnQ0hFbWFHbjZtaSttcWJnTmliWjFDM0FTVTdKNktO?=
 =?utf-8?B?SWpGQVJkUU14WlRTemlRdU10UFdPRmlBWlRIczdZb2ZQQkMwQmgzSFJtaWxp?=
 =?utf-8?B?MDNpLzhZMXlQUHFDazBwaEhzS0IzSC94VFBtWkpkYkhmVE5uT1F6cWFYS1pn?=
 =?utf-8?B?SFdQT3VPc2krQ0E3LzVBd3haTStsQVVKaFNXU0NCZ0VMYzdkYWVzd3hPczcx?=
 =?utf-8?B?a1BMS09uQ1Y2N05vSERnU2hpUWZZa2tQejdQMmh2dERMeVdJdHYvWkNjdUVT?=
 =?utf-8?B?OTAzRWVUSnhlcW43QkdjbGgrL1RRdU1NdWEwSjNPbnRjeEtQcXNDc2cyc3p4?=
 =?utf-8?B?Rkw1OS9xMStKMmhzdk1QaHBseFkrZ2hLT3Z0MGwrSStxZHRGb2I5ZEUwMkZZ?=
 =?utf-8?B?Wi9tK3FGR1RjeElpZWVTelAzWTNDbXFERVVBNTBoclUxdm5YUUZoUG8zRzI3?=
 =?utf-8?B?QTNzRzg1RitmVHlaMFVFMXg2VlYrWUl5S1FFVWNweWx3QTVIUVFRblZPaFFz?=
 =?utf-8?B?eW9EZWxQNUZ2UmtpQk9Sa0w0cmtkbWcwUEsya2hKc0o1MGZRSlE3ZkxHS3k1?=
 =?utf-8?B?MUVCV3pTMEdmTFp2ckZ1OTNwWVRWbmxCZ2Zibk13OFlVc2swZ244VWxxOVNs?=
 =?utf-8?Q?LUKs4eHTSOrsOHjk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6604d8-fe8d-4b70-b871-08deb164fa14
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 03:00:38.7514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onHt8C/rxFrhhaR14KeJDMh1rMatyN6llusWtRR3ZU9+SfKLRox9MDhVG0U6m4sGwXoAwhWXzOfm9Otg4o5P5x7TrL9aYcf2TZnaObapgEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7025
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

Hi Lok,


On 28/4/2026 3:00 pm, Chen Huei Lok wrote:
> Enable MTD command support and SPL SDRAM driver for the N5X platform.
> - Enable CONFIG_CMD_MTD to allow MTD operations from the U-Boot shell
> - Enable CONFIG_SPL_ALTERA_SDRAM to initialize SDRAM in SPL
>
> These options align N5X configuration with other SoCFPGA platforms
> that use the same SDRAM controller and MTD framework.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   configs/socfpga_n5x_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
> index aeeaa1636ae..b6df9946ef3 100644
> --- a/configs/socfpga_n5x_defconfig
> +++ b/configs/socfpga_n5x_defconfig
> @@ -55,6 +55,7 @@ CONFIG_CMD_MMC=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
>   CONFIG_CMD_WDT=y
> +CONFIG_CMD_MTD=y

I suspect the sequence may not correct.

Did you run `make socfpga_n5x_vab_defconfig && make savedefconfig && cp 
defconfig configs/socfpga_n5x_vab_defconfig ?

Best regards,

Tien Fong


