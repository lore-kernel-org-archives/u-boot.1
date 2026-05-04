Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA51FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5FE3846A1;
	Mon,  4 May 2026 22:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="PYZqDm/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF1B846BC; Mon,  4 May 2026 22:03:26 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id ABF53846A0
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 407B51BCB;
 Mon,  4 May 2026 13:03:16 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.68.2])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AA5A3F763;
 Mon,  4 May 2026 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777925001; bh=kUGwfpeMq+JuwZeMURWEdB0EJSo1Adwh1hXEtQJ23vQ=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=PYZqDm/Q4RckZXNyC3A/ir5weFCqQk9n1jjA6FmeG6TI/N9E2Ql36xBbTZurB9QDL
 jE5k+/zCAHsd+BSI2i+cbHBCgw0sMA2FsU6xKMA/XgfaaNDPgZVupjaQkB2AoE5odi
 F/T03rPSX12V7RvNmYvdjP1/q6/vdganJRYY2IJw=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/12] efi_loader: add runtime memset helper
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: harsimransingh.tungal@arm.com, u-boot@lists.denx.de, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
In-Reply-To: <CAFLszTgfKTVFxj6Z93dbecjHeY=oAGoGtUmBhYiC8EtrOzVsdg@mail.gmail.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-2-harsimransingh.tungal@arm.com>
 <CAFLszTgfKTVFxj6Z93dbecjHeY=oAGoGtUmBhYiC8EtrOzVsdg@mail.gmail.com>
Date: Mon, 04 May 2026 21:03:14 +0100
Message-Id: <177792499454.3275395.17057771256029107703.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Mon, 04 May 2026 22:09:25 +0200
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

On 2026-04-28 12:08 -0600, Simon Glass wrote:
> Hi Harsimran,
> 
> On 2026-04-24T17:31:50, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> > efi_loader: add runtime memset helper
> >
> > Add efi_memset_runtime() for EFI runtime paths
> >
> > This keeps buffer initialization in runtime-resident code after
> > ExitBootServices() and avoids relying on non-runtime helpers.
> >
> > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> >
> > include/efi_loader.h         |  3 +++
> >  lib/efi_loader/efi_runtime.c | 21 +++++++++++++++++++++
> >  2 files changed, 24 insertions(+)
> 
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > @@ -1151,6 +1151,9 @@ void efi_memcpy_runtime(void *dest, const void *src, size_t n);
> >  /* runtime implementation of memcmp() */
> >  int efi_memcmp_runtime(const void *s1, const void *s2, size_t n);
> >
> > +/* runtime implementation of memset */
> > +__efi_runtime void *efi_memset_runtime(void *dest, int c, size_t n);
> > +
> 
> Two inconsistencies with the neighbouring declarations: the comment
> should say memset() to match memcpy() / memcmp() above, and the
> section attribute does not belong in the prototype, as
> efi_memcpy_runtime() and efi_memcmp_runtime() carry __efi_runtime only
> on the definition. Please drop it from the header.
>

Thanks for your feedback.
I will fix this in patchset v2.

Regards
Harsimran Singh Tungal

> > diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> > @@ -233,6 +233,27 @@ int __efi_runtime efi_memcmp_runtime(const void *s1, const void *s2, size_t n)
> > +/**
> > + * efi_memset_runtime() - fill a memory region with a byte value
> > + *
> > + * At runtime memset() is not available.
> > + *
> > + * @dest:   pointer to the block of memory to fill.
> > + * @c:      value to be set. The value is passed as an int, but the
> > + *          function fills the block of memory using the u8 conversion of this value.
> > + * @n:      number of bytes to be set to the value.
> > + * Return:  dest is returned
> > + */
> > +__efi_runtime void *efi_memset_runtime(void *dest, int c, size_t n)
> 
> Please match the kernel-doc style of the two helpers above: tabs after
> the ':' in the parameter list, no trailing periods, one-line @c
> description. The @c line is also over 80 columns. Flip the attribute
> to 'void * __efi_runtime efi_memset_runtime(...)' to match
> efi_memcpy_runtime() / efi_memcmp_runtime() in this same file.
>

Sure, I will fix this in patchset v2.

Regards
Harsimran Singh Tungal

> > diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> > @@ -233,6 +233,27 @@ int __efi_runtime efi_memcmp_runtime(const void *s1, const void *s2, size_t n)
> > +__efi_runtime void *efi_memset_runtime(void *dest, int c, size_t n)
> > +{
> > +     u8 *d = dest;
> > +
> > +     for (; n; --n)
> > +             *d++ = c;
> > +
> > +     return dest;
> > +}
> 
> Just to check, was there a reason not to mask 'c' to a byte (i.e.
> '*d++ = (u8)c') as the doc comment promises? An explicit cast matches
> the comment and silences future -Wconversion noise.
>

Thanks for noticing this.
No, there was no specific reason to not to mask 'c' to a byte.
I will do the suggested change in patchset v2.

Regards
Harsimran Singh Tungal

> Regards,
> Simon
> 


