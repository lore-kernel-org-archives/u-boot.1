Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9467CD54BE
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 20:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A689086C32;
	Mon, 25 Sep 2023 22:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tf9sHxBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D1BE86C1D; Mon, 25 Sep 2023 22:17:15 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 717C286C5D
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 22:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59f6767a15dso43110047b3.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 13:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695673032; x=1696277832; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PGvXiyegDovUyn6u8q7q9R8Wph+cmBI2ghbEcP4sbw0=;
 b=Tf9sHxBstiKgCl0Hp9Cv+n7tHg/Ito2uShMb474Q4bTZe7rqYS5VVYWA904vFLkSoV
 0wBlXuXjlGY+NznUUGY0mW2j2cfCW0Al18x/9luUTRXZkGwLExEgf+yX9X6flokTMPIt
 EfzQNRgHzh3TM6q3j449ql8IshsviJl9UAdXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695673032; x=1696277832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGvXiyegDovUyn6u8q7q9R8Wph+cmBI2ghbEcP4sbw0=;
 b=cVV7xeJiGzMZhiK7kPHiU5Xy77HdhMV6YYjUMgGPJP4pujLFhHoF4NsFiLk5iqi9w+
 szZH1rTM6O7hs68sngUdiId9DqzyBKE9NWQcRrwgDxB0tU3B23KCbFwWvdVYcPwD+lJb
 Xup+v9lwclEzsltWAHTdjoslqDf1eBqDnLHRJnHWgumTSkaohXXdDPHqBzE0l0ZJFpfn
 au0kjuPoQvqriVD9tCli2SwqOKPjuO980PXbdlgPMUHI5FyZA7DhcVs/iDHCarWAtgeO
 8QKsUJI6r9xdmzovQgPcnsOmX76g7dOtyDmybXzB94B1istcCm7l9NCJvvfSiqHKBrc4
 zy+Q==
X-Gm-Message-State: AOJu0YxnCrXrXVT4mPOxmY3LAvhi/mvBtoL0g3CmNR7zbuLArKPkvrou
 T/cZhNS7w4qNQCJtGBg4wH1j6w==
X-Google-Smtp-Source: AGHT+IFqCltfmVStOmKene8CIX/udQuZhPh4MFrkoAY6jlb71B8ChlyPW5QF4uuLD6cksdrs62uIQQ==
X-Received: by 2002:a81:4f01:0:b0:59f:66a1:bfca with SMTP id
 d1-20020a814f01000000b0059f66a1bfcamr469752ywb.26.1695673032159; 
 Mon, 25 Sep 2023 13:17:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 x124-20020a817c82000000b005773ca61111sm2608717ywc.42.2023.09.25.13.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 13:17:11 -0700 (PDT)
Date: Mon, 25 Sep 2023 16:17:09 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michal Suchanek <msuchanek@suse.de>, Nikhil M Jain <n-jain1@ti.com>,
 Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Stefan Roese <sr@denx.de>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: Re: [PATCH v3 38/38] pci: serial: Support reading PCI-register size
 with base
Message-ID: <20230925201709.GP305624@bill-the-cat>
References: <20230924192536.1812799-1-sjg@chromium.org>
 <20230924192536.1812799-39-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gSi++YYNmcC/FXCR"
Content-Disposition: inline
In-Reply-To: <20230924192536.1812799-39-sjg@chromium.org>
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


--gSi++YYNmcC/FXCR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 01:25:23PM -0600, Simon Glass wrote:

> The PCI helpers read only the base address for a PCI region. In some cases
> the size is needed as well, e.g. to pass along to a driver which needs to
> know the size of its register area.
>=20
> Update the functions to allow the size to be returned. For serial, record
> the information and provided it with the serial_info() call.
>=20
> A limitation still exists in that the size is not available when OF_LIVE
> is enabled, so take account of that in the tests.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

So on platforms that end up here, we see consistently:
            eaidk-610-rk3399: all +224 spl/u-boot-spl:all +224 spl/u-boot-s=
pl:text +224 text +224 tpl/u-boot-tpl:all +224 tpl/u-boot-tpl:text +224
               u-boot: add: 2/0, grow: 3/0 bytes: 224/0 (224)
                 function                                   old     new   d=
elta
                 fdtdec_get_addr_size_auto_noparent           -     124    =
+124
                 devfdt_get_addr_size_index                   -      72    =
 +72
                 ns16550_serial_of_to_plat                  316     328    =
 +12
                 ns16550_serial_probe                       132     140    =
  +8
                 ns16550_serial_getinfo                      84      92    =
  +8
               tpl-u-boot-tpl: add: 2/0, grow: 3/0 bytes: 224/0 (224)
                 function                                   old     new   d=
elta
                 fdtdec_get_addr_size_auto_noparent           -     124    =
+124
                 devfdt_get_addr_size_index                   -      72    =
 +72
                 ns16550_serial_of_to_plat                  316     328    =
 +12
                 ns16550_serial_probe                       132     140    =
  +8
                 ns16550_serial_getinfo                      84      92    =
  +8
               spl-u-boot-spl: add: 2/0, grow: 3/0 bytes: 224/0 (224)
                 function                                   old     new   d=
elta
                 fdtdec_get_addr_size_auto_noparent           -     124    =
+124
                 devfdt_get_addr_size_index                   -      72    =
 +72
                 ns16550_serial_of_to_plat                  316     328    =
 +12
                 ns16550_serial_probe                       132     140    =
  +8
                 ns16550_serial_getinfo                      84      92    =
  +8

Can we optimize this in any way? I'm less concerned with full U-Boot
growing by 224 bytes than I am by TPL growing by that much too.

--=20
Tom

--gSi++YYNmcC/FXCR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUR6r4ACgkQFHw5/5Y0
tyxYPgv+JAiOV1PM2hSj/YPWpqFm8p1Bvp/DJMKJ0ijeidbPugBj9zUZTYO+UlWx
/qTMGnZ7vi98Q6SREsChENtyOZXuX088FPxV/Hx2LfWrLMsPURFmZJFWb2Zi9O9L
Zf96hb13rB89K93yfQxeiMx1ayEtGTm3pHMHRTvbhbctUjHfM2SvURnSCBt+uHua
SRuHawYVbmFHljoNL2WIpiA6FQklj0CsM0l5UElH+WUuIADK34rPpXvKbLcJhRWy
u0kd44vRHVg1CVibdggjEBi6zUzEf245BEnRXoHOw1chmIiezjk13XY1j4hC9NnJ
57FVezl6LkohumPTHtwx9Il0UzueqpprbRlujre4qH2G/AZNoEXM8DELocDDzsOt
KjwV0V8MtRK61hcX9YcP7KQ1z1r1rkn5Gzlm6c4nWg1ud6MBxQY2/ZlsgpnCFpyP
OCQrcFjKqxWjSPZ1g/nQnKf1yWO3ou8ItCF7ioD1JsMmRf/H8deB4Ydmit1pMbdu
jAzsPfSI
=6qBr
-----END PGP SIGNATURE-----

--gSi++YYNmcC/FXCR--
