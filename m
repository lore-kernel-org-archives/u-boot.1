Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511A2C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 06:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C917B8490A;
	Mon,  6 Jul 2026 08:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qijwVzF0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BA918490A; Mon,  6 Jul 2026 08:34:33 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90A9A846FD
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 08:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNh6hq7/Yqkc8DKjYY5GXa30oNQ2rK/+ilS/CROXRBnyqjPxchmyzMqCBvlc9IQznbHr0lQnKjUwFQuZ+hF9xSomYy+yzAbjv0jUj5Xgfw8PR3KFQvz59HwX/WdBzfkCeXQv4qB5+9Rr3Va5WcA0aWiLza9MOvYAkT3PrdsL89SUK1ouuoP4NZoHjgNDauliJnXi6ItxhhOKYRE1BEG8Gk5mFQaOLQ31nh8Z8vp4Vg7etNExSLLXUk7NnMeNViWbSNN1aIaQUtV5yQVm0yfDeKTBHywhQuGSKOaeiP9512fNKmpADgtoCdv4RisF+/rKoKh/QVfR0f7wVIG52jMlcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqrD42i/y2ekYykX9t82H4g+xhlSvS8+KTm8T9cHeb4=;
 b=cBDx1vGS9KDJ1vSaS8bqv6KGG57yCjkwNSVOF7x8C17zSn3mXBlbf6jRkK38MVZnBwHJ4PvrVkdnk8IaBMlMDfxwmsreiPwUHG6mXSOp1xNyP4bfrZwXX1l83r2yFUPZL8UbXFuony4x2sxiw2j7AIZdebxwRcfyjmilbNq6AcrfH2GabwtqREIOwkNCJbXUy8RvFZFT7qvey1V7nfoep+2p5rTwPrEHC2Z4z4ZP0pRWX48nnmHiw0D7Dm6QKCOlgWgcs5METSw/7bdtsqTO1r62/48oVItAd5ud9C0/mySBlCjXAA+cXuBl+0gNX+iwqUPMSNe15xKj7xFBgBlN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqrD42i/y2ekYykX9t82H4g+xhlSvS8+KTm8T9cHeb4=;
 b=qijwVzF0qLk25MaziMcGT39icv1Ha40S6mnRmWD+TxVN6utZJkXWFP879iquO1inAWgMDvSUHi74XrxqcDUje3CZFdCXcv5BgWN/oHxnxH3RdJUGQ3wPqWlXyvQ+JbqxueVzK74x5bMFXmrASTE5+WNtJxoQx/OP/RdQ8m9mn0IvPowUNqZlMKh60X+hG6hMHCERdMCe7RmpB+diEZArrvKrlEMa6Y5cBCska3ltCJDy6tS+yKNTpUNxGnmITrZ7TVkhmwRqfjoTXa5PcJNEjT+jBWUGHhv1/U5iZJByCYhic8/NqPUeEhnkIX7Ij0wjdi2rDEagTQOzrpdDmptGxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB8835.eurprd04.prod.outlook.com (2603:10a6:20b:42e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 06:34:29 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 06:34:29 +0000
Date: Mon, 6 Jul 2026 14:33:15 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, trini@konsulko.com,
 marex@denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Tze Yee Ng <tze.yee.ng@altera.com>
Subject: Re: [PATCH v2] Revert "mmc: sdhci-cadence: trigger tuning for SD HS
 mode on SD6HC (v6) PHY"
Message-ID: <aktMK89WkwERXq9r@nxa18884-linux-1.ap.freescale.net>
References: <20260629061619.4268-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629061619.4268-1-tanmay.kathpalia@altera.com>
X-ClientProxiedBy: MA0P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 582bec31-2c98-41e7-2130-08dedb28a1f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|19092799006|376014|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: aaqFeQjyy6iADt/cPwTlAz71QWHClKL06aeOLF2/qRpcs0juWIKqn8BsOIQd9+A9A5Wqu9Yi5220jd4BM5bopbcRR4uOFs5EaRC/VcwBSO8ErQzTqkbioLF1sjetLFMttHWtFXj0UsMFxCv5K9ySkJd6vojzgKdOuxa/3M5XA1fA4ExNY5d773ZAa6UlDpjbMGhvH/VEXjNM1n/vbUi2lwE73ffcGa3eRl6wxomiYZiS7JIeN3+Ct3by8ZiruFku99uvhk9SHPGy3nK9GfNOCC/WZut3VpLp+bMKzBEEF/Sye5WCsh0fcwqL4SH+eyU8t960PUart4yZjxCPFaJMhKovKRXd6reP3GKfFIsTMlkippiU+XgGKy9nNaUeg1l/fXu3KK8rUB3/5s/JMk4bqkJb1+O5n2kw9KgPGSjUSSFZq/gbb/bJVuvAGJYKFlimAlEZJpijHEiIBVC+K/K2x6Cyk9Pg5y3eW9h2ioKRUWljlCqPNieZrbfYkCuQSXEzz39Zxme+RkwwUsx/9fX3K1psBw0J8rb7H0pOd5KayfgxELWu2mMbW8tYGyHuGZvwS/HGrHXlWZ4Y8ZLwAiyEobED3bN882+ib718XzeKyGsdvpwAm7zb8itWo8EpMhf6yQac4xbWOiwZizURLvLD3M+4HgMyjBdvpzwueDZ2S0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(19092799006)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hP+sVnh+LcjovW50j75SoXLzG1usT9BcwBB+P06CVURBIQuzvwi2FvVKJgYt?=
 =?us-ascii?Q?abA317bvWG6U7CF62Lj51hvMa62hidO2sJyGwwBZNcZPH86AHz8kxF53P0Hj?=
 =?us-ascii?Q?NJj0F4deWfljDEgH2njLRRO+2Tsm8Y4ss+WfPhLcwyElGO2BZeKvRGA56MIA?=
 =?us-ascii?Q?juoP9gpYgMNaTI/foQZzRfjj0flne5O5le1zcXxmO5l63zmj0HCrsTbaSg3t?=
 =?us-ascii?Q?0MSDnZBp0SjyRD3cpr1VucWTxKajP2v/itd/Zod1+dWyLXeBLkb33icKbzL5?=
 =?us-ascii?Q?mPLMqNydQLxrvlOSu90SYP1a0/cbEaIkrjJGbmtnEAR9JwqPVIHDFRwgH6LQ?=
 =?us-ascii?Q?zU64Xr2wTNdp55vzHGsLCdBMYk6xxk2TONKa8jpKXcFBLviM9DmJL9Q4527W?=
 =?us-ascii?Q?CXKGMGTlI3rZnkQMADE90k9nYqwiaGyhyfleSuVVJRxhMoMMBubF2OScMcML?=
 =?us-ascii?Q?DJXqCyoe/ITMhxLT01B/UtRu0E9TaiveOKPbavJ3X1IOhZY80GN0nGk9kvah?=
 =?us-ascii?Q?9qwe7aPlzVJ2qXIUw3fLrYzZtWRtwOtNw2oHl4RRvrvn9t6rWcRZ0GSGxA8w?=
 =?us-ascii?Q?MokpNEnfZ6xHnyBzATeONTkHs+rPg22rekLXcZLFAhLuOtpd9Qwu1akGwD+H?=
 =?us-ascii?Q?1wS6TvDGPAuHC/eDu32nczrEk8hz19n6F6IMLyt9xD/g1CUhvZjQYu5nWPxf?=
 =?us-ascii?Q?hETXwy+ieg/1ZskF9Q2VMSzxjkZJozKuwJd+69K+J96FVQSZHaDIOvUpBbQF?=
 =?us-ascii?Q?yLlyMqSDxG8IXVEm4ocvYEk5+XD+SP4DuAkSBpBgsVmKYDZG7mV3mQA5BG01?=
 =?us-ascii?Q?aiUKZjjCUOC2xzwkiXl8OmNOPPXlFvKkYbp691PMaI22xGUMp1+FWpV1vrzE?=
 =?us-ascii?Q?5lCq63gCE3wc2U59TT8AaMJB79keMEH2p+m1fAdr/ZYHLnvyFCq+Q/fSP9VR?=
 =?us-ascii?Q?d9/Ya0XrgdWB570hbyi/h9ZrFc/wZF972wLECrYHhjl5B4UEjXbttUUH0odr?=
 =?us-ascii?Q?sDcPeUkHgdX3O6U4ZlCtDItHyugG5tqhIqnLGC9nR2TJHTTXI50CNpLnqy3Y?=
 =?us-ascii?Q?1PKDaR9y0/C0+Ng97/WUqm4fAJfZ/IrAKdWKwQ38LABH/jBJrpJXWdjyD7BE?=
 =?us-ascii?Q?WsZWvpmnoMOui2d4iRLe5oWDrmqQ7rT4gnuQDhrJlcR86eHTtjIujipp8x+L?=
 =?us-ascii?Q?9JE2xdvvOgu23Nll1wJ7Hf9yaWsnkSiv1/JDXnT+nDtuu/puaSdOx+Esicub?=
 =?us-ascii?Q?g+Xz6TaKzemJfBjWLVVdqJu7FizlDXxS5foX0aYDZK9uPX13sXYfafQgQq1Z?=
 =?us-ascii?Q?y0TrSXpQA0OFNrx2m43/TBsVuv+3dQRkCu4wcDSDBGOhB0yjuT91FCwmvq+G?=
 =?us-ascii?Q?153wqY+ArC1bgTgsoagCSd3GfMsSsJdFJ0vEzQDhNI1bnYmlm/7P/4I4ehNz?=
 =?us-ascii?Q?X3WxGYs8hdeJQUCobnYQW+Yler6IEW/ecXObfuBQ/vbUTAtqgtn7pHx5TSkV?=
 =?us-ascii?Q?YlxyCQwcqa+XxwvhG306nRkOM8OQMCFuPIDzeEvGxXvsB6LAvawQP0QEEf9r?=
 =?us-ascii?Q?hhr3+9gfBqggBEa6d+f4RDhZm0Aif1CHfM9WzyE2/4O/90UhlqEuqkEMuE/n?=
 =?us-ascii?Q?e8N3frMorCwrGQ5jJSvPQiW1d/BsISNC/jcZiMSFt7Tl8+fxeYpjdSfe+bqy?=
 =?us-ascii?Q?UI4J4x55EGxGLA3PR/JTjpJ+X2vQYg5tVZEzpMBXU3+id+fzC+NwZdj4CPbB?=
 =?us-ascii?Q?R2xJirp2f2pVqLEuHNYV4kwUZuhHWdavUHnATxzTmoImLeRIM64T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582bec31-2c98-41e7-2130-08dedb28a1f9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 06:34:29.8409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehfdzu9hLSisOYnkBcgUfTp5hx5JAU61u0hz8q5MXyofMH93P6IIRIoOUdwFCSKX6uiD6UUtC173cIljj9S0IMgY1SF+sdt4/ejy1BRk9uiW0uGwfxdqAWorGvbItQmG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8835
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

On Sun, Jun 28, 2026 at 11:16:15PM -0700, Tanmay Kathpalia wrote:
>This reverts commit b42c67188c14 ("mmc: sdhci-cadence: trigger tuning
>for SD HS mode on SD6HC (v6) PHY").
>
>The reverted patch introduced several issues:
>
>1. Non-standard tuning trigger: The SD Physical Layer Specification
>   only mandates execute_tuning for SDR50 and SDR104 UHS-I modes.
>   Triggering tuning for SD High Speed mode is outside the spec and
>   is handled via a non-standard set_ios_post callback rather than
>   through the established SDHCI framework tuning path.
>
>2. Non-standard device tree property: The patch introduced a new
>   "cdns,sd-hs-tuning" DT property to opt into SD HS tuning. This
>   is not aligned with existing DT bindings and bypasses the standard
>   MMC capability negotiation mechanism.
>
>3. Incorrect tunable mode allowlist: The sdhci_cdns6_mode_is_tuned()
>   function includes SD_HS, UHS_SDR50, and MMC_HS_400_ES as tunable
>   modes. According to the Cadence SD6HC IP User Guide (section 7.5.2,
>   Figure 18), tuning is only required for UHS-I SDR104 (SD) and
>   HS200 (eMMC). SD High Speed, UHS-I SDR50, and DDR50 only require
>   a PHY settings update from the pre-calculation script, not the
>   tuning procedure. HS400 transitions through HS200 and reuses its
>   tuned DLL value with a partial settings update. HS400ES only
>   requires a plain settings update from the calculation script with
>   no dependency on HS200 tuning.
>
>4. Tuned state management outside the framework: The patch manually
>   tracks tuned DLL state (tuned_mode, tuned_dll_slave_ctrl) and
>   restores it across PHY reconfigurations. This duplicates
>   responsibility that belongs in the core MMC tuning framework and
>   adds unnecessary complexity to the driver.
>
>Reverting to realign the driver with the IP documentation and the SD
>Physical Layer Specification.
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Applied.

Thanks
Peng
