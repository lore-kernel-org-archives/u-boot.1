Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D4DCE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 15:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7605A83BB1;
	Mon, 17 Nov 2025 16:18:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FqeKOSg/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60E1383BBE; Mon, 17 Nov 2025 16:18:23 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B07A83BAD
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 16:18:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-64088c6b309so7151002a12.0
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 07:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763392701; x=1763997501; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VG8CVPmV7Iq1DoPUIifJdmBQHAD0JzoQdrkMTtTIcb8=;
 b=FqeKOSg/NFCHSRbceB/wuFPScmLFONfrrVJEytxlYuB3pHH4ObNP9TbRJGmEdLpfwD
 J8yH+d/yPj6MGhnRGMXBBXi5X89zUZ6LshMY0ze4TYOvjmEIKrWqasD+NJoD4maUgVhE
 Pw4eSzXjA8u2mP7JAMXXxMaaqT1PzYDqfG2VjbFj7dynM+C19HQ4ABGt1x+18Hp/ExYX
 MjntUaTJxwZzs8LHHvaM6JnUb3fISwMtX3X1PYDGyT8K125PhdnwPlDvQ/8ILT0Hh+ky
 pOH6iayJC1BWQu27fWKppYVFSWPLjylj0l2wnmghFKdBU5ImCjdKUnDy1aQ0rLBpcjkx
 RAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763392701; x=1763997501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VG8CVPmV7Iq1DoPUIifJdmBQHAD0JzoQdrkMTtTIcb8=;
 b=amNmGaARkxTiGVvPLRxVRxm0+I18qnj9hj3bo/QCnZ0I3VErnKCRwNHr9a6sf3mRhL
 I1LXsqq4C8Iph1sf/NuhZCXEd0U3rpjOZshKv6ZYxgmrhTepyoPzrY3H0AGy5RPUdhoo
 rvwrU3o3rw6qKKSeDe2BopqS5priXRIuEnQGDAsLEpQe6iDMCs5DDhRDu/uf+1jty6E4
 2AG/K5263wkQya5NPMNkYI3mVyxi2lROgRc0MnKv91ksq5s8rN33khlGKPUzH/Ei5lRt
 LwXQOm/YA7uluawYayL8x4u/er5WpPF+FuMZpfaj+JFxqpL6TBSMBMjnuJnFzOdBtHtw
 iszQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtdtYP+rlLptkVU8+uUD7iwrYEmsQ+zuiwOdyaSMEWHjel3sYs7TiyyTih+7WUl3cGe1qWqj4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2/gWxhxOjxl+yF/pNwCd6Bj0HhfORH4guIvPlhK10OUAIU6oY
 tgoSy6aBaN+MFtiTstsDDYZPGqpQw3aFkCVeUOXijByh2mHbRurVrDXBQvwwXz80C/QFdlNWHgR
 lflacoY3lKrE2FLTYvflIwSHsgRK/O1c=
X-Gm-Gg: ASbGncshhkFYWcMeuEHwkfZyq6XpmU+ymZTlP5FqLaQPU+62VX6XE6nxVo7mmt78w86
 F7U74ywV5UsaG7F0nZp+ffr0fVXPRYIf1K1+yxBX22kM5WmJtbV04vKxKGXByzgkKzWA+00lSYW
 mawec+LnDBC0zCcCrMpcucVXDwCGOv+PwlEEbtMC6DeExhKcQIjzaXcf2LwAnIPhh/TMkKS8gpO
 XKV9k3tx+kKMfa4762oMMG33q5Ru7imnvFE3yFpgaT2owj+4A4WRkSMxl3i0EWpvTsGCtpcXfe9
 1/ACsWDe1aTPUxPUM7LdN6h4DiCkPlNNFdr+pVkNKt3649Mp//nommog6EfbaGMb8kFgDz7jGWD
 eg0pAt8Kjn+AC3ln2rWxh8UYwsnJOV0HSWHzSXdUXztrUWsPAdwvcR9Q5q3csv5pgqV2tb8jbom
 o=
X-Google-Smtp-Source: AGHT+IFvQehDMj1qipBJX1eK5S5v6JJX7xuISw7fgvoDYZhMdHyN/GsHbgxD6I5p56FwDAgwASY5O4CtQp/eNlYvRvc=
X-Received: by 2002:a05:6402:1d49:b0:640:a7a9:289f with SMTP id
 4fb4d7f45d1cf-64350e04fb0mr10747985a12.2.1763392700548; Mon, 17 Nov 2025
 07:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <20251031-binman-engine-v1-3-c13c1b5dac43@cherry.de>
 <CALeDE9MYi2+u_ek1Rapmzx2_T9uE_cQcH8paKgxKwZjtGJ2gzg@mail.gmail.com>
 <DB9PR06MB85123A4CF4B3A698386F9EE9CBCFA@DB9PR06MB8512.eurprd06.prod.outlook.com>
In-Reply-To: <DB9PR06MB85123A4CF4B3A698386F9EE9CBCFA@DB9PR06MB8512.eurprd06.prod.outlook.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 17 Nov 2025 15:18:08 +0000
X-Gm-Features: AWmQ_bmaLTvSN64ABMJmY5eh36RxYOtccOFvdvIOPhZhkQFnwmOjr_D9VNIE9LA
Message-ID: <CALeDE9PswgDAG=1Ouy5W02FKZRFskqc3tx967SVms+MTL8Z1Ng@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools: binman: fit: add support for OpenSSL engines
To: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Bryan Brattlof <bb@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 11 Nov 2025 at 10:14, Wolfgang Wallner
<wolfgang.wallner@br-automation.com> wrote:
>
> Hi Peter,
>
> > > This adds support for using an OpenSSL engine for signing a FIT image.
> > > To use it, one should set the fit,sign-engine property at the FIT node
> > > level with the engine to use. This will in turn call mkimage with the -N
> > > option.
> >
> > Just to be aware this should likely be a OpenSSL provider, engines in
> > OpenSSL are deprecated and due to be removed in 4.0. A lot of distros
> > are already dropping support for engines. There's a patch [1] adding
> > support for Providers support to U-Boot, I suspect we shouldn't be
> > adding more deps on the Engine support. OpenSSL 4 is due in March.
>
> I'm aware that the engine API is deprecated in OpenSSL, and that the provider
> API is the way to go forward.
>
> But the PKI provider of my employer currently only provides a PKCS#11 library
> with an engine API, and I'm not aware of any plans yet if/when they will
> be supporting the provider API.
>
> So for the transition period it would be nice to keep the engine API around as
> such use cases still depend on it.

my comment wasn't so much about removing engine support but rather
having parity with the newer version so that when users upgrade they
don't end up being stuck with broken functionality.
