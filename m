Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76826E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 13:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DE938021D;
	Thu, 19 Dec 2024 14:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dpDwMGq7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 555778022B; Thu, 19 Dec 2024 14:53:48 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B279801F5
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 14:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-46783d44db0so6749291cf.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 05:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734616424; x=1735221224; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/IfbRygg2fjnVKmkkZzHfW284woAvVyRliRGC190DL8=;
 b=dpDwMGq79cNwEEy7xJ3v1gddh6CLIwgdPwPsXehKRmU3D60zq/C3CCWEs1dZZdMb2a
 OEw6WEQ5b3dqsDt3hlnVVrSzJ3i2xzly9310UIzG436C6R9eA3dFqZXfDjHRuU+myGvb
 GjbCpZC16GQiYXIG714nXHsSphTQXnhQYHBaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734616424; x=1735221224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IfbRygg2fjnVKmkkZzHfW284woAvVyRliRGC190DL8=;
 b=h1/hcGdb+wXo1cqotBo19fC7Mno//igQWpvYow5UnsBhnXgPWosn/9DQYtPA6rjQj2
 rtJ+w2l/DvOyiiG5Zu/vHBoAkQfFTiXjBnBJoSpICPETtpZuC/TClCXIF0mSl7lx8jkw
 5plDnMgZINBQM2nJ+o1M1ixHr5ne7ro4wUibH0dWv21ssQqYCzDaz7msx98dO0X68gUz
 JNCWqfL5GLh1sfMFbg28vYBDhXOLuScfmqyR1toUMRgYr2vMHMBgMukWw1PO2/KMMW8E
 U0rEp/A6kxYBNGbx03XV3ugSy9sz7tSqPG5adiE/a5HStXTMyr4qmJGqv+NixBBQvumw
 3oog==
X-Gm-Message-State: AOJu0YyUtMUd5YhUGbc1517U+a+NSuk0zEHE2GgvBv3OixmBSOazJyes
 3IXvgs0w5x48KqAJW09Y2Yut0HBz/B5U+jauJzbeFI0usDLiJcYw7UDw1ps2vs4=
X-Gm-Gg: ASbGncv1osWvZvsFP9fgE0MDOJ/QqWLXyDBY9R0bP24xptkhFTM9XW54lLlYaRFFN7q
 HvIEg7VCWTM4RynMPRp6x0x7WFXe5gNnYNTsXYMrZ/XN/UqoY8U/ucBrlTbVr6QzSGWiN1OVo7v
 ZdsRlPfynDP2Tr6nwv8+nZ/c7xOftjtEluQjTfb6UiYFnD78/Ov6OJssg73/XtdelTP4zWacL9Z
 ju/Y4pe3ZqiNiv82Mez/uWb6mhB+6IK5+VyTw/leYwACWELRUNTtLyt
X-Google-Smtp-Source: AGHT+IFJx5wyK1RldQmKw8h3LZRl+oRSHsql1ICfYr4LE0D8vv9jHRILURuF+tfKEUcpx4n1WILu4A==
X-Received: by 2002:a05:622a:11d5:b0:467:597a:be50 with SMTP id
 d75a77b69052e-46908dbe390mr145430971cf.4.1734616424389; 
 Thu, 19 Dec 2024 05:53:44 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e67e23asm6208791cf.22.2024.12.19.05.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 05:53:43 -0800 (PST)
Date: Thu, 19 Dec 2024 07:53:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, sjg@chromium.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de, jerome.forissier@linaro.org,
 mkorpershoek@baylibre.com, akashi.tkhro@gmail.com,
 francis.laniel@amarulasolutions.com, ddrokosov@salutedevices.com,
 git@amd.com
Subject: Re: [PATCH v6 0/2] cmd: Add support for optee commands.
Message-ID: <20241219135339.GR1505244@bill-the-cat>
References: <20241219043918.1646095-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WHdaro7Yv2ttDAha"
Content-Disposition: inline
In-Reply-To: <20241219043918.1646095-1-venkatesh.abbarapu@amd.com>
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


--WHdaro7Yv2ttDAha
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 10:09:16AM +0530, Venkatesh Yadav Abbarapu wrote:

> Add the basic 'hello world ta' command which increments the value passed.
> This provides easy test for establishing a session with OP-TEE TA and ver=
ify.
>=20
> It includes following subcommands:
> optee hello
> optee hello <value>; value to increment via OP-TEE HELLO WORLD TA.

Neat. Since we have the ability to do something like qemu+TF-A+OP-TEE in
CI, we should have a test written for this now, so it can be run when
someone has the time to add it to CI. And we also run on real HW that
uses TF-A + OP-TEE, so we can run the test on those platforms now (or,
as soon as I update OP-TEE if needed). Thanks!

--=20
Tom

--WHdaro7Yv2ttDAha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdkJVcACgkQFHw5/5Y0
tyxazwv/WE78R6WgTA1E0Ar39x7pEuHNelBx+pWwViVWcl7U+k9x6e2iuIsor+fi
ntWmFGHKbbOYsNyxWjPbiuSdo0aquX4vWPtrEnBBQOCD+JKzgb2sZlPC8fEEOjKY
ZPTHr5xqbiHu0JBmk8AAkjQ4i1dO5kEqUzM27vK7FsBh9lIm6A1/AsnrzMgWs3NZ
lZNIISsLCeNTq+vrXF7BGYrhYLn4HuWwlZEHOGON0lP4JMy6o8yhI3YXs73w5taJ
iU582GBi7twLjIBoA6RRPRnRdNAn5IXru/C14HmJKslNhK1RWwI0s2J1cTeI2oa1
uMIQ560/VYKmsUQ2EjSdEvtQoPB1G9tCjq4aTX2wpAwZq3xvZlGcyMNjHxL2sHL1
FtPFNf5b6oOF1j6W/KVsGg11tc0LQan6T87g06MGnh0cca2p+UrlSQt/uYGzNxiE
HTr9sV7MN1Qj2yccswVBoCeuqGJbFPdZOSKKvm2vpSZNEIkxt6Qb+9zgWdQf/vFZ
V7M9HJh3
=p95f
-----END PGP SIGNATURE-----

--WHdaro7Yv2ttDAha--
