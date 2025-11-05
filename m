Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C98CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 23:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A00083B03;
	Thu,  6 Nov 2025 00:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JqTv2q/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD4C783B0B; Thu,  6 Nov 2025 00:10:34 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90BC183AC5
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 00:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3e2fc677775so176113fac.3
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 15:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762384231; x=1762989031; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XfNTJBGmoK4bzZ4+P33BMUbblpQRF3EkBgPuVy5GQvs=;
 b=JqTv2q/wvdHWjcX5KHd5WzhthoS8ej/4Tije1M/5jqCy9Te3F2LrKbVNNbqqq4CZ3h
 QO6JFUTDZYB1OPtBvC24dcZ2E7NAg4bd6T+vQWTxPnrC1kVyay5efAP9M3m8s/XiHm77
 VJMMWjfW2dMnKS0c40AuYwspE471c/LoCW1So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762384231; x=1762989031;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfNTJBGmoK4bzZ4+P33BMUbblpQRF3EkBgPuVy5GQvs=;
 b=oBIdWNTbDIfFuOuSKXqrwyULe6055YMLySv2vWfQm2qk/xgm4HZ29FvAKAwd/JZMgN
 12qM0lmq6GxE+U2t+rNOf9QxK+GMqFdh5vWVlEhoDDBhSkzqOJtf3dGm0EggxpW9tifm
 IgsXEDMd16gt4I6e7vIcufp1B76V+qR7WkKG5O1DxpNV1MKmiyVDBbC+E4ht/FITyn/y
 kgMDO9aOYGxWwVW2U8vcUvvZV+NUwF33tWxTOWySLQyzRXzsaP7ySK2bIXJj0LZm59hQ
 8cUx0gpdsXYE0mbWBpw4JmxfiW+wFBjOp2NImhT5kdDwXbgqKmQrdhLHXgO4X2ddKkbm
 pxDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoqgpmDD/RZ5GlzIPzK+BgXof70gSAFegSjkwegA0rWffVW441gT6C1cIbMp1GedrxVegsfJI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3IV8IUtneHr2nAjHvzDpK7GsJR+iADeu0ZjHRYcwtYqaYXC23
 IFJ75UtCHiF8hn7L8fHeHH80Gp0u0vZHYnI9mJME1SmeDdQkUWzy4eZOU3JINBJfXns=
X-Gm-Gg: ASbGncs34pgFebcicPnP6qZ53ZFGs1BHdn+o4lVc35WJa6xsa8Idugpo8pUpBldyFcs
 kXeDxDME+V6+fZDIaOGlv6ddoT96P4F0PtQAuWy3vp0aMnRKT4lKKGEMrjCPHj/Php0AOXx3D4E
 sPCnNk4lzMBHNkII7LE+kpDj138z80XWsB1tz692SIlB/cBKfW/vhiJndKHphxmRVIe15adQAaO
 /f4XfjPIC7znAZ/N8gnFQ80N9Ji4qFfpum1/bXko/RsOAkVKmbt1b/mC9aXziOB4YutJ96Wh6FL
 VEf7a5t4ACv+5Cqad2/+A9M/Vi0EgRHeQ/RZ0I5dL7nVv8T7AniNr4gk4aWgVo+gQtFnOX4SkGn
 F5btanaleZyUPTqIM3SyDRfXNfJ04re0zThuweNqsg6++JM783Za/0a/PTFWDGMBxLenLHnPoD6
 MOVAItKNbyMLD6dmr0mLID6gjF4V4E58FShJHhrRg=
X-Google-Smtp-Source: AGHT+IHnGGt5mI3/7XsBvZmsHv14YnqKsivXHs11IW0dqHIxn+OSUn7S5llsqhPFmHozZm6PF47hqg==
X-Received: by 2002:a05:6870:3906:b0:3d2:c10b:cb45 with SMTP id
 586e51a60fabf-3e19915e4d4mr2185824fac.9.1762384231315; 
 Wed, 05 Nov 2025 15:10:31 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6e31c8709sm264188a34.1.2025.11.05.15.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 15:10:30 -0800 (PST)
Date: Wed, 5 Nov 2025 17:10:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] configs: CONFIG_CONSOLE_RECORD=y on
 qemu-riscv64_smode_acpi
Message-ID: <20251105231028.GW6688@bill-the-cat>
References: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
 <20251031195931.622513-4-heinrich.schuchardt@canonical.com>
 <CAEUhbmVCkjyPOyYtbABqEQZYeGV5QLwMUkO9xP4obFne7PryQQ@mail.gmail.com>
 <219a1f79-8ae3-4724-bf37-a7c5902aa9fc@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GVpt6cP5gH8RPgC0"
Content-Disposition: inline
In-Reply-To: <219a1f79-8ae3-4724-bf37-a7c5902aa9fc@canonical.com>
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


--GVpt6cP5gH8RPgC0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 12:07:27AM +0100, Heinrich Schuchardt wrote:
> On 11/3/25 12:07, Bin Meng wrote:
> > On Sat, Nov 1, 2025 at 3:59=E2=80=AFAM Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >=20
> > > For testing ACPI on QEMU we need a defconfig that supports acpi comma=
nd
> > > test.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   configs/qemu-riscv64_smode_acpi_defconfig | 1 +
> > >   1 file changed, 1 insertion(+)
> >=20
> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
>=20
> For some tests to pass we need to increase CONFIG_CONSOLE_RECORD_OUT_SIZE.
>=20
> The sandbox uses CONFIG_CONSOLE_RECORD_OUT_SIZE=3D0x6000.

It's worth seeing if we should set a much larger default too, given how
infrequently it's set:
$ ./tools/qconfig.py -f CONFIG_CONSOLE_RECORD_OUT_SIZE
10 matches
corstone1000 sandbox64 sandbox64_lwip sandbox sandbox_flattree sandbox_nocm=
dline sandbox_noinst sandbox_spl sandbox_vpl voyager_spl

--=20
Tom

--GVpt6cP5gH8RPgC0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQvZZAAKCRAr4qD1Cr/k
CuUBAP9bD04xQlXjaK0nKl9ylLsfDmw3YmjEVBES74ZKKcUkWwD/X7Gf6iKFrwsw
uBb9S9zyJtR4ZH3C2NIi+FH3wTpb7Qg=
=/icL
-----END PGP SIGNATURE-----

--GVpt6cP5gH8RPgC0--
