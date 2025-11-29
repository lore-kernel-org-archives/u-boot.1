Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103BDCFD2F6
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 21:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D64837F2;
	Sat, 29 Nov 2025 22:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H1XeYCoE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC2418382A; Sat, 29 Nov 2025 22:21:48 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4F0C83759
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 22:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-596ba05aaecso2681680e87.0
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 13:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764451306; x=1765056106; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pu92qOUORHUCaresmVO6jndigZgWoihMccT1DsSXwN8=;
 b=H1XeYCoEha6QfEwdVib5h6xgl21Df8cEQKCeyDMCfdxZJTMxAo26GOhtsNg/QfiYqg
 /lDbmIfEXOxKFC+D+2/hQx2MPuhnMljtN7bGv46W7FRa1Fbjet3ur1edur/vpvw02VLO
 u8U8mm4xDys4W1sKOQTd3o2cLFOAv/hia1PLLAUhpXA8kmvawKYru3Lomh/7s0Zk4MRv
 T8GBK2bZwSFkQVXgvkMvYMADpmGaUnjysaHdktDijL5chCE4aGIEIztxL6Brr8jAQfS0
 QSMfG9OH5DHdJZDuK1gu6ShIyFZbJ6XKRqaI1hyRSeuDdl5kGahSTyh23W8AWAODNR4E
 IOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764451306; x=1765056106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pu92qOUORHUCaresmVO6jndigZgWoihMccT1DsSXwN8=;
 b=mIjNnW6KmFI1CeNmD8W+OKUzeaIxd6bX/80pE7SNKQ7vpvyyZXxy5dc4XYe9pwe34q
 qXVFpKy4IWJrMQ8JeeBWRVzgYaXBukmWQEvvQCgIxNbXH0+GoBOYIKC5TPocJ4YGuVCf
 jqKMLl6UlMgTqWmskqHqRqaZrbYd4Z/pnnr1NONANGVAHBfKRTWO8XnfW+7Mo4eb/KGY
 wZmJCco9nbvah94ACHzzNE+ryruH3uxNzbIc+7M20W6ymDPe4mfsh5RqnLvWB4TQzlpx
 yoPuGeApvKnXhD73Bxfyx9EBgL6JPHNvWttkqOhfLLizwuGX5w0SFQH52VDupqX1cSvE
 UXiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW7ZN4Tso38xLSSmw59EbPisbmk6CgXgxhWVLLK1X3lvhHIpfCHChUWwEd3T+ajQ0suim2ccY=@lists.denx.de
X-Gm-Message-State: AOJu0YzrI32pSc4xiIAQgVpWVM6VtB+yXu9CG/C8cv3sJ2ZMgRE3lxa9
 Su8ZI4XTzqL7WVOCSQ9InP2ErqHCl44bJVe1m9ayHC6aSf+mswwTLjxs3gzUICs+1qO2vWDEtAR
 F9/L57EPswxPg6AVfJQWUV8RHV9Ibsys=
X-Gm-Gg: ASbGncvLREvz23mJT3eLL704ny1hkFXAAav9bzxlUrWr5sWX6hsuk1ndKotGX7/g/Ob
 saESnXWglPkRNAPpeucZ/O5Ps0OmG2qBmLc7vhcEKYqmkICTxRNAcBoNP0fL4YunqePvLP3wO54
 jsd/wCD4iCi7tHM2xS2/S9knUVX5/lCVWO0BZkiypw5nJnE40HR/+eIECYI8Jx9F6/dbs2VNiwA
 TXFNHuPOsYxuoXRuVcCUUfkin9IWBkxc0wXgfSJd8WllSql+3mVgO1BEmpvJuzJ9+lo/4hWGAKQ
 hhJbrE7/mGX8GGEjgBG+Ez/HW4c=
X-Google-Smtp-Source: AGHT+IFYj+l1vrrVHUAMsV6VJwfvPFfdq/uytRi0y7PtBNPBlLJpfg2QluFS3OtdJJ/J40xX9OqIBujWo8jaxAsputM=
X-Received: by 2002:a05:6512:3341:b0:595:81ba:fb4 with SMTP id
 2adb3069b0e04-596a3ee4fd3mr9699424e87.47.1764451305830; Sat, 29 Nov 2025
 13:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20251111165509.212632-1-frieder@fris.de>
In-Reply-To: <20251111165509.212632-1-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 29 Nov 2025 18:21:34 -0300
X-Gm-Features: AWmQ_bkXpOT1Y5bZdVmpocaPNwZMYyfhJ0UcS7cVEmQUj61rpjtNvsCrALeefTE
Message-ID: <CAOMZO5Df7W2QYmy3HVVEF6FiOYzTpmiGMjTeGs3RZcesrMtYVg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add support for Kontron i.MX8MP and i.MX93 OSM
 hardware
To: Frieder Schrempf <frieder@fris.de>
Cc: Stefano Babic <sbabic@nabladev.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>, 
 Eberhard Stoll <eberhard.stoll@kontron.de>,
 Ernest Van Hoecke <ernestvanhoecke@gmail.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peng Fan <peng.fan@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Vitor Soares <vitor.soares@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Yannic Moog <y.moog@phytec.de>, Ye Li <ye.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Nov 11, 2025 at 1:55=E2=80=AFPM Frieder Schrempf <frieder@fris.de> =
wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> Changes for v2:
> * drop DT fixup patch, and add workaround in patch 1/3
>
> This adds support for Kontron hardware based on i.MX8MP and i.MX93
> OSM (Open Standard Module) SoMs.
>
> Frieder Schrempf (3):
>   imx: Add support for Kontron i.MX8MP OSM-S SoM and BL carrier board
>   arm: imx: imx9: Use arch override for env_get_location()
>   imx: Add support for Kontron i.MX93 OSM-S SoM and BL carrier board

Series applied to u-boot-imx/next, thanks.
