Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6535CE7A89
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 08:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA7C886B82;
	Mon, 25 Sep 2023 10:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="K8e0SQ6E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C639286BF7; Mon, 25 Sep 2023 10:10:11 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::70e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CE0786BA8
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 10:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ev1PDV8QfAMC6LrNr7EPjpvSJCX2ZCrX8M0neSoOLgpn/mvJ1pS15SJnqg4jEZR20ueiqLYV4ziBkNVMMwuK8ouATKLdj7pNin16sOF8xRGsu5A7Cofs41mpGkyWgoKdcX3GhNysq5UfCa0Qi/g/Nvl/3eesAzKYUEVCTfmjG/tdikmOezoa6lwJX9OeqFC+etmJJjNU/WYYyJ4+NrYOv2wO50La9r2c+t9rtwisf0bCmbSqVQ1IzNUWRUlent/9ZwKaMpTyhRGk+2W/xx3u76uGklJkZlFLZTeDaWDImJqhUd4bfvH8q2Kir8WLBfAgE4ZW9flhYANEyRW5/l/rRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gs7j0whEijYm1iaJxWpN3v9QIQFP7HwHVI65FRBRd88=;
 b=eSa/vIshgyMqHMKeocar4ohzKEGqyMApAzfYE0VmvO+wTuu2SviyakOvaGU2x8FZgiDj3VLuIXruH5LVLjU79JpEZv2vNGr8FQAxphUQ5bhBb2HFj7WUBo/KtI0yfAHmF0dWSY8lQWF/aGA1xUSR20j8VZ5twxB0e8OFzGnfXfG5RkbDrvbtnb3jQfW52vVbM5QVq4pTpv7htR16Np1PItMHkXOYNDgGUeNC0jiIMO7AalUXqTfVtyLSnZOnPDyg2oFOf9r1oe4zeNImWrxDwhD6Aj4QPSm1O+j842BJtgXSnk8s0Fid4szdwGxCet22nMo4CdKFxfzkqVTix3bhHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs7j0whEijYm1iaJxWpN3v9QIQFP7HwHVI65FRBRd88=;
 b=K8e0SQ6EgoRbCZMqVwSYnt3jJg8pO7lnXH6+f7TYRyKXPru5msMlpN7+KhD4IHQFfpyoTAYJR/NCXQNf44P4T5CBL5OmpfDm3eLHspeHIQ3Bf+/glCVKJDioZjBG98ismQnG2fMTRHe9jA2N5MloPOylf26hYe6qMZuwsbqr1EM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB7399.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:10:07 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:10:07 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 2/5] iot2050: rename overlay sources to .dtso
Date: Mon, 25 Sep 2023 10:09:06 +0200
Message-Id: <20230925080909.365098-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
References: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:208:122::20) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: e7da3db7-49f2-428c-c4db-08dbbd9ed45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPY+0vfLMObaxHf/7AhAbok+fEtqshFRxHT4/+eIsTU1jzgfzHCyvOyDWJv9x+Il0KMcnX5FCRTOYqYQdLX4cQP0QBj1VzkfUUlL3aju9Cjqo0MilG9aBvhDt84g+foPb2bSESNWb3g/MjY0njpOBCSQ4PTJNNYxX61cSoiKSg8Ysam9EG3s9s8+wHTn0VvJI+3fjiCELnU/8tSj9bOTr8rjZASWE4+3P1AfYTs3M4INq5ZMZ+4ckwwCx2NDY3AoUqk2bvx5Z12qgTjr1eYloUetfB3WwWJm5/mpGhm+n+jHxfxhHsNE7/sM4xrbFOfzMGmOQh2BIzYn7BRDz8Zgg+HBmPwV8hk7jix5yFvqhqm+o5yzdCyPF++JPPPfmEI3pgZZX9YZj4BYX1I12tElhsMwU/9r+sTYyjSibkYsTOzeF1Gk4nVpLIpDCNMsGF6uz8dl/RId4l6Rdp/ppyd7HCuVBcXD6SdtIqAwU8c0Wwh7fEaJjFc+tQcl87YZKsrZa87VIPAHBjKEkDpxtCEg/+Nfm7lPs/XYi/QmTefg/1Or5u0OKNHA9/s2qdJ06SucSAHuErcJZXfK7rZEamo1dYs7t2xsf1d03h1ijLOxTOrbeFBu8Oy919fn4T7X76vC6tO/rmq66F5Kw7l+SY3qbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39850400004)(396003)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(86362001)(36756003)(6486002)(6506007)(26005)(5660300002)(52116002)(6512007)(54906003)(66476007)(66556008)(66946007)(2616005)(316002)(6916009)(41300700001)(44832011)(1076003)(107886003)(478600001)(4326008)(8676002)(8936002)(8976002)(2906002)(38350700002)(38100700002)(83380400001)(142923001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QHWmM4p9DEOPSp8svtMVtor4tILr5AHgomZaR1mHiYzMXdhPuWrXHFCCGbyr?=
 =?us-ascii?Q?J+R6KW/tIddzWMlveauSu7Nsv5lpt9eLrdCoS/7r9cEawvRy6h+FknDms8DL?=
 =?us-ascii?Q?haLSfr1mLbTvQH1Y12F6QsfofpLAm3Tv1zZBjUfbGQwUCMUI95fqdiMAaIxj?=
 =?us-ascii?Q?M2txUFmA0oerdIsg/OuM7MDgjDAcyovnWXr2Np6Q7x0gV/Dx7KJLhSQMNT7n?=
 =?us-ascii?Q?d48jBFcN2WAHeC9dxfful08kTDsJJr42fGSNz/s3tJnVOtZaoaDpfqXFo/jR?=
 =?us-ascii?Q?xE6x2HLTUdskVV7Lde5+hHYh321ZHYWAxnRaNEL2maf0bLwxf1umsvXQKR5x?=
 =?us-ascii?Q?ClITf3kmb42FXIxy05JGesBSfUPab+RGde6a46UGdbH0FQJBVVyAZnlqeVW7?=
 =?us-ascii?Q?an6tcCmE97GQIzBKBpL2X1iulvFQSyS8ALnedx7jVLmXDKWHSjNhK2Ge2rAM?=
 =?us-ascii?Q?VQRqaLaNh78EAXiKrp/pRzwDe1aYSKXUyVv306CnKWhyPdil+xHB7hz+38Qc?=
 =?us-ascii?Q?s9sStOWqY4rUUUTOOBdFpEDnxJLMBDbPuGiXKdAt/+qz9pOdnOD0Ly+Mlfdh?=
 =?us-ascii?Q?XmWift2Z+WmUM+mbd8DoJThWC8hhtfybvKsx6csUj0Z4q6z23XjUylcNGAwv?=
 =?us-ascii?Q?i8xv5CeMrPg7X06EoyxHuMnmfmeshzhJ1YwZ63GcOilOLSSmF6iGHx7j8SGD?=
 =?us-ascii?Q?EGEGDJGRjwAG/Zcvs67P6xy30Rsxe0bJvSLzPyqVa36pXETlaaJGcHUrjXtC?=
 =?us-ascii?Q?A1E3ZxQRj2OH0Y3VahjpMewIRBXa67DzCmXDxgidE+i5PEKCzrK1c0FXVPcF?=
 =?us-ascii?Q?yfxIGBLrcxoFAj4SKXvxSPfn5C+R3cnZycAdJZSIUfXJ6ECCIkE7SRR7TLDQ?=
 =?us-ascii?Q?9/B6kudC0yphndrFhJIAS3OQ03x81imVsW7yS97orFddZe9r8lCJvKQdV7z0?=
 =?us-ascii?Q?g2zWMqckORi8m+FMMegfnLn4CGxhFyf4Ru0GffrSjrLhbJnh/yLIfcmshY88?=
 =?us-ascii?Q?ioEhux08db5S+xmiM7nY8JSWerdNITytsgPA6c8kZNpXzhVR3rw38IgSI/1l?=
 =?us-ascii?Q?Ae6ojww41XD64GD0nQ45jXHZNABBFzdj0OGYF8b2NicRTO2l8yScNePIrXEr?=
 =?us-ascii?Q?3PbD//gt+dwKujqjcvaUxf7SMOROZ7bTIE0MEns3H8v6YnEoxvKmemN/S5mg?=
 =?us-ascii?Q?7QNUH+Y1r/v82vmKXT3eWQYDMEOSo/d8VZEanKrwWpjvYfxsAJDyamu/GRIs?=
 =?us-ascii?Q?3rbbpf8V6xhGQP/O3t+qwbZAyqtfWA04T7hcS0ASCg1b/TKdpjIkfSw8+inA?=
 =?us-ascii?Q?epp8yKXxUB1a5LkjjGvURuhHMruQKFmtN1EV80wRcdYJv2jDEUMbH7P+k4OS?=
 =?us-ascii?Q?E3QV9AwxdCKjH6zVhVkyA6Go9R0uHOTfg4Awm/PIw8tfv+AhiOuzue8uTKcd?=
 =?us-ascii?Q?EuVovUzfFJtCi5C3rSYPOPLqAJBO4mvmPIhhgRDmc7OWPeIzAhI+2DrbiwOM?=
 =?us-ascii?Q?g/OIS0ONlwJWdq0rWdS27goj339BrBMcciX1QHsKAtQJxC51onIYECbkJZyy?=
 =?us-ascii?Q?NGoJU3p8MqMyKD9OFGmHXzl1UQ4lxkLHscekxR5dRQANCnSK7rq0Q7M8m6Vy?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e7da3db7-49f2-428c-c4db-08dbbd9ed45c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:10:06.9716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXM8o2IuU/whRBtnq6KI8LVgtBgBV/iIdvnS6ZVHlONCjZct4vAn/g5n0EYStIHiqe2ZMq379186LyU4BFzj/nuJ9bBoVRmGbvDY0YOvI/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7399
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

Distinguish more clearly between source files meant for producing .dtb
from those meant for producing .dtbo. No functional change, as we
currently have rules for producing a foo.dtbo from either foo.dts or
foo.dtso.

Note that in the linux tree, all device tree overlay sources have been
renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
81d362732bac). So this is also a step towards staying closer to linux
with respect to both Kbuild and device tree sources.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 ... => k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtso} | 0
 ...y.dts => k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtso} | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm/dts/{k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dts => k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtso} (100%)
 rename arch/arm/dts/{k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dts => k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtso} (100%)

diff --git a/arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dts b/arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtso
similarity index 100%
rename from arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dts
rename to arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtso
diff --git a/arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dts b/arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtso
similarity index 100%
rename from arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dts
rename to arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtso
-- 
2.37.2

