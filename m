Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B55C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 919FB8786E;
	Thu, 21 Dec 2023 17:08:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l41SkA98";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF28887872; Thu, 21 Dec 2023 17:08:16 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BCA3877E5
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-67f848f38c4so3488106d6.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703174893; x=1703779693; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kn5BsxvMw+1jkt1HIZMPLpvw0e9ETCPunB0LJddBhJg=;
 b=l41SkA987Uo4KY/i+/UfaEXOw0Hl1DsiOkFxf0puQT/oPmh2pq5leV1iQMduiWYUYG
 Iqfi0fXC1D2KqQRSmdfXNZ9sOCK+Mmym0jgAnc/v3H7z2JhJKp8UV4kfADYgYnB166wg
 t4qpPZ0EQCGrYJlvwTyskPOapPlQfq77I/jpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703174893; x=1703779693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kn5BsxvMw+1jkt1HIZMPLpvw0e9ETCPunB0LJddBhJg=;
 b=Z6qtRKfnFXWBPnncXX0dveCqr+h7D+vn9Ew9VVakjIaA5C9zvStfj9u/5cfWwVmVhK
 JgJkRfsMskfLKQE4LT6H/cnONJax/qhtFAbPjUuKPphHu3mw7kkQG7kX67UDGaJOt2YA
 HCHHaPge+btXWf/7EqvG8JyjNrYp4uRKr7jkhhiRJhiGJ7jmatjflUffOSoqzvyWLLAI
 W1rtu6/oLs/3UObRw+XzKV9CPiJ8UVep+ZDOoAaX8GW5/VqLkHILGeGggpgNiDSWWmNJ
 xm5tycSvs5i4sO9of/cmjVjqRpCB6/cUqU/8VR9TaG2gmy1WnHW/QgbfwDLRpBopWyh1
 uU5Q==
X-Gm-Message-State: AOJu0YzxtYFaHxoqtZJL11pM6lBmcNjHQ6tsy4YiJiVfkmHEC8UIQfQh
 iHCMay1VAlugZl9/O+8u4rC3zg==
X-Google-Smtp-Source: AGHT+IEgWnAXvfVsAqzWwHeInin1PumvzyMf7ZzyxE4024xDhSPutw52appnQlMRl0mqjoajNRuWmA==
X-Received: by 2002:a05:6214:2023:b0:67f:6b04:4262 with SMTP id
 3-20020a056214202300b0067f6b044262mr6403444qvf.20.1703174893108; 
 Thu, 21 Dec 2023 08:08:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 dr4-20020a05621408e400b0067f8953f78fsm287135qvb.41.2023.12.21.08.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 08:08:12 -0800 (PST)
Date: Thu, 21 Dec 2023 11:08:11 -0500
From: Tom Rini <trini@konsulko.com>
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [tom.rini@gmail.com: Fwd: New Defects reported by Coverity Scan
 for Das U-Boot]
Message-ID: <20231221160811.GJ2513409@bill-the-cat>
References: <20231218162618.GI2513409@bill-the-cat>
 <CABEcMwUrEdD87fG-qf3YFOYgVp7yMdJ+MWaq6iwxMTFTqHRGfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Dq1t/SSw+ltasB/m"
Content-Disposition: inline
In-Reply-To: <CABEcMwUrEdD87fG-qf3YFOYgVp7yMdJ+MWaq6iwxMTFTqHRGfg@mail.gmail.com>
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


--Dq1t/SSw+ltasB/m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 02:48:31PM +0000, Shantur Rathore wrote:
> Hi Tom,
>=20
> On Mon, Dec 18, 2023 at 4:26=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > Here's the latest report.
> >
> > ---------- Forwarded message ---------
> > From: <scan-admin@coverity.com>
> > Date: Mon, Dec 18, 2023 at 8:42=E2=80=AFAM
> > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > To: <tom.rini@gmail.com>
> >
> >
> > Hi,
> >
> > Please find the latest report on new defect(s) introduced to Das
> > U-Boot found with Coverity Scan.
> >
> > 1 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> >
> >
> > New defect(s) Reported-by: Coverity Scan
> > Showing 1 of 1 defect(s)
> >
> >
> > ** CID 470930:  Uninitialized variables  (UNINIT)
> > /boot/bootmeth_efi.c: 465 in distro_efi_boot()
> >
> >
> > _______________________________________________________________________=
_________________________________
> > *** CID 470930:  Uninitialized variables  (UNINIT)
> > /boot/bootmeth_efi.c: 465 in distro_efi_boot()
> > 459              */
> > 460             if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
> > 461                     log_debug("Booting with built-in fdt\n");
> > 462                     snprintf(cmd, sizeof(cmd), "bootefi %lx", kerne=
l);
> > 463             } else {
> > 464                     log_debug("Booting with external fdt\n");
> > >>>     CID 470930:  Uninitialized variables  (UNINIT)
> > >>>     Using uninitialized value "fdt" when calling "snprintf". [Note:=
 The source code implementation of the function has been overridden by a bu=
iltin model.]
> > 465                     snprintf(cmd, sizeof(cmd), "bootefi %lx %lx",
> > kernel, fdt);
> > 466             }
> > 467
> > 468             if (run_command(cmd, 0))
> > 469                     return log_msg_ret("run", -EINVAL);
> > 470
> >
>=20
> The code in question is
>=20
> if (!bootmeth_uses_network(bflow)) {
>   // snip
>   if (bflow->flags & ~BOOTFLOWF_USE_BUILTIN_FDT)
>     fdt =3D bflow->fdt_addr;
> } else {
>   // snip
>   fdt =3D env_get_hex("fdt_addr_r", 0);
> }
> //snip
> if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
>   log_debug("Booting with built-in fdt\n");
>   snprintf(cmd, sizeof(cmd), "bootefi %lx", kernel);
> } else {
>   log_debug("Booting with external fdt\n");
>   snprintf(cmd, sizeof(cmd), "bootefi %lx %lx", kernel, fdt);
> }
>=20
> I am unsure in which case is fdt uninitialised.
> Unless the tool is being thrown off by different version of
> bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT
> check, I don't see the problem.
>=20
> Please let me know if you see it.

Ah, right, thanks for re-checking.

--=20
Tom

--Dq1t/SSw+ltasB/m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWEYugACgkQFHw5/5Y0
tyzlOwwAosp1/9v5sxGeSCS435FOAYSX3U/wxGvZ+ez1pMlsWbOMPlAinHDfmO/U
eMKVVtRnz6onKir7uFLr0B+ZMWdsq776DHyDtWbr7zraJHxnTH/xePEuldjN9+BG
oU8s1fxK0Fqzzbwkeh7GEWzW3haNHUofIjBtZnQY+LMDzvs9C/2snpgRd5ssLLTK
l/UTScWkozyhqNOoYhgGMXn9FPsxyL1KOJeRGtrPoK+LODOAdFPQz/WKedibVfJ1
fHQcBFfehjSXjRpyupJfx+iASRg2RWw4S+UXEtsYoIBXTFs2U4uAR+mlJwiwXtsy
XV0tPe3JSAnE/T3L4VJoQFhgpNmLVrXPSiwXAvWPIf/9B5SD4dDM4S+bhCW+05cq
sPppap3c0zKEBuNN7zzXF+HkVPA0I/G1CxneMPWWKUjGMm5TKDbLwhD5dzH7ac8Y
Q9+2fZF9WcNIyIWnshbm+pbE/1ZTgvFLU4CcdyvdOBy4N+1T2k4C3RI3U2WJzVzd
Um4YVjpK
=8gt1
-----END PGP SIGNATURE-----

--Dq1t/SSw+ltasB/m--
