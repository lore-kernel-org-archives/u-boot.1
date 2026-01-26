Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A27E63C9E
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 01:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C052083DB6;
	Mon, 26 Jan 2026 02:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Obx2cIQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2557583DEB; Mon, 26 Jan 2026 02:20:30 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3493183CF5
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 02:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8hISO4KOt0n8SyTt8pTSxwQHHA9bttvsTu6MNoqhGVZyTpFJqbijM8cdB0IhOfeKwCc2lJp9ylzr0Dz94LGV68IhYRTKd/EtfM8dFhUqxxe0/dXzy9OqiGaZdl8E2LJGGq4k/YoqjfRLQ04ipW5gmjWDdf78xVZHKpVh5PYftsK3C5U/+GDPyfe0F9+GWztsaNKMMMzwC6pEy7a9qbFdoVQKNDYmDo5nn9rwJYR7aoJVzx43vHfiCk8pvGPh3pw0D+3rAwwW/Xo4XKWX/b/UwRPOoM4WYofnNPVYn7CiYkzncrSocw+dBDM13SWPhnyuULCM/G+ZC7B9jCf19n7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00+Pl4lwD1bpKmyjLH/zv4nl5UO4hpmMugTPG0TyimU=;
 b=kn7AoldCOHEfadX+5qAC/JVMNCu2xzM78yBt0wiRAuQPpnJxTF3cmQoQNWRqwo40/WsHwqhhFcPF3jb7pKkWHABH1QohcImqLMgG8HXixxYNC6Y2qx5NDHUgqEe2LuP45Hg/4mZaQPjgDq8eZr7PnI5AIISOci04lN/PanwaE3lC/4G7sH9ymuVz+f1LCAGD4cZkKtkM5NSghEhwH8Brak7tLrV52zpooCTLHIKVvnEG+aHkhXpQFCD7WEXMFtRMJcjaQqMJMhS5pv4w0vNs51vGyajZLsCFY0O9ksPcIFKgzlUUPej4bJTCXrYFSmgWLl+bgqlyrf6rknQTFOKROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00+Pl4lwD1bpKmyjLH/zv4nl5UO4hpmMugTPG0TyimU=;
 b=Obx2cIQjh3JsrR9WYHxN8gPfmlIeGScLdIXn5aUd5AXqldk1z0En3F+gAFqauW7DVoebvLzFfXbB4Sua9NOJIMHtj6PY376YSq3MV8bmnp7AdcevAm+LRoBMD/zGVZ+C244tHeEPtPHmIoWiYg9aQCt1Yq3qnTdJqhvRsF/tW0adHg4Vrqxa45Q4mhmdtxpkX2luXu7cazNV5C8jIVE7Pptp16nXhJ7FAeCiI7XntQIJxTzK5KjTonHHellIF/VrbHNrCq5h52E/jInYUygRScF4XN4bi37kbcucUMv3A7BaHacm6IRG8zFGx1u8yaR1Oz019FrXoiRa6nvIBzFCyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 01:19:02 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 01:19:02 +0000
Date: Mon, 26 Jan 2026 09:18:59 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: Re: [PATCH v1 08/11] siemens: capricorn: always detect emmc device
Message-ID: <aXbBA208PKsaTUfv@shlinux89>
References: <20260124055452.8799-1-hs@nabladev.com>
 <20260124055452.8799-9-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124055452.8799-9-hs@nabladev.com>
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|VI1PR04MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: b97f7829-ed2b-4b82-c5ee-08de5c78e424
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|19092799006|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qBDxCDy02Th4CDnSZ+UJktbOBaQnixx+l/FDqhFifMw0kYw1ZS//CHa7IggY?=
 =?us-ascii?Q?Js0v0Az6jFOUe+uDfIIwrdAbHbYLxrKZn995RY5vDc3zlfFx6T3Ns4IftAxR?=
 =?us-ascii?Q?3ZxBDmej0udIGTNyW60lWbXZiICUXtPMqwC7/ZBD2li1J2J8L/YjmUfu/gBs?=
 =?us-ascii?Q?4zTd9Sdy8ShcFN6LrlzvkZErnch9r2rYbuLiOz1ZBLZIWX3OwbSPtBPVKd4t?=
 =?us-ascii?Q?R3BIWYecgg6MmOKHZchLudn1amRdGZ3XAM85t2xxMuH14C8wqK1UvMb97p9D?=
 =?us-ascii?Q?5i6JuOU+Kb8ktcVuxaoKCVBLzPU522hHyqL3jjHlprWXGLzwM2JHRbQFpJAe?=
 =?us-ascii?Q?NCBIAD+RxyXG9V3MwjO4/VnmOdgnJgZIMd2MpXe6BVg87qUCcGHjX5/wXOTZ?=
 =?us-ascii?Q?LyLLnILw4etwr0dIo/fzNlRua2AXDQlWfrjEuHB9II7HLwi7FMyeR4bcg4N9?=
 =?us-ascii?Q?JbMP6klRYO1oBvuW1xcmV5c7kge5jnI6uQS+m/XgEJ3TKYsMv379gwCRPMcF?=
 =?us-ascii?Q?yb98XQtfaRMISh+G7fq+DT3FZtAYVFqWNpO9EKapqqMCW9P+mEMtG8oZ36K4?=
 =?us-ascii?Q?u4V5gkreYWkuaUbmN7VPjl02Bjvr3+LNcMbPB6LGj4/Atn0G+S+v60Pa58Ce?=
 =?us-ascii?Q?VL5aBJAaaAd8LZI/toTQ54AI7vWtKSun6C24s+G47uPgkSARXJQHzerZD+qr?=
 =?us-ascii?Q?jxWkJ1eCQJiXrHw1H5TQ7pJ5vQk+1xqoCFi2n/A5ttaD2410pntlI40tTa6x?=
 =?us-ascii?Q?esm1EpKqaWQJbkmNsg0aihMWRWcTOuLCA/LoslwPjkde9NPG2xPVehUoohpP?=
 =?us-ascii?Q?Yhi5nYFL0Se5JVilSCM3gXWr0bNAtjzk2VcZmEf2qbFR2fsr3h34iGqm4ogM?=
 =?us-ascii?Q?et1erlgceYlkw/0kuF8MWCMgbX0tGERm0r8Q+L13iiE0n8KsxdomzNqMu/R5?=
 =?us-ascii?Q?wmpBtDNZKX/G94ceVSAuK/u3IsLZPzLodpVj3Xda5oe46szUTEC5m20gduQ5?=
 =?us-ascii?Q?4OW1j7eHuQREjR0gyykyrCAo5nrVe9T2C4kuyvU9WKR9ZQm3uzylD8+2ft3z?=
 =?us-ascii?Q?kgTmePFBZ4bvGz+k6rCaKmTnCDZ0f8/DmjygWYz9nLW0yC792Si+X+WEK/CA?=
 =?us-ascii?Q?bzrTKvnD3MszcVeKEQUrVImHUqZZnHnuEJM495j8noaSxubgNzw8ltdEJT6f?=
 =?us-ascii?Q?ZKhATZYi/DTxBNn9Mrg9BO1Dixu3nqFHVnW1dNl2KTdFqSfjNgi08t9x/+z8?=
 =?us-ascii?Q?9XKtvBRl3cJY0f+5OZKkv0gGU1XoqRHmcGBQpsBp9j1OGXamC3X7ycV5tLca?=
 =?us-ascii?Q?AVuedciUn+qpTsfSGS8Z7H0eA9jdcy3RjkTYew5gVTyzGsj6H3eQbWR/8T57?=
 =?us-ascii?Q?8xnbMsS4J8C8BQMvJjnPCr91+OVyHKmB4Z/qFhtdjz7lRFiroPDzU992MrK5?=
 =?us-ascii?Q?HKZClKONvwpT6BFVwvAGFSXlGL/xbZPCEJCS5CK/nC9Is1IWuuGJkGRuCBWP?=
 =?us-ascii?Q?4nBnhPmhCkVBlMLlnH8hKLk4Y6EZnXhjVNXeVbolNo2wYxfiE/jFtwQfV5wf?=
 =?us-ascii?Q?rWuX+j2P3i3/gBr7ebQse9sYgmFnvdJ9uNl9aGDl5dGZX/AsXIjIWHABodoh?=
 =?us-ascii?Q?q/vvZieJAcRYYcJcghrOvX0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(19092799006)(376014)(366016)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/F2R2gMtmhlCXabbnODo45S7Mw4Rg+XSx6ceyw2i7pHTQK0atHf2DpLJA1gk?=
 =?us-ascii?Q?RYK3FXnZWJ8FjNPlz8mZ/1CGJdinTipBR7VVkbjbTnGQ+FMbBCSq4kyHzvCi?=
 =?us-ascii?Q?hSsPTcuu8mt4/bMPi0/Y/R6bUU+eStCzWb48Emle5KsOvMBKLKT6lq5hH3GB?=
 =?us-ascii?Q?8rOELrbNrPgmIS5egPgrzhJtXckWLgTzDX6aBRvBa0DCGn3yqSrD541xz0Dp?=
 =?us-ascii?Q?lA1ymsLEHbThHXzGib6H/CuWgQJlA9IpB8MgjkOw5Hwre9LTpPvbp+vyU+wL?=
 =?us-ascii?Q?i12rbF+CSXZdyUM+aEx/MuwQjpFAV0xz8ziVTV/GMOMDmqpvVc25vUR2tX66?=
 =?us-ascii?Q?+9vJtbW4i+txJHdaWuVyWfx4gSg0V75JtSQFkrxyBh1Nkq+Eo6b1ceFqmXqb?=
 =?us-ascii?Q?Gi60GZllvhvjxP9AMXJq2NXC9nRMXxVQVORaWRdTqLEMzhtw/KTtn6j4nLc1?=
 =?us-ascii?Q?vj0N3btQpjH+f/4acDw+LCZQOFqDsCGZ0GImoGbue+GrdVdsJjUjx0XROLN8?=
 =?us-ascii?Q?EE2ggSPsy3ufQ+cmqsyLgmyEs3v+iJsoZR0naGUHbjamv4LvoHVN13BDf9AA?=
 =?us-ascii?Q?0AU3d9UD+9j+NSsGJHZ08s+w/AmGJH1C7EIZ2uLtV0hPl1kV2T/KB/WpZonD?=
 =?us-ascii?Q?FvfrQ+J92IZ38+3K4kKFyaSlQhH2ooqatav4GaXxMDvAemyhXuPxgF0BHrYA?=
 =?us-ascii?Q?qUOkocJRRLWwUQ7H7eOdjFamJbEpk4zqUd0RjYJh3Ww21MXLxTQHoDFoBoSK?=
 =?us-ascii?Q?8NhBjeAqG19BNdmW4nIGc/Obxy25TsBRB0oY8OH6ZvbrQd/yVr5eglg2eEov?=
 =?us-ascii?Q?/SnvRrcPYFBep5zSkNTyxIvwqFYxS1sx31leK6Uan3r4dvzn7AxU9eN1abDu?=
 =?us-ascii?Q?262si9E1+wm/qYFEBgzBIZYEbK1a6txKnDe36ukeMKfZtidRXc0TBgIdPrsJ?=
 =?us-ascii?Q?XJiqzwR/UhhGcGjyUw7XeSvzM12+08WyO3n/kIPAIYneaOF/1UdJZ2E8pfZW?=
 =?us-ascii?Q?I2sFThWuVD4Tb8FZLDFmGEZLc+OQTcjnBByL1jnMDNj/DYIGiB84CAYe2kpV?=
 =?us-ascii?Q?rXXVmOzlXQGnt4bZVfQu2CjZ1C5pYEQvcv9goDNO26qZXplP11q3rAQxTvNG?=
 =?us-ascii?Q?hlmu4fcLHS/rIhB9qilsu6er/kG9Ai/N+rMPx+/YTuJCDsQXJhTtdw4/VUem?=
 =?us-ascii?Q?+t3UxaSiRrVBV8IFBkm15tjWa4jcyjg6mcb3UQXntz+d6Uk+qT7h2zYJ3lFW?=
 =?us-ascii?Q?BEjT4yamR5diHpakWAMZt5RfLlD62md4k1j030kZYEzyo1A2zh0FPkLEk9Kn?=
 =?us-ascii?Q?jr4vI8E+NBxJgbx/g7MgNcKS77IZt5CWPj2VtYpLXYtA/L4CiBNooSr0Nkd4?=
 =?us-ascii?Q?Kem66hP6Pu/gWUntRnpmS8o+4oZuTXy6CEHZrlPXgJdnDQ3oIhPmNwd2n480?=
 =?us-ascii?Q?4U1v2xyicWGfd5Lq7YJ/ZYzGCesUJzAuURw05zXuWrkak4OSPsqcW3h7yqbV?=
 =?us-ascii?Q?pK7BoecbDbU54kX2esYSxtHLCxs35QsYHyEvYhQp9uqBhRT5z7o6/q3rzb5B?=
 =?us-ascii?Q?vIetTLVExAXKEjYaLdIHQPrzljgv3cXxfhyXVxxN/jYcyPcojwkJZWmQtrlS?=
 =?us-ascii?Q?2SlIllpZgdTfVtk7d1fXbsEFfpNUlGFRAvXnJA0DJZ1p9jl6/ITPGh5kimPN?=
 =?us-ascii?Q?JFSL/QjOI2zQ6t0jeiQ3tspBc9puiUb5Yzg6zNQubUt1eNcfwXcTQjBXidk+?=
 =?us-ascii?Q?Ugrm2wUFPw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97f7829-ed2b-4b82-c5ee-08de5c78e424
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 01:19:02.8173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5f/Rg4rYOTebU1gf6HAdbFH2Ma/G+8o1YDJ7UCiQOyaTPuJ40ZvDLz+zUcbAOsdQPjNdd1SVG9tS7DK8ZkEZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6861
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

On Sat, Jan 24, 2026 at 06:54:49AM +0100, Heiko Schocher wrote:
>drop Environment variable mmcautodetect and the board logic
>behind it, as we want always to autodetct the emmc device.
>
>Signed-off-by: Heiko Schocher <hs@nabladev.com>


Reviewed-by: Peng Fan <peng.fan@nxp.com>
