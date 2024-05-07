Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12403C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 21:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C9F687FA1;
	Tue,  7 May 2024 23:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qgaXr0cF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62B6C8811D; Tue,  7 May 2024 23:16:52 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A41487FA0
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 23:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-79291262dc2so346690785a.2
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 14:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715116609; x=1715721409; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lAb59UszZFgoREFpBLr0lHyf+Y9gaBJHOIF3ff4slXA=;
 b=qgaXr0cFnnkb0sUiclZcoMGjAb/H4t/EJiXRfwl76fih8NS+0znE2WwKoMbdryZKrv
 OSjkpfk6bjQ7lNQUyfUSMy2O5BHciQx/J3cAZ2S1BmZbaeQlSdg1AXy29uMTBiWiJo7Z
 +ARoxIDoPYOMn+kUFGJpJexTIjlKY4rQWDjeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715116609; x=1715721409;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAb59UszZFgoREFpBLr0lHyf+Y9gaBJHOIF3ff4slXA=;
 b=QKfNZGkSZ7tLncvaJdwk8to+fqrt2acarw2RTrLpdBb+abEwy6mExk6SwK5kfwQ6SW
 V2w5Qnt7jlAIci3SY1MXYdJt4WOYBUZFvMXG6yhjR9DBCJLM8fjvV+ZInHbq3tGgMaFd
 5IkYHvfBZ9IZ1e+KkoXsMpaKwgcamj2Wph3jDKwQ/2eR9U/umzoKvai5K/dJ5/adtuny
 Dstt9sEodkZcW5p8QLIzbBUb8mmvAwbDedPX9v1kMCTaWDcII2swBgQP2l4JgpaEuNm3
 qYwQvvCQ5q4cJyO3uvHuJ/w/9uGVQ5tvxfKiafueC4584FNU+q5FrIovr2BG+LpXLT8X
 ei6Q==
X-Gm-Message-State: AOJu0YyQdFc+4zEjAQtPqH0HZShtw60SxVjCheY64yv4L4CIdFYAxx5j
 BKkH2jSOX5P0ECPZH4e98RG/VLLSzBZHcbdetAV1mrALOiCmRlcunH//igRhaTk=
X-Google-Smtp-Source: AGHT+IFXSc/ZNlfECArIC7Y0sOI8aXMiArQwD93gtLNTKIyEYl9K2UFiN0VlzdwrLUcEuQ1ej4OEGw==
X-Received: by 2002:a05:620a:36dd:b0:792:9da2:a615 with SMTP id
 af79cd13be357-792b27693dbmr86681585a.70.1715116608915; 
 Tue, 07 May 2024 14:16:48 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 y25-20020a37e319000000b007929275f4aesm3081768qki.90.2024.05.07.14.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 14:16:48 -0700 (PDT)
Date: Tue, 7 May 2024 15:16:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Andrew Davis <afd@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: Re: [PATCH v2 03/28] mbedtls: add mbedtls into the build system
Message-ID: <20240507211643.GY2568172@bill-the-cat>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-4-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CRlYs9NVK0Gv/oBu"
Content-Disposition: inline
In-Reply-To: <20240507175132.1456512-4-raymond.mao@linaro.org>
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


--CRlYs9NVK0Gv/oBu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 10:50:45AM -0700, Raymond Mao wrote:

> Port mbedtls with dummy libc header files.
> Add mbedtls default config header file.
> Optimize mbedtls default config by disabling unused features to
> reduce the target size.
> Add mbedtls kbuild makefile.
> Add Kconfig and mbedtls config submenu.
[snip]
> diff --git a/include/stdio.h b/include/stdio.h
> index 3241e2d493f..874279c60dd 100644
> --- a/include/stdio.h
> +++ b/include/stdio.h
> @@ -3,6 +3,7 @@
> =20
>  #include <stdarg.h>
>  #include <linux/compiler.h>
> +#include <vsprintf.h>
> =20
>  /* stdin */
>  int getchar(void);

Is this really needed? I know our include structure is a bit odd. Should
we perhaps look at moving a prototype or two around to be more broadly
compatible?

--=20
Tom

--CRlYs9NVK0Gv/oBu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY6mjgACgkQFHw5/5Y0
tyz0kAv+P0OXhgMh1depvTLK0p+AqWh9MGp2gJ2yGUtX3p6QlYa4eQbftaerElE0
f67Q4EVixRtDNvj6lrSDopl0CYovpihpE15GgLtT+EOsJxZ5tLh+hIl7/nVUz36f
XLl1vqyIDW6LoQWlVqZcpApQ4Uz+RLNkiIfz30miNEwq1+FU++N/oblxybsR8nPx
OaCJ6D/+Nr+TF7kAc0eD1VC8CT88yKw9sS/QhLb0EhZIIat/TwZq1YsPd5mhWBs3
vVqSSF8yX8eC/o/tSlfqMdLTkCS9PnyMsZPh19FVDJs560/BGeR/lZAhIYfCZESI
Uzjb2Ad0WQzlRb82LVKtxaG+YVw5iUuPWF4k+8rMuzfL8O7lkJ4jELF/RRztNW+G
GnkSYHFEUA1PuSQ7jLGQkah/M+VnHTh9z1//KqjFHv1AqqTvVkxMTNznVmqXWrsO
ovDptnIJeJFNJmVTYwB6DUUQYgc5QdExJCPM+SqQYtw/M1MpK2VO+G5dAgy34xw9
5apOvW1H
=8eZI
-----END PGP SIGNATURE-----

--CRlYs9NVK0Gv/oBu--
