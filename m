Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB2C606A327
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PdClgK6E;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=QAwVlxJH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B0AC608A4;
	Wed, 25 Nov 2026 15:02:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XBiCA5WG31oe; Wed, 25 Nov 2026 15:02:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 293EF605E7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795618957;
	b=cOyVz4rJPh49OWvsqKlvntMLHLjdLgYFyT+5NbnbvyDDMXL5gl9EKyr5ME2X+/jdkAHb
	 5Ccv1XCL4SgrCDnRgxZ5B5ni35fcRY8W+g68m78pJNB+HHhodTwXHQaAX+kqY+EDNvA14
	 w7ohFoLbnL3e8HITrF6BOZTuIFkovktANf8z2WRWvCFoRVsmamUiQoF/t1ZyQaDxPVvJO
	 hk3sjtVs3S5Nwx8ymXU17ptZqdFm3Xsz7XpnaVlCxomyGzIPMi6EzvNnDchlUeWqW2uDi
	 6ymbuIzEZd5Bl6BdEbGgbB04g+DZnwCO1B4aWOlINcXn84S36LaCrcjluLrwa8G9vbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795618957;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=svAZlcwuRvomjhXdahUVvoTGd5ZE4ODKAjedgLeJVUk=;
	b=MeFXfDgi8a5hQNMe7Mlr/9W0S7PMx/djVILAbnTnBhV0wOMRFhOLOeTYSHqavClbNrl1
	 rSb/ucAErjo0aBB5KQfqnPssbs/DHadrwACLOWQvmDXDcSMXkWeLsxSqV8WPLX5tZitTV
	 3NqR7gP0pyP9AWSVJcORAVWK1RRSamTjjBJSau9oQfF+gCJWv8fO3g5hpT3YIVcI3Z9cR
	 S3d4ArZif450vHq0KUIc5h3d16g0jAmJTwwFPMmtEMgNOxvW233bqu1uS/yGX30Sc1DIx
	 19Rouz3S7qQsYiiUV26jttGY1ghfJdGIGjQk5X+seD9D869Nv6Z/+NzSO/SM6Hx4TqQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795618957;
	bh=svAZlcwuRvomjhXdahUVvoTGd5ZE4ODKAjedgLeJVUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PdClgK6EEcyffBXZsY8K/3yyUvOUOsvircUtV7W7j79e1fidFE8uNuxJQC3NBETGD
	 a1hnS6o3yPc+OjfMlXLGHeelpRZoxBKH5y/P4uBDB3yqUIvkJbPHFkAzDPy0q4uTNI
	 6xyuhAjwH6YSezAb1CUAKR1nnlXXMBEY7vujIZr68ahPySqn6ziAVfc7RHKSveKEd+
	 +JXzmrp1l7kd7WgBbc9Jagv7+h+eDbgziSpSm3UQRXxxDWwBJ4qNeRp+tUT5KW7LwW
	 ccGdp5/LkfTEye9o7t0gAh+grfW1SnDY9AiQf10Ur10m06hqUrp0aHuRxr+Nduz6W1
	 du7T+HO5Ors4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 293EF605E7;
	Wed, 25 Nov 2026 15:02:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 27DAC22B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 16548403B0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:02:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 98DSQ2ULkxWG for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 15:02:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1909240116
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=QAwVlxJH
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1909240116
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:02:34 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-483c607ccb4so3056011fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795618953; x=1796223753;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=svAZlcwuRvomjhXdahUVvoTGd5ZE4ODKAjedgLeJVUk=;
 b=QAwVlxJHY4t8OYvTNh481LX8oY7brjqaLx+UpIghnZGPaIDkh86qG9Z0/2Ao6qFbuM
 NHZNTT4QtQkWtLHaLciqLT3n+NqxhI4pC8/1Ot4HIacqxW0+HlSQ+Zb0Aj5wTgJFq7jy
 nCqJ689nbfQa2dLNAHyQhUZO7iEqvHc51dTsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795618953; x=1796223753;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=svAZlcwuRvomjhXdahUVvoTGd5ZE4ODKAjedgLeJVUk=;
 b=pZCk/eJySMqdfevC3Eaga+uJvtRJ0Km0IF2+pSJjl3reUMjLm6AXh9zAAkdIobzN8F
 WN3nP//GEYSddFMscEMU3GC8ee/Gy3tT5Dj6qMTOL4F/A0i+GYK7Gy4jRSvk/7Ynz4Ie
 UyGGiKAheXMqnFTYRKg6ZXAr4g90ezcSuTNLE2oP5ehiFtoNKGYZgcYD/z/0a60J+WU8
 53201Iq6Q6U4kFXVfttVIpGP0wJU7mBN4CZJoUoaujz1GimDpCUm/shCH7fKlpLcG0CF
 gtKQ8tygAd/MD30RoVle6wISvcD3SMye3OZdfT/nqxje0/hvzyq5EqtnXBFG1PzOjuqd
 IE/w==
X-Gm-Message-State: APuU4Z8kRmatRkJxBZIze6MlJyPbRFAOGOWnH5SkoKOOA0CuGPeRRFxl
 3O3UR35RVOacoTjNRpDXOthLudL8Z/YDTIzDJhhvT1MrGIVwZPuHTdMNvt5WQw9tF2YcznYvlVs
 GMwYRdW+UiV3p
X-Gm-Gg: AZFdTZfdiwXasFPicUdJkAosU+FYWvZ3qF2PIS6UiI2hrL/hxDg9+XdtvqKnfxezUBo
 BBxgQm/24rVRkl4CmVEHKqHMZe8P55h1FL80sPznH47qKYkX7E+9ciO23rzTvKncNSzP+2SWWDw
 es5pnMU/F5hltwQM80RUf6DSoXWdcNPAgv1jPJNxeX4b2BLrn1hcbzvpEiwLTPab71NXax/pDEj
 B+VZmi5u6pnuaPvW9/mmtzb6QBEMJlXUxrdk+pOlPneZ56VyO7k9HefU8W0SxMj6+HkthnH+Zwi
 sfw8cKSfTZmge4pw4B+9RLrsLTCercU/QROfL6uPElfiOPIubnvyOtf9yOjW/osPcUtjNmWzPAY
 vjWpjgtcF56irHOWluctMUJ3jjX2b60axYaAMfvPfio0bwFR1EfIcUml8JV43g5QynXYvTlltFv
 U957Zydm3ZEglE/YeeWDoX/fKEDAIbx3PLFBmqSfX7x0Cu3PxywTW7CI14F/up8LglWs7sbZzbR
 Ryx5Svn2Y99plfHobVtvv0m8m9OBfnt7rNCH1+BnSQt3fcMSBpTDdcFqNaG8joOx41/WXAVTx32
 KjlvZdtOVMxHnmglJsBjdChaLvf+3gUXrysL3Bj61Z7jYwCGL5wGJIQClUXQU0UxszzH1kcZ+6q
 pjZ8k/Miub7VVxXU8pR5R6LG9tIionX0L3M9vPwX2wtsw0stkXDlxuoBCHPhW+DmpJVwjs/HAeP
 /hOow3kNVLsp650Z2TF07INhrDs6TZVZc=
X-Received: by 2002:a05:6871:cc45:20b0:4a8:b8ac:a718 with SMTP id
 586e51a60fabf-4c720dbfb33mr4771290fac.54.1795618953306; 
 Wed, 25 Nov 2026 07:02:33 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60491337sm16395913fac.12.2026.11.25.07.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 07:02:29 -0800 (PST)
Date: Wed, 25 Nov 2026 09:02:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/3] Dockerfile: Be more polite in two git clones
Message-ID: <20261125150227.GF3176972@bill-the-cat>
References: <20261125134317.2479815-1-trini@konsulko.com>
 <20261125134317.2479815-3-trini@konsulko.com>
 <9f765c10-3e60-4253-8f68-67ed973bde62@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fyvbj5/isFX8nZ2h"
Content-Disposition: inline
In-Reply-To: <9f765c10-3e60-4253-8f68-67ed973bde62@cherry.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--fyvbj5/isFX8nZ2h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 03:02:34PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 11/25/26 2:39 PM, Tom Rini wrote:
> > When cloning grub and qemu, stick to grabbing only the tag that we
> > intend to build. This both saves time and their bandwidth, which in turn
> > makes our build more robust.
> >=20
>=20
> suggestion: use tarballs instead?
>=20
> https://ftp.gnu.org/gnu/grub/grub-2.14.tar.xz (or
> https://mirrors.kernel.org/gnu/grub/grub-2.14.tar.xz) for GNU grub for
> example.
>=20
> https://download.qemu.org/qemu-10.1.2.tar.xz for QEMU for example.

That's probably the next step, yes, and then when we need a
cherry-picked patch we'll just pipe it in.

> > @@ -397,4 +397,4 @@ RUN /bin/echo -e "\n[toolchain-alias]\nsh =3D sh2" =
>> ~/.buildman
> >   RUN /bin/echo -e "\nx86 =3D i386" >> ~/.buildman;
> >   # Add mkbootimg tool
> > -RUN git clone https://android.googlesource.com/platform/system/tools/m=
kbootimg /home/uboot/mkbootimg
> > +RUN git clone --depth 1 https://android.googlesource.com/platform/syst=
em/tools/mkbootimg /home/uboot/mkbootimg
>=20
> question: is mkbootimg even used?
>=20
> I don't see any actual code running the command, only documentation.

Interesting, I was expecting a test to use it, but no, it's not.

--=20
Tom

--fyvbj5/isFX8nZ2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawb4ggAKCRAr4qD1Cr/k
Cv7pAP9R48qA8N2LaFDaINjKGtEsr8DAT+knK23JAmrriVPtbwEAuRrIF3oeFHRi
yUzBMkypSTQMqgVp2G7IQgjaQnrWTws=
=65AQ
-----END PGP SIGNATURE-----

--fyvbj5/isFX8nZ2h--
