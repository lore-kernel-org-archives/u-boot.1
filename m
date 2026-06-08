Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BC7CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:59:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FCE0846E6;
	Mon,  8 Jun 2026 15:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NAK2ZesQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F2D84704; Mon,  8 Jun 2026 15:59:17 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18F61846B1
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfYZHQ0qOie5CeaiSfpNG1kBe5jXR6Jow2oJg2bAZ4oCgvkzR2PPfT6dBo/ox5QoiHTTlJDRsW/mUBcP7af5cdYOfRMWskKSuadWUlGkPWlUMNPW1NcAwXwdaBrNTX6G12dOnykOo60EUmfWlzo2QB/VQCNtvD14lTZmFz+10jZWlj6NWWTknQJ3OzuBtJWT3WvKMikW1JwxSROc9W0i6aIUquRhC7xbUVytvCppJyI0IB01DsnI7dgR2G3Dh+3gltRs1XGq3vEvNz5FuFVSy7mpozmakQbpcYJq2Zx4c+ZDf5PVLldIT8mqPQgkoBHseyB9lxkwhpdvvtmu66HxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/onPAC3K9apWw9qKgM/Pg/QvNmfAMLczoHmS2MDiv4=;
 b=gZEih9cF6lr5Pwsmi4LT22m3zOTl8lx6PsGevX0S2hg1gwX6+SD6KHFZBCmZJzC/csQF3j+EhVE+aisbZq19LDkk4bD3bHBMsjHhom5qbzKUDbNukxQlRu1yaqq0nrWeFhy7x49LD7T39N4n2lNgRL0TOgWpFpYpveuPg7gcaykFcAJXMKGo59QhPkPt7aOLqOv6UO71TzTHzEvdw0Z1mkg66Wuwl/64V/iyv6bH9uwCQHUS/Pa5M4imVvPzKDTKNrDnauAeoxfRYXRNMFXLhIo8IeUvFdPpH0D05aIL5XYyEUdKqugiSPMiGw0Xdw7o3cBS15GzeaEfDgMo3IUolQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/onPAC3K9apWw9qKgM/Pg/QvNmfAMLczoHmS2MDiv4=;
 b=NAK2ZesQLhPloWiZR1KxcsXWMc6d+XRBjWD4iWumxhHHlGJdfVEeupdQVKKYXW4dxFxwvf8k25WC7sOXNWHRjRxfYq8WpzyCbO54+7foDIqzL4yohPNTv36QLme7gKjv5CZwgZ7OftiHJjKweDeyxBIrTtMqZjNAWQENgK14C6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AS8PR04MB7688.eurprd04.prod.outlook.com (2603:10a6:20b:29d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 13:59:12 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Mon, 8 Jun 2026
 13:59:12 +0000
Message-ID: <9b0b5a7c-3a6d-4a54-ad67-10433cbd3435@cherry.de>
Date: Mon, 8 Jun 2026 15:59:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xyz-modem: Select CRC16
To: Daniel Palmer <daniel@thingy.jp>, trini@konsulko.com, sjg@chromium.org
Cc: u-boot@lists.denx.de
References: <20260608130606.121031-1-daniel@thingy.jp>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260608130606.121031-1-daniel@thingy.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::29) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AS8PR04MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 4583feda-7820-4ecb-558c-08dec5661eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UGLj9WUP8B+7wZoWTIPvhlmPwxBIo1IlXIG/7JnW+kKCEPX3BrgeqPNFot+plUfBTG4V3Y9VQacTopT2yW6bvj1TFQXLZdRiJW/HyjnaGRJkvljf31GdxmAMWSKpfcF+GeCt18orIbP8IRgLuIkUdS4ECxbXqnSLqX3KMUdXgkrmF2jThs0aMIPv6qeIdoy6XrQk2US8EMYYRDOq8wxGEdQq7Fc76J9ZHjOPz1nOHyJqh15eApeJdvh8XaiuD5OhJvy4tgi1tg4IpKDk8/HwbksMa9O7nK75erGuAcq9YUqDfmHi81xBlOYR5ks4B4KLEBrb0U6Hylhp3fszrsZxe1KyrmkBM0BFDeBXNZ0H3zDFnz5212wzNsvYkTMeSbnSqVdru0h7O5968y1psFVJH9iiebeRWGstCzyk7ppPC/ZoAXiUXAeavYaXGxqvjYbIbWP0gd6u/b/7VlFZ9Ol1ynuhOEE7clSR2N4xaJztbO6hG3/q0+xsMwxc9EyDl/w4SOJlOciuJJG/+CkFP9xxkjtbi0hk39IsaPiVLwtssVfW4vVT2quz6xpJ32yaK5/EXKculHPQ0BN1YtSzKOW6/EhNnRhk4Y0UF/QkGjWemOSp4/3RBtHK9FM6AgbvWgtLz+BzXwV0Dx88ZJoLCYYakaaUvh94RyqFdIFoH07eXBIoalxy8HpI3hXgCvji5dPO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkJoYnRITXdjYndsanBYNHRBWVlHa0RabTFqT2lwdzM3MDZlWFV5WEJJQUsy?=
 =?utf-8?B?aWNmbEpKK2xiTGVOQWhvVkt0b25VWldLRTNqSmpNeTZTdnhCMTlVTE5NTjdI?=
 =?utf-8?B?dFJVQ1hRd21LMm9oTWIxMlVoN3hPT09TcXl5NzJuckRva3hrSjdXeTE0d3pq?=
 =?utf-8?B?VTNDcmozZjkvTUpDSzF4M0ZvdmJyakdhcW14OW9TblBWOFNOcWw1K3FIeWpz?=
 =?utf-8?B?MVN4OXdmcTk3eGRIejlBbzV4QllxRUFYMC96Z3lPK0J4cjNlK1hiNVJ4WGo3?=
 =?utf-8?B?ZERwWmJ4blE3SlpFd1VQU1J6YmJsUXZFMzhlTUl5cHJqNXpEZG9zR0szSjVu?=
 =?utf-8?B?dUtFRmxPZnBDc0VqaUhBL1E5endkdXFYQjBVS1UzUmJhK1V5ckdlekpJQUI0?=
 =?utf-8?B?cGxzc09HS1FyYlRSNFpXNkxNbHhzcnB2YU9vTVA3ZUx4SkF4NXJZbXh6aE1p?=
 =?utf-8?B?TzR1N095cjExdGtHRFlOUWFQcU91L0tHRzZWb2dENnV5dVpwemVDMjFlNEUv?=
 =?utf-8?B?dEtJN1d3dVBJbWd3RjZCR2Y5aDRudUs5bDAzNmxWb3NHMkd6SGlhZks3eEU3?=
 =?utf-8?B?RkZYeFNlL0FxYlF0b3VHT2NoQm9mUGZORzVuODBndkR0WnNBSVV5R2JPZ3lQ?=
 =?utf-8?B?RHRMbTN3a2lzcE9wdUdtNExLZXpsVjJ6cEZlS3ZMZHM5VUNVbkRjdkRNYm1v?=
 =?utf-8?B?YnBvTUVOVzJ6YUlWTjkxOVdRci9qVG5UdlFkWDNrbitMU0hiS1pOVjcvQjVH?=
 =?utf-8?B?T3NucnNFUC85UzBTZlppUmx6T2pWWlZCU2RuUk1UMm9zTlhNU2NTY3FiZnRu?=
 =?utf-8?B?TUhFSDRuYmVKeFRQQnVmcFh1Kzl5VjhpTmlWMU9yTkZsUVlRenZjaWhFTzdF?=
 =?utf-8?B?OVdHL201Sm1HYk5yOUpOcnBVMzBtR1pzc0NrWHZFT3ZJY1BnbUVyOTJFYjdx?=
 =?utf-8?B?eTVXM0kyZnlrekVuUVVxUWg1Qlc4SVFzeHNHZk1Lb2ozVnlQc3JRcVlPM3Zv?=
 =?utf-8?B?eitlLzEvelRFeXJDOFRkTm1xRUdXWlNuL2RlRnphK0JyQ3hoZzhhRnozSW1x?=
 =?utf-8?B?TG9ydnpiS0c2WlJZZzVOclpMWU0xeTBCVnQvUGZWSlJpUnovRStmcTA4U1Vn?=
 =?utf-8?B?YVBJdjVFWTB1VmtWOVNHRnFkWHJlVTZsbWpXRmRXVGpONjArUm5uVXZtNXlk?=
 =?utf-8?B?QU1yWUJ1V05nR1J3WFY4YjE3OE4xUVJDSllrVW04cTBOQVFFdW0yNUVZWnY0?=
 =?utf-8?B?a1FZTkhDaDBreC9PUlJIV1pFYTZnaWZQTDQ2cUNkR2pqSno5NWpJMFdOWTdm?=
 =?utf-8?B?Q1pxM0xZYWZpamJiUm94MHB1VWY2cXRKQXFUcmRIcW1GWFZhenM4RUNMVHB1?=
 =?utf-8?B?eGhiR1Jvc3pDTnI0Uy9qWkVJc1NHVjNENk04Vm9NSHNFUjRiN0VNMnhENXpN?=
 =?utf-8?B?a2w0NGNlYkc3RG1OVjNTblRlTkxRZXJ6VFc0OHlPMmI3N2NHRjdZcm5GS1k1?=
 =?utf-8?B?ZW1wSnl4VWcwMHpaVkNzUm5OVjVGeTRMRmovcDlBdmx0d3NpNzBqVmxuMTZ3?=
 =?utf-8?B?RHdPU1Z1aHpsSWZVK2tXZEt5L0xZVVY2UTk5OWZLSzFHU3hlWi9udTNDbDV2?=
 =?utf-8?B?clMrVnROdjU0VTRnVytvZ3oweEJUZkZVdGZGTkVQa3YzN2huQURvR3RCY0x3?=
 =?utf-8?B?SGlaSm5mM244SlFJTzZQVDhSWU52bi9ZODBaN1RFNS9ORnRLVEZFTWpGM2ly?=
 =?utf-8?B?Vm5aOVVMNnVLbVNoa3Yza3hhaFJ4Qk12eWthcnBVYnh4UXJ4bStSTHNldWdy?=
 =?utf-8?B?TW5UT0FpN21DVGVCVWVYWTZtbDJrZ1FqMSsxRnQrbmNYZTZtZUZkMUpTT1dp?=
 =?utf-8?B?b0tPUmdWWXVIdXJtQmtNQmNDbVBXL2NMSExhaVBOWHcvQ1pBdWZNV092dVVT?=
 =?utf-8?B?a05GbUlRM21DVVd4NmxzdkxPQ2Y5blZtUC9aUFByeGFvcFBNUjZqaUJTcVZ0?=
 =?utf-8?B?M3JMbkNJdVhVYkg4cjVvajZjNVhsaUhFaDJxWS8xbzBUSEJydmZWb3ZvUW5x?=
 =?utf-8?B?UDRqV3kyTlVpWm1TUWlXVTNqeUN2V1JpekhRYUFyQXRRQmtDc0FnUVlvWkM4?=
 =?utf-8?B?TVBuSFFOSkk0MW80aEpIOWt6Z2NzL2N6MmgwcXdWdk44NG5VSW1VM3hDbUEz?=
 =?utf-8?B?S3BldWJlRmpYdjZSbyt0VmZhcEp4U2R6d2JqWmJuYTZXWjRhWGRNWEEwSWZo?=
 =?utf-8?B?VXpZSWdHWDZWMkpvWkFpTkVUV2wxUWUwelFSK2l0OGw3RUVLRGpmc0VpMXRG?=
 =?utf-8?B?RUR0bEhORDArbEJQSmR4MUI1dHRvWWRlTENUcEt2OHBWZERJOE9IZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4583feda-7820-4ecb-558c-08dec5661eb0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:59:12.6977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K96dxxyejn9sPQ6p1Y9fGjKrajhlFAPiZiHI3aqk3oGcUI6Qvp7gIJHflM0iDS14KHqQIifWJzgCjPkL2eDDaWd9PSo45XThyeK7mYtESQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7688
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

Hi Daniel,

On 6/8/26 3:06 PM, Daniel Palmer wrote:
> - CONFIG_LOADB causes the xyzModem code to get built and that code depends
>    on CONFIG_CRC16. If you don't have something else that selects CONFIG_CRC16
>    you can unselect it and then the final link will fail:
> 
>    LD      u-boot
> /usr/bin/m68k-linux-gnu-ld.bfd: common/xyzModem.o: in function `xyzModem_get_hdr':
> u-boot/common/xyzModem.c:388:(.text.xyzModem_get_hdr+0x17a): undefined reference to `crc16_ccitt'
> 
> - Add CONFIG_YMODEM_SUPPORT, make that select CONFIG_CRC16 and make
>    CONFIG_LOADB select CONFIG_YMODEM_SUPPORT.
> 
> - SPL/TPL already have Kconfig symbols for ymodem support but the spl
>    ymodem code has issues building in the TPL phase and doesn't seem to
>    be used:
> 
> /usr/bin/aarch64-linux-gnu-ld.bfd: common/spl/spl_ymodem.o: in function `spl_ymodem_load_image':
> u-boot/common/spl/spl_ymodem.c:138:(.text.spl_ymodem_load_image+0xdc): undefined reference to `spl_load_simple_fit'
> u-boot/common/spl/spl_ymodem.c:138:(.text.spl_ymodem_load_image+0xdc): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `spl_load_simple_fit'
> make[1]: *** [scripts/Makefile.xpl:546: tpl/u-boot-tpl] Error 1
> 
> - Remove the ymodem symbol entirely for TPL.
> 
> - Select CONFIG_SPL_CRC16 for SPL.
> 
> - Finally, since everyone is now using the ymodem support symbols remove
>    the special rule for loadb in the makefile.
> 

When you need to list what you're doing in a commit log, it usually 
means you should be splitting the content into multiple separate patches 
(in a single series is usually fine/recommended).

What I could identify (slightly reworked, which better match how *I* 
would write the patches):

- changes made to common/spl/Kconfig.tpl with the justification given above,
- adding the missing CRC16 dependency to CMD_LOADB,
- adding missing SPL_CRC16 dependency to SPL_YMODEM_SUPPORT (possibly 
squashed with the CMD_LOADB+CRC16 patch above, I'm undecided on what's 
best here),
- create new YMODEM_SUPPORT symbol and migrate CMD_LOADB + 
common/Makefile to use that,

This makes it clearer what the purpose of each individual commit is:
- remove dead code
- fix existing support for CMD_LOADB,
- fix existing support for SPL_YMODEM_SUPPORT,
- quality of life improvement by migrating the CRC16 dependency from 
CMD_LOADB into a new symbol + making use of that new symbol in 
common/Makefile instead of "hardlinking" CMD_LOADB with building 
xyzModem.o (which is quite honestly confusing, so good to see this fixed!),

What do you think?

> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> ---
> 
> v2: Fix the SPL/TPL stuff as brought up by Tom. This opened a can of
>      worms when I tested if the TPL builds or not so I decided to just
>      remove the TPL ymodem stuff. It didn't seem to be used in any
>      defconfig and there isn't a CONFIG_TPL_CRC16 to enable the needed
>      crc16 code anyhow so maybe it hasn't been used for a while?
> 
>   cmd/Kconfig            |  1 +
>   common/Kconfig         |  4 ++++
>   common/Makefile        |  1 -
>   common/spl/Kconfig     |  1 +
>   common/spl/Kconfig.tpl | 11 +----------
>   5 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index c71c6824a196..503fc51f6bb4 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1412,6 +1412,7 @@ config CMD_W1
>   config CMD_LOADB
>   	bool "loadb"
>   	default y
> +	select YMODEM_SUPPORT
>   	help
>   	  Load a binary file over serial line.
>   
> diff --git a/common/Kconfig b/common/Kconfig
> index 8e8c733aa295..0db74aa580e4 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1274,3 +1274,7 @@ config IO_TRACE
>   	  confirm that the driver behaves the same way before and after a code
>   	  change. To add support for your architecture, add '#include
>   	  <iotrace.h>' to the bottom of arch/<arch>/include/asm/io.h and test.
> +
> +config YMODEM_SUPPORT
> +	bool
> +	select CRC16

Is there any reason we wouldn't want the user to be able to select this 
independently from CMD_LOADB?

I'm asking because this is both invisible (no prompt) and has no help text.

Cheers,
Quentin
