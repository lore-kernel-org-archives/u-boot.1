Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5631DCCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 14:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CB5F83D8B;
	Fri,  7 Nov 2025 15:14:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nNGuwPem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFCAC83D0B; Fri,  7 Nov 2025 12:04:26 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD73583CB8
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 12:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwIlYfY1dZonkhiGGWNRptV3pyT6zLzd3dzZcGzFzA5elm/Vz8lO7JIBMLHp9vOm5qibqGTSQ3G4yOjKiHMYhREsLwXFmBXc2nqV58R++NMuqiKL0T8NFhvMjeJpTBePJ80zvqHpfdWTaw9BtZ29SaG9ZmxWL3xjfNCP+Vlo/9HY4txdzt5XuDBpVIa1taNabeHaE5dKqKTw1bHHmL1BOpgw0ZTx5zltrxsjSestYkbcOuoq4BSbsYJ+UmhVLMY5INoyzgj2z3zlZbGHqUryBNtyEZYlafcdvnvPpxf0TUCLZCiWqqIvI7DuOXJgQs/EeUw7FUfRTJxuQ8UFkKWdyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcu5lfnF7WqRZOEkxNM7dCTGPVdIIdYnM+DBmibllo4=;
 b=nvqCBE1Ar4G/55FdC/f5M5ce3SOT+EMsm0grupJy90AmWqorYwxdfvwoYhSvXzFE1xGJ6gxeblOJMBf3ylyHxa3DilOcMk15QczN84jmrpRc5PhrbEQStQZJ1AzFAuAyD7ns4rXKOJ6rxpE3Tsr/fnxeDQuc6ss/72qazTum8MCrMMor0ENM9swDZ8v7QV2amYtW4VBHXoxZ8pUIeHqx7CISLesQGZ2Xm1hPso4I+y0uhrTbrBZjiRha4yTTVGnKp7/ArsN63jHr3CyzkIX13xU7ykyUmLKzxGmFcQsAuTudBJHdZGVpAZXDXflULUDXBFx45HfR9hglDsTwrLycuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcu5lfnF7WqRZOEkxNM7dCTGPVdIIdYnM+DBmibllo4=;
 b=nNGuwPemsRKOGwF1E5qw0BsqXV6WUy2RxIehAhufRVncqhdBYiB0jnmWKT4w0h5fusegeN4RTbhJM4m404XoA9BDmCrBX0qhgnhLFo14nqWXkYhFjkHJSkq3RNS7QRT6LlwjfwTv0iBgHgNcWfS/HaFGrppBJtdR1l02kTfkNXFuigY4uOcO7/oFLapMRzwRjNkUlERbvLJHIISKB2jk1ncU0lWRH5xrkRVRSf4t8szNm459Lbw9JZRio2nLD1yapuMMZ5ht92ZF62H1x78ZBsnef8RUqvime5OGZzE5kqwYU9EDHC4xLuKluhD406z8JeS4IAmwkahZLZvwS2+QNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8852.eurprd04.prod.outlook.com (2603:10a6:20b:42f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 11:04:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 11:04:21 +0000
Date: Fri, 7 Nov 2025 20:16:50 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: Re: [PATCH v2 4/4] clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES
Message-ID: <aQ3jMu4dW61RgbWX@nxa18884-linux>
References: <20251107030352.475169-1-marek.vasut+renesas@mailbox.org>
 <20251107030352.475169-4-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107030352.475169-4-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec917ba-8ed2-4474-e468-08de1ded6759
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rx2x0ErdAlonnXeGBDPNY/myMInEAoq8f1Q9xbqsrT2cIANBfSOuP+OSoCrY?=
 =?us-ascii?Q?PnvbxN02JWhENQpd9vRRZG90xCFc1iHE47zTpLYjVTvhkwAenHlIj7JT3xFO?=
 =?us-ascii?Q?DPJPycYDoi+ezvZw+H+cUj+1icZR4ZvBdN6b6WnNeT4zG2VohFFYmpp6EA/9?=
 =?us-ascii?Q?pMHKmoW96AJtBv9Aui6OoGcZNqHU2s8qO07kyd/ufRGlOpc+Us1kJTF75KkW?=
 =?us-ascii?Q?7XSqwGSpBHfqmidxzcomOa5sPDyN10UMzhubFOyawvFRgVjIgRMCRS/gOpwF?=
 =?us-ascii?Q?wiYKeyavB+nWhBGUzvEXCGYEB2mqtHn2ngVNNLh/zOFKy2EFV4/1pxukoD6O?=
 =?us-ascii?Q?fYAy0PjcCVstsS91AE+t7IVb0FcDDyn+lVz4NFEpgHKyOuANL0oO2t1YZnWg?=
 =?us-ascii?Q?qdVWChowuu1TrlQVNZR7L5Y8VsHd3tZM6XBXEhreZMfb2A6Af6+HqX1Fv4KG?=
 =?us-ascii?Q?czcRWePw/pCwTwgBqTrrGgdKk+ONreCmIlxYtjfuP2T0z49ipdybBZKBwOXw?=
 =?us-ascii?Q?cju+qVtrUgFEtjHnuOIznBT13g/LTcwx9pECsiDpZeLPB3vrvh2Sn7owTZ3H?=
 =?us-ascii?Q?biqMTqRvnVQr822ACs4J2W2AgBuVZY16Hoe93hxuAqtU3JxXj1uMsKxm42pZ?=
 =?us-ascii?Q?f3Lp0JXdHAm/UcgC6a6Sf/XkUDNiZw+Lj0oUq36eLPCVl6c+eZHHIRHLt/ex?=
 =?us-ascii?Q?9aqQaxRYK5GEuVacnwjzqWbe7EJ3B4G444yUZ0n1tXMJiAULlJKehuls4tkV?=
 =?us-ascii?Q?4QlEoHnj1MaNdbT6oejIlBMpWCfVPrE+qTkW9fsgWsddzWABcnEeFH8+TjMo?=
 =?us-ascii?Q?6RXM1ZknUUWqW5oQpJYxCzbXSq4y/UVqj/0u8mrAA23H94Dr9iKpBttrhqYL?=
 =?us-ascii?Q?YxW7biP1gnV5SDewRIoSRdKuCwBdsDvlOKeMfCV3dnIsSK810zNYlj6MD8kA?=
 =?us-ascii?Q?BPZlboOvyABzRdcK/CddQeptg+5wYrsEPdoVjvy7Kb+lliO3rVBHmtfBy+Zd?=
 =?us-ascii?Q?Rvfwy4qVx1DVfokalS84gaCoYAA+wYQ6DIKlCSIluzkLf5jGrXkCaNoaU9be?=
 =?us-ascii?Q?fU7gEEWoVL4ZCbe9+latuekfatr8s4KSSLq4Y+X1T3QrEFWfrF8CvTemDIB4?=
 =?us-ascii?Q?6RTM4f24Nvc+I7uD3akabf0aMos4YGMx2YnUqB6dqEAWjXffX4eKsn3+p8dP?=
 =?us-ascii?Q?lJxFaNDtDL8+tQilchPzcbttwT709S9iO6q1X8UPspdLuCj1HjA4wslHJ/22?=
 =?us-ascii?Q?M83fX4j6FSNYBu2GRh3+graitucXcHEfcBhn7+YKU5uKkvKYGIqQS/y/rRYZ?=
 =?us-ascii?Q?4Y/gkpVs7hAcuQfr+9zkQjWKnRHdb83niJ8e2YgOxE3UGSqZai/ekpa/1DL+?=
 =?us-ascii?Q?hkg49TQE60Qz3IZlIjXXanJyXdjOaZ1hY/l32hvO4CWJy9ca3056BH2klDNy?=
 =?us-ascii?Q?6LlZlwdgzSQddXTdIPNOHlAjP3ZzDKfCAwmjw190368yN8NKJKZi+WnHQ7bj?=
 =?us-ascii?Q?PgRM00JOawyjbq5tzYYuUZ1WqOVSTEI5x1J6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RQJ/mTMZBsc0e8c9//c2ElWjau4+P3u7hc+Nz6d+TO4pfhbsRSjVIc53Yh3s?=
 =?us-ascii?Q?SU05arbYMoRagDY7cF3+KfIF6VnWXbnSV2oHGuEEivN8vkB2AKnbsjVbIsFe?=
 =?us-ascii?Q?9SaNj5xR17cHtdxCxc3+MuAGlta2AufHTneVhjKOcyUIDgPYeGuD0OulU06/?=
 =?us-ascii?Q?LQTFXMgtYVsTrPoHrCevNhuS47E3XYecJHB5jYMfoqu5JtgoVhJgnb78QESy?=
 =?us-ascii?Q?Mz30Ock5cyGWAEZXgTgrtcRs7HC/LmTLMBN0dkPfxKXezAiwgsGsqpmjdkux?=
 =?us-ascii?Q?Z5MTgfmRh422dk0oQdpT8R4VkDsIPU1O1xDtBftBmJbmulv2I4G4pPJNQFQ2?=
 =?us-ascii?Q?p268DQJP5QStWUS7ZMRcdaXaD4IhLvedeD/w1TRr/CL4dGBnxrMDa/EDodNT?=
 =?us-ascii?Q?08pYxg2n4ECWh2s/B4gtS7oUqSqPSNJmWtpIeEr3OmYFRuMzLgMOT5a4yI9P?=
 =?us-ascii?Q?/EJb7an5xkXcIq/uBVXcnc3c2cr/ykjZcq4ZFIvN9rbo8vmwIToPP2BLV2vs?=
 =?us-ascii?Q?soWVMa0dHkB8F/ucvdRu5uKpCpY7EE8KCUxZ4QzXkBfGrL4qTW7ctGgRtZY9?=
 =?us-ascii?Q?BsXC8XlcfFKBe3d1CHmsAot6aeSda/FqHS0g22D3t1HWAeLgNr9fcUs7urjI?=
 =?us-ascii?Q?zvwMlZDNe0HRzWIcNOGKWnxhVetmmDjnXop/dygyFQIbBEE8jGGyfLO7uhm9?=
 =?us-ascii?Q?q4dP5t9Q0U41a7iMoxIHaXM4ffw3R20tVvErSA0ckBNF2CgNjGdV+DgUTaXh?=
 =?us-ascii?Q?WrKp8zDHzjdeJC4Aq7wGTE8OHV+sjKNSlPv4wBL4z+LcAChi5sM1ycD8ZjZo?=
 =?us-ascii?Q?vfcCJY4iBGSbZWhD+OGQWUsRAd97UATw4w+JpM/P6oX0SOs0LVzhDiN/zHJb?=
 =?us-ascii?Q?2D23FwobJxInoADLbBID9E8zBycWgQ0l8FWLNZozf1GerJD6iDxmC87lHF9f?=
 =?us-ascii?Q?Kj1nByqeO+fap0rcg/IPhJXrZZvHhMpF980Ehc0n590tTRGA/8gXO8mnJTN/?=
 =?us-ascii?Q?RD13XIXXdR9WdvZBqEkmmJN94X6pgDHgJRZPPxSoClENWiKOpb9lHxSiiLud?=
 =?us-ascii?Q?ryh1jHJH3Iq5KbwT8t56ui/Dp9rfwK5441lyjjdws2HDQat8lxbWSOBpKZKV?=
 =?us-ascii?Q?aHcLdOR/k3qIqhTKwk7Xjmj8okPPUj4eireyh/90lsIX5mjuqPw2zvj3T3C5?=
 =?us-ascii?Q?kqZRJDbF4Azng1UwBZyih4ax6dBxGf7gZmvq8FHr5wQq169/H5bI6xzxVGgk?=
 =?us-ascii?Q?9HMjBqrhGFI80mQngghov/IYtVGr2vn/pesKaxscH5QupoymV2K7/YIcV65a?=
 =?us-ascii?Q?mJr7XZQJizceuidyfCmYhJX5YYtpvcXHP0RHEb7eXiulOdjzvYrvdiYHGBx9?=
 =?us-ascii?Q?INipXWlWvYWVOY1eVxx/oQnLDgfOJt+ldYkkdHzj7KJrVtdScK20iX4TX1KM?=
 =?us-ascii?Q?MYNbVxjYLE1FdbWu7mHrFDayRQkVwDnD+4JoESgkII/vZHEK6RB1ON1W8p0B?=
 =?us-ascii?Q?N0WOnZR4RxqKBO7L9VjLkVFKrjh2ErLHmTSVkoCvi6qATvq7uTBCDxHfWVl5?=
 =?us-ascii?Q?hUycF53bPCF9DGHeZgC7YqFSotzQqVrWodt/puSG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec917ba-8ed2-4474-e468-08de1ded6759
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 11:04:21.5368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYokNbYU1DNLZm5BpcyuRjugd5nzMhcE3s11Vk44QjiveI1KU6Ni6+uo63wpygXgoTMzYWOsUcwqwEuXyFa4Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8852
X-Mailman-Approved-At: Fri, 07 Nov 2025 15:14:30 +0100
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

Hi Marek,

On Fri, Nov 07, 2025 at 04:01:26AM +0100, Marek Vasut wrote:
>Instead of resolving clock control flags using SCMI_CLOCK_ATTRIBUTES
>during probe for each and every clock, resolve the clock control
>flags using SCMI_CLOCK_ATTRIBUTES when the clock control flags are
>first used. Because most clock are never used by U-Boot, this allows
>reducing the amount of SCMI_CLOCK_ATTRIBUTES considerably, and this
>improve probe time of the scmi clock driver and U-Boot start up time.
>
>On Renesas X5H, with 1700+ SCMI clock, the boot time improved by 1.7s .
>
> 
> static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
> {
>+	struct udevice *dev = clk->dev->parent;

I will change this to "clk->dev", otherwise there is CI failure.

No need to use clk->dev->parent here. The core code will
find out the scmi root device.

No need send v3, I could patch it in tree if no objections.

Thanks,
Peng.

> 	struct clk_scmi *clkscmi;
>+	u32 attributes;
> 	struct clk *c;
> 	int ret;
