Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A9BE6C5E4
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 00:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E40A885F4;
	Tue,  3 Dec 2024 01:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dGylrHkc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01384885F4; Tue,  3 Dec 2024 01:38:28 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D228E87F3B
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 01:38:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4669eecd88dso40551911cf.0
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 16:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733186305; x=1733791105; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Kfp5VnpHgp5Am9C/yWJn3p7IJyLlHLgW1kR7B/l12kE=;
 b=dGylrHkcZuaaMCDPyGYPCLQ3p8OHIx0nOCRFP3KU3rHu+6cwojU2iTNdC10XvCB30j
 g69UoGINS/AzuuIFf6VbvT/zTNjYSuOr+uzFO+pNtMbjFU/n63puU8Jbig5MCP+1WxfW
 U0HCEAOUB66ie7bE1TKRt3UhgF85XgzumJPNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733186305; x=1733791105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kfp5VnpHgp5Am9C/yWJn3p7IJyLlHLgW1kR7B/l12kE=;
 b=WTYcrDSUoNcJ0oX8GqkKCc8Ia+e7FTpGZdjwI16sjE/riZS57YZyAiSxArTowv9US0
 XYYvJZGNst8j1Dn64dZAQY77tsnGxjs62FXAJfZaz95+95j73u/UWJqYzqmoBZLco5VL
 ncmfiUTLAjQadQmL1FAqF8nGyZwC+qhXXjdwVnimdSmjRGo04kwilPJRh/f/Im3YpUua
 nZXxEHIr/6NFHFKammRqy11HYPkOyt9K2v2FfqPXK34C6KPTuQKnm6CX/wtvA6aEddep
 77aSgo4s6ROkWqlCEgT0oquGIh5Ol/eytm1iy2Scq48RyIPdqYTzCOBaMah5K5HCo94a
 cQCQ==
X-Gm-Message-State: AOJu0YzZhUZCb09FLK6X9ihXNTi4i1XG+ISiu/52HtuIzJnMGMTL1ulw
 o+QrtaRL8UhZRRepMdqfPx+H+1l+tibYPJk1+YA4/H6s4N6v15q7JciGZ/gI1W/U1QiA2atmZpL
 Qr3o=
X-Gm-Gg: ASbGncvcG2qfrgCKxscju8j/HSRElfpTUGdPGerGITmH6pnGolWtg+GWiGVL82jBQAX
 GuqwOYHW/Dz4JDgtip3nCPQriDWtmL7erbCX+9jt880oE+ttftQ+eP9fhnyYWSBfrz0Vio6IUps
 L9xH1rni5M/BboOp+O+3v6E0fIDWM9xi/Sko3HQihmajl7dES1KPYyQD/BzdnyYN4vtn0Dryogq
 QNECbkjL5+QVna1mWfhyK8zv4kqhMfckDKjabRTh6X8/PljQQ==
X-Google-Smtp-Source: AGHT+IGPljz4GvkpCybmo0J0htedTvH6PDh4UYDF5HHFzNU/vptRvgoXnLrw0TpNnL0m5PiVqdVN/g==
X-Received: by 2002:a05:622a:1b86:b0:460:e593:45aa with SMTP id
 d75a77b69052e-4670c0de337mr6198051cf.33.1733186304724; 
 Mon, 02 Dec 2024 16:38:24 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c407d435sm55093301cf.40.2024.12.02.16.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 16:38:24 -0800 (PST)
Date: Mon, 2 Dec 2024 18:38:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v4 04/25] efi_loader: Add comments where incorrect
 addresses are used
Message-ID: <20241203003820.GO2457179@bill-the-cat>
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-5-sjg@chromium.org>
 <20241202201832.GH2457179@bill-the-cat>
 <CAFLszTitE4Gq+LUEm64ro2eL4_VME+gDh7s2jEnBTmVvkgX9sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pfK34BclhloWzE5I"
Content-Disposition: inline
In-Reply-To: <CAFLszTitE4Gq+LUEm64ro2eL4_VME+gDh7s2jEnBTmVvkgX9sg@mail.gmail.com>
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


--pfK34BclhloWzE5I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2024 at 05:22:44PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 2 Dec 2024 at 13:18, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Dec 01, 2024 at 08:24:23AM -0700, Simon Glass wrote:
> >
> > > Some functions are passing addresses instead of pointers to the
> > > efi_add_memory_map() function. This confusion is understandable since
> > > the function arguments indicate an address.
> > >
> > > Make a note of the 8 places where there are problems, which would bre=
ak
> > > usage in sandbox tests.
> > >
> > > Future work will resolve these problems.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Please just resolve these rather than introducing a patch to then fix
> > them later. This is something that should have been fixup'd before
> > posting. Thanks.
>=20
> That was deliberate, as I wanted people to see the problems. It will
> save discussion on later patches where the problems are fixed, if we
> can agree that these are actual problems. If people are happy to add
> review tags to the later patches then I'm happy to redo it.

No, please drop this patch. A "TODO: This is wrong" in several places
and then changing it in another patch does not help.

--=20
Tom

--pfK34BclhloWzE5I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdOUvwACgkQFHw5/5Y0
tyyqQwwAuUW1iMDjuDSTTksg1kQMPVJ4zMswsOaLfcJMZUJE8ErA4H8zDJFKGBWy
nF7Ns/qSUXOdO/WmZ+Ild6uoHP7eTQMBHfdKzA/O65Ii4BMeuBX4HpJHJYgNM/Nl
XUOkHQYh+1ASchNZvhKN+m1ZQDMYSZ6DkTwnWO+wTTfv4gKf9XvZnfwGsQAftt/i
36dTXAUOzjJZR6AIxVq0GY1KXUGsAkpoShfVo4U/u5OxxIQ9VwHiEIMKKHXKp5sD
/DrCOYmyS5Z46jA/4bTIjrsCC8CLu59AohDXuQjLGQ/BlhtoyxT+FAGUQTvzfhnS
xfVwrOh6FgR4CT71QqMYKulTuldvd/zbWlV7PneDl4Z6CfvI//qADvdwwGxqTVo/
YHkpvnWGVFBfWZWV+5D6RHYQwmXLdWgnrIF7703CulwxUG7BQHTu8dnw4VcwMqjI
s9uJAWJbysKKwfnzwFStYoB/nWRmO5jXcaxOMSG65FVHL/lBC5rMaocNyxAXpa5v
suSmjYmE
=RJkG
-----END PGP SIGNATURE-----

--pfK34BclhloWzE5I--
