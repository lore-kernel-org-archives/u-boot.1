Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F02C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 22:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDBDE80FDA;
	Tue, 29 Apr 2025 00:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nsMIuOB1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9768780FDE; Tue, 29 Apr 2025 00:50:51 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60E3080F03
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 00:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3fea67e64caso4397313b6e.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745880648; x=1746485448; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CHuM5JIpbdvTp/w+/EE8mmyrf/NnF9ySf13YugOJhdk=;
 b=nsMIuOB1dfleIfSrLtQ2oh61hTPTuH4ptGx5sOHwYK56w2vzFXVPQVMZF5ypg3v2ch
 dxFtrHC2dBFeZIgXgDLSGDYqDg1HLwqlmotfqlCj38ZnTw9ZsNljwKaBm27pbYAqAQUu
 5IOptZzXMwpRaCUQbVfdt0/wrjflVfzTO92/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745880648; x=1746485448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHuM5JIpbdvTp/w+/EE8mmyrf/NnF9ySf13YugOJhdk=;
 b=h7PiNW9ZOZ3nNB3JMb0MCo++QeaEswc628cw0GpC0cuszOoNi4GRtBFPFknfrrFL3G
 CVXpyDoQOtmEXCiLEBmmXvISeGJEiidQcO5xRxcb5J6RxkY+NxiIR0RNOVX1x7q/v7Bu
 V40KEIx3f9fKTpxd1VHcG3ZiIUXir6FOEctoHx3hwmCj8Z1+XU9etCnl3MfGgXuiRnyw
 rZblHjJWP29fYVrkozh9KpVkWZsxfdvP1xwAAu60ZprDbXlqda6fgIJykDSHQEs2zent
 v2ca+eaCKYK9gURz00O2dOS5t/5q274G7diwwr6ASTgLyEU0NIHB/bd3BvTvUi3p/Mi0
 Fz5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqA7P/WwoOYmMgZWE5C8tcD61Qh6o8IbXXFwOkIn2GNfA8GZws0C6dCxJZ9vmso2S8SLKrbbY=@lists.denx.de
X-Gm-Message-State: AOJu0YxZwz/efRiLq+NlvhDB5nXW2t2oz+fXxhT6qaoA0dSCr+SIHb/x
 FQSdfvgK8EwisS03CtM4a6lCJIiIitqGm7L5LreOX9rwD2NY7qna3y7kmCbU6SU=
X-Gm-Gg: ASbGncvn/EpfwF3hLIx4dhiUsK7+SEnVV9HMxnOCT1KtoHK+mJestx2w9/KOOZZm4eI
 8ANwTUDkkN/otqwFpqtqCjY/sHTD0A7HUu/zJ9ToaSAsLtyc61OWupbInoRxLtJ8eGxkZMhfwzh
 mj3jm8Eckvbhb+WGwOtKSkuEqGrKjHMTXXkafcW+he1w2ioSVLXBsZvzvMW+2JgqV2lhU3hQM7M
 XSkLRfyXbSiV2aZnWvgJDovfCuBhOAg0t/wud/iNkEhPhTAblX68o20Kbt9b0yQZSgF6VIHelG6
 TEFlmkXPloKiuWUjZA3G+lGmapk8eyL1MSQOGKfNiL4kFU0bButr9CJBwps4vzY+AgQt6KN+SyL
 bGw==
X-Google-Smtp-Source: AGHT+IHS/oCBpB34VMxDtFv9w+gLmq1rb3kvgdN3Mv8rZ/Q1NDhbqVLz1bLgt4+G57w+eFe+rk+xYA==
X-Received: by 2002:a05:6808:3383:b0:3f7:e1f6:20a6 with SMTP id
 5614622812f47-402107015acmr1055387b6e.0.1745880648093; 
 Mon, 28 Apr 2025 15:50:48 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40212925533sm23145b6e.11.2025.04.28.15.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 15:50:47 -0700 (PDT)
Date: Mon, 28 Apr 2025 16:50:45 -0600
From: Tom Rini <trini@konsulko.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Anurag Dutta <a-dutta@ti.com>,
 nm@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] include: env: ti: mmc.h: Find DTB files in dtb
 directory for AM57xx
Message-ID: <20250428225045.GO5495@bill-the-cat>
References: <20250425053431.1622267-1-a-dutta@ti.com>
 <20250425053431.1622267-2-a-dutta@ti.com>
 <01ad9412-f1de-4628-aa1d-9fe391872fa5@ti.com>
 <334d7a69-6b84-4a0e-aeb0-f581008d3e79@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="veG8fd54qqDTjlas"
Content-Disposition: inline
In-Reply-To: <334d7a69-6b84-4a0e-aeb0-f581008d3e79@ti.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--veG8fd54qqDTjlas
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2025 at 08:00:44AM +0530, Kumar, Udit wrote:
>=20
> On 4/25/2025 12:19 PM, Neha Malcom Francis wrote:
> > Hi Anurag
> >=20
> > On 25/04/25 11:04, Anurag Dutta wrote:
> > > Add dtb/ to the DTB search path.
> > >=20
> > > Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> > > ---
> > >   include/env/ti/mmc.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/include/env/ti/mmc.h b/include/env/ti/mmc.h
> > > index dbb0e3559ea..968d6ec03dc 100644
> > > --- a/include/env/ti/mmc.h
> > > +++ b/include/env/ti/mmc.h
> > > @@ -24,7 +24,7 @@
> > >   		"env import -t ${loadaddr} ${filesize}\0" \
> > >   	"loadbootenv=3Dfatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}\0"=
 \
> > >   	"loadimage=3Dload ${devtype} ${bootpart} ${loadaddr} ${bootdir}/${=
bootfile}\0" \
> > > -	"loadfdt=3Dload ${devtype} ${bootpart} ${fdtaddr} ${bootdir}/${fdtf=
ile}\0" \
> > > +	"loadfdt=3Dload ${devtype} ${bootpart} ${fdtaddr} ${bootdir}/dtb/${=
fdtfile}\0" \
> > >   	"envboot=3Dmmc dev ${mmcdev}; " \
> > >   		"if mmc rescan; then " \
> > >   			"echo SD/MMC found on device ${mmcdev};" \
> > Are there any other boards that use .h instead of .env other than AM57x?
> > Would they break with this change?
>=20
> Yes there are few
>=20
> include/configs/am62ax_evm.h:#include <env/ti/mmc.h>
> include/configs/am65x_evm.h:#include <env/ti/mmc.h>
> include/configs/da850evm.h:#include <env/ti/mmc.h>
> include/configs/omap3_evm.h:#include <env/ti/mmc.h>
> include/configs/omapl138_lcdk.h:#include <env/ti/mmc.h>
> include/configs/phycore_am335x_r2.h:#include <env/ti/mmc.h>
> include/configs/ti_omap4_common.h:#include <env/ti/mmc.h>
> include/configs/ti_omap5_common.h:#include <env/ti/mmc.h>
>=20
> One way, I see append dtb in search path in patch 2/2
> ti_omap_am57_evm_fdt_map

We need to get these converted to plain text environment please, thanks.

--=20
Tom

--veG8fd54qqDTjlas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgQBkUACgkQFHw5/5Y0
tywM5QwAky/w/oRVR6MxM8i3cb2jyw4sN0STT3+K0KeLRCFEPGoWqHm9LHwF8Rup
sLfVwACtza2JlzBltNLc5Pj7iTuaf4xChMWtlt71MXaZyG9eszTtxHlp3BsOrUIA
TJbCUQwV6b9hw32XTZ1yz7OP6wu27V3a2NKeR6AY0X7HrzwF8FfuPItCKVN9i/+V
jZje9Z2ItsQrRomm3cJdeBxfwMCCW+H2eoXDQGTm7DQrYASbh5PRfSAY764GOh4+
BouZiSt9LiOCb7E7BcEhLbegU1YwE8Kyt2gzaHufsbLJC8Ij4pwvTMyERNx2sQCd
qSoNyVefODab+a22hcMhfH6AEcLKfG/x5uJyLOhkI2ZFE/oPHJDaNVzdkJWRckAG
RoQW+24Wpl1t0ht7fpKOd+EuAQiP68nlOKpmFiLAy67HbnbWViUe0j/Fd5hnj93J
a3Kmb+slfLDiOXHaQ/QIjSIQs5xblVrgxejXVrecTlsVNcU3BuP2CO/o5muq6zbw
0XKhXmET
=7qb0
-----END PGP SIGNATURE-----

--veG8fd54qqDTjlas--
