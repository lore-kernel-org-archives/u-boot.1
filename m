Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08DACCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965768394E;
	Wed, 22 Oct 2025 09:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NAacy8V9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05EEF832BC; Wed, 22 Oct 2025 09:14:38 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B14C82E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJ6zPZRQnCAThgSWrFvEWFVD4z1hEM+BxlY6iOSoyeyZ1k/44qRq8gwB1eFOFDUbVj+BjtpNwmLPE8LHqthatV/VcJE/ft6EHUeGoUpYkawXub/e8EQFlCPYouWW8ALeobuqx7MgvL3sDpcFHx1/PMIjz2Yuh0C7el1KXp7kqVULQxIeGvFPtiEvhuKf2FuahMHmPUuXsTBnnORsPRFbkJiCN1yqq89v6NxnQTNDcWTq8eEnVYbvVyRPpYHcOKLkPPLuEKMOVexYSBXBRN/d6c2SCUdjb6Q7IDOprmoTM0azFElIw34agMWqEvknPzCcQUO2QtZ5gzFNiE1Wo/vS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjIeFoZRqS8XnL7vL6iq2tmX0V1KYC/2VkOIrvWIf90=;
 b=XnRA3nVl8Ip1rRYN9sy4/EaaFGA9xDRhz1rvMp1XMIbCKsJTbmpVYujeat9aVOX2VRJfGIzDpfjanusS5PMFXGZvg5wqA3CrUNpo8b3rW6WsDtFatp1jsYLh5rY8gASZYFE833CkNvVLNEnYVXnVdkftvgdUTaaxF3pEqFH1xoBHAz+NnlK05BowgrvaUVXuQJjFN04V33oZ8hFnVtkDnKWC/qiv2Dvuf1edHAzjJMW19eVQpENH3wxFiRv78gWvYFW/npAAzCoQGCaNYHqPQ2yxFJFWwsBU8Q1j2YBdB0Ot3WUkec2u7wdbB34yEUAxkeGCoE/MoQMfKWsYGXcfDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjIeFoZRqS8XnL7vL6iq2tmX0V1KYC/2VkOIrvWIf90=;
 b=NAacy8V9GF+Zw48OXW6skAek4+QKFx67NFn0RsfXxDgo2NXd0ELiMDlsNBYn1X1h7dYLI37I+I76RTRkXnvR2kXnsY1Omq2cJnJYTIii3v8xcUcXeMTGOyDwOhKlSlNr3MkzdpLqbDUC0fQeebJuf5G3w6Tp62SsoZDSdp6DrewkAE4v4dEDXe6H0p78SNQnFbT3O81BdkODcADVzzahWzQI8JsjwzJIZttdvIP1zO0jwmdwd845fCXPRMpWEXJc5G4G9Laqa/BozSgbpfGyTid/88r64PLGcIugcSiJYWTw/Ce95NvaNl2g+Nz8LTZE7hFaAjZjQ8u5RmcUo+0y0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11326.eurprd04.prod.outlook.com (2603:10a6:150:2a0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:14:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:14:33 +0000
Date: Wed, 22 Oct 2025 16:26:47 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Henrik Grimler <henrik@grimler.se>, Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 4/6] power: regulator: s2mps11: declaratively get/set
 regulator mode
Message-ID: <20251022082646.GM30163@nxa18884-linux.ap.freescale.net>
References: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
 <20251017-power-pmic-regulator-s2mpu05-v1-4-91cadc0f4156@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-power-pmic-regulator-s2mpu05-v1-4-91cadc0f4156@disroot.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV2PR04MB11326:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a5fb96-3731-4fad-c3d3-08de113aa651
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ogzo93vxb8nlThxZPMQf9H9zn8BWSUmBATPI8k5BAmL/u6gPhDMINoGHZDkv?=
 =?us-ascii?Q?w5+6E7OSdWWg7Oj5K25kazh37eKuIY7RBfpgA+kqg2aB0zCk6SkYUOPNtDAG?=
 =?us-ascii?Q?Ty+I9nyLhQOVs5Cx5ydEcZSZKN8Vl4Nm7b9XjEvB67va99MLURshwILEG0nQ?=
 =?us-ascii?Q?6e2Y5YILfd5WockpLwY3VcvenFnh8ltUGzqF7SSH7jlWI3mDiUSlzRmmi4jf?=
 =?us-ascii?Q?7o6YQChVShev4nKdxXsF1b0z3y4mJKDHuNYWncr/y0BDptTZQZhzQ8tdPc3z?=
 =?us-ascii?Q?wa3Y5CGPnsdn6SaaUga7yxSvfmtQj3nJ4FDH1Ji3FGCWvovUf1XV/Zr5qZFy?=
 =?us-ascii?Q?A+ZmJvXLQbzLe28p7/JQAwih/kLjqhO9JFYUDWvhZEl5PlkXBUPx94bspMJk?=
 =?us-ascii?Q?7MeOdOduajn3foF9BcQSgyLheXuYH+S1Ezf6ECS4fv5UJcTHiPcuhxr+0REg?=
 =?us-ascii?Q?QoQT0pEkY9w99CobiavtRMTi8i7gVRgyq5o8aaKIXNSQ03aRUR05dj+X8iuQ?=
 =?us-ascii?Q?D/tiMauDlUtN4bHUZ7y77lfrrQtUTDZu4O3uDno/TsvBgSYv5Omo0uPhuOyl?=
 =?us-ascii?Q?9B8+f6gJMzG2VW468x2863A35t28AiOR4YfG6sEtSJPjzmhhlDej4waYqX78?=
 =?us-ascii?Q?0rikqaHd/4K/5zLVZBoxXzev1OOkM0LqT+a7ErqJVTLb1UQUeMg9p+pV4K+R?=
 =?us-ascii?Q?B+pha1K49eu9nvc69pbNCx32nwL8JfdGeahUae9W+s9UmcizZS0eaL5GTQoX?=
 =?us-ascii?Q?UXjcZdhqaJEyU8r2Zdlk/vW/N8HBhefDD+dsYNLI1A6f5UWLUaHcsOVq8FPl?=
 =?us-ascii?Q?qmGgp246VbFjdjcaztncTKKka4sz99B9SOEGWinSaS9Mw9AQCKdbI4dXgFwx?=
 =?us-ascii?Q?+DPtgSjO4lVon2D3ejCIU3GPekjltc4Ve1zw2lltiEGnT7LumaDFiYqMrAID?=
 =?us-ascii?Q?PL3E5McwKmYhfuQp+UMTaBszmUKYmqSAzzEAiarqtit3ctJvgK/BjAZvnRai?=
 =?us-ascii?Q?zA/os0CEHkmyeFbJnp4acWngJPX1YnwHUllBMGFCWWSjyYSodDCSI3PKWUwn?=
 =?us-ascii?Q?dadDDIVyfVXVK6U1NAkhsk+ZGGVDFhyqEvSudElB2oAfuLGPyumOLZ8r0d4U?=
 =?us-ascii?Q?XiuifkdA3bAM4JUvqgeLiF3tib9A5LozBFQOp9zKgzwqaZWK8anyxCk0IMDS?=
 =?us-ascii?Q?gFU6Wl2dxokLt2kVUmnu7Hpg9VTmvOA1CnvrYdEbJE0W/APJ5QiYIj9oohAD?=
 =?us-ascii?Q?VzsCoOvAihrz1nVTYYOUztcQ6BksS5M+/xgjz4USRvJKvJBwnDlQlEkuEele?=
 =?us-ascii?Q?58Tiq6GTcgJDLyZXTUAW6/NxFje2Qnu7kzQ5OnY1ndQVtcgVmDbZ5FMN3JhN?=
 =?us-ascii?Q?2OKxx2EDAHUPETK8ofYmDOMpxpMzTkzApnwcBfi2DyeyeaAOkZ1MDkiN6rN6?=
 =?us-ascii?Q?yd/ey8VlniisuvYRCejD7/OdklvdtchjFblFc0TD8VC1E9LManZfmZSUS/Xu?=
 =?us-ascii?Q?CToW1shzhdrjPaVM7y46+7KNYQUx3I158/zF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NpWz0Hwt8KaT7xAxOoc5F2S14xWr9Iqlz78YDYsUWNJX4JZdpTkgw6ac+6t/?=
 =?us-ascii?Q?SjK1OhcnTttbOVr0WeGsg18JTQcgTaFviEAQep78UKuXa6q9p6rusuegKZL4?=
 =?us-ascii?Q?bL2T0HGnq6ko7eM+6VfMHI7TWOpOXiI5CpNZ1hfllrlBaqXaEUw4xJ0tyiII?=
 =?us-ascii?Q?a8uHq5RN5/YzP+QL5eq0glktYa2fY4BAdZH5vHN2ZPGrBGLYMATeoktLHm/0?=
 =?us-ascii?Q?7BM7PenONW/PFO4FGRIOXouBnOBOtXo9SiDqQlTp/s7ZV8WcHwfTu5LhXLWk?=
 =?us-ascii?Q?Mj+px/xZEMpYzis28bveDokeV3cOZ4YJcIV85ekSn3q2FBY7cxpOUgWPvzi3?=
 =?us-ascii?Q?3lWiOFMRSAuuSO3acJ4P4s4JMoYpfLBQYw9A0M26KwD/H/B4F4+zModdsAuQ?=
 =?us-ascii?Q?mC2NoLpn3eUxEzIaf/7PCsM5jnmrGoHZWMb6JKDOroE7mn7HEchqiMOy1oUo?=
 =?us-ascii?Q?EsYE1jDDg9YRtmP6biG6Y+WmZ+UGPz8l78bVPqBceSqhI0/erzJS4XSpF8MV?=
 =?us-ascii?Q?KY9/OUFywxpicm9Z3hKLq+lUyaMnnBmtM3DwyLS+Mp4RhZ6sWoSv7oWzXSMO?=
 =?us-ascii?Q?V6+0vEgwXRnjb5udOpaVb+p99awGci02/RBeS8glKqieDKHrUjp+3+UK+jhJ?=
 =?us-ascii?Q?CSj+6NgDNxHu3xz1SeuPuZmadMfkFdLHRCcZGm22M050YFoRJDO4hU5s9NmA?=
 =?us-ascii?Q?/tjMnFfcZb1m9thzEoqyOEmxAIzKJX8lokV6FlMr6XdR3OQM1qFmqSJbL323?=
 =?us-ascii?Q?OdJFPqDQAmslIH6d0hKVYTTRVkdTHYUGVuf9adv+c1nNRROAXJ4etJtlG5Jt?=
 =?us-ascii?Q?o6ThfrvFV09vaL2Z8pb1bgBfUfwsGpGIgxZokjEzf7etz/Sd2Vt+nI8X+IMT?=
 =?us-ascii?Q?65eh9LEFMYRInjIs+FeVB2zpsxA2U+y6MzOKZqGNibf7X4y5JYQy6ciKAI8V?=
 =?us-ascii?Q?L6mhVh3MY+PeHfhh9AZr/LUpmyPyulnifnxYtInfu14pJn6e+iaZJ3eDoOSB?=
 =?us-ascii?Q?1lt6Waa9zscJ55tAe4TmwkktcEIGU7f676p3TO1UMMZUP3IMwzo57AnOZ+Px?=
 =?us-ascii?Q?XOKkGvSAl61etqmUpzCL7LXQz4hh/kf2sILqLdnQag239RnBB4Y3jfRgIBNd?=
 =?us-ascii?Q?jSQ1rnwz+aUAWm9IFodJGM7uhBPVjdwY7cPYGFXAvNPpQZYgEeBcdJiQobKo?=
 =?us-ascii?Q?uLN4COlJ7CfEMd2ORymCkpohgv+dG392zRSU4HCLhhZvCwLP7OB4mZuc7HWs?=
 =?us-ascii?Q?pbml1/QykWXUUsMAhDXd5+JbzNrgnvJgdZ9ExYvNz0PiiEiuSZecCHvhS9yw?=
 =?us-ascii?Q?6kgKjaxBQvJURGaLIvo/nZhbWhX86JmZ6QybAo96vjCC6WPljJmW710ItWaw?=
 =?us-ascii?Q?Jmbxg3QtUEyhO4Yx34CvXBkNoJIyk4++/MJ0H6L0vkEYCjY5+g6kNbW03PKh?=
 =?us-ascii?Q?0vUXOTwglslyC1PawkeZTlmRXRJH8nX+gilL+dyD65j1bmB3Czk8ilOYm3wk?=
 =?us-ascii?Q?dCJsqNHYilGJUdy52qKzdBqaY1QtRoCkE03q3sLmVoD/zIftEFAmrQrJsOX5?=
 =?us-ascii?Q?zS0MVaXeE/or39ZQWeAg/XMWxqWwyyeLFz5/RgkH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a5fb96-3731-4fad-c3d3-08de113aa651
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:14:33.1592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rk/82saHzxuDL5v+a6F79aJ5+I0gGxc31cFyfxW2WOBzotoHGp62WDBjjgtkgHXpqNVEH0y8C76RJugIX5ZpAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11326
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

On Fri, Oct 17, 2025 at 08:58:19PM +0530, Kaustabh Chakraborty wrote:
>The functions s2mps11_{buck,ldo}_mode use the s2mps11_{buck,ldo}_modes
>arrays directly in order to extract the mode of a certain register.
>This approach does not allow similar devices of other variants (which
>may support a different set of modes) to work with the same driver.
>
>Instead of using these arrays hardcoded, extract them from the device's
>uclass platform data. Now the responsibility of setting these arrays
>properly is done by functions s2mps11_{buck,ldo}_probe, by implementing
>a switch-case block which can support modes of multiple variants if and
>when added.
>
>Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
