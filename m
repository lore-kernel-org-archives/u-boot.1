Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD9FD1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 09:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B691B83C54;
	Tue,  9 Dec 2025 10:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="i6FzeswX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A5F83AEE; Tue,  9 Dec 2025 09:58:56 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C38783885
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 09:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFAk3IeDJNb8HZX2eHm10dWqZ9RZA704W99LpxNRmWAekBPQ/WVaKvsQKJ5uE0Ve94F/Gi/0EK/i5otz+ly5bS0BKXWOV4feeUYCYkBBzDk2+jOvkerRmjuOLiG16OscFrVwL46i0wSSZ9B6s5QpGX9vHE9ZrI4DQcek1xIaoNstcyhOTfdRwrgvV9ujaqRxViZplJ4VvDdzgLcVGnrvxFz2UP3z52gC1kAw4lGu6EDVo9PvGaXeoxp37URHP2eyfIkvWm2SaZR48R27YkUiYpAfEAaqe2+5P72kg/Ek6B2lSVT1TY8zGe0BDxbKNgoCth4bovki/az7rPw8pcnIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qr6WOpzENpacq0PrS5l7JLF3Ao2NYF5oNhN2s/rVuno=;
 b=lEF+P8US1+6P2VGzBwvmtoPVzKAhlYebBJ7Fba7RuSYF55CbxHWvofV/oxYhn5bFrfmHxGpKT3serMG9YDTjzPcgjhQgI/Kst1OGX4/5AwM8iEkb00pIJP+P+aDaEpzzx5s+iHWeFllSm0WUZvfQb3Dj8CyxkeLGCRI45ixzbxKpyK/TpM4VWwdvgnFBNblWPKCLybk+hB/OXl8E3w1Hvvyw4JkA31RygucgfbBMETBlC4DuohYbbAbTga+/05Q7EboLhOTgx7i9St5C+nMlF8Z5q7LLzmIG0jzU4gt3aXKGS8f+X4qkORXXanZO6w1dcuB4UqGAZ6k35soHuIQFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qr6WOpzENpacq0PrS5l7JLF3Ao2NYF5oNhN2s/rVuno=;
 b=i6FzeswXktTAarlpKNaJDGXdYaDA64SAPdHKUMg0pvyDwX0UdD9LBl1PhVtCC3rEK4SS74/LNAt6/lvbaF/uhU+G9QI4xMmCLVeAfaDbshXbv21MAodgP3JUA1DEhkNxvsbcyedw7BNEJyxB2Cu6osXTrK3PnCsIihbRaySXoNr3GyhgvWaamI0thq5c7tytWAdFPhG2fgI0wXOrar7ZVmWJbyc/GYZfhc4DDqOxNJivXQXPvwnMmEW+tGTLuD0UmgJqzQ8sJCPJFxLMMnx3VkeuTZqeGUF/qMw25QQUxjJyfxQvY37dqrnUJRuNq8TN8PtbmE4aQx6t/mI18tVi/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9558.eurprd04.prod.outlook.com (2603:10a6:20b:482::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 08:58:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Tue, 9 Dec 2025
 08:58:52 +0000
Date: Tue, 9 Dec 2025 17:00:01 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>
Subject: Re: [PATCH 2/3] clk: scmi: Fix priv initialization in scmi_clk_gate()
Message-ID: <aTflEeNvyzsfJ6Nw@shlinux89>
References: <20251208-sqqs-v1-0-290f0594e30b@foss.st.com>
 <20251208-sqqs-v1-2-290f0594e30b@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-sqqs-v1-2-290f0594e30b@foss.st.com>
X-ClientProxiedBy: SGBP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::26)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS1PR04MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: cf290f6f-81ba-453f-93a0-08de37012cc7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|1800799024|19092799006|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MK6f3gLAc7u/ODnLHaJ4yf8B3FZc0lKMThmfVkY+fJjW9owQl8salbko2ct8?=
 =?us-ascii?Q?vVMWjKibbc4FtctJrbi3oIloBLEqtnFIFyj6VtC45Z3HKN7Kr2HtHSKRVlyP?=
 =?us-ascii?Q?JJgx+zk7PqtddB/CAJguLrgnkitBZO6bvhNwSeuVhBINRBzY0o8Uj6w/v2x0?=
 =?us-ascii?Q?zhf6/wKH1/bq9KSz0gJBGnCZ4M0j9OSCc1pGGG7DIAEGRL7KpUdMulkn08wg?=
 =?us-ascii?Q?Jj8BA/T1noF/CIuzidOoJvmE2/Dr3azBrsAa1YW0KwUoW94EIc3pEaGe8Map?=
 =?us-ascii?Q?ryjxxDuubUAyWGhRLPpkS1GrhfaP/lXbsaCNHHshiDuz6+GcqGuMrBFtu+FV?=
 =?us-ascii?Q?DsYAPOFpLZPSU3+Fv0IFhoQsPvsREZVYy1vCljR5aZRoBb2OcN+REGxOOcQJ?=
 =?us-ascii?Q?ekqk3jhLVSn02/8pgL3Q6HrrjIk8wkVyjP21IcakCtHLBpRLYEfItBjDaRK+?=
 =?us-ascii?Q?F3H4Ftky9zXVPit+CuHzsga6C7bByqJ/cebqvk8MXoLk7ZBwKR0Pk4pWQL3P?=
 =?us-ascii?Q?ljPls3wwfDH8PXCQ6VbqIj10xaBV9dq70dr7GxUMw9kHEqoQHKhnLriO03ax?=
 =?us-ascii?Q?1F5OigjXROFj6Kf9Hg4aLsoO6akjuf5pcW1tKVm43GoyGaEQy6DhAkOATCZf?=
 =?us-ascii?Q?EGsiaC9EyMixHa0VFjjQJGHMPnK6Xalb0/6ILT/WZ4qE+oMAb02DjJx+FbPG?=
 =?us-ascii?Q?CqSxqZ8J+N7BL9ahRz7FUCCth3lyyQNwbE25vfgcqgIsjvumJHZQXXDG3IQb?=
 =?us-ascii?Q?41q4sriOcWRpSLbhrXCUwF9YasHrMPjXNl0OgMWokIIlu17CWLdxc8jnn31/?=
 =?us-ascii?Q?87mnGik+Uqo/WcQQB11FsbAmOIFYOpc3O9jQ9pJfeIp2iNxRZtQ05HDCosZ5?=
 =?us-ascii?Q?YJxSOrfweC3y6sIMC0R8ieFzQxckhALybWE3Rj7TETfsVti9UnggFasVasIv?=
 =?us-ascii?Q?p4zSwp0GJu20o8toFGY3Gr7tGtWa2aGsDCJOO6Xd97Dq7fZtOooOdxiDlO/e?=
 =?us-ascii?Q?4Zm5cuz7JTH7Agw3z+sS+x1OqmNNBoa82kioDXb6xT5c/tByRvcljY+ua8pu?=
 =?us-ascii?Q?bL1Jzjra3GqFe9xdWrAJEoc6ynexJscUOVxMcj+5raKvo+Y4KqAuwj2G6EcG?=
 =?us-ascii?Q?xlgydOPnvDLWIrj/vsi0L31z/UJyjl1dbU/w3yHVY4r6oPgWZVkSHbCO8SdC?=
 =?us-ascii?Q?ilR3v1Spuk1+iPfaVZMDwg3XW9HTBjwuI+8vbww4x6/FDQwgxhxMGohPSz1/?=
 =?us-ascii?Q?+/1jRY/Y7TgAd46iIah/KCBgmA4C8VKcpNUWsHq4KaTGoYxDPOBMNwIP8Gbp?=
 =?us-ascii?Q?kCNtCl7rujwpfX08y1GW7s0bwl0T48Fv6r9iJQKN/gFAGBgk2B6hOd9FT0nB?=
 =?us-ascii?Q?sLCar7RK7WAWLwBndbl3QZdMSkPB6NEQqngGfHZDd+VSOJy2HhMOJMmP+aFd?=
 =?us-ascii?Q?yxvjaMHPdjUA7Y2a5niSQ4NZhJQPdfZ8F2EAvBDNL4sjDZkwnCkqElbwqVbD?=
 =?us-ascii?Q?iuByiu5GzuUbnXzZpSJWLB1kPVEozf0PkeMw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(19092799006)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wM8GTzVtyXvpAx4sH3CkXSkOgWaFB821UZp15Fx47JPfEhVZevDz/13P2bY2?=
 =?us-ascii?Q?B3ml1FkfwMRkQn6Up5fzrKKi6vzoz1Ui2kAiJwHWtbOONTExVKmowVuoyVad?=
 =?us-ascii?Q?nnqDWTv4zcyms++YgaoffWSQtj22/vOyGPbrC+AbSnZpHN6dbPk2UghtvMOW?=
 =?us-ascii?Q?AhZjrWx0k2FDuTQ4yiIS09hl8xlT5IxKvjRZwLBNORCUoTwxFkC2IdEqxvga?=
 =?us-ascii?Q?N09le4d5jMEfDzuO9pfFs7VKB0T0GirsHXoz5SWp1BvU4SL0mKvDQPvETaBj?=
 =?us-ascii?Q?I/jyHF9inx1PVzRZhDGMa5qrwjs0nm6HZsv94D7JLWhlsowVpbEOAAgzIo/k?=
 =?us-ascii?Q?LHSRpSjYJE4ug1Atl0vKtvtZHtiWrwUcHs0EbLrdDKK376WjCHeEoFqjB0BI?=
 =?us-ascii?Q?LcHYbNaF29SM5tvggO6DAg4qSkApBnfGLspgsqIFvHKQkQ5KPNn6ruj9ceYH?=
 =?us-ascii?Q?sHMa6KJ5LCSFAp8Nz7mAEjlIydvVnJPSObK5zx6amTck756xQQiaVX4yiEwR?=
 =?us-ascii?Q?1Mwr6j+FTxLgQiBsolCDVt1J5oTbLzEhm0r2sMuBeeFEhophvKFb70jgSnjj?=
 =?us-ascii?Q?dXhyoeZexdwW8nq9JwjHLA29UUHrS5vwI3s9unFgB6lf5Fxo8JKOomfaGlHl?=
 =?us-ascii?Q?vwlbBZcee/RNeBSkSsTSeozMxTUcfj05cyCescrIPGNHn9qvzOUedzhZmqrz?=
 =?us-ascii?Q?oeMl9XvT+7VVGL65I5PFwd5nDe4qPqtz0D5CaCdmtfjMeGMIvvMr/7Fvi7tn?=
 =?us-ascii?Q?LL8r9RG1odoq6Lp7XHtE1TO4yM5hbuFcWLUw7a1SO1FsyJLkTaKB2v9eTTaU?=
 =?us-ascii?Q?U0mCHciZfGcByz50KZSxFXt0iVMP6UAYzN5PdBiJV/UjGGdQVR3qs1mL6fbZ?=
 =?us-ascii?Q?tU8dxGjXW77gIC0OhDrypP7e03GpBLNNb5gHgnMAYVa4zVVgPkXmjOqiHP7Q?=
 =?us-ascii?Q?NWqbcHvApghbw5dVy9Qc/QRsi0EV6pagOM/SLk1IiTvAoctPCAamkLfRBU+B?=
 =?us-ascii?Q?g/74XNDMV53COxQ3d7SCdh1KERZyUowZkeogeWJOr667gO0HAHrVi9Y0AfNQ?=
 =?us-ascii?Q?AG5BgbK2KP5mZN3mXWyX2v5I9PlZ9p0FBAVYLA6FRIL+NdJttxeePFL8PGv2?=
 =?us-ascii?Q?RwmW9mt2vGd0vNeATGpc+bdyH8Ck6p0AfDS0YOe3G+Wd7y5AYSHLTZ4FdYR5?=
 =?us-ascii?Q?r8CeWbFi6Me2FRsUUMVrcNPJGrh5f2/ePsTRzqNQcWZSUaX999VYWZ+SPq8p?=
 =?us-ascii?Q?H2gbYktW/ZmQeDUbKRfPpbS7I92GCOQ+3WCfZzhGQpvrv7nGvm7vbpabWELC?=
 =?us-ascii?Q?GwAMmB+6t4646TRUhSuZ3pr987N0r8/c9dKYIYqVDaZj1HwN1/K5Kh7OKR7i?=
 =?us-ascii?Q?pm24CO76qcVwjDgXokc/r/+647aluxlaT74URh/CBQ+fIS+LW7DcA1hSzUfN?=
 =?us-ascii?Q?ts4RoMAPqT+QHeSw+BsyFQZ1vvcaqqbcQq+1dO1iUeMDY7BcdSIM54Bs7pwS?=
 =?us-ascii?Q?SH8+Gifn6MziEtbXTyOKPC2T6G27Br1Zf4297nDaCByTDK1tgYaEqYwNaFrr?=
 =?us-ascii?Q?ynAdJzd5IVoUZI4iRDIGdOxORxzaSaaeqWdEGmNh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf290f6f-81ba-453f-93a0-08de37012cc7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:58:52.0794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzAxRFcRqHPWgD9rEPmb+JQUbWpmMkTz4NkeB0tRBiJxab7HQGtH8ylUTuettY1YyBslMIT28W4tTIodfj+eKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9558
X-Mailman-Approved-At: Tue, 09 Dec 2025 10:26:50 +0100
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

On Mon, Dec 08, 2025 at 02:51:26PM +0100, Patrice Chotard wrote:
>In scmi_clk_probe(), in case of CLK_CCF is not enabled, parent private
>data is not set, so in scmi_clk_gate(), an uninitialized priv struct is
>retrieved.
>
>SCMI request is performed either using scmi_clk_state_in_v1 or
>scmi_clk_state_in_v2 struct depending of the unpredictable value of
>priv->version which leads to error during SCMI clock enable.
>
>Issue detected on STM32MP157C-DK2 board using the SCMI device tree
>stm32mp157c-dk2-scmi.dts.
>
>Fixes: 0619cb32030b ("firmware: scmi: Add clock v3.2 CONFIG_SET support")
>
>Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
