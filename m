Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983B7C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 869B884832;
	Fri,  3 Jul 2026 13:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="FDTQIndU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87E6D84979; Fri,  3 Jul 2026 13:18:17 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2976F8469D
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAb5STHxeIdxVZdmIk++xQMnvfBiNXpl7EQKKwUlgHn6kc9C6peeik0aus9tqG3MSYL2FflOTNSDkWpYCWtWuuqPNBiUDsf0PPsDl8TwHpVx9ycIuuKNuqozXv33klgiHioTefBqYA1ThtzbS4kU40hRrTAIHj1L2ommGNkBUuedt4uufuyWMG7V8zdOLihAgeZsyER1kKw97KGvI5u0I8OSp9TEZsaMPHQLCBYq3djSXUBpS9Pon3/mU52OwXJp4/8aeOqTXPHJcpQU3Y95+VAV9jUQIEd4KZ1sz0UNGbIBsSgqanviW2IBcjaeHJVkqzfC75iCxPEGujkpI8H5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8cyzyDL857BL30+gJuUY3M2vBSaozrBdSysMB7cvKY=;
 b=LO+OgGnq5e+0p//lNJ/6SSlvYSZ323HAg0kK84eW+sofGuUegLXaW5FKmAgteA28ndTVKqGx5u1WR2Hf1ob5blIgUcf6YeMQiQDSrveQolhmZGzTDQY9wxd1p+4XRbymxVp6LpH7207FSx/QmD+XZ+gug+QQ/nz044WZXFrQv9tNFiCSsEcXxtK4lVf6NgTeBY3+eGzN0rYs4GHS95LLf8qzrWDYg0XLK1GREodoJzC+D9IrHJOhrdJnZaZ1EKPYBOBYxxDxvanzUxNEpemhzx95VzlQokYsGGH9C7kqWMvxSIbZg8pCx6JBis8Oc8Y5PwgV47b4Pf6GBabTXGgEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8cyzyDL857BL30+gJuUY3M2vBSaozrBdSysMB7cvKY=;
 b=FDTQIndUC4m3mWbXBn/6fA88LKQR5bf1gAcEx8HyxfmLy0/1RXK40pDffNfp+Uh1RohacA3eymVnFYmNUVQfiIdLLnuDldyQ60iU42/NOGlem/oD+2w422xmKzvRNalbw3jOdBRrt7PHeQhA2N1scT9M2Ez9r0iCgy05MOzKr1D8NSpefRPy+a8O4SpgVXtIsRHl+na4FK4SadZkKbO1bXoRsU/gfS0yuYcPOJIDumwBEU18ecCynQxacdatnZQN96oEVs3KDDWQGiX5ZVyah/TRPfTvFzhJr3QuLBK32NMCXz0AWG2MdVxFBfvROrfVvDYnou+attzvVic8wKze4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB10257.eurprd08.prod.outlook.com (2603:10a6:102:367::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 3 Jul 2026
 11:18:12 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:18:11 +0000
Message-ID: <028d33d7-ba0f-4c6f-9c7c-a1757d5edb39@iopsys.eu>
Date: Fri, 3 Jul 2026 14:18:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/18] bitfield: Add less-checking __FIELD_{GET,PREP}()
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
 <20260702055744.2164975-3-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszTg4ZuiEdQkfTZcomtcWxSN+f1CKvE+Hikk+EHWghPaKYg@mail.gmail.com>
 <20260702135918.GW749385@bill-the-cat>
 <0c01810a-8a14-4c9a-9599-38b135c7b7e1@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <0c01810a-8a14-4c9a-9599-38b135c7b7e1@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0063.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::27) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB10257:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a7c318-04b8-4045-b64e-08ded8f4c4ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|7416014|4143699003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wPOK7zKfAtJ0//U/7Z/LueccJDjCvfg4op/O36aATbOO53c+yiphp/s9MTBe3FuBazKv/mAPJLjzdFHiBzoBiwxNFm43RICyljmeFZGZdZY41TS5rA03/X/PELLczBQ8RIOj/CW7fWyM+69rg9AwEcXGa/sqK3PGRrZ2bZRGR2x+HTKtzdVWMmVLSRDoL6q4x8X1CRdgM7qeEZG28xeqga1Lox/ERwyce6Is6x/epBGpaT6cd8E7ssMo5OIZ4FzhMpmjt4EAYu5HC4pXkKTioPhTT4TkVCRM2S73OldO1LjQPsgkLKv3X+gHUJf2HlWd4x/16ixl3T2KA8s+S+3FIaQpZHGjYEyWHLYS4EofjIJPkBQBs7AngPqBRNcMi+sS74ruLIyU41nPWu+E2Vno0DlJuZHaQ0FEDVJfxxTzQRoY71lLw6huGrvil69QSiIzWZ6wqXHlvzuNgvZ6pswfTdHgDCSjW5el2ZHJQLdKYnL8DXODVeFWNWF59icgfpPnkMqPwxKNR0B9WP3n+zYyegoHk132JTjvre5I2jQ7JC1k/3LE/95l4zLEvRCbsMXt5RYwZFz7Y7V3+Mpr1py9pcqQhfMKZ4QxBSF8TOoVzYh+knp4WgKJuxuLWPluWu9vIYopynKV31QkmhokaBexprdrrbIEqd+geltwK86Y3U4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(7416014)(4143699003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0ZiQmxTbGl4MXdMblg1YlhEdnZVeVhlOE5EVVAwbU5ycTFURi9OdExWZlB5?=
 =?utf-8?B?UU1RLzh4ajluNmxMYktyTVZpVmU2aVRYbHpiV3NHTjRrSUE3S3M0MkQ5ci9Z?=
 =?utf-8?B?OWthSzdheHpCU1kyQ3B1OTlNNzFPeTJtQTIvN0FaNlBDRm9jM3NuVEV3S1RY?=
 =?utf-8?B?WXV0SXdoNTVYMmdCaU5zL245RWNvK0haVG0wMDFlT3lBOVdaUTBIQ252Ykly?=
 =?utf-8?B?ZHFFeEw2M1JhWFpHK0w0ajZTeTBXMUl4Q2U0N3dkTWxqLzl3TTFNTVVycmFY?=
 =?utf-8?B?dDdCOUNQOEZleFhPL2tSb2dTOWFZbk5LUFZkVzlHZVRqVkJYMG1Fa3VMa2ZD?=
 =?utf-8?B?N09mSTFMTWtETVAybUdkUzFBOExTMzByZnB4WmYvRnE1UnhFZ1E4MGI3QlFS?=
 =?utf-8?B?ZGxFbnh3bTg4aTBQVW45T1p1aWtRRGRwVmNydnplY256SUNieEw1THcrVHE0?=
 =?utf-8?B?alFLODhxM3dPbCtwQWVub1IrS1FvYUMzRUx1MEVjckJvelVFWVAvR2J2TzRH?=
 =?utf-8?B?dW5uNGpTMWx3NHJHdmJqdFh2azZpbllmbWpZMllkRXJqZGhrQWp2U1kyZm9K?=
 =?utf-8?B?Q1pMTnBtMWtOb0ZRK01VQUI4RXFYdXB1bGxiVCt4aHlUUDhwekNKOWtKQzJZ?=
 =?utf-8?B?cDRkakZtTitEOHRBdVg4N0V2cTVOdWE2ajloN3dhSnZSWE83OHhhYTJ0dEcy?=
 =?utf-8?B?MXVxRDhnVzFxUzZTdktXSmV1S1piZGdkZThHdWVwb25MZWdnbVJ0K1ZOSzhw?=
 =?utf-8?B?T3RXL3g3QjQ5enlLWjA5UjZUS25heW9wb0Uxc3RRbG52K25CN2VYUVJzc1FX?=
 =?utf-8?B?RGRUL2J4ZWpHVkNqd3N0eHhJYVY4SDFOd2treFczY0wwNzJSNGtzWFd2Z3I3?=
 =?utf-8?B?eFhRdG5nSUNzUXk1V0tRM29oN3kyK2hwenFjQUhqV1B0c3FSd1pCeEdIdmRY?=
 =?utf-8?B?QkI1aDZ5VTlvejNFUGNzTSs2cnZMYjlqVW5lQktSc0Z4Qm1yY0RvL0oyUVFO?=
 =?utf-8?B?ZmdSTFk4WS9QM0p2aDZsOXBYYnhZSDN6b2M5K3A1VnlNWGcvTzZPWmd5T3Iv?=
 =?utf-8?B?ais4Z0FNYjZJRmpzM05HNldYamdubytSc2NzbVVRYUtZQjJBM1hicGF4T0JK?=
 =?utf-8?B?SjRqNkk1cHBZejd4WGNyL2cveHlwbTJ6SkpiLzdtMFc1UjEvT25SOC9RZUdG?=
 =?utf-8?B?eEsvU3REaEkxMGorOHlzcjdqNWh3RXJqVEYyYTdKVHloWW1wT2hBSlYxbmNx?=
 =?utf-8?B?THlnMXhidjhMSTZGRCtuN0Y2M0lMcnBESis3c2VVM3RNTmY3ZUVLWllBWE84?=
 =?utf-8?B?a0J1MVl4alBrME0wczl6WTNuM2JyM3hCTFV1ZG04Y3NlTDNuWjJieWZ1cUsz?=
 =?utf-8?B?YUhSMVI5UTJycDN2ZXF4UWQyVW02Z2lIZ2c0cHB5TVlRUnpuSGZ5c2NhMnZ6?=
 =?utf-8?B?WXRSSUhQVjUwY0wvd2xVZUd6RjhXd0t3c3NLRnh2aC9rYU10STBqYXpOby9H?=
 =?utf-8?B?YW5VejlOdSsyZWV1aWZWbHRnbVpNMy9yMS9FNU40MDJrTE4weXZSbnhQTHNs?=
 =?utf-8?B?Wk1Kdm12T0duZzBDTDNTQUdlcEJyNVYwZUtXOVNpNUZnejJCcnF4clloVkVq?=
 =?utf-8?B?SGZ3WWFMSmtrdVhXUDJPUHZpalh2WHprQ1pMMzdOSUR0MVdySHF4R21YRkRE?=
 =?utf-8?B?d1JCbzBBV3k4V3VrRit3a3N3eC9NV0lhRk9DRzN5RUxqUXRQWVlxY2VmaFhm?=
 =?utf-8?B?dUduVTUzSmxtTnUraHlocEFiK00vY2wzeGIzODE0Z3V0MUE3Q0lvZFlHMTVI?=
 =?utf-8?B?MExORUZGUjdpRUZUdHVHYXNTa3BKdmlDdzZERGI3c2JTSEttTHoybjZtb0Vi?=
 =?utf-8?B?bjFwVGp5V0JqWndyNGdXUkw5QzFFUTJ1UVJTRjU5WC9xQU9KL2NzVDBTMGhu?=
 =?utf-8?B?RXdNQmpxOFNCb0tJMVRvbzllSzRQVnFrcHZtOXluakpEbndxc3hBWnFNaG5Y?=
 =?utf-8?B?RW0xNXJrKzgzWGFwUU5TV0trcjBEL0szbXdIaXh4MEx6QnY2ckJQNGt2dnVR?=
 =?utf-8?B?R1BCOTNaellsZEJVT0tNaXcwYW5CUTcxSjlydmZDeCs1RXdyNVNmRGZRQWJD?=
 =?utf-8?B?Sllqb3c2ZFVzWjZnU1ZEUFpPUDBxaElXS2pONUtTSVAwRFVkdXhQWUdTYXBH?=
 =?utf-8?B?UkxCeTJDNXVSbFZXazFENXBlMmlRSFhsc25BS3N2Y3BnYTVaMHZ2WE9ERmIz?=
 =?utf-8?B?OWxSN2lPMGZWalBqUGhNVDhVQVQ5WS9xa3IzWXlvUmFCazZaY0xPdERuK1pz?=
 =?utf-8?B?RU82N2E0NlY5VnFDK2VacGl0VlNsTTJCQmtiWVcvU2IxNTlaUDhzczk2ZWto?=
 =?utf-8?Q?QMp9hczYYQ/O3KcA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a7c318-04b8-4045-b64e-08ded8f4c4ac
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:18:11.8252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2L7hY82If/43f0sE+PXJfPE1GSmWTy2t9aRSCjod6Dz22oF9FvuEWtidK0FqwdR/+Fu45a+9FAqPFOqLw7oOdutYlMy8HUQt81WSnJcC3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10257
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


On 7/3/26 14:07, Mikhail Kshevetskiy wrote:
> On 7/2/26 16:59, Tom Rini wrote:
>> On Thu, Jul 02, 2026 at 11:53:05AM +0100, Simon Glass wrote:
>>> Hi Mikhail,
>>>
>>> On 2026-07-02T05:57:27, Mikhail Kshevetskiy
>>> <mikhail.kshevetskiy@iopsys.eu> wrote:
>>>> bitfield: Add less-checking __FIELD_{GET,PREP}()
>>>>
>>>> The BUILD_BUG_ON_MSG() check against '~0ull' works only with "unsigned
>>>> (long) long" _mask types.  For constant masks, that condition is usually
>>>> met, as GENMASK() yields an UL value.  The few places where the
>>>> constant mask is stored in an intermediate variable were fixed by
>>>> changing the variable type to u64 (see e.g. [1] and [2]).
>>>>
>>>> However, for non-constant masks, smaller unsigned types should be valid,
>>>> too, but currently lead to "result of comparison of constant
>>>> 18446744073709551615 with expression of type ... is always
>>>> false"-warnings with clang and W=1.
>>>>
>>>> Hence refactor the __BF_FIELD_CHECK() helper, and factor out
>>>> __FIELD_{GET,PREP}().  The later lack the single problematic check, but
>>>> are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
>>>> used in the fully non-const variants later.
>>>>
>>>> [1] commit 5c667d5a5a3ec166 ("clk: sp7021: Adjust width of _m in
>>>>     HWM_FIELD_PREP()")
>>>> [...]
>>>>
>>>> include/linux/bitfield.h | 36 ++++++++++++++++++++++++++++--------
>>>>  1 file changed, 28 insertions(+), 8 deletions(-)
>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]
>>>> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>>>> Reviewed-by: David Lechner <dlechner@baylibre.com>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>
>>> Please can you add your own Signed-off-by at the end of the chain?
>>>
>>> It's a bit confusing that you seem to refer to Linux commit hashes in
>>> the commit. So maybe this should have a Cherry-picked-from: line
>>> indicating it came from Linux?
>> We don't use Cherry-picked-from (does anything?), we just mention what
>> the upstream commit was.
> There are several commits where something similar were used:
>
> 86a720aafce5b2 ("mtd: Introduce mtd_block_isreserved()")
> [scottwood: Cherry-picked from Linux 8471bb73ba10ed67]
> Signed-off-by: Scott Wood <scottwood@freescale.com>
>
> 88f95bbadda89b ("libfdt: Add fdt_next_subnode() to permit easy subnode
> iteration")
> (Cherry-picked from dtc commit 4e76ec79)
> Acked-by: Gerald Van Baren <vanbaren@cideas.com>
>
> c9fbe861a2fc1c ("arm64: dts: allwinner: h616: Add r_i2c pinctrl nodes")
> (cherry-picked from commit 1665557aa57c2140d014d68dfe1a1f92f9baac82)
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>
> 13f3b04f61aa6a ("mtd: add mtd_ooblayout_xxx() helper functions")
> [Linux commit: 75eb2cec251fda33c9bb716ecc372819abb9278a]
> [masahiro: cherry-pick more code from
> adbbc3bc827eb1f43a932d783f09ba55c8ec8379]
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> 1fb87de83dd6e7 ("mtd: nand: Support controllers with custom page")
> [Linux commit: 3371d663bb4579f1b2003a92162edd6d90edd089]
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> and so on
I think we need some policy about cherry-picked commits. It should include:
* who should be an author of cherry-picked commits
* should or should not be original  Signed-off-by/Reviewed-by/Acked-by
be kept * how original commit should be referred
