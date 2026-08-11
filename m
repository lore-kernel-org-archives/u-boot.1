Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF918C5B572
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 16:34:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F25640816;
	Tue, 11 Aug 2026 16:34:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Nb_jv09cbfy; Tue, 11 Aug 2026 16:34:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B6D34081E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786466060;
	bh=EAh7fnb8RakZ8Ps6WTY7OSTaeYe+kawBR89JDn5H/6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D6RlC0vm/BqHUDGmLcsUuhQyuXzoJwjHf5UYVtDIAprBMd7XpqDjbOvH/uBCoUN0W
	 JM0iUUhQgIySp971TcQ2XEUK/KPD0mwLKfF0gGPpLBa9JaI6927HoFprt3xsSm0YnT
	 1lIdJoLxy+JhtwAbSm+gjyLYXz3HmNRogKsI09Qo8+4kedXaZw/bsunn2bPcLn2rfX
	 BQmLy1q2YbFvM+FABYP69Fs7dDl1yn2Zm0LxMykfGyJx8Keyx7f0NZleqW2ka4FJ/c
	 42lICYoD/XkkJh/3//WiSGRMjGStKvYvWcnFC4OrqraDtZZsOmmcyhTIyO0O+Ju0Md
	 RnuAOV5W4l9pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B6D34081E;
	Tue, 11 Aug 2026 16:34:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 06FDD259
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E15F0606E9
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:34:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5wqYXoxqdW0n for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 16:34:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E8E34605E1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8E34605E1
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E8E34605E1
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:34:17 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-43b7e186a0cso1026405fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 09:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786466057; x=1787070857;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EAh7fnb8RakZ8Ps6WTY7OSTaeYe+kawBR89JDn5H/6A=;
 b=tSU53TIRlRSFdCHqQNBZpEq4HKFevhDZHU/VCOELy1dz2YZeDLzE8xz7IARyypfhhP
 UgD+DA0hShDpQToS/DrrulNwMdFDbXqPZfMHjjaODq5fKDUPy0Yu1GFcJM54Hi+t/PBt
 9gjneGeqKS9yQzDzTZON6pA7ZMfjl8Z5lf8GeTk+sL+WiL+lOcXeiaIcjHfVu3YtA7nE
 uRPi0Io5PIk0qd3+OmXr+TwnNY5uvmVR/jySE7KaS0ZzeDJaPlVMEfBNj8I7peHLn8SR
 FLG3vTXWdMsRq5Yg0R13mdc+hSvjyzHu+fyvUlRmCFSgHKsk74fC7znt6e8yBRUx2xpz
 UvRQ==
X-Gm-Message-State: AOJu0YwPifVeshs7ZjLxwG8XkRJ9SPZmc+2x035HSZqMtxHRjnJ2J2Gn
 VI27COSqgZnSW4up9dyfPxPhFGBPHrqJNw9RfPoWjYxKp/QiZqkO3vbH+H1zw4T150s=
X-Gm-Gg: AR+sD13s19BWufBxIOFJutZg0Sgt0FNt3EEvlV9ITaygfiFUPJagZ8uZhrIrQvvE12V
 LG3dDuzgSvfvr9s1HGoY3HIB0oZwNCu19UcmWt5E3Sh+nMiAKz9CjtGZMG+nI1ptqWrnLlKQB6f
 QYR6mk5zccHJk90QfUSrn8cVgCAZougdCOfDye89k1qW00rCIPzpHnVyVgjTVn5GnpgWZ7SFqdH
 w1xL1Ys4BZ4MM5iZ7vWxh9IIm8PdO7SnBkR71O3HAevPidYXoNhM9YJhn/lteeMk1/2rQikXb3L
 QcQCVc7agWPIr7Xh8LralKpF+p2w0nyhDiMfarXyR/hNmqPssqcBPCHzRRKPHwHot6b9+ydlTMH
 xAz2FPgyRv3xK5HC/cB4NAbFf/VQKvHoXHIYg8c1evbG4VbIMGK8PqmdoDTjqKG+cAbHBAmjL9a
 FnczuLPnk+cy0Oh4W6/r3kFECxytNanzs57jdv0/UADtrdFSdF14rwmcGKFYsxNg4/DsCjhdEEi
 kXaNH47M6Z4QvY4/ue1bDI9FuWwBRC5LUxpjb2Pp1wiUgJXoVbzwAUC8Sw/7YLkSpnwIiDpOqxJ
 gGxPgn+X2g==
X-Received: by 2002:a05:6870:d888:b0:457:4470:96e2 with SMTP id
 586e51a60fabf-45e2152d73fmr3115203fac.12.1786466056733; 
 Tue, 11 Aug 2026 09:34:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45e355a487esm40143fac.12.2026.08.11.09.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 09:34:15 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:34:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Vitalii Skorkin <nikroks@mainlining.org>
Subject: Re: [PULL] Please pull qcom-next
Message-ID: <20260811163413.GI1160436@bill-the-cat>
References: <20260811122549.2586034-2-casey.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JwFpFJdbRQwyEFio"
Content-Disposition: inline
In-Reply-To: <20260811122549.2586034-2-casey.connolly@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786466057; x=1787070857;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EAh7fnb8RakZ8Ps6WTY7OSTaeYe+kawBR89JDn5H/6A=;
 b=NMOu0ZksdaSFJ3tWqRnHy8FymkYJOZTO7whRM07XqKVPMwj8MmS8701vRp9W2czT9H
 UocVZ77hy1fWQXidNS3KKXDtG+WKBEzO1yUDVHLsf3vb8J5QgCClKVqmIPyp7kriY/63
 K5OtWIc0NwrhnA3nWj2Xc+8bh/ALiaZ7S8K+o=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NMOu0Zks
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--JwFpFJdbRQwyEFio
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 02:18:48PM +0200, Casey Connolly wrote:

> Hi Tom,
>=20
> These changes for 2026.10.
>=20
> * Support for building mbn files during the build with the new mkmbn
>   tool
> * Remove UCLASS_SMEM and the old smem driver (Qualcomm was the only
>   user of both), replace it with a port of the Linux SMEM driver.
> * Refactor memory map parsing and support reading the memory layout from =
the SMEM database
> * Set the serial# from SMEM
> * Introduce initial support for SPL in mach-snapdragon
> * Add a defconfig for sm8650 with U-Boot as the primary bootloader
> * Workaround an MMC issue by limiting the transfer size
> * Add support for SM7125/SC7180 (clock/pinctrl drivers and UFS phy)
> * Add support for the QCS6490 powered Rubik Pi 3 board and document it
>=20
> Thanks,
>=20
> The following changes since commit baa64b2f892890f00a377eac4a3e685472bb56=
b5:
>=20
>   Merge tag 'efi-2026-10-rc2-2' of https://git.u-boot-project.org/u-boot/=
custodians/u-boot-efi (2026-07-31 08:55:30 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-snapdragon.git =
qcom-next
>=20
> for you to fetch changes up to 914dd2f5d18a3a89e4ddb6d1d97b2743618ae5ee:
>=20
>   CI: add Qualcomm requirements.txt for world build (2026-08-10 14:49:42 =
+0200)

The syntax is wrong for Azure (which I thought I looked for, but
missed). The world builds all fail with (roughly):
$ pip install -r tools/binman/requirements.txt -r tools/buildman/requiremen=
ts.txt -r board/qualcomm/requirements.txt
=2E.. success ..
$ setuptools
/__w/_temp/bb9f7c2c-5e2a-4697-aceb-b7e045c9cc89.sh: line 8: setuptools: com=
mand not found

Because the line continuation is wrong and we need a '\' at the end of
one line. I've fixed this up myself, rather than make you re-spin.

--=20
Tom

--JwFpFJdbRQwyEFio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCantO/gAKCRAr4qD1Cr/k
CtrpAQDY+GY2tCdBTiqcxIcsitML+DFscA8kAXXVu+4s3qzU3wD/W6qBgYNKp09C
9pbudjEvB/rw4kYfmQPtDngQjooPEAw=
=J8Se
-----END PGP SIGNATURE-----

--JwFpFJdbRQwyEFio--
