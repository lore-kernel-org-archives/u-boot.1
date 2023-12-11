Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E48C46CA3
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 15:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1FF68771F;
	Mon, 11 Dec 2023 16:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="gREloQCJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC7058771F; Mon, 11 Dec 2023 16:24:03 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB66876F8
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 16:23:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=holger.brunck@hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i615vzooCbNXjU0s+kbYwCKrkhNFRIvZ9Ve47GuaEou4tyPPQUefXm7cM94ND9bTKieiYVtAbMlW8fht3f2VxjYeEKJKMih7GBWSNNMTjqlkFR6fk++qoZge7iV8dq6Yt5O7tDpQD6vGhONZWTEVheiwj92V075LjFGWH73WAJScLM4Ks3E214nhecFcbwXUtOm539SMDGRo//Ku9I+vMlKZ9kyPa4JpPfqSX2yWmEL3ivgiNzkNf9uX8nMmcom5AQO7bFJcbxDzsTbMURClQ3vSpAaZqzpAuGEoeJDghyFWwrxrP10K+hhdw3ZFCcTgnMhH5hfFffPksQWpI9PkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQZOPQQRF3kDJAor1xoY97F3iCW203LJirhN1+yMkRo=;
 b=LiVnsY35tMM+MJbLUZ/RFYWRt9qyMlbJU/wMEdQf4aKkBo6V9YEV7sHCDf5+4UYV8eSDFv+/PvxT6rwj+DKfxDFSJ3n+prgBJ5cr8J2zgt+IjR3uVtvvzRjD2tv2ubkXTQvZI9aWD/JH9RF1r5++Tq4RerG41LmF1az0Sq5BYrn3oY2qXMeOXjEYZmfvAf4zAc2UqRehoVbcR+E5+TOPGwu6UZv/baxmEbWYncqzMHRxvYt40fSj1Vq1mj86NnRTP6nD5SYLwpPBIMReSQBUieZIyjAZcpLhDpqV1VmJIoRU43gAMD0c12Xw46t9wcMGJ3DBC/V+p53eCanvi22BEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQZOPQQRF3kDJAor1xoY97F3iCW203LJirhN1+yMkRo=;
 b=gREloQCJccZlZzoCnOZkX0O4fIxJDylUrF/I6CwAYDcEm8cZ1ODiAbdxcUokKATRCkdZceVRjBkJf0mnVq5tySwQTnaqfPC/Ctf4eh5BPxoVQV3HbNZ+iu5P3h1RIVtOhCsnP5TXMdjVEhcdjUlMDh4Rki1I2eBe2kG7KWnUsCdeui7cA2mu1FmUAUI9roPJZnTV0LuF6+Xaj3DrUUzKpiY6JAlcHYG7bYkvZ3daD/mcPoAmyosL3DVvz6LyjU3JojoQ7h2RtZ7rCPcsG6gUWgE124MoB/NJ3DoYxHiCr0Lz94kDpQ7JQiEq30tWF4PgxWzV0SxsM44XlarqVVGHWQ==
Received: from DU2PR06MB8334.eurprd06.prod.outlook.com (2603:10a6:10:2e5::13)
 by GVXPR06MB8798.eurprd06.prod.outlook.com (2603:10a6:150:112::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 15:23:57 +0000
Received: from DU2PR06MB8334.eurprd06.prod.outlook.com
 ([fe80::7761:fd7a:8b02:9546]) by DU2PR06MB8334.eurprd06.prod.outlook.com
 ([fe80::7761:fd7a:8b02:9546%3]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 15:23:57 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: Francis Laniel <francis.laniel@amarulasolutions.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Tom Rini
 <trini@konsulko.com>, Harald Seiler <hws@denx.de>, Simon Glass
 <sjg@chromium.org>, Niel Fourie <lusus@denx.de>, Heiko Schocher <hs@denx.de>, 
 Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>
Subject: RE: [PATCH v12 24/24] configs: Use old hush for several boards
Thread-Topic: [PATCH v12 24/24] configs: Use old hush for several boards
Thread-Index: AQHaKiZLt4odRaYmh0mj/AQTFSc9eLCkNr5w
Date: Mon, 11 Dec 2023 15:23:57 +0000
Message-ID: <DU2PR06MB83347C10573EE54EC0259B32F78FA@DU2PR06MB8334.eurprd06.prod.outlook.com>
References: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
 <20231208223025.55076-25-francis.laniel@amarulasolutions.com>
In-Reply-To: <20231208223025.55076-25-francis.laniel@amarulasolutions.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 8.28.0.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR06MB8334:EE_|GVXPR06MB8798:EE_
x-ms-office365-filtering-correlation-id: 4c0e8a5b-03f1-4e48-80a0-08dbfa5d3185
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LkMBDgNKkbjA7NiIZ8RsCjrrCZds5euCoEn/cW9mT7yMbsADx7GPuwYu6Xj8SPRCxbB96k7VjYxPmX2Pvdf4eBjaaFLpFIpyMGdENVTWt6VTL8cKutxpvqkwlKXHGVqJc452Njgq3LmVB0GPRvWW6y/uYctxGojJ1PpVKqLbCGl2uVcKkFrpUmWNdIfhYfD7gweG9zEmqiHnexlRzxYQOuiuZCWKTCbkJPu2UHUqUWANO4LOagoaw8xNnTkYZoI4d1psP+qqncA32TAC/xUzLfYluqR56iQ/mJ+a8TYDblojg1m8e27+lvLOC8dj1e3VfRdwSyKjVCI2UimBoThcX7j3ZmMnVpuEFcsPenJXv3dU2zst8nQql/ITvctbalmUbKeZp1A5ve1VQM1LFrFkkb/rmj0DttPrjO57MxgR0i/aVJDjyq27CmKDSbX/YWMMecWuywWOdG3zV5vbwiubgW+cVcCPDxNtlpABW6JaCup8qqGBja3q3BM5/JOF+zx0zBHfbOorkS9JSIQSs5J/Ofj0EifhKbr/O/HgtVHZoTuzi+dYcEiPoFknxHzg/ITGNq/ZM41M5Uw9dcK0IXXAXhMjdt5Y6LUMrZ1BBWNBUZWZun6nYYnl4MOLrnS4ceoP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR06MB8334.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(55016003)(107886003)(7696005)(26005)(6506007)(71200400001)(478600001)(9686003)(38070700009)(38100700002)(33656002)(86362001)(82960400001)(2906002)(44832011)(5660300002)(54906003)(66946007)(66556008)(66476007)(66446008)(64756008)(41300700001)(76116006)(83380400001)(122000001)(52536014)(316002)(8936002)(8676002)(4326008)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TvqAJN3IOUguAz0/+hfX0IJ6KLDuOKGgwv3C/6AmSJfw3hk6ux0XxW2fqMav?=
 =?us-ascii?Q?0CGLGrh0vuucQwHliYIR5Yu6sIaeoVwBalAMlkA8erKcaKLCz1MA79+30vUe?=
 =?us-ascii?Q?/uEZ2TlKh7GNkZpRzRxSN2l9kSvPjAwZfGb/8JBwhkdLXIJA1uRIFUezT0kv?=
 =?us-ascii?Q?cHUABEhd7REka3a39LlmQFTO7HHdp31i9vkIfqi9pJ4CRIIjn3E/It6KWqvQ?=
 =?us-ascii?Q?GAgYgAEjVUhIScoatZr5Hu4VtXRYzuVJb7zSHdRogfPbpwh83YSgA8QpGhNu?=
 =?us-ascii?Q?UU3842KRu7M3pISNQ/kuS9TCuv2OF6bRQjTBH4QJALmdgjWqjraldMxOsGFC?=
 =?us-ascii?Q?YiyMNYODcuaelzvQjBz38foe15nOMd86jek4pWuu4e2kGgk0Jp7tSV9rZIT5?=
 =?us-ascii?Q?WM8MXsV8jY8H894GWGvgF2LAohGUcJQhx2bU3o4wlT31MK1SXc/wKqlzYTLc?=
 =?us-ascii?Q?+R3JyLuebGq9Yd7YYLryxlm3Q1zpvWPEJDzZ9nHk8x+OcmbDduhD+PP5HeH2?=
 =?us-ascii?Q?BUTAucyPatP8EVevsn1Bm1YAgVvPANzAg2x1x5zb3ZuXGc5mPhNVhqpf/eWE?=
 =?us-ascii?Q?BaMW7We58EgLoZ5OBKHeSsPcGkU1qGhNnf1PZhtyrApyPrWuChJ1mVNkYAgc?=
 =?us-ascii?Q?cAnGAV2tuvoy8Ml03uL2g5cSGhRgvZd/BZbZHUr6m8pe21DpJC45L1I8JZX3?=
 =?us-ascii?Q?82Qg8qnsUacSeFohGnfv9l6qMyf7/0HvAoGlRZ3+tLncf/j5BDAg+hqT5cTK?=
 =?us-ascii?Q?SfKCoEl+K5PGGKLzh8L2KojZCYst+uO5LPU4pGF3zAS8U7rdbWBa96wK++pP?=
 =?us-ascii?Q?jDQit6HJZYmmV6qUz20oxWgI5kvVO+o53TpBQs/mAas+eBGW0dfar3FW8VI7?=
 =?us-ascii?Q?G1mvH5v5Bm1kjQLe4Pir1+Pu7r/ojuKRyMRp5WVznf9H8cpoqQ0+7oWzioPp?=
 =?us-ascii?Q?cq9A1RWDP4pPe/S/0nME9w+gWs2oj4E9AB5dbs+wQq3Od6mr3yIMS/GsRkz4?=
 =?us-ascii?Q?R8Fyp1u8kV0e4V2Zma+hgwZqb4DjmzPRY2sAPfqvr7DclDCAFVqiD9ODUWVr?=
 =?us-ascii?Q?8NPWjE3L0ONxWwA5eaUN8Xlu0G68kWT+7wjmOZMjSP49jb/qbL2lHQ41LJPT?=
 =?us-ascii?Q?IqyqaVS0Uhdm8r/vFO36o6DhW9VSL2dcuz3VrvCMs6+w+fHoUAleKdtxIIpl?=
 =?us-ascii?Q?HOq1ROskxzKD/b5kLQFKy6cldw4tO7o2IrcVXzO8OnkMRT3qwAtKYN9jKMOW?=
 =?us-ascii?Q?qT3zHflSePPm8ultyqfuJsK6SPBndfv1MHxfjfY/z5rk7IWAxLKVrc/gGMOT?=
 =?us-ascii?Q?mH22HeLLVqlyrJ2IJ+6TAvdac6O6qqBriNiwkAljsl6K7Cc1KrpYf8UE77gQ?=
 =?us-ascii?Q?eHZ2eCoOAB245y0AwAXiW21X+XHs2sX8tjj4NpqYJN0tPMH9nOftfXYIbC7n?=
 =?us-ascii?Q?tO7etwRzMg9MlLCfBZwpVWB5QKpk+awD4cYjZgp4EPe/NQaqB39ZtZJhlO1c?=
 =?us-ascii?Q?B5uIhLln6eN/5TtBu2WfUegBWddZOY7YNGjyly2bQIk+llEj1qOR7+2FpBpW?=
 =?us-ascii?Q?BV6E+uqIVBooNKUTR92mPdj1k3/AgTGIwifr1Cp1LiTzit2JJ//jSzr06QuQ?=
 =?us-ascii?Q?Og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR06MB8334.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0e8a5b-03f1-4e48-80a0-08dbfa5d3185
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 15:23:57.2465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5gCqro29GX7tGd/MTpqOYlbri+3ohtNiMsbMx/tIKE1BHUwrm+s3AQ6qXRFtIIAKUQ8G8jJc8voVSwpzVM/nJsLjqqKL/9AHH7PgbzeneU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB8798
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

> Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
> ---
>  configs/kmcent2_defconfig              | 1 +
>  configs/kmcoge5ne_defconfig            | 1 +
>  configs/kmeter1_defconfig              | 1 +
>  configs/kmopti2_defconfig              | 1 +
>  configs/kmsupx5_defconfig              | 1 +
>  configs/kmtepr2_defconfig              | 1 +
>  configs/pg_wcom_expu1_defconfig        | 1 +
>  configs/pg_wcom_expu1_update_defconfig | 1 +
>  configs/pg_wcom_seli8_defconfig        | 1 +
>  configs/pg_wcom_seli8_update_defconfig | 1 +
>  configs/socfpga_secu1_defconfig        | 1 +
>  configs/tuge1_defconfig                | 1 +
>  configs/tuxx1_defconfig                | 1 +
>  13 files changed, 13 insertions(+)
>=20
> diff --git a/configs/kmcent2_defconfig b/configs/kmcent2_defconfig index
> 2cf9565fc9..ac272b3840 100644
> --- a/configs/kmcent2_defconfig
> +++ b/configs/kmcent2_defconfig
> @@ -111,3 +111,4 @@ CONFIG_BCH=3Dy
>  CONFIG_PANIC_HANG=3Dy
>  CONFIG_LZO=3Dy
>  CONFIG_POST=3Dy
> +CONFIG_HUSH_OLD_PARSER=3Dy
> diff --git a/configs/kmcoge5ne_defconfig b/configs/kmcoge5ne_defconfig
> index 257ceeca90..ace5080690 100644
> --- a/configs/kmcoge5ne_defconfig
> +++ b/configs/kmcoge5ne_defconfig
> @@ -202,3 +202,4 @@ CONFIG_QE=3Dy
>  CONFIG_SYS_NS16550=3Dy
>  CONFIG_BCH=3Dy
>  CONFIG_POST=3Dy
> +CONFIG_HUSH_OLD_PARSER=3Dy
> diff --git a/configs/kmeter1_defconfig b/configs/kmeter1_defconfig index
> 46e0370e35..56b83c085d 100644
> --- a/configs/kmeter1_defconfig
> +++ b/configs/kmeter1_defconfig
> @@ -173,3 +173,4 @@ CONFIG_DM_ETH_PHY=3Dy
>  CONFIG_QE_UEC=3Dy
>  CONFIG_QE=3Dy
>  CONFIG_SYS_NS16550=3Dy
> +CONFIG_HUSH_OLD_PARSER=3Dy
> diff --git a/configs/kmopti2_defconfig b/configs/kmopti2_defconfig index
> c6c021adde..08c7602f5d 100644
> --- a/configs/kmopti2_defconfig
> +++ b/configs/kmopti2_defconfig
> @@ -183,3 +183,4 @@ CONFIG_QE_UEC=3Dy
>  # CONFIG_PINCTRL_FULL is not set
>  CONFIG_QE=3Dy
>  CONFIG_SYS_NS16550=3Dy
> +CONFIG_HUSH_OLD_PARSER=3Dy
> diff --git a/configs/kmsupx5_defconfig b/configs/kmsupx5_defconfig index
> 25642e7018..72db26f320 100644
> --- a/configs/kmsupx5_defconfig
> +++ b/configs/kmsupx5_defconfig
> @@ -166,3 +166,4 @@ CONFIG_QE_UEC=3Dy
>  # CONFIG_PINCTRL_FULL is not set
>  CONFIG_QE=3Dy
>  CONFIG_SYS_NS16550=3Dy
> +CONFIG_HUSH_OLD_PARSER=3Dy
> diff --git a/configs/kmtepr2_defconfig b/configs/kmtepr2_defconfig index
> ea37a29060..ed908d3c77 100644
> --- a/configs/kmtepr2_defconfig
> +++ b/configs/kmtepr2_defconfig
> @@ -182,3 +182,4 @@ CONFIG_QE_UEC=3Dy
>  # CONFIG_PINCTRL_FULL is not set
>  CONFIG_QE=3Dy
>  CONFIG_SYS_NS16550=3Dy
> +CONFIG_HUSH_OLD_PARSER=3Dy
> diff --git a/configs/pg_wcom_expu1_defconfig
> b/configs/pg_wcom_expu1_defconfig index 455b439151..0337447f79 100644
> --- a/configs/pg_wcom_expu1_defconfig
> +++ b/configs/pg_wcom_expu1_defconfig
> @@ -105,3 +105,4 @@ CONFIG_DM_SERIAL=3Dy
>  CONFIG_SYS_NS16550=3Dy
>  CONFIG_LZO=3Dy
>  CONFIG_POST=3Dy
> +CONFIG_HUSH_OLD_PARSER=3Dy
> diff --git a/configs/pg_wcom_expu1_update_defconfig
> b/configs/pg_wcom_expu1_update_defconfig
> index 269116cd0d..e5daa306ab 100644
> --- a/configs/pg_wcom_expu1_update_defconfig
> +++ b/configs/pg_wcom_expu1_update_defconfig
> @@ -103,3 +103,4 @@ CONFIG_DM_SERIAL=3Dy
>  CONFIG_SYS_NS16550=3Dy
>  CONFIG_LZO=3Dy
>  CONFIG_POST=3Dy
> +CONFIG_HUSH_OLD_PARSER=3Dy
> diff --git a/configs/pg_wcom_seli8_defconfig
> b/configs/pg_wcom_seli8_defconfig index 678bc10070..e86a17abdf 100644
> --- a/configs/pg_wcom_seli8_defconfig
> +++ b/configs/pg_wcom_seli8_defconfig
> @@ -105,3 +105,4 @@ CONFIG_DM_SERIAL=3Dy
>  CONFIG_SYS_NS16550=3Dy
>  CONFIG_LZO=3Dy
>  CONFIG_POST=3Dy
> +CONFIG_HUSH_OLD_PARSER=3Dy
> diff --git a/configs/pg_wcom_seli8_update_defconfig
> b/configs/pg_wcom_seli8_update_defconfig
> index 7c7b001903..886334a043 100644
> --- a/configs/pg_wcom_seli8_update_defconfig
> +++ b/configs/pg_wcom_seli8_update_defconfig
> @@ -103,3 +103,4 @@ CONFIG_DM_SERIAL=3Dy
>  CONFIG_SYS_NS16550=3Dy
>  CONFIG_LZO=3Dy
>  CONFIG_POST=3Dy
> +CONFIG_HUSH_OLD_PARSER=3Dy
> diff --git a/configs/socfpga_secu1_defconfig
> b/configs/socfpga_secu1_defconfig index b8052f1dee..2622bb0432 100644
> --- a/configs/socfpga_secu1_defconfig
> +++ b/configs/socfpga_secu1_defconfig
> @@ -113,3 +113,4 @@ CONFIG_DESIGNWARE_WATCHDOG=3Dy
> CONFIG_WDT=3Dy  CONFIG_SYS_TIMER_COUNTS_DOWN=3Dy  # CONFIG_GZIP is
> not set
> +CONFIG_HUSH_OLD_PARSER=3Dy
> diff --git a/configs/tuge1_defconfig b/configs/tuge1_defconfig index
> 9ff5d1599f..5c4d33235e 100644
> --- a/configs/tuge1_defconfig
> +++ b/configs/tuge1_defconfig
> @@ -166,3 +166,4 @@ CONFIG_QE_UEC=3Dy
>  # CONFIG_PINCTRL_FULL is not set
>  CONFIG_QE=3Dy
>  CONFIG_SYS_NS16550=3Dy
> +CONFIG_HUSH_OLD_PARSER=3Dy
> diff --git a/configs/tuxx1_defconfig b/configs/tuxx1_defconfig index
> 5b33e8fa64..16b50dd571 100644
> --- a/configs/tuxx1_defconfig
> +++ b/configs/tuxx1_defconfig
> @@ -183,3 +183,4 @@ CONFIG_QE_UEC=3Dy
>  # CONFIG_PINCTRL_FULL is not set
>  CONFIG_QE=3Dy
>  CONFIG_SYS_NS16550=3Dy
> +CONFIG_HUSH_OLD_PARSER=3Dy
> --
> 2.34.1

Reviewed-by: <holger.brunck@hitachienergy.com>

Thanks for taking care of this.=20

Best regards
Holger Brunck
