Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462A8D206BF
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 14:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC37F84073;
	Thu,  4 Dec 2025 15:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FR1BzGsb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B3EB84081; Thu,  4 Dec 2025 15:47:24 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD03583A57
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 15:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-657523b5db0so254600eaf.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 06:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764859640; x=1765464440; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=42W99Ubh69AmasOsBdP+CBH+846Z+LhKZ0aTjIl0wpI=;
 b=FR1BzGsbDS7KPzAt4GZRs7/FjkOuPfy4pzBIqKsdP6WjxcOEa/V//pXQjB+08FaVCd
 PJ0WfUeXqlEi/H3RkYkzchgceKx7JelmfydtdwZhkVcBcvnb30HtQtlp8OPuCUyh9k3s
 Q/g9Hx7c0EY+4RIsmcadsAdNV+Z2zo4xm/Oi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764859640; x=1765464440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=42W99Ubh69AmasOsBdP+CBH+846Z+LhKZ0aTjIl0wpI=;
 b=PKDHWi7HNIUGikZmumJxWmjoRgJk6hfwYvLdsj/eVLkUJNZaNMzqv0POqGvqae8xlZ
 CrT3H1v+k7xRr6eS1fpCtmbk+Ux0nhVIKnJ1cYkH32X02+hapK8CfACYc7AdimKwrtCx
 9mUC3s9cEhcGv+yM9LdFfQGfN0IQcD3pmNKl8rMV5tq3wJGHzxSyPbHGianEwH2UolN2
 gONdI2WL2XNXt2CRlVsP59rR2h+z5+UaWz3PHIZSOqLljCuuBsV6Z9Qe6VWBzUw9YN/K
 X5gGP83ewpSFdD4HK72bOjBsg4EbrKLEmU6SvPvxJS8qF3wwh6M5DLP2wzF0UrBEOgSf
 WJWw==
X-Gm-Message-State: AOJu0YxQ7fHXZvCumQbtR5tjWTJ7bD8jQ/0OUOYNpD8ZByLSiyP0UmkA
 y3f5c1L8pyOb+U8FwvnDCFFekJzgwWCy/wwHldZo4Drc8tYA8fPy8BXWEF0EFU6MW8M=
X-Gm-Gg: ASbGncsHz7tmTkFZ28WB30CykFWWpyOnKh6SJAwS7ZWba0694AoaLKrbdPQ7WvoWhQt
 Sg5/kNhH4i8qMoAlsDEXtjbxhKonzTVlI5OCwv7R/IJRJRbGasuoME7KeG09qxpZjtqKYQBGKxI
 zRqACzbhsmhTlQpVp2mOVaUqF2uUzpE8r4oNJFT9+gMztY7mmEf1EHMK1rABBngJki8s8rbc6XF
 OdzvfvMPE01ZK99IsBOLlinqzXiWug3PHQXHh2hw8lY/78afHIirduVWY/P++kcgmOcAyIWXQ3w
 X2gZkCunoQ39hI9N9VAKqQYioWUgi0aB6YLPpzOOS17sq4IyE8n/D8K9VfrIoyNglXTGb3EUIBo
 hLkAqSUh2LKmKygPXKLWBlcft9w7YLyAVlVDSntLFEhWcdCRT89Z9hrwntqRLk9ee7tLepYhQEh
 4qTA7znfIODTE2cbS+8UIgaaCBBqNadYrjNAZYdkFjmqfW+lsuKw==
X-Google-Smtp-Source: AGHT+IGlioqVJAFcHYF/3Es9SoeHl7HPHXNoyug7CFU/Lstk+op4o8ByI98h5uzvI80ef8bBzCGPag==
X-Received: by 2002:a05:6820:704d:b0:659:7f3a:7d55 with SMTP id
 006d021491bc7-6597f3a8059mr732840eaf.6.1764859640591; 
 Thu, 04 Dec 2025 06:47:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6597ec25ed1sm788835eaf.1.2025.12.04.06.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 06:47:20 -0800 (PST)
Date: Thu, 4 Dec 2025 08:47:17 -0600
From: Tom Rini <trini@konsulko.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>,
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v3 4/9] configs: am335x_evm: Unify evm board defconfigs
Message-ID: <20251204144717.GW303283@bill-the-cat>
References: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
 <20251204-topic-am33-evm-oftree-v2026-01-v3-4-3d1566ce4dc7@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x4r2bR5w6IYeuG6V"
Content-Disposition: inline
In-Reply-To: <20251204-topic-am33-evm-oftree-v2026-01-v3-4-3d1566ce4dc7@baylibre.com>
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


--x4r2bR5w6IYeuG6V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 11:25:40AM +0100, Markus Schneider-Pargmann (TI.com=
) wrote:

> Much of the config symbols between the evm boards are the same
> independent of the actual board. This patch creates a hierarchy for the
> am335x_evm configs:
>=20
>   am335x_evm.config
>   `-> am335x_evm_defconfig
>   `-> am335x_evm_spiboot_defconfig
>   `-> am335x_hs_evm.config
>       `-> am335x_hs_evm_defconfig
>       `-> am335x_hs_evm_uart_defconfig
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--x4r2bR5w6IYeuG6V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTGe8gAKCRAr4qD1Cr/k
CtqwAP9m82SwXl/er6FjcMGnfxBXv2Jw0IDjO6l8PVpFsL7xYQD/ZqHo8QWUyQFT
DXJgg4n76MKDN7lowvdvKaW7eE+qqAc=
=PZeo
-----END PGP SIGNATURE-----

--x4r2bR5w6IYeuG6V--
