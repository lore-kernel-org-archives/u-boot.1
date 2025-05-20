Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44FEC3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 14:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B70782C2F;
	Tue, 20 May 2025 16:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y4FU0Nui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 136AD82C55; Tue, 20 May 2025 16:24:08 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F9982B7C
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 16:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pz+bXYcTyiCH8VyixFGIIZ1GFYHrCLMxcI4EzEw519P8VvnIkYpAUM3uO3O5TUDwZ+lktjxW4AO2M7eP2MDMRliwbcXK08UAkll3YSLYm8i5VTjOnNnHb7B4jmltJt9XK23ap9BpPl6gL1Keo0o4IvEdZexfqnAxBaqizBNT6VtcoX2xEgHajJif8dhAmkGUbnuKSXFfRlK5EPgK8PefdwD1ScylHpqhfq4RTwXiOltOtbCaflbPS8iK4e7pBxjBRN0n0ozLhJod8mxWb/QxQveS6HfVlbeCLwF7y1qlXVasINFfIcui1rOUalVImiZok6pbolsNXt6kLUAdR3mBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WAV0KU+EAfCeN5irKUYCsXm5Xjd196v35KnkNLuduY=;
 b=ZHnnWtm0uGGwh7KunOli2f36e8IZAzPYH7icqFpkaRZez+KDdD6Aj+5uUtpn/I98+RjPoYqloP966TCe58i68Ayjx5ALjVjIFOjdNPUiJcFaophqoEI0rFNjcQ+d/L7oOEaReJrRd1xQRxLHLqHMhVN6D8KbzvouGAt+yyDZplSaCFwo7V62h1YXeW3FBacFe538ogiAbyzQUGF0C5G8rHRzlVUBv5puoW6pygya+LNg7N29uXbVIPd0CDOIAqZVd7E7WIBs/F8HtRUkQfmgs6CXGYPumjDKYVycOJd2VaF6U2HwQU5Lof5jZK3BcBkyGoZ/IDfOrL3e0NUY5hphgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WAV0KU+EAfCeN5irKUYCsXm5Xjd196v35KnkNLuduY=;
 b=Y4FU0NuiovfIdN8eDC1d5qlg7Y9gb7QXwjxQqEqOuBEuoAFbFRdS63BXF/gf6TMftnXRZbYwDwGs5j4XG66n8nF3+hx/qIfqIePeu2+99NifCV+N00QLQgJ9bD2Z3Kqjh1LyTR8A5Kwj3FuPb/3jKEY0lYYOA6HKQcEgp1HnAIMs9QZLS4RtpWLnRIgEAiCg89rEKwYM/bUJ5St0hzKp7eAslOhz4KD9/lPT57nBXAr7fDVqMppcsw32VIUXatdUNk5iZfycVbJ10i5oQl50LX7xGXNoco/jAY7i1MQCuhe5Mm0ysKVH5dxP9SDIoHH2931aYDLkP/HDAJbZTqtUIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB6879.eurprd04.prod.outlook.com (2603:10a6:803:132::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 14:24:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8722.031; Tue, 20 May 2025
 14:24:02 +0000
Date: Tue, 20 May 2025 23:33:36 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull mmc-2025-05-20
Message-ID: <20250520153336.GA23450@nxa18884-linux>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0c1369-9157-4b9f-10cf-08dd97a9f831
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WhxOcdT1vNmj1XNfqOJaZ0QQ21DRChVoJ/D+DiImdUbetEN4mh88N4qCtmrU?=
 =?us-ascii?Q?9S//xaEvGbtYjOUwPa1wfTXArXT0fP08/iu02uINgJzkk+0unmJzmGQxzyoG?=
 =?us-ascii?Q?fbP5kpP6CgxTR7AWJGp6T5BmPuPQb5B1rhrDMltk+rzrIljVa8hsQHUpzWRE?=
 =?us-ascii?Q?ecf/vjhdHa3jbkccCY0Mh6bIdT2s+UMXypEpeYj203lFAPcAhjlQD3I0Wfdn?=
 =?us-ascii?Q?ckVA9himxdkC+6WK5P/J9NpJbis4mNay//yyzXEqxKFbWaBx4+G4YyjH5zxS?=
 =?us-ascii?Q?7Skdm0c/WeMH+MRLVwSrd1Lr0pevgX6fNh9O/D5lrwas1zXEuqaQwxwX+FyW?=
 =?us-ascii?Q?MZT0VFh5JN37XMT6MFTsnlHBXVWs6XhkTk4MxffMyC/9sqiVMlBExBszalEi?=
 =?us-ascii?Q?WEB4ANEG6M6W7ukIbiR8UHF14TDHgQj5aFHBW2JI3zIR0rjko9GNm8gVQ052?=
 =?us-ascii?Q?jPdf4PzVGVfO0+fHDf/AfUI4F1qiL7gODpoOHU2f77eLR/8raM2Kd74+bhqx?=
 =?us-ascii?Q?+aAWh/RV5MnKTPcNbnTzStBdSrcHQO95k6g+zhGLO+VqoOqSxD4DYV1RxbPJ?=
 =?us-ascii?Q?jaZ4qhSzlKZJr9NeI2JQk5tLgjlugvp4xS2vir9x0adFckVrh10z+fq6j4rR?=
 =?us-ascii?Q?8YxKgecoUwa8ayQlC0bYcxFPXL5k+QmC+mh4tiSFmY1E4fPNIVcKHKzQ5GXL?=
 =?us-ascii?Q?8pZEprZuIYx65NJryCdHR4Ic7C9xRQ2sOG1jJwYuwc4njErdFFyF5UsSzdPL?=
 =?us-ascii?Q?0QvjrnuQIZTbxPxAeX4m0RFQY1A4+i8cPspXBOmvRxw3IoIm+Nscy+cEe4Kp?=
 =?us-ascii?Q?wfX9w0eCrVPl+g3qs00YtVZjSTyjd/sZcRJ7Dy2L+ZWfgxHIAdLNu6449Ygn?=
 =?us-ascii?Q?yfRP2hxemvSIQGBoPAgYLjmgc/EkmPJAJNUhbZ01nKm50y63a5TARhkHshg0?=
 =?us-ascii?Q?5PaY73/vHxMuQ+b/uieIKjP3gIRqeBbobAw1R13bW/bSspGvyOwPTTKyFSFn?=
 =?us-ascii?Q?EsxTF3UVwIF1hSJ9yfUu6+yTdLdNGO0q5wajtacU77p5TuU633EyyBbzzePa?=
 =?us-ascii?Q?SCgzRhprCszpGjlOMxTrZb0MXkTDngtCYOFQkvEPhOa8ULrplF7dZmaOLstr?=
 =?us-ascii?Q?hLWevyhzA48MBueoK6zJ7UXTL/XW/+7gnH/klzZjoNJS2u7MvyBDuSTJHstT?=
 =?us-ascii?Q?BZs5FZyog4b2s205apa0HYj2bR2C86/ktzKC7t5ZfbkZtI0u1hfcIrC9OslH?=
 =?us-ascii?Q?4n9qH5mIchMJ0RPFOE+Q7gkIzTrerEOh9gW6ORDv/HmI8Tpz74eyTlQbYOJn?=
 =?us-ascii?Q?nZkyIyDxssiH0AM7ScJMiyg8VIb6R8ooaDJ2UHwOkFoXpw9Q3XXS7zmJXMXJ?=
 =?us-ascii?Q?eQXWPKhxTM3wuUcjCGkVusOUIDGVdPg4NYSG4BGFZ39D+cVkVDevHnQKcfye?=
 =?us-ascii?Q?whg5P1gu/+o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yM9Y5CmVMmxLkkyM83hMU0dEv46YqqSTIZD9Rc2sU140fZWGZwYaxSExlSFw?=
 =?us-ascii?Q?6wA+qyK1kkci6Stcz9LxjWwJxTEF3xgJDlBR8xDo0zlrqYBOk2AJL/gc0xns?=
 =?us-ascii?Q?YD56nNFPR2ZRj2YCtDdpG6x+KD1GAt8FLbDE5vaujWRyv6irPJeQ2hXC3WxF?=
 =?us-ascii?Q?0MRql0ajw1BKLEyh2aIdpZ9GjMoO5xqwWUNE7bwZ3AhAts+MUfvQALQShZJm?=
 =?us-ascii?Q?Wf1+y6Nle8BCUFvH0OsKd6UlVA9BjbhyySIdlM94o7QdxhLynzd3ipIP8JH9?=
 =?us-ascii?Q?/VxNuqLHJ7tzADrp7grbMSjdmvFmeZhh4nvaTuyLdy3ojy4ZXYApMFiL4ZvA?=
 =?us-ascii?Q?FHaLaymp5/xowTrxrMLtwjB/grOk6ee7MLomRKxJK+MhWep2LDEfspIN7hMc?=
 =?us-ascii?Q?k52YFAsed0E+C/8uKPm8SPN8Ov+a+cyiNd0D6y9bI/t8jTt/YaRZf0kNB0Iu?=
 =?us-ascii?Q?SvwrwxGfZ+bPEp1rKHhXDo98l2RcGdRsqMJrcybifsQfuxiTYxccT1BConuA?=
 =?us-ascii?Q?TlCOEAAi8sHkSVRqg64nj4Hvm5OpCZmcOjNUl9JcCctQ1ilLwH2x4fWDo9AO?=
 =?us-ascii?Q?XCUYICXkK65OMmCWt9ZoWDkkbTdX7OzjE7sCWGfOoBAbgunr/fT93fTYjA2K?=
 =?us-ascii?Q?bCsr/f8tttTe8d7Jw5yhEvmJM6rsSi3ZgdOxg0RTIwqMVNuLL/o/kcFBWNFQ?=
 =?us-ascii?Q?652MB6EI2xs/X4pajeCQGcV9LFS5yo4eBwy3+EX2J7d9828cdeol6Gmf7MqG?=
 =?us-ascii?Q?8bS74KzEI+6nEk1w8IPiPjJi5COUbrT0VxqqNzBzPH1I3eaAqvqwmVqQRhrf?=
 =?us-ascii?Q?mh6hOyjb0Wz9F+XAyQlh7hjxEe+YYJG9ojfTjRWnAJERcGA8zDdPhkMfvgHN?=
 =?us-ascii?Q?63Py2q/ChmEwU19WifoymaBEHRg59UnkWJHDU3SVYPn3CxGhtY+mE2PXDeA7?=
 =?us-ascii?Q?TSg+z5I6Sm1zuMXZwt1zRL9CPVjdS5q0guuXXM9aPo8ND17QsLINsk1V/qIQ?=
 =?us-ascii?Q?ahoRKaScbs+5TqHO+IeEXfWczK5jOAuc/OB6wZGH+GK+J8n2LiUCLCTB/z8W?=
 =?us-ascii?Q?hzZyAu8L5E3GoN22dNjkm93iKPx0URlAGcCnHVLjx9+iouiU9Kzv/+x9Iu7e?=
 =?us-ascii?Q?3+ztoklLZHHliVyasNnSCzvC85ARnGQ/oE0WzjYnf/9UnKJ8p4fz7hni9C/d?=
 =?us-ascii?Q?8ud42HPktB61DVxA7DkMgB0JwkxUp/J76Di18JXFQPBMh+x6w8baCiP+oVfi?=
 =?us-ascii?Q?vubNesHFGamEpdiItlsgorxzFM3oANAriDuUVTN5gNH4VdbhBONvzcw0/Xf0?=
 =?us-ascii?Q?4BZ7k/Ru8f5vgY4H1UrCn/BxBGcTyZ/ar3UQnp3QfEI4fHl8GKtw2n0NWZvc?=
 =?us-ascii?Q?DNjLG+J4AX/7fGu8MVR9AJz5HHvD6dd+ZOiBtpjc5o2tkJvlm5WLnYhxJR1A?=
 =?us-ascii?Q?sIf6ICM74Ddhj/Sb6SOs3IgGpSa/BE7qs0YEWbFW4/Kzx5ClMdM02hayq7AM?=
 =?us-ascii?Q?LBK9xNilvi/cNNkZvJ4QBbw31+eBCnOiTw55YcCdEwS3LTHVkRwLfX5eqznb?=
 =?us-ascii?Q?wycwVuRPSSVsEJJ0DAURr8misk9Il0qyEzSqD4j9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0c1369-9157-4b9f-10cf-08dd97a9f831
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 14:24:02.8072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73cAEXldPb7awzX8/aI/wyY8O4uZie02LtE7AT0WV4TzkZgVdFFqi5mA88Q2FV+b3i8G3FEg35ee+0J7qxdPXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6879
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

Please pull mmc-2025-05-20

-------------------------------------------------
Fix mmc cv1800b build without MMC_SUPPORTS_TUNING
-------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/26241

Thanks,
Peng

The following changes since commit eeb5ff1a468b2303efa9deb2483b5edbebb568c6:

  Merge tag 'efi-2025-07-rc3-2' of https://source.denx.de/u-boot/custodians/u-boot-efi (2025-05-18 08:06:56 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-2025-05-20

for you to fetch changes up to 72ba30aeccfc225152c19991732228f95b050ca4:

  mmc: cv1800b: Fix build without MMC_SUPPORTS_TUNING (2025-05-20 23:11:52 +0800)

----------------------------------------------------------------
Alexander Sverdlin (1):
      mmc: cv1800b: Fix build without MMC_SUPPORTS_TUNING

 drivers/mmc/cv1800b_sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)
