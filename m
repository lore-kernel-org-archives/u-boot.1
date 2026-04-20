Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB63F36C58
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 11:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0CD084314;
	Mon, 20 Apr 2026 13:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wuqLQ4YY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F84884315; Mon, 20 Apr 2026 13:38:57 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 651A284312
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ye1rTS7XR4dMze4PM+SAYZnhzMAgMn1NiJ/SD1Oaa29eRjcoCv9MIjjeBecsql4Gl+RsIuo1ahKUHzREwNfwu1fR7bSwnFozpb5yP1nyXa4ba3xRxvJ8SbSKTj9OJvGfwiQnQ7H+qGuwtJzEzEVTZMHHHzQk4orVoOBv32wiWj4SRr9sVkN11d6n5QXRdVAW5PP++WJwIQ7ZiChOQNab6p+RwvTq8YAzTWaKKQpOPck3Uf2SqzqTIdlXD4sSxxC5S2QZ1W3AWe8NKYe6o6F7xGMnT8/m3UDJXqZO3dKcPfRkq5H1DECxNYvK8BDJCynhkU8JijrfU7NkKtWT1HInTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7zTANoyayTo7HLkucnUVDkbdooQ7jeUi3L2JiLiDt8=;
 b=WY7p2FgcbBpmpZ86eIZs9dk2Pouek3MnZfs4snUT6/FYAec6amoEPsDud/p05yNnI/xoWrS8CM3PO3aR7gjUv3qPit6uAWUPI47gvhr/gEtE1jv48RRhBqEfNzzWcSi/l+CQldeCUp5+CrRwNxBcF1uIxaNkHtZY2E2VN0Yfjs+907NBMD5RZf9GaVLNpE1cRsrd42ntiN9ttQiH+aVbX7nj3FxS29yC2itbJNaCJdeYf9k5Vo2HLD9qW2Up9sb9j41eAYOiVhIGiy4Api04W8KYPZEnPgcsDBqlwboNuAy32eRix33iiu8dYk7GnBc8YEUy7PH0x98YSVnjEryrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7zTANoyayTo7HLkucnUVDkbdooQ7jeUi3L2JiLiDt8=;
 b=wuqLQ4YYYypsQP4QdX3E/wJPaR6FzOGT/m3oGx09jNeKEDWaIV5KIFdcXX2yh5mr07ZogT+cW74jtmnpE+fy34zAD1/1dBrD61UZPZlJ0e26BaAdNaqkC+04ZAQxu1SLH85DeXxnLjvp+BrfOIlrLwUb4n9I86yIOTKWA6tkk/oTdcJwUmV5Q/jbluLknh/0cxXvbjprY0h7NcvHFvwT+HepvgHgux1gYyJ+DXFnNX3eRpcr3wIZqc1zoI3TaR+CepXKguy8i0Lou7Eo0jqJ0f2fUmAn5Njbpp9fM4gHX4ql0Xn74CkHT7NN91AZL0yq4EENmunTBmDh0F1oSKiOfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAXPR04MB8928.eurprd04.prod.outlook.com (2603:10a6:102:20f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 11:38:53 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 11:38:53 +0000
Date: Mon, 20 Apr 2026 20:55:27 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, ye.li@oss.nxp.com,
 uboot-imx@nxp.com
Subject: Re: [PATCH 1/4] arm: dts: fsl-ls1088a-qds: Fix missed -u-boot.dtsi
Message-ID: <aeYiP-bvOna5PiV1@nxa18884-linux.ap.freescale.net>
References: <20260417141437.1490591-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417141437.1490591-1-ye.li@nxp.com>
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PAXPR04MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: be5791f1-4491-43ca-5c9f-08de9ed16633
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: b4+dEk5b7zQIr7YeefaSzZBPHbgZ3OKsacRKMnt/0P9PAPZr2iCjlhpEA+9pyxm4cyrxbltLvvo0B1A1KIQ8V/MTJ50mVQySjI4MlIuLsHJ9xDC147+pip3NxXoBst2mI7tPJoLD+UydTYrr3GMeelzjuc6RRYbKOU+GJX5hNU5e8XhJrc+AoU8AIkHQiCY0hZns5vGp1a8Ur31VGHOltDADqYVnhDhC9GguMD2f42hWgTJLVircjzauWG68EKSVm/MTMWWutD/mE5D+DDT/6lU2z7cMtJnvXI+R5xmC6H0hy0KCuH3G9YNhVzR89rcsQrxUGJmqNCEBBu7iKLJwJRn7j1IMzGOFrv++LRIr7j21rIjG2SMkD4lzvxc4VTTCILWOkG/Z0U1NzAC3De5Rgij++pItXZjTHhD6ge98Z9SsQ1GQGm8KCteD8QYOOVzXcR/7qXgm5RtHrPEd2PKtmj145BNl5pSbQC3+wzFNaKfMlA7wqucQl2ft48RCUivk6GEFEGi6LnhfH8LZ+0byb+yVdS443o269IjLkP1uNsqOOQiWwNfFH4nRwP+nPQ9wmug2/yhaP8PiPVk6FjyB5QMeKIMYPPnO74vMYbR6ynpLAd9G1FqJTK6we59qaV8qdvWRDl7dCBoVdpeHEPWwhcRsW4peomn1faqn4tDbbMYH4lzOn3b0kv+9lmN12pF1CHk4csTJjTtuCA+B+Zm5p9DhQj8HmeiGF3lG/HTeSJDUXbJWm1DkmOzZTlia26rLpdmEnh+PekRRkifuQytYvyzxdG8GGdu6Pg6RpN6Ab1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lkPA/IHOHqDxccjGREsawrb+Mun9u6k2q1nn6J08AkJInWiDyAJQVNuqry/x?=
 =?us-ascii?Q?zaSqaHit0kHHhrI8WI8I67VKHrDyWi0/347OrJPTS2FpGbKwdP04qfaWFJiY?=
 =?us-ascii?Q?yYjVcFtm/6DHnaVujaLwetUzmoM2Kvt6591qBA5itDVc4IItxTftnlGL39zG?=
 =?us-ascii?Q?QKLtrWeoCMimH17JavdtS6BtbINUH7GLXxQuEoPfrI66vHpNxEbk0CbILCcv?=
 =?us-ascii?Q?whuHmlgjYj2Bm127jisn17cBmwPGNJ3bcpMDQzvBYxnUBURxY3Tv6k3ucwQd?=
 =?us-ascii?Q?IHgJn0rie6Z2jU2j0PxgR1tNfGy8enxc4iOE9VoNBmaoZXQmN6jMWqt1hE25?=
 =?us-ascii?Q?P4NWlcU0/PsohIw66UBP7WF8R2tcaqQXF/xzrvcRaBj7YwlUlM4OX9gvD3N8?=
 =?us-ascii?Q?qxyY2cVPpHNvx9Xp64yihZLJL7bqhE+45J+ceVlXTHBCx3rLlek9R/GThalb?=
 =?us-ascii?Q?nU3Pk/5IFkuViitO8KBr/zJMsrJfs06s+XmFARk8dMz/HAWbSNCtax0QYfAn?=
 =?us-ascii?Q?5JGwpiQNsGjXFM3NfM1KRgnh0sRtlAqWL3iWSYY9QbOd86yPsTD5tyvOIsdU?=
 =?us-ascii?Q?AvKd4Ny8jdRgG0Y+amV9DhRNtE0Dc+XVromgYy5/OOZ2Co6IheI9Gp1zJZr2?=
 =?us-ascii?Q?aPsqE8Yj115B6HuS5aq7V1oUtU4hywtC8Y6wTmYJecgVZG6/yLlyGjew2V4C?=
 =?us-ascii?Q?0G29lzkzpYqzKdq8jHYeM9tbDMAPPeEhtOSNZqw/HReeT1FtVpbOQr0NdArz?=
 =?us-ascii?Q?NHMLsQQ5MYn3JcswMzqmKc8LDgvSr9xiMwwKAOfbA9M9/J+RcYHSHnjhfVje?=
 =?us-ascii?Q?c/JdK3dQskejopYlHozQjKx2Wvs6QfRojTIo3ER1IanOEN21q9vsnbuu0Uo+?=
 =?us-ascii?Q?EpVYj4njpx0oEpZ/+2rjNs5EWX60PqYCzpV8+544mc59ArO+dNHoEvZax6qe?=
 =?us-ascii?Q?5i6PBYLlkYJaOGo/v3UebIeJNlxw6KbJsx4TJ8V0HqE9pjZeTLE5qOSxZFpA?=
 =?us-ascii?Q?fsgvrKh5oqwNFju5+f0j7+zb9Ba4M+eHjzJslEqDsT4gKEkYo+vDHh7yCS2E?=
 =?us-ascii?Q?60Dx7lOb/2ixmb3Xb7wNeNVPmXe/crFZfS8N//9K1y1avOwH4Csqe/LgVUXC?=
 =?us-ascii?Q?k0mGVzzUIVsJAjlIfqH66LcFhVvVsOjG8JH6Iu88XI/HmbCvelnH4r9RfcUS?=
 =?us-ascii?Q?qherBPf73socQsvul48gfVj2UEC6La/LkJ8mDHo0wgYjuz2tN9xW3aRmoJno?=
 =?us-ascii?Q?12Z0vWujsp1+p2c0dZAtL4mfZs7a//5c53Ob7obMcIdfNsUeD4xyr1Zaxt5B?=
 =?us-ascii?Q?FvvsJpDqie3Xt/FrulVM8YLJsjzmCl8Dh9FxWNedUP81e1wJefJ9Va7a46/O?=
 =?us-ascii?Q?FBDZMxeA06UA3Us8/biwldp6FR/Sduzfz6Sr3VqKqsHlaiVxertf1OJzkjGx?=
 =?us-ascii?Q?Bo0jPBQXpA779xi9KekVAiJqrYq797xNYzxmiOtLy80XteRa/Vf+bvbkbdAH?=
 =?us-ascii?Q?BfJ3QX4UPiTVPfn53OlgIcZs9FnkeWClsT24iZh0F4W9asQDJ5GaRu/W4x5p?=
 =?us-ascii?Q?llgvQTKrw5CUp8K/0qCkir3MFJivSZTI53XcsdcLrX+mH2v91D3NvXdO/Wbm?=
 =?us-ascii?Q?DrAIeBvsr+N55HyviK66R6BH3qlNqjug9ck/CUdI5O2v9A63F+URqqhQW9Cf?=
 =?us-ascii?Q?KIrKN8VbOiZEDTB3CXi2PmU78cfD39ZiowqNW4U1d80YCcL4k9C6ACBvVCu/?=
 =?us-ascii?Q?uKGSspzO0w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5791f1-4491-43ca-5c9f-08de9ed16633
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 11:38:53.5229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7D3/LQrNG3Tck5b9ZUHZnPy8SeLtFaUX8lb7wQEdSm0oWWru0soeluJzzm94NuY4YKtMFS4Qr1yrOmnzFl1RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8928
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

On Fri, Apr 17, 2026 at 10:14:36PM +0800, Ye Li wrote:
>LS1088AQDS u-boot contains multiple DTB files:
>fsl-ls1088a-qds-21-x.dtb and fsl-ls1088a-qds-29-x.dtb.
>It does not use default device tree fsl-ls1088a-qds.dtb
>
>However, the nodes updated in fsl-ls1088a-qds-u-boot.dtsi are not
>included for fsl-ls1088a-qds-21-x.dts and fsl-ls1088a-qds-29-x.dts,
>so fail to get any output from serial.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>
>Tested-by: Wei Lu <w.lu@nxp.com>


Reviewed-by: Peng Fan <peng.fan@nxp.com>
