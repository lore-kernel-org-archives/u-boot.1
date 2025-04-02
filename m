Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56F6C36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 21:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF26681F0B;
	Wed,  2 Apr 2025 23:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sK42xpII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 462C081F44; Wed,  2 Apr 2025 23:11:08 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8124A81E6C
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 23:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c13802133so80049a34.3
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 14:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743628264; x=1744233064; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=92Qw4oWi5bJMUH9FzB8E+rtlBO9HJ5At1dnMUpIpJjU=;
 b=sK42xpIIOIFUrshqR/Zw7e2xJwspAVmPe+ENPgjJXkDfW9DcKh1304AemEnFQ8S/DB
 Q3gctXex10TrjzDBz2eQxqjxVJuAXsJ5kUEQn17tIHT/ex3J3TT1PWDJOLEnRxUd0N4t
 w5xeevRvcCq+Ry8pKfcuZ8EkoGFRC0SDoT904=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743628264; x=1744233064;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=92Qw4oWi5bJMUH9FzB8E+rtlBO9HJ5At1dnMUpIpJjU=;
 b=ZAeH9+4badWIsSMa1eLCj5DmW4mLBdpwS4XFnfzVEnqawULsjPzkWLu/GXJy/O2Sq8
 x4VdvGdJNDMPCjQ1XC1EeV8DhEn/NqK0IFNWU98lj5I26+n1lYCZ5Z2JgSx3pasTF7hu
 7D1yKDOnz8qZFl46DIg7VC2U7WjM6CN/jQnQxWK1JU1ZYzj+2TZlvmWEaryEe5q3Qzv2
 deOAa51QUePPrbq94ZKgJt0/5ibaDgrTr5rEnQN3r7O1Yr9Vp0gj2BaeBGMwSgEKbo5Y
 lwVjGt+eNO3XS/+GRs2SvEazFN8Uh8pdVvjiJWZdylEL17SKJGsusyAzzUOe4ZC2o7Hu
 xxMg==
X-Gm-Message-State: AOJu0Yws0oXNi2oUeXpvWKe/QYQoVxeHI5KvYlXEg1VMajVcBkm/ye0T
 hzhdOzt89UBNwQEI8yGTRtciU1t5igNqFZGUh/ypxL+LenoIPihsfZIUQ7nDPUE=
X-Gm-Gg: ASbGnctfotM2xva8AsjK2h/9mpODk618SFNe3LBs6M+AIvk76fGWI+wCAl1hFuInspK
 eZFhmQHyrYaKeGHdAv27XLOobpZSwJq7L97I8gEgQjgJWbz4Eg2zu+oVS5OCFcY29FdbzBATxKx
 GIurLgIv485fKs8/z64Y0+iXttX4nGMjZrBefAdUHnPXO1IEwsPPwwCZbbp+MtioDLg7YbBxDgY
 QXuiOr5YjF5SJABNjBGlHiMPQcrtFimgFLOL1qGWA4wWa+mSTCL/y3IliCeoyibaJvxis5LvhN6
 c+bE8YM3vkPmUC8YNlb53ksBSS6AJJMp7teimG3oXW2y7wU/wsReVk7bMFLBmZUv5p+1EPxw9Su
 0Z6JSxA==
X-Google-Smtp-Source: AGHT+IE20+K11bE0lV4onJPXEV+qBg1CtCOdX8/ItljA3D2bD5W9T2o/16hKS+fXUCkewpjWW1itPw==
X-Received: by 2002:a05:6830:660a:b0:72b:93df:9213 with SMTP id
 46e09a7af769-72e2ee74fdamr332399a34.10.1743628264057; 
 Wed, 02 Apr 2025 14:11:04 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-602844e5b91sm2352049eaf.8.2025.04.02.14.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 14:11:03 -0700 (PDT)
Date: Wed, 2 Apr 2025 15:11:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 00/13] video: Enhancements related to truetype and console
Message-ID: <20250402211100.GD5495@bill-the-cat>
References: <20250401172948.1236000-1-sjg@chromium.org>
 <20250401214113.GP5495@bill-the-cat>
 <CAFLszTjJuY9pQDerNuFcmkRuZbJU+EfPSBTrDyhjFMZg+usPnA@mail.gmail.com>
 <20250402150024.GU5495@bill-the-cat>
 <CAFLszTh-N2PSKPV_OHa63mEi1ar6Y9+p+A4UTfTbf329wOiN9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ly0m2ZgN0mW+TKDH"
Content-Disposition: inline
In-Reply-To: <CAFLszTh-N2PSKPV_OHa63mEi1ar6Y9+p+A4UTfTbf329wOiN9w@mail.gmail.com>
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


--Ly0m2ZgN0mW+TKDH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2025 at 08:19:03AM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 3 Apr 2025 at 04:00, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Apr 02, 2025 at 01:08:56PM +1300, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 2 Apr 2025 at 10:41, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Apr 02, 2025 at 06:29:31AM +1300, Simon Glass wrote:
> > > >
> > > > > This series includes some precursor patches needed for forthcomin=
g expo
> > > > > enhancements.
> > > > >
> > > > > - truetype support for multiple lines
> > > > > - make white-on-black a runtime option
> > > > > - support drawing a rectangle
> > > > >
> > > > > This series was split out from schd2
> > > > [snip]
> > > > > base-commit: 3f76d803db9b500f43bc534465945a8d2836bb3e
> > > > > branch: schg
> > > >
> > > > I get as far as patch 4 before it doesn't apply to -next.
> > >
> > > Your tree is missing the video-damage series which adds some more
> > > tests. It is here if you want to pick it up:
> > >
> > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D369663&stat=
e=3D*
> > >
> > > I can rebase and send a PR if you prefer.
> >
> > Reading the cover letter again, that doesn't seem ready to merge either.
>=20
> It seems OK to me. What are your concerns?

The cover letter read to me like it should be further reworked to
address some of the problems it still has / exposed. That's likely why I
marked it as Changes Requested a year and a half ago.

--=20
Tom

--Ly0m2ZgN0mW+TKDH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmftp+AACgkQFHw5/5Y0
tyy1YAv9Fh5PLtSzvkZyWKYbAZMSibrTduoBDH1Hac5pqP4GpGeR5Nrfc5FRC6os
qLX2DD3+9Fgq4Gb+a9QSfWhMcUJ8QjEOYdAQnivkxJo81Y31WXgwbXYZePqBNVCN
omF8LlgkG+adrvEC2fVZQ7SSyBERPNG7SqTp2CAGCJoNlcebT4eNQL5IbdbaMW3X
CGHTdybuwVN6sqbZKu7TzIUQfMbNPSzEIYpazzTkC6ReNmadkPziW8g8wqDCxFiN
sw1YEXkIj936Y7H11oqgmO5mv6e3Ac6YG37awSIk8G5ZgBRNxCaqDwwbCD1S6RHJ
qgkXxDmrUUfI3tVn9AA1bKBBKYn/Yz/uFNtjijMUtLFEkAIpxIKyyB2N0RistnkN
SlhjhBoJwqQpQUHj9t4X02AEfmIa9JdfXr6daTpF6jURENlA8Ims/q00DDa9+7AY
996VyNeU5v3FUP0P44W2MJldfdUTLkj247p4T07yplzAy1WdUUjcOCYFUrVAJzuE
QdVUqiCG
=kb4e
-----END PGP SIGNATURE-----

--Ly0m2ZgN0mW+TKDH--
