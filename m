Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CA6C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A26F882B7C;
	Mon, 26 May 2025 09:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LEgFiIU8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB26D82CA2; Mon, 26 May 2025 09:09:25 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC34E82B26
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozyPlKVe9DkapR7TISvy1OdeF5p9JzQqjMNg7Gk+MiUWNUR4j3vKEfwBNeuGhiokSnqKP4uz8I9AGTWqfh/pCu1RAiGp8Ctm9UgDdOHBD9JOPnwdNpn/48W00tHM66FqnXRa1MvJW1Kgg5M6wOIlQsa6YGho7F5MMa/IVpSr73udihgIPAwrmQzIgKW50rzuCnqirC9IQ4jna+08trKQYN1CTcZ+2HQWLtDWGkPA45MEVSnmzBdP+m8XoSUj76Eb1xSZu7lWqDnE4lUyZBwqnS6miwS3ZS6CLPpRwC97P22ZEw9aqD4oXGEyv1O7McPcHuExaeR1wE54/Fco3S06vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGfwxRECkuzK9ApNquDtYO6VP0u5JrJEBLjWSZyIo9g=;
 b=sjo5OznkxJd4xHtMikAENIiFbgRoydF7Vjhj/IwW3d0OimUPmFc2HUPkrqSFw/hlSu2sJSl1tncUuabCmlXwWcKXJWC+cegHPhchER+ZbmrxWQYxhtaionaQ7SnQAYlDjPHcF5JhNVq/CgEr63t4aorYVXYYeXl01HVQBgKWy9KI5PXq5WF9jmrhID7iKGAs+d+O9LfoGfkSHvx60oqn5TjcROHseaT4bSGzU6dEXngtq+5qU3hh3k4pxfERmbVkIV1CPHNmYm6T6jLeGj0WqMDqJJbF4cyNCDgRQpfMf3qWyaJBo8bwerlf+rxK4zlzgDA2AM/hpA89kjNZiRoQnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGfwxRECkuzK9ApNquDtYO6VP0u5JrJEBLjWSZyIo9g=;
 b=LEgFiIU8JvaDXYHu7FOVpSWfNOM/SvKRQ3CMV+3C3Q97GKgjfdY9HTHrOZG/VEv+bH8YbNRPvrTFruBSFygaflBUASAopJavlkUzFRNS7yznd+LhGGw0cTPmY+vCC7F9XkGsovXAU4KMU3XPk+YQMiy5MntDFv9LArPdQszo8vSDzPRGTN6f9xzUz8FRSAuidFWRRYfCxNy8UsjBdvDWI7zYkCaaMAHxInV2n8VjVgh3c2tJO3w9gPt99X37Gkh+j7WaZiiWoje166Hc6rEGUNgNGgt6Y/o633zDU+eE6Jxr9ko/xyP/i4klRp/gF1hM0cQLyp3NCiEEfXeRnniFwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9934.eurprd04.prod.outlook.com (2603:10a6:102:380::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Mon, 26 May
 2025 07:09:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:09:21 +0000
Date: Mon, 26 May 2025 16:19:07 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH 10/13] board: venice: add FSA support
Message-ID: <20250526081907.GF19264@nxa18884-linux>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
 <20250523172018.4164647-10-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523172018.4164647-10-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: 447a9c61-675d-4b43-234e-08dd9c243d06
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BY0Ear2+7gSOFLlz+7po2IQUB0JN2d5pFsG8/CNCtC9/DfUVeEplvggD5GCp?=
 =?us-ascii?Q?wzHYwbJqjb/HEdYng0hxWXyBWXQz3p9TeCwX3/yv+mNh5GnuNS3oendcoXAB?=
 =?us-ascii?Q?/WMwCk1ggzKELQ1QGplBa4l7upgMTSX4zHMuzZp3f4LwbFMK3bpL4a970nCI?=
 =?us-ascii?Q?PAGHdCbUaUzZbAPpMUOzX5F8ngVByiZB7DUky8DN8oSqzaikJNA51nSVfM4Y?=
 =?us-ascii?Q?k1i/A7iVu6ZU9Odt1fp7nxpXw0Y8AlNvXX/3cZo3bZWdhaDe0VXuHrJ3SHvQ?=
 =?us-ascii?Q?TAqst6fHHbUgKPoBqHL1pljc0wimXFa/pN/R+2zEMdmEYIy/qp4Bkosf3EJO?=
 =?us-ascii?Q?toE69+IXvYhde7rRXTsDSlLqT0qJckQXLmzQhWi8CFrBxtFh97GH7pTBULSE?=
 =?us-ascii?Q?eFoxMZbWIEeEbOhSXYT9B1kHQDHL1pIT5mCWKiNyd2bHC+TPHWd5CqfZdOdm?=
 =?us-ascii?Q?2xfPZY9Z2iT8uDrDWNCFTpaJr4wwAVaRlo+i3TKKATzMn56FzghnZ13AC6rf?=
 =?us-ascii?Q?Yxe/BCZ/fBgpVf9I0xaRtHpW94IOBEte6ZCQNEQz+61GAftxGXhSW+cW6kZ+?=
 =?us-ascii?Q?AvSh9l1CX+lIX8S5ajjoPDQFiSCJ4P7uBygabOY5DRguy4MhJJoNS58jCUIt?=
 =?us-ascii?Q?X8LNb1JACC/DhhOybfbzwmuNxAcSVtAuM3wAYLL24T+hFzC6OWyl+YdWH3Mj?=
 =?us-ascii?Q?T6NnOOkMZTZUtHcV6ZIEKn/ewGWrpToUZ4/byYnf2FAxZ8mD7+elgya4rhf8?=
 =?us-ascii?Q?ln81xZ1A02eTS4OREu6uZakskBFodqfk1KE6fxGzRJpEE6vyyHHgk+h1gZ+8?=
 =?us-ascii?Q?LjMTkF8ogURXHg9Tap3gAEhf0OexMFNC19UqSXQP3ihux1dhyPMcDuAwMzEP?=
 =?us-ascii?Q?P+uFT37AYBq1Ez8Xd36+xkWZPUEbwkxcslKT54NTVME9mko4ooIddhG+fObN?=
 =?us-ascii?Q?Y9bPc5PYCHQkM/gGOjycFn2IkBjjnTL9lJusnkrw8VVanQARtoO1R14Y2SHQ?=
 =?us-ascii?Q?9siFgy6vNc8Is7V2AdEsE3m/CsdPMQOPTUKTClNvAR/Bx3i5XdY5e3nwzmaa?=
 =?us-ascii?Q?UaGciXdsd0PMEvtp/ojfajpwf+o2vLoEdX4iXhtdrd3+XwxQ7MSx3E/bRe4O?=
 =?us-ascii?Q?fbbCUL5rplokAJ782YkoYevHVyU2QCtwfatl7UfiMsac2cnPQkdh0liol7Vl?=
 =?us-ascii?Q?+MXfUtO658YT5PC4dytfjIcPSfIJs2zVuI3Yhni4FfLg7xz0JIlxlgW8/kkR?=
 =?us-ascii?Q?jldD5VUHxCSVr9e3ytLmabDDo5cvDJQfJC48HjxtMen1rnFW2CiU/lIymNLb?=
 =?us-ascii?Q?TvXXpYMoeUNEKwbs2UqJG/wnUqdF1slnQZAxWX1YEREuIKTdyrHu1UsFaoqB?=
 =?us-ascii?Q?7KDJ1DA8NlXhMsdwps6NdViaKJnNQhJ5M14Vn9TYhR6mHUGohcseWf7/qmaR?=
 =?us-ascii?Q?e9LDfpJ6k6DkuTaLum1NRG4eI0v3ugwoTzIwxNgu2S9gg/H1lUhoaQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6wmWX4LZCSh73PhMigDiX08ZpdaLk7SOHKfvmrXfb7UzZ724/p0QPd+2SrCU?=
 =?us-ascii?Q?OQuwqBVtthV9a9bZEL2zXukLVChN3A2Kwnvw5ef30h5de8J703AZOZw2j4Ah?=
 =?us-ascii?Q?yciDbuMrw9VniGJr23HDJQQ+OCxmyL1J2IWVKQB+R/D+JNrKhMWdiHv04Cy2?=
 =?us-ascii?Q?L6Us2Sd2xfyL/kX5whhHSCSAqC0Ea8wPx0ORA1srEOOC2ljvBHDzz+02OpQR?=
 =?us-ascii?Q?21z+PtHjjCue9dSWBOzIaJ6eGu8ksMzdfkazJ/phsKpYglX1GUumTC5q7fYU?=
 =?us-ascii?Q?qafES2KK/U/uh1BKIlkc6frKVHKb53uuyYw2Qobt+/U19z+4sBtXACQyJSDO?=
 =?us-ascii?Q?zLWSnyrrFerwcwBBLvhU7DGT3TWHm0j7Z8nOZtVYuTSioy0/kUs3jFVQysiW?=
 =?us-ascii?Q?rC4dCaapD8ctJu6tGNrynPHX4j4YshVkRFHptpuMiHMfMLqcSzvF+cms8kgH?=
 =?us-ascii?Q?1bji1VDIJOHg2Lu3IM+iheiDzJfQ2BF9VIaY5hapYSVHZG/OzlJuS5Bs1B6x?=
 =?us-ascii?Q?4gbBuQw1/cWXHSfIN4QSTUvM6/VSD8DMdiwMxPSUa1PJ8bbwks0tZ7XAg94m?=
 =?us-ascii?Q?8PzSW7Gqeo1LM8fQ7C86k/FsuQMfH7tIoATy+eF0uuVR5tTSSJT9PPNe9cG2?=
 =?us-ascii?Q?Rpsn+Pb8JC5wQZWIifrIJammYbaaV9AAWMaUBgHRQGIbnGkyuCGJvGymHaiD?=
 =?us-ascii?Q?6eChn/IEIE+/gXqN01kAh25ysMcKg/p0Cn2ZGUh6j06TrEDpUVGzgVGNLNDa?=
 =?us-ascii?Q?22pnYVO9rW2RRJjasiM6Igx3bS7ThyMYDTPtxDG4yWT4rGvoGVt77rpFWTtG?=
 =?us-ascii?Q?nIuEOJknXN4EcUjbHl18IR7Wd6nrU19jeuaMd7H/nHYIIUxNAmRS1Dcoy+oy?=
 =?us-ascii?Q?WAPapdCb9xOJqPaEUV/Dy2+MfJNE39ZePHltlPe1PfGPHba9sPaRFrqO4wrk?=
 =?us-ascii?Q?f/rPLMqmG9Dd7Whe9VRNdC41ngdCOpzQRjravgbmhz774DDvjyyyrvKvPs3i?=
 =?us-ascii?Q?U0VkBfKvPHUcoT3rZp290Nnl26HHbIbjBfmocaZGgsKnt2qNuXljHjxITbpC?=
 =?us-ascii?Q?V36aA4MN4ZpMwrPbnB3/aUR/h2cFjXFGuam4mUKg0q0tZezBF7kzpwaWnHP2?=
 =?us-ascii?Q?YgBGQXT6qAMCydsNWLjgPOjf4LDYc/jTqcepOM+4HHVtJSiOEyDZCG1/lOaX?=
 =?us-ascii?Q?ouFeRDO3H903+VlB3vAadgGjUMAIt2hBuoCmInH5a0q7gB0Hsw1vaLTqJ5nj?=
 =?us-ascii?Q?0Zye0yX4eG/DZrSNq4D+NI6+06OUculzOroChN9M8227A+wAtQvpyBU2RmPf?=
 =?us-ascii?Q?jjz86gol6u3/PUQym5beF5MJM38F/MT8z60qBsy0SgE47fwQT/LXGlgMK4aE?=
 =?us-ascii?Q?AtQJAI9Oox6Yu9Xpz7eOkhnpsESZvV2oFw3Ok5IT3ed+7LK+9y16RvGWLRLC?=
 =?us-ascii?Q?x7ferb/i4zUGiwX1XE8E3mgGKpcIDd/j2GttQpcFZhTUaV44wELOfmLTnI2s?=
 =?us-ascii?Q?tTMY/y/OYm7C9DgMLMfrEjvwAJocqExy4m+WzIjTXBT8iagS/zukGpfE9TVh?=
 =?us-ascii?Q?p46KGDmCLUreFSdgmudHqmmd/4xNmIdqMt8CEQiG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447a9c61-675d-4b43-234e-08dd9c243d06
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:09:21.5143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riEBdFEhHKSIt+9SZALwhDa+NmHONVws8+OTpqbpphy7CuaGtGRcFnXgLdlSEpaGV0ERtfgsooVozP/3CRfjvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9934
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

On Fri, May 23, 2025 at 10:20:15AM -0700, Tim Harvey wrote:
>The Gateworks Flexible Socket Adapters adapt common
>busses such as SDIO/UART/USB/PCI to various connectors
>such as M.2 B-Key, M.2 E-Key, M.2 M-Key, and MiniPCIe.
>
>Each FSA has an EEPROM onboard describing its details as well as an
>optional port-expander for configurable GPIO's.
>
>Add support for identifying the FSA's and configuring their
>details such as user description and GPIO's:
> - enable pca953x, pca954x and eeprom support for communicating
>   with the I2C eeprom and gpio port expander on the FSA
> - add FSA detection support
> - add FSA gpio configuration support
>
>Each FSA is identified in the device-tree by an alias to it's I2C
>bus where an eeprom@54 node must exist as well as an gpio@20 node
>for an io-expander. These nodes must be enabled so that
>they can be probed to determine if they are actually present in
>the system. If not present or not enabled the gpio expander can
>not be used. This also requires livetree as the gpio expander
>node if not present must be disabled.
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
