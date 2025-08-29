Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E6DC8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 04:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFD6E83443;
	Fri, 29 Aug 2025 06:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="L16gzt2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CC7B83487; Fri, 29 Aug 2025 06:52:24 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28A8D8341A
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 06:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQqOxUXJZ56XnYgr/fsVfjcmu7FlQyr0/natH8Wq5StbRR/9mxW5yoJ1gSlxxIaG42YUNYMpdk/200sYswEATuPkIeH/EO+n38BcnCdCDSqk1U4kPGog1NS0OURdK0Q7tWDBBvGDXFaxfy6dvDHO5+wQEOVPQZtGC42I8gQiJT7A1p5+jdFvf9JQ3gmhoGxHqsrO9xwAsjREy9fsz3LeP2BPc1QMBaeb1FIe4T6XmsnlR+uLqylBbt8M2uMXDcEQ1Vw75CJS+qH1qhun9u4fLJB6j5rgBjzUFeNpYoBMXIsCghZWg/HCVcCjOdyCmVq9q7YjbUPFid9vBeXooHKKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkhQUcbphFrhnjZydZDojkeEttqpOiI5YA8iTqKjWK0=;
 b=vMwDriJ1Q9ibHhYG+4o/AAIMsBgXqbCHOgOHMJyWRNeDgRdkvBrHIxmVTektgA2bWfY68xY+AKFrBCgY8/ngo7wZfUkfCgDy3sYnxRj4qxEvbbjPAI/TVE2GQa6Wtrxuzf1x03bWqQBODSA8/KFLSSQIjwnCAM7TewHNs50rV86nKjB7PrureXbssYPL0fAJ79YPbwr2gPIeEeMiIjyuOjLNaIiYnHbbWw+wEO5/NjgSuXzy6rrphI5bH88Xvd6PK8suXlMdNvffyRsr/LHlmSbNinDrViG3mRsg3TfnNZt1VEJVV7hHwKz2rI/jOvNnieac5VCPGg6Ua/zun4esgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkhQUcbphFrhnjZydZDojkeEttqpOiI5YA8iTqKjWK0=;
 b=L16gzt2WDPRsQOHn/VYp1s9WOhpZDQyJijb6iE15a3KP4QGg+Jxit7ZCsi7WuZNBwuOsS3bpgK/iFZCrM+oQrl+hkzmT4eEYd7AsdPRSS1Q4KbbaMeNYwSJ3t9W9TIEJFntZJyuqnTJQq5FT/qKZuG4045eGeRurcXDXF3Sc36yLiN/mUD9UCpCDzYZTIBEWif3i4CO+PJgpAB7JZG57l3pD5EmsntHH4ywKBPYreLkDirSH17vVcsMDyE9R0bIFIG4dhz7iGcBNFc4jHjw3GAMnOwQ5j8NuKw/VoPZEQC+uEJsFv/VQ7Gi75VL6DaP3QZpbN1NX7iB0zr+FplZFXg==
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by DM6PR03MB5081.namprd03.prod.outlook.com (2603:10b6:5:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.19; Fri, 29 Aug
 2025 04:52:16 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::7b6d:7517:b2b0:bca0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::7b6d:7517:b2b0:bca0%7]) with mapi id 15.20.9094.006; Fri, 29 Aug 2025
 04:52:16 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v2 1/4] arch: arm: dts: Enable USB3.1 for Agilex5
Thread-Topic: [PATCH v2 1/4] arch: arm: dts: Enable USB3.1 for Agilex5
Thread-Index: AQHcF+RnP7LRyVNoH0ydtZMdPinxbbR5EYbw
Date: Fri, 29 Aug 2025 04:52:15 +0000
Message-ID: <CY1PR03MB8121C4D1900E02D3FDF9FEC3A73AA@CY1PR03MB8121.namprd03.prod.outlook.com>
References: <20250828062418.17945-1-nareshkumar.ravulapalli@altera.com>
 <20250828062418.17945-2-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250828062418.17945-2-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR03MB8121:EE_|DM6PR03MB5081:EE_
x-ms-office365-filtering-correlation-id: aa608947-0f11-4655-63f3-08dde6b7d39d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9AJ3eja8pMEMjL+MQRwfIcCdNUY0hsGMmuG8dQ//M0xOZZe7/n1vDbJvTp+k?=
 =?us-ascii?Q?55EKLzwVtSugJYnSBD1b8fiSdwJN1Lqhh1h7n4mI8KIDKYfDt5zTpOH60nbi?=
 =?us-ascii?Q?oddlZAijR1UXygANVUFr0DzywxNt998lLsQBcOXdGPmpoH7GdUtJLfEHseKY?=
 =?us-ascii?Q?KRWbY5pgCNlyothla/6hzu6BJYY1E77njvUI4ZSQSIKHQisRCJTQK3nbQwxI?=
 =?us-ascii?Q?nESjWBPotcCl8EOSrn68ufcAgL/PXxBn7tgW1UvmbIQDsTKHH4hVZrli3ti8?=
 =?us-ascii?Q?bRVK7+XYgLAWiA1d9WXLTzmUduQvV8VXxPgfpzDR8vcZS5IVG2ekwERQYw64?=
 =?us-ascii?Q?6N8lm2o4FFtz0YFPIJqlmAmXgp2w3ayZwPGRn0g10jLjmLKt4Mu/RQcxDmQq?=
 =?us-ascii?Q?EXy9L5RSWnP1nm2rQuBKvNwSNkBUanio8SfiRDGB/qJLzAPd7Hwn3xE3+mKQ?=
 =?us-ascii?Q?XNsj958D3igw7YWP7BT09bMAIzC3c3QZcZ96EE2d1W3mh4KgkKhIQzMDYIKL?=
 =?us-ascii?Q?bUctTkf6v2yTqAwGjD1w739cg9HKBHaNCiFmSe3/Ma81bXUTOxomiUs155JR?=
 =?us-ascii?Q?fGG/WVskQ3LW16eyydEF4tvGgH9MN9o93+c4t765uZNBsQM6SW+LvLRklEw0?=
 =?us-ascii?Q?dxQd9pAYNRpQKAQ9b1GIGa7grDzDolzFio2gQO4j+k94mRXd09uzzOckVLdn?=
 =?us-ascii?Q?Lz57DAkQgkvNuJE1wDafG4TZgEtBf+N+zMBgt4kv6Ap6J2yvrIruxQHl67oF?=
 =?us-ascii?Q?1EXIq66XxiaIaHGIkncbk+ZCSe1KDVUBNAVUtq3dWL6VGI6oIfPQBU6kj7jF?=
 =?us-ascii?Q?U2Kdj5z6A5gHyGLrZOFl7J8m1qFI3LDCFnExHH9bcU/Iy6iCBbk4C+7IyoMJ?=
 =?us-ascii?Q?WSwXBNbZW5QJg5o1Q2L9riw0NEw+kkC7PPZxQ7vfK8NnQrCJQmVQUSJD3pJw?=
 =?us-ascii?Q?jlDMhSNLxjw6ob5+khrB8Xav6zKSHldL7e+6vS+TuOa8X89/Fv6oRe9765vx?=
 =?us-ascii?Q?JRBOEYRF/D1B6twfnFVqpzYG3cFrhyjrZ7GJ6b/DgJXVVmGyZW81MS3n26U+?=
 =?us-ascii?Q?Y0h/Dv22wzOErCaI/K4Mgjy5ZjIg2hWEDtwuZNlZZOKuxpQbLnUcxK+2Udzk?=
 =?us-ascii?Q?6NSsmq+shKNXw9G8RSfQjm4anEZt0FKM3pMyTiiepySXHm9W0fBd+MTzrWH5?=
 =?us-ascii?Q?kaHQjmiViWyeIm9qEWwy0koQW0GLAy1tbt4X27GwT0eZZZhGcanxqxp+iKpP?=
 =?us-ascii?Q?JzU4KPTYwB/9hrmvO5yMvmzhaHsmDJ6hXjtu2T/4tlCOPxpTaMd7ljFmZjc2?=
 =?us-ascii?Q?4jtgki6hB5yhZb6ljCknHsYTPz8cvjwJiN5HQhODgGkkCf+/f61P/4+fmGiZ?=
 =?us-ascii?Q?jCdGz+GPU2cR5gyAQ+DdAg0wZkkKDqzrkJkOdMd34qxCvMQHEA3PcIZkyPqM?=
 =?us-ascii?Q?ygFfIPl3VU8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k8OTheKWR4/tyeKcpX3PCMMRNT4nEBwciJJebm6Xk9mRyKdCd7kySx8NYVWD?=
 =?us-ascii?Q?oSF+O1XWupAioEHFFbihsQA4SUmn5jnRHXPEoHVRegwLufLFvZJa7i4EHJAb?=
 =?us-ascii?Q?9rFtWWqgTvCdiIaDB5e7JyGGCzcnpfuubCCltmFIUiKDFIPZOyEHyS8tfAQn?=
 =?us-ascii?Q?oKHwRWfexpsOKH2nlg2ReyXtBFKbVVfMxmslJH44H/daH+qV3H64easpoyw/?=
 =?us-ascii?Q?uKic2xLmblRBQtL4rANoxQiHvbxT0kvpDFNKg1XUYKki+OkZA6O2fmENUZwT?=
 =?us-ascii?Q?f6nemQCwuwLLZrSbQQyir/Dv0eT0vzgBA1J+o47FaADTdqFZYQNWBGHs5zz8?=
 =?us-ascii?Q?9H42KqtsVUOQ684ARuVBF8cv9pey8pLf8WHvbeA6iXmCjhUtRIW6k8wBIk6o?=
 =?us-ascii?Q?nuE5vZxZSiMleozQhSJidy/1R8gXx/5yB9zuDbI4dMgzyFsW1gfvALvk4DzX?=
 =?us-ascii?Q?7qnvtHfNXMIpauclOzlVrF2vuzagieyg7c7LIy4EzbDBn7czwJRd8hjLb9In?=
 =?us-ascii?Q?Egy2A1yG6qwN7CeGIjQHTE08oHUIYfxidpC23OlqGXZRhEo51cAd08byPa1J?=
 =?us-ascii?Q?xRrbWmHLldtvuw0igiQJ8WS7rEPzbIlDgVmJhQcKI6XBAw3Rd+81SYfKiYfb?=
 =?us-ascii?Q?bKHzt3QVBZmMJDxqCm+UbMGcgVvmOC2zmcmQnWFOQGYVSoeEUsOHM9srj2Oa?=
 =?us-ascii?Q?zB6XDyV+y4ud/RUQFaO37Jt2b7cbrBtRvtW5KR3YMRVdLS0sS3T6QQTWcMj5?=
 =?us-ascii?Q?/doA+eao3abkAjpqUMAHk7uSMFDyRKcvr/c4lGX63TJP3KfCjdy1juliuEcS?=
 =?us-ascii?Q?YQ9QfjmcWL0RMFyYHFEEmsIGSgVjOGWAkGcCitDj9xOGz04pFJJNzYaWpQvK?=
 =?us-ascii?Q?l/xbEdsVMXch3oBonM2mtXXVstjOvfqpU/Jfr+OfJ/j1VsuWDoyTUm9yfDZm?=
 =?us-ascii?Q?yKQG2CE5Pf6FQmTJpUukV13wWm4I6OC5y0mUSIRIvZ0Y4+JrNLZRche6oWuB?=
 =?us-ascii?Q?F4FLkmjqmAbIkckKqrPdye4Q98w1GsMf5sbOsc8QDThLRF7w37yvINSqSoLO?=
 =?us-ascii?Q?Tn9AA10G3ZS9UtiHbrp+sIZgVVvCAcMYnl7ebTOmmiLOywjDEK5HB7dwXpSY?=
 =?us-ascii?Q?aHmBaliKAwa1pSgujcxKL8KFGghHZJF7qfg575jJ88FVxYxXp55HIiHd3V27?=
 =?us-ascii?Q?7DTl+Uhf99Su0cVx19ruzAdU2sly+/2+w1rNqW2gczRInTnnr6tkJU7/6j2D?=
 =?us-ascii?Q?+HMmdjzjkL5s5IaAyTaDc5BWqK+J5vaqVJldydimIWayrgzlOav2qA+tDBOA?=
 =?us-ascii?Q?r2Z/e4GmiwHNcjXPwrm4p7BbW3jyhaAE7OB+I8bcRPWPB/muP4erCuoSyEhG?=
 =?us-ascii?Q?/VOblwIDigGUFH1KLnAt0nYcgjKaEzT6gmVDjiJ5r7zOZ9y/dt+zBG8J35P/?=
 =?us-ascii?Q?TwVAtKAmB0SszbJl8uG9ktD6BqvN90q8S81QoikCocxD6ZhmQKkSJeB6N1Ud?=
 =?us-ascii?Q?fkL4Uk1805f8jjbUxA0fV1mOV+rcJD4/UJpKJbE58fo191YLLAXAUC2zND2s?=
 =?us-ascii?Q?eLEi0dy4vjZjq5Web9vJRLHR3Mos0Zm01gMHuzsi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa608947-0f11-4655-63f3-08dde6b7d39d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 04:52:15.9982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJsETAK+wKcCOLD/Y8hqf4JtduVf+7Q0DerMtzoEAwzacjnvEYHTZPuvn1bU2jwG50c4AYDniySWnkb8XBBBD9Y5BAuwsjJYbinaoIuT0Nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5081
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
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Thursday, August 28, 2025 2:24 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marek.vasut@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH v2 1/4] arch: arm: dts: Enable USB3.1 for Agilex5
>=20
> USB 3.1 node is enabled for Agilex5.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  arch/arm/dts/socfpga_agilex5_socdk.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts
> b/arch/arm/dts/socfpga_agilex5_socdk.dts
> index 2ab143e38f8..86e6d374948 100644
> --- a/arch/arm/dts/socfpga_agilex5_socdk.dts
> +++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier:     GPL-2.0
>  /*
>   * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>   */
>  #include "socfpga_agilex5.dtsi"
>=20
> @@ -87,6 +88,10 @@
>  	disable-over-current;
>  };
>=20
> +&usb31 {
> +	status =3D "okay";
> +};
> +
>  &watchdog0 {
>  	status =3D "okay";
>  };
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

