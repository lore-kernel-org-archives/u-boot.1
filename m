Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FCCCF45D4
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 22:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 929F5836A3;
	Mon, 12 Jan 2026 23:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZxzE2QlV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A28B8388D; Mon, 12 Jan 2026 23:03:32 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9FFA80077
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 23:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7cfb21a52a8so946276a34.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 14:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768255408; x=1768860208; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=71yx8/11vKFuGvEy/6v3J7rFgKY3gPrvwTFmW+67Zkg=;
 b=ZxzE2QlVPrTg5wELatbHfHHgsriyKtbKBZOUo3hMEsCxdLcj+WrQdnud08u/E1mRux
 wwu0jdwbcrsLZgHrxxZ0lvtBpbMpfwWHafuJ4Ie/ct++TRkjPXC4f5vBqr5FCA1Az14M
 vG8rdBO3s0ku+OgGqmXRp4QKeH54t7LR0/E5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768255408; x=1768860208;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=71yx8/11vKFuGvEy/6v3J7rFgKY3gPrvwTFmW+67Zkg=;
 b=QnixVJmw7HI2hgSDIevJc2Qvn/UdWPN7u+vSo3HoNwL7K+mAFPWO68rzjdJXYWe7ZK
 6h4V1TIBnZTvvEYNmFfR52z7oO5JCD5CL+f/SQi4cXQgdKStD56yDM5kjNhjTShfgTNt
 nTe24+COVzjIrDojJFx2tv3UjJCWUFGNUkHcDQ8nkrCXMvcUYF80XQPVXYKSZwux3g5t
 QNRP2SlQFQpKc18l1O2J7nkzEfE6YI1243tgPXOlWeH6lUJpawXkGG5QNpOc4xo6f3BX
 Yy3PacvcSlJof8VK9F5NjUIshevElmNt7CNnG9VWWpBeDgH0krCCWuCnA50ifipnMlfS
 eBxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6kw6zScG/HxZhoNPgZ3alxJ96SnP1mhNFDJVPbSb9C0G0SpbmeLOdtQjtTVQBEiZFOQXO8bY=@lists.denx.de
X-Gm-Message-State: AOJu0YxoQVG+7WZcO6VRA7GijgBEfFwVXOcCOuseKsgz+KJRNDCd0k3A
 xmpgGUzgP6NMmgRtsVUgEZsRp151R9w5llMK4OnsCh9BMaEj5NcQU8THudi58MMBBY4=
X-Gm-Gg: AY/fxX7ZnUlTG/FV7/wtZepGzniiwuD993937bigk0LDEPyePyh6AEsrK5XcvZFoktc
 OxEcSxsXTDunrFvSbtbsgKMLckvAHSU3CmvRdYU7QULD9iB/qLTcR8YK8pE4tNz/fQ7Ed2JK+kU
 BT+aQBCZKNXExi+scCqRJs14Ta30TwCCQ7/S8GD+lqUFWVpSFKL8OrjZzNsb4tgKN1S/EFLXeGc
 BgaX//Ey74wO9ATRoYUGs1jjy7SgSl4fyl56ZuFY1psatJ6vqVL/G5H+m5s6vv2oBmOulR+FIDq
 4cbcxxADyewCjrUHTM0MMCHhnJaylhM07n7O5X839YOZdB73BNY/nizZHKLrh5x+AqRgkdleKfL
 Ae+H63qVEhrG3sobXjTLnrnOwiRxntg0FcNuPv0OI+a2Q+irbqlO089DJmWv7ANBjlt300lanvG
 UEYOh63K6H4cRUYQOYPxdgDQNfdsesBGL/gY7GroOlexNVnIwsy9NClgAdNtFv5hkDrwBBkVJeA
 E341Q7z5P035z5mazQuadv8WYiMGkWPiXBFMhxpb1M/n7VLKw==
X-Google-Smtp-Source: AGHT+IElYnhOCFWLdklU7//PnF22U55xiUN0sDVzRljXc55st3ZNHHu9BPlTmCMvtEaGHETxEGABJQ==
X-Received: by 2002:a05:6830:441e:b0:7c7:501f:4bce with SMTP id
 46e09a7af769-7ce50a6dbcbmr10630535a34.25.1768255408629; 
 Mon, 12 Jan 2026 14:03:28 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce4781eecasm13848691a34.10.2026.01.12.14.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 14:03:27 -0800 (PST)
Date: Mon, 12 Jan 2026 16:03:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: "Padhi, Beleswar" <b-padhi@ti.com>, ilias.apalodimas@linaro.org,
 malysagreg@gmail.com, sughosh.ganu@linaro.org,
 philip.molloy@analog.com, james.hilliard1@gmail.com, anshuld@ti.com,
 afd@ti.com, nm@ti.com, vigneshr@ti.com, n-francis@ti.com,
 u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] scripts/Makefile.xpl: Align filtered DTB to
 8-byte within multidtb.fit
Message-ID: <20260112220323.GT3416603@bill-the-cat>
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-2-b-padhi@ti.com>
 <9257e248-512f-4c42-999b-0f8c4f0f92b7@mailbox.org>
 <2854b18c-324f-4052-a6e5-538df6a0bcab@ti.com>
 <a799f9d0-e369-4ccf-8c64-60623143ca86@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c2F8kaiNdtqhyUWZ"
Content-Disposition: inline
In-Reply-To: <a799f9d0-e369-4ccf-8c64-60623143ca86@mailbox.org>
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


--c2F8kaiNdtqhyUWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 10:57:46PM +0100, Marek Vasut wrote:
> On 1/12/26 6:25 PM, Padhi, Beleswar wrote:
> >=20
> > On 1/12/2026 8:09 PM, Marek Vasut wrote:
> > > On 1/12/26 11:11 AM, Beleswar Padhi wrote:
> > > > When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
> > > > packed inside the multidtb.fit FIT image. While the individual DTBs
> > > > and the FIT image start address are 8-byte aligned, the DTBs embedd=
ed
> > > > within the FIT image are not guaranteed to maintain 8-byte alignmen=
t.
> > >=20
> > > Because DT properties are 4-byte aligned, and fitImage is a DT with
> > > long binary strings encoded in them. But that is not the case here,
> > > because the invocation does use mkimage -E .
> > >=20
> > > Therefore I see two issues:
> > > - Should the code which handles LEGACY fitImages with 4-byte
> > > alignment be fixed to relocate the blobs ? I think yes.
> >=20
> >=20
> > This we can fix in the Makefile via the dd command as suggested by Tom.
>=20
> My concern is about LEGACY fitImages (means already generated ones), not
> newly generated ones.

Why is that a concern? If it's a legacy fitImage for the OS, we relocate
the device tree already normally to be aligned. If it's a legacy
fitImage of U-Boot, it's an old U-Boot?

> > > - Should mkimage -E align blobs to 8 bytes by default ? I think yes,
> > > and frankly, I thought it does so already, but apparently not.
> >=20
> >=20
> > This can be done, but should it be? Not all FITs demand an 8-byte
> > alignment right? It is only the FDT which requires this.
> Maybe if image type is flat_dt, it should be implicitly 8-byte aligned th=
en
> ?

Well, the device tree spec says 8-byte alignment. It's not "FDT for OS"
that's 8-byte, it's any device tree should start out 8 byte aligned, and
everything else should then be naturally aligned. If we're looking in a
device tree for another device tree to use in place and not relocate
then that second tree must be aligned.

Or am I missing something?

--=20
Tom

--c2F8kaiNdtqhyUWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWVvpwAKCRAr4qD1Cr/k
ChnLAQD3JGVX2GjtvtpkfC9btFvEoWpARcy270iryxnZknBE3AD9HFEkBWdw4QFV
PvKE16K2IOTeLbIAwICdV2opPesPKgw=
=AP1H
-----END PGP SIGNATURE-----

--c2F8kaiNdtqhyUWZ--
