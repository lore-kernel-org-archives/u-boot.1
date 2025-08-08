Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A23C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 06:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E02B846A0;
	Fri,  8 Aug 2025 08:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="c6UtpO9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D140884559; Fri,  8 Aug 2025 08:58:41 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEDF3845E6
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 08:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qz8KrxvMSFNnckHOdf83pqJimV5i1IUdxKpMlfeTIcFvaZMBW9FDzKhiOw6uJjBNs7MDOgeI3Bn+kDZgON71VGeMp57DqxAz7BQFZa30NDZEj5AsrdafkdoY9nfPVWpil1zGCo5ASxsB/OS/ukYDhp3BcEMUMGOOXoqlR8Y8BpKLrpAjkaAlJ8fZ/heTQBGlCSaGoSdONm5bpPqT41KxHkdRgu0XREKE6NuGGe5aYM+T0JrkR9xpYtBnI81lZRksnOb6mliS1hGDISD9nMXmbMacsDAppzq95u3KDNcne9L7RsXb+x4eGbvacmkXnPGSoNxDbQdwxq1Rk/PnafCIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsYGxYkPsjMnUIU+mWhclPqIQ/wpZrd52OZWvwo2G3U=;
 b=cSjBznmZOssmoafZhZ8es6DvO7YqXUE1Hzp1ttEvDHn3tWKLNUCGBdRaTHwrV2VYyi8jf0E3jw149m8i03kegcAVsKAWTx9iJRGonaHR350HLCiu1BknkdCM7nNcEOzx4r6EkM+RMv85r+YNcQD/XErONSG+v+rPefaMILFUtAvSVrGw+nh+w1pzbsVFMAfCf2O8a/WUIjV33+qr87ezhd2uFcPJ4cTer9av9gW46EzYxn68XXJa642dIFGaXqYSIr1YAy3Gbwpn6qmSiEJPm08YShEbFddtFNE4ixQgviNtk2zgvNQxD4W14in4bEbYkKIA6jU3I4EJ1jHHDQG6zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsYGxYkPsjMnUIU+mWhclPqIQ/wpZrd52OZWvwo2G3U=;
 b=c6UtpO9L8e6TadWd0FO0Hjhp5LtYnD9y7/zqiOZCNZpOvfeerOc+FX70WGO6JTwvs+Nidbla1d7tIB0dsV7kBmL2y2NxaBS+CccpIMgsOp2R7AuzgOOSS0TFoZlmsIAjcbfvLiC1Mo6mZIVnVfnbr9oBjT8jBG24IsJTKErdKWU+qS+Q1H+QpMaf27qdHaQ3i39wN9hrVqP0zyh/HBfjKd/1GRkNNuLhqCexUsHTEZPXWKnxLOejvjwY5NznO39iaw6wtG/q+viNJWniwxf8dnpYTiunyQ1sRqUywXUVWzN6rpHfpMD37SDQvpx0+ULK50uu7NzxV5Rafih15D41FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU6PR04MB11229.eurprd04.prod.outlook.com (2603:10a6:10:5c4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 06:58:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 06:58:36 +0000
Date: Fri, 8 Aug 2025 16:09:24 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Amit Singh Tomar <amittomer25@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: owl_mmc: Do not dereference data before NULL check
Message-ID: <20250808080924.GA4104@nxa18884-linux.ap.freescale.net>
References: <20250731-owl_mmc-v1-1-8493be6755e6@linaro.org>
 <20250805040014.GD29103@nxa18884-linux.ap.freescale.net>
 <ea192ec8-8477-4de7-99cc-2093dbc62273@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea192ec8-8477-4de7-99cc-2093dbc62273@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU6PR04MB11229:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d6125b-d713-47d4-6181-08ddd648ff2c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fcG8JbsBZy6eTyOuibLLhNljYxMOe0x6ffmDIole08zlrx0FoKlLKqLqJIOW?=
 =?us-ascii?Q?7Ch8M0AVZX1CA1KQCsmifsVWCYcHhvm6KkPvQhsZbDUXIoX8UZqHdbBXpPO4?=
 =?us-ascii?Q?Rx6WIzoW/PuEP1dGw5qUrMI9+IpcFsK4m7hJIf5ZY2U/VFLzx+jAhEBjOI5z?=
 =?us-ascii?Q?FSaUKAcSJybsncMDJrlzq4iF7tXGPyG732rEtQFJRFb4Qawsx4Z1SmU6zlJ9?=
 =?us-ascii?Q?qSVN+JvOy6dheut33hijfwHA/oWG7s3N9f3c7b8yZMAJJH937LMWqlC/JRsl?=
 =?us-ascii?Q?VEylGeMaU16O2tLrAojH0f6UHLauNdbLjwRoCAw6ZYZI4mFfXM7KBbp2iLIS?=
 =?us-ascii?Q?dBNUVrlD84oI/DK32KBgXh1GFJGrHU6fmk3MSBTKlMo7MsWaVWOZ0/HTPYRp?=
 =?us-ascii?Q?8ridetBqNM7Lkr/cgPXPWzgG6d8Y/HtiXeto5pfrekspRaEobNomgCwf0C/k?=
 =?us-ascii?Q?XfNQtjmD7jKomnou3hm0dUEN6cxuCHWJgEv2R6BDaoSxlzm3NhBMnSres7GM?=
 =?us-ascii?Q?rdK6CyLXtf/ATzFVRURQ3NtUsHC8+Me8ew8kY75wYjiLFXJSdJd/DgNh6yHC?=
 =?us-ascii?Q?7Fc93O8jdBVZgFmgbVz/AK1AEdZt2CjOz+gDe4JslCpIbddb0siz7EKJB+gs?=
 =?us-ascii?Q?OJaed9Fp2N+D0CiuieofQPaohbzNm3gS6/Zom9mYLzx1l5wAzPvPNzWIpeY1?=
 =?us-ascii?Q?uCUCB21us5KGZnFixIQYoiZiOsVMa4jmNQOmLLwFoYw66SnRh7vuUNiYa+6o?=
 =?us-ascii?Q?13YaQNueyfIFU390aZR9x4uVG57InV4n29Xq2rj52oW7oy9T93uYKqoChM+R?=
 =?us-ascii?Q?mthE3DyUlr3kHHOkLAust1xWUjjEB5OtQgm6EA8gEIvR9NRVrvZB0jeNIbGa?=
 =?us-ascii?Q?09rq2sX8S6gbrLND7m2+P2HTEkKfjwYGl/WSEgB2fzDDB7lCJ3n+1A1sDcIw?=
 =?us-ascii?Q?u08UN8XgiTQcDzQpvbSwW80tQ3NxZG2f4zecVAZgDeIRGY9hk5lQi+vd1UwL?=
 =?us-ascii?Q?40XDdbf7BznoHIkcmrJ2r21lEJSc8ktXnYDYGiOi7/lktchOfS6hC/evy955?=
 =?us-ascii?Q?PzqrW1nPNRX1il0YQjfMWniJEIy+P3/qbi7sD2671twITShldLz51/ItrRfs?=
 =?us-ascii?Q?xO6ilJzSrJp0FWxyhIN+ZKLhqGOboiDFD5EPASmvdl6sxRE29pe7KJjCcnav?=
 =?us-ascii?Q?/qTtbjuRFAaEiayvHtp1SzvsBx8NWwaKXbjCSZ6LTifWver1YXlbs6Weflr/?=
 =?us-ascii?Q?d+04qEHZH+LZ33Pq2fCEOJ9BZUZcDCbsginwZucxhOF89OBi/hDrV/ijqjrd?=
 =?us-ascii?Q?Orw9EItQ3oECgJCeUeeRJeQT3o1qZnsN9ZydPUwcH5t3o2AJmgziWLv7lbpt?=
 =?us-ascii?Q?gR6Yt5uqEB4386GrFqQO4xj55S4pUP7cVx3IecaVbFmRffMeJtHzjHIKIIP2?=
 =?us-ascii?Q?phKd4niN/oesmh6OrKrWFIuQU8oBSH3YTVNTf4QwXwhg5hBWAS0egw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f35b4icun+Qg9qI3hXukfB6GaCijshIP3NPy0B2M0eNnG3sbsFg+HayjXLLi?=
 =?us-ascii?Q?6/Z1IuHXsYfkHax4iJz10pHx5tJDqx/KBU6Zyc506BT0X80iE0g1AnCP6juG?=
 =?us-ascii?Q?90RX8dNAFSOGw45wcmNjYBTeWxd7B713oQOMdntcg7ihLYSGZZx2gqZvUsZz?=
 =?us-ascii?Q?aPPM+wuJtsa2NImlRioNkv7GMs8KR2YgKJD+c+/t20wK3OrzWdljNhgHs154?=
 =?us-ascii?Q?2QUGfzt7Mn4ppzuf0aN2w1iXNUkxaVGSD0p8jpHUGxuf6vnOZKnbQcfu4tqM?=
 =?us-ascii?Q?ebh0ug4T38HXvDHZakXppWb/czDIhLcmVg1yZ7B0QeztdSsn7oxkwe0e/L7o?=
 =?us-ascii?Q?dGoLdxaLLI/J29sMGbOIXEodNSYXGQz/ZImqQW/ydQUJRm9IYeEF3dlK+H8U?=
 =?us-ascii?Q?fn0wC2a3UfQKLCIla5F5SYm6x8YTl8gYmCiWjeY5GL9yOLgk/5+tv4z4KRFa?=
 =?us-ascii?Q?kqX+RwcVmkP1WA2kba69jsfUbZAZ/iL4idjlDgK/cHT7QzuLsoqd96kvXqnd?=
 =?us-ascii?Q?/TWTHGrb4CHO9oCraCDgFRBW0T1av+McFFk4TpLD3NC+VwtMQ1OoREMw8I67?=
 =?us-ascii?Q?g41bzYceCtje9Az45OFKQcUhQQ8gjJT2pkxRIQvuTUcvJr4g33n9AqXYVdA9?=
 =?us-ascii?Q?+56oWYikeaTciSI7uq1iGGGxty3BKLmVWt12kKpkSUbgI83w9RCoVbWd5CBe?=
 =?us-ascii?Q?Qgk7qosKwEjMVEkiGQEa4Irm8UNKhVbO4UMn4d4cYtmgub+Kbqrr3kWYSsup?=
 =?us-ascii?Q?fSyAin/+a5zLobkNM0de4aif7+vAsjVc2+AYaPYG8HiYv8VeHnSdReJBvmHV?=
 =?us-ascii?Q?58hG4SfNoZtYjw0q7hKzMiFoVfcHsKlRYZ1f20HHIM0yE8dfGBDRzYx08zxc?=
 =?us-ascii?Q?8odF2+v5bwrU2wFMlGxm0zjpvuZS5qej7swufU7sdG2m1A5oCAl6yCrPFQsk?=
 =?us-ascii?Q?2S4jm9UjtAa6pexH1hyzDp1d+6QTzxfZgNrGe2oK2pCsZsDzzdZ2+19oJ9JU?=
 =?us-ascii?Q?+vgsbQbEGdh7Gh2buZJDtz7Gu3Kh63ge5W3ruc6OnlOmpGBkrjARA5JwbS9a?=
 =?us-ascii?Q?q2o+MOivDQmfJ7IVQ6KYzLjWwLyRsBrCfA6ax0ZIHEMomKZ56KrhQoDkYdm6?=
 =?us-ascii?Q?hjzQYU9K4mO92FJV1Y9UeMLJogiVX93zGh6aFbEocMinRhnvwD8a7lGhKIgy?=
 =?us-ascii?Q?Hd2fBWgd12IqU30O6JwhL8qMJlPw3kIByFAQ6SJ0H3pYtgfRT70xA2wKKn0z?=
 =?us-ascii?Q?R1E/HbsqN6fQSt0kWpYevZjEsqjXq36lnA3oOwcRvTLjiPbLqSitN6VfhIPr?=
 =?us-ascii?Q?i8iUBdG9uPD6jTKTZx30l0zAo7c8ZEl9yh/BAzM2zaNmCS3zRXBhAu6mYbYp?=
 =?us-ascii?Q?zFdjGUId2Kfo1iu6dVKfjbEgP6gn0QFHo+bMqYutKbS/V8s9tdf3MgD1FT34?=
 =?us-ascii?Q?Ba6RkW9MCgfHZ7DljNiYPHfDTZs4T7yAJocdf+H/yZYmZBD0LrSyAW6Dx7eu?=
 =?us-ascii?Q?PSwoThqIG61j1jpOvwdyT9zr2cVq1OAzzqW/FV4u5kp4MPKCZhtjr+nlu3xU?=
 =?us-ascii?Q?JqqncCbfZjo4fvOxWoWIwJ7IS/pfo2xRUlPqXOl7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d6125b-d713-47d4-6181-08ddd648ff2c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:58:36.6059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCPhkWgiqsBSYBGDBItoHP8padwXm1PIhb9sgyvzTRYLtxhJFbcq+btbTOEYL+/vdKI+HNrf1JSSBN670mvKCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11229
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

+ Amit

On Tue, Aug 05, 2025 at 10:22:10AM +0100, Andrew Goodbody wrote:
>On 05/08/2025 05:00, Peng Fan wrote:
>> On Thu, Jul 31, 2025 at 12:11:47PM +0100, Andrew Goodbody wrote:
>> > In owl_mmc_prepare_data there is a NULL check for the pointer data but
>> > it happens after data has already been dereferenced. Refactor the code
>> > so that the NULL check happens before any code dereferences data.
>> > 
>> > This issue was found by Smatch.
>> > 
>> > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> > ---
>> > drivers/mmc/owl_mmc.c | 18 +++++++++---------
>> > 1 file changed, 9 insertions(+), 9 deletions(-)
>> > 
>> > diff --git a/drivers/mmc/owl_mmc.c b/drivers/mmc/owl_mmc.c
>> > index bd4906f58e7..c18807b1f49 100644
>> > --- a/drivers/mmc/owl_mmc.c
>> > +++ b/drivers/mmc/owl_mmc.c
>> > @@ -135,19 +135,19 @@ static void owl_mmc_prepare_data(struct owl_mmc_priv *priv,
>> > 
>> > 	setbits_le32(priv->reg_base + OWL_REG_SD_EN, OWL_SD_EN_BSEL);
>> > 
>> > -	writel(data->blocks, priv->reg_base + OWL_REG_SD_BLK_NUM);
>> > -	writel(data->blocksize, priv->reg_base + OWL_REG_SD_BLK_SIZE);
>> > -	total = data->blocksize * data->blocks;
>> > -
>> > -	if (total < 512)
>> > -		writel(total, priv->reg_base + OWL_REG_SD_BUF_SIZE);
>> > -	else
>> > -		writel(512, priv->reg_base + OWL_REG_SD_BUF_SIZE);
>> > -
>> > 	/* DMA STOP */
>> > 	writel(0x0, SD_DMA_CHANNEL(priv->dma_channel, 0) + DMA_START);
>> > 
>> > 	if (data) {
>> > +		writel(data->blocks, priv->reg_base + OWL_REG_SD_BLK_NUM);
>> > +		writel(data->blocksize, priv->reg_base + OWL_REG_SD_BLK_SIZE);
>> > +		total = data->blocksize * data->blocks;
>> > +
>> > +		if (total < 512)
>> > +			writel(total, priv->reg_base + OWL_REG_SD_BUF_SIZE);
>> > +		else
>> > +			writel(512, priv->reg_base + OWL_REG_SD_BUF_SIZE);
>> > +
>> 
>> This piece code is moved to after 'DMA STOP', so code logic is changed.
>> This may not be expected.
>
>Are you familiar with this hardware or is there anyone on the list who is
>that could comment on the preferred order of actions here?

Amit may help comment here.

>
>This was changed for two reasons. Firstly and of least importance, it makes
>the code tidier by needing just a single NULL check for 'data'. Secondly I
>wonder about the correctness of the original code. It seems a little strange
>to me to be writing to the device registers while the DMA is possibly active.
>This could potentially lead to undesired effects. I would expect that
>stopping the DMA before changing the registers would be a safer order to
>perform these actions. However I do admit that this is just speculation on my
>part and that this order could be fine or even necessary for some reason, but
>that would be.
>Also, of course, in the case that 'data' is NULL, the writes that were before
>the call to stop the DMA cannot be executed as they dereference 'data'.
>
>So yes this is a bit of a speculative change but I think it would be OK.
>But if you would rather I rework it to keep the ordering as before then I
>will do that. Please let me know.

I am fine with the changes, but need Amit who is the author of the driver
to give an Ack

Thanks,
Peng

>
>Andrew
>
>> Thanks,
>> Peng
>> 
>> > 		if (data->flags == MMC_DATA_READ) {
>> > 			buf = (ulong) (data->dest);
>> > 			owl_dma_config(priv, (ulong) priv->reg_base +
>> > 
>> > ---
>> > base-commit: 79f3e77133bd7248e4579827effc13f97a32a8a8
>> > change-id: 20250731-owl_mmc-ef16e32b68fd
>> > 
>> > Best regards,
>> > -- 
>> > Andrew Goodbody <andrew.goodbody@linaro.org>
>> > 
>
