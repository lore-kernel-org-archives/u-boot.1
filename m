Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CADCCCD195
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FA89838AB;
	Wed, 22 Oct 2025 09:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZLHtcrfb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14629832BC; Wed, 22 Oct 2025 09:02:05 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E4FF82E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:02:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJhtye3vpTUuZ/O8lkpG1uGuWQ348iJkk8NFCdSonkfFjVOUT5N64P9VvmeJlY6uE/qjoegwyPBD/7fNwV5GrXgQDue5q9iVr0uF/FEVRHv4EI0NM8JuY9sykqd3DH0uXQnJLcZivPukK3GzAdEdDRCQnuGQxi2T5y4AygbZEY/wuCuw5NVBZFoq68t69LpyV5xgI3spy+sShuYG/mrS2kdVJlMPS4P3URIg3N048TbOlFWs7e9etvJ3cDFllOKDuFs55yKFWhOLk+T63NYVslARKEvefx2DbRKde1GPpQmkP77NXzynlPDiwrglwMSAYk/rb3yHDKvvNKJQ6ePGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiZpCzkovZykM1/zgjqw7f8FojDRBhWieqs2w3Ng048=;
 b=PJGP/1O3hbCLTZImJcTFdvipS5ZfJSbDWGKcgYrpCU40iIFHdpTnPXyBp42Zz2f9723bhmW1EA/4XJTrH3QP/NrTwP24S9qQVnKy0OZy4uKusJQk3FFHDzXhcdRGXiyqzP7qw8Eiow3AEuwyptq+aUAAeoFuFCu/XUmxTfGLgyRmctTTn3zdMw5oQrsqLfk8OCfYtKAnFX7mpBTuszUovxeuYRBYW2FAdDRw2FqAbLA05ye1bfFc7eLaU3BLs6u3DCgaaKS6WG5FSc84kdCaXytY66FFk/3TxuVgG40ZO6uH17pDDZzi1blLfMAuuGr8iCzcxhoc2HgRSWwzAljxNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiZpCzkovZykM1/zgjqw7f8FojDRBhWieqs2w3Ng048=;
 b=ZLHtcrfbqG21+f1wL7Nx691Y5ZzVCTHU8AC7G8bpLjhHIzpQjHHCG3DJhh72oM72IsynbwZcFg0aDtd/kWYdccX8L4u4dt1PVPg89g/dFhnlEA+4yxrlpREgzQArQrVyHlRNc1isqy3gX9pXWFC6Qx/PgTKRH5laasDqS36qdqKzz67jDVy1qdumhJzOmjv+MMntIiXn0VzvV/37/nUTfbaD5GqBoy5InonOtq5IW3mqWNdQimuhEQpT3wm+KrtNlhBUbwbMcmG/UuxGad52L7FM8vt68mSlg7105XSh8zDdJI/UAZJd8SGq//VoDWoFxh3rhXIkyByYAijMuRlX8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8572.eurprd04.prod.outlook.com (2603:10a6:20b:437::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:02:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:01:59 +0000
Date: Wed, 22 Oct 2025 16:14:10 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Ronald Wahl <ronald.wahl@legrand.com>, Anand Moon <linux.amoon@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Henrik Grimler <henrik@grimler.se>
Subject: Re: [PATCH 4/9] mmc: dw_mmc: add voltage switch command flag
Message-ID: <20251022081410.GC30163@nxa18884-linux.ap.freescale.net>
References: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
 <20251017-mmc-dw-exynos7870-v1-4-a2c5139d9afe@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-mmc-dw-exynos7870-v1-4-a2c5139d9afe@disroot.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b48e3ac-3332-4e55-1672-08de1138e4cc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|19092799006|1800799024|366016|376014|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qj0uFYWS2d5nvcmbIUVfWsidFtnbTBNKKbD1iieZsZK9gbBDbKrl3Zhgq7rc?=
 =?us-ascii?Q?u7muNbdxIp9Rtv3F1ns8M6Tg/1gn38aafgMiwKPXrnlP4+Q+JtK8vRwagB3u?=
 =?us-ascii?Q?YffUPPSGmTMu8Il6GFHx2lv+QX+DNdKTbCxVl1jzXqyDYUO5DPpPzMlSnPmh?=
 =?us-ascii?Q?OTKNrYTO0Idf3zFoLezedCDa5MYmVmhApeUJ1Lk+z0+JOK4LUfY+o/ywq+Tk?=
 =?us-ascii?Q?LRncpKSwQWgwe3ti+L0xNoBt1Exe4lXWEeI0E0dV7XHWAvzfeEFbwuqUFKxg?=
 =?us-ascii?Q?YauFeyyqWL6xZav0SM17RvtY1+JkpHe6s2MfJgWlPD4lps/gphNzq+FZ/ZS6?=
 =?us-ascii?Q?LgWKkU+wiQW88B/eMXMwg3qUKYseCt60qH8LirtHITmtQs35KzrK8HWZF31Y?=
 =?us-ascii?Q?cdMDgUcin+GQdF55AexpN/QFY/d7A8sdx9vr/KbVIjwpo4GglE4p0DxUCwI7?=
 =?us-ascii?Q?q46AKxytfYO5WSsHR2ppMQh7rSZFPZs1sQSu5jVJxJYR44uRYrkJpoGjzI88?=
 =?us-ascii?Q?/hzg+wlKGlBLkXOEd1M3IRH+WUIxRWP4TFD6eRNS4bCatoeLcPhUdGJIib9s?=
 =?us-ascii?Q?lUIDLN7xft0A6xnU4BWDqPG6qffC1+4wy3izB4duSeHX3yWCSNOpdE1N8vJN?=
 =?us-ascii?Q?FnUtNE6psgzcXsIcnkUzLYw4zrtNaMkwmjiai2fB2vNNAQ7qtGJ2fxg0XKd6?=
 =?us-ascii?Q?kxk9qD/F3CbEOd5ka3CjwZ3jMLkI0AgilgHxVhG692tmHddiGiBaT30QfBKm?=
 =?us-ascii?Q?MzHo+w4XrQ/Dm2mG947NrBCJaThByjpqb7zlpHVSDpvmOsriQl8N53t/IBCX?=
 =?us-ascii?Q?opRJGIf79iaxFj2RCgtq/WKEfpewNk++HvSW8/wO8pH4izIa3Vxt09Vpegke?=
 =?us-ascii?Q?LA4ZX08It4jLsjNjgwsdaCR5YaLVoomZuw11OJua4kS//6B/2pk0iA32ZXZN?=
 =?us-ascii?Q?fgMmC8zCvgTYgsPENEm3ysWmIlGMiBljPk0yPZBq5+Sz3D87TbVTFgZxRErf?=
 =?us-ascii?Q?P9IZxdozuAd5xTWXCenNUgB+tqKpPBvDmp2W921GYQb29fS5i+tmZ1V1Z3P6?=
 =?us-ascii?Q?xCSQwtzRtKATUARxBwF61QZwfFrKqBUmjBsbNy0gR2kVIPYrqpjzsDDDiTfE?=
 =?us-ascii?Q?3l6TLHVXaxSqTTD1J2aXmaUGbMDdXuSy4KLUAZ2G0/ECaC0wrCEBqYkBL3o5?=
 =?us-ascii?Q?YTRxQzliXugC7UtQgGiN/LHEFlm6gTwdiFVuI0yw1r1MgbZY16oh0v35F4AI?=
 =?us-ascii?Q?E6gtbhKn1eufxiLBSbGIK1G6XGL0PjPYxRkWdNBB4BG0Pp2vA6oZj/ngIlj9?=
 =?us-ascii?Q?K5UWGbJbJZeX7tOk16Oi18T3ticALbMF6JIvBPI0hsBSXXohRcB/tawSb19A?=
 =?us-ascii?Q?NjJ1sSSbtkZNsmsgKTEtLORV3LbjWYb3BctmsC0wIhR6puwCLOU66kVecB+p?=
 =?us-ascii?Q?2gvI74gsfuYOAJbj+VrCSZORJonr+OSZ/brhTltb1LUm5YnKF4x2iHSqroVw?=
 =?us-ascii?Q?1kMFo1N6HCb3XX2ZCmWLtTzebzGHCAF2n/fC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(19092799006)(1800799024)(366016)(376014)(7416014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yiHfPRNqwWENTWh2GEzZ17q/2r/AjmGQDr/EehHe/oj2MuoIR+JEKgDhju2T?=
 =?us-ascii?Q?5RBZClCxIFhBp4qA+Z4dmnyIn49trWk1AnFtlAiB+v+JcvyWYiicmH+8eyde?=
 =?us-ascii?Q?/msxqJkvICJSMuY5fQK28RV74Is7MNFTZvXBiaKyZN4Ow5VIMjhf1OSviiU4?=
 =?us-ascii?Q?jwThq3ibxIeROAUjr8o97CY+gmraPRjpIUkfsjbrGJalrOF651vgyKEPC5LJ?=
 =?us-ascii?Q?Ookuffz9Zo7pF+NcauE2i31l47rvzaBirSWiYakFXpkh3s+etyT3hKKRxceL?=
 =?us-ascii?Q?rcfssYqByWHUteE0vOq64aXKJ0QLgajtTpd0QsK/iOya2ihjARG8TtpPnsWF?=
 =?us-ascii?Q?G3WGlgL0NVmgI5no42YqHf5saHKPwwpqho1TkELwL/EFwVXisqqLgH4u+lGO?=
 =?us-ascii?Q?DY1MCN9lEQuhhVX0lovNwX1MzJbSZjjpPVs0dgKVpX/Ws5AsnQ72g+HRfdz4?=
 =?us-ascii?Q?hnLvt7ymZjDjOWtcv/7cWVNnfDFCdgo1DTWjfeNfXrPpIWkSiT95ykt6Zm9n?=
 =?us-ascii?Q?zg08dLNkxBi9VHGG/oiB6KR4qq6SZHWD/g4Bm+awQZE4R1dihkgbWMOnWjLG?=
 =?us-ascii?Q?Cz/P9zAy5mpkt02lKpXSuT9Q9QlrGg7E277T/FQp11q0PRu4s9UEACmbjnH/?=
 =?us-ascii?Q?RzxmDhxLiXG68OqJ86t0VnyKobAiZsHLAflk7a4cUC5+SKDodLk9ZGFNI5Uj?=
 =?us-ascii?Q?9UCbDRopgw3CuoAXSvKuBd2Rxcag1WvN54X/8q7FVrzf8PgiyJGyKl7CMPFn?=
 =?us-ascii?Q?rpnUp6Cp4+zvfIHDW/4ixAmwQpewI0l1FIcldwWG7BhjnAklgDy0nVaAFFkN?=
 =?us-ascii?Q?jrNhHNd09cf5ZzkXtt36yGN8b1+mwIxYc8OVFuQ+MfDabqTjbiHfD+vzdEmn?=
 =?us-ascii?Q?ec99qwCBMYRrsUPDpxLebokjEjh6m03NbMb9fGL0lsKB2MebWXgyJwhtvOvO?=
 =?us-ascii?Q?raDChjRgEM7NFducuFc4+tyosngIXEXE985uGO0iGIheH1jtrkJyI3KhZLdM?=
 =?us-ascii?Q?lCzP6TyyiJAEP9IlljFFSGagKWN021CH1I2n2B/AfFlebWiLNaOgbTxCP7GA?=
 =?us-ascii?Q?hpzu6LPIp34OmGCdxZu3A/nkS33SjaKz/7QBKPZJ4miO8OkJFs6gELYIiha2?=
 =?us-ascii?Q?zQ8EMsXjX+3VD3tFbK78rJH/tTjW/J6xYPtE0Zs8zuBKbXQL5R8M+1e1/bM7?=
 =?us-ascii?Q?2+9MQotqvyp7zTIq4fPqWquGj7Y8VwRGJplYV7ihJGq/gkbt11YK4GTvAH2p?=
 =?us-ascii?Q?d+FPR0nyK7eRAdEQxDWyDmIbrJnLFRvpGpx8xKdDqmNTLCfSvrBjg0J6tw2H?=
 =?us-ascii?Q?NBF+HR2b399XldTZrUKngrk7lhuPg/afT5uM+OP9c8ey1eRSj/3mIrFMZfma?=
 =?us-ascii?Q?oDjNBBw7b2oa1F8xa68RENgd0HMtKW2/60LuoU2HqT1zo2JaupdXgm8ZDKhP?=
 =?us-ascii?Q?p2rT8nazgnSxOybyMIq5axyaPMHqHI4TtD9SH/t6TdAxL+oVEXal9FNvnJwy?=
 =?us-ascii?Q?iVGtHvTW5atqfKOYYScXqzNHYJf2/QwiY0bIsILMA8HdAY3Z59eascdzxOWv?=
 =?us-ascii?Q?BKEUNstJC3FxG6fd5KcXcWp5o9tsvvM/875CBU3E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b48e3ac-3332-4e55-1672-08de1138e4cc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:01:59.8437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hAh08ts8pRjsex4j4njd0tnS6Nc1oU8BwqUK4bD33cJd+uyGAoQLQGnujhC6HiUUPY6Wm1tbYxSuOeIfeLaPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8572
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

Hi Kaustabh,

On Fri, Oct 17, 2025 at 08:54:09PM +0530, Kaustabh Chakraborty wrote:
>During a voltage switch command (CMD11, opcode: SD_CMD_SWITCH_UHS18V),
>certain hosts tend to stop responding to subsequent commands. This is
>addressed by introducing an additional command flag,
>DWMCI_CMD_VOLT_SWITCH.

is there any errata or spec have this information public?

>
>The associated interrupt bit is defined as DWMCI_INTMSK_VOLTSW. This is
>set high when a voltage switch is issued, this needs to be waited for
>and set to low. Implement the same in the timeout loop. Do note that
>since DWMCI_INTMSK_VOLTSW shares the same bit as DWMCI_INTMSK_HTO (bit
>10), the interrupt bit needs to be polled for only if the volt switch
>command is issued.
>
>DWMCI_CMD_VOLT_SWITCH also needs to be set for subsequent clken commands
>after the volt switch. To ensure this, add a boolean member in the host
>private struct (herein named volt_switching), which informs if the last
>command issued was for volt switching or not.
>
>Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>---
> drivers/mmc/dw_mmc.c | 15 +++++++++++++--
> include/dwmmc.h      |  4 ++++
> 2 files changed, 17 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
>index 1aa992c352c3f11ccdd1c02745fa988646952261..94b6641c44c39e67aac453c027d519c0e1580de6 100644
>--- a/drivers/mmc/dw_mmc.c
>+++ b/drivers/mmc/dw_mmc.c
>@@ -419,6 +419,10 @@ static int dwmci_send_cmd_common(struct dwmci_host *host, struct mmc_cmd *cmd,
> 	if (cmd->resp_type & MMC_RSP_CRC)
> 		flags |= DWMCI_CMD_CHECK_CRC;
> 
>+	host->volt_switching = (cmd->cmdidx == SD_CMD_SWITCH_UHS18V);
>+	if (host->volt_switching)
>+		flags |= DWMCI_CMD_VOLT_SWITCH;
>+
> 	flags |= cmd->cmdidx | DWMCI_CMD_START | DWMCI_CMD_USE_HOLD_REG;
> 
> 	debug("Sending CMD%d\n", cmd->cmdidx);
>@@ -427,6 +431,10 @@ static int dwmci_send_cmd_common(struct dwmci_host *host, struct mmc_cmd *cmd,
> 
> 	for (i = 0; i < retry; i++) {
> 		mask = dwmci_readl(host, DWMCI_RINTSTS);
>+		if (host->volt_switching && (mask & DWMCI_INTMSK_VOLTSW)) {
>+			dwmci_writel(host, DWMCI_RINTSTS, DWMCI_INTMSK_VOLTSW);
>+			break;
>+		}
> 		if (mask & DWMCI_INTMSK_CDONE) {
> 			if (!data)
> 				dwmci_writel(host, DWMCI_RINTSTS, mask);
>@@ -508,12 +516,15 @@ static int dwmci_control_clken(struct dwmci_host *host, bool on)
> 	const u32 val = on ? DWMCI_CLKEN_ENABLE | DWMCI_CLKEN_LOW_PWR : 0;
> 	const u32 cmd_only_clk = DWMCI_CMD_PRV_DAT_WAIT | DWMCI_CMD_UPD_CLK;
> 	int i, timeout = 10000;
>-	u32 mask;
>+	u32 flags, mask;
> 
> 	dwmci_writel(host, DWMCI_CLKENA, val);
> 
> 	/* Inform CIU */
>-	dwmci_writel(host, DWMCI_CMD, DWMCI_CMD_START | cmd_only_clk);
>+	flags = DWMCI_CMD_START | cmd_only_clk;
>+	if (host->volt_switching)
>+		flags |= DWMCI_CMD_VOLT_SWITCH;
>+	dwmci_writel(host, DWMCI_CMD, flags);
> 
> 	for (i = 0; i < timeout; i++) {
> 		mask = dwmci_readl(host, DWMCI_RINTSTS);
>diff --git a/include/dwmmc.h b/include/dwmmc.h
>index 639a2d28e7860f2ceb09955ee11550e406fd1bd2..47e3220985e900050d9db9d80e0d45efe6c2e545 100644
>--- a/include/dwmmc.h
>+++ b/include/dwmmc.h
>@@ -72,6 +72,7 @@
> #define DWMCI_INTMSK_RTO	BIT(8)
> #define DWMCI_INTMSK_DRTO	BIT(9)
> #define DWMCI_INTMSK_HTO	BIT(10)
>+#define DWMCI_INTMSK_VOLTSW	BIT(10) /* overlap! */
> #define DWMCI_INTMSK_FRUN	BIT(11)
> #define DWMCI_INTMSK_HLE	BIT(12)
> #define DWMCI_INTMSK_SBE	BIT(13)
>@@ -104,6 +105,7 @@
> #define DWMCI_CMD_ABORT_STOP	BIT(14)
> #define DWMCI_CMD_PRV_DAT_WAIT	BIT(13)
> #define DWMCI_CMD_UPD_CLK	BIT(21)
>+#define DWMCI_CMD_VOLT_SWITCH	BIT(28)
> #define DWMCI_CMD_USE_HOLD_REG	BIT(29)
> #define DWMCI_CMD_START		BIT(31)
> 
>@@ -190,6 +192,7 @@ struct dwmci_idmac_regs {
>  * @cfg:	Internal MMC configuration, for !CONFIG_BLK cases
>  * @fifo_mode:	Use FIFO mode (not DMA) to read and write data
>  * @dma_64bit_address: Whether DMA supports 64-bit address mode or not
>+ * @volt_switching: Whether SD voltage switching is in process or not

Since volt_switching y means in process, I not see it is cleared when it is
not needed. Is this expected?

Thanks,
Peng

>  * @regs:	Registers that can vary for different DW MMC block versions
>  */
> struct dwmci_host {
>@@ -229,6 +232,7 @@ struct dwmci_host {
> 
> 	bool fifo_mode;
> 	bool dma_64bit_address;
>+	bool volt_switching;
> 	const struct dwmci_idmac_regs *regs;
> };
> 
>
>-- 
>2.51.0
>
