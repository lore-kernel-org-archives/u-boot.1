Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075D0C88E42
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 02:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 628A183DFA;
	Mon, 26 Jan 2026 03:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tyAu4AnQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B34383E57; Mon, 26 Jan 2026 03:03:02 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1015483CF5
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 03:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+jk3hOcXeQE5JHgoBx/aS4Shj4yx+o4BPQD28z53yi1jEdOO9YBg0/XZ+NIT1irhEVLD5mDOl7EL2npO0BtigIebFR7qbCQN8McGZ7Il1LvpJgVyhzwVpTkZ6F3AviA2y3dQG533qhjrppyg4fb8Db+gxyuzLZiUiF2rbSH7Q5m3m+3CPCjbKqY1JagvuNRv/oLd08lV2VGeJvkA8WdeoUrNM1aLPUuz0zmU+UNl/ixXIZP6wuFmwdp/5tWa7EfrecoMB1moq4ABM2EzHoGmj4b7B75J6Wa6GU4cY6yn66Pia1eQXsav7uDWP4+BC9xMAn+yIrLXs2qO+jFoypMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJaW6ZiHgQGsrvLjbYH7Q6kKOgtWIZl8IHm/+RQoEmg=;
 b=G0imdjm7ZQMfyTV9i2wtn72ldY8++iOZTr5K8VjnyckLvnUZmW8t431RMZ2t2DDQNgr+H84pFUcE1TK+Ezry5bWJT8RlbdOI8PQBzBY2nYvHa/F7sDThc5nLC34hO7U7MbQBUWZX2YIJUHFxRZ7uu/4XEBA1K6EvegK/wGOfR9OxV4MGXbOtpwwVOviscUYaCCLmuPHKfTUh/EUgmXQ4k9K7x9NApJjXu5r8c3I8rp3uHaOpeTcKTmpE+5kHOl24QHnvILknS1e6AuC7XlIfQ1nEz6DMQQ29pFzjWWjM509H9SlRlg6yICvpKMqVgsqHkiXoudJ6lM0KDS/tkHukgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJaW6ZiHgQGsrvLjbYH7Q6kKOgtWIZl8IHm/+RQoEmg=;
 b=tyAu4AnQF0DdHWRBr02A4ygTECdeS/OO39CYOGqh7Pde4Rq38aYBeBer6PZnDaWSb6YYFpSPmAmDJbejo2iOwV3LagRmGve8JenG579I9b9O3zJtoqcxEPpA+M99KKtYSHx29NgPWLeWOtq00Qj8RVg5OPOyEB9s38HFsSs/mfgKqyQbhFFMgJFjc5D+k9r+3sw8GLzeEeO5pQGKnv0ERXskVaKOy1/1UnhZ6yPti7MEK2iLiiACWRPYTc9+f1GTBxBFb2bEvR6eXzdZjUlMBpPYKH/OiqbmceQiul/LjlU5kpwIDwgL6TNzKV331pRFn4izXCvepZ3O2+Pgpnx6pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by FRWPR04MB11246.eurprd04.prod.outlook.com (2603:10a6:d10:171::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 02:02:58 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 02:02:58 +0000
Date: Mon, 26 Jan 2026 10:02:55 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 alice.guo@oss.nxp.com, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH RESEND] board: nxp: Rename board directory from
 board/freescale to board/nxp
Message-ID: <aXbLT9xwbP4bipYR@shlinux89>
References: <20260123-nxp-v1-1-91feb4312639@nxp.com>
 <aab556e9-9789-41f0-a4c8-01d48c191940@mailbox.org>
 <20260123143854.GJ3416603@bill-the-cat>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123143854.GJ3416603@bill-the-cat>
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|FRWPR04MB11246:EE_
X-MS-Office365-Filtering-Correlation-Id: 89538ab5-455f-4b9f-8d9b-08de5c7f06e8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pG20rwAnPYpBKDC36XJ377FkOQJD7jrYiBRwt6u8zrAgbp16gGigDFohOHV1?=
 =?us-ascii?Q?3Uie8WV5I77oPK5dp4gG3SfeeHyZ2E2pmGHU1cKrp5WzDwwYhgQrLtccisaV?=
 =?us-ascii?Q?DjyelM7cr/k/hzed0DXguLGyM6XKumM06VtEtLXeJew3RhIrZReQ87wv3SdM?=
 =?us-ascii?Q?K3vukHX0XwfzZUBpZsbaAPNTHK0dDUliFjchg7hpAaCyJ0VrSkVxmZRB6jkD?=
 =?us-ascii?Q?KpUn89/NERvwEoddTKkzSM4mJKAC0x24N7SbXJ9+YF9nUf2tXPrBgUkvqHsX?=
 =?us-ascii?Q?OCV/gLMglIGTeoCwUUm7ZmrYpzOZO1+ilBvB/nmlkUigDU6MRONjHffMvDs5?=
 =?us-ascii?Q?RLeMxeu/6iRKB3pj1PJjcmrugX1oaJAVyGfVC6O2rWm+5PBZf1ar7iQNLisi?=
 =?us-ascii?Q?QzAA2RW2pJ3eXEULvsQB8L7p0K7VyafetpBrx4Z2MhTk2b9QbTfK3U5FHMO1?=
 =?us-ascii?Q?G96/h5c0WcB7VZeKZ1YsoR0U3zVlUQ8OnlgFQizuPZsiGyUUzAaUMVQ05K90?=
 =?us-ascii?Q?K/K+8QBUIBSJSGL1WYYYRvL0MNOsE3aBeeNfigI7EocWajT0+4Yq0n0+Ckoi?=
 =?us-ascii?Q?jhSQsgClkQa1my/fcWdeJZ0mJ67nBQCSd5rjodxcFKx6yX2SuoUDLm4BqL+1?=
 =?us-ascii?Q?lpQY21qiXJDyyu/uw+VOWiWfSNaMNwcTEFTjfRwr+21AE4AQXux2I/B67GAC?=
 =?us-ascii?Q?yAZWpWaazLWPkA4PGsaTkvmzdz6ZmNK0GAmJD9+YoBREy1ZX7QPc9yK3Ut24?=
 =?us-ascii?Q?Gy12sFGGmac3pHYXbxPaUvuNT3sa+NT6RZskoZsVcBuYfp1s1dnA8IzK7/oQ?=
 =?us-ascii?Q?mz80L36XHJ2/zjixTSt/t9zzsccGDnLa+ScT1pLl2sLSkP4mYQwPJwwhmjJG?=
 =?us-ascii?Q?p4H7rmSLdGuFvpkG+Fdxgz9N9BMk6insSnfxnWW9cskeuL2Skm3c8x8i3e9O?=
 =?us-ascii?Q?oKaaEpbNUpUQJt6Si6IWwIEHbeCsGzJgtzEbpXGxfAAiUOo4yMywLTPWHqDy?=
 =?us-ascii?Q?UwSNliknPbcbQjD3I5n299KIAoCU4NDEsI88QMylTbxRtCuxfI7jKELA0mTm?=
 =?us-ascii?Q?gQTPsKkTMAFgiXzgURvuGLOIj5YYLpVT11J+54D8UaHb5wbHjLDDZb2ZeEtB?=
 =?us-ascii?Q?RZ5zK3IKOn/Xvm31DdHwwZUohncpqWEnW/D0Kk6sO49ZXHs1wHMooPfACxkF?=
 =?us-ascii?Q?xJhhCL2NnzEECV0Kiy9UjZoebEBgkDZ4JtahlDt9lbfhWgQ/tGgieUxnSO1c?=
 =?us-ascii?Q?i44bBJQTgwCpXX2eLwjuksMjnf/pE4YYiTHopcc4mFZzxQU97z7VdAsyeYm2?=
 =?us-ascii?Q?zIGWyjVZsHWmoDMe1e9qeqp9RrUTLXADHMJNu/LyoFfQsTW4faDBARABmkbs?=
 =?us-ascii?Q?i9+szKOgmALOxZxLxYA3JPptvYmFKjfraj7/xpCpHmiNMLf5tJLFXEz97xvi?=
 =?us-ascii?Q?V3da3JZ8svLlhzprmCSyz2j604tbca25NK8Jutd+RZu0rfuObr5rU3I9XbEZ?=
 =?us-ascii?Q?rrZsIfwHEEeawsclzoNanLYkyf//rb5mFiWn2FSwKRTelwJZXpmSzqJ3nTym?=
 =?us-ascii?Q?Dk6k/1MuYc9My1fqPsncthqhfgkPPQJsNBfZombMAueKzi4evAdGb7j3bSnE?=
 =?us-ascii?Q?0LTHIQxeaHGEAdKC7fOdmL4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v8oPZJPuMSqbTHKx1bScrsibWWeDbHqebqSo53+/Um+fApF3EVi3Oz0HPcpK?=
 =?us-ascii?Q?8I1k++q/WmKxa9LU5QceASoQUU4yumQpanEZ1w89yNy6E7ZZzaKV1ByCIOQV?=
 =?us-ascii?Q?KIlZ8tJ/oOo9bHf5FV5JkAwiNAebixUDYLBUl9ucAg3yjQ+O9xLNXAXnnfJ0?=
 =?us-ascii?Q?OZRZvyiGjj50TvanPNTiEl6hZaxCpV9+NWkIeZTqctBZKQcfLypK8G3jaiZb?=
 =?us-ascii?Q?L/6q5+EJ3ErnOdbQv3pi3RjKmTeA1pS/CKcvhk/GT3aJQuMx0Kk3mZGB47Gt?=
 =?us-ascii?Q?ieDeW5+0TLH72l73f6+uYyH5mybsNkc7C1QIiyZxgfObPLn/YTWbCF6SVxA5?=
 =?us-ascii?Q?PyQA+1vY2UA0ZDHPhlTr35ox1EIDFJtgUkXjNB1ipSPQ5OvtKq/tH8hgLPum?=
 =?us-ascii?Q?18LZTo4Bg45c9vywMG8hmw6cQF4dBQ9EMPe197e8i1/8wHXCd1yWKJ6P0vYS?=
 =?us-ascii?Q?G/42mrXGrmp6J6DyOcZ//hQKLjITPhtD0jU39rMieCTOvdaC/qjPMtxqXFPx?=
 =?us-ascii?Q?TbWdibA9VM0doBkhrGJ29VI6g2tzdHQstq+ml6eIK9EQAcBoBiV0aiAdVA6m?=
 =?us-ascii?Q?W9nB5M7w210oVtuYuIHiN6gfyKXnjKk36kzN96PIGUk2WooFeILMEbuLjqpA?=
 =?us-ascii?Q?XmsNIM0w8fdS94QPqLrt/G/H3qGXtjYbtPbLQfcDe/NF+0MdBPRT0gOYZ7na?=
 =?us-ascii?Q?TFXNohkhJcviSAwEkebNa0wJxW8ePl6Byq6uDB191PZqSJnrywFRulxRKGM+?=
 =?us-ascii?Q?sj544bUno3uhmDGAa5+lUjeN4zKXVqkpoAmo+CH3Uth0k0RgeIJ08LNlN8MY?=
 =?us-ascii?Q?0h4eIN41UaBwHFdueYyeL59rVgs0mJxL7uQO+lHRVPHTguUFh/Xa8ND4fNA+?=
 =?us-ascii?Q?/afOk8JbaocGhIHqw2Z1CodB3FLAo/PBstmVjrcUsFMOY40AghZ/s08MgCPj?=
 =?us-ascii?Q?QlcG+V44HDGuIBakoORGaJ3iZhNv4YdMIgh5EwRKo88xtEr2lSZOr7X2liyy?=
 =?us-ascii?Q?kjNMKOSES8fldYLru7xpZNtduv3H5kxFWMy0yO1ro/YWrMSueTAomD4++Fg4?=
 =?us-ascii?Q?gSbowjtiVzv0yyxLcPQiFgwXEiOK3LCtZd+A6WB8JmOHpLldG0DzXjpPt+4/?=
 =?us-ascii?Q?ltKw+2Z2bp6xIrBjOerGUa8mPhZcar5rUfphfxWsE2ezZAbcv9BddmvfAoAq?=
 =?us-ascii?Q?TESdmb552pw4mMsWq8IS05dpZoVhB/bIa+w3QdazPqZ8sD4y5SeVIb/tMO/+?=
 =?us-ascii?Q?oPC7YlfBd6lFtbFrII0SKGF5H3J4MgghjDHhbqhRreGgsSmwjOTVMZV62PjS?=
 =?us-ascii?Q?rwwaKz8pNYIvERXM6kBh5EpE7Ov9cghE4eaukP8I2INE1irvWOeZshZNLX+A?=
 =?us-ascii?Q?BPHrsxeDNwYHdabEYPWqdhATuNEdvjEbhrE90Y/qcVbHaoKfdO08aRh4gwov?=
 =?us-ascii?Q?RYLXP3DJ20a2X38E53G0nm++DHWINHfocnayYppZX4j/tgEQvx/C6tDEeXzH?=
 =?us-ascii?Q?ydaFXYBBJmBYMvJSLJlEhIGpc9RRjKJTQbko7XdKvnYecjSrJT9oMGmh7kNf?=
 =?us-ascii?Q?XvE12DqTqSYcvBpe0rhUF4ze1tO9Skvn4cunNmgANHj8mmtFFSWTyg8o0eRG?=
 =?us-ascii?Q?TBTG6xPiFff1wt3rnk4jvABZu5S+j5zckivtalO68Dy6uole13siB6++7O+0?=
 =?us-ascii?Q?P/6smME36wy0gedmtSWBVHH5n9gt2rDMGDi5wSzb+L9uJ1bBnPncwp/9nyuz?=
 =?us-ascii?Q?N1O4FeN81Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89538ab5-455f-4b9f-8d9b-08de5c7f06e8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 02:02:58.5714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JzYnn6OXtVExLnThMNaiKtiackdspYjinPywPNoJCYKKJrGnMFfxpuxRYL4C87YM7vUGBNvdBhKhIC8xq1COg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11246
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

Hi Tom,

On Fri, Jan 23, 2026 at 08:38:54AM -0600, Tom Rini wrote:
>On Fri, Jan 23, 2026 at 11:29:48AM +0100, Marek Vasut wrote:
>> On 1/23/26 8:54 AM, alice.guo@oss.nxp.com wrote:
>> > From: Alice Guo <alice.guo@nxp.com>
>> > 
>> > This patch renames the board directory from board/freescale to
>> > board/nxp because NXP now provides Board Support Packages (BSPs) and
>> > tools for the former Freescale i.MX and other i.MX products.
>> > 
>> > All relevant references have been updated accordingly. This change does
>> > not affect functionality.
>> > 
>> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
>> This should be applied for master branch ASAP, so it won't conflict with
>> other patches.
>
>Honestly, I'd like to see Peng pick this up and send it to me in a pull
>request. It's going to be a bit messy I'm sure.

Since this touches LS and i.MX both, I would like to get an Ack from Fabio.
Then I will send you the PR soon.

Thanks,
Peng

>
>-- 
>Tom


