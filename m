Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7494ECAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 07:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E974483045;
	Tue, 30 Sep 2025 09:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kiFYX/PI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65F6983071; Tue, 30 Sep 2025 07:37:52 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DA09828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 07:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inyZXs+LduxQ0J2JbEC++ua2zU6IVro4IVebdk7OuKXPHkT/ktxzF2JbFWkPReTwo8qbQ8eAjmAE7WlQSiP2YVA7lX6G4xu/P3ls+U+sjCO6KI/z/G7R+Ys7+zM7EBmyY1IuOApm78umsk175OcNfjF2VQF3Sj/7OPE/n4Q79Px8gwzoRJTp61XK/vKY73o1pU9h55VRCIr2DBK36oHs8FvrJ/IGokOQ3MgjMTr+Wp5fIv0oRBKAbuvqFyU6X7qEDO7aZGsf5gWEcOrsg3b/PaCcyUJgMcG3t3i+pArfxnAPSgFrrXGsHgEzSckf0eOkK6hr46Th0WN8wyG/PHEAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zL1aQyf7QCX218pSfW/a3uKQp5vCxZSTY4fLvcQqTg=;
 b=iCPFOmNGcPejx1AqdP3cBDQSWy8Ua9ZxbWNptmQGmDRfQWt4gZEfwUDB7YltnrnCp0NlGLIz5uc9bVnbXJOvG9uS+cKxViyOA+wZnz3LjFjojrgfdUX4fOQXFHVrQr9yaeELg2PgkwBkaSLl7wjy8g4gXB6urkAcRy+3yIjdajeQYO34WP8diiMTu9RO2rcRecQE/IZ7AIAaTbFCTC9EIhxm0KmZorkYpJRnhPqQc2BhiB/uSUo8SDc+X85NFlJOGZaMgduIy6wckZXn27egikOqK+MRjLuSdMzRGe8P+IHtu1hYy1PQSTK4awlg2/ZoSxTXvjUExCkoY6Uf405beQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zL1aQyf7QCX218pSfW/a3uKQp5vCxZSTY4fLvcQqTg=;
 b=kiFYX/PIFHePPRASsmfDytp/U135lCuXfXTAsRKBXt5hlDx9fTkhfyS71DkydWk7Jfj9XQchYgDv8GQqn9RhQxHe1rx0T+su1LTOfwcpGoT4+spcPPAMZmLzcx28FT9yvzx2iD5OPzWOXZ3sPGj+zt/IDmvky94tsnuntt+0vYB9BdhOQ18Yo896mmGHLZ3J30+LnlBALH+FVd/3qHqyU0uvXen8a/nOBPz+FcSDJS9ShtOEm1JiPkk0ySfniEErue2owQfBcWdGHA0ERWrjnMKgQWMLq+yD4NEni3rzwdz5+2dEHr9mTP9KD7lZFglbZzgUzV7HhOwRlwmjaescrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11423.eurprd04.prod.outlook.com (2603:10a6:150:2a3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 05:37:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 05:37:46 +0000
Date: Tue, 30 Sep 2025 14:49:38 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Pramod Kumar <pramod.kumar_1@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Ashish Kumar <Ashish.Kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Udit Agarwal <udit.agarwal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Manish Tomar <Manish.Tomar@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aaron Williams <awilliams@marvell.com>,
 Mathew McBride <matt@traverse.com.au>
Subject: Re: U-Boot PHY_MSCC vs PHY_VITESSE
Message-ID: <20250930064938.GB17703@nxa18884-linux.ap.freescale.net>
References: <20250929224336.GS6093@bill-the-cat>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929224336.GS6093@bill-the-cat>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:4:91::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV2PR04MB11423:EE_
X-MS-Office365-Filtering-Correlation-Id: dee987e3-672c-42e2-7cf2-08ddffe37aab
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CFKXnXmZzn3ASrSXNelSipNSYh8NJqnaNQLBv6tnGnuO+ZVr4dv8Bk3jpQBD?=
 =?us-ascii?Q?s97JYarsJXTdfrZRLO4G0duoQSKRgUD1m3NaDHbb3G0Ph2HyBMn1DVbCVb8I?=
 =?us-ascii?Q?zWqG8tj2D8NjqanYLuffM5bT+3rtKyu4GoNrUOjnY7w7c9nNWOlb4IeoVGUr?=
 =?us-ascii?Q?5NksRrdWvDqqY3upzNHtUVgWgamqdVYTiG57/GiPaU2OrIHPUayOF6KvZQPa?=
 =?us-ascii?Q?ZueZjKnOvw+pWTxcNeA8wYvAUQqCtC3uJojBDkbcRTaZppyVUndvfJl6IkbJ?=
 =?us-ascii?Q?1Bb1XPggExHNee/4V/22y4tCCSNpfrsx+Yg7ZgpmDzMr8wHHCS8VUOnnBZlH?=
 =?us-ascii?Q?ewWK1YP9dms4fYhehx4FRFfTaAx5zfvJYrgugeZf0U6WxMPzUVvcnJ33QTw/?=
 =?us-ascii?Q?J+Fz8M+WUvqJgApSDS4k2flfew7Ls8F5uAuWkjpzbvlpvwRWXrnbNP2i96tH?=
 =?us-ascii?Q?d2S48wD2nwymEYw+d0in+dNbhX/GeEavlgrGpBfjwbc3+W7UzJ9KTpl3ZNqZ?=
 =?us-ascii?Q?Sc0O6X+wMMEsYHBhdvvMEw0NSClKKrmyxlbU5LijQIfd/8BEim3RhGRGfUyj?=
 =?us-ascii?Q?T9lhI8Tvzm+ADCybvYeJAxRjsf90iOmw8QpzOcjPX1ds9erZW8xzrxmKrr76?=
 =?us-ascii?Q?5Y4dOQxrMTQV7wOkjZZk5kDhISzZzRhzsDrK/VYGCSb9vjL0XrG6gt8NMs+X?=
 =?us-ascii?Q?9W4k2LZ6XSfhe5z9LKhXWGB6y57BWA/HjyA6Opzx9slDfImAB9PYNV4RLXg+?=
 =?us-ascii?Q?pCin2693MjSri42HryhxGS5ZE0awfrMCD4jdGPeMvUKFql+FoUzI9dvTqehS?=
 =?us-ascii?Q?fzbep1M35lj6/sLbU7zsShQTuI1Gkd+d9WCdngYZMv+JclopZcYQ10SoM5Rk?=
 =?us-ascii?Q?UdLLPshvJLiWbEibJbo8rHbWL82tkW+pm+B6QZ/NcJS3cwzwAtsMrhWMEgEV?=
 =?us-ascii?Q?DNEWrhx/BD07PeGtyiw37D6IJgWgzDuCxw9d4vGWjRKvqBbB+kqXh3hceSKY?=
 =?us-ascii?Q?6oWqywtUxBttZ9h2XuJTnGds8yTcpfrnSMFvWUrhWwytMi/zxW8IJK4TKCLD?=
 =?us-ascii?Q?DZECMTsM8iQ2DibbmBuNoKC1m5C43pXMdDSmMH4g0jUyH/bygpFJjMfHHNuw?=
 =?us-ascii?Q?EQiurzOOXnSyYbZGPtgXqsdvQz7hrrEuN44uLYKRNw+EjfX02lGGZJysPtVw?=
 =?us-ascii?Q?2xh5SUEJVwUS9zs0TZgLqGHA08kNlZRO7zthHt1AHGSa2PMxVtDy+T1wkcD+?=
 =?us-ascii?Q?RZgi5aO+jQ4HSBAbuSnLhUX9xjR/Vmo0edbamsRTauca+DxvrNdgeEcpDFln?=
 =?us-ascii?Q?elaBeuybCR5M1JlmsQ2B4521Ia0R2CoEDngBnOBNrISr3fbOH45QJQCiOzme?=
 =?us-ascii?Q?J0wr/sQzKzK1oNj9kphaKevyc0ygLZBIRzxAqUlzbcmCVnUsWqt7aXc6tbX+?=
 =?us-ascii?Q?DBV+lrRfqGxjmtMezLqOny+MsjSFCn9Px+3CMt+VwnU8WoxdTV2yXGY7TA/c?=
 =?us-ascii?Q?jQSvYVERUExccNRPUzJ4K6k4mq1xGI8qN7f+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6BFSGdMA1QCWAZ8+QjblTTJCJv5g2q1wzLxZiJXffi0ldQrxBwxokaIe9/WC?=
 =?us-ascii?Q?LHWnYIinwIQEuO9ULi8Bjf00O3OOuFvkFvSrb5cj6EHvqgoNFvpUDw4I4NgT?=
 =?us-ascii?Q?RvS3Yko0RN89uIQ09gX+A99V1NHvVDwEmW8Q+4PJzLo2anXlbckZ5zFxbzxG?=
 =?us-ascii?Q?6nSLjUfMq8akJZiQBv6T+aTa/9QNKPIIM50AdDINdjKui/0kq4Z4XEV5yoGx?=
 =?us-ascii?Q?eeROW1TDuo2i8pnNE0yzuUtNp8XU7HiWMrl/tNJoxKYgDVhm8sh9nJYLJ0wr?=
 =?us-ascii?Q?qu3HRmKPSNMxymXVnUTfif7+MS701QgdOlTUiJmGlmVTd5539MdhNfGhv3Q4?=
 =?us-ascii?Q?1jdeCMdZXOC63zgFVXF0rXHqH+Jn7jb0c1oVZNUyKEkS4gvrqJ52KkP/et2J?=
 =?us-ascii?Q?JtN7WSI4jWaj1RbqJub05/sQTmxPfcqVwu2+IJLN0dPAd83fdCNpIyhphia4?=
 =?us-ascii?Q?D+GWxyo9m18eD2Mpg6Qdtvuma+cR4O45lvQOIW/kWPh5hlQGrpfexRYvJT2o?=
 =?us-ascii?Q?2qeCguY+m18WPW64bYpqVAvFUYfQ35SwrUJVs1OuOrIvbSrULLxRIeh7aD+N?=
 =?us-ascii?Q?2xdZ8XhwIz00brsYtv1fLIAkp//z2ylYvpULhH6Df5QHN7dwAkg1NMBPBnF8?=
 =?us-ascii?Q?7cvz+oEHQY2JeIIMoScUXddi+bsDs+Ept9fLU7E9ZlxnUQ0uNxFpEsHoogHz?=
 =?us-ascii?Q?3P0uUqvYtjSDVUCc9mu65iR7HAfLmBPtkJ+3++6kXQlA3PJDcVmyZw05vbes?=
 =?us-ascii?Q?7rh/m1xmHsViUe4M6+nyKu1Dn/t00VnVzwwT4O4p8cpDhYWjeWQKMW9Qp+5D?=
 =?us-ascii?Q?kLx9wLBvK2S2o9088+ZQ8BhHE+KYQzL5geSu7qqrG4b9mutNfFz7XggQRLdg?=
 =?us-ascii?Q?nWOkmmlGRghRA4oLP8z/x0pbzL8OmhtQTfp21VdaeH6/fCuuATH+H09P0KWJ?=
 =?us-ascii?Q?8K/aX71xPDlHx0YCVXEEhRJWs6+ykXBkDLsVkvf7pvZ8tgw2r73cAmq3+zT/?=
 =?us-ascii?Q?Onx59XLqz/QGOzigGaVqACQDHbS11En90LoKWkq06bavDgb2QAM7YOwVxSDC?=
 =?us-ascii?Q?ibskMz+qNVKYdv3d2mk7RA0/SWsYtg9toQnsZhwER4i9htso5hYq5RuRJNai?=
 =?us-ascii?Q?AKVfQNN/9EWT4ipb0O9W3czdWFEJQCHfodD0i64qgdEOcPPgOznxfWxYWp85?=
 =?us-ascii?Q?J7IfqSSOEApDe+WOujjKpxhk5DpXN6dAw69A7K3yGPs3mnL0vHSeBDgMKdK4?=
 =?us-ascii?Q?FsB95SpDkzljY26cD6e2iR0PRlE1Gr5FF3bdpscMgGZGmRbhU+88RbQBh4Ae?=
 =?us-ascii?Q?x3hefVpi1KGZ4x5HVf1FVwBu0mGYPyG+Dl95fN6sOmZzigUufuJ8XYfOvpAd?=
 =?us-ascii?Q?xx3tklxyySvi43egcKe8qcDTQVeWSFfRnFJylDgdNEv1y08fgUuofUxfUhLJ?=
 =?us-ascii?Q?lf3rHkTqC/q72MJkYHe3BvDCv8QrEUZOBzml5sA3126yDJj+TLT7qK3PxKoE?=
 =?us-ascii?Q?pOnWaJaxMgvOnjQnVBcaGBHqVg5J57iqoJDERBtQQLDMlx0179kvnix4XlUG?=
 =?us-ascii?Q?T8+R3XsKl9sMYsVMIKvowxV844R7O1xEBa19pO14?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee987e3-672c-42e2-7cf2-08ddffe37aab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 05:37:46.0080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsLNziAd+FHzQkW1xMlhls1CaNU1kZmVNIvdXepf+QuPCc0tou4mBgXqwp1IpWVYdVoSZYq/bPg145CwlkcYqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11423
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:20:46 +0200
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

On Mon, Sep 29, 2025 at 04:43:36PM -0600, Tom Rini wrote:
>Hey all,
>
>As part of working on "allyesconfig" support I ran into the following
>problem. Both drivers/net/phy/mscc.c and drivers/net/phy/vitesse.c
>implement support for the VSC8584 PHY. The vitesse.c driver is much
>older and only had VSC8584 support added for a specific Freescale
>Layerscape platform whereas mscc.c is modern and been updated with
>newer PHYs as well. And we need one driver to support this phy, not two.
>I am inclined to remove support from vitesse.c. However, only 4
>platforms use the PHY_MSCC driver and everyone else uses PHY_VITESSE.
>
>I'm cc'ing all of the board maintainers (other than PowerPC platforms)
>that use PHY_VITESEE today to see what their feedback is on which way to
>go here. I'm ignoring PowerPC because that can just stay on the
>PHY_VITESSE driver based on timing of changes in git log.

There are many Layerscape boards that we need to support are still using
PHY_VITESEE. I need to check internal to ask for resources to help on
the migration.  BTW, to support allyesconfig, is it feasible to
make the two configs exclusive, saying "depends on !X".

Thanks
Peng
>
>-- 
>Tom


