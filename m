Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CCFCA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 14:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8C14809A5;
	Tue, 19 Aug 2025 16:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y4t7eEip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86EA580FA1; Tue, 19 Aug 2025 16:57:37 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FB35802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 16:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-61bfa392bc1so1952013eaf.1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755615454; x=1756220254; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CQV8T2D/Lm+5ZClTnKHp88HcE3HQHxZhAlRIdnG95Is=;
 b=Y4t7eEipFI6pOAivP91fsJfdNbmJpNW+kIoyn9DTORpTh8j5BJIEAFYzGJoiZJp385
 Kl37mezA8p6zvV8v/m4RYrTOz/ChPGpncsDnyJlOqZMCTK6S3baMo6b/lVRzXmHlqLkV
 Ht7wUJ0wXHUyzy0/3uJj8JRqsCd45likRDPnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755615454; x=1756220254;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQV8T2D/Lm+5ZClTnKHp88HcE3HQHxZhAlRIdnG95Is=;
 b=NKF4scvMqgdcJCcrltSMMJXwz1SNCanm4otqO6viXL6HZLhbUJRYyu8ZRtBDtj3TN6
 Dv2fL/IuErP3xP8iqw1jC8o6rqi1P6lqJfrIemFA8wlSmco9D8vrs/jOfvAqqCFe1esD
 2mzyJRJS0nSr3vTAH1JcZjbOM1rZ3kLIBxqpvkOhJrH1lIHTuQ8zuR3xkkJJAiGmA7v8
 vGli25eCUz/vARS2imL3QXV6XwB4X6aZDqYQQQucMy2Mlo9TdTYE6XlLHVpQKa7rM+TU
 sJ2H5BPqYeaEldo+qx99UHYbYtEzmWpUN6i4SPLGHRkknY0A6Ag9tGCFlG3Uh1cXsvTh
 z6Fw==
X-Gm-Message-State: AOJu0Yz+Ov9oXZ9ODIH/fsqMe15+ClLeBmZvKB6U145GkY84lWvdgIih
 LKB72zqKSPvcHkXwHtijJxI/zV5D6OzfALjiqJKj8M16REC+LvhQjm/ic8rfKqHSOfg=
X-Gm-Gg: ASbGncu3L2T+NeRbhV/RvlIDA6XYvq2Pb9yPnO62jopCp248PehsSnHU5vwvuqOQ//u
 9KasmOYuaLs1GuiwxTR+0EmdWFrZWi3vCW3zGAiIKhJKv3lTP/KyNr17teO12jUG/wjSGHeFDrf
 9FV0V/ZOqPmEaKV8FFrtXARSJtmjxVuuMrMFXJhK9uWeAFODO9L1tv7XE74gYaioZ9vQECKh7rE
 IoeNIA4S2hVZjxuq+1DZRSu9PlXvB18SGMPalpzRyyQffefsXXgfvsXsfjbXEEuheZiGUWiyQz7
 /JdvBmZh4ljVrWBKX9e02L1mOPOtFTe8Bac9ZowEfMgK9iWlJ59WTXJcX9B1cp5S8cYAwuLpPtT
 qy+ODvuVppdeM3WCgKuORKv/JOGj0Uxs8gV06onmfKklmPbD43PRmqRd7
X-Google-Smtp-Source: AGHT+IHewiJhegY8cgNYGqqn2jriEJ1omxHb3xkyrihkmJbxgS7MUw/9aJG66bdikRav+zZldXoqrw==
X-Received: by 2002:a05:6820:408c:b0:61b:f98a:2f19 with SMTP id
 006d021491bc7-61d91c0922dmr1459791eaf.2.1755615453650; 
 Tue, 19 Aug 2025 07:57:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61bec11cd94sm1152968eaf.21.2025.08.19.07.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 07:57:33 -0700 (PDT)
Date: Tue, 19 Aug 2025 08:57:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Sascha Silbe <sascha-pgp@silbe.org>
Subject: Re: [PATCH] boot: Add LEGACY_IMAGE_FORMAT to DISTRO_DEFAULTS
Message-ID: <20250819145730.GA124814@bill-the-cat>
References: <20250818165119.3193853-1-trini@konsulko.com>
 <87jz2z372g.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4vz/0R8OPUA6VprH"
Content-Disposition: inline
In-Reply-To: <87jz2z372g.fsf@prevas.dk>
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


--4vz/0R8OPUA6VprH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 01:05:27PM +0200, Rasmus Villemoes wrote:
> On Mon, Aug 18 2025, Tom Rini <trini@konsulko.com> wrote:
>=20
> > At this time there are still major Linux distributions which by default
> > boot using LEGACY_IMAGE_FORMAT type scripts. Add this option to
> > DISTRO_DEFAULTS to ensure these platforms can still boot.
> >
> > Fixes: d780965927d4 ("Drop the special am335x_boneblack_vboot target")
> > Reported-by: Sascha Silbe <sascha-pgp@silbe.org>
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  boot/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 2ff6f0037384..a6fc46ff4f5f 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -1163,6 +1163,7 @@ config DISTRO_DEFAULTS
> >  	select CMD_SYSBOOT
> >  	select HUSH_PARSER
> >  	select SYS_LONGHELP
> > +	select LEGACY_IMAGE_FORMAT
> >  	help
>=20
> No objections, but I wonder if this, and all the others, would be better
> of being "imply" instead of "select". After all, DISTRO_DEFAULTS is
> mostly a convenience symbol that turns on other commonly needed/useful sy=
mbols,
> not something that is absolute required when turning on some
> "DISTRO_DEFAULTS feature".
>=20
> That would allow a defconfig file to set DISTRO_DEFAULTS, but still
> explicitly disable things like LEGACY_IMAGE_FORMAT. And it's actually
> somewhat hard to migrate away from having that set if it's select'ed by
> DISTRO_DEFAULTS - one would have to deselect that, but then manually
> ensure that all the previously select'ed items were set explicitly.

The purpose of a board enabling DISTRO_DEFAULTS (or something else which
then pulls it in) is that all of the common FOSS distributions will work
out of the box. If you want to manage what a board can / can't support
more directly, then you opt out of DISTRO_DEFAULTS and instead manage
the various options / sub-options instead. Like the case here is that if
you don't want legacy image support, then you don't support Debian (if
you're a 32bit ARM system at least).

--=20
Tom

--4vz/0R8OPUA6VprH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKSQ0gAKCRAr4qD1Cr/k
CkSPAP0Q7PnZVCgbVjLXwqxsMHHgoAWLhIYjIpSBaf9OLWMdQQD+NNn+bqlDx9uR
S+X1p9xnk+yJ1Ff2ryDHpqbo7zKRlAc=
=z4za
-----END PGP SIGNATURE-----

--4vz/0R8OPUA6VprH--
