Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9711C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 14:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78FE6803DF;
	Thu,  5 Jun 2025 16:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nOI15Cju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 108328091A; Thu,  5 Jun 2025 16:23:29 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AF6B80050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 16:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7311a8bb581so734172a34.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749133405; x=1749738205; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=raf80TqDn6juA4bED3MMs8OpbAvpNnMY95vJslK2HvU=;
 b=nOI15CjuNCnBvdkO2yepZgf2ZN8oFUUFMkt5600rzMKN9oXDJY09onYEwBJCvdM1kD
 RMcgGxSaF5Hnki/ndeBMVEdwQ4TVWm7ZnTrRaWlbFdlovGKR5jv/fAUIl6HyUwVdYFKd
 eHQ0toqiOkQ/rwjEskuZKPpqpDSouTq5Ee1qM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749133405; x=1749738205;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=raf80TqDn6juA4bED3MMs8OpbAvpNnMY95vJslK2HvU=;
 b=OnH7ZkGOp4/2nHBB9fXHNX2dngP071BVmr0SwHEDWU82Hyn2ptmoMgrU6DXCQJoGcY
 ekjLX6GefuoVzHAhvdb3Y73LHCIs9OQ/WEsc28bLfBgIaZs4Gz/jpkKCimcUZUf/FdeA
 NUloJK+mto6Sazq2kmIXCC8gjESQMCAhFOb0qH/o8yml2zmS8DVylQ6PHL1hpv8TqBMz
 e633EXAyJHEtR5h+di/T5+RIDq4CQig8BnHumK9nZKT+xgmqkIXzQY6yOh7LDH9nWArJ
 Ts+ORmfPQ5I5n1/YkycSINzKTaCFo9oidtscR21bWvoouA6lg4blubavlS5PA/6aPB+B
 flBA==
X-Gm-Message-State: AOJu0Yw9zVStPASr6HI1u2GR2sraMtUiOq0w85YEeKKP6u0f3RjL2Jcl
 nw17jREhfZsNtq4QioR/2QRkxNZi4j6183w53cQP7H3moJ8dspFOKxLbZ8uq3whyI6A=
X-Gm-Gg: ASbGncvoDqauS6oSH/YJiBWLjZjeaKjFO1y0+idbYmp/3xYvX1s49eormbptN6rpf4e
 6S729dK+6oaGUfyZDJt3NJQy/pSc4D3cUsrOnUgyfJ/+Dc0I5XTyeAnd+4jfCvWLC4O/SqUgMe4
 6B49L0DJ2zbgAWL6Y9WZFRqmtURuhnfMSlNYzTa8l6wCGsEnPg+o3E7aYeSuvEHiHK+u9ls51k+
 0m3kTH7/HOwwEar+giEIVlfcywEuZi3b7L57GFY+vrE6ous5juGGAlgzp1QKVInLhr5jxRt+AgK
 s7bXVMfCLxIDhNp1oMrWCe4FThScuUdb2fhuN4kGJXrrPWKwpG1KAnmjzmse3V64M3HBCUTGNK/
 C+ccGUEs4vSGVUBLbixis24g=
X-Google-Smtp-Source: AGHT+IHrEiTqI/C6CXD50sB+dem8QfIunXR2WR+das7W+32w2skndesNKJgH4LAmIODYNPA88QSh3A==
X-Received: by 2002:a05:6830:f8d:b0:72b:992b:e50 with SMTP id
 46e09a7af769-73869dea6e7mr7327179a34.21.1749133405334; 
 Thu, 05 Jun 2025 07:23:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af9f2d4dsm2599623a34.66.2025.06.05.07.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 07:23:24 -0700 (PDT)
Date: Thu, 5 Jun 2025 08:23:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 uboot-snps-arc@synopsys.com
Subject: Re: [PATCH 00/12] drop volatile from global data
Message-ID: <20250605142322.GW1382132@bill-the-cat>
References: <20250604195612.2312979-1-ravi@prevas.dk>
 <20250604200702.GS1382132@bill-the-cat> <87msan1bqd.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h2xcrK68/upFtbbg"
Content-Disposition: inline
In-Reply-To: <87msan1bqd.fsf@prevas.dk>
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


--h2xcrK68/upFtbbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 10:40:58PM +0200, Rasmus Villemoes wrote:
> On Wed, Jun 04 2025, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Wed, Jun 04, 2025 at 09:56:00PM +0200, Rasmus Villemoes wrote:
> >> There's really no reason for the gd pointer to have the volatile
> >> qualifier.
> >>=20
> >> In fact, I claim that it's completely unnecessary and just pessimizes
> >> code generation and forces ugly casts in lots of places. For example,
> >> see the casts in drivers/core/tag.c where elements are added to
> >> gd->dm_taglist, or a helper such as cyclic_get_list() that should not
> >> be needed.
> >>=20
> >> Also, it is what ends up standing in the way of an otherwise
> >> innocent code cleanup of list.h:
> >> https://lore.kernel.org/u-boot/20250522165656.GB2179216@bill-the-cat/
> >>=20
> >> Note that riscv, x86 as well as arm64 with LTO enabled has not had
> >> this volatile qualifier, so it's unlikely there's any generic code
> >> that depends on it.
> >>=20
> >> CI seems mostly happy:
> >>=20
> >>   https://github.com/u-boot/u-boot/pull/775/checks?check_run_id=3D4346=
3083829
> >>=20
> >> The one failing test seems to be an infrastructure thing unrelated to
> >> these patches ("docker: filesystem layer verification failed for
> >> digest
> >> sha256:379cc6cd06dc3fc80e31d5170204c0cfcc25cb3b3ad457ced23bed2b38ec9f3=
6")
> >
> > Azure seems to be having some hiccups, sadly. I know from my end I can't
> > hit "rerun failed jobs", is there an option visible to you like that?
>=20
> Technically yes, practically no.
>=20
> On
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D11303&view=
=3Dresults,
> I see a "Rerun failed jobs" button. Clicking that, I get a popup saying
>=20
>   Rerun Stage
>=20
>   Are you sure you want to rerun failed jobs in the stage 'world_build'?
>=20
> and after clicking yes, a banner with red(dish) background appears at
> the top of the page with text
>=20
>   TF400813: The user 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa' is not author=
ized to access this resource.
>=20
> and after that the "Rerun" button is greyed out.
>=20
> I can do a trivial change the commit log for the first patch and
> force-push, which triggers a new round of tests, but I don't know if
> it's worth it. I think the current revision is the third time I've had
> CI chew on it before sending the series to the list, and each time
> there's been at least one test failing, every time for reasons I've
> deemed unrelated to the patches.

Azure is annoying at times, sigh. I re-ran the failed part and the
build is green now. Thanks for looking.

--=20
Tom

--h2xcrK68/upFtbbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhBqFkACgkQFHw5/5Y0
tyx3fQv+JCxJ1t0XvqTCMtqZeGZKVJGSB62UDNwSGiOVrY0+7hzfjk/kcYBnTdF1
Zdn/OtQh0bZIicnrqqe+KfjOj78CImq+k8c1mHqkVLtE4sz203LoQfeszQ3tLum1
oQmanwuB1o4CB5/2ALRex2juDgIIVOQpFdL2CRfeQuKPuqsQk8ZLcJBBhPzD35uT
5LJwC6a+o5Eh8mP040zBOeQ1CzrYL80+eRy1z9ylGD3jg8QCdA/w2ag1AUFs72rS
5xPKrfTojps9ACpIkj6Cnj0tUgwfyaCY62GdiywpO8rds64LQ33hYg2fpDAnL+df
+MHJSa8VS8mD2OccNii8kUdmCmSnIITlJSykEsEgIDsj/74YPucRUsOY9TBrpzUV
3YmrUdzeGumLCv+LQV5NOHKYdga1jurDJyPpJzgAaXRSDViHV0dsSlP6XjbtcfNd
DeenPP3OxG5ZGd8hOLwrYBIPUx+zf0QEFYZ/H30yiyUSTfmvxOX4ohXLtLoJzINv
/Ylmj2pL
=7ZY6
-----END PGP SIGNATURE-----

--h2xcrK68/upFtbbg--
