Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD6BCDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 11:52:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A6DE8404D;
	Fri, 26 Jun 2026 13:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="komzkKLB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D568460E; Fri, 26 Jun 2026 13:52:35 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA208805D7
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 13:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDtg1zslJUhhZqzTn4e2MrvFS01HAZA3eSIxE7IqjIGT25dBPmd4wTLcjNdLZ/zkmXbyufb782TG5LD7srljrLJ2tgHx5zhoA/EdzxW8aWRfpqQO9ARbCsMZqFVZwkxCeiDVUuBuqm9XuVmF27dsOc743gxmoCwDfVXh50VCmXSBYJYXsuIzykQsRrGRWkfZZVAJWn/1gn5/DCVeRVCumugJRQ6/MeM8uawVQFS0/kMEshwBPNfdPjTj1q0LFzDYi9SkA58W6HOfwWJKU2EOVqNDgzWqTvnZDVMk+E+5dpcG7IJIs02NgRcaKuMruQ7GIIb04ROtMvlzyFmTVZJxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Znk2n4t4HCYkiEs3vFsnZaG6r7dCRPSYuf4UH2GAQCA=;
 b=cWToEaiwq0zgO+2kaOMzfyXFhptXuQzYg59Xt1PE7fSIWNNEBzbRbi7qTElG3XqeX+agj3vm6AtzPlJqRdSrNLBTEKb6LaTfRTJAaTvmdftfY2PYpbAJQwxnd185XGsAHFIMUbzMMliz6Fs6O5M6laPEIKZdlRabD7RAL0yjVtnfzovb2d8azcDhBjDt0nu+ijJaSNghY1Bv5llAVtgbA9ihT31sPjrPLDu4o5QOzLKZkeAmmx34BvEStBIj8YPp+llaW5G21YJ2P0HhhVx0f6sreiNffewPC0zR9JPpgIZexOpKlIzHMdFo7vbOTs7A9KLDtwzEzfUJ3Agktg5vWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Znk2n4t4HCYkiEs3vFsnZaG6r7dCRPSYuf4UH2GAQCA=;
 b=komzkKLBF4PXuU3yRbC6BLPoKVH2NaDH2dCKPDtlvWxZYaIPFGfhPPAeS8ATju+TxrMY5sAmzVodqQJPJdcOL2eVf5Z64EBclKQKzRL6NVyJCGckpDPCtu2nSV8flPmC6x2EchbyscB9wQoHJxs0JDuJq+P+VxWNllNtlUZzhYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM0PR04MB6788.eurprd04.prod.outlook.com (2603:10a6:208:18e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 11:52:31 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 11:52:31 +0000
Message-ID: <d1471aa7-dc32-45f6-93d0-e55fb278945b@cherry.de>
Date: Fri, 26 Jun 2026 13:52:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: boot_mode: fix download key detection
To: Tianling Shen <cnsztl@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20260610030154.173455-1-cnsztl@gmail.com>
 <d3e58ad8-24b5-4de9-a01b-adfd4825fe75@kwiboo.se>
 <9da8802a-55ff-4797-b748-6963b8cc36a3@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <9da8802a-55ff-4797-b748-6963b8cc36a3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0008.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::15) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM0PR04MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 428b4d98-41a3-453f-e9e5-08ded379676a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: n9W4RzJFIOVImBtiOA1Oz7909TdSrcfRLmhvdBiLCCfPa5VVeLh9jITGkg1ig2uAa95wVtB9L4C3QrHV1lBWs4Tn1JwfXdJskI6tvyeMo/c7yciIbwjfj4sr+aVuI1jKW2KyEdPzcEYuCUfgnTQ6T0TC8sDbtkWMJHL6vFG/Vugsck/d7B/gahrOrczf9uQUkWGWDYiKZ8Iq4t34GTrUprD9E1X9r6oMnWvmiOZ7hE/iDULllUj35zevv6ZbnUz+X74k/n4vi6/lSlxj62B81xicyUw4M4Ww+1WFbgZ9iiW/gPudQzFPmjjB5HdHmuwYtq0YTHrqtgW03vOSjy50MhSg2fzkJNjuA04uO6YSa/rgWoCxOJ+ummmetPbflfVE33wWzOx+oRrc/EkOHM+uolIInmn0WwPekALhDZnd+rqaukuXdmiy3QlGE0RBvc80hHBy+aaLTdErVs3ByxUdEWBRActbJ0ryCjEwtfE6RY2Yduegg0i+hZWyvW95ZwGHDQldRkv3yKnz4v4t5fGT5NytAiLzO+tGGoUwTwp8F6UnYwKKQFeQAt39rzOIficxY2hgB/dxFLS6KTnc9JnyWcf38gK5ougNmHD1teivyvyR6cOZkqpy08REbEqCejJIRo9i4/XjZN1guQ+fdShHkFWIMSYyeV2/gJ9v3Gg5Fjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFlSVXRuUnkrankva09VaFlGRVpXcllLVXYrME5mb1ZVZG0zMGtGNTlSQkxX?=
 =?utf-8?B?U0NjR3JqUThYRnB1NEZKb2hwTTMzMjlDMUN0aHBhQjVCbW9jYkg4TEhuZ3hi?=
 =?utf-8?B?d0hpVXQ1SFZXemVBYjBUUHcxU015eDVBdFJLNWl1Zk84elFrWmJHa3lRa0tQ?=
 =?utf-8?B?R0xuVDBEZGRxSUdsRHZyUGJtSUFVbFc0UGM2bk1xTGdHOUNYdTA3Y05QL296?=
 =?utf-8?B?VE5pN29Vd0xFMDZ3SHZFeDQyemZldU4rZVJRRmh6T0k1eVNMczE1Qk9ENDNP?=
 =?utf-8?B?WG1NbnQ0NjNIcktiV05rV0c1ZFh2eER1Nmk2NmRuWDQrOXFrM21nNFVQcDJs?=
 =?utf-8?B?UE1lREMxMVZaZlRMU3M1UWNtQUFxZ21GZ1F4MjZaUXZLNmV1N3BoWTRQR09v?=
 =?utf-8?B?Nm94WFQySXphRy9wRkRzWFVqN2pLSFRwb2llWWVFazJCbDRLV1hSd0pCL0xI?=
 =?utf-8?B?QlNuc1BNbzR0cHE5NTRVOGZ3OHJ3R0E3MENLc2RmS3VvQVVPdWhFSmdTaU03?=
 =?utf-8?B?cG9RVndka2xDcVBPMnAza2JJUnd3SlNCdFJTTmFnaTYzanVlYTZlVWlnR0E1?=
 =?utf-8?B?Uk9VUnhua1hqZlJDNUFlVFdvTnZUMlVIYnhDR25uTDMyS0c3dEtHbUJNMWN3?=
 =?utf-8?B?M3o1YmFvZ21hOWFqSFhJSlhIeFhpOHJzMTQzUzB3UjI0enNpczYwNVNrU0xq?=
 =?utf-8?B?OFFNYlVQMDhoTFk2Vms3SFZlT2lydUZPK2tGaFhjT0dwZE1aV0Zob2pFdGpk?=
 =?utf-8?B?UVRQZ1ZNWCttejNRRGk3RDJGSjhIZkVBbUtmRHZvUy9lNnMwOGVLQk95VWh2?=
 =?utf-8?B?aHFLdjlFK0VRL3M1UXkzbE1YaTlSZXhJeFRHUEFTT1hyRnBSNlo2TjMrRDRF?=
 =?utf-8?B?QTdQbFdkWU85Y1NTQ0gzeHhJZHh5S3ZXWUE1Y2VSSEZuM2RqbDROa0JIOUg5?=
 =?utf-8?B?Y0dLcWZGV3ZjVTlTMTNuTzMxS29nTE1lVzYreWp0OWN6NUZwVUZDd1NXQWsr?=
 =?utf-8?B?cUVhNVBCOWRQVWhjWEcwdDlGQjlUUm5sdjhneGNvOXVrVVp0M1dIZURhcGlO?=
 =?utf-8?B?eUpQT3lwTTZrRkZJcDQ2a05UbHFNQ1g2MktCdTRCQlN5cVhNQ0ptTDhtVktv?=
 =?utf-8?B?WVlwYUovNDlCUHRhT3dPRGpiTEI5M0NyNGFPV2xXSkpzTkFwcUxFRUdHcW5Y?=
 =?utf-8?B?cmRjLzNZSGtjRmlBZGpHUEliMllwdFR5bExmTjNyMWVQZDNIeUNSOTNQNXEx?=
 =?utf-8?B?cTc5Z25KaVRkc1c5OWxBUEVMODRhNmVDYjUxZUhDc01WVnhyNGt3dkJ4Y3Az?=
 =?utf-8?B?SmRNemNhZC9QY2dvb0NMZG80bEY3S0UwSnAreW1UaktSbWp5bUlqU2Q4bW4r?=
 =?utf-8?B?ZmdtZ1JYSzJRVDRGRGNPdTRDcUp1dFFiU1JkSHNuNFk0QUh0c2xUWmcvRmNy?=
 =?utf-8?B?TnplSmhmUzNoQktyTUxScUZFZjAxWThLNkFnazZCd1JFaXZHbE9OZ0xWeXA5?=
 =?utf-8?B?WHZYWFVSWTlBY2NOUjdwTHFsdmRyMVByM1p3L2VnOURyRjgvWEM5ekloWFZ6?=
 =?utf-8?B?cDluK1lTWHRFN1BZMDRqR1huaHhIanI4bWFNSUdYb2RDbTVyZlVvYnFrT2lp?=
 =?utf-8?B?dzNHdEg5aGZxMDhlc2UwYU8xQWJvR1JaK0I5QkI1bXR3STZkeFVRZjBwRmFS?=
 =?utf-8?B?VXNaQ2xlMnRyalBic21ES2ExNFl4eEZHOFIxM051RzVOT2IxWDFmQWRZc0Yz?=
 =?utf-8?B?ZTY2RDczc040clplbWRlNms3YzM1OFlUTmJTUW5keDI0QSt0RndhcERkRU81?=
 =?utf-8?B?ZzcxRVJpeGlHalFZbzRNYi8yTGZkdUJRN081cWJzdG1jRmVEL3JhbjVITmJY?=
 =?utf-8?B?SE1nbkhUL2orM0tkMVUyRXFqeVVpaGFNQVlManRpZnFrYTJhN0FpMGJUM2RE?=
 =?utf-8?B?ZEljZlVybmFWeDVHOTNPLzBNeHA0Uk5RdWJ0bnJyZUVER3hRRFBsUmZCVVp0?=
 =?utf-8?B?V2c0OXZTclZ0OEZsc3k5YlgxSGNGNmpwVTJlckRWSEVZeFV4SCtxc1o2aFYx?=
 =?utf-8?B?SWxpemZHNFFGcTFxbmQ5SytTMkcwcElHR09BSndaMktnZXM4dTUxMWRyZ2Vj?=
 =?utf-8?B?M0JvTXF6KzVHQzNTWVFBaXErVlRCSzJLWHZGVG9zem9ZSG1lcjgreW9iejk2?=
 =?utf-8?B?eWFNbmtYKzkycTZCQWF6UEJCTGFoaUJFa1RRYytSbHZFRWsrZzRGazRQUkNI?=
 =?utf-8?B?aHlYa3lEQWVSZENkZzVzWk5lNGdxSkRQSkN2R2ttSG9DVlZBTVhSU1hVTVRU?=
 =?utf-8?B?VGVyR2RlNGJkajZZeC9zZU9ZV1JpRE8xUmRjWEZBdnJZN0E4KzB3UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 428b4d98-41a3-453f-e9e5-08ded379676a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:52:31.3759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSy6wPPzdu8+ey0BxEJ+YRoTdDHpRJS4AhSq5lg+mSZf0SbpeTTdeqSY4FuOCXJOhVd0L4vMWReO/CQy9Vln2gDlbhn8gBTdNafGnOGNQdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6788
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

Hi Tianling, Jonas,

On 6/11/26 9:45 AM, Tianling Shen wrote:
> Hi Jonas,
> 
> On 2026/6/10 21:25, Jonas Karlman wrote:
>> Hi Tianling,
>>
>> On 6/10/2026 5:01 AM, Tianling Shen wrote:
>>> rockchip_dnl_key_pressed() looks for the ADC device by checking
>>> whether the device name starts with "saradc".
>>>
>>> On RK3328, RK3576, RK3588 etc., the SARADC node is named "adc@...",
>>> so the device name no longer has the "saradc" prefix. As a result,
>>> U-Boot fails to find the SARADC device and does not sample the
>>> download key state.
>>>
>>> Do not rely on the DT node name. Match the bound Rockchip SARADC
>>> driver instead, which works for both "saradc@..." and "adc@..."
>>> node names.
>>>
>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>>> ---
>>>   arch/arm/mach-rockchip/boot_mode.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-rockchip/boot_mode.c b/arch/arm/mach- 
>>> rockchip/boot_mode.c
>>> index 55e9456668ae..363fad523cbd 100644
>>> --- a/arch/arm/mach-rockchip/boot_mode.c
>>> +++ b/arch/arm/mach-rockchip/boot_mode.c
>>> @@ -51,7 +51,7 @@ __weak int rockchip_dnl_key_pressed(void)
>>>       ret = -ENODEV;
>>>       uclass_foreach_dev(dev, uc) {
>>> -        if (!strncmp(dev->name, "saradc", 6)) {
>>> +        if (!strcmp(dev->driver->name, "rockchip_saradc")) {
>>
>> The adc channel used below may not fit all boards/SoCs, so this change
>> may have unintended consequences.
>>
>> I have previously avoided "fixing"/enable this code path for RK35xx
>> because the download key selection should really be improved when this
>> is fixed/expanded to more boards/SoCs.
>>
>> E.g. maybe add support to declare a recovery button in u-boot,config
>> node and use UCLASS_BUTTON to check if such button was pressed or
>> something similar?
> 
> Yes this is much better than evaluating raw ADC values, but BUTTON is 
> not available in SPL so we cannot have this functionality in SPL (though 
> this idea was already rejected :P).
> 

I'm sorry my memory is failing me, do you have a link maybe to that 
discussion?

> I have made an initial version that use UCLASS_BUTTON:
> 
> ```
> __weak int rockchip_dnl_key_pressed(void)
> {
> #if CONFIG_IS_ENABLED(BUTTON)
>      const char *path;
>      struct udevice *button;
>      ofnode node;
>      int ret;
> 
>      path = ofnode_options_read_str("recovery-key");
>      if (!path)
>          path = ofnode_conf_read_str("u-boot,recovery-key");
>      if (!path)
>          return false;
> 
>      if (path[0] == '/')
>          node = ofnode_path(path);
>      else
>          node = ofnode_get_aliases_node(path);
> 
>      if (!ofnode_valid(node)) {
>          pr_err("%s: invalid recovery key '%s'\n", __func__, path);
>          return false;
>      }
> 
>      ret = uclass_get_device_by_ofnode(UCLASS_BUTTON, node, &button);
>      if (ret) {
>          pr_err("%s: recovery key is not a button: %d\n", __func__, ret);
>          return false;
>      }
> 
>      ret = button_get_state(button);
>      if (ret < 0) {
>          pr_err("%s: failed to read recovery key: %d\n", __func__, ret);
>          return false;
>      }
> 
>      return ret == BUTTON_ON;
> #else
>      return false;
> #endif
> }
> ```
> 
> ... so it can be configured in u-boot.dtsi like this:
> ```
> / {
>      options {
>          u-boot {
>              recovery-key = "/keys-1/button-recovery";

This should absolutely be a phandle and not a path.

>          };
>      };
> };
> ```
> 
> I have tested this on my DshanPi A1 board and it seems to work okay.
> 
> Is this an acceptable way to configure recovery key? I'm also wondering 

It could be. Typically, when a new property makes it to the device tree, 
it must be documented in the binding. Here it would be part of a 
u-boot,config node, but I couldn't find a binding in U-Boot, Linux 
kernel or the Device Tree spec, so I don't know what we're supposed to 
do here. The button itself will need to be part of the Linux kernel 
upstream DTS, the difficult part will be which event code it needs to 
return and will be board-specific.

> if it's necessary to keep compatibility with old adc_channel_single_shot 
> implementation.
> 

Not necessarily, but we absolutely need all boards using this old 
mechanism to be supported by the new mechanism, which may be difficult 
since we don't necessarily have access to their schematics.

I think we can maybe compromise for now on a Kconfig symbol for the 
channel to use? What do you think? We would still need to check the 
schematics of all boards that exercise this path and check if fixing the 
condition won't cause side effects (because it now is reading the ADC 
channel while it wasn't before due to the typo). The other option is to 
explicitly disable it for all devices that could never meet the 
condition with the typo (so even at SoC level since SARADC is an 
SoC-specific IP) such that it can only be enabled if someone tests it on 
their board.

Cheers,
Quentin
