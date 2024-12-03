Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC752E6C5E4
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 00:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 575EF895D2;
	Tue,  3 Dec 2024 01:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tRCyMeXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64A3289588; Tue,  3 Dec 2024 01:35:45 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43ED887F3B
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 01:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4667931f14bso51897021cf.2
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 16:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733186142; x=1733790942; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uoGOwUXFXHT/f5Yw1MP6xq/5SCk5kdZm4AYbVQXSom8=;
 b=tRCyMeXUnMFHHzrQTHLz9+X0/1ewWu1f4Ptb0vfLaRU4/5g4u01zUy87LaWGhzPe+d
 jPukB+clCTPmrh1tf0mgli2WlDF4XLqso9wH84zAlendcFLSQzs/fpQaspPxK2vKZ1/A
 n/i0uz8enZT8rthwBQ1ALnucNq6EcT/aMhLPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733186142; x=1733790942;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uoGOwUXFXHT/f5Yw1MP6xq/5SCk5kdZm4AYbVQXSom8=;
 b=quv1I+3miLNaPst9zshrcGZbzGA7P+X9ZKNmLQNTLiSLu8VTpUo/RXsIIVxO+b86/x
 rKHpLHY2ZNpuK7Fj9+7ZtNh3b+oH6aFH/adxpo759j9mfW7WzPWR33oQM/8rULh2yUiu
 BkyTzORuoUhRxEk2P/4QZxBxsKRUJhOSxCv1PU+zC9IlWo86Th2qyA7QRyjSOpPgzYXz
 EQoY+BKe5IeSDN2xfGS6/mnsOumy8TRXXay4SpFnIuxB3i4cTg5jOF5WEXQaZdRqrr1W
 WVf02qYcYbFw18lAFcg/4BWFJFWhjjYzcT0n9xxafKPYRTAuUqlD9NRUTJg5Ug03mmAu
 oB0Q==
X-Gm-Message-State: AOJu0YxD5bvYnqEeTyE39qxFeEchiBcEsQpzk/H9wyU0rD2GqjUkgs3f
 342rjuDLCOT+i1m+Ou4NILte7B9dD3fTs6LWe1DW7JiAyu2U9weBdNfHu0+Hi8U=
X-Gm-Gg: ASbGncveS6Vpj8eKFnn6JT/MsT5S/RHdo3uDHgHVRAXUBpjzsu9DYtAZQjW0uTnDLpE
 vXOok29r/uJHZ3KJYQ7RiGzrRVBpycgI1YX0aGkAXSdzIX2rLbTop8FldVrGbaKotd1Njqbepdd
 Z6mKiIBFwGNZrLQQHbE9bb5CLyAWlRp1Z9xU25OoNU/csEzYVnqXBEFCHqEwUGqPw1MI2L6MxZW
 d3ucTynUwsN2wW3zTAgvHVIPpRpnsDisEoWNOzaAl0TlKhItQ==
X-Google-Smtp-Source: AGHT+IFipYsdIMoSaLcrp8N5N8b3Li9zB9GmHSHtc5f5cscrhtOkXh7SuZ9gxdtRKru3TdhecwbTeg==
X-Received: by 2002:a05:622a:8d:b0:466:9938:91f3 with SMTP id
 d75a77b69052e-4670c73aa94mr6307161cf.49.1733186142139; 
 Mon, 02 Dec 2024 16:35:42 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c407daa8sm54980881cf.50.2024.12.02.16.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 16:35:41 -0800 (PST)
Date: Mon, 2 Dec 2024 18:35:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 1/8] CI: Drop extra condition for sjg lab
Message-ID: <20241203003538.GM2457179@bill-the-cat>
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-2-sjg@chromium.org>
 <20241201164017.GS3600562@bill-the-cat>
 <CAFLszTj=8ux3kjM-gCa+MZrOja-Qh+VLYoB0VKRy3gabv5pqmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7llD9OtUCCU8mGz8"
Content-Disposition: inline
In-Reply-To: <CAFLszTj=8ux3kjM-gCa+MZrOja-Qh+VLYoB0VKRy3gabv5pqmQ@mail.gmail.com>
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


--7llD9OtUCCU8mGz8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2024 at 05:20:12PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 1 Dec 2024 at 09:40, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Dec 01, 2024 at 07:42:29AM -0700, Simon Glass wrote:
> >
> > > The rules part of the template makes sure that this doesn't run until
> > > specifically requested. Drop the check in the script itself, so it is
> > > possible to trigger a run manually without re-pushing the tree.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > You don't need to re-push, you can just manually re-run the pipeline and
> > set the variable to 1 on the webpage.
>=20
> OK, well I don't want to have to do that :-)
>=20
> Are you wanting me to change the commit message?

No, please drop it, it's not required.

--=20
Tom

--7llD9OtUCCU8mGz8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdOUlkACgkQFHw5/5Y0
tyzA4gv+Jv/JYgB7sKxcsGzttowd0/Ep14wxJTyG2r7ik3fGWZL/sKWBV2Lx3ia2
Gq7oRYUXWuHTt9e8pGFeaPjn56a5T9hfeuuyvNiJ22nbuCZlodxjv457saDOpZgY
xCsQjo7JpLeq1C/fQqkWhO0H4B9nuBZhnMFHrqFgqUvPGmm9btB3Ow6citpEUY4o
c38d1eQqFmfJVXgXjgQ75NEug6xPAmyIdmUNw9ZSfYjG54iODAfW2+8Y8fgESTfl
ofSKApYj/dRwvVmfY4MKpy6xgTSTImXQzCTBQwUqur4iiZLzL5VONmk+rY8AHv15
WFigw9guTQHBFH6CgRNnAer9mTXL4ravPk6YXefokp0WtwMOJzhdECwJFGfrtUpC
bSfdLBvhGfgfagUWBuzjnSWf49YYA/EasKRZEerSYJcAGu3avHS6DOn+QoG5y1pA
rImEKtD8e1u/NfzgGZ7SIoCncfsy4QKBXCVuZEC17TXnexQdnk/tbaJSEXlLF0ep
GoDYTzAb
=Dx0O
-----END PGP SIGNATURE-----

--7llD9OtUCCU8mGz8--
