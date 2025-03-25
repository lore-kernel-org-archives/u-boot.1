Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D70C36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 06:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC1C80EEF;
	Tue, 25 Mar 2025 07:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZKvrCIsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA89380F70; Tue, 25 Mar 2025 07:35:33 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D14D808B6
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 07:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIqAyK8uex4uApOICw0/uyyS86nYpH1qX4VOcq/fE7qVjaI3CSvkLUr1J68DTTV/q72P2yGiFRjl3gWpLK1aecXE11Otbo2l4hAsx6D+08LISDd/DyS8ZMiXDD9ny6+jg9+JBHa9S9Ao3ud4eR51TPy82g+z4NYusO4sqcmaUslkQS8kC7oy18SubWDWQFOHLF3hsK2Lzs3XUmr9wfamTJae4YrKy/UXRLHmsiTNkWTnEPgF00GANigcjxIYUO1vPpK7gXzKO3+5LD7w+ieRy+2Jn/zQq+7hMWnTtteZ+mYzMzSa+GaJ87paPWXGV2b1jKiDKn/HxHa1wxSV8S9q2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDPZ2l0SpNWgD6yilOCY5QACg2n79H/jysVbcvZ32kM=;
 b=WM+GIppIko5joSmk37G5xidJCc3LWQH7Wyo8+jw62gXEvvWV5FNOF7yM5ROI0kQMXAGYtl38+pcFCT6nIwHO2SCYkxwOfcp85afzpOB+QK4zqB471r/2+C6R04dVBD/K0RIXAKRAu6CtRHyjrA8ubm/CMR3XA6HXxtTqSpwZAhWgRMHMNp4sutIP0q8fesd9oLiIe5GMVlk5nTXXChEcnwzo/m+SP7bFEAP9/jzNuwqp6QoTdIaXwUDYzY8ZE2ZdB8JR/yLULwR1c0Uv3pMW4819n7nTL1Bai816wF9pZjp/cGp/HiTufpsgklIuUjUQQoMZitJbeHjDxR2jznN1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDPZ2l0SpNWgD6yilOCY5QACg2n79H/jysVbcvZ32kM=;
 b=ZKvrCIsJGSn5gsnbchflKdHU4zpNoQ1m822mzdEeoY5epwPRw3mEUU9zk5MnBUGGOylHVeULrgSgd6qvVES0/kN/+twD57PJGhzIsreWHZfNUAvA7T3JtH3KokgSHWQG1uzwWLqvPD9fmCfX5WWLhWPvVkh2UAQIsxWFJEWXE9fOlSnTPgAgNgILHuIcV74LCCFzoLoRg9hXlVQ8nHl8ZEWid8XCPRS+Ndo8X62a1VyEdQB5lhI6ZpD+XBNlZZtNTR5Rk0wylASdFhw8FRHEu7GE0CCiHvLOPsBgrSGKFkPrCLcsz1EbFPOeZtToEeODgwX8h9vaslT5GvT/cmlpSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10726.eurprd04.prod.outlook.com (2603:10a6:150:20f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 06:35:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 06:35:28 +0000
Date: Tue, 25 Mar 2025 15:43:21 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, festevam@gmail.com,
 marek.vasut@mailbox.org, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Teresa Remmet <t.remmet@phytec.de>, Gilles Talis <gilles.talis@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ye Li <ye.li@nxp.com>, Christoph Stoidner <c.stoidner@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH V4 0/7] Migrate IMX8, IMX8M and IMX9 to use imx8_cpu
Message-ID: <20250325074320.GA27303@nxa18884-linux>
References: <20250325025452.950303-1-aford173@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325025452.950303-1-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10726:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb7388f-7a0a-47a8-c6f0-08dd6b673bb7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Hah2fl1GofsSoTIixrjFzxtETUucqZ0E9XAiTADAH6W00i4nYekr7Xt6tYo?=
 =?us-ascii?Q?4vrP0CfyG0/x6n053cajmoYH+UJU88J7qTYcnld1v71EPp8MT8Z6cqzJxSH6?=
 =?us-ascii?Q?tMkQCejp0oTID22Cf4NRbp+7ngdOWc03pYgW6+ptQ1lvIt/NoIGjzQmoEgTg?=
 =?us-ascii?Q?IPZmdEQ52oiDuxx3uVj/38Pdqk/7k47efYEKYYDYtpchI1oIqbjLax3BJdo4?=
 =?us-ascii?Q?3j4FdVJOZ34SLLEWh3x6F4xsADYf3xVZdEP03bConLyA/C4Xa9fMDt6DBejG?=
 =?us-ascii?Q?OQ/dCE8t68IRn6w6B2WdP0bf4RAmIVEbAmhsn2N/K0Scxf4qpxqK2m9C+ivU?=
 =?us-ascii?Q?pjpdNfS3vM5LHN5IFtLmxCabvxdOsqeu0UManblRSSqWsdbtADZ+v4bqFQ9n?=
 =?us-ascii?Q?hI230JqsfWhrqeLUKEFUf21hIU59n48aNQj620zAkjbJFsKGuaX8PecNYns1?=
 =?us-ascii?Q?zGzLkraRJNEVILKMTz2Pk7sQmt/30ngDIz7Q17Wau7okp3HWPABn5snPobI+?=
 =?us-ascii?Q?EP0oCpHLpGWSEUKQ6fXbXcKsS0rASOmSCGD+cu2JWQxZO51b7TAfsVD/R3Z7?=
 =?us-ascii?Q?U4Xo55NlZtFDW31cB1NwXiQJKtU0tYZIXUfPq/J5QNZdJc1ucuwAphEUofT6?=
 =?us-ascii?Q?DS2NEaUCdUPUBzu3ykBlwE0LSwLckbp60o6S5oFyA4WLd6uCzZ5OMbQ/xusP?=
 =?us-ascii?Q?ud5LQucN31lI39Keb3aqkfECx7m07KfmryqxzxcmnXHbghBGlD38dgjsvmLp?=
 =?us-ascii?Q?ecH1zHFCq7kGu0ptxpgBRn2QBpGi72nPwBNfiWV1F08wOtrDowszUOhFqrjW?=
 =?us-ascii?Q?Eq5MNeFx1QvuM269LH7ouRIhzg7m1sCOMl7GwtSr/mNzzNYZf7FN6KZVD9Nh?=
 =?us-ascii?Q?pX25xyrJknNGlXyBF/nIfC/4IFfDDwSWwFrfxTfgpvOyToqHKHEPcQgnDmB6?=
 =?us-ascii?Q?FzXRvlTHRyg5ModUynrJ//KLhCODe17AV8wpBxNsLctgC6ucsAIr7OEWfHa8?=
 =?us-ascii?Q?/87qQD+jt7tPKxPidCNKmTiH25lV0+y3q+t8BRWced3JVMTHURMRwbmGOw02?=
 =?us-ascii?Q?3NlznEBUKm7BNyPVtc/i1tURvtpsIRfMyPSSVT7LMubWp83CSmTHdIlt8g8L?=
 =?us-ascii?Q?k8tMu0HbyFjBCyYAyyyL/cH6KQDDsuyClV6VL152OVw8ffAen+133CieNbUY?=
 =?us-ascii?Q?AfcJQZ27E53j9IcDP65o+aAesI3aJaYI7LdICALLe1apBGtk/ns+ubrb0R4v?=
 =?us-ascii?Q?UL2OykLAWhFzEU3IimKu1aKQ+gNJsNX1W1kuQuFTQ4EM7Cw486Ydkk7nzddK?=
 =?us-ascii?Q?v3VO6pJLLB3A+7gL7NVZk7Zil1a5ELQFOlJ5w0EBLKXjaYNigkM0P5GKyNKn?=
 =?us-ascii?Q?AGERvOrxUt9zdpRQTvuGYSi2EFwuNUbhoHSxeyLSjidSgHmBHuyjavkiQTrL?=
 =?us-ascii?Q?HO/Vs+J/4nqOOfosFUMM/cZUPm+iBjQU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u62Knk+jSORP7cZ11umjb+BkETp3ykLZwmklkTOCgN8eofwiaagPmMLMC6sd?=
 =?us-ascii?Q?kzIuC2V9qzZeNm2zVc374yc0lJZGCxvtTkMkGGUAaF2SlOZ7Rm8V3CqiXeVr?=
 =?us-ascii?Q?hxGaQecdVAEXfT+6e3RnvAV0y30vPjrqYqcSBQk+UWiLdt+x6BWzlBgi9uSy?=
 =?us-ascii?Q?ugpSkqp6ztCW0R4ZEXcRt6O4hTCzgNoYYSw3inmorsP0PiPkj584ScISuaGG?=
 =?us-ascii?Q?rCxjEDC+WsYI4GZLkgNrejb51A63Op2wMaz5ZqD2awcnjIRYqhq8oAMjM4e/?=
 =?us-ascii?Q?n8IJACurNSXObOu5bkuRW5HMU8wodPx2TUiUd6/aahvi5ars9fD9qsASeWlp?=
 =?us-ascii?Q?eFLI7htlhf2PJ+acZp+4SzZcmk1Lip23AjVEtSW2AdFsJa2mLGN7/4jOhqct?=
 =?us-ascii?Q?Tg4MaphFJqER1T4Nzd0oR3j5WUrTvr5kFE57hje0GwkVelL/ni4OWmt+E/Pe?=
 =?us-ascii?Q?l6F53kZPC2QYTRQjuq6T/WtD6IS/THJlLJgbYVbwlD9yC2q+ZxUb7Xn/gdgq?=
 =?us-ascii?Q?53E3sfn24ZSbC56S9uxKwRKrr3V5hDXHVANn/yyW5nMs9WJlWBVFnKFzhC/N?=
 =?us-ascii?Q?X+Tp2VSA2W9clSElFQmDYY8TJWAVbe2lJkJTYZjslNLF0I9DujxaGKpRblUR?=
 =?us-ascii?Q?QC4jGrR6I4zP0wQaB5wldV/0PbB5D92I2azyqT+iO4ih1H9X7zWbWsYF4uey?=
 =?us-ascii?Q?QayqzHDapdaaJXiGvvuUj3j2ESbw8Ym6lguEodg/hjzgcc94GHn38lASgp2+?=
 =?us-ascii?Q?AxMJFZUkBgotNM9zr/6EqhqS8HJ8Qp0OwDxkzevvY1k41H4vXzwivWcB7Aq4?=
 =?us-ascii?Q?waa+WaYkNrY2JElhOXEemu8yhQs3HSyT6d9mp+EbOgTfCPxqb+L3aANTgqwa?=
 =?us-ascii?Q?vJCfzkwkA/14K1YeOxwV9qeX72t+vGgEjnbWbCqwOCcyAKgajLdh8l1gnRGp?=
 =?us-ascii?Q?oHQdy3ZLHKyOcIG0TidMT3NNdwp6XOz2x5R2ACfX1WFiSzQIKjwbLJUEK6LZ?=
 =?us-ascii?Q?bWP9Y1pB+hnXT/4VWtsuhoPoT/lZ9SPXxmgtcq0zVGndpczoOJ/tFutGxn1q?=
 =?us-ascii?Q?zf9EXNGdlEC8R0iI6/QQstZWDLtrumc4oNQV9+44x4ujD4Pk5P5dIZ1mrFbp?=
 =?us-ascii?Q?7nC+oTw3h/Gna6pi1WZkj04PomRcPW2Cis8ASnSx4LdlGd4/A8jevewCZHfx?=
 =?us-ascii?Q?SnNu5LaQVvV+3C0tYFdcpd6AvedVaz2qsUJLDEhW6mdXYwZuJe43PTeojG2P?=
 =?us-ascii?Q?/umuc/W0DUhR9zm7aao+hwVZyqODhVDhGUY4+3XuSqqA9kss3ZVq11MUwpmF?=
 =?us-ascii?Q?Epxb7sAZcCefuJpkm/7Y+cCkUYi48F7ObMfz1T6UZwI/fNgRRZurKV8iSaH7?=
 =?us-ascii?Q?fryA7yaGp28VnTdrXKUw6Bnt5HDT2Za3++pG+Flc6TQdfWpOpd//Qjvu45Df?=
 =?us-ascii?Q?YjoHzL2RvpErEGb+tLty06yl1FP9D6J/sk2DfXTwXwQC/qOt7sUY2LAzPyvU?=
 =?us-ascii?Q?5UdqthzvH3MCsle/eVrXEcb5iXkMxxVjQ1QfD1kXf93R+o00HDEByU91gjHN?=
 =?us-ascii?Q?+0PqOlYyg8IYZ3Zrt7FB5zuhKuiD0snt1SG/kNcG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb7388f-7a0a-47a8-c6f0-08dd6b673bb7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 06:35:28.7057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: md/1ERdLDkjkhcoah0Xa7e/cbtDduZea0PKpFzdykyvFfltppYLj8cwvR4X3PYAD3eyzfYRNie6RgTq9jlMILw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10726
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

On Mon, Mar 24, 2025 at 09:54:41PM -0500, Adam Ford wrote:
>The imx8_cpu driver uses the driver model to represent the processor
>cores in the dm tree as well as display the processor type and speed
>on boot.  Currently, the imx8_cpu driver only displays the temperature
>grade of the processor if the processor is IMX9, so in order to display
>that info, the check in imx8_cpu is changed to check for IMX_TMU
>and IMX_TMU is implied for IMX8, IMX8M and IMX9 SoC familes.  If
>users want to fall back to the older method to display the SoC type
>or remove the temperature grade information, they can.  Doing this
>at the SoC family level reduces the number of duplicated config options
>for each board, and was done at the request of the IMX U-Boot custodian.
>
>V4:  Make IMX9 select CPU_IMX instead of imply since it appears to be
>     required for all in the platform.
>     Fixed some whitespace in imx8_cpu around the temperature grade message.
>     Re-ordered some items in Kconfig to keep them alphabetical
>     Added more CPU items to the list inside imx8_cpu to match what was done
>     from arch/arm/mach-imx/cpu.c.
>     
>V3:  Added the imply IMX_TMU for the 8M family and added the imply for
>     CPU and CPU_IMX to IMX8, IMX8M and IMX9 families.  CPU_IMX depends
>     on CPU, so both have to be selected.
>
>V2:  Changed the check in imx8_cpu to drop the IMX9 check and instead
>     imply IMX_TMU in the IMX9 family
>     
>Adam Ford (7):
>  imx: imx9: Imply IMX_TMU
>  cpu: imx8_cpu: Expand get_imx_type_str list of supported CPUs
>  imx: imx8m: Imply IMX_TMU
>  cpu: imx8_cpu: Print Speed grade if IMX_TMU.
>  imx: imx8m: Imply CPU_IMX by default
>  imx: imx8: Imply CPU_IMX by default
>  imx: imx9: Imply CPU_IMX by default
>
> arch/arm/mach-imx/imx8/Kconfig  |  2 ++
> arch/arm/mach-imx/imx8m/Kconfig |  3 ++
> arch/arm/mach-imx/imx9/Kconfig  |  3 ++
> drivers/cpu/imx8_cpu.c          | 54 ++++++++++++++++++++++++++++-----
> 4 files changed, 54 insertions(+), 8 deletions(-)
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

>-- 
>2.45.2
>
