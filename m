Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E099BC0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 21:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AFE080C91;
	Sat, 25 Jan 2025 22:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sigVavXH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7E2880EC0; Sat, 25 Jan 2025 22:43:25 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C39A80836
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 22:43:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-467a3f1e667so19897931cf.0
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 13:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737841402; x=1738446202; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OqJZviWei3GUt8mWgguv30TgcfsllmqGPmifoMtWwuE=;
 b=sigVavXH7JNGXwzneq5ZoNTbR9AoR1rHnBTPic4CQGSCcKGfobUTRs2nIz+LAojzCc
 mqVYhNFo5sRPVAs8SskqMWhuFgFCjhDiU82txVUCDaITIQZ8hRB+Rx/6VtHQhIIf1nIh
 gF2j9FABMr3DwD7s6VvK2w11swhUJCkIn/3l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737841402; x=1738446202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqJZviWei3GUt8mWgguv30TgcfsllmqGPmifoMtWwuE=;
 b=jqbUSkOUMgkAgLKQGeuijHUHGQaI6ZgDWTtpqHEhzszqtkAwMPElxkKOLqqXxqoLoz
 L54AVT9++VmCWj8bW+QdQQ101ewQhIlFhQF6AlarmlM0r9uTudROwwaGp5PfrgNtLV7R
 G8b+hIvq+cP/Xnmwwmn+/pIp4V4KFBI3J6SZLf5Z9pOJq93L90EB4V/Ye+Uda9Aj7X5w
 1TGLyuWDIhe2htF9zoMaGpNXoGJG1dZC9TbLwuCYgwzrPVU5gGO/LWp2pOv22+72obRH
 jUw2hb87u00lT4aBqhL/+JxZVhWCRUan+u3aK24rk/HH+1cx5+ju/NkDsh7xosvABi8t
 irpA==
X-Gm-Message-State: AOJu0YyhiXvCaIHx3qSQr2azu3R34kckN7huBUcHfNwOSJ645sLBIRri
 Pc3mUQ/g85Q93jZJXC+eQRx/Q+sj7OGwLLEcHYjDbkk7JN+lSvldZEXTYkTsm4s=
X-Gm-Gg: ASbGncvZETVsk9s56Z415Gy7Qm9yNeLpyjfsabN/SeteTTN/0lLPPISy7HsYUdS+6G4
 WhWVb0/pVJuDK6hZVRI74vxls615Fgo8wvP7hKlWICrL0AxwX6CYMsmrmD3NbKNdyQk+UlWNlY6
 BPFIAAAc6CRRVLY2KQXCL9hc9ZSs/vprspGP/8DweBXyFdIaQPBCBTEjwZLMrEVhWnBK2ONzGTK
 tYmiQXkrTDdlVeoJ1TMiQzSR79n24JHlWpCLBfxsJhWut7I0re+yBwDTo2yvdWZLDdw946uwV25
 4clJPwDM+iIliZY=
X-Google-Smtp-Source: AGHT+IGMdjhWhwLOSSYBnxiRwBcjfVJz21t7UlBYqZetvEpeBI+lFR8KGjW4YRfWw9dXyfVYoa/Gmw==
X-Received: by 2002:ac8:5a88:0:b0:467:5da6:808f with SMTP id
 d75a77b69052e-46e12a940c6mr514356551cf.22.1737841402294; 
 Sat, 25 Jan 2025 13:43:22 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6689d058sm23513301cf.32.2025.01.25.13.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 13:43:21 -0800 (PST)
Date: Sat, 25 Jan 2025 15:43:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/4] test/py: Show info about module-loading
Message-ID: <20250125214317.GC60249@bill-the-cat>
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ui1GPHiCtVaihFXI"
Content-Disposition: inline
In-Reply-To: <20250125213150.1608395-4-sjg@chromium.org>
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


--Ui1GPHiCtVaihFXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 02:31:38PM -0700, Simon Glass wrote:
> It is sometimes tricky to figure out what modules test.py is loading
> when it starts up. The result can be a silent failure with no clue as to
> what when wrong.
>=20
> Add a section which lists the modules loaded as well as those not
> found.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  test/py/conftest.py | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>=20
> diff --git a/test/py/conftest.py b/test/py/conftest.py
> index 5096c20ed65..23435b7db3c 100644
> --- a/test/py/conftest.py
> +++ b/test/py/conftest.py
> @@ -286,19 +286,26 @@ def pytest_configure(config):
>      ubconfig =3D ArbitraryAttributeContainer()
>      ubconfig.brd =3D dict()
>      ubconfig.env =3D dict()
> -
> -    modules =3D [
> -        (ubconfig.brd, 'u_boot_board_' + board_type_filename),
> -        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
> -        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename + '_' +
> -            board_identity_filename),
> -    ]
> -    for (dict_to_fill, module_name) in modules:
> -        try:
> -            module =3D __import__(module_name)
> -        except ImportError:
> -            continue
> -        dict_to_fill.update(module.__dict__)
> +    not_found =3D []
> +
> +    with log.section('Loading lab modules', 'load_modules'):
> +        modules =3D [
> +            (ubconfig.brd, 'u_boot_board_' + board_type_filename),
> +            (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
> +            (ubconfig.env, 'u_boot_boardenv_' + board_type_filename + '_=
' +
> +                board_identity_filename),
> +        ]
> +        for (dict_to_fill, module_name) in modules:
> +            try:
> +                module =3D __import__(module_name)
> +            except ImportError:
> +                not_found.append(module_name)
> +                continue
> +            dict_to_fill.update(module.__dict__)
> +            log.info(f"Loaded {module}")
> +
> +        if not_found:
> +            log.warning(f"Failed to find modules: {' '.join(not_found)}")
> =20
>      ubconfig.buildconfig =3D dict()

We won't see this warning normally, only if some level of verbosity is
used, yes? It's normal to not have both u_boot_boardenv files for
example.

--=20
Tom

--Ui1GPHiCtVaihFXI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVWvIACgkQFHw5/5Y0
tyw2Rgv+Jryctc40tVSijrfgO+dxO6ZmmGeI7Y9vz9wddr4FTQJQ/HCfzw5kG31g
EMTcfNbygEse7KVUbTpzc1C7uTuyYRcZlsF1T4MAokv94TmZftxG0enW/gNBsdiC
hFZnUnrAngaxMsKAypt2FGQnRHPhIJufgqJNCSAWvkbfJ9e8IQf7u+M5V3bBnDVO
GRJkpu0kCKudfNoKNh12S/my0RtAR8XpZmpSSHSqsKmQqhaII74COO8eDt35jjqZ
LGXg9Rp6RfKLzsYDSoaeeCwVROaHmf0SI4zkdDC09Wri/fm1PO+shVvlqrmO3Dd4
OlehuB13aSmzIIahNEp+K6l9NTba8CaRTRRW1H3FCo473CczL62KfGi76rvFO0Qa
JlbRsGES67lF3BsyDaJTixNGGRNLrqvx/8/h8IFF8Jf93BIAjfd3pvsBnL7q0Y40
u+uJPaFTRYp82Pfhi3jqK4llrsoXWEUypmBW2YrjFUcGP71et0Uav/WZvbVcSqlc
bDJTv2fJ
=wuVs
-----END PGP SIGNATURE-----

--Ui1GPHiCtVaihFXI--
