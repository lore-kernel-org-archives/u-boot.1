Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2049DC5DF7D
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 16:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC07B60A86;
	Fri, 21 Aug 2026 16:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uOWgDzIVpph8; Fri, 21 Aug 2026 16:21:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787329277;
	bh=KiNoooYkX63C9cqAMwM+2fHuU52F2R8FttxhDmM6Bdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OO0Albh9bwy93kdilmN/ondQRdpr6QfRwBwZHw2kUH9ORUuKVNrik/eWLJGZezxYZ
	 o1xt5ubJzJX4PBonwZxGdKwDuVcVLkz2uGDJ7s96jCGaXArvWwA3si8Buh1mAvynIF
	 /2Fri+AmUAq0TctzlpH0ye5XsixatFJcN7GDnv4s1MLQ3IamB4JlPcbZSbKvfzDi5U
	 QCuu9JtZn0hpeY2yXOnMgIbxqeoG8oO938WjIip87vpzD/prCjjKtoPjuuIMGOVOvy
	 Gg3ujpZbKjumE8zqGI6BcE02JEQqt7TQXGldcMwP/lwF4yUXQjnBJk2ttcX4QgpxcN
	 /KZgfuJmjHB0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F0FE60A77;
	Fri, 21 Aug 2026 16:21:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EF118263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5C5F40A10
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:21:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YZg3fcAGjHk0 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 16:21:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Qk8cb+zz
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 800BC40A14
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:21:09 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8200b55dc47so18407687b3.3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787329268; x=1787934068;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KiNoooYkX63C9cqAMwM+2fHuU52F2R8FttxhDmM6Bdg=;
 b=Qk8cb+zzUNvdU0qUsfbNdeubRfSeWs41UnUbFBGslhoR1ftw/tfHEtZoNpvd6Ix4x/
 OOVvoWXIpjKhSv3MDxuBcSoxPKC1lM2L7VX43jKMV2pPAWzg0+iF9rDMswkj9v9RX8Vr
 nASv3YQuq7qfFJJ+UhJofVcn01mmg/BWYPpDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787329268; x=1787934068;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KiNoooYkX63C9cqAMwM+2fHuU52F2R8FttxhDmM6Bdg=;
 b=TskkIVgsBKoJcvlDNuuUqurfbhwQTwq7qa9C9lc+MN+EJ9F16KmAcARqIuMaMLU5mh
 zS9QmniA4+0LH1dkjbYK2CqUbVrqcs2668BQhOmRESqzsgK6JuiBO2QcAvfha+FRBdAs
 GJv0rb6Ebs1E1oYCyqVEEWFZfEnTALmImnFO5Bm0K1nZwGlul6tx6Ob/gB0B1CcDvXJn
 09dzCc0yxaEJsgZPtqFw1AszcxFYL8Ub9YEcf/jPo0JUmzATOxR9RbbdQqRywU+J5YLD
 pS2NT05NRLMl1NlcFt5QXNm7O/JsGEMu6DLEi3TI1xB+p2ajrdHQ9MuiSIT2K1MJ/AaO
 6h2A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVKg16L8otkXCZ9D1vDyYP/DPQe77HrsaSsZEcPEwAJ6shmVoQ3omqstlYN9O3/Raz3wORIbc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m5rAAp+A11yoI4U1ep0qD9+j+SkRYslIxCN9aGnB3MLXFM5kus
 3d8EPla5u6KQ4f9rX4z/BR0kjjduMa0UiG0mu+XBqOgIvTIDtSQfZyOf+sZuomEewGw=
X-Gm-Gg: AR+sD11p5yAfmqB0EJjiII78uUhg8OuXrdG3+cAphGpKb/3xDIylRwprPN2GdiYu9IY
 pSYypNivq+DM4VoGy70u1HwZ3Q8vSuiqbeD3eFP+W2SDIhLt08cbc0YKpXa8xEQW3uOKWNDen14
 gR8odZXKlw4YH25qsGUiMISUYMnY48XK2yoliygTdKsprS+xRt0GBx+njR129GOVANEfJ7wsr8s
 qqwSsCH3dJ3NaeSRM82X7XTkl+z/aC+CSsMQjQCjAoKbdi2C5DyXBLX0WDYKH+AqllQ+SNUh1k6
 JjK+C6g9PDaVP3wj6rZ5WzwJ/yf7VnmhnT8iBkPJMy4gXDBT8zNwM5xiFAjXhPtQdJV+05fe6tf
 xM2laaENl1tD3z+7LWQHhM5xbrtmRHEEP/JKqpMt7bntJB04S2rcsCk2E19N+pRzI3r2nPtWFM9
 iCrOZVeqIMS58y18sbkh+KATjK5JMe4aUbCkzx1D9R5kcpc4fj5zOhGqDEKyQz56efJsvzxZiRd
 dClKfjrY98iVE4rzxqYsVhQLuULXWANE9VG2bRFfJYSLJ7QFZyx6nW5NszDE8DsiC7dqrB5TaVI
 Vdalyd9RjA==
X-Received: by 2002:a05:690c:dc8:b0:80b:a1c7:9fa4 with SMTP id
 00721157ae682-849efb60bd7mr27203087b3.1.1787329267930; 
 Fri, 21 Aug 2026 09:21:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-84511abc153sm43466417b3.4.2026.08.21.09.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 09:21:07 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:21:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 19/19] CI: Wire up qemu-loongarch64
Message-ID: <20260821162105.GP523975@bill-the-cat>
References: <20260821084219.1703743-1-me@ziyao.cc>
 <20260821084219.1703743-20-me@ziyao.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8mKt+4kMBEVtXCfx"
Content-Disposition: inline
In-Reply-To: <20260821084219.1703743-20-me@ziyao.cc>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--8mKt+4kMBEVtXCfx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 08:42:19AM +0000, Yao Zi wrote:

> Enable qemu-loongarch64 in CI so it could be automatically tested.
>=20
> Signed-off-by: Yao Zi <me@ziyao.cc>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--8mKt+4kMBEVtXCfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoh68AAKCRAr4qD1Cr/k
Ck2MAP9ywpTBC4zT98SccxUDeZCn6+2beWAXMgUNdBhOMigWlAEAoO5aee8C1F7D
6Ud4obxfGinUhrbIlEhDI024wiV63wA=
=cASn
-----END PGP SIGNATURE-----

--8mKt+4kMBEVtXCfx--
