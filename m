Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21931C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 676D3864E8;
	Tue, 24 Oct 2023 20:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K7ZK1KfF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E820863F8; Tue, 24 Oct 2023 20:05:40 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C9F0879C0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a877e0f0d8so259767b3.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698170737; x=1698775537; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vFDgHX52FYc7fAX24elf4Wpggr6hUmHSyTzo3YTIOf4=;
 b=K7ZK1KfFAofQ8glYNMSzrSjrSkojnev1SU5G2YlioXFxif58CVS0wiDav/VcV0a6K3
 QQsPMSHFP5vglOVLPeOorE+ts6Z8I3EpiXN45VwP/jWXBUM0CIMV507gcOkD2gc3vHz7
 s6xOxsgE5kSvmBmacs2gEYjhxd7vL4PKf7eeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170737; x=1698775537;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vFDgHX52FYc7fAX24elf4Wpggr6hUmHSyTzo3YTIOf4=;
 b=uQMgdAUM95Uja5YWZUVBJSKJ2zBXm2JPWm63NUYgTpfpwoMBOI2g4dV0SyJhj/uNmV
 apsymhgLxFjyqx9bNtvk15R1JO8jXotfejWTUe18Ne9frb4njEGh8knjvf3ReZUSlTCZ
 CkIMhvcqnjhs/DnQ8kkUmpTlYwss8vp1JX0SxoY1b/FQkMFOkVO75k87OIObJuysTCDa
 NR5SvKuEQw6TEgQzJ/9yiOatvYJNJnRAa0QUixm4OIQuw3yDSmcyVPZxCvxGXK2YP0/c
 onpghpDiboxpUS4A8hFKEvJ3Ndam58tpehFde36eu72ZIfvcxgahaoGYZF4bTXDwHpvE
 VH+w==
X-Gm-Message-State: AOJu0Yzm3nL/xxNUOhav+tPMu2pa7D0xNUFJgX7hIFotx8pjXZwNJPVl
 VtEnzX7lNfD3lySzRNp6/0lNZw==
X-Google-Smtp-Source: AGHT+IETThzoPGCBOvkcubS/QDguSk0Z7+2o0SrLpk0LD9rBtYXfzbZoj8P+sZtuCIW70kHZ42kylg==
X-Received: by 2002:a0d:e891:0:b0:589:e815:8d71 with SMTP id
 r139-20020a0de891000000b00589e8158d71mr12441500ywe.11.1698170736971; 
 Tue, 24 Oct 2023 11:05:36 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a81bf53000000b0058fc7604f45sm4233011ywk.130.2023.10.24.11.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 11:05:36 -0700 (PDT)
Date: Tue, 24 Oct 2023 14:05:34 -0400
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [tom.rini@gmail.com: Fwd: New Defects reported by Coverity Scan
 for Das U-Boot]
Message-ID: <20231024180534.GE496310@bill-the-cat>
References: <20231024011828.GY496310@bill-the-cat>
 <CADg8p97LUPHUqwhNnOmcD1Ev57SjXxqiLCKjkT8EsYS2OuACWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vgTCbEvWXc3i6wKi"
Content-Disposition: inline
In-Reply-To: <CADg8p97LUPHUqwhNnOmcD1Ev57SjXxqiLCKjkT8EsYS2OuACWQ@mail.gmail.com>
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


--vgTCbEvWXc3i6wKi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 08:35:58PM +0530, Sughosh Ganu wrote:
> hi Tom,
>=20
> On Tue, 24 Oct 2023 at 06:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > Here's the latest report
> >
> > ---------- Forwarded message ---------
> > From: <scan-admin@coverity.com>
> > Date: Mon, Oct 23, 2023 at 4:40=E2=80=AFPM
> > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > To: <tom.rini@gmail.com>
> >
> >
> > Hi,
> >
> > Please find the latest report on new defect(s) introduced to Das
> > U-Boot found with Coverity Scan.
> >
> > 16 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> > 6 defect(s), reported by Coverity Scan earlier, were marked fixed in
> > the recent build analyzed by Coverity Scan.
> >
> > New defect(s) Reported-by: Coverity Scan
> > Showing 16 of 16 defect(s)
> >
>=20
> <snip>
>=20
> >
> > ** CID 467053:    (RESOURCE_LEAK)
> > /tools/mkeficapsule.c: 859 in dump_capsule_contents()
> > /tools/mkeficapsule.c: 859 in dump_capsule_contents()
> >
> >
> > _______________________________________________________________________=
_________________________________
> > *** CID 467053:    (RESOURCE_LEAK)
> > /tools/mkeficapsule.c: 859 in dump_capsule_contents()
> > 853                     empty_capsule_dump(ptr);
> > 854             } else {
> > 855                     fprintf(stderr, "Unable to decode the capsule
> > file: %s\n",
> > 856                             capsule_file);
> > 857                     exit(EXIT_FAILURE);
> > 858             }
> > >>>     CID 467053:    (RESOURCE_LEAK)
> > >>>     Variable "ptr" going out of scope leaks the storage it points t=
o.
> > 859     }
> > 860
> > 861     /**
> > 862      * main - main entry function of mkeficapsule
> > 863      * @argc:       Number of arguments
> > 864      * @argv:       Array of pointers to arguments
> > /tools/mkeficapsule.c: 859 in dump_capsule_contents()
> > 853                     empty_capsule_dump(ptr);
> > 854             } else {
> > 855                     fprintf(stderr, "Unable to decode the capsule
> > file: %s\n",
> > 856                             capsule_file);
> > 857                     exit(EXIT_FAILURE);
> > 858             }
> > >>>     CID 467053:    (RESOURCE_LEAK)
> > >>>     Variable "ptr" going out of scope leaks the storage it points t=
o.
> > 859     }
> > 860
> > 861     /**
> > 862      * main - main entry function of mkeficapsule
> > 863      * @argc:       Number of arguments
> > 864      * @argv:       Array of pointers to arguments
> >
>=20
> <snip>
>=20
> > ** CID 467045:  Resource leaks  (RESOURCE_LEAK)
> > /tools/mkeficapsule.c: 859 in dump_capsule_contents()
> >
> >
> > _______________________________________________________________________=
_________________________________
> > *** CID 467045:  Resource leaks  (RESOURCE_LEAK)
> > /tools/mkeficapsule.c: 859 in dump_capsule_contents()
> > 853                     empty_capsule_dump(ptr);
> > 854             } else {
> > 855                     fprintf(stderr, "Unable to decode the capsule
> > file: %s\n",
> > 856                             capsule_file);
> > 857                     exit(EXIT_FAILURE);
> > 858             }
> > >>>     CID 467045:  Resource leaks  (RESOURCE_LEAK)
> > >>>     Handle variable "fd" going out of scope leaks the handle.
> > 859     }
> > 860
> > 861     /**
> > 862      * main - main entry function of mkeficapsule
> > 863      * @argc:       Number of arguments
> > 864      * @argv:       Array of pointers to arguments
> >
> >
>=20
> Both the pointer and file descriptor are not being freed since the
> process exits once the dump_capaule_contents() function returns. These
> can be marked as false positives. Thanks.

I would say that's "intentional" rather than false positive (and perhaps
a bad example) but indeed not a fatal problem. Thanks for checking.

--=20
Tom

--vgTCbEvWXc3i6wKi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4B24ACgkQFHw5/5Y0
tyz4ggwAsmrDLVsmh8o91KsJNsVu/qeRrCjvLoZQsuPqoDJIZOOEQ+nxMVrpt2iv
3XfT4bCdKQwgxJklhFAIzumB3aYK/n1r/9JRAXc/FuUOdai6N+ZgDzWeOOCh6uRP
OzqR3dvXETN4BvaoJ9VYqDie1hOoiwSXDm7rphx5t5nhJW+8/BxpnmcKjFTmnL+x
tUJ9TuE+zJOVkf/A4Lfdshzh5NJCYxUOJ81pW/lBL5eQv5YvWaEQP0vvzb3jXThj
WlYWbirqdaZfY1lUxQt+1y9AfQTPzuEmDFDcB4hXflUsVg/YJ6TrwnV3jXc/n5Ge
LkkHlzI2A9jYye0Bj1g4KFQlt9r8apMMdvPEf95z2B7K7D0k52xKF7E+jyYEgjMU
rNMW9w0pbyCH9rZzrPZ9OMke+bdaRjOFq4aX0CjtGZFh/o8bdv8ryySL+PcuZnmU
9fsO4ckslUDR6B3UT5F52bMI/9e9sOn2KIklUHRhTHg2e7W+6zAvEfxStLmpIROT
nhi8G5RS
=si0u
-----END PGP SIGNATURE-----

--vgTCbEvWXc3i6wKi--
