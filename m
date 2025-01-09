Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C11E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 18:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 272EB800D0;
	Thu,  9 Jan 2025 19:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gi3is/ix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F4FE80107; Thu,  9 Jan 2025 19:08:27 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1EE48001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 19:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b70e78351aso97287585a.0
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 10:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736446103; x=1737050903; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/e01hIPxOZa6cpxjbWg6UQR4oQ4IxoQWYcqXkg2SMyo=;
 b=gi3is/ixCiCDQINXywzmVzl1bqvHWkKJlRVOtyexdGrirzjBT4P6+oF1yjASrEWyO+
 AbULpQ9RGPohXTIqlHbzJtGku1RDqio/0CTpbDlSu8FimuZSx1/p/Kvtj1fgzugElYyJ
 +Laj00O1ug6uvv7ktwsITDzHGQO2oZ9ngrwyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736446103; x=1737050903;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/e01hIPxOZa6cpxjbWg6UQR4oQ4IxoQWYcqXkg2SMyo=;
 b=S5mWNPBM+R6CH1vJpYAQ8fytzTfmi5ugDN21y2B2pjRSuC+GDr8ST+apLWpo0Mk9xY
 GhJNq+BlTvY6N9ItaRimyenrE0QQRXhTt4D89zsqYQtFvBbzShrS4Mz+W4bUAX+fXXQC
 mGbschG/6/FDBYB+NCG7SNlP8Y9ih6AT+yreMhlyxMOZ1OoAEAC+8F8Sg40tX5b3DZsu
 3VvwhtJnBOudm72gv54N+mwf17YUO5g0fwMQznvXfzofeanL9PMgB4J9iDsXijN9B/rk
 D5EmY33eO5cU+vXbImbP3tDcbfn1p2a8oK1rHy51DmpwlBuy+wrop5q2ouAzBPYi3UDJ
 bF4g==
X-Gm-Message-State: AOJu0YyE1QIfpnNGvaRtR40ekHqrs7FefWmwDZlUclAUpnmUFSDnIzgK
 8HH7yfHlj5LjtnwS1VZuhDI1mKCiW9WCompzEOWCmWSstuqCG2fGWuvnryGSjVY=
X-Gm-Gg: ASbGncsqpIHsJoaKrWLfXzSI90FGlE0lvl4jmUdm81g492S5B+hr+cY75r9ecqyY/3i
 OluZAp5cXFFoO7C0xRtCIgqGUMgFAH11qCGZyCz2LjsOy1G04/TrUjSzku2ZWr8yIiWcxhNt2x/
 ShPc5g0EgvArIl4j+1I6J2sdPmHHUeDKsp/WSf8HiRUwRvicpR+sqBaTWXIiRRc+gV/GZNgBTCV
 3U7rNERsdtslq0jMjFWH8qdVmgE6VcGdC+gNtGGKEQQYvWmlUqVyMA=
X-Google-Smtp-Source: AGHT+IG/sgQ4a1L8UoaqjXUEHCPoq9423Z39kOK3TtyJc5kycKqRVsYA40T6X+UjsGgoIpM/XUQ1QQ==
X-Received: by 2002:a05:620a:2490:b0:7b6:6e7c:8efc with SMTP id
 af79cd13be357-7bcd97bf690mr1219348885a.44.1736446103577; 
 Thu, 09 Jan 2025 10:08:23 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce328128fsm91352785a.61.2025.01.09.10.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 10:08:22 -0800 (PST)
Date: Thu, 9 Jan 2025 12:08:17 -0600
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
Message-ID: <20250109180817.GC3476@bill-the-cat>
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-18-sjg@chromium.org>
 <20250108182528.GN3476@bill-the-cat>
 <CAFLszTh=HYTxwNSBOOmaiPpG+DO8tc52=XsQQiXAfMSpcwediA@mail.gmail.com>
 <20250109150954.GU3476@bill-the-cat>
 <CAFLszTg+pyMWMW-9rXe9D=siFpk1bbgTq1yk0g-+cms2aKnEuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l70G/xSdBcNUzwkN"
Content-Disposition: inline
In-Reply-To: <CAFLszTg+pyMWMW-9rXe9D=siFpk1bbgTq1yk0g-+cms2aKnEuw@mail.gmail.com>
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


--l70G/xSdBcNUzwkN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2025 at 08:14:53AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 9 Jan 2025 at 08:10, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jan 09, 2025 at 05:36:03AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 8 Jan 2025 at 11:25, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Jan 06, 2025 at 07:32:13AM -0700, Simon Glass wrote:
> > > >
> > > > > This function uses separate arguments for data and size. Use the =
new
> > > > > abuf instead, so that they are paired and in one place. In some c=
ases it
> > > > > also saves an argument, thus potentially reducing code size.
> > > >
> > > > This is one of the commits that globally increases size in both full
> > > > U-Boot and SPL/etc.
> > > >
> > > > Is all of the "abuf" changes just a "tidy up" that increases the co=
de a
> > > > bit?
> > >
> > > Yes, a tidy-up which I hope will help overall. I have been thinking
> > > for a while of how to avoid having addr/size and ptr/size passed
> > > everywhere. For now abuf seems to provide some sort of solution.
> > >
> > > I see this:
> > >
> > > 18: boot: Update fit_image_get_emb_data to use abuf
> > >    aarch64: (for 1/1 boards) all +4.0 bss -24.0 spl/u-boot-spl:all
> > > +16.0 spl/u-boot-spl:text +16.0 text +28.0
> > >
> > > so growth on firefly-rk3399 but not with rk3288. I am not sure if the
> > > growth will tail off as there are more users, though. We might even be
> > > able to be more clever with static inlines.
> >
> > Yeah, lets not do this now then and worry about some "clean up" later
> > when we can show that it does, or does not, improve size.
>=20
> Oh.
>=20
> > And there's
> > something wrong with your numbers:
> > 01: Fix neighbor discovery ethernet address saving
> >    aarch64:  w+   firefly-rk3399
> > +(firefly-rk3399) Image 'simple-bin' is missing external blobs and is n=
on-functional: atf-bl31
> > +(firefly-rk3399)
> > +(firefly-rk3399) /binman/simple-bin/fit/images/@atf-SEQ/atf-bl31 (atf-=
bl31):
> > +(firefly-rk3399)    See the documentation for your board. You may need=
 to build ARM Trusted
> > +(firefly-rk3399)    Firmware and build with BL31=3D/path/to/bl31.bin
> > +(firefly-rk3399) Image 'simple-bin' is missing optional external blobs=
 but is still functional: tee-os
> > +(firefly-rk3399) /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os=
):
> > +(firefly-rk3399)    See the documentation for your board. You may need=
 to build Open Portable
> > +(firefly-rk3399)    Trusted Execution Environment (OP-TEE) and build w=
ith TEE=3D/path/to/tee.bin
> > +(firefly-rk3399) Some images are invalid
> > 37: dm: core: Provide ofnode_find_subnode_unit()
> >    aarch64: (for 1/1 boards) all +324.0 bss +32.0 spl/u-boot-spl:all +1=
6.0 spl/u-boot-spl:text +16.0 text +292.0
> >             firefly-rk3399 : all +324 bss +32 spl/u-boot-spl:all +16 sp=
l/u-boot-spl:text +16 text +292
> >                u-boot: add: 6/-1, grow: 4/-4 bytes: 516/-224 (292)
> >                  function                                   old     new=
   delta
> >                  ofnode_name_eq_unit                          -     160=
    +160
> >                  ofnode_find_subnode_unit                     -     116=
    +116
> >                  fit_image_get_data                          80     176=
     +96
> >                  fit_image_get_emb_data                       -      84=
     +84
> >                  ofnode_write_prop                          224     236=
     +12
> >                  ofnode_add_subnode                         232     244=
     +12
> >                  abuf_init_const                              -      12=
     +12
> >                  abuf_init                                    -      12=
     +12
> >                  abuf_addr                                    -       8=
      +8
> >                  fit_image_print                            780     784=
      +4
> >                  image_locate_script                        696     692=
      -4
> >                  fit_image_load                            1584    1580=
      -4
> >                  fit_image_verify                           176     164=
     -12
> >                  ofnode_find_subnode                        140     116=
     -24
> >                  fit_image_get_data_and_size                180       -=
    -180
> >                spl-u-boot-spl: add: 3/-1, grow: 0/-1 bytes: 108/-92 (16)
> >                  function                                   old     new=
   delta
> >                  fit_image_get_emb_data                       -      84=
     +84
> >                  abuf_init_const                              -      12=
     +12
> >                  abuf_init                                    -      12=
     +12
> >                  load_simple_fit                            580     568=
     -12
> >                  fit_image_get_data                          80       -=
     -80
>=20
> Yes, that's the whole series, so not related to this change.

Yes, that's the whole series including this change, so it's related to
this change.

>  I elected to have two versions of ofnode_find_subnode() to avoid the
> size growth in the previous version. But the cost is larger size
> growth when OF_LIVE is used.
>=20
> Without OF_LIVE, the size growth is tiny.

And even worse in SPL, somehow. But you want more OF_LIVE users, not
less, yes?

> So...what to do?

Well, if you drop the abuf changes for now, SPL won't change at all for
most platforms and that'll be an improvement.

And I'm going to keep complaining about size growth here because a
non-trivial subset of users just wants things to boot quickly and be
small.

--=20
Tom

--l70G/xSdBcNUzwkN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeAEIoACgkQFHw5/5Y0
tyxGZwv/ccClIXXqY12Beb2jigOOC1+/SXbUhtQsilsuOg1hVpsXO71YnwVr9m4s
/e4qLaJ76pz6JgqOEWKO+hqaJfKNJHVtSqyqhwkoIJeipbY2QsARxpfoq0nq0snD
AKtUd7on/vjrq17yCL7jkjdi96JEWvuNfT3RBp1j1R9zfugR+6UPZ5yjbbdsgFBw
f7jpxKvLvcdpB8L2F+oEPOGJqNVSuypC1/w7OQVjx3QEreX21aQbQCVFv7ujoPKP
PdIl7LWkeb4SheEd4y/ZCRbf1k6CUXDSi6zA5VBu6QL5V1TCGU1SSHAZ1QEmy8en
Zwc03vOH1GmKvccJopYyRs/G0xxdEjUxVS9t1YVnDf0knclbBnI3ijWQ+vu3yKc6
pBp5FKfWmJQlI9BppZ6prGwlUGBK3cj0Qx4nveJPlje23hLAxcmpcxMINcTtT1Cf
gYkoGYEpZKEMy4m0WJnVlEdPudCcQJx+M8hX0PbbTS6xCVXLqPDmR9ECzGnfrFqk
XUM7UMMA
=Wnki
-----END PGP SIGNATURE-----

--l70G/xSdBcNUzwkN--
