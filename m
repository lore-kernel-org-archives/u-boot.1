Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92215CD8C9F
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 14:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12D0083FEC;
	Mon,  8 Jun 2026 16:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nGwYzwJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DB7E8466E; Mon,  8 Jun 2026 16:53:33 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2B15838BB
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 16:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/r11puaqyXAihBUMS+LKX9Byxt4BZdiIyxyg926ediYTMRKKNKMKzCR/hdZgm24WL41W+QD0R8rFon+r3O7FRUZuv8yDKtrwMoDOogzde8O3UxtTjiP8W7sa+M+bs/gAWSeDN8UOqJ4P6+71l2frmpsCvL+dJxnjxetiO1Slv+vW0gJnbrdtNPAtjWcXPjhFDiP5pNbXGnhb9uFWrC9CDzY2PrcrnM92xkjmYacoYBrfjCBAmCp4C9uE5vVym4AvstFPuZZr2ckkNxBOkznTMHTWMeOWFMVCcEY6u+AsRrv7cSmci/JewQPJtKtSmiNTdj/iHeFM2csu3LJpxfR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jJqffbuMeNtsFocm8f8v3VrIlhohlNei3v/9C+N3To=;
 b=X9IA2h71Rr+e3bNFZDoxv1/S3IiNA7xkj7He8rbV0LU+iCe+7RAQ68bY32BAg4QD1RVIKDul2gXc42CTQjqBeAervpWXY0+87ZPjDBSMEkeia+5bNCDrI9k5/ZgLGguQ5J4ql9atiTsK+FWQau5kx68biT8v9b+BLLTisZXZnmOs/DEkUBueScOGqbnIixlhw8iwjMD+mHjsoLvJHnqefFgZSIjbgkWqarw9gS6f1J1GSVBolQgagwSBtIkZm2WoVviOIFZiHDj3zxKsTZtAUO959usuR2dxXN3mnItccKsvAbLTYJCaDK2ER8f8u4JhwE64N0eXpTMMzBArzFD/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jJqffbuMeNtsFocm8f8v3VrIlhohlNei3v/9C+N3To=;
 b=nGwYzwJ0hYR6Qnj47T5I2o35CBzrfTFReiIKjxWY3wjqnMwV9tL/LsHsBQlnjzLEaOfFyU0O5PXMSKSXKVedi6zsNvZKQEXTTsV0ukD5fdktWas1IZlp6BXrnXQVdBhenfuRXmFNL1MuHZ521MgDmvXjL3GsFg/i4i8n5GQgpJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AS4PR04MB9481.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 14:53:25 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Mon, 8 Jun 2026
 14:53:24 +0000
Message-ID: <4fc15188-3de9-4345-85e9-d594efe9bdd5@cherry.de>
Date: Mon, 8 Jun 2026 16:53:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 me@samcday.com, aswin.murugan@oss.qualcomm.com, clamor95@gmail.com,
 michal.simek@amd.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-4-varadarajan.narayanan@oss.qualcomm.com>
 <667ec81b-da7f-4b10-b1ae-45e578cd9d54@cherry.de>
Content-Language: en-US
In-Reply-To: <667ec81b-da7f-4b10-b1ae-45e578cd9d54@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::6) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AS4PR04MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: 47271061-ce6f-43f8-4b03-08dec56db101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: /WIMIKvR48xaQhSC1+XLFIfWg/xjmIPKW7mC5ovlpOycH2AxOIcxFZgnb0iZ1J4g/FcLl4IIEl7AJ2fIzKZuEFX2BsA2oodvrvVdTbas7eKgBkGH0BdntLdgZJVsqvqnL7Z3S14pDlMGgmswyXroze3bhmip+V4FcxVg7LWzk22eCVbrpFc/1U2cAM1fz8LshpmtRZyjRou4kzzwV17VGgMtC2lP30orsUuGqZCw3gzF7nFP9xcPlck+AtZvts+fIrL+1moOyIpF8U7SMgvUGUQM1rFdNdqdHozSEGIosANrsdJNp68e4UtPgrkjIhNqV0BxqrV9E6R+57p0TYk7HJB+LgmORfQQhWMsrlz24dFHrP6bsE6+y9FonpFsWhuE2LOj+zsmF69M+M9o5BFxcoP9qU+YnmFtrt8igbuFGBM20mZbhWekIoLS7zC128rkrf2FyoJj7/70fU5/8QZ/gLBRVs3i80CAq1Xgi1lx60hoGCLg2RvuE6sVyPbTUJ51Xw1J81+HLAg4eNzkpAxep7cFEa9NIWDZ6+jAoibb6laWl2O8uGi0Ue2vpJdrTlOHbKqzw3EGTdnb3P8wUi3OnlPi38Y27sAQsXsV0LkSl1gKpbNCm07BKGs/biQ7RIuyCH/irmHYr1QsvNPaAjTPZOs7fJw45Tl1FFTmvk6nXwfbUq93MEBT3dRWtc5UqMMgtVxOarFwtEzaihv/uF9arp+t587CS0SeM8Nb1gjC9i8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXdoWU1neWZlOXNZaXJOODZ4MFpqMGJnZGhZbVpmb2ZhRzA0bm1HZDhCUDBL?=
 =?utf-8?B?MWovdVJoQmVWYzlLak5CdFNUUzhneXZqWnVHRlk5YnBkMGJsYzdKamhDdXJt?=
 =?utf-8?B?QVE3d1d0Qi9vbWIzRDcxYzBoV3VRa0krenZBRDgzOXY1YVBsWjNFNkg0ODdC?=
 =?utf-8?B?eEdaejZTRXZwRmJod0VLUlIvZE1rTFZPcmxVNFAzSjk1NDhpTHVVWGtxdFlW?=
 =?utf-8?B?RVJqNHFSOGNJeHJnNzdlSWxZYXd5OHphRGhINWluRkFwREdMUDd1TTJza3hj?=
 =?utf-8?B?U2xpN3NQd0NaWXFZckZibjN3U0NyOTdEcTM3M2EwTGpoWGp1THovbFNXeXBu?=
 =?utf-8?B?eXhja0RNU3YvdCtLTmtINHF2SWZrcHR1MFgzV0VmdktZMmZNYzQwK2pWVG1O?=
 =?utf-8?B?L3BNa09xeTJ0ZzZVT3JkYmpocmpmeWtVYmJwNWRiQS9FUzBZU2pwZHk4YlBL?=
 =?utf-8?B?UDk4M1l0NWVCZ3dtMkJseXdLOXRDMWF5YW9UeU53d3YyQ2VaRUVrbnUwNm5N?=
 =?utf-8?B?NWkydCs1dC9OeWhLVWd0QjNlb3haUFkyS2tseko0LzMyWU9TTGg5Yjl5YjBX?=
 =?utf-8?B?Q3V5aEhtT1VYb2xoVktNSldQekxXSVJtTmE1SlVTSE1mVFRtMk9GMHBxRm54?=
 =?utf-8?B?cm1SN2tFd2JsOURPWTF2ZmR5YWxST2R2dGFCdWVBK0VFNmpFZkNydnUwQnNv?=
 =?utf-8?B?QmNCeHRJek9rdWl6TnV0YXZlcGVZeVV5R3EyV2lOV0RsK1dSeVFGR0FEWStF?=
 =?utf-8?B?L0piQXRSYW43QkV4U1ArZ2IwYXRMYzg4Ykh3VlZlbUJjQTR2NFBUUmtJSHF2?=
 =?utf-8?B?c1p3YzNZc29obVhmcjl2R0pFRWkrMlFVeTBpTDFoV000d2k4a2tIUTNkb3ZI?=
 =?utf-8?B?Z1FYcVMxTXhDY3hPKzZHN205Q3diT0NybElLLzlZdTFrNUtkTWJLKy9pODdS?=
 =?utf-8?B?MFE4V0U2K0RnVm1aQjdrNXkzSDVIcnU4aUJkYWtqcU9BOE5GOUtKVFlJNmps?=
 =?utf-8?B?RGhZYnpNY01td1cxYXk2RzFyeENYZC9vdExLWGsxTDJEKzJLS04wVCt3SCtN?=
 =?utf-8?B?QmF2aHRtQ2hIZUtwNW5RNE54UVovd2RlMnBwdlBSSndvS2R1ZEtpb25uanIx?=
 =?utf-8?B?KzREUWdNTjdYTVEvN2FTaDhPOXNjaHkyVlo1cGcvcGQ5YVkxaWtGb2ZNYkhw?=
 =?utf-8?B?ODl0UXhrczNmLzIwMlkrTFlCZHEwa0tJc2drUWxiNWFrNXVtMVVvL1B6VVJ6?=
 =?utf-8?B?cEZ4NW01Zm50WTN6bXZUa0ZrUWY1Nm1kak9QWW0wM1FxT0ZNTFRGOWhCOVBG?=
 =?utf-8?B?LzRMOFNvVjQ2WlZrWksyYXN4Nkh0V2l0bGM4dXVPTTRndStTQzRpZTRwWWNS?=
 =?utf-8?B?aGJwU1prc1NscmttbU5ZTHlLcnRnVXlVZDJqRldtajd6K0VvRFBsYWtGNTFJ?=
 =?utf-8?B?Qk5nenhNbm9ZWUpzY0FGbzdVMXRUTTBBakx1cE5BUHVvQ0ZtdzVqVDE4Y0hD?=
 =?utf-8?B?QzBGMnNDNkNjbkRRdStHTGNNQjk5UUxKNXMyMkYyekFPYzVPbnpZeEFJQktu?=
 =?utf-8?B?R2psdmowakpFOFJ0NENiS2hib0xIRFI0VklobU9JVk9yK0lGditES1BNTWpr?=
 =?utf-8?B?MHBlcWl1N21SVmtFRTlJc25VNW9iR05qNnNwaUdmdVdHWG9LcWlwZnRIOFdZ?=
 =?utf-8?B?V2ZLTUpYblpURTV5VXEyd3hha1YyUDhsMisvVEV0a2Z1SCtFUG1Xa01vMVk3?=
 =?utf-8?B?YnpJY2VCQUtGQVRDc3NkSnIyUmlleGM5b0NKWnU2VDJxV3ExNmNyUEJiKzhy?=
 =?utf-8?B?cTBCZHFJWE9UejMyRkZXYmRZQ2hUZEljV3QwK2hlWGllR2lxeXZjSlpJc2Zz?=
 =?utf-8?B?SnlJY0U1N2FHMVZIb0NueGk2SWpuTGl1allZcVR0N2lUeEMxQ1o0cnJCdW1O?=
 =?utf-8?B?MG1xOVhwYkllL0g5d2NjRlpyd1d5ZGpBakU5eE9wV21yNFgxeFNxTk5XMWJ0?=
 =?utf-8?B?N1NtTHliSkwxeW5jMklORHBZb2dNbVQ0b2p5MzY0N3hZS0sxcitFM1RLWFE0?=
 =?utf-8?B?MWpaeHJIdmFxejNrVk15OENOV0o3V29HNXIrY3dRNXB5VFE2R0ZPbysxeXBq?=
 =?utf-8?B?am5xR3QzTithdytYaisxWkRpUHZ3cmx4bitYc0FDU01qS3pXcWUreHB3eVYy?=
 =?utf-8?B?aHdxUkYxMkkya2xpS2ttUXQwNGFuZWRFbWg4Y3NIbmVVaUVXMEdna3MxK0s2?=
 =?utf-8?B?RkU5dytacGlWRUVuWjdKT0dWVEgvSWRwdGFXbGtLb0ZiUm5SK2RMYm9FMUN6?=
 =?utf-8?B?Ry95QUlDMkRkZUkvdzcyR2JPbEhUa1RFNFVzeVVHeDF0ekZQd1dTQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 47271061-ce6f-43f8-4b03-08dec56db101
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 14:53:24.7493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpwZyZJx+j7RPXxnQ0iCnCt5IcyrB7T8Kmwdt7gsmxqA92bTRql0XXqbn1yFy3j0Nd6SSmXiZnG2bQRXhU4RW+TQqKKvfhZQMQL8AaOtiJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9481
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

Hi all,

Gentle ping. It'd be nice if we can fix this new API before we have a 
release made with it?

On 5/26/26 3:32 PM, Quentin Schulz wrote:
> Hi Varadarajan, Casey,
> 
> On 1/21/26 7:39 AM, Varadarajan Narayanan wrote:
>> Implement request_arg() sysreset_op for QCOM SoCs that use
>> PSCI to reset to EDL (Emergency Download) mode.
>>
>> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
>> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>> Signed-off-by: Varadarajan Narayanan 
>> <varadarajan.narayanan@oss.qualcomm.com>
>> ---
>> v4: * Check if ARM_PSCI_1_1_FN64_SYSTEM_RESET2 is supported before
>>        issuing it
>>
>> v3: * Move argument handling to a separate function and pass the
>>        arguments to the actual handler to process
>>      * Drop Qcom specific SYSRESET_EDL from the common enum
>>
>> v2: * Update commit message
>>      * Elaborate Kconfig help text
>>      * Use '-edl' instead of 'edl' for consistency with other 
>> arguments of reset
>>        command
>>      * Remove 'weak' for qcom_psci_sysreset_get_status() and make it 
>> static
>>      * Mention 'SYSRESET_EDL' is Qcom specific in the enum's comments
>> ---
>>   drivers/firmware/psci.c               |  4 +++
>>   drivers/sysreset/Kconfig              |  6 ++++
>>   drivers/sysreset/Makefile             |  1 +
>>   drivers/sysreset/sysreset_qcom-psci.c | 45 +++++++++++++++++++++++++++
>>   4 files changed, 56 insertions(+)
>>   create mode 100644 drivers/sysreset/sysreset_qcom-psci.c
>>
>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>> index 2e3223e1c32..b6838a244d2 100644
>> --- a/drivers/firmware/psci.c
>> +++ b/drivers/firmware/psci.c
>> @@ -186,6 +186,10 @@ static int psci_bind(struct udevice *dev)
>>                        NULL);
>>           if (ret)
>>               pr_debug("PSCI System Reset was not bound.\n");
>> +        if (IS_ENABLED(CONFIG_SYSRESET_QCOM_PSCI) &&
>> +            device_bind_driver(dev, "qcom_psci-sysreset",
>> +                       "qcom_psci-sysreset", NULL))
>> +            pr_debug("QCOM PSCI System Reset was not bound.\n");
>>       }
>>       /* From PSCI v1.0 onward we can discover services through 
>> ARM_SMCCC_FEATURE */
>> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
>> index 6fb0ca81dc6..905ad2a7769 100644
>> --- a/drivers/sysreset/Kconfig
>> +++ b/drivers/sysreset/Kconfig
>> @@ -301,6 +301,12 @@ config SYSRESET_RAA215300
>>       help
>>         Add support for the system reboot via the Renesas RAA215300 PMIC.
>> +config SYSRESET_QCOM_PSCI
>> +    bool "Support reset to EDL for Qualcomm SoCs via PSCI"
>> +    help
>> +      Add support for the reset to EDL (Emergency Download) on Qualcomm
>> +      SoCs via PSCI.
>> +
>>   config SYSRESET_QCOM_PSHOLD
>>       bool "Support sysreset for Qualcomm SoCs via PSHOLD"
>>       help
>> diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
>> index f5c78b25896..8bb1eabd48e 100644
>> --- a/drivers/sysreset/Makefile
>> +++ b/drivers/sysreset/Makefile
>> @@ -30,5 +30,6 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
>>   obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) += sysreset_at91.o
>>   obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
>>   obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
>> +obj-$(CONFIG_SYSRESET_QCOM_PSCI) += sysreset_qcom-psci.o
>>   obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
>>   obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
>> diff --git a/drivers/sysreset/sysreset_qcom-psci.c b/drivers/sysreset/ 
>> sysreset_qcom-psci.c
>> new file mode 100644
>> index 00000000000..3627bbf5c82
>> --- /dev/null
>> +++ b/drivers/sysreset/sysreset_qcom-psci.c
>> @@ -0,0 +1,45 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2017 Masahiro Yamada <yamada.masahiro@socionext.com>
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <dm.h>
>> +#include <sysreset.h>
>> +#include <asm/system.h>
>> +#include <linux/errno.h>
>> +#include <linux/psci.h>
>> +#include <asm/psci.h>
>> +
>> +static int qcom_psci_sysreset_get_status(struct udevice *dev, char 
>> *buf, int size)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static int qcom_psci_sysreset_request_arg(struct udevice *dev, int argc,
>> +                      char * const argv[])
>> +{
>> +    if (!strncasecmp(argv[1], "-edl", 4)) {
>> +        /* Supported in qcs9100, qcs8300, sc7280, qcs615 */
>> +        if (psci_features(ARM_PSCI_1_1_FN64_SYSTEM_RESET2) ==
>> +                            ARM_PSCI_RET_SUCCESS) {
>> +            psci_system_reset2(0, 1);
>> +            return -EINPROGRESS;
>> +        }
>> +        printf("PSCI SYSTEM_RESET2 not supported\n");
>> +    }
>> +
>> +    return -EPROTONOSUPPORT;
> 
> I think this is a logic bug.
> 
> For reference, what calls this function:
> 
>    int sysreset_walk_arg(int argc, char * const argv[])
>    {
>            struct udevice *dev;
>            int ret = -ENOSYS;
> 
>            while (ret != -EINPROGRESS && ret != -EPROTONOSUPPORT) {
>                    for (uclass_first_device(UCLASS_SYSRESET, &dev);
>                         dev;
>                         uclass_next_device(&dev)) {
>                            ret = sysreset_request_arg(dev, argc, argv);
>                            if (ret == -EINPROGRESS || ret == - 
> EPROTONOSUPPORT)
>                                    break;
>                    }
>            }
> 
>            return ret;
>    }
> 
> The issue is that the first sysreset device implementing the request_arg 
> callback will consume the args and return EPROTONOSUPPORT which will 
> stop the loop.
> 
> Think about multiple sysreset devices, and let's say we have a new '- 
> dummy' argument to the reset CLI command, then it'll depend on the 
> registration order of the sysreset driver whether the dummy argument 
> will be handled by the qcom driver which will return -
> EPROTONOSUPPORT since it isn't '-edl', or by the dummy sysreset driver.
> 
> I think we should have a fourth possible return code which is "I don't 
> know how to handle this argument", e.g. à-la IRQ_NONE in Linux kernel 
> for interrupts that aren't for the device this IRQ handler was triggered 
> for. Or maybe we should really be using -EPROTONOSUPPORT for that 
> meaning and not exit the loop if that's the return code?
> 
> Or maybe I misread or misunderstood the code?
> 
> Cheers,
> Quentin

