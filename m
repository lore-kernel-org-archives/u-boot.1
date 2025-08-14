Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D322CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 18:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49C1B839CC;
	Thu, 14 Aug 2025 20:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YS/lblmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7012C83A1F; Thu, 14 Aug 2025 20:47:14 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ACB5839C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3e56face8a2so8157815ab.0
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755197231; x=1755802031; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U+wedn3nsJ1znUJgzbsUY8ldzhquxZbRZXdF7xqnkVo=;
 b=YS/lblmgRquoreS7nfRawcIsf/OicL0Y4HfcJSKUed7KmiC0dSILj3Raf6fuV/aCw5
 gCDxUGGfF5J7nYmW6TL/zN7CKkt7SfTyl/Q1lGCF2v/atqR/7uNa5mvpqhHaOUTvADOi
 JjCLzysPft3x36jI051tA6DrfnvQ3QMJv7Xig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755197231; x=1755802031;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+wedn3nsJ1znUJgzbsUY8ldzhquxZbRZXdF7xqnkVo=;
 b=UrXtfkmpTjxxepEwK852jikXMnIvEw54DidTiATYfj412uqOA/ij6+3jCcWAv6gE6n
 4ptwbIvA8RB3ZomT5gvUU7k+Qe/i8S/4Is4y14BMlNHD6vJUw9rovlYyIpoDBc4GhJ63
 hfMJmXFSZglL+EHjq1HDYR21cpOa8aPyb5anEUqqxnSCAj7gcGx4bHAOyIaHas63hD0I
 /v3uOIuJlb8ubGptgsNF3jSzDlxVGKM2srwfJrxtLwrz6gfcJmQ3AKkyty0fuOMY3mWU
 tAZaG3wPrEaz96ZUh4dkem2s+j1MXNH028+6WsMugeO6u05EFzlcsOAZFqO/UuNRdpvH
 UYbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2Adhbi4U3NBhL6IYh7nAF/3oaXdrMKLzlN88pkQso1YQPfzJMYviIquYe2jDnHmDvgUHUH6E=@lists.denx.de
X-Gm-Message-State: AOJu0YypmtA+X6jfvhJn2QmRTTn06/DkPbOEz2o1SFlEm21e8dQvmBVr
 HOqJhAoAJOuSi2D0pr5nKVh1ioSfKUNvMxIElvBQdixfXFRWlS8/1OqSTHEZ1RYXYlY=
X-Gm-Gg: ASbGncuAPhVT6YYGa2crSU/tD+vX0640iIzLYYtrWoCZc2HqGATFBAPF2GKp1kJ/ho5
 fmi7/Upi4daunn2tBq3EVejQYP1nEc7jTARP2G6rNNoGOu7oV8DoIYlynJ+5Ay7myv5mnrHNb1H
 42ApkGOZCRPr/HdGdcm5eplIpMdi4YYShbQtHjgLmPLSpIGhQjVzX9xF5IizdpFqL3cwsb5T5/8
 uVDDKSb8GYNNMCbnXJQyAa5bY5/gONDxQ178c0z3YEkOLaM9tIja+b5uM89fJh8S83NLOUsYBTs
 RdsN1w/QoFGor3GQrayGf3822iKIf6Zprp80zbcqcBwWZZJxWiwdGuxRPx+bNJ74NHBJZcOT1uA
 7zT0CedAy1/SD4l2vq44CQH6RJvMY95FYCnMNitW81iROwjnJpELRsXI7
X-Google-Smtp-Source: AGHT+IFfypHMknlxQH2vd2nPuIPoTclRlXiDbYam5PIchbLafS4Q+V7Ov19iRBKnECEcMEbEKFM+eg==
X-Received: by 2002:a05:6e02:2384:b0:3e3:b35a:e8ff with SMTP id
 e9e14a558f8ab-3e571896ee1mr78565605ab.6.1755197230985; 
 Thu, 14 Aug 2025 11:47:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50ae9c2999fsm4709454173.73.2025.08.14.11.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:47:09 -0700 (PDT)
Date: Thu, 14 Aug 2025 12:47:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: tuomas.tynkkynen@iki.fi, jan.kiszka@siemens.com, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl
Subject: Re: [PATCH v2 2/2] qemu_arm: Select CONFIG_SYS_EARLY_PCI_INIT
Message-ID: <20250814184707.GP124814@bill-the-cat>
References: <20250814181436.1598067-1-festevam@gmail.com>
 <20250814181436.1598067-2-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Lkk0wl3Wz+xpmHTG"
Content-Disposition: inline
In-Reply-To: <20250814181436.1598067-2-festevam@gmail.com>
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


--Lkk0wl3Wz+xpmHTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 03:14:36PM -0300, Fabio Estevam wrote:

> Select CONFIG_SYS_EARLY_PCI_INIT so that eMMC emulation can
> work.
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Lkk0wl3Wz+xpmHTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJ4vJwAKCRAr4qD1Cr/k
CjPRAQD1As5wHltH2PmD4roB48OUmDuWvDYxKgqjOwTGRB8vJAD9FPmkILYM6fV7
A/qiB4ct2Jv2HWZLve+/Y3cdcyDyLAU=
=7amp
-----END PGP SIGNATURE-----

--Lkk0wl3Wz+xpmHTG--
