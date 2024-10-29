Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF11D3A672
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 16:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A865188DC6;
	Tue, 29 Oct 2024 17:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bM72qeuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E316F8917E; Tue, 29 Oct 2024 17:37:17 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B278857C
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 17:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cbd1ae26a6so29096056d6.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730219834; x=1730824634; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NbSTo1jFtiFetKW8pOzeVlm4WwD1Oxv8NudTPePuCd4=;
 b=bM72qeuX6qdM/KdkuWyKZmu5mQcsLztNf/4bEOfxthVfVX9fyJYsV1NGRjqWzSq5Es
 wZjgTqMwITgq/K5AJHZSLkt73v/YzHGGBAG3IbRQfs0rE7hLuDyUjQLLhvOP3cRLBqEq
 uTGvcbM7beLjZzS8c3lOGfVX+usxTZTZYEUqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730219834; x=1730824634;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NbSTo1jFtiFetKW8pOzeVlm4WwD1Oxv8NudTPePuCd4=;
 b=q98VR+Jbl9kXIh1UKSGvBDx06R/qLV0i1nI3ColPWl1dU1HJKUZmAF7tOxflbXgz3v
 0+S/E42DQSaC0E/Fkb5Rsu+so3TtUXEIlL25HyCLbE1ljsZbSQ7323dBKNEO2BJg5l6X
 gjVr01tYN4oYgDJL7gKXOnua6B2liVuTqyNpdaZjvpWgpFR9G1xfJU+2YkiWmYSgRkAH
 4C9yqKEqjJFnWAP7s+9i5TyMbkTNCFfrQO0RE/zFsQg6cZltmStBpWNs7UhV3TaM4wFC
 hjt7rihVXeRxCDbWNGaCPYGU1peVgPARSWaUngryob6Nw9MVUec7r45+/klNe6au2opn
 dnIw==
X-Gm-Message-State: AOJu0Yxf9iM9T0IqmAr3zf3saMix11C+RpOqJztVDMjNvP7VmZoWLPOt
 VnVzAFDhQ7nm1ugwfJ5uDz5JCKCoHPw5Sx6BAgUPfRr3jXKSa9F0xwmbcKy1D+ZeWmcFKdB/B+X
 GFwI=
X-Google-Smtp-Source: AGHT+IEU+HBpor52xyQoC7KJGkMeTKl9nyUSZ15cHJJq6wJOl7wGVJaAMWGW2oCWr5V+E3vO4MJxIA==
X-Received: by 2002:a05:6214:3103:b0:6cb:f2d9:80c2 with SMTP id
 6a1803df08f44-6d185860f81mr178987506d6.52.1730219834412; 
 Tue, 29 Oct 2024 09:37:14 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1798b764bsm43321106d6.44.2024.10.29.09.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 09:37:14 -0700 (PDT)
Date: Tue, 29 Oct 2024 10:37:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20241029163711.GB4959@bill-the-cat>
References: <ZyDWMoaC8lSs8QZF@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PGbCCLCaSpn/cLNt"
Content-Disposition: inline
In-Reply-To: <ZyDWMoaC8lSs8QZF@swlinux02>
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


--PGbCCLCaSpn/cLNt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 08:33:54PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit bfdfc6c12e8ca68fff1a7ed3892c180143a6a0=
ef:
>=20
>   Revert "acpi_table: Fix coverity defect in acpi_write_spcr" (2024-10-28=
 20:53:34 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to 239e4705099c7516f3d3cf958f3e540d635a4ed3:
>=20
>   riscv: dts: mpfs: migrate to OF_UPSTREAM (2024-10-29 19:58:22 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/23080
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--PGbCCLCaSpn/cLNt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchDzcACgkQFHw5/5Y0
tywDoAv+KQ0OHvmw36Lvpo7PW5jfH9LcsUdKxb45wXpxBhWoUf4Iz8T/OSYk+q/b
LiRd5ucXwSGoG9FJw4UgmsE55IchK8NkDB3Hae6P+1L9Tgs3Cuyc1yNZ6T5/JbxV
oSkTb2g+9mPBLYRz1yESGfPSFO7oF5BsRRqe4LemPlbGQWYZB5agaedpGQLD57oD
/Yrg8qvc0ORQ2zPRWN3z5dXUSAzl1oANRZEEWa+XfUmqHiUQo7tsS9eglvVPtLeQ
EGXS/udFrU+EQFE/YY6zI3F0FmnTeiRWQbP8nqAX7gjxV+XU5gz0jZT7Tp/b4Khs
U/uYb0Iazn/wgdD5Ydb2UKBJhT25aRFqQhr34Qi35bzhSpDZ1vR2CbOLMfk8zHh9
FM/XDB056g9RgZxzM21jbQjUARvQZLXGwrqz5O6px+z7UX1fB5VnvbQaDXDl4T10
XXcTXa83ZUmVnldOX+XWgAg+myNY7/AgGnl7v5I2o0XfhVA8tbBPzFwnPPnZRTMd
rLxVQAIR
=EBng
-----END PGP SIGNATURE-----

--PGbCCLCaSpn/cLNt--
