Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3842EC001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A47B686863;
	Tue, 15 Aug 2023 16:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UME5KqSt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF50286863; Tue, 15 Aug 2023 16:43:22 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44110867F0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-589f437fd1dso19901197b3.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692110599; x=1692715399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r/ceZe4MXyye724yMJNTdnrCpAsFGfqlM59EkzfFQRA=;
 b=UME5KqStC/WoHoeZ/9/OlcVqC9chu5sOc9bMdYUotKlTBrMGCet6qGE2vahaIgGIyU
 drPnnEQIVKvYaGZxwigFEIalJxd+ZteF9V18+A+/fj5NKqO0Gs9YUBzViikxDka0hwfQ
 wmZUF9ygicQkL5gZLYBKspk2ng59M4vEc9Eog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110599; x=1692715399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/ceZe4MXyye724yMJNTdnrCpAsFGfqlM59EkzfFQRA=;
 b=dWeGB6l1s+rlt2ry3Vr4yyf9Wn0ASLZ5bdnHEkGfsqAed6oDrbIHVcnPXSMYJj0p7P
 oh8EI9GfyeKmeWfK39U2jioXj9nFIXHkEn1psc2uLxwiRMjLKpWzpSjxozsirAgme2+H
 085o4yJYdHKMA7F5zPQJKq8wzNfaLs436EB7u/D5xw+wTtD2AwYYj6LwfWjBHHl4EfOC
 JELr9DdLypuCX+DFCVij46AzHpxvhAk2gpDQYh8cj6Oou5r6l9ls5ZFtNEWsmciUk50G
 cV1WE9IdhiypMslgYohoGOifZ43Ktgjcbc4ASND5YA8r7k5jPH796Rkbu5kY1ac7GvyD
 k6Vw==
X-Gm-Message-State: AOJu0Yymj5tTEYWIQkPEVoIjcfMR2BEap5DJdWP30s2YIyWmR20wHaEQ
 PcUvkwuILXSdPnjjmHL/kbnoHA==
X-Google-Smtp-Source: AGHT+IHEW1jqRemoUgeV13Fcv0JuAR2qN31GzbqneFvu6xhYVon6M/OB8a71t5205ia8paBTNfDdcg==
X-Received: by 2002:a81:4a41:0:b0:586:9c8b:4bb4 with SMTP id
 x62-20020a814a41000000b005869c8b4bb4mr10393316ywa.29.1692110599071; 
 Tue, 15 Aug 2023 07:43:19 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 h125-20020a0df783000000b005869cf151ebsm3403414ywf.144.2023.08.15.07.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:43:18 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:43:16 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sean Anderson <sean.anderson@seco.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] spl: add FIT support to semihosting boot method
Message-ID: <20230815144316.GR3630934@bill-the-cat>
References: <20230722192748.52856-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pYxWQ7roSUM6p8pQ"
Content-Disposition: inline
In-Reply-To: <20230722192748.52856-1-heinrich.schuchardt@canonical.com>
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


--pYxWQ7roSUM6p8pQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 22, 2023 at 09:27:48PM +0200, Heinrich Schuchardt wrote:

> Allow loading a FIT image via semihosting in SPL.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/next, thanks!

--=20
Tom

--pYxWQ7roSUM6p8pQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbjwQACgkQFHw5/5Y0
tywINQv/ShfsA2jy9hcITha9LvGyoqZpuA73ftTmrG4vFTVH5/IRl/3iNBhBHEUy
BNYGJqwHjeF1QboGBNNWwYDAh+9mmChqcq63kJsFfgLAqaTtE2gVFYp6YkL7ELz4
lHJiSIKyVGhGoJyVmkdoogUW8DH8WNWPB51gTMT5OJJEENU8RPwDUkqKprdx+YNG
A3vpgdjfRm4s89mXh4VUNFiLakKNOaVLXoa+E+2ffr5VWf8JlVC8WNlLO0TMBOSV
EphsTy39PV3UhbFAZ3rh4gEHCpDTRHBHRs11wROpJ/enm0Bt/HZamgTmQooguhui
rd6L8FTkc41aTyBimiEnA8BRlcQ9u6fW9/5wSiZfl/FtIMWfSWm7hd3SKtPpiSz0
1qtNlcWwpSN24EdM5X5s66xnMm8OX/Km27+JZCjUye+TMIN4cj0CbfaArM5cvOhH
/oIrhEmHwc+76LqJR7tcH4bwKnf7n8lPAr7o3WqTf3YZzxw+MTFQBkyrYma3VCBG
C80JcHsY
=TUlA
-----END PGP SIGNATURE-----

--pYxWQ7roSUM6p8pQ--
