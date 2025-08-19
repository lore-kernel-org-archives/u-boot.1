Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E4BCA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 14:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E63A82E34;
	Tue, 19 Aug 2025 16:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qi6y8yz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF457802C1; Tue, 19 Aug 2025 16:57:43 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A370982E34
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 16:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-74381fbc6e3so2289503a34.2
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755615460; x=1756220260; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qpALEVv4jOuAbMk0TyAHHQIMhtvSwu0dCUzinKxOBRs=;
 b=Qi6y8yz18Kpc0m2B8LNj5xeY3qLLgPvvk75MUCyPnCIogHWCORNWWa7iQHfaIU8Yad
 LG2p2KFAkvtqxJlOAAtzoI64JTjFE6myfTQMgg61xLB7x1p01+wOyh9hCKXoJmTZy31P
 ZvUBcLdEVeBMJ7wnI8OSc+VOI1uQ8/v0l/XVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755615460; x=1756220260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qpALEVv4jOuAbMk0TyAHHQIMhtvSwu0dCUzinKxOBRs=;
 b=j2BuMTtCItG40e/LSlVFqe2oiZywW6ztnumIHK6LHnoFt6Ui5eWSE2Cbka35noTXub
 dzIavsVuFEzNAVfsyS1ZajPgFRR5cAtOA3SJSFrvW6do9xceqQcbj2DgOoKHCWeNH2Eh
 o5+DheUgwqYK4I0dNWxEbzLDAxQSiDl/SIiH0s21myAJE+W4KRHEhdR55lmZMwavMJVT
 sl2hStLGvZpO/Xv19tIKyAm8FNfuT8K9+LJoYtq7PClsWg3oMqwVLUbr15hTfYAI0ZL2
 fzwuuyOkiawPUUInK3fLt4yAwj2EpwEordUZqLwcAH4nz+ULa2bfeO+tHDoMHrs1dwot
 IxuA==
X-Gm-Message-State: AOJu0YwYFfWujbxbrWVW5+m+B0FNGMvdKRdnS0IgDo2EMTwO71QnHgVu
 OZTk9aaFUdU0YIb+Wj0Mmg9nzpou6cXep1GkynwxFSZqxFy4IP9vEfzy3McAjvkxsuo=
X-Gm-Gg: ASbGnct+VmEnLxk1QPmVZob5woIpKr71TLDZSoQ5cFcRBe0oXU+6tBPVCUruXoLVDyB
 t1MFuWI9A1bS1kXvX588HqYUcagUzCzaRQVM2yECrp5tGKJ9o3DO8T71JHjn08jJiucWiMrUh6C
 Obg6lL/mIQ+OIdXb+0mvgpekrVLmnj5aWa+amNl8rrSm0jwk/VHK3FlZyEvoQ6OMyWxAIGMy2SD
 YnCfiw1VOp9T3u7/l4NzvU7UxBlF/b6YOsWziUBpvlzQDB5H3igdQocvyq3OxI3kpj5A6MH9SQE
 XCTl6sfBIHJBl/Zqu7+OztwAEYs1pKNjIvHZUZYCbzLwqu2wj4Lwz8qNEoRdCYvooJOr/+srUE8
 144W1cqXT02DlDqmZ3cF1JBOlOZnIjQ9EyEG2Mj9MQLEfj/wcSCDveRDA
X-Google-Smtp-Source: AGHT+IH+UXzSjf4vW175Rnyy5iA2kv6Ej03XC8oFPxuKb65YjuJN6rX8Cg6b8TzHApschzq6Ulzjpg==
X-Received: by 2002:a05:6808:15aa:b0:434:f62:6905 with SMTP id
 5614622812f47-436da1e4714mr1782591b6e.26.1755615460301; 
 Tue, 19 Aug 2025 07:57:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-435ed0fd830sm2327681b6e.7.2025.08.19.07.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 07:57:39 -0700 (PDT)
Date: Tue, 19 Aug 2025 08:57:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Sascha Silbe <sascha-pgp@silbe.org>
Subject: Re: [PATCH] boot: Add LEGACY_IMAGE_FORMAT to DISTRO_DEFAULTS
Message-ID: <20250819145737.GB124814@bill-the-cat>
References: <20250818165119.3193853-1-trini@konsulko.com>
 <CALeDE9PqJBA9gS+YaNjM605fH011wL1SyT8Odk_k2Lm_V9EHLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2SmbaFJpjPCeJuNB"
Content-Disposition: inline
In-Reply-To: <CALeDE9PqJBA9gS+YaNjM605fH011wL1SyT8Odk_k2Lm_V9EHLQ@mail.gmail.com>
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


--2SmbaFJpjPCeJuNB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 12:13:31PM +0100, Peter Robinson wrote:
> On Mon, 18 Aug 2025 at 17:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > At this time there are still major Linux distributions which by default
> > boot using LEGACY_IMAGE_FORMAT type scripts. Add this option to
> > DISTRO_DEFAULTS to ensure these platforms can still boot.
>=20
> What is the legacy image format exactly? Does select make it non
> optional, can we use imply or similar here?

In this case "legacy image format" is uImage-style images, rather than
FIT images. And no, we can't imply it because then we'd break Debian
(which doesn't boot on a handful of platforms now which do have
DISTRO_DEFAULTS but don't have this).

--=20
Tom

--2SmbaFJpjPCeJuNB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKSQ4QAKCRAr4qD1Cr/k
Cjz5AP4oZ0RQky405vm6c0uDO0YMG417bY96H3Lty9+9t66zQwD/W4SHfJLsn3Im
jNStfA/YxSz0lXZA7+7epdlG/uVtAQc=
=bTRx
-----END PGP SIGNATURE-----

--2SmbaFJpjPCeJuNB--
