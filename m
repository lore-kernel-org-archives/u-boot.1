Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF0CCD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 07:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E296B84995;
	Thu, 18 Jun 2026 09:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="d+VDCqlT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8633084874; Thu, 18 Jun 2026 09:56:43 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F2FC8460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 09:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qA+XMoZvPFpaouqIfHCrdnn6A8An4CoocNf2FWNeg3opnLBh4QTjR0Flmo9eFzOt3ncMvjpgOUl3I613cF5rc6PztR6DtKwnShv/LlmZkpFYnThmTuO2VoRFT2X/h+/L1BIiOED7pctB9lnJKN26MBBP5CU2Uc/CummOwkWrSl9xoc4klNIWS50tNm5vyMVaeL7syNyHC9VqLr/vGiv0exRZ4iYZOUo+pB61xiuwjbmn8FHU+bpzjbDs4+d2X5aJe047+JTF0VKScZYEAviHBAgnTAzhQa2qBvHg+hpYyo4CWq8UNkabStEHeil6+u4iGqrY/p5tsdJiPV2YLbv6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFMA1+B4dt5OOk+zOxolVq0z+6hwpIDxRKCxB0sHTQc=;
 b=PHM4dkDb14cThYu9k1Ih2w0EDNlvcllVNpYdYGeS+D4BCF+V+h4U6AvnOOORJvdC3GhWvy84IrMTaBAMyF4uBlaQ7g4LG1cNx1gEeEP55eNQq3brJoWeTLT7+Pl3JQ8BgaaPF54UljieeTKWEf6VokWKgZaokYUJyc3karoaBMtOJzO+Fm8wPuDFkTgdszJwxGkN5Ove7S+v5xruHpwwEnessEG2VPI5zL0PQUyhy6E+nIKnaLdomKhL7jfmexbi3bSYNhmXSahatFDTrKd1Q7KOmf5YmgotA2zUVc+9QUgcdSEgfgzrCJUjY28U1xck0nCqDLP3NXIQkVhBlXCiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFMA1+B4dt5OOk+zOxolVq0z+6hwpIDxRKCxB0sHTQc=;
 b=d+VDCqlTwIgChHbsL69m2R5heYj/xmZCDx0XZa7XOGRdL7cU7VbqciXv951Eus9dVArYyPL1wj9avaM0shbmgIBM4vWPzAW7GB802nTd9+ZZukb+SBHwZGd1wzMyZ1DSiGFXOG7ff7NVCS0dWnZtwLW4j25brGxPMhW1UmNuPnbaE2BHDGK2W7hT+8rQ566Ce5L4R99wq4fFO6i3QuQpiE83lrNAjD1KKZZ15DmUm4/0WMotKlmPIbdNDxsvqtSeNDO2UGjkyJwnGgNO2BYf1frOIfI/qIAifNSXx8rDWxv+lzTk4f+ABI2PVcVP48B0eKIFvJAMO8NtkpFRbVCwEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by AMBPR10MB9274.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6a9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:56:39 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 07:56:39 +0000
Message-ID: <65408efa-f6be-499c-9526-e78a9025cda5@siemens.com>
Date: Thu, 18 Jun 2026 09:56:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] qemu-arm64: merge built-in DT
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
References: <20260608130924.112831-1-ludwig.nussel@siemens.com>
 <20260608150852.v6.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
 <20260617170720.GA1942927@bill-the-cat>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <20260617170720.GA1942927@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::19) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|AMBPR10MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: a5cda4ce-9423-47cc-ad61-08decd0f20e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: kF7JhFz3I0mkk4+Dk89X/oTpmoeIQVbx0B+KHUPflBzAjhe6rVlynkJfqjU99XVsUWtWUXP2RMidhAa6D0Rq5oKSWPIoZY+DpByCs7jmpJ0zG4ZllazptejJIRUH/rjllxRfkKFxeglEw99NJ22/4tL+mwHt2r7jOf7w/sAHRe/XSM/oX7JX0JAWO9sbC62fXtEuTkOvhyXKRrILeVP4JlhkfLR3XAD71/f7181v3bTAew6uLrsMHLU6tE8b4QSy3fqE0o6iy7cciFar9iRriIoE0Rq2g42xgFqS9gmGvdReIcBWz9dOPMVb3z6tT2RmEhmWgrdRYnrF+6OCJtS2RSRf/XWBT9k7H6dtMNzFMl0s4U83WTPrsQLG55Scf9VYX7tfJA+/zFUIPjjWLGAfiCH9pgJIeRdq4q9OGuptisxVdl5a2ILmEnyriOj/2/fbgR1FmfLaGrSB8XDTZ5iM1xk2Ds9pJJQZS1eX/bfBoHZuClmSC9VD30o5MCumtWSUH8h088j9oJq5O6Ii5G8EWMIRMHQecF46bXiRXyZ+CvuxpH6z+WOzny4tqhk++K1iiIn0+Ozs7oMALKASyTp+/p4srDGGMv+bZDv0NAKw9ry6z4+67rCdnaswwFi5ojNKvGQjnKuardBPUPzUUGWNXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjJFS0VLTFVHOXc2QXpVeGlUNnlobzBEckhrZDNoTEQ5K3FiUkFBbzNyNEZR?=
 =?utf-8?B?QnllUEM5enlKZHlZZDFKTXlLelFrTGZ2NzFlRTdhRlpHN09mT3BiMWxWSU9Y?=
 =?utf-8?B?bEppYTN2bnQ0enpDZnRWbTVhdGNjK1J6RlY5ejIraDhQNGtHdE0vMEFlM1Jh?=
 =?utf-8?B?VjdScHhlbFB6Y2ttc2RGcXZQZFVoZTNlYVdxZVd0ODZiVDMrZUtsK0EwNzZN?=
 =?utf-8?B?MVZGYmYxazZxakJrajBCTGFOVkpTWTZKbENuVXRHUHk1bFBKUjFIaTBaTkRO?=
 =?utf-8?B?VGJxbUxCcldHelNSMnE0YzdUY29ZM3NJK29hZTRzTUZkQkpoZkd5YXFSdm5U?=
 =?utf-8?B?RmFVditvWWZIWC9SbC91ckkwRG11cUQzbnBqQXYrY0hFc2Y5S1ZRbVorbVdw?=
 =?utf-8?B?V2NCTVBhWWtEOVU4ZWF6L21kVkpyZTZVOCtxaEFON01rbjg3dkdDOW5EaFgw?=
 =?utf-8?B?RjB3b2FVRWR0RTMySkw4S2Jqc1NIL3RQVjQvamdYOEMwS2lsb25ORXduUFBv?=
 =?utf-8?B?SFlKWXpKUmJ4WkVYRzFmN3B5SW9kK3VQRW1pWHFuczJjaEF5RlFOYUQzK1Fi?=
 =?utf-8?B?a3g2M0FFWG5NZTJsVjFVbjRQa0NYekwvbk5sUmR1THNaVEM0eitsa2xHeXJi?=
 =?utf-8?B?TWZod0F1bXR0TEhZQXo4ZGg3dU4xQTlXeHdkRlFZT3NCTW90RFVQeVV3cWJr?=
 =?utf-8?B?b0grWW1QejZZTk94UWs0eUovd0hLU3l5Zmx4WTc3VVhrdng2RStGd2lNUkgy?=
 =?utf-8?B?TzRuL0dHME0zdTA3YTVucFpnYzZTYVpXV1NyMEVDYkFIZ3R2S1BnR2FiRHY0?=
 =?utf-8?B?TUYvQVdYb0x3NjFrbW9CcmlWbzZoanVMTFBQK1B0UUUwQnNMUWU0M1ZVU3Fu?=
 =?utf-8?B?dStaMmxzZFdvdUZMclgwbFVWaERNRDJPVmliVU9YT0xUVFE5NUVUalRBTTY4?=
 =?utf-8?B?N1plRGRMSGJVUGZMbXhjNFZhbWdBZ1gxRXpxbkF3OU5Ud1RWZ0EzbWVJWEc3?=
 =?utf-8?B?c2lRM01mdTJmUkE5R2JsVngwVU80dUF5ZWV0aGhPdjY5UnJ6Sm83T1Yxak1w?=
 =?utf-8?B?MUxkRkl0UkFGUXlHYUdUK2RNUmlQYzcveUU4OHNYVFhjUitTa3h5ekV4bWp5?=
 =?utf-8?B?K1JQbTVQQzhSUFhzZDJMWjhFNk9SVDMzNDBGU09sWXV5SlM3eTR3cFl4TGht?=
 =?utf-8?B?L2M3TW1XYUxTTTZJVllCdU14ems5b0NnSGEvSWJKSUE5Qk1jTWljMk5OQzVF?=
 =?utf-8?B?QUptYVpPRjYwb2IyVmtIMkx6aHRLQzdIRUs2YzZNZVc2Q3ZsMDhSNWxUaDBy?=
 =?utf-8?B?bElSRDhoTXpwbnoxUUoyNHZhRHJzRlpXT3R4N2xDZytyUVIvMVdESzVYblNa?=
 =?utf-8?B?d1BETk9ueDdGQlVQSFNTWW9oY0o5VTh3emJUbUR0Mk05SlN3NnVBTFVXRlJ4?=
 =?utf-8?B?a2d5QVVZWmYrdWpYUkFPa0tjekhUY2UrN3lkU3lFeURvN2ozOGdUYXJpbGJw?=
 =?utf-8?B?UmhCSDZuNDdNc25Ma1BVZjE3b0ZheDc3ejg2Mlhia2F0ZHpJZHMyQ2RhdzF4?=
 =?utf-8?B?SGxwa3dld294R1FpQTZhZ1JOYS9zN081UFo5SmRUUXNWY1NhcGpqRXZ0cnli?=
 =?utf-8?B?QU5kMW1qMTBvUWd5MVRXT3RUQ1ZBbmhUSE1RVWduemdabXZwVkZlZ1djaWdp?=
 =?utf-8?B?N2M3dHFWL1FHM2diS3pPVmVKL3k4a1BDM3BDWjVSUFRaY2lUelgwL1l6WkZU?=
 =?utf-8?B?MTlFYm1VUHpmbmFJYVFCTDk5MmtlSFoxZndoVWxuNlZMVmM5UWcyZXMrdy95?=
 =?utf-8?B?SGswRVo2ellCVVFRT0MyUHNCRWgzYUlhTnZzSnQwamdmdkhzT1pZL2I5VXpV?=
 =?utf-8?B?MTEvWTNyeE1hSHZoaXRPRUVhUHI1S3M0U2d5WFQxa1k3WHhJcnl0WW03ZzZm?=
 =?utf-8?B?amIyWTZWWWdRQnJDaUFyMWdrOEc2RzBsTWpKUUVqNHRCdTZ4clZ4TFQyUWND?=
 =?utf-8?B?Vy8wS1FsNUplVEtCMlVwenN2d1VRVjlQYVgyTXJsbkJMYWk4WEUrcjdSZjda?=
 =?utf-8?B?U3dJTGJZOU1XRXNLV1VhOTZ5UU82WHRGdjAzbzBXTGRsVDFaclFmZUZReklB?=
 =?utf-8?B?VHZqWk1keDhNTWhTMHY0S1ZxYzBwMllLemxpNnRINXpLRmVIVGVhZnVFUUxs?=
 =?utf-8?B?a2JXSGlGOUpuR29xY0NHSW5vWkZDTlRmUnJWSElwcFQ5V3RnRTdWR0N3alAw?=
 =?utf-8?B?YW43RnlVNXRuYXFodTNvbU5FSDVhMjZ3blZBdDZ2b0pZMVErQ3R0djJqWnE2?=
 =?utf-8?B?enJQMnJUeHJxTGI4MnVKNWh0YjZZL0p0dy9zS3UxQ0x0ZXlpSnh0OWZJQUZh?=
 =?utf-8?Q?yS+A4N0WqAQzxPW8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cda4ce-9423-47cc-ad61-08decd0f20e9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:56:39.6626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcIFP0FNZRWXH9WrCn6AaVVqwXvXarXuVqtBR4hOM8+dm1ARehPvLrLCH6IJCTDVeVPMUBzt+s/3HYU/QoovpgKB4ceIZ0XL3Q9x/LQGBmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9274
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

On 6/17/26 19:07, Tom Rini wrote:
> On Mon, Jun 08, 2026 at 03:08:47PM +0200, Ludwig Nussel wrote:
> 
>> The keys trusted for FIT signature verification are supposed to be
>> embedded in the device tree built into u-boot. When running in Qemu it's
>> convenient to use the device tree provided by the VM which doesn't know
>> about signatures though. So merge both device trees at startup.
>>
>> Make sure CONFIG_OF_OMIT_DTB is not set in qemu_arm64_defconfig to take
>> advantage of the feature by default.
>>
>> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> This leads to failure to build on qemu_arm and qemu_arm64 in CI. Please
> see https://docs.u-boot-project.org/en/latest/develop/ci_testing.html
> and resubmit, thanks.

What is the failure you are seeing?

I've just pushed the series to github and the CI there fails in yet 
another test that actually works when I run it locally:
https://github.com/u-boot/u-boot/pull/990

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
