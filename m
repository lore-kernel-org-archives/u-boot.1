Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D58CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 16:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7F85846DD;
	Wed, 20 May 2026 18:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YlE9upW+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BF38846E1; Wed, 20 May 2026 18:09:52 +0200 (CEST)
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D4138464D
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 18:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc44.google.com with SMTP id
 006d021491bc7-6966f99716fso2643188eaf.0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779293388; x=1779898188; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6L7pHBhcNLejFpIUuRfgJAd9u4aVxkdJFu4r3ZuesR0=;
 b=YlE9upW+mkv4/7b+RFj8ncgwa+mnCSrOgFqjaVx6CgZ5k/5HzHZL9uHfMmz9BdN+bF
 La9qllw9co4Fg9nxif3aGQhyl3brQhLMA1TJezbiwPb3rvh5R5btt2WIewGzU4nTSWaX
 4rTsQlfHE+cPYnKmP/TK7zMZJYdlLSGWYoJUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779293388; x=1779898188;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6L7pHBhcNLejFpIUuRfgJAd9u4aVxkdJFu4r3ZuesR0=;
 b=TiitM8gKUkGSZ1VKy7EOuVmJ5snqriGiW3quaAq4SXoSjGG16tqLVqNtiSW96a9nTu
 vNZUCCM+lmSuM9E+LXLjC8+vSpwsAtYHPGLWnE0XJ62Zht3TE5nkC/xedkdmnkLRPddg
 RNBeYJ99JWOM1iv+JwlLWRp12kst57jXkNLlUgTnVXTDICsuguofn6Z2SKuwC4CoJH9+
 yjQE2v18EFxhN58nbWNFYsjR9flGgBP4EQBREOLUlhayzFqlHy4Vk2bh2QLmfjM1SEg3
 VQEBP3L8Dz7aY9inJ1ukncUG+iGYCCDLe4ITyp5kOzQrk0xqteehdJn0hOk9Hbku3EVR
 qyxg==
X-Gm-Message-State: AOJu0Yz2JaIkPZveyNVMPSpiBcWlv98fCh6/r+vZ6fG9cNEwmvXQ8YG+
 LWoLrFS4r1LThWs0+NE4OIq4Pbvik7pGfpmYS2BtLfGjLHseBNWMvVeo16Fgwrqe6LU=
X-Gm-Gg: Acq92OF+IeE68qp/scIMvSlu0sEA9Op3WdA+n6M2f7GYDZt/8h6njjuHDXQRyG1vvFF
 qTpo485tYaMdYkRJWpG7h6bAABinQFoDnpbiXUX8h4r+PS8ohK6wminYpaERNj2in1APyKJjrIb
 E/WKdd09ZYOiy/IqTZjXZyxDE2yv1TAVgPlDRC5hfihR16bAdZ9KiOhBWrP3/MvyGxWmh/YsYIm
 BDRU2uqbA9H3pedr8SxkbpVTr/D9usDKL9i3dskDFcbhn+euzh5OTwyWtgn8rz7rHC/N4Wv8TR0
 4fIyAgAIkeKE802vH4IZkHHbzM2bIf8YdWiWF3zkQ821H5tFkRJSvO9BIXjSKTUJKCKtpO4rRAb
 iwVTFC1eAR26CzMEF+JLtiiAa6NvpPmJYxki/867VdFQ9ZuV4vX/YZGpl7DnRxHgmjJo/5flex+
 QjPdyB9t0t87flKOaoyZWwRb/KvSbl0sHXZD/N9kVyjD3EsARFFVCDsm9lHKKhwiiq7NwBnFz6I
 okIR02ba7AIwKbquorbTUL6t+UNTIcwN2uhNVdsBjNAnpPxBLM=
X-Received: by 2002:a05:6820:2911:b0:67e:2988:15e1 with SMTP id
 006d021491bc7-69c942ffc08mr15824162eaf.16.1779293388167; 
 Wed, 20 May 2026 09:09:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d048b246fsm9026296eaf.10.2026.05.20.09.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:09:47 -0700 (PDT)
Date: Wed, 20 May 2026 10:09:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.denx.de, Vulnerability REsearch <vr@binarly.io>
Subject: Re: Multiple vulnerabilities in the U-Boot FIT image signature
 verification logic
Message-ID: <20260520160945.GN1858239@bill-the-cat>
References: <CAPWaX55jG=pc+SD09V_z4T5q8qBcetZ8OJeKnrDF6w7pQ=tr1Q@mail.gmail.com>
 <20260520143639.GM1858239@bill-the-cat>
 <CAPWaX56ZFuBYURp9m7HMjYf25_sDA2dpEP_8H1h6Z0=ke=_0xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YI1lccCHzB+Ixegg"
Content-Disposition: inline
In-Reply-To: <CAPWaX56ZFuBYURp9m7HMjYf25_sDA2dpEP_8H1h6Z0=ke=_0xA@mail.gmail.com>
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


--YI1lccCHzB+Ixegg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 05:02:19PM +0100, Anton Ivanov wrote:

> Hi Tom, nice to meet you.
>=20
> While we understand your concerns about AI-assisted vulnerability research
> and AI-generated security reports, we're not sure why you think these
> advisories don't require attention.

I'm not saying they don't require attention. But I am saying I'm not,
and I don't think anyone else should either, without the reporting human
doing, well, what's outlined in the various links I've sent, pay
attention. The hard part has rarely been finding a bug, it's been
dealing with fixing it and verifying it's a problem.

> We have recently started using AI tools for vulnerability research
> projects. We use it responsibly, conducting several rounds of human revie=
w.
> We have confirmed that all the security issues described in these reports
> are valid. Furthermore, each advisory contains a PoC section that
> demonstrates how the vulnerable code can be triggered to lead to DoS or
> arbitrary code execution, as in the case of BRLY-2026-038. We used either
> sandbox_defconfig or qemu_arm_defconfig builds to confirm this.
>=20
> As for the content of the reports, we strongly believe that they contain
> the minimum amount of information required to understand the vulnerabilit=
y,
> including the PoC and suggestions for fixes, as well as the other common
> information, such as the CVSS score and disclosure timeline. We understand
> that this format may feel unusual to you, but this is how we typically
> report vulnerabilities. You can find more examples in
> https://github.com/binarly-io/Vulnerability-REsearch. Please note that mo=
st
> of the advisories were created before the AI era.

That's good to know. Unfortunately the bar for entry in the security
research world is now zero and so as a volunteer and community project,
we don't have time to investigate if every reporter represents someone
with a long standing history or someone new that unleashed an LLM agent
on things without a general understanding. That means the bar for
reporting from long time researchers is much higher than it used to be.

> As an alternative, to save everyone time, we can provide the necessary
> patches to resolve these issues. Does this sound good to you?

So yes, following the general project guidelines for submitting patches
as I sent before, and also if applicable
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/process/coding-assistants.rst
a patch to fix the problem, and updating our test suites if possible to
catch regressions, would be appreciated. Thanks.

--=20
Tom

--YI1lccCHzB+Ixegg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCag3cxgAKCRAr4qD1Cr/k
Cjl3AQD3xIudeHMml2KAGGjT1LpqYuZMVq3Xm1ApBhwMXkc6WAD8DJBOX+GPhNGA
M8mKPfqZ1ae40t7Jk/lvF1RgZE6h5gs=
=JGxp
-----END PGP SIGNATURE-----

--YI1lccCHzB+Ixegg--
