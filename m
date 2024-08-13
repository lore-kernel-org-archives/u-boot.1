Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9F1C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 08:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7799B88969;
	Tue, 13 Aug 2024 10:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="BnbMc67a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BBFB88969; Tue, 13 Aug 2024 10:30:53 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0509988739
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 10:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hh4FIWSnaJKXpggAyT+RYb5OL648iOEVWoRl5NuTpdrPnMJ8AWEt3jsnb54Ct7OXp+GFUJC9qvv6gfwOYdck+e9l4rzx804d6WhC+1wgI6jM50MPQonO1a0Q80Gk5D1PzxfGo8SBEvv5sodJsgZ/M31u5AumKED2aOlfKQjUeCcVUUAv3ULotiATutXjTww53av3hjNI5sbrak2PUb04B4+4D/BSckWqwNYLTnQcz6pnAc0CLeW3yelVRrWgwA9mQsJTuaZG/RBxsH8pUaMjsa27P/FGzg7JYl1rFZdYHWoCVh7ToacjUrtrthMtDpzEq6YDkaqlCRow6WkeDDTemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wu+GLA5EKsJWccf9ums5FjJ+WhY0+lDWHVRJyBH+YbA=;
 b=hFSdmNaDlJ1BG/55Wxr0HuBp1PlLOR1ioQs7BTL15938Mj2il0o4g/H2IwIUURckfb0shuBVld3t3OkrGiaW8G/kLXRBVxLb4B4SKYZi5A9Is67h6NejFTiuIusip1HqO0el4SOge6tekZ86l8uicT6fZUNuHQNAJ6YWYPgo/+XPkCmsQfSLRE6Z/lSynKPPsPg/Z+v6HSUdaigaNo+GYF2O2R4g1x7JvHta9+gpZgth6rqCSSX3Ij+EnUthH+ejKu8ET+FMVyyAl//X6IA/NZrFOF6QOmwbMJEFXCIuPPrrbB+C0Xy8JHstQTBqnu1cK2+OcHJi2jmnD1OmtOYUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wu+GLA5EKsJWccf9ums5FjJ+WhY0+lDWHVRJyBH+YbA=;
 b=BnbMc67aJ59gyCr22EJC7J1+s93a2PVNfsv0/PPsyyNO4g5mQ/2YS/EDQowuYPElAhg2alUJH+OZMZ89ll5Ty4U1o3JVrxwohVhkK1E8OhvVpxcUGopKfeBtZo1GlqpVuPKXz9/0Jklnj4YQ80iEjJ8Ucnx4v7IXCv1P1HDKbqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB7118.eurprd04.prod.outlook.com (2603:10a6:800:127::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 08:30:46 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 08:30:46 +0000
Message-ID: <8124c430-0fdb-443e-92fc-b0308ac2b545@cherry.de>
Date: Tue, 13 Aug 2024 10:30:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: px30: clk: add UART0 clock getter/setter
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, lukma@denx.de, seanga2@gmail.com
References: <20240731094307.65307-1-lukasz.czechowski@thaumatec.com>
 <20240812162728.460138-1-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240812162728.460138-1-lukasz.czechowski@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::26) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd10603-5f52-40ca-0c6c-08dcbb723a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjBXRGNENUl4cjQwaEFHMzNJWlI4UG1YcmEwTTNJUUlra2dqb1JvcHhBTGs3?=
 =?utf-8?B?T3dvN1JpWExtM0dDUW1rREpNWDRTdlgzRUhUdyt2TEcxeUdKMlZCdkhVZ08r?=
 =?utf-8?B?ZTUwYUhLS1VjR3JtN3U0cXhYcWRwMFBwaHUweWFEVGI2VXE1OGRVdVVlbDZi?=
 =?utf-8?B?WDAzM2xZLzF4QVVVQW51NWlNZ0xWM0d5WXljbjVMUk5kVG5UMjVZbytYQjFE?=
 =?utf-8?B?WnFQU25sTHhlUkJGKzVLMzk4b1k5Y2szMW9RbEEyVkFyM2kzME9ZMnBYY2JG?=
 =?utf-8?B?V2hTY2IrOGQ5NUQ5K2ZtVUFndk4ySitHVk41MWw4OUVoNFdZZFVPUzlzTlNw?=
 =?utf-8?B?Ynpxb2t5NW55TU1CRWMwZ0RpdlFleHFtUEpQWndhOGpMbkxJa2tsdnR1RFEz?=
 =?utf-8?B?aGdWUVA1MmNzTk5GUTdpVkRuMFhkeWo4b0xNNTFzZ0dyQVkxREM4UnFiK251?=
 =?utf-8?B?MFJ2czZ6NHFVWDNIK2RQeTVnaktwY2lOS01veTFiUW1NQTVzSnczR3lpeGJN?=
 =?utf-8?B?cis4Q0hXMXhXbGp5aVVEN2pZeVMrcGdSekVXdlB2enE0dXBqUW4zUXJBaGxI?=
 =?utf-8?B?c0dDaGs3cGRSQUJ5RUdDeXY0VHMxZGFLUXd2OHpSUE1jZThITmRUY3E5dlBZ?=
 =?utf-8?B?Y0UzamFaeU9TbmdJMnBNZS9xY1o5cU1qL3NhT0lLemxQOWFXT2plVGZFSFJj?=
 =?utf-8?B?cW9FeTY5WDhIZlpyMFBYWnlxalVtS3o5aXNBUXdqR01IWENKYytJSDAxcXhw?=
 =?utf-8?B?VTROZExHUm43Y0NVL3kxQWZPM2VJT2tVU0dSRFM0WFBvYjFwVENRZm44REta?=
 =?utf-8?B?S2JrekI5aThqSHRFa3NvVXduTVkyNzduTHg1cDVwbzV0T0dEdlpLUjRNMUh1?=
 =?utf-8?B?L29wNXlmbWx5N09BeGNRc3NJaHJUVlZwaFQ2V0d0Q3FSQnI1NHFQTjhkS0Nx?=
 =?utf-8?B?bGcwaWpUWkR4L1VUeHVOS251THdJQ0dSdnFiTGxHNXduK01FcHdKYzJkWWFZ?=
 =?utf-8?B?Q1RyZUVBMStJKzdWdWtQdjcxbWgyaXFnMWhLOWJ4TDU4QVB4S2VsSU5aRmtN?=
 =?utf-8?B?UlpZcnJKeHgxSmdIUnNsTHdPcUE4VFFYT3h1WEMreHRWUS9LbVVjT1FKUE03?=
 =?utf-8?B?dWFlL0FFVHFMRnY1cldjZnExd0FHbGE2RWRHWllNSnkzUnB5U0xqK2tJbGNi?=
 =?utf-8?B?aldidVZUU1d0L2toV2FPeXc4K01tNlY0SEc2cW9oajIvV1l3RVM5RlJtdGNp?=
 =?utf-8?B?REk1WmxDZi9RZlBrVzMzZUpEeFlNUk43SUVwdkNXdmVMbnFFc09JWWNpemFz?=
 =?utf-8?B?T2FTc3NFaVZKRm9FSEpocEdNWnYzUzNhL2VsRlFrT0JlWmZ6V1J5YVdsakxP?=
 =?utf-8?B?YjVPelhnSTNJTEtkODl6UjVibjRyK3pkbDQzNWZuUDdXYzhBNjJTd21wUkVH?=
 =?utf-8?B?WmU5bytRN1pWbzVycUt4bDE5bVU4eUxGbm5jUWdqSkhSMXNTd28wMVdreDlY?=
 =?utf-8?B?cnhJVmloaG50SVZiS3dhaENYQWZ0ZjJmNXdNdUMvY1RoT1VGMXlXOTJBYndC?=
 =?utf-8?B?VWwxTHVrNGx4R29pVGtWbnNYWUZ6R3RsdGNmNUxBQUlJbG1HVFo3TXc5M0w0?=
 =?utf-8?B?LzZrQWhoVU5YaGNoR2ExcHJsRkhkMm5UWWlkNExzQWhramlqcUxaU1poWkhq?=
 =?utf-8?B?VUdhc2pJWWJ1SC9Ta2lLM3JPNERwanltYnVUaFphMHBnT2NPQm1VbEJ1VTRL?=
 =?utf-8?B?Z3FITTJ4TjE1b25aSVJLWVhpQzNOeFBmTHlncnJ1ZnBtK3BXMnFHSUg5QmJk?=
 =?utf-8?B?aEFSUjUzUzA1QW9kMFJIZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djRQSFppTUtsM2d4am9CMmVuSUp6dlNBdnFTdzZXNDhGNksxS1JwdnB4Q0Q1?=
 =?utf-8?B?dmdyeTg2MHNlVDR0NXRiTUtaaGNpMUtSRERoLzdhYWNsKzROZXArcDBCdW4y?=
 =?utf-8?B?MlhCSm5Tc1VMaktDRkk4Skx4c2lqZ3llbW45d0ZrRnRXVlFaVW5NMXBQQ0tP?=
 =?utf-8?B?eVROVXNQR2xJcDJaTThIem8yR0Zkb0tGWGxNWXpSM3QrVFlXUVdQL3dLNzJH?=
 =?utf-8?B?Qm5taEZsaDQ1NGkzdmEyb2NuNytJSCtEcWlsT2Z6ejJpNFBhakxPV3doOXNZ?=
 =?utf-8?B?a0VxUDBzUWx6V0RsVmZaRit2WmRNOFpNYXc3YkF4SUlNSDVLbi9pU2ZzZjFF?=
 =?utf-8?B?SitRNWxRc3VTV0V3bmdmK05NS001YW1IWUFQMnMvSkhPWVZtSENPOVlaMUJl?=
 =?utf-8?B?NEh1dmNLMXRPb0RTWmlBcUhBNjNNbUhFWCs5SzFocXBzZWZmV21BbVVkWWpM?=
 =?utf-8?B?bWhDekdWdm02VmcrUE9DVGhRV0tJSHBlQkkremtJdG1kQ2NsVkpRakFmNFp3?=
 =?utf-8?B?eVMvanlLYTV2QUtsNmR1TFRlOURUZzRpNVNYTTBSbHdoKzM2elIrRmhuWUg4?=
 =?utf-8?B?STR5K28zY2h1NE43UlliOWZJc0ZaL0lzamlWUkwvRSt3MVhsc2dxYklRQ0ds?=
 =?utf-8?B?VlVSaTlsUTEvRC9weU5nWTRHeFRkdjVVZGcxVHhKdEJLRm9UcmFYQnp0T0dY?=
 =?utf-8?B?SWZKUDY5N2d1MkxEb3BZNnVkZU15Tlo0SGFIOHlhd0MrV1lWelI5dHlRdDd0?=
 =?utf-8?B?T0xCb0tuS3dzR2tNUXk3RmRFSkh5WHF2dHhKTTZwV0kyZjBhcVkrdXRkUmx1?=
 =?utf-8?B?Ukc4OGtLbGE0YXBqUFhMeFY1anh1aEhlZGMwTVpZOWNkcjlXZ3lCZjlldmJF?=
 =?utf-8?B?ZGdnUUNDMFdRRGRGdHAxa0pNUldYb0hvdTdJNmcvWm1BZjB0eWVxWG1TK21t?=
 =?utf-8?B?ZElLaHBrRWVwSzRIZ0ppeWhtRGZjbHpUVzNjNXRWTFRTOGNBUEhKY3RzUE9o?=
 =?utf-8?B?V29aNVlHTjVWc3lOZkF5S003L1RzQ1M0R3ZOV2JQVEc3WW1TTzRLbXVIZXpW?=
 =?utf-8?B?WGlUQkc3RnVTN2hYVmtkVzJNeFpxS0U4ZUMzVzNzSGRtQ3RyekwzSng5Mjhu?=
 =?utf-8?B?T2l0bW9OOVJmdHFoMEgvWG13cGl4K1NHSTRzM0xQVTFPbG5WRWs0RUVSYWFY?=
 =?utf-8?B?ZytWMERZWEVKZ29pM3JqeEdCZVpYZGFvZlVpODZCVk5RRHBVWFcyQVkvSWds?=
 =?utf-8?B?QXNpWTBoRzM0Y3lKZFNkR0E1SHVGeTI4WDg4bDVYaFpPcmpyOUx4cXlXTWc4?=
 =?utf-8?B?bnpZZzFiMG1Ocm42T0NNMkxleFEyaXdCbUNqVWlKZEtXZHVLSE9DWHB0VTJI?=
 =?utf-8?B?Ykdwb25hR0tNd21EZ2VVZlZveGNTak9mVHE3TnAwMzNLVzliZWlPMDVhNERt?=
 =?utf-8?B?NUhHWXdoWnRoajVFSGozMkxPaldiUWZLY0xrbGtwNktISVcxVUo5ckVGbXRi?=
 =?utf-8?B?MjFTSmNxSU1RVG00UGRVZHdRbHpuWHBoQ1loek5Wa1ZkbWh5QWRvZnpjRHFY?=
 =?utf-8?B?YU1jN1BwVTNFMW9lc0UwcnB2alVBU0t4WGE4cmtuenpTYzFJNEtlQUhYZmVO?=
 =?utf-8?B?SDJDTkl4T0lURlRJb0pObGZlWW1tK1FLSnVSWGdLaUtRcXNmNG1tNVFyTlNz?=
 =?utf-8?B?dGlGVXlTMENDdFV1dHIrYjlEMUtKREFNUFVaNG9TYmlEYytQRG83SEc2NmY5?=
 =?utf-8?B?a3B0enlTWmlNQk1iSlViMnR0VVp1bU1DQUtmc3J5eU9yT3ZtYzF5dkh3Rkhk?=
 =?utf-8?B?SFRQaTBtRittN3FlcWlWM1JNZVZSMGJ3Y1lScmtNenZBNVBDR0NVRlFIK3FR?=
 =?utf-8?B?Qk9FYmcvN1IzeXZ4SkE2emcrQzg4ZmxiVm4yWlo0dzJkYWdwNHEyZUs4T0Jj?=
 =?utf-8?B?Tml0OXhteCtTMWJEKzhqMWQyZjI4RG5FUzdsa01JZ1NyYnFOQTEyOVRTUkdv?=
 =?utf-8?B?SDcvUVhBN0N4dTRLVktNUVlVUWdybnRxSTV1eGtxTWZOdGdhNDlObnRYallR?=
 =?utf-8?B?NmNBMXJONXZkSVNhNUhQNHFQcmJKRXk1TkcvdGhUNEZoc0RPdHVlbEZSYW1k?=
 =?utf-8?B?eEttUEpidzZGbUJ1M1hLejhuYWIvY0s2Q2x2Z1BZeXJGZ3hqWFdRNVV3bURv?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd10603-5f52-40ca-0c6c-08dcbb723a5e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 08:30:46.5937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buVOgqgYn3+5ytp669T9waFnHlRZksChKVgVDVfH1nAwv4t5Oh9CYszGQTBcQqc+RTW1xper8ZoBH1jtHHeMqgY/m8waGSmEQzsXzfVH2qQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7118
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

On 8/12/24 6:27 PM, Lukasz Czechowski wrote:
> Add dedicated getter and setter for SCLK_UART0_PMU.
> This allows the driver to correctly handle UART0 clocks, and thus
> it fixes the issues with UART0 not working in case DEBUG_UART is
> disabled.
> Unlike other Rockchip SoCs, i.e. rk3399, in the PX30 the default
> clock source for UART is GPLL, instead of external oscillator.
> If the DEBUG_UART is enabled, the clock source is changed in
> board_debug_uart_init function to 24Mhz oscillator, which also
> matches the fallback value obtained from DT node.
> In case the DEBUG_UART is disabled, the UART clock source remains
> default, and the DM serial driver wrongly configures the baud rate,
> resulting in broken communication.
> By implementing the UART clock getter/setter, the serial driver
> can probe the actual configuration and corectly configure itself.
> The DEBUG_UART settings now should not affect it.
> 
> The driver supports GPLL and 24M oscillator. NPLL and USBPHY480M
> sources, that are managed by CRU, are not yet handled, as likely
> they won't be used in real scenarios.
> 
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---

[...]

> +static ulong px30_pmu_uart0_get_clk(struct px30_pmuclk_priv *priv)
> +{
> +	struct px30_pmucru *pmucru = priv->pmucru;
> +	u32 clk_uart0_div_con;
> +	u32 clk_uart0_pll_sel;
> +	u32 clk_uart0_sel;
> +	ulong clk_uart0;
> +	ulong pll_rate;
> +	u32 con;
> +
> +	con = readl(&pmucru->pmu_clksel_con[3]);
> +	clk_uart0_div_con = bitfield_extract_by_mask(con, UART0_DIV_CON_MASK);
> +	clk_uart0_pll_sel = bitfield_extract_by_mask(con, UART0_PLL_SEL_MASK);
> +
> +	switch (clk_uart0_pll_sel) {
> +	case UART0_PLL_SEL_GPLL:
> +		pll_rate = px30_pmuclk_get_gpll_rate(priv);
> +		break;
> +	case UART0_PLL_SEL_24M:
> +		pll_rate = OSC_HZ;
> +		break;
> +	case UART0_PLL_SEL_480M:
> +	case UART0_PLL_SEL_NPLL:
> +		/* usbphy480M and NPLL clocks, generated by CRU, are not supported yet */
> +	default:
> +		return -ENOENT;
> +	}
> +
> +	clk_uart0 = DIV_TO_RATE(pll_rate, clk_uart0_div_con);
> +	con = readl(&pmucru->pmu_clksel_con[4]);
> +	clk_uart0_sel = bitfield_extract_by_mask(con, UART0_CLK_SEL_MASK);
> +
> +	switch (clk_uart0_sel) {
> +	case UART0_CLK_SEL_UART0:
> +		return clk_uart0;
> +	case UART0_CLK_SEL_UART0_NP5:{
> +			u32 clk_uart0_divnp5_div_con;
> +
> +			clk_uart0_divnp5_div_con =
> +			    bitfield_extract_by_mask(con, UART0_DIVNP5_MASK);
> +			return 2 * (u64) clk_uart0 / (2 *
> +						      clk_uart0_divnp5_div_con +
> +						      3);
> +		}
> +	case UART0_CLK_SEL_UART0_FRAC:{
> +			u32 fracdiv, n, m;
> +
> +			fracdiv = readl(&pmucru->pmu_clksel_con[5]);
> +			n = bitfield_extract_by_mask(fracdiv,
> +						     CLK_UART_FRAC_NUMERATOR_MASK);
> +			m = bitfield_extract_by_mask(fracdiv,
> +						     CLK_UART_FRAC_DENOMINATOR_MASK);
> +			return (u64) clk_uart0 * n / m;
> +		}

Considering the function is named px30_pmu_uart0_get_clk(), it's implied 
everything in that function is for uart0 so you could have save those 6 
characters (_uart0) from each variable name which probably could help 
with having less odd line-wrapping.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
