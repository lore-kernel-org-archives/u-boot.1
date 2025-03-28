Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03B3C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FD2781951;
	Fri, 28 Mar 2025 17:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ADCCQC6u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D53B81DCC; Fri, 28 Mar 2025 17:13:29 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA998144A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60288fd4169so319012eaf.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743178405; x=1743783205; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xo3a0sW5/My/tUIz8vkWvT0H+Ad6OKfRLlwPygeRPxs=;
 b=ADCCQC6uN4rbKTXXE4JgOleMuyHi7Hqd435gt+1y22LKHKmIMCzLBDURtPX/zAflcc
 7eZx9AYYlsfBDS7FhSwiVWtWmfFiEApYd46dLVRcPFriIn50+YjQQzgd1KcI6LBbhN42
 fnv4i6VEK4eD4d9xJZwJZwvfipz5z1wslXlO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743178405; x=1743783205;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xo3a0sW5/My/tUIz8vkWvT0H+Ad6OKfRLlwPygeRPxs=;
 b=ikleEdpgtKbgW1w1KThUvsUblivIy5Qf1xz4S25C+X6UguWiqgtlXBOxUNMSoNGVkG
 dmnW+R6e5upErFPc1RublVrcHq4XVkgshY2NsFjBYgFoDWfXxFwD1q3TcdYWloaNSmIk
 JuTZhAnX0t98hXFJu2BNP7SZjWxpMFWBmXNCdrL7U/vPPhQmzA/Q3dRFJ4VkIMSP132N
 qxmV/VLS21N9D4X+gsiJjDsUEehPCfQJTiwDUyx2YBv4pzWXfhKmt/pwLyRy1MVO1WLW
 Vt+rK/jRMMXT/r7Ia8G+ml8WaN+FmEhuTvZxEuYG7YJYVc7rQ/5PBANx0+lON9B6wVTp
 wIAg==
X-Gm-Message-State: AOJu0YzSAWyY5O58nsXAoBPBSQsj0qtsJ0SDGmBSyYHmuTx/pBXSTQHn
 ZfSsI/+IcpOO2Mt2PtYy83iozuS0j6yvH842TfKK2eJcL/aCTEZr7BldcouSnn4=
X-Gm-Gg: ASbGncu1uDuKXI5OLgcfgs/ff3P7BfzyBeV1FSRvdTg9LdKRjrMpoA0NojjUmjCjw9K
 msssneuuvfJm9DloCJC+B5SZYBD1VlE4cCIPxKdJz0UUzy7hB75ZEInCJwUJwqrZw0Do6oMpemG
 YGnNmHcer+EttXYj3aC624VfKU2B2w93ROMHdPm+xCG/tXr4OXVZmeRAtsDNq/iqLWUpVpsBEtW
 j4hn7yufoYuzG5VoLIQC5ASVkL51N01B+xWhB8MThTtxpPzB7YGzpJwYZMvFRUD4ck6qy6MghJF
 WokJpNOBQlNrAjLAATwg9/Jqch1xXD5QRDT/7bgyjTcKi/P3k1GkWDOy5HlMIxGa2RXMR3aKXJk
 MO27hSw==
X-Google-Smtp-Source: AGHT+IEHi1n2hQBORRbfGSjTuSe8jMMxWY7MqXd5RIQcLNAvWau+JTFMJg8Gxi3lymAyn42IQ7K3mg==
X-Received: by 2002:a05:6820:2bc3:b0:602:7989:85a5 with SMTP id
 006d021491bc7-60279898cf8mr3472810eaf.7.1743178405073; 
 Fri, 28 Mar 2025 09:13:25 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60284500a04sm382623eaf.14.2025.03.28.09.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 09:13:24 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:13:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v3 29/31] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
Message-ID: <20250328161322.GA93000@bill-the-cat>
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-30-sjg@chromium.org>
 <CAEfUkUKa-_=zOry+0-EnS=e8tEq7=nooDDt6Yr_M5vx31w+JUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zIdxKZfd7rzD24xm"
Content-Disposition: inline
In-Reply-To: <CAEfUkUKa-_=zOry+0-EnS=e8tEq7=nooDDt6Yr_M5vx31w+JUA@mail.gmail.com>
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


--zIdxKZfd7rzD24xm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 11:50:14AM -0400, Raymond Mao wrote:
> Hi Simon,
>=20
>=20
> On Fri, 28 Mar 2025 at 11:36, Simon Glass <sjg@chromium.org> wrote:
> >
> > The logic of this has become too confusing.
> >
> > The primary issue with the patch is that U-Boot needs to set up a
> > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > phases can then use that bloblist.
> >
> > But the first phase of U-Boot cannot assume that one exists.
> >
> > Reverting this commit seems like a better starting point for getting
> > things working for all use-cases.
> >
> > Note: The work to tidy this up is apparently underway. For this series,
> > a revert is the easiest path.
> >
> > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> >
> > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=3Df5ZKXNniOfV_-vFryq1Gn7Q=
Z5hKU8Wjo8igw@mail.gmail.com/
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
>=20
> Is this same as something we discussed in the thread below?
> https://lore.kernel.org/u-boot/20250205015606.2686149-29-sjg@chromium.org/
>=20
> I am a bit confused since I think we had agreed that it should not be rev=
erted.

Yes, it is extremely frustrating to have posted both this:
https://patchwork.ozlabs.org/project/uboot/list/?series=3D450425&state=3D*
as the first pass at doing what was agreed on the path forward while
also posting this thread which cannot be against either next nor next
with the above applied and so isn't worth anyone elses time. I suspect
this thread also includes various rockchip patches that were requested
to be broken out and posted by themselves instead.

--=20
Tom

--zIdxKZfd7rzD24xm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfmyqIACgkQFHw5/5Y0
tyx3rgwAlTfhBRf8MZEBjB1WdBGYYjvJKgFuoXmEPNA5gYhNna82WrzjNXEQ7WSx
2I6K1hbsf03pG3GWS/V6lwXyaekMb2Fzm/VqmcrDb58vCbAACZJbBKMOMS8wYpOC
pghTiDiCxzlXESZni7n3d1f8RB2DuAzM4qTEY0ix3/2T9Dp8bsxyNU9/+DaCuFT/
+JHanVG3BHJelYFM0q3mLWAxsj9sZBPKE7ci2Rl9K96Iw3pkZVzcCOpZ1Vw8SLg2
0vdEmp7/7VcD6DGuej6GjU+6NngfuwruroNkhNaKEcJEoWOPjwmd4U6Y3hzlrPpD
3/imWG7HGN/MWZiLArpfiFwU6SEXqh13IUG+BvIZ2BtzWxgQ4nlZsx5mGrjKtWIr
gh5Nqwo8miL6UAOEShwc4TIPeWCgNR4b+9qRLmruvGbCpMF2iNSNZz0OTgYFq2OY
TCBar4l78gN3Vc3ifMEJ+58ok2YUIv6iEEP/VGOpvDm+1GphWh0vH46Fr9WAQCNq
/tErBckz
=+y4q
-----END PGP SIGNATURE-----

--zIdxKZfd7rzD24xm--
