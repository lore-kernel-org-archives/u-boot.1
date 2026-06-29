Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562CBC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 22:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7216B84A29;
	Tue, 30 Jun 2026 00:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rt2KYuoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5FC584AAC; Tue, 30 Jun 2026 00:21:57 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC21B846A4
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 00:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-48982e3f12cso2396279b6e.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782771713; x=1783376513; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h0t12StJF3+YRKfvbvfmIauYx+/Iipj7nAPV2KFqNUs=;
 b=rt2KYuoK1FoOxq4h/6lbmRr7K4OKuxM/65rk9l2R0C78IbnJSaSXlsEJ5BKjsNweeO
 8oDn0U5u5lF99ZOq7Jc06o55VoqxW0Se8wTFe5t4Qo7H0QJSxomyovaVXTa4BV5gurji
 G+vn7aPeLOQCUjBvwSvJyaE3jGU+/3LgA9jPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782771713; x=1783376513;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h0t12StJF3+YRKfvbvfmIauYx+/Iipj7nAPV2KFqNUs=;
 b=UnxRH2cLSWDKPm72uP5IHmcfNYKUc1LfLFcZbR3P5+KC3DpoSCwUjtNqlzkiAMRsQg
 eW2zLEH/QqRFmXyTXPXZxsyST/O2/7+NSXWB/8RAGmelhkNlbme5ca+5Kyu9y9GbeJyu
 HxCvp6XcZjpN1Gs2QHFatelHhFogBAgnd1XfALyJpUWS6R3sDEsw/Zf4kr7mihm4CMc9
 0V3bcLq9fpD9baxfk+5oMcy/8Ps0cT44xgQZTHq0iAAJobCp10CxekldwCkVha/26l3j
 rcKlRAYYafzzYPvhD9ZZRkSqDoBc8ji8SmVbYLN3ZDWXbcHq0SpAdmZ04pmQJb208bHK
 eFTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HfN8fkZ3agrCAATmPJzzAL/V8hEVeieFfhoKwDEUKm7MJJ0o+X8UIMhKCA4MpF2XXPb+bUYA=@lists.denx.de
X-Gm-Message-State: AOJu0YwkMlLViTyBwu/9AzZPupmIZel+3BlxRVdvYzT6v2iclQ11WXp5
 7pZwKf38alYicfkqGJv1Z1eRj4J3LFrEQPpnasmX/0VMAsiZ9GG2BdjNc3Kx1YSF1CM=
X-Gm-Gg: AfdE7cnQFsh0rb8Z1gz/D8GYfEfpva2S8q+Z0A2RTCpYjLmXwEx38yhZZEwQOxwbAl2
 1aMj3ztPVA3KCM5zgo+NtL441+KqkCykpVR2v/r3c17SrRkv1ZWWMBF9ufgk9NN4Mw7Fux+Oruo
 3WP9/LxGlTjafNxOzijTOrQ/YqVbul2qX3yyT4GPOz3+xb3hsEF0I8/Vh+hlorTyVFM8DoZbrQx
 pgjXksXKy3Ixh9hSdTF5+3ChmB0VyRGUioW7OENAQcZqWUYCUpouWm15Br66FlUDNAUH7POUxTC
 LRU7mEEB/1rdM32a0rXsvmPhofp7fRuJyEKuzd980NAFSgmqk3hwCZApfk77tur8POerd9mllQC
 NqdqVMKREzIdDTlRKsSsf5C2WfqUIeDZscpADQuaxYS8JHNCEnVfcu8Y6I6YWaOq0+QQnChzopG
 3PjIyutFxkGYUtnyRXhJrFz05rrwQQ1XZ8e42i8Eth8w6mGtP0OeAP4a5qneWtvzOV5UIsRJjIm
 U1pDlhWCnrdEiJ2NP6Rvqd9EWElfCMfGYFeceqk
X-Received: by 2002:a05:6808:229e:b0:495:e429:6eec with SMTP id
 5614622812f47-495ead9b25fmr1042876b6e.10.1782771713552; 
 Mon, 29 Jun 2026 15:21:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4935596d2a9sm7459741b6e.18.2026.06.29.15.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 15:21:52 -0700 (PDT)
Date: Mon, 29 Jun 2026 16:21:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: U-Boot Concept Tree Proposal
Message-ID: <20260629222142.GA749385@bill-the-cat>
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <6c21c8d8-74c0-43bc-9249-6cc1dc401136@linaro.org>
 <CAFLszTjGwi0MhX3wNH0eGVsumG=8c48hupe86eS_8E+J+LNdBA@mail.gmail.com>
 <CALeDE9MSA5RGEuBseiSrj6-yw9a44=0+PWC8=_HKboC-fWkkzQ@mail.gmail.com>
 <CAFLszThAqVjZ0Jd5kdB5q=bhGTNpAeHw3WXpUHnFQ_OH_KmXLA@mail.gmail.com>
 <6d0f3078-2ba8-474c-9a1f-481eeb7f47bf@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0wgSt/NKk+Cq6UaU"
Content-Disposition: inline
In-Reply-To: <6d0f3078-2ba8-474c-9a1f-481eeb7f47bf@cherry.de>
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


--0wgSt/NKk+Cq6UaU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 08:07:16PM +0200, Quentin Schulz wrote:

[snip]
> I'll finish that my gut feeling (shared with some of my current and former
> colleagues) is that U-Boot is disappointingly unstable. Unlike the Linux
> kernel, U-Boot suffers from fewer eyes looking at code, fewer people
> developing it, fewer people testing master or even any recent release (the
> number of reports we have for bugs on releases from years ago...), and la=
ck
> of proper and extensive CI test infrastructure (and if we have some, it's
> heavily centralized into a handful of people's offices). I loathe every t=
ime
> I need to update U-Boot because I don't know what I'll have to debug for
> days or if I really do test everything there's to test (is it my fault for
> not keeping up with master, yes, but I shouldn't feel this way).
> So I really think we could have much more confidence in code being merged=
 if
> we had more testing, possibly on real hardware, possibly by companies
> offering to do some proper CI (e.g. like Intel is doing with Yocto, spend=
ing
> days testing release candidates before the project tags a release). Maybe
> with distros slowly adopting Aarch64 and U-Boot with it we'll have more
> coverage. I know you've worked on labgrid support for U-Boot and you have
> some merge request(s) still open there but it seems you're hitting the sa=
me
> wall there you're hitting here.

Thanks for the feedback here. I've been staying out of this general
thread as I believe my thoughts are well known already.

For the specific topic here, part of it comes down I believe to a very
uneven level of testing. Both AMD/Xilinx and TI (and in turn, a number
of their vendors) have labs and run tests with a good deal of frequency.
I suspect NXP has some testing going on too, and this isn't an intended
as an exhaustive list. But others really are very much volunteer lead
and getting a reliable and remote lab setup really is a lot of work, so
no one has done it. Rockchip is an unfortunate example here that I know
you run in to. I have an rk3399 I've been trying to find time and space
to get up in the sage lab, for example, but it's still just not there.

Some of this in turn has been held back by a historical lack of a legal
entity for companies to work with that represents the project. We have
part of this solved now, so I am hoping we can make progress in the
future, once we fully finish migrating to community owned
infrastructure. Other parts of it indeed might shake out as part of more
broad usage of at least arm64 platforms in general Linux distributions.

--=20
Tom

--0wgSt/NKk+Cq6UaU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakLv8gAKCRAr4qD1Cr/k
CgvkAP9LlpF9E/sxyCAg3eZeb3hpfXtwZNH/rYAkdqIcfgHjvgEApV8gPzovI38f
Aw8h/TxKA6a842aoke+Rdp1krspDIAI=
=iDnz
-----END PGP SIGNATURE-----

--0wgSt/NKk+Cq6UaU--
