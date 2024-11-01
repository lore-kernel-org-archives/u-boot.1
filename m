Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F52E6F06C
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 16:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AF8288DEA;
	Fri,  1 Nov 2024 17:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DyJLdRxb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F73588DEA; Fri,  1 Nov 2024 17:19:49 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E429F8897F
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 17:19:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3e6005781c0so1234713b6e.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 09:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730477985; x=1731082785; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/wPuo8VM4OUjBKEdMddZDvSb3IJILSu9CI6y2oaPXQQ=;
 b=DyJLdRxbSVtUA3CeFAN3BjmSJiYjwGZIQ8zwdoXGi20WVjKfwkb1fQtTPsyq2SZUly
 SMX/knylLcWktXupcA3N9dBzeD7kSQIIkxYxZJWnymVUwsBXSAOPvJ3cqPWFF19ObiJo
 O9oQURus3He/UC9heYgV3X/Xxi4I/zAWwJ61k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730477985; x=1731082785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wPuo8VM4OUjBKEdMddZDvSb3IJILSu9CI6y2oaPXQQ=;
 b=cqA0YAPzUWxoGHGNzWCfYNaFMWvY/c4PSoLzTa2FVjdjErwbIlTfKJfGZjp7O6W/eG
 zF+pNN1CQ0kOGQuxYnt08b2j/Dn830zxNUHHyUutuLSRCOR52kYawelJG/VpSxQwnIQE
 Tt4B9m7NeYt8ks3dFe+K04AhmIOVZSFFrGA/Qk+bMa4B1Voybb7ggHnKcBRNVbjANbod
 QzFJalermmgxXqysinYCa8DEJFVY6j42aDnAcoYwdcoBOJjwG+0gN1qR3cpakeymZK7v
 cBtDmb5byQSS1wgu0fKOWhQqZrY4fKZcjsL1gS3ho6yNM0HnI34J/vmbTCJ7sDB8j6Tc
 Y/Qg==
X-Gm-Message-State: AOJu0YziPmzmOgFUn71tLr/xK6nyXpbbweHbaq9gelT9ULwIOAzRWz1m
 WF20wll9xYzZbKlk4XNdljDQNQjgnQM1har09G3MM/pq0vDNFq7ldWFQQeIIKZc=
X-Google-Smtp-Source: AGHT+IH53gAIAIyKGt8CODqo1slLEd+bU2pWrqECOEJKf1rD8BOBv4tGHxLvNUxm2pkYj29wQkojZg==
X-Received: by 2002:a05:6808:654b:b0:3e6:5978:5e1a with SMTP id
 5614622812f47-3e659786003mr10287047b6e.34.1730477985664; 
 Fri, 01 Nov 2024 09:19:45 -0700 (PDT)
Received: from bill-the-cat ([189.177.122.145])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d35415a713sm20636536d6.95.2024.11.01.09.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 09:19:44 -0700 (PDT)
Date: Fri, 1 Nov 2024 10:19:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v9 08/11] efi_loader: Drop sandbox PXE architecture
Message-ID: <20241101161941.GN3600562@bill-the-cat>
References: <20241101152614.238747-1-sjg@chromium.org>
 <20241101152614.238747-9-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XIWk1uVspbO6Aq5a"
Content-Disposition: inline
In-Reply-To: <20241101152614.238747-9-sjg@chromium.org>
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


--XIWk1uVspbO6Aq5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2024 at 04:26:06PM +0100, Simon Glass wrote:

> Rather than returning 0, just return an error, since sandbox is not used
> with PXE at present.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--XIWk1uVspbO6Aq5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmck/5YACgkQFHw5/5Y0
tywnxQv+LUisFP0NXIc/y02c39nKTMockkx9Z0cOn8pW//gEz24RydM9PJkrvWtt
Y1vkoLFAi3dBPavhgfTGAiFa3Use6uflneDb1Vj2O+riUgCPizeKEUHKB/nhuUWH
YhVoFYKcnpdiKdCmyk57EhPbGUyZCoFPwM3kANYdONYO9pFrgB5JMvhEAPrgNhQK
KZyKKChI8UNgsLg7pSvIekaGdZMx5xxchN7QFCacvqWOvprQpjfqJRevF2h+bHMV
YtZw2gK6GununmrAO0yI+TXznXF+SQ7DF6PGOU1V9eFN6m3/ybWgYL0Wp84MzbAy
6OM5b5f+SH+hEjKSy4E0Y7Wpr7QKlkzrzBgGkJ5AgqC8kQPvbLYljUb/A1qrU6v/
CNVQRxk9PeVw5siJ+024bvHPBB7MBC0Ti0xEOStYnN3/pwudhOnddOWUL9Yco0ab
ay2xwWSFbXuFrwV7i7cq9uXdgszoj/P6OzftmOL7FzZsk4LAzb6we27wYlaEY1IN
lS3QklLe
=Um1U
-----END PGP SIGNATURE-----

--XIWk1uVspbO6Aq5a--
