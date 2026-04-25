Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D2AFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B0B584144;
	Sat, 25 Apr 2026 18:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PkjFHu4o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2193884137; Sat, 25 Apr 2026 18:06:39 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DDE484011
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
Received: from DU0PR04MB9370.eurprd04.prod.outlook.com (2603:10a6:10:359::20)
 by PR3PR04MB7243.eurprd04.prod.outlook.com (2603:10a6:102:8c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Sat, 25 Apr
 2026 11:58:01 +0000
Received: from AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 by DU0PR04MB9370.eurprd04.prod.outlook.com (2603:10a6:10:359::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 09:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbe9d4zUzJM64Be9YS9gJiS8nOSRcpIYQbthOC9cn4TavSDoar6uPDyZSnLnp/JiTDbL5n/0qzRjSIuzSkHWn2K7yWDKVsFzB0KcBS+26oo/+Umppc3kObi4s83zyILyycgN7qmFlCGVCgDTQiYbCXg2DSE1WiQhHIyVV/W0Bkh1ckxiSSjt/TD0Waw1DSbJNMiYdeAQZ9UxPjWUNKpx7Au188xLouALXMJ86FpP9GEEB7RdsWWxoXoHnQtqbnZA42RtIrbI6rJ46TWneis3GWq2e8l5Ongj5CRw/04Y3BmCJbG1mFC3oqYtybzf/qh+9cwlEQI6Dn7iugPYvXawoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAE7Yc5ywoSoDqpVSHvEn805aFO12T/R+5S21hbZM0k=;
 b=ME8LCSn0NC/xTW5Ox6ORYEpbOx3TSM6E7DtpL2zyBSfiuY9xmDQOkyPDSyc9x46xFUNHQPiWbtKX6Z7SJnznndPRF1F0nZNcTOgEM2n8hpfm8XpNWkTdi9DCkZr1rEW3sRFTlx5nDmgqi5GGIMcBJVnzZ8kaK9e3mZeqk41GKXHo3uy0QXXVGdABU68wtSB58URRteXMw/B9TjKJPzk1zOO3Jjao8icS36pFCkZbA83PVtOKZPF5MSY5g3ePAyspvRab9x8ClWiy54bF8Ak/3yxEPEfWw0Y7cVZcpd38ARKUHFsXNJL1Y3ND6DeLjP6qh5mu7h4zckH8iCHgA76pWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAE7Yc5ywoSoDqpVSHvEn805aFO12T/R+5S21hbZM0k=;
 b=PkjFHu4oIsXWehRy0jgx+ql4rJl1tsOeMXG/bzkHK/LvauqaPnXLaL2PGXL2ig9jty+eEjqXwCG9f1R/zWuwck9Cq6sfMpbVt9Qu+lj6/NVAA8GVHOO9ihywQheSXBNWD7KsHZvcnhohEL5tk0HV0V7TfoohRWYXONR+YOeapcEPzREmpHE66Ex6AzvozRXpvlQGcr9gldJ7wZbuXWxJmyxI4qp4eSWY0PLFFCcfNImk5LRDSmIQA2a/VNENUac4vaqsM3PcGN0eOvomgfHyNnA0hoVkPCutu4kuj6eieqTWcT32pR9TmFCDoLBQqDxbASnSMEhEyiEmpvH6mwEHLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Fri, 24 Apr
 2026 23:21:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 23:21:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 25 Apr 2026 08:36:59 +0800
Subject: [PATCH 07/13] imx8mm: mx8menlo: Switch OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-imx8m-of-upstream-v1-7-07527be92e5d@nxp.com>
References: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
In-Reply-To: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm, u-boot@dh-electronics.com
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, "Lukas F. Hartmann" <lukas@mntre.com>, 
 Patrick Wildt <patrick@blueri.se>, Ye Li <ye.li@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 Angus Ainslie <angus@akkea.ca>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Olaf Mandel <o.mandel@menlosystems.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7876:EE_|DU0PR04MB9370:EE_|PR3PR04MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: eebdc8f7-3f8a-416e-0da1-08dea2582894
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: lAy3P1y9EKu5cUUSbraSHd9DnpopZCtZE+S2EgzHkj5LnwsFZXXqoY1tgxWcjbb9Ey/LF9iB+nsZavblbwyFwFtWUhSpgNqV/umlyO/wWjtiARWmzsEDQqs391ow7FiGynpAWXkwYWphmjg0Kc7BuovV5WcCNeVUIWPoE92dKM4/S3FKBZs2vohTVSbVFygnSYrPgxjVF+r9rKRPat7/c9oj+Nv5RDklMvjQc/ac/Pj8LGtDH/mRxnPy/tYGBK8MHIhELhbx9RfIr3bg+iybdJYZSxiIX775LxeYMOIbIrOOt7SbjMihoyjA/MF60A6Rh5aPVgf0CP2ZcRXr1yPpClIbOW7z9uIjRfL8mXqWGwohDLDtSmxvTMHXKtlkZ7HJV6ySzh+3gXVGYYJzE650QKckNElUF+E+COKdJexNjunyH231mRkSQ37SA+HRWJbvHXbK4T4kVi1FIL+AqNmTziF/KhWKLYu92mYk0X+Q6FOwHE2olWKxcY4gKSR8+XKkQBQ/00uBIIk895qkHBN46w0sLUTfB0BTqCARabwaxUdXl6r62Jv1sHVq6maJPugE2dzPsm7yyNSIi+pxwJH41C9RjCpcl5ytvQ+JW7Gdb8tA4NsFHs0ISRYkVh/AcawEhmvRI7Y0GiheL/fsJ9ghe1mIxU6uRv0JsFryhyS/TbTpf5fHLO1PlYmiOuBhfLXtP8MOMFcVxP0dwYlvw1EJ9cliSNAD/rx4cNR4hfNJRGlkVs19CdE/K/Yh9NHULjRv3za7BrjsNAAizfXi+grEdZD5ORd3mStVh9R0fafR4aU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUc2QStCblo5VHNzYUdTWWgxbm1xSkxLN1lUUGthLzNtZUNUQ2dORCtPUHhz?=
 =?utf-8?B?T0UySFpLeXFIVElHbU9aa0J3a3c4bDJOZDRSdEtDckREbE9SRUJiZ0dXdDhZ?=
 =?utf-8?B?Wk1MK0hOZXIzUWRycWxOVkZOZ21aVE90TVQ0aUhwcVhEcHkzQWdOYXpFa3RX?=
 =?utf-8?B?NUhMUlB2ZUVzTU02WFdZREdmc0V0QVM1QWVWd3Y4aUw5bkw1RXp5QktoMmM4?=
 =?utf-8?B?eHVFOGR6MmU5TzZ0RVlzMUROd3VGUDBTZ1NodGdkQXBOY3d3L3N3cVljNDZI?=
 =?utf-8?B?V0Z3UFBVQ1lvWVo3V1BJVENwSUkwU01Kb0VuVjM1bE51M245akVyS0EwWTZW?=
 =?utf-8?B?ZEpSaGVFWHN0M2cwclRRRDlWV1AxUk5tTUF1eFdkUUNVbWdnQ2M2bG1RR1pB?=
 =?utf-8?B?RnNpbVJpclNUTE1zcUdiSFRUTkd5MXBGbFV4N0ZBSDVtVVluRHRNeVAybW1s?=
 =?utf-8?B?a2V5V0ovVExQZ09yY0NrUy9SL1RVcVU2LzNKUWlJczdtTXk3SDM1SDYxZmxZ?=
 =?utf-8?B?UWZFTVljcjRmeHdTOWlFZ0N5Q3NwZ3hvYnQ3L2ZVQkVYMWc0VDRBeEp2cEFj?=
 =?utf-8?B?Ly9PRWJDbXFGYXRQNFdUMlV1Q09aNUtueGxYN1JrYmVGdENtMWNlTTJwa1Fa?=
 =?utf-8?B?bGFTWXNKYzJDQWxpc29UbENzRDJ3Mm5lem5ZTTBBWVlENU5ScWVQdFRRQzMr?=
 =?utf-8?B?NTRjaktsalhyYVZLeHZaeGVYU3ovbkRoRGhVcy96c0l2SGc4S1hmV0J6SXE0?=
 =?utf-8?B?Zmg0Y1kxT01sR1V6SkpiVnM2a0s0S3pPa2FGK2JwczBRbVE0U0gyVWM3Q1pX?=
 =?utf-8?B?YUthRFdBdW9XdmhqTFpFc1A2N0hVMDM4UnljeEJaQ0dWZDZ5djJMNk9rM3hk?=
 =?utf-8?B?NDZ1RWEzdXJXTUxTVFNOdjQyLzdRZjhDZllyN1JiUmxBanFhd1IxRTR0cWlh?=
 =?utf-8?B?RlZRb1YwZEIrZEd3L2VlSFdxT2t2RFEyWmdXVTZseUxLeWxCWCt6NHVEN2s4?=
 =?utf-8?B?ckdDMGx0RExZWEo1R1U1elNDWTE0QlNOS3FHejJJTVdFMU5xaUhrbDZTczVS?=
 =?utf-8?B?Mk9Nb3hqRDhxYUdFUXBNQXdJZFcrejlBL2VLTnF3QWRnYTBOQ0VMUVhVZm0v?=
 =?utf-8?B?OXdlcTJLU0gxRHp4bXZCOElRU3ZHZEtqSm8zdkxBSVRoWGlLbjhaU2ZRQTdB?=
 =?utf-8?B?RlBrSUNaam1QNjJmeTN1UXJtby9FaFllOXA1cDZuZXJCK2JEQ0NkQk5zUlNQ?=
 =?utf-8?B?VStTczVEUGk1VlJPZldKa2lROEtWOG1rdTJ6enE2akhoa3E5SmM4cVhLVU16?=
 =?utf-8?B?Q0k0VW4yL1hPazYxa09oS2tXUjFHS2ZaeS9GODR0SnJtMVMyU1hSemVrNThO?=
 =?utf-8?B?NDJhL3NIVmxYT05VSGYyUWkwOGtxeXl4TjJHV1pHeGxIK3FmMi9xSlBZS0pl?=
 =?utf-8?B?OThYUEFYcDhobllWeXlJMnZuc1JXRWFHd2RSRXI1Lyt4YjFzQkt4cTNSdUsx?=
 =?utf-8?B?YWpiaFpJelQxanhDR3pGVUJMQjROWW9Uc21wcHpydGs5OFUyenJkbmUrdEpS?=
 =?utf-8?B?UFo5emRIRW5QSk5pdi85S1BFY1htUFcrdEg3cmpZb0ZxdEs3TWY2WUV2SUd2?=
 =?utf-8?B?T3JHSmM5YVpIaUxQTFdaem9WWS9mV0srd3M2V3hPSEd4ZTZ3R1pvZW43UGhN?=
 =?utf-8?B?YXI0ZmkwaWE3RGVjUDBYZEI5RyttUDNMdmVpUm9RNEZrUWllL3ZIYXRCbmRt?=
 =?utf-8?B?V2w2Q295NTlRcUV6UHBaazROKzhIMmlDTVpiQlpxZ1RXMGFzM3pKTVJvVGFB?=
 =?utf-8?B?LzR4d0VCSG5SZDVWZVY1SnRwZkpnZk1kZHVza2ZtNlRpRmJxUjB0YkNCUTMw?=
 =?utf-8?B?ZHBwaWJ2WEUvN1c5aXNhelBJazNuaStLNzloR0d1NGdzNjZkMVRremZIWXVw?=
 =?utf-8?B?VXZjOUhyU1VnWGdGQ05nRDFPbUZRYUF1eVV1UEV6eEc0TmNSSFJtZ0dBYzZF?=
 =?utf-8?B?NGQzR1R0SGROUWR3L2Y0TmhUMmg5NFpkODhFMGZlaENJMzYvcFdqaWo1WVVh?=
 =?utf-8?B?bUs1UHlJbDVYYm1kbDhaTTg3WWxacnRqSmU4RVZRNkJ5ekxtV292djUyb3JO?=
 =?utf-8?B?eHp4TWc0L3Y5T1NsQUN2Sm5YQUpKQ2Z1c2RqaEFKeHBGZ1ZwSWRyckdoTUFR?=
 =?utf-8?B?VnI3eU5CNDg0UDkzNUpCZ3UwU2QwQXNIb3JlMmRrZkpBNXl0SENRMi8rcUZk?=
 =?utf-8?B?SXBnWWxZaWxTVzV0ZldjNzVlZkJsRkJJdHY3THpTcml3ZGdqUGUwK2hCZkNP?=
 =?utf-8?B?S2t5U01TS3dyV09EZ1RKTkY2RytzdnlINUJZMGZrVGpVTHd1YVBtUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eebdc8f7-3f8a-416e-0da1-08dea2582894
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 23:21:05.6389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhD0a5pxsUUcThuH/oY6oZpmetC7FND/31S/Np1HFtXAlZS5ovHFNpXg9b6U/YRBUFXWqiaMd4MkoM0T0a2iqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876
X-OriginatorOrg: oss.nxp.com
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

From: Peng Fan <peng.fan@nxp.com>

arch/arm/dts/imx8mm-mx8menlo.dts is almost same as upstream Linux dts,
so switch to OF_UPSTREAM by dropping the U-Boot copy of the dts,
enabling OF_UPSTREAM and updating CONFIG_DEFAULT_DEVICE_TREE.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile             |   1 -
 arch/arm/dts/imx8mm-mx8menlo.dts  | 335 --------------------------------------
 arch/arm/mach-imx/imx8m/Kconfig   |   1 +
 configs/imx8mm-mx8menlo_defconfig |   2 +-
 4 files changed, 2 insertions(+), 337 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index c4360390984..dff05dd5888 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -876,7 +876,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-data-modul-edm-sbc.dtb \
 	imx8mm-icore-mx8mm-ctouch2.dtb \
 	imx8mm-icore-mx8mm-edimm2.2.dtb \
-	imx8mm-mx8menlo.dtb \
 	imx8mm-phg.dtb \
 	imx8mq-cm.dtb \
 	imx8mp-data-modul-edm-sbc.dtb \
diff --git a/arch/arm/dts/imx8mm-mx8menlo.dts b/arch/arm/dts/imx8mm-mx8menlo.dts
deleted file mode 100644
index 0b123a84018..00000000000
--- a/arch/arm/dts/imx8mm-mx8menlo.dts
+++ /dev/null
@@ -1,335 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
-/*
- * Copyright 2021-2022 Marek Vasut <marex@denx.de>
- */
-
-/dts-v1/;
-
-#include "imx8mm-verdin.dtsi"
-
-/ {
-	model = "MENLO MX8MM EMBEDDED DEVICE";
-	compatible = "menlo,mx8menlo",
-		     "toradex,verdin-imx8mm-nonwifi",
-		     "toradex,verdin-imx8mm",
-		     "fsl,imx8mm";
-
-	/delete-node/ gpio-keys;
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_led>;
-
-		led-1 {
-			label = "TestLed601";
-			gpios = <&gpio4 18 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc0";
-		};
-
-		led-2 {
-			label = "TestLed602";
-			gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-	};
-
-	beeper {
-		compatible = "gpio-beeper";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_beeper>;
-		gpios = <&gpio5 3 GPIO_ACTIVE_HIGH>;
-	};
-
-	/* Fixed clock dedicated to SPI CAN on carrier board */
-	clk_xtal20: clk-xtal20 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <20000000>;
-	};
-};
-
-&ecspi1 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1>;
-	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
-	status = "okay";
-
-	/* CAN controller on the baseboard */
-	canfd: can@0 {
-		compatible = "microchip,mcp2518fd";
-		clocks = <&clk_xtal20>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
-		reg = <0>;
-		spi-max-frequency = <2000000>;
-	};
-
-};
-
-&ecspi2 {
-	pinctrl-0 = <&pinctrl_ecspi2 &pinctrl_gpio1>;
-	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>, <&gpio3 4 GPIO_ACTIVE_LOW>;
-	status = "okay";
-
-	spidev@0 {
-		compatible = "menlo,m53cpld";
-		reg = <0>;
-		spi-max-frequency = <25000000>;
-	};
-
-	spidev@1 {
-		compatible = "menlo,m53cpld";
-		reg = <1>;
-		spi-max-frequency = <25000000>;
-	};
-
-};
-
-&ethphy0 {
-	max-speed = <100>;
-};
-
-&fec1 {
-	status = "okay";
-};
-
-&flexspi {
-	status = "okay";
-
-	flash@0 {
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <66000000>;
-		spi-rx-bus-width = <4>;
-		spi-tx-bus-width = <4>;
-	};
-};
-
-&gpio1 {
-	gpio-line-names =
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "";
-};
-
-&gpio2 {
-	gpio-line-names =
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "";
-};
-
-&gpio3 {
-	gpio-line-names =
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "DISP_reset", "KBD_intI",
-		"", "", "", "",
-		"", "", "", "";
-};
-
-&gpio4 {
-	/*
-	 * CPLD_D[n] is ARM_CPLD[n] in schematic
-	 * CPLD_int is SA_INTERRUPT in schematic
-	 * CPLD_reset is RESET_SOFT in schematic
-	 */
-	gpio-line-names =
-		"CPLD_D[6]", "CPLD_int", "CPLD_reset", "",
-		"", "CPLD_D[7]", "", "",
-		"", "", "", "CPLD_D[5]",
-		"CPLD_D[4]", "CPLD_D[3]", "CPLD_D[2]", "CPLD_D[1]",
-		"CPLD_D[0]", "", "", "",
-		"", "", "", "",
-		"", "", "", "KBD_intK",
-		"", "", "", "";
-};
-
-&gpio5 {
-	gpio-line-names =
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "",
-		"", "", "", "";
-};
-
-&gpio_expander_21 {
-	status = "okay";
-};
-
-&hwmon {
-	status = "okay";
-};
-
-&i2c3 {
-	status = "okay";
-};
-
-&i2c4 {
-	/* None of this is present on the SoM. */
-	/delete-node/ bridge@2c;
-	/delete-node/ hdmi@48;
-	/delete-node/ touch@4a;
-	/delete-node/ sensor@4f;
-	/delete-node/ eeprom@50;
-	/delete-node/ eeprom@57;
-};
-
-&iomuxc {
-	pinctrl-0 = <&pinctrl_gpio7>, <&pinctrl_gpio_hog1>,
-		    <&pinctrl_gpio_hog2>, <&pinctrl_gpio_hog3>;
-
-	pinctrl_beeper: beepergrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SPDIF_TX_GPIO5_IO3			0x1c4
-		>;
-	};
-
-	pinctrl_ecspi1: ecspi1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK		0x4
-			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI		0x4
-			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO		0x1c4
-			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x1c4
-		>;
-	};
-
-	pinctrl_led: ledgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI1_TXD6_GPIO4_IO18		0x1c4
-			MX8MM_IOMUXC_SAI1_TXFS_GPIO4_IO10		0x1c4
-		>;
-	};
-
-	pinctrl_uart4_rts: uart4rtsgrp {
-		fsl,pins = <
-			/* SODIMM 222 */
-			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x184
-		>;
-	};
-};
-
-&pinctrl_gpio1 {
-	fsl,pins = <
-		/* SODIMM 206 */
-		MX8MM_IOMUXC_NAND_CE3_B_GPIO3_IO4			0x1c4
-	>;
-};
-
-&pinctrl_gpio_hog1 {
-	fsl,pins = <
-		/* SODIMM 88 */
-		MX8MM_IOMUXC_SAI1_MCLK_GPIO4_IO20			0x1c4
-		/* CPLD_int */
-		MX8MM_IOMUXC_SAI1_RXC_GPIO4_IO1				0x1c4
-		/* CPLD_reset */
-		MX8MM_IOMUXC_SAI1_RXD0_GPIO4_IO2			0x1c4
-		/* SODIMM 94 */
-		MX8MM_IOMUXC_SAI1_RXD1_GPIO4_IO3			0x1c4
-		/* SODIMM 96 */
-		MX8MM_IOMUXC_SAI1_RXD2_GPIO4_IO4			0x1c4
-		/* CPLD_D[7] */
-		MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5			0x184
-		/* CPLD_D[6] */
-		MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0			0x184
-		/* CPLD_D[5] */
-		MX8MM_IOMUXC_SAI1_TXC_GPIO4_IO11			0x184
-		/* CPLD_D[4] */
-		MX8MM_IOMUXC_SAI1_TXD0_GPIO4_IO12			0x184
-		/* CPLD_D[3] */
-		MX8MM_IOMUXC_SAI1_TXD1_GPIO4_IO13			0x184
-		/* CPLD_D[2] */
-		MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14			0x184
-		/* CPLD_D[1] */
-		MX8MM_IOMUXC_SAI1_TXD3_GPIO4_IO15			0x184
-		/* CPLD_D[0] */
-		MX8MM_IOMUXC_SAI1_TXD4_GPIO4_IO16			0x184
-		/* KBD_intK */
-		MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27			0x1c4
-		/* DISP_reset */
-		MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22			0x1c4
-		/* KBD_intI */
-		MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23			0x1c4
-		/* SODIMM 46 */
-		MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24			0x1c4
-	>;
-};
-
-&pinctrl_uart1 {
-	fsl,pins = <
-		/* SODIMM 149 */
-		MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX			0x1c4
-		/* SODIMM 147 */
-		MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX			0x1c4
-		/* SODIMM 210 */
-		MX8MM_IOMUXC_UART3_RXD_UART1_DTE_RTS_B			0x1c4
-		/* SODIMM 212 */
-		MX8MM_IOMUXC_UART3_TXD_UART1_DTE_CTS_B			0x1c4
-	>;
-};
-
-&reg_usb_otg1_vbus {
-	/delete-property/ enable-active-high;
-	gpio = <&gpio1 12 GPIO_ACTIVE_LOW>;
-};
-
-&reg_usb_otg2_vbus {
-	/delete-property/ enable-active-high;
-	gpio = <&gpio1 14 GPIO_ACTIVE_LOW>;
-};
-
-&sai2 {
-	status = "disabled";
-};
-
-&uart1 {
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&uart2 {
-	status = "okay";
-};
-
-&uart4 {
-	pinctrl-0 = <&pinctrl_uart4 &pinctrl_uart4_rts>;
-	linux,rs485-enabled-at-boot-time;
-	rts-gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&usbotg1 {
-	dr_mode = "peripheral";
-	status = "okay";
-};
-
-&usbotg2 {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usdhc2 {
-	status = "okay";
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 0e885f97e63..fbabd17288f 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -132,6 +132,7 @@ config TARGET_IMX8MM_MX8MENLO
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MM_PHG
 	bool "i.MX8MM PHG board"
diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_defconfig
index 097425399b3..55614bd946e 100644
--- a/configs/imx8mm-mx8menlo_defconfig
+++ b/configs/imx8mm-mx8menlo_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mm-mx8menlo"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-mx8menlo"
 CONFIG_TARGET_IMX8MM_MX8MENLO=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288

-- 
2.51.0

