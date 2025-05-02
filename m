Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF8EC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 13:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA5C81E72;
	Fri,  2 May 2025 15:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dz1G6jeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2DE481F7E; Fri,  2 May 2025 15:23:20 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47CAE810EB
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 15:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-acb615228a4so580870066b.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746192198; x=1746796998; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NYysJKGrsExjEAVAVamFZ7fcVO7ddXvXEXLP7A7a9b4=;
 b=Dz1G6jeR7j4Hp94ID5LDnnIjN/+2Z6/rWlZJ+Ap021onuQSSlb4lMY7w5cgsGUmgAL
 M/YRxlWnEp48NJWBLe4yRUD5tS4ni6Ja2qGUYT+iGGIFr/naMzeylWL+Kpviug2u6oOo
 x5VoAFFlIpEOBfIA+IYtrmGWr1VyWuFfZxEoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746192198; x=1746796998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NYysJKGrsExjEAVAVamFZ7fcVO7ddXvXEXLP7A7a9b4=;
 b=eQferykQtaJrukxhp3bQGeXLnwLNL9KXb1zqYQxSwZThGlYdnPRF4LWSjOgsCGOLb8
 Epwr3qxFLiZJTZXHmBKPjkljWK5XPRXBiC57c1T0NXiD8pCghYxZ77wesqAk/2N2oDZO
 1rFpZ51vlFfTlBRuYPde5zD4+WCi1aqad3XCVnRJbfcda9rq9+kALzuUCymaIhA0KvvW
 QJSTJ8s3w7XsJfejHKWp2V9Upglk0Hy0AyMUmj14dkoE0JpoPYPXNklbZyTglEzbF+Xj
 b5D/fpBWRuH02Szmk+u3qSEp6PR90Mfiz01av3AMx0b+Tt8Pdx6MCzOdqSh/DVHrhfc8
 XVaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgPEVqiDx7jCWjm/pCsDjc5Cy/DOvwbC8QqzXG4ZONsDsPJ7Mn4hetq/3oPAaRKehoSkv2pbI=@lists.denx.de
X-Gm-Message-State: AOJu0YyvCw1oop3LwZu+cYffSSLqLScOAWt/oSIbLqKLlEJ8VYYrlxX5
 dYoQvr66QNu8gOKR+AvIe2XgZ6os/yF73t9BTmHE0YWqNZzpCEnp4vB144+j2Z9aKUK+2+uRfWx
 GmzSxyLo0otCqvHtVLFhaNFuVfKmycB6wbZlb
X-Gm-Gg: ASbGncvinjTX/vjKiY9ty+ZfGtGnaRoQkYZ9iPfxvpiq9mpROUNdBpcAMC6lrAjPb4f
 /Nvxec9Wrtc2ykZBC4t1fctdrukKdSJ26FDj/osQ5Fw0kO+obOH2KEKWJnK4h82swMqMJczGUSH
 42Hi4fV6QA8tWyYQk6/FUkIIw=
X-Google-Smtp-Source: AGHT+IG8ZCaZ2B0mX6YHmiV9HZAnINOp9JcFgrnOjT6g2+YcFAnbkTeLSbgn0xh8/F9FaUg09KL1fO3KLxJdMfZybik=
X-Received: by 2002:a17:907:7216:b0:ad0:11b3:ac90 with SMTP id
 a640c23a62f3a-ad17af8e7c7mr306629066b.30.1746192197640; Fri, 02 May 2025
 06:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-3-heinrich.schuchardt@canonical.com>
 <CAFLszTgn3kXFrbsfbQCpJ0pHmgAvF2Df_V7_tTZ732k3Q4UVew@mail.gmail.com>
 <2c28be83-aab4-455a-9ced-602b7c6b1354@canonical.com>
 <D9LKH17KOI3W.1X2BUOB3TJWX1@linaro.org>
In-Reply-To: <D9LKH17KOI3W.1X2BUOB3TJWX1@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 May 2025 07:23:06 -0600
X-Gm-Features: ATxdqUFlR9-tawl08Dnbg5g18_-m7AHmQx-zjm8xiez06jg2dAnrKM9HU7kpL58
Message-ID: <CAFLszTi32wXAnzeL3uP2kS18vx38rbPgnpcySyrn2+Sf-AM7JA@mail.gmail.com>
Subject: Re: [RFC 2/8] boot: BOOTMETH_DISTRO should select BOOTMETH_EFI_BOOTMGR
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

Hi,

On Fri, 2 May 2025 at 03:28, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Heinrich
>
> On Wed Apr 23, 2025 at 3:53 PM EEST, Heinrich Schuchardt wrote:
> > On 23.04.25 14:28, Simon Glass wrote:
> >> Hi Heinrich,
> >>
> >> On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> >> <heinrich.schuchardt@canonical.com> wrote:
> >>>
> >>> Distros expect the EFI boot manager to run. It falls back to launching
> >>> EFI\BOOT\BOOT<ARCH>.EFI from the ESP.
> >>>
> >>> BOOTMETH_EFILOADER is obsolete.
> >>>
> >>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>> ---
> >>>   boot/Kconfig | 5 ++++-
> >>>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/boot/Kconfig b/boot/Kconfig
> >>> index fb37d912bc9..71ddb37f6bb 100644
> >>> --- a/boot/Kconfig
> >>> +++ b/boot/Kconfig
> >>> @@ -597,6 +597,9 @@ config BOOTMETH_EFILOADER
> >>>          imply CMD_TFTPBOOT if CMD_NET
> >>>          default y
> >>>          help
> >>> +         This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
> >>> +         launching EFI\BOOT\BOOT<ARCH>.EFI if not boot option matches.
> >>> +
> >>
> >> I don't agree with marking this as obsolete and your commit message
> >> doesn't explain why it should be.
> >
> > This method was written in a way that per se violates the UEFI
> > specification as it does not set up required UEFI variables.
> >
> > You must never run this before the boot manager as booting
> > EFI/BOOT/BOOT<ARCH>.EFI if there is a boot option violates the UEFI
> > specification-
> >
> > The boot manager covers the functionality of this bootmeth.
> >
> > We should delete this method.
>
> +1. Do you plan to propose a patch to remove it and only leave the bootmanager?
> Or you prefer marking it as obsolete for a while?

No, neither.

The work-around that Heinrich and I discussed was to insert bootmgr
later in the bootdev sequence, not to disable this bootmeth.

Regards,
Simon
