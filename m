Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522FCCD5BB3
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 15:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D34F884841;
	Fri, 22 May 2026 17:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kyParkDn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 128CC8484F; Fri, 22 May 2026 17:00:24 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B651846DF
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 17:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso7412574a34.1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779462017; x=1780066817; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yNFIfBuS7v4B8vLrksx27aM2v1Q5C8MpUQqqtPSSD4A=;
 b=kyParkDnOcwsmrQxAqt7wnqACKRmHqbXHRGde3l/gPa7fyk7GAaT38w8plZ9MvGxp7
 JWKgTLoDlRyiXzVCADKexCB8i/IfnP8ypD3bRzVQQXKrX4wV9tnxfxolpJwS5lnQpipv
 z3VF0Ze6ktEseaTtkShhXB6PUi7u3S1M0yvS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779462017; x=1780066817;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yNFIfBuS7v4B8vLrksx27aM2v1Q5C8MpUQqqtPSSD4A=;
 b=dWKpnkvYYnCYPEb+aBdyCMEbW4qglBCIzKzN0Bj7q0PS/LwjXVN/XLomx8ioZ1D1dW
 4NA7aJvK86VWCXruDGdJh3jHHUbeOlL6f8Ir6hzZ5kGUPpkKQS9snHdPIUeXdDbS9yLy
 3s5SxzpGlm40HI8S5J/zYnsf5BbG1R6i2GMhr95NHLg3sX2D4AMQMwtQ0emiHmTtGtOO
 9400rs/UgWvQ705/mHPEF3Pw+5xZo+bZALA9x6OlHjT7WFKYJGrTKzueWv9Hzzr1wgIj
 +S0/jJ8tlUtwzrl4UnSOHAThb8OxLyGD+nH2W6+GnTQT9TBkyiVzRnXWnQ9hsEeFp/nY
 UfQg==
X-Gm-Message-State: AOJu0YycBxFPzrPG7Pv3uOdc/BkqK/B/kWji+MQdlIQtNZe8w155C2zF
 9Sezs4GluYsmJVoelQFpqZi9JEAC9d+qjCzcUaWqK4jhtYuzxPMxcUj5pfDJOVtpNT4=
X-Gm-Gg: Acq92OH6Ps4Idm5Fg2eUAIRyTnr5MQyIY4R5Li5r/kicNfeJ1Smnv5e3rXd2NzuCidw
 OKlzoeNejxFSqpUOieuGwDzBjG7cuSUvZAxuzHsM4028sOS2clPVv6/cVkHpxfwrKm5iG1XQEEZ
 mPivItxZokHss7Hz/A0Jt2Ty3mB+0UA/y9QsxRTyvoeZt+RAMQuI1HraQ1xXn0cfsvMT31U0TV+
 Us0owB0VB2d7M6X/I9iW/mWtvJzCTLbFMgniXz0ic9b9cMPu/xt4pRupFR+AgiBkq8yWmnpR9eR
 Jd2dIJWZBnW92f/uJh7BslcEPetzggvr2FCkW0EQM4vb9635Yx6CEPJIN+EfgR3X4qISoIkCYth
 mUybDuISU6o9HbWXKzNnrM64CVE+9eFtZJBd/MLl1GCLH7NsGA6sAvcKuv77y5eY+qawb0Prqf7
 Lhjn/92zwyL6F/ftxcBS3odPKlik/v1DnQFPhmYAUT+Y842eVXXkLwqiscOQpsE7a0ytGL30rU1
 3NcfxYQfGOU3QDT8IkqCMfhGbKKhM/hWf8GNxIA73A/gioz/nUboLw3
X-Received: by 2002:a9d:7173:0:b0:7e6:9e5:49e9 with SMTP id
 46e09a7af769-7e609e54b21mr766499a34.12.1779462017208; 
 Fri, 22 May 2026 08:00:17 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60666ae5fsm1181521a34.24.2026.05.22.08.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 08:00:16 -0700 (PDT)
Date: Fri, 22 May 2026 09:00:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [0/5] Remove some empty bootdev_ops structures
Message-ID: <20260522150014.GQ1858239@bill-the-cat>
References: <20260519152101.716714-1-trini@konsulko.com>
 <CAFLszTh3vk3FbrOXWrxY1JP_Se7ewuoQhHETZhjrkKcQLZ5pzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mmzVIrIfvLfNs4YM"
Content-Disposition: inline
In-Reply-To: <CAFLszTh3vk3FbrOXWrxY1JP_Se7ewuoQhHETZhjrkKcQLZ5pzw@mail.gmail.com>
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


--mmzVIrIfvLfNs4YM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 05:30:12PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On 2026-05-19T15:18:15, Tom Rini <trini@konsulko.com> wrote:
>=20
> > This series fixes bootdev_get_bootflow to not require the ops
> > field in the driver to be set and then removes the empty struct from the
> > places which had been creating one.
>=20
> Two more empty bootdev_ops structures fit this pattern:
> nvme_bootdev_ops and usb_bootdev_ops. Please can you fold those into
> v2 so we clean them all up together?

I'll follow-up and remove those later, and also update the doc and
remove the mmc one.

> > As part of Marek Vasut's work to add static and/or const to structs that
> > should have it, but do not, it exposed a small problem with the bootdev
> > uclass.
>=20
> BTW for patch 1 it would be useful to update the comment for
> bootdev_get_ops() to indicate it can return NULL - normally, we don't
> allow this.

Don't allow which? I get the feeling you're saying I need to audit the
reset of the uclasses for optional ops fields and then see who is just
setting an empty struct and fix them too..

--=20
Tom

--mmzVIrIfvLfNs4YM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahBvewAKCRAr4qD1Cr/k
CjlyAQCRLGnoD+avYm1qCCawigbUbt5FdTx0q2P8TUoizlOc2AD9EXn2PQg6bIq6
OVuSQeJ6AEBcexT0r6tD4I8dPCemzgU=
=63Mt
-----END PGP SIGNATURE-----

--mmzVIrIfvLfNs4YM--
