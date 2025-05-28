Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1D0C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 14:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4929C83253;
	Wed, 28 May 2025 16:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VFV2qlEy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE5C883287; Wed, 28 May 2025 16:09:36 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAEB7831F5
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 16:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3fcfc85f1f5so1020121b6e.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748441373; x=1749046173; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lmS3dLlFoU16atl5bTGdT09IrQ58XnJxMNjogimeyYQ=;
 b=VFV2qlEyL6nMUGQvtuZM0ChVQ9AnseuQoitQw408sweXN63aOaybl4HUOzmEFWq4Cg
 rTsw/aXPctYjxqvweWQMyVsw0HfR5eR2euxl84BVnO39oXzxvz+GtD27ES7ABQ1Keoou
 zOTCkQQe9sF9VQ+OA69EGLBX5UsDEEx5HAuSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748441373; x=1749046173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmS3dLlFoU16atl5bTGdT09IrQ58XnJxMNjogimeyYQ=;
 b=reabwFkvhIUJhN3lWC/TGL4QPA3sMTOc0mQaGeQM4M9UU6hXRJGFae6ShwMltsGpbq
 r4EiUxsK1PxaBoFm432dVAipZde19p8Ho1g/6FaP4cmpTYux7rYHk4BrnE4hayw5a+08
 s5ynC3sJpGSeWYC8/jTkChnU7oP+8acHYZQrY2tqGD4Lyv26jQJVi9X1Ue/TsKp11elw
 48qKPtMqnrVUC/9yBaUN5xXkCr/tXdZTi26FskwdxumIHxX22e8OccVg9tavMZcnjxWs
 1MFcf6bpHv0jTG0Lse0IBPvM07E17DQ177Lsk7unpzii+OEy9bW+FfYXbnUQPFFxO5X1
 1tDA==
X-Gm-Message-State: AOJu0YxqKxmTU9zNGb1LsO68mo/fr+bJCCh0a2NvjqUmRQAdO/OYTZjr
 pJfkkFu9MRg3mw8gOrw8NF+6lLVAXy5rEetE4P7oE8YMU6bJo8GHkfdXBMDjOCJM8ns=
X-Gm-Gg: ASbGncvZiMPriUAzm5EYdGAXE/JCRA4VXgDs7ZrRdtcsN1RFxe8cmeWrvGpjCzxEink
 si0j9TkVxMtExG0x2gDOFFECXd0R5o8F+aeOQ3FaxdUzY2MlT5CYkquQCu9bVsfEHC+vjpvVBAz
 aSe5pLp3fC/89QD9ZmJhHucebTqZEfQB03GG3gMpSj9++pDbKbJUKMTCf1PBQGxyi2T2czYCLLF
 jpvuA/WE4SxowI2LxN3zTQj2KAbONBGJOz6pHGQlEBqTcFy7c4/HHyW7tMkf6DYalmLH0+ROOxf
 nGWXDRqQ+EXvRadzv6ccYSTBK5BRj/zA+sxkQtnuUu/ynIB84hX48JZ2nh7QRsv31p1tJqjul4J
 iGXaZpxEvwF3C
X-Google-Smtp-Source: AGHT+IF9MXALYdATM6V4vjDoEYbmGJMDF6rYCm3EUrBDI0LgrDTyW6M1utefcQ9q+y1WjvP7AVHB9w==
X-Received: by 2002:a05:6808:1c09:b0:3f6:ab0d:8dc0 with SMTP id
 5614622812f47-40646856b33mr10574725b6e.24.1748441373371; 
 Wed, 28 May 2025 07:09:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60bd9c1bd00sm191470eaf.12.2025.05.28.07.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 07:09:32 -0700 (PDT)
Date: Wed, 28 May 2025 08:09:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH 00/27] x86: efi: Various app improvements to support
 bootstd
Message-ID: <20250528140929.GR100073@bill-the-cat>
References: <20250528082520.152391-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EJ0mQTiHH9sGlQmz"
Content-Disposition: inline
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
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


--EJ0mQTiHH9sGlQmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 02:24:26AM -0600, Simon Glass wrote:

> This series makes a number of improvements to the EFI app. Mostly it
> applies to x86 but the ARM version will share some improvements.
>=20
> The main updates are:
> - Improve linker scripts and options to detect missing symbols and
>   remove unused code
> - Enable bootstd and provide a default which can find an extlinux OS on
>   EFI media
> - Make the 32/64-bit apps more similar in terms of features and link
>   script

So I give a little, and say Yes to you despite technical misgivings, and
you post yet another big series that's based on your tree with already
rejected changes in it. I do not feel that you are working in good
faith. Please stop, and work in good faith.

--=20
Tom

--EJ0mQTiHH9sGlQmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3GRUACgkQFHw5/5Y0
tyys2gv/UZ6/HiZ5Xi8hoal6T9upsKQWlUwkCHvTGgOlh2Cjf7O0KeXtOvkRx24W
xsMmk+IdECaQpQf5Wn0fuGd/ZNkkemQTnWtG7JVNJX1k8xrCgal4weQP4zXIUPfi
u9rqHxFneuVqvtKnkszyrQZ8k1LoHw5r9B+cs5MaKPfC0PAskFbXUYh0ZFKUXZF+
uc1BASkdkqxOUBp0VYjqEn2OLN6xUUZg+CSK6gzwtoF17ARxoSsPP7H2CVlObCRv
zJO0Stll5iMfOlTlXcnczKRztxqcKvA9YcC2qa2bczOA+/OsTtOqj0p4hWx36spV
IVgEhePky2yHp1gAJqOFJ51BinEdeNrcYHSj7IDP9ZwiBCoUIER+8IJjQENr0krt
n6+t24h7zIc6ConsXFabFqdA8DL6dvzEOZSoCDyq7+EAYao5FVTLuLW4bE/+YWZE
G8H2rveTkDC4/uq6GDZvt8Cp+T5zASvXhfRkrnpQA39ILtq8D2t43N4txFUKrZbm
AeTCRZs+
=xZYx
-----END PGP SIGNATURE-----

--EJ0mQTiHH9sGlQmz--
