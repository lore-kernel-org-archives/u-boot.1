Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00297CF9C40
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C03F8409B;
	Thu, 20 Nov 2025 17:16:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZFqYhKc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99EEB840AA; Thu, 20 Nov 2025 17:16:54 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 698AC83A6A
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c78d30649aso770790a34.2
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763655411; x=1764260211; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ho4AkgH/Ex0g72TG7JR3/ghv0Usj//C7iP/FNzE7qFE=;
 b=ZFqYhKc1wtf7ougKVzZjO0pchEQQCIgIQq/0DZQKcDEdnwC2SMlKGUjMvwDPbwOSS0
 y93Aw9zinOBt1dZZ1xd4yWLun9ZzYM8oAjHLXfP7ZqzHoJZY9SwCj5KetjkugOKb1qT9
 nzmn7Z6UygOmfg1tpXlNLtDjB/mj5C6csynQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763655411; x=1764260211;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ho4AkgH/Ex0g72TG7JR3/ghv0Usj//C7iP/FNzE7qFE=;
 b=K8jlMpYVwFzY57MBrVuCVDZ/E+mLJcu4kHXgdqsbBk4irStxO333H+8Gd8a/i8CnJu
 dda6lW1fairY6dzkTyW67+4p1/OX6qjYy5He044VRIv4oTTpVFHRHKCCSnz0eesmk5oM
 Ma7vO7H1VzjHn6F+gSZ1uWLa5kU832MF6qdVsidEhKSk+nKQ1ieMLI8g4faHZRoIERo0
 tG8wSa+GKtSC7FSYUWtgOBY38RcGV4f3y8pqviXszxpNpzcDWl2hp3WufrFce1uWrH6x
 wDOezAJe2fE9741mOlsNwaQPm7ceRIpK2jwekf3gegk77DWMgLqtWYiwigP/pRtuk1cC
 iI2Q==
X-Gm-Message-State: AOJu0YwGMOX6PEuuwx3jQkQZuzFhGbdsN5kfwU8sO8Q+EAJpm7gOM1QH
 ohKHQIpsest5qruZ1om+qMrAcoii71sdh/QcAbolkgdL+9ntg/Ciohkk3ic4iD5q3gc=
X-Gm-Gg: ASbGncvp5x3xrUMgn6fNR4F87XbFPBDBQIjePBSIN3pEIUNce8ErQnS9DNxpI/a/t3G
 /uZFweiFbWKPV5TDiNaX2p/GDm9OQ+38NbO3KVvhmz0aGWTMfMMGlY1bPQPJzz/6Rye5we7vdZK
 0M51dL4S353yY72v9P0GpupYAKbiGiYO/vH5mCryT99QyJIIUe/m8BtGJ2FpyBlqKKDI8RbxXgW
 vXSml3NUL+2orxTdIhDZkAuT5LqHcKD8J3vGZMo/6PI8WhmoL4fTZ8Jls/6Dg9aWbJPGZ8PcubH
 5a5Vo8kCGp+SmYZnq5KDOagts0sAGTtoZkIoMrSRKhH6Xvnu/BmujUkTXBidRTzx0AaSEJmRl0n
 HQWJukOQchWnElYp+ocIkpTPH8nLslBSGmh6XyGrc0NyzHXQD1DyjbuYACId+ETK1CCg1Bz4Zpz
 B9coxhytOtQsKAW7vTO0+3gFrQJlCZzhk37/0CAlitw+trSiAwlA==
X-Google-Smtp-Source: AGHT+IFaMOJUVasG7x29xLvfzrdys5vCtJEWzl+Fmr31++VT+GEtpOtjwsZkHJpxxKYMaBvSS9T/yg==
X-Received: by 2002:a05:6830:7105:b0:7c6:cedd:8bf8 with SMTP id
 46e09a7af769-7c78d2f1262mr1948102a34.27.1763655411101; 
 Thu, 20 Nov 2025 08:16:51 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d306196sm1148698a34.2.2025.11.20.08.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:16:50 -0800 (PST)
Date: Thu, 20 Nov 2025 10:16:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] tegra: Stop disabling device tree relocation
Message-ID: <20251120161648.GL2125796@bill-the-cat>
References: <20251119145540.843448-1-trini@konsulko.com>
 <CAPVz0n1wXCZpy0Ngvr60EdiNLeBP42s8Coyo5ujFO+cwV+ZwUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2KBWLOPyYQ7RUTHB"
Content-Disposition: inline
In-Reply-To: <CAPVz0n1wXCZpy0Ngvr60EdiNLeBP42s8Coyo5ujFO+cwV+ZwUA@mail.gmail.com>
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


--2KBWLOPyYQ7RUTHB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 06:13:43PM +0200, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 19 =D0=BB=D0=B8=D1=81=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16=
:55 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Remove setting of fdt_high to ~0, which disables device tree relocation,
> > from the default environment. Doing so prevents U-Boot from correcting
> > problems such as having an unaligned device tree and leads to various
> > failure modes in the OS.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > If there is some window of memory that must be used for where the device
> > tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
> > or bootm_mapsize are the correct way do this. Please see
> > doc/usage/environment.rst for more details.
> >
> > Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> > Cc: Thierry Reding <treding@nvidia.com>
> > ---
> >  include/configs/tegra-common-post.h | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/include/configs/tegra-common-post.h b/include/configs/tegr=
a-common-post.h
> > index 2f08dfed020f..a9c0cea4e149 100644
> > --- a/include/configs/tegra-common-post.h
> > +++ b/include/configs/tegra-common-post.h
> > @@ -50,17 +50,14 @@
> >  #endif
> >
> >  #ifdef CONFIG_ARM64
> > -#define FDT_HIGH "ffffffffffffffff"
> >  #define INITRD_HIGH "ffffffffffffffff"
> >  #else
> > -#define FDT_HIGH "ffffffff"
> >  #define INITRD_HIGH "ffffffff"
> >  #endif
> >
> >  #define CFG_EXTRA_ENV_SETTINGS \
> >         TEGRA_DEVICE_SETTINGS \
> >         MEM_LAYOUT_ENV_SETTINGS \
> > -       "fdt_high=3D" FDT_HIGH "\0" \
> >         "initrd_high=3D" INITRD_HIGH "\0" \
> >         "boot_targets=3D" BOOT_TARGETS "\0" \
> >         BOARD_EXTRA_ENV_SETTINGS
> > --
> > 2.43.0
> >
>=20
> Thank you! Overall change seems to be valid and should not break
> anything. Unfortunately, ATM I have some major technical difficulties
> with testing and PC access overall. I try to find an opportunity to
> test and verify it ASAP. Would you mind if I include note after ---
> into commit message? (no additional actions needed from you).

Yes, please feel free to amend the commit message when you take this to
your tree. It's not urgently needed (this is for v2026.04) and will be
preceded in the tree by the patch that warns users that fdt_high is set
like this and so may cause problems.

--=20
Tom

--2KBWLOPyYQ7RUTHB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR8+8AAKCRAr4qD1Cr/k
CsiOAP9OKtI7Fj4mYuL6rOUWfT0WPqDJvlEM2pg4QBxgdrfHlQD/ZZADirMRc3eP
PKxJXhzxQo6v3X84SJoP+EnbWgHnaAU=
=tSYR
-----END PGP SIGNATURE-----

--2KBWLOPyYQ7RUTHB--
