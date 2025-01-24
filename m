Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39CFC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 22:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C81A380ADB;
	Fri, 24 Jan 2025 23:17:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z1AZhWTM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D1580ADE; Fri, 24 Jan 2025 23:17:41 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3D6A80A52
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 23:17:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7be8f281714so258086485a.1
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 14:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737757058; x=1738361858; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vVruaZaoURaAQYcDnbUjBWjR1U2OCdmpKoRwYaX9fsU=;
 b=Z1AZhWTMqQwW/E8MnNJXwPToXSGINKBpSRZ7NIVw61oxSw19mmd9kncrj1wLs0bSU+
 k3Y1f5TIgXEDgqTHTXb77wRlGYNUmc22+lQCh/vQ/jFuTcrk3uL3ClGIjqtchfq/s+ip
 9ktyKSHu3KB5zEAYmfpAsVlA3h6+2ua6OiVEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737757058; x=1738361858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVruaZaoURaAQYcDnbUjBWjR1U2OCdmpKoRwYaX9fsU=;
 b=wiBpz57ZydMH0s2DvAVwsXeBQ3NOLcfeSOk4lvyo+fy8/HSkJZ3aRG2KBTyq32x1la
 0yp98vCulYqMmY9jDjlLNjEyRdxmYjVDDWbPUjbBzBi1pOEuuQu3OOViSV30n9etjfnj
 cA6v9otP4TV0zyvwLkaf+DgYz5u529L0QT1onRq+nQLPUO90Z50K7ACJCVrWMDpqKO8s
 f1kqPBM/SlDTZTAxwFBgIsvZqH6f/Vquibk9lBgeQjJDgWCX/V9MzMUqmbtAGo4lbCyJ
 dZQwfexeWLnhjFzUd9k4EqVTYtmGsUjcg+y7iJm6MNONDLWa2PLGuYYJufHAWWPRa1+O
 iCIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuiSOqRRjVTusdzboluULBYqxALixuODkrW3utsJrC5BA04HWgM9mUSvo1OgyLFRv/jIw4O7k=@lists.denx.de
X-Gm-Message-State: AOJu0YxQ+UUfBsBEl5BqV0qRacyQbV/YgnyZ5wWq/F3qCrp2qK42DkLY
 onjXeIJ6emCpzrer4Q6gwDPZ32PLAdwi21Yck0wg9zEj8s/gb9ZdkZfMb/mR9nk=
X-Gm-Gg: ASbGncu1gNh25UaJPltQCubdiGPpXeMdMpGDY3vXtZrMrViklqy9R+ftLqG+XXKgUNg
 NIwVUD186YVdRPLEXHlkoWDTpw3ygNB9c0z6OutMI6/aEwCkUoMjEL9nXuHSJNw+SDP5PE4A98U
 fqiNWlTqt49BU9r4ylrH0TnoiWHyw8qtQyNakx/UOjA/42qs1uriBLNU2Xbnpl+CDgqqCAMRfai
 NFhIXAtJ3mqV09CEzuLsJlZ+wZTOiDzBtne67ATBK5l3E+nABXTlF70r2e0oM7ISVuxI8KLD9Up
 Pxqc
X-Google-Smtp-Source: AGHT+IHbisY8mS7Y1a4ysqonlLX4aKXN/udKz1R53ZtaqGo8ydSGK9Ij7BsK4E7YtF0qW1b0JPV8hw==
X-Received: by 2002:a05:620a:4001:b0:7be:39e7:a025 with SMTP id
 af79cd13be357-7be63249e37mr3608441285a.26.1737757057815; 
 Fri, 24 Jan 2025 14:17:37 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9ae7ec0asm138187085a.12.2025.01.24.14.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 14:17:36 -0800 (PST)
Date: Fri, 24 Jan 2025 16:17:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Ferass El Hafidi <funderscore@postmarketos.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] mmc: Remove alignment hole for cmdidx in struct mmc_cmd
Message-ID: <20250124221734.GY60249@bill-the-cat>
References: <20240127162922.284598-1-jonas@kwiboo.se>
 <CGME20240403000039epcas1p46afc0540b893679113e0683d87227ca8@epcas1p4.samsung.com>
 <d7a2b5ef-ceb5-4f8f-b2d0-fcd6f2d6df1c@samsung.com>
 <33caeb3b-2945-49ee-8756-8cf8aec1c632@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U5o8/US3NEmtepr4"
Content-Disposition: inline
In-Reply-To: <33caeb3b-2945-49ee-8756-8cf8aec1c632@kwiboo.se>
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


--U5o8/US3NEmtepr4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 12:35:26AM +0100, Jonas Karlman wrote:
> Hi,
>=20
> On 2024-04-03 02:00, Jaehoon Chung wrote:
> > Hi,
> >=20
> > On 1/28/24 01:29, Jonas Karlman wrote:
> >> The alignment hole caused by cmdidx in struct mmc_cmd cause strange
> >> issues together with the peephole2 optimization on Amlogic SoCs.
> >> Following was observed while working on SPL support for Amlogic SoCs.
> >>
> >> sd_get_capabilities() normally issue a CMD55 followed by a CMD51.
> >> However, on at least Amlogic S905 (Cortex-A53) and S905X3 (Cortex-A55),
> >> CMD55 was instead followed by CMD8 (and a few reties) in SPL.
> >=20
> > I read your RFC "https://patchwork.ozlabs.org/patch/1841495/
> >=20
> > First, I will retry to reproduce your case with other compiler.=20
> > After that, I will inform again about this patch.
>=20
> Gentle ping, this patch has been on list for almost a year now.
>=20
> Have you had any time to reproduce this or can this be merged as-is?
>=20
> For some reason only Amlogic seem to be affected by this issue.

Poking around in Linux, it looks like this is equivalent to 'struct
mmc_command' in include/linux/mmc/core.h and so this makes us
equivalent.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--U5o8/US3NEmtepr4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeUEXQACgkQFHw5/5Y0
tyx8FAv/bFMKXlHtjb5U0tAaWml7kZDdPV672zElGwbaZDlrzFWr6g/BSffK217k
MbJcfWUZ4ioxnWAgPJsD8NcIInR26e0UCaVumnuNd/8FS7Wi/Dv0Rq+7wNaKy+Kn
RmSstUTc1GIV2BlaFO4Y/BsKuI1vo5EE4qf2vXcnJWWIS1M85w/Jcj2rzH8j3dU2
Bw3v/JN5+vL3b7d4Rv+J12H/7V12oXm8kooHtPfiV8PbGmk5Klo0hUcbR1y+T4Ce
S+0tqdChETQNk79Rm+3AAXBTOlf3Q/VxichpjQafBzAjw0P72UkxmzV/Vm8z5FgY
vhM5gUcAst41IyEH2f/W2pBgdx6xOn6/2VDE7wDgLgXSP84dJFVxz+7WpoRNnHnS
p+2reCGquMlECOz2Qg1YHY5WfT8RXibp3TU/jYdgTEUN81jFJf0wpZucs6NwiqTp
2rhnL4Rh2fPizk2i1uyENpnLpEqjfMvP909FEdl9suNfOCYiRGcZpKc0ci/CtB5z
WlENB4Nd
=4JEB
-----END PGP SIGNATURE-----

--U5o8/US3NEmtepr4--
