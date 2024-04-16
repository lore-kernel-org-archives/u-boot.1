Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41C8C04FFF
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 13:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C471788403;
	Tue, 16 Apr 2024 15:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="RDjaVEOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D71388404; Tue, 16 Apr 2024 15:22:55 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::70d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A61308810E
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 15:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f84PtJRFDW2zsgwY8LjR0CRvGDUbbzMlfjyLYTq7g0H/cZjHhglrY0eirL5W9+F4we4+sP5g2cK7jkf7ppyRQ8Jqw+BySC1MYvtXgJlSQvXcECbCmWmWH1YvKquq4NP8buG2GV9ee+tuwSE78pp4qM8Yqut8TGA7GMdJ/pf6j9glJueE+hzJULACPGenyZqtsUczvY4OnT5L42lyR7eUuP+Kez7uM4trl9P8ksU+zdIVVbAOkF3mDskp6KzCXv4dgxHrp9js+gjhHAV0bLncSao6Y6KRe80T4J2mUJ+ASXRp354Hi5/DuFlKjjjBG5IySj1k4kcYiMzqkKuRAUwqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nj9NbJHZ4OWin+QyzLR6NT1jv5dyCsnhIAVF1Cb4EZw=;
 b=OY8Sjo6qoxYuQyovw9kYzLdkZ8kQ+7r5fAf6Cr73lroHv57GSAQLdfoAHdE+octzK/pvV/4X5AsMjaAeDDmYbfjbzuI+erFQjY3TOCEbK2vwYeE1+vr189BR9acu3h3HRBWe6k27mJJE84YzuLp4q7hsd2uYZe9UZg3pev57/FSEcrspMetPVQoDwLW2MWtif2fJkackdlmQmkQu44Ig55VbPZ/V61GPVcg4c53twbC7dOO9cdLoYFk5N5ctA5dOfn4qffK4dA9p80Shq6C6jpMMbXUxKjq5LslhQPNxiM2mpLth6vAflEgGTL+3VSyNtwfheoag/LeujdpllQ53jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nj9NbJHZ4OWin+QyzLR6NT1jv5dyCsnhIAVF1Cb4EZw=;
 b=RDjaVEOBkq64IFpm5cmrllIaX2j1QZXZnYtF+/FPs4IKf9yR0tLgX3jyBarirZvohmXm1QHtjqoXb22hXpA2xBHAwfUCHltUjGsC1QzdJwYfF6Us8vz5/dCdqkQ/FixaW8FCWJj5e56oN5nW8t0dpsaSTG9J5HHBy+g5MvSUgaEoJLGCVKnxUdyMq9tInbvZqFro/1nUscWLiDuM8oZYaF+qXzdQODbHhm1qma99PKvLkaM4HnUImB4Hj40ZwU+zP2STK27d+KvF+pAc1DYJal+O2WLAkzto6P94LDNjEY28l5+M38/0P1m3EstEUOZjdiErLW8m1zUYmUh5sn7Rkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by DU2PR04MB9115.eurprd04.prod.outlook.com (2603:10a6:10:2f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 13:22:48 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 13:22:48 +0000
Message-ID: <ee8b9906-0e32-4c89-ae3d-5dead6f4ca77@theobroma-systems.com>
Date: Tue, 16 Apr 2024 15:22:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: px30-board-tpl: Use CONFIG_TPL_BANNER_PRINT flag
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
References: <20240416124701.157545-1-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 philipp.tomsich@vrull.eu, Kever Yang <kever.yang@rock-chips.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240416124701.157545-1-lukasz.czechowski@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::21) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|DU2PR04MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d02257-5b1b-4291-8dd1-08dc5e184ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZxwd1otFdguFKFvDXH3RS56Fj/BBoBsScpeQWRn4nSpsQ/yYx2swCvKVcGhrQySB/FfGHH6ClUSPkYOwk3lzAKOP7zmvf1LNjgGXDKhQORkS4whu92EdWna4D4v+eCGJCcq7X6Nnxhf4MkdtlqeIiXUOGRX10zRmbpTBeJoJJ2Kyxz9a3deixE6aTSSpQT/pElF/noR7BsVIUZ/ANNuhmhCg7248pZbRD+yHQwtDDPH/NgM9ucqeJCE3+ZeSXZsTPu5AmCi/Vg2NEItVS3lxkJbJPyYBIUANCs8F1o65WDMk77bak3LQ7+6BKhQAAgsWeRJV/t274/RZNdqna/fSw9FG+Pwx2R8KcKgHmpQ+jy4Yw1vQmMejmPjtzDIuMdqmyyVlNku1WOYTq8V1tgIDIfRUA//z03CiTN7ZfuXcE1Y4DVTFpEMfwsYgGR5b34RWMn0yRSh6NsLqr8K6UWAwmuwkDKDYv9464wREL7vMhSkxzsdB4pN28abTcO4y1PhS52FUPFczs7c3QPyhWTGJGLuGADJSA8YNqk+IiZbPArmb++9vn6ivpk8+wJy630gnQv8ouAdKK500cBDN8IxRIFEA+zpCXL/Nqe9quSdwpBtW+jOxBz8VWbcUe3dCPzquHIll9vdGO4OqwWPGUVXq/5CRwt9yXihz4U/S33MTYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEQyQk5zVXZXUzJzNVpLT2RYalVYbHNsVG96Z1dmb0Z4UDlTTEpKY1krN2dm?=
 =?utf-8?B?eStuTk9IN2NHQkNpQ0p3eWpxV3U2Ti9QOEs4UkpIZ1RNMnZjR1dPd3c2YmRW?=
 =?utf-8?B?bVNyWU1rMFh4VWhCMnpVQk5kZDhaVHdoMWN2cTRhWUdvQmtSZzVaYmpESVhk?=
 =?utf-8?B?d29mU0RPRDZnRmM1V0hZbUFCYkpDZFlIZXY0Z0hsMkJVWWM0bWhRNHEzSjhk?=
 =?utf-8?B?cFZzQzR2Qm5aOXM1aVNTQUZPRGNKUE9QN2lqUWxYTHJyMWtvb3l5OWpqVllj?=
 =?utf-8?B?ZXE5bFhvdXB0R3phKzI0cEdtQmppNGJ1OFdEeVFBZHV4UlM3ZGdwdlBGWUVa?=
 =?utf-8?B?enpzeEZnSWJVWlZNc0NTMkVPaXhzSU9USGdvMEpqc3VTYUt2WkNSOGQzZU1C?=
 =?utf-8?B?dnV1ZW9lanBjN3o5S2NYdXJYT09vK3FSSWVxWWpaMDczRXAxYXlpNzdERVBZ?=
 =?utf-8?B?dCtMaDBmR3hDdG16Z2hCWjFWMlFwM1l2NmZJNTV0U05HT2NKVit2djJyUnBy?=
 =?utf-8?B?VnFScW1ZNFEyU0RHN09ETTRMdXhUSHdzVldYRGY0WkpYZ2x4Sk5TUkpSMUMz?=
 =?utf-8?B?K0V6dzh4c1Z0WnY1YjhqS1ZCWm5peTVYeXBSMytSeno3Q1RnNkxCNlpBYmRB?=
 =?utf-8?B?UTlFODZ5OW1sc0F4VE9WZ095eUxOVkt3aVVtQTBWeDA2RkJHam5WU1ZwL3pH?=
 =?utf-8?B?K2lDd1BCSTMzVWNZUjFaNjdlc1k0cnFRY1k2NVJSVTNjZ0psTWVudFZTb0JZ?=
 =?utf-8?B?aDhsRG4zd1ZqZ1dTMldHanl0VG5sNHhNQ0lSaFBpR3d2NTZPdXc4SCtWK3lo?=
 =?utf-8?B?WWszY2dkWGNmQ3ZZQVY2WGNwMUVQRFdDMTNBTjZibnJkeHl4QkF6TWZFWGFW?=
 =?utf-8?B?dkpralpCYnRTaTRWWjNCczFQcWtlM2ZPdzVTMWZYZkdNVVRybHNvWk9vdGE0?=
 =?utf-8?B?Tkc4dWtxbVo4ZjJQYWNuNWNpV1dlVnRKd0lsMk1mait4RzBSUnFMT2NTMzVS?=
 =?utf-8?B?Q1lnakRTYjg1Zitydm9kSzNXNmxBWXV0eUVoL0F3TFAwSXEveUY2bENwNGxa?=
 =?utf-8?B?ajVUNjlVOVlSSXVGYmxDV2x4THM1T09CMFE0R01YdU12b2xhRVMwS0g0ZXJ3?=
 =?utf-8?B?Rk1rWFBCWlhzOUdPaUNTVXBXRVVwcDZqNHhoK05UdWZFd3AvaDQ4dllKeEpw?=
 =?utf-8?B?c3MvRUgyRVRoWnd6VzdLQ1N3dmxtSldxUmdnY1VJTEt2SjFKbFFCUTJXS3cr?=
 =?utf-8?B?T0gxM3paaTRtRHlHSk5lVVIvV2FjZVNFeGlSRjR0VElMaG9jTVZ5S2pJQ1BN?=
 =?utf-8?B?NUZUM1lwVzNVMzN4ZEs4ODl6SHJCc2xUc1U2ZzBqWWN0MWhURW1VejdjRHZQ?=
 =?utf-8?B?NlY5QXJQNXpCWmdqR3cyZWlncyszU1U2RlRZSkJMeGViQjFjeFVVVGhEOXBv?=
 =?utf-8?B?YVFBaVdOSDM0bWRqR09pa0RWQVBRODRBTENoWkNCMkRvbkI3MGRvUE1DaHRC?=
 =?utf-8?B?VmF4OWRHa3V2SUtwaE5yUEF3VytMUVh6byt0b1I5Y2xIV2x1cXp0Z3ZDYXFw?=
 =?utf-8?B?UkJDdFpuZllXamMvYW5HNnd3OEpCcXdhNXV1d1Y2cGo5ZHh0NTU1Mm5TamdK?=
 =?utf-8?B?Szd3U0ZTbGloK053RkxyT2JHVDBUU0RISCtkUmxGelM4d1VTSXM4d0xGR2JD?=
 =?utf-8?B?djhYWGRqOFp6NjFIMDRWYTRwVE9nYVNiS3FOZEt5ZWgrSitSUDI0STlreG9z?=
 =?utf-8?B?Ly9qWHJPV21aT1NBQVI5ck91S3JKRVhCcmZHenhnSURnQzNPeXZweTNUMk9P?=
 =?utf-8?B?UE5DUVdKc3l2Wmg1c0w1aHRVM2JTRUFhbXc4Ly9vYUpyQ3ZzQ01HdnR2UDF0?=
 =?utf-8?B?V0JaQ0w0Z2NSQ0pDUW5oWGluaDhIdTBValYxdjhKbi9ZL24vUFN0bjZIZFFx?=
 =?utf-8?B?SHV2TExNcldOdk44UmtYd1VtUzNHUjNuaHhMSThiREZGQnF4QUtUQVhtZVFo?=
 =?utf-8?B?NVovMkJmc3BYcHRzYVp3S29EQ3h2c0d1RjZZa2NwUTliRUF3TGx0THFKN2lP?=
 =?utf-8?B?VzRrTzh4aFQ0eFlLZzMyOFBjYjR4VDRITGdJaUFaRnNjOWlUMS9OQjdlL3l5?=
 =?utf-8?B?NGluVFA1TFArMFlZMDY4TnRjSHJMNm5wcGNvSG1tSFhtWUhEbG81WWUrYXJO?=
 =?utf-8?Q?dsJt1j8AvfVniGyrpTLt5Uw=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d02257-5b1b-4291-8dd1-08dc5e184ecc
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 13:22:48.1700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxC4WzT2553H8mQW3u7MtLIfdRq2pUkbPPEzEYDjpsZndy/SdY0e/sLb7StX20fN8iZk+8hLXzvzaxir+HL9L2CjczXw1Rkpb7TL7Y+zyDIPjBT2+ZDpWZhO3+Yha2xb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9115
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

Please use scripts/get_maintainer.pl to set the Cc and To recipients of 
your mail to make sure it reaches the appropriate people explicitly.

$ scripts/get_maintainer.pl arch/arm/mach-rockchip/px30-board-tpl.c
Tom Rini <trini@konsulko.com> (maintainer:ARM)
Simon Glass <sjg@chromium.org> (maintainer:ARM ROCKCHIP)
Philipp Tomsich <philipp.tomsich@vrull.eu> (maintainer:ARM ROCKCHIP)
Kever Yang <kever.yang@rock-chips.com> (maintainer:ARM ROCKCHIP)
u-boot@lists.denx.de (open list)

(one can use scripts/get_maintainer.pl on patches instead of files, and 
it'll return whatever is needed).

Plugging `b4` here as well, because it's a pretty nice tool to use:
https://git.kernel.org/pub/scm/utils/b4/b4.git/ One can install it with 
pip. I use it for Linux kernel and U-Boot contributions for a couple of 
years now and I'm not going back to manual workflow :)

b4 prep --auto-to-cc would set everything up properly for you.

On 4/16/24 14:47, Lukasz Czechowski wrote:
> Display TPL init information message only when TPL_BANNER_PRINT
> configuration entry is set. This allows to disable information
> message in case logs on UART are unwanted.
> 
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

This matches Rockchip's non-PX30 TPL, so:

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

> ---
>   arch/arm/mach-rockchip/px30-board-tpl.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/px30-board-tpl.c b/arch/arm/mach-rockchip/px30-board-tpl.c
> index 637a5e1b18..a660816db0 100644
> --- a/arch/arm/mach-rockchip/px30-board-tpl.c
> +++ b/arch/arm/mach-rockchip/px30-board-tpl.c
> @@ -46,7 +46,9 @@ void board_init_f(ulong dummy)
>   	 * printhex8(0x1234);
>   	 * printascii("string");
>   	 */
> +#if CONFIG_TPL_BANNER_PRINT
>   	printascii("U-Boot TPL board init\n");
> +#endif

I'm wondering if we shouldn't have the parent ifdef also match the logic 
of the non-PX30 TPL?

#if defined(CONFIG_DEBUG_UART) && defined(CONFIG_TPL_SERIAL)

instead of

#if defined(CONFIG_DEBUG_UART)

?

Thanks,
Quentin
