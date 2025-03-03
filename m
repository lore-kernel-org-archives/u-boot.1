Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DB0C282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 14:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5B42811DF;
	Mon,  3 Mar 2025 15:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BmaX8/Qm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90F39811E0; Mon,  3 Mar 2025 15:03:08 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EDEB811DF
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 15:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6fd8be1e534so5034587b3.3
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 06:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741010585; x=1741615385; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vjp2wXDsZyxM6GiGuxirLBlH9KwR1/+13769SGrMMMo=;
 b=BmaX8/QmwIa51h48/UkTt8kaXk4MV2c/KEWoSNOQ2X39QApml/HA+8jjESRDF2iTUv
 yRKGDAgwu4Jhz2j9xk1tmCmX7CaAYyjEoykae5FWUTh8H0BYWgANMYe6haI2NojuS6sO
 qgL8hQEf31ImTDorPaZClvsrCTS7iZiRKjF3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741010585; x=1741615385;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjp2wXDsZyxM6GiGuxirLBlH9KwR1/+13769SGrMMMo=;
 b=IvG9/n/GOqq+QerXpjS1vZrwR0+RxQ4bMVuJhnuDHdklX8wkjAhUMwn8vbAYS2IykA
 BGxEG9xn0nHbJOMWWiWXBvx13eGuNOy6Io8PI5qQpe/pjs8y49ywoJLrmW1bKb6ymT4e
 JBYbkDNrYCvSwCf+pB45uu3yq9X6nch0kZzl7vum03kKzgTrCvK+R//fIa9xXgDnujR0
 OPT8dtgUm2FmrfxMnVpUUclwDVBgBZAuh71tS9Cw0DNDfTCx7oIz0HjquG8M1W3lcoea
 WfnykBJ8pBlisk5uJUZl7T8/SO1240bqvyO1AtpALck+JBJeoPduFq/IeZjRvuv1OszI
 WlVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+OlygpKGXCg1xRnq/i5VkfMHs6Ay3nEcZjOhveaLG1fByUl7YOtx48hGeN2hEU/hz4oGVP4k=@lists.denx.de
X-Gm-Message-State: AOJu0YyDhITR5SxEFnGiRkLii+2PvnQdS5f2ajmClSpJksTJ3qwfH7hI
 RliS86WOJLf7+X5GH9V82Ej3pbTLv1WhlY+7FvIT7Pweol8aPXMU9yi/7SvnN58=
X-Gm-Gg: ASbGncubzNrq5Xw4mQprwORlSi0IGvaTCPdye/aadi8npwGFNWMY2IG9DVAaDKqctGb
 VVWlxTOGKvyRh1fyM3PuECqiB/1vuGb258rQS8BnnF5nVOx1TK9CjTMwRdeVxXDK2WYPi8/pghz
 H+BKCaD/G/NGbJqoqiixf8teU0uO3AANIFNirNlJx917x2CJCr8By1OV5iv1l+kMdiF+lsQw0p+
 YFmg7+64E+UhMBhR0d/4GPdCPCBvk2d+sfWp4RD+zZNkLR5n9HKzA6Lt57uiilK6F5PubifTWlF
 nvp69puFrDFQqiSOumlwex4mJfLI8DGW44HpNkQYCqo=
X-Google-Smtp-Source: AGHT+IFIZ+Vq4Ozgk5RJhoQQL0GwxvuXqWKQ7pzGkOH/Ioid/wArpVNT24R1ZT7p7XNg7MoZvDZ/Pw==
X-Received: by 2002:a05:690c:4441:b0:6f6:d405:7010 with SMTP id
 00721157ae682-6fd4a12e035mr166632517b3.29.1741010584842; 
 Mon, 03 Mar 2025 06:03:04 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3ca462bfsm19975647b3.45.2025.03.03.06.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 06:03:04 -0800 (PST)
Date: Mon, 3 Mar 2025 08:03:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 Tomas Peterka <atheiste@seznam.cz>, tomas@dronetag.cz
Subject: Re: [PATCH] feat: Add CONFIG_BOOTCOUNT_ALTBOOTCMD to Kconfig
Message-ID: <20250303140301.GQ2640854@bill-the-cat>
References: <20250130164758.GC1233568@bill-the-cat>
 <20250131100845.31380-1-atheiste@seznam.cz>
 <173955934703.3052361.10140738654072110732.b4-ty@konsulko.com>
 <CAOMZO5AvRCmZHtOTuw6faW6M0BPJxTsnQ6uu9xHQTX6ovGi-RQ@mail.gmail.com>
 <CALeDE9N_XsqOfVryKSu9bT2NBkGMb+-AvzzjMOLMgQerDLJp7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3CiAD7s2irdL+lKt"
Content-Disposition: inline
In-Reply-To: <CALeDE9N_XsqOfVryKSu9bT2NBkGMb+-AvzzjMOLMgQerDLJp7g@mail.gmail.com>
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


--3CiAD7s2irdL+lKt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 01, 2025 at 06:54:37PM +0000, Peter Robinson wrote:
> On Fri, 14 Feb 2025 at 20:06, Fabio Estevam <festevam@gmail.com> wrote:
>=20
> > On Fri, Feb 14, 2025 at 3:55=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> >
> > > Applied to u-boot/next, thanks!
> >
> > The author's Signed-off-by tag is missing.
> >
>=20
> Maybe we need to add a CI check for sign-off's

We actually have two checks for it, and I believe both of them caught it
(it's not in gitlab, it's part of my build tests). The issue really is
that for a small contribution like this, a Signed-off-by didn't seem
worth asking for a v3 over. It's small, the relevant discussion threads
show this was developed for upstream and adding a Kconfig symbol isn't
the level of contribution some malicious third party could start a
lawsuit over on the authors behalf.

That said an after the fact Signed-off-by would still be appreciated.

--=20
Tom

--3CiAD7s2irdL+lKt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfFto4ACgkQFHw5/5Y0
tyx1Ngv+I4y69LFM8f2Y3Dl0dTgAPsFopBcq+31YNHPInwfwK9WSfEBAWyVBMHfd
xwYDy2qxgNxXlaWVvPvGhtkTFKGElBtiNUPRZgsZKHenSKs032et48SBkaILrJbq
fkpuhCLRHt8Xlct06KpFpYVXD/JJekKRT8K+ZfDw8Xdxs78fRGmTKazKXGQA0/mq
1pUnACrE6ON2NNvnN73J6NyYkkP48FYHM94QiF+E4jVktaS3nDfDbav5NBniicfJ
zTz5FX8l85R4BZlhHNRuP3e6IpfnEy5tj0BcuzTrBO9jImDmlYlKG3LqD0NSapjP
JlKiAQVNSYmtlI4AOTbJ1g6/jnwQqAcDydzS/72ZNsEfTa+1wjuNpYh7a5dk+Uwn
Yolly3EAzF73ywLvXAbcNVzt5b/qwJ0EG8waYAYhEX+INPuGtq9g+qb3Z0Vn3MYE
xGv8G71tUJ5YsQ9Dmb93pJBVhUgAOCMYDo6eedWHINTzBFNlQrRic6m5QLnrDX/O
ickQHKhq
=dnuH
-----END PGP SIGNATURE-----

--3CiAD7s2irdL+lKt--
