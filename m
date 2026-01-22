Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA02D6CFA2
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 19:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54C7E83AC5;
	Thu, 22 Jan 2026 20:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SU99FsE2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C9B983B03; Thu, 22 Jan 2026 20:28:47 +0100 (CET)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED9A4839DF
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 20:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-40444c41a70so668370fac.1
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 11:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769110124; x=1769714924; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sr6hWmitW242Pdyr2WN4TzUqyRyBU7WkwcqQ/boLDZ4=;
 b=SU99FsE28dWoyHJbIWVd0QVUwplnkXXb3HFgZSWemAzk4M3cYGXRfGaAyVkUV/Gs2u
 lkQ8tjCPYxO0hjq1S9GSBmHR/Fmnl+JVzdj5I47aIQPLYCOt7oyGP8xvnCZC7JBtqEYb
 fmR7KkYosPqSMuk/FdG1P5AL4PYO7VUP27UlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769110124; x=1769714924;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sr6hWmitW242Pdyr2WN4TzUqyRyBU7WkwcqQ/boLDZ4=;
 b=jAFnfduOrQ7+tXbMqmaPP779OuRYrdajHAbECfG8IJM45Da9cupZJY9WFH2tbmjCrn
 yeDgt4zQ6jVcAh6eKfaxzw5xeRjPFs1tWs+I5YnU2r4auMIAFlENXOZKIvRtne2mXSeu
 Am7HRYQlBtbvzjvnr9hSrPxqc2w0huDJFLxPbXdfhm4fSgK9DG2U7/5JYSdGbFAld9nN
 99nclFi11Gx5ulTReKGcqKCbKIHNRRkChqGpD3BlnAQ73I8+nGxZyySKGKxBJqR9iSWi
 0+ps8VGv8/atPoRuiu+kcxIKQEvhLiiikb1PmuoQWX1bePxVfxvH/8WoH2m8fU4e92jm
 nYwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjI5ajXixCnqDsBN32yp6f3fSXIT5c3SOCSO5Xbqs5uYL00oud/GPKLgZkSox/xs3A6YPhdjc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzh05fbDZ16lis5m3TBd/jJ5Fshrss7DbOAXGnVru+lZ0prkuyd
 AOn7t+kyasPq5Hgu9P5fU0s28QpgF9juUJ3Sg/BzSXFCbmeXKd8oQGOUCFD339VXypU=
X-Gm-Gg: AZuq6aIRAmWEmtREX+D2D55N1yOq2boG4dtVOg7b+CWjrz9iPL+qlqPg4UBsxN/RBD+
 AMh4NwPkzVqw28gXGfLsXrJGGkiv75h/K7mEffxkCAFs/xfV3AOjErCjjkOX5YGuCq1RvmHNu6y
 S/k4C84p1L/vQZ5c6YFTpBY8OE+2FUx8jiuKGgzw7TMLTLnAqeczweq0hayMRGRXZJzSuKQwQrA
 tOjY41HMBImwnCX17OqWrkwdQJQcu4fbdg+eXGttcjV3mebFWRzr8pb4qZhSp1FXn7Mjm3L/JQt
 7K9P2KFgzMirgjytEprCWDBMRjjC7GBHaadCF4RH8+pTasoEz8qg0yyLUQyRa6GelM0y/1q6tFv
 APtG+vqNtNa/E9ejwh1JxtgzUz3SIcBHKkOaHZRPiWtzXQP3Eovz/KYjU6TGBlUEi0jyM2gJtru
 DHg3M80KMud1jgBjPyomzbeZfmSot9761tqh/mdIDbP3iVwkS7IQvJDGnHdoU9MXEF5Xhu2wMjj
 3cuQUw7f1k9Scw7brGw2aoJYRgB8TO+PNYZ4d1zJhUVi3JgUg==
X-Received: by 2002:a05:6871:790:b0:3ec:4b7a:7ceb with SMTP id
 586e51a60fabf-408ab834bfdmr389091fac.48.1769110123619; 
 Thu, 22 Jan 2026 11:28:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-408afc09d62sm34199fac.18.2026.01.22.11.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 11:28:43 -0800 (PST)
Date: Thu, 22 Jan 2026 13:28:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joel Stanley <joel@jms.id.au>, Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
Message-ID: <20260122192840.GE3416603@bill-the-cat>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
 <CAOMZO5COTa3ykhF8XZyzmJ0QZNotK4USo0LrH0XBJLogatfXFQ@mail.gmail.com>
 <040e129c-44ca-4a59-828f-d37c6e41d3b2@mailbox.org>
 <20260122142323.GX3416603@bill-the-cat>
 <CAOMZO5AZiBajXK1b6Mse9LPwHEzhJSM_-OcQs4BsnbXP3WzuxA@mail.gmail.com>
 <20260122191042.GD3416603@bill-the-cat>
 <CAOMZO5CJ4BAi95gjV8a=_W-Wu=zr1dMOoDOCB4yUVAzY2ARBUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cIRcdj3DreTeR/aA"
Content-Disposition: inline
In-Reply-To: <CAOMZO5CJ4BAi95gjV8a=_W-Wu=zr1dMOoDOCB4yUVAzY2ARBUA@mail.gmail.com>
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


--cIRcdj3DreTeR/aA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 04:19:55PM -0300, Fabio Estevam wrote:
> On Thu, Jan 22, 2026 at 4:10=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>=20
> > Can you please share it with my off-list maybe? I'm still confused as to
>=20
> My work-in-progress tree is at:
>=20
> https://github.com/fabioestevam/u-boot/commits/rv1103_prep/
>=20
> This tree boots fine. After rebasing these patches to the top of the
> tree, it fails to boot.
>=20
> > Well, where is the dtb ending up in the resulting binary? The addresses
> > are aligned correctly, but the dtb isn't where it's supposed to be,
> > where is it instead? A challenge here is that I could only check the
> > linker script used by about half of the 32bit ARM boards
> > (arch/arm/mach-omap2/u-boot-spl.lds) and not the one used by the other
> > half (arch/arm/cpu/u-boot-spl.lds). The initial error you reported makes
> > me wonder if we can somehow unify these two afterall, which would be
> > good in general to do.
>=20
> The spl/u-boot-spl.bin file is 4 bytes longer in the failing case.
>=20
> Let me know if you need any further clarification or if you'd like me
> to test something.

Oh, does
https://patchwork.ozlabs.org/project/uboot/patch/20260122172247.2995437-1-b=
-padhi@ti.com/
also fix it for you, or no? Trying to figure out which case we're
hitting now..

--=20
Tom

--cIRcdj3DreTeR/aA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXJ6YwAKCRAr4qD1Cr/k
CjMYAP0TSTodKvaWcoRs4Ce4kttiPBZv7IHZWrKOy+GkP9Oi9wEAvWQP7hFx4vrr
dQqSrpV550u85y5EGK1pjQ9iNME71wc=
=LFm3
-----END PGP SIGNATURE-----

--cIRcdj3DreTeR/aA--
