Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6867BCD343E
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 18:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1CD783CB8;
	Wed, 12 Nov 2025 19:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JJGqJhp0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BDF483CE8; Wed, 12 Nov 2025 19:14:52 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED5B483CB5
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 19:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-3c9991e6ad1so552787fac.0
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 10:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762971288; x=1763576088; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1D9XShTEzqrA7Zdn5/jgH/VnZ6dpVE5CocKKSsORpNA=;
 b=JJGqJhp0kOwHCp0UNk+6unZFc8YTBdGNvRqbRbariOi/d5rtOKdSyF0ECQeiUdKrS+
 ULJDVxroJm7mOiZZ26QBCtuwqf9C7+RPv1fWM9mQ+c2Cyvu55s7K7KIcEcZd7uXGJtOG
 r+9R/y4xH8DEVOY0y07r7VUIjHj6JVuJ0CIXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762971288; x=1763576088;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1D9XShTEzqrA7Zdn5/jgH/VnZ6dpVE5CocKKSsORpNA=;
 b=gQv33Endcviwnk0mmrl7IfqAm3ssl+nmCtG7ke9QLvLeS1KU9hoSkB9F3hhJ0XabnT
 cMchVHKw6FdU3hAzV4tLSl3Ana0Gq3446lrKefYlTMtFC2CLQR2BJuogNzxKxvYwWZ4k
 UkSw5B4X8s+Yj5G0TXv+BHUSV2b+AXIxI7J/q8OEc88ciRr5/gApJ/6EFv5RXKbvNvz7
 a8o8yBZos8iS1VIoSujtpDS4gm8iwHTIVVNr9bjDZ0s/VJZitLKWGybqpszxUDSLg5fr
 zWNMS0BdZ6XhrT4YcQTfaw7vDIirF0vv92RdXVKMaimjl9ZUJCQHILPIuxOQsC+bcLX7
 3JpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOReFTT2wgZz7p3zOR/vSi0sd69MKT1WjyxBHfMBUIqyE59n2UT0JoxlOY3WmxgsexWbh+t3U=@lists.denx.de
X-Gm-Message-State: AOJu0YzhkztUIt2qYqPMIQ9dK+mFzIa3cnEC9OZtuuX7rB+jWEoVFTGu
 +RDt89fpXh6t1cntjHqo0658Ux8QQD+p0bIujsGdGUqclmnNIULWef2JVglJKgsdjrg=
X-Gm-Gg: ASbGncuiGHCkr0b2TPqiIeeFxxt1WvV4/KVztcJ+KdLyLi+4/FfaEXOWeWDbotV3ZGh
 tx8lx/HXQ7BBM5lF3rpDhnEcxMI/wqm/jCydMtjajwV1FQJhLksLSefdKfoiB4GLzR1JYUpXSzg
 UI7tHbTUZ2QCcWRsvYY2j9uGjCe6o4scqPu80Rhq4lAv5XTO4FG8/G0+8dUh4B3FpAV5FLZQpJU
 tFsn5FxbH72XZSaJoA/fycM3bxtltyDdC5rNEAKk/ngttPxFhmvGid+XtPNlnbIqlrzN5P2Eipu
 lXBnDIFyQbCf7lVi/k0RrTslPfC8aXWVLNA5SXpgm0bXDksCedz/k+Q1jb1THkdqWoB+nZFhQCY
 5Q+qZZia0bfE5i+vW8Vt9u4vE0VjskDpCVf+ai2/m0laJti7G/C5baz9mf88wswtIpyAmpgQq1P
 dYxLThKPs0It9+c2J4iyWfViufRLLCsynO5I9gWBw=
X-Google-Smtp-Source: AGHT+IHjre9itZXGgaxUeF4BjzcSdHB10RHDtLGN2+vNMdMhrJR3vKSuc52zoxhBCq2uzVlaVOR9Sw==
X-Received: by 2002:a05:6870:1641:b0:3d9:4713:d186 with SMTP id
 586e51a60fabf-3e84c46b580mr227971fac.9.1762971288657; 
 Wed, 12 Nov 2025 10:14:48 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41f13d088sm10243190fac.13.2025.11.12.10.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 10:14:47 -0800 (PST)
Date: Wed, 12 Nov 2025 12:14:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] test/py: Use aligned address for overlays in 'extension'
 test
Message-ID: <20251112181445.GE6688@bill-the-cat>
References: <20251112020230.414101-1-marek.vasut+renesas@mailbox.org>
 <20251112133558.GY6688@bill-the-cat>
 <1933c9fe-22f5-4405-8938-fa28fe89a330@mailbox.org>
 <20251112152750.GA6688@bill-the-cat>
 <87732B74-9EFD-4D6D-BB52-52B31BB7923D@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Vyn0TZ437kahCHVs"
Content-Disposition: inline
In-Reply-To: <87732B74-9EFD-4D6D-BB52-52B31BB7923D@gmx.de>
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


--Vyn0TZ437kahCHVs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 06:50:48PM +0100, Heinrich Schuchardt wrote:
> Am 12. November 2025 16:27:50 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >On Wed, Nov 12, 2025 at 04:24:34PM +0100, Marek Vasut wrote:
> >> On 11/12/25 2:35 PM, Tom Rini wrote:
> >> > On Wed, Nov 12, 2025 at 03:02:21AM +0100, Marek Vasut wrote:
> >> > > The 'extension' test would set 'extension_overlay_addr' variable to
> >> > > decimal 4096 due to conversion in python. The 'extension_overlay_a=
ddr'
> >> > > is however sampled using env_get_hex("extension_overlay_addr", 0);
> >> > > which converts the 4096 to 0x4096 and uses that as DT overlay addr=
ess,
> >> > > which is unaligned. Fix this by setting extension_overlay_addr to =
0x1000
> >> > > as intended, which is aligned.
>=20
> Please, do not use fixed address 0x1000 which may not exist on real hardw=
are.

This is already a sandbox-specific test and would require substantial
changes for real hardware, it's using "hostfs" for example.

--=20
Tom

--Vyn0TZ437kahCHVs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRTOkgAKCRAr4qD1Cr/k
Cum7AP46y1L24Ooz8NDbRNpN49Tou2EqGZRBT/adfayuMI+F3gEAvsOwDIDogIeP
88N7RF6bQlEI+uEmAmndCd3U9RqgCAY=
=fjYq
-----END PGP SIGNATURE-----

--Vyn0TZ437kahCHVs--
