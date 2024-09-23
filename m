Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0C4CF9C5B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 02:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF2E588AFF;
	Tue, 24 Sep 2024 04:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="XFIcZ0dO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A388288A74; Mon, 23 Sep 2024 19:36:46 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12olkn20809.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2805::809])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06C7188A0E
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 19:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGJYnPacrZmjPtXsohgDyNcQnLOjPzniSRB0Z001rFTe7fX3T8eECBxZ9ZqgU7JH7MDq97Yqq407xBxFjdErnLL9D7Xzm8BHgyBsgVHVspC0UEUla4ehwdXVnxLSE6PfanBR241NmcJXJyshVD50MrUWvQIY08JkAS7w+WkjT0pGBgla/I87WMvBFKhDD11bvWlih7weoAipnrPqui+8Si/sQSqrSIuwwtU0t6P0KPHJkhr2OI62CxHn82DL0/vkqZ5ejR5YmvQcYNwqmma+UKuDa9ogtxh+FkMYFO+BsyNEkAIuCshM2C6z8YVAIK8dcpOPUZRMp0SgNbpzxVw5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaUfc/Nj48BDm67+yetxXHfa9z2dcTzOP61a5k4Hh38=;
 b=BgPA6S6kOgRLYTlVqIjNqxNzuqQzIZUefXS2XI+Y6LgNIeEl6QKNs5u5J1CXdsRwPRfiDDytXqpcAyK+pbgX7zHTjR+zkIP4bpjsTRhAqkKEpxtm0y88J56NatDHrJ6NW1br0lOYRt/kl6fYImylIY837QdMEab3BfgoNbex5z+tG1h43rD7pQbsr43evO6dqQKjm5594iOU5+YaorzJrd3+66YuhsSIPTxs7obvYlnWEetx9fX0DWyIQ/bHEgv/Gk/vNpDTcaGIuPvtbLbq2nydwx9Zf/enueq0r3gk4LciXE7lpxrR25hZxyc+Q4bnpeHjKqXCfd4QbmvISeqe1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaUfc/Nj48BDm67+yetxXHfa9z2dcTzOP61a5k4Hh38=;
 b=XFIcZ0dOGORv9b0Ql/NJS+r4kkCOfJpk7+ogpNP17UVs5G5ofpXbDFNmCWQsSSPoUfAoe0XC6MBim8mbxU4VWvoDAM5GmTs1MjCnLcPQuTSPZi/3gcXFn49EvX7IA2vrwdE27zO1MDOHQRzIB4Gl9xRcQ0Ih4FasxmJ/FhPOmZH8e4ZIdJw5Bz5jeIUrvyRg5r0UZ92uiqalOSQ8VlFKWsNDB+uBPTHNPIml2UWHS7lGumMx2b4UH3s10HJClBfbVFcDgfyn7bwYcPcN+eO+hc9mqSajqgdrpKYhgFyH3qyPaUwQBZJZCah3aOaE/ARpGRXqC7u2SGMuVCjOGdPoVA==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by SJ0PR16MB5082.namprd16.prod.outlook.com (2603:10b6:a03:418::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 17:36:40 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 17:36:40 +0000
Date: Mon, 23 Sep 2024 12:36:33 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, dsimic@manjaro.org
Subject: Re: [PATCH V2 2/4] board: rockchip: Add vdd_cpu reg fixup for RGXX3
 Series
Message-ID: <MN2PR16MB2941DA215E7CDBFD7E3AF730A56F2@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240919140022.511067-1-macroalpha82@gmail.com>
 <20240919140022.511067-3-macroalpha82@gmail.com>
 <2a207719-e37c-4289-9470-2324928e24bc@cherry.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a207719-e37c-4289-9470-2324928e24bc@cherry.de>
X-ClientProxiedBy: SA9PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:806:22::18) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <ZvGnITzpkqkypaRO@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|SJ0PR16MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e173448-1ee8-45fc-95ef-08dcdbf647ab
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799006|15080799006|7092599003|461199028|19110799003|5072599009|6090799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: HNYXrIIgBwFs9Q38z+gJesjjMaia7y1qFT+8jpnylo3/KnsejJcOMGOyQstxwzn3e8af4StHXUHmLiQJqFI9S/XuplnrpWMB1AYFFt1mglEH/NTETtcgUDZb8Ib53livHnYcOgq5BEY4ES0LFUaNh685hayy1pxMRwQWJtwCmlUYGSHnecnUvv5csmzlUiP952ht0aBov7Y0n/rZ64oxuo4YFvQ0yZiHDyNkl3zyL9K4SsTlVZGNtSx1avnhhfIf2NRJ/9+lZ60FuMLH1EVBjC3aZ9IrIe8nL3//PhSnluIkt1YqG3xd0hZ8AusBkLtZljWGvXiLpND+ZK9hp70LTXxYZvlbrZf2gai1xsTo4goaRCmwcCI6ig8ajCm4cE4dMyTNOeMH9GbdXv1mHoUhHAf1bUDYoI64azJ4qkviysPhrH9Jn8Qk9D8Vx3AO5F3QO/YVGB06gqiLxeaMFrFFqAKgpDqj/OmsxK1oRIf6ZzKUJZhSxBZJdUsH/W9C9PNf7zKMe1bIF8P4p/DKE2OBFwQygOZ1kxzsGzDrixlwHFjHqzfWhh5PR+N5tOKkPZ60uxaUdrQxedG1fdB82T1l3/WVmeejZgKzYr4KW9ik1JX+tCXSujlHtozACmJcId7D1S61FB1K++QQy4xGp5spWeH2Tg1oc2/pse1fEoVRCe3uswrQr6aq8BCXZoVAPTgIYx8IT4EZBI4CJvcG4J3hR7zLxP25ukZ4//Pkw1uOQ1GA8sZTOrxfAO3VhUNcmNV/4tMbX2FfgiNeeELIT5PpDw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?45eimOCUg0vc/A/xs4SR1A52wFk5O8b5h3YD2s8rWGRtJsEbTYpDfnTK+BHN?=
 =?us-ascii?Q?+mtSlFjt1Y1AmIufu5F3nsFmJoW+VJdPrDPZorWJcEl7hbN9slNx4AXWn20U?=
 =?us-ascii?Q?U1VcMlB4XCdLp2O1Uzgl7Gop1DfeewyP29PbOCkfyGHELRW1PjNMe+Rfk5U1?=
 =?us-ascii?Q?H8KLvCNNh+jR4pGHSs4p++qF2KCRb5gbjqvvgbsFqDHUpl8D/SR8fDumwSyL?=
 =?us-ascii?Q?fVnFCR2HgJSQae8fNZa17sQnO07vuLlVN7bEomyYLJh1bzpRsWeR+rSGJjKA?=
 =?us-ascii?Q?bFXfyng8hXw2VzgpeUoBRzJxQD+R9RBlsNt2aaGP8xjTmQZYSegaeklqn5JO?=
 =?us-ascii?Q?c2qn42g+Fr75fDcxaLUo68lWh10KF/vo9e0SyjH6swoeI5WL0MF/DQRQ09mo?=
 =?us-ascii?Q?ga113CkMEf/xhn/wQ5wPsr0dR/i4u4u5UtbUX3t4U4mOoybPCG/mG7Qvg1yv?=
 =?us-ascii?Q?gVSkEEMshoQc10Z/BBXRO0kn1Ju+ThgJUIGDCKaXFZ8hQDhstYgayvNopc2i?=
 =?us-ascii?Q?p6FsdE6sqInGmWFJFVQ4dH9BCDU4JdATeArrgooC2EjyA3lxgj9MAMMn3Zt8?=
 =?us-ascii?Q?TlrOl9hQcSPGR17xxCSVpij5eIcfSHeY7MsXfbcDvprpCLdY8Jf9Z8e7jsE3?=
 =?us-ascii?Q?6ncLLFC2siUTu8dKhWY6l5hyKrETtWoIfDWMu49KYZnbcaG3XOtTEic4HWyy?=
 =?us-ascii?Q?jlgZOIgIBb1OdkP0k6NeWXh5zLUh55yXafJguX/lwrHpPthilWrGK/Hjynga?=
 =?us-ascii?Q?/77yKOZDHQmFTpLcEwXhpFyrsGonPczCdb0OlhPJSuxxPEyXeelivsir4EJ7?=
 =?us-ascii?Q?UPr/a8sMqUiA3Qz1r8r4capY93nfJIPQnmtznN2VjtMLTRvuS6FCum+Dwh9F?=
 =?us-ascii?Q?f3iNIRhKC8xnBLeo2bb2QGAftbrmOSLNfKEK7trXvJsk60Pv65Ffr1NG+BBK?=
 =?us-ascii?Q?s6X0fxN/WJH46jVaEuDGQWYI/h4qAdA7pTh9R1SJTYQNwvd+3J79CfcDvPEy?=
 =?us-ascii?Q?MqkIyz+T2xHl4sQWxpFwiSeg60mNnjfwotp3tp4nxFoAVDmvgmGpGzzoSh+B?=
 =?us-ascii?Q?enzhU1GjxMGDECYppssfqDwTmArOS11P+jNF2SuTHoSiLpjdag3NfNfwfRHZ?=
 =?us-ascii?Q?KQUkoq2m7Ozgzi1Px4qAE1ua8VhZgvgHMWGwWTpg1x1mJKIsES1XBJQhh/54?=
 =?us-ascii?Q?kLRC8h6iSAMCionsizTafJNJhhAv78ZVehMgmrKWoKHZHfLlmrOaXOB5gJ0B?=
 =?us-ascii?Q?6efaA1JSLZ4kC13p3Ii5nC1UOPb/Z3OUiKjYXjxXnw=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e173448-1ee8-45fc-95ef-08dcdbf647ab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 17:36:40.2218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR16MB5082
X-Mailman-Approved-At: Tue, 24 Sep 2024 04:13:40 +0200
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

On Mon, Sep 23, 2024 at 01:21:01PM +0200, Quentin Schulz wrote:
> Hi Chris,
> 
> On 9/19/24 4:00 PM, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Some of the Powkiddy devices switched to using a different vendor for
> > the vdd_cpu regulator. Unfortunately the device does not have a new
> > revision to denote this, so users have no way of knowing in advance.
> > 
> > Add code to detect if a device is present at addresses 0x1c or 0x40 on
> > the i2c0 bus and update the devicetree if needed.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 147 +++++++++++++++++++++
> >   1 file changed, 147 insertions(+)
> > 
> > diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > index 224019f9ba3..c1d1826fd14 100644
> > --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > @@ -43,6 +43,7 @@ struct rg3xx_model {
> >   	const char *board_name;
> >   	const char *fdtfile;
> >   	const bool detect_panel;
> > +	const bool detect_regulator;
> >   	const bool uart_con;
> >   };
> > @@ -69,6 +70,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> >   		/* Device is identical to RG353P. */
> >   		.fdtfile = DTB_DIR "rk3566-anbernic-rg353p.dtb",
> >   		.detect_panel = 1,
> > +		.detect_regulator = 0,
> >   		.uart_con = 1,
> >   	},
> >   	[RG353P] = {
> > @@ -77,6 +79,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> >   		.board_name = "Anbernic RG353P",
> >   		.fdtfile = DTB_DIR "rk3566-anbernic-rg353p.dtb",
> >   		.detect_panel = 1,
> > +		.detect_regulator = 0,
> >   		.uart_con = 1,
> >   	},
> >   	[RG353V] = {
> > @@ -85,6 +88,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> >   		.board_name = "Anbernic RG353V",
> >   		.fdtfile = DTB_DIR "rk3566-anbernic-rg353v.dtb",
> >   		.detect_panel = 1,
> > +		.detect_regulator = 0,
> >   		.uart_con = 1,
> >   	},
> >   	[RG503] = {
> > @@ -93,6 +97,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> >   		.board_name = "Anbernic RG503",
> >   		.fdtfile = DTB_DIR "rk3566-anbernic-rg503.dtb",
> >   		.detect_panel = 0,
> > +		.detect_regulator = 0,
> >   		.uart_con = 1,
> >   	},
> >   	[RGB30] = {
> > @@ -101,6 +106,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> >   		.board_name = "Powkiddy RGB30",
> >   		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb30.dtb",
> >   		.detect_panel = 0,
> > +		.detect_regulator = 1,
> >   		.uart_con = 0,
> >   	},
> >   	[RK2023] = {
> > @@ -109,6 +115,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> >   		.board_name = "Powkiddy RK2023",
> >   		.fdtfile = DTB_DIR "rk3566-powkiddy-rk2023.dtb",
> >   		.detect_panel = 0,
> > +		.detect_regulator = 1,
> >   		.uart_con = 0,
> >   	},
> >   	[RGARCD] = {
> > @@ -117,6 +124,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> >   		.board_name = "Anbernic RG ARC-D",
> >   		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-d.dtb",
> >   		.detect_panel = 0,
> > +		.detect_regulator = 0,
> >   		.uart_con = 1,
> >   	},
> >   	[RGB10MAX3] = {
> > @@ -125,6 +133,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> >   		.board_name = "Powkiddy RGB10MAX3",
> >   		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb10max3.dtb",
> >   		.detect_panel = 0,
> > +		.detect_regulator = 1,
> >   		.uart_con = 0,
> >   	},
> >   	/* Devices with duplicate ADC value */
> > @@ -134,6 +143,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> >   		.board_name = "Anbernic RG353PS",
> >   		.fdtfile = DTB_DIR "rk3566-anbernic-rg353ps.dtb",
> >   		.detect_panel = 1,
> > +		.detect_regulator = 0,
> >   		.uart_con = 1,
> >   	},
> >   	[RG353VS] = {
> > @@ -142,6 +152,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> >   		.board_name = "Anbernic RG353VS",
> >   		.fdtfile = DTB_DIR "rk3566-anbernic-rg353vs.dtb",
> >   		.detect_panel = 1,
> > +		.detect_regulator = 0,
> >   		.uart_con = 1,
> >   	},
> >   	[RGARCS] = {
> > @@ -150,6 +161,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> >   		.board_name = "Anbernic RG ARC-S",
> >   		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-s.dtb",
> >   		.detect_panel = 0,
> > +		.detect_regulator = 0,
> >   		.uart_con = 1,
> >   	},
> >   };
> > @@ -172,6 +184,22 @@ static const struct rg353_panel rg353_panel_details[] = {
> >   	},
> >   };
> > +struct powkiddy_regulators {
> > +	const u8 addr;
> > +	const char *regulator_compat;
> > +};
> > +
> > +static const struct powkiddy_regulators regulator_details[] = {
> > +	{
> > +		.addr = 0x1c,
> > +		.regulator_compat = "tcs,tcs4525",
> > +	},
> > +	{
> > +		.addr = 0x40,
> > +		.regulator_compat = "fcs,fan53555",
> > +	},
> > +};
> > +
> >   /*
> >    * Start LED very early so user knows device is on. Set color
> >    * to red.
> > @@ -361,6 +389,44 @@ int rgxx3_detect_display(void)
> >   	return 0;
> >   }
> > +/*
> > + * Some of the Powkiddy devices switched the CPU regulator, but users
> > + * are not able to determine this by looking at their hardware.
> > + * Attempt to auto-detect this situation and fixup the device-tree.
> > + */
> > +int rgxx3_detect_regulator(void)
> > +{
> > +	struct udevice *bus;
> > +	struct udevice *chip;
> > +	u8 val;
> > +	int ret;
> > +
> > +	/* Get the correct i2c bus (i2c0). */
> > +	ret = uclass_get_device_by_name(UCLASS_I2C,
> > +					"i2c@fdd40000", &bus);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Check for all vdd_cpu regulators and read an arbitrary
> > +	 * register to confirm it's present.
> > +	 */
> > +	for (int i = 0; i < ARRAY_SIZE(regulator_details); i++) {
> > +		ret = i2c_get_chip(bus, regulator_details[i].addr,
> > +				   1, &chip);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = dm_i2c_read(chip, 0, &val, 1);
> > +		if (!ret) {
> > +			env_set("vdd_cpu", regulator_details[i].regulator_compat);
> > +			break;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >   int rgxx3_read_board_id(void)
> >   {
> >   	u32 adc_info;
> > @@ -485,6 +551,16 @@ int rk_board_late_init(void)
> >   			printf("Failed to detect panel type\n");
> >   	}
> > +	/*
> > +	 * Skip vdd_cpu regulator detection if not needed. Warn but
> > +	 * don't fail for errors in auto-detection of regulator.
> > +	 */
> > +	if (rg3xx_model_details[gd->board_type].detect_regulator) {
> > +		ret = rgxx3_detect_regulator();
> > +		if (ret)
> > +			printf("Unable to detect vdd_cpu regulator\n");
> > +	}
> > +
> >   end:
> >   	/* Turn off red LED and turn on orange LED. */
> >   	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | GPIO_C6,
> > @@ -547,6 +623,71 @@ int rgxx3_panel_fixup(void *blob)
> >   	return 0;
> >   }
> > +int rgxx3_regulator_fixup(void *blob)
> > +{
> > +	const struct powkiddy_regulators *vdd_cpu = NULL;
> > +	int node, ret, i;
> > +	char path[] = "/i2c@fdd40000/regulator@00";
> > +	char name[] = "regulator@00";
> > +	char *env;
> > +
> > +	env = env_get("vdd_cpu");
> > +	if (!env) {
> > +		printf("Can't get vdd_cpu env\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/*
> > +	 * Find the device we have in our tree, which may or may not
> > +	 * be present.
> > +	 */
> > +	for (i = 0; i < ARRAY_SIZE(regulator_details); i++) {
> > +		sprintf(path, "/i2c@fdd40000/regulator@%02x",
> > +			regulator_details[i].addr);
> > +		node = fdt_path_offset(blob, path);
> > +		if (node > 0)
> > +			break;
> > +
> > +		printf("Unable to find vdd_cpu\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	node = fdt_path_offset(blob, path);
> > +	if (!(node > 0)) {
> > +		printf("Can't find the vdd_cpu node\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	ret = fdt_node_check_compatible(blob, node, env);
> > +	if (ret < 0)
> > +		return -ENODEV;
> > +
> > +	/* vdd_cpu regulators match, return 0. */
> > +	if (!ret)
> > +		return 0;
> > +
> > +	/* Regulators don't match, search by first compatible value. */
> > +	for (i = 0; i < ARRAY_SIZE(regulator_details); i++) {
> > +		if (!strcmp(env, regulator_details[i].regulator_compat)) {
> > +			vdd_cpu = &regulator_details[i];
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!vdd_cpu) {
> > +		printf("Unable to identify vdd_cpu by compat string\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	/* Set the compatible and reg with the auto-detected values */
> > +	fdt_setprop_string(blob, node, "compatible", vdd_cpu->regulator_compat);
> > +	fdt_setprop_u32(blob, node, "reg", vdd_cpu->addr);
> > +	sprintf(name, "regulator@%02x", vdd_cpu->addr);
> > +	fdt_set_name(blob, node, name);
> > +
> 
> I'm not sure this is viable in the long run... This relies on the properties
> for the two devices to be identical. Are we sure it is absolutely the case?

Yes, for the moment at least the devices are entirely identical except
for the CPU regulator. Unfortunately the identical ADC IDs is why I
cannot simply have an additional entry for a new hardware revision.

> 
> An option could be to have a DTSO for the "new" regulator that removes the
> old regulator entirely and we would simply be applying that DTSO at runtime
> before the kernel starts. I assume you probably want this for SPL or U-Boot
> proper as well so applying the DTSO there would be required as well, not
> sure how to do this though.

In truth I really don't need the regulator this way for U-Boot at all.
Near as I can tell it defaults to being on and the right voltage. I can
do a DTSO, I just figured a simple fixup would be easier (plus we're
already doing a fixup for a similar situation with panel revisions).

> 
> Can you please tell the HW vendor to have some way of detecting some
> variants of the HW instead of letting us just guess stuff? How do they even
> support this in their downstream kernel/bootloader????
> Have they already ran out of channels on SARADC?
> 

I have told both Powkiddy and Anbernic this. Whether they will listen
is a different matter. They haven't run out of channels on the SARADC
(except for the Powkiddy X55, which is its own board and has no
detection logic). In theory if we allow for a ~10% variance in the
resistor values for a resistor on ADC channel 1, and the range is
between 0 and 1024 (20 and 1004), that gives us about 49 total devices
we could "detect" at one time, assuming no one collides.

I have no idea how Powkiddy fixes up the CPU regulator, but I know
Anbernic does panel fixup with some hacky code in U-Boot and Linux
proper that detects for the panel like I do. In their case it's built
into the probe function of Rockchip's own "display-simple-dsi" driver.
In our case we detect the panel ID in U-Boot and then fixup the device
tree for Linux with the correct compatible.

> Cheers,
> Quentin

Thank you,
Chris
