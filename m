Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A32C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 02:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 118C382AC4;
	Tue, 15 Jul 2025 04:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wE1iccZv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98D2282B07; Tue, 15 Jul 2025 04:37:44 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ECCC8277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 04:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHBCcAeFiN440PDykpvptZcaUgR/EvRmAmZhNSiA4Bqx0Bolx5vDn3IABo+LFQBROK52GVXl7O/g4nvIShT7onseqbMVtFt7rYWrNN6/PDV9gcdMb8Psm11eUBwe5EwdVHoszMwS8B+w1ckKhqTaGm5spbMilENOBdYHzZ6nVaDTUSVtQlrcC11KYwQR1oJexbv1mnnGIK5k019WSgzzopjtDlmtRyhhi9yfLJ2KgH2EDyCc3ELITcGyJn+2t8t3BbVgghkq5z6GZoyBaAkvNBSpy1bEigslaX4SY1lcTDRRq9D27nHhhOzd3g3pEptbDfY4lPYhVrW+5cpVth8arg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuQghIR9zoUs5Cn4Wkk/+L0Sc7emW+xQv3sp70pQuo8=;
 b=qicINcvZ/HO+2r10lUgFS36dfQHSXQhteW0O0KwAfF37NS13CFW0rlX5YdUC0Ezpht2XiCVBT9TCYfcGsfAeH0UAwB8iSspRlh9xK7ZTtRHcy0NO2m0LTcLbEND+OgWMd4JV3IRd1xscmWd/fhqXP3Ipi2hyXqlZ4j3xenDlWAq554fmSokk60bGQcltzFb6um0Q+ujCYJJk6CHG/dKIZds9rbV+UvUqvWQnJwTP/aWjOtQAIv4GdqYlrUsNft6EnBpL7iM5h9xoPXwq98G7mwC4rtpaDlIgC31plibSWnME5zcBBsOoxdccIZyUbzzuPnLKFi5Tyw5gh3z4MGejJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuQghIR9zoUs5Cn4Wkk/+L0Sc7emW+xQv3sp70pQuo8=;
 b=wE1iccZvOANa/jWmSD5fLM7Vs+J2Z3Vv9Hmt90b0Z5PPVuLWZldSgQnuN3HmyIdSCPu63SDC8V/axudGk4saaQ7k46YvdrcuV/LbtHHUa7z4q5+WDL/x8s1AOgXeZOPKT95UYH/yxZ1h/Qn3FsoxR9fHtkIA/5XVzC8OkBiFjzcKP0y8sWiId4suEaef2aw7UMcOuw13RVnVILCA2ohVy6d0oURqY645d7gOpEo7ZSv2SJhpN4AEsxAfxmZMmbG/gJXC9DvslDD7qkw+ubc9tbKiZJNoGdNmSd9gQidHlHGJKluEYzgTTIRA+7GGsznn9w/4DibbAfJnkM8Ij4IoeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7647.eurprd04.prod.outlook.com (2603:10a6:102:ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 02:37:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 02:37:39 +0000
Date: Tue, 15 Jul 2025 11:47:58 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: John Ripple <john.ripple@keysight.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "alexander.sverdlin@siemens.com" <alexander.sverdlin@siemens.com>,
 "andrej.valek@siemens.com" <andrej.valek@siemens.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "hs@denx.de" <hs@denx.de>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>, "sr@denx.de" <sr@denx.de>,
 "sbabic@nabladev.com" <sbabic@nabladev.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [PATCH] Add ahab_commit command for imx8
Message-ID: <20250715034758.GA632@nxa18884-linux>
References: <PH7PR17MB613046F296E7C25AFA85DB7D9C54A@PH7PR17MB6130.namprd17.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR17MB613046F296E7C25AFA85DB7D9C54A@PH7PR17MB6130.namprd17.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: cf55d94e-289f-412b-8e1f-08ddc34890d8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|19092799006|1800799024|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/aAaJszhIDxeU8pw+wQSnxPo85uU6dGd2foVwuJrulmCVbPkl8WrbMJaMiFu?=
 =?us-ascii?Q?0EN9m0REL9JpBvMslER9yMK8IWBgo6ktY3SXK18OUInAGBUEikX9jYavnPoS?=
 =?us-ascii?Q?xSvlnQ5qk1q/cnu0Gzmq8PucN2w6sYAOVu8+jYLEfdHmjoLdrvVjfC5RfQgi?=
 =?us-ascii?Q?ylHBINKt9QmpTmx7HbcMtJatF0Qx7YUSdS0E2Dm1oZrMUPtDdyuXHf41rArx?=
 =?us-ascii?Q?YUQZ4PzU86Mzo5mlJX3ruKHE5MXzPjO3HGfrNln95bOGJdVHCyGsKKewW6U7?=
 =?us-ascii?Q?TApxxPyUc3Vxhst8M+gtdY7UuYFy2+vTVWppKBHfko6/aqBN7wYMEv8i/mxT?=
 =?us-ascii?Q?luFrZTxPkP+qTveGtIKY5Mxn0w1pBlhOBuel1hjJ8rvyB8ZwxDQmK1VbpJjT?=
 =?us-ascii?Q?8LbpdGjPvsdyMp8iP3ck4RUkn/BcWY2+6Lp1XWsChLf+tSaZyy/Z1soR0sVr?=
 =?us-ascii?Q?D/P/sbEkw8x4cotUySlCksxB+x7rqZy3DJovpJQ61Mi7JTrSFz0O5m04Pt/I?=
 =?us-ascii?Q?8JDsgyIJae4wu4fSE50j1D9nu1eR4e9eJwVbUQwc1mmNwBeUryeEriC9Shqp?=
 =?us-ascii?Q?f9FTDMfcJvIm7ArROeIAHb7ItiKf1nea48hijCpyMrB42xHCZmmvdd1vbRt9?=
 =?us-ascii?Q?xVJr2Pwo2xAMuNhbJeOqvlaFXTs/m5wBSlm7GNOsdP20/QbE/FKsKdM9n5ev?=
 =?us-ascii?Q?QnpO7hf6Vae1VorPEiNsEVpdoTQuUa3MZ8ZOmCsiP7RIwnt23joUKgsgwJTF?=
 =?us-ascii?Q?E1fyduR/c7mWC2aRRMmgiNufvUgVNugj4nze/3cAwHAdwZjrE/T47MiuGiwx?=
 =?us-ascii?Q?v+e9l28buFVdiuNgpIYWtLepikPGwO8s9CP7EUBRpkJb2JeWwtyvHPkEr+1A?=
 =?us-ascii?Q?EH8InuqF+hfjD9bxUS7kMpCH+kYKvt5JaNWAU0M5k/x9HZD+6b8qUWvhZsAc?=
 =?us-ascii?Q?PDzg9dpfikZMXqCA7hmTyD192irojj3hROYnQL34CUJFi6+0oskc4KPMW//D?=
 =?us-ascii?Q?/1o9JU1RCpFoTn+3QMT1jSin+e1/Os02yakUpvP0ZO60lCXdyUGSv7Seb/ir?=
 =?us-ascii?Q?x46iKuGOedZ4a/viZ6MsoasCZofe07R0LLACw1Ebndsj2244CzxTGDCNB2e2?=
 =?us-ascii?Q?5n7lFBlqWSMarjejvhC/c70FdeLZ4KPB0zSI863NfMbq9SULbOzqVdrcwo5v?=
 =?us-ascii?Q?T5vKki5t/QQOF/STp+nlQ6aP53DV7TD/w8ii4zsrBK5ZKgjLifn5sSjZSoTq?=
 =?us-ascii?Q?fyVAo/OJ8EMM0O1G5UpXMPfOqYi9jbZh3J7hg8nqwRq/uALp6zO4jR9F4Cz0?=
 =?us-ascii?Q?UKgPyZROhV+l0H5aiq1tmSL6e6qExUYZCarkv3mR+rV//DnriBnrtalMnv7c?=
 =?us-ascii?Q?Uwt/Z6XG/Qj24jDfZ0dvgLaLVGCxQIKyefH1AxGbNZ4/0uQVWWLOME7viGmM?=
 =?us-ascii?Q?Zl5QIVsyxJLp4SclzcSP5ujbSlytViLVcQ+5CUQNpFzHcIH4B15/pg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZB0wVAIWcKR2wH1VeZPZer7LUGXSD6ZCZG+mFakZatrOeKuEQMoM0Dk06jmr?=
 =?us-ascii?Q?CJ4HaA6SoWOtgBGlvZ+amlIu56gYANDB0ATbTqPX/SsQImlHn0r+/XKV6XPk?=
 =?us-ascii?Q?6IxTryHZZPr/h/IpMVOCMVA0mxW2DqQO/iGkO8UNpW1DVPpMiQxHP0ERkO5f?=
 =?us-ascii?Q?zh0YiW0kT6CArRglgZDHzvEF8ewb36cP8yIoajdqU/NOxWltVr7827dURDxM?=
 =?us-ascii?Q?3AeUmUMeIatVr2ArcQ04CZnImw20xUPLOGIiBTY98EZEQhfEPTLonrEx8qY6?=
 =?us-ascii?Q?3p+L+372vfKFFyXKZkJZ5qOpBFULsrCmpq+QfPSrBauADDZVxAaIdES5JjAe?=
 =?us-ascii?Q?P/ZpX/IM4fwdfIDOYOfjMjxfXEpXWB/h4MX/FzeIDpRh1/h2P2KwdizW3uWj?=
 =?us-ascii?Q?pfM24XCS0TqFoOGFi2O2H9A7mCZj2DSCpFkyMBnsQfonobf6Tliq12JMVgXW?=
 =?us-ascii?Q?YpyQ9kS2gXHQAp/baPXh5nzlJ5zE0xIf11RvjLjRcaeylymzqullaWTZN0WM?=
 =?us-ascii?Q?mul7Ia5MEBopAL3gseP9X9eHLIx+6N5Buih0CfbVJ3Wn2rpmWSfp/LgApQNs?=
 =?us-ascii?Q?0IE7i5wdrWCVHjmZq6PL1BRCPSGE4RE8OIfDoa4ZaT4Q0YMx86m496BMwpjs?=
 =?us-ascii?Q?Uv9JJnvshpAn9JXZdZ/KckX3tzStAtS2+meGGK6mOwJJUIJd61/dXjt9CImF?=
 =?us-ascii?Q?ykXvSXvLm1i9rV05A+VR0HqhxN5tOs+dU10Q/5yOLPcpkDAAcILfxFKWu/VE?=
 =?us-ascii?Q?J/lFNpau62HfDvdbXQaax8LHMhjGcvMk/QfMLKqqQj7u2uY4GTZyLCF1MWiG?=
 =?us-ascii?Q?sS5585MMaLGIGgL3d+SVq0wYXWZZXAYEsAMYMfAZsM6NcFcv1yjIj82MrMvV?=
 =?us-ascii?Q?C11BtCYsKl3O6l88Squm3tkQcnFQLbS2DIRQu6ELDXfupOGz7tYo3RPauMs+?=
 =?us-ascii?Q?afvkNr5ToPyEjHKSdZYh6Fx9VjvxnggfydEN1BL/pVSvEx7iTO4bbfH4RVOy?=
 =?us-ascii?Q?d7KtTj8c+SDOp7VERspaiILUNhrV1vtoLV7nITlx8d/AVDNck9dG+aYDbERv?=
 =?us-ascii?Q?1NLA28D90/76r++TCRBjxFlMAbUXsSs0bKx3fJQbJCWMGnfyhKyvS0dlfL6X?=
 =?us-ascii?Q?W97nDHWInrxF8APMLfhsQKLZWJKduPfzDEPSQy2TA3Iwx0E9Jy2LVWl8cuCk?=
 =?us-ascii?Q?uUUMhQjcolp4snLcW/NERFygsra9LrtS2Px0CrFOUMt2ax730PWhgKrpswxc?=
 =?us-ascii?Q?ytGgHteC3h0KPWxqV6q0+9uZ2O1Fe9rLjNAPUGo8B/WFFRCTmHMlWF9UudT+?=
 =?us-ascii?Q?70EoPZ/mH2bibsgTiv9ARDbHa7W919YJy+NgkqgTTN/YQSMg9W8mSpWvDSHd?=
 =?us-ascii?Q?6etUTQ4+mwMv5pDWGF8z+U3TDEuAkiC9vHIQit7GMWENZdJRKAZS3OS6kaRW?=
 =?us-ascii?Q?0LORkRAjV0sDT8bY7BjUW+YGdVKoIF4W5dlM7HFo6mTAp0D2v6NxeeRC3NGG?=
 =?us-ascii?Q?J68/bNwb22zSdN5yL757i2hSMK4EBwsTi2qv9X3Oggj/xJR5KNViWyp/XZhE?=
 =?us-ascii?Q?vNUfbRbgYZerdbBzrrx7KpsGQvFWZPOdCW1jjoZF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf55d94e-289f-412b-8e1f-08ddc34890d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 02:37:39.4432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jD1nUPsO2yyuFG5s66lOPYo0O8SYa/082fVkQMiRVGkDrkK/SrU4q3Y3LQ7+DyFABRfREJw78r4ARKPvCJkbBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7647
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

Nit: subject: imx8: Add ahab_commit command

On Mon, Jul 14, 2025 at 10:07:29PM +0000, John Ripple wrote:
>The ahab_commit command allows the user to commit into the SECO fuses
>that control the SRK key revocation information. This is used to Revoke
>compromised SRK keys.
>
>To use ahab_commit, the boot container must be built with an SRK
>revocation bit mask that is not 0x0. For the SPSDK provided by NXP, this
>means setting the 'srk_revoke_mask' option in the config file used to
>sign the boot container. The 'ahab_commit 0x10' can then be used to commit
>the SRK revocation information into the SECO fuses.
>
>Signed-off-by: John Ripple <john.ripple@keysight.com>
>---
>
> arch/arm/mach-imx/imx8/ahab.c  | 27 +++++++++++++++++++++++++++
> drivers/misc/imx8/scu_api.c    | 29 +++++++++++++++++++++++++++++
> include/firmware/imx/sci/sci.h |  6 ++++++
> 3 files changed, 62 insertions(+)
>
>diff --git a/arch/arm/mach-imx/imx8/ahab.c b/arch/arm/mach-imx/imx8/ahab.c
>index 324e010bb2c..f9a425c899c 100644
>--- a/arch/arm/mach-imx/imx8/ahab.c
>+++ b/arch/arm/mach-imx/imx8/ahab.c
>@@ -401,6 +401,27 @@ static int do_ahab_close(struct cmd_tbl *cmdtp, int flag, int argc,
> 	return 0;
> }
> 
>+static int do_ahab_commit(struct cmd_tbl *cmdtp, int flag, int argc,
>+			  char *const argv[])
>+{
>+	u32 info;
>+
>+	if (argc < 2)
>+		return CMD_RET_USAGE;
>+
>+	info = simple_strtoul(argv[1], NULL, 16);
>+	printf("Commit index is 0x%x\n", info);
>+
>+	if (sc_seco_commit(-1, &info)) {
>+		printf("Error in AHAB commit\n");
>+		return -EIO;
>+	}
>+
>+	printf("AHAB commit succeeded.\n");
>+
>+	return CMD_RET_SUCCESS;
>+}
>+
> U_BOOT_CMD(auth_cntr, CONFIG_SYS_MAXARGS, 1, do_authenticate,
> 	   "autenticate OS container via AHAB",
> 	   "addr\n"
>@@ -416,3 +437,9 @@ U_BOOT_CMD(ahab_close, CONFIG_SYS_MAXARGS, 1, do_ahab_close,
> 	   "Change AHAB lifecycle to OEM closed",
> 	   ""
> );
>+
>+U_BOOT_CMD(ahab_commit, CONFIG_SYS_MAXARGS, 1, do_ahab_commit,
>+	   "commit into the fuses any new SRK revocation information that have been found\n"
>+	   "into the NXP (SECO FW) and OEM containers. For SRK revocation use 0x10 for the value.",
>+	   ""
>+);
>diff --git a/drivers/misc/imx8/scu_api.c b/drivers/misc/imx8/scu_api.c
>index a40c8badf9a..ba93ff9bd74 100644
>--- a/drivers/misc/imx8/scu_api.c
>+++ b/drivers/misc/imx8/scu_api.c
>@@ -1287,3 +1287,32 @@ int sc_seco_secvio_dgo_config(sc_ipc_t ipc, u8 id, u8 access, u32 *data)
> 
> 	return ret;
> }
>+
>+int sc_seco_commit(sc_ipc_t ipc, u32 *info)
>+{
>+	struct udevice *dev = gd->arch.scu_dev;
>+	struct sc_rpc_msg_s msg;
>+	int size = sizeof(struct sc_rpc_msg_s);
>+	int ret;
>+
>+	/* Fill in header */
>+	RPC_VER(&msg) = SC_RPC_VERSION;
>+	RPC_SIZE(&msg) = 2U;
>+	RPC_SVC(&msg) = (u8)SC_RPC_SVC_SECO;
>+	RPC_FUNC(&msg) = (u8)SECO_FUNC_COMMIT;
>+
>+	/* Fill in send message */
>+	RPC_U32(&msg, 0U) = info;

This should be '*info';

>+
>+	/* Call RPC */
>+	ret = misc_call(dev, SC_FALSE, &msg, size, &msg, size);
>+
>+	/* Copy out result */
>+	ret = (int)RPC_R8(&msg);
>+
>+	/* Copy out receive message */
>+	*info = RPC_U32(&msg, 0U);

	if (!ret)
		*info = RPC_U32(&msg, 0U);

>+
>+	/* Return result */
>+	return ret;
>+}

Regards,
Peng
