Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5026CD4F35
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 10:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 364578465A;
	Wed, 13 May 2026 12:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DPI4Lxsx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FECE8465A; Wed, 13 May 2026 12:56:18 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E01D8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 12:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUenkAbqdfZRGdvoKa9sUpTCkokN6Ja/k9RWH1BZrMKoag3CqZ+pQ5YedhwZrtSmqZLCMxtHa4ZNXpdqFxJg28LT75/pSOkkTMYqQ+6XzI+azX6TC4iFYm2bBUnoVCCwx/yAVCZzS9Khm98FGI7ytfK/bmy4aVF9cxWQy5Z+X0n2R5QWpA8YQyvvtZbISyfowKwqBkJvxHpLNht8/8ev/bhNQALyFoEs46sMgXREA8pnRdsT7r6xbaCoQpYQGL23QlwDfaBj7lQpq91nWwfLb/kjxylHvoPyo/o2qZezsOhmaPrgN7e7WtBSUGRpY4CUXtEhu1SKLxXUkAYeukFe+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6XHTzkEZb+gHm/fpy8ncOlvv78E6hvCXNa9eSzCqyc=;
 b=sDg5+6tBtdEbWIlK0Xi6JUMAndsa42nOhkN/7GuzU6vGv0pElra491ggFjxsikbicK4V7DuJ7D4vx6gXcxSKlePnNecsqCSWuiYSBnVqgeRs37QdUTPCYSNnPovF66CAkM2YP/9nvgC8d72JFqBKeoTE0G4P41XF6pMeFhkyXphXDJ3baZqF8PJZeRCuMeuigpxBWMLgZhOj4iFHHncsF+vm8QSvEGiAF7qYlOxdTezRutFsb/wkQmn2o1VyoX/FoNTvDc+Y3bEMqAJuDsYvWR/FS3MrEqNqLM/rbQFuzw5w4Ln9jmMUWlQrEuG1RQLP4HrzRwMkp8dxtfnq9Uq5aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6XHTzkEZb+gHm/fpy8ncOlvv78E6hvCXNa9eSzCqyc=;
 b=DPI4LxsxOUZxpANCGsm2RC/bbU0zSERohcmyk+0kQFCVZp6kA9xI+/YIB58KQiwyop+eYb55YI9oDfZ7FySQWqHCl8m8PgAwTpk5pGSuqLNSHcKnjnkNsu4y0SZiOlM62X/Ilg0DwhHW/PqC6a4f5zv0E97TJUOWth6MQYpxPyWmqpbX/xl4upgPkOkmqPJpA8E8RgogiIY79MJw4wRFPnQRS9AtUvI08NaFEX4yostxReruh9gOLRyRB8tqojIgsr7A4EM1H2jD9dOsVPVgArMFb0x1q7CLtwh9xXa7nw7lsfd/qjXQCTMRcUDBRSRzMH54OO2J9FNYu7V1RR+VQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS5PR04MB9828.eurprd04.prod.outlook.com (2603:10a6:20b:678::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:56:10 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:56:10 +0000
Date: Wed, 13 May 2026 18:59:00 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] power: pmic: emul: Staticize and constify driver ops
Message-ID: <agRZdK62wFa24V+3@shlinux89>
References: <20260508122403.512925-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508122403.512925-1-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: MA0PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::14) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS5PR04MB9828:EE_
X-MS-Office365-Filtering-Correlation-Id: 6650c0b4-b3ab-46bf-8a3b-08deb0de3e1e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: ZcIBeu/FTEXu/ZnHJBJ4KW64kzq8xHvcqh8rDzLpLFfdcDDocZ7qVtFGiDSxlI8qkF/fXXG7Hq++UKiuD2/DoBmbPBSyEJhMC4Bj5WFx+gpZ8fdCEKJePOOl1BzGz1cuVi0hh28lm2DscYxWQzYuSHa63dI5HAX9r31UPHPfCHhiqbNFNaXe7eNTKzCRo802JpLNZO/gGCF8XuXfml8SB+ze8F421bsBM1M2xgo1TSlh5Idc2cynM1iQ8vN+jjnquIsjZEOELheD/X3QQVJdO9WzsIh/qZILX+JX9CKZL3Sw9sMTcuH5Mi5o8xQyYg1H1shsS2dBZmta2l4TjVMaHTIOgYypvAFgaujXML4CWcuE9vSmFD0ixuOS+7KzNuUvQQ43n3mWAFtXZbO4B+H3ObsiHfph56XHircNVBQIQhsnCm2KLSestj6kuHgEYACeFbKfK/QFkBo9xBnLdFDMQOKOJEVW7SsXDww7LMQGCQoh1dwZBmd3ODxf0YY5pzx6QMOymX51dqtiyjPeePkJ3pFTLoVZ7dcrtLijOZclHbwOAMbH6Ah1MtLIKvExr5z5dzg678+4lIbjG+F8zp9XTB1PI2JIMorDL1cF2cqIbAJWdjCG8odVgWxB5B5dWb7NEjXB9+bgu4sjgV5Av9YQI4JjZR07KEh0GXePZ0zturpbEWZymBwh2m2XQ5ACs7o9ETc0CazZoyGA0/io02abuNd/VuTha9rwuCa2u/dj+8RuIgJ8ZNiVOyKTWixbMkIs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+mfg63ZOuMCHZ9pM8ZjV7igzhSlU3k26wfuiVRKK7LOppkg38BquB9bYyRAb?=
 =?us-ascii?Q?TgZbVw4ISNHcusIzYk3ac6RuIwpx+a4Az6Br2E2S2h65qUwMjLJfQO+6D4Tk?=
 =?us-ascii?Q?gwQhAANYSfWvLribtn5E8k1YWpxPmL5iZNHJIlqcVLXcxls6wo7hP6bVM3pp?=
 =?us-ascii?Q?XyWLPuvn0Kn6xB08OQy5nlD6hUHUezhXgKC5vJYHj64coJ5ftc/JFWERisCh?=
 =?us-ascii?Q?ER8uHW2tMRvHtdD4qgKXfiDdoI3/RS4Cws1KMsOfqMYgmqfwU7sFTkAFd+Ss?=
 =?us-ascii?Q?gWDgcqWPFVS0nC+SE1XDD7lE8+yt+a7By83YOFK/sFvW9Y4eGgq4h8NfKccf?=
 =?us-ascii?Q?jqnA7GP0/IhTuWvVcPufEUB4YpuziNQuJ3sP5SQtP/qpQa2KnB4NZzDO0/oR?=
 =?us-ascii?Q?VrGGppcuCY84rSj+Pub6qJlAzgFlk2m6a6VpJf+IK++RBO/4PiUhlt8GoWkl?=
 =?us-ascii?Q?Oq6r/q1vLsi+4I7wT19KWkW2V//B+ZkcNsfsR/JJhiDDtIWPiAvcjRFvfYBS?=
 =?us-ascii?Q?h4rKbcmK9TLYCGSOYEZoBRu1uWEvAaUo/ezXK80X/3ykj1VugqQIUAaKxuQ/?=
 =?us-ascii?Q?lDErTp5V34mZXwiJQJooiISzHjlRbmSzx+EgHfprWoVYHujXCOqEdaTYyKQu?=
 =?us-ascii?Q?d+6YtXvyu6LZUlScMypPKTEwGXq64pKo2bVyzVTwbJP0zyLu/IXHW8xNnvEF?=
 =?us-ascii?Q?UOYUmxLOdB8nkaWAlL9E89dvMZDQDVd5r2Xy3CLlq7+6SfoEVuhsWYF7hSc1?=
 =?us-ascii?Q?5Q5dhKO4u/3IWSxgIo06IO6LfaIgDy+/twLYEO8SoBDlH2nYMQebAhlSp6bL?=
 =?us-ascii?Q?ajOjQtCeHzMOiEMiprCXoIqif4N1wfk8l1u5YG8iXEvRp7Rw2BekRFQXepDj?=
 =?us-ascii?Q?bTHU7kPjKJgvi6SW9CiaWEn2m2Uz5msFMjftoy67ZvJ8OGm7JcfE8gsKEwsp?=
 =?us-ascii?Q?jVlIwA+0uW8kqg8h620K/yeNSKvdc1jJyWys3/WXwhOIL3LDA4LvrzDbRI1v?=
 =?us-ascii?Q?BxTm5ar4RZhTfn2AObAqhkZ3ComjsY7l7kioZY2/ve+P8nCNbUfPYLlPeDzu?=
 =?us-ascii?Q?BoGRDe7ypXclas4norpPkY1NqhlIN/tkvRRkDYYERoXenN3loz/JwXSL8Gus?=
 =?us-ascii?Q?675FUnM7yGTjiCF7l6vLK5KRwSECYU4d05BFymX3vN3QJD6l+FFyhHQ/zX9s?=
 =?us-ascii?Q?N0uV2wmkS7q4m9jhzs5ZbdiSEx15XhIii8WFCxn54W9fO8M0nbqQbunA9tNh?=
 =?us-ascii?Q?tkEC925LnMEK6LEiu00Me9VTmqXWtoGg80PF8Fr0Ye1oQgkoYpBZWsPgltwg?=
 =?us-ascii?Q?gfc7ldl382ByS3d6lw1/rI2GIsAixUppbuRfb1fG0Mffl8qIBOTWyn1pNFPG?=
 =?us-ascii?Q?Sm1K4MrABMaeK9NstfMMwlBy+lPam10YPWPQ48709NeKngNBkKT8peHVKvsq?=
 =?us-ascii?Q?Zotal1kFsfmIP8Rcz6BF4ShFfogwpeq6b6rEG3vrzIfnD9EftVZkEN30gElC?=
 =?us-ascii?Q?E1O/OiKorgxyBeruEappTggBis3bRKeQcTIGUUmMMgEgGjnmcVFTh/b27HaA?=
 =?us-ascii?Q?SqtWFYByhyLL5UDXAu/Nrk5p6igUgd1ngPnOGrskU6/2KfxD3RWrtRhf/72K?=
 =?us-ascii?Q?0nKJrF24Y8V3BybpM25pkGdxsvxbUIu4Xze28iNKdQa2QYP8hv3Dd81j8X6W?=
 =?us-ascii?Q?lP4OK5Qzw45DFnvpAuRCR1wCVfSjdgvOnMreCY46I/GWKUR0HFyMLBDWtLhM?=
 =?us-ascii?Q?0hsUJI0J3w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6650c0b4-b3ab-46bf-8a3b-08deb0de3e1e
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:56:10.5376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssjaKg9lrd8qjLFkapoRGrCqlgK0NrA6ascu+5oeo4J+nysb3eZw5CAjQ57i39Q7B8IshZA0cnScVtzDegAgeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9828
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

On Fri, May 08, 2026 at 02:23:58PM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
