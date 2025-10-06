Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12051CCA470
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 19:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61C7D83D5D;
	Mon,  6 Oct 2025 21:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hOxsGnA4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A609983B64; Mon,  6 Oct 2025 21:14:16 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10AD483BC4
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 21:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-938c85ccabcso225922939f.0
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 12:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759778051; x=1760382851; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I/h9EicOBeIODh//nd11Lf7Ygh/kU9kBcrz35CVAg0s=;
 b=hOxsGnA4pklIcfhoxHg9gIrR+xQec20WVCTs0uL+v+21FIba/Tmy2SEuHCrrvRb9mm
 g+qRO1Qc5qlmIMeusA/HpifKOCxsL5hHLGSN4B8vHWB3WZLPdowCGMFT21q6k+NJsQdo
 GnRPWFygw3H4rljkXoFTCoQ6ObuEOs1LLc0hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759778051; x=1760382851;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I/h9EicOBeIODh//nd11Lf7Ygh/kU9kBcrz35CVAg0s=;
 b=gMvJp2RqMxhU71rn4sbrmskSQNru8ohhLOhkQw9fI4Nec2eMZBlwdor/WDEfzVkdS3
 RaDk0b8JChbM8xf6VSKt0egSLqd+YbkBRTnJ003Xw0pNd3cVSeczZYgFcBxtSZ8gRX4F
 v4AGr2n75gAg+BzIMwd9UXZI1L5jtSDUmglSJObipYp6E7W15LXhhYAg9aXrDPaWSp0r
 UYUyrEpaJSPTP8FhNiToaUh0d8+enFNSlQqvc7bI26AvEn1NAm8RAab+xPOlYFAqx4+M
 yn4Ua0o0j56EfhN9DyAcGaPEGmo1BqcbytHzeY/KgUDrlGqkvfd27kJJTtZ9gJ8MF5ew
 azaQ==
X-Gm-Message-State: AOJu0YxSpJZUSd7prFaxbuy2eySKG0wljJxevA1/KwC4ow8+XVefIUVR
 Dcr7ZCMW7bwiTJvTZfkEumZbw4B7cHRFIYcQqpW9P/fCsVjAWpeWc3KNYFOEqp8xUYntPTzwr+d
 JqX/8a9M=
X-Gm-Gg: ASbGnctCHqQc9z1OaZE7EE8pUzvACeVRws9+cL39yWADzKy15vW4yqxevTVwytIleyF
 70R2EIp/P1lTz6n8/7UvOu0ZmatLdHA7wl7TizxFQ5PmpA167OBF+QJYdKH0Qbb+osGfzVN0llj
 0uIjwTZoayvzSIwN+aTLHVAx4kdtLYWzMdsC9wt1A94yLtnIpl3cVuDLOUOed9MaFK/NAqi/Ubj
 MxDJNAylgtjyediWbhnwmyH+NMyBFDgbOi9JclqCiO7KC4bVD396DmSpnjOJy2CdsV1c6LstZ5X
 tz2QWwDRHntI1JXO/UNjVRxLyyQMfpz+vE7rJrTM8yP8k5QyG2X76/ZYDLCKEa2FuUxTLmgiKV7
 3ay+8prKltmCjxbhy4EuI3x78QLDyfB4b9mDu6klwLRYEHWE7BqzYekAhniX0BOxuSyeoZ5EonH
 kShoIn/QRSiMwphYZBczXbgUxBeNmSP9o=
X-Google-Smtp-Source: AGHT+IH9Q+2hTqrjcN8L1B7flqIJLgT0OdrxR8hzNGp+Bovho5O52yAyCWI7tIM5Ms6CuEUO93nz5g==
X-Received: by 2002:a05:6602:a107:b0:918:46b7:4d35 with SMTP id
 ca18e2360f4ac-93bc412cf0fmr75857739f.6.1759778050635; 
 Mon, 06 Oct 2025 12:14:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a88b580f1sm493972639f.23.2025.10.06.12.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 12:14:08 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:14:06 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.10 released
Message-ID: <20251006191406.GB298503@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HKQbI5npPzfMHjry"
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


--HKQbI5npPzfMHjry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and so here is v2025.10. I will be merging the next
branch back to master shortly and pushing that out as well.

As this is a full release, and not just a release candidate I'm once
again hoping for a few more people to read this than do my -rc emails or
just regular mailing list posts.  As I mentioned with the v2025.07
release, I was looking for a few people to step up and help with the
overall organization and management of the project. To that end, Peter
Robinson and Neil Armstrong have stepped up and have been helping me.
This has been part of the process for the project to join up under the
Software Freedom Conservancy's (SFC) umbrella and have a legal entity
that can help the project work with other legal entities on things like
donations. To that end, we'll have representatives from SFC on the next
call to answer any questions or concerns people might have.

With that said, we'll have our regularly
scheduled community meeting tomorrow.  The meeting details itself are:
https://meet.google.com/btj-wgcg-euw
October 7th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

A high level changelog from v2025.07 until now is:
- Updates to some of our python tooling, both the tools themselves and
  documentation / usability of them for some of the platform specific
  portions.
- Upstream device trees resynced with v6.16-dts tag.
- Lots of cleanups around implicit header inclusions. Out of tree boards
  might now fail to compile because they had gotten <env.h> or some
  other common headers implicitly included from something else for
  example.
- Our Kbuild infrastructure has been resynced with v5.1 of the Linux
  Kernel (and more is under development still).
- Improvements to numerous ARM platforms from TI (K3 and AM33xx),
  MediaTek, STM32, NXP i.MX, Renesas R-Car, Qualcomm (both Snapdragon
  and IQx families), Allwinner, AMD/Xilinx, Atmel, Marvell, Rockchip,
  SoCFPGA, Tegra, Samsung. If custodians want to follow-up and highlight
  specifics please do.
- Updates and some new RISC-V platforms as well.
- Standard boot now has RAUC support.
- The LMB rework that went in to the "next" branch near the begining of
  that window is now here.
- A large number of code correctness problems found by Smatch have been
  fixed.
- Both more and better documentation in a lot of places which is in our
  generated readthedocs output now.
- Improvements in both our legacy networking stack, lwIP support and
  areas shared by both stacks.

And I'm sure there's things I've missed.

With all of that said, we're on our usual cycle of 3 weeks for -rc1,
which will be October 27th and then every other week for -rc tags until the
release of v2026.01 on January 5th, 2026.

Thanks all!

--=20
Tom

--HKQbI5npPzfMHjry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOQU/gAKCRAr4qD1Cr/k
Co1dAQCch602FmaSyaj8kHn4DUPzhTr9fZZK7Diz9JXFqKmvugD6AwclRBn6hpDc
gDXiCD8NvwR9a9CxSM5eP6G2Zud5+wk=
=JCFw
-----END PGP SIGNATURE-----

--HKQbI5npPzfMHjry--
