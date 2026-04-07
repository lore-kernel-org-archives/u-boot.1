Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A364EFF5136
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:28:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A49D8404A;
	Tue,  7 Apr 2026 21:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YysjEGn2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CDAC8405F; Tue,  7 Apr 2026 21:28:17 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72AD083936
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbff06e4a6so580103a34.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775590094; x=1776194894; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bAJ7mKsTYcepmpjaxXASgGTdWDeKZEtNhCHKv9CEXig=;
 b=YysjEGn2FxAIcUtteNnO+swr0AYQyFy/uKD25y/4Lmm7osS159IAYnWiTeoL71BjSv
 jUlemfgM099GYJnxRssWN5IbJCk6VzZiNJn61B9OyEyLgLzMiTTCZxkFknUHT466IPJe
 QL8uS/ypNrFK/bJfeKPA5LYkN3pVUmDnQS1vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775590094; x=1776194894;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bAJ7mKsTYcepmpjaxXASgGTdWDeKZEtNhCHKv9CEXig=;
 b=WnTzwqPgpoygvsJS8McjTvm4BRSO8GtOA1IpY3Csvl3GVeFIJ9AJKozT9icp1pIQfk
 7mzQh9zMLsvx9HuHNfcOlM1q1NKlQYKzQK4ZZ3pi27VQ5RbUVGx323/p1u3bsQuBdmkM
 QrtzjqybJ3U+36i9PL82YbPMOFNBFGpEqWlHYTR7IYY3jNb6IKRoUZD9lbYVrSnbEzjQ
 A997lPeLtWacSlaPh6ITgfTvV2uuJ0NP5at5aBbRtJtA37y09angN/2VV4UV0fN0ajAg
 WCDykrLxMfYkiwxhJrif/26Pazu+/i1tV4cwYZSwVW9w4RG2fUTKlKYfmlqthgNRTzoW
 Iosw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOeAddbi1In+5EB4PXefIb9RPuYQfVBYPuG/R1QKX9CsOEfekmUTPR6BC1fmuesKDl7jsei3c=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1a0ghqvF//AiGSFiD5v5J5eZYaslrl+yb2v8qB3/WgAhzMgTc
 h171RwHCKKtM7fjCnf07XBUKrZLMSXZIoupW5hWBVavwpF3LXzJvmGuGdo0R46KopZ8=
X-Gm-Gg: AeBDievKash/ppKDsmB8OBAH7+W09/u/sMm7TI6LtJ3E39uU7LDJPYBP7noy1TgVd0f
 I0KpDyEijvAo3F4/Dz/aE53f6P/3eRPd1lJ7/NWgqcllBv4p258Y+r/3dRtc6EdNz+rUv9PUb5b
 WLoHh2maREGNYgptI2aDTP7+H5tD//Mb7K7oIXrzQPbDxvOsjVyoIvEbVbmhr9bvc9A1CIOAZA4
 vgLI2fE3jnRQ32zQogn0CauC7m8TlP/xj7oOBNgbTHVAg/ACI0heFJOKTVddclfl0WOsCoyS/UW
 K84ix71y51/3/LOT6/+Sg5vfueJ/wFeQVeLY+/TaV/F8fpB1WkFa7gDML1GjMSfaNuijTqVmEmN
 Qj0OdzkNvc/C6zjLqWyJvJ+bW04iFvfg/IZi9UYwF2Smif7MQuGcoqX+EJ6+poQSW+U0mTjkra8
 C01tq9P+R5cAw7Ftb0kHdrXfm+2J07SEiwmMXcw7M2e+fik6TictQbWZ4CBcTat46bGiJfD/0Pl
 kZyIovQ8JOOPDVRQcREEXqXWPJzmGVLYJN5UazJvR8UK4/ixzq+ZX0P2KE=
X-Received: by 2002:a05:6830:67fa:b0:7d7:c87a:4feb with SMTP id
 46e09a7af769-7dbb730ef6cmr12184853a34.30.1775590094121; 
 Tue, 07 Apr 2026 12:28:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbf2ddd6c8sm2678425a34.23.2026.04.07.12.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:28:13 -0700 (PDT)
Date: Tue, 7 Apr 2026 13:28:11 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] doc: release cycle: fix 2026.04 stats link
Message-ID: <20260407192811.GB41863@bill-the-cat>
References: <20260407-doc-fix-stats-link-v1-1-1b53b54f816b@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ijLhjEJbLdvGhEzE"
Content-Disposition: inline
In-Reply-To: <20260407-doc-fix-stats-link-v1-1-1b53b54f816b@baylibre.com>
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


--ijLhjEJbLdvGhEzE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2026 at 02:13:25PM -0500, David Lechner wrote:

> Fix the link to the 2026.04 stats page. It was likely copied from the
> 2026.01 line below and not updated.

Whoops, yes, it was. Thanks!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ijLhjEJbLdvGhEzE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadVayAAKCRAr4qD1Cr/k
Ck6OAP9Xs8Fzzp2VcFdCU61hwK/q8g9ojIJr4eycm7e0SqLC6QD+PuP5DLHo0lBN
8FmnkiJLMThUN+HNaYZwlX+E/5idoQU=
=O7uN
-----END PGP SIGNATURE-----

--ijLhjEJbLdvGhEzE--
