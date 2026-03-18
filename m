Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAC8103E160
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 11:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 834518405F;
	Wed, 18 Mar 2026 12:00:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mHdi2cqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDD3D840B0; Wed, 18 Mar 2026 12:00:29 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B4884083
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 12:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b97a0f18a3aso524228566b.1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 04:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773831626; cv=none;
 d=google.com; s=arc-20240605;
 b=auXKlwFEU2quYckXTjNO1ET/Vzym9vAFcrSm6QJuPZPlk724VYlIxJLgUBRKbYv6QN
 qBmghWGXRVD1A8JFO0k0naF+XjWo03lzCZGzHsbiKjxlKkX1Dm9UJevWBRgT4VHC2iJg
 0TPtIjmZ6qLAIAAxzdP1CQUNBBUsjlAhDH8ZguDwmR4MF1cNYgn2Sb8/211mJ3lnjRBh
 cMm9/wg2CNLsYSKdkgrei6TmZnVrATcmngJ1p8T2973DPOgY5V8GEbtcgGh1oqIOJcm7
 OVEY5tWVB1DLnl+RzVjbkxqQ5v8v+qmv/KLu+IIGZ5cOGaKQlsC1zetpLJniySGKy1pE
 0ZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TDEIhN0z60pqbLTCWMme1xYmcsUKmkkYYFHXxY9XEiM=;
 fh=Ocm9gqAOloMldLKW+/XS3lUBvYVERM3emlAYwEVY6VA=;
 b=cmmChzhFITfa2oklG/Q2epoXnfsd8rPscH2IgLKzoEIxM2mtBe/Yxxt/stlFBcmg8k
 P2IQIf5KqT5rsCiMmeMYa4Z88XwSi0EJCYKCDx6GEE6Kjjyg+DqeTu/OOuL6FRDf+Bg/
 5JVtlHxAnslKkUTrRh2XAn/Ii5bQnpZSd+9LVMTDKv+6srptbzW97ztXS9qBLkt+Rq4+
 4hZhwF4xpmaE7MGgmQvk50SH0FC4wwe+XIDXWMyi1Z8RWUyddCBC4aH/tR/pHJ4YU7zN
 2OeKTJWcSNv+nkvmxJzlboxaWlmjwbozjcE6L+lJ9V9bfH/69JfVc5eek4BF7fjLEr2s
 5fog==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773831626; x=1774436426; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDEIhN0z60pqbLTCWMme1xYmcsUKmkkYYFHXxY9XEiM=;
 b=mHdi2cqNMQGnv7geEamd2NwG6SJTP0KpX17lIrzP35+Knnt0i7pon4A05I8+juIpwt
 mo0xPLb0kSKAvMda+39iqjzt2MPm7AeAZS71IrgN/FYrvxSL+t5Q6W4xxuLZCW+9zpKC
 Nvp6k7lIuHuqeXCcfalOCZdZ/5r6NeQD8hp3R+WGrOMae62vI6AR/OadAMMIOfq+hziy
 fOYewLR9ajmDX/NcU8zJcTEJ+f3WKaz52d7YS+4ALhxLKGDDTlSFMlNTXayM0UydDwhV
 3x3dL5T2frFTs+QWdfQ3/9l1renQ1JVU3LyO4AUsKzxjpo1MHeVSBknZSCjCaKSgBvk+
 FsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773831626; x=1774436426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TDEIhN0z60pqbLTCWMme1xYmcsUKmkkYYFHXxY9XEiM=;
 b=kQ93R0rwlEX8/bctj8epA34SPtAiII4MZ6hOo9Z/tjdIDohNzxxMOqS0/nlALVIRAn
 eAo8p3W1I2wCqxdEFSjo6vv224HhuoisTDxUORxQaEXKU75auj3b3y+bT/nZTBgpGdUb
 UUXxOD4zN7YQGuYzZtr9u3EPUb1H7FfUkSF5JJVsp/Y1cYIMdXHAmu6KuLB/VWgB2HIV
 j0dBr1cDoX6ALDGPYOkl8n1CDZYF2xlDhIoXrSmdF1xK8suJJB7uTk9AMWOt+er7k0Th
 Xd4vmJ0KPckXmv3ziqnh4/Nvf/3aunz70EYQx8H6HbYR3aW9A0Q2n2ncv+IdgeuwI1qs
 Wstg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa3bG22Ty2baLQbob5ITBj+T2V1IZs+akmHTCC7OoXK4F6nN2b22Q+ViXxu72r1KSb3veBYt4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/lg1xzMvSVrT8cqh76kuq4t+CyLmjucdggqflpnG2a5RSU3Fv
 WpYpng2WehhfJbjD+O6PwnsnzENRK1bAxierqIaPrI3IfWh7hJBXybVRC3uEjnnFOrAiU1AU3/2
 V1Wze4eFuWZrevw+VLQdS+bOpGYdQ4gZDbSqJ
X-Gm-Gg: ATEYQzym94yNpGedFlwtqfiwvuzQzX1132h5VgiYvTvAEJuHJllnVPsFVtX5Gsdtg60
 lS878bgljnn9XXbiNUTukwBff5PDG0vBv6aPPCwPkzbeWx+nw48EeQOnMsLapzuqIk3LTtQANfw
 pb0ji5D73/gAUfgkaygSDiBTI5NO3ilNnCxOi5LRhx7fIh5m0V8OQEWYBHvzHArddvkw7VlVYse
 N38RYyprVk0DvaAiUERLtjZCiMruCq9XD6wRZyY8BeNVubLJ6fYP7OP9Dh+4ZZJj0Y9A7y7uvIK
 uWtbL8EoakhDM+X+ZtKShOlELy71tU2zKe5wj38kGlv5a8tNSWcAKPLaH0ZolJcikeB4+3xS9/7
 jXQoVb8c/2/Yt1C2K+B3Cr3c8NABL+uA7v4W9RUDDUOpFm7ZKh2k=
X-Received: by 2002:a17:907:96a3:b0:b8f:e46f:8079 with SMTP id
 a640c23a62f3a-b97f4939261mr153612666b.22.1773831626053; Wed, 18 Mar 2026
 04:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260317012449.4162666-1-trini@konsulko.com>
 <CAC_iWj+WHh14nTdYu2BUTqvSwrtHiJBJVncArPwrBqWb6kXnTA@mail.gmail.com>
 <9F36DE37-16FF-4519-9F66-A4A79F618794@gmx.de>
 <20260317134427.GU502704@bill-the-cat>
 <CALeDE9MVgs--ABnZZ4RJDOnTLM-+imKxG6iJBGmQFHHXivLMxw@mail.gmail.com>
 <20260318014701.GJ502704@bill-the-cat>
In-Reply-To: <20260318014701.GJ502704@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 18 Mar 2026 11:00:14 +0000
X-Gm-Features: AaiRm519xxk1N2Mo8km2XTJGrwqvAD2xhurKFnYzNZe25CA4rOBrW1oX12ZpBqY
Message-ID: <CALeDE9O=y6fGKd50eiW3Och7vQWKvj_DzuB9UeNLnvj0rqezmg@mail.gmail.com>
Subject: Re: [PATCH] EFI Loader: Correct dependencies for EFI_HTTP_BOOT
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Wed, 18 Mar 2026 at 01:47, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Mar 17, 2026 at 04:08:22PM +0000, Peter Robinson wrote:
> > On Tue, 17 Mar 2026 at 13:51, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Mar 17, 2026 at 08:42:39AM +0100, Heinrich Schuchardt wrote:
> > > > Am 17. M=C3=A4rz 2026 08:03:47 MEZ schrieb Ilias Apalodimas <ilias.=
apalodimas@linaro.org>:
> > > > >Hi Tom,
> > > > >
> > > > >On Tue, 17 Mar 2026 at 03:24, Tom Rini <trini@konsulko.com> wrote:
> > > > >>
> > > > >> As exposed by "make randconfig", we have an issue with the depen=
dencies
> > > > >> for EFI_HTTP_BOOT. As this is implemeneted by running commands (=
as seen
> > > > >> by what it selects) it must depend on CMDLINE as well.
> > > > >>
> > > > >> Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > >
> > > > >In theory, you can configure UEFI with a set of prebuilt boot opti=
ons.
> > > > >If one of them is http(s) the device will boot even if CMDLINE is =
not
> > > > >selected. I am not against this patch, but we will remove the
> > > > >possibility to build a firmware without cmdline that just boots to
> > > > >whatever is was preconfigured
> > > > >
> > > > >Cheers
> > > > >/Ilias
> > > > >> ---
> > > > >> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > >> ---
> > > > >>  lib/efi_loader/Kconfig | 1 +
> > > > >>  1 file changed, 1 insertion(+)
> > > > >>
> > > > >> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > >> index b5f81e0ff530..a9b2f813e1d5 100644
> > > > >> --- a/lib/efi_loader/Kconfig
> > > > >> +++ b/lib/efi_loader/Kconfig
> > > > >> @@ -600,6 +600,7 @@ config EFI_BOOTMGR
> > > > >>  config EFI_HTTP_BOOT
> > > > >>         bool "EFI HTTP Boot support"
> > > > >>         depends on NET || NET_LWIP
> > > > >> +       depends on CMDLINE
> > > > >>         select CMD_NET
> > > > >>         select CMD_DHCP
> > > > >>         select CMD_DNS
> > > >
> > > > Having to select commands here to get network is what needs to chan=
ge. The network commands and EFI_HTTP_BOOT both should depend on configurat=
ion symbols for the protocol implementations.
> > >
> > > Yes. And this is about fixing missing dependencies, today.
> > >
> > > > @Tom: Do we have a target release when to finish the move to the LW=
IP stack?
> > >
> > > We do not. I'm not yet sure if all the various use cases of the legac=
y
> > > stack are fully supported now (I don't recall off-hand the NFS series
> > > state right now for example).
> >
> > I did see NFS patches go through the list.
>
> I saw the NFS support as well shortly after hitting send, as part of a
> randconfig build.
>
> > I think there's also likely some legacy usecases where non parity is
> > likely fine too.
>
> Perhaps the question really is, for the distribution folks, what are the
> use cases you know of where lwIP doesn't have support yet? That's the
> first big hurdle towards, likely, saying EFI_LOADER implies NET_LWIP
> maybe, since I know there's cases there lwIP is better for.

I don't know of any problems or missing features, I turned in on by
default in Fedora across all devices for Fedora 43 (The 2025.07
builds) because I wanted UEFI HTTP boot and haven't had any bug
reports, and I suspect the features like UEFI HTTP is more useful for
most distros than loss of other features because a lot of vendors are
moving away from legacy tech like BOOTP/TFTP because of lack of
security and the fact most of those technologies are not usable on the
Edge/outside of the data centre.

I know of one device which has tight SPI flash space (Jetson p3450)
which I need to look at closer to see what I can trim, but that's a
side point on that device.
