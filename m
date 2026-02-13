Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00587EDF16E
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 14:44:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 556FC83015;
	Fri, 13 Feb 2026 15:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kBmdlQHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6344183AAB; Fri, 13 Feb 2026 15:43:57 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94E5C80B98
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 15:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d4be94eeacso858804a34.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 06:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770993833; x=1771598633; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JWgOXtwnl4IECnGAigsclU8DD6ycflJ5Yq5jEr0/KFY=;
 b=kBmdlQHVWV1nJBoilU0t8fsWAEZuh+svHrFGU4A7Yulnn9GWrhUslyPNpfe9loLvhI
 yNhw0Olx70wPV4IV3bwA0g24BYEzP6bxjFAQCJ/LbekcPZrEAt1uKDxQT4JHjmEE9lek
 eyqhU9T06ZbovuSyX3zLbcuBBUPAm/ZxHADE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770993833; x=1771598633;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JWgOXtwnl4IECnGAigsclU8DD6ycflJ5Yq5jEr0/KFY=;
 b=W9HNk7CS5QQgMrrYBmPqLRVADudg44/AZoYPXXZiRYH0XnD/w5sIp2RIqtykFqqWz3
 y52779PLQtdu2V/Z+C9QgD3two3sguCqROXIuuphinPwUJEg1rAQweou9H34kwqYtcVB
 ZtkALQuJZJ4lIeWqAleTYKN8I0okiz9FHL5WzT1iy6043gSeHjkLVkVd+NFqnNLrkUC7
 Ra7uJ0qhN4KBD5GHczcp9Uak6jlhA4w7bSnhfBVvzRCNXqPRNMRBCK4v5CEE/jdo/f5i
 VssBxzKv0xQdwb+2YtXNPykAOUParDHtzU+vX6U6ADADlhPtlBCM7K9mNoxdA3Y6ubuy
 BJcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbdIhZVqX9YLhwNX2pnk0TUXnhMHj4l5a8e/S+FM4xQFhDRAeGVhdRCBaTYEnI/fQ4GZkQN4o=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7e5jozwNGoHTA0yrWPUua2XD81O2ZEfTkRFUswXeYKXIBELke
 w4rg0SQvgYeO+YJI7d4xFUkK7y7dHNF8JYU0mk0t5DZg2oHlZ4rmo6J6w3Fp1LjUwXMQBsvalzM
 +6tmhyD8=
X-Gm-Gg: AZuq6aIjxjRC/QzU71QHPmJob9V5poU85P1Lk9MhusnjRqgGXpnHG9fNhUE3MfABscZ
 f3ueGo16Nb1mvaf6Of9sJWO4kFvtye5mtLy/RrHbMQ51xIek5eeIgEn4BpInFWseoHvQSpQitnF
 al7B/AAW/RjYzUiqgLySKlMevG6oeql/TvKKZHDz1rVPWaS4jdsTrZ2oCQWFJk8dHn0inWEHoF6
 MCQNvwU+MO/YUulc6gKm4rs1W93kkvJuRrG9FxrDu7OXZrJiM6AST4ISu8oxNO8/s5Aaxqmb6iJ
 vXei+ZPMyfYueTQ0CZh4kB+F9qx34DLsC3DCz2/bQfb5Va85cxptn6OYahwrlWlqsB4zsg5aqDf
 J3rIgSoD2LMFBfZnpjhFCXygvqaCFHz/QtD5zr9e7yBDO8KwSyjbur4VJnme78Yqv1P00FEHwXz
 pUHiKQqWIEmbTBHRPR7dXm1V6XqnqwA3Tu6cz/bDQRnLCPEgsNl2q8CwDsQMmd6YvNujjmIAb16
 ohGxMZ6Yu64VmZaXaUV4d/1nvEdjvSMETlwkoI3FHcdQpXxhZ09zFiaLGYj7g==
X-Received: by 2002:a05:6830:903:b0:7cf:dc3f:6b34 with SMTP id
 46e09a7af769-7d4c4adddfdmr1130274a34.20.1770993833322; 
 Fri, 13 Feb 2026 06:43:53 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a7530d08sm6281649a34.2.2026.02.13.06.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 06:43:52 -0800 (PST)
Date: Fri, 13 Feb 2026 08:43:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, eballetb@redhat.com
Subject: Re: [PATCH v2 2/7] disk: part_dos: Align dos_partition_t with struct
 partition
Message-ID: <20260213144350.GG2747538@bill-the-cat>
References: <20260212204511.619392-1-javierm@redhat.com>
 <20260212204511.619392-3-javierm@redhat.com>
 <CAC_iWjJysPTkCTJ10qR8FmNxSBYT6mK7YWoqvxxwez+6H8Yf1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NxdmDpaT/4V7MVCb"
Content-Disposition: inline
In-Reply-To: <CAC_iWjJysPTkCTJ10qR8FmNxSBYT6mK7YWoqvxxwez+6H8Yf1w@mail.gmail.com>
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


--NxdmDpaT/4V7MVCb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 10:41:08AM +0200, Ilias Apalodimas wrote:
> Hi Javier
>=20
> [...]
>=20
> >         unsigned char end_head;         /* end head                    =
         */
> >         unsigned char end_sector;       /* end sector                  =
         */
> >         unsigned char end_cyl;          /* end cylinder                =
         */
> > -       unsigned char start4[4];        /* starting sector counting fro=
m 0      */
> > -       unsigned char size4[4];         /* nr of sectors in partition  =
         */
> > -} dos_partition_t;
> > +       __le32 start_sect;              /* starting sector counting fro=
m 0      */
> > +       __le32 nr_sects;                /* nr of sectors in partition  =
         */
> > +} __packed dos_partition_t;
>=20
> This always has to be packed and the part_dos.h definition had this
> wrong all along?

I believe that's what we found as part of v1, yes. Or at least the linux
kernel has always packed it?

--=20
Tom

--NxdmDpaT/4V7MVCb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY84pgAKCRAr4qD1Cr/k
CuCxAP9UymLIW3A0iM1+SWgsZ6gFeWdPMiLuXiublRAbH4mT2wEA26GOpGNP+GDW
dt4xCAGdWZ6iYu9zduU4No3lfhKQsww=
=yQ3b
-----END PGP SIGNATURE-----

--NxdmDpaT/4V7MVCb--
