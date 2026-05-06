Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A12EFF8855
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 13:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0271F8490D;
	Wed,  6 May 2026 15:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="X9Qcr6MH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32B0584933; Wed,  6 May 2026 15:14:21 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F8F984903
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 15:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AimXzjmVMmm9spYWZxI2moowYWLSHPJDlGwpWycqa80RFeko0ME7P2R3wZaO+q/hiI4UsfPlEZDKgpXq6MF0cpWmsEqKGfiqFeN8hOXpQrTa5qBak+QBziNqdRX39zNIlqQ//07kr+ob/AOY8YbV+ICPdPfxUvQn0y4GrehjNWD2iurbr6ODJ3i+jRZUaJQB9RqeQ92UK76O5sRzD6D2wVG7M+SrSUp/IL+bHm3aGrkewkuP6oSex+DDozulv4pmVexcLZxEfjEcUqweyRQJca1VTnzVltZ2K953g8k1mVyK3XdasSeB9AeAHkTvKD4HX7soAL+Pc44hjofRckacYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KGVXrM++7MBMfjmoOucx9DFA3QoetQb9FFQhqBuXoU=;
 b=BSd07JJ8twNuwY4UB2lzBfAgInlXdIR/iCkD+7gtbmLdrmR3HRfThIowmlozYPfgBcqx/UmsP6C4IFl0QNZDkeTeJlgzNGW443r9szNgDX2QaqW1RVBGHXGc4YNRNbDvNBJvhYp9v6pfJtjV0fzU4EfM4gY23U4lNzdXsQW/7n/6X35XO9SVmmqwNwYXmpPDy8zs+M4Iim1BxbXMzktc8SIC2nosLXeO+MBqRQcu3sN0hJ7HlNSdJfZN+SLtlKrRwFQ+eVQHMMHt5bbH6QFgSqgjfTP0NHrwnpwxJE8x98SxJl0RCTjIFYfj4aYh9yNhrXYV++6i/6JaYpEKCQs0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KGVXrM++7MBMfjmoOucx9DFA3QoetQb9FFQhqBuXoU=;
 b=X9Qcr6MHBamiIdUwVsfJojAUmxyvKF+69fX8PEclDBMrkahcgQmRlkQsA5/UigB1UhjE8SY0YsSVBHybeyI2CT456rMUD0TeeCPhi0nzFEwfYhiJfsIaPtTCS16fTW7eaufKTxv0EwDDVhMMnc2WBjaPSYJeGc7nqsmiqFO9xME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 13:14:13 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 13:14:13 +0000
Message-ID: <b55bd93a-d117-411d-8cb2-3c5f7c8d64c2@cherry.de>
Date: Wed, 6 May 2026 15:14:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 0/2] Modern pinctrl for Exynos5250 devices
To: Lukas Timmermann <uboot@timmermann.space>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <me@ziyao.cc>,
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>, Minkyu Kang <mk7.kang@samsung.com>
References: <20260506-pinctrl-exyno5250-v3-0-11649fe82210@timmermann.space>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260506-pinctrl-exyno5250-v3-0-11649fe82210@timmermann.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF00000121.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8b2) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|GVXPR04MB10248:EE_
X-MS-Office365-Filtering-Correlation-Id: b25cc760-7d22-4017-6836-08deab715dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3suOqIQohDDX4pLOcxkrIJ3cSNsyCjEmCXB2700JuYJ8/5KY8w5+tCzw78Lgqfu2Zl19oT+mNneTLmDuDatXho/Hm/6zIJmlp/+ahDCvOpX7n76szFJYj2RZ6JRgP9/6i7/7SfxpDQmS/TQS4xiib3RHp3Wapr1j7Kmc26xinqo1GuJGelZljVF1Iqm1hpDyvhajAavlLV64AnbWC3Ahm1jL2qz3+fWv72bF3mRtZg7zxVXmyHqQy5NQ0+X1e0Q/FJ7ltilGzEy7Tu7s1nojEVaoDhqaweyGRbQUClw5pAR4PxJOPX6ccUuDUL4wB5sEMXbdIKpJiBTyjLajV2H1LZh8q9V7ln24xlSwBIpVPxBYU0JFs7nyLZ6Hiw6oRDrjO/8WIuGm5MZJKx/QGMBT3bsH0QQci4G0XQrl3lKL0J5vOMn01/i21AYZVwnlSj0UZNLDaSYYLQiN2yEKdTCuQugZTz8I4Cw9Dc154Ylc0eqJvTqhqezCvrDaloBJlWbtRfk2Vx8joMN9Z9ixX9G3cxn3PYpwq3bTgq0n0I80muYGtMSKM1pkxkLvNIOoTScFvu08DFFlrF+uGH+6cxy6Z4ymhFtNBMLt+gQAE0Jpfk0Jhn2H5lihCiCoAdCHcpQCgn12d2EPudx5/9sx+ejOpDgiA/dbPY/rIl5lQH1hlpe3PsSwSBHRe1EmsHK9ckrU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXdhOG9ubGdaY3R1S3l6Q2VFM1B6VjdvNTFMOFV6d01zNmlPUlUwUzUvMG9W?=
 =?utf-8?B?MDBkdk5wd25pT1A1WVY2OHhSd2RWK2c2V3hDQWJQQ2M3Z21iMW5Tb1k5L2tG?=
 =?utf-8?B?b2ROMElhdzh1b1FsV0x1b0x1UWxCSzl3WW9XMURxVWJZWm1FOEtROTMzWEJy?=
 =?utf-8?B?Wm5ZU2o0OE5uUWlyTEtGTlZFWWdiOHdiMVpWdWc3QjU3cGc0OU9BNDY1NklE?=
 =?utf-8?B?bndlUXVIUnBCRkhLU0hiMm10Rnd5NiszdmoxUWNteDYwb0RoUWVpejJ4QUk3?=
 =?utf-8?B?bGxwUkNackNZc0MvK1JYMFExUG45d29aSFl6YjYzNHN3MVlRNzNleHBKeWZM?=
 =?utf-8?B?cFUxMGtnWUMrdW1oMVlKZDVPVzc4SndJY1ByVFFWS2NROEZzdnFkWmZVNkpH?=
 =?utf-8?B?L3ovTVJDK24yb1lrMW5vTlpON0RiL0RVTktNUURRRXVPR3lxTVhhbm9GSTJX?=
 =?utf-8?B?b3ltYXZrU3R3SEtsQ2V6L3pRVTdwNjF0YXZGc3UxTHRRVlZTNGUxZ2pwZEhm?=
 =?utf-8?B?ZXpWSkZYdy9sRWg5dHJ6K24vd0E5NkF2VzhPaEtPcCtUalBlckNyY3BJU2V1?=
 =?utf-8?B?RHFEc3JaWUl3VFVkQTd4am0zeFZqYUpoUnY2RU1uM3VtQW5URU9TRnpZQ0Nu?=
 =?utf-8?B?V3dqcnFOY2J6a2FWNGtBeU1LaklxdG5Oa2dVamp1RHlBSVZISlg1VWQyUUND?=
 =?utf-8?B?ZEcybWpUeHFnUzdwNWVLTE5xVWh5eUU1RFc0RXNiQnVHTERsZmVoL2orQ2N6?=
 =?utf-8?B?bE9wMlRuNnVYT0prclU1dGhqR3RDYzZmTHNnODVXWVBqaXd2Qnh5SkMrdzZT?=
 =?utf-8?B?bVJyblU2TmVvL09SU08yakQ4TUIrcDlrVW1vZzMwcW5HZ1lqdjk5RFFFbTAw?=
 =?utf-8?B?YmhINEpEYzRiRWRFTW5NOEtObW9iek8zK291bXlZd1JwcW9lbmw3UmdSc1hD?=
 =?utf-8?B?em1sTFFaeWlFMXQ1UmNOR29LZFIxNzZFeHBwbVFFaXhhcWY1a2l6Wkg2OVZQ?=
 =?utf-8?B?M1pLbitnbit4cXozQzdoZ1lBM2RmQXU1SlR3SVhRbVRMeE8rUUl0amNJY05Q?=
 =?utf-8?B?SHg3bmJESjJJN1BhbnBORmJsWTNvamZzMmsvNy9QVklIMEpudElWaFJQckd2?=
 =?utf-8?B?aHV5dm8xaDRwbUwvejVZUm9IcUU4eVJqM3B6dDRXbFMxRW91eUx3ZEVZcUpM?=
 =?utf-8?B?TEFlZEwybHBkZTlxaEQxUzltZDkwazNlRnNxdE0xdVJERG9EanFlaGpiMVZ2?=
 =?utf-8?B?WW9ob0E1L2pCVTVNRXc0MGhuaVRuWFhadjZnVXdQUnR3eWUzU3JlVDVRWDdK?=
 =?utf-8?B?bDRKTCt2KzV5Y2FSbHloOWpjd0dxUHN3NjBKajRjZDBqYnR1L01wbnZFQUVr?=
 =?utf-8?B?cUwxQS9ZZXFwdzdGNDlCZ1VvU3pzSkYzQzZnVHpBeC9pcWtUMkpvc1FKZGJP?=
 =?utf-8?B?a3Zram1TT0drZFR5d211K0FPRlpCRVJrTlJKMGpIMzNyYXR6c21GdWsvMGJy?=
 =?utf-8?B?a3IxUE5yS3JMSktsS3dKL2czSXJ4RXhWWWpSWlZDRkg4aFExbnIxUDVmUE5y?=
 =?utf-8?B?MkR0ZnZnWTljdmRnS1htK0FRdEczTitTSVVmekVXK0hMUUhaR1hMcSttK0cv?=
 =?utf-8?B?QXQxWVlCa3FOYXg5Q2JqKytZcmt1d0RaRTdZaSttdmFETythcWRDZkJOLzNk?=
 =?utf-8?B?OVcyRkQyQit2V003VWhYWmx1VWFsVDZvcEVSbWFRY2dhSUg1eWlkWm14VlNr?=
 =?utf-8?B?NW05RlVFRERYeUtVSXozRzZvdDVuV09GbVRzU0g1U21hbTR5eVJ5VEFLTGs0?=
 =?utf-8?B?cmNYaDg3cUxVSkh4dUd1UXZNTFV3VE02UFdIQkZmaUtMZ25CK1JqUzh3NWpw?=
 =?utf-8?B?L1gxTFo3VGdlT3lZejJjbmVKaHE1MVkzdUhkMXRvRjJvb3JmcXJnbGVoUzYz?=
 =?utf-8?B?YWVsbXhRbWFUUEYxTDVZMCtvd25YdUR2Y3c5WXZCWlpPN2grK3lWdkxZU0RL?=
 =?utf-8?B?ejlPcjFGWE0wYUtidGRoNE5rS3FQT0xBOGpOQXlZU2hKUC9lckI2NXNaSHN3?=
 =?utf-8?B?U3cvQitVLytpWk9MbGFiclN0am5iaVdWZmVpRTduaE8xOEhIMmJqSUl5TUVl?=
 =?utf-8?B?WUVoTlRtalJJd0lHK0FaazRjMlI0SkJuOWZDMlg0ZW1UemQ4aUtmRS9qRThh?=
 =?utf-8?B?akZadWxtSTRQdlA0dFJLUGJQTnNOblhSdW45QnFjenpDNTl1aXBBMU9WTGU1?=
 =?utf-8?B?Vk14aFY0M2UzbW9zWUZXdnp1c0lGWWs0VmRWQ2ljVlJyR1hEbmpVL1cwT3ph?=
 =?utf-8?B?bFZzY2J1WDlnbi85UXlScEkyNGF4bDRtN3U3MFZHTVFPU2VYa2VoeWFOOGNZ?=
 =?utf-8?Q?ZVPxRo62XMHj/LeTcoM+Wz6oieVMkh/EtAthz85ifTalD?=
X-MS-Exchange-AntiSpam-MessageData-1: Z8ihYb3OkvdUa4NDBk1iqxevQelWOltWdgE=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b25cc760-7d22-4017-6836-08deab715dfa
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 13:14:13.1751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKomjYeYIOGTtQA3+3zWr1DPPFsSLxr/0i7/1alGZ1+Tsz4WF3BUxsfX167V5b7Cul+TFzi9aS2hWcDiW4OhRglzJhHgO5/86MH6FiwH40o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248
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

Hi Lukas,

On 5/6/26 1:13 AM, Lukas Timmermann wrote:
> This patch series adds the necessary files to use a modern pinctrl driver
> with an exynos5250 SoC. The changes are well tested and are working.
> 
> In contrast to v1, this reenables GPIO functionality. But as I'm still
> lacking experience, I'm not quite sure on how to prevent s5p_gpio to
> load when using upstream DTS in a clean way. Because of that, this
> patch series is marked as an RFC.
> checkpatch complains about using #ifdef.
> 

We already have an issue with samsung,exynos78x0-gpio so we'd need a 
similar work-around for that one.

An easy way to sort this out would be to know if we know of devices 
which are still using the old binding? Qualcomm is rather special, is 
Samsung Exynos also special with regard to how it handles Device Trees? 
Do we get it from an earlier boot stage or is everything coming from 
U-Boot itself? If the latter, we can always migrate the existing devices 
to the new binding and remove support for the old binding and with it 
the same compatible in two drivers. Another question would be, does it 
make sense for both drivers to be compiled? If not (e.g. it's only 
pinctrl IPs inside an SoC and there's only one pinctrl device per SoC, 
so if your device supports the new binding, you only need the new 
driver). Then we can add a
depends on !PINCTRL_EXYNOS5250
for CONFIG_S5P (we probably should have a different symbol for the GPIO 
driver though, maybe CONFIG_GPIO_S5P?).

Cheers,
Quentin
