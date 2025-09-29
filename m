Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3BCCAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 06:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B41583192;
	Mon, 29 Sep 2025 08:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="q2cyt/q6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6145B80819; Mon, 29 Sep 2025 03:24:53 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C082800B1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 03:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FrsR9LA+80xtda3hnfiHupOE2SoJbULSy0FcTC1f5CB0i47snfva6ULsbyYkoFh/3qK2mdStNwoFqL+tsM688IXxq5FWdiB47xuV8rrvBaksmSSqJlgD6UnDjrmT+NVwo7vaJqHi4uGETvPQ0wMXi7MX51SgdhfcM9sIk1fLq9NrEaifL/mmBwabmsfgrHWJHBtA9bb1qN1cclzaMC6XKCHCL1U+kKrIYsEFf9zkrdGzMvoHQrCrAXjvDuRq+5MVYnOA04W8DefM/R2EJ+1J1TV7GLWqOyAu6flqtFa1pmmLgGI67gmoPlBsPQPelfdSOP0EyTrAWOJoyx19ldCReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DG+N9w4IPIrL80AcoWZIHSeemRdiZEc8mHWsXqrR2Dg=;
 b=q8Ko9t+KLm5in6VL/gv9GXXmo0BW+pwnJaLnvIQlxm97n5P7KjTYs4c6rjY18aS5kiWj7DS+5AiVEDrMleYzPfHJ6ooXAGmbaNiMsiMZCGVm8t6SfOVPUi/Ncm5cB9n8pyDGAYPrLDhU5H7bT4a7LNOyq0ITW+r4PJ5pcw60Q4nrcB5ArnmIsJG5fjhaAoNiDwFrC2SGhy3oifzM1hXBuewEhoHBsHGBzbo/ncXCd95aPCdPyfUT23QPJQI5tJfzlocUbgedZfnghPQEy9WjOz2ZYRsE1uGLRDjTe8C26RBDle1WL4rw55IvZjgUU2TtXspBfYEmzE+5QeSmk1jHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG+N9w4IPIrL80AcoWZIHSeemRdiZEc8mHWsXqrR2Dg=;
 b=q2cyt/q6j0jP6E1qktNI6N0G5saNtRsgzcjoG4HG0MXbQN28OoSyT59ZESHaTUFuyJyTo9HyEJ8LyYsTb9qKQDnptZSemdO98CbTkd5uTGXg5+nsAF1UeN2a9AekvEfXdVXyjluaGNIT3Ag962K/gGX1HEqBU91nnr4lqcM4QJU6mbZ10oKS4dSpehZzy7Cdjx+D8U2uO6GZj2QO6ATDDUh6PPMYB/VL95wTKmfTiZbP8xkz0rLrMSGQTld6CG2nHLtA+GzNK8ZYpezUd0zW3z9rVILZ3xAny1TpN5lq7eWhCs+XFZ5BpSSg/PSYhyvjSkMoeRJ7PCZaPyoRcCYSxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6919.eurprd04.prod.outlook.com (2603:10a6:20b:10e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 01:24:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 01:24:48 +0000
Date: Mon, 29 Sep 2025 10:36:37 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <chris.paterson2@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] arm64: Add MIDR entry for Cortex-A720
Message-ID: <20250929023637.GA4184@nxa18884-linux.ap.freescale.net>
References: <20250918164936.25592-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918164936.25592-1-marek.vasut+renesas@mailbox.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG3P274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::36)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: b844803b-f72c-4678-b48e-08ddfef6fa29
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HzEx023mQCKx8Cvgex9W2gdrZyXuCKUyvWH7Lk5HsXwY3FCvNsc+ofTiPy77?=
 =?us-ascii?Q?dbDU3ZiX8+CtnjewN/XTUIDXa214PQQC3d+B1zMwr0YmguxsCjiQcRQH2UKP?=
 =?us-ascii?Q?oRNCksI9h8Ju/pSu8nO7qw04vtikhzA7L6tOekN+WSDqwF7QE7AH+dxdpxkV?=
 =?us-ascii?Q?dBErv3ZUDCDznsh4+MORLz+izzTtdPixpR9zPbWLxNQhQxg70J/jupjN921D?=
 =?us-ascii?Q?Er3oy5zjNhZq3iY8de0ttVsw36FDfErodTYpDq+d+8/fKOK3e9Ki8R2RAzUz?=
 =?us-ascii?Q?O4i5LSqQSfT2VKfRx6ub4VxKJk9u4mUFK34Es7P4Pve9ZSnwJ7/cunkVYl3J?=
 =?us-ascii?Q?ZuIyeLZxKtDzfhlWIBnhjGLagGz0Q10i3B2a7RzODPRHscRFBVcxl1A7Rq0P?=
 =?us-ascii?Q?gxFbpHDK/tynR69JggN8WMxwqILZuBs5OSkk+q2U6b0Cfs8K7R35XBFQ4Wz2?=
 =?us-ascii?Q?jbkyt0EyyV3pJhk4pr1/utV7MuTSJHmWRz9Hgy5TLDVbmRwEFhgFsgkwBDHD?=
 =?us-ascii?Q?R8CuAYI07oI2zqj7TGLYDsTOhVNjklF3LzmxjA6tPTwx0IUXmP9oJGNTmREq?=
 =?us-ascii?Q?7QLMU2yz+bzNqXEVUVGuRawqJpcUSOgFWQ25xVIipdoi5jhIjvPIbSJU/tzH?=
 =?us-ascii?Q?7pnbO6mpHw3lm3kVP4vFrsS2/TFwRuaJDDijPwl7Ijh9uQebXptdY9Cuty27?=
 =?us-ascii?Q?JhVPYN9tYTCX5yjkvdJrUNiM86nQNgmrfWuvVcnSL/yF73qLLIb4jWjX51Al?=
 =?us-ascii?Q?tmWJSJvxCEETC+OCtLO6I+oeCentwLPTsp3WjgPT2ZxXMPmQuMqrwmQxXoHf?=
 =?us-ascii?Q?86IAeDxKPXRI+YWe+jiBW1Fk1A07GnxaA9Bwc1KH8jB5Rbgz7qAnF8BkU2zu?=
 =?us-ascii?Q?jRZsd7fQNtvb2h/GoBTVTXQnuTNCIvQt2Pf3PxvIXBhp3ZNwvFLx3OdtJiD6?=
 =?us-ascii?Q?EHAxXRUAl8ThOTHn+Akrc3BmGxtaTpXHqWTPx8AyXXM6riTJn0+6fST9P7fQ?=
 =?us-ascii?Q?fEhVH5sRoToq/2PVn+7PPugbibYsTSf710eZ7R2AzjIbT52SgkYx6U4nJt3S?=
 =?us-ascii?Q?/aWW29zRdn+H1BjSsqahuGnICXOMqndIF4cDqxueLxQH+5g2yAuK7jY6s7qw?=
 =?us-ascii?Q?E+3bvE1H94MLBXbbjtVzct7Mj9lg3ilc0HigG/En1EsOK/9IkgBFOuuCoOzt?=
 =?us-ascii?Q?PD9r/TEjjnQV7JQ7389kX0ymUGjkYyZjHqdVPH/dbqK/48vqRAhv8TjLE5fz?=
 =?us-ascii?Q?pbcv5YTjlFGVbUyGAyFECOCpfejOkTjuvPInkCbp53bj+kxmoKQ59JejC5j5?=
 =?us-ascii?Q?PHxU4SJrT+a3Vjqlmzzf317g2ANvxaVthjrLhuVYMaC606YHjq0muLdxGU0p?=
 =?us-ascii?Q?xMPGVtBr52TnUkOVW2u090QvEvILZ0+Drp8WVkGo2Nw4+rN+8XYNRNbXE3xp?=
 =?us-ascii?Q?jm2siUwGYcQ3StVbQ8jl64SLkokyYg/3MadZR40eFENUvNGDX/mv8SlCTryj?=
 =?us-ascii?Q?WJR8DlQtKzO7gPOMZkUP/4BrJi355Fy1g2Kw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FIsMq2n7M3cIfmgpXLckKHmG0EvRkSdR7rioYkK0HwoKrIpYMUGuFrEaa/Sb?=
 =?us-ascii?Q?lWHPem3dT76j9sIyqtT/haasM+1tHDNZbbmHI+8NREM6tdsGDX6HdB/GGPKk?=
 =?us-ascii?Q?FCfmDgXprAypgGOo7AiHXQKD+71vMn3VlZnAoi6uzGeAxbzhVLhSirqb8H3a?=
 =?us-ascii?Q?j7YIzcKvRGsdDoEuldx/4d6Xn9OXaGY4SQM6jmTvT7F9Ptx7RfeTWx8Zeg/N?=
 =?us-ascii?Q?AT+7ceybovH2xW8cN0Ty9kFKutepKu2fCIZs78JZYOUL7p5ov9EmIsQdn/6k?=
 =?us-ascii?Q?29JsZwI6pzvit8oeBlUNHDxKDPlgQOY3AOr/mafRzzeu0NGP/uUcMAyxJKiF?=
 =?us-ascii?Q?XdejYRjc5py0zb8VteAam4ZYP4CqXXdwfXUEtWkwER1We90wY5RH+PthdGmE?=
 =?us-ascii?Q?zCsF9Z6fUu7RSQnL/6EZ/0weh2FLWg1RBrTlauDDivFDMjUoxvqy4lHTTjjE?=
 =?us-ascii?Q?gA3Fdof9yO6XpGmphz2IJ//WsjerKdYic4kxZg9TPq3WnXnCo1KGVFvyhUp8?=
 =?us-ascii?Q?CKpACY/tJfTMcO1TWNdc2JZcodseMfyKC0NiSDSstczyM6fGZkdRm+P03kr9?=
 =?us-ascii?Q?35850oqlDKzoSFbyBhD6AWHp/lf9tY3ur5veMZHBgrgEfhMJR49TqDIpJbit?=
 =?us-ascii?Q?QAIeI2ARoubdmRfVFFkdl1Hu+46hc2KndYoJlOKmbyLy13RQrzpHUGmpHhug?=
 =?us-ascii?Q?/RvLSF5T+IgE/w2neGAWXpkeOUrnIv+GELFziKW8y90+rr1DTotbJG2kolvb?=
 =?us-ascii?Q?ZKwzZjW2PsAjewNm8VvXSqcPsJhvqpWscAQ2dbO0dNTXDsFBrW7XXLZAqIIE?=
 =?us-ascii?Q?qqoqmSJih1pxD65+w0Io0hyGPlANhP3wizO3JKgyEj2tMJT29rYinpUTtmcF?=
 =?us-ascii?Q?mlFl4nGyLHksemnzIWDorYeKk3w2nJURumGSIYF0HlfJfBP+0TbGsQvQoDtp?=
 =?us-ascii?Q?xHdRuK2JUttADWSUadTyYWlNgo9lR1C/XnngeE3gQCL6nxEQOCpyG2o1J/fI?=
 =?us-ascii?Q?WmDo2ERQmXR1dnN+jIAAGxNvYa/wqlaZh2FvVBa4OVWeTc0cZGaVLcYlrclp?=
 =?us-ascii?Q?0ZqMvLGgVvv39DL1uW4vd+1ylG7jW/W8aG5oqOxf/NgHxCMPb1RPS8UAlHKm?=
 =?us-ascii?Q?eThkZnMom76ThlKZFrAQp9AJLRzpuC7FxjOMC8vZfQ/AhoudwsjnwsbcKypn?=
 =?us-ascii?Q?FPRvN0zhqmGPpvV011h1rz9a0InAsesPCHc2s9y3cXG3Lnonfr1czzIxDX/z?=
 =?us-ascii?Q?XtD6wx7dfdHJjZsvJv1vzyRGC8RuZRBAYheEgATdDCstGW8gBhAiF8xz1H8+?=
 =?us-ascii?Q?PnV3qahaTBPQT/zJTZEfDF7Une6zFFPZvGFXREkBDjrjhd5LGheA9E6RnBC5?=
 =?us-ascii?Q?lmFdEKJogByDqMvw9kxbtWCw6K9hz0R5UMpOMUPPq6MhrWYnIXFRNoNJ9O6w?=
 =?us-ascii?Q?SpA3j717AH/UT9EwapC5V1HkZKJTRgci6Ys5elVTiVjZuqq/rvBpbx1U2uf+?=
 =?us-ascii?Q?sDGVbMHTGkqgREW/VKfZY1jpcNgedbkacKe5DXUyrjj9T2hJYL3vfdyiYZRU?=
 =?us-ascii?Q?DxUOJm5FE8HOOjDzzyCz+XiMDruDY/TKmel7bG08?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b844803b-f72c-4678-b48e-08ddfef6fa29
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 01:24:48.1049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxZ7f0xu3fCW5Fxb/JXve9TW0RAmh2aGJQOPIiK5uS0miWcAoOU6+8WTZVtBI/EdZz5L8q4kzHcayZqK7OvEEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6919
X-Mailman-Approved-At: Mon, 29 Sep 2025 08:49:07 +0200
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

On Thu, Sep 18, 2025 at 06:49:19PM +0200, Marek Vasut wrote:
>Add MIDR entry for Cortex-A720 core.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>


Reviewed-by: Peng Fan <peng.fan@nxp.com>
