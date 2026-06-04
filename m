Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F9ECD6E75
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 17:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1E908493A;
	Thu,  4 Jun 2026 19:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="J0/17lhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4794B84957; Thu,  4 Jun 2026 19:17:12 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 521A2848DF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 19:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-68e5f7c1131so1808379a12.2
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 10:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780593430; cv=none;
 d=google.com; s=arc-20240605;
 b=D6UG9P8AhYt19UczACzRLUDxFBwmOggWleR/5Zrpsd743zofIzYCeNm9QCVJOgJMdi
 +wuGOekDjUu2iu8OJtzGp4Jl5tm2d3YfZ2Yfgt936ZzzLn/mPxcQDQKh40hMvePOt3ZU
 XV17YrLz27u32DnATvQN0M5RwkLprgSzeI9gz+K/Z6++GMvfow1tY8d1ZjN4bwZLQHbe
 nRHsb1xb+N/bOOKg4P4VCtutUVJ5JPHMguNpbVAGMK3ngf3mcoucwvR7FDdwWlET88yN
 5sa9yPmYqVU/QekzzNd/FlN7XVy+Llk3AeVxmmJDeqHm8qJGkVXU3VwvZN8WMYxyPKip
 TXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k65FIo4tAzUkthDVPMsUuensqoSf2RNyWZXA5R4Qe6o=;
 fh=CizVzkhoIphOMTLPi+ZX9XSsICPt2R1OOdm20ifr28U=;
 b=JmeN/UYVuyFSTNntphFc7l9l1XxyNxytOYWZQmdDM/KxspdMCCHFyim+VoW4Z0MmEP
 vPUifrsFpqnkwC72pOmfkjAd/67Q5IhKl6T5/7w0aj27+W/3IHahrcitN/i2DAwIiZHu
 W8TB4W++BDDGEidEAMWiAPeeYhYfgPgjisKROZgHD0lN7AhW6YxhDRzOq+zkoi39bF7S
 aziXJ3IHdQYbnAWk9BdHTXURxGrx/mIFwpLSC+pANdRscWxw/aMLTr3FZQGfcDyTJ0X/
 jICAOLWNHbfksSVXbMOUe7hDGIIh7RE697J/9cpoQweidLUNAvMSUnOHp6Vegd/sLKtV
 4yLg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780593430; x=1781198230; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k65FIo4tAzUkthDVPMsUuensqoSf2RNyWZXA5R4Qe6o=;
 b=J0/17lhVdqb/Wn5CgVQzt7HW+KvIaVbMPKJu2u3z18FjYJZ+CnTRdlArwSM3pxPqmS
 o1Ojb/VbckvIC5fVKfrLjT1MWsoEuyR9qkemAcd4vVnt3uejAwEl8TEG8Jc954FzewLO
 DIPCTxUI7hT1AX8VOYOwGTB2aBxTQ/ATrjcFZS5R8MzmTCGNadTojSw1aT384x+oGbsY
 ydv4yAJly8e8VnUhvRGoTXdREVJ1UhC2Nh+e24PP3806IqiSOoSNgHROzIs367vg+PZz
 w+aXKgHfuxukJPPMmkco+WsJyNnwq5Vo7D+IxNNLyX1HTZhyo7dkvq6fp79Cnjx/J+Ff
 mw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780593430; x=1781198230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k65FIo4tAzUkthDVPMsUuensqoSf2RNyWZXA5R4Qe6o=;
 b=DGJey6Hw9WLL5zJ/ZnAwyB4DNng1b79leuPSHlzlfKnuRBY9ynkSb5NckJ/FAQGypB
 Oe5bq6c9iRqhvOTmlesJ5xzUZP9i3y3kSZvpRXjQHwHbmBxonPllL1A8CAvTZzwr/UPW
 fX77Yniwj/lmIL4/EsSVy51IbE9xk7qf4e/0HnGusht/kwOrTWmGqqg7ZVnQFdd4wMU/
 1dyPLRh5VWTxnUy4t64oh+KU8wf20LJNuKT3k48pxoIfmRS+q/d+/0YmT5uiskhiBrK4
 nlPToiwNdaPJD0zMcWJ2mTe8Xv/LIshdaQbEYn3mjm831HBCj+bJFZmM1oEuB5Ro309C
 Rh9g==
X-Gm-Message-State: AOJu0YxyVk0YK9+oIyokgioXgYkkwVFLi9dQZFKBfdse2refXBu0wuPq
 hn3d8NTlImmwxdxnI4VQ9KuyOyM8SXR/Xamrz36CRdhGzjaiCVRBe3EBy3DIGfRqt9je8+uFOaN
 om+LXzcXyRdNC/CJIyba1uMkrIS9jsOiqrd3ifV6dFg==
X-Gm-Gg: Acq92OH5agOPT6sI05X1g6n/YCRaU8jUu3x7cbbF4QAd5QETW2wLLIn8AtBztmthts+
 6PFyDiDMiR7BsmIg+5chkRbwf5jxUoEjYBZCqLthnymd+EUuBe5gJbL6kzmQ+DJdFbapNMQrMd5
 OjlG+Xw95DWd56RVdQ2u437VOWwVHlPAuVkVHByd0IJ9x0GU3AW6yvaiyUjFMvsNduGvW3sd9K5
 pslQs0+UDeG+aQ3qBWk+0eICTXufexKahHwbAzMQ2mYpuTmXxOKikkn7M+CxiK5zgCmDJKXCOSJ
 QhXbo7Id+d7kQ3jnktoqay3tH04LS78gswVVdPWXmuggq9p0e4MItjAIWfDb
X-Received: by 2002:a17:907:c714:b0:bea:f4e0:c7b9 with SMTP id
 a640c23a62f3a-bf0a89338aamr527954066b.19.1780593429713; Thu, 04 Jun 2026
 10:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604160547.GR627328@bill-the-cat>
In-Reply-To: <20260604160547.GR627328@bill-the-cat>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 4 Jun 2026 21:16:58 +0400
X-Gm-Features: AVHnY4KMF7owAI8v82mirKpIO4Y9AqBPtz0srmzc8yDAyMsSLA8EXfH6TcL2yD4
Message-ID: <CAKTNdwEt+CpeN8JssJr_JFowXi8yt8QPFg77=OKG0BeOri43MQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] pxe_utils: small fixups, implement BLS type 1 boot on
 top of them
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jun 4, 2026 at 8:05=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jun 04, 2026 at 07:31:05PM +0400, Alexey Charkov wrote:
>
> > Add support for the Boot Loader Specification (BLS) type 1 boot entries=
,
> > as generated by default by systemd's kernel-install when loader=3Dbls.
> >
> > Given that the format of BLS entries is pretty much the same as PXElinu=
x,
> > reuse the existing library for the parsing logic.
> >
> > BLS type 2 entries are out of scope, as they are effectively just EFI
> > applications and should be booted as such.
> >
> > This implementation is also only allowing a single top-sorting entry to
> > boot, as the standard boot infrastruture currently doesn't support
> > multiple entries per partition-bootmeth tuple. I have a proposed extens=
ion
> > to enable that and will post it separately as RFC - that enables the us=
e
> > of `bootflow menu` to select the kernel to boot without jumping through
> > several menus with different behavior as is currently required with
> > extlinux.conf.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> This is good to see, thanks for posting it. One concern I have is that
> out of 1529 platforms, this would be enabled on 1392 of them. And the
> size growth is around 1.5 kilobytes. Is there some smaller percentage of
> platforms this should be "default y" for ? Or is the expectation that
> something like Debian will be configuring for this moving forward, so
> yes even something like PowerPC platforms be using this? Thanks!

Well this is the config format that systemd's kernel-install produces
out of the box, and it doesn't require EFI support unlike UKI (a.k.a.
BLS type 2). So one could argue that any system shipping with systemd
benefits directly. In my view, that makes it more accessible for end
users than e.g. bootmeth_extlinux, which is also "default y" but I
could only find a suitable config generator for it with device tree
support in Debian (not in Fedora, nor in Gentoo out of my extremely
representative sample of N=3D3 distros).

Happy to make it conditional on whatever platforms find this helpful
though, or drop "default y" altogether. I personally only care about
ARM, and Rockchip in particular :)

Best regards,
Alexey
