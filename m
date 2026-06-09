Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F39CD8CA4
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 14:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A2684704;
	Tue,  9 Jun 2026 16:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RtC7Nsbg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A92684825; Tue,  9 Jun 2026 16:53:39 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FDB284664
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 16:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0/QJqHET+708VB9f5cPOy8y3I5h4Fkv3sZh1h9pyxFF+sqY3XarH8qhJfnldp+vWvwt1Zliv4ZaEu98EBSomsIz74fV3+Ek30gU8dGIj7OiS/6vVtvW3VJ4Eyl/U64r5HehL8XdVTef+PP0g2Vt15pkWP1VtF8s2MBI3N6QxuAk9NBpK26qQY1lQwRJPfH71FBVC4lGaFvstZF0zSPrdefYO4wmn18l6mznxEelBoLvrlD+OymkUWuqWDv2e/kjLfii8LJTvb0yj3uUkDSv+ie+8U5vVMFvV3eI5dIdPKGzpZKpLixYN/iHBO87ULO98eIydbIRbJ28zLTwcWoYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTilq0dbCWE/mCUTFUjbYB5oNWx/NFAvRZ+h/ligUI0=;
 b=HYaKHmGds46TAxtV/sQog4dIruKcwy1NBXf84VHRAQ3yIhbu0dT+ADI+wqjj5jI/1VtlvmGTACOL6KWobDvtil4lBqRY0XnVDg1mndPDXafimLdPFJnonF1kLy7IPwKiz+TquvYyzkHOwtQ5KZKUkB95+Ctwu3XLBUyOnAdDl1Xba/mEZfiGVAVb5/xbyOYvNFGo7Tzld+j79iGeQyQF7AxFDbMq3RgQObOxc6+tDdzsSmcwSrxc/PTdYIjY+K27D8CDiQ8NZBUU/X1BrCZ0b7kqjK9PBJxYNO4zmRyl8KMTqESS03muCDuMShl9Vsl8DsScQHh6Tcn1ybBdstObYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTilq0dbCWE/mCUTFUjbYB5oNWx/NFAvRZ+h/ligUI0=;
 b=RtC7Nsbgom6PwtSxian1YTtSKVtC42ZOw2qd07W+hs4KMAojF4x6dloBDBI+CHCC6HhMZAvE8QV9VB1qilGGxH3UlwvOkZ0444KZ0JYcYqWWPFgtwl/dXe7upKaIZg7L1rUxFYaijSd5ORUcL4nN7dAzAPBUf5jSfeZHcf2CXNnKWo/PKyOuy8CJ9Wp2w9Z/yFE91up3CTX5zrbfEQ4Ku5hyxeLAKLgxKYbtrRcLZRCwVxUcibpLarfqEb/JYK9kAX4Tv6FISjobB99bR7KwP/TDiS/kS5NnkVdSss8sXMdUEtFHDKto3UhhpeiUWZDV7+kLPUqAnnk8q3vS0noHJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 14:53:34 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 14:53:31 +0000
Date: Wed, 10 Jun 2026 00:10:39 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 David Zang <davidzangcs@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2] thermal: imx_tmu: extend with QorIQ/Layerscape TMU
Message-ID: <aig6_-DfsVjDlqSQ@nxa18884-linux>
References: <20260527134744.511819-1-vjardin@free.fr>
 <20260528125712.716561-1-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528125712.716561-1-vjardin@free.fr>
X-ClientProxiedBy: MA5P287CA0212.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::9) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 6156e7e6-0509-476f-ea4e-08dec636df80
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014|4143699003|11063799006|56012099006|22082099003|18002099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: a3azMvvOVLYJvozWfeZ7zURPE94xIcuNqJNUiKGlm+2+mhjLCVL9dGgacR0uSni4usTdTpwn+9ZfIdCX1rHoZFXMZwDMSyF4+qqqr5RivbDRQZdJYuESVVDGmokka3HMwpeqjjLypR5bkdBGqq132XNYQ/5XBbnLZyCPikQ8p5ldXIQF9w1VZIvAcKEdcgLpJ01XojNb768w8h9UNpAPU5BHMM/rKkqKduJ1u0HMTyZpu9karpTxZ+/Gl8Jp0Eh1iSmSFURT7upHmrn3tyHYbcHOq6V/yCRGOuiY5CGTzrLL3vn878vJgQ65sYd5p1FKi7pU/6TBLTY7+6VZWeUmdggws8OgHWtcGzZY56N2YLj0fYcqqxy7DMsZFrTnIIBARWJLhAwHMXyAJbCWSHmkXeXUqlvH1O7XXm0iWw7y3N+/Pblf5nJobXgpnFfct9IiSHKB8MhjbN8kZ+ceg0FGO2gfI62r0Yw8Tyj9vqd6eseM/Ta8coTr47OPSiteO+hn2hEFZENMCUleCmdqKqGdb7kWjrjU4RPPcdBXIzj8DKvDhSSBwQS3kIwuYA5tG6YEoVoWcNMwmeXFgkAZOS0Wru5z66lcO+iMTlvajTW7VP9AoHnJHuNfCPxWEWzmJU1eZOzGMGVf9bVDc2plU47prEhaWXL9sVWlpyhSkMAozAv736pFQTFQhRZmhMk9PJNhhrE/rFlemMTlrUUIEEsOcbXPjq/s2IbS688pSPiS9Zid3ZxhjtAQPrD2tYJuVnsCrO7Xo/QueMEdylm06v4AjhYkG/Mi9Maw10h/nHQzRGjRdhxGI2iimyZosLAY7nfk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?COJiW0rjNvG3cXrawmYtI+edRErjS/mBdprvWqVYqZOuUqtwOyselPrf9zXr?=
 =?us-ascii?Q?SgjUR6frHDqv4I2HNJCGZlSylMOHmMVVwV4+bwmG0A7Ljdtd3Jji4pqEh2Y+?=
 =?us-ascii?Q?AVtqETNlwhmtQPqOWsHt6/4CxkvByfqsp9QDXJXNN5dLyzAVpZzCdH6BoGtf?=
 =?us-ascii?Q?h83Au8iOgfBjow281o+/vUIE+iIpXcHtJAXp3UAogXvA7isJs+IpmZqID6Ia?=
 =?us-ascii?Q?TgO/bgnYPHDtneo115Ls9v8TGe/ZU9sBY/pFPwi1Ngq7kTqlZaLPkb6NEITn?=
 =?us-ascii?Q?yg4ELPxp17PRzGeG8jC2M7jFb+muaKd6+xg4p7cXWLv9OiqKL5TlMIvxCF5a?=
 =?us-ascii?Q?gC0/sDWSlkbR9tUvyI3BYKbl+DNL68v9Q7S4edMyHaGQlnL1jfFrvyug2VZ/?=
 =?us-ascii?Q?JTnnNZoT+r5TbRaYVm3AAhJSThm1z0BfpnVqx1nuaQ3AXaSSW/exo7OACF5O?=
 =?us-ascii?Q?OAvV0D0KGwyt1UAGNXmfpsRAVrhTbis9Xj3UKI7ANSCotG6yv5cD9VlMVTvb?=
 =?us-ascii?Q?lYLGsEcCJD4unMsUCPqmD2PCVqjfoM+jbtZIExgTV8vVweiOaBurreKfk4Yr?=
 =?us-ascii?Q?dRjGcCeiiB2uoomWZ5QJzPSM9qcSpNnYUTyf1kJ+a1KOqQW06eS/2/8Q/480?=
 =?us-ascii?Q?cN/pNqjn3IeK9NZnXpXPeGtHwmV6JOuv2U/NvB72NbS50PJUugZpzyxocr3Q?=
 =?us-ascii?Q?IqFIixymqwJCz5E1hMQFjvT88y6/e+XKjwOkHaP9Xz0Uaml+7qSPj33anUKh?=
 =?us-ascii?Q?U66EqLFfa8F5B0jlXb5pRHZxUBoHE5XxK+9QgGxF98whoHpBQ8JYBUeBHcVs?=
 =?us-ascii?Q?hrVeYS3RcL7y4gUla+yj4HVEwXNwXPtEMUwYT2pL4irMrjhUj7zHEiRgO2v/?=
 =?us-ascii?Q?VcOueWYG6SZR45mS5+kEccV+WvXo7Q6H+XBr5WmfhJKuhV6Sjh0isvbGBk3E?=
 =?us-ascii?Q?QlDZve7HYLshBFlucsmJE4gcD5zJ261Ypq0grD5O1oQMbuo/v4QS9VnaDL3S?=
 =?us-ascii?Q?hKfjXecazCRvoqUn+LWTrPuUc5SzQwWLdKn7fU9dA2xnp5sEV8obQ8i4tyKZ?=
 =?us-ascii?Q?lBtTyuMlNgizLH/sVfbs3Dl/9B7JfNuochnzZzSi45+KnErUHut8N7NY9eZC?=
 =?us-ascii?Q?4QAhzcnswW6V8Ngy+wuaS3vweJJK9YKguhJYipc93sHQ7rWZsTeGoQbZ/NkN?=
 =?us-ascii?Q?xZO1MpN+nqtRC12wL1Glk5lYg2SROS0hXPXBPEOdxhnCnAIKdiTH6y7ihTQm?=
 =?us-ascii?Q?wZzrSmOxCGgIaT3kfMA7Nen8TcE3MRZUMI+HoGEI7Lw7vHs3Vpwea6iz73Mb?=
 =?us-ascii?Q?qsXi+tyK0lCXPUoD4RYb4qh2kGoS7wPm8UBMXnq3gnNrB//6rVsJ66gN6Db5?=
 =?us-ascii?Q?pwO14NBV2BuuWgqshchBMNqlJQ3RX1LO6hGiWygfdVTJ7YexVbMKhbK/0mQJ?=
 =?us-ascii?Q?X1t6Jd14yV8qOifd9kmzwCZfwQaHM6lcBReazsRDA1w3IuYrsi+cNWEBvIdk?=
 =?us-ascii?Q?lUP3OqyZd63urwp1Z647w+f2oeGh2ZN9SCbDfpzotsygJZzGxwrhUwtuLddv?=
 =?us-ascii?Q?gMthSD7ixEU5uG0Vpwl2zyd5K3qEBVg6gI8Peqx3EQtNvdnuQDOg6nqZ9miJ?=
 =?us-ascii?Q?bEDWAAvoeEp4/TNW/bi08btf0fldZBustlnr9eJ17OvDM3fQC7CVVmYgjxi2?=
 =?us-ascii?Q?7BVKKzRdXZxM2JuAfUm7WlR5IHCclRwTAu2hLN9xcpD4B/rSNDqvB0l3cTui?=
 =?us-ascii?Q?Ebi6qPteuQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6156e7e6-0509-476f-ea4e-08dec636df80
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:53:31.4487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENdlWPmiySVmHlpYjSwIE5hymXdNY0kwxOWc5fIXmCTdemyl49GS+P0hRNnQEgMRUuPlsn8weLrf3c84zH+5oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820
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

On Thu, May 28, 2026 at 02:57:07PM +0200, Vincent Jardin wrote:
>Add support for the on-die Thermal Monitoring Unit (TMU) of the
>new QorIQ/Layerscape SoCs (LX2160A, LS1028A, LS1088A, ...):
>
>examples on a lx2160:
>  => temperature list
>  | Device                  | Driver  | Parent
>  | tmu@1f80000             | imx_tmu | root_driver
>  | cluster67-thermal       | imx_tmu | tmu@1f80000
>  | ddr1-cluster5-thermal   | imx_tmu | tmu@1f80000
>  | wriop-thermal           | imx_tmu | tmu@1f80000
>  | dce-qbman-hsio2-thermal | imx_tmu | tmu@1f80000
>  | ccn-dpaa-tbu-thermal    | imx_tmu | tmu@1f80000
>  | cluster4-hsio3-thermal  | imx_tmu | tmu@1f80000
>  | cluster23-thermal       | imx_tmu | tmu@1f80000
>
>  => temperature get tmu@1f80000
>  tmu@1f80000: 82000 mC
>
>  => temperature get wriop-thermal
>  wriop-thermal: 81000 mC
>
>The parent tmu@... node owns the MMIO and calibration; one
>UCLASS_THERMAL device is bound per/thermal-zones site so each shows
>up by its zone name:
>
>  => dm tree
>   ...
>   thermal   2  [ + ]   imx_tmu   |-- tmu@1f80000
>   thermal   3  [ + ]   imx_tmu   |   |-- cluster67-thermal
>   thermal   4  [ + ]   imx_tmu   |   |-- ddr1-cluster5-thermal
>   thermal   5  [ + ]   imx_tmu   |   |-- wriop-thermal
>   thermal   6  [ + ]   imx_tmu   |   |-- dce-qbman-hsio2-thermal
>   thermal   7  [ + ]   imx_tmu   |   |-- ccn-dpaa-tbu-thermal
>   thermal   8  [ + ]   imx_tmu   |   |-- cluster4-hsio3-thermal
>   thermal   9  [ + ]   imx_tmu   |   `-- cluster23-thermal
>   ...
>
>The dtsi additions mirror the existing fsl-ls1028a.dtsi: the LX2160A
>SoC dtsi gains the tmu@1f80000 node plus a thermal-zones hierarchy
>with 7 sites:
>
>  cluster67-thermal       site 0  A72 clusters 6 + 7
>  ddr1-cluster5-thermal   site 1  DDR1 + A72 cluster 5
>  wriop-thermal           site 2  WRIOP
>  dce-qbman-hsio2-thermal site 3  DCE + QBMAN + HSIO2
>  ccn-dpaa-tbu-thermal    site 4  CCN508 + DPAA + TBU
>  cluster4-hsio3-thermal  site 5  A72 cluster 4 + HSIO3
>  cluster23-thermal       site 6  A72 clusters 2 + 3
>
>Signed-off-by: Vincent Jardin <vjardin@free.fr>
>Suggested-by: Tom Rini <trini@konsulko.com>
>Inspired-by: Peng Fan <peng.fan@oss.nxp.com>
>

Applied to fsl-qoriq/next.

Thanks
Peng
