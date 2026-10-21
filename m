Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D997606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IrGJHOCM;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=egmZp8sI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3CEB80AF3;
	Wed, 21 Oct 2026 18:09:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nxuZBtoOCwfL; Wed, 21 Oct 2026 18:09:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 285EE80AA2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792606193;
	b=a+lhvt0iZJ5hwf4DgGgCP2SGKGA9eMx3zySU2dupEU0aOf4FgibfnzvaP6p8iSzs+ald
	 0qq4Pr/VBPbQtveovbqDvRyXAgnpxfKZgl6A89fK+OvWa+tqCS/s7dWrk5/vs7/SAOa1X
	 1xINNzTO0rIvTnIFBJ/c32iyXyN+RklFO6qUMCYZstNlx9MP0i5d2tw9bwf5kPJr0qR1C
	 EwhKzE/fwtbsDK9kb+ELWoFCrJ0m8n94pjRfDB6+jNNWYemRtPBQ1WbrngUC6M7sgPaPt
	 I0XyeJWHSkflkpBZOWHSXHN1Qw/YqWZWBBB8h1QstdisZgBEdzG0JyRMQalYvXIHOKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792606193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vdpcqIFgau71NOXwvmJjrJt7xsfO4xLHkuAS0q7xw74=;
	b=UQ/uhkWKrsauzw5aojzwieYkd56n0GEYbwi9rXpYC4OuwSROI/DWGzJfYSkt3hgYyHQr
	 zAERFnF3J+yPADdYbpN7x8E0vqAdf3WA1vdAXJRK9AZx9cy+Xsve0+yANiTxNS5874iiY
	 uASNUO8AnjPQPGNfFyMCrVCF62OuZr+kqFv3WntF6mACv/fHvAjO1x5M+mAqseYkJ/Ozd
	 3iwEICqB6yhYlzrEqomeo1DkIZJajzO2Y12Lw/CcLi07mrRJxFL7siSvimupXgXm+AqWi
	 yz4wJ/hlebSwFKiafC9kDFT0PxaeVZXVtcJBuiwx8b25p/NdczXnYnc7BNxBQT6FR+A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792606193;
	bh=vdpcqIFgau71NOXwvmJjrJt7xsfO4xLHkuAS0q7xw74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IrGJHOCMKn51rumlaCdk06xb+H54lWns3a0fisbGn94dz0ewWfmEa83l2H5LiPQHa
	 LmgFQPgKDAc1P/cvs82B8dLE73VbKbOXAhRqT8COsLAf3xdmXbHh7WsPsAM2fBdJtS
	 Yi7GB/0ajgKTBbkgKHRFQxUw+UhX86/4ROZ8ZknxTA7/d/nMP0Or+8otq3Cf128QLT
	 P4C3F5wQLSm6os/fGUgG7XwelHgwY/FUNnSASVC8JKXwYjWl81USH766iV6tufI4mf
	 YT8zIgGqDa0rv+p2jP9rbBpA4ad8DnfaHZC4R/efo+1+nOGZOMqfpRnYA3Mc1lpmQ3
	 eJyeAKNmLMArA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 285EE80AA2;
	Wed, 21 Oct 2026 18:09:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DF66B1AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D07976079B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:09:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q5EGokEEHgu8 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 18:09:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1147C6068B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792606191;
 b=NTBHQ43MicAXgNjQCk5MCEF8IyjD/yFpRCTYv1Mj5Oh1DE0j22UKbbesLPU0AAXR2UZw
 ZsNYap3t57Ifh15LwHOAkzQiO3hAgoEUjWlqHVLH/IKDLMBIrR8xBoAU8VpzYoWBk2/Ss
 z/XeZTVtDaVJVaYUcBa8951rx4zpB6dV/sHvc1Pvx4wpJ+FCvlvOWpn+ULck19PznInJV
 T29GYTfkkyLNEb+0V6EydUrgLU+5hrxTLFcFd4jahTSgMO9b3Uxk+4vyCxNwMqmqtFqI1
 jT88vLcibwp23i/ExyB2kzjY3sREkJ49cne6DLfk9/VVUMYXvEtxz8DFFCIDXa6+Ejw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792606191;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=vdpcqIFgau71NOXwvmJjrJt7xsfO4xLHkuAS0q7xw74=;
 b=Lg7mayW6wkSgO3JfUY1yglw8quD1NdHSkUFDOTo22G9qke5YsH7fs63WaqVB2o+EHtv3
 xnIjwp83ns1dr/6QAPMX1WGj0sYhFqW0WzlxJdDtCZdVDpERsyrOZse+/+/nnjtotPEUx
 Am4T7DZpx2XuwNwe0HCw0SJawSqxV+dk/dI7e4zmC1VnNsNH0QPqmdz+iUPyAiCgvy5go
 ezy/AQirUUWp5ZET354FogY3okPUGrT00AYia6Ga5VS6w0Q0Ptwaju3lRlsvjev22N2Ct
 L/r8BhV0s0J7EXVOFZFKXjNH/4z6cGCf6cbcMcHiPvxKaEtKlKUJrDF9g6g2+KJwGhA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=egmZp8sI; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=egmZp8sI
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1147C6068B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:09:50 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-706113e92f9so606117eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792606189; x=1793210989;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vdpcqIFgau71NOXwvmJjrJt7xsfO4xLHkuAS0q7xw74=;
 b=egmZp8sIn2ZvsYzx55WrX3iuuERrySP1ctNMt9wEJJzZAJ58HjZ2HqYk5q0YbTWZTh
 VEutQyd/YDydU4tcup88gGCVI1O3sER3MtxAXAmD8lPJnXMAkPpO/T0x3YYWeYGBibJl
 vF+gz2C/8XOxjmhvCUMWEmPiZqt+h3JUt7aX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606189; x=1793210989;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vdpcqIFgau71NOXwvmJjrJt7xsfO4xLHkuAS0q7xw74=;
 b=GOc30wChM6pEJHzQUNIbTD+aBVtq8hIuCsbzH1vpsDZQxybaphGlauJ7piXzZdgBi2
 1s0Blf4/4HLSDQvA+k8GQutKkUoiOJ1BLNrSPfqHR+MwrIW2PdFRMzu9LmTmEEKygiOO
 gunmM/o+XVjFL6i/+WyV8nFOtGrClE29fRVNB1fAXm9OZgc6tUawUZ6Q/gQPA1YbRUZo
 vzPM5afKsgeQ/1BdItu8XQONbVF1wMMoIWOq34Q/qygIldUzpK+CzbxLBjg20a7/mmFM
 gTowWzQbJtUbfDl10CPwM8XO2mDVDOn4SUUDY9bqhilqanGwAqAwNdqjwiq+mj7PFUrS
 vu3Q==
X-Gm-Message-State: AFq9FYL3utywZAIM4+d+rlAxsD1N/L4USchXIWxpXmetPzh433GOU0hr
 w947/glFfqGN39Dnx+8Tto7ptVuU1+AKXQPe7+KWfNynxYeepUXwlTRVWJy8dudKIsQ=
X-Gm-Gg: AYBFou32BOzRYKG9G48KqBjIKFFmYpAOARVavxn7LQMKSVJJFy+4EP3pA0o7Cpouy8c
 1ga7vwfKwp+itHcKY21RcsO8H5yfGM2KCzTRCNvURFyvXvhfBVEh41jbRp0bwoCBaEu6OCyejRM
 evDATx1WvA1CW48pEw2t3kulIJvrggmIRZCyTOKXHrxli7LvBAIXDWCAdclQEegv2avTzCydeZw
 U76Co/HLXaV/4K72Y868b4vApFyCo22E9Xky3njXw4YEZoLO2fiZWAyEIoyDzulyCj+6Qhu+OtS
 ZuIDBL+fW4G/ud0n8SNcufGGYyrWe1ENMrxJJ9QQ3C7f9YNsAwzlMePMWnOz21f4Qhw4raKehUz
 6iKeDNAWGrbUbU+KqtkryNx3oG8gxuMbdSCg78aqS9UDU0bQs5iL77nuMuzKD+7VASRWISSqWBp
 IuTPz6lG8LH/4BrIwt+5OddqRpNjcFXCZ15tLLQVvSEIhZitQpdp4OaXgRJtUgKhF0FlNwgfQbs
 bMRzbBp4PJNhzchcHlBT05/roGoAuFXlm/7A6k3N3Re9NiptL4p31HzJTEF/lU0d49OSSb0ynwO
 JyES9qXtTeWlKfe7+GB7YQVCjJOUowi6qy2xW6LbnN1YDZzsTvNmvxY5QGsPEJNjNNDXf8UHe7Q
 U
X-Received: by 2002:a05:6820:6ae6:b0:6d9:e2f3:9b51 with SMTP id
 006d021491bc7-709415063a6mr1970323eaf.66.1792606189385; 
 Wed, 21 Oct 2026 11:09:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-709036d65a4sm2823277eaf.8.2026.10.21.11.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:09:48 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:09:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Bradley Morgan <brads@mainlining.org>, Sinan Akman <sinan@writeme.com>
Cc: u-boot@lists.u-boot-project.org, Mario Six <mario.six@gdsys.cc>
Subject: Re: [PATCH v3 02/26] board: powerpc: Remove MPC837XERDB support
Message-ID: <20261021180946.GG3275858@bill-the-cat>
References: <20261021160145.10430-1-brads@mainlining.org>
 <20261021160145.10430-3-brads@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8ZSsdb6ogi0UCcqC"
Content-Disposition: inline
In-Reply-To: <20261021160145.10430-3-brads@mainlining.org>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--8ZSsdb6ogi0UCcqC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 04:00:58PM +0000, Bradley Morgan wrote:

> The MPC837XERDB board is unmaintained and lacks active community
> testing. Drop this target and its board files.
>=20
> Signed-off-by: Bradley Morgan <brads@mainlining.org>
> ---
>  arch/powerpc/cpu/mpc83xx/Kconfig    |   7 -
>  arch/powerpc/dts/Makefile           |   1 -
>  arch/powerpc/dts/mpc8379erdb.dts    | 153 ------------------
>  board/nxp/mpc837xerdb/Kconfig       |  15 --
>  board/nxp/mpc837xerdb/MAINTAINERS   |   6 -
>  board/nxp/mpc837xerdb/Makefile      |   6 -
>  board/nxp/mpc837xerdb/README        |  97 -----------
>  board/nxp/mpc837xerdb/mpc837xerdb.c | 242 ----------------------------
>  configs/MPC837XERDB_defconfig       | 193 ----------------------
>  include/configs/MPC837XERDB.h       | 218 -------------------------
>  10 files changed, 938 deletions(-)

As we had talked on IRC the other day, you still care about this
platform, right Sinan?

--=20
Tom

--8ZSsdb6ogi0UCcqC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatj/5gAKCRAr4qD1Cr/k
Cm1nAP9LOlx85VbI9o6FBNZ8X/YZ0kFhsOeZZtlVzWXeWN7pIgD/RlSZxhAB8VVV
v7sYqgVDcogxTanEvviHfvkYbWL9WQ0=
=Dok0
-----END PGP SIGNATURE-----

--8ZSsdb6ogi0UCcqC--
