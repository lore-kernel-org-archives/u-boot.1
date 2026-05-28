Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1909DCD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 15:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68BA88056B;
	Thu, 28 May 2026 17:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="feZWHNyX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F341839A8; Thu, 28 May 2026 17:47:52 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D402480087
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 17:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dd73b7c757so6033179a34.0
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779983268; x=1780588068; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pguSeUJCFzTwzlewOh42SthVRk58P0pc0PN2bfTsDRg=;
 b=feZWHNyXsHSNLF7gWLIYU5dSxIdaAy/jv/n/GCv6b7mkij8aKliQWsAQrFMGMRNEeR
 efl5FJ3/hYTHouCvAcTnMxLeToCxNTXdAa+HSF8jzV3esFee55r6V00VxDozrav8JktE
 UfqQpmEV9iSUmH6UdsyhJYie3QF2Z7EENEuj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779983268; x=1780588068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pguSeUJCFzTwzlewOh42SthVRk58P0pc0PN2bfTsDRg=;
 b=K0oX0HmMx0u8xcP+KxVwFJp/WtWF5SFEKML2TkMtzj/j0w+LP3SrulLFvE2IFrYNQx
 rX23dOamWtyD71dGsX/lMJ1p1Qxqav6LF8oqRRvYflbAG9zFQcBlTZ6Nm83+aHcPuyhW
 X9+gkQYSG2WvDsROr0bq+vi9cGn0jpx+TZ0/8OW5px1ISf+K3BgR+sbZTvkhF2AMuNaM
 vCyMRwg85MpD0WiW7tIcO6oFhMy28tgXlNlW7DnYaG96atqqq0naW/bLbz1iDLvTdBad
 BPoTn+q2ICU8a/G6044Mi7Ev9pTcBqzNmf0fXdG8lUiDRQDu07ugSquTlyjhQYkzolaQ
 0E2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VO9O7WzlxDTvaDgqOKlRRFzJ06yLhluVDgvpy5jcMGTvwfE7jYrmddLtpd/BDwAdG3oHfpc0=@lists.denx.de
X-Gm-Message-State: AOJu0YxGi5wsReoez+ZN1VE+l6YSi/Xc+MgMsrbYwWfC3C0MZjBuBCQ3
 ELwGlvWU2sfQNNRVwVkmjApYq1uIAduT29nXNCGkeOuGl5VT8wMeDrcIV/6PzYQajxaho4g52Zs
 ityGHMPg=
X-Gm-Gg: Acq92OGbsm7ogQmQxiPBYRE+tD16A7kQS2Sa6Uh+mxtgc+QBwrrG5U5zpkHO8mHPvuz
 RNFZK9ldbhHAZCAIY6v4McjG8dsAquWtbtIIt/zkJU/u/97rph0jg82k9+NWhb11rZd4Ju4J6Ka
 SI4hbRB0lfNAwQJPKm6UDZQF5JAf4MGlCTTlvY/spgQodxmE1Lh5V4Alc8pppH7PM3VepG7N1NU
 vjyt6jPnJgq5l0/Gd7VMyWDPf2armS5DWbgVh743Iciw8UW9Zm9xTUTypTu0j9QK48jAtfQIlTP
 1mkQr24aT8RYvig0SU4V2UcEh64Prd8j/enHrH13pz7+C0gbN0NT/JkmKcxZJcr7SWETOnD0whq
 WZdO18QjZ3tnJnQbVGDvpOXLmiIJ+BXp9ShZ0Is45jMPwYWPCwjjCdqbWS30/UXdalIeKIQivLa
 qdvt+R23hpg6j0v7+TTQ/V1v9Eas+x3MeqHi3J8u9V+il6We6R2l5tuh945Z+yaaKqgIG0Y9H1J
 lmItMVOShPOc/Hp5bcdbY6CCL7etJrtsmrd55O+a60qxqtSIGEWX4qN
X-Received: by 2002:a05:6820:138a:b0:69d:fad5:fa8 with SMTP id
 006d021491bc7-69dfad511d9mr1008312eaf.7.1779983268501; 
 Thu, 28 May 2026 08:47:48 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43b63a15569sm20343708fac.16.2026.05.28.08.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:47:47 -0700 (PDT)
Date: Thu, 28 May 2026 09:47:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Josh Law <josh2@disroot.org>
Cc: "Lee, Brian J" <hibrian827@gatech.edu>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Kim, Youngjoon" <ykim3186@gatech.edu>, sjg@chromium.org
Subject: Re: U-Boot TFTP OACK option parser reads past unterminated values
Message-ID: <20260528154745.GE93986@bill-the-cat>
References: <DM6PR07MB43775463F18267C7C1AE8981F6082@DM6PR07MB4377.namprd07.prod.outlook.com>
 <8C6CF5D6-B9A5-4837-8D4C-86E151C7A617@disroot.org>
 <DM6PR07MB4377F2C4B242629F7E4FE52DF6082@DM6PR07MB4377.namprd07.prod.outlook.com>
 <E4D3C94F-5528-4BFE-9B8C-55CEC835E6B4@disroot.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xfr6xDB0EicMK1XS"
Content-Disposition: inline
In-Reply-To: <E4D3C94F-5528-4BFE-9B8C-55CEC835E6B4@disroot.org>
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


--xfr6xDB0EicMK1XS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 03:46:51PM +0100, Josh Law wrote:
> On May 27, 2026 7:55:58 PM GMT+01:00, "Lee, Brian J"
> <hibrian827@gatech.edu> wrote:
> >Thank you for the acknowledgements! I apologize reproducing the PoC had
> >difficulties due to poor quality. I will make sure to improve that. Thank
> >you!
> >
> >Best regards,
> >Brian
>=20
> Hey Brian, sorry for the unexpected email
>=20
>=20
> After playing with my server slightly, I got your script running :)
>=20
> [run.sh] reusing existing
> /home/josh/stuff/u-boot/INT-tftp-uboot-short-ack-oob/INT-tftp-uboot-short=
-ack-oob/poc/source
> at
> 215496fec59b3fa09256b4fb62f92af46e2ec7f9
> ERROR: AddressSanitizer: heap-buffer-overflow
>=20
> I've CCed more people who can help you here.

All,

I'm sorry that if in the end it turns out I'm wrong here, but given all
of the public evidence:
https://lore.kernel.org/u-boot/c67720e2-bb73-43ab-9d75-851ef1f4afaf@kernel.=
org/
https://lore.kernel.org/u-boot/ahXPidpyl-qRMOkH@google.com/
https://lore.kernel.org/u-boot/64b5a656-d73d-4c72-95b1-3c843b18c2f1@digi.co=
m/

I do not believe Josh Law is a human but rather some LLM agent. Please
disregard their feedback.

--=20
Tom

--xfr6xDB0EicMK1XS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahhjngAKCRAr4qD1Cr/k
Cn8mAP4yLI9TSW/xdRvg3ga1zJsxno9FeRJqo+ShqeGXMP5fcAD8Cy4TYCV8l5Rl
gySklqBhFXT7tIfj8J8Q28rjIsJB5AQ=
=lL39
-----END PGP SIGNATURE-----

--xfr6xDB0EicMK1XS--
