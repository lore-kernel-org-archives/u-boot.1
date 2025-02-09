Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE3BC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 16:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5AA280B9E;
	Sun,  9 Feb 2025 17:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ChA5q0tB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A44B80BA0; Sun,  9 Feb 2025 17:59:02 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 148BF80A0A
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 17:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6f99efce804so23724977b3.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 08:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739120339; x=1739725139; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EwqVV6uKJZvmH+UJAC08fQwurfJn2sj7jXuivUnfXsE=;
 b=ChA5q0tBoldue0SQyoDdFJvuIWOKm7z+YYQmj6MsSCthWt+Fd50adtygweLnolhTy4
 poPXb9B8z0HgInvIBao7RQjty3Hidwj2zdWP7oWiHy3vttPSbn1HJCaIyZDn4k7aUhXx
 h0itWw2fwgOvs5lT3JqSz7gNR4le2wKAisRsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739120339; x=1739725139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EwqVV6uKJZvmH+UJAC08fQwurfJn2sj7jXuivUnfXsE=;
 b=Q+axcTvjnH+LHccJ1PnReOxA2WB7oTxQQtdwbCVvu2n+6I+2S2PzD8xnj8D3YnUhNc
 QagdJILTZA1cMpQi6kxOkDPQt0+RZsp1+o2AU+bgtCZYdexStv6x9D83TL3PcxkP/mKF
 U7VcewqZE0RT3F7Pqh2Sr5PPPu2xe96WpPTJ3pAXvVb0ZmK8Z/vL1XS6JniDv9X74CwT
 SsbnkZjYigOs5hwhYsoTJMlDTl2oKhg7X1ZfX2/PxZtn2am92/Z9Sf0lulVmje+O/GFR
 P8JAqiuI2bg+JMcRRYqApjgvNlpiGPKNkA0YbRZU0azEZH8O8Y9aL2r97lfC1/M52POv
 GYug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU7oY0riBaoVitjqU8tfxggOS//aFsOnGrjlC43Y5Ocu+fJK/sCLtLFDPd5rC2RMFNX5ugUjc=@lists.denx.de
X-Gm-Message-State: AOJu0YxOr1QAr21aPPG9ACpHbRc0tJHEJhUOD5TzP+24mfoam+Gvk9SY
 Lmz+3rA46Qh6yNSakTQc7X+yhz6dN8+WEK6IP+XhlzyvNaKh+mrulblBCq0fH9k=
X-Gm-Gg: ASbGnctyNFs24doRMvKqVl/8grjrqGgqnHi5F7TAtOWuuikyCcnvIcMIvHfAJj7Ay//
 DnaPc+5hSnwcYQr/OMxnLwIf9b0t3e2w1lBTyhVsgKgq4PBydTtjBYpwd2iHfIL5vmub2zmf/oY
 HWBGGTuXqCz4vjWvV6FQpwiCH2OZDsIDRddIgAuvHSAc15PMbFvZ7IAJijBPr0Q68sXJySbQN4u
 QisL0FVU4LG7F+MXa6czO+AZ3OFfN92PdueiHdFQUWoIYjK7tycCiYaMcj312MkLYEHlDu3VKDy
 e0kCikCUWkXFG/Q=
X-Google-Smtp-Source: AGHT+IG2wH4QNtqPQWf8EeLXQiIIZ9W7OLztC/67/hNvrb6REHoqqIWdA+PwUxJ4C1LIW/m2ZzytnA==
X-Received: by 2002:a05:690c:c08:b0:6f9:525d:a096 with SMTP id
 00721157ae682-6f9b280fd6fmr92129967b3.3.1739120338918; 
 Sun, 09 Feb 2025 08:58:58 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fd1bb65sm12924807b3.29.2025.02.09.08.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 08:58:58 -0800 (PST)
Date: Sun, 9 Feb 2025 10:58:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] rockchip: rk3399-gru: Fix missing TPL and SPL banner
 on debug UART
Message-ID: <20250209165856.GO1233568@bill-the-cat>
References: <20250208224945.2641933-1-jonas@kwiboo.se>
 <CAFLszTj=NNZ=-uJojzPZ7WZbUe2HVp+OB8M2o2MFbKTHd1fbDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2ec7W/+/NoVVXWi0"
Content-Disposition: inline
In-Reply-To: <CAFLszTj=NNZ=-uJojzPZ7WZbUe2HVp+OB8M2o2MFbKTHd1fbDw@mail.gmail.com>
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


--2ec7W/+/NoVVXWi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 07:28:38AM -0700, Simon Glass wrote:
> Hi Jonas,
>=20
> On Sat, 8 Feb 2025 at 15:49, Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > The PP1500 and PP3000 power rails must be on very early for the U-Boot
> > TPL and SPL banner to be shown on debug UART for bob and kevin.
> >
> > This series restore the early power on of these power rails in
> > board_debug_uart_init() for both TPL and SPL to restore the missing
> > U-Boot TPL/SPL banner.
> >
> > The reverted patches was introduced in v2024.04-rc1.
> >
> > Jonas Karlman (3):
> >   Revert "rockchip: rk3399: Drop unneeded bob and kevin board specific
> >     code"
> >   rockchip: rk3399-gru: Enable TPL_GPIO for bob and kevin
> >   Revert "rockchip: rk3399: Fix TPL build of bob and kevin"
> >
> >  arch/arm/mach-rockchip/rk3399/rk3399.c | 23 ++++++++++++++++++++++-
> >  configs/chromebook_bob_defconfig       |  1 +
> >  configs/chromebook_kevin_defconfig     |  1 +
> >  3 files changed, 24 insertions(+), 1 deletion(-)
> >
> > --
> > 2.48.1
> >
>=20
> Thanks for figuring this out! I'll let Tom run this through the labs.

You should test it when you rebase your work on top of master again.

--=20
Tom

--2ec7W/+/NoVVXWi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeo3s8ACgkQFHw5/5Y0
tyw0mQv9GHd3/dDChuczGAVEZwI+cT08Y+A28YIIAEbXXditeweb9w9MN4bdpJ+F
lOXNDUbJ9o8HIkCUhghzwCP/RhKizluo2wq0p487z66M43wDCAF7gt8v+N3b935B
KbbgG8CTUuzPWrRmM7tbXOdye3ASuw0ZY0cbVHl71GELwFaXr2qz9SsMxVAco32P
5z4e7V1O31gj+9ZBe4UWrb7Ie9v2Pd8Lp5qQqIGPXvT4GSQQOgnT8zSTpLwNmAq8
jspEIb/sFiXl/8pBQZQ85GHnliAr8KRAar/3mPLptoa2EKlRcvP9ZuZWie+2N7tb
dps4fCWkDqLlBCLrcxK/UBO8QGVDkub3CUerb3v2W6Il/geqkEYceV26U/+tFoK6
gxmxjSnhNwQ9N1fzRRsrgxiz40LcRv6/2LWinK905Th7GV1jKPX9ACFvghueorRL
LlUxlXD6QwTTmXmO+5lzdBGgq57wgwY5pBnIz/wioFMg3gDPkpWBgU+yYs0lU4V4
8yB9qcXB
=nlod
-----END PGP SIGNATURE-----

--2ec7W/+/NoVVXWi0--
