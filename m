Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83CBCD5BCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 15:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E95986517;
	Tue, 19 Sep 2023 17:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kkNuYaCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7503D86548; Tue, 19 Sep 2023 17:14:28 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B042864A7
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 17:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-59e6ebdf949so43000067b3.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695136465; x=1695741265; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l1HsFPWwZB0+DuJM3+FvQfNbvJszcgg8H4sKpoIGg80=;
 b=kkNuYaCRrgUGcpUbpEZKHz5kIVbxxg3P4u0/8pDfJjZ3dQOp3TV7XI+YUsOVnFRSFc
 0onCi68jrKmmgmsyao2hSYGwr4eozFSQ8IEoF1k7dgVrByfxv04JYcVSj+oVPH6LtSfI
 YNKUO/v9HsEAiQW/v26IiU6RVlHdVvbJqGG8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695136465; x=1695741265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1HsFPWwZB0+DuJM3+FvQfNbvJszcgg8H4sKpoIGg80=;
 b=LJgM4sRBG1EHrmUJTTzRlbQPyAXKHBbVQNNSpqej0UErccGCHrW1ae3/ktRUeGP6FY
 f0t3HWC6rXUixYYvvIRbSsqFAb99DQcu0SRvddkOeiAbFYJ9YSq8KnP8u3vqZ6VRSu0j
 sXGtewjewoinKvHmD2obhBKHurNfDagrgBNeex+KfB89hpB2o39rZDKz2i//H4cuzhum
 pY84HTYw3TVM4161X7N54F1OVsBrBEor/5zVZmPuRHkLNwSmKellcvKbA76bI/SEWYWS
 ktYH0Ohp4cJE1P5A681R3xMfnrtinwYKYtTIRweG53slt2Z7hMwPkTE1g2YKuKCcWUJQ
 AQbA==
X-Gm-Message-State: AOJu0Yzv/WvsyAdE15P4+o68Wnj9Qh/u1otqHzhEF4TXepJnb1aOdcrm
 JvON6eebcSsWAMX/a1i5UHf7Xg==
X-Google-Smtp-Source: AGHT+IEkr54MiFJiVptXa1YYqfsbroDS3MxfMrLetBwsM6eiPfxtIM6mtwU/0Ywff2iIkQ9fE1nM9A==
X-Received: by 2002:a81:840a:0:b0:59b:6f83:e564 with SMTP id
 u10-20020a81840a000000b0059b6f83e564mr3339817ywf.4.1695136465105; 
 Tue, 19 Sep 2023 08:14:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-715d-a992-91e3-9182.res6.spectrum.com.
 [2603:6081:7b00:6400:715d:a992:91e3:9182])
 by smtp.gmail.com with ESMTPSA id
 c80-20020a814e53000000b0057399b3bd26sm3244874ywb.33.2023.09.19.08.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 08:14:24 -0700 (PDT)
Date: Tue, 19 Sep 2023 11:14:22 -0400
From: Tom Rini <trini@konsulko.com>
To: Trevor Woerner <twoerner@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Michal Suchanek <msuchanek@suse.de>
Subject: Re: [PATCH] am33xx: ignore return value from usb_ether_init()
Message-ID: <20230919151422.GF305624@bill-the-cat>
References: <20230831024951.22599-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UERYmTXRlbqFyPOX"
Content-Disposition: inline
In-Reply-To: <20230831024951.22599-1-twoerner@gmail.com>
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


--UERYmTXRlbqFyPOX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 10:49:50PM -0400, Trevor Woerner wrote:

> In 2cb43ef1c223 ("usb: ether: Fix error handling in usb_ether_init") the =
error
> handling of usb_ether_init() was changed. Not a single other call site of=
 this
> function checks its return value, therefore follow suit in the am33xx cod=
e.
>=20
> Do not cause the boot to halt if the usb gadget ethernet initialization f=
ails:
>=20
> 	initcall sequence 9ffdbd84 failed at call 808024b9 (err=3D-19)
> 	### ERROR ### Please RESET the board ###
>=20
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> Reviewed-by: Michal Such=E1nek <msuchanek@suse.de>

Applied to u-boot/next, thanks!

--=20
Tom

--UERYmTXRlbqFyPOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUJussACgkQFHw5/5Y0
tyzEcQwAjigyh4IF0LBnOeIj8EmZUBr50gCzm/fvhHApar/9sc2VQdwDPjCru35O
2hzXUp6mIDPiwx6AnVJJlxJ52pU0T0lhyA5TmF+HV2k+ZmdUYJT9xF0KrCAcMFr+
D1XJS7UZ9Nz91/XtP5220fEno59pmhazLAacNeePeWqaS1i6oWEvxqF6AqTKaHc4
rzieM22WTW4q8HrBSLcWWdGHzzOSc6MUgKKMJHKiW0k5sbgYPOnFhkR0vyXMZCh5
/TG/jeGXrct4WAE4G2YuR30lU1WvDHzlaLqg9Vi0RCtMJjzky/NsqN9Li9YltCLL
kRJJeWe7k3J+CStAcFUKGoN1YqBYr8OlzsY3bxzF2UgExEv7CyGNc0lMWJsMLwPZ
4va6vat++5Bss6BzjccIziAobtiYe5Oo9bcbNPlcSgd7YKBBfiLajw6YMgX4xyyL
rvDvYAyayPZNAoNI6xIvWzK2Vn/4drZI5DHvCbw20kuWwdj4Q3dSLl8pW09pURwY
U9AqcaUQ
=muqN
-----END PGP SIGNATURE-----

--UERYmTXRlbqFyPOX--
