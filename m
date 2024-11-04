Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF1DD1CA0C
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 23:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D10E788113;
	Tue,  5 Nov 2024 00:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="odhIiGVS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 539BF88C7C; Tue,  5 Nov 2024 00:32:35 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C5DB87E30
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 00:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b18da94ba9so414717085a.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 15:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730763152; x=1731367952; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dw+E7QDJPUhsDb3DEVqqTuBfocvXNPjIkSWQasXHoVM=;
 b=odhIiGVSIU2J2Cq5HbGbHv8i4c8aK9ZL6Y6K+j2D+uOctyg1ci5NejzozibF+W4uan
 SyEcJoCzy1qP0+sXPfUQ68Yyja9iPdv7/lACAvsztdSbEQi8WWiH+WzR30VDWwXpl8LK
 EiBUKjORNPot2nAM7e03elAsAkoHSblwpp/Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730763152; x=1731367952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dw+E7QDJPUhsDb3DEVqqTuBfocvXNPjIkSWQasXHoVM=;
 b=nFBU2VnAz1RsBhrz0zvTP2niia+Yq24nWmto4gRjZnkgbfbjNHR21tHJoO7AVMfdM1
 E3eOyoYNaPhzHV0U214iTF/b9OZtTOsSM/qblQn37MlRoUUBEK7aW2ggH+xrhIvjJCwm
 c2/AUhZvCmbiAqO8MFxGaxGampJTjCABFYpBjcRUshtLZOXqKpjd+xwmyy0m233HGoUC
 lN9RHEcF/kIHvnazBcAFE6LbDLrYzMr7UoYmb7RglPyUfZ9iSEN1l8m0nByzPJBhCEE3
 HEhYmOM3IO+JZNzmX+FUeHC6s16S135hF0t0XpNKJym1bUoSaaU6tDKk7iKmSsPgl9Th
 ufZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsfMOXT6TylYs0G2QnjzjBmj+K74CxRHVRZMVwK/UxYhS7sPNKD7uFRwDKaK/fJx1vrFfpYiA=@lists.denx.de
X-Gm-Message-State: AOJu0Yws5UBl3DfCzsOulU7gcnmXs4y0gAz/IHCBVwTd8UrsfqYIPj7a
 QTYS6HNLdk2JXB2OBZ6U7BF8hEu1L+P30VmDOMCN2pp3o/VI/76dQfM1dZvbQWw=
X-Google-Smtp-Source: AGHT+IHor/mcmJnM2swXW4phVoMUEg5CSrieHo+IbkQDGyc559CVDC/4nK9lD95XkexwRCeK8fCPSw==
X-Received: by 2002:a05:620a:3182:b0:7ab:3516:56c1 with SMTP id
 af79cd13be357-7b2fa61d734mr2488854885a.14.1730763152025; 
 Mon, 04 Nov 2024 15:32:32 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a9ba34sm464512285a.129.2024.11.04.15.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 15:32:31 -0800 (PST)
Date: Mon, 4 Nov 2024 17:32:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v12 00/13]  net: tcp: improve tcp support in legacy stack
Message-ID: <20241104233227.GA3600562@bill-the-cat>
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qfUC7HlLSpdk7KYw"
Content-Disposition: inline
In-Reply-To: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
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


--qfUC7HlLSpdk7KYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 05:31:30PM +0300, Mikhail Kshevetskiy wrote:

> Legacy TCP stack is bad. Here are some of the known issues:
>  * tcp packet from other connection can break a current one
>  * tcp send sequence always starts from zero
>  * bad tcp options processing
>  * strange assumptions on packet size for selective acknowledge
>  * tcp interface assumes one of the two scenarios:
>      - data downloading from remote host to a board
>      - request-response exchange with a small packets
>    so it's not possible to upload large amount of data from the
>    board to remote host.
>  * wget test generate bad tcp stream, test should fail but it passes inst=
ead
>=20
> This series of patches fixes all of the above issues.

I know Peter asked on the last one, but I want to ask as well. With lwIP
merged, why do we want to add features to the old stack? I can see
fixing issues, but not adding new functionality as well. Thanks.

--=20
Tom

--qfUC7HlLSpdk7KYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcpWYsACgkQFHw5/5Y0
tyyxqQwAieeWE2kAYUuHSMwUUl9JuVvU7QCIRBFuMzCciKqTQ2LLFNXuzY3RqOrG
RmcJUVdxVJ0g1t/jKDxTjM9jVM9XqSdFtfmZ/rMXRBHOzNWFMqKmtFnIPEZu7bPS
pfsd2EdYpCqLN1aiQFuaI3CcWJZOxI/eBsXbaFe6AHgBTTR+nLzgqsClMjkYeQp7
FMDvQ7ttuASkeAha4Ed5//e1cP4B2M6UMFi+9hTAGVvUrjMO0txXOfPF5V0sXnET
pyzJ/XxWvPJ9gLvKWGyuy+bnfeaFQLIq2I/yuONsGOlxCxu2n5G8YQboQwzfixHf
qpMs+QK3+4D5XglBlpASGFm07KOVERx2CKLp+oldvcy/TNIWP+5wjfTtrqS9xLaj
LSiJ9nKZqoUKzEEHq2C9RlKWasavWjftOroC1EGE+9hXU90JGkVp6uTlLtazrNCV
oY2JR9cf+AkQfH0cvLP36SEK+DCU7tmB33qLfIYZb+TaHWoO5luFaa4hZv47EqCI
MW6IF2Dv
=cxP5
-----END PGP SIGNATURE-----

--qfUC7HlLSpdk7KYw--
