Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182B6C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 21:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B521883BA;
	Tue,  7 May 2024 23:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SYVeXxCg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE17487FA0; Tue,  7 May 2024 23:24:03 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD13883BA
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 23:24:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78f05341128so265178685a.0
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 14:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715117040; x=1715721840; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ud9IH38VZyiHZ+eQ8PczoBzbJA6FcMS5eoEW5KpyhsY=;
 b=SYVeXxCgcXB6ngPwiYkypzKPeiaj4hS59NiKfeOud0FovFz1KoQV8Ol2wVQauoDCrP
 88wvQyrer4sAe/BZEy0Fr2PZMH/zZtPPg5OGGy1nqir3ss+Aq3lJ8dzC83Lu73bULEa9
 fZhyHkl22wYM/fL67WLx/u6MjsIp11kiQIATk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715117040; x=1715721840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ud9IH38VZyiHZ+eQ8PczoBzbJA6FcMS5eoEW5KpyhsY=;
 b=DJ+HpwlwOBlbKsuBnvXS4ossZmg3m5d82+BjKqhr/SQME8VryBXSsvJbykHONB2UqT
 YKCnjFPq8+wD/yv2lpywAzrj2nz2z6sM/ICPxdBmQ2Eqoh/59W7rzD7TzazfTawrCMyE
 2rZq/uoMYGIcUrNHOxZ8NVG1x3+tnFQn6Xk5xPyNv0ikc52AfzsowIJvxTpKOejxNjCe
 CSa6LzZJAm1UOZav7dtd2ZmI2ZXOM/as9exEr17lGRmkBFfGLkxK0Sk+5JiUUdKsbXGQ
 FbQyNnWWbtwaNyLOXozM25Y9H4xW7jclYMjjTt488OzmyVCWrvntWQY77PyA4k5XcdOW
 tZRA==
X-Gm-Message-State: AOJu0YyD0z/oQvwyrsyHLJ8EeFd2oNxoruKiIf5sfjSUm2cxph4yJ6O9
 hLtVHxM6Wx3KhWlrSEjzGI6XkwMqLULtt0r96CRZ/y0LQSLkUC/T73KDTkrlgrE=
X-Google-Smtp-Source: AGHT+IGajlYa9RUhqL7xpJ+GJrOGZu+TjgSwD1VgMevcxEK7qX9rNh+XYDCBDSl4sToBpbrhyk0ogQ==
X-Received: by 2002:a05:620a:f8b:b0:792:928c:d4e9 with SMTP id
 af79cd13be357-792b275c0aamr77909885a.7.1715117040335; 
 Tue, 07 May 2024 14:24:00 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 q21-20020ae9e415000000b007929d34177esm2000775qkc.79.2024.05.07.14.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 14:23:59 -0700 (PDT)
Date: Tue, 7 May 2024 15:23:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Sumit Garg <sumit.garg@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: Re: [PATCH v2 05/28] image: remove redundant hash includes
Message-ID: <20240507212355.GA2568172@bill-the-cat>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-6-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vsBsZd2Nz+KqlB+f"
Content-Disposition: inline
In-Reply-To: <20240507175132.1456512-6-raymond.mao@linaro.org>
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


--vsBsZd2Nz+KqlB+f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 10:50:47AM -0700, Raymond Mao wrote:

> Remove the redundant includes of u-boot/md5.h, u-boot/sha1.h,
> u-boot/sha256.h and u-boot/sha512.h
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--vsBsZd2Nz+KqlB+f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY6m+sACgkQFHw5/5Y0
tyx6jwv/d00tKmWbbSuITnfqzH3NWpvt0TAGMXu3VPS9d7gv6ZXnCl14U8DKdhea
tIHK6oO+7sdjoBRkrMK2HmOXp5E78WM1QpsemxIZIbn2oab5TR3cZUsW3/VqcGPG
QgBPgrIdjji+v9rAjuhOaD9JaHFc2/it1emMupiJfm7rq6Vjyfg1ZGep5uAzmCaO
oKaa9RlO+bd+IOHy32AlDS3iSSRzdfLAI+Bm4y/CfRiO8RANKy+dc/r6AtZBAtNP
eR83loJfac/laIuQyNZQCnjp7zL5igmLHVyS0PZ9DrDIaDioVdRp2HnZQEzD7/wA
U6HPFWUJRmcLIZDrrk1RskF9kD1l5d9SBP55tooG8HIE5zvDy5uD9xMoeoWscMpc
OERYWXgL9D3vUmbasDC96ooGFxnDqrdI+J1Vl9SXdNpTx63v+u3EHaMUT7LcILio
LZfiwcnd9JI8lipvBxAhLWV2WbAxLOErk7MGmdxNW2ZpyVCBzURvF8O+ca3xFNdo
kxQoc4pS
=fK4D
-----END PGP SIGNATURE-----

--vsBsZd2Nz+KqlB+f--
