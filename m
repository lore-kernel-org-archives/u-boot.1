Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65F8CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 08:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EF6B8407D;
	Wed, 10 Jun 2026 10:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hFtx9VMF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44FD9846BE; Wed, 10 Jun 2026 10:50:23 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C905D80086
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 10:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSjYP5Cc2NeMQvsgyiOkrNP3wQFQoIsMkvGziPySFSwWlHPfxZbo2H3LpVl/RKErJHLceHDAA0451HITD3RckSCvC7pSBieR7tJPBSEqNrjF0DI9vOl9/J9FE8PvlwQqgIpv66Mfi9O2eBc2L+PjxtYX7YfGJgdufnPTELcuZRDyU1vapuYRUPcgKB31BFFocteq7u5mmHM1TUlXQOFbPzNei/CrN9lq/DGTcl85mnr/BTc1ZdxeexZw4tBnfSGjDoID7y6N3+hdniEyOLjmlhELurAcFCB1WwVo72xGprubCH7+U81UcLrk2txzutL0XelnX2h2laqiaVANh0PbZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRggs2JES5+7foV2buP80Y3lr7GO8ZGZ6NSYiltW3fM=;
 b=ltmloEKFkdRrU0BqrXQFX2d5FCiLvUREXPMzv0ffbnjRPNOlfQrXBncA7QYykZRq9Fe42xrE/n5To16AChkmyXAgBplDi89RsFkw3LZ0pA/gsHwf4lyIFSk+YpOyFyyl/1d//wJnio4RvfHb6T6UsNRlLz3afjjGkVqYLgG+oFH/enw1YkukhguRUqmJ4piXJPw44vXYZoK9oO8WOL4SMf4kAiIKY3AeYUYEAnEYpom8y19RqZE7AA2uyMqbgpML9v1j9jIfI2vfeMAQhWnSvyZX74tLBnZfC5sMUheevCw505cA6B8pKtwTafSkPJK1X+U84hWqo4HrMAlc9G3n1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRggs2JES5+7foV2buP80Y3lr7GO8ZGZ6NSYiltW3fM=;
 b=hFtx9VMFc1NuarB6U8ieWyHIyhjMKSq7HqWPGUJUCL6HTOOpq6bmcdcMWgCqXt8mldol2yfE4EbDu7B0mo5ZG9+XAF9VDSgeWipqrfusGt2XCqFlrzWvuKmqXvMjT++mP4iMIDk/i8x+upwn449ejSktu1JbTb/UM6dL6UyKPmY1Zxzbu/S9uNfEQ6L/7BZ5egjs8ujINOM5oxqu1QsBv/O9xfijO5xs+kw8HJVM+gojl9rRfFm7uMxXuarorRlBg9bJcX3UwSepL6q3OIi60ut/m/I574nFQo5l7RK67yn7Tkb/dDzAPDGZROATRZqA8eylwNTWIgsxKW1EojEsOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SA1PR03MB6324.namprd03.prod.outlook.com (2603:10b6:806:1b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 08:50:17 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 08:50:17 +0000
Message-ID: <f5ad9ef9-0727-479b-978c-7f5247414c89@altera.com>
Date: Wed, 10 Jun 2026 16:49:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] arm: socfpga: s10: Enable system manager driver
 for Stratix10
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
 <20260605015503.11709-6-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260605015503.11709-6-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:295::13) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SA1PR03MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 194c32c6-5c0e-48ff-7854-08dec6cd4b99
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|7416014|55112099003|13003099007|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: TD/m2B2c7C8xrje3a42cunp4/aOMtxDxtAoQwmUIeqI+lRsqTPPnbSWCxsJdFrvk0L1yfGLdsfuR1y95CmkSuPSG4ihGv2/dHEFZx0YKOMby+8VUxR7baNKKZcdjTqfmMD3Qx7kuJ87ZBT+w5hDbNSghxJu8DTvtVb+bOC545sCmVTyFMhmw0ZHRf4dAa8bwk/nqIrdL/GNwPSWiWqDm6UPcBzm5GM2FSlMekJ/dcv6ggSQDYenF8HFYa+XJKomIVNdC8OZpr/EQHr4ajeSHeXcSk2rupEC485t7iBHMocudD6e/i4iL6K1Gizwth7sv+N+d/7jaqmLorRow+iOIYCPcbduC7XHHckU5n8FebTN+V41++ObijDu1YA0loINVxaMP6BYpwCTpzgOTgpWnMi4+M9UtEPkPzbpmlJeLr158TqMThUf7QWG95NwDFmE2tnDQfkp/8yVSkNWRw1C+wDeKvJEPNtbS3ec9vgsfvrPVk+ShmQr37B7QJR0PboaIZWa45z196lVpMmsGlLg2Kg8e7JGlS+KRwxjikz+OKDiyi0zFnXBxyZ/ScNM8HLqJAHF9JXmUPMT3CULlzSQQExmFzvvqwtOehZAnDtozGrlYej2etu9HdIwIu8qWo9A5Udfx7ySQjStnfqM4nFBGUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(55112099003)(13003099007)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWx1RFJJSTFMSDAvVXh1NkVWamlEOUpYSGJPdkZEUWVjL1Ivem8vTHhuYU1G?=
 =?utf-8?B?a2RyaXZwSEFNSmk0OVVFbkRhVEhqNmt3OWNOREU1eEhRRWF6TSs4R3U3OElk?=
 =?utf-8?B?YytKUWtVc2p5MEVUQld4VUtnWkVCb1NqbUlnbDhZdHkrT0pDbVQ1L0NwbGF3?=
 =?utf-8?B?VllsVFZFdVg2eDh2L0xXblh5bDh3MVZia2ZjU1ZLb1h2L2dGS2ZkbGw5UEF4?=
 =?utf-8?B?YzRFWEU0MkhTNXEwTXQrU1NaOGYvZHFROEZ0Wi9YdWRBRGs0dXE5RUo1RjIr?=
 =?utf-8?B?UHczejNIQ1pSOXJYWjZoMlF2aHhOSmlvNWVPeUQ0cmRFUkFJZEEwWC9EQkkz?=
 =?utf-8?B?cnZVTmdBR3FIY0NGeitLdDhTYjdWS3daU0k0bHdxeldjZnUwakI2OEQwb0Nk?=
 =?utf-8?B?cXZLMFdKei9jbzJOL3BjQzB0R2pHb0toRFczbkY2OHFVRjB3L2F4aVR6cWZs?=
 =?utf-8?B?WHZCeVZDbmw4M2t1VnZWVjlyNjd0NjRxeGZXd2Q5bUY5N2hvNHpGNit6ZkVn?=
 =?utf-8?B?VjkraktwSFpCU2JDZ0ptNlBEVEJWYXludzhGT3dLbm9UVCtrNzR4NEgyaVJV?=
 =?utf-8?B?aGU0UVVvdDhEUFBtbnRZVWxIZUZ2L3NBMllBdDBQeUJ4b29weFR5YkxybDlI?=
 =?utf-8?B?ZDBLK1BsZTF2NlNWaW9lbkxWTU12RVkrTkh6SFJ1NDNJMElRbVVjRmErNzdO?=
 =?utf-8?B?VU54UWY3Yi96cDJOaHVLYVh6dWE0SmcrelRWVjhpWU1BRDg3SzYyUTBrenZJ?=
 =?utf-8?B?Nm1waE85WVR2ajg1U2J2c1NwdUF6aXVwSXQ3N2xVdmpjRXFDQVJIa2FWcVI5?=
 =?utf-8?B?aWRsTWU5T1NMR3lSZFJmL1pBTmZwK1FFMkN2aWFDbkpDY2VXVnJheEJMa0Vy?=
 =?utf-8?B?SzFIRFdCdVZPUElYdDJTSEhZTEVlV3VIakNBSTV4L1F4UlkzbU5vSng4Ykg5?=
 =?utf-8?B?OUljNU02dFh3VE1kc0lGdlk4cGR1alMwVXIyTDZpVTRLZWlBck5pNUc3MVFY?=
 =?utf-8?B?OWxYVmdDQ3ZhUWl3OFFMSzFHWVM1WWZYV1dNSlVIeGk4RXRUSWZ1RENvbDVB?=
 =?utf-8?B?aUo1cnB0SHAyN1VCOEYxaHpHSzhjNlh4VWpPT2YvakxydUFqeEI3NUxJcit3?=
 =?utf-8?B?OG8zYlRUUDBsd2hlMldVM0JuTUxEMzRmQWRhVmdSdHVYb3hHVk1Ld0Zoa2Iy?=
 =?utf-8?B?T05BVnFudjEwSm9ZTVk5KzFJbWo0ak81VnYwWjZNNU9ERVVyKytVdDludHQx?=
 =?utf-8?B?ekdKZlFLNWxGWjJ6TnczZStUSzM4dC9TcnFCa25zd2RlVFNyWitkQVFWczJZ?=
 =?utf-8?B?bW1PUk1FT0dnRHdOSktNWmROeFJWdzVOWUErZjlaSjZCUHBSMmM5ZWZGOVN6?=
 =?utf-8?B?TC91d0dVMjZ0TkxsaXlWL0Y1ektrRVdTM3ZJazVlblI4VE5JUDBmdTI0ZWpO?=
 =?utf-8?B?KzVuendpY3lPQWdrQXRXNFpNa1FsVFdqU3VaN210YXljdk0vN3FoNFIvYXlT?=
 =?utf-8?B?a0o1QitmdDdJQWtQV2drOXpxa2UyZm5NKzhQQUpZQUlZMU9VbDlDRUY2RWhW?=
 =?utf-8?B?elE1bStjeTlLaW5zSzBRSXp2dHVmcXV5QjJEanhwSWNHOHMrS1hsTkdtQmE0?=
 =?utf-8?B?YzBMMWdCZi9kdGloVjZiQUNjWmg5VTlYR09lcU45K1Q0UWZqUDFNV2k0Q0l5?=
 =?utf-8?B?WEFyMHF5Z1FzM2ptdVVic1VzUSt5NFU3TWt4TXRPTTJqY2pZajZWbHBta1hQ?=
 =?utf-8?B?MGNvNWUrOXRGNUdFQUFndVFoUWVmRFNWVVpFVG9IRlkvWXJqdUpmbU43ei9x?=
 =?utf-8?B?RjhaN3hNRFBzTVBRTzdNNFVUZExsV1dCRWtqdU4xZ1E5VWVRN3l2SWo5QkFP?=
 =?utf-8?B?RHRvaVNqQ0JpcU9weXBvU1pLTmNSQVUyT1hjODZ2cXVXNmE1STRyV1gveXZY?=
 =?utf-8?B?N2ZRdGdvQnBLcld6azhwL3VjQkhOa2xGRE1DVExSaEw5V0grYXNEeUtJQ0Zu?=
 =?utf-8?B?NytNcTVxby9iMUY4RExYZnZXczVLVGxETGMvOHFSQWZkRTI1YXVhOCtWNDFt?=
 =?utf-8?B?MmdDT2cwU3pkdEpjaGJDTWZSL1QwdVVxYkh4V3J3VmFiTk9OeDcvZVJ2SmVn?=
 =?utf-8?B?SUxFMWV4bzBvY05nTTg2bUdlVzZ4YzhDVEFDZEFCRHdtRGE1eDlTVFJ4Mjc3?=
 =?utf-8?B?WWhKZTBvNGlWb2g2ZFZ6WEVFc3dCVEpKWmNVSDhBTWZuaDQxZHhyUEl0eFBz?=
 =?utf-8?B?UHlvVVFXVjg4QXQxb3NMU3pzQTB5N3U3WVIyend3Yys1WlExSjdKaE5EUnYy?=
 =?utf-8?B?eE1nOWpvUUU4WHc3RDBJa1NGNTJDVVlZVmQ0WTJaMTlsN2VpcXhYU1NmZ3N3?=
 =?utf-8?Q?bwwtRxaqTiou8u18=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194c32c6-5c0e-48ff-7854-08dec6cd4b99
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 08:50:17.6405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7fnM/zMk+4Am0X/7B0IRRtMNbwxNJjoRoEJYa47IP2VpfgRnQ3/unmiaFsx+wZG7c9OW1hn8B37qFL4fPpBqUaJd1XQwCBYFOotFUtBRkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6324
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

On 5/6/2026 9:54 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> The base address of system manager can be retrieved
> using DT framework through the system manager driver.
>
> Enable system manager support for Stratix10 by probing the
> system manager driver to initialize during SPL boot up.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - SPDX-License-Identifier format correction in
>    board/altera/stratix10-socdk/Makefile
>
>   MAINTAINERS                                |  1 +
>   arch/arm/dts/socfpga_stratix10-u-boot.dtsi |  6 ++++++
>   arch/arm/mach-socfpga/Makefile             |  1 +
>   arch/arm/mach-socfpga/misc.c               |  3 ++-
>   arch/arm/mach-socfpga/spl_s10.c            |  1 +
>   board/altera/stratix10-socdk/Makefile      |  6 ++++++
>   board/altera/stratix10-socdk/socfpga.c     | 12 ++++++++++++
>   configs/socfpga_stratix10_defconfig        |  1 +
>   8 files changed, 30 insertions(+), 1 deletion(-)
>   create mode 100644 board/altera/stratix10-socdk/Makefile
>   create mode 100644 board/altera/stratix10-socdk/socfpga.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 571af196465..bc4abd21dbc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -168,6 +168,7 @@ S:	Maintained
>   T:	git https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
>   F:	arch/arm/dts/socfpga_*
>   F:	arch/arm/mach-socfpga/
> +F:	board/altera/stratix10-socdk/
>   F:	board/intel/agilex-socdk/
>   F:	configs/socfpga_*
>   F:	drivers/ddr/altera/
> diff --git a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
> index ad4b383f704..89fa0e829f6 100644
> --- a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
> @@ -13,6 +13,7 @@
>   	aliases {
>   		spi0 = &qspi;
>   		i2c0 = &i2c1;
> +		sysmgr = &sysmgr;
>   		freeze_br0 = &freeze_controller;
>   	};
>   
> @@ -283,6 +284,11 @@
>   	};
>   };
>   
> +&sysmgr {
> +	compatible = "altr,sys-mgr", "syscon";
> +	bootph-all;
> +};
> +
>   &uart0 {
>   	bootph-all;
>   	clock-frequency = <100000000>;
> diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
> index b6f35ddacc4..962dce67c64 100644
> --- a/arch/arm/mach-socfpga/Makefile
> +++ b/arch/arm/mach-socfpga/Makefile
> @@ -39,6 +39,7 @@ obj-y	+= system_manager_soc64.o
>   obj-y	+= timer_s10.o
>   obj-y	+= wrap_handoff_soc64.o
>   obj-y	+= wrap_pll_config_soc64.o
> +obj-y	+= altera-sysmgr.o
>   endif
>   
>   ifdef CONFIG_ARCH_SOCFPGA_AGILEX
> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
> index 1eef7893e54..418d7dfb572 100644
> --- a/arch/arm/mach-socfpga/misc.c
> +++ b/arch/arm/mach-socfpga/misc.c
> @@ -263,7 +263,8 @@ void socfpga_get_managers_addr(void)
>   
>   	if (!IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) &&
>   	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M) &&
> -	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)) {
> +	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5) &&
> +	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)) {
>   		ret = socfpga_get_base_addr("altr,sys-mgr",
>   					    &socfpga_sysmgr_base);
>   		if (ret)
> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
> index 00d43460fce..893579f17c1 100644
> --- a/arch/arm/mach-socfpga/spl_s10.c
> +++ b/arch/arm/mach-socfpga/spl_s10.c
> @@ -48,6 +48,7 @@ void board_init_f(ulong dummy)
>   	if (ret)
>   		hang();
>   
> +	socfpga_get_sys_mgr_addr();
>   	socfpga_get_managers_addr();
>   
>   	/* Ensure watchdog is paused when debugging is happening */
> diff --git a/board/altera/stratix10-socdk/Makefile b/board/altera/stratix10-socdk/Makefile
> new file mode 100644
> index 00000000000..2e105adf942
> --- /dev/null
> +++ b/board/altera/stratix10-socdk/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2026 Altera Corporation <www.altera.com>
> +#
> +
> +obj-y	:= socfpga.o
> diff --git a/board/altera/stratix10-socdk/socfpga.c b/board/altera/stratix10-socdk/socfpga.c
> new file mode 100644
> index 00000000000..f8facf79204
> --- /dev/null
> +++ b/board/altera/stratix10-socdk/socfpga.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
> + */
> +
> +#include <asm/arch/misc.h>
> +
> +int board_early_init_f(void)
> +{
> +	socfpga_get_sys_mgr_addr();
> +	return 0;
> +}
> diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
> index be0c452ead0..53864251f29 100644
> --- a/configs/socfpga_stratix10_defconfig
> +++ b/configs/socfpga_stratix10_defconfig
> @@ -28,6 +28,7 @@ CONFIG_QSPI_BOOT=y
>   CONFIG_BOOTDELAY=5
>   CONFIG_USE_BOOTARGS=y
>   CONFIG_BOOTARGS="earlycon panic=-1"
> +CONFIG_BOARD_EARLY_INIT_F=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

