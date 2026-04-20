Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6435CF36C58
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 11:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E87784337;
	Mon, 20 Apr 2026 13:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sHgbFbDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 080DA8433B; Mon, 20 Apr 2026 13:42:49 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C8C384312
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8JJ5whkGUBAAOO5j0/aXXSKefyRQknRKyr2fGbebk1RBp7FdoVWemW9x24z5j9nPkaZY4mz/+K0Ww9T6mWHjTmJVvB8NjBNCIDdQFzwBNMwHbGm1LXo9+e1O+5hRlXZOUL65P/MnN1JN4CU4qT9o0KpFh4LrSG+zFnr+L9aaMjSaqM/8N6defSTkPwb0Kk19jd2oifo5VKJOTiFAQooGrX1vNXJwdeo8dS9ZZb5K3bvet0k15O4zz1n4gblyEv0nLCetPAwjqNUe305dq/AOmHB1+Id00fC+5VZxat9wMYWEY3W3gFqVqg7q8TfuBlLLfgyVrclpQf7bQsWbRNgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZNL3MFdBPZfqir/HxlVuxV4qAh3t6Mpws38rLkmSfk=;
 b=Q0RZFQSUw7Sjmoc5silK0RtnKgIRm+prXhUbacKJDBMPb8sUMZ5raiMJyzRHi0zkwJ+vxJc3VdgwoPFvBTsMrJmuzk0hxLG+toT5U/pN4OENj3OdmtyI47rseG9y0qSk04DWVF/xtq9d1RXLRBdQ9In/ozLrFS3iQIVaR9p/uk9qirkbtSHOkCVkkmI/cMowBbsI/nGCFsPBmawRFQJ2mqLL7rHpPuA3az9Q9sr8a6lU0j04YEiUa+UeuOGvo06aJrMZpxscHxMJFxsfD81M1CM9PQPHFNOmZfN+r9EVIZwSm/TxbBIt8B/WIPzPuQvdbJgGb9Hm6BR9gEqUkwwGpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZNL3MFdBPZfqir/HxlVuxV4qAh3t6Mpws38rLkmSfk=;
 b=sHgbFbDJEa8LVmkogAMtdOWowE1r9n19KRsXQjjas0eLtpratzO6hRu3fbYrhdm1ZxYtXX95Ib4MAq5X5y2p2pGh0baWofCjFv9urUg6Y1RvTr2W6YKa9eU5jHznVRUUHo8UcLnbXKq4i3offfUNaXUJLzRGhRvNny+30ZS08RoMHAgJhROEQ8hLQ0R2kCeqXPWrWakVYUqhcGslKvEuhReAO/P9BzQyFwSUm+eyihw5WLFu5OIhes/XRYqAU+gl6TIr05chcbqg3OezKF4IHMIORFdlfl/lGzZvCNfQ22YTEHpegFUofkhFlLUEEo/y5vK16Rrdj7s6jqr30FCQ/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AM8PR04MB8017.eurprd04.prod.outlook.com (2603:10a6:20b:249::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 11:42:43 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 11:42:43 +0000
Date: Mon, 20 Apr 2026 20:59:15 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, ye.li@oss.nxp.com,
 uboot-imx@nxp.com
Subject: Re: [PATCH 1/2] arm: dts: layerscape: Fix DT build warning in SPI
 nodes
Message-ID: <aeYjIx3FIkewLRhe@nxa18884-linux.ap.freescale.net>
References: <20260417141637.1490695-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417141637.1490695-1-ye.li@nxp.com>
X-ClientProxiedBy: MA5P287CA0152.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::11) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AM8PR04MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b6e6bf-a295-43b1-d674-08de9ed1ef26
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IEmWldnp3vB2IOqmXH5xAU/lphiDodOY/vjjLO+6/PnaqZut9QcrcqsMzhQG+w0475zj2EbQAP4IKP0FVi+ChenpCOrtGFHPXZ7iz84aM/jf81yhoeK7WhakN9Wz2cA2jolnNCqO0OSV0pYjz8sPGhtxg729HxpDjq7E+1X2pJAm8rvTOFJifBy+H1qdQgUl9tiXQ6UhSbVf6vMaUgNE6T7e0GTR96e8REoh2coPXCnRI/m3mFh4W8glkK6Cs5Tu8u/oVm/i3PdU/sC9ywtJ8DVY+PDFQ7W9sEmMTdfQo7WzjinzKKcN+jt+wiFhTGRUuIXlDvamwhKjoDtUTGKlz05FDPQgxZ6ohVid1SCtFhELtyOAo8SCYE/OOrlN1FB8uSof9mv4YcSpktcPR4d1VOLs5FPCxceEhMc0q/7m+xV69Eo9mpaiuQfgYf6snbbmUCWKibcwzxw3VypBRr/eRXuujaqaRZ/vcByFNTxMGR+LfQYsG6gWWxUxILXXKg0dAm3ZJol+3Q/E7P3KoZxtXsvkYD1xGOdR7DawhyUXmYbQoh4WCTXE1ho6mM6ASm1fP8HC6oaE0BG2yo/USRWghYO+wIyXQXvPSOmw0AHqOsAnK3vSrOo0I74UMPKUI7MIlnE+pKG/TeeLwgMnuc1u6KqFVSQU6YF6WhH+TA06cxzhdBpE/4+Zd0IDG7qGh61fvPbZc5iTA3qLeAyIYy7LjUUjPTk4EpJwkBNZBONtt8P/9vQXmUB47C5/eNk0qvNmkv0HfqrS3Wp/PxeQX7wN/irB235ljv+c/7mmD33Sz7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6bXe2HKvJYQwtua3NeJfvid8Hk6KnQ52nN4U2izwKf/JtkMHnmX1NdtJoaow?=
 =?us-ascii?Q?d24dHUeaSrG517XmpaAUHRnkvuQzkHonaq09En7PSsrftZU9p18we0oCrx9q?=
 =?us-ascii?Q?TcWnRJbkgopNFTeE0trtZOlcKPWOdvq3vDyLpF6hIF3f6I/a365E7RgNOmPs?=
 =?us-ascii?Q?+5M6qJwTaskqK5ZRT9YEPTOku0n/2MZEzAWNX9t5K3pQdyb53m+6Fa8m58uy?=
 =?us-ascii?Q?6Blqk0fhN6RJMBGab5tDYkbiHC0Th/O5t5mqVlGAcgYVAFSgQKITKsxD+pAk?=
 =?us-ascii?Q?Q+qaYJCmCwO3Rn4UxQrY4M/9NZRYjRk70+u8WJ/UHC0dvtK9WpiMYZIaD71E?=
 =?us-ascii?Q?rgxogLgo0JSAsO+Eom2KhUPepPW5Xox71B/zbZE0Fdv5xa+rr1imvM8LCVEb?=
 =?us-ascii?Q?UhwUXxo/qedke+NZO/ANvhT4rLg0butwIzpBroblyuSTS05/2VQMqLycKoi7?=
 =?us-ascii?Q?dtIncvFXXvXv5Y3B1mJvvN91YXkbE4mOkG/iFMIv2uU24BbGOjy3+r14QaqI?=
 =?us-ascii?Q?rrM3I3sgvqD1FjBTp9ilvoNBkTb/KCrQHlYkHxFo7TZoqIjR/ApJmqIPN/Ua?=
 =?us-ascii?Q?qxLLk/VZyI8Ot45XZ8cs8mrrDyo6rcHxlgsSy3Z2jhTRezyDp2neMdPy9duk?=
 =?us-ascii?Q?L3AroDlMzF1hSyRcQ1uf4HfvsKVqsm9ruviFf23ZrdbT4Bvy1J1/4xHPUp2R?=
 =?us-ascii?Q?5iAE4a1Ey4Kpv6/LgRdRN+1fUmiIQ5TYh7hgMQGDIlfUwKN/UVm2q7UxPgnB?=
 =?us-ascii?Q?k+7hhvpVmL7wd94TJbqCWQnueE+PsEl/1E3DWpUSal44sSejVqgaadE8gzez?=
 =?us-ascii?Q?bKhkSeeW4dpOLpOWlyIj92AgpWQyeHLIyP5wL5yOMRp4vK8UzDLlZP/x1Q0s?=
 =?us-ascii?Q?/Wvhfsg8M4CDPBxevYYoHIxX9+CbVBF1FBNKCpXsWYx5cpgxKqMMewf4Gclg?=
 =?us-ascii?Q?04Hs3/+1zZDymOAGRTdPTXQ32ccqXpfPbnA1Iu7gpWz4YgGSASHmDa4W+uMQ?=
 =?us-ascii?Q?Tz1ntYWrrfz0OgwIvswju0f8DmddaX3HvkXGDB+ztZc52/6axaKsSVPhPUGp?=
 =?us-ascii?Q?5xo0AbKT+fY7BKzzzulneFxUhsgiSpN5cxNIcRm37AFxGZFBXRJ/UJQfJ1VF?=
 =?us-ascii?Q?/yPsXvs0GHJ13jdGAnM8OrhFr+CT7tBCZbgLBcqkrbOw+pGXULDf26JvSBqZ?=
 =?us-ascii?Q?xnCPUD7dEbKLtrQjTc68UefSHSmCegM9bWX2+NXmqzKJl/lUcNSQ+NvpKWcb?=
 =?us-ascii?Q?A2GfLq4eoy3WQcW6J0PBkv4tgnRRijf5c8MKUWbM8ShpA0uPqnwO0mM3ZP6d?=
 =?us-ascii?Q?8UpK/BLoUVRsTSbOMfrUFhBErQ7vNnI1DdWfArdtKpOVJ8pSCjmECFY3gGQA?=
 =?us-ascii?Q?2TrK+MquQHuG0FilckCCSyb38lUM6cBWT34IynrV3nb9faAn5SSG0AnscAXd?=
 =?us-ascii?Q?6tFD8vRRXowhkiIYCLytVC+Lw437HdxJSrrhagyRCSdvByXCT6nkXrsTtcf2?=
 =?us-ascii?Q?QQXP10pGd/MKkxF0aXJ4dNrQr6bljdJ932rEDTfmSqF/n6WFawNP45nke/6n?=
 =?us-ascii?Q?T9DgjOntwo160a1iX7x+azuOOrNfLVtlBzjJS1NeFCBDIdJhstVDgYXWlOWv?=
 =?us-ascii?Q?ptQUkqYDmJPf3ZqyeTrFTE2WzqOZEDRXKG2wnqkV9GTrPWgPl1elpsgw8LYw?=
 =?us-ascii?Q?nf3BOJIXvcp/rY1389nDPg+NnYdhJ8Vg4dXT4P1+PXSyk4oiNwEvA6fBP3Td?=
 =?us-ascii?Q?QlIfvvTHMA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b6e6bf-a295-43b1-d674-08de9ed1ef26
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 11:42:43.2632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4O8/TbOvnG+bcZ7VggQSTTRG0AYamytxb5Q2mL+6PxFdRJfa45whCzS+eleyUW7HTeVNAdzdn931Lv/2Vbafw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8017
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

On Fri, Apr 17, 2026 at 10:16:36PM +0800, Ye Li wrote:
>There are lots of DT warning in layerscape DTS files like:
>node name for SPI buses should be 'spi' and SPI bus unit address
>format error.
>Update the spi node name and flash node name to avoid build warning
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
