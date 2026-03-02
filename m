Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7FDE9B37D
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BBCD83F2A;
	Mon,  2 Mar 2026 14:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="f5ReKnbR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21CF783F30; Mon,  2 Mar 2026 14:07:56 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0267E83F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 14:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHiaK9QftRc8X8MgxKWsxU8BxH6HMP79fP6NFEH12Am8QIGxuwx+fLJQTH7cJ9cRqUcfvXikuO21hqPIlEsNqfLIHw3r9fCajc59SUeJDI5fpgcBrFDCvKRNp00cyn7Dxk1D2BAbtbM5tctXTF5gPoXhz4y90KsBcPR9FPNlS5OW+lQMiKk5OzHifWJU/oD2NbBUP4PlexpSZMzYe9r+hUXNLzZgSgTvG3meGed7LFHjXVRGxG9Ym9G0Djhw4wcLT81xo4nLpFuBNj3iYrhlegpFw3uWD9rC9hI60MNButZh8Lk2T2uXkUeBmMg/1BDBfOz1aVCC+x7585bFOGwWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvGVnmSiqUniN4QNtT8bkrYmay5zQUXInV/OmSWrd7Q=;
 b=rYuhYlkgkdZSEMB+JdbJebvrhJPXSShv0NOpJbxxcFAU5X3w0v4zkYt7MTzhNRIXbky+cETki1SksEruR1PTkB2ti8U2dbUMT6Rgwc3OpO25Web2d5wax9KNU4tfoFyFTbVTqzken0eWYtLn4+RAhCo3c+jaLdXB5g7VfiJwL+6OdpZW36gbWdJK5uincsG9GeAmC+JZexs3Sz8Um1x8qlsxm5VZTIoZ94p619uqup+j9MPlwgtc94zOFKOYonlEoSAelgL+w6LKzorUZiti4OdwLPbaECk1DQCroCDNpmZxdUip1DRF/GlJbPlLKiKgSHi9RpexPp6T59KyiTsv4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvGVnmSiqUniN4QNtT8bkrYmay5zQUXInV/OmSWrd7Q=;
 b=f5ReKnbRr7FeRpBKBrB1+eXkxxqkaRlea7TNou6L+DGt386lrMd/Ec2moclTzlnlfg1HhvjueoBxyRJx2ycgGZRfEfYFtM8Ulpg4buG3M3LrUjAsGimtYmwgLDUdtZb29ikQb77AEMSQuyXqn8WeU0LPuXuyX9m/PfJZstAoLuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB8818.eurprd04.prod.outlook.com (2603:10a6:20b:42d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 13:07:51 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 13:07:51 +0000
Message-ID: <d194a890-6921-472b-935f-8b2d01c1289c@cherry.de>
Date: Mon, 2 Mar 2026 14:07:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] led: led_pwm: fix active-low behavior
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 Ivan Vozvakhov <i.vozvakhov@vk.team>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
References: <20260209180718.32451-1-clamor95@gmail.com>
 <20260209180718.32451-2-clamor95@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260209180718.32451-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0060.eurprd04.prod.outlook.com
 (2603:10a6:802:2::31) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: 0337ee6f-2857-4f1c-2168-08de785cb5b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: g1QFJRcjt/I9/By7m8/oTz8HJkRwkS/KANLogWWqLo1SnvWBWHxEyLJswfKg7+Bd+YhuouBbKa9onx5WfXir3keymwxKtPlnTpMpbIMwQe2+ziyJGd50dihFK7ndy9jEQDJth8tv0MdZYcA06yx0vB1WDJcTM++nLB2ehEZrqq+Az7RhVHJ6PEhnhhxkDny5xwaWFRPkKWFLANeQIp78fGLa3zUkvZJPfwOyZMkoahwY7UegdfjCafUf62cjh+KO8X0KwLajOL+HNvppBufEnvUuoPIt6Yxr6LYKXp1+9MrmoCATvwj8FE5ABqjS8Nu7nuFbcRhieWGDhWuWC1Xw6vn1U9415N0Rc7tL7u24x3bB3KdmSUvyxuLGflpftaQpEo3yApByqUv7Aer4pJWHjBHY1Fa7kXvu5vXXUUBTAE/ZNHwREkX+CrQv5HH7Kj6enQcjn5nBpJC5syyOeiSWbxZinoaRlHx9NkBzk3KSXPDKfXCqR659pOj+a5TEDo7GFPUgu4ciRYDyxz+Wqz0GqyyNSi98DCj7dj8S8E/8SwB+GYycmgOt6YIt3t57AE5ig0jEt3L0ETXHYp1eqLjp0wushM+SI6ZNHGk2UVYCEc4nU0jdvKY9z7NDYfjQ0Id/oCHgK2IRRJcPcRkvbtMjB4wOJl3vP2ljUCuOpSx+8GJdXtd+C8YJYzcdbc/W7wQVIZ/ZpKgW89y9s6zzTrjpkJDKGEH0UYdX2mz/qNaozp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXZWQVgrMVJtc0J3U3BwejNTMUluQ2dQRU9BcklnbEFyQ1hTZlh1UC96ZnJx?=
 =?utf-8?B?MDluVGpoZlFWZUhFRXpTQmJySFR6Y0Z4UCtNRnFTRnBMSmJPN202SXlKZDN3?=
 =?utf-8?B?R0pFcW4rcWJvSXdaK3FWUEpWRW9OVjVJekVWSGpJYlQvdG03cHNXbFV0d0pl?=
 =?utf-8?B?ZmFZSTBxSGE1MVoxYlZvMklFS09tdGpyOVVmdVVWOUNRMXpzcGZiVjlKa3N4?=
 =?utf-8?B?ZE9Nc3lSVkxaK09iMTRFeWROVTY0M1Y5Q1RBSmJmaURaMDVsZnZvUTFxcUxa?=
 =?utf-8?B?RGs1TXRFRkZnYmJsTXdaRVNuZmw0OHNlN005TUJNZzBsaFVzT1BYM2hqRHVL?=
 =?utf-8?B?NTVmYzVsNmdYTmhMVS9UajkzRXVnellNaEp6aHM4QWFoVW1Xb3lUelFHWWEw?=
 =?utf-8?B?aTBFVEhLcU9OMTh1N05POEEzaE1FeThFMEhKUTI1alAycHcyUElsSWo4YWRZ?=
 =?utf-8?B?RnR1Vm9TZHQva2RkTitBd01ZS2V1bEJ1RUNXRUsyeVZ0WHVWMnhvby9KeUtR?=
 =?utf-8?B?NGZyc09pZ2R0UjkveEZMUHdlbVd5VFRsWXI1YUNaZS9hSVFOQlZlUEtOQUFt?=
 =?utf-8?B?ZmlDdXF0Wm1yaEQyZ0xSUnpFbGVsWVUyY3VBZlNFaXhocXdVcTlGLytnV09F?=
 =?utf-8?B?QjY1RlJ1SkZvNnFqYjdmdkI3c08xQ3Q3WnZYTUJiNC8vbVBMckJpUWR3R0hv?=
 =?utf-8?B?OS83VDRPRVJURFltbDZhNndmTUxSZXdsM01iSUVUV0xBTmJXcVNSNjQ2b1Ar?=
 =?utf-8?B?RHp3bnhnczNhS3l6RGx1UDhuUHYvajRhTGlBSnZtRVcvbW5aQndhNjRZRDhP?=
 =?utf-8?B?QlNab2FmM2pkYktGRVE3TjMzelRMTDVpTHY4MTh2eHdpRXhhalYxOFpBQ013?=
 =?utf-8?B?NGV6aVhibGM3MXpteFVVaEE5NW01SUFIRVh1cWh4VTlTb29RSnk5Q0cwWVRs?=
 =?utf-8?B?ZTRvNjVmcWVwS2NnbmN6NkxTL2dSQ3hBUW9zZnFVdjlDdlZaU0FEN2h2Q21j?=
 =?utf-8?B?eUY0MU9CNjdrM04zS0lTMDk2dVpQcGwvc1pjTlFzNFVHQ0xqNUxHU1Jqc0JQ?=
 =?utf-8?B?eUpMc1NlbkNHcU5BdVRIclhzRWttUWI5dW02NjA4ajBDWk1XTlc4YlRxanZp?=
 =?utf-8?B?WXd3Vk9rcExGOEk3V29mT3NVWTdpNUxCSzlrSVN3TmZQNlh0SzhjRUx6N2Ex?=
 =?utf-8?B?TDFFM0FaWTFkMHFtRE05M3laUWw1bm81L2FQVXVIU2x6S3R6UUg1U1RZK1Yz?=
 =?utf-8?B?cHQxNmdsOHZ6M1lZcnNSZ1ZuL1lNQy9SRFN1dWJIQ2p0a1NZM0pNMlVjcjNJ?=
 =?utf-8?B?eHFPMjZ6VlpqUnYrRUVqOTVKTlJqcU5HaDJLQkdYVXlOY1lGaFE3SnFYdlRx?=
 =?utf-8?B?VUVPR3ROZ20zemxadGlQTFRLQTRsTXVOZEsrajN2cU1RTlRKVmF2YVA5RDhm?=
 =?utf-8?B?UVYrV0tmcVZvWTdQb25iM2xubTZCeTVVbDZrSkk0L1htSitQcjFvVERNWFZl?=
 =?utf-8?B?SUF1dWJ6K0NXejVhVDNvMVdqTjJITHNoN0EwOVNkdWlJSFlFNmk3UGtOWVVy?=
 =?utf-8?B?ZTdXVnhkRGlVYTBxSW9pT2p5VTBsUnZQREdGUVVZUnRzc3VNak5DMVZ5QzhS?=
 =?utf-8?B?NzBXa09jVU0vR2VpcFZFRjJQL0pqcXZEYU9oMG82Y0ZRMFpOWk1CU2hWOHh2?=
 =?utf-8?B?NTFiV004MFBXSUcvUmhLMFJjRCtGU29ZWmMzQndZMUN0UmtPb2pCNDFvOEVs?=
 =?utf-8?B?YWJnUnRjbDNVQ0E0eXMwV1dpcjAxUU95c2hLd1VubzI2amk3b0w4TGNremU3?=
 =?utf-8?B?QXdXa3ltZXYycTRKWG10M211V0k1TGZvdHU3bEZ4T0ZVWWU3bUorZlpYYlc5?=
 =?utf-8?B?K3g0RDF5dDQ5K2pwTVhRQjY0cDVZN1VhUzF4NXZvNmZYNnluQ3laS2k5R1p3?=
 =?utf-8?B?djZSYWJOTklpOER3aDVrMGVoaGl2NXRzUFlKYkVLbGZwWjBDQzRHOUxLa2NW?=
 =?utf-8?B?Nk95NFZ3a3JrUmtyMDBtL29BNEFsOVgwdVh1QWE5Y1RTaGw1TEZ2dzhQQ0FU?=
 =?utf-8?B?TnZBY2JhdVY5eXI3dFdNbmw2b2hjUURpZDlPMHl0L0JSWWpiUGpFRkltVkVp?=
 =?utf-8?B?aHdrOVpKUFFWZDFpOU4rMGlhRFlsY3JNWTlBY2MyU1hnR3NiR2hOKzM2K05M?=
 =?utf-8?B?NkpnNUxXc2VFbUt6OGVFM1VCS3JLVTFBZ1l3UTdUbnQ2MGU1bzFGSTlUdTBt?=
 =?utf-8?B?SDRXZlFWczNqa0xnOUJTaC8xK3grNnQ0NHBtZzlQTysxVjFaV2NhZjZ1bWxW?=
 =?utf-8?B?Ynd0RWNiVjN1ekNJWnZSM2RQeXlNRGVBMXVlUmREWHgxNUlJMWYxZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0337ee6f-2857-4f1c-2168-08de785cb5b8
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:07:51.5728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzypI6/e2ImS8KB5nUHlk5SaCkf+61oX+BTJv7NAKm8E9Lh6OtaS0JEqiqe9BLsFmZYSC2kh7QzCqdI9WK3G+7PLER5bX+DfDPqWf/rL02E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8818
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

Hi Svyatoslav, Jonas,

On 2/9/26 7:07 PM, Svyatoslav Ryhel wrote:
> From: Jonas Schwöbel <jonasschwoebel@yahoo.de>
> 
> In the case of active-low behavior the Duty Cycle needs to be set to 100%.
> The PWM driver takes care of this but the LED_PWM driver does not take
> this into account. Adjust LED_PWM to take into account polarity of PWM.
> 
> Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   drivers/led/led_pwm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/led/led_pwm.c b/drivers/led/led_pwm.c
> index 15dd836509b..7edfa286468 100644
> --- a/drivers/led/led_pwm.c
> +++ b/drivers/led/led_pwm.c
> @@ -34,7 +34,7 @@ static int led_pwm_enable(struct udevice *dev)
>   	if (ret)
>   		return ret;
>   
> -	ret = pwm_set_enable(priv->pwm, priv->channel, true);
> +	ret = pwm_set_enable(priv->pwm, priv->channel, priv->active_low);
>   	if (ret)
>   		return ret;
>   
> @@ -52,7 +52,7 @@ static int led_pwm_disable(struct udevice *dev)
>   	if (ret)
>   		return ret;
>   
> -	ret = pwm_set_enable(priv->pwm, priv->channel, false);
> +	ret = pwm_set_enable(priv->pwm, priv->channel, priv->active_low);

This feels wrong. Why would both enable and disable paths use the exact 
same value for pwm_set_enable()?

I can also see that the disable path doesn't actually call 
pwm_set_invert() unlike in the enable path. I'm assuming this means we 
cannot call disable before enable and have consistent behavior?

The kernel seems to use active_low as a way to invert the duty cycle if 
I'm understanding the code properly. In U-Boot, it seems we don't handle 
that at all and always pass the "normal" duty cycle. Maybe there's 
something we need to do there.

I'm also assuming there are setups where PWM should be enabled but with 
a duty cycle of 0?

I'm also unsure what's the difference between active-low and 
PWM_POLARITY_INVERTED (I've seen them both mentioned or mixed in the 
kernel DTSes).

I don't have experience with PWM so maybe that's a just a 
misunderstanding from my side?

Cheers,
Quentin
