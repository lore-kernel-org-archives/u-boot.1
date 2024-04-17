Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6019C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 13:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9DEC88343;
	Wed, 17 Apr 2024 15:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="iiPwzgJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75F258835E; Wed, 17 Apr 2024 15:58:15 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA458832B
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 15:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKgAeGqvDJVpDxWYki3n6HybMW3zypbdbso+6ThuzPm8EmQphQHdbvOGyYAe1t6/jYuJpQt7KqGsy9vd8jj3+tG3lgHLAV/Ex4F/WE6gi0yjZ7T/YUbjC+dDt8ZImaZoNH9ircwSyBcJvs6MW92vX32y48P6yiu+OqsRfMe0VpZsrRHsylJM3h2HIaqUA1TjrkaDgO6pL3FaxWg5H9buapRc1DXsSGSBcCNr9MbP7cIGXsiKxZmfSA/CMCgKsK8B5554kOzR2FmuZuG7rsJBsWlSRgbAXp3PjaKpa7b9YTJeU/+XrEMExIQoW5UNCrxlZpaINpMtktHddbLbggVMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug1J7kJMzEbRysiB1K7Bb3maD2YsrravvOsMHHZR3/c=;
 b=MSWEChFn39mf9yKKaOq13RtC09RXYTUjj5PdqC3efOx05KGaLvpdVG5tkC7We0L3fOaqjraA01BhqtHBgERdThOQ+56XXp5JAkU64cXZmHMzJho4Yb2c4NKs/0uTe1/iUsKGcfuzt0pCvg8VkkTILchdor6issxcRnUQrItVk896dgsxRTFH5i65l0pqO2Al2YvFmsvLOb2jo7+1rnfvsZ3g3SqEn3KjTQBt0SnGfDoSvg/5p+bqacZ113VBFDkcFi03I1DL7gD6gTjS/vW0mUVwZrL+K69RbfApYxN/9qW3sMtHVG7D6GwNUeGbVHPDuw4G2TrBnBscOHOPUQ36bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug1J7kJMzEbRysiB1K7Bb3maD2YsrravvOsMHHZR3/c=;
 b=iiPwzgJPfxnmlSeJ2g6SiTNNpsgblDvWG4q8c2xmB+jVPZUQ6leoSZezFGk3GxH1FS3oyA1MXu3i21sS/TBX1BtZQq7pIYpUd87HYlQSv7WCfj952PA0uAOIgTshy1JIps7FAFLC8FrlUNFwzhlLXlZhSX+n7pc8rwDRkaJ0lPY1V/gyrzKATNzBM6DrYuOq7KXxIoEIlYUZwtaGGORyMb/BfxxUX8D0n2PAsmShrC/wwWBtd+FXEoZoYtoyF6nRH1q/r2a5SfgN3PrJUBE4fke4kduhfV9Cyf3f0HT97gMiZkqsclmnvRKIAu78Sygz7QVxnYgSLh2jLgKoqomqVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 13:58:10 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 13:58:09 +0000
Message-ID: <09ab0f81-46fc-47ac-8eff-d7d3e05faa94@theobroma-systems.com>
Date: Wed, 17 Apr 2024 15:58:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ram: rockchip: px30: Replace misleading log message
To: lukasz.czechowski@thaumatec.com, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, Lukasz Czechowski <lukas.czechowski@thaumatec.com>
References: <20240417111625.288202-1-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240417111625.288202-1-lukasz.czechowski@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::6) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|PAXPR04MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd8b149-af57-4efe-5003-08dc5ee66a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cavAkQd2RdIMpLVTLnlaQoSREFGhDac8CaKBso3yXICVOdZDosMwHJpEq00QaaUbz52FwmjMucNIBxK64cTIoVNO5z2ulb2GVm9ibOwppLQOoHeysxN8pRLM/pF9nYWw+8DQ0Bltddo9vE2xGJ8luK9jkNMCzaLPkwtTusTalMc5hHdJdPI+Fl2vFQAIaK0TYdzlsWXn+2k15ha9FHqYfAEJeod4NMzkD+MRmf2vLzNrL9dlZkFE9FDQVrIFVoDc+3GHv7x02EMtpukvFw25aG6CKufpoOm9Emz5wj4J2phULKYhnyodzH/j4YzAydIEMsBdEXQYRzMmNUZVM96RFSfKE4cCdl3gtnyV4x4tjAqRbBInwe7wM3BdPRESNFY5WVCQTFisARkxS15AQHAxub6wojCMrNIuRtYj/hstLEuylL+QWC3mpc3yRRyNYr/lHC1uvd1G78AeuaouiSgwe+IycwiyhpkFAYBzO/IBDxdo6QgpBSBwdMornbBG6ShxSOh113E8iOTG6j3ZrRd2zRdT/vhFEHZbQDTwTgLdV14ZifwTcYeEgDIFoR/viv1yVv9lckKxvPOl4YNwDsXOnQ0kC3zjgMQg2LW1WUg5gJnKuoUfROftnYL7YsKKaLvYcZbbudX2D3+/lDWetKWO160gdY5hWsqoWbfDhvjUqNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2hiZlBYWndZRXRlL3h5UnU1eUVlT0xVamZoc3YwZ3M4R1NpbWNyN2s3ZFlO?=
 =?utf-8?B?Yk1ZM3dicTdoWWJ4UnUvNkdqQjZ6U3ZUYXd4NG9YTnRoSU1LbVdGZnBGYzJt?=
 =?utf-8?B?cU5adUZNNFBTWDl3WTdDbFZxc3RFalFmNmczYUtJMEZNTXF0K2JwbWdKVTF6?=
 =?utf-8?B?SVdubU9jbFVwYWpoVzlLQ00yT1d5ck5wRVcxZGhSYmR0aUJWbHZwV3dTREJa?=
 =?utf-8?B?cklxNUFXVEhXbnhBYzNXTEk0SmZwZDJjQWJ5VWovR0RES0VFQndPZWFYVjlE?=
 =?utf-8?B?MEZMN2hsYlMvYmphSnJSVWhZQ0xGQmJ3dU1Bc0JGV2J5NDBEY3A5ckN6VE1s?=
 =?utf-8?B?bjJQRGZCNHBudWZkTUx0WWZBZEk2R3l4Qm42anovQ0lzSVZnd2Z6Z0pLUE11?=
 =?utf-8?B?czBXaGtxZVlqZkNSelZod09ZR0owZEZ3MmYwdEczWDl4bHBiSHpHZHRxZmJr?=
 =?utf-8?B?R3E3clpTcERMdFd4K3hsNVJNZFM3TmdyQjVlNnA3QmR0eHBYL2Q4aW9nNkFX?=
 =?utf-8?B?OXh2aXp3ZmFMVUkrZW5qNUtpUjQwMHBlVVhoc1NkOFBTNVk0ZGF3TDNxQVNp?=
 =?utf-8?B?b1UxdEw2akYvdmZvc3g0OTRCNFoxcWczTjUza2FYb2M3Vlc0ZExnNTE3KzZ2?=
 =?utf-8?B?a0o5bE9CQUZ2WE8wVEVzQmFhNzBBZlZoZjBrb1Vld2FiYUZ0QjFWRWs2WUZY?=
 =?utf-8?B?Y0JYTTBONTdYTVRPM25nWVdkYWVBNzRTeFBHRmkyWXRPajdTR21nOE4xUlZX?=
 =?utf-8?B?V0RSRkpXRG96TDg3MGUrTkRDaU84TVlNM0ZwdXpjVGZ1Ynh2eVVUQTk3ekUv?=
 =?utf-8?B?c2lNR3g4cVpPRFcwaUVjcXY0TzJqYWE1c0NGZUlXN3VQM1hFYmxwQVk5YnM4?=
 =?utf-8?B?cW9ZU3doMFRlM0JDM3JSZFJKbk9McGcrTzB1ejhpdVYzcWRzbjI4Qm9VOGVY?=
 =?utf-8?B?RTZ1bVZHaW5OME9PWldIWmV3R0ZGbHlLSi84K0gvdW9XQTZIRDN3RW5HTEZs?=
 =?utf-8?B?Q081ZGQwUFFFK0pwV2RQRXIyKzBhQndySDdvcWxXcDk0V05TU25tYWcxZFU5?=
 =?utf-8?B?ajVmc0o2cThSMExOMHAvZjE1bHNXYXhrV0FHcDVnN1NwQlVLVW11V3FSdWEy?=
 =?utf-8?B?aWo5OGNJZG5yRkxHSU16VkFzTkE3MjQ0WUw0YmI2Q2UvNEJQSWZJVGdpU3RJ?=
 =?utf-8?B?cHBwT1haZUtlS2swL3ZWVGtNaFNkVGgwcm1UdFB4aTBnMkNadVpuc0dTV2pu?=
 =?utf-8?B?N0lRbzZWeUtLUWlWVEk3N1Y5cEQ5WUZXYU1naWdhaEhLNzNQWUxYOXpFcUt2?=
 =?utf-8?B?S1oweUE1VWRxQzQ1YjBkRkNaVjZMNDNKUWhiN2VXSm00SnBlOGdxKzBBR2p5?=
 =?utf-8?B?SHdkK1V4cDAxSVpoWU5VL0k2dlZhdE13NzVJSmJPT1c2UjNLbDI0OWF6YXpr?=
 =?utf-8?B?Rll2ajNVakNZYWZoYkZQb2RqVzYwdk5LZGZTeUNmcHdGZ2Ricy9pY0VuNVpZ?=
 =?utf-8?B?cEt2d1d1VzQvajNpanowdmM4ZGlXTW5EWXFHaENyNlVUL0xYTnRaTDVRcmJy?=
 =?utf-8?B?UVRVYi9wZ0hoSW1MckphbWVCMTJsOUMyenZiMVhueVhBNzJoQVRkSjQyam9N?=
 =?utf-8?B?cDVEV0ovbHF2ZGZZVmJyL1I2NGZTZGY3T3prOEg3R054eWNkd21jdmNNY0Zq?=
 =?utf-8?B?dTBtV1RjMmowTS9SMVFEeUlDTXBhajk3ck9hb3lybEFZYVp6b2F4YmhmYjJo?=
 =?utf-8?B?K3JWSDk0RnU5MUxuS3FoeGlSODBXQ09lZ1NDWHd3MGRiL3grMHFBWnA2clNJ?=
 =?utf-8?B?c3UzeTBHTEtuWUZ1VE5hRnRPQTkzYUo4Sk14bHZ3d2crRzNFelFRcTF1OFhS?=
 =?utf-8?B?WEFlWklBK3JyNk5mQVdkbWh5ZEZxYXp3aCtlK2szdFd2cEdGMVh3UEhUanFn?=
 =?utf-8?B?VHl4ZlE5SjZTaSsyQ09YSWx6Tjdwcnd2cDVwRGdNVnB6bjJUdm55R2luSFky?=
 =?utf-8?B?dGhKZ2RwVXd6MlBqNmg0eWZOOFU0YmV2Skd4T1lhaDdmQXJGMjBDYWdDSjg1?=
 =?utf-8?B?UFFvakpjcytjMnlmdGJDajhHQjBiaGR6dG15Um9BN3FnOElBN1BqTVV2SzJS?=
 =?utf-8?B?cFc2WDJFWjNscVZWdW51bnFFeW5FYWxoWjV5N3RBb2dseE5kMTdHNytOZWt5?=
 =?utf-8?B?QVhXUTcwN2dKUVJweWhOZytKb1B1RHg5RGRURVhUY2NqdWRQaFMydHF5UjYx?=
 =?utf-8?B?OUxnQVVNRFRxRUxCZHd0UUh1RGFnPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd8b149-af57-4efe-5003-08dc5ee66a39
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 13:58:09.9031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdnpqnl+sDEN5HP9bGYzIWg3tMVlFdAT7ieDiHL7qziz6gtFXXJzqRLGRwWY+SKBIHxeT9XDaclnleTbJg3LS5iWztjlJ+c6j0bYEkAzEOx8o6o5qa1cLHnvmb2YxmDb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9351
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

Hi Lukasz,

On 4/17/24 13:16, lukasz.czechowski@thaumatec.com wrote:
> From: Lukasz Czechowski <lukas.czechowski@thaumatec.com>
> 
> Remove the log message "out" from sdram_init function which
> pollutes the console. It brings no meaningful information and
> might be unwanted in case silencing the console is required.
> Instead, add a debug log with a more meaningful message, printed
> only if DEBUG is set. The same convention is used for other
> boards, i.e. rk3399.
> 
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---
>   drivers/ram/rockchip/sdram_px30.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
> index 21498e8957..3b429973cd 100644
> --- a/drivers/ram/rockchip/sdram_px30.c
> +++ b/drivers/ram/rockchip/sdram_px30.c
> @@ -712,7 +712,7 @@ int sdram_init(void)
>   
>   	sdram_print_ddr_info(&sdram_params->ch.cap_info, &sdram_params->base, 0);
>   
> -	printascii("out\n");
> +	debug("Finish SDRAM initialization...\n");

Mmmm I don't think this is appropriate. debug() is essentially replaced 
with printf() whenever the selected log level permits. The issue is that 
printf() != printascii() and I have a feeling we use printascii 
explicitly because it is a much smaller way to print data than printf.

Additionally, we're extremely size constrained in TPL on PX30, so 
increasing the string size to print may also not be wise. If we are not 
enable to even build the TPL by defining DEBUG, this is basically dead 
code and it's as good to us as removing it entirely.

So... questions:
1) does it actually build if you set #define DEBUG 1 or whatever is 
needed for having the debug message printed? If yes, does it boot?
2) What's the size of the TPL with this change and with this 
change+DEBUG set?

What I can suggest instead is to guard all printascii (or at least the 
ones only useful for debugging) with the appropriate symbol, e.g. could 
be CONFIG_RAM_ROCKCHIP_DEBUG.

I have not tested it (only build tested on Ringneck PX30 without 
CONFIG_RAM_ROCKCHIP_DEBUG nor CONFIG_TPL_SERIAL), but here's a quick 
attempt:

"""
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index b7a6f100d41..17656e99a2f 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -11,7 +11,7 @@ config ROCKCHIP_PX30
  	select TPL_NEEDS_SEPARATE_STACK if TPL
  	imply SPL_SEPARATE_BSS
  	select SPL_SERIAL
-	select TPL_SERIAL
+	imply TPL_SERIAL
  	select DEBUG_UART_BOARD_INIT
  	imply ROCKCHIP_COMMON_BOARD
  	imply SPL_ROCKCHIP_COMMON_BOARD
diff --git a/arch/arm/mach-rockchip/px30-board-tpl.c 
b/arch/arm/mach-rockchip/px30-board-tpl.c
index 637a5e1b18b..8f56147ca7a 100644
--- a/arch/arm/mach-rockchip/px30-board-tpl.c
+++ b/arch/arm/mach-rockchip/px30-board-tpl.c
@@ -36,7 +36,7 @@ void board_init_f(ulong dummy)
  {
  	int ret;

-#ifdef CONFIG_DEBUG_UART
+#if defined(CONFIG_DEBUG_UART) && defined(CONFIG_TPL_SERIAL)
  	debug_uart_init();
  	/*
  	 * Debug UART can be used from here if required:
@@ -51,8 +51,10 @@ void board_init_f(ulong dummy)

  	secure_timer_init();
  	ret = sdram_init();
+#if defined(CONFIG_DEBUG_UART) && defined(CONFIG_TPL_SERIAL)
  	if (ret)
  		printascii("sdram_init failed\n");
+#endif

  	/* return to maskrom */
  	back_to_bootrom(BROM_BOOT_NEXTSTAGE);
diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index 67c63ecba04..cb59bcf0414 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -16,6 +16,8 @@ if RAM_ROCKCHIP
  config RAM_ROCKCHIP_DEBUG
  	bool "Rockchip ram drivers debugging"
  	default y
+	depends on TPL_SERIAL if TPL_RAM
+	depends on SPL_SERIAL if SPL_RAM
  	help
  	  This enables debugging ram driver API's for the platforms
  	  based on Rockchip SoCs.
diff --git a/drivers/ram/rockchip/sdram_common.c 
b/drivers/ram/rockchip/sdram_common.c
index 60fc90d0a5c..8076cfa9aad 100644
--- a/drivers/ram/rockchip/sdram_common.c
+++ b/drivers/ram/rockchip/sdram_common.c
@@ -231,7 +231,9 @@ int sdram_detect_col(struct sdram_cap_info *cap_info,
  			break;
  	}
  	if (col == 8) {
+#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
  		printascii("col error\n");
+#endif
  		return -1;
  	}

@@ -348,7 +350,9 @@ int sdram_detect_row(struct sdram_cap_info *cap_info,
  			break;
  	}
  	if (row == 12) {
+#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
  		printascii("row error");
+#endif
  		return -1;
  	}

diff --git a/drivers/ram/rockchip/sdram_px30.c 
b/drivers/ram/rockchip/sdram_px30.c
index 21498e89570..607d97c268e 100644
--- a/drivers/ram/rockchip/sdram_px30.c
+++ b/drivers/ram/rockchip/sdram_px30.c
@@ -231,8 +231,10 @@ static unsigned int calculate_ddrconfig(struct 
px30_sdram_params *sdram_params)
  				ddrconf = i;
  				break;
  			}
+#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
  		if (i > 6)
  			printascii("calculate ddrconfig error\n");
+#endif
  	}

  	return ddrconf;
@@ -281,8 +283,10 @@ static void set_ctl_address_map(struct dram_info *dram,
  			  &addrmap[ddrconf][0], 8 * 4);
  	max_row = cs_pst - 1 - 8 - (addrmap[ddrconf][5] & 0xf);

+#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
  	if (max_row < 12)
  		printascii("set addrmap fail\n");
+#endif
  	/* need to disable row ahead of rank by set to 0xf */
  	for (i = 17; i > max_row; i--)
  		clrsetbits_le32(pctl_base + DDR_PCTL2_ADDRMAP6 +
@@ -523,12 +527,16 @@ static int sdram_init_(struct dram_info *dram,
  	/* do ddr gate training */
  redo_cs0_training:
  	if (data_training(dram, 0, sdram_params->base.dramtype) != 0) {
+#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
  		if (pre_init != 0)
  			printascii("DTT cs0 error\n");
+#endif
  		return -1;
  	}
  	if (check_rd_gate(dram)) {
+#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
  		printascii("re training cs0");
+#endif
  		goto redo_cs0_training;
  	}

@@ -543,11 +551,15 @@ redo_cs0_training:
  	if (pre_init != 0 && cap_info->rank == 2) {
  redo_cs1_training:
  		if (data_training(dram, 1, sdram_params->base.dramtype) != 0) {
+#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
  			printascii("DTT cs1 error\n");
+#endif
  			return -1;
  		}
  		if (check_rd_gate(dram)) {
+#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
  			printascii("re training cs1");
+#endif
  			goto redo_cs1_training;
  		}
  	}
@@ -712,7 +724,9 @@ int sdram_init(void)

  	sdram_print_ddr_info(&sdram_params->ch.cap_info, &sdram_params->base, 0);

+#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
  	printascii("out\n");
+#endif
  	return ret;
  error:
  	return (-1);
"""

I haven't put too much thought into it, so this is probably not the 
right way to do it, or it's reaching too much. After all, there is some 
important information that needs to be printed sometimes :) Don't know 
which ones for the DDR init though :/

Cheers,
Quentin
