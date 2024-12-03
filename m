Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503EFE6C5E3
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 00:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90FBD89555;
	Tue,  3 Dec 2024 01:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lz+INy6Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10D528951D; Tue,  3 Dec 2024 01:55:49 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C525F8933F
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 01:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d87f00f786so44254376d6.1
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 16:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733187345; x=1733792145; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gMAkpXKjUmBTGQwjknFFNeQ0n9v/svKo0bYJ8QpbdTQ=;
 b=lz+INy6Q1A8fha1WjDL7SWeICjE7BWX9Yyk/kdUasVy/VCvn33iWOBZgX73z7ZbwjL
 fGs1bH5uf2xKJi7IVcAW+T06x1ztsUYHCvjRbWMQpwsmpppNzXyHyDBPpFIQHCWGY+8O
 OuiEAiXGhrWd8vqifI+WdQlttUkXWKKaR8P1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733187345; x=1733792145;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMAkpXKjUmBTGQwjknFFNeQ0n9v/svKo0bYJ8QpbdTQ=;
 b=g5zfvRnmuh5kmKRABntjm75YiUheEhJPLlOMNjZFuw/t3LLDBe798Mn/F02w/wtTW+
 BI81BE8gJ4yQXC9YTlZE83pQRfmr4TbgmyLUJRKMafjd/4fqnFeXXkFBsmm/unVouxx0
 /+Vt3OKUj8q3358dxDJNowFoyYyWZEWWOZ2xz0w7lwrev/LqH3vUF2dmsBh8mmIhS/P+
 5+JhYwS851V1Xopew1g6iEDJf/X2vQ+B8vMiBLe0929KEtQsbOPw3ffqVZ/C9Wmyfn8r
 dImzZGjGaS1hUZDMvwfz5RvKYog/0fRLneGjp7Peg8AgOyJscw5c7DxPzBvcVRzG1R7b
 iR0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX64epAsuq8W33DcLtbgRIye+O8+Gs+eZWAsG/6E+PBOuLiVXvc4AlTs4nbDNOTT9l8x9vgiE=@lists.denx.de
X-Gm-Message-State: AOJu0Yyu3cxRQyYzPY8WokisAS6Db8OhuM3BkUWMqonTkgcUn6XvwOzr
 zIfyxSppsTG1tA7y4uL9vXqApPrwwdmT2X3FZhk+/FQPgx3Fpj4j5fFNfSszFe8=
X-Gm-Gg: ASbGnctHniy+TOTW5C05Uew9Sx7pAWMpA3C1u7fcYD+dYx6zZAbwXEXjdHrI/IZnijA
 peCY67Vau4MnP9wNcNbOfYzqdMAWjsUFrkgEaZe/ychiR3oCRQ+1e9D7C2ZM/0eqpLFtbivBEvS
 HWT/sxzh+4IRj0N/ms1EgqlrJbPQfPgqC+grEsQogCe6JmXzCPQ11KuwEM3dhlE8B37zE8GV9qn
 VbF2eesvUBlvjHBvZ2rKl+RtxlP5CI1knfTb83JBQYUoXqIlA==
X-Google-Smtp-Source: AGHT+IFY6luTxV3CLwm5VwSiCAWAMtjGB5T9KEbrHNLmPxt2K8VSt6DeZB6/NbYj+8OSuwOTayYOPQ==
X-Received: by 2002:a05:6214:250e:b0:6d4:1a42:8f03 with SMTP id
 6a1803df08f44-6d8b6fbdf79mr11178296d6.0.1733187345693; 
 Mon, 02 Dec 2024 16:55:45 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8a9d0ee80sm15329056d6.44.2024.12.02.16.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 16:55:44 -0800 (PST)
Date: Mon, 2 Dec 2024 18:55:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@linaro.org>, mason1920 <mason1920@use.startmail.com>
Subject: Re: [PATCH 4/8] Revert "fdt: Allow the devicetree to come from a
 bloblist"
Message-ID: <20241203005541.GP2457179@bill-the-cat>
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-5-sjg@chromium.org>
 <CAEfUkUKGKMb3rXS7sSDQnPTHs2iOcYFN8zbViajjDSp+aHzXZQ@mail.gmail.com>
 <20241202162239.GE2457179@bill-the-cat>
 <CAFLszTjvnyE4vFQ=Z=Ma1bOjH_Z4JEdUWM51Vc_nRmSUkRzF4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="17pcFQ0F2caLMtoU"
Content-Disposition: inline
In-Reply-To: <CAFLszTjvnyE4vFQ=Z=Ma1bOjH_Z4JEdUWM51Vc_nRmSUkRzF4Q@mail.gmail.com>
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


--17pcFQ0F2caLMtoU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2024 at 05:22:35PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 2 Dec 2024 at 09:22, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Dec 02, 2024 at 09:26:42AM -0500, Raymond Mao wrote:
> > > Hi Simon,
> > >
> > > On Sun, 1 Dec 2024 at 09:43, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > > This stops coral, bob and kevin from booting.
> > > >
> > > > The correct way to do this was always to use a Kconfig option, so l=
et's
> > > > first revert this broken idea.
> > > >
> > > > OF_BOARD and BLOBLIST should be general and hardware agnostic,
> > > do you have more information on why they don't work for a few boards?
> > > Maybe the way to handle these logic within certain boards should be
> > > changed other than to revert this?
> >
> > Yes, I'd like to understand the whole problem better since we had a
> > forever-and-ever thread, compromised to what's in tree now and now you
> > want to revert the compromise and bring is back to what was argued
> > against for forever-and-ever, at least from a very quick read.
>=20
> I'm sorry but I believe I have explained the problem in that forever
> and-ever thread, so I don't really want to re-run it. It may be that I
> was right all along?

Or maybe your use case is still badly explained, and your changes will
instead break other platforms.

> Raymond, I cannot pass the DT in the bloblist from TPL to SPL on x86.
> There is not enough cache-as-RAM, for a start. Plus the DT is in the
> memory-mapped SPI flash, so it makes no sense...

DT using x86 is a pretty odd case. I don't recall if you mentioned that
before, and it's likely everyone else assumed you were talking about
something more standard. Of course, you're listing one x86 platform and
two ARM platforms as needing this change. Non-chromebook Rockchip isn't
generally broken (or several other people would be complaining).

So something that may or may not be explained in the longer older
threads is how the firmware in these platforms are doing anything with
the device tree?

But, the biggest problem I see with this portion of the series is that
patch #4 is 'Revert "fdt: Allow the devicetree to come from a bloblist"'
and patch #5 is "fdt: Allow the devicetree to come from a bloblist".
What you need to do instead is squash all 3 of these in to one commit
and then write a new message that explains what exactly you are
changing, and why, instead of making someone else do that in order to
review  your changes here.

--=20
Tom

--17pcFQ0F2caLMtoU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdOVwUACgkQFHw5/5Y0
tyzIggwAgikoAc0MjLZ1KYbHlTQH8xZOlPqqL49BXONkY88YSw+xG3XD3Xpp1JGd
2O4BXkwe7U6RxMtAf8HJLpoAzOT78I0c8EYx8HKap+h9TgPhaMyOgrfXQSHO1OJ0
aR8iazjnEpQ8rWPklWJFeosLQL27BH0ZgSFeDqzdKhJ2ySV6mtIA0NCDex7MZr3l
eDst+3g46wONARxRakEGm1TRl2ssTkszyeNOYU+ce5LvRV8RAM6B6wVrKqEB3B8+
yd5gz+eoKSwD2Czt1UfP4zidFFqR69yUNvzUVoFTX4iMZ/xXLSQex89Y/MxSqCpt
/usYR8ynoviDwdmptegYY6T8SHbRVUWkT48vg2bJ3HLAx1E6grJb/vXmpMsH1gGw
XJ7SCiJTTlGhbZWm2GGx4oCkrtW1EnC7TQ1eQwQicqg3biIif4TyT330WoWpFhpr
H3ZrlJ4eyPwriIG2/aTWkgYLW43uSPSKGr+u0hfj+iZYa72osB9tyFfyz+H0QrL+
lS86D6cv
=ahEw
-----END PGP SIGNATURE-----

--17pcFQ0F2caLMtoU--
