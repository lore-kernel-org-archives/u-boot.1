Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFD8C48286
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 04:30:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA8587964;
	Tue,  6 Feb 2024 05:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="ubFKPKUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01D0287613; Tue,  6 Feb 2024 04:20:09 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d001::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9938486F8E
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 04:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLrhITNNz5BbxUmcrnKO8HccNoKyclRPHkWEQ7YSn2xU9JNwEhIW8jdmHyUZcVcmhMIDEWC6+LioZAKFZl1UT3HDELvJtNBuXHS9yPAR62PWSvtDF1fYPXgVs0XJA9x0mcmYDi8Ys5tIWf/70HZqCjPSvp1dm6Oq2uXdTY7lIFQKTE7vMww4e8khPYAEhv9y90R/yy2fXeaYUtH1hRnq/wvLJayIYBI8Vp1lT4NoK6KDip/RLhATICGY2ItlCb3poufeppWNfWZ27PyrfiFXhjYPTQR+Xl6BuKkJXV6Gwpki1pU/HceKH6HVm/s89E7ffs1BDhz2k2w6DRPBrBvtVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5Msk7jU61L2IC7vJtwldG271AeCiHX4z91JAsEDgT4=;
 b=IzmHfd7IeJULxXalKKxkSP3JoAZA9gaf/T629r9c1c2rIWGkEZ+6Cb2Tx9O86QJj2633LKxrXq111Hs8g+PSHZFSzOw6GLmWlR3eIcQNIxPXpjonIpY618mTF5NgxJal2REFb+7YF5g851lgT1t0l49qAn8chiz8cvwTa1bhINA2HVDj6kCSm/C8brfEzvTvVWtsYsHwmoPPawBOjtvp8aFjiqfusucyoOtne20I6srJNXqP/w+rSNdac2yh91nYXIZSTz20Mv4bKdmRs//dqPwDzKsK3wPIfxN3XlUMLAShvQBw1lH4j2nZ25/ecro4N/RTj33Q1BO3mnf8y7PcUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5Msk7jU61L2IC7vJtwldG271AeCiHX4z91JAsEDgT4=;
 b=ubFKPKUN67ZCn4FvomJHwYkvHInE0GCm6Hqh17gX4fhh47VRCJJztYYsyjxLPoBnlmD/ixCGiKrxJhQwAJe6KHJdLjx+Ft95cu2PZdkaNT3KOUMvKBMcGG7z+lYTo0dcnMUWXnWFR1FMM5x8qQgwe5VBL9oc1QN0jIkZd31QU8K4EXqcLXzp/fFZUC0cpaVx0xGs7MfqXWQP1pXEvQvJ6J2WyS2cgPJ0mUTWck+R0x17Fbu/ZoyEfDIyXIZM608mQmLXwo04DLTWz0uOsDf4MYLWK672gEdvtp7dsa4RooKxMN3v4YHz9V1rwI1DRpM+WL9tXBOm6IYdRyrCZsGLyw==
Received: from DM4PR05MB9229.namprd05.prod.outlook.com (2603:10b6:8:88::20) by
 SA0PR05MB7451.namprd05.prod.outlook.com (2603:10b6:806:b8::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Tue, 6 Feb 2024 03:20:03 +0000
Received: from DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::7592:72b0:48c8:ec43]) by DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::7592:72b0:48c8:ec43%5]) with mapi id 15.20.7249.032; Tue, 6 Feb 2024
 03:20:03 +0000
Date: Mon, 5 Feb 2024 21:20:01 -0600
From: Chris Morgan <macromorgan@hotmail.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org, jonas@kwiboo.se,
 jagan@amarulasolutions.com
Subject: Re: [PATCH 1/4] arm: dts: rockchip: rk3566: Remove unnecessary clks
 from rgxx3
Message-ID: <DM4PR05MB922989D3C8BC3E8965239A55A5462@DM4PR05MB9229.namprd05.prod.outlook.com>
References: <20240205185855.21508-1-macroalpha82@gmail.com>
 <20240205185855.21508-2-macroalpha82@gmail.com>
 <502f8fb5-667d-40f3-a1b3-8916883cb844@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <502f8fb5-667d-40f3-a1b3-8916883cb844@rock-chips.com>
X-TMN: [mpKcFOiKb2Zp6aMyotKDZooqNH0SLPgW]
X-ClientProxiedBy: DM6PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:5:40::43) To DM4PR05MB9229.namprd05.prod.outlook.com
 (2603:10b6:8:88::20)
X-Microsoft-Original-Message-ID: <ZcGlYRULp+cklmFt@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB9229:EE_|SA0PR05MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5ce169-20c6-43b7-ab81-08dc26c28228
X-MS-Exchange-SLBlob-MailProps: 9IecXKUgicByOPSJwOf10qQdVsmxHoSia4aCR79Tqxn2SgWIHxi3z00pdgdImXUD/P3tKVHp7iwI3saCwnfcBEUgM3m4CdRTatsPj4KXYQOZpVGyNYL2mf6RAjSqwmX7elL4XQh9Uol/ark2l0eeuPUIFXNoeg8S+fZvuhclUtEnSE/qxg2sSf9AIgjDibZIzUypyojAClSnfeV/7Qk/FM+QgrHLiJctnzpP5lM82oI51kQxdmWq9uRQSX6+bWAptup2+bfH1mwVECAn8DsOpUOkn5gu/yZiJdlQ+mn7iqdav2D6P2aMLSuC8/BWdKjBnIgqwF3PMjKBRM2iHW1GRnlUnS0OrJPYHvxmBnbmA43avNPZ0hkJamJ6qVwVBBbPja3cnVDUi10/rrTDlPXkCYNsIbKVm9Hz83TPgfvxPW8HEhXtWnNCIgy8U4IRcx47EwNd3McID3nQb6jt1DCnqnVBl7Noh42t31OWt02b6Z0zWfE716xvpt2pYJ8cUFpbgD+teTmbc/BHR9f93aj7alrpjU51kCrwnJT8DuA+j7x490KzkZSKAV2eo6t7ilHH31E+WhQw2WZjPUzqxDChuEAqoWcCzv3wuQXpp4RQ6vIH7glFXeK/8dcikCLAdesmf2i57NFyz/0aHfEzS3p37pqqZpfpv3OayJUUGal4pm4o4VnRtKYmDpd9KLtZf3S0V/MBRVRiGbXVMucasoqAZiFB8xA9jTrm4ofutMBEpcQuR/EsgnbVpQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/OktjUuE/mZ+4GSefAodYQ+iKytMfVaUhQci6hG3JKMaSnlmz8nV2xud9XRfmwFqXXOeEEDKU1XlOcyUzbQA25WcTutJ0/ORnozMF9d2bIvKW+uxkkMMUnjFg8rYAhJdCTeHllmNolXFctjDUOAL7xjdYUXfhqH+6IOGHpHpgx9rW2xNG1pOkGfhvfhLChqJR8i1ZEXEJaJgW59pF9qYkiMUnzS09LMBYXAlez8yji+NouzUls/cWMuGem10Cyb9elEwCUDXM/7vttylFY0SCovC1cCSOVLeDZiLkpD/TPfS6HQf1hUWF7QjHCNqmJRtP/VbcOKCYfPT77c0u61/WEUMM2ubOMPmC+2UpZ5HDZWdBOByj2V7vk15BXxkG5/s54qK1mqCFn6C4hhAIMEeQxEfwZyZphw+mFRl0T/CIh+OEhmCgMbuSYuKuvHhOKykPjwjDlR1Y/SruVeCrVrvJjsVcTpvO5KeyizuqM1XycQyj+OzTATq0flVAbiIf2YexfebZT4dbj36qyaMVW0kHINcGyXUPRdgmttVOO1zjoqBlWrlyEyca87GGlI7Gsb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RON5LXFrvMIgY9vGytjQdBlOTprf7NIl8mSKWfsNcrhStnETLPGfv9L8hhTl?=
 =?us-ascii?Q?CK+0nOgkuzr+jLYxNdmRQfIcHHR6FrMJKJ0Nu1woQzCDa23p0g+Vzb7sXAFu?=
 =?us-ascii?Q?c/vkxmVnHtKPVGWLfCp8moB2ubFFuA2FGG19T0Pe2mslzRDjQDveY9hI2RNb?=
 =?us-ascii?Q?AQvsRB/2hobIhHoGfuueSfcnmDT+XQzlCExVFESmV5vrW0GczpaUZRDr5UBQ?=
 =?us-ascii?Q?6qcNl6rS8jujrnyJFG3OGVsxIRfmrFtKJl2+8d8hpkVy9j4HyyaAiw1tjHCT?=
 =?us-ascii?Q?+220XlWYdQj5k6tf2Sk4vC+QPY0oIXrZ+flYEmfeY6deSTm2bHvAO0nnAR90?=
 =?us-ascii?Q?SJ5C9Nw1niwcm45UhTT7QPrUZ49uG6nmmyaiAVf89cQCuNtqJON1t0wpevRN?=
 =?us-ascii?Q?r8xi61ZcsQjvyqABAfGseh4auB7vsOGwDSwvkXAIKRUGykypZsECL+Ir1wTM?=
 =?us-ascii?Q?TQxuWIkrYHNMWhbwIDBV7gTYje8jwvjIx6t85sVDZxgfE1pYTFStUM+7FMMY?=
 =?us-ascii?Q?v6usmHfkd4U0Rg2TOVy4IM9yH0ESniEvEfekWu+NiLFffFuI3A6ekC7r1grf?=
 =?us-ascii?Q?bGhvutv69ziifPxGwR/a81DHdRAzTrWiKr70C7yag8GX+8u3lYy3D39gYDZK?=
 =?us-ascii?Q?iQwj+h7CsLbnFpgjUfwf0Uy+rIA+ocDNIAhp3nh54Yh9c3ik5w4Dma/dESdi?=
 =?us-ascii?Q?FcaEcd9QJPIuEPFnNJ1cxmSRD8D0jRwAipWYMpD3efIDJzVSvlEM+gmPwCyU?=
 =?us-ascii?Q?8xGGLqSo/KjlWQTb1gCtJZGBz+9/153AVP0ZrNW+FT8fa8Z9ne1q53pcMdF1?=
 =?us-ascii?Q?2l+QRFr06ZoD9WrfdpD2/O+kB2MW54CqRAS3bSnIfhyf74r8NDJrgtRniQnJ?=
 =?us-ascii?Q?o++q3F/zeFmrpin+BrvNaiiQ2G0j5SVe3M3hHoJy89rS1G6cRrO9/MOJBTzX?=
 =?us-ascii?Q?BPFsflySqOo1vP/Pxjjbqbmfv3ELUiXBXLgnLjAQCYIrFuy1+FNJ9I4B36Up?=
 =?us-ascii?Q?w7KevTdfusOwIBV5wqxrTUsJmOZxDjE057EP0k7qnV1hT8IsZGKSCUK2HTxX?=
 =?us-ascii?Q?38GKB2yxLy60YQLFSuXt82IpHbCst/Jayu+tGFZgsSbL8PyKaA5zqLl8sacM?=
 =?us-ascii?Q?+qLgzqToAZd54hkdepBMXsc9SlgVJ3kkLcXowYEYC5Ki0RVhYnYO/jZe7n9j?=
 =?us-ascii?Q?ImAl55QiFNYhcIruWslBicjXHkJ11nY7n+f/1CNW9IGCIhASYjqSO7ll+jU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5ce169-20c6-43b7-ab81-08dc26c28228
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB9229.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 03:20:03.2251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR05MB7451
X-Mailman-Approved-At: Tue, 06 Feb 2024 05:30:45 +0100
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

On Tue, Feb 06, 2024 at 10:38:40AM +0800, Kever Yang wrote:
> Hi Chris,
> 
> On 2024/2/6 02:58, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Remove unnecessary clock frequency defines from the RGxx3 u-boot dts.
> > Move the necessary defines to the RGxx3 main dts file.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> 
> First of all, the dts should follow the one in mainline kernel;
> 
> and why you need to over write the cru in U-Boot for this board, I didn't
> see this change
> 
> in other boards.

This is kind of a special case, because these devices are so similar
they can all use the same bootloader. So as a result I have all 11
of them (and counting) pretending to be a "pseudo" device in U-Boot
called the RGxx3. The only reason I'm setting the clock here is to
set the PLL_VPLL value to something so I can start addressing the
DSI panel. This way, I'm able to probe it and send a panel ID request.
The problem is the manufacturer (Anbernic) has 2 versions of devices
with no distinguishing characteristics.

The specific ask here though is to simplify the clock definition. When
mainlining a different device (the Powkiddy X55) I was asked to not
define so many clocks, especially if they weren't like that in
mainline. It turns out this device also does not need so many
definitions, so this specific patch is to undo them and make it more
simple.

Let me know if you have any other questions. Thank you.
Chris

> 
> 
> Thanks,
> 
> - Kever
> 
> > ---
> >   .../arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi | 31 -------------------
> >   arch/arm/dts/rk3566-anbernic-rgxx3.dts        |  7 +++++
> >   2 files changed, 7 insertions(+), 31 deletions(-)
> > 
> > diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> > index f986e1941e..ef4f81500b 100644
> > --- a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> > +++ b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> > @@ -15,37 +15,6 @@
> >   	};
> >   };
> > -&cru {
> > -	assigned-clocks =
> > -			<&pmucru CLK_RTC_32K>,
> > -			<&pmucru PLL_PPLL>,
> > -			<&pmucru PCLK_PMU>, <&cru PLL_CPLL>,
> > -			<&cru PLL_GPLL>,
> > -			<&cru ACLK_BUS>, <&cru PCLK_BUS>,
> > -			<&cru ACLK_TOP_HIGH>, <&cru ACLK_TOP_LOW>,
> > -			<&cru HCLK_TOP>, <&cru PCLK_TOP>,
> > -			<&cru ACLK_PERIMID>, <&cru HCLK_PERIMID>,
> > -			<&cru CPLL_500M>, <&cru CPLL_333M>,
> > -			<&cru CPLL_250M>, <&cru CPLL_125M>,
> > -			<&cru CPLL_100M>, <&cru CPLL_62P5M>,
> > -			<&cru CPLL_50M>, <&cru CPLL_25M>;
> > -		assigned-clock-rates =
> > -			<32768>,
> > -			<200000000>,
> > -			<100000000>, <1000000000>,
> > -			<1188000000>,
> > -			<150000000>, <100000000>,
> > -			<500000000>, <400000000>,
> > -			<150000000>, <100000000>,
> > -			<300000000>, <150000000>,
> > -			<500000000>, <333333333>,
> > -			<250000000>, <125000000>,
> > -			<100000000>, <62500000>,
> > -			<50000000>, <25000000>;
> > -		assigned-clock-parents =
> > -			<&pmucru CLK_RTC32K_FRAC>;
> > -};
> > -
> >   &dsi_dphy0 {
> >   	status = "okay";
> >   };
> > diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3.dts b/arch/arm/dts/rk3566-anbernic-rgxx3.dts
> > index 404dddfafb..9e0aa9e63b 100644
> > --- a/arch/arm/dts/rk3566-anbernic-rgxx3.dts
> > +++ b/arch/arm/dts/rk3566-anbernic-rgxx3.dts
> > @@ -16,3 +16,10 @@
> >   		     "anbernic,rg353v", "anbernic,rg353vs",
> >   		     "anbernic,rg503", "rockchip,rk3566";
> >   };
> > +
> > +&cru {
> > +	assigned-clocks = <&pmucru CLK_RTC_32K>, <&cru PLL_GPLL>,
> > +			  <&pmucru PLL_PPLL>, <&cru PLL_VPLL>;
> > +	assigned-clock-rates = <32768>, <1200000000>,
> > +			       <200000000>, <241500000>;
> > +};
