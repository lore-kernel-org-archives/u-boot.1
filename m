Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3E0C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 08:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 021998331B;
	Tue, 22 Jul 2025 10:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="S9pfIbfj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A22E18331D; Tue, 22 Jul 2025 10:36:32 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92DE7832EB
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 10:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmoRqzGOWH/+NJGmX3gCoS6Fx5F09XRqYtfxkNm7qORZ2Md19ewlo4cvTIDe+QjJseVNxHi6GOYEpywklNUXB/M4D83MpHiHQu79c7dprofXWfkMFDdsj1+hC+swRHXTN76TmZXFmgmis6Yj5LkQsUQh7KzBQ/MydlVGkLyzvXnUBV4vtoNeYDT3JOQXFoS1sQMGi9DPEpcvA5wVsWHFDyk/gfR/U3bSf/gdmvGYBrBkZm510YkGgj5GTclB/GZd6oaaiiqsq3ZhefJ8tjj3XSdkYKa52N024WuRq3Tey/9Nyf6Q3XW/A5Bejd/wcQIkAqAKbh44zXqYx0ge6775xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH8E/HoSybWLX8d1AUb7W6OAa7PiGDhFAZbk+u7Hjkc=;
 b=oRdbe2S+Q7kS+Xxc6jlc65YLJPaBDp7lh/m5RIExghN50wPCg1iihpo2edn1gNFYenKpgH9ecSPpcTptQb12+l9psmSxXQ81WmSlU/XQO46ek9QdAOBafZyYHPoaONi+Dx33CT6vK31RQkyhLa6toC2niUqW141/KPLI5QVvNv5Yz9IgFv+VoIqkrj8o8y1EH1ifGJ/6xnRmHRAwKGBue6hrUMu0GAr0sM+pKaa1d2Kb9E/tRilZwzl7v1FPcMVMrGpwQI7RQ+GUffvfU5ko8Dej3/i4eUe4UAR8VjbPUNvC/jAfKNS3tdRleBRf9moY2Qn8IFXyfbmW9aK8pt6Yjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH8E/HoSybWLX8d1AUb7W6OAa7PiGDhFAZbk+u7Hjkc=;
 b=S9pfIbfj3skwbF+UV0xH2s2lF4HQQVAjv/Kmez2J5g60NfGc7DRRfTZ7bj+bgx1dzkqT0rFL/+qtpVJRPtUiVV4pu6D5pZRaikc3wft42Xqul1wFIwzesiU8UXNo9TzanzbS6SmME5I/BftXQKfzRxTsSw5mM1EAMoaTfVZzqeK2xHKt8v0IZdk74Jbdulzhqd9duRdvrpbklNfpjSxtq43xJHTcsdKtA1KztbUo5XZYf82SM/KYyc1YMsKVLPxotajlSIrPiDQODtKvi6yGq4LcrrnOONKkDT1tq9Yrq6dsnzLb648y8CaDDsKoLUyu3LYXIXtcls0HzVSYDokVSw==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DM6PR03MB5019.namprd03.prod.outlook.com (2603:10b6:5:1e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 08:36:27 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 08:36:26 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] arch: arm: socfpga: Fix header file includes
Thread-Topic: [PATCH] arch: arm: socfpga: Fix header file includes
Thread-Index: AQHb6kRMkg5x6hguIkC5VzRxCNORILQ98tgw
Date: Tue, 22 Jul 2025 08:36:26 +0000
Message-ID: <LV8PR03MB81370725BEA1AE73417CAEC9A75CA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250701045448.9622-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250701045448.9622-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|DM6PR03MB5019:EE_
x-ms-office365-filtering-correlation-id: 2b09ca93-e85a-40b8-b165-08ddc8fad93f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?00jiOkGmsN/JKU/9T4ItwPJ+P7hZzqcdBKf+lmuMEWUoLoMUpsOO6d297YJy?=
 =?us-ascii?Q?R5H25GFTuSPpV6u5lVpX4jLL+gUTEtFj2/lwN/1vkAS+I0KlAgCld6m1X7PK?=
 =?us-ascii?Q?IpNj6D5PU8RP6x6lFAXutP3IyAGd4nBAV9Xtei4lHyn5hO3fkBD5RtITK03y?=
 =?us-ascii?Q?U/8KAAoD3y2rVSREZDlE30LEqG5og9anGZnoqK3e2j0ro+vWXKJvY8FVDg4Q?=
 =?us-ascii?Q?tZnO5ki3ok/zn1kHXTxR0UMAslhgA8N1U9SIfTtHMW4TK4mQ7QSgjdC8ORQT?=
 =?us-ascii?Q?7vYvWUr5FSoxhxAZUqsXI8MICZ4CV09yOfW0fFtE6NIGGmgzWjLv8oyhdBfP?=
 =?us-ascii?Q?gLek/d1LBlnibHZ/i/uonhEyVnTAR3ERJjEYWzxRt9QjKKhj9Ck4Mo3/2GB7?=
 =?us-ascii?Q?jylcPS1DebpFjr/Lyc9aVi0YkSmX3mEhfaU4qzr/IXIvUVzbVnMNGIRUrRHm?=
 =?us-ascii?Q?IP94Oah3BaUGuO/TDvKdbWI9rnJgff7XuA6vp3dBPZG60OnjiF1/6yhuRy+F?=
 =?us-ascii?Q?eC8KTIlUzcWSsR+eBdinWJ67iUtAP6rbnJhU3bC68SbkvebgDdahIU7632HU?=
 =?us-ascii?Q?67a+uKFweAM0BXFayrpAcdNL+HwcjXWTe5EhnJ5C7n5tT5Rwub9wKJJ7NLgd?=
 =?us-ascii?Q?zMM/sqVvpKyS1yAQQub4DVlltYd4SvU/PYumyF8/kPlEc6+sJbUdcR55CqV8?=
 =?us-ascii?Q?WtvU1vGdqbtNARLYM+C0lzlKruBOMDvlxEozIhpEApLLBT+n8O0oBNVOrNKn?=
 =?us-ascii?Q?kaoy1EobPyEmGvuIhCxjmLac7USBX+WTLUTMS71Nxp3Fy8Ya+dU4X4/x4n9Z?=
 =?us-ascii?Q?nj2hw1C9VJM1FAhLhir1FXXMR4TTYGp+oxXAZxpGQwycjhw+jUNZNGwcfcd2?=
 =?us-ascii?Q?IXo0FU8t2FvwS1UKarZm7aHRmawhJ4DpLecODd7oAgclJOYE/UDyzf/4O3hU?=
 =?us-ascii?Q?gqgTrfVtYOOR3oE2JZ9jhuodqUwcvq9A6G7jrw4I0S/C+CqSL2RQLjCV+hA6?=
 =?us-ascii?Q?kqYingOTxKZuNKkzvEi/xg4XF7OH7WS2GWJe3C6hSGi9cd2RUKJGZKujyd52?=
 =?us-ascii?Q?TrAkxyBSQvCFRddt35wxBvb+LIbMBLLwphUllR69Pj88jnEGIStDmhoT8HvS?=
 =?us-ascii?Q?cIepJbcLsNSQ7Qkd+OWS8fEHWX8SoW4B2gVCxOddYr6ILjFoOdxaXB8N8k5Y?=
 =?us-ascii?Q?ZamFjdgFP3tyvEDaaPDQek+seYalJ3YPyyHBhADk4z0b75YWQwp3OyrxpnT/?=
 =?us-ascii?Q?7eI0eQEvetvUmhR4yXxAA/tY+e4CL6lT2eKoS0BAxLGLyoaW2CD2b9pSgVlx?=
 =?us-ascii?Q?2VTgtJObYvL/8SrD+nnq2AX/7ryZiEBfH41aBGSXN/bV7M/maavibjXj53mX?=
 =?us-ascii?Q?uEhjKgWvUVoOtG/NHaeINWWjLDnlfb/xdh9p5Z+5eJwgz42TaLABJJIKDYS1?=
 =?us-ascii?Q?qV3ZAphRxme9X0inaZRPLqXe22fxP6NTffXtHklVxcKt4D6sZLE4Bw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iZi1wO+y6lNfmndNPHmqAF1QH13yqJCtzCBhX9dEri/GkZk9Z59MpYyMKZDA?=
 =?us-ascii?Q?Fr5tkCOwaWCXdjeDzm15GZ2FVquQrLVAo8rNgD6qzdSeKMI/lgtIymKYuBk9?=
 =?us-ascii?Q?lEe4dNldOPlYP5lThDzA/mZg2qZo7j+ENdFDfTAaH8uuyzeb6obUQrkra2Hf?=
 =?us-ascii?Q?lLDmJMhyrdAoeesxgT1IUtraPE99NtnulTJKBSmmYpANBAVSMXFsEVy0uqbG?=
 =?us-ascii?Q?ELF8kqxpwdctull+RgzYUSPMb+yznno8/pDgnPXIB7804ZgPQw1YYIeZEQi2?=
 =?us-ascii?Q?j0sziFzNysA8ordV4I6C7YdFd/L5Er6KrM+6MRx72bECNWXyCaMcng5SZpjR?=
 =?us-ascii?Q?wfyLoIit+4uWuqfHGbSFJwL4HgHBTTtdw5FfYH/TVPI8Qx7ba+ypReTvIOC9?=
 =?us-ascii?Q?WDjml3nbhKX5j8+/ROOPTsP3Hm76gp0mHGSk8I0CoePByhtjmqI6d2Ccy5C2?=
 =?us-ascii?Q?P7jg3NJ+GnYrNt/BIYIK9ANYWy06ytabrDgW1DD4svw36Ke4XeFdFvdPcX8u?=
 =?us-ascii?Q?+GWSHrb2F/6aGWrIxaGPpCDGjebixGBJ4Pq86KQE/C9vISP0jNEx14lxrfaA?=
 =?us-ascii?Q?qBoEM3jgS0mYeydGQPXg5rKqe5K/n3d4JTEPigveXAz3Vw/TjjxvUzziGsF6?=
 =?us-ascii?Q?lElebv8RqSAopTQw/Hv8JlKUMCiOp6CJHl0RT4y/iyxUULSrMU9y4yZNTZaQ?=
 =?us-ascii?Q?535tiNNdSuQoF8yJFzy+fDKGEpZyGj+6b7o17TPVyavgXGfnv6vpQQcwYRjE?=
 =?us-ascii?Q?4veNVznu/vzTxewXD7OwRgS15W+2GgMnNDdK24VXwfmp/0pnoEpgIUVwTbL1?=
 =?us-ascii?Q?0DshE/wjfwX51/upeYlgsIPAna5vjcbrwzZuoT1r8AkIEC/riSVXnK+MLjyt?=
 =?us-ascii?Q?ymZFh15wz5TxPyKElc/ecnTWjxOjbjwlQQ/AykVCGMNQg7UmsMwqxjggdOxq?=
 =?us-ascii?Q?fN7uPkM785wufT8EaKf6aQOeru0NHwSJPASoU/6g0h3kxjrBpFo4G0HuEesi?=
 =?us-ascii?Q?zv8SDPFxoAWbAg/2m9qVVh17/eJK3zWhbzxBOzQEKVA32Ky5PYPEc45DMF3h?=
 =?us-ascii?Q?IJkHzrmEiAJ2oTqqmRFhfYyHqtK1hog/PfqDCOW4D6+ndV1Rb1CWZZGV5D9B?=
 =?us-ascii?Q?ydMqpAgOJCyhdDPry6wjyY81wU9W5ysIN8XyUcnKtSMBvYFFXJcwpsO1rr4v?=
 =?us-ascii?Q?ntCQVDGRj4X12b9nS6wQ92zAFEv8b4yc+1lywOa04mFJBtcEiRRXCjPMJV5Z?=
 =?us-ascii?Q?kJ6Lh8sOKTbabLcu1BzsX+QjRI6MbCI/hCq8ZdWk9zzo6HmgXsG7pvLNMvjq?=
 =?us-ascii?Q?jUIg55PFNUzKyahVzTIH9MaEzbSWdl8HOyQdFX42p0d0rBX119xypVEHkYpB?=
 =?us-ascii?Q?GSu9fhcjGAHyPz205umFDrbrzHEhQ0Rk+wpONLjzeg7Td9aaZnn69fMCmz8Z?=
 =?us-ascii?Q?P2pyPPjjxsJd4eYZRwMCQ2NrkhcYYeSYirGIDNn7FPuvl9zmCOzAkw+HWvc+?=
 =?us-ascii?Q?nO3aonL9vdCv4cqnRPeBGsGEm3+CEMV0SaW72I38lkBnSPZuDK9qf7cNdNqx?=
 =?us-ascii?Q?l6D+x2GLBg44ezugJaSIBhEaeEyl1OBkFSRs0TB9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b09ca93-e85a-40b8-b165-08ddc8fad93f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 08:36:26.8603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPlJpGiLic2CuKh6t9UjGuATxitltsYcv8tqlTpOwYjewOBnK2iYLzPOqjsH/JSs8hzqxCS2o0oPeOJRT30tbNcxi4lT9wo2PBCrw/U8uJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5019
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
> Sent: Tuesday, July 1, 2025 12:55 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] arch: arm: socfpga: Fix header file includes
>=20
> Appropriate header files are included according to U-Boot coding style.
>=20
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  arch/arm/mach-socfpga/secure_vab.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/mach-socfpga/secure_vab.c b/arch/arm/mach-
> socfpga/secure_vab.c
> index e931f1043b3..9bad2873a49 100644
> --- a/arch/arm/mach-socfpga/secure_vab.c
> +++ b/arch/arm/mach-socfpga/secure_vab.c
> @@ -1,17 +1,18 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2020 Intel Corporation <www.intel.com>
> - *
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>   */
>=20
> +#include <log.h>
> +#include <malloc.h>
>  #include <asm/arch/mailbox_s10.h>
>  #include <asm/arch/secure_vab.h>
>  #include <asm/arch/smc_api.h>
>  #include <asm/unaligned.h>
> -#include <exports.h>
> +#include <linux/delay.h>
>  #include <linux/errno.h>
>  #include <linux/intel-smc.h>
> -#include <log.h>
>=20
>  #define CHUNKSZ_PER_WD_RESET		(256 * SZ_1K)
>=20
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

