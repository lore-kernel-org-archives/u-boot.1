Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269A5C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 02:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 951BB836EE;
	Fri, 11 Jul 2025 04:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ke6lepMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F4F6836F0; Fri, 11 Jul 2025 04:50:39 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D420836E7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 04:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdfuxgukt70P/hL/jTi5h/wBbSgs8lkOMJDb5dl3Aw/xm0nn8JcxTAM43vBibufPWPNW49x7xcmyVRLSEEJTMbESaby931UgV+jyUrwe8qcGBW3ejURbemNfODbhfmIM3eUquPPkK7aNUccJ+rqNBpZmf2JdlTT5nyk0WQb5Wo7Pgkc8KcJHvPs8pw9vY0iUMCiBJRNOj0N1HagKyadG8Sx0/04QSAbnK2sfXeO5jiu9+1DhvAhnOJZuGdwswVVQ9HA9Fdzoc9BSkEojoBNjG2gDzhr/WPzPPK2ITPA1qRinXoyuqMuUSuc1c1+YmrpcnjhV9x2/TaoOpRkmD0uLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctOC5UgB4f+fFDcDmEB95yP2E90KcVyI/ggylPOsftg=;
 b=shO85pI70tzOFgD+wuDZjfdXLwWbjKZM2JmhFlEQm7toeylVmO3r1TZrUH+FxQ6dyVsmzEVFoimlHG92v0WO0VAx7LEy1zXe9DAw+mL69m92ueifo+Uw9/E3BclqjUquQgoRjJubGw4bbhqoICDerorFtUl3aEhD18CIca7kuCZBRZpv4apfh+OoLlZuwZ6M3xFL5zjn4983hUNfLHU0ayxePY05xL/359zGOMSa3WYPtezs/oWouGiXaAejVaoUsjcTfap2HbMxkERMMnkJaQMn48MuoxpSgU0cgHKM5yRX2+dXM5Z0zlMvr+EbV6cpd9O0bJTnI55J8hTkxeqgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctOC5UgB4f+fFDcDmEB95yP2E90KcVyI/ggylPOsftg=;
 b=ke6lepMP+McpVDFa3BsHyEc6fxRYORanIigJj3BckeFNN9/dalUpP+YhRVTWAAimhMLt/KltP1RS9AGfeEQ99wiWKWOcCoPa8DavwseuGZ5cBq/PuX9SKFAMJWBMLYDVjB4iIc7RXt0ssZ6JmKPEQeoYhhlg2K9MXMk4Z7jPzaqJVvauEVV7M/jK55sZai9+7c9+LWKwrsnyZcx9klnNcJiseBH2ya5qR/1cdW36IGuBkSxq2UIjN9v7Q9JMoFP323FPgfQvqpkBBDKuNFAaYTH3s4omb/0THArFWzfAYWC4dOC7uy1I2g0QWkr2APZtkql+Drp9bFnCldJtOt+yig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB8030.eurprd04.prod.outlook.com (2603:10a6:102:cc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 02:50:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 02:50:33 +0000
Date: Fri, 11 Jul 2025 12:00:52 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: hs@denx.de, U-Boot-Denx <u-boot@lists.denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Marek Va??ut <marex@denx.de>
Subject: Re: i.MX6UL: Adding bootcount support
Message-ID: <20250711040052.GC1654@nxa18884-linux>
References: <CAOMZO5Ag7CmRBhpvOB5btNvHiAMayBoxSYMoBJXbV3-w1ET7jA@mail.gmail.com>
 <072c3a1f-7501-891c-b2b7-a55ea47be0f4@denx.de>
 <CAOMZO5A_7Ruaq9mE=owPctK-6uDu56kaBkqth-Vngr_CvAMHKQ@mail.gmail.com>
 <6bea1e46-e5ce-d3aa-369c-b6fd7b0b116c@denx.de>
 <CAOMZO5Bsdx__qUGmwkYAAKTCbYcBVC2wExsV8o5c5mf9_N8CvQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5Bsdx__qUGmwkYAAKTCbYcBVC2wExsV8o5c5mf9_N8CvQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: e684043f-09f9-46f6-723c-08ddc025b49f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qS0/uVP6vz7tg6MEGVKZ8Hv4016GLPMMGzZD8mjcfIVIJH+QNm8oRZvXpM6k?=
 =?us-ascii?Q?wHizEbfp28jhAKi/VFdVFCMb4rFCPDrkrrneaFf9AsFUYHGsyISA5Zj28Uyy?=
 =?us-ascii?Q?ZF88fIvzN9KhTrrvllvz2Vd3DLD8ojMiRWjupmpbf+/hL0eZcfmUgrpX6lLO?=
 =?us-ascii?Q?ffo5XQoo9Vi7ZmYvDiJxxq2SyUMVjq8cAIgvXH7k7mphiMU+6+mOVnmeN97j?=
 =?us-ascii?Q?2uuFN0F3T8ga+AKMA+YcsnE8P9FNTACemBQ2P/Y/GY7rMq0qM3o08BGWT2DC?=
 =?us-ascii?Q?ahtL3wry4IaXxCTAa8R4D1d8WPGjvCxTEewrGNVZeY/0/+ERyaQmawFbCnbE?=
 =?us-ascii?Q?6N7rIHjwdVi7A/4hIl1xoq5T19DjtBNJneLmE7fGN7nDxhkeCJRxVRFdpEtJ?=
 =?us-ascii?Q?7mRxueU7rigxA+6a5aB7Kt7G8uw3Yca5RXHHB5p+hr+QbtiPqK51UJjx8BwV?=
 =?us-ascii?Q?LkbpALuGAwept478pNz++L4nGhTmvehkGQ3Es/LLvAbQ8nlpdUx0J/XOZ1sJ?=
 =?us-ascii?Q?rVqnotqNY68fGKNI2srOT/KCb7xh/hBfo4E9sPbkyvF98dxhreuS60jSKR/9?=
 =?us-ascii?Q?y2+TAIiYv4v8kreaC3dp5Yge9Qe4qlXAnQ0Th0UWL+6PbAofM96Ctl+Q1u5b?=
 =?us-ascii?Q?RQwLagIIT0DidqC4bGXJFnESykaIDgMqUnGyOJRa5Jr3x1mxetMQMqLT0vE6?=
 =?us-ascii?Q?j/8UAjTRMbSINaxcTDI3fb1oIabXWNl3A9/wPZF6Ze499tNUNAtyH9Q4SS4A?=
 =?us-ascii?Q?jOpiaVZmoehOegbgPPgVcSXY1/0+k4CemKvWgtetjklsEuwQsYiC3zj2etKO?=
 =?us-ascii?Q?lvkuBUPdS6gQ2PKx76BD6zQlzHiqonOfJ4BGisbbutz2Px21mydB1DLVd9UU?=
 =?us-ascii?Q?b2696fA3F5anLqasVowZlI9r7Zi7KShaXCkbbBMdRGzTwfQummuH/RpKS3A0?=
 =?us-ascii?Q?+167kO5xy4fuqz+uqUKwABPqykwg+zTcFmuJUj7XGpjnqsuEA6ea55TAKW1F?=
 =?us-ascii?Q?g0rRt3jC5ibmpFEkzdblx67Nya41GxWtxyvLgywPd1OmIaLfNF30vNw6yuqU?=
 =?us-ascii?Q?3iWIYMYVVvZAtxNbcX5lNprNZF1sg6OUUXnUENgKufMgq8ytHyzFFCT1q0FT?=
 =?us-ascii?Q?gDNt7gEySskwtWUBhNCKPAyBSu4gTqRUIsQ+QvJ6M4VdLFwI00ZGCtyIG8/m?=
 =?us-ascii?Q?2XZWqWkLF5SuhKxLt+aJHttf9BM9jYIxm3FR1URcoSFjAEPIK4UwBJadNVbz?=
 =?us-ascii?Q?Q/2KafG0jFwFGeobVuhDbRsUkG5q++nCqidF/qOn3bEtLd6LTP57lnt2WmBn?=
 =?us-ascii?Q?0AQiIrtLCj8iEu8SKMVwu0EVNlg85A+2gZtHp8GsgG/4zF38mqHIfHJlw8dl?=
 =?us-ascii?Q?vKsQOYr23HxxnfI3PRMXa4XaFAVm4sKEmAwZx2GqJjFwlT/D8sSw5sxhVS4Z?=
 =?us-ascii?Q?0KnqIFlF713JREJsm0l1xR9CIgVPijNO+UubBTEw/veD2qHB77nEEw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+1cjBPggywTcejPFxA8utIc3nkbj3gddcILDTiPcBZOtip3zepAkpeOaowUL?=
 =?us-ascii?Q?I7c1Twb4Ld4XYUY5SDuhBJvtXdS40mKEYLsALc/oX+vvzOHWkzpdeL0sBbnx?=
 =?us-ascii?Q?61iebhATwJuQydjO0vJJ9RJzBCc2mXg5zPw0oUel16SRVNxqefg12FOJL0Ru?=
 =?us-ascii?Q?s9lXjT5bxKZHnCGAghFxXLP/XbFuKeDyVSvnwfdbl6EdI+6q6EOapu19JXSC?=
 =?us-ascii?Q?cvY7tMM1b3/rAQwf5woIxIa7quGFIw5tjXfdfwzskq0MWyWDwDp9/UeONIIp?=
 =?us-ascii?Q?YsKK3EKYxm021Vt5PLGfVGzN9aMSkIQS8apNnEO3CZJgZ5aDfYgeJyDz542e?=
 =?us-ascii?Q?uJbVf4dOR+1kIK5U93rRMz4Xn6ou+1+v8kOoHeh6NPcoywuw3lJ86AMR9l9S?=
 =?us-ascii?Q?//wHcX71bsrjtLBMZUln1+6OvPPJFDu2JazhG90hFqUU3vaTGVIYjAByHW5h?=
 =?us-ascii?Q?DVPuTh+eDpKnCJID+yerIBctcZTFhwB4WDQR/HTvhSkCPP5rcIL7bQUhKi6l?=
 =?us-ascii?Q?a6MUL7nQbgOk7CLi2cZxASzu+payQ1dPRm4hd2NRFXP0AcwcYp5VjL4bplbs?=
 =?us-ascii?Q?tDJk4IxK4uydOtTKPPAOFdoHjf37F0Tau7t3DaXIpzjbocNBjtpBUoof+7/w?=
 =?us-ascii?Q?vCi/uSFr6RPxEy2KhRP60prgreH4bT0Kn15Lxu18flcS5OuldDqaAOIUfLJp?=
 =?us-ascii?Q?MLI5x2tmk7eLqL+SCRRGk2NAKFizbgt0na+R36z+feURwHIaVXgjYZYZ+AlY?=
 =?us-ascii?Q?M2cupJ8vmo5HuBVOhnBXiDpmOfOEyM5JwOfNg/CgOKDEICOSVFJ4yplVXK+2?=
 =?us-ascii?Q?XnoCQGM023JP5gBkJz2fwpnwphIYAZ20lI1Wb+9qhYW72jByukkhsP38yP3y?=
 =?us-ascii?Q?T696Su740/7AT68G+dZaKIFU7haer4I9hNEylmDDEXPtVL8Z9MWQ/aaYXFe+?=
 =?us-ascii?Q?pJoM3/cMOHCmkwFUJ5/MxWG5dCyMQWDFX+aNG0ZqqZsSNCQxhnHxbD/tquRo?=
 =?us-ascii?Q?HM9DIJoVp7NVXbXLbueNTG4HKcyHHTLgWlZB1Z6qbPXh3Kaq1/lB9GHHRnn9?=
 =?us-ascii?Q?A9tXfJa2VC89EuhQLT11FcD6x2SawUgvEy7zFUSWLmswruAz7GC4bGOg7UGS?=
 =?us-ascii?Q?MUS7z8k0DTpCEO+HLVCb3+LQza7EoAQS/b6aEU2Slgs0pQJa7+Fo8HL3p0Tc?=
 =?us-ascii?Q?wb1zrWdeKdoXso78vZugHAu0TdoBH2cIy+6ZIRV0szew3aJS0WpbpJ9Z17jc?=
 =?us-ascii?Q?bDVwLnXd4sfO0+4eZ0Di4EMpBZomxbi9RUd475RsqtixKuspCX87CSC0ScB/?=
 =?us-ascii?Q?LUYWUNxf/kmhNVzlq+FRSWemmvOehCQDOKb62obB/xZKa2iCwws6T+zDlKcg?=
 =?us-ascii?Q?IQ4p+yaXm/74xzeSNMqQ32Dd5lKvzVh8KIngM45TYVWMlfdi5C3CpnCtW81C?=
 =?us-ascii?Q?vMGQbEOxs7ivs015jWWzglfgh4hMUAconP7K+gV+cDTFny935rtNSHaGRcXS?=
 =?us-ascii?Q?zIEf5fuTSRKGYNiYWyDe9XKi21WNoZElnc33eLz7mGLFJykNBqhCw41stAmf?=
 =?us-ascii?Q?/wmVP39Mk+kcnUzYM0ZxulHPLvzYo2SWPGZhqX5K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e684043f-09f9-46f6-723c-08ddc025b49f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 02:50:33.7605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXZgYiVXKMm2+m+3Z815yfuKfmI8dzQeW4/DAev8wus1eN9nKoBAyoYmxIex4dxV1h52Lf8fT38rzOJcfR5Ueg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8030
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

On Tue, Jul 08, 2025 at 08:37:53AM -0300, Fabio Estevam wrote:
>Hi Heiko,
>
>On Tue, Jul 8, 2025 at 12:49???AM Heiko Schocher <hs@denx.de> wrote:
>
>> Ah, looked into RM of imx6ul ... it has also a SRC_GPR2 with the same
>> comment as imx6ull has ... uff... why does this not work for you than?
>>
>> Try with md and mw and make soft resets (not power off/on !)
>
>Thanks for your help. It works now with the changes below:
>
>diff --git a/arch/arm/dts/imx6ul-14x14-evk.dtsi
>b/arch/arm/dts/imx6ul-14x14-evk.dtsi
>index 1a18c41ce385..0239a153080c 100644
>--- a/arch/arm/dts/imx6ul-14x14-evk.dtsi
>+++ b/arch/arm/dts/imx6ul-14x14-evk.dtsi
>@@ -384,7 +384,6 @@
> &wdog1 {
>        pinctrl-names = "default";
>        pinctrl-0 = <&pinctrl_wdog>;
>-       fsl,ext-reset-output;

Without this, there is no wdog output to 
reset pmic, so only SoC reset, the value will
be retained for bootcount.

Regards
Peng

> };
>
> &iomuxc {
>diff --git a/configs/mx6ul_14x14_evk_defconfig
>b/configs/mx6ul_14x14_evk_defconfig
>index 0e35e5e6af57..4a6a35346759 100644
>--- a/configs/mx6ul_14x14_evk_defconfig
>+++ b/configs/mx6ul_14x14_evk_defconfig
>@@ -110,3 +110,7 @@ CONFIG_SPLASH_SCREEN=y
> CONFIG_SPLASH_SCREEN_ALIGN=y
> CONFIG_BMP_16BPP=y
> CONFIG_IMX_WATCHDOG=y
>+CONFIG_BOOTCOUNT_BOOTLIMIT=3
>+CONFIG_SYS_BOOTCOUNT_ADDR=0x20d8024
>+CONFIG_SYS_BOOTCOUNT_SINGLEWORD=y
>+CONFIG_BOOTCOUNT_LIMIT=y
>
>Thanks,
>
>Fabio Estevam
