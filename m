Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE38E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 893C4806DD;
	Thu,  9 Jan 2025 16:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EkFKZzoh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CBA8005B; Thu,  9 Jan 2025 16:10:03 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4003806DD
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7ba0fa25f07so79756785a.2
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736435399; x=1737040199; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aNxp2xWaEVLbULJALCHy9vyGMHgqroHoKpVvXFLECu4=;
 b=EkFKZzohxV+DV6buJ77WYYFQEYTMYh7WPjHu52ALi5/CmoZDOgBTfhVyZEYM/Qff3m
 vN5Rh7KeGhbLEseWHrgYw+Hx3bJTyftiVwo9CjQt2jI+HN114PiU629L2lXT5HJ94QUL
 sselirmz/+e3H0aNCJ9vWpgbsaxdGZOocAsnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736435399; x=1737040199;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNxp2xWaEVLbULJALCHy9vyGMHgqroHoKpVvXFLECu4=;
 b=gVoJvjbpVBc7uqCoOeYwdo6LdsqyVR2SJbUmvvenH91oMx72K0jW1xlGiJw0S5Cxd8
 0laf77Rp5Z34Ogp4Tc0EhD3mG1ceL2/Vs28/UG5k/NPk1Uzp7WfVnNceqYc89p3moxS+
 t/KyaaAqhiM7UuzklkNbph+HJpHUddD6Nwb11ZsbrXnpgrqfjX15p33J5LvaEmkLvS2p
 33sbChgNqACXoTPbi7p5xShKKA5lfCNjfI+/9f/ybR+XHdMduUv751DVkKglbgm/66gK
 8NvW6vitxnTEzaPLGE91q2ObTbZSbKF42Kn1Dj/UGG1qmtqY5weHgGLULUJLa5yRgSUb
 jcSw==
X-Gm-Message-State: AOJu0Yx1QD/seQOvCU7Vi07TNjcyT53/zmlEkS26/X6JGAUifzhmmFvm
 bbb8ZymL7yqFj/icG0YFP10BEPedfgu5Z+X+r7i54GiXQLN+pSpgQ1Ns6OeGrUA=
X-Gm-Gg: ASbGncu2LMv9+RfuBXjPqgIBAdfoTo4YkfLTqYnsamHSvHqMpQqPG6jfcJKEkiBTrxL
 2akC+I/dMDSUXB1DWTs/G+gqiGOOrM3Yuyf+LkhxEEbXWJzxdf1yfcpgBmNHnFsNOga0y5KhT2D
 ptiS6VtrV0hsk7eP4kCDt5F606ZwTIpWWetASG2RO8vuGTlpwtsWcp6MannBJU8H6TPJEWRLb8y
 FQ0b2JXloVYOl4rQJXYgYl4tT/EnYwSeqruMsv2BB1QGKM9gevrO0Y=
X-Google-Smtp-Source: AGHT+IESGvfxEP4srU9qFOm1c98TCHi1JbxzB/D7LXJVrsfxiZ2vR3hPqkb52NKdPmc5eoTffaSeiA==
X-Received: by 2002:a05:620a:29c2:b0:7b8:5629:5d65 with SMTP id
 af79cd13be357-7bcd970d48cmr503749985a.24.1736435399593; 
 Thu, 09 Jan 2025 07:09:59 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce35160c6sm74763885a.114.2025.01.09.07.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:09:58 -0800 (PST)
Date: Thu, 9 Jan 2025 09:09:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Dahl <ada@thorsis.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Julien Masson <jmasson@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 17/33] boot: Update fit_image_get_emb_data to use abuf
Message-ID: <20250109150954.GU3476@bill-the-cat>
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-18-sjg@chromium.org>
 <20250108182528.GN3476@bill-the-cat>
 <CAFLszTh=HYTxwNSBOOmaiPpG+DO8tc52=XsQQiXAfMSpcwediA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9UpsjYNLJz9vKI7A"
Content-Disposition: inline
In-Reply-To: <CAFLszTh=HYTxwNSBOOmaiPpG+DO8tc52=XsQQiXAfMSpcwediA@mail.gmail.com>
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


--9UpsjYNLJz9vKI7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2025 at 05:36:03AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 8 Jan 2025 at 11:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jan 06, 2025 at 07:32:13AM -0700, Simon Glass wrote:
> >
> > > This function uses separate arguments for data and size. Use the new
> > > abuf instead, so that they are paired and in one place. In some cases=
 it
> > > also saves an argument, thus potentially reducing code size.
> >
> > This is one of the commits that globally increases size in both full
> > U-Boot and SPL/etc.
> >
> > Is all of the "abuf" changes just a "tidy up" that increases the code a
> > bit?
>=20
> Yes, a tidy-up which I hope will help overall. I have been thinking
> for a while of how to avoid having addr/size and ptr/size passed
> everywhere. For now abuf seems to provide some sort of solution.
>=20
> I see this:
>=20
> 18: boot: Update fit_image_get_emb_data to use abuf
>    aarch64: (for 1/1 boards) all +4.0 bss -24.0 spl/u-boot-spl:all
> +16.0 spl/u-boot-spl:text +16.0 text +28.0
>=20
> so growth on firefly-rk3399 but not with rk3288. I am not sure if the
> growth will tail off as there are more users, though. We might even be
> able to be more clever with static inlines.

Yeah, lets not do this now then and worry about some "clean up" later
when we can show that it does, or does not, improve size. And there's
something wrong with your numbers:
01: Fix neighbor discovery ethernet address saving
   aarch64:  w+   firefly-rk3399
+(firefly-rk3399) Image 'simple-bin' is missing external blobs and is non-f=
unctional: atf-bl31
+(firefly-rk3399)
+(firefly-rk3399) /binman/simple-bin/fit/images/@atf-SEQ/atf-bl31 (atf-bl31=
):
+(firefly-rk3399)    See the documentation for your board. You may need to =
build ARM Trusted
+(firefly-rk3399)    Firmware and build with BL31=3D/path/to/bl31.bin
+(firefly-rk3399) Image 'simple-bin' is missing optional external blobs but=
 is still functional: tee-os
+(firefly-rk3399) /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
+(firefly-rk3399)    See the documentation for your board. You may need to =
build Open Portable
+(firefly-rk3399)    Trusted Execution Environment (OP-TEE) and build with =
TEE=3D/path/to/tee.bin
+(firefly-rk3399) Some images are invalid
37: dm: core: Provide ofnode_find_subnode_unit()
   aarch64: (for 1/1 boards) all +324.0 bss +32.0 spl/u-boot-spl:all +16.0 =
spl/u-boot-spl:text +16.0 text +292.0
            firefly-rk3399 : all +324 bss +32 spl/u-boot-spl:all +16 spl/u-=
boot-spl:text +16 text +292
               u-boot: add: 6/-1, grow: 4/-4 bytes: 516/-224 (292)
                 function                                   old     new   d=
elta
                 ofnode_name_eq_unit                          -     160    =
+160
                 ofnode_find_subnode_unit                     -     116    =
+116
                 fit_image_get_data                          80     176    =
 +96
                 fit_image_get_emb_data                       -      84    =
 +84
                 ofnode_write_prop                          224     236    =
 +12
                 ofnode_add_subnode                         232     244    =
 +12
                 abuf_init_const                              -      12    =
 +12
                 abuf_init                                    -      12    =
 +12
                 abuf_addr                                    -       8    =
  +8
                 fit_image_print                            780     784    =
  +4
                 image_locate_script                        696     692    =
  -4
                 fit_image_load                            1584    1580    =
  -4
                 fit_image_verify                           176     164    =
 -12
                 ofnode_find_subnode                        140     116    =
 -24
                 fit_image_get_data_and_size                180       -    =
-180
               spl-u-boot-spl: add: 3/-1, grow: 0/-1 bytes: 108/-92 (16)
                 function                                   old     new   d=
elta
                 fit_image_get_emb_data                       -      84    =
 +84
                 abuf_init_const                              -      12    =
 +12
                 abuf_init                                    -      12    =
 +12
                 load_simple_fit                            580     568    =
 -12
                 fit_image_get_data                          80       -    =
 -80

--=20
Tom

--9UpsjYNLJz9vKI7A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd/5sIACgkQFHw5/5Y0
tywAcQv8CMEyVUW/1eWTOQnRM2nxiqkb++ys5fjsmAsr/d0ssDrtwqtVP6tJHUMF
WJWY4avvQoCKVmGSiVjW8/RYJN9dFj5qt7ao3WoA39OrDN4bAMZoNlyd1tTBDLWm
Hz3lWCribXKnSsGHMKFt58qyTSSz83BaniYYETXCVRR5tP1orFmmKFWYW2bSjM86
bPDCMyvZUufeW4XrOW1jvlLevVU8zWcKf7S2vo/wKzOAzOuee7YPPpvqRKY+e83k
Zj/cRQ0kXFIowlwE0lCaayk4q26VQ+c+LXf7ODmJVlRd0tkPTtavEd49l5/msKei
7p0zxf1yD3m8Hp8WFFaWxR78B4Hedrelr6Bhhk/66007EqUc4YacRSXpF9Ne4dvr
9/KrHNsUMQelqxWCNyCd1rNkX9vXf0/jBVJ3xcQJS40u4FWRtxBESyCzLVN0LxuR
quPN3UU3Ry+YmQPZzNU6WQmkdzUq2cIqd0izkaQgmytECfWj2UvAMMw7QlcFDXAt
ir/EZcH5
=0FbZ
-----END PGP SIGNATURE-----

--9UpsjYNLJz9vKI7A--
