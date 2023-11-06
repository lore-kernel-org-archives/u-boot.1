Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448FAC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B00D87152;
	Mon,  6 Nov 2023 17:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aqlGroww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C780C86823; Mon,  6 Nov 2023 17:33:56 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF6C87176
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41cc56255e3so28617871cf.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288430; x=1699893230; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TQZj1dxmK6v7Eh2x/mQqV9oJJC5iX4JIdYdBZiwt7yo=;
 b=aqlGroww8KfeCXjbeEiO63cVDiiyxndkPFyfAukIdOWtMGw/nwaXuCThaP3ehOkdxf
 8ApGf1GFgJqgfmhpmLVVmO1BsW04Gzu/G6c0PkbgGUtC6RvqjoHZRQi3fkasV8E5O8UW
 WpVc8+N/lYcgBnKnZwg7+MH/B67ce4yENWpC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288430; x=1699893230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQZj1dxmK6v7Eh2x/mQqV9oJJC5iX4JIdYdBZiwt7yo=;
 b=rlmc0TzPteu5Qg9OwirIkcq7A46vnhlgm0EotQ2E1U3flVSb87rCi+1sAajIxkSw7I
 +j2YlFQu1+hwTysvXQQvF9tuOpuWQjAEicBqFIjEpdpYZKZS3LbZxv2jdjLUJonEJGmi
 MHnx3QG126Pcma5Vo9P3dtsSSLJRSUQmbQ9QIBv0VWLKo/WVAMyzAqUk68K61qxmqb6O
 5fL7zcjM8lO+ApF+RqgBbAV48y4TpQqJ4cXAjsnJahP3rU8S3yr/0ri8HXzaQu9pDvZQ
 KDJCMnA7kRO1obWvTTMl0eUjz1RCavajqhrIfVeNsPQnkOzQUzkauh89djc5kL/wo0I1
 zMtQ==
X-Gm-Message-State: AOJu0YzIhBZus492MZgxh7tGNNdKHhBIWuZiSAhy/Oh9i5RjFYdu28Ju
 AM/H8Vr++TpG7wo0TkNAGCIm1g==
X-Google-Smtp-Source: AGHT+IFhWRj+0Sn0mBWASY/l/x9qjmF950l8J2dqorsF0fWn1j5r13aJIJ4QvatlkXY3Wmog+KveOA==
X-Received: by 2002:ac8:5fd1:0:b0:419:544d:1c0 with SMTP id
 k17-20020ac85fd1000000b00419544d01c0mr36936998qta.3.1699288430588; 
 Mon, 06 Nov 2023 08:33:50 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 kf8-20020a05622a2a8800b0041817637873sm3545452qtb.9.2023.11.06.08.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:33:50 -0800 (PST)
Date: Mon, 6 Nov 2023 11:33:48 -0500
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20231106
Message-ID: <20231106163348.GZ496310@bill-the-cat>
References: <93fdf4b5-db69-47ec-86bc-94741d362b24@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q0S9TLazW98MrvN+"
Content-Disposition: inline
In-Reply-To: <93fdf4b5-db69-47ec-86bc-94741d362b24@linaro.org>
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


--q0S9TLazW98MrvN+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 03:34:31PM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> A little set of fix for:
> - also enable DFU RAM boot for libretech-ac, since it uses a different co=
nfig header
> - SM probe fix
> - A1 USB missing clocks
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/18452
>=20
> Thanks,
> Neil
>=20
> The following changes since commit a4c83bda17196bf5d1ce640844595aaeced646=
5e:
>=20
>   Merge branch '2023-11-03-assorted-tegra-improvements' (2023-11-04 09:55=
:39 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20231106
>=20
> for you to fetch changes up to c550e81171940932664a85bda315a6a073aae23c:
>=20
>   ARM: configs: libretech-ac: enable USB_DFU like in meson64.h (2023-11-0=
6 09:46:05 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--q0S9TLazW98MrvN+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFWwACgkQFHw5/5Y0
tyymaQv+LI4pg3zjONNo+cqUcOLlgQYuxDvX+b7JF/BgAr+Z2VgOZskAlm2cNe6O
sTviSIKa98ilStM0tzzJg19FATptYuqIRGPyk4XPvTqbUe8aWSe2a4h/inCHw1fx
mVfusT2tvNMY6B2dlShlj6SW+ndHvsFeMX0wienEhZYe3Udu53h24loX22tqcYne
9Csb+LrSnsuVugoxCwHkn7lijoBJD2Cu215d+B7eNR51p1QKHwZ8ARrkd9g9U9Ir
8k5yyqxmdmI8mTjm8p4IH8QaDnn9dX51DqtRQlYwajGQmgWbgeeHvUk+xXCKuDLj
6BqoaljXT0IwjeXYYp0eWfgl6YVo7qet+5XP84dSLqXCiBnqyyejHJZbDzOS6dlT
yYuohIcpxUo0HjAIEMValpfI43gHEJTGtkyRNEIXOVm682XWunQa6dng5yno2Jse
gEQA6bJsManZGOc+Xz39rkPMW+1X7IQeft3ITMjmrOpYmlvC1mAgD51QwMx8nvJ+
ueM7+twZ
=Va9t
-----END PGP SIGNATURE-----

--q0S9TLazW98MrvN+--
