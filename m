Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E917EF99DB
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 20:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC56283E1E;
	Fri, 13 Feb 2026 21:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CXdyenIJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D41883E21; Fri, 13 Feb 2026 21:20:21 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4419D83E0E
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 21:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-65a414a6859so2339364a12.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:20:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771014019; cv=none;
 d=google.com; s=arc-20240605;
 b=iOjlrbMERynFYhxzL9aBJ57vkeTZyZZAApu6x/gpCAzfKy6OVN8STiiTxVD3NSlE+/
 GdzaN1sfKYW22VaLMqfU3Fdky9WI4ir92GYkE9iQCD6rYAPORpSWRdHamMbO0R2sTCTq
 5RftViXsTuvixwSY0mNcWMJX/19Y3j9ZYGtCwepYpI5Lgf/hsHDN/jZJLbcr2ODzJOfo
 rMO9l3TpY4s9+mFTjdKix7Ir0PxXLvGY24s6gu3yuA7GHvItHar2Xu/jVaE4pMVm0oso
 soxOP9x6TgkasRAieDFZUjCP+S3aiVb0XSZ3G07C7BJh066VBaXNSvi+kUAEP4hxURp0
 8jSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Wl9VIuUThz0xnf3+bfSH7yL7IQU3ZRl+vvAZnTSxwYs=;
 fh=1akHetpqskEqSYgELX/yMqhhZZ3pZvdHrlr+aALp6Kg=;
 b=bPBi0nRIFgeRDPDaDY4K9szWbMMIVrorqc22M3xrvhdy3ox6z3ykuMhImTAnTfFk7X
 OHFPdoFFiENJvBTlP35csIvr073PKm4302u1XCvOH2gK+1KM0y7sa3SGssej6poUX0e5
 LhNU4aebzb+ZlexZR7ykHdw5L7+d8xiamAX4syMvmaLPHvpYjuVdMHcwAxYID1aWwuYy
 ebjDxsYwD4tFVBox+DOQkkW7AsqibxR1kiXHVaPUbtSvNDPNS6o7ZMQ+393/O0qey+q6
 aZqM4Pl91WE+FltZuRqUk9UkNEuv4Duqx5xXY29cf0WSOT7uuFYj6cY3q55EEO4kWYx3
 BEyQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771014019; x=1771618819; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wl9VIuUThz0xnf3+bfSH7yL7IQU3ZRl+vvAZnTSxwYs=;
 b=CXdyenIJNJ/V/aCjmL1dyuq6FFgBYPDkkcY6udpfgnZ8bP5Ky9JPUgHP4dxDVYBsbc
 a5gX9cSUOLXx7GYsyDU5HTdRDnaC6Dv7dZRdne30luaEa9MvibZpaKCfqgvCLF90qtcM
 +x3KAfOrNyMlYRV54JZH8To9oajDjgY07WyeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771014019; x=1771618819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wl9VIuUThz0xnf3+bfSH7yL7IQU3ZRl+vvAZnTSxwYs=;
 b=wEwld4H6rbuqn/nNZ9R/FrHNbZppGEm428f5SxV0D/2f1bZ1P2/C8A8we0NOJmIEJe
 8DD7xohOLN8miS/gGIiIvpWRWpiqNeT7kq4k+gr+P6kKHFnlt9SO4nuFRyYejXtjq37A
 GQSUx+shtPQGbRXeorWdUqs31UWxVjQBHyKfnjgJmgDC79x4xCi1p/Pc6aMnf/ZpKjJQ
 pKESuhuSHujHIOCSuk6ttJe/hDB8d4iQl4xCYohLyPP/Id/Ku12Ia2aXN9aKDNrsayXr
 FTGmbFPZGruGNXzsFFtxmqSMkk11WGtooCgvlfLG1+dfskprQ2diiGOWhSFcoI3pOMyB
 GO8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXZf06CfAMgu30bhJMHkZOnTJasRyt8OT8JAWFeVZ9SONTiGFRJbivNtNi39A+8HqMc3BVJeA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3t5Q2Hw2tf6bcVnn0XKgJmbgWjr/28NUVAETsU8FrBpYtbcps
 eaaZ/hH6WHqx8V4NTlIodR+HlZlwmSZauK9yF6q1G24L9bd9ZntvfNBRyEr6BPFo1Bp1qGHklge
 o0UHMIV4zU7Q1p7UF+GK4zr+z0gyG0RJ8qCuo7Qel
X-Gm-Gg: AZuq6aJGe0SsRTgQJEFIJFbUg23/UjzXaCklxNdBxHpO/M8PpgZAefXtInZLMDjunBH
 u5lgNIAyjAkrG2ZurWnuFmZxBzPbYLftRuS0+y6YXTKPSiDKxeXK0nfV24QawH4xfle50+BPidQ
 8ObRtb0klJ5o45/nlXHTd10iUP2hlhU9ZTKl9aGM9LAU85Vvit79sFumphipB1HHA0EG3NUExO9
 j+E9jiqGSW1fnmsXFCT5JMN0IqMaE4dVBqeAluqHrcKiQ9yoSfZQqh7Iqf6D2bu7i/S7GRwur7h
 I9gU
X-Received: by 2002:a17:907:2d0f:b0:b88:504a:f381 with SMTP id
 a640c23a62f3a-b8fb41fafaemr165643566b.23.1771014018693; Fri, 13 Feb 2026
 12:20:18 -0800 (PST)
MIME-Version: 1.0
References: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
 <DGDUAXWN8ZAA.8A73T56SKN9C@linaro.org>
In-Reply-To: <DGDUAXWN8ZAA.8A73T56SKN9C@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Feb 2026 13:20:00 -0700
X-Gm-Features: AZwV_Qi3tDjRSIfn_ndLHuDgwi0o7M2dBNwzmOkVqbfnEhbREkYF75OHUDafivA
Message-ID: <CAFLszTifrC2Lz_MP3KN4sA0eGzu4V5vqF+LdG4vUjiXAgR6WzA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] UEFI Capsule - PKCS11 Support
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, simon.glass@canonical.com, 
 u-boot@lists.denx.de, trini@konsulko.com, quentin.schulz@cherry.de
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

Hi Ilias,

On Fri, 13 Feb 2026 at 05:41, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Simon,
> This has ended up on my patchwork, but I wasn't cc'ed.
> I'll have a look at the mkeficapsule changes soon, but do you mind if I
> re-assign it you since it's mostly binman changes?

Yes that's fine (we synced up on irc).

Regards,
Simon


>
> Thanks
> /Ilias
> On Wed Jan 28, 2026 at 10:05 AM EET, Wojciech Dubowik wrote:
> > Add support for pkcs11 URI's when generating UEFI capsules and
> > accept URI's for certificate in dts capsule nodes.
> > Example:
> > export PKCS11_MODULE_PATH=<pkcs11 provider path>/libsofthsm2.so
> > tools/mkeficapsule --monotonic-count 1 \
> >  --private-key "pkcs11:token=EX;object=capsule;type=private;pin-source=pin.txt" \
> >  --certificate "pkcs11:token=EX;object=capsule;type=cert;pin-source=pin.txt" \
> >  --index 1 \
> >  --guid XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX \
> >  "capsule-payload" \
> >  "capsule.cap
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > ---
> > Changes in v5:
> > * add bin wrappers in test for all external tools
> > * improve error handling in python test
> > * fix data types in python
> > * standardize option name in mkeficapsule
> > * fix typos
> > Changes in v4:
> > * adapt mkeficapsule python support to dump detached signature
> >   for authenticated capsules
> > * verify detached capsule signature with openssl after generation
> > * use p11-kit to figure out location of softhsm2 library
> > * fix missing long option for dumping signatures in mkeficapsule
> > Changes in v3:
> > * fix write file encoding, env setting and extra line in binman test
> >   after review
> > Changes in v2:
> > * allow mixed file/pkcs11 URI as key specification in mkeficapsule
> > * fix logic for accepting pkcs11 URI in binman device tree sections
> > * add binman test for UEFI capsule signature where private key comes
> >   from softHSM
> > ---
> > Wojciech Dubowik (6):
> >   tools: mkeficapsule: Add support for pkcs11
> >   binman: Accept pkcs11 URI tokens for capsule updates
> >   tools: mkeficapsule: Fix dump signature long option
> >   binman: Add dump signature option to mkeficapsule
> >   binman: DTS: Add dump-signature option for capsules
> >   test: binman: Add test for pkcs11 signed capsule
> >
> >  doc/mkeficapsule.1                            |   4 +-
> >  tools/binman/btool/mkeficapsule.py            |   8 +-
> >  tools/binman/btool/p11_kit.py                 |  21 ++++
> >  tools/binman/entries.rst                      |   4 +
> >  tools/binman/etype/efi_capsule.py             |  17 ++-
> >  tools/binman/ftest.py                         |  66 ++++++++++
> >  .../binman/test/351_capsule_signed_pkcs11.dts |  22 ++++
> >  tools/mkeficapsule.c                          | 113 +++++++++++++-----
> >  8 files changed, 221 insertions(+), 34 deletions(-)
> >  create mode 100644 tools/binman/btool/p11_kit.py
> >  create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts
>
