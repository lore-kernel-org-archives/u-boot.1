Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C05CC021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 16:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B46C680BA8;
	Tue, 18 Feb 2025 17:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="CHzjynli";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8643D80BAE; Tue, 18 Feb 2025 17:24:28 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C193080646
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 17:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frank.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgwABkSEAXiJ+iKHTe54H7j/LIFNCqB8zdkIfKr1RolFUunl1bAOoLq9C2yP/6OHbr/E2udO35M+WrbW8IuLhX3JqCWjGusfaKg3PKEuePwAArX9vWU2BCcqTellqIxAmHkR0X/K/QBvzALwoAMa3nC2Te7gs/GH1pG0ggmQih6Je4eKx2TqHm4bTvMB/8uO6v6jm+tzod1UrF0AboEIkuLlWhlx2Ck92ftx559+jZ1LxlPI2n4KYeEvQdGFjqxF3erSNa7lJ/BP7BdWs0wzXa1FwaUwUzPeua0XADqKZymw6/4rPiepPGv5OLYyZ0YIWB3pkSc5o+vuEhnxOHayjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opSaYgGe+gAKemnbcgRnNG3tlBi+JrMZcms4WV8/AAc=;
 b=T824FoSBSA3R2TLoMvRW6JnYC6Q6l2IHX3Tpi1QltXlcDtxGK60cjhaCVkaopbxOkCUHTyVSP+zgTeadzlsgFufnpva8i2Q/duQM1xnGBdymzY13lpWRjtVTMJQUIPyrWYi2a3RRKxbpoGfDCklfulpvvQ1bWIqCkOmSmUX6USBD0p851tmPOf4i4LavCLJ3yEiiwRZ+YziFYHl1d7lFyI9x4HWxyGwbew+YTzdJSZmmgYwjmayYw7SwKrkAiRRUVLwPvr/By7OT+V/tVt3QGm0XbsIrJu1GvlzlZ9nJhtX3WtRlQbXjDK0DNm+QixJQlT7/E8kgWXU4QlpmdbOCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opSaYgGe+gAKemnbcgRnNG3tlBi+JrMZcms4WV8/AAc=;
 b=CHzjynlio7RlS7dhMgzcV5iJgdlImuMrjtzJ2gca/iSXHRiO9Nj9JLrJsCN5O/RQYTf82vzYnEXKPKBqqsSR6BmoIuAze9TcTRn//X5AcUsL8JYp/t3Qn2B3xajsevW/a10hW2BQ4InRmhMuFgS650aCrwSnUsfIOh+xqdGPNM7XUljNdnhGJOopL02czlfUPIOTFgB9txIwyfvVgclYmcxb+tjzrTDD8tUtlK5Peg9CLj/qsz3hhRUjfAONfA+u2w6YqG/sKFzxfRHnqnkM5GDavEYurdwLnIa+2FCdLOW/ch0lMUUAzS9M5MKgEr3Os/Uj+66kOY3r3X4SBwoLbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8958.eurprd04.prod.outlook.com (2603:10a6:102:20d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Tue, 18 Feb
 2025 16:24:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:24:24 +0000
Date: Tue, 18 Feb 2025 11:24:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: dinesh.maniyam@intel.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Wang Jie <dave.wang@rock-chips.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Boon Khai <boon.khai.ng@intel.com>, Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: Re: [PATCH 01/10] dt-bindings: i3c: Add YAML schema for Cadence I3C
 controller
Message-ID: <Z7S0LcUSb5y8Nr4u@lizhi-Precision-Tower-5810>
References: <20250218025705.50051-1-dinesh.maniyam@intel.com>
 <20250218025705.50051-2-dinesh.maniyam@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218025705.50051-2-dinesh.maniyam@intel.com>
X-ClientProxiedBy: SJ0PR05CA0153.namprd05.prod.outlook.com
 (2603:10b6:a03:339::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 32045736-0cf4-44c3-7871-08dd5038b4a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|13003099007|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H9N922PvZ1JusUOMfEUmPFQcUCdzN4Q5lo06+++hs7Ev0xh9p2WQ7RKJxknk?=
 =?us-ascii?Q?yxp0RZav1WL4Fn7xEmX3WpdFQ1uHLQ7iNB05TrnRJEqXNnpcjk82oBP/Bfkf?=
 =?us-ascii?Q?4LBtyS8LF0jw8tpmU6mBlDo1NQo2E3ifiDR5SaUE2j6Aih8qHBmDaGvSzOgo?=
 =?us-ascii?Q?MYL4CpOCVjOc+DHwUZYAP3ILo7xEJWigfdbONw2u72NV+PNOGihZzCmsxagt?=
 =?us-ascii?Q?0uxXvCiJkSjLTS14k10M8S4s/4JMzMgEywlUqyX/MrHKjpMd9tzVStjXIciF?=
 =?us-ascii?Q?CimUro4ZRjpyHKlaZJO1+pLelphFaynDTy4TO39Ru4aDrO0byfkjke/AqdYl?=
 =?us-ascii?Q?/E2hZ7BiA8MhbGw3vjyqPxOi0mCr9/seoywu+mjTrk0r+4Ezm179ZX2TvEQt?=
 =?us-ascii?Q?57hKld93mf0Snu2MP36lzWDP4Leqff7O0rv8iQTYJTrIdWrc12Ikp++Sdv/W?=
 =?us-ascii?Q?gg0IwsAsuzo6upPMpoQx8j01a5C3/BWwXhE4qu3dK0xbiz6iQQpL2x/ddRMd?=
 =?us-ascii?Q?i+ch0N4p6eFtljF3YkpkNPWFmhMBEfZGbLKSR2rtpiWOPQMD7ZVz85avG1ze?=
 =?us-ascii?Q?X2w7cKThTcpEq0+1U1vQmVqmFRv6YWhYqmjDH6jojXF69mldbSQzeUrb1EDB?=
 =?us-ascii?Q?sGY0QOlGOcH5q+XruQZu/tAvXX6tGIZkJDNhMQZHTtk4IfqEER5poLyhBcQ6?=
 =?us-ascii?Q?6H6Bws1ZqaaMoQGmOTfKNv6mn1FJANxiJsrIRWacMKBqtyWg4GRtQBl0ZA4Q?=
 =?us-ascii?Q?gMWXMlF3H9ZZhnYnARofU0AOFm1qDwO1AjzjkK+g8CC5uOS8PHHa2r8WDCgd?=
 =?us-ascii?Q?SxWBoTdyr6MURadgSz1nRvPMWvBImwfnXZfxtK7loW/y8M+GhKI7mpwXy3tf?=
 =?us-ascii?Q?t1P6cAEJrjpHLXniAebkpCACoG7N9xVklVCGBwKzNJfq8hP5Izp86Tsm3mjm?=
 =?us-ascii?Q?5q5z3a6y7dcMw6K6KYBZfmmhJI6dcW/0GQvqLUx9PM+qN2+48J60wgyxCZj3?=
 =?us-ascii?Q?h2zqjEpevBQFRPuc7uVUfXPZpwp25hJKj+28FIiisbJXgLSWr6YW3ad9XpbP?=
 =?us-ascii?Q?3Qxx8q3xgBJrRfLTP4YwS4DkyL3F7+CkhBEwSuFsrWl5DOttwavIK21dube/?=
 =?us-ascii?Q?888oPuPd336bM8PqPg5i3iVVpoivQtzfeSRN4A/NqXoZjLaIGDcNIXuqUwYL?=
 =?us-ascii?Q?WqNPzZvfUJanhVRGJ3SQ9ltVHP4Pcb9VfwfFLw8LPGi8kJxp/zic2APgZKfC?=
 =?us-ascii?Q?V0yP4mugAneUqVIPIqYcEjLqBJw/irJKpWYhv5b0z4KwS9jVWWIG6IneYMLP?=
 =?us-ascii?Q?5FlrAm2plF1PwgvUmkr3kOXu8wcYvplYl58UKp/mbUK+qz1wTqkCpbkLI6CU?=
 =?us-ascii?Q?LFnKkJ5GD/fkmFwpbVI9N3aTWFsB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9642.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(13003099007)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EtiPrRMcwqX0Zw3ksLKXITSUg49N6HDzkbTvbq36uW1hlmB11zlqpW9FTFes?=
 =?us-ascii?Q?i2z6S2GbrlfcbY1wwmyZIyiQkBcjGSiwDyinq1E6eU9hi/zSU0UbFZ9oIdjW?=
 =?us-ascii?Q?kxK7IUxrtzV7ALdeqaVPEpI7KS3ZJNBEVeYq4wI3l1+vA41HQ5NEbjHvfwC0?=
 =?us-ascii?Q?PQBsIbZPFiGHti+gr66q6Rbc+D8ghb7ejWbhBUJu534A7wTh4TL8hy+Wt2//?=
 =?us-ascii?Q?/v1YLooOUztrKUsG7BxKSKAGlwhOFt1eXFMsGvYrX1JmdxngOPhCbgjwCsso?=
 =?us-ascii?Q?90gSOnTJA7uZ8WJXtP35b//BA0q8i0ZvSSb1AxNowAyEcje1TwjV/MUmKyxd?=
 =?us-ascii?Q?U5rWNsBxCTQmt8hhD5xL3AUM8NEdiH8H/vC1kbYmBzs8DgCBVzdh1Qm+lvvX?=
 =?us-ascii?Q?2JYjhAhVSX5kJJ4fzeGw5j215X0guuIsrKRFDaLq9SUbmbmN6TnjugduNLCD?=
 =?us-ascii?Q?jrjuHtghamyt6GN4dOPWINoWlo2EPhFTb39QLdHNTRVui3ZWa3SATK+jT7ox?=
 =?us-ascii?Q?zgQVY06GI79ELlQvYD8Ieb8lisFFKXGnL1OZVvl4WIcidMMdINklJxEJ8m8h?=
 =?us-ascii?Q?3wRwxbJTaRFgqh47e1JO4yWoy3whV7+Ufz5VBygjCOlEoasMOtz7yvkpHB0/?=
 =?us-ascii?Q?wa//FjWVyinocMbeAw3TESQzzk7CP+2HFVnQlU8JBdllv4q3AjCphbTudz8E?=
 =?us-ascii?Q?ATih8+UJdXgpZIIK1XqzIaGTXzj+E3WJYCgG9WFQ6Cwe5uf7ufyGFd1W+Gyh?=
 =?us-ascii?Q?IOQqhykS2AzZF1WI/E0Jea4BTS0Sm80PE3vcX9k7W16z7qGYH0Jg6UJlTLaK?=
 =?us-ascii?Q?yI61KEESio80Z388E0m09PF27BtK1VlWQOiRA/Nq/8GxI+JP80eQfixrxQ/d?=
 =?us-ascii?Q?JKLGFFhYdJ83B2hXiReEyhTe9W0hesy/KKaTUt9K1Wy3tqhtD7ibungjQ0tu?=
 =?us-ascii?Q?VswtgjcYz9MQfbr7Mdlh8ocy/zQkZZwp10DzBDePDkJe8PIkvtSnvex6oLG7?=
 =?us-ascii?Q?tRwHQEwm4RS6LMNIoOReEu9df7BFG7M8n+Ry10hmT3j+bRoF7o2st/KD1eIL?=
 =?us-ascii?Q?eTUKx+7OZr7xdBcU523/W62pblmw02dKa0kTMj0hzLgpFe7JfepeFRDaW0/k?=
 =?us-ascii?Q?TcburGtjN5PdAGuvYvk6pKpXDEWl1C7KufUSBOUlo2nrcol2m8DjsqHpteaD?=
 =?us-ascii?Q?dqXxoVfX5INIa+fpqCqQEl+F5lxKIESVkp+YtSjaoMcusg2FgwVCWgQ+6bq4?=
 =?us-ascii?Q?NlppgP7u6p2udSh8VUXO4hRpxbq4pybZys2Sb32LukkfU8hUeyYsM+1y2B+H?=
 =?us-ascii?Q?wTF+fJGEqOaNT3qi/RSE2QeIuRO4ItOtisQG3WkD0tp27pue3kMagebCdhrk?=
 =?us-ascii?Q?XrxNX8UuT8VfEavbRZ9SoiMA09JjaxIzoBeFMzE5WcZJC4fGYSPKOwLC+Uak?=
 =?us-ascii?Q?IrUDZThSe5I3QYvYcEzkuJaSmCE1iwh+VCe5GN/1+kBIwBQ5tOeeex9cWPjy?=
 =?us-ascii?Q?FbdVGcvl339zwckpx3uNRFP3QDHsJsY0/5miTN+RsIMoM6Z08LDlqr/zvGxt?=
 =?us-ascii?Q?q8gs+nY+u/ErT7/ucRRtvQVE+u83FX8ogMKkGkpy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32045736-0cf4-44c3-7871-08dd5038b4a6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:24:23.9965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACEDUYuNrj1jjmyhQXkBjiWEp2FOWVraMQ/31XPtotLlBwH3di4IGo73GqG9MMB0mZAPZA2dr34M+HnSVZgzmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8958
X-Mailman-Approved-At: Tue, 18 Feb 2025 17:30:07 +0100
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

On Tue, Feb 18, 2025 at 10:56:56AM +0800, dinesh.maniyam@intel.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>
> Add a YAML device tree binding schema for the Cadence I3C controller,

Cadence or snps? compatible string said snps.

> defining required and optional properties for proper integration
> and validation with dt-schema.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> ---
>  .../i3c/cdns,i3c-master.yaml                  |  51 +++++
>  doc/device-tree-bindings/i3c/i3c.yaml         | 186 ++++++++++++++++++
>  2 files changed, 237 insertions(+)
>  create mode 100644 doc/device-tree-bindings/i3c/cdns,i3c-master.yaml

file name should be one of compatible string.

>  create mode 100644 doc/device-tree-bindings/i3c/i3c.yaml

Where doc/device-tree-bindings/i3c?

in kernel, and already have i3c.yaml
Documentation/devicetree/bindings/i3c/

stop here, fix file path firsly.

Frank
>
> diff --git a/doc/device-tree-bindings/i3c/cdns,i3c-master.yaml b/doc/device-tree-bindings/i3c/cdns,i3c-master.yaml
> new file mode 100644
> index 0000000000..0eda16482e
> --- /dev/null
> +++ b/doc/device-tree-bindings/i3c/cdns,i3c-master.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i3c/cdns,i3c-master.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence I3C master block

Snps?

> +
> +maintainers:
> +  - Dinesh Maniyam <dinesh.maniyam@intel.com>
> +
> +allOf:
> +  - $ref: i3c.yaml#
> +
> +properties:
> +  compatible:
> +    const: snps,dw-i3c-master-1.00a
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i3c-master@2000 {
> +        compatible = "snps,dw-i3c-master-1.00a";
> +        reg = <0x02000 0x1000>;
> +        interrupts = <0>;
> +        clocks = <&i3cclk>;
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +
> +        eeprom@57{
> +            compatible = "atmel,24c01";
> +            reg = <0x57 0x0 0x10>;

please use macro in include/dt-bindings/i3c/i3c.h

> +            pagesize = <0x8>;
> +        };
> +    };
> diff --git a/doc/device-tree-bindings/i3c/i3c.yaml b/doc/device-tree-bindings/i3c/i3c.yaml
> new file mode 100644
> index 0000000000..8f9c440db2
> --- /dev/null
> +++ b/doc/device-tree-bindings/i3c/i3c.yaml
> @@ -0,0 +1,186 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i3c/i3c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: I3C bus
> +
> +maintainers:
> +  - Dinesh Maniyam <dinesh.maniyam@intel.com>
> +
> +description: |

Needn't |

> +  I3C busses can be described with a node for the primary I3C controller device
> +  and a set of child nodes for each I2C or I3C slave on the bus. Each of them
> +  may, during the life of the bus, request mastership.
> +
> +properties:
> +  $nodename:
> +    pattern: "^i3c-master@[0-9a-f]+$"
> +
> +  "#address-cells":
> +    const: 3
> +    description: |
> +      Each I2C device connected to the bus should be described in a subnode.
> +
> +      All I3C devices are supposed to support DAA (Dynamic Address Assignment),
> +      and are thus discoverable. So, by default, I3C devices do not have to be
> +      described in the device tree. This being said, one might want to attach
> +      extra resources to these devices, and those resources may have to be
> +      described in the device tree, which in turn means we have to describe
> +      I3C devices.
> +
> +      Another use case for describing an I3C device in the device tree is when
> +      this I3C device has a static I2C address and we want to assign it a
> +      specific I3C dynamic address before the DAA takes place (so that other
> +      devices on the bus can't take this dynamic address).
> +
> +  "#size-cells":
> +    const: 0
> +
> +  i3c-scl-hz:
> +    description: |
> +      Frequency of the SCL signal used for I3C transfers. When undefined, the
> +      default value should be 12.5MHz.
> +
> +      May not be supported by all controllers.
> +
> +  i2c-scl-hz:
> +    description: |
> +      Frequency of the SCL signal used for I2C transfers. When undefined, the
> +      default should be to look at LVR (Legacy Virtual Register) values of
> +      I2C devices described in the device tree to determine the maximum I2C
> +      frequency.
> +
> +      May not be supported by all controllers.
> +
> +required:
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +patternProperties:
> +  "@[0-9a-f]+$":
> +    type: object
> +    description: |
> +      I2C child, should be named: <device-type>@<i2c-address>
> +
> +      All properties described in Documentation/devicetree/bindings/i2c/i2c.txt
> +      are valid here, except the reg property whose content is changed.
> +
> +    properties:
> +      compatible:
> +        description:
> +          Compatible of the I2C device.
> +
> +      reg:
> +        items:
> +          - items:
> +              - description: |
> +                  I2C address. 10 bit addressing is not supported. Devices with
> +                  10-bit address can't be properly passed through DEFSLVS
> +                  command.
> +                minimum: 0
> +                maximum: 0x7f
> +              - const: 0
> +              - description: |
> +                  Shall encode the I3C LVR (Legacy Virtual Register):
> +                    bit[31:8]: unused/ignored
> +                    bit[7:5]: I2C device index. Possible values:
> +                      * 0: I2C device has a 50 ns spike filter
> +                      * 1: I2C device does not have a 50 ns spike filter but
> +                           supports high frequency on SCL
> +                      * 2: I2C device does not have a 50 ns spike filter and is
> +                           not tolerant to high frequencies
> +                      * 3-7: reserved
> +                    bit[4]: tell whether the device operates in FM (Fast Mode)
> +                            or FM+ mode:
> +                      * 0: FM+ mode
> +                      * 1: FM mode
> +                    bit[3:0]: device type
> +                      * 0-15: reserved
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +  "@[0-9a-f]+,[0-9a-f]+$":
> +    type: object
> +    description: |
> +      I3C child, should be named: <device-type>@<static-i2c-address>,<i3c-pid>
> +
> +    properties:
> +      reg:
> +        items:
> +          - items:
> +              - description: |
> +                  Encodes the static I2C address. Should be 0 if the device does
> +                  not have one (0 is not a valid I2C address).
> +                minimum: 0
> +                maximum: 0x7f
> +              - description: |
> +                  First half of the Provisional ID (following the PID
> +                  definition provided by the I3C specification).
> +
> +                  Contains the manufacturer ID left-shifted by 1.
> +              - description: |
> +                  Second half of the Provisional ID (following the PID
> +                  definition provided by the I3C specification).
> +
> +                  Contains the ORing of the part ID left-shifted by 16,
> +                  the instance ID left-shifted by 12 and extra information.
> +
> +      assigned-address:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0x1
> +        maximum: 0xff
> +        description: |
> +          Dynamic address to be assigned to this device. In case static address is
> +          present (first cell of the reg property != 0), this address is assigned
> +          through SETDASA. If static address is not present, this address is assigned
> +          through SETNEWDA after assigning a temporary address via ENTDAA.
> +
> +    required:
> +      - reg
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    i3c-master@d040000 {
> +        compatible = "cdns,i3c-master";
> +        clocks = <&coreclock>, <&i3csysclock>;
> +        clock-names = "pclk", "sysclk";
> +        interrupts = <3 0>;
> +        reg = <0x0d040000 0x1000>;
> +        #address-cells = <3>;
> +        #size-cells = <0>;
> +        i2c-scl-hz = <100000>;
> +
> +        /* I2C device. */
> +        eeprom@57 {
> +            compatible = "atmel,24c01";
> +            reg = <0x57 0x0 0x10>;
> +            pagesize = <0x8>;
> +        };
> +
> +        /* I3C device with a static I2C address and assigned address. */
> +        thermal_sensor: sensor@68,39200144004 {
> +            reg = <0x68 0x392 0x144004>;
> +            assigned-address = <0xa>;
> +        };
> +
> +        /* I3C device with only assigned address. */
> +        pressure_sensor: sensor@0,39200124004 {
> +            reg = <0x0 0x392 0x124000>;
> +            assigned-address = <0xc>;
> +        };
> +
> +        /*
> +         * I3C device without a static I2C address but requiring
> +         * resources described in the DT.
> +         */
> +        sensor@0,39200154004 {
> +            reg = <0x0 0x392 0x154004>;
> +            clocks = <&clock_provider 0>;
> +        };
> +    };
> --
> 2.26.2
>
