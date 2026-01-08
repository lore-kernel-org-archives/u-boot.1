Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC21D1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 18:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18D2A8415E;
	Thu,  8 Jan 2026 19:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DbsNDpO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 424C58415E; Thu,  8 Jan 2026 19:39:05 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35AB78415D
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 19:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-459a258561cso1468569b6e.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 10:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767897539; x=1768502339; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hTJEeg8uxcPSltosC/g6v0QNQXD475EVHhoC9N97E68=;
 b=DbsNDpO4AdmFNuctA6+jl7TKotexMDsYacL9uSfkOXU/s0hMAi6ld8qr1KM9Sxu7vf
 PAvHRwRn+weOOFLnhJVNNHzInJvdauABeuUWqC0LQGb1RF2OkRfLvdsLtbGK7jRWU5tc
 zDTAYx7B3gTldyLugRf3tch3rezDq9KUp8sSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767897539; x=1768502339;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hTJEeg8uxcPSltosC/g6v0QNQXD475EVHhoC9N97E68=;
 b=b0U+6Dtf/8UbiOZ0mlTfH2pUmugmQvhh5nnaPUGizkEMB+DQGkgNW9autXagSfrrmm
 G5wWprCeZbAn/Xkx2GYbw7FONgVOHGZ66qnKAEb4a4O6kPasykoPvRjbw8tzI+3Sr3mH
 Wr8/OFf0BduLi6o7xmqa4QlSD3JX0uHBKSZh75Bo+honWMlnwUEX07Uf98Rze61bIkMi
 1OTXtcQNFplVtRgIMe/7vGJjFjqisXP0vmIhNHzKxqN9RDY6qqBvDnK0ndDF66CYL5G1
 6FuEptJMgh17EelHowYG1IC+4LGOkWL1hA4WEbR+2mfs/x5v4ReRPOH4FBnfOewI2lTE
 sNVA==
X-Gm-Message-State: AOJu0Yx+yABtiWJ+1pP5mhEnWirku9Y9trm8H+DKeYWNU+S8xzc3VmK0
 R2Yhq/9CNUo/lxWNyRBAW17jB4LufiRRq4Rok4/ApoVHW9I6tGJE8j9rN9qutsynnlc=
X-Gm-Gg: AY/fxX4wuSAWWsH+gKXTNmeL8Pm2Q3u1CoHLHDD5qHmWVDUaQWIkYkBHtm6Z7mLZiKq
 EfWPHPg1NQJvZpgje7wAevvkYpiaVp1gdObBchB5f/7LjbX96MHa/az/cIwsTt9FkUI0PBf/Wbw
 EQ+Gx9WW1Qs1yJ3EZ8zyN2cde4+Tf6XJKpE/TztKuyp3etyRwhRjIR9DReP7RCVtzeUlhkRkT3Q
 sMSajrndDMTnEPPiwOaE36fY/u8cgMyWcEYn/V5SI67BKloDAdhzKYEDH/O3k8MZbVtk5iP3mSy
 snPP4p44crxqDIrJSvm/hBPVW0cuBCw6vKkdOXfhNJLVqj7is4qFWtNbrnZjiRhN25X6RwnG9dR
 wDHtcsBbqju0YY9ca6TqyKYX3FJMYp5Ch0uO+/nwNiK+OSx4UXlkazNDCBnWUbcPlaTprEv5ZwP
 LeFnE3E2AUUYgAAxRGCOh50bfA7Jqb6B9p17/p5AfKf3maP7KOgQTbHTRFjjLpaJ1MjRDZuiRK0
 tVuT7nrEXB2Bfpf2UZITw/63SUNHU3ZvsiOEfo=
X-Google-Smtp-Source: AGHT+IEpq162fqgvLyWB0lmnHBXYDesYIRg2+/V/WNNBvvDfGYSZq32DNKxC4OOGCt9fl7ZofY3CrA==
X-Received: by 2002:a05:6808:1692:b0:44f:ef44:9cc4 with SMTP id
 5614622812f47-45a5cafa65emr5825150b6e.32.1767897538880; 
 Thu, 08 Jan 2026 10:38:58 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478d9c17sm5906546a34.22.2026.01.08.10.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 10:38:57 -0800 (PST)
Date: Thu, 8 Jan 2026 12:38:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Timo tp =?iso-8859-1?Q?Prei=DFl?= <t.preissl@proton.me>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/4] fix integer overflows in filesystem code
Message-ID: <20260108183855.GU3416603@bill-the-cat>
References: <20251228164500.313817-1-t.preissl@proton.me>
 <20251229144813.GP710860@bill-the-cat>
 <CAFLszTjFP4N1v-=Uob+DRpG_Fc3szkt+yziG+cbLQ7nxaM5mvQ@mail.gmail.com>
 <20251231015450.GW710860@bill-the-cat>
 <20260108150025.50206-1-t.preissl@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B8XljysJaRz6JhSo"
Content-Disposition: inline
In-Reply-To: <20260108150025.50206-1-t.preissl@proton.me>
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


--B8XljysJaRz6JhSo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2026 at 03:00:32PM +0000, Timo tp Prei=DFl wrote:

> Hi,
>=20
> this is a gentle reminder for the v2 patch series fixing integer
> overflows in filesystem code, sent on Dec 31.
>=20
> Any feedback would be appreciated.

They're in my queue to apply soon, thanks.

--=20
Tom

--B8XljysJaRz6JhSo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV/5vAAKCRAr4qD1Cr/k
Ci3qAP9Lb/hLffCv4QA/sQUlQyTIAEriWC1meAXePMDbwZjK5gEA3jsqSCLCyzU5
YX2QVW+IeWfITleKkubgQ3j2aik7DQM=
=lhmx
-----END PGP SIGNATURE-----

--B8XljysJaRz6JhSo--
