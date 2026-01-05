Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41C3CD0402
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 20:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C82C83D17;
	Mon,  5 Jan 2026 21:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R9jsIMQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9729583D9F; Mon,  5 Jan 2026 21:51:20 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D24083A5A
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 21:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7c6dbdaced8so307556a34.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 12:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767646269; x=1768251069; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h8a/aq2fGDRuJtC253aP2MyjObv3I5pX9wkuwAkCR5k=;
 b=R9jsIMQuXs5Zi+X6lJWlvMT9uH6Rl2FK1lQea6RsVgihzebjazKM6a/mWiGMvRLQOh
 B/ipYvq8TayPcT1FxvoA4NKv4MFyIDldt22wdDPGv7ZdWixS9/DFQ0fBIGlnKLhMip+/
 lDvtJ7nasm2gPKWUe4AlgftISN9rTnuH1IFpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767646269; x=1768251069;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h8a/aq2fGDRuJtC253aP2MyjObv3I5pX9wkuwAkCR5k=;
 b=XmL/85TgiuVlC9Mu62fpDsIVOFQOVBbXVXH3TLbKZL7t8d4ZiJ6T884odmYm6GSE5E
 /hDXQlibXQScUO1lruBo8kv1otMfYKBcvxsJamt/rWJINQUD6/YP3xcSD4g09CFqREkP
 PeocChruHy7pS+zm612beDJqVxIpAEZvzFW/xKJLv3NFu+SA5M8ZYuOJrBTPvghbI0Gi
 IIUFKIn0d05EcSvSGlB0lwWno6GamkNJFf0NBxFH+gy63f1H6vY5C2Jbdyezz9r7Z6Q8
 wMhAt3BX7HjJyyunDJTn8HclE/hCLEH/1mv4T0CkfSbBB91+VGjBQ9x3N0ebgL+Tn7Cn
 I81A==
X-Gm-Message-State: AOJu0YzZpjDk7ONNuMIKqOf0ggdojhywDkVf9zpLs7206mKvnmukre+S
 b7I29U8/uXm/EdB5HPQFsnWMlpP0OAIimx6Yw8h5JV6shF5DzJvPuEQOsRcT8Q3l5G9rah1CCtC
 gHq/VVM0=
X-Gm-Gg: AY/fxX4kNwDQjKHex9+DPPYCqIRvYi5ji8LjHISrEidxDc570YPvBDbnVr0j/yOIQiJ
 EgRjlL2onC16I2HqJlxx5WRG8WkfOTW6p/5fYfOrh13L0Z0OM4cAnOUX5Ea46JKDzLNpSNPgqRA
 sJ2dbHSwTcXt2ojGpChQC8z9nFYQOeX6/vjaFs28C5YN59R0jKth4nD+ED+uokcPEKV6mZil1h6
 MNnU3a3sUwtTGn3LvyEAd6N0EU7ZdAkGabIwuiNkSBFNGyfoYtZMvW9I71UJ8AI2KGr0FjvIo9N
 aqKTxD3wN2qIvZkfhiSv9/a3orUjlrfX/UpObnHK6RtZFqsoaZGq0ETFq16KkyEOhn7H3ZvetXD
 wXc2uG0sDi3UT1zAFQ2MCcMFjJHKIYn5JWmVMCCE0ZRJKY0TE1RWA/OV+bdMbgD5u9CWdwjPjsw
 G29cyqLv3MkAU8/SnxnZD/TwZ8yxRmvg/gK2GpHeprk/2mUbM/YMCN63I04J6Tl20bfg/rvcRXQ
 wKOxBva1JWJEJ/hmpMlsxK/P57AOojl3BzHGxo=
X-Google-Smtp-Source: AGHT+IFmyNoG+Owu6gddwzepXjay9TCCOFwFwJ7HiqeQNT1Ohph8qsnU09f9CAHjZCtZslcoAC7uiw==
X-Received: by 2002:a05:6830:2e05:b0:7cb:1270:1255 with SMTP id
 46e09a7af769-7ce466d19c4mr386378a34.16.1767646268875; 
 Mon, 05 Jan 2026 12:51:08 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478da6f6sm46343a34.25.2026.01.05.12.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 12:51:08 -0800 (PST)
Date: Mon, 5 Jan 2026 14:51:05 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.01 released
Message-ID: <20260105205105.GA3270357@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UhEiFJ34qGR32ya2"
Content-Disposition: inline
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


--UhEiFJ34qGR32ya2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and so here is v2026.01. I will be merging the next
branch back to master shortly and pushing that out as well.

As this is a full release, and not just a release candidate I'm once
again hoping for a few more people to read this than do my -rc emails or
just regular mailing list posts. Continuing on with what I've mentioned
in previous releases, we're now officially part of the Software Freedom
Conservancy:
https://sfconservancy.org/news/2025/dec/29/u-boot-has-joined-sfc/

With that said, we'll have our regularly
scheduled community meeting tomorrow.  The meeting details itself are:
https://meet.google.com/btj-wgcg-euw
January 6th, 2025. 9am (UTC/GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

A high level changelog from v2025.10 until now is:
- We're on v6.17-dts for upstream device trees/bindings. The v6.18-dts
  tag was too late for our release cycle.
- Lots of platform updates. I don't like to single any particular vendor
  or architecture out. Lots of updates in lots of places.
- Lots of fixing of issues reported by Smatch, and in some cases
  Coverity too. Not quite relatedly, some dead code removal as well.
- Continued work on improving our old pre-rST docs and converting them
  to rST.
- Fixes in our DFU, MMC, PMIC, USB, UBI, UFS, SCMI, MTD, UEFI and
  networking subsystems.
- Some cleanups and improvements to Falcon mode, so that we can now
  support this in some secure boot cases.
- We can again use clang to build on 64bit ARM platforms.

And I'm sure there's things I've missed.

With all of that said, we're on our usual cycle of 3 weeks for -rc1,
which will be January 26th and then every other week for -rc tags until the
release of v2026.04 on April 6th, 2026.

Thanks all!

--=20
Tom

--UhEiFJ34qGR32ya2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVwkOQAKCRAr4qD1Cr/k
Cq5zAQCSuwgiOcV79IviD8AWsWOwZi24vIPzGdtGLoVKgtTfLgEAiT4SexkmSdK9
qNU1o5gzg/G60oQxMiKbDj7qS6Singw=
=ZHfT
-----END PGP SIGNATURE-----

--UhEiFJ34qGR32ya2--
