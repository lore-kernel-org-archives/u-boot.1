Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B9BC46CD2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 23:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40A72879A3;
	Tue, 23 Jan 2024 00:52:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i2kvh0Ct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43D7887579; Tue, 23 Jan 2024 00:52:18 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 164C18753C
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 00:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6001449a2beso9215427b3.3
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 15:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705967534; x=1706572334; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SLJgMRwvbJDj/liW7Deoa1yvyzlJKlDL4sLY5J9CANE=;
 b=i2kvh0CtI9EO8QOWc+buNirceAcq3CB7v5QsIRWYOcKcIjugxCPUpWwKxsxT2bpr2w
 VrDsWt7V/7S8ALKxojGA1iB01fRIIMEEWwDJhptn6X6LaDcv/CcGpIOBzIJotdJjbm6e
 wsDEse/EVYyU/iPh8HGNy/d5pmpxIYD2UNUfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705967534; x=1706572334;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SLJgMRwvbJDj/liW7Deoa1yvyzlJKlDL4sLY5J9CANE=;
 b=UlW9XUE2dTfL7s2+fzatFNKZaTBj/cR2vIdiPVW8mGwGBGtWkFHqjfISob8RhSjtGf
 fxQoq4MdZkAvLCDQ01rbHTfd+GTK0UqBR/XTZ7AhOPU9Nj6AWFdiGPg9dZkl82vGpcdv
 qg5xtP76c0C2ERXsG9ezbp9wg9LnaM2ZTeIRDzwOHiwGLrKCz+Zk84lvw/QTG2eITX+2
 J0ysMiJGritIvcfQ6ZXH6XfckuTFNO3aUn5UFVcqbx+FJYkatBpg+ktN39DW1W2GRRMI
 vB74MKM1B1/lMlZMF4u37DhOwfxuoFQMRavqJKupeeXQ5JsHZOwf+JmQAn9DTkHXr/tk
 gnHw==
X-Gm-Message-State: AOJu0YwzzfQS2CS5eruDIhW9mLFtPNoob/FCZNoomX2tqKByvy/Zwg5a
 tQX2irGaEMoYrZwfpQ2qrqKLbtT1dtNHuA071apT32LZGhYDFRPRecqCIC3aVmCqHJYKAaiVZL+
 6
X-Google-Smtp-Source: AGHT+IHoPXxbbxs/7swMVxkGlnk8Ahp3vC3nTnpf+Y+ZDEfjnALfYNBLzbfmiybKnVzyy+ynBecSfw==
X-Received: by 2002:a0d:f5c3:0:b0:5fb:da77:af07 with SMTP id
 e186-20020a0df5c3000000b005fbda77af07mr4002058ywf.32.1705967534333; 
 Mon, 22 Jan 2024 15:52:14 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 e4-20020a81e944000000b005ffddb2369dsm1263931ywm.82.2024.01.22.15.52.13
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 15:52:13 -0800 (PST)
Date: Mon, 22 Jan 2024 18:52:12 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20240122235212.GS3652023@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QX9ol6o2vVSqR7nq"
Content-Disposition: inline
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


--QX9ol6o2vVSqR7nq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've now updated to the latest Coverity scan tool and that eliminated
some previous defects and found two new ones:

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Jan 22, 2024 at 6:42=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das
U-Boot found with Coverity Scan.

2 new defect(s) introduced to Das U-Boot found with Coverity Scan.
8 defect(s), reported by Coverity Scan earlier, were marked fixed in
the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 2 of 2 defect(s)


** CID 478862:  Memory - corruptions  (OVERRUN)


___________________________________________________________________________=
_____________________________
*** CID 478862:  Memory - corruptions  (OVERRUN)
/lib/initcall.c: 82 in initcall_run_list()
76      if (ret) {
77              if (CONFIG_IS_ENABLED(EVENT)) {
78                      char buf[60];
79
80                      /* don't worry about buf size as we are dying here =
*/
81                      if (type) {
>>>     CID 478862:  Memory - corruptions  (OVERRUN)
>>>     Overrunning callee's array of size 15 by passing argument "type" (w=
hich evaluates to 255) in call to "event_type_name".
82                              sprintf(buf, "event %d/%s", type,
83                                      event_type_name(type));
84                      } else {
85                              sprintf(buf, "call %p", func);
86                      }
87

** CID 478861:  Memory - corruptions  (OVERRUN)


___________________________________________________________________________=
_____________________________
*** CID 478861:  Memory - corruptions  (OVERRUN)
/cmd/nvedit.c: 356 in print_static_flags()
350     static int print_static_flags(const char *var_name, const char *fla=
gs,
351                                   void *priv)
352     {
353             enum env_flags_vartype type =3D env_flags_parse_vartype(fla=
gs);
354             enum env_flags_varaccess access =3D
env_flags_parse_varaccess(flags);
355
>>>     CID 478861:  Memory - corruptions  (OVERRUN)
>>>     Overrunning callee's array of size 4 by passing argument "access" (=
which evaluates to 4) in call to "env_flags_get_varaccess_name".
356             printf("\t%-20s %-20s %-20s\n", var_name,
357                     env_flags_get_vartype_name(type),
358                     env_flags_get_varaccess_name(access));
359
360             return 0;
361     }

--=20
Tom

--QX9ol6o2vVSqR7nq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWu/6gACgkQFHw5/5Y0
tyxZpwv+LhevDi8ce0SzUyLylDQFx9KKYk1miZPzjxs2lf230tG1XVLcT7zUaGAr
ALAdaOi60qtFlQk9VLK6McenQclQ+L0buzwC3BrR+GMwLjwrEs90ajxHYrm65ZhL
7U+WtPzL88anX01kBV++cSbUAq8jNOqYJfZes0Gbf1s5uLcOoRAiuDGSdypbBVsq
iCAxF5kJDYhgL2TRqI2B6xu7rQN82C5BmlzqB9kS/esF4WjcpG1gZNZMabLAMI1A
tazFou8NA5UjvWirCR0CqK3ipLY4yKyzbUzp0gE/QkZKxeQvrOB1GqWIZPiRmiKO
a6QsuGZX3hWGV7oqB1cM0XE9vJecr4BXrQySPmFmY4WSQj9KZ1WBRBzle+YGDagZ
4ZM5wOJgv17ja7c5LCqqNR8UzgZmFSe/ueN7gRIgDxLa+6n0T0fn0ufcCUbLFhUA
SI1tw57pLPVcVdHdbBdK7oZsAJFLXngt/EW8bDbziDpNjxQ9Z0w8GK084w3saHbZ
Jszb+PfO
=/hc/
-----END PGP SIGNATURE-----

--QX9ol6o2vVSqR7nq--
