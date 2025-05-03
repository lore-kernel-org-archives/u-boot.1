Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB6CC369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 16:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F1318214A;
	Sat,  3 May 2025 18:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W05Hh2wj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1E8782163; Sat,  3 May 2025 18:58:34 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 939FF8212B
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 18:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3feaedb4d2cso2097123b6e.1
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 09:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746291511; x=1746896311; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r54tz/K6Suxd/yzdnQhX8YshfRG3YBfYafXObjxAvzQ=;
 b=W05Hh2wjYG4z/YDtXQdhgizTgBqJ4FjqeEJwEiS7CNqcAXKx55YgJ1IEWxNOH4QdH1
 G3tQGla/Oxh6FEA/kMX2F+BAsjnGQ6omKrEgtfs/dBSdOVN5QmgcB/bQkmY+dgAUDHwu
 yLWBQA0Kr/yRPC9YZUmyeeDnDP9LhTEV5PNlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746291511; x=1746896311;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r54tz/K6Suxd/yzdnQhX8YshfRG3YBfYafXObjxAvzQ=;
 b=tIhpSn+/JUDuw5zkQ2vGxKyLig7OZUy2BHotT5t5GP5ihj8UE1E0jGbB2lvbzgn9rT
 sr99FZ+LnWcVuQSFpok3l2knzQO3MNCJGtol0RsRPC3P6U3vNPaS9LEDB5pxuYYVOt4M
 w0tuOYZ/3HOwcL7TIvumVgjNHODNdtqtNxlIH3N37RH2uuVN8q48Li4X0z5kfs4sALJh
 Ce0+6FTlz8w8ou34bsX8PC1Dyn3qzyCyEvuKd0piP7i4GYaOUQfXa9MicP9RWM+w2Zke
 NrLmMmuzWh2GMIFYNVrmh6698egE9rH0R4cRpvfiAb1PfZZK5auRyNZVvfn3XulSwDar
 6LAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg5HSNBk2pZVShaCACmtIJzaqXHeiNBc0RMm9dVNUrz9g2ZOdqZ+5B6JuKkNVonf5ZA0aTohc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2TY/Rwz9Le8QxJ1NlCtbFscL45FmbeviWUMKSjRlELREjMzT9
 TJ8QkoAviqmbxPKKBUJckXPlFLzMR7UcYo6rDLZUK0avmKCS4FsIyq34stiXYws=
X-Gm-Gg: ASbGncupOz/d2i3LyX3SOMw57sNkHVWYb6doUrhbcG/QeALKPadUvxN426HT+aK7ZaT
 0T5MrJEiP+FEfwC+MefwYY2bkwGHSioevSjO/ybQz2N3f2T/LE+YuLoSHFNqs6AZZwu5r8+Fo+F
 0fcuZt2VXeWQFAdpQJWC8ASh+cy1s9RjWWHd17VBFgUT8yXlv8e7Me8nNaJDVbJ2N/sElN2QOan
 QOZwT2U6LdZrjbfclfaRt4PSDTidYsnfODh1FKvnSP4ssq6XhIsf6WfrI93GJ2VO3Iz5wmq0RcQ
 Htb3FRsHnlEo5soDB9yil8L5mjTOWCW275kn1LDhfndwPp1CAwwtf4H7iOYnz23DYCfZbBeWBDR
 wFA==
X-Google-Smtp-Source: AGHT+IFPK0T1ufIGarlwJFk9jOdJXVBFs7oVGkF1YyrBgrRb1jsnL4CqVQVkeye2U0wj4Q3dyoBQUw==
X-Received: by 2002:a05:6808:1918:b0:401:e8e1:7167 with SMTP id
 5614622812f47-4035a565308mr787021b6e.10.1746291511249; 
 Sat, 03 May 2025 09:58:31 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4033d7df83dsm1113890b6e.0.2025.05.03.09.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 09:58:30 -0700 (PDT)
Date: Sat, 3 May 2025 10:58:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/8] Qualcomm: cleanup OF_LIVE fixup and fix RB1/2
Message-ID: <20250503165827.GF1261075@bill-the-cat>
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
 <174620317246.1348341.13335565510376078911.b4-ty@konsulko.com>
 <CAFLszTgv8vVkK-ts7zRPN2p6oLPWwTKuTk=PjNse-AC2ZgV8WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bsxL7WjydmL8Bng2"
Content-Disposition: inline
In-Reply-To: <CAFLszTgv8vVkK-ts7zRPN2p6oLPWwTKuTk=PjNse-AC2ZgV8WA@mail.gmail.com>
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


--bsxL7WjydmL8Bng2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 08:09:48PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 2 May 2025 at 10:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, 11 Apr 2025 14:47:37 +0200, Caleb Connolly wrote:
> >
> > > Introduce a new event to signal that the live tree has been built,
> > > allowing boards to perform fixups on the tree before devices are boun=
d.
> > > Crucially this allows for devices to be enabled or disabled, but also
> > > allows for properties that are parsed during the bind stage to be
> > > modified (such as dr_mode for dwc3).
> > >
> > > With this in place, mach-snapdragon is switched over to use the event
> > > and some hacky U-Boot specific DT overrides (which had to be undone
> > > prior to booting an image) are removed in favour of fixing up the
> > > livetree (which is not passed on to further boot stages).
> > >
> > > [...]
> >
> > Applied to u-boot/master, thanks!
> >
> > [1/8] event: signal when livetree has been built
> >       commit: 993a9db918af451c68851522c8770e582b717629
> > [2/8] mach-snapdragon: use EVT_OF_LIVE_INIT to apply DT fixups
> >       commit: 5a1dfb27f9170d35a475ea8be46b5d7c037ee837
> > [3/8] mach-snapdragon: of_fixup: skip disabled USB nodes
> >       commit: 0ec337d03410a4a0b7402ae72968470cf63f0c55
> > [4/8] mach-snapdragon: of_fixup: remove confusing log message
> >       commit: a6cc4ef343dc39c17fd5b833d983aff2f26c94b7
> > [5/8] mach-snapdragon: of_fixup: update comment
> >       commit: 9bc7eef9bf58c4c1d453cba81060dc61375f5354
> > [6/8] mach-snapdragon: of_fixup: set dr_mode for RB1/2 boards
> >       commit: 3b983cf48e70ecb6aadca788d0d91a021340c802
> > [7/8] clk/qcom: qcm2290: show clock name in set_rate()
> >       commit: 229fd3f9a8d4dbaad7c9a2e9c1b62d14d0753b0b
> > [8/8] pinctrl: qcom: qcm2290: fix off by 1 in pin_count
> >       commit: 2803a466a96153ab01c5789321e48397b6bae9c7
> > --
> > Tom
> >
>=20
> One of the patches in this series introduces the concept of two
> parallel devicetrees in U-Boot. So once we do move to livetree 'for
> real' it won't work. We did have a discussion on the series and I
> proposed a couple of alternatives, but have not heard back on those.
>=20
> As always, I don't mind what is applied so long as we can change it later.

Yes, it seemed we had reached the point where there was confusion over
how things work, so we're going to move forward and see what's needed in
the future.

--=20
Tom

--bsxL7WjydmL8Bng2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgWSzMACgkQFHw5/5Y0
tywUlgv/UF97aPrrOo7AW66Wc6o/fPBnPUW9kggX4s9NDoiHwlvrF3qKfFxjvENy
h8/4FZRVZfm01wHw3pqFpOP5YeZW7cXCcJE6n1Ci8vPeJoHi+Oru12adLk+SHihg
qFDddg/NHQqVxpxM/YlTVmxfuEkGVcH16mEtB9huFA4+MYCbI9J4o+L8tGcd/dJg
V8+byvaxaKJbRbwe1qV7+TLQilcI1jqFFQyK0i2vZ6a+S3OC1LPlYFLMVTllQv1/
K+csBbSShNd5DloiZ8GjdTEMdRRvjiFtnBXWsg4L9BLvroNS8VFGx6JNqUaQWVgn
ZJSiTTtQ5HTbQ36eYv7iECTT9MLRRXomoL774ZD4qhy54ZzWW3F4Iyv6MSn+bPdt
Vir07pPsPqJCbvGNRB685X+P3X9lKPYhMvjoFzVzzftGmVw84GvsOwHRa9BVFii9
gDpxPLjYs0zJO7tVkOAwkIusHeJqM8ptJtkk1BxATikj0zpPOcImvElrh8eODW8j
CvnE+ENj
=IbNY
-----END PGP SIGNATURE-----

--bsxL7WjydmL8Bng2--
