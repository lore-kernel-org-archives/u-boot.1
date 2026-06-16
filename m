Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A4DCD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 11:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDA9584119;
	Tue, 16 Jun 2026 13:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="JP5vwkrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6E1F846A4; Tue, 16 Jun 2026 13:14:31 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC93A84105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 13:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/stNbwfmgGky3uroP/PQQzpK9PkLW2vMbqhiJEUqB0m2WVCJ0FCNoM0pVbNwVYts4CLJAjYb9K5nkV0KpeD2Ev0VhhG40DRcdoE8L8GE4d8fms4RT4w34bDcyGehZKTFBsKaBU3ifOi9HmaevsiZeXb0iJ9k3z0kbQYZf+RO2+aMetUlziPYDhzEyqeXCSWzpgVmZca+JZqa9I+2curovHDiJWCBx43k/dSPqpFQiiJaP0GjUmC2EP6qlrzA605nvjoqRONbPX9zEgK71Jmz8HNmrYWm+kG5+FBuUq3d1phpQIhBQvK9JCxcZhM/Rb/E+tWxn/pyODyAgwjZBKwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0lYT3orjk6VXPtLjoVwD7Fn+3h/jrwt8fXwZDJUbCQ=;
 b=hZJWzhvIRBzQn3flEEhnlDXfzR1tg+g5No7bZgoYUxHw+EmFK20BLrA4J9vr5eUNxo2OPMqOHIRcq5w5WPdTSFuAHbGi0PSfH/2PB/kcTKdmHHuFk3d1bBnAplNn2rKLBvd2ONCgGCyOIahRckCfwTPGv6VwyFkejsYmqynyXYfK/+3ypJA2Ssc0qlgmzcJsOV+aEKfAFbvUV/0yumOwGv/bR9lgWoIuiPox1NdMPnfvZI+gMlSeAcBZrV6lYmAUswoRCQ4nC2Obx0mDOiY6flt0uijGqrMqhkHmy9nJcRfEJhXxN4ZTU3W1V0OiH7wM3eAA+ov3Kmk9ObOAJKf3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0lYT3orjk6VXPtLjoVwD7Fn+3h/jrwt8fXwZDJUbCQ=;
 b=JP5vwkrVzeFZzRxcW2kgDDc9wqd+9rhaD5xuuR2UKgio26UCLVn5EMAidJQpVxJFK/lF6Syb1DTQnzQdHCGY1rHROz70C5ALHhgtdyRgWOlglIoPkpSa8cdLO5Kr/lTX+nEtKuQTPiffXJSzigltcubfSZb5fq4U/pE9uyneaXAWCRw0U6Z+u8vIgNnJwewHOhx5V86unAIGKhDUqehC5u7odK8PIas87IZmFyK+5TdYbPrhZTtt7LNTpIjsWcmF5qJ6Q99Y0GEMimRe3Wx/ez12uYKqsOimwn5ZfyFs7QTATZdoa3mYZpwIF4aIj5j1YcuQOyKwfYFil6AqQIiIQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AS8P195MB1797.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:529::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Tue, 16 Jun
 2026 11:14:27 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 11:14:26 +0000
Message-ID: <b5ff80b6-d40e-42b0-a8a5-99f72e61aaa6@phytec.de>
Date: Tue, 16 Jun 2026 13:14:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm: mach-k3: am642: Update MAIN UART1 serial alias
 from 3 to 1
To: Vishal Mahaveer <vishalm@ti.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: Anshul Dalal <anshuld@ti.com>
References: <20260605193829.395161-1-vishalm@ti.com>
 <20260605193829.395161-2-vishalm@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20260605193829.395161-2-vishalm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::6) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AS8P195MB1797:EE_
X-MS-Office365-Filtering-Correlation-Id: cefa41cc-e199-4756-2157-08decb986d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|366016|376014|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: THF7X59vnB0RkMaOEl2q19RGa5aD1c4QhHRgZxOaKqO6AdcA5rqyFFWheNQ8OR9V+/aPr4UOBGDDov7hDG/cTX0MohK9LaW/3ysZ7izbhBLKGb5L+PcvxT2PdVcxL8188ZJSgOwfECXcdAoo27VZxw2M/dDCllkn8Pqdu5KEIxVygmqk6QfOwvCYEWFAqujjMEMLWb7gpjvPuBy6c5ZxdcVQ0dCAqdq6S7jhlfc0vHoVkaKX4WZd9vWQM9t3GXUhJaLedbAbz9X4rDjrbw4oJxy23cJi3WFpgqZIamBaBfuQdi65UjKmAN6EgP01UKzTkxid26QIj1lox589s+WZu0UUvarzbyV2X05y1HzI7Wss57Mc+x2/k3JlwpHbsaGEGioT3yUKVhni8nut35bO3T/p23mWy+DUr0CYMH7krZJS8HxY2syjM2GT/CN2YIUX8g/maIg2NhuhDFpT1Jas7z+58XWI/BIP0bnkpr32wkKpo07iqRDHAyEinTWchYYE09KCMrKtqwoUEYDh7aoyg96h+Zx5HqWt9Q8bAFn+iKVmiT12WJ78iWmfFVs6/2HOfFIfOQw7TyM1DkQZ9C5NppQzMDtaV+ZGQ5qnKZUap96CiSCGlyH6DJQ2K+vBJQCDQtXRhrpNGowLY3RP4KgIFhHqQTpNDy7WfxMJOjN+OZbY+qnmfZnSrQ32qkFsgbsW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ly84YURkUklEK2ZPK25xQlpJOFpuMURuSmt4Znl1L2dOYkVqb0lmenpsa2h4?=
 =?utf-8?B?bERHazZwZ0tqc2czUFJoUFlHNFYzc1BjelFwcVlEbUtWWFFQSUlteWltRnNO?=
 =?utf-8?B?Tk9SWE1reWQweitEU1ZNWi9vZkRodmpwQk96WWxodVhCSmREbGJVN1FYMVdO?=
 =?utf-8?B?WU0zQ3lYeTJZQUdLZDhXSzZzSExEdHlJaXI4aEZNRkJPMFNad3RHK21UUVl4?=
 =?utf-8?B?K3pPL1BueXd3WVYwb3hUbzd2T1JOekVxWUx2OS95R0l1cWszc1NveklKQ3Bv?=
 =?utf-8?B?TktrVmx1MHBadkZvb3MvM2hLQzJkWDErcTN4TFgyNHhwL1g4SjF1bTVzcW82?=
 =?utf-8?B?bzYwelBiRTdSN1BYOS9sUHBmYk9uaG5SeFRac3BhNmJEN0txRkIwK2wrZGoy?=
 =?utf-8?B?d0ZrdjNSRTkwNm15K1pNdjBNTzZVUmNXOW95ZXVTMnc3NER3cm8ycThqcXln?=
 =?utf-8?B?dlBIQnJGL1IxU3gyWmwwdVAzVGtDTHVSSEVyNFIrd2JVMzFUY2dtUDdJU2pr?=
 =?utf-8?B?QXZ1K3NKcVZUTmNTcGxWRHR5aGZGWkhXMTlnYlpSbGlQaTltdTVoZjdLb2Rx?=
 =?utf-8?B?LzVwVEg3TlJxNXdxaVhnWlBLNEFoZkU0VGk5L01CWlVxZGpGTHhQYzZxVVVr?=
 =?utf-8?B?RHFtbW1vNzJnVWhJY0VOM2Q5REN3NjVFMWVHYmVIWTFsaHZLQVpsNXJqV0xM?=
 =?utf-8?B?WmdsV2VjZ29jQnJmejBtSUN4ZU1WaCtpOWoxdVpTMitqWUxlUmd0TXI2SXlS?=
 =?utf-8?B?Z1hYcFdnQ0hlN0tKanBpamR6cE1PVWh4RFZ1Tmc5ZHJlOUZ6My9RbTFDT1lz?=
 =?utf-8?B?SDVIbUtKbzZhL1liN3g0cmwrNHU1dDhuNEJEeE1sUFFZRXNZUW8rcFh2ak92?=
 =?utf-8?B?cTIrU29Cd3Zzc29uQ3JqY1ZUa2hoV0xGaUR3WWlZM0d4bGJzK3FaRGRCSmth?=
 =?utf-8?B?WkdXcHZvSWhDRitJbXN1WmJtN0xLM1FZSWpmM3doRFVLR09RbjJncWlmcFRv?=
 =?utf-8?B?T3pTdndCSWVXRnd4dkhobHpZY1NCRVAzU29rL25vc1lMODlyYmcrR29JUVFx?=
 =?utf-8?B?TlpmRTREeDg0emdjR1RwOHhrNitwYy9haXFrVGlqWDRFREhQWk1LZ09OSm9B?=
 =?utf-8?B?Y25FR2JLM3dXSDAwMHBLelFTZlFGTVo3c1lWSVB6MHdHd0tFUG01anVyVS9k?=
 =?utf-8?B?azNKZnBCS0MyMWUvYnY2OFkvWXg2b01xNjRObk9wa1BzNjBJUURqQ0pHM05W?=
 =?utf-8?B?ZFhTbStNUDJUVTdLRXExVUJkMi9HSmxjM0Q5WTV1TEN6VlZEZDJMb3hNVU56?=
 =?utf-8?B?QWNWK2NxclcwRFhnV3k5OS9PS2ZNMUZWNXNuVnBEZmVDTzhUamEwbGw1aURt?=
 =?utf-8?B?QU9RQnlmUkJsRjVTamVsbSs2T01ndUJuQzNMV3Zlc1EwWjBOTHJPRFFtaDBD?=
 =?utf-8?B?bG90RXdIdUJrdEwwWjlVWnM3ZDl4MFpzVmFPV2tCUmp4YTdmTlVGSG9JUUdS?=
 =?utf-8?B?UG0zNkpRN2dRbmljLzFwRFZ6YTdkaE1NazZXRjVqWS9wbzRYWWhpcEtKVFNm?=
 =?utf-8?B?OUtvUDA4bnc0USs5NXZ1M1FiUVBhS1AxWmdCZGJ6SU1OM2c5T2tiTXM0OXRn?=
 =?utf-8?B?Q2Z4aFRzWE1nWjNhT2hmbVA5dEZzdWcyYThBZWFJZ1Z5VVlZTUZIZlVldXpP?=
 =?utf-8?B?cHFERkF6NWpwL2pxaVBrL0s0a3FUL1kycXFtV21ra3BXNkFheEYrR1Q3Q0M0?=
 =?utf-8?B?dDlreWRVV25Zc2dia3RHekRtK2tWSlpGUExqWE5hWm04K3Q0WjNEaUtuSTVz?=
 =?utf-8?B?TW1PVjNCZzg3L1BsMmhvTXdUTHBJQmJnUUlFaktxUlRPVE1TL3JNTUQ5ajl3?=
 =?utf-8?B?b2JTNHY0aG1BdUNlNGVGQzcrYjhKQUdOWXZqYlo5djE1NHpVZFZKMUdhdTcr?=
 =?utf-8?B?N0pRWjgyRjNIS0ZBYnJrb0FwSzc2YUhFbFBtdFV6TGJ0VVlLRUlTOVpFdG5k?=
 =?utf-8?B?T0tVL3pSNXlITlNDZFFPWDZBYWVZSXRaY0Ntck9vbDcrZE5OZ3lpc3p2MUpz?=
 =?utf-8?B?SStXT0pWUXp6K0JsdUkxR3p2SURUMUF5MmxWcmoyVmZ2RmlHWjVQck9RaHhw?=
 =?utf-8?B?VnN4RmpxQmNQWDV4Ukk1a3NuWWsxMUFTSDZIb0Z1V2ZpK1VSVUFJZFlXZDVx?=
 =?utf-8?B?UmJpcktBRTk5M3VkN2V0NGh1L1RkUytnYXpCRjVFY1N3NzZRRXhmR09EZVpx?=
 =?utf-8?B?bkQ5aGh6TEV1WEozOWhINmhRMFRWUXBXeThVbkk0bVB4bUhsazFuSVk2QzZh?=
 =?utf-8?B?Q2s0TFc4STY5a0dLWUEybFhUbXh1V2VQZkVWVHl0UGhaM096ZGdUUFJTTktZ?=
 =?utf-8?Q?gbR9kXwBr/4MF7/pEY0agVwyX4ZTrQktw+BCEfm+CivsY?=
X-MS-Exchange-AntiSpam-MessageData-1: r3D4bFQtGVkoiQ==
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cefa41cc-e199-4756-2157-08decb986d9e
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 11:14:26.9465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwSBjDS/i2PIiJAIuRKIc4nB4BV2Gme3S83kepye0YRX0iWbRLDATo9TmusPubQilifi1qSTjR66KK6+o8T1LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1797
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

Hi,

On 6/5/26 9:38 PM, Vishal Mahaveer wrote:
> The upstream device tree changed the serial alias for MAIN UART1 from

upstream where? Can you point me to the related change?

Regards,
Wadim

> serial3 to serial1. Update the board initialization code to match this
> change by modifying the UCLASS_SERIAL sequence number lookup.
> 
> This ensures proper pin control configuration for the UART used by
> system firmware (SYSFW).
> 
> Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
> ---
>  arch/arm/mach-k3/am64x/am642_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/am64x/am642_init.c b/arch/arm/mach-k3/am64x/am642_init.c
> index a15adf1cb1e..d6cc7a85aae 100644
> --- a/arch/arm/mach-k3/am64x/am642_init.c
> +++ b/arch/arm/mach-k3/am64x/am642_init.c
> @@ -212,14 +212,14 @@ void board_init_f(ulong dummy)
>  
>  #if defined(CONFIG_K3_LOAD_SYSFW)
>  	/*
> -	 * Process pinctrl for serial3 a.k.a. MAIN UART1 module and continue
> +	 * Process pinctrl for serial1 a.k.a. MAIN UART1 module and continue
>  	 * regardless of the result of pinctrl. Do this without probing the
>  	 * device, but instead by searching the device that would request the
>  	 * given sequence number if probed. The UART will be used by the system
>  	 * firmware (SYSFW) image for various purposes and SYSFW depends on us
>  	 * to initialize its pin settings.
>  	 */
> -	ret = uclass_find_device_by_seq(UCLASS_SERIAL, 3, &dev);
> +	ret = uclass_find_device_by_seq(UCLASS_SERIAL, 1, &dev);
>  	if (!ret)
>  		pinctrl_select_state(dev, "default");
>  

