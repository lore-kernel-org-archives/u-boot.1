Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE92C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 14:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0723282012;
	Wed,  2 Apr 2025 16:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JB7zEJ7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8F7681FFC; Wed,  2 Apr 2025 16:29:05 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FE1080FDA
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 16:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72bb97260ceso1716017a34.1
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743604141; x=1744208941; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SwFgIrKnzQhug0sw1kzi0PqqIA1JtKnsdBqgpBcFSr8=;
 b=JB7zEJ7nO3n7Xi0eAmcl+tq+LFtGVkB4V5SZuQlclks9hzPtBLQKpbO/HkKrw4sqH/
 PlxO8X34evLiJWiLPNflKaKv5ZvBWTiOvroA6wfh8GCB+pPKUrpdnPgfq+T1MhljiXhB
 OoBcFOYOapNVYE+fUEL8FUZNU0xCGlquq2csw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743604141; x=1744208941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwFgIrKnzQhug0sw1kzi0PqqIA1JtKnsdBqgpBcFSr8=;
 b=Z+LWTJDeb0EebxQ35q4EfBryYFhj7nrWv7G4bHFDYxtTtcPUt31vaN/1EVLsDXT0Dg
 Hs96VJN7aC73ErlLuDnIZTTnDRM9mMxsUVXhvWLPATOM0KgVdCSHdesnRzA8j8VW2erO
 oLv+7m4d4S+6f7sjPxj7telnE095z0xMTrMRuT5uTIW61ysI4UrjmurgAyKtNeAYJ174
 LgdgKP/Sro6UoqEnlLW3lGRI4e+AJtCr9qTIgo/u655Fba6ClCXHVrp8TYJom3W6xO7D
 uYCms4HtpbbtCV+b8vXuBjCouQSmWRl4Qu0hK/3FqgoA5QCmqKFeclAVQhPtG69Kt6vc
 K1WA==
X-Gm-Message-State: AOJu0YzPmP1syh6i1hdmUwJjg9ng46laHKxq2PTa+SWcclTAIqhUhg88
 6OD/V/2Qn0aXejtFh6/514PsRxW/IWi1kJo9Y4tAM/3S7bxaxjKi2P2OeInC2kM8eVVwpQo8c+D
 /
X-Gm-Gg: ASbGncvhLsvdIabayKyfZ053NbtSuGFaXOjEpj10zSBioCzH/F1ZoNTps6r0N/tVgIV
 3E2rfoD0DUVnZSNs+f1yNCU4M1swZuZlb+vzseZRa4QYf8JljOZkDMSNK/h1igFRlG3EgUpBVq9
 XG5vCtCXWoFbmnFyVWYId5OzMSbdX/bQ43ct6Fvm2z+d20pnqguO119UgU82GktSCfyAE1PBO6+
 rdv42aYoJEjb6uBR78YPzyfL/2b0+4hT4o8GlBVypVedVuuYjWGV+PFnw1rmFUtFy1FXfEFx068
 Da/QoEjGqTOss7/qx/n3f8mYXy7YZQlYPFHgYJ2NQKOfqNTmFiReCIBN3fYj9GQ8KYo2P5wWU5K
 tIgvDrKxI+o+NtD4A
X-Google-Smtp-Source: AGHT+IGOhLnzXLzwFXFoTHdDSfCwPCW73A8cMXwL5/SK+mc/Xcw/dMXXjEtqWn8eAK40BsucyeW8DA==
X-Received: by 2002:a05:6830:3742:b0:72a:1625:ef11 with SMTP id
 46e09a7af769-72e258f8075mr1585994a34.27.1743604141058; 
 Wed, 02 Apr 2025 07:29:01 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580c8b1dsm2286867a34.28.2025.04.02.07.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 07:29:00 -0700 (PDT)
Date: Wed, 2 Apr 2025 08:28:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>
Subject: Re: [PATCH v5 40/46] boot: Support IO UARTs for earlycon and console
Message-ID: <20250402142858.GT5495@bill-the-cat>
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-41-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jalJla3zC30p88bA"
Content-Disposition: inline
In-Reply-To: <20250315142643.2600605-41-sjg@chromium.org>
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


--jalJla3zC30p88bA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 02:26:00PM +0000, Simon Glass wrote:
> Update the string to take account of UARTs which are connected on I/O
> ports, as on x86.
>=20
> Fix a typo in an error message in the same command, while we are here.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v3)
>=20
> Changes in v3:
> - Add new patch to support IO UARTs for earlycon and console
>=20
>  boot/bootflow.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index 58a1afa7a75..4054a966af8 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -942,8 +942,9 @@ int bootflow_cmdline_auto(struct bootflow *bflow, con=
st char *arg)
>  	*buf =3D '\0';
>  	if (!strcmp("earlycon", arg) && info.type =3D=3D SERIAL_CHIP_16550_COMP=
ATIBLE) {
>  		snprintf(buf, sizeof(buf),
> -			 "uart8250,mmio32,%#lx,%dn8", info.addr,
> -			 info.baudrate);
> +			 "uart8250,%s,%#lx,%dn8",
> +			 info.addr_space =3D=3D SERIAL_ADDRESS_SPACE_IO ? "io" :
> +			 "mmio", info.addr, info.baudrate);
>  	} else if (!strcmp("earlycon", arg) && info.type =3D=3D SERIAL_CHIP_PL0=
1X) {
>  		snprintf(buf, sizeof(buf),
>  			 "pl011,mmio32,%#lx,%dn8", info.addr,

I suppose we're well past the point where we can delete
bootflow_cmdline_auto() itself because that's just going to lead us to
trouble down the line (5 years from now when the kernel adopts a new
preferred way to pass this info) and grows every platform by some amount
of space every time we add something new here.

--=20
Tom

--jalJla3zC30p88bA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmftSaoACgkQFHw5/5Y0
tywXQwwArq/n3XawTuvZaenFTi2x3GPkMn+e5mxpPcFw1EcQf/YZqz66aWlDm6tI
jgPz4FxZPRDS37u+ywsb13YSxYw/f9hJGDQ8Hl78GTTvPd22AnkePqaY9P7lJT5/
PNvU/YzJ4qJmgZ9gBf2TW4yjhfrKsxwWquF6mg0YwE8tmzf3n4YOyyo++5GoaKV5
fjAorxZWqn9jkrhz2AFiLFwGWwozG8OtKZE1ddiZxabOc/ruyFAcxRzpaX5mRKgd
6kU+sHFBMtdfOl6VivyYPbM8TPazVFb2XNvmKTn20+BakyQK2789PwefCW9XKvvI
Tmx6pUINLVm4cPTebDN3fj/05eJEX5i9RL0ESXm64VGj3MaJ1qLppwFQz25hwPph
cVPOL/97N0esO48NjrMuLOnoS1vXXQlbWWgHAx62qLfc9hsJHyOU2hj2h+mZFxzn
djXj1jYTdDaQx7IzPk49Wg6pgKFvdpSaliTHZIa6GlQQYcV+7aLesodFiAyTIxGV
2GUa/rCY
=hvIe
-----END PGP SIGNATURE-----

--jalJla3zC30p88bA--
