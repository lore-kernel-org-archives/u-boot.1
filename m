Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96819CD8CAA
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23AE3839A8;
	Tue,  9 Jun 2026 12:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kmQpZ4sS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2B49841C2; Tue,  9 Jun 2026 12:59:12 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B3D7838BB
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuC3joBCeojxuE5DCLjbis54edzcN0rehLUoBoL56fi/tn93RCqX3LJdGDBkE1G9FvviDa4y7G+DDf4A62BR3AOzRAkoZ+ZDhknW5oXMYUKsD1H51HZY2FSXwm1diEFGRplwLLV4tY/U3KCxk+9psE7Sojt/sLLpX420x947Y+bcPG7BbGuabaB4L6WMbSeXivSH8Y3PIuOeg0V2+TalIEoLEzRHcFUui9IHrbWw1cqb25+PSXQJeb7AJ7ACdTcDwxiLtgIEQyojE/WwlUiNtq7tBZ3MDqXYTjXPpo+jsSxt0XXbuPGAZr53rBZtzwZA6YfwTRG7r4WtdWdI9DMFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1eWh8yJWLFHnTZyeflh+m/lar0hDDnJnk9HWFBmtDo=;
 b=dQFWMTYc3TLvGn939vq6kJEstHfwLcgexaT6UeBsG66oORBGdrNnQG8bfjM+PKM9Lyuik33dYLAGsoPJdFbtNUrNuo0S6dS7khkMRQNpHAVo+KHK562wCVqfmHIUQsYgY0weBmPJc2oztzSbhKibplPSsrfAdiXPNMdjf1rAnVTBkG+QJl8d/r8LJMkIM8oH/YBnx0Cikix7AaqBbWD7QwnODpTo+haOiGKjyUDZ9OCKC+motH4hubBH3r4HRPM7ATQNdh58d8d8HiwjPGuDHgrWoStJv3c090SuPB22oo1+vXzAcfsy870kH/xh5+gkvXC+hq7JJxUOtjv32kSa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1eWh8yJWLFHnTZyeflh+m/lar0hDDnJnk9HWFBmtDo=;
 b=kmQpZ4sSAR6ELtrvU+TrfUBTvHpJmESBibT7GcoGoTWxftKoIQn7l+65ZqDAh/tFFf3ppLnJo6deBf8VQpfoqnbKiCKqYYMIj+1qQbXafnYsaELZwtQZfxeY6MHfuDWpuT8Uj24DzlDU/yllwOpcXxiMTkr1dtDQH4rJm1kOegiuGv004TIvY2daeDuRG8M7OkCv1plZJEZOjg4IruijfnEpgI8tAyjb+AQQRLUm6kcQY1GpHIirzXWzIQtlhYhdzOV6ihxefFP4Q4WEBiuBfIVl4KDDDH/X3ttbPyv48YEOkjiEMF7R2Vgs5EdwupJi8okW0MBCAkIB3npJlQgy4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM8PR04MB7937.eurprd04.prod.outlook.com (2603:10a6:20b:248::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Tue, 9 Jun 2026
 10:59:08 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 10:59:08 +0000
Date: Tue, 9 Jun 2026 19:02:12 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Zheng <haidong.zheng@nxp.com>, Joseph Guo <qijian.guo@nxp.com>
Subject: Re: [PATCH] imx93_frdm: Add support for 2CS 2GB DRAM support
Message-ID: <aifytOZZxdUdHpnh@shlinux89>
References: <20260609-mathieu-ram-v1-1-72c18e8f24d9@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-mathieu-ram-v1-1-72c18e8f24d9@bootlin.com>
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AM8PR04MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e34c11-128a-4600-bb6c-08dec616214a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fdxzPTvoWO9+76whtcPtHe7P7zhOHwz60Or/dA+54CWcFhuJKpkJu3IE8zjWMA9MU0Va2NtTd0obPHgF2GQUx9dsagto2Ct9UkSdEnw9kvb7B8Y34hVuEs1owX2zpqX+UMXWRhHN0tVpvXrEweyXLHaBn9ti/wHH+9Zge248uw/RjXB7QtR20aJmD17HsOkEOLCUfn2isEOABvXvSl3SF/8W0pUHQlMG1Qkeu4g5CYirGxbEhVdmrWdYxWapA/bZwx8GP6Q+L6DwdPyBEgCug2JnQFVVG8Lg6AciZqC7Tx72J2rr66+AQWV27UpK/p9k1UzG3RBlALI27tFjlIxXSKIhxcM/DOCKS/0oyMH2COAgOrq0T6bWChOCAo8y+VVDW2Y9H5FBB13F2ae40LCgQvmQiw1c30NYFq6TmmwAguxw7s9HoFqtUXucROXQNk4oIMcT+/jla2jsZ9h4hA4fZZm7t56pVW/T4uHPfclUQRTjkRG4ksMhvRoGCgEZIt3/GFxCW1I724Bi3J87bI2tS+aCnD+acWzFS2Sem5e49Bgn0Jm+zU1P1YPf3CdT2IR4AJhiwTcvOZuc5Km/AwK4oL763LEZvazs4816dJ57fBWLZUmexNjoLA0OVwJqIUnSYR4vohns1ppzBeRqp/0y9sITo7vgmUs88cYMO3xpdZSMXqkVYn7KHXG4g+qUB8HWslZxRDWDbwuLr0RX4w1DHZcfxBEP7OhvNjPfTSH9FqBD579+9HUX/7iwLCWAoWCK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s+VDzaQHH7I+DWl+hAuY+vZq7CPmSxcwYoiwo668ndKQHpYtv5XTrhAgmgU7?=
 =?us-ascii?Q?58XICHgjDfkA23EMM8aysS12A5/4mf+vz3fbAmo5GgAFPa5qWKr/k4rlaYF1?=
 =?us-ascii?Q?ldIupFS67MSQKbmbwcy0z/HSziRW6Tm4PApJg56CHXP1Ptqtvyx1DVBFqMeh?=
 =?us-ascii?Q?evzVgFPanVss6vGGNZs81caCFgsENQAKds+LCY4JP6nRodmH1EaKbHJbxPsZ?=
 =?us-ascii?Q?PZR+fpsJMPW9ByGD+XGoJG9T9BtuyxGKLxus87BUDxj/g23v3YrS9keLmJR2?=
 =?us-ascii?Q?enL4ok+90ICISXDb4TaHBOK5XqIuRciw3tJI0nwxUpMHNId2OWeoSLuMCWvP?=
 =?us-ascii?Q?OfDGa9Xm0gcTP7OSp6iheTynreTp0O/iL+RzO4Xv886BXkt8LC/YD7JI+V6T?=
 =?us-ascii?Q?6nfB0vEK6qaiq+5GKxyHsBt4OQdPUTIygcu3As9q1wyUmlMiTiUZ0ZhflXIU?=
 =?us-ascii?Q?VAFwHMqh9RvKEWgtGO/ljZpU8aboT62zfStWyiDKvZZU2ZlbMunVfSQJhKTT?=
 =?us-ascii?Q?7lG4jrhmPy3EidOUp7T9CodXIT3P8B9GuXest/Rzr1VzDjSW7+fIkp+hV3Zk?=
 =?us-ascii?Q?IhhO/4ICD832CkBfSAHfKWOpQvzQlEVJe1IFQfpOQeDqqU+4nQ8eo/gyV4OU?=
 =?us-ascii?Q?f26pXK/aba+G8QlgCbsARc+rW1ov884h9/MhKDNuQBRUyTZfkmEHGj3FumVa?=
 =?us-ascii?Q?haXn2j6P2kUD/XJaZvkuBudvA1+ejqqJC6096Xt8NIX9bDqXuPaeAgz/upp+?=
 =?us-ascii?Q?Alk3p4cLYce8rOKcBey3g2OdJKmtJvpBXbQoSWN+xaK6m/M2qbgxY15K95Nb?=
 =?us-ascii?Q?2Kfkn9Y3HeIoxlyYafwFFoTRLFQXizdudlUCk+w7/fxjTCkU2HfekHaZux57?=
 =?us-ascii?Q?70q2GffzI7f96/jl4/UnAgn7ID3pSmsNlL/HAdOEZZXKoU/MbfRSzs4c3rsj?=
 =?us-ascii?Q?lGWaom2TUiIZrawMJruMu4uCo6WWcCCdKUVWN0m1/SLiLRV8ERhKxDYbQkDZ?=
 =?us-ascii?Q?pKNV7i6rXs//lSf25QRWbZOd8zdidVQBo6ItgX2N00WwVKtkXeIY3S3KsfrZ?=
 =?us-ascii?Q?FQFJEfit+mCUup8qYVUN4gxpmEKF1ZUyOuKUh4h9L5gsz+41VzX3ahmDbcav?=
 =?us-ascii?Q?5sEWRelUUyF04XvkxvDQhUsuYB+6VnbK61iodfrFRStbxmhgrDXkTaRl1w6+?=
 =?us-ascii?Q?tM9NDYeBeDcUpu41cp+SybtXg/PvZRLo1CLRTcljGikWVtgaSMLw5jqKerid?=
 =?us-ascii?Q?yhAR6YP07dosBsY9yed9cC77gqAfDEITKB2T7Qd5kcjiN7e8rpCC/w02Vpu+?=
 =?us-ascii?Q?BzJ4kjHSIBGw0pmre/esh+EClRhcghfBSXkavzwA14x3z87RCSOhQnUph33X?=
 =?us-ascii?Q?dHRPE7Mr8sTRJFBm+U1QVkRY0ojz9Ftc7GZJn8VgZ7RfpvSEQSCr09KYS7Yt?=
 =?us-ascii?Q?NUYIDOamzSp4xdSZRmn4zhdikToxiJJg3b1ZeabqUDK2OjgMG6YM2JASs1AQ?=
 =?us-ascii?Q?BER248jAagE/fxXe4+y8L48XfiMA961XhI/zSc76JRXFpolkt6ZZlMH9Nr4P?=
 =?us-ascii?Q?b0s2gYRbo4Tw4gayhXWSHt3NuiXZYudDOh7/GoJ9AhfEjLXKd9ETpmwMw0Af?=
 =?us-ascii?Q?3WBxoCZ8fzTQSkIU7QhqcaSZChzS4CDJwMoNmIGdW3tjyaKyTt5B7O4h1jlC?=
 =?us-ascii?Q?jt0sS1gWMrBSKpT/5BHmbD4F2wmL7XuuGBTFzK6x8gzcA0OSS4uTZT9Pte1r?=
 =?us-ascii?Q?4Qluny/Chg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e34c11-128a-4600-bb6c-08dec616214a
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 10:59:08.4465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsBnWbwdA/079rfHx66YLNur5u1vLDRacKmRycsR7ae9Y/K43WnpEeDbv0mvaAuyjNUEBc9ccxmmCKdotYK27Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7937
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

On Tue, Jun 09, 2026 at 09:47:32AM +0200, Mathieu Dubois-Briand wrote:
>Import 2CS 2GB DRAM configuration from Tom Zheng commit in NXP u-boot
>git. Revision B2 of the i.MX93 FRDM board is using this configuration.
>
>Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>---
>This is mostly an import of Tom Zheng work.
>https://github.com/nxp-imx/uboot-imx/commit/4c35a6086aed

Better place this link in commit message otherwise it is vague that
commit/branch/repo. Then

Acked-by: Peng Fan <peng.fan@nxp.com>
