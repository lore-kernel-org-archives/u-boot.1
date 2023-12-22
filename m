Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F132C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 15:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3D1F877B8;
	Fri, 22 Dec 2023 16:47:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q+2Rzy1M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB73C877BC; Fri, 22 Dec 2023 16:47:38 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99ED0877B7
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 16:47:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-427a462fc5dso6939801cf.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703260055; x=1703864855; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oanDUML6p+JCZdm6eOel3ZM1mSlFaDuAwsh9mje4yyU=;
 b=q+2Rzy1McALT/SRGAZcRMcKeY5EJAsUIektFSSaq8aqu0ts7GaEua27IOA45fySfJ+
 iWP83SX6BrVkA6IbJKfeEtgKMX4YhzqkmhNErwC6CvDvvdvEEY/Cbl0yrYlCtrZK4ThL
 xYYjUGwKZ2+OmxQcANTIa3DBLiTTKTLjEW4sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703260055; x=1703864855;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oanDUML6p+JCZdm6eOel3ZM1mSlFaDuAwsh9mje4yyU=;
 b=rDJUgzmPGwVMFV5dQ0WAKI8mV+Hwec+PLQmvEJKj+3ggvJ2X7bAsiSfZh70eoFBSvj
 kCYAWLJxewqqahBKd7F90dmO5ld1u8S798mstOXFoa8uPjhhONQ3jhphyJuiSBDqQkrd
 d/xZwqZxC8Qax/HdiO7u2ZutHefiB6bpreiZuw9UwtYFSshdQ9NFk14I9zrblyjXEh0g
 7Ds21DpP9m8AnYucM+UkNfYIDNAMBVI6IXyShXI8C1A0noi5U6I4E0Rop3PbfA/q28tg
 UraPvws2jX296zuq3hCxtCjJlSA3O8/M2wHLOh7tZMk0MSyucOP0ByaFA/ihQhWPsD2B
 N9Iw==
X-Gm-Message-State: AOJu0YxlhiS4hiLhKSnL2nCidw/G7+ZxYo2Y2fdnkewkzpweHFYIs8Nt
 Ufss0a2aJWUZ49lqZ+5+X3t4fJHApbn1tw==
X-Google-Smtp-Source: AGHT+IGG/nBHByoSHeqaRp7Vh7xMy3jd6p4MTyDdR+sIxqkhD+RN/hL4vejZiY6TUPvkFUHpClouew==
X-Received: by 2002:ac8:5782:0:b0:427:7bb7:ed55 with SMTP id
 v2-20020ac85782000000b004277bb7ed55mr1578579qta.48.1703260055391; 
 Fri, 22 Dec 2023 07:47:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a6f1-1968-9d2f-89bf.res6.spectrum.com.
 [2603:6081:7b00:6400:a6f1:1968:9d2f:89bf])
 by smtp.gmail.com with ESMTPSA id
 q9-20020ac84509000000b00427720a980esm1929169qtn.2.2023.12.22.07.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 07:47:34 -0800 (PST)
Date: Fri, 22 Dec 2023 10:47:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] bootmeth: pass size to efi_binary_run()
Message-ID: <20231222154733.GB2652760@bill-the-cat>
References: <20231222150156.39783-1-xypron.glpk@gmx.de>
 <170325942760.2653128.4640507980296072811.b4-ty@konsulko.com>
 <CALeDE9PwPsxKQx5j_embNv_4NwXSt68Mo7apBPwDOWdApPA=mw@mail.gmail.com>
 <CAC_iWjJTRZV9_n1-j93y=aMwQhhUgvx7N56n9d+-p1aPb3W+Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p2bDEQdSIyjByF0m"
Content-Disposition: inline
In-Reply-To: <CAC_iWjJTRZV9_n1-j93y=aMwQhhUgvx7N56n9d+-p1aPb3W+Aw@mail.gmail.com>
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


--p2bDEQdSIyjByF0m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 05:46:11PM +0200, Ilias Apalodimas wrote:
> On Fri, 22 Dec 2023 at 17:43, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > On Fri, Dec 22, 2023 at 3:37=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Fri, 22 Dec 2023 16:01:56 +0100, Heinrich Schuchardt wrote:
> > >
> > > > If we call efi_binary_run() with size parameter set to zero, we get=
 an error
> > > >
> > > >      Not a PE-COFF file
> > > >
> > > > Fill the missing value.
> > > >
> > > >
> > > > [...]
> > >
> > > Applied to u-boot/next, thanks!
> >
> > Is this a fix that should land for 2024.01?
>=20
> I was about to ask the same. I think it should go into -master as well

This specifically fixes the merge of -rc5 in to -next however.

--=20
Tom

--p2bDEQdSIyjByF0m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWFr5QACgkQFHw5/5Y0
tywwogv+MK9KLq5CN+r0MiaNhQ5eXosrVhsNCrqI/A+XgW8SbY/1StS3JQYrX2BH
C1D0R6YxMklIMtSwvSPDK6zh2t2gNSqQkJh0vp3sTR2TrvWGIZXr69g4aq6U0Ko+
2348674j+tClfr6nDbPWs1xzfUNOX3oKS5+VYxVwdI3QyCpBk3F/CRX8ZteWr60t
efGSLgLMvhg1qQpj5x3/WuydaEgR1VpWWd+QCUrJBwVqDi86QUaqBQzoZuG/MXRt
75gJCj3xo57adijQk5Eu+1pMx+JvKNK7BmeMSXnz2+IynXeHeu+M2s8UiErwOJtK
jlHe17yhnAghy0VmR7kSvdEtSbB3CEufa0lKMg+15U8y0gU78VKb0hkNWoTF6wK8
CkLqMjYeYkSWx8rEzIUyicc1rBvOh5n+JEjD6j/dAxS1hmtv+Rw+f+OW2AKrQM+Q
Ykz3xNo8Gr1iC+RZO3AgV+f/G8qslrldovjLqxbJd8VMMUwZB+dV3Pr3UQnL98Yp
N4i0RqhU
=uM4o
-----END PGP SIGNATURE-----

--p2bDEQdSIyjByF0m--
