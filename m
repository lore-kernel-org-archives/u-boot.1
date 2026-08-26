Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A1DC61DC2
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 06:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A9F180BA2;
	Wed, 26 Aug 2026 06:34:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8-s3HKpnKePp; Wed, 26 Aug 2026 06:34:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787726082;
	bh=q18qddm3VtlZvWTIN2izQC6vp1mp/SQp8knueg0oRn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=siDAhIyolM9wswbjlTFX9bSg4GZA92RLWokVoH/5Ojs7QkJrZYjrEG71FHotdJD/C
	 TLyZv4rt/ua1244sJ1Jpbd6fGQJY0Bd/Tiipp7jJLwxHA27red+0C+pJoPF9Iuay29
	 FuYFtE6YIPAS5V52gIwVGd07LBTpTjtgNPsTQkhQCP3NvmaG2IG98Vldql8sccp+Co
	 MYxVyMZTxtnuKxVS1Ued8geJBz3HL2xJLy6j9b6cU7mhkgkpq70d2NoRCXEMn92d23
	 p50NK14c46VvDX1+eFo2wYlx+WrsdTqGsSyEaOXxbmfsIXwAxr3wfY8HlWV31uyGF1
	 jWfPyrJ36rigA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D216480B84;
	Wed, 26 Aug 2026 06:34:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FDE523E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 81F8E402A3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:34:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1loxn0Exoi_G for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 06:34:40 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=r1oxnzNO
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E95640216
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:34:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tynf5yXEgKniMLloLEhzhMyFA1E2LQPW6ThE5aLxNcgSm+hc3IXgDrFey4XFkDRqE6gZuOjccz2DTwsGH7D4d36nJU4zeA6pydNBApYwzB1nmxnV6T0hRCGm5h8X2BJT1+1eCOpZVEvKLyIaH8Rl/LYbtf9wMtUVkoMkUnSEZ11Lo9zIcT2G7/g252jfTe71yjpynezLWEMdIYfUHrnF98laQAkCRfjqSVyrE9S9BR0LzKrPFY2rjvAN+G7zvMEWhqUqGpDPDfaSHpmDJalvUIWz3MUHs2TUk3QP7+nME9Z0It11P3iho2MX1I5mQMoDeoMfMMX/0w7yKLq8fgQJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q18qddm3VtlZvWTIN2izQC6vp1mp/SQp8knueg0oRn4=;
 b=Lm/sbIZTuz5CbuPS+7r640DfOVNzcX8aCM0f+Tb1nuCTmRm3mAl9TLaV0U/M473uYssjuWHBqBYHr4wzVmtLj+46CcyfXvjLYgXFO40AcftNAaxo4jMCCLI05NMVgJGomk5EImus83T+Gf8h/CVHsLQBFP5yBdkEJj+xjkYoky/m2OmJtlHWPfujXnIy6glKuD9ugaXMnbkG38oVyvPS87YoZhUEBZUme9+FhWUAa0mfc6ddKLJc7How8BYdQRmCy1El/kWV525DJbsW2budpHVX38byXjVMUSMg/GxXkObFMXIGzvYU5GUrQr0h+Sex7Z3vDpen4inx4o9gUsJ/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q18qddm3VtlZvWTIN2izQC6vp1mp/SQp8knueg0oRn4=;
 b=r1oxnzNOb0Kvv1PEDtEV8/zy4xjpUwO0wvOKeYpgoxbOXgeina02IB/nFV4aApV0YtRFPJOkvnGi7pAyCHq0jmSSHJ8ChQrF1UzAdP3MH0RJdZ2PlKtrB+/1EXbv5xFqb7CD+b3H8/0uNxP09qiTBkbb3AxUZqRzxkQtaqqLb7b+ZPF9Zio+xROQPSZ73Yy/nqTToDT0XPvaUyS9zTcN84Z5Mvi6XPfxUDfNeIWSMS9mOV9OQLGJ2GdQ+wPeGARx++IpUOvYNucjtN7YHhXm/V/0/XEpF1SjsR6ZJfkZ/BDOn4ir8sbE2o2ys6FdCXGdKAM2Wnh00XGNg3buLrNTiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM9PR04MB8923.eurprd04.prod.outlook.com (2603:10a6:20b:40a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 06:34:37 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 06:34:37 +0000
Date: Wed, 26 Aug 2026 14:32:14 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: Re: [PATCH v6 05/13] mmc: arm_pl180: Set initial supply voltages
Message-ID: <ao6IbpwmDL4Cl0z0@nxa18884-linux-1.ap.freescale.net>
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
 <20260825-ux500-external-sdcard-v6-5-61446b6c289e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-ux500-external-sdcard-v6-5-61446b6c289e@kernel.org>
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM9PR04MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 89425f73-5a8a-4dd6-cca3-08df033c193f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|1800799024|376014|10067099003|6133799003|3023799007|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: bXWKBD0Dych46KkfoIyMICnCYMxnb0Y3hgZeYQq3lXo41rf15UqjoS8sxBtKiKJTDdclwnfNFFhT5OHvTCm7F/nOnAokg7Y4Hk3Iz5DXO80OAcP780Fmg3QraXywDA8vd8fs4TW1Pjd9xJGicm2BsYQjeXbrLSd6DiyPdF84FZifEH56aFWmRfn7ybVn53ILP1mefOMn4PVJR42FzC9CGa1MgKxxbibw+PxgdACb+oSxtA/ozWvYW1faIF9RwBPc/KXt/ENI895w6G1EBQaIfWva+8UHdL9pSY1Y21C3GgI5qguzvq2ka74o7rObyIY8B2iSD843sI9FVhMVAq99l3ENhDfzzDxxqoEw0v1Cc6IEGcw3G6gU2n1MlZOLd5NL/QbZk5vuDg0hL9VcBdnW2Bw/O7dam1Wjpk1HrqWrHmRgbqXW04o2RpTb97LxtaIk3StKrmiBgN7qyS72+uzyyVIHfALsyvCGwiQ0/QAguIfdxLx6ZeCnke/hYYGB7rTnBLpWxJtTJgL5RB//dc2caN9kzG4dYBE05H4X9XDwacoE3xIsTCQQx6VJ/ua4HbhDFWSEqfzHtNI5H5QwCLv6WOXRN/svBflVOdG3Qxit2YlKwZzgfEv3mIp89CjuwBpkNxIU3BZv61Rip5HQ8bngH+m15TPBKZXAFx0mqfZrYJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KNdFEF0w//lhk+XHvvuOMRLEKTspm1z1MninS5TxB4T4gAW1Zj9OAzbAZKpF?=
 =?us-ascii?Q?EiyPAozljwXRXBOF1104tHXd1jYToPHahPR37ECk8aN7xrnzg1x38BA8y9GP?=
 =?us-ascii?Q?JOn1sKiMZBwcpBl3GURpnx9P0N/BuItakJUlZOQiXxneHcUFzhypZ+ZHKitQ?=
 =?us-ascii?Q?YtaI4QxShlk+V4+E3Ll3wFJncj9YXjZZt+8vHYTwYJZKSMEucZfFL9osz4k6?=
 =?us-ascii?Q?s3UjChwFIOlscc3cbMWqt44gtcvIaYuNR9TdIAbV/5FzdlY/WEGJQuaw5Aic?=
 =?us-ascii?Q?MropTtJ36L/PFJCejwi/eM/moWnlYTD9b+dWht5eX2uzRvhfSmXSxu1Ua7l6?=
 =?us-ascii?Q?mU0fxlZcCMfv2wF6X8Ue+8MEVVuuAkC8D+wuXpX9FM/BlZTSARceFB2hPAYQ?=
 =?us-ascii?Q?JBKLJk7BC/IDoEanLCLsxom40rGo074DNKwAfNiv61D7C5W4qJulPj4ho8M8?=
 =?us-ascii?Q?uvQGpmiYRo2StLticbTN7ex7kPh/iheVY2vhAHxNGTR23FAsEVNWFo1Ratxg?=
 =?us-ascii?Q?oScvF7x2D+kFLo8VbSyLs3X4CDQPWFz4CjNwhLjQcLpeY9uMHdC1eYl36ui4?=
 =?us-ascii?Q?I3EwoVxBlTOEyMSrN6JShDoQssVDVIxLJofZ32TNYb03OewxepGPha1aWE50?=
 =?us-ascii?Q?tmNcyh1K5t/qSE1ngoTiHsu9XbiTZ3jx2VK4CFM55DNCXA7Okm+ds/Uv3GSS?=
 =?us-ascii?Q?NN/t6nAHwk6dL4aweKfMfXgeYDRmtKw3XwE+lSDhBQqa6ny5YHSZ2vTEumVR?=
 =?us-ascii?Q?4Z9OiTZMGZVNs6hepe0BimoeYUt9HO75PeXiYgAvZ/YEApc0Q/OwgMhjB4Cd?=
 =?us-ascii?Q?rj1kzdEl53M3mj0/84HjE7CGd+arqSMScm4zzemqlkdIDFbJIvBb34SONHEE?=
 =?us-ascii?Q?fKAu8Ym8Tg6+TRviumiNnwugjg5pJXPVxruYeYWYtH+aBppUcjVny73/ocVG?=
 =?us-ascii?Q?YrZlakkQG8Oj64kNXccwRi/6urNofsr7Lufjv4dltmtchTxaJDMbIWBJrHb+?=
 =?us-ascii?Q?iWUk1qqouy12Vz9TLpKkA/1W/Np6hHB9rCBzICz2EY2w6lxiOBH2M657czqi?=
 =?us-ascii?Q?sW8GybdWtr2xjTTsRpfKVWop6mXex/4vV9fVWObpWn2sG2rVaIX4/SmIPqvx?=
 =?us-ascii?Q?3D/CnWuO3oqcwL3cMwfQ4Qmk+feQO6qzZRAwlOws3g3/aLrMvGVKJe/z+b4n?=
 =?us-ascii?Q?VdCfw1yVmnyDg1Y1RhicLG1ZyJI4i261VplO9/3HvtYwry1QbepEOvGJ5OKd?=
 =?us-ascii?Q?/5yDtgz8CCqL9TwbjkmzVsIjkPgp+xKThWSUAIarEouXx8AhGuaY8+8cxk5n?=
 =?us-ascii?Q?jQsUGCFVDcY/PKoxVB9kBV0FtmokE9dcKD3PlIIPNt4eWzlLdg61KFmJclL/?=
 =?us-ascii?Q?PqIOEFS09e0NYAPyPf16Q6AYvxsXQJ1X4eW0hMpdXeeB0b/N7D9AdWa7XQCk?=
 =?us-ascii?Q?hMlojL3rk0KDTX2+OWzUyMy+P9wKvoRsSA9xN4HQ0RmkObKiNlI1nBS0Z4mu?=
 =?us-ascii?Q?RFCsoZgtXbX5wmNXjmFKzEp4xuEPiskdj8oBlYNE6Agfs0ZxKE1lR6/X7fN0?=
 =?us-ascii?Q?Qdw/O59HGDIhCqk3F34md9Goh7zrXt/i/drsZNIs4bQ+hA39vRP7dQjkg8dK?=
 =?us-ascii?Q?LbRzq2JnIkQM0BqoI+Mb4hxSMgok9hpStGjIjs0fr6EdaIvdWAuqapMVVUsA?=
 =?us-ascii?Q?w8odN3mz6OnXis01PUAxA41wq3Rg4jWSzRgeN1kh30JwoPT8WoD1t77vDl66?=
 =?us-ascii?Q?FR1XZymBrPUDByPWjVnOpliipIupCBqPpODvIQb7BCFi1jtrsf6R?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89425f73-5a8a-4dd6-cca3-08df033c193f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 06:34:36.9619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9d8oD4Q0YRvzD8Jv6x/gcd0YkRHOhojArVfIYpAQFzUrBF4/8dhf1Cv5g0X6djO3iVKM7geZd8XUBkw4VdBH4mt9VEKCQw4nMPw+5A3UFBwlmjT+2tTBnm7M5TV3jt5K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8923
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, Aug 25, 2026 at 09:04:05PM +0200, Linus Walleij wrote:
>Obtain the optional vmmc and vqmmc regulators and configure them for
>the normal SD voltage range before card initialization.
>
>Request the standard 3.3 V target within the allowed 2.7-3.6 V range.
>The regulator clamp operation lets regulators with discrete selectors
>choose the closest supported voltage. This selects 2.91 V on AB8500 and
>3.05 V on AB8505.
>
>Ignore the unsupported set-value operation for fixed regulators; their
>voltage is already described by their fixed constraints.
>
>Signed-off-by: Linus Walleij <linusw@kernel.org>

Acked-by: Peng Fan <peng.fan@nxp.com>
