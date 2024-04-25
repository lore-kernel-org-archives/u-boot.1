Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E79C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 16:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2415E8906B;
	Thu, 25 Apr 2024 18:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rqo/lFfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A518F8906D; Thu, 25 Apr 2024 18:19:04 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1772889054
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 18:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-69b9365e584so18148266d6.1
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714061940; x=1714666740; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kcFNSSZ6s/GorfRVkg5u1OcWOHiH5uJiX3tVvcPnHj8=;
 b=Rqo/lFfEqUgg2/Pz12L7YcLccZGFJboboyaFzmxe0HakXZTYBVUGwK1ixiL0tDBCuV
 /gRrm38G0EbpXvYVxwx2zHOmI1Dq8Q0ob8VSMXDd4IyXLXYjObfE2rJAA2KcTqCPreSw
 TcLUgxwN3XM5jMDkPV8S5xUZjRBiUMPTCD0L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714061940; x=1714666740;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcFNSSZ6s/GorfRVkg5u1OcWOHiH5uJiX3tVvcPnHj8=;
 b=WsextdaEl4eJIEfw2N8BHKBLhXUZrltEy4ChP1DzU7IAOLHSzbtbjPrsXi37jxXgcz
 UzYTZfCK+ClhRP2RoJfflQtXJx6xG/y93lMhMc85o9otZRLt72+mn7dGMl2nLzetGhIC
 ajefXvg6YcxRzpO6Exrf7FV5maYVf+6eu03Bkm6Uhnq8QOpPgnbFSPZCJmsYtkhTr/CX
 /y8U+SYO8Hz8B3FCp4C2fEYv8U3LA5WBzZOFuxw1REWLKjRe4TAxu+Fqpn890NHVr8u2
 VFpL41YvUDmER8ovvOwisx6eip3U1lixn2dlj5O9FDk1Wyl6M1c4/bq+2m6A3uf0F0rW
 pDnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw964eo1D8L6/SUdjlrzKMZJ6YHIyDt0B883Q+RiBY2pwX+o1LBxt7yY/lVdox9UdmP+4G23sGXruY3zG6K/NClwWd+Q==
X-Gm-Message-State: AOJu0YyRdQm0K2RMqbWxj/SlExQ5Vr1BdoM5XCoifLuHGnxPiWVhfglM
 3QoahG/5JHWP8/lYQuaIArudNfat4QvU/vXD91HKh6EYWDw1qCJ4UAcM13beu7c=
X-Google-Smtp-Source: AGHT+IELjarAr248+h3gk+AVenGUc0O97kzE2SpsdLMoKvk1ahEYrZ87bGhaU1JFoT4kkosSnOEeWQ==
X-Received: by 2002:a05:6214:c28:b0:6a0:9645:526e with SMTP id
 a8-20020a0562140c2800b006a09645526emr304420qvd.15.1714061939933; 
 Thu, 25 Apr 2024 09:18:59 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 g2-20020a0cdf02000000b0069b447066bbsm7055108qvl.78.2024.04.25.09.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 09:18:59 -0700 (PDT)
Date: Thu, 25 Apr 2024 10:18:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Richard Hughes <hughsient@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, FUKAUMI Naoki <naoki@radxa.com>,
 chris.obbard@collabora.com, Paul Liu <paul.liu@linaro.org>,
 Heiko Thiery <heiko.thiery@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Michael Walle <michael@walle.cc>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: Capsule GUIDs and LVFS
Message-ID: <20240425161855.GG1054907@bill-the-cat>
References: <CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com>
 <CAD2FfiGuFaC=r+TGfq9auzWJbyzVNbug8zR9RzSwM2+Uk52d+Q@mail.gmail.com>
 <CAC_iWj+BonsVbA5Bw3Kck2k4b8SXru0U_Y2kAmx5=_t6SozotA@mail.gmail.com>
 <cd5ca19b-befe-47cf-9a84-f610ae7f04c9@linaro.org>
 <CAD2FfiELXfvc9jEDpKVx44BnK5yDpVViARkB0QrHkpMRrdsVEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rnPWU/ama7Q77LoA"
Content-Disposition: inline
In-Reply-To: <CAD2FfiELXfvc9jEDpKVx44BnK5yDpVViARkB0QrHkpMRrdsVEA@mail.gmail.com>
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


--rnPWU/ama7Q77LoA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 05:13:21PM +0100, Richard Hughes wrote:
> On Thu, 25 Apr 2024 at 16:16, Caleb Connolly <caleb.connolly@linaro.org> =
wrote:
> > I discussed an idea with Ilias to generate GUIDs dynamically based on
> > the board compatible/model, which seem to essentially just an
> > abstraction on this..
>=20
> Yup, that works too -- on the assumption the compatible string is unique =
enough.

This is where things are a little fun. In previous discussions, yes, the
machine compatible string should be unique. But it's not. Is it unique
enough for this case, today? No, since mechanism could be what's passing
the correct device tree to the OS. Might this in turn be what drives
people to fix the case? Maybe.

--=20
Tom

--rnPWU/ama7Q77LoA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYqgmkACgkQFHw5/5Y0
tyyMtgwAmusJdeqjNMlyvhQgdGYqd3XH0A9NJHo3dP1ZmJL94LfCvexDT+HGEMOS
P08OwcXxaxklV1x2BkbA1d3e+BVd7C7vJtrlAvhX8f7M5cw27jp75KGh7qPzgHuL
eRLpksRzXa3ATDrjQ5FdPctAAZLmoS221z15uruROPrKM2AkhHKYjBabgC1ZM2KY
x4RwcoSfUC83LtclvibPC316Jdc3iqmpYdhQCGujkuqGrBIY596mKsUrDr1UafHf
LybDgqebPWJ9dz7Bh8N0lU80zLdOnvYVDRI/6cQYJ+zDj/o+XxUAJZOmGRncP4uH
HIPMdW9OGiP+jvI+hK5qfYjPK3kc68LXn4B3kK0KOntmnmKqPJ20nJzYr/rRyt6R
T2SHhTfSyriTebMLoN5pDq89uC4lrPKY80WtHuBXRguIf9BBJM9WbmVersGRkY6i
CUBT7C23frFT9n85ZquledjegZqBdZT8pT4WfvhoymFMXmO1h1AdAumf7wzEr1jz
hxA+r44x
=RsVw
-----END PGP SIGNATURE-----

--rnPWU/ama7Q77LoA--
