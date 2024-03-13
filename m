Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B415C54E58
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 02:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9265D87C86;
	Wed, 13 Mar 2024 03:18:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="S5XoNDcJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E31E287CF2; Wed, 13 Mar 2024 03:18:19 +0100 (CET)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 082FD87C83
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 03:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isCPBDzEaIXX6G2pgr2oU3Fx0clnrg4E36qT0G/pZAtcLzJCumc6TQnAw7tTq2R6O0LbGMzlkrwYx0EqViAP2Yiu15NjC4osqlB8fbjPZkr9F8Bc9NPTooiszOghIajh84PBm0Y9+tnbGHIxKhnNCJV/Ls694U73MLTFgNSMImYUO8V2Gi2fchw2gRXiI13ZZLKHrJWvPoE8KzwFN3y6taF8UvgipM/5B0EzDlW7g/LNz/bw8i2Bb4y8ZbX3TANtvaVi9TNler7LM9Y+qatugtrBG2WrkgrVh3jZgqlR8ZGUybfIfWgOaTM0Ko7qMygEVdEMihKc1Z6+vYCEQqPT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vi7S9ncAxt2j0cbc+rhnDrbeAMuUA7tTyjJuJYib+oo=;
 b=kZNYjyWvyAKxPcFJe+8Yug3td7z6lq6MY69Do4n5wH15ocZzk38AO0QaCjmJf7tyVx7t+I3/hEhLt1dR+MpCC4JFgcauLRbzPvAFR4eBjzc6G1+nkQXHx07F2DDm/SziAQsIxRQg/+dZkSb9OIOrpC25YDGX68PZbJxTrP+hXPouxkMFfoMVQW9t6omAYK5O5teNUB79tlSCzvarTeEyUBdQ9IOWwjFJ3pp8UFAZKMogIEAG7NLsC+WGFBDVZYiKS96/Wbdq4rMfse9EWg64lIq7js7FrcnQ1Xnvv9tQsKTcNa9d2ncehKFj7BaJ6+55v4/BBRfDXp/Oc47VGIrb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vi7S9ncAxt2j0cbc+rhnDrbeAMuUA7tTyjJuJYib+oo=;
 b=S5XoNDcJzDNdpEMtyukqsK8ZpZ9i+3fUrTnragOP1KY4A377Bh/MGSjdt6Kkkv/gLPIJVFWEyLJViKp1x84kMiZxYnibABIVIPRjFcOLwkDFwEP5tqAAnzsUpttMq5sn1N9bbOyjm6lozxkNEHdhqYuz9lGbfjnGHPUguAXlDBY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB7026.eurprd04.prod.outlook.com (2603:10a6:208:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 02:18:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 02:18:16 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Marcel Ziswiler <marcel.ziswiler@toradex.com>, "hiago.franco@toradex.com"
 <hiago.franco@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "joao.goncalves@toradex.com"
 <joao.goncalves@toradex.com>
Subject: RE: [PATCH] apalis-imx8: Fix sc_misc_otp_fuse_read() error check
Thread-Topic: [PATCH] apalis-imx8: Fix sc_misc_otp_fuse_read() error check
Thread-Index: AQHadOHGEVpjqRLryU6j4uNyiYsp77E075hg
Date: Wed, 13 Mar 2024 02:18:16 +0000
Message-ID: <DU0PR04MB94175F2C12269F33DC2D43F1882A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240313005941.2654166-1-festevam@gmail.com>
In-Reply-To: <20240313005941.2654166-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM0PR04MB7026:EE_
x-ms-office365-filtering-correlation-id: 55711253-697c-4267-1528-08dc4303d7ec
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HmjJkLQvBZxRr7eTKmnK+vK76Jpoj6q0fTY0nEbyVLB7v7pqX4CsUBreAU0wysPExdHSH1OSOxhLjtxfFeA2XaCQdOBkiimJMk9oUJqs6PO8+xA1rsOUbqJLxPV1ZHANR0v8Kgp9U1p7oGwnHvywPFJh0oY1i2N9pvDBynRISXlNN+hSYJoPcoJDm1HRRW2YqxKQ3zLplDXoXcyIwatp6i67xepElJTbq+i09fn+XBflJR8CVd5tKd8CcpzXiMszeMRF3D3V8QZtXgHg1eqbh8KcTjMvPDbOqoYAdd58tuG9HplrPr4P4tfjyzQBHrHvvmGGjhC5Zw1OhlpA5a6n/2gaKcYaHTl5Y2kIVqDA4zgw6sHwWaLRyDZXXkhiYHWT94UwgBPw1wOuYVOdvlJdvy9Fy753IsS3/ywHxEpC695uyUIRgcyykrkkkSUPP11iR/5xT1JpKq65EQUg2EU8C4slZC748d5ORkEA3BBU1TYOiBk5Pu1UpV2wXMO4EG8RenkE6C+3vNywk1Fi2ZD57X5FcOoOHqo0xrZGTQAA0LKeoJQcMnGicVAUyAQ7XoHJNpBk03IeXh9BpctWVZhER246Kyi6jm2uENA5x+s6iGkBqbhcGRKjYPP5Vmy4fjXJD89cb8cYTMvAeMryo5u9P8M5JFMqdGdEwB1lqe0phe+4qiRpMe1At8FbEV0VBb2Wwv7ny9XoH+GDiOojnbwYtXYayBlFKMzgl/s32v/kOK8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hd9PrWKgTK4TrzuNkONg6X8jd0sWuDaBWA5TqxaFpcPhJDFADlmlRxGSCdj/?=
 =?us-ascii?Q?LvNOpEfGBj1SKYnkysGotACk8xLs71YYqzUARbTSTFOlhN5/2vOAw9OmCODp?=
 =?us-ascii?Q?/lBoUa9raoCMRYvlhCFPR+RZUV30p5sfUnta2mCC/tlkILs16ziRRlovaQIO?=
 =?us-ascii?Q?KcDQdLlpGTfK+3iVn3M2apHH2C7A/YLjqVG/cjrP/IoKHruAHTxLMfGu0Sdu?=
 =?us-ascii?Q?mOSEYQcDLa9mMwHEnwvlbCeDffaOyL/dE93tCJ4Y1rIP5tsvAQv2E87z7RBq?=
 =?us-ascii?Q?vQ9wQx0D26KFS6Ey4PVMTJ7tNTLdAsGyCCbE3FiU53QG5Y/aQDlJrSp8Ub+G?=
 =?us-ascii?Q?ZL+VWI7t+0+wbPLReuufVJMcKsHEjAH0Y2+IvsNjpIWsOQtTOSBdoZeSbq1J?=
 =?us-ascii?Q?QM727llw89QQUf5yTqSh0NG/s75H8siAZiejWXdtbUIKhcNEk9615AVtwTFq?=
 =?us-ascii?Q?2uOBfGpLBXPb6PcR1mi8E202s71PXLlv9ml9uBSkwYbj55aCqGol/IdO5aGs?=
 =?us-ascii?Q?XF1HmIvY2fqzq4qVkeMr9ewhJvsKRZOHsaZRkdA9Mn1zHh8uS4sUxhXhXeMg?=
 =?us-ascii?Q?U1q3CeNPCtfRbiReaWL2v6L/6Ba77LOX6AZ7UyBIcjaDMMSNUXcaLjHupYjM?=
 =?us-ascii?Q?ea1c1gc2BCv6mBSu1jdqznKqnvgdNeXnyA+/h3RB77NwX8YcOFmeEijl6LLZ?=
 =?us-ascii?Q?HdaVN+RXz1oD6gN6PaHzskTgB6VERxpU6LAp76LJYwa7NpXZ0JgTgeFFtK3D?=
 =?us-ascii?Q?R7TCDARxGNUIoAHiYsbUMFk070SSRiM6XXSccc66pLSvsbAXvY30kdXVc0fk?=
 =?us-ascii?Q?Qu+NoBk46Kk2yKADyGW4tUhh7IYlgJbn+2eqOox0pO1bwr986ebNU5rLsCOS?=
 =?us-ascii?Q?FptAXG57vLCTEWK6/4Wa347b+/p6LF/8peT8+bBWRTRs291hY9wcmAyZJwZS?=
 =?us-ascii?Q?I5eMIJv70dK5HqC/4d2YnXa+l5IkYagCQM1RrS5puND1ohji64xBmIWKEDys?=
 =?us-ascii?Q?oT3RmD6IqO8VpYOQU5vBRuy/PV7RdjQ1FSKgGKd+T0kfDv0+27+HgA1dn+Rg?=
 =?us-ascii?Q?o/5b6+LcAI3OzXvmQTxyji0b9AkfU05SxUtI4EbGFwYliP6Iqmo2O02qyLJs?=
 =?us-ascii?Q?YHhWhK0zB7Fqz3CbDtlkcamtvWYYz4pp2Lho9qMb7piQNbPN4jUNHlWphskQ?=
 =?us-ascii?Q?aqhMdrw4CDBTNKx0SIG/CKYGeZbktPjQFJwiqYjbSS6NIgeqVUM8VPfwEVkw?=
 =?us-ascii?Q?LKAAtWQDHnbzREkpn6JZk7QU5CMr1y+u96WTRnTvbZ4YTIsayoKA0B0MMfdV?=
 =?us-ascii?Q?txfVPmH2umxg6QLjkLNVhxQ+hNn3SRXseWLpmZ1Nf+3sOJ6vkMvjq/IavrzM?=
 =?us-ascii?Q?xugS70aZkz27SnDhaumv+HlAJeVGQRrSmaFMsdT7Ir9cYbqv5Bjibutiiv/C?=
 =?us-ascii?Q?PpfivFtBmJFnmY1eEtK/BNSPutr0azmkdAsNoT3BHyWe1s7jcQoQKKPfhVSN?=
 =?us-ascii?Q?k4FtRS3byjjm/x0YPMsl0lzNyRPu1MsnLDHYrOPuBcHSBcsFb6Qc8G6gdd+i?=
 =?us-ascii?Q?swc/5UKYBub+cf1ci8U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55711253-697c-4267-1528-08dc4303d7ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 02:18:16.5761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUjIBHV9ti/sazBsYLtjoB7xzdAeGW5PPmG5P8/tOY58wZg88u5+wIUOyTAZQ5d/Uq2GnjOz1nWr0Xnm2mbfTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7026
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



> -----Original Message-----
> From: Fabio Estevam <festevam@gmail.com>
> Sent: Wednesday, March 13, 2024 9:00 AM
> To: festevam@gmail.com
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>;
> hiago.franco@toradex.com; Francesco Dolcini
> <francesco.dolcini@toradex.com>; u-boot@lists.denx.de; Peng Fan
> <peng.fan@nxp.com>; joao.goncalves@toradex.com
> Subject: [PATCH] apalis-imx8: Fix sc_misc_otp_fuse_read() error check
>=20
> Commit bfb3409d676f ("imx: toradex/apalis-imx8: correct SCU API usage")
> made an incorrect logic change in the error code check of
> sc_misc_otp_fuse_read():
>=20
> -       if (scierr =3D=3D SC_ERR_NONE) {
> +       if (scierr) {
>                 /* QP has one A72 core disabled */
>                 is_quadplus =3D ((val >> 4) & 0x3) !=3D 0x0;
>         }
>=20
> The other changes in this commit are correct.
>=20
> sc_misc_otp_fuse_read() returns 0 on a successful fuse read.
>=20
> This inversion causes board_mem_get_layout() to report incorrect RAM size=
.
>=20
> Go back the original error check logic to fix the problem.
>=20
> Fixes: bfb3409d676f ("imx: toradex/apalis-imx8: correct SCU API usage")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  board/toradex/apalis-imx8/apalis-imx8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/board/toradex/apalis-imx8/apalis-imx8.c b/board/toradex/apal=
is-
> imx8/apalis-imx8.c
> index 2483a63c6733..49719f2f5533 100644
> --- a/board/toradex/apalis-imx8/apalis-imx8.c
> +++ b/board/toradex/apalis-imx8/apalis-imx8.c
> @@ -133,7 +133,7 @@ void board_mem_get_layout(u64
> *phys_sdram_1_start,
>  	struct tdx_user_fuses tdxramfuses;
>  	int scierr =3D sc_misc_otp_fuse_read(-1, 6, &val);
>=20
> -	if (scierr) {
> +	if (!scierr) {
>  		/* QP has one A72 core disabled */
>  		is_quadplus =3D ((val >> 4) & 0x3) !=3D 0x0;
>  	}
> --
> 2.34.1

