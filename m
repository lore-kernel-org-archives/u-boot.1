Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6A1CD5BD0
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 12:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B0884704;
	Mon, 25 May 2026 14:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kgCvbc0R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D312A844CF; Mon, 25 May 2026 08:11:59 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC188405A
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyoVNItFPZpGSp1r7ASYgsYQVurKO1DMVh4fxPyh+yNyMxV2wld/cuPWusPDKF5TcpweMZ1W43XneCAaAHHOcl8urhBWU8aY64qj0T8CK3mMtOpudaehP0vaBRvMdnLCQaqweURLEElNrbRRBI3XA1Ckki9G6/cI7DygM2FhIQhLd4zR34u120gtKQ6q1OalWyN97fZrxHFYWryJAeJM4y8K85chlnOOX8So1prgsTj6Mrjmlj+EIXKJVZQ2dkOhH4rF+O2PzE8pfFopHVCH0GjaiAeYskxwr2HXo8lbgLcXx40wBV0qZGwPomzXKuzVZZaa/gYm8kzGXkW7sn4HMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEVJYHLhS+F4pRI+6LLxPEBl+Q8aEjh0oMJkzAABLnE=;
 b=ityX9XCYdxo5r90nwFxtTvTAgz4kwekwNEh+bqLQFU5ishmf/iGg3OJ3U12nELO3l8hIctWOweYgPCBKklj1l5QLOT8eb4VrJ6M8mgXOgpRBww3D/lD3uN8MBtpzfuj6ahqTgCNZ0vgg/BTo7tYZUDyUA5J/84xtVHFhpBpFOzdv6FzDN2ySYQPUoS/TgE175oj/d2vixL9Oa1/oZWXZ6AG5BznIBP09H+wK4iWwYEnjqIcBPvbt9IAIfUKsCjEKrpFSHyFkPbBvZk6czLeTE6NrMKTTbVCjfZiaMknZrSTJAx2au2aJxX5Sx9V1iPCo1+pDZVYvyyJhmNkjFR9bxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEVJYHLhS+F4pRI+6LLxPEBl+Q8aEjh0oMJkzAABLnE=;
 b=kgCvbc0RxzbyYCXCqeCT4iFFOE0Dv+tj0dGT2lh79VZIK7kAMEsQmctzO5bTs/PQ34Lyw4emf6cH5cf55YHFe6tqlESrKTgApKjV8be64HzI3mEMX8JnRLLC/ODbNgVCS0WrcLrcU5fxDXsu4CeVoGvvS49nKSETKLmC1nj0vzMX8S2C2AjVsNO110JntLH2Kx6hOMqUJT6slt75Lurkoe5Fgr8dQvDXShCLba5/p84qza5yGO2PduJaeaMbNKGSzBE77nbFBAchwJD56XdyLA3AD29vF4jrOJVRm5p4HouPAp2cFAnyB9eBE2J9fQjAafPCW6C2WczvbKyOpZwfVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV2PR04MB11797.eurprd04.prod.outlook.com (2603:10a6:150:2d0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:11:54 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:11:54 +0000
Date: Mon, 25 May 2026 14:14:40 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joseph Guo <qijian.guo@nxp.com>, Francesco Valla <francesco@valla.it>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Johan Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 David Lechner <dlechner@baylibre.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>,
 Paul Kocialkowski <contact@paulk.fr>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Brian Sune <briansune@gmail.com>,
 =?iso-8859-1?Q?J=E9r=E9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Jacky Bai <ping.bai@nxp.com>, David Zang <davidzangcs@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Fedor Ross <fedor.ross@ifm.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>,
 Simona Toaca <simona.toaca@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v4 8/8] imx: Remove hardcoded watchdog base address macros
Message-ID: <ahPo0DPJRZ6cPeUF@shlinux89>
References: <20260519-wdtv4-v1-0-deef133b81cd@nxp.com>
 <20260519-wdtv4-v1-8-deef133b81cd@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-wdtv4-v1-8-deef133b81cd@nxp.com>
X-ClientProxiedBy: SI3PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:295::18) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GV2PR04MB11797:EE_
X-MS-Office365-Filtering-Correlation-Id: 873d7799-bbff-4f10-4474-08deba2484b1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|376014|52116014|1800799024|38350700014|22082099003|56012099003|18002099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: LqBIZZg8P+0j8wsBjAxqHop8mVsj0UGj4TI8tuBErIu4A6F7mCVMhfWunLaI6SqmbmIelzTHaYOFJsjDFuqP9hgpfwMiGLJUdt6nGzofdxoeHMgnXvBXZe92zYhZWO25HHcxgxPLXgq/VWSRFp8fj8lgqPXsCu2xNe4UcoNWKRv2ru7OTQ09knAmtpPGvfrm8KH2bMYhJLXWGprS4qOHgRx3cw4ufZ8F8xXwWWyVd4bC0NVBTReDeA7igjqq68OoCj0qRWv/jajCO8xKTTFwHDX3ad9YbM8IMjdXyhK8/EsnQECuKn27i39+YCFdNfuHTprSV/x47nb6e0i9ejb1gEbjbmTXdaQiPyqKDstwGuxl5iwbm2Oj4Ohz8B3x9opSO/I0tN3YmrZMizf+lZ+UyPY4eN2DtJycJr4cttwbjvyZmwQdcTyShHNvIvfgpP7UXprX1rYcIOSIcaV1ymtnBbLEHs9Ej1RAiizvb+hwxnM7CCjWhwL1yIPuXf06a1a+cBx1kU3aVkhh8FA+RIOiZwM2ISnuAgZd4cKPc0zx3dqDvasTqA7KYk4lXlMOx5Ye0ZM5rYa7VlWtPJZJCqw2/2QYRnA/iDBuFpcUZRvuDsOmGwxHJeedjIHBOMBsLc21Dllw4c3HRqnOZw6SwmrJN9DlY5PlYrtRPWVIuvc8Ra00S3vJetABnQEE4uKe//TgG6aqwiUxbMDoa+WuvF+WkQ36Fq4lqDoVsVl11v1kcG5bWPcyPa5RQuUQRmiDxBOS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(376014)(52116014)(1800799024)(38350700014)(22082099003)(56012099003)(18002099003)(6133799003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rdMUEMo6OsUuxJe6Rt0BoQqBoh+7vMCcfALxRJRQyr2yvLNMKWhcbWyDhNAd?=
 =?us-ascii?Q?uyosSwaIB8PahtB27ud6rkP0W3uoHdI8jIORERnxVOvO5LqZIf4yLQRSU63M?=
 =?us-ascii?Q?VSgOez/h3gBrqCrAu1jJSyov2ymitUyRS6P7cKoTvGEwRZ/PuruCPkcjeuaG?=
 =?us-ascii?Q?d1cr9YD7XWrYVLSxUo834QrBM4zEmKWuklbZ7owCWpdPEcxCnRMHgyjegrdZ?=
 =?us-ascii?Q?Zo/SJgXk0ISe67shY3q6h/iD/gcIvdnJWhEdE7JTZ/ZRNhgNzlpDxGrHc45t?=
 =?us-ascii?Q?VLyZ74Ivt6HoKGKTcFbQSAfYK0TC9WQry1LmQwzNn5YlvdC04bXIC2nA/AKK?=
 =?us-ascii?Q?3NLXZEZPLKjzj1UjPCypQt+QlTH/QKeiIVhUpvhF1HGGMJI20IKxiAFpYX2V?=
 =?us-ascii?Q?SeiwHNzTf5ktic85ah2iOFMEKFGWQF1esMXjFlgky/sUgZRGUdnHcZ6+IGwl?=
 =?us-ascii?Q?QtR0uDnS534qormvpCwO3nXNJw32Na6dPMUA7chL5FbNVjLYJc6MIdLv0New?=
 =?us-ascii?Q?b5ePeA2EamKfd8KIK4/dMIvUtm0jdW5s7W16D/XXEHBGOhS2UN02F3FOQreY?=
 =?us-ascii?Q?Y8s7aMtI5a9TjVFbWA7gKOGF2RwAc4vs4pPvzWeFTg8vDcFiaMciSeETEAPE?=
 =?us-ascii?Q?IFb0dVN4m/8DSL9Urc/FcbRb/BFrytdqcTfjGDpOMQtRweBfrW8q7VCirySY?=
 =?us-ascii?Q?+pOq7vTokYsOIAYuVASNjG8oJ4/mYY/DA5PIsjOkjSsbV+UuyAl/tnADkp9v?=
 =?us-ascii?Q?a2bbaQzpJjcABTk2hnlizpcWCYj/ktjBSkfIpIvyinUhiVzxvsIGgqepXttn?=
 =?us-ascii?Q?7fFpvcqoqTkHfvPf83m/wopouPlc1pZzdYqqkUAlg75NtP8SJ/pyzHTKZPhh?=
 =?us-ascii?Q?BpjhTHLWPMWkBwYIIurXRInvLm1ICH7vx+Qjy4O1Yc7mkeUUHCfhOYSZMVq8?=
 =?us-ascii?Q?Xue5/SGQOJyMSlZ3w08XzTlmrIyQw9MCXO3jV7sigjaEVCcNrOHjSbyzofmz?=
 =?us-ascii?Q?apPaA+MtaeJZBJyZY8Jg3x5ujncc3jthBi4MNcdgwDbs+CBTRV2F43Fqw7rR?=
 =?us-ascii?Q?vePvUhxvWuOALUp3XB7bH9jb1CojyW6SoTCL329RJUPYmpqWvzaFGwJL8Mjp?=
 =?us-ascii?Q?4M3iqSS14SPzna20yLe6ybHyjloH5uaqexiY9uWOfspDGYi9TgMMESrAZR9b?=
 =?us-ascii?Q?yDesxyyuL+N1v5DogHwObvDHPemThi6MxRN2qW7X6GuJOP1vigcK5hvpjhuG?=
 =?us-ascii?Q?baz/4QFKTZzB7jBqrgWBS7m7hIOZl/xPIPI8rUkA+K/I4UBAWXz1du977fj7?=
 =?us-ascii?Q?PsPvuAbYsDFMO8oDf4skIPK7on9nQdNP5YswyjZmg3jMslbLa8EWOxn2WNwR?=
 =?us-ascii?Q?SQ2qvGzLj5JKOx5pGzBhjw7T0NmDCX66y+r6UH5fKzfqs4D8ecD05BRhKoH0?=
 =?us-ascii?Q?FYNFWiXWKIABlS2BPPve2rbWfQ83MKnBzfieUOClmrbB2O+4lH8iGEDBwamm?=
 =?us-ascii?Q?5f9Iz9M861ITsHlX/QXMJlSN6mzJePtXAMlWsyU1Esmn5mFXons/qqEtlhXa?=
 =?us-ascii?Q?vjH2SbrxL49ozocLlwZBzT88Mo07e1AAv74l+J6HN2vxjMyy4ZFMic4bac56?=
 =?us-ascii?Q?SeF27i+XgiXqHFtNsEzk5ES/BMBICiYM2glblTfHP9+VT/GF8Nfc60FN75sk?=
 =?us-ascii?Q?VTbBdsPfX5QfNgAtLyOawW8y8/81cwnJLi2n7ElHX7PLHokpJ84pF5N2DP8Z?=
 =?us-ascii?Q?6SBmKV5FNA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873d7799-bbff-4f10-4474-08deba2484b1
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:11:54.1964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtxRsl2rPnaq0qltL9ejMEpIUuN4U32uTXg3vpxZuUTA3vk6wMv+0+qvNY+Bj5Ih8W6qMQx0Yo3CtvuWtxtRZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11797
X-Mailman-Approved-At: Mon, 25 May 2026 14:31:01 +0200
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

On Tue, May 19, 2026 at 02:22:08PM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>The watchdog base addresses are now obtained from the devicetree via
>ofnode_* functions. Remove the hardcoded macro definitions as they are
>no longer needed.
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
