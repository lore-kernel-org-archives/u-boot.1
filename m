Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2D5C83F37
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 19:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11D8C865B0;
	Thu, 31 Aug 2023 21:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GRER1taF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C586586590; Thu, 31 Aug 2023 21:32:22 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1487D80702
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 21:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-591ba8bd094so13711857b3.3
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693510339; x=1694115139; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+QzsEZO8sEpoTGMJzrbCkOsgvQ4aHRXW5O/MOml4/iA=;
 b=GRER1taFh1ldWtU2DjWg9x90SgSKN6uCiEFio8388IkD/YBaRPm3w5uEUQVIJ1tx9c
 CsEX6v7/xY2y2HoYHcno6UtJIp4w0y3U6b1Q1LLNEsSZ82+EUOsK8naKN2eS5+9DdYc2
 h1f7xFNCU1soIk7M6Nn6R4KWCcrcW7q7aqJmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693510339; x=1694115139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+QzsEZO8sEpoTGMJzrbCkOsgvQ4aHRXW5O/MOml4/iA=;
 b=cr7QtWYag7omjG2g1Hvy+2JzrNkFSuVtUzeGuyhHoo8+HGxJ9Pc0BPD9qRTNhOtkXN
 HWpe8Z7arS8gbaOsL3UeK5N+TlOkLRFnyc8tfakanxvn2L72a9OQplOk+a7OlN0kuglM
 LCXRpBqZ80nUohSY+TgJTvRqlaFjqEKd1nwdSlBlBhn9WDFXA8wPZ+7ZeSeNcr3+kxTe
 x8S+aQJ6Ona4LKYL65dZqrT2ctIcDMWUFTJK5PW4IKCQloev/f9pzpesd0KDJqeUTusL
 o70tEjp8bvTKtAmcD32Q4LRR8h57oduvhFi7ZX9mjZ3a7fhme5mNqp4/iRbh427RgHOE
 IdnA==
X-Gm-Message-State: AOJu0Yzwdp0hsU3MsENpdPeZ4Yn6pjqI50QtQZKEpHfw4lvST+MyHpCq
 A009R/fQk/USjwVdY0CR0RlPIA==
X-Google-Smtp-Source: AGHT+IG1RMP895ikqeMC9DLWfRbJXag6F2SG/Xe4ZAiCYwGtH4J2tYJHgeL4mx6nnFWuAerYNPQZEg==
X-Received: by 2002:a0d:e081:0:b0:595:2094:f87 with SMTP id
 j123-20020a0de081000000b0059520940f87mr366596ywe.47.1693510338763; 
 Thu, 31 Aug 2023 12:32:18 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a81df03000000b0058038e6609csm619057ywn.74.2023.08.31.12.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 12:32:18 -0700 (PDT)
Date: Thu, 31 Aug 2023 15:32:16 -0400
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <jmcosta944@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, antoningodard@pm.me
Subject: Re: [PATCH v1 0/4] Port gen_compile_commands.py from Linux to U-Boot
Message-ID: <20230831193216.GQ3101304@bill-the-cat>
References: <20230820190412.21266-1-jmcosta944@gmail.com>
 <CAPnjgZ1c12NPKPgrYMY69181_nKtzas6hy4Q15u8knL8b_a=Hw@mail.gmail.com>
 <CABfBAmB6-_+mdvL285prf6oKEFX8=EUS3ZLtyj=7Ducc0wcyKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tV9E5KkubG1bF+W8"
Content-Disposition: inline
In-Reply-To: <CABfBAmB6-_+mdvL285prf6oKEFX8=EUS3ZLtyj=7Ducc0wcyKA@mail.gmail.com>
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


--tV9E5KkubG1bF+W8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 09:21:19PM +0200, Jo=E3o Marcos Costa wrote:
> Hello Simon,
>=20
> Em seg., 21 de ago. de 2023 =E0s 21:13, Simon Glass <sjg@chromium.org>
> escreveu:
>=20
> > Hi Joao,
> >
> > Can you also please bring over the documentation for this feature?
> >
>=20
> Actually, I couldn't find any documentation per se (e.g. in
> linux/Documentation) besides what
> is already documented in the actual code, as in the help message,
> docstrings, and comments.
>=20
> Would you have any suggestions?

Can you write up a little something? It'd probably be good to have it
documented in the kernel as well too, so something that can be
contributed upstream (and we try and be good neighbors).

--=20
Tom

--tV9E5KkubG1bF+W8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTw6sAACgkQFHw5/5Y0
tyx2hwv+Ivk00MHqH+cm5ETz6hhB3SFJGPvebQ0bWFnG2QrE+D4FUCOM5/E8JY7P
SwMQbeJ6l15J4vcpFTvB8R221QhrcI6xljJP9HmSYoNeauCxKxxKO8lo2gcgmTLZ
tvAmQp98IHKbPpkqR5Ay0jbceqapbamU9xK8zlW+tuRkJj0P1nPpyQcCBqhvkJZw
9+kz91Cq6ivXyL9ESzaXKdS74RZ252+q+YqkLCZ5R4zhibPeJ4ZlQLlcHYoLVA+G
8MjIryl6JM4utY93b/+x+/qSGJBXXQ+MBBuYDLYl8DMEEdmS7OPl37In5CnU+j37
xy2/mJzhihPH6eRH6fj4egXI+vzPT0F1jNMexcaG/zuHHOwD5DjgCq+7G3O6lKIT
uTEwy3+7F4ozDRv7507pp4VOnuyv9ROWLFI3lLLmVU8JBPJbUCN3O3Stotb9JEfK
lbyMHCzf6z9ANEwAqXYtu4hQA+52FfX+VDIQ/62dmdzNynGrB/m9l8TAZQ8pFEWZ
/Tpc+ZKT
=sdDv
-----END PGP SIGNATURE-----

--tV9E5KkubG1bF+W8--
