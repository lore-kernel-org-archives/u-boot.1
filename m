Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AC0CD80CF
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 12:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEA2A86DC5;
	Tue, 10 Oct 2023 14:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uDTxerjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6075686B87; Tue, 10 Oct 2023 14:58:32 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF94F86DD3
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d9a3d4b9456so1417295276.3
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942705; x=1697547505; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nF2oiEhcTdsb3DG9bu1x3ot9Oxs6ktaquG2xXILCDaQ=;
 b=uDTxerjv0lCslOVvFhW53X9gsm9RhyEqidAV4O5j5zywiLAi/f8iqLaRoFIuEqAi8W
 W10eynX2UlUmJo8/NCQkyCkUmV+9VQ3DlNVfq/+qAs0IFyZd4rAJ/w0X3CaWqx9fPvdl
 bm/dezMLO2FurE6VRBAQMlz9vNHVSyxJxjy6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942705; x=1697547505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nF2oiEhcTdsb3DG9bu1x3ot9Oxs6ktaquG2xXILCDaQ=;
 b=SRAqT1Y/RAIqPWFDTo6X4pPKywi9lLI8M6iJGh0LFN7APTVs84vBwktHIMXMq9BFzg
 GRzQbIWYd4QeFe+qmK2mCYTbepfhy865cmD7mwK6/BT1KLsmN6f0djB4T/oQDE4aXNLC
 Ydz9g34CGCXT2VDnZwf1zJtkYeDq9WASzKt1wN7pH5mo72Ii6YoptD0gJ6dVMQo+Zvmp
 p/NxO7lOarugC0ia+tVdoa9lvvyKJOmwJRNVmB2ypKKOs04jV7/K3ctW6Gsitn6nazNR
 Dc6SvOYVe6UpcbgFfI5L6u1D/kkg1AmG1aMugzgDWRwguGWXn9aXIQ/+yNutEu00x4EH
 XqTA==
X-Gm-Message-State: AOJu0Yw2ktocnEyJR8gXh3YPcb6XsvmZ0e7lTuT13by0KNuhQ+Lm4+Ob
 aIMix0za0wDii9QMG/m4A4SJuTzdKterhvu5HMPxcg==
X-Google-Smtp-Source: AGHT+IE75SYN6+nQ8Y4iMU/z9ThtcuX4wqLVGT72IWwWeHBdmjKbUVZtfL4ZIGNo/q7rTtlFCR0mgA==
X-Received: by 2002:a25:9986:0:b0:d9a:c1c:1159 with SMTP id
 p6-20020a259986000000b00d9a0c1c1159mr5182475ybo.59.1696942705575; 
 Tue, 10 Oct 2023 05:58:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a05690204c800b00d8514dcbbfdsm3675329ybs.13.2023.10.10.05.58.24
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:58:25 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:58:23 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] exynos: Cleanup exynos_init
Message-ID: <20231010125823.GZ2227687@bill-the-cat>
References: <20230921233248.159047-1-trini@konsulko.com>
 <20230921233248.159047-3-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RLWix8MHGOYk6hHX"
Content-Disposition: inline
In-Reply-To: <20230921233248.159047-3-trini@konsulko.com>
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


--RLWix8MHGOYk6hHX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 07:32:48PM -0400, Tom Rini wrote:

> - None of the callers perform error checking and based on the non-empty
>   versions of this function, there's no checking to be done, so make
>   this a void.
> - Add a default weak version of the function.
> - Remove the empty versions of exynos_init now that we have a weak
>   version.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--RLWix8MHGOYk6hHX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSm8ACgkQFHw5/5Y0
tyyBegv/QXx3Mqe+uTsv489XX/ZvqJsj6Lkri1mC956DJmjbZdXivRFtmrI0cVrL
2NmQOxYb0E4k8zmq2zSLnEYnNWiZ6I/HJoIdB1XLUg3kKB55MnT2Haqw+4VVB6En
D63m+Zy+0o9AwqL5os1cHrwC5AXVQmaKGyH3oooUsIIFGjulAfBt++ZBbwImxzyb
N7ugGhA9ZFyrl+SbzFqqvLCmyPH/rNL3Ycw61FszPEriR7Sct7wS9+ovs4YUUDBl
YcjE7+Men13IgC7ZcZvqdZUpWIs+GReejtKMD2+KgwOcnmShCuyqc0OOIwYJOBem
q7eHW0TB7WsKLw2OgNEldXUrIqYY6764zf9GjOf808k26wFp4ef3kMt0ePU0goUc
z7NTlrwB6RzihC1Eb0D96Xggl9M9p9gOqd09Y8fhCEE7sAvppa6TSW/vn6WScK84
nabXM6d6i9WZ0829IKtqlKjB8bKYY07+w1/tiRhzl2BRdiXWRViku7NGCU7Gpu5V
AOWghguf
=CrwR
-----END PGP SIGNATURE-----

--RLWix8MHGOYk6hHX--
