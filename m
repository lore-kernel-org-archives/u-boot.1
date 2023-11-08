Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4047EC4167B
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 14:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84EE387186;
	Wed,  8 Nov 2023 15:42:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LBpbEAmM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2EA8718B; Wed,  8 Nov 2023 15:42:00 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06C968717B
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 15:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5ae143e08b1so81972037b3.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 06:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699454517; x=1700059317; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nDNhbblyegWDo8fcdcCwPzeLowfbaSRpioFj0sl0E50=;
 b=LBpbEAmMG21w5Zhmd0KpTMINe3U44IkNTpxyd7Fj4SOPg12pOYxVECyGVewcIx3LaO
 gSsTexwP9nsELHb/T/nhg8Ehv/HgygtjEZtRyBg3PbU2tXEqONe3TVFV6CEOkOinZdiC
 DOzB2xxxiewvSHdpFnbJvgiuHPdOItDMv65LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699454517; x=1700059317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDNhbblyegWDo8fcdcCwPzeLowfbaSRpioFj0sl0E50=;
 b=DM+GG6zLVdM6wv7S7ay0Hr04u4VKIxtKu06rBL6V9d4yvygoNFHLqjwdwkutSRhD36
 pu2gSO6HprdM5KGm87SM2NOCjblbkdhBv1i+I4nOtGZ8Hk2qz4vlc2W8Wvz7IS1RkGGr
 Mjix3amzXOEQQJXL9fngFYgLF0ScgoaVr5LRa5QxHxlsP1T3sdPl3Qk3kK35z3aGfGWD
 v8+21DgwhTUP1rnO+o1OebkpIgzdCSJt21y5IwI5BI6IEeViCi2IPS46bUHztNYp8EFv
 SEFiKzqxb8fLLgQGf2QeYzjLejDTHwkWynzj9OADzDgAj6jpV72hQ9lAxWbzSGsR34pH
 De2A==
X-Gm-Message-State: AOJu0YxVPb0CSpbvYzILQ/MKUh/Q1+UMzm6+Ah0lZEepo/F1Zu/UJAxF
 I0Pu4dRpdXkHpLeCQYJorlBvEg==
X-Google-Smtp-Source: AGHT+IGUGAPI2QMdEg3afmH4ha8uRlRrVmgHOETUCpFRUDtID7pqgHHFGu6uX/ypK5nSk1tvu5ftUg==
X-Received: by 2002:a81:9b89:0:b0:5be:ae23:c002 with SMTP id
 s131-20020a819b89000000b005beae23c002mr1092464ywg.26.1699454515764; 
 Wed, 08 Nov 2023 06:41:55 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a816944000000b0058427045833sm7038360ywc.133.2023.11.08.06.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 06:41:55 -0800 (PST)
Date: Wed, 8 Nov 2023 09:41:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com,
 rfried.dev@gmail.com, v.v.mitrofanov@yadro.com,
 seanedmond@microsoft.com, emohandesi@linux.microsoft.com
Subject: Re: [UBOOT PATCH v2] test/py: net: Add dhcp abort test
Message-ID: <20231108144153.GA1069311@bill-the-cat>
References: <214217fdd0d69a107482c5c6f6dce96894aa5dc1.1698757115.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ksJLulMcmJUo4vUM"
Content-Disposition: inline
In-Reply-To: <214217fdd0d69a107482c5c6f6dce96894aa5dc1.1698757115.git.love.kumar@amd.com>
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


--ksJLulMcmJUo4vUM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 06:29:20PM +0530, Love Kumar wrote:

> Abort the dhcp request in the middle by pressing ctrl + c on u-boot
> prompt and validate the abort status.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
> Changes in v2:
> - Mark CMD_MII command dependency

This doesn't work for me on a raspberry pi 3 in 32bit mode (and I
suspect fails on the rest of the Pi families and builds as well):
test/py/tests/test_net.py ..F

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
_____________________________________ test_net_dhcp_abort _________________=
____________________
test/py/tests/test_net.py:139: in test_net_dhcp_abort
    eth_num =3D re.search(r"Current device: '(.+?)'", output).groups()[0]
E   AttributeError: 'NoneType' object has no attribute 'groups'
------------------------------------ Captured stdout call -----------------=
--------------------
U-Boot> setenv autoload no
U-Boot> U-Boot> mii device
MII devices:
U-Boot>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
FAILED test/py/tests/test_net.py::test_net_dhcp_abort - AttributeError: 'No=
neType' object ha...
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! stopping after 1 failures !!!!!!!!!!!!!!=
!!!!!!!!!!!!!!!!!!!!
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 1 failed, 101 passed, 86 skipped in 39.89s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Perhaps the method you use to interrupt the dhcp attempt needs
re-thinking? I don't know if we can reliably inject control-c instead
quick enough to the console.

--=20
Tom

--ksJLulMcmJUo4vUM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVLnjEACgkQFHw5/5Y0
tywpKwv+LZOvc360fqw8401h2jLs7iAhH+6nLC48yl5+Q/Yd5bHrbK1mqvb1me1N
vf6h//tEebY6cFWpQhrwC5yAm81b2fk7h53HwxEeNVJIgLInLGtphw9TRT+p3DHe
E64CNRKxSu7XQd87yxQjjT0ZqnZNGpCEAYt9sU3muKy9nIU2yazwOSjKcb1M1d9G
9SRneFnd/8F1GJkEPu6iRdwhqk3gjhOIfN7hN0BAK307nrUX0XoUKMZw6nNuGsGM
BtNnTNxb1Hq6PhcULFjQFcpuQY2M8eaTkafWIL3AUzhIXyXSNV/sMHQqvLTFPvY3
NZiDJLjr7sIaY0i2bkaG30Qf8LpzQMth8Yq/08Hr/Zo3gUqcOpOeY/EBRn8/8IrA
p/StRw2gy+7f3CT4qenHl4+ieDJQvtzUqbpPudiUlns7odzbavvbRH0LbHJud4GD
I0Fr1DOrHE3pi8XOW/aH8Uh0jdRJmsUKdGigE3UXeSkTApjWaPupW+Be3wYxSUPp
6+0vwsIr
=Hdr0
-----END PGP SIGNATURE-----

--ksJLulMcmJUo4vUM--
