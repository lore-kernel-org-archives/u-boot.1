Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7421D778B1
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 01:15:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7797B83DB6;
	Mon, 26 Jan 2026 02:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Jw89+sv+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF44983DCA; Mon, 26 Jan 2026 02:15:55 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B97083CF5
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 02:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8+6IfOqDtrdlj9ta+x4IKn/uCzFwcX6f4kmsZ8uRaC8N+dFj+NcqBFO1LTKrLsb1znHf3PedZuS6ok8zrI7M6ZuwArOMw8CCjkqJ2IemTUqmcKAR/pvFmHWdWIpeqPMIEgCvAlbg4a63uKTcU7/5APXF81oU7ANPvaDrkI+fvzYvxJJcKfdKquZePQz0P1HHQ/Kxt6XUoRc8cBjtZ64hYxou96klpEOCfn6NQVmNMLStHLDQbaoW2j5WTJPWfdWb9hljUyj8vWQS1ORbWDWf4WZ70kwBZvICd9jHCmE6iEbRECT6SByhCk+celZ+K0c/E2eLReiZ7DkKNROkSH/cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rtFfm2el9JX+toPBNzFqBUAMmDUIzyI24T3P1+T2D8=;
 b=zTSHjt/bSReElMtG61AuUgv4sFAaGk389ZMLWJlUSM9mjZ3asuNwp3ItED2QHqdHVGU+ZY5L2YQHXHQMXmN57eYQfYJvuWi/DWQ3AAEeRFiSBbNxSdJAawwALM2friKmKm+H3MnafbkFGEuIj7MYb+szzdCVMrZUP8SPTCLpOUc6MU47ns5mqhH/36ylrAhHiL2jcNxt5Ixa3NjzDG3wq0zubyG1AQqgiMDTHvS5dGa8mzSmNL6iE2pNk2fDn7M/sHn66He9rDxhJdqnaS07QeUj0L6xeUU1GocR8dsTTU9XKGjAOYd3DYMnCFZQOuvESEBHgPk30jmXbyo2insTUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rtFfm2el9JX+toPBNzFqBUAMmDUIzyI24T3P1+T2D8=;
 b=Jw89+sv+IxGF1BFGWJcLenIOtRDYMBZdwfW/L1OIVbTSoaTtUppZUhOmZvfqEgOi0V9BmTDp1AfwTGLGcux82V82KbV9GPcjeu7KKOp55LkdR7VvuTPZOq1A4Ghdff2CduJ617mIK1R+N/K1yar5t2QSYQfdkc3PjuS2WLGfny6GGvKKiDEXtXASp1e91PHG+fnnNOUT0FpZjSpT/5YQJXxo/Abor76TfR+ukytF6xenPbV0vdMwx/R88kXevK+MNKGjAThG7XImOMIik6/2i6Jy27uPlPvaqDkFaQDx5KIFpx2RmOxp5lnIwywV3tXiV2CjNzCIMYJmBTYgsPmx4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GVXPR04MB10779.eurprd04.prod.outlook.com (2603:10a6:150:21c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 01:15:52 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 01:15:52 +0000
Date: Mon, 26 Jan 2026 09:15:48 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: Re: [PATCH v1 03/11] arm: dts: capricorn: remove pinctrl_usdhc2
Message-ID: <aXbARBDe1bwmEFcS@shlinux89>
References: <20260124055452.8799-1-hs@nabladev.com>
 <20260124055452.8799-4-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124055452.8799-4-hs@nabladev.com>
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GVXPR04MB10779:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e069566-2cec-41ea-549e-08de5c7872d3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qGWaFynC8RSOyN01OV5kYKcVOMZZgf2fX1xzmwY8WHmngd2tku2Pv7x/vkqS?=
 =?us-ascii?Q?QFWk+oD7pZkMtLtBmN8pgakfWW12rcTORXvkriLjv82mF5Zn4IIOPCWOmzoB?=
 =?us-ascii?Q?b8MZOcuCinFtC8y5ycqCMUQwsXsqAg6zvI+4UWG/RoNOWFKVxu6uQWULZFcw?=
 =?us-ascii?Q?6n1ZwYCjyiEEoeVUOOlngwMt9toe8DEKp9n7TrfEFLBumYwvOvaBG8IOLjDP?=
 =?us-ascii?Q?J4LmBiGBTBsEI4gSmBnUD0sjGX65P9BUSsVjXNg/IGFbVkBrnh7m+6nStBFv?=
 =?us-ascii?Q?G1B2PXrjatxRz+Adj9yRbK23q+g+z0PCPAndC3Eft3SF2g1Gwg05KSHvK8ss?=
 =?us-ascii?Q?rjkOmIsFBPd0cp8xh786DHGxS8vE96u6aKfylutcYd/0ukNRYTF4rvp9cTkj?=
 =?us-ascii?Q?vjirnAGdIZN8+yAexVF26nhOh+O6zRdl4X3iHHfs9YWGhKk9MCF3rJzMq0js?=
 =?us-ascii?Q?IRZwTwfDzkHDAnnDKdAPtm+OTIC2sNae6n0MKT7PQMGgRCLANmx4WkQbchB1?=
 =?us-ascii?Q?Ui7uNc7PrNRGQhFuku3ORJVbirSBTAJoEQjUdROrnkpwkwsbQRK+ECFZTTD/?=
 =?us-ascii?Q?IDBUtED/xR4AWs/WpboC1mMQ7rwUXspnkRQ1IRoBtD7Zlf2+1Tsqo9r828h2?=
 =?us-ascii?Q?MH3iC7+KHEjZfpUc5clQ29Phc6FIuLnuWiP0nkS/oFERtIKwey6H+RA2P7J4?=
 =?us-ascii?Q?XWbKmi3sli3Y2e2SuFjFJbm7rxzZ8ZywiXipYyjdCiLLNl5K6gTVfFWrWXLF?=
 =?us-ascii?Q?hQUvvQAqDhv98R4POkjOz/K6AqajWtD+HbyOQdV5wFK7lHIp8OC+O37+XhM6?=
 =?us-ascii?Q?C7j74DI/I2agV4VAL6aFAFFbS3ID6dikeqaoYI0G5V0PK9bqdsL6KoDGwg9n?=
 =?us-ascii?Q?A3SKzfKSlt3VDv9e1TEg08NARWW/ODK+L1YMLXzcGK8hYt2e5yAJZjNzy8nU?=
 =?us-ascii?Q?5Vg5cEnanqYdZFJv5UadqivNotD2OY//ZFWz1YLIj8PAOOmEtXCQUoCU+YpW?=
 =?us-ascii?Q?ZJHpjKkso0gJ3cOFAaXqDrMH3Y+WMdXQVcByx7UvQDj3CVrsd1vKuFYrjdBb?=
 =?us-ascii?Q?3IFjZoa4MS7ch6hcn/vfyXwhlvpplMiJowIeAAmweMeoGTrzMe9xtGhpflQC?=
 =?us-ascii?Q?b7quyDRc1mT2UYjtPPSUnVnybnsgTkJ3bkxFuy8oWz3cpTXMbtjFwTQRS1uc?=
 =?us-ascii?Q?8t7scd6Nl0scf22fzN4xbgUEiwEumPgq22ePb7Up2zoyXHtzEORAkP/Ah+KB?=
 =?us-ascii?Q?hXjf2oHJ7fy9WKLI/8Z1To41jfXr+JQY1qf7bhK08rLWnbO9cIVdfzLeIrXq?=
 =?us-ascii?Q?9t8gK96DB7eMigpP2UvvsCEZFLufxSJEr639vxQSTNziEwR/zTM9ogDqfWHs?=
 =?us-ascii?Q?WgOj17sh9jB1no/IQNCH7V8UGSjKMe7lsSTblJL4c+hmOL6zpBsrC+sGEqbB?=
 =?us-ascii?Q?Kol1i5aFXcijUDvLeH7O5n3sLHbs33IFFYgnTl6m6ISNG4Ei8SVMAkrc8+Ll?=
 =?us-ascii?Q?gUMCdvDzpnneQuRQ7So2WQeTPw9BiTaFiytzvDi8IBWYb2tDNPuvn4XC2BQz?=
 =?us-ascii?Q?CWqN2t3fCy/56NDwFGOgIJD3Xl6H3AEvmnDDKZWXbHABGaoFQPerY3O1bSWU?=
 =?us-ascii?Q?6Iup8cbVc3MPXHcbk8j1oOo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wNTFz5DlUI6CnLLdA425GGaSB7R9Fj+T4pqhx/sdOL3SP8OAH1EuXu7AfhYL?=
 =?us-ascii?Q?pDPRostQSutam8Hh3XGwIVSUR/DO8Kg05+q1yGcnTp2z2bH3k000l3I+n9Ig?=
 =?us-ascii?Q?ft4eonR2TzxbUUvtEgwh3cWZySArNEzF7KW1CifWl2PTxelD2UtENRoFOAPQ?=
 =?us-ascii?Q?PT88GRAgI5/vzfK9qZXwu4xJjuycbkZh73hi4lTlyj3Ek1c7b7Jaq1Qz8cfN?=
 =?us-ascii?Q?kB9yvwoeOEBg0JCmc9Ks1syR+Axa+6ykLNa+1zVHYAeI/4w743hiqTszlTPO?=
 =?us-ascii?Q?NvaEvIi5IK5DfIdp53tbNRjdUCJq8c52cAswCgPEdx0Hck98/CXR7wR3XRKo?=
 =?us-ascii?Q?2LbVqQRNzVPxdhs8nqTH6Dg22bef5unJ9diNpJpHS+JYDCDYulCKsL43OwBM?=
 =?us-ascii?Q?HfrgYDtE1eF8JQHyva2jteXtJhwQDEgDXIVfWbwIE8HoUzXNL+bPi35e4qNL?=
 =?us-ascii?Q?6lEXFB28jpo6vP6ZJN2YuUlOIfTqVMhw0sIY39Id/Ft8wGxrt7dqXrR5QlZh?=
 =?us-ascii?Q?IEFYA12sZndO0ATK4PB7KLN0Hrjiz2Ok7f14XKAyjGGyBNLSSaK+LwN10QCn?=
 =?us-ascii?Q?1yTcCTmeJPGBhSjy0LDWhe58e+1SXBziquc1Bv+pEw4we5+FCf0qJyVt7e7Y?=
 =?us-ascii?Q?GJ/dVFrHUJ8H2rAdnY/LvE5PPLlq1fTcv3aJSO9Sn05DEBFu8qrO0URAtWRv?=
 =?us-ascii?Q?gquqAEqZXlwLhTAfH21MrB6a6BKMtEOzC0Sx4E0Bq5XL4Vlh8k/7UwNwBttX?=
 =?us-ascii?Q?/GFIG5KbB+ROoNZ5uG1XchdW3pefiYb8aQq2a0niZ3jTqnpeO5pUyxDpWO5X?=
 =?us-ascii?Q?vqhT5xMYH9kDrSYja3+d0ApAeLWj2VTVnCb0reKQAkYKKhzKMgLBk1xg48ln?=
 =?us-ascii?Q?CLwgUCvaHQhK65+ikAGkcrGRR3nYbJpQ5aQpPDTXeHLjOkbnwfiwzypsrOSi?=
 =?us-ascii?Q?UZSnK13TDmO9UQq2dvz62+z4RbY1bG51sJN5w9MvxTje2j2xnSxrbGwjBXuP?=
 =?us-ascii?Q?r7gpxjjKEk3CpsY/yFBUPc/BD+EJmGsi3kzR0BeuNlprrOs6CbXB2zBnHlFv?=
 =?us-ascii?Q?+2CK+q+V3yJY6g1wGE+k8Trh5pn847JtIekrQDeU3hvz6+gHJ6L3w0wy8CXU?=
 =?us-ascii?Q?PygHexlOHkwStIdJYKCvajFhYsJ51CH8VCQbNhOFBlzgDrOPlTodlJ0AXMl3?=
 =?us-ascii?Q?eRD9EfHgQeA99EB6xY6uDdWZrSU0WEWSHkJ56E3MSl5AXPPukL5b8VVQ5oJS?=
 =?us-ascii?Q?pfpiPU0qcoDnIZThE1tBFV7NLU20MeCf6XpuFPDr3wMwKPAJKLpyP5EzH/Ec?=
 =?us-ascii?Q?Cb+dCtyM+ueV8VVN0nOhLDfZticUVihkpoDN8zloJaA1Kw11vbG2491EvzI7?=
 =?us-ascii?Q?dSCedtP6B8nV1STVqdQd+RtNu8B9AvSURvT5y9DAU9//wxyWuckjrywQI61f?=
 =?us-ascii?Q?GSKzleB3XyDlkzBCGYSbZQDwkrFagOwkEw1zgOyTzX6OSf2LvTLhIhzAuQWX?=
 =?us-ascii?Q?jraZtPwtMRSDscRIwUGYfVCotJggm+ilkAm2kN/BtjjqQzktrJ8Ma+MG8B6N?=
 =?us-ascii?Q?+5gbSB+yfdlWQVQO3MnX9w1XJCiBW5YgHa2S0zi82j/Kwx7TdiPedBrvuw+F?=
 =?us-ascii?Q?EmgFnYlvDdl9SvPuLdLfd3lfTliKolSDsAogLiaKJqryDKuOF3KP5Bgr5o/0?=
 =?us-ascii?Q?7sVtUwDy3sQh1dpO43htBEigTdC12zwTImmADzCKGMWnbns+x4LBcijcIDtE?=
 =?us-ascii?Q?vVcyxByTww=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e069566-2cec-41ea-549e-08de5c7872d3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 01:15:52.6646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HryGnquH0jkoJipW2DTzZq7H966ouBqrHLw8L182/iLLOvLswnzTVG2jaJYZzKqcYB+3q5CGLCgheMTwDO17fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10779
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

On Sat, Jan 24, 2026 at 06:54:44AM +0100, Heiko Schocher wrote:
>From: Lukas Stockmann <lukas.stockmann@siemens.com>
>
>usdhc2 is not used on the Capricorn board.
>
>Signed-off-by: Lukas Stockmann <lukas.stockmann@siemens.com>
>Signed-off-by: Heiko Schocher <hs@nabladev.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
