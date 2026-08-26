Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B07CC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 06:31:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BA0680B7D;
	Wed, 26 Aug 2026 06:31:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7PT85MF3dCQp; Wed, 26 Aug 2026 06:31:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787725896;
	bh=gnhfZyUHVMldHF7/AAMIlHvCXYojzOwc4fPk2GkLho4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DUQek5ohAbQJYucChitT11tBUdesnt7HAphIH1CqvM0MhXt7R59PITNMMgqWOOcNo
	 uqRETnNrs+fsEB01lTHZF4Te5PIIHvl+V+bZlRIl375YWjKb/PXMRI3kQvTdUrO4ls
	 Xvm2eRDKhLLhB34gDyP4wTrL9Mox8HuC6L2gvxHhgjOGpqiMfsRWnrmK0JYQnJsXzy
	 JH9UsHGmdobRoIuNRfgMiJ4MJd+FxX3DShITcZ+HT7ntJCA/C17VlRowtxKolmv3vm
	 sv9gr4F3PjNAjQJsRb04916uMJ07kCQBZzp+Q0EEKQ9uPR+dkfixXs2CUHenGWa894
	 TvXpDgux2AsTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D489280ADC;
	Wed, 26 Aug 2026 06:31:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1157A39E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:31:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 028DC40547
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:31:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CVhln8QgLVyv for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 06:31:34 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Cf5Roonm
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3264040545
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:31:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMbbD6rxsJ2saLyj2uD7nCcfFYrvd1nNJ5grAL/3gKjHHNgTKrmkZlx7Qsqe5NrEZnIEJKoXcAeHrLppuaY8uUvPpWrLNIL3jKNH4S7HPDNYgrI3B7z7OX3EvsgV29mV/mZ+u+mwzVxXNlSncrrcGeyiGyNCAxH/Mp63abTJdFJP9PqXNUnzGNLqFWb5yc/M9OBZd1yEuB/uMMBIHosE6L+xN8oH1+eIOiXG+bn+/Pt2Xn/neS6jHwcGq9mS8cy4dHUgbQAsYqsdHJVBq87/Kokv2hZDirazVucM3pG6AGrqAElfSxnz9QhKqgWzzdGsSHxcEKuizLKAlJ41zlpmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnhfZyUHVMldHF7/AAMIlHvCXYojzOwc4fPk2GkLho4=;
 b=ZQIHvKvIkaDGh6CBUswhHJ5AIoONQ+fahgGXyNM8JhK01XE4Fj+zJ68ZTf8kQxfVIkmw/y/NJUaK/lGeR0F+TtFXtUfFCeU5lUzvGPMs+J6ndgIdeHunKYfsRcbNfjjtwqRA5yr+9jhYOKmDg0qBmXmr2uok3R1JMYrZh49shq6KmFpRBkM2c+VoV1XFBlmUJq40Wqb9Wtd7oJeasxWxQVIpHHDvyPSnG3hp2Khg+DZw+KELrlalZ412amSzgGuih839OdxLWn9lHj0S4Nk7t4tioU9niFXYV5GWzNqaiPY1aDhm01VYQ10h7kQlneDCflAcc5ZRE7UPXXyVaNYLAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnhfZyUHVMldHF7/AAMIlHvCXYojzOwc4fPk2GkLho4=;
 b=Cf5Roonm/o+YD7IVTpzgenMdmd1zr0nJf2jN62ZMgNt537DO6kS125d2Pi2FYllWuh5PlDZZvH1cpixo/CpEWCnelY+1neLaEQs+frMIaWocUYy1wlS4QuCA00sPxn/YoAxZ+OV4hyLd2YvCy+PrpNDE30FKseHShbmA4n2TdHi0m1C9dNo4gpHKDeoxLkWyQWQQYwq7gWpbrB/b1Vr6W6Uun96NfCUcNPmIRiybWwNgA2K+bDtp6+ze9FsZttXvoCbNKNDjDpVZyF+IcRzlcuFIqE+Ci/zjg0RG1ImWjLVCSYwEKiOf0vRS3oyuzVixV8mRpEDSZZgMuHzSc705wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM9PR04MB8923.eurprd04.prod.outlook.com (2603:10a6:20b:40a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 06:31:27 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 06:31:27 +0000
Date: Wed, 26 Aug 2026 14:29:04 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: Re: [PATCH v6 04/13] power: regulator: Add driver voltage clamp
 callback
Message-ID: <ao6HsMvuCzelqJ0A@nxa18884-linux-1.ap.freescale.net>
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
 <20260825-ux500-external-sdcard-v6-4-61446b6c289e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-ux500-external-sdcard-v6-4-61446b6c289e@kernel.org>
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM9PR04MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 19398d1d-74d1-421e-bc8f-08df033ba849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|1800799024|376014|10067099003|3023799007|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 5tdg5geHFQjkGStSUoJx6OGJL9tlUFV+/z8m8F6fe3QRozJA/qd/L6uys7y49aV0DvtVjBC+FSS4oFB9pvG6lRzyJvG7CierOZul/0v8imw9MWgoZ4w0lne7G5joDIebp//STDu2hgrasaueDkBCzjps0nzWVOT2A75IjuhFQIpwaahECwoRA18JV/J+RDSIsFWKtDtPWmfwmrmBZ2j8LFb/997S9/uHqHD/JV9p2kutEVkPZ185Cghtj4Kzf2P6A6b11wGKwtJ1NY+v5N+M6PW8fk7PqWEcddl46Trjt3ZboUaq2FWfA0Ng3Zez4Mhu9ZeRsjQwOOOL9izsYVIgHfAXQqsOzBuw5btn8DHHw3qKp/N+SAM6dqSu7Wtn8aZl7LVlNEt3fLAbkWSd3JINlPSZpDBmcqfhZ0hwMzNQt65S5eZ4HRsP6gzoD1FD4JQmgIg7FZoc90++wpp7PSrXfQQl2QY4h+jPr8qmgwFgPq6RyxO716ES9vetI6MRyQ3bz7XPes+raSi9a891KIvLkRQO72vHUSMcR151vUZazmc20ceakIq91u1Ya/zLE4mIXJ1UITmVDGSNuPAG+zXZCnJrFH+yGL2rojnxFropcXDvghAX3do0c/sAPELSsIN5zyPK+CYeRfDzkRSlegBek7qPsU4POHeOSFfF19UmAsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(376014)(10067099003)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CRHTFF0M/OVK13WYkdrNHTBVAWG/c+IQI+w7MtYn9LahYk0OomttClH5bYbi?=
 =?us-ascii?Q?2lB4W8heuiPVSoqdt3INEhXWTE/eMM9kiZ2s2Vx1QdST9qfY9RvaJKo+Ttj2?=
 =?us-ascii?Q?bUfdWCorKKUaiCUd1wCNEuGptytcCTBbPfvZwIVzwYVdBLYk6WEOo8/zK5p4?=
 =?us-ascii?Q?uHiRFQBx9V05fUH6RaqSxMR2s+7o7Se23g6qqqC7HzUpEVZ0c4hRTvaIkTny?=
 =?us-ascii?Q?/nEI1FvrLvU0Dr4u7PKSg4/U3I165MNW1NClTCQeDiBiutNppItTZWHyxDmv?=
 =?us-ascii?Q?3tBRVNH8Yxdc4LePo36hdDHVmsGl9qLLwAJAljEBC0b/ExfhoIdKETc5QHbR?=
 =?us-ascii?Q?2Y8ZdCMbeXJf8ENJI4XS1Qb4vsbCIvY9fKUM8vmQ1SMzUvMOuJ3NukM9+eO1?=
 =?us-ascii?Q?UMOTkCO2PIR3XPj7Oo5/1ndG8XqWuHvGcqtA4k50ILSiJDPxT8DJ71LpB7R1?=
 =?us-ascii?Q?Iz73Bl4Z29EQgzi2eXtXFSugFiaJKGUbjmJq/eeBZLVHczIMpjfiSyISGX1l?=
 =?us-ascii?Q?Rm+Mvml5J8hO3E1H/INYy25lb/tHjgaLbxyB/2rXRLLjY+e71pCVikB5lOd/?=
 =?us-ascii?Q?zLflqvtP6E0i67bWUbWqZwXpwKbzxvlzAL8kIV1aA5qQlTngjg2RlMiiiv92?=
 =?us-ascii?Q?gc4Nzg548J5KXEmWTIJBURebXSPa885KL5UNYGcbzLX2GvwYi2xMCzSJ6+hE?=
 =?us-ascii?Q?Z975Sz9Wm4nChcp5D2b5AXbiBIGf10jzXYtvf8VkqFSMDTuXLO5xzgm6N/yV?=
 =?us-ascii?Q?Tka67gCrrk6hp4TirBqH/5xtpxyWKT0CKddsLp9YdkeKn9ilyFtpGOHRjHgv?=
 =?us-ascii?Q?mlQ0W10Y6TNhsKovmqZzJn8T71k7/h/lUkzgl6ty96djPyKhIhrgjGAXhhi5?=
 =?us-ascii?Q?DPB3Ni3IjAoHu9mprAjdY6Jfrc+wUonfva/3csMWUYdGsNaJWW4PMnSNHfPp?=
 =?us-ascii?Q?8L/g+pL6xq/l+NA9CK5cQh7hmhKZ1GDWaLkASdHOevKLwpP0kl9iqGIzSJWG?=
 =?us-ascii?Q?gLdCLKXPGAb+Bcm4SEwEaUZS1+DDM+ksXCBRQs7ifOoLPwMW9qw0v491KVGH?=
 =?us-ascii?Q?3tEdt6/9AtYDVH7baOYeZVl+2XXiOrEbrDDytB/kISgwOaa1/MDb7tfRG7cI?=
 =?us-ascii?Q?wUkUb/vbjIqGhGn46ZZgK8zEtHzkUdZNq9ymh8X7M6uy45A7RIA6TVhI0f8K?=
 =?us-ascii?Q?R2kVRqwrxur5u0M6BxIBjuvusWhMM6VEz353xvg0sxm5fLd3/VY/4xv1+XLd?=
 =?us-ascii?Q?25LSivEPp4nZjNHnwFqqInVQNNnYKpLGEJlB7bPak0XuN2MbJI5r2nXiq50O?=
 =?us-ascii?Q?Uxs9EYvy9mZcpJmL+UU4U6z+gbgO2O7qLiMo8RgDh6hbfo4NUphfJJ53ky5n?=
 =?us-ascii?Q?n0/qPg6tPxotLKYucF19FRbUN6d8pXDzZFFxKVFtirD9UaFEQq8TaWAXlHbA?=
 =?us-ascii?Q?9vlkJVcO0CpxQOwTbhOpy69ps5o8KDNu2TAM8dPc9ewEogxFgVFmC6bm1nEv?=
 =?us-ascii?Q?+wdRluf7iHcpvdclJbZpLlGAvRVZfhZsAx+4TBmAP8W3ABISDqKiOV9K5C/3?=
 =?us-ascii?Q?WtCTHeflL/Wt8hJ0ZTKZVim/JjnbGTo2qWIVdc0GkkVPtoMqE1WBhjZEDEVR?=
 =?us-ascii?Q?64ZEXW8MDQ2sCkVeHmmqKozH41WkyhAVuZ1zX8tv6BgE4yvhLAyI4X5SDaru?=
 =?us-ascii?Q?65xlNCCKCKq1Ah3XuzSlJta/h8GgeQFuapSs6NGLtft2AIuvaZkutU/z49Dw?=
 =?us-ascii?Q?Hl40n/3fvK3DiHWWrx/KUX93zo0f3iolZaDe4Lt8Ail7v6kYesZs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19398d1d-74d1-421e-bc8f-08df033ba849
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 06:31:27.4305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEfjX7lbbbGrJhdTFJWPeMhXgiqgi9nXbUNexXCfgsCy1lj0toRpypPvC3uKLroKLMw8TSfLl1Mng7iRWEsm8CarSRwcqw1L2oZlfuNvI50CheMOcoi1RzdJIZwXHfDd
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

On Tue, Aug 25, 2026 at 09:04:04PM +0200, Linus Walleij wrote:
>The regulator core can clamp a requested voltage against device tree
>constraints, but it cannot account for discrete values supported by the
>hardware.
>
>Add an optional set_value_clamp() driver callback. Apply the regulator
>constraints in the core before asking the driver to select the closest
>supported voltage in the resulting range. Drivers without the callback
>retain the existing behavior.
>
>Signed-off-by: Linus Walleij <linusw@kernel.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
