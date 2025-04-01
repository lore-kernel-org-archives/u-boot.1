Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FD4C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 573A481703;
	Tue,  1 Apr 2025 19:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WhQgwA01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78F11817C4; Tue,  1 Apr 2025 19:01:19 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34DE180FDA
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72c27166ab3so3222362a34.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743526876; x=1744131676; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tEWmhKXeUBLutlRdglvUNpPvMnrjrPcXX3bONHGf/vo=;
 b=WhQgwA01MGWP+nWAnuv1iHbrQ2WNG3n5D22lvNGcJnuRnKFhMfT2boceGKydKYtwh8
 BzFoWg6lfoR4ZwbeUXKsHnFGFjqVqLkHydBVgIAbOzFw+XZv3te73sQ4vZ7U1x0i27Fl
 6CgRSBxGpHySajBCJr8CBQ/wHT6zvDloKeFxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743526876; x=1744131676;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEWmhKXeUBLutlRdglvUNpPvMnrjrPcXX3bONHGf/vo=;
 b=JzYgMUimA/as3V6i+BXTA7b1VzW1hkbxTlNd14gL/ciddKW3vxTeaRRJkHCaZ1dnhs
 UBs01xhvVWKApBvSexw8c96b2DyE1hcpfyFKnSGw/yqpQFzm4G1YVFRJHUmLrpwEX5sj
 1pfFImXM2pAnEOcvAvwCdp8MP8has7osMKw3diLHxnXaDY+QxT7lxrOaan7CamCyDZ0s
 7v8tEEIOsq+hfHleKxtLbrgPjuDloIMhHbUzJXSRYfCFViaTqCHzwQPPWSPMqNW5apGa
 kXYJWYLivBodNoM1z1DNXgioeQUakjGCwvr+P6sAuTR075/4eU5HA7D6QWWekp/RxTPL
 veiA==
X-Gm-Message-State: AOJu0Yx4+H1x+SxPsS7bntRno1o1d4+hi0atlwOWSNVnxc5FJQdupfYk
 SMzJ2ncHgVZXmIZZPO6Cw4jZQE1q7EJlMVrPFFJJHTGxY1wyesAkxOtwK0G08D4=
X-Gm-Gg: ASbGnctDdjrtBTJ7sCTuJUuAaKIRgGSicRqhT3NKM4IIhsvKX9IhenofTCNn7tudKrL
 hd9ypumKGRqol8GeCKC7F91SftfKUMTRLzT9hU+IUmhUHl021qtqi58I/hMTqu/e+pU4TFhOyTk
 L1WGmOAUMNqMZKsWepqrgPLDZxYgUBAA+5lAdk7i4O14CPDM3x80JB+aL43Kl6/s9zXy+HC1SFq
 A57lF/3P/Op4r1NHCK4sJUVV4UKhWan4KIbFMXfiI8aTFgcvKDMrTdxyRS3jWJ/Bk+KBkfFKKc1
 PUGitQyRrwYRQ+B8Z1SmYReJQZ+GhF+AkBrWRcDKZicA6MZei2dwWfVX7QPh2r+GVrHjKcrez0Y
 jH7GAWg==
X-Google-Smtp-Source: AGHT+IHxPm6NFa/3oU1zZXFXMzuZaTzKVRzD6ShQEPqDd/dOGiMwbei0acOijZRfV0+mRWnnFTHHYw==
X-Received: by 2002:a05:6830:b90:b0:727:3f3e:53bb with SMTP id
 46e09a7af769-72c638337e8mr8788791a34.24.1743526875789; 
 Tue, 01 Apr 2025 10:01:15 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580ba8dasm1905944a34.23.2025.04.01.10.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:01:15 -0700 (PDT)
Date: Tue, 1 Apr 2025 11:01:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Baruch Siach <baruch@tkos.co.il>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Roger Knecht <rknecht@pm.me>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 00/17] bootstd: Useability improvements
Message-ID: <20250401170112.GJ5495@bill-the-cat>
References: <20250319143820.2385092-1-sjg@chromium.org>
 <20250331174008.GG93000@bill-the-cat>
 <CAFLszTio55sM+TUyV429Fv8vXv-AkE-HWS4ROC_qOZK=UdjBMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e8pgAvWsdGYGf6Mc"
Content-Disposition: inline
In-Reply-To: <CAFLszTio55sM+TUyV429Fv8vXv-AkE-HWS4ROC_qOZK=UdjBMw@mail.gmail.com>
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


--e8pgAvWsdGYGf6Mc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 04:53:32AM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 1 Apr 2025 at 06:40, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 03:37:54PM +0100, Simon Glass wrote:
> >
> > > This series collects together some bootstd improvements:
> > >
> > > - Improve iteration when there are a lot of devices
> > > - Add a test image for Ubuntu (to compliment Fedora)
> > > - Improve the naming of USB devices and bootdevs
> > > - Add a new command to set the bootdev order
> > > - Add a little more debugging
> > > - Use an abuf when dealing with allocate files
> > > - A few other minor things in bootstd
> > >
> > > Most of these issues were found when adding the new test image and mo=
re
> > > USB devices to sandbox.
> >
> > This isn't based on mainline, either:
> > > base-commit: 569681e993486b830035064f23ec87bcd70795d1
> > > branch: schc
> >
> > And I don't know why.
>=20
> I am sending patches in the hope that people can review them and that
> some of them may make it into your tree. I'm doing everything I can to
> minimise the differences and I would encourage you to do the same.

I am not merging any of your patches that are not based on master or
next. You need to post patches based on master or next and not your
personal tree. Lots of people have personal trees and you're the only
person who does not follow the normal expected behavior here.

--=20
Tom

--e8pgAvWsdGYGf6Mc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfsG88ACgkQFHw5/5Y0
tywASwv/UcEp3Shc9TWsAyyfzUAhI7j9/4DKu9lvc8h//Xu55kOor8zXLgDwzIGA
i8hMa+rs3ybYpLgAxCB0ql8NJoDiAD5whDTmXSW75D9TQf/fyy5qIFo2X5awTcBT
FIC+G5yvMSVWeOm9Rm+bFjpYDgRw9Uz5J9SGbB8ordqY0PkrqNwkF2zCamO04SwD
jZrLlN2F9MB7eXVQVKtjPSz+wEZaNj4d3YSsXqI1mAVBjDmKOeAyqrnVtKUffkPs
p34KhFTvWei64lP+nPIEt66FsDZUeW0PeAYyKk9uXYTvIpaJvLXY+T3cJ1YDu1Xc
3UIJYBiJLQjEm3gudA9p6pYptwaiNG0tuNLJdv/K/EwQrdFeFf6VNuXYsqgBUi5x
a+M14mBhpgHHifO+OM2wm1cPS4ceZ3doy57VlRHJCZqOeN0Kw5q+tZB+wcaS4UfE
xWi5updDlqRtbyNOa6GxSi8hbcGKtWQn4ty3AgihHKWxqX/3gD1peGYyX5KbdIBG
uUtUmbL5
=AOXU
-----END PGP SIGNATURE-----

--e8pgAvWsdGYGf6Mc--
