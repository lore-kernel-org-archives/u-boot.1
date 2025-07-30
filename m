Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19294C83F26
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 17:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DE60831C6;
	Wed, 30 Jul 2025 19:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FsiVKeLu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBB04831C6; Wed, 30 Jul 2025 19:47:22 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE2DA8319C
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 19:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-40a4de175a3so36217b6e.0
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 10:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753897637; x=1754502437; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e+rbJw8uzy4hPCYKzqhzUvZaZW1HbVd/ccLJCHYePKM=;
 b=FsiVKeLuZ8HieRNBNlBVr+hoKt4CqJaS4F8ME09GsECKuS2cxtCS3fc2ID0MDuvXmr
 Zhsm7ID3JY2O4LDa/TUu8dKwzL7LUCjD2EmQEl+1kQsd9/GddWvHOHR7MNzjT6RToWBR
 uJga2UQOve5llMeG9t3AyTyk/9pAek6LGvnBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753897637; x=1754502437;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+rbJw8uzy4hPCYKzqhzUvZaZW1HbVd/ccLJCHYePKM=;
 b=lK/DvjNhEPwi0xAWtYLMkguxONZ0rir9vz0mquujIMIRLgfURg1JoP8qmHGAFnjURE
 IoyENbjT2DT+OATMnvKOxHLzmHbEktA02j4JYeusIxTVv5mLuUunmS+R1LcIldYtgVnv
 4uxEwXJ/xgOvgiGi3eCDuBIB746PuGpqtL2UXpx8nh6iinLDE8bDgvzTsbl326rRq7aJ
 /YnErEFWg61+kDxIegkmVySZnr3WhUpFY/KyxZDd4qx0iIXGYU81XIrL4G74t3pyajFI
 l4jppc5bCjbXzwxqIErZSXJz+/Kx4ugAEtNEMCpOwzeH7CAZYzN33ivKF1A+bu8ezE8K
 94rQ==
X-Gm-Message-State: AOJu0YxT5CSEgFvp0o1zyWCDO+oPVjXrLatToT8mCDdGx++wBkSJe41k
 ic7BtfBFatD3qptR/l8OIgSiRcL46Krp50/8a22N9d1WO3WJcIm6YVyyZYFKGZiU4kV6CKGYbzY
 74Pmn6gY=
X-Gm-Gg: ASbGncsDeHVQZNk2v6eLRUNo0X0B6/zqDSsHi0f3rJqWZmLugD1d/vRbkSLFPbrpwek
 23BEBF1nNxQ822vnIBoTNVAwKkmFryQgRTAwOOcQRR/9Zj2WXm0j76B9lXKOnOD7WEnN5j+W5Rh
 LrGM4xCLrJVYkoYe25x9tmlAotDLIqFFLQjN0A1w8Scv4K9wn1d7lqZ/czC6UGdFlIBx6lI5NM1
 ucBV1JoGoRdvEih8KD+6T/Rvuze4w6F4+EXRWZaCEOLRxy4HmGUmLSjVrQIf0NMBaAG5OHsUbvL
 6g3U64J0b++HBC2IUpDjqOpqvWRwI2ic6dCbnAIwOEbrLHu55gS5vkCBch4LxgZei5e+ILldtr0
 w9EneV29saLMPRuJUaNFYRjFljC6/QCkMddxGKxwVFy61xDUMsGzKzHVN
X-Google-Smtp-Source: AGHT+IEBfgoDuMM/qZUvWck4ZHkBRBFjW/94vuljLQH+fV38UzTVahd2yGzNLRvfXCwvah8oeTCI3w==
X-Received: by 2002:a05:6808:4445:b0:406:7704:b2e9 with SMTP id
 5614622812f47-43199d8fcd1mr2675970b6e.9.1753897637448; 
 Wed, 30 Jul 2025 10:47:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30713592187sm2997006fac.22.2025.07.30.10.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 10:47:16 -0700 (PDT)
Date: Wed, 30 Jul 2025 11:47:14 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.10-rc1 released
Message-ID: <20250730174714.GV1807455@bill-the-cat>
References: <20250729002400.GJ1807455@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9/xtiocAPXWaPvrZ"
Content-Disposition: inline
In-Reply-To: <20250729002400.GJ1807455@bill-the-cat>
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


--9/xtiocAPXWaPvrZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 06:24:00PM -0600, Tom Rini wrote:
> Hey all,
>=20
> So it's release day and I have tagged and pushed things out. Looking at
> my own queue, I think it's in reasonable shape. I do think there's a
> few other pull requests that need to happen still and I am optimistic
> will come shortly (but I've not reached out to anyone in particular). If
> there's anything big that people see missing, please speak up.
>=20
> We're continuing with a community meeting following the release and the
> calendar link is
> https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DN280=
N2tlcXE3aDVtbjlicnNkcm82YnA1bDAgODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjB=
hYmQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBn&tmsrc=3D89be7b813136bec06a83d=
e4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com
> and once again this is the same time as the previous meeting. The
> meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> July 29th, 2025. 9am (GMT -06:00)
>=20
> To join by phone:
> https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

The summary of the call is roughly:
- I gave an overview of where we are with rc1 being out and that we're
  in good shape I think. I reiterated that I'll be taking the v6.16-dts
  tag as soon as possible.
- Casey talked about the arm64 stack backtrace series and asked a few
  questions about how to handle things, I offered suggestions.

It was a short call.

--=20
Tom

--9/xtiocAPXWaPvrZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIpangAKCRAr4qD1Cr/k
CpPoAP99zDJg2AqWh59cDe9IuHt3UkAzzhNjEY1n/dSlNVdcDwEA/gj9qGJuVHMt
7XHpN5J053FZnxtw7rFuha0ToFQPgQo=
=G5PB
-----END PGP SIGNATURE-----

--9/xtiocAPXWaPvrZ--
