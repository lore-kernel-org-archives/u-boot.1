Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A29D1038E
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 01:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6433188F47;
	Fri, 25 Oct 2024 03:08:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y0lCQzkc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2348388F71; Fri, 25 Oct 2024 03:08:38 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7342E88D3F
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 03:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cd7a2ed34bso8222056d6.2
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 18:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729818513; x=1730423313; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sgfPnKVjmc13P6yIo3LcqsnSujJVRq56Ut09wSoerrg=;
 b=Y0lCQzkcJ/7hVx28382+HNCD9wRQjIS7Bn/cbk2m4dcffickzF79Yk+YOrkAQ+sEpJ
 gu0+lf2+E74HBO20XNVbUNCHlahzeuuQYSSSDm+I5twjrQyJlRuSZtza+Xpf8lmzZZM/
 d4ryV8k+RvOx8+VNI+XTuOLWQ6WPrNGqIvgr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729818513; x=1730423313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgfPnKVjmc13P6yIo3LcqsnSujJVRq56Ut09wSoerrg=;
 b=WgwUFfd6rURH13PkipmOBPWtVGZofP5LQ8XKtyCBKGVo0PA1fuTci58ziM+uiYXgNQ
 snlo3I7eD79LQQxN/6uh9HR1bPzyUq9siNGNdwAZGQzfMWpqwMfgowG1JFzp7isY2apW
 phP7Fq5v0simQEKHoWx21E8O4DjhScJBR84gisd+vXI3ybvGtQ4B7sK+vWfJZw+PZO+J
 FPoHUDV2IViXO5E1HHFduAblksQaeX58wO6/nruv0u564GfbAqrOHdNbQ/wo86MdJJHD
 agXw3TtOHfk1EEqeHFionm09BnFZF5YtL1fW5fWbye3SyZROjRCU+Tv9lrP36nvSmpU/
 3MMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsXFTIynBVQ/+iAFQOANsq/6hlfBUBUUq81RV/hvBsPhMcvXvwaVwZUlmUne42nbEKwSg7M9k=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9GGyTJGvybsmSMWm8Fr7q0Hx7ZNbnPwB4CvxaY9pV4HoTFfaL
 y9m1PXYwJd5JtCXh/Ec7L539Iq0oAv0gIuulOr6sXYtfS6J/kNs0AWlID+pxGCE=
X-Google-Smtp-Source: AGHT+IEqzWu7svU9PTfbOVCZ5rDpcJxpvqSrVYscdFxms0pv06+fU+O9yMaF0hDl72mpoukq9WgmlA==
X-Received: by 2002:a05:6214:3a8b:b0:6cc:232a:ea0c with SMTP id
 6a1803df08f44-6ce342a4fbfmr114752296d6.44.1729818513293; 
 Thu, 24 Oct 2024 18:08:33 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d179a0abf5sm1173396d6.98.2024.10.24.18.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 18:08:32 -0700 (PDT)
Date: Thu, 24 Oct 2024 19:08:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 01/11] board: siemens: iot2050: Fix mistake in list of
 writable env vars
Message-ID: <20241025010828.GW4959@bill-the-cat>
References: <cover.1728539755.git.jan.kiszka@siemens.com>
 <f1a4ce2a80a6d49863717f5f4cb04fd48399b304.1728539755.git.jan.kiszka@siemens.com>
 <CAOf5uwm+pKx8o3=AxGcQJY9SiPSDE_2hjRLQuzFgdSr4DdFLZQ@mail.gmail.com>
 <39bfa764-452a-4cb2-b4e5-78b44ceb7039@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u3yEJ589BRXHdrNc"
Content-Disposition: inline
In-Reply-To: <39bfa764-452a-4cb2-b4e5-78b44ceb7039@siemens.com>
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


--u3yEJ589BRXHdrNc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 08:09:48AM +0200, Jan Kiszka wrote:
> On 10.10.24 08:34, Michael Nazzareno Trimarchi wrote:
> > On Thu, Oct 10, 2024 at 7:56=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.=
com> wrote:
> >>
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> This prevented to set m2_manual_config - as evaluated by
> >> m2_connector_setup - under strict configurations for secure boot.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>  include/configs/iot2050.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/include/configs/iot2050.h b/include/configs/iot2050.h
> >> index 94a9c767882..0f92e0d25dc 100644
> >> --- a/include/configs/iot2050.h
> >> +++ b/include/configs/iot2050.h
> >> @@ -39,7 +39,7 @@
> >>  #define CFG_ENV_FLAGS_LIST_STATIC                                    =
  \
> >>         "board_uuid:sw,board_name:sw,board_serial:sw,board_a5e:sw,"   =
  \
> >>         "mlfb:sw,fw_version:sw,seboot_version:sw,"                    =
  \
> >> -       "m2_manuel_config:sw,"                                        =
  \
> >> +       "m2_manual_config:sw,"                                        =
  \
> >>         "eth1addr:mw,eth2addr:mw,watchdog_timeout_ms:dw,boot_targets:s=
w"
> >>  #endif
> >>
> > Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
> >=20
>=20
> Sorry, just realized that I forgot to add your reviewed tags for patch 1
> and 3 to v2. Maybe Tom can do on merge.
>=20
> Thanks for reviewing!

Using "b4" got the tags.

--=20
Tom

--u3yEJ589BRXHdrNc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmca74gACgkQFHw5/5Y0
tyz3MQv+PgnkyagKxGh635mKBUjNxdLnNUmdxfKGXXARiXSceN2+WDePu28dSE9M
vLUlLHZM+OYyq7xrA98rW4aSxOJYfGz/fKs1jQAuRErnimYeVDdlG/q1pOnvM6pP
HrXoWYW0rkLYYAnvLOMmhB09tjHJlAd8AQq4oZPAYk0JERxzo6vEi9ilwfu+80SU
wTrW8KSNdmokIfqrdzLmQvOSN1ZysnfNcPFbXPNxiIjPALNKub1t4k07M0E1ILcx
FqEHgR7BO4gvg+lDIR5HDgsHHWUk/0S5BBf+J2d9aj5ZBfqZJXkoSPzav0uz2JdS
7yCn/Ig/TCp0GGSOM+mwG2YufqHdJUERURBn85wIVASG21a4pwojmBvof92+gFwR
Q5tI5H+RKGVuwF+ZtExsROV60yFv0PgeuTeRwZeDy+LoH4Ie3XHSJI3LM96UfMx4
EFanoQ2cnDfUruzVQ21BUpueyYdT0jF8l7VliFrQ5G6UY2uieJzarW9Cho/K5cIs
2EaUVWnB
=tMtB
-----END PGP SIGNATURE-----

--u3yEJ589BRXHdrNc--
