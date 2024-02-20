Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30A4C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 08:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26E5A87F98;
	Tue, 20 Feb 2024 09:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="NLu9pdzM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AB1F87F9E; Tue, 20 Feb 2024 09:38:23 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 344AA87F99
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 09:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jR0uDIQuBKzr2Jh4eDrlg5mdzrNjoDrxz7QPdh0gafpCqRnLvZqLkL4MpX7TG5WqiSlzeVMXfc2uPYIPrQs9Wdu4HbNFEHRq2jKPNu74u+fkN0Tb9MjCeiEQNd32edL3bre5qHNEVPq/Ui/rBsGilIhP15FdlFb17SkN42z3DWeztj6IuAc7ZVySQPCX1ykVv7t5RUvFrmBl4Qwt9itoBSGXKr6K9ymp1fcBbE0HXpfuegayGGNLZW8XQHqSvNNYSPaqZoa24pfvn5/jUjD7npxDsQsljvhQmwWi78DUVIMzzZYF/u+rFc54p+H6mI60hVzetisuFrglGdTmjZoNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhvAMOTiLrzXsqjLzPxUxT/V2xnrL8PkWwc78KffvJc=;
 b=ml5JataMgBKFzVu9AVQouRzAuzpyimea4rtokHovfFAYJuQMU+uPlKtuDuQ+nKmGClWEgIr00Qp3DAJJJYtpiHFYc0ncKXt886/E2k+A1hdE2xnrnhmjA8aMQs/quYEifR7mj3iR+LVMBvaXS9jCcOSzPILaCQST0g3sAWpZG24cXaNePvXKMzhNLHFySIfmYvEIzwCF3zezmuNRzLrfAt4cT/QC4gVDLt9lIRJyHce2FAtj/Bta0wSyChWTZsNTlx60xbGuTQHAOZaSHEd6mShamdLiujqSrwXeZP/rBKt1SguImCExTxeiDt01KZdgXb0FzdK75F5RRgqK7e1Ysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhvAMOTiLrzXsqjLzPxUxT/V2xnrL8PkWwc78KffvJc=;
 b=NLu9pdzMA+SIFv2fxJO0ctKesO6FyHqPMs9uiDkiq+Fc8AkxAAJ/5/WfSLJMX/Har80yLKhcNWamXLfsYjzEsbipiLdmbCI3uguD4qigyn526vCEa3ZGW0pwpouxUVlKxxyP8WHkB+WFN3CnDc8tVQEmUyXC+MlC1/ISi1APcn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GV2PR10MB6066.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 08:38:03 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7059:adf6:18fa:1ddf]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7059:adf6:18fa:1ddf%3]) with mapi id 15.20.7292.029; Tue, 20 Feb 2024
 08:38:03 +0000
Message-ID: <847f8bd9-000b-4005-b6e3-2075b72191d0@kontron.de>
Date: Tue, 20 Feb 2024 09:38:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] board: Add support for Sielaff i.MX6 Solo board
Content-Language: en-US, de-DE
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Frieder Schrempf <frieder@fris.de>
Cc: Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Christian Hewitt <christianshewitt@gmail.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>
References: <20240215133527.216126-1-frieder@fris.de>
 <20240215133527.216126-2-frieder@fris.de>
 <1a3b311d-0f5d-4f2e-a9f7-da0ec0c4f60b@moroto.mountain>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <1a3b311d-0f5d-4f2e-a9f7-da0ec0c4f60b@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::6) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GV2PR10MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fec69d8-7767-48e6-8694-08dc31ef40b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22+LpLbsp4LiX4YtS3FjxTxG7kgBhTP6pnHdkdrDB53cy1tRcpqi/38GGZi+i+i5JGXeza9qj8bxfyo2rcaPCRureuysnoO21Nnm0Dgt5I3gDbteShynwMY3ugPyoRQitRNwcmaauq797iue5Zbd3pcjLuJwHQyv8wCGrjyYtjVDooEqT3HV3Yh6hHLGD/BdLM8bzIfGisPzFzCoLiTO2HdP+fNuMEGys6kXTwO8XI5PLqAVUq7w1VEGxQXa5r8yGfJwGoKOFj7faE6erELy0rOTQ6bs5JeepjyEm8RnVDwWVaLPcNGjqGZ/Sh7ZK5P0ROyJ1bELwUFPwWQi1SmauQxwiE1e1G4CALwYgcFQPo+XrWVmCAKAdt8k3R1OgoMWLZGH96X8T9LxoKtcaMkLSFKucMvvjT/U9rQIHrMvY4Cut2mnXluqozlC3fIIgnxaA15SIc8+eOBkPudW7UodkLtwTiUoVYhSwHVfZv0Gk1tlb8MQuxxjdCKKovEyd9TLtn1l42q3YXa0aV2ymw0PtQJ3kDxltDt7G0i4oVZuCHmWaDm+Bq1Z7KOL2OTmZ8cp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?allCTzV3MDF1cVlabmk3WGpLc04zcWdEM09CL0hMZysvR1RaTVQ4Vndjamhz?=
 =?utf-8?B?VWpTejFqKzJlR29WZTBnTHE2SGFJdFdxWUZjYkZYS2VjaEQxeENoZ0tNM0Mr?=
 =?utf-8?B?c2grSjVwSHpGam9BQnhCSnN2K0dyaE5tWmlxeXorRlZlWk90VGtlZitMQUFo?=
 =?utf-8?B?blB0TFh4QmREV2FLQ0FqSmZkRGRibmszc0ZEL1VOeUE5eFlkOElPT01PWTcx?=
 =?utf-8?B?WGwxaDQ1K2l0a09WZXB3czdVTDdvc2MyUzROVDlTVnBQalZIRFM5ZkFOczM5?=
 =?utf-8?B?NzYwZUN6ckVCa2Y3a2NkTVFSa2x6RElZdytiQzRnc1VQZ3cxVUpOL3A3RFRG?=
 =?utf-8?B?UzkzUWs4YUlXU2ZtLzBzZXA5Y3BscFkzOE40ZGF0RlZqTk9oWGM5SkRkYlZ2?=
 =?utf-8?B?enJBMmVMSXVDTTFqZi9hRlBCYlpHTnUzUUN6SXVxdVlheC83SVJzRDQ2TTRH?=
 =?utf-8?B?U0dRaDh2amo5eTUwdlo1aDJDeGJIbkNsbmRYUlY5SC9sQ1gxMysvdisxREti?=
 =?utf-8?B?bVltTXVRMUpjQVp2SDhGNmpRdzN2cEQzMVRubHZlYXlsQXI0UlpWUEoxMFpw?=
 =?utf-8?B?aWx3WEVVWE9kT25xTUk5NHN1MW5IK09EMUlVQ3V1eVNQVVlYbERYa1R6RXMy?=
 =?utf-8?B?d3JwVmtLUTh0dGpxbngvRDFTSTNWMGhKRHpUYS9lVVZRa0lVSG45RlQ0YjV0?=
 =?utf-8?B?MHovd3ptaWZzd3VrdVZDVkdqam4vN2xZWElUdnlDVThsVzQ5bU9BWGRwalBz?=
 =?utf-8?B?TmY2TjF0aTBjVzZSak01R281ZUpmUU5SK0ZsSEhRQTkvNUF6a216dEJ3MjhR?=
 =?utf-8?B?RlFsUGJ3eFBSVENsbGs1RGlVZE42eWt2V2wyTUZVU2liWTRUQVlPeW1tNTR1?=
 =?utf-8?B?VFRZdnd3aTZ5OHhSU1F1MTVSaHEvVkxiZzNrWFVQQUt6VEcyUTZhRkFXN0Z0?=
 =?utf-8?B?WnlidjBFemU3b2JVa0VuWjlqWU15RTlxaTBENmw0alhHNkNLKzBGbHpVZFlp?=
 =?utf-8?B?MkZGWWJZUVpGVXVOdzRmSThWa01HVExtVmtJZ0lYK29BSkp6Y0M3dUozU3Yw?=
 =?utf-8?B?Y281Y0JVK2NFalgvbkpQV1V4RHVWd1RtbU1VMHJjelVsSFZnRVd5T0JUby92?=
 =?utf-8?B?TThpdXJBVXVKRlJzNmZ1QnQ0Q0pkUTRTTXNvZWkxeGQ1SVUrNW5USDVxK2NH?=
 =?utf-8?B?U1FqeHB5Q2djemt3OFF0VjlsNG5zMlMxUUxjQVVPdE9OeHJLVkgxdXliMk5a?=
 =?utf-8?B?T0hPUnA0VGtxVE5DMk1ZUnd6TUd2dW1HK3FHOFlsSEpsWW5tcExERkpxNUtt?=
 =?utf-8?B?R1Z2Nnc4ZW5EZjFnaDlLWEZXbVErMlZPOXNMWHAzai9tbXJMZ001RE1RRzl4?=
 =?utf-8?B?ekR3cGhaSnRTMUF6WmY2N0NuaDBIVDRtMEdhdjY0TjZEeXdUeGQ0MkxPcW0v?=
 =?utf-8?B?RVFRZTA2dHZiVER6LzcwT2wyeFd4b0N3eGJzNG1GbG1jZm84KzJoTGM2MlVv?=
 =?utf-8?B?cUg4ZXZQb3hJcEZoWDNPTkhuenZDSWNRVnR0MlFYcElCYld6aUFjM1NmWU1X?=
 =?utf-8?B?dkRTZlkvUVBKME9FeU5XenF6VDAyc29SNXN0dWdXSWhnaHdOLzY5eU1peWRW?=
 =?utf-8?B?bjRndkZhbkxnSVZKQXVxYURDVXAzNkQ0THcrM0xaWWZLV09YSXhxVGRZMHJr?=
 =?utf-8?B?bFBVeXE2NGdDNk85NFA4QjJmSDQ0VFRaWHJTZGdKUU9DY21EMmxBRDlwdy9T?=
 =?utf-8?B?Q294RnNldm1xZVphd3dXVHpCNTNvTjFYRFJTRXRDdFlmeEFtVW1NWFVpYktt?=
 =?utf-8?B?Vko1b1FSNUExY3F2dFhaTURBSEl5MnRicmI2UnlsRTgzOGZBQno0Ukt4TEw1?=
 =?utf-8?B?c2lHNlNFL3E4Mmo0dnM1OGwyckQwWFR0ZExoN2FlSWc2ZG1sM2c4TWc2blhO?=
 =?utf-8?B?SUY0TEFxUUYwQmJBRWhOTUJoMmJHSGwzRURSSkx1QXBXejJJaFFUNTkyNS9t?=
 =?utf-8?B?QnFDdS8xWU5yR1NXOUZ6NS96aHFKYnpUancvdU5ObmRvaFRFMG4wRnJaejlB?=
 =?utf-8?B?eStPcmR0R25OMjc3TmFoQlpBNnp2UUNPaE1GMTcyakU2cDNaVjBZenhyYStU?=
 =?utf-8?B?MExTaGQ4eDJuMklaeHFjVytwZTIxKzNZOGlJdjcwcTlEb1I0a0JKN0tlWER5?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fec69d8-7767-48e6-8694-08dc31ef40b8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 08:38:03.3873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLyGdJkG4rNSoimbeQ7TUP29Ekl9pw/9tiImrCe8z5LLyCQu4D8V2nA5b7+HGQbLcMhuwBy8tvjcjpAA6F/8UTUa17O4xFxL1j6OEm60TVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6066
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

Hi Dan,

On 20.02.24 06:56, Dan Carpenter wrote:
> On Thu, Feb 15, 2024 at 02:35:20PM +0100, Frieder Schrempf wrote:
>> +int board_mmc_getcd(struct mmc *mmc)
> 
> This function is never called.  Also for bool functions make them type
> bool and name them so that it's clear they return true/false such as
> board_mmc_getcd_was_successful() but less wordy.

What makes you think so? This is an implementation for the existing
prototype from mmc.h. As far as I can see this is called by the mmc
driver and I can't change it in any way.

> 
>> +{
>> +	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
>> +	int ret = 0;
>> +
>> +	switch (cfg->esdhc_base) {
>> +	case USDHC3_BASE_ADDR:
>> +		ret = !gpio_get_value(USDHC3_CD_GPIO);
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +int board_mmc_init(struct bd_info *bis)
>> +{
>> +	int i, ret;
>> +
>> +	/*
>> +	 * According to the board_mmc_init() the following map is done:
>> +	 * (U-boot device node)    (Physical Port)
>> +	 * mmc0                    USDHC1
>> +	 * mmc1                    USDHC2
>> +	 */
>> +	for (i = 0; i < CFG_SYS_FSL_USDHC_NUM; i++) {
>> +		switch (i) {
>> +		case 0:
>> +			imx_iomux_v3_setup_multiple_pads(usdhc3_pads,
>> +							 ARRAY_SIZE(usdhc3_pads));
>> +			gpio_direction_input(USDHC3_CD_GPIO);
>> +			usdhc_cfg[0].sdhc_clk = mxc_get_clock(MXC_ESDHC3_CLK);
>> +			break;
>> +		default:
>> +			printf("Warning: you configured more USDHC controllers \
>> +				(%d) than supported by the board\n", i + 1);
>> +			return -EINVAL;
> 
> This will look weird if it's ever printed:
> 
> "Warning: you configured more USDHC controllers 				(%d) than supported by the board\n"
> 
> There is a checkpatch warnings for this.
> 
> WARNING: Avoid line continuations in quoted strings
> #1137: FILE: board/sielaff/imx6dl-sielaff/spl.c:96:
> +                       printf("Warning: you configured more USDHC controllers \

Agreed. Fabio already applied this to his tree. I can send a fixup for this.

Thanks
Frieder
