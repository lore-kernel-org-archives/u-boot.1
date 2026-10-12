Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A02CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 20:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5E7640536;
	Mon, 12 Oct 2026 20:01:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ocSKbUpj1Zp; Mon, 12 Oct 2026 20:01:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1A53640537
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791835299;
	b=Id2NmBPQA7Z5ENWSzWH0X0YRLhHMqwzDBsMi5HOKl/SVfmWQOwN7QY+vQBmCalOYgWTC
	 9Jnk1wr1Bx2gj6hBDkkxmUPAVy/pW0moCmM2wO122yi42qh0bagiWdTriGhLT4dioIr98
	 SKxUeryUN6tKHFKOSpAOa42DqFhIpmxexq+1j/GeUrrQ3HSiWLDNhrPnbsIrzvWOSmcth
	 JNZuYLtNRejGIbfqMMJTEmTxE4sBKov67PXszWJCoYqmDn25K514jIrfAVsp+5deQoDS+
	 4+mGR4sB3jiFzzhPShK9pxN7Guec+W4k52TK06G25twFmfEDT9EYw/1Diy/3fsVss/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791835299;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=tyCv0kNJwS5zIL5wXkmGq+jHgDu/9wMHCl5FpxKyvsw=;
	b=VA1HhNYQvirZ+Xj7pOWaGK7tlOpxf5ZsRoC5zPv/eSRMlTnj4gj5SUltrv5sxjTvK6Jq
	 p0k19rsDJKngW+qaHNK1DbvMTqO6jcvsWy52p7SwuISuZQPm4ZvSCimpzeH4LZ+iyNLUK
	 YUsTnPrNuHngVGZ7kLQnBQWHCMFY2JV5ukvljtFi6pdKZ6nrZqAbntzT5ONoR9e73r6pP
	 Vr/9f124OsMFsKMHSeoZ3BaeUlyzXZChob8AsTrGcy+4XJB3/l9gFRe1PFXs8w4OY56/B
	 1vNtm7abLfnH0aKju+Pmvj0RgpRFphVZTz1scKV4mdDVV9BWABo1N31yc2qpMsOIf0g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791835299;
	bh=tyCv0kNJwS5zIL5wXkmGq+jHgDu/9wMHCl5FpxKyvsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rFC3x7bVRPIQAts2Nu0eaX0BEmDE7xI+/6PSF9vQRj7RXwwlhGSoFmIgAoU5Xd2fe
	 3pujxLKjYBNgsYS4mrk0MFahW0gS1ZAIqcULA7K0ORCoa7QfvUnbJLG+FMxN2qF+o0
	 cmGo40N9IcljEMWAbfNjr5CRnKZlr/hdSv0X8GOccH7cngRq0PzjUdK1ZAQwYmin5v
	 kzW6XXgjqXaCWWTleIg6XvOk7jiyteUixRMGyFAYRbAw5YiQ87231Zk1xVOKL8cEOA
	 sA5670EKld4m+anO9Zr8jLwRV5aqE1WhD6k8Ofe/n6hcv+vKVH/0mwg4nt35qDhWih
	 SnATckzFjzyxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A53640537;
	Mon, 12 Oct 2026 20:01:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E42AE2A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E1A5B605F8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:01:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fooQRXuHM56Y for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 20:01:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2665A605CF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791835297;
 b=oZWDgbZT86XjH7+z2RYH9uI61h+Vx7DqEz0yMgzJyLtJdT7SlIru6UBnfwd+G3J+7L32
 Sdr1KKs8y5fXWgh4JEPMb1N5i0KU4HWp2efMse/nZHezzxxJVQMOE7/dlQGmnV22q8sUG
 oTKvIFkVTrWy3nYnj8fgHJE4I1pCpJg1XvbA5tKJiq3blus5zaoCrKN9tB72a+do82iVk
 w8ZoVgX09SjGNVpQPsOprZb9BW77XtdmXF3bP8LK84Rwh1cj0nPq3l7GVRRXAEcrkLVIs
 31dn0TVymYuMRb9U4cSsCC3mVkx7jiN1GRGITUOli44hyqkQy1rHoVAXTEYDcdIcN0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791835297;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=tyCv0kNJwS5zIL5wXkmGq+jHgDu/9wMHCl5FpxKyvsw=;
 b=r6wiQn1zMkt5UoQiTWgUhsqNuM8tLup+O27cg1o0EPY57myEgXM1UGRY+hpzVhbNfPil
 6bP/6VbW/Ry3KawGeB2WWMxLc8lxsKyrJkpB7niEFtvO54QmUaODa7U6kol/YqPff/CMK
 c1RzlWmwKKY6eXEm2cZdZw5poFwNbmZ48KgxS/uUlWaT3QBRS+yLyi4eRScFbhyLc0egf
 maLEeipYrPuq3vzyF8e/cWO40G63SyFnk9gIHRG+pehIvD/ku+sy8t2vIhjOH5iJXkeCH
 G64JjpBTX8f8SGewdaxExZiDivKULr8GjEYKWamH0Gd9aOVmxF3KJ2sk/0Jq4onKl/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XnHU1eh5; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XnHU1eh5
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2665A605CF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:01:36 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4b190cdc9feso1411887b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791835295; x=1792440095;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tyCv0kNJwS5zIL5wXkmGq+jHgDu/9wMHCl5FpxKyvsw=;
 b=XnHU1eh5bKe+yNOAdikRP+903t//0yWjq3ix0awRgTTXW3pKWCjspcTEGop7Gh/WBT
 AOGDYYBfMX7IPIncH9mEdFMILAZ2RC/nJYkKznO26esecNb2hMaKm7z/iNJHdCzV25Q/
 MJkiL1ubj4dtbN1+007akN5dLu+pYO5nx7jog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791835295; x=1792440095;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tyCv0kNJwS5zIL5wXkmGq+jHgDu/9wMHCl5FpxKyvsw=;
 b=srk+WUy5Ny4GCgMs9h0gJYAzyd5mr/VE2taYWnWmnV1WoAjyXqmXKYPEbRezqGxlIJ
 ktDclBC/dSqQpX9V/aCUzSJ0mwk4cyp7L6s4jFgEDcU+SILXn8PFeDSBLh9FhQeSCijW
 JkHnHMtwTX9IJrOb2OdWrC2GMY2zQfO18d2jmUl7O/ZKP6w2Pll0gNB0WneXFLhk6qsc
 +F+ueo6oxhckfdJMoqtba4vX81A5hSyVbtSXs+OykD4Mm8NoToBt2YFG0d9cTMgb9mkq
 WYA46n8Jv7reKc6IXVzE6t+PHYH2aVfI9Y7YNRJLmB1LIB2GYiVL5pxL7v1V6XSHgoub
 RZlA==
X-Gm-Message-State: AFq9FYKEE7VOKnJgcs/oZS12DL763HCiUs4zuF5DnpT1RyibhNwrC9kR
 mN5ywjAuWmdFIg7PUivGYLgyGDhlLcGlxGBo43ZmmjaK+Nnxe9VvNXbj4adHwj478lk=
X-Gm-Gg: AYBFou30mA6H1DppLkZOIq7eglgCfguSrA0SQ77V0Zl2h91ThPYqKl/glsdxe1HO+sI
 dTI2Qe4HaK6uwneANwnWvJHyeo8ZEWRTYa8qZIT74M/x9fY0CiLBkz3JjOWvBWFvagyyBM/VWwI
 Os0Up2/OJrT+n35gvc19s87CyRUzw4dfTCTXQw3zvi15qL6r7zcWTn1llDrn8GfD8qY6G9qyRvi
 n6DGcivYa3nOCCbK+arQEmNlj3gk3o4nKF3jJSdGMFt6KCzjieHSgEeJc7tHKyH5JNWt3qG/Eau
 XDKTPHnK+Dmn1gygzm3jVGGclnPjb9BnuDwPFYteFWAdRNEftG4gbHZPEeNalcXM39KbPUzzTA8
 G6jlDkBrZG8rUbg8xdJO+V4wVnfLUfVE+UcJsd6cBhwSydIOlrxPO2ouBDRYuC5XvR9jl8UOqFR
 nCPRHOqlMy/YSHga0NYUSuSnZYzOEZjjYrgJnIQeFhYNz+yvPl4CUfYWH+qMZ1A6f8oM4PmyJl2
 sYTicVEQRojT1bWf+0s+j3LD77u6KfF9VnsxLRYeVAQckp+hNeCNmCqnLnxN1uSWRMz/H3umcwY
 hBA8AeJHjK4SatgUmFU=
X-Received: by 2002:a05:6808:5028:b0:4bd:c8be:1e00 with SMTP id
 5614622812f47-50c532f8a99mr10597227b6e.13.1791835295592; 
 Mon, 12 Oct 2026 13:01:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c19f4c066sm11560177b6e.11.2026.10.12.13.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:01:34 -0700 (PDT)
Date: Mon, 12 Oct 2026 14:01:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Sriram Sriram <sriramsriram@linux.microsoft.com>
Cc: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>
Subject: Re: (subset) [PATCH v2 0/3] Bounds hardening in NFS, TFTP and ext4
Message-ID: <20261012200131.GH3722450@bill-the-cat>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
 <179081761139.570197.9802971587834247609.b4-ty@konsulko.com>
 <ar6Ag0tw4KYUrgev@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <as0zB9XpmfOK7CtP@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p4usZ7vyYzqoJeWI"
Content-Disposition: inline
In-Reply-To: <as0zB9XpmfOK7CtP@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Clacks-Overhead: GNU Terry Pratchett
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


--p4usZ7vyYzqoJeWI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 12:20:39PM -0700, Sriram Sriram wrote:
> On Thu, Oct 01, 2026 at 08:47:15AM -0700, Sriram Sriram wrote:
> > On Wed, Sep 30, 2026 at 07:20:11PM -0600, Tom Rini wrote:
> > > On Tue, 15 Sep 2026 13:52:07 -0700, Sriram Sriram wrote:
> > >=20
> > > > Three independent hardening fixes found by internal static analysis=
 and
> > > > code review. They do not depend on each other.
> > > >=20
> > > > Changes in v2:
> > > >  - Dropped "boot: image-fit: add overflow guard for FIT decompressi=
on
> > > >    buffer" (2/4 in v1). As Tom pointed out, max_decomp_len is used =
both
> > > >    as the allocation size and as the unc_len bound handed to
> > > >    image_decomp(), so a wrapped multiply cannot leave the bound lar=
ger
> > > >    than the buffer, and image_decomp() already fails cleanly on a b=
ound
> > > >    that is too small. The claim in that commit message was wrong, s=
o the
> > > >    patch is withdrawn rather than reworded.
> > > >  - net: tftp: replaced the four bounded strncasecmp() comparisons w=
ith a
> > > >    single check that the packet ends in a NUL, per Tom's review. It=
 is
> > > >    smaller (+16 bytes of .text on am335x_evm_defconfig instead of +=
24)
> > > >    and it also covers the dectoul() calls, which v1 left unbounded.
> > > >    Retitled to match.
> > > >  - Rebased onto current master (a44f46af0aa).
> > > >  - No change to the NFS and ext4 patches.
> > > >=20
> > > > [...]
> > >=20
> > > Applied to u-boot/next, thanks!
> > >=20
> > > [3/3] fs: ext4: widen ext4fs_update() block-group loop counter
> > >       commit: 1c1b6c2b2ae03912007ed2ffd361f43b7c2e5401
> > > --=20
> > > Tom
> > >
> > Great! Thank you.
> >=20
> > Regards,
> > Sriram
> >
> Hi Tom,
>=20
> Just following up on the other two patches. I see that Jerome reviewed
> them on Sep 17th, but they haven't been applied yet. Is anything else
> needed for those patches?

Since they're both networking ones, I'm expecting Jerome to pick them
up.

--=20
Tom

--p4usZ7vyYzqoJeWI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas08mAAKCRAr4qD1Cr/k
Cnc/AP9qeR8oCTWD0yi5eKd4rMfA4xg+Pu/nn46hGGI902pjWwEA3TA3GtDy62oK
ohcPt1AxX0VSsZrVPPgIAeXMTlT8XQE=
=/r8f
-----END PGP SIGNATURE-----

--p4usZ7vyYzqoJeWI--
