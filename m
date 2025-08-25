Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4DACA0FE9
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 09:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF62A81E13;
	Mon, 25 Aug 2025 11:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="VUU5iaxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56EBB82DA1; Mon, 25 Aug 2025 11:43:06 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1A63808AF
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 11:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRTqsMDcvCHzFrLeJrbUJZO5jps3Pyd3YANIrycYlp6rTIImw3EfTMCVVzC9EJL5VBooGGwD1LG2REde71n6/wIUHF9NNjr//u//+xX9JzIlyCo6QJVYZ2jSYbPkEmIvVHknGENdISY4AWSMi/V++nTbQy/uktQXqwKdtSdCOuGBPvpCOb9l09djfp75wTjyO4EkgptBGMXfAOQPBKjnCB3iSEzpoSrJSWS1lgzb3cYD4SHiL25+IX026S9K3FlQDVIr90VVOLTweIu45tbJbOF7/jHuinwlF0wqplk2WSUKH1lTOebWz7yXA3/f+NsUsaq7e+aaxiCFKDgOnM2Svg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4iFR8TpUd8pBq/CWI36iWcZKIUfydSujlSrgTguv5A=;
 b=l5oO1bU/k/cwYzTo1E1U8a3435DeiLjXG3Mq29be+jto5ItElDSKpohkBEp53KXPGzLVETvYOFiJ16lLKMQl+BSVkK5o6xfvBAUcp/70BRxdjrJaUTL4nWRtky4d9qb8J1cRXglD70RKTTeTuzrlqswVCFtjpnuPtysZ6Tif8Q4IuV1PJNH4NpMp9Mn6IpzUF/KO/w9VgUJxC4/9sdM9eTrtbQn/H5ix/GZ8roCcRryg/UxmvHa7OZ8P0SsfkjgLUCuoqiEtAYJwJ7ESIBGAgn3O7P1rk9b4m48FeMvxVB36Tx0S+rzzF8ywKspf4WMsvz+/Zy8ZCh+cH4es/GEM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4iFR8TpUd8pBq/CWI36iWcZKIUfydSujlSrgTguv5A=;
 b=VUU5iaxI8GIGTkql3xMU9Frf4H+iXlueUelgBtp8vJwD4QV+TmridAKH8Ponc/E1ToIdP0RuAhfeSg6Dv+yzg8MJ72uZ8eQCffW59FHzaoXWBdhqbfltMVcJrrhHQELuwPshqDtUr5uNDciLuefZugBnhoUCjCboREm9A9Jtyp9BeciTlKr39Cl4OjzShB4mZVIDLK6dyr4atLLRDT7A6TdUGMqxY2hHO9eIau3IHbFfMmiB6rtI9JPj5r+1Ai3xef4HsvM01AIRRVKItWIEz8E9liCNE2orZ0+aLTUDIx4N/TL/nddtkQjmGvfkJjI838T6r9owK8WW+7h0/w1oMQ==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DS1PR03MB7944.namprd03.prod.outlook.com (2603:10b6:8:21d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 09:43:00 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 09:42:59 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Michal Simek <michal.simek@amd.com>, "Ng,
 Boon Khai" <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v2 3/3] drivers: fpga: Check bitstream address doesn't
 exceed 512MB
Thread-Topic: [PATCH v2 3/3] drivers: fpga: Check bitstream address doesn't
 exceed 512MB
Thread-Index: AQHcEaSTwiJDwYP8OkCqo7/tKLpHMLRzJYMg
Date: Mon, 25 Aug 2025 09:42:59 +0000
Message-ID: <LV8PR03MB81370A93399D0C1E3D814F13A73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250820073201.8649-1-nareshkumar.ravulapalli@altera.com>
 <20250820073201.8649-4-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250820073201.8649-4-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|DS1PR03MB7944:EE_
x-ms-office365-filtering-correlation-id: fc2c5a6e-c5a8-4a80-f069-08dde3bbc751
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1ICP9KvEqYg/Xupa6UMP9RxtbqT1rTgjCWiTu5EXRGDyWhfMQtr6o8osERPO?=
 =?us-ascii?Q?h5933S2VavWnx6XXFjqgkq8b+DsrTdVXNHm2zUBnFs8M0OwRtjShzrZhbFQ7?=
 =?us-ascii?Q?DNbmKb3XdS9Q+ZXUOxngvWdIFNBsrOOWciT19kbOsq3tGz0WEGmVejvPcv5O?=
 =?us-ascii?Q?w9HMFwgkyt3o2esMry3QVbCL45mpVBBL7Y9ydOrLymJD7uV1FK2ySYZotM6e?=
 =?us-ascii?Q?hVDB/sWQyeSMgADna6++MBRfV0XxxMOrlHQfDHN8cyMfszGXUN/zQDlt0vb1?=
 =?us-ascii?Q?BP3YdH0ahrsWCx8EPa1I2KRxJ2dwljoQbn6vfoescYxRYfT8F9KdwoMrrN6T?=
 =?us-ascii?Q?Z+OnPSLsUbfOWcZOdfbRfV9KzFSK2pUEbeYNb0Lj4mZwMswHvBFS9SxY876s?=
 =?us-ascii?Q?QLotQQa2LFTvfKO5+DEDrJ+b2FIBcf8jiSGfSnD1NHXBczmD5J3Ex2vwoTB2?=
 =?us-ascii?Q?fVFam0gfxfqTCcBdsWgKqQWFXMg2vUH0GNlWEgMCE/asC6+XlddSrnYrYki3?=
 =?us-ascii?Q?7lnUp8drqv1LfGnF9PEUzILxg7q/wltRejtu9YFH3TgCI2kkyFIg9/AuvCn5?=
 =?us-ascii?Q?nLbGezuY7MXnzvCmgQaLx1ErIp+2oog6CRxvcJIjDFs24aM/Bk5SBVX2jsoj?=
 =?us-ascii?Q?lJsaFtzvgTqpxW1VNr2BTBD8Wpk/KYJGP4HRuZzhVPqUcdcHZlOf1TGXh5It?=
 =?us-ascii?Q?GyroeEDCtgd6UOLIwUgUjF+OQs9bdoYpe66P4aewbl6GfKmKCQdLFwiuRaNJ?=
 =?us-ascii?Q?44NUZD+fKTEb+plg9huAGgf2uahzENHzecd3cmDBWRz9W3tEftFY/vI4v+Qs?=
 =?us-ascii?Q?CLE9dB0UpP7mqB0Mb1iChmHQwipIUc6/zU29A1eb/IdSDDP+PT8C6p3UlacL?=
 =?us-ascii?Q?CUEApbgNNZaBmI1Jr8SFIF8E6RhDSta8fIGx8WR09ADHsNVTOXbkWvqSF9IQ?=
 =?us-ascii?Q?SUNRUwJSlhA9MRj59pPy4Oj3VeU0Gtvmwf7Hf71Of1jfLUu7XYE4oFsBETyQ?=
 =?us-ascii?Q?bvd/gy7hAbcr7yieeEAweA9nS1u0kXgCpsilcyOMKIstisCmU9+VhjSLkalr?=
 =?us-ascii?Q?91Qh6Tw85+gM81knztABMIk59Oe4mnnoTVZHdNz8i8Ml9b52w0M+DTT1uqli?=
 =?us-ascii?Q?Gvgc+cpQallPo6HC+xJcgsIwByDyChcQ8u5+5z7o2inNtshr8m55JgQvDZJu?=
 =?us-ascii?Q?WJqnLXLxNH4NV23kMrchLHOgF+nlspW9ASQZb9KpO4rMl7L95oasa6adbV/i?=
 =?us-ascii?Q?DHOnl8WRvKmqtnxYMbSDJCAuutgtCk/wHsDP0K5CCeFnKCnSweKqoRk4a2gi?=
 =?us-ascii?Q?mNTNzkPo7MBVeDkxIBmsbMsU6eQB98gas823dEB/CW1YCL7FWMY3Lkv6f59G?=
 =?us-ascii?Q?EK/UuKnP4wn3UPMfUS4ZHyZQ1nvxXynrQ/NeSL3R0egM87qFyHjyLYOOoHPo?=
 =?us-ascii?Q?J5yORkDfAWUBR40MqIxb7m7QZ4dXQ3yDr1QIqL1RpnKT//C46dPFcg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v6+ZHZ8J60hrJ5fyZimZYO6Mezc+YVzqSEaxdHx4GPhe4gLVjtx1K/vqADo/?=
 =?us-ascii?Q?7H8Bz7ej4CITDwFOTfXDnoOuwtZKFV1beaXr/03FnYwlH6tKpGZnQYA/YBhN?=
 =?us-ascii?Q?M9hqppDq6pE8FrsSQoCn7CEij21RFFiA6CUVZoBEX7SNe7hCsP8+BdKP6DWp?=
 =?us-ascii?Q?htBQ6wLPSqzsz+7yMcLWKzTVvowp2p2rtmKbK54Li98xAA9LG3KY1Sph4EO2?=
 =?us-ascii?Q?sANCIYlKGg7H2WUhqAjgpaVGtVqM/ee9Scr4zMLqNWUpOvHnUqgOuC5+PHCo?=
 =?us-ascii?Q?N1JrjLBSSVIuI6fi+OaKnMHQ5S8849SLnDTLZj28LE7HK8sGKonuRLv7KlZh?=
 =?us-ascii?Q?cvlAyHvUt70Qy6kTXD9up+1HTIIgOjDyKgeWlZ1fNnkfWMfesWhgnp63NhCC?=
 =?us-ascii?Q?mdJQwiMvgA9ZDaAmf8HCA4vgpUReL58Zng68IJDj3kQuIuYhB7yELFJWnhPR?=
 =?us-ascii?Q?aVK1c31JclO7TlqCAL2XQ69KQ6O788UiSwqQdDFCHOhQlQXBH3bJ+Xn5TK3z?=
 =?us-ascii?Q?c7I0j+hfYp54mUyKeT6vIqFE7LrhicnjBTYi4f1M42fbayihMsdQpkpVAPFC?=
 =?us-ascii?Q?uuQsexu0PX0lNxOo+ugQ28g9O4uzlY71ES/woTi62Q6/4A5QudG6208wMKNl?=
 =?us-ascii?Q?iLc+7Ir0+njDRa0XEqLfsdeb6Hn2ibT+WmtWWlRdXcSeIrdVuK8FeoqTmetN?=
 =?us-ascii?Q?KyLycwpC0pdKiRM6uvOHQIpeB9SgKJwI4J8jXNl3wU6rUu7KcGcEsdGwOo37?=
 =?us-ascii?Q?b/w88LKO5OW5jEy6CwbSVxWd+NmGW8Je3ja/yS51NXv6S5zjzX/EjgdspBd8?=
 =?us-ascii?Q?UV+krQ4b/vTnEhc0Pq6HG70wlIdvP34pqDnrHvHLPBRCreS8QNl5Gm7M7rn5?=
 =?us-ascii?Q?pQ1s0S9e+WJVXTsxkFFKKCOGIjERmH6rx5jbDkliLd93e5gtPFUx1lZaBMkF?=
 =?us-ascii?Q?ZEqneVpuEFDUAaE7sJq+C9LYreyl/RxoPL55r3Ocz89H93G0I3sGO/eCyFX/?=
 =?us-ascii?Q?pPVR+O3gUbc/moKRE89xB38MQyi+/Uaees4OUeC2oWcBn6Pmy+KnRrLeQmo3?=
 =?us-ascii?Q?VvHCiUeIXzhnPtncfL7Vsvu4PPDxeujNoEwkELApjx6PBQEcJ5CIhHOCQwVA?=
 =?us-ascii?Q?TE31z7MMfsqHU6w15hYYj/HpXrLUppyeON5y2vMjGzLkzTBpgcN39aV+nrH2?=
 =?us-ascii?Q?TIQ13OTYI7pWWm8iFwG/Y9SHmDSd6JGqCebdhM05JzkHmCXO23BiAwCS8iE6?=
 =?us-ascii?Q?LREwOpMb1iewaQ6feQ+p2DUzBj6/66hXnoVTSj0nSJ4NZ/FXQYWWAvZKgF88?=
 =?us-ascii?Q?EwES1nEHd+AuETk2gkm6UwYWI5xfQxJpTDwK4SDwSBl9d7HxKP5rzPH97jCM?=
 =?us-ascii?Q?SbcP3la8G8NvrZ8HCg6bSvWur9KIQU8TuO7yhSSkXPzZjxxvYlyHU0L6bxFs?=
 =?us-ascii?Q?JcL6XEWiCSWwdqwXErRaGEMGYEc6DOP/fFSJft1r43Kf8GKlizhEv8ND9Pnm?=
 =?us-ascii?Q?3UpmK2bEtTHGxK9k3b9CZ3Ahzajhz4xcHRT+C7MaxSDk8NKa0Q+rrSA8ZURb?=
 =?us-ascii?Q?ZusnNlqhX/sKUjwvXjV8l4tMoK51aSVintVXUGrr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2c5a6e-c5a8-4a80-f069-08dde3bbc751
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 09:42:59.8451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyIc0XdiRNFXtyW/tK8woFIjU4BrHpaedyJuy6yDKJzKYUHXNie78fErWDOBy2mdOfGTSvRv6KFMppvRi59xsPlKLcb07d75r+/r8TxzVlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7944
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

Hi Naresh,

> -----Original Message-----
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Wednesday, August 20, 2025 3:32 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marek.vasut@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Michal Simek
> <michal.simek@amd.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> Ng, Boon Khai <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Tom Rini <trini@konsulko.com>;
> Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH v2 3/3] drivers: fpga: Check bitstream address doesn't
> exceed 512MB
>=20
> Secure Device Manager(SDM) has only 512MB window address space to HPS
> over PSI BE link. The default access range is 0x0 to 0x1FFFFFFF.
> To allow SDM accessing the address space more than 512MB, SMMU has to
> be setup for address translation.
>=20
> A conditional check is added to not allow the fpga reconfiguration for an=
y
> bitstream data where address exceeds 512MB, unless PSI BE link address
> translation is setup in SMMU.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  arch/arm/mach-socfpga/include/mach/smmu_s10.h |  6 ++++++
>  drivers/fpga/intel_sdm_mb.c                   | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/arch/arm/mach-socfpga/include/mach/smmu_s10.h
> b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
> index 209caa86e38..d611664e227 100644
> --- a/arch/arm/mach-socfpga/include/mach/smmu_s10.h
> +++ b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
> @@ -30,6 +30,12 @@
>=20
>  #define SMMU_SID_SDM2HPS_PSI_BE		0
>=20
> +#define SDM2HPS_PSI_BE_ADDR_BASE	0
> +/* PSI BE 512MB address window */
> +#define SDM2HPS_PSI_BE_WINDOW_SZ	0x20000000
> +#define SDM2HPS_PSI_BE_ADDR_END		\
> +	(SDM2HPS_PSI_BE_ADDR_BASE + SDM2HPS_PSI_BE_WINDOW_SZ -
> 1)
> +
>  void socfpga_init_smmu(void);
>  int is_smmu_bypass(void);
>  int is_smmu_stream_id_enabled(u32 stream_id); diff --git
> a/drivers/fpga/intel_sdm_mb.c b/drivers/fpga/intel_sdm_mb.c index
> 5f4aae47d6d..1bbb717015b 100644
> --- a/drivers/fpga/intel_sdm_mb.c
> +++ b/drivers/fpga/intel_sdm_mb.c
> @@ -10,6 +10,7 @@
>  #include <watchdog.h>
>  #include <asm/arch/mailbox_s10.h>
>  #include <asm/arch/smc_api.h>
> +#include <asm/arch/smmu_s10.h>
>  #include <asm/cache.h>
>  #include <cpu_func.h>
>  #include <linux/delay.h>
> @@ -1031,6 +1032,18 @@ int intel_sdm_mb_load(Altera_desc *desc, const
> void *rbf_data, size_t rbf_size)
>=20
>  	flush_dcache_range((unsigned long)rbf_data, (unsigned
> long)(rbf_data + rbf_size));
>=20
> +	/*
> +	 * Don't start the FPGA reconfiguration if bitstream location exceed
> the
> +	 * PSI BE 512MB address window and SMMU is not setup for PSI BE
> address
> +	 * translation.
> +	 */
> +	if (((u64)rbf_data + rbf_size) >=3D SDM2HPS_PSI_BE_ADDR_END &&
> +	    !is_smmu_stream_id_enabled(SMMU_SID_SDM2HPS_PSI_BE)) {
> +		printf("Failed: Bitstream location must not exceed 0x%08x\n",
> +		       SDM2HPS_PSI_BE_ADDR_END);
> +		return -EINVAL;
> +	}

This function is common for all SoC64 devices, but above limitation is not =
applicable to Agilex5

> +
>  	debug("Sending MBOX_RECONFIG...\n");
>  	ret =3D mbox_send_cmd(MBOX_ID_UBOOT, MBOX_RECONFIG,
> MBOX_CMD_DIRECT, 0,
>  			    NULL, 0, &resp_len, resp_buf);
> --
> 2.35.3

Thanks.

Best regards,
Tien Fong
