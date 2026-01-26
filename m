Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBADAD19519
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 20:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8B0A83EEF;
	Mon, 26 Jan 2026 21:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LNl+Ojek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD6FB83D9C; Mon, 26 Jan 2026 21:45:55 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B053783015
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 21:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7cfdf7e7d19so4337248a34.2
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 12:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769460351; x=1770065151; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UpxkDRa5bPRK+7k0ROpvSK2oCmvtUTbqkR07ocXGaeg=;
 b=LNl+OjekasnUzzL5rrfCYRLDLFb2X1LYEURFnN2yQ9A3QtRsTR/5C18tTHYmxazuP/
 qzx9Za5/FCp8qrC7wXAClJVhRSsfkgxij9zn3N3t9zyZi7FnBWjGOFv0HERLo5R9C3/A
 DZzJfYDwoPPSlZqwcRhcBCFLxA9OB+X6hB9Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769460351; x=1770065151;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UpxkDRa5bPRK+7k0ROpvSK2oCmvtUTbqkR07ocXGaeg=;
 b=JdXza2ja3LhyEGmSGH5wXMDW/lDP7huZ+mmZOeFrzeuf0FwklLVPijE62mq8xLiI41
 1JtHw0tEddpEqTe3iJugUChWfrx5is4YCbKVs42PPJ7soddvHatUgqYYZtD+MRGJSUSE
 jdrh1sfJ6lTOnFwUvYjGP/R1npJz7nJ7N+BBWWmetqawvRwITrmU3QB9yVEok5c8XwHr
 lEWSYNOUmkEztwvfdBbrzoBCn+x9rd+YJbm0vsss3BJTRvq8mp2xmPvJsQZLPQaYH6Ia
 9aedzamzxMApMnbfTFHrKCNIwnW0J9YdFpXFzbBiYd17NK66J3SuAAqDy2xotnXwCSZC
 PUlA==
X-Gm-Message-State: AOJu0YzYLRScu3xwKj6ZwsQD6hadnv2ZWy+KQLOFXwoWmNibeSBwoFfL
 NEGydwGyIzO0g3t6tC/hdc/nFt4FKco4qcuo/yQTwzBYcjWYmEErMTtAVudPQJlO40q2OtTSb5J
 mbG1s1Sw=
X-Gm-Gg: AZuq6aKBFtywBx4sgB4FQFP/dYtEpGj80/ky/HFsLatEGqvLH0GtsouggbkJ0ucSTqE
 y5qzSg/341fBb7wGU8NsiCRmlDzGy0aFZqI0F3a1rnMq8HdWvAH6+JihLnwIi500/cVpcSgEtpC
 73zytlBpczA7Ijw0fMzygd7eUrv7mOEXiDqAocIq2GAQT4C+d4+42075eIVedJJ0sUsNQTB5D3g
 MTpmVS7D+CiQGts0GluWS62WkrLOMSV5WpmiF+l8NRUHyr8ltgLPqWMMmqDGOqAPuuu15o6khb4
 CL4nBRRzypQL7cUAI8+7r3Quaz+6Pdc1tF1UWGkgi7LtvcuCIos9DGfMI+2ulq56NzrIeApONDS
 Z8sWGLzah7pzIsAWmElIQG2xt4YRDpDhie/1lUjsFhmA0noZdXzzkVPkJkCJaPgEqkywDIlaZpF
 y6Ko8b8Xq74BZLT4Suvzt3tLFF4nVwRQrraTi4BdTtFVlXQhkFSqsadTgX7noe9/u/X/Rw2hWIg
 B+icOAHoK9UNPn+Uk5tf5S6OlNdCM4MbVjCWwDwnzLN71orRw==
X-Received: by 2002:a05:6830:6c0f:b0:7cf:d0f4:125c with SMTP id
 46e09a7af769-7d1701b5232mr3805540a34.8.1769460351351; 
 Mon, 26 Jan 2026 12:45:51 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d15b346df8sm8783113a34.6.2026.01.26.12.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 12:45:50 -0800 (PST)
Date: Mon, 26 Jan 2026 14:45:48 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.04-rc1 released
Message-ID: <20260126204548.GX3416603@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AEB8eR7lhq+PZZw1"
Content-Disposition: inline
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


--AEB8eR7lhq+PZZw1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out.

First and foremost, this is a bit rougher than I would like but I hope
that doing the release will underscore the urgency of finishing some of
these fixes. We now require for our own use to be given a correctly (8
byte) aligned device tree. This is done in a lot of cases. However:
https://patchwork.ozlabs.org/project/uboot/patch/20260122172247.2995437-1-b=
-padhi@ti.com/#3640858
is needed to ensure that platforms that use a FIT image in the SPL phase
work.
https://patchwork.ozlabs.org/project/uboot/patch/20260120153314.95091-2-jam=
ie.gibbons@microchip.com/
needs to be addressed further to fix the case of platforms which apply
overlays in FIT images (SPL or OS). This series also shows that if your
platform does not boot then SPL_MALLOC_F_LEN may be too small.
https://lore.kernel.org/u-boot/20260123161907.392211-1-festevam@gmail.com/
contains some of the discussion around the case of SPL *not* enabling
SPL_BSS_SEPARATE and so having an incorrectly sized empty BSS appeneded
to the image.

So, that's the important state of things right now. Some platforms are
broken. People helping to test the proposed fixes, or if needed, picking
up the changes and posting the next version of them, would be
appreciated.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMHYzYz=
Q1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/btj-wgcg-euw
January 26th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

In terms of a rough changelog:
- We're on v6.17-dts for upstream device trees/bindings. The v6.18-dts
  tag will be too late for our release cycle so I expect people to be
  using the cherry-pick method to bring in dts changes as needed.
- Lots of platform updates. This is always the case with -rc1 and I
  never know which ones to emphasize.
  - That said, we've removed ATAGS support from some platforms as it's
    very legacy these days.
- Lots of fixing of issues reported by Smatch.
- We now support clang-format and prefer that over the old
  scripts/Lindent option for formatting code.
- Continued work on improving our old pre-rST docs and converting them
  to rST.
- Fixes in our DFU, MMC, PMIC, USB, UBI, SCMI, UEFI and networking
  subsystems.
- Some cleanups and improvements to Falcon mode, with the aim of being
  able to support this feature in secure boot contexts.
- More patches required for "allyesconfig" to build have been merged,
  but some are still outstanding.

I continue to plan to do an rc release every two weeks and the final
release will be 05 January 2026.

Thanks all!

--=20
Tom

--AEB8eR7lhq+PZZw1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXfSfAAKCRAr4qD1Cr/k
Cp5IAQD5b2+mVkRwogXdW4KFYEj6qYd/GQlSw3LebYagX4tSJgEAxN1gt4n4yUkF
QLj3kz2FSxywQUcnhjp6OQW3sZPutgY=
=qTEW
-----END PGP SIGNATURE-----

--AEB8eR7lhq+PZZw1--
