Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2088DE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 00:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 368CB8006D;
	Sun, 15 Dec 2024 01:00:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ld+lJ1+f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC778006F; Sun, 15 Dec 2024 01:00:07 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56B2A80066
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 01:00:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwaUzro0dExLDR3TOosXZ5JEZL3CmWeUls3IHoT7IVHjqYAMDODF8jpeV0SGVbJqN4eFDw6Ae51lgKcJNZvVpbNZxXKZHHy77BGFaAOPEwYMagKYzfqWj+cVoeDH1lxucILleKDqyxCJgyNL5Ttaj7kZA3dIf/oJA6NKyE2f+fS5dEStwAAUR/EQA3Y3bsb5960vV4rCKV9PrvFMft2M638IoGSDqhxx68OLWw+njVZaI7NeudxkRC93/wxYBjLwWnCGXiFTnNi+MasigStyOOVDO7/WHqDAiwc5XoUYt2f7zyl+/yoQ7/8VEthTbfFfX/X3ZU9MiMWRzY6TG9Km0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifCpSIT4KP4inSJhhwUG1kRTmrvbD2VlTiOerXaODxs=;
 b=SnCDj+tI6sEXiVO5zOD2WNWTxCJwUiMDl7yXexbUaZaRO6PcScTg6vnPMrZxFdwl5+m8QMKc9mR0OW4TA3jD0Y2bwza9IRg+dUYpQPkvsE8oS4m/h/Akcp5u0bzu2RrUFro/2/l8eHyTKxBSuMfL64cjJoO5yEpHDyAPVCSrCBVwAMj8L5sYrMAt/epqTeSM0GvYI3djoxFSDfVqkeIRm3PYoLbD5QdBVTNRvxz8b+ZUiGi7U9eYubaA1XEhZfHGulzdY5DWoTxUR94o326Ge7V28Wvh/Quefszqx9haBB6H/f4jOr4Jwz+MCRZ58AGHbvxhVz00WahQYGNb5ezEGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifCpSIT4KP4inSJhhwUG1kRTmrvbD2VlTiOerXaODxs=;
 b=ld+lJ1+f2F0r9Cskbarf5MlmSjMxw+4d0BCewu/FlVgQBknfpLMKUXsqmqXDjqlCBgCOglgyIM925/yD0rRZ//Q60fM2syJjPpZb2PEscM9uAIdjAC7zVU8sNaXS0VW9GQyATQAibv9rzCgusLMzIYmqN61IF1j5YCIDFKTtBFRt/lx7pXw3XRCOMWXb4+R+CFfrheqLvHZg36EYFeNbrl18jsPgEEtZJeZCAMF4pFX1soyohVCx+G0FU00hufT8GOzRvUA78OXHFZj/SdVcBVKPyImrClZ30dkyj+wnJ2+HFRDokhlpNDVV3BLhQpGqgv2Bf6vdbGILgA6z1aHhhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB10025.eurprd04.prod.outlook.com (2603:10a6:800:1e0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Sat, 14 Dec
 2024 23:59:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.015; Sat, 14 Dec 2024
 23:59:58 +0000
Date: Sun, 15 Dec 2024 09:05:18 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Abdelrahman Ibrahem <mail@aibrahem.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] arm: imx: Remove arch_env_get_location to fix env lockdown
Message-ID: <20241215010518.GA16463@localhost.localdomain>
References: <20241107125122.48361-1-mail@aibrahem.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107125122.48361-1-mail@aibrahem.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB10025:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f124c7-6257-4629-16d3-08dd1c9b6a52
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P6t2BDmgqvktBlevaiESuPDVXocO4dr1JyVa1qYUL1LSoAXJExFMRq7swHu6?=
 =?us-ascii?Q?Qc4rp0KYgmbjU2hz2FhtsY/yhPoz1LQ75jR42JJJOYXPoY4nQ4T4UHItpAJj?=
 =?us-ascii?Q?CQBmOiyKWlWCfs1fmJqtWA6qLHLQVLZpqZlIa55NGwp0s5e34+RbOo3gDtRL?=
 =?us-ascii?Q?oOiC2KXwBCOOnOhF/y+gE4BlzlsXY0R5z04DZwBTgqFpkePXtUSm1leSfkI8?=
 =?us-ascii?Q?W7iQmiHpErqLeL6qpMCZdZ+TMM8m1/HfyVpvCcxOW6tArXdGDdG+1T1BKeF9?=
 =?us-ascii?Q?VqJDmrCaPNrRbtMgFCFQTBNYo8IWKiACO0tNKNVP/1N/t9XkPrLuXOI/EtZK?=
 =?us-ascii?Q?YM5U3SFD5hAYMQZe/gUC4Ez9vJ0/B9ezOaF1QkbhTYO7PmwSdwe7xY0TRpiu?=
 =?us-ascii?Q?1FbpSN4ZRhfR7UYlYIBSZ9K7xOopaPAkMQEJgLbAqLq5+BZXxFahNLh24D1J?=
 =?us-ascii?Q?3Hh77SwMDgKcz74FURCCSK1wpaIiZc2K9V6tkO23/dONA2Q2uimSS6Nzhrr6?=
 =?us-ascii?Q?gaulBAmc8S5fh+pE5V1tkqqorCLYFFnNhiCvYlGj4XhkezNK2QjM9AV52G8/?=
 =?us-ascii?Q?ijtS6Vmoh5k6UCmB9LGJwztoc0NoCpp+q2ljzcVnyrDnCWAs8GzYUMopRk6P?=
 =?us-ascii?Q?RFp0q1z1NlL4Ex8m75Vaew2aNWLQoYIGU6iUIl7qFapxJgZwlvFetE8GIrrz?=
 =?us-ascii?Q?k3dxeN7D1g4+0G9+zwIm2xEnLW5qekmtU59elgNw0CuNbkcAqRKf93VoMCyE?=
 =?us-ascii?Q?+xG8Kn8gO7TsY04a5dM/MONvCp1vDE+/PEfnk1IAv+IGdABEO/tOOwwd8S4q?=
 =?us-ascii?Q?KO5FwRL2qm8TAzBqWN5rf9NJCJK2gHun/69g29q6x5saATqGu+rpDP1TueOP?=
 =?us-ascii?Q?jwHZndwUH6YpBjHTZxGc44HMAHxVO4tEHQBDT3OFZdvvTuSWakr9le9MpAd4?=
 =?us-ascii?Q?tCZkA5pSqh7gVxXL1QHk9GjdJNbEPxq3zXShUV03mXZjIneOF9qCIGXC9bDA?=
 =?us-ascii?Q?La69vt01RQ+riDgTMHzBoz83+D2QswbxhOPpyO/FZxAJTfTP0PjJ0g1wbdrk?=
 =?us-ascii?Q?wKwYF5u4K0433xQBWy9RzaLNwHTlImxpne/Bbb0/c4OjD8WLM6Y9ilqYoMG/?=
 =?us-ascii?Q?JDqBHa9E1wCI/D7PpGyfxmbjnP19AcmeBJLBqy5kvcXxnH2aktFnfvcvMAww?=
 =?us-ascii?Q?DMacc3k0NquVHM2YuVIswiFgc6jJJJsRzVFiYYI2NtZMpwL2/1k1a1xAlYic?=
 =?us-ascii?Q?9dasx0/mbKtTXuHcyL2rgkGbgNVEmLXQiQNTXLbCk/FIYWi7maMr9vsLUS3j?=
 =?us-ascii?Q?M+di5kF/imzchmLIFaVqNjEiAUHCBP7c5icbWwUrE3trpyeD+T6hnNvVoTcT?=
 =?us-ascii?Q?FvKbvdilfqmv/J6KI+GtCHIabLmk1ltVE1+coIWl1pBQI1KIBgaqY+S5gCqS?=
 =?us-ascii?Q?ndyDUygiBUhtG59IEgc4+yb/ZtSYhpAf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8mo5TR0oF6bUA9lz96LtQWrG5CeOWXdXoL8edB+gKU6zgjk3yEYwcDPL7G63?=
 =?us-ascii?Q?0SuEqlq7heozzRafEoD6wFmhslBeE7rlVplq6qRjBmkVEyJJpWgzNy1gwVV0?=
 =?us-ascii?Q?vrbB4GktPAm4BAr7YQ0P8t7+aJJxC2haRnjcbDrO07hW+UA8MuDlVIv2AUd4?=
 =?us-ascii?Q?2jdj8DTdNaE+gpogb9CN8x5tLGPwthAvyhr2S0SL1E9RpmwyW1cdm+DHyWCU?=
 =?us-ascii?Q?WIzJh0OxHsM3vNYZCwGFL+TvDDFQFaySMq0IFfYpxIua0DDrpC6m+usC660X?=
 =?us-ascii?Q?a29rsfIqhdEHuD+qiic0gB22o34BLJdKc/G6SqCIld1HcWDeer825sg0QTLA?=
 =?us-ascii?Q?MtTF9oSiuxvboon90V+5H8rYtoozl6idwQQCFX1bM0ovL+XydfLCVsdD0ETV?=
 =?us-ascii?Q?288JDx2vqW8YzQAQ3LC6Jo1zyvtRBsQKU0YWpe9XlQRJpylq5WywPxIj/5qD?=
 =?us-ascii?Q?SG4sEUtyIZ65DqyasyzSPd67Lwt0vFp3aXqUmNkOv+zAQrnLLISP89yI22m0?=
 =?us-ascii?Q?C0rMoK27jYP3JQ3kbRyKzQ15fIQ31R4Q0Pz0fj1qXfPnHCj2RHFlV28g4Cfq?=
 =?us-ascii?Q?IT/1sR0/DLYkDXlsqePZ0CEt9lcgM+HCp5cFkjyxdkoEGMmmUKNpM1LxXtCL?=
 =?us-ascii?Q?9mP694VzW7CZSCFmXX6VuvZR83EULoeP3By5vWweA711YTWDxxvhsZL0wyo2?=
 =?us-ascii?Q?+klsGQrNGQoImRlQFhkEVqaciRy9yxoFn0lKHWf0MXpu6ft355ih4aDPYiJM?=
 =?us-ascii?Q?GIOdFkTtULVez9tQDJEP4N/q8bCNEd6uz1MhKECSAPle33fxnWekSVznIxFR?=
 =?us-ascii?Q?jKFshMleNws7I5J3kORNzk/L8QrM22eKAdTbtKLoMp1trWX/JMhzHHC+gh/s?=
 =?us-ascii?Q?k9X/emreNr2+OUnciSOtTw17KoAIUOIeW5jG1ZitV1J/oDYI5eWCGG12URIa?=
 =?us-ascii?Q?Yh9AvOIV4VHMtB/WnRmSgqm4vnfoGQG+GMFQyUGJxCP2GbzXNy+KUGxi6B/+?=
 =?us-ascii?Q?WugUT++PdTQNySbuLhPNoVe07sAchdW7l6VX1FSwfjqdQbQ22iG9H2iG2nTW?=
 =?us-ascii?Q?4cO4Px+rRUHM02FQJO2T3pMTYfRe0ooaOptAPPjHIcv+burABIRnzmM7/r0h?=
 =?us-ascii?Q?SslPgR2ar+yzAjz3d3STi4Z+xloiQGforVsxkN3A86idFogAFdJcdA3JMSAQ?=
 =?us-ascii?Q?tZUIM26gEWdT3luMnBBFaW7FBlYOkja+ovax25L1n+dp0IP+Isk34N8djVNp?=
 =?us-ascii?Q?XM7f9QSl+miiNURsqzh5IZDvpM/zLaLTOy+ovf7rDYeE5aU0oSCAFAS/ZWYf?=
 =?us-ascii?Q?XuBZUf2VuXXO+EAwkbUDwv8FDdGEDDVkKljt5+2dobsuh8o3SNhVhwU4W3Jv?=
 =?us-ascii?Q?jTWntEqHblfIQI8EX+iBD5YHw0bHIIywMeArOdsbzz9BGOcvef4DdwLPz2V/?=
 =?us-ascii?Q?aul08yF+Cj9fnDmB3y4wRFXg40Vq/8KK3Sjn9hwEkE6VR4n64oCzMdmRZua5?=
 =?us-ascii?Q?oDI01ptio6OpJOlVfzRJjahSBc3Y3VtHUmfWo1I3iuiOu+ZLb9hQru76wVnQ?=
 =?us-ascii?Q?PBJvvL8ufSvQ4PHb0SXRJT6poAdadAy3U1YK/rmY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f124c7-6257-4629-16d3-08dd1c9b6a52
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2024 23:59:58.7389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mqXVRYZ9RymQdBOb2faXm2evjyUBe+Acp+iygA5rxM4FD79+iB2yrg0tIadGrIWUfOL34YBkgV4VQWE2wQCQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10025
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

s/imx/layerscape/

On Thu, Nov 07, 2024 at 01:50:44PM +0100, Abdelrahman Ibrahem wrote:
>This patch resolves an issue encountered with Layerscape SoCs, where
>attempts to restrict write access to environment variables to enforce
>secureboot are ineffective when using the CONFIG_ENV_IS_NOWHERE
>configuration in combination with CONFIG_ENV_IS_IN_xxx.
>
>Signed-off-by: Abdelrahman Ibrahem <mail@aibrahem.com>
>---
>
> arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 41 -------------------------
> 1 file changed, 41 deletions(-)
>
>diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
>index d2d3e346a3..7dd5f429bf 100644
>--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
>+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
>@@ -819,47 +819,6 @@ int mmc_get_env_dev(void)
> }
> #endif
> 
>-enum env_location arch_env_get_location(enum env_operation op, int prio)
>-{

This looks wrong to me. Drop the arch_env_get_location would break
other cases.

Thanks,
Peng

