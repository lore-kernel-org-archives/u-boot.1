Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECFDC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 23:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E26D58826D;
	Wed, 22 May 2024 01:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SuvcY+CQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A66288441; Wed, 22 May 2024 01:46:30 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A0CB8843A
 for <U-Boot@lists.denx.de>; Wed, 22 May 2024 01:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6a8691d736cso2639446d6.0
 for <U-Boot@lists.denx.de>; Tue, 21 May 2024 16:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716335187; x=1716939987; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eu5dtEGDzOjka77UuSvfG8om3U1qwy9mceh9oXoo+nY=;
 b=SuvcY+CQwXiQfobeYpoQC+B8I1Eybk+jZ5awQWz7HsmQXFlexIQ+oGKrdqGa2q5YbU
 7y1UqjpjKNhc0cCKXvsCy7jeLVzY7nyYYH1dhYGHw0PMEz18CwwqTAfm5rOWt10WweEJ
 V8SDwZHGT4Q+okHM/X4d4e3yTSCIrkweR+CSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716335187; x=1716939987;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eu5dtEGDzOjka77UuSvfG8om3U1qwy9mceh9oXoo+nY=;
 b=DSGvQkG2R6YFXiLayAOr4LiPrxNKRkx5jQO97JssYsiq3K48i+BV/H8FpXV6KPXaPC
 wPRppPVUh2H3euNqN1olLXWBjRvJLnOQeL+5+9UTpC3pPlEo5vsJM9r9jcorD7lKsn0N
 4OjUap5XsLGMqJwDwoWptXl3s1H6LmfOFy9pihrhi/cHq/FFuTVJPdr+SMyfh5rQ8JNU
 XDR38p/scfHX0FJ2UtVjPhYiWwKQc5EZERYhGHKykNDtDqiUN7SHq+XeuIGulkdkUhT/
 a99GDJR3xPusT7JUg/ULqVeFl7N2w6Axhtkb0FGWhHOR/hDzEjsnq08wx2TheCsarJzm
 72NA==
X-Gm-Message-State: AOJu0YynuCgwZ4lm0hMZYYnh9KtnktJhJV8dX7gkFpX4cIiU26EAT9VP
 zpHESqUl1IwD2/O2Vo/qV+lM6dagriAeb8/H5kJYaKT2iESq/0zHvwssn3Ps7e8=
X-Google-Smtp-Source: AGHT+IFH0IzmZ+ss8fYWLVp44RRLhN5zeMc0oOkqz8/8ah8NYrI+hLL5ZIxZp99CnkFZIU1oXhaz9g==
X-Received: by 2002:a05:6214:23c9:b0:6a0:e7d8:4adb with SMTP id
 6a1803df08f44-6a843b719aamr205347206d6.26.1716335187201; 
 Tue, 21 May 2024 16:46:27 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f194d16sm126795106d6.66.2024.05.21.16.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 16:46:26 -0700 (PDT)
Date: Tue, 21 May 2024 17:46:24 -0600
From: Tom Rini <trini@konsulko.com>
To: "Brunham, Kalen" <kalen.brunham@intel.com>
Cc: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Message-ID: <20240521234624.GF2568172@bill-the-cat>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <DM4PR11MB5296769279BCDD505F614E6BE3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SG5q8jhmC6Wdy3X+"
Content-Disposition: inline
In-Reply-To: <DM4PR11MB5296769279BCDD505F614E6BE3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
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


--SG5q8jhmC6Wdy3X+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 11:28:10PM +0000, Brunham, Kalen wrote:

> Hi Tom,
>=20
> Thanks for the feedback. I've been able to build the EFI "hello world"
> application, but did notice the logic for CONFIG BLK prevents it from
> being directly enabled even when the dependencies are met, which is
> why it didn't immediately work for me. Do you know the maintainer of
> drivers/block/Kconfig that I could review a patch with?

Can you please elaborate on what problem you see? Thanks.

--=20
Tom

--SG5q8jhmC6Wdy3X+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZNMkwACgkQFHw5/5Y0
tywlrwv9EOJUhoR1ALcgk3I0azUln0iF9FHT7lx6g/N0oXuiZtmLh8QoDk//oa8X
hJjN7lwI5DzvmYW/++b0cVIDXLkXekiLzvC/x8kXzU2S40ttlfpvWMl8b2B7khGm
7q56o7Sb4ng0G7J0xrKDD0qePp+tuSwPm3+LV3Yi+efBrTXFCuy/iYJjC1qS3GSd
YS0Z9D19Y/20XkgfKIPGLYKRnqLQBlWMTG4HsStl1xxkOfFqm4A8uvWiFwjuaXek
mGTc3D42sbsRxSWLubkqdbbmO6ERxpTr+K2+nhcPMb7VrcREdtljcspSEJvrEwNK
ZcOjf0Gee6kd/+P53agUSVkP0uYeScY7hZ0Sjb70r/3HRFzMBaPI4M0f7a61ytPt
7oHMBkScV7P2lm976WYU9R7hFWH6Iip7tcWr3Rsf/eD3weZH0bEiOZMjurnYEMhQ
//5Putbu9TYEjXWuV4F+XrRO75eE5H2VO7AF1lGPX/r/3ia9G6T/oJ/Vthl72tzh
zlpNvN7m
=Uz06
-----END PGP SIGNATURE-----

--SG5q8jhmC6Wdy3X+--
