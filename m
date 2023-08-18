Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C01EE498B
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 17:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B01A686F61;
	Fri, 18 Aug 2023 19:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SFRXUW0L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 486B086F0A; Fri, 18 Aug 2023 19:49:43 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58C0186EFF
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 19:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-58c656824c1so12049187b3.1
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 10:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692380979; x=1692985779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GfpTmL7FXubcOJhMWF2JG8zencZ0wY6BT9oqQUQbSdI=;
 b=SFRXUW0Lcxo7ccywKXj9xfQKr2OWEESgl9PXBO3CsDv2SfPnypfUmSz9qDI331A56M
 VI/5AuM+6PPzglKftd48D5fVkr0X3WbX345SyUATGhQfGZorOYYeYISm3AEiGlp2AKas
 90mBAt0wsi3IS1LEFScr8yQO05QRzOlT4cG2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692380979; x=1692985779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GfpTmL7FXubcOJhMWF2JG8zencZ0wY6BT9oqQUQbSdI=;
 b=I5tmIU88f5KecvpZMGnWqgyp1GQThlB+mcLTeWf70RRR1PQhjhpO5gJIenlr0yLTba
 sFtZ0acfl2GJ3qQQq7Ngc+rsEpSv13nxWM9lNSs2S57g9Kuzfnpx7+eA6ZyhlKBevFbu
 izBbJDiWH6ybp1U3Rj8q3D/dUPQgIeJDK81jstS07lI+TO32vuKocvcKZWxRtgi1vEtX
 zy5xcQisWf3gs0S33KIsNrnPnRwFAKBJFiRtuLkjjI0cTW2WTjzgzjkLc3ZeSO6Y5unC
 b9NkQ8b621uL772KsggWliiMV7g17XIsMGviAJHyZLQlh5fa+/i8FFPzKApoAuwHwLu9
 RXgA==
X-Gm-Message-State: AOJu0YyrePQnQIbNcu/hIFgomEapBVuD8nlK3SyiX3QpKBFP2UEDpsd0
 OGkgDNeGLI0JD9xoaWklvPM9Qg==
X-Google-Smtp-Source: AGHT+IHd8c9ifRs9ARolplBDqjcCYnA22WoLU+LXHJfK4fsLhb5GngyFbGIegTpeBudEf7v5uUOC0A==
X-Received: by 2002:a81:7709:0:b0:57a:3dd8:1038 with SMTP id
 s9-20020a817709000000b0057a3dd81038mr3391191ywc.12.1692380979159; 
 Fri, 18 Aug 2023 10:49:39 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 e127-20020a0dc285000000b0058d1c2762c0sm629481ywd.26.2023.08.18.10.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:49:38 -0700 (PDT)
Date: Fri, 18 Aug 2023 13:49:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Kevin Chen <kevin_chen@aspeedtech.com>
Cc: kabel@kernel.org, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH] armv8: Skip PIE in SPL due to load alignment fault.
Message-ID: <20230818174937.GD1515023@bill-the-cat>
References: <20230803081218.2129053-1-kevin_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BcBhDQtcL+dA+1/f"
Content-Disposition: inline
In-Reply-To: <20230803081218.2129053-1-kevin_chen@aspeedtech.com>
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


--BcBhDQtcL+dA+1/f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 04:12:18PM +0800, Kevin Chen wrote:

> When PIE is enabled in start.S, u-boot/-spl use __rel_dyn_start
> and _rel_dyn_end symbol to be loaded to and executed at a
> different address than it was linked at.
>=20
> u-boot-spl.lds is used in SPL build, but relocation information
> section(.rela*) were discarded.
> In line number 80 in arch/arm/cpu/armv8/u-boot-spl.lds
>  /DISCARD/ : { *(.rela*) }
>=20
> If PIE enabled in SPL, __rel_dyn_start which is defined as
> .rel_dyn_start in sections.c will be apended to the end of
> .bss section.
>=20
> In our ASPEED case, size of .bss section would let .rel_dyn_start
> without 8-byte alignment, leading to alignment fault when
> executing ldp instuction in pie_fix_loop.
>=20
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>

Applied to u-boot/next, thanks!

--=20
Tom

--BcBhDQtcL+dA+1/f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTfrzEACgkQFHw5/5Y0
tyzlnQv+JdaOuCgbF0weD4Ke3jj8QP6ALDst5I2k5OGqLcZYfesgp4p72WY5gV4g
eVip9Xd++RMy5XnkiCNcwHuxNMPM2OU9GweY7FqtEsnQ41RhUIrSUgpic5DOsZQU
FeyspgTkRkJXurdRCpH2cU/uY2Zgi+FibBU8aDTWEY9ntuz925FinO1u4hM11UuJ
8y5NQVSU15SW64pnIPbq9tjbHKYMkcH9X0KLHjizxm0KzniYRMcNtsrg3WiCcSm+
sXvXdRJaB1pajMwGtc8Z/Fhy2j7gDqovj8MwkVBzLAqTqcHfp1Y/HHLIwuURMFAn
YPpsDWBgVd9XpfCZkgUobeiyk37Jbo+jO12gVBck2lfmHrocW2NZBv3L9ZH/iBjb
4SbJpcB7l+No+rbGtv9gv39hMCfvrkQDsUvDBzvmb9SWn0H6UVt9F3pycLJseAI/
469IjvWzApDYFiXcJXQm7X9B2VhGIBif78qqol5unqZneo2rPFt1i7Q87rhrSbzj
+C0gZMEE
=NXPi
-----END PGP SIGNATURE-----

--BcBhDQtcL+dA+1/f--
