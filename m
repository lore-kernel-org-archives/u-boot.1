Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1CCC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 19:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FC7C607D9;
	Wed, 26 Aug 2026 19:58:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cZqAKWVC7vgk; Wed, 26 Aug 2026 19:58:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787774331;
	bh=zPL8oI3qkymW+g+UALUEOQkQJi+xadT9zsDPnJviIC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dp5NQ5YHaZ3+g8FFdbTTcXr8xN3thlPbo3tjJ5niZQWL1vmkp7pMglT0Dy3f9W2iD
	 1k5LNR7QV7PgL69kjEti3ua4eYFUxDdl20M057MYoXE2IUmd4dpDNRxKYbUwy8O6m8
	 Z7DdyPYA8qQfcLVa9UdDZgj2bbBBTbiE04Wg48G5D8jxC03u2x2Mqxo8qR3tN7Sc2w
	 YGVAsyr0BxOaFriBIpOxkswQc57orxbPWSArl5fQm4bLaW+qEmLGwEz4q0dVb6AOtg
	 R+be0/FRMdTMTv9qsBoToy5jRGdOtXKc++BXWsc7iB6viBPTWXgNfLld82xhUfyZ19
	 kDedzW6cktZtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8153607B4;
	Wed, 26 Aug 2026 19:58:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB8FE334
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 19:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D1CB840123
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 19:58:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rjtJOWnWDgNV for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 19:58:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::33; helo=mail-oa1-x33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LzAadpJI
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1D2094011F
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 19:58:48 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-465e7ba7b4bso488177fac.2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 12:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787774328; x=1788379128;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zPL8oI3qkymW+g+UALUEOQkQJi+xadT9zsDPnJviIC8=;
 b=LzAadpJIkLGD2l8Gr1xHiiBl5jX+HGsOyVVGuaCrLSJf8vikn/prxZUtW2TfBu0zbe
 zafmP/OL9uvZER4bH+hR8DQ30KLprJgp9+ulMGacK7/Bqpig1Hsl9ePTrwyMgBOihWp8
 U1ZFRw/Kan3jy+NN84pxjlDx77e8/KrWTAie0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787774328; x=1788379128;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zPL8oI3qkymW+g+UALUEOQkQJi+xadT9zsDPnJviIC8=;
 b=V6891agOA6Y07B8tFz+e96ZI7D5mk1pcyAF5M8H5lDNiuNKpwHoDFLnrNG0vJgG9T4
 mqJkXacbEuk+ioyaXyu3hsJu+xMyMpdyxiQWI64bBV11ytC1OjhXspbfGA0gB6+5MT2w
 BsPmx3h/VulVisqThAwow92KedyzEMHHkVfAB8SuPn9+YAZGe3QdfQmE5pPHJiJ8YlzV
 XsmOjZesfgX26jtO409oS++v7O40uLq4DSCXlCbCV/9mHB1fKYg6+YtQAYM/QGySbLws
 JTBncnXTzvc1UAIHeZjpRBPZrp4KZuOzSmfPk5fnnsJxOFvePPry1/WOPHRVd46uUDCz
 RzQg==
X-Gm-Message-State: AFuF++lPfyyj03yOPlD5cwZ7QfBjWtFWZ9Sh9gSbTJ5FY4lBoRLY5hny
 3i+GBkDAy7ni6PjQ+8abyzcjiKdo0upXV7H8gqLssBZoUGpsSioeO0dkMMY9GxR1bwTkf4VduaA
 OmelEyo0Vx1jT
X-Gm-Gg: AR+sD12PWsoHdbW4zNjK7oibegfiRivbJhrbFNEjDIqcQrWDKct2FYIyw/I7Fq+lRB/
 1fl3wVMJpt0TMszQgXRKqTJHPqt88UrsirLp9JmuRQUEr/Jum3nWWpdf4BFOzHdN50pSknhmRyL
 f0uzp6JHu9zC1gky4VEhRexudnRKLBJZ0HbOer3gO8EbLPeIwZUa+9pZosOvdXx9EK6kKlA65ru
 aql8jBHyFllYYLASB6Cx4LFxZ/6t0R8luj8LhhdutuWRZ6nCz8q6HZs3cy95WUL9GzE0+4e0o56
 SOzvBiRlQSx/bj2yCJXxo9uGGvpiKXWWrSDcaoJe6rpzolf7X5s/LkJGvF8oDVRhJNIIA/pP475
 6ELIrXotTRvaScz7shavVKlrnCLGGjGDF3IwdnNhNwmgXnuRygBqHNF/cnRnyqIh+Cb+hZbzjPK
 Q/hyRJbpOJbqt/1fzyjsMOmp2nMhfou5NhnZZKHKNpeF+a/SubloBSe3EPvv7eS0ksuerfbUZYJ
 oHE9FV6m5Cl49RH0yK4/+zkS2yrk6lFB6eqHq4TLL64b8ux5Evv9sT54iPUME63MkLbaNLC8+W/
 071GSPOv1UBNC5dBu9cY
X-Received: by 2002:a05:6820:220d:b0:6b1:445d:aaf9 with SMTP id
 006d021491bc7-6b1a03ac1dbmr8348177eaf.8.1787774326526; 
 Wed, 26 Aug 2026 12:58:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c7f50d80sm2373063a34.0.2026.08.26.12.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 12:58:45 -0700 (PDT)
Date: Wed, 26 Aug 2026 13:58:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [SPL] ELF loader support - design discussion
Message-ID: <20260826195843.GA3959812@bill-the-cat>
References: <CAJM1RwPMXB8qLm4+4h_hBLqsq9=YBW_GndXroi5En4VGBVq-oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yXksNFp9HZtM7Gap"
Content-Disposition: inline
In-Reply-To: <CAJM1RwPMXB8qLm4+4h_hBLqsq9=YBW_GndXroi5En4VGBVq-oA@mail.gmail.com>
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


--yXksNFp9HZtM7Gap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:56:36AM -0700, Urvashi Sharma wrote:

> Hi Everyone,
>=20
> Hope you all are doing well.
>=20
> I'm working on a use case that requires booting via SPL in Falcon Mode,
> where SPL is the natural choice given its minimal footprint. Our board
> specifically needs to load an ELF image from storage (e.g., MMC/NAND/SPI)
> directly into memory as part of this boot flow.

Note that "Falcon Mode" is specifically SPL boots Linux. So please
explain your use case a bit more, so we can help.

> U-Boot already provides the bootelf shell command for working with ELF
> binaries: it parses an ELF image, maps each segment to its linked address,
> and jumps to the entry point. However, bootelf assumes the ELF is already
> resident in memory - it does not read from storage itself. This differs
> from the existing SPL image loading methods (MMC, NAND, SPI, etc.), which
> combine storage access with image parsing in a single step. Since the FIT
> and legacy image formats also don't meet our needs, there is currently no
> existing SPL loader path that can take an ELF image from storage into
> memory.
>=20
> To close this gap, I'm planning to implement a new ELF loader within SPL,
> built on the existing spl_image_loader framework (registered via
> SPL_LOAD_IMAGE_METHOD) that already lets board/SoC vendors plug in their
> own storage-aware image-loading implementations.
>=20
> Since this would be a significant effort, I wanted to check with the
> community before proceeding - has anyone worked on something similar, or
> have any suggestions/concerns I should consider?

The SPL frameworks, generally speaking, are around ${content} from
${location} and then executing it. So at the high level, you should just
be needing to add "validate and execute ELF". But the baseline
requirement is to explain why you have an ELF and aren't just reading /
executing something in say a FIT image already.

--=20
Tom

--yXksNFp9HZtM7Gap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao9FcAAKCRAr4qD1Cr/k
CtuxAP0SAKfmJsQX4AuI3t7sGjEk2UflU0Yp/042plWGKH99yAD8DAJk1dLTXSIX
jwuhIgbUNG/MKG15RjRqTwruGx9NjAY=
=+7Bc
-----END PGP SIGNATURE-----

--yXksNFp9HZtM7Gap--
