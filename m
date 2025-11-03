Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599ABCCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 13:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC538838FA;
	Mon,  3 Nov 2025 14:21:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hv+gsIiO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCFF383700; Mon,  3 Nov 2025 07:15:35 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC5648331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 07:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CK0GT7GI39jHLlJ+Csm1YaN/DIbP0drmxttfKXRFt6ds0fM9ldAnZHWLg8KQ291vPprClRh8oKqoxkCFjZrkObWNm4zecYz5pGYxFigeQG9ljZ1QCcsNKrkf+Gb46ELgZQnd6GPTieyWQC5VC8oJGYEKLQ9cKIxMx1PGG8LNzIhLDiFbkQyYPQbu7XzBd7/A2jSGHAHyXwC3T1EqPRd6WG3ecUdhFdBV2AJhSOLrm8yyRyVzJqZWLhB1MrusThXYe5kyXfjoDdAmZ9CJzWZ25F0q0D5K6PbcdpkWYqMd8vod758d6Y6qL+SekXgSjYF8MRUCuDAda0uTImWO9Gcl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adDQiQdrFnWLfJEKworcNHpvGZ1DkS1/uSyIkjZ+FWM=;
 b=f3wiEu2F/vBd8KKiMmb1+b7mnnb5DOlaXDTIGv8UewKVrfHvpHqwb9ULO42peC2uetmH4cKHlEUglyA0DwHYvpCIiRr6MPTAIrHUSHQNui+wt0FvrQn+yraelDNky+ToKjQptOVSHnUaj4t09MWpuYvRt8WdVTn4gWaXMDtDcBqlfZAl3ZXoZMx0mmv8XfailiDhc/1bVU946sUI/epG75HSvdMDlEXU6xyfWU2DLNQ2DmVGv2T6KB0MrZnkZAFuOlQ0yWXsRdSoc5W91Q/SHZHqnXHoHKQZo9yqOc85g4GvT9T2AP9E3LJyvpbdrpwFoWaKy5nwf2JVmG1sxWCc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adDQiQdrFnWLfJEKworcNHpvGZ1DkS1/uSyIkjZ+FWM=;
 b=hv+gsIiOgEFMyqBJfymXajv17YdfuRoQsJ+ZSm+WHltSNFjDT3LRPAafTt2IIk1ilFPqwpwFg9/HZ4Xbmq0g4/6uT8l5U/5UNdTx9mrypCXSCcHii4kn+2VnMyPIphW1hmODqHIrWqz+VunX+nmxLqopeDd+XJUMHKBwNWWB59X0GeV735xNLN4x4ndJfSk8BrQRxlQWSwEZLCM+1VnjmVsEYgZWB/TTt/1bfJSHNo9E7Jg6PlcsLS9+HIbV2c7eoDMEyPJZjuH7U1XKtESlYjXmH1mofk367lJN5etjbyWyoTIQDzyx96qGkk3PjQ+0JpiBJlHU0e9tYYUS9yarJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9353.eurprd04.prod.outlook.com (2603:10a6:10:36d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 06:15:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 06:15:17 +0000
Date: Mon, 3 Nov 2025 15:27:46 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Jindong Yue <jindong.yue@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH] imx9: scmi: Drop parenthesis around enable
Message-ID: <20251103072746.GA632@nxa18884-linux.ap.freescale.net>
References: <20251102173459.80904-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102173459.80904-1-marek.vasut+renesas@mailbox.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f87f6d-c057-44bc-7bbd-08de1aa05bdd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2xn/h0kfW8HHgxcmTdcedm0zPbnrDwXifs/CyZAqxBd6BCXOcVmwc1KkSPDC?=
 =?us-ascii?Q?M7CzjzkBDLhnCHy0ItvajstSWtjeOa7U0thCYdibf960+qy/tDyXbIjNLZlc?=
 =?us-ascii?Q?RpJHrQ4tWtHo3jtuPSOh2lGIKBtfbMdZSipf976xH3p4v1/cuEImipaenQj9?=
 =?us-ascii?Q?J9tblXQRaB4TqybajvMXphLZIvl9VbZisYGVMuiMSOcGA84V/oVopVW2Vdwm?=
 =?us-ascii?Q?p+FlafIJ3Uyj/Ocx7OHxBG8yYtKEYKRgZgQt9t66SVR40g+lsadT+8sDZqQ5?=
 =?us-ascii?Q?NhkhscczbnNV8dHWLOATPwumoe/J3ABsbcBHHEfDUUJy3dGLD2YQ/3ERysOE?=
 =?us-ascii?Q?dCyZGqLbyO1nYovs5kyPzoNt9MSWMtEfkjw+9zcg8LYH36FXpTGDaFfYIupd?=
 =?us-ascii?Q?W+CM+G+vfo5eWrxt0ro2v+QiAxSjyHE8YBhtLjuJw52fPIThZuDm+Eljfoxi?=
 =?us-ascii?Q?MCV2Dq2nqxabdbgL0ryVhGnoEDIoPd49b5QsHyr/Tx0QgAwmMqYF5u966SFR?=
 =?us-ascii?Q?yGtR+ekTKA8cbYyi2yVfd72sk4esWSINUpoSyzAHVxTpjVYyisJtvGQcY/pQ?=
 =?us-ascii?Q?z5ufPGlYb4F+BbNv05VLJKiBH1KY+VTqjpvwQsU8atJpzti5e78Vna9CCCia?=
 =?us-ascii?Q?RGIy939RAT3ay4cuNk5ICs1KcvSPYvGOz9VO4NdfM3FP2+5sNWWNjPaXLx6G?=
 =?us-ascii?Q?lHzsB7OoT08jLRqOnCZaWE+Lo0hKpAukNTzE365X4LIFyGG80yAkEtXrYwRM?=
 =?us-ascii?Q?68ZPU1K6U9gdk016yWy5cT5x6MZU4oeWquR2tlLNIm13LSYwFEQYz2kju9tk?=
 =?us-ascii?Q?TiU0/nNDymoXqLiA/3QlFAYPVcMYuAuvA56GmOEnhdxr4fo7ASWsRpUwEG7Y?=
 =?us-ascii?Q?Fzg/2fH8cORmdrTyHDI7iRyRudfVldDNeWdHHXiQ8Zj/1vjssdaFPKFzQf6p?=
 =?us-ascii?Q?rnaKkkA/YU+xBQlM8w+k/7ZvaZJDNLxEi6RaoZvvneuiYmLdI/0f7lx4gmGz?=
 =?us-ascii?Q?EMGggaBb7ReOJAB7TmcI3nqkGh8Rm8JoNZ9y71W7WXpt59/g9yQRYvs0ENYk?=
 =?us-ascii?Q?WXJ8F+LSb5jhvoPZLFz9MYQlKEBWuJ2rBYEoihm0ofrVOSrM5hiQJouddKOK?=
 =?us-ascii?Q?LVbkO6TJdAE+1Od1f8FhnSQD6wbIwruzAvWZYzEnKtIXWTISOajuQz3Rav+y?=
 =?us-ascii?Q?v8B6jWWxdtCh17nzz8WnQSkK0Ubk6Urntehb9uleEHVM86chGi0w7+7LU/vu?=
 =?us-ascii?Q?w6Tv5dnSCCfZQqpZZ7cfIFkb3+/oYAeEdc/99brfqFk9kHrTxs228WmOm1bT?=
 =?us-ascii?Q?RB//ZjdKCZ117MS+0MyM/OyLzItuX7bdcN+f0YNdeqC58gTDv7ck3z+X6y1a?=
 =?us-ascii?Q?I+zS0/SkX57cTCEpW91AIc+exKRh5alM3xndfeKAKEsknQNHjjZA8TgPUyfx?=
 =?us-ascii?Q?nXCQwmHfzRzuEx95cxxUxUlf7YMgsU/IFcpAz+XbnDZazNfu0bapFshr5aLk?=
 =?us-ascii?Q?FRWGNyJpX24iGQ8ose8kQ3mT1ZhqRZFmak3p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jKrMZnXSw9RJrktH2qTjhOe2lngQralN9g2v4odnUMNKLuakCx6AyCfc3wvy?=
 =?us-ascii?Q?FbQnLNdrPTCgCbyZ+U9ALB7WAIfbLd8lMK4GRy3FmG5umIdPjFGihyDYtIIx?=
 =?us-ascii?Q?Ucr3Atr8rXd+LcWGVU6/TyIus2nrrqn3DRb/I/AHU03D/iuAaz2et6yHxY77?=
 =?us-ascii?Q?EoXFhZwjnCCzyPXqdUNSgCSl2Iaio154BgcR+hN3L1NPboB23hfD6qyjRDiu?=
 =?us-ascii?Q?wGOMYfLOnUsOESQMZMnA24yZ/+MYZG604Tww4Q3K3EpR1BCsK/LTjJPgUXe4?=
 =?us-ascii?Q?azsEgI+h3ElxdKu+UpWVqGPR2YPldIuEDRHvhYLxBK4elOm4H1a9h5hJbf7+?=
 =?us-ascii?Q?osmVviEAHC4YrpyYo+GxpfZm54hw5Lgz66W+hQg6PNAEFKDM3GGduejwcr2O?=
 =?us-ascii?Q?Gj97YTs3pqgYfKWZJaAHqMxXAdCDooAqie4a80+jKXmjlAy8vVxMleKW7bTQ?=
 =?us-ascii?Q?TqdNfPrSNBRQ3CrSUQdJ9pDO/SyYwYsqP0jQsNR4IRmFPMGRP5mcbQi1T0rn?=
 =?us-ascii?Q?ynlYR3C9K3ewHMQmEZSdvJKH8NLWms7/dv/iCTChE4ePP4GZxzPk5MycXikF?=
 =?us-ascii?Q?tYeDf6Xdk39hHDdO2bj3my+mtCdFeljz8B0Oz/lDVsHBoJhLNF92oGMT4y9Q?=
 =?us-ascii?Q?w2aWwbxRBC7OlAlnS32+VtFa9Eh7FtGENgmUtbwbq9Oxah8A3J9cQHUZt3QC?=
 =?us-ascii?Q?SooSMnW6JxYhqtvP6MZ7LXdHkgW25u/y5dFUWPsWJmV9/bcL38zX4xUdHjA0?=
 =?us-ascii?Q?dAq9za4O0yZVdtKXp8BbPS1dXu4MZSkfVsY0MiIkZnfTynZ+jPd9kIcIBE2x?=
 =?us-ascii?Q?K51I95z0b9YIYiKNfUekhQmWU3RJHVdNLuOCJlUM2VGEmYbDET1Fo6E0sDs9?=
 =?us-ascii?Q?oQ2SBqh3Fe3hkka429D/MHenixTxntKcYr5ZO6YbPKeziagMH8YyGDDIr7A6?=
 =?us-ascii?Q?A11pghCVvMdszDFP76Ln5gve7xEN1eyysKExU2Vks0bdmg68iEYQO/QpRHVa?=
 =?us-ascii?Q?+1LgzpRL+8KUeMfbuzWHVpJ4c6OppIt+KKnyMEa1jqpq6CP/XBmtYBcEZBG9?=
 =?us-ascii?Q?H7Y2rbsKYhigk1ZvmGZ4czGJbCJgq0oIrNAGpmbEDVdHP1z4aG3ZxCSzQsB4?=
 =?us-ascii?Q?lvUFMIBI4byuf7wzCt+1n6YBVu8Ot1+2cYKdBdIFA7cE4YaPwC759n6RzKkE?=
 =?us-ascii?Q?NAjPOaLCmbvDKs4sgJ4baxSUK78d/j4RvXGdRUrYiKzNDrpvDjsWS2hOHY2Y?=
 =?us-ascii?Q?bw6hfVGZE0vi3A0Be0jkMkRjwREuPiI7y8BPZdGoAa9wm8zlPlEBCDyjHfqj?=
 =?us-ascii?Q?IH8qdZWmWSKODwtblBSDgycDQkuxBD7gI23PXw5KKliX0Kf5KkKqPOUZCLby?=
 =?us-ascii?Q?yDUz0zn6zZf6xoBiu0FSHZQiZ7ig1qvab+7EV02QlbC3UHy6MhyJySeXH1LS?=
 =?us-ascii?Q?7DLxp6CAqQPRC2/Ab3AnaDj3hglXvYt1HgEXOtqRSYgulaQUEfAX8g9uk3Nr?=
 =?us-ascii?Q?ZjkZW0clSm1Bc0FTVh+xFJPUOs0aA8SjiNOwiIGmmcA68mhgVPhjJsPoyjhj?=
 =?us-ascii?Q?+CVaxFo+SqYp3uSLXoKgW+0RivxDjrUzrPkEOUo7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f87f6d-c057-44bc-7bbd-08de1aa05bdd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 06:15:17.4132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUrGq3tU70fqaUu7ifKBegsJNWhev6F/KHwjKGNjIhRbAEjUP0PZhP9SYR5Eho2cP6ETNIqTtJ0/K5CgHSZKBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9353
X-Mailman-Approved-At: Mon, 03 Nov 2025 14:21:42 +0100
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

On Sun, Nov 02, 2025 at 06:34:37PM +0100, Marek Vasut wrote:
>The 'enable' is a single variable, there is no need to have
>parenthesis around it, drop them and change the implementation
>to simple !!enable.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
