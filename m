Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F0BCD6901
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 08:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE4C786940;
	Tue, 10 Oct 2023 10:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF13864A0; Tue, 10 Oct 2023 10:14:52 +0200 (CEST)
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com
 [61.152.239.71]) by phobos.denx.de (Postfix) with ESMTP id 24F1686D59
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 10:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kuanlim.lee@starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
 by fd01.gateway.ufhost.com (Postfix) with ESMTP id 131C383D4
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 16:14:43 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Oct
 2023 16:14:42 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 10 Oct 2023 16:14:42 +0800
From: KuanLim.Lee <kuanlim.lee@starfivetech.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Cheehong Ang <cheehong.ang@starfivetech.com>, WeiLiang Lim
 <weiliang.lim@starfivetech.com>
Subject: RE: [PATCH] spl: mmc: Resolve emmc not load image after switched hw
 partition
Thread-Topic: [PATCH] spl: mmc: Resolve emmc not load image after switched hw
 partition
Thread-Index: AQHZ9bCNy1u6JRMnxUuVKA8o7Cp387BCt2Fw
Date: Tue, 10 Oct 2023 08:14:42 +0000
Message-ID: <4c05105b92894041bad3c706c2ed5c34@EXMBX066.cuchost.com>
References: <20231003041720.893-1-kuanlim.lee@starfivetech.com>
In-Reply-To: <20231003041720.893-1-kuanlim.lee@starfivetech.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

Hi,

Is this patch considered as accepted?

> -----Original Message-----
> From: KuanLim.Lee <kuanlim.lee@starfivetech.com>
> Sent: Tuesday, October 3, 2023 12:17 PM
> To: u-boot@lists.denx.de
> Cc: Cheehong Ang <cheehong.ang@starfivetech.com>; WeiLiang Lim
> <weiliang.lim@starfivetech.com>; KuanLim.Lee
> <kuanlim.lee@starfivetech.com>
> Subject: [PATCH] spl: mmc: Resolve emmc not load image after switched hw
> partition
>=20
> When selecting MMCSD_MODE_EMMCBOOT as boot_mode, emmc do not
> load U-boot proper image after switched hardware partition.
>=20
> Signed-off-by: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
> Reviewed-by: Chee Hong Ang <cheehong.ang@starfivetech.com>
> Reviewed-by: Wei Liang Lim <weiliang.lim@starfivetech.com>
> ---
>  common/spl/spl_mmc.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c index
> 20f687e138..dc8a45222b 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -447,6 +447,9 @@ int spl_mmc_load(struct spl_image_info *spl_image,
> #endif
>  			return err;
>  		}
> +		err =3D mmc_load_image_raw_sector(spl_image, bootdev, mmc,
> 0);
> +		if (!err)
> +			return err;
>  		/* Fall through */
>  	case MMCSD_MODE_RAW:
>  		debug("spl: mmc boot mode: raw\n");
> --
> 2.34.1

