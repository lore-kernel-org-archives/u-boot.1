Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE22C5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 15:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 582378785F;
	Sat,  2 Mar 2024 16:18:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="COc8cRHH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D65787E69; Sat,  2 Mar 2024 16:18:20 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E005687DB3
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 16:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5a11b781a79so327302eaf.1
 for <u-boot@lists.denx.de>; Sat, 02 Mar 2024 07:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709392696; x=1709997496; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+ix3IutbnK9YYauMdQE56UD9nLiU/cI4vzt+SYzsULQ=;
 b=COc8cRHHuRHKXej069terZCGXq/wiDtk7VwLxTCXNEIIw1+N4I38cq8aWLZsa17vxk
 u4HHBP+dtkuZLXtqaINi182bzw/Gvnthr7ALJm/GfUd1EHbeJPAaI3ESOyiy4dVEsc6h
 m4C0GY1TZAIE1TbwnBLfqwuH4zj+Km/hHQ+v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709392696; x=1709997496;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ix3IutbnK9YYauMdQE56UD9nLiU/cI4vzt+SYzsULQ=;
 b=ksENalo9uyFIbfjvfCPZ5y39RFJw6X/LLGbRNBkzHkSAAn42eW+BfVny2CF7Nqb0s6
 6obogfzKIt4awzabRGp8KO9aqRqCyyigEDSQ0+7Ib7+qVBGLmmt9HlyH9DBe20Hq+LXj
 4zHnROqsZlZEBRav0HihOI5WqDuR4mlcJe9EQE7aax4wccmEz3xCoZ6f9HBJIb/vPYkC
 RHfkPcVbmGGe44sf6GTFafJaBcjNyLQ+AM3yIitWC0/noVNdfaWbsqTOWgkme9HbUmeo
 tSO+YFRJaAM+kUGb/vS7Rr9xcpGi44KXhzQ+hz1HB7USljqJyqEyXMchkGfyb3rH3r3z
 XDrQ==
X-Gm-Message-State: AOJu0YyMJuyHlv1BwjBUlZmvUFowh4ZeYPrwJcGuZGVV+cDu7oCOj5fU
 2JjGVYcYq4AfE4fiA9t1uWLypjtUsQcmHd7cooOJOxyYurskQgWjMB7OlCnEhI4=
X-Google-Smtp-Source: AGHT+IGBuQEAkT/3lfpK3DYBIdkcFEOAITnugXJm0AFk0Wo63tJRdI4q9PEIn5NEXFlhdVq/h7i1jQ==
X-Received: by 2002:a05:6358:8a0:b0:17b:6453:d696 with SMTP id
 m32-20020a05635808a000b0017b6453d696mr4586018rwj.0.1709392696265; 
 Sat, 02 Mar 2024 07:18:16 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 r8-20020a0ccc08000000b0068f6e1c3582sm3008499qvk.146.2024.03.02.07.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 07:18:15 -0800 (PST)
Date: Sat, 2 Mar 2024 10:18:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com,
 Angelo Dureghello <angelo@kernel-space.org>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3] test/py: reset: Add a test for reset command
Message-ID: <20240302151813.GA1652651@bill-the-cat>
References: <4b7c5e82165b009cf8b28701ca3f1e182fbc3c09.1708414720.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ngWwtbdpgIzFy8N6"
Content-Disposition: inline
In-Reply-To: <4b7c5e82165b009cf8b28701ca3f1e182fbc3c09.1708414720.git.love.kumar@amd.com>
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


--ngWwtbdpgIzFy8N6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 01:11:38PM +0530, Love Kumar wrote:

> Add a test for reset commands which performs resetting of CPU, It does
> COLD reset by default and WARM reset with -w option.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
>  - Set bootmode through boardenv if modeboot is not defined
> Changes in v3:
>  - Fix the issue with bad pattern found on console
> ---
>  test/py/tests/test_reset.py | 61 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 test/py/tests/test_reset.py

I had hoped this was all sorted out now, but both this and the saveenv
test cause qemu_m68k to fail now.  See:
https://source.denx.de/u-boot/u-boot/-/jobs/791635

--=20
Tom

--ngWwtbdpgIzFy8N6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXjQzIACgkQFHw5/5Y0
tyzUHQv/XVpY+KxwBAZPxs2VBisI8P62dCPO743NTeX9eIJDotMDE2JkadUkaORR
ENSZ+TWYLhLHWlsVjAjQHMhCSm9oRCFZ0fL2AeL4Rr3VHgMkkFi99op2Li3IIEYY
30gHZfZJoUji4lYqJwmscJ4vj0qlqdcqimP7OlIarjt4hFshbvIpvikIH8DnvcuQ
wKAKGF+uZ7/0IOaYlCoWBuKE48H0x+WMqPdwDSdPOl3Z2IVNnwNUlJ3xIPZvqSUV
P2+0wAcTYWj1drpGJOO5Z8LB4YZ8qvePcKsdnp6yXkMbQP66IoYPZkj6TQ3WeWhX
TcUe8C6FsRujjDJ2WqViH1UqI2DERA9GoFsW0DHgUziKZFxIr/SC0gMFR0UAIkCm
tKcBI2mWOds0HHXTSoQ71wnDG0K8nRnps92Rd9OWRGRSRcR5URwmlod7Et85XtRB
ENIQHLddno/y7fjYVwEXG6vnPVFkUVemfVQSPkgc+KuZBWpbxbyucr0ZkJAQZqvY
fIL5YXMu
=UIEm
-----END PGP SIGNATURE-----

--ngWwtbdpgIzFy8N6--
