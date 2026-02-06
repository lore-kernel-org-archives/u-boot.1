Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABFCECD9B0
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 00:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69DC0831AC;
	Fri,  6 Feb 2026 01:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pWvn94Rg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D87E8341A; Fri,  6 Feb 2026 01:49:56 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67FFB83015
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 01:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZ+TiVdyAdjyECpkhwWKEy77EvjFTj+UH/+9kKno0Y1ecJ4zOSJCAEhfJhcLCMYmJODYOpLs4VpXYgXflsWpc6HfVHR2oWI3z1u/PLWnPRguSv2/nSw3jhHcqVsOnQT4QXN4OSYVePaC6hFE79FuV6tpWvvPdNO+Pt+y0H2JADS5reKhOgLBIJ/A0dqksa4wVdQFt6mccYVpzW2A9GsxekOkOGVPOMAX4XUywNKgCrScjVTPLTNlIStDLI3Kj3MVKVadA0Sc2vKbKtQ18hdP8jnVVsEIh1rD6GkQq1qhD7WTOt1LVSDNMOICJbKjUZUH4xy+Y54XgdhwAqb8prKhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIzY3m5LmlDFEFtzH5RCsQwjJ3cHKAVwdWv5AqxB6Uw=;
 b=eeDqo9r19/iA3UvodvwUJPuDixqNmdmR55rJ+O2tivr9CURzmIEo0GQBgpC+E65KRX9hloJf3OQumEexXTmLycreaAYB+3jgn8zSA4KnASmCkdhQzJPrHF0CrtD1Tx9gwdgZnc3lRK3jNj+ZEVy6ghTUlzkXBjRhXpyeAGC+IfJ8Cq/EKynPebclp7Y4b1URsNvbtwehyfFH6RO+eUs2LGXKUvj8NSm8pHkmA6UbsJLlwW9nyAMfHWbEMH7GxjfAckOQb/34fijIwLbkTWfZPBT6xfwmE2brXQuqoqa2Sd/KIXveGwn0PIAZcGxr2s4v1Emq8vc2CrvfpXa0IpRLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIzY3m5LmlDFEFtzH5RCsQwjJ3cHKAVwdWv5AqxB6Uw=;
 b=pWvn94RgSZrzUO9fn+jE+EndUVAx5Ch4V/sSgU0QX5AnhgDyJOU7/bHlcYcqSHpfv63CAiYVrlbilbJKleOpYTprSPgMnNT3tpU8C/HPDcjt316TpfOh4TL22w529hkBJ7BVXEJGGbmPQYPck9al/4iJXEwyp++IXzjSqD1MZS75gQT92YxMzfGXZZbR4uaDNmjB9Sq//WThsb1vTYdeKr3Xo7K/BiBNNfD8IGjF6wv5/LadhjQy6vszm59aj3jksnapmfFfvmgyVMTMNfQlMS9MvHusBcy2XHQIg20lLcNx4wVxw0nHrF5bGq5H8PsH7ezV0k/EkJVL480mz3EDmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7759.eurprd04.prod.outlook.com (2603:10a6:102:c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 00:49:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 00:49:51 +0000
Date: Fri, 6 Feb 2026 08:51:28 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jindong Yue <jindong.yue@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 11/12] arm: dts: Add U-Boot device tree for i.MX952 EVK
Message-ID: <aYU7EMvw/l6E+Cdt@shlinux89>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-11-2103d0222a0b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-imx952-v1-11-2103d0222a0b@nxp.com>
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 0020b8cb-54dc-43ea-63b3-08de6519a29a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HvRzF1+qcIPA2hJES471TpeeYoH64ovqrcp+Ko0lpNorPiTbr9Y+hkjOf8/u?=
 =?us-ascii?Q?ca3Hq8ANUXF7N++sZSBmDTqg883LWyiKv/HDK3k0WjCd9BKBhoK4PseqoW/3?=
 =?us-ascii?Q?86iWG/Cwg7XkWn5hX7zHxDw2HLr0U7F2JnB61JMWBmUNWJAvdxPQDoXMIBn3?=
 =?us-ascii?Q?D9BMcatn3iloj0rpa9n2pc+t0p9G/lM6XchTcRWAd9GAn2yhFLSlSrYdN6hB?=
 =?us-ascii?Q?nMtCOVAuV8PVLHlmQUxVsrcpzw2G6UXZDqwG7gDU+tpyle33jq9jvPPbCSFO?=
 =?us-ascii?Q?3r/qQn8NoDKi0yPJrxmuEAfuIeIsLlk2IYYJsAtZgJtb3DzjrdL8Mq2h02jF?=
 =?us-ascii?Q?aQCNDVIyNgXR6dkSX76vCDUPE8hCeQtb0FMLGU7VsTbJ5z/vDfSXPmEpDsDE?=
 =?us-ascii?Q?aHUcppedZjU56rUq/kp8gt1tB0Z0Y6ySxVwPS380aWunhsgbI/zbKkkAS6Mh?=
 =?us-ascii?Q?1pUXc1KPFlylpyd+YF/gw0wICmF3SDRLfVoCOoFOWefPvIFh9G1xxxtL2XW6?=
 =?us-ascii?Q?tbyWER/EKV0jq/b480Is6ZIfDQhMb+H/W1rImjCbgpSXj0RuamNa0QQf+Aay?=
 =?us-ascii?Q?xwd0j5PSeDj8gJtADQVIA+Lvi7OH43fwSv8e6OC5jT14hSZ5FpTrtbSGCAy+?=
 =?us-ascii?Q?QxOXny+nsnhojIeJNOyiRy6kMxrZR0ZKa8IZTMI5UuFaBvbwTE0StT76libP?=
 =?us-ascii?Q?ojjrZF/7rDnpGl1fO48F+4ajoubsGQ83qX6vjInrnrJBa7jQ9ykujZYkiX7G?=
 =?us-ascii?Q?rwpI3RxS+3sQY/aeywEGjEHs44jCFAwsvO2Qs0chrZ1stCab8GSudlUoXvc8?=
 =?us-ascii?Q?BUZjFQ2yPupQNCdrkN6grRi9TZXI4l/M2nPArIre8251l6TZs9ywFVgcUfY6?=
 =?us-ascii?Q?EEwvzLhQud9adszyltVXp1xDzfiFMhSjo7TVwDXJBJ1uGu3/k/oWFq7gmHlS?=
 =?us-ascii?Q?xcZAcxoczCYf3MmPk7NmmADzBrutiIf9ZEmCDq/3OLYMsEsbdFVkd4//gWj5?=
 =?us-ascii?Q?L9smrTyHPqi2P1ychE04J8hDL9Lc9dOYdhVmCSwl3RKdvmaWbp5JKLhcYP88?=
 =?us-ascii?Q?Sq5Fo2Pzq/HTGUr+xTI2WlGTobUBCJXKnKKxPFBYGrWm5oMH2yHUFWtDZ/X3?=
 =?us-ascii?Q?pzjpQpcdXn3cF6Ba5a8g10nOWtxyoedTNkf7LV9TPhFLbC9C4hIggbM6Muk7?=
 =?us-ascii?Q?5eIm9beCSXKcDyIT7r87E2Rlak3PDqm1Km+4cv0lhhgZgOsg7+WiDUOwKBD4?=
 =?us-ascii?Q?m/KXrAaVd8kkbotB3tm6U0FTm6JGtXrXzmx37Wu/ZxQHu0AREaJgedPPnrKp?=
 =?us-ascii?Q?hm+yQ7wK66J6UuF6p6jI8Hhn5CafZ/kcKbbCs8pqg4hR+/DQHyVEqx5MjDqt?=
 =?us-ascii?Q?AJo0oEeJJnd0LRaUsLcS0MetA/ecEA6XsoGJtCXJk/osa4+T8PnC8OavtUGC?=
 =?us-ascii?Q?HvA7RpKydVWL62dL3FnNvxPKtU5RrZsY84e86UC3+m37g4+jYlUWr3zQqMTk?=
 =?us-ascii?Q?KoLzaOrhMTVEcC9pe3JaOCJPBKtwGHkmtud9XlfXxF83yVTRLWNYgLBzM1k3?=
 =?us-ascii?Q?gB6cuDJzrlA0dV1eyxsj+XULN3P9HanYGw6AJEu3onxvwn+wxUaxKWYjit9U?=
 =?us-ascii?Q?vowMJQdnAwts2HxD86BSWcY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dQxoRI1G4FcpRLG1wfVO71i7zKvN7sRYTFRG4awbVPmCfNemZAYKJoaL49TT?=
 =?us-ascii?Q?fvdkrowxVAtB7HtTHeff55m3Pwsa1afaBZSstnULTzpVheLlkCUS28cWe1W8?=
 =?us-ascii?Q?ZiLoMDMAej0/eHEPCVrEkmvpvjyDRT+hznbxiCwFnOwvZKNoW45vqQCAKTGk?=
 =?us-ascii?Q?gHaHHDONDEFC8IG+dmsUKE3GCU5pURvrPQuWM0zy5c53+u1VX0nZMSWGAc2W?=
 =?us-ascii?Q?BqrjKr09PNrhseQBEz/CmdHiIjShIqG/1emB54YTnCPyuVgNYG0SJuRfmILN?=
 =?us-ascii?Q?pVQpgDmj88r1M8kFKasfrTmanmG6JUHG5N+6DGyhlsgkf1YPdbcQtvMY0Iul?=
 =?us-ascii?Q?sAtgYkH+dHLEQuwsWHNK6O2gRdEn1GPOkP9TiOtQVZf65Fpa6WeJx0gWPy6t?=
 =?us-ascii?Q?tgnT2dVQhMDq9fy0kWk/SyoOrsJ80IYwzYRu4AYfH9+vVSH1dsCKnUES6BBI?=
 =?us-ascii?Q?zl5kGRJ17vG56K1oE+4GQUN2htMdvhlyv2gnEvYHrC1gRh36g0z0gBaBHsmo?=
 =?us-ascii?Q?HDLTK/Q4UhkDAPnU75P7fFIbc3d2dkftcx+/upgPyXYMbuSHyeuCalPPb1il?=
 =?us-ascii?Q?CcEDeyUndTmVvL21CaewIL1z0mmYUVIWEryqHL6TJJtIXG1IwqOfyE9+38Sn?=
 =?us-ascii?Q?+lJKQr6YzO1Gfk9a/s5UIH+yn3SV0vfCsHod4J3JxDCr5OpZW1qjnVqy1g84?=
 =?us-ascii?Q?QgP1o15y8Nnr+mD/dHBX1d3vsn4n7j8qKICcKcQlSR8GdQKAJgjzBx+O9QH7?=
 =?us-ascii?Q?M19UXGUSVqWooAJPVoFjPoxsJRi15kf/POlUntQ1o6Wsv5ONfeDBYFZD/J8D?=
 =?us-ascii?Q?zAO5ETr/9IjrsK8S/cbGAQdhaPqeheyM2vjVg1Z/pvOXHLaKESHSr2Z74NRo?=
 =?us-ascii?Q?0MXQ2+0d9pd35uv24oQv/aiMB/aoylgVZ19p3sIxt5mzFUat7tynZv1iWcKb?=
 =?us-ascii?Q?i3Carb/l3fxWS1RXOnx5Bim0mGExeV7wcZvLl8joHylPO5/tmDbm0n4qLjKL?=
 =?us-ascii?Q?1MB9tovux08Hi/kiTUSbR0dD6EXG37gs/TUnlecWx9UOWqFPLkr7MnHxtkll?=
 =?us-ascii?Q?8oGe/upiSfT2pKGdfF4QwJ8B9GHI0RN6imQYNpckxheVpBo693U8X5JCNy8x?=
 =?us-ascii?Q?rJfRs6ZO7oBWCcnUjLJc3NtbILyzl6aOCF5Qaf+qlgPQoY1Lop2T5QJXuZgW?=
 =?us-ascii?Q?oKZO1sq646fCFyyK+bvI1mL05/ic7NlatKIl/xIR46OzEkeAW2m6/qQaxxkc?=
 =?us-ascii?Q?EG6q7y6XmOkHI8H1RcvyDnBQPOnX+CKS0ZaLPiLWlHA0Ea6c6a5D2GLMxJ3r?=
 =?us-ascii?Q?FLC3c1/4NCW+cPPoF1mn2/om7m6XXMq4mfKzi/kCamM6thVdAUcQ+377dVYe?=
 =?us-ascii?Q?mpZ3mQKeqvAHSAfEyTeI+dh0XtGTZaE2JvXo8k90feKriZXDnluTUVG9ZS19?=
 =?us-ascii?Q?CEaPmjBInBBWQALSGUz9xLgaBFQ0APZ39iY2rDrqTUibeGLPG2hk9d8uiQpJ?=
 =?us-ascii?Q?Sk9Z+1qGhBiKBC0kMhTirAW7x7B+2mRC+fq4IBcRz75dN8ESA49SZBN8XGof?=
 =?us-ascii?Q?L4TW4ssMoqFxzqinE5LhDNLoyxITh/UXo5kmDr3FcY70s7v/Zij7gut84H3L?=
 =?us-ascii?Q?zN3eNOZ9FfaVkllEei7rop8bqT2svOt8hm/RRfcoqMF5Mwb/T0iDDl6lWTec?=
 =?us-ascii?Q?Gk3NVJaT64Wgce2ZEO4nYoichJ+ZWw9eIRlSARLr9oQocBrl1tJ3i/mQVIVn?=
 =?us-ascii?Q?MpwwFDaaeQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0020b8cb-54dc-43ea-63b3-08de6519a29a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 00:49:51.2198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xl6JPJqW+y1lQgiESwCnGQFQyq4toKhvM5GGgd5i5JZQBdbslRmectJ5Uf/CQNWwu7Nq9REYKCp6ZHM2CLTlbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7759
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

On Thu, Feb 05, 2026 at 09:55:17PM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Add U-Boot specific device tree configuration for i.MX952 EVK board.
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>
>---
> arch/arm/dts/imx952-evk-u-boot.dtsi |  58 +++++++
> arch/arm/dts/imx952-u-boot.dtsi     | 327 ++++++++++++++++++++++++++++++++++++
> 2 files changed, 385 insertions(+)
>
>diff --git a/arch/arm/dts/imx952-evk-u-boot.dtsi b/arch/arm/dts/imx952-evk-u-boot.dtsi
>new file mode 100644
>index 00000000000..1b2c314a41b
>--- /dev/null
>+++ b/arch/arm/dts/imx952-evk-u-boot.dtsi
>@@ -0,0 +1,58 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/*
>+ * Copyright 2026 NXP
>+ */
>+
>+#include "imx952-u-boot.dtsi"
>+
>+&i2c3_pcal6408 {
>+	compatible = "ti,tca6408";
>+	label = "i2c3_io";
>+};
>+
>+&i2c4_pcal6408 {
>+	compatible = "ti,tca6408";
>+	label = "i2c4_io";
>+};
>+
>+&pcal6416 {
>+	compatible = "ti,tca6416";
>+	label = "i2c6_io";
>+};
>+
>+&pcal6524 {
>+	label = "i2c7_io";
>+};
>+
>+&usb1 {
>+	compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
>+	/delete-property/power-domains;
>+	bootph-pre-ram;
>+	extcon = <&ptn5110>;
>+};
>+
>+&usb2 {
>+	compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
>+	/delete-property/power-domains;
>+	bootph-pre-ram;
>+};
>+
>+&usbmisc1 {
>+	bootph-pre-ram;
>+};
>+
>+&usbmisc2 {
>+	bootph-pre-ram;
>+};
>+
>+&usbphynop1 {
>+	bootph-pre-ram;
>+};
>+
>+&usbphynop2 {
>+	bootph-pre-ram;
>+};
>+
>+&wdog3 {
>+	status = "disabled";
>+};
>diff --git a/arch/arm/dts/imx952-u-boot.dtsi b/arch/arm/dts/imx952-u-boot.dtsi
>new file mode 100644
>index 00000000000..208931ba884
>--- /dev/null
>+++ b/arch/arm/dts/imx952-u-boot.dtsi
>@@ -0,0 +1,327 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/*
>+ * Copyright 2026 NXP
>+ */
>+
>+/ {
>+	binman {
>+		multiple-images;
>+
>+		m33-oei-ddrfw {
>+			pad-byte = <0x00>;
>+			align-size = <0x8>;
>+			filename = "m33-oei-ddrfw.bin";
>+
>+			oei-m33-ddr {
>+				align-size = <0x4>;
>+				filename = "oei-m33-ddr.bin";
>+				type = "blob-ext";
>+			};
>+
>+			imx-lpddr {
>+				type = "nxp-header-ddrfw";
>+
>+				imx-lpddr-imem {
>+					filename = "lpddr4x_imem_v202409.bin";
>+					type = "blob-ext";
>+				};
>+
>+				imx-lpddr-dmem {
>+					filename = "lpddr4x_dmem_v202409.bin";
>+					type = "blob-ext";
>+				};
>+			};
>+
>+			imx-lpddr-qb {
>+				type = "nxp-header-ddrfw";
>+
>+				imx-lpddr-imem-qb {
>+					filename = "lpddr4x_imem_qb_v202409.bin";
>+					type = "blob-ext";
>+				};
>+
>+				imx-lpddr-dmem-qb {
>+					filename = "lpddr4x_dmem_qb_v202409.bin";
>+					type = "blob-ext";
>+				};
>+			};
>+		};
>+
>+		imx-boot {
>+			filename = "flash.bin";
>+			pad-byte = <0x00>;
>+
>+			spl {
>+				type = "nxp-imx9image";
>+				cfg-path = "spl/u-boot-spl.cfgout";
>+				args;
>+
>+				cntr-version = <2>;
>+				boot-from = "sd";
>+				soc-type = "IMX9";
>+				append = "mx952a0-ahab-container.img";
>+				container;
>+				dummy-ddr;
>+				image0 = "oei", "m33-oei-ddrfw.bin", "0x1ffc0000";
>+				hold = <0x10000>;
>+				image1 = "m33", "m33_image.bin", "0x1ffc0000";
>+				image2 = "a55", "spl/u-boot-spl.bin", "0x20480000";
>+				dummy-v2x = <0x8b000000>;
>+			};
>+
>+			u-boot {
>+				type = "nxp-imx9image";
>+				cfg-path = "u-boot-container.cfgout";
>+				args;
>+
>+				cntr-version = <2>;
>+				boot-from = "sd";
>+				soc-type = "IMX9";
>+				container;
>+				image0 = "a55", "bl31.bin", "0x8a200000";
>+				image1 = "a55", "u-boot.bin", "0x90200000";
>+			};
>+		};
>+	};
>+
>+	chosen {
>+		bootargs = "console=ttyLP0,115200 earlycon";
>+	};
>+
>+	aliases {
>+		usb_gadget0 = &usbg1;
>+		usb_gadget1 = &usbg2;
>+	};
>+
>+	usbg1: usbg1 {
>+		compatible = "fsl,imx27-usb-gadget";
>+		dr_mode = "peripheral";
>+		chipidea,usb = <&usb1>;
>+		bootph-pre-ram;
>+		status = "okay";
>+	};
>+
>+	usbg2: usbg2 {
>+		compatible = "fsl,imx27-usb-gadget";
>+		dr_mode = "peripheral";
>+		chipidea,usb = <&usb2>;
>+		bootph-pre-ram;
>+		status = "okay";
>+	};

The above two nodes does not have a working driver in upstream.

>+
>+	reg_m2_pwr: regulator-m2-pwr {
>+		compatible = "regulator-fixed";
>+		regulator-name = "M.2-power";
>+		regulator-min-microvolt = <3300000>;
>+		regulator-max-microvolt = <3300000>;
>+		gpio = <&pcal6524 20 GPIO_ACTIVE_HIGH>;
>+		enable-active-high;
>+		/*
>+		 * M.2 device only can be enabled(W_DISABLE1#) after all Power
>+		 * Rails reach their minimum operating voltage (PCI Express M.2
>+		 * Specification r5.1 3.1.4 Power-up Timing).
>+		 * Set a delay equal to the max value of Tsettle here.
>+		 */
>+		startup-delay-us = <5000>;
>+	};
>+};
>+
>+&A55_0 {
>+	clocks = <&scmi_clk IMX952_CLK_ARMPLL_PFD0>;
>+	/delete-property/ power-domains;
>+};
>+
>+&A55_1 {
>+	clocks = <&scmi_clk IMX952_CLK_ARMPLL_PFD0>;
>+	/delete-property/ power-domains;
>+};
>+
>+&A55_2 {
>+	clocks = <&scmi_clk IMX952_CLK_ARMPLL_PFD0>;
>+	/delete-property/ power-domains;
>+};
>+
>+&A55_3 {
>+	clocks = <&scmi_clk IMX952_CLK_ARMPLL_PFD0>;
>+	/delete-property/ power-domains;
>+};
>+
>+&aips1 {
>+	bootph-all;
>+};
>+
>+&aips2 {
>+	bootph-all;
>+};
>+
>+&aips3 {
>+	bootph-all;
>+};
>+
>+&clk_ext1 {
>+	bootph-all;
>+};
>+
>+&clk_dummy {
>+	bootph-all;
>+};
>+
>+&clk_osc_24m {
>+	bootph-all;
>+};
>+
>+&elemu1 {
>+	status = "okay";
>+	bootph-all;
>+};
>+
>+&elemu3 {
>+	status = "okay";
>+	bootph-all;
>+};
>+
>+&{/firmware} {
>+	bootph-all;
>+};
>+
>+&{/firmware/scmi} {
>+	bootph-all;
>+};
>+
>+&{/firmware/scmi/protocol@11} {
>+	bootph-all;
>+};
>+
>+&{/firmware/scmi/protocol@13} {
>+	bootph-all;
>+};
>+
>+&{/firmware/scmi/protocol@14} {
>+	bootph-all;
>+};
>+
>+&{/firmware/scmi/protocol@15} {
>+	bootph-all;
>+};
>+
>+&{/firmware/scmi/protocol@19} {
>+	bootph-all;
>+};
>+
>+&gpio1 {
>+	reg = <0 0x47400000 0 0x1000>, <0 0x47400040 0 0x40>;
>+};
>+
>+&gpio2 {
>+	reg = <0 0x43810000 0 0x1000>, <0 0x43810040 0 0x40>;
>+	bootph-pre-ram;
>+	/*
>+	 * Use one SPL/U-Boot for mx952evk and mx952evkrpmsg, since GPIO2
>+	 * is assigned to M7, disable gpio2 here
>+	 */
>+	status = "disabled";
>+};
>+
>+&gpio3 {
>+	reg = <0 0x43820000 0 0x1000>, <0 0x43820040 0 0x40>;
>+	bootph-pre-ram;
>+};
>+
>+&gpio4 {
>+	reg = <0 0x43840000 0 0x1000>, <0 0x43840040 0 0x40>;
>+	bootph-pre-ram;
>+};
>+
>+&gpio5 {
>+	reg = <0 0x43850000 0 0x1000>, <0 0x43850040 0 0x40>;
>+	bootph-pre-ram;
>+};
>+
>+&lpuart1 {
>+	bootph-pre-ram;
>+};
>+
>+&mu2 {
>+	bootph-all;
>+};
>+
>+&reg_usdhc2_vmmc {
>+	bootph-pre-ram;
>+};
>+
>+&scmi_buf0 {
>+	reg = <0x0 0x400>;
>+	bootph-all;
>+};
>+
>+&scmi_buf1 {
>+	bootph-all;
>+};
>+
>+&{/soc} {
>+	bootph-all;
>+};
>+
>+&sram0 {
>+	bootph-all;
>+};
>+
>+&usdhc1 {
>+	bootph-pre-ram;
>+};
>+
>+&usdhc2 {
>+	bootph-pre-ram;
>+};
>+
>+&scmi_iomuxc {
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&pinctrl_hog>;
>+
>+	pinctrl_hog: hoggrp {
>+		bootph-pre-ram;
>+
>+		fsl,pins = <
>+			IMX952_PAD_XSPI1_SS1_B__WAKEUPMIX_TOP_GPIO5_IO_11	0x3fe
>+			IMX952_PAD_GPIO_IO12__WAKEUPMIX_TOP_TPM3_CH2		0x51e
>+			IMX952_PAD_CCM_CLKO1__WAKEUPMIX_TOP_GPIO3_IO_26		0x3fe
>+			IMX952_PAD_CCM_CLKO2__WAKEUPMIX_TOP_GPIO3_IO_27		0x3fe
>+		>;

Add a comment for the settings, why they needs to be set in hog.

>+	};
>+};
>+
>+&pinctrl_uart1 {
>+	bootph-pre-ram;
>+};
>+
>+&pinctrl_usdhc1 {
>+	bootph-pre-ram;
>+};
>+
>+&pinctrl_usdhc1_100mhz {
>+	bootph-pre-ram;
>+};
>+
>+&pinctrl_usdhc1_200mhz {
>+	bootph-pre-ram;
>+};
>+
>+&pinctrl_usdhc2 {
>+	bootph-pre-ram;
>+};
>+
>+&pinctrl_usdhc2_100mhz {
>+	bootph-pre-ram;
>+};
>+
>+&pinctrl_usdhc2_200mhz {
>+	bootph-pre-ram;
>+};
>+
>+&pinctrl_usdhc2_gpio {
>+	bootph-pre-ram;
>+};
>+
>+&pinctrl_reg_usdhc2_vmmc {
>+	bootph-pre-ram;
>+};

Regards
Peng
>
>-- 
>2.43.0
>
