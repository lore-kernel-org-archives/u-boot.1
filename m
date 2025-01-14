Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF1CE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 16:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE4FB806D4;
	Tue, 14 Jan 2025 17:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BnCP3wBp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16EEA806D4; Tue, 14 Jan 2025 17:58:20 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17DAC8060C
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-467a17055e6so67363191cf.3
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736873896; x=1737478696; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qdXEaxYJ9rdTBWxg8o5nxlwDiWuLtxqlxm9nXo2bTb8=;
 b=BnCP3wBp/ReaTp5wrWqOM47BAlL2gw2qhGIOsPBb3VMdelqG/KP7AVwjMqCaj2gojJ
 OjZANacxCjKWk7Fu73C+mIDoRle7W38qsRodsdSutZA2qgVK6g5bmJMcGTErR46biC7u
 9Fyx83Tv2Vp894JgZQ3mK6TnWUlvTFh9lP6/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736873896; x=1737478696;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdXEaxYJ9rdTBWxg8o5nxlwDiWuLtxqlxm9nXo2bTb8=;
 b=ELk36bqzxXdxDkUJoH1/mF203pAhYyBrgc3aPhAFatWG6Daa77CT/qOxSdvMi7uo0u
 Eb1mQsYEgOe1zIh+Hp1dDB3BUy6Ym36e367cu351P4JyClvLOGXWrks7z/53hmiPZNXx
 +MR3r0jAdDSmd7abTO4DfWgSy2CLzDnLHKwhrz4t8nOLKEaqZNvMCNV3gQPruyUSmhwm
 FPBbNZAzH16uo7TmqFrKLp3Ns6WIcBuGgVku9o2aKbEYmPRfAaXs5tTq9oNIFlNsdg6j
 t8EjRxRHQL+YU5ndOXEjk2YjD6siPVjsb1xq7CYqqnuY/ui7KgSA9EhuvZs1YoSN9izA
 0UpA==
X-Gm-Message-State: AOJu0Yx8BBBO0sgE71ydXu3+jaZhSCj4bne44sCC0qndd7YjPDnMAukI
 0f7tEkxymOK+aAYdGoEC/MpnMDr191PK/Pns/EInxh/v/5BHbRT8c8gvAa3cov4c0H6Mw3VQ5tA
 v
X-Gm-Gg: ASbGncvZ6Qf7kBQZzv0I9TDCWZ47uGXbOkc6s6Hvg+Ag417aTBL1li826wNgWjPaCb4
 TOOSHQ/nI+7YKXB0ydq54fHoTKEScY7XJkPyiGfd6lkSSUWquGRJ0u9ekoePP12fSRUDmZ165ra
 QJnspxmRbrz5M3akKJDAHr2F2HPEhqqOJVOk4rpcLhwPt8uHIqvWPt74+TCweTc2Lm6Q6hnmPnN
 YEFOSUNRLFAHUzqD1qtoFmnu4h/JTjHMNLldt04OONWuGE95IlBXw==
X-Google-Smtp-Source: AGHT+IHqU7b0ZQJew3Qm+Hy5uxEYXuZye/TnTYdiKAYuDIhQvt/3hSRK6fUgVnaR7ChBLn0IpcGNsQ==
X-Received: by 2002:a05:622a:199b:b0:467:52d4:3c0c with SMTP id
 d75a77b69052e-46c7102c96amr422932911cf.32.1736873895975; 
 Tue, 14 Jan 2025 08:58:15 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873df366sm54108831cf.71.2025.01.14.08.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 08:58:15 -0800 (PST)
Date: Tue, 14 Jan 2025 10:58:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/6] drivers/mmc/Kconfig: Remove extraneous BLK
 dependencies
Message-ID: <20250114165812.GK3476@bill-the-cat>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-2-trini@konsulko.com>
 <4bc57e54-50ea-42ef-bd77-983cc1740764@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BWnYdUxGTfxTGcdc"
Content-Disposition: inline
In-Reply-To: <4bc57e54-50ea-42ef-bd77-983cc1740764@cherry.de>
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


--BWnYdUxGTfxTGcdc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 02:25:45PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 12/20/24 11:22 PM, Tom Rini wrote:
> > At this point in time, MMC will always have BLK enabled, so we do not
>=20
> This was not clear to me as to why until I read the definition of the BLK
> symbol. Could you please reword the commit log to make this clearer?
> Something like:
>=20
> At this point in time, BLK defaults to enabled when MMC is enabled, so we=
 do
> not
>=20
> With that,
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Will do, thanks.

--=20
Tom

--BWnYdUxGTfxTGcdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeGl6QACgkQFHw5/5Y0
tywP2Av9FyIFa6EZgTOPlOnjzR37t1Gg7i8MuYlHah+sOjsggZB+g1sToWhDhwEr
4SftPt/7rbaqsddOPGd/G9vXP0SxStCwfj0nKuIUZ8DHBqXEYd24Shonc3XCcUd2
uMFi9wXbmocVAfelowRjFW3rPrwob5dzCjjft+UoMsybC4v857gCem74wKKACVb1
P4litYgOYdODH0PTYyOs8TsyTwnAkUD1vsiO8DqT+uxMwyiftzIOtMhNWE4JfcUF
/UAE/vX024lbKxNfaaXPaqYSokMN3ph7gX4259F54GiDOM7lrkGKD8ji6jC6S+uQ
dOjP2L177Uha35pAryicaB9NmGQZA1ktQVKVUx+JGUBpNM2zwp/xEk4OKfqmMWvK
RgODNCNc14JiZZSCSARLcAlJBAGPR4Nn7sLIVRqzGRdR8tQzn9UP2t0tV/bG4Xoe
14XgvidUeY1KTGfpKb3Ii0KDxfwsIEeckkeWj8ApL5t55QiObAwbmPEDSJigZI6o
z3UhZkvo
=8jbO
-----END PGP SIGNATURE-----

--BWnYdUxGTfxTGcdc--
