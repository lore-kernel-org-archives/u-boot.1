Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9A3EDA687
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 15:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28433839DF;
	Tue,  3 Mar 2026 16:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="AJVDEzX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A43A983E7F; Tue,  3 Mar 2026 16:25:16 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C5A6838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 16:25:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0DSvVSLf4cHWV8XMEuUijZya9pF4jcRHIhfV3N3bunWg9kiy7uX2uIK3oelVYCsGBaeqbIGwe4CJOC5CrW2Lo2rZWOmdmixM7i1Ht2fcduZCAHYyNet+N1K1YwahtPbohon1s0Iho7weK8VFH8eDcFeVd3DKP5tkNPXutqvWJxk6KoC5GoWohaN2PY7RbyKnd5t15zh3G6XTAbui1/QpawQ14DieMyi7mvSywbrJkaYVUK+hLjWfK8zYk3k5NOZXcC57W2dvvA54D8WklRr7CDaZOog60RTxqLG2AdPuP3D+nUOQ5qa5lPY1mfRvU66jY7aKr3/v6zkdiwszusEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI5mCyjIgfeQlpAQ0kvSSU17m9qa2PI40w2PyUUaK9Y=;
 b=MAPeWRY5H36xyYTalgvj5x/h1TlY/wbSteoC6UaTOU7ZiWBHOZ2Gm3u+UtovlnSaMMt1QjqusXnMZf68+UCx11rKEMQcKUiPxk7gGsygIpw4QzDpxmJiIctF/G24JDw57yhDDHmxo8m9CdJjQAkAKkTdYFC1+YbjHm/TOMg5+1ANBhlT9SFpt3Do3+Qjltm4p9CJFyFv1A1iHx7vgqx+GeKW0W24ygE18a1rjOS9ZskTdBLVUpoX87wumirn8OgvjCEGhk150HSDvTaKM8ZidB9DY3kN9MYUwZ6WPYkTaZtSLvZuLDgeZx41dg838u1GQq0HOLWbJcx5gPGL5W3HFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI5mCyjIgfeQlpAQ0kvSSU17m9qa2PI40w2PyUUaK9Y=;
 b=AJVDEzX7tWIV173pvkcDwa/1yw/FJYNb7WgWiTHIKy/sjElyV0pFd0z5wudazG0qK0tW+LTLL0VJvTQzT71mzTSWdW+GbnWD8Z/kxdRRXVMrgwyPH+75dA4aBEHobAEyQaAxVpH6fie7/g3QQ581OGYK29esVAgO/IDU9d25S4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB8182.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 15:25:11 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 15:25:11 +0000
Message-ID: <9e0f6e50-3d72-4186-8f7d-86938ea1f8a4@cherry.de>
Date: Tue, 3 Mar 2026 16:25:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/16] binman: test: Move vendor-specific test files
 to test/vendor/
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alice Guo <alice.guo@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-14-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-14-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0158.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bff220f-8ea2-4e8a-8acb-08de79390f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: xLRCz5md3AE5Oz+pinwQs9KtxDLtkRjd10/wajYFnx8dvMBjnEKVYKkARebyWRWwm7zjJlDtO5Azmd/HZc0ZsGVHvDvTiLFHvRLQXZhCxLHGCZDK2YaA3VNCJuGBWEF+Zpx7s3yWKmlVZqxx7JzlMIyrouZkH1YEcF4pUNaSqnT4UqiPimIfetbqD2VexJy0i/ZCzLJHXFpdZfSTB7TBNDINKep0k7pZTQRih0dekiAq0KOVzMlmai/+eion/syQl77CuuZD3zg3mCucfvCDsub4ItY+hwqcjAo0lZ51SawEiRBeOPjbAH6MjBGsga/7c3NzxAe5l/RBWGJcL0lqfTF1xeISuHA7/S2zdEn0KyRCe9212/C5f7yBcNshSh4UpqebzD8z7MGs7/AkQIn5k27ZV9Glvp7Hn3oKX/RDS8whFzk7CjOnrzmalwijqa8+XKDJA7C0RQaYz6+8Zw9DOJD8yb33+3h3bAEjN/dcXx7o1oQmZr4KY9h+jr1v9rtAx8T+nPT/Z/GtB078oebuBIXCI1OcyihZUF44M2Rlq+5y3MdgEFoEvrsmCnRJOP2Sh+4DqZWPPesacX1xDpSlHNo4gL6xeChJvspnfLRcSLGYaL5KlmNQXNZxzjFViWFQLvLoRMx1Y4upr1Hj4Ajkalm1mGkDc6YWb+2eXV9UXYuX9om7D/UHRX9jtg859yzKhFrc/TUlfJdboY/Q8tXuHuGWbVEbTGqzcJX6RaZaxiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azZYTHpKZmVyamdBM0ZVaWoySWpwWE4ycmVjV0s3Z0FjbGl0d0ZQcnRzYXV1?=
 =?utf-8?B?dmdLWXV2TVMrKzlIRU1JS2JqWE9WZUpnTkdTSFlGME9rcXVoaUl0SDFiTDRL?=
 =?utf-8?B?a3R3NUlxc2RubzFaRjFQU0E0QTlNSm9BMFNLNC9haG1mUWx5bzBsZzhGU0Ux?=
 =?utf-8?B?a2pKWFNPeS9WTVk0VkpTRHlZMlI1NytwejFDd1hsaGlPWHBlcytlbmthQ3pJ?=
 =?utf-8?B?WXkyalQrRTFNekRLaVptSkM5UTllOXlITGQzQ2Q4bTVZcVREb3NGakpoUjR3?=
 =?utf-8?B?cmd4eXdoTHZUOXVLbWRMYkZyVVhINC9HcDBIVmFEUk1mdHpta3Y0UHlMZEtm?=
 =?utf-8?B?T3Uva0RtbUdaNFpsQUZQc08wTXVESzQyZVJiS005S2xoVFlYbU1oUVZqTUov?=
 =?utf-8?B?cU9rblE0S3U1Y1RYdVA2UlVaZmszdjNER2QzVEhaRVQwSWorVTI1ZzF4cUlW?=
 =?utf-8?B?bC9sK3RKdUNrUEtmbEpyRERtTFV2aXJmMEFDNW92TUdhSk5mdnBxRkQvdG9J?=
 =?utf-8?B?N3lEYW5hSStoT3ErRFdCbW41RTRrQXBlV0xCbVRBVWZsR3YvNSs0dG1aM0Zn?=
 =?utf-8?B?SnBhU2tJT01DWUU0QTNGNVJaQ1g0dmhmcE1VYkRLOW8yTThYK2VUUGR3c0Z2?=
 =?utf-8?B?ZURkZGNXM1ZrRmpIN2x5YnFaU0ZpM3diMVZtZjIvNVpsTUo0ZjRZMDkxL2ps?=
 =?utf-8?B?UUhIODdmeG02OXo5dWZqQmVtTTJFK1pGWERYSGJZblZSREE2YVNvOER0OEt5?=
 =?utf-8?B?ekt0b2l2eTljS0kxNEp5ODUrcStwWitTb001NXo1Vnhka3BQZHdRUGZac0ZB?=
 =?utf-8?B?YTE2b2RIazVtMFo1aTBjSzdYRG8yYll5dkw0eFJRTDRaekZNcllSV0tkY0Rj?=
 =?utf-8?B?UUNFT2FkV2tHc2UzWFdDMzJCM0g3cjZOTUtWMENYOFI3VDFDN0J3ZmFRYW5y?=
 =?utf-8?B?VnQ0RXhaK0pEZGx4OUlkT0MrbjcvSFNBUklOOEoybFQrQlAzd1NCMFNTSFpO?=
 =?utf-8?B?OThSQ2xVRit2N3V0b1dBeTNSQW50UTNaQmVGVm9RWTlxY09wWjZBVHVBTGpj?=
 =?utf-8?B?NTJFSkdzQ25tME9zbWpycG9UdFdWSk5QQXAyZ3EwUU1hQXl2dytEQW14SFhG?=
 =?utf-8?B?OXp5cXA5aEtOZ084Q2lpRXZJRXBoamp6NGdoSUhwUWM1OHl4SlVnM3ZsWU9p?=
 =?utf-8?B?L2RheUlXQzZHMDEwQmgrY1JyaVpLR2lpTmFkcGFtL0dpRXVtVXAxQXRCaHcw?=
 =?utf-8?B?RTc1eUdEM0greUR3dVZBcVBzMGlJeGhkS2owVFEzVzl2OU9vMThKTWwwNjF5?=
 =?utf-8?B?bUhMNjR2SUtuRFhLem5MMGFjbkRDanYrb0I4MzU3QnFQYXZTU0NoVTlCQkN6?=
 =?utf-8?B?MnFCTGkySWJIYWM2dThHbFdUcjBZUmd5dFlyZjlCSFF0UTdMRkxteDNXUm5K?=
 =?utf-8?B?cFBEZHVYa0VMWUk5cmNNQmQ0ZzBud2l0WFFMMFJnMWhkTnM0aXM2MGtRSW1y?=
 =?utf-8?B?TjBhUm1uRjlZWk5ZZG8yNkFzdXJQVVAxckJydTJ3WWtGdTR3bHRYQWRTcThI?=
 =?utf-8?B?Z2hDNS9rUHJvT1lQb3ZibHFHWEN1VFFLZDl4VjR6UjhPVVkxd0xTT2lZS2Vp?=
 =?utf-8?B?ZnJRTXhuQ3c5QnhEcFBkQkFqcFhBNGdXTHNwT0c5QWhVWkUwemM2c0xaYzR3?=
 =?utf-8?B?YnoxUG9rVU56NGpIcUNIdy96K3ZwK0Y1bEk5WGJDcFNONTZCL0Z4UUp0VFZG?=
 =?utf-8?B?aWwrM2FnNVNZY0JpSFYzS3ViVCtvUEtnakdrL1J4bk9aYmxIT0VVZGRsMUlY?=
 =?utf-8?B?ZFNjOXhTS1h0Qm5wWDdNVktGZnk0SnU5SzkyVk4vMzNYNHlCS1VEQ2hlb0ZH?=
 =?utf-8?B?R0ZRa0hVN09WS3czYlUxdVFGYTMvSjZDQXd2c3FDVTRIMWh0RTNoaUlVNTJj?=
 =?utf-8?B?Wi9QRklZWmxDMjQ0SC8xcGhNOVFXaFhpNkY2WXZBRnBibWpBeHBEMkR1Z1BO?=
 =?utf-8?B?RFJjVHZ3MlRYQWYzK1VaYzZGR1p1bmZjOUV0dEo0L1RtZ2hMSmdlR0I3WVNY?=
 =?utf-8?B?cmwwajNobjdFK2hYNGVxcVQwdDRkT2ZNQSs1bWhXN0QyTzhzWTFjZE1QWFQ3?=
 =?utf-8?B?ZUVrWGJyMjZ6ZEdxbnFxVnNVOGd6K0Q0Ky9sS1IrQUhBS0ZmdDBXNi9WbEFE?=
 =?utf-8?B?bFNId3F1d3hxL2VjUWIyUExaclV2dDFQQUFuUmtzWHRyUXZ1akN6VFBmVXlM?=
 =?utf-8?B?bElmUlRlTHJ4UUpQTmFDTUJkMWJ0ckl2U3dtRFBjSUUzWkFmY0Q4TXhRT3Jy?=
 =?utf-8?B?Uzlkd24xbXNNaWM1S1JqZ0dXNnlBT0wxWXFFSTJXMHNrbVhoN2R6dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bff220f-8ea2-4e8a-8acb-08de79390f78
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 15:25:11.3782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYB9TQqdFioz1HMp0huwpk9Xt3eobs6wfKPvTRVV2ua4WQULl2Y4D9uRFSpn07zWgLglRfgsJ+C1GgaB/YP5eDtZWKOFIul5SBul6kHD0ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8182
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

Hi Simon,

On 2/27/26 12:47 AM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Move about 20 test files for vendor-specific platform support (TI, NXP
> i.MX, Renesas R-Car, Rockchip, PowerPC MPC85xx) into a vendor/
> subdirectory. Drop the numeric prefixes and update all references.
> 

What about config.yaml, schema.yaml, schema_notype.yaml

Separate patch is fine.

I'm wondering if we shouldn't go for vendor-specific directories, e.g. 
instead of vendor/ti_*.dts, have ti/*.dts.

> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
> 
>   doc/develop/binman_tests.rst                  |  8 +--
>   tools/binman/ftest.py                         | 56 +++++++++----------
>   .../nxp_ddrfw_imx95.dts}                      |  0
>   .../{339_nxp_imx8.dts => vendor/nxp_imx8.dts} |  0
>   .../nxp_imx8_csf.dts}                         |  0
>   .../nxp_imx8_csf_fast_auth.dts}               |  0
>   .../nxp_imx8_imagename.dts}                   |  0
>   .../nxp_imx95.dts}                            |  0
>   .../powerpc_mpc85xx_bootpg_resetvec.dts}      |  0
>   .../renesas_rcar4_sa0.dts}                    |  0
>   .../renesas_rcar4_sa0_size.dts}               |  0
>   .../rockchip_tpl.dts}                         |  0
>   .../ti_board_cfg.dts}                         |  0
>   .../ti_board_cfg_combined.dts}                |  0
>   .../ti_board_cfg_no_type.dts}                 |  0
>   .../ti_board_cfg_phony.dts}                   |  0
>   .../test/{351_ti_dm.dts => vendor/ti_dm.dts}  |  0
>   .../ti_secure.dts}                            |  0
>   .../ti_secure_firewall.dts}                   |  0
>   .../ti_secure_firewall_missing_property.dts}  |  0
>   .../ti_secure_rom.dts}                        |  0
>   .../ti_secure_rom_a.dts}                      |  0
>   .../ti_secure_rom_b.dts}                      |  0
>   .../ti_secure_rom_combined.dts}               |  0
>   24 files changed, 32 insertions(+), 32 deletions(-)
>   rename tools/binman/test/{353_nxp_ddrfw_imx95.dts => vendor/nxp_ddrfw_imx95.dts} (100%)

This also depends on 
https://lore.kernel.org/u-boot/20260225225040.2568118-1-sjg@chromium.org/.

>   rename tools/binman/test/{339_nxp_imx8.dts => vendor/nxp_imx8.dts} (100%)
>   rename tools/binman/test/{364_nxp_imx8_csf.dts => vendor/nxp_imx8_csf.dts} (100%)
>   rename tools/binman/test/{365_nxp_imx8_csf_fast_auth.dts => vendor/nxp_imx8_csf_fast_auth.dts} (100%)
>   rename tools/binman/test/{366_nxp_imx8_imagename.dts => vendor/nxp_imx8_imagename.dts} (100%)
>   rename tools/binman/test/{359_nxp_imx95.dts => vendor/nxp_imx95.dts} (100%)
>   rename tools/binman/test/{150_powerpc_mpc85xx_bootpg_resetvec.dts => vendor/powerpc_mpc85xx_bootpg_resetvec.dts} (100%)
>   rename tools/binman/test/{357_renesas_rcar4_sa0.dts => vendor/renesas_rcar4_sa0.dts} (100%)
>   rename tools/binman/test/{358_renesas_rcar4_sa0_size.dts => vendor/renesas_rcar4_sa0_size.dts} (100%)
>   rename tools/binman/test/{291_rockchip_tpl.dts => vendor/rockchip_tpl.dts} (100%)
>   rename tools/binman/test/{293_ti_board_cfg.dts => vendor/ti_board_cfg.dts} (100%)
>   rename tools/binman/test/{294_ti_board_cfg_combined.dts => vendor/ti_board_cfg_combined.dts} (100%)
>   rename tools/binman/test/{295_ti_board_cfg_no_type.dts => vendor/ti_board_cfg_no_type.dts} (100%)
>   rename tools/binman/test/{352_ti_board_cfg_phony.dts => vendor/ti_board_cfg_phony.dts} (100%)
>   rename tools/binman/test/{351_ti_dm.dts => vendor/ti_dm.dts} (100%)
>   rename tools/binman/test/{296_ti_secure.dts => vendor/ti_secure.dts} (100%)
>   rename tools/binman/test/{324_ti_secure_firewall.dts => vendor/ti_secure_firewall.dts} (100%)
>   rename tools/binman/test/{325_ti_secure_firewall_missing_property.dts => vendor/ti_secure_firewall_missing_property.dts} (100%)
>   rename tools/binman/test/{297_ti_secure_rom.dts => vendor/ti_secure_rom.dts} (100%)
>   rename tools/binman/test/{299_ti_secure_rom_a.dts => vendor/ti_secure_rom_a.dts} (100%)
>   rename tools/binman/test/{300_ti_secure_rom_b.dts => vendor/ti_secure_rom_b.dts} (100%)
>   rename tools/binman/test/{298_ti_secure_rom_combined.dts => vendor/ti_secure_rom_combined.dts} (100%)
> 
> diff --git a/doc/develop/binman_tests.rst b/doc/develop/binman_tests.rst
> index c7fa9ae6199..2bdb7756465 100644
> --- a/doc/develop/binman_tests.rst
> +++ b/doc/develop/binman_tests.rst
> @@ -457,7 +457,7 @@ can, which contains the new etype. Put it in a numbered file in
>   ``tool/binman/test`` so that it comes last. All the numbers are unique and there
>   are no gaps.
>   
> -Example from ``tools/binman/test/339_nxp_imx8.dts``:
> +Example from ``tools/binman/test/vendor/nxp_imx8.dts``:
>   
>   .. code-block:: devicetree
>   

We could also do

.. literalinclude:: ../../../tools/binman/test/vendor/nxp_imx8.dts
    :language: devicetree

To make sure it's never outdated (not tested). In a separate patch though.

Cheers,
Quentin
