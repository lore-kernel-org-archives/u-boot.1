Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456F3C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 00:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 609FD809D4;
	Fri,  7 Feb 2025 01:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PAX8+FNt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51ADB807EE; Fri,  7 Feb 2025 01:50:16 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65423809A5
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 01:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ab7740ca85eso207079966b.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 16:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738889409; x=1739494209; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/4ChYlNRZ//SkRWf1sHxDv/6uB3BRVoFw3eClw9BLpk=;
 b=PAX8+FNtjxWm85Ye7jPISEaqK1Jhaj8Q/RCnLKq2IUTAW8lPJY2z2hlV6rTNSmqU8f
 KBsvifHymO+6AjoLm3aOpI6Q0Xnqj1VDpgvdJk2AeMRIX00VtYNZNZ1/eb2JMHNPMU+J
 DBbvVkayjNLGTGwXXG7Ett0Y8GwlTKeg6kdeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738889409; x=1739494209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/4ChYlNRZ//SkRWf1sHxDv/6uB3BRVoFw3eClw9BLpk=;
 b=NjHklE+Cb0c+fKWygrTPX12irChPmAJynRsgPdx0mNOEqO0NemV7m5sGVlooE/kdGy
 EiXPWgQfJRZNXdNm7fNb9P4QLbIRRYoRTBx6wgAHHToIPvxjDgOC32YjTpnjjdKgjjJf
 P7wqnFjoniNoldN/O6/9I3I2LycUpRVyWE5beL8q+R4/w1pLtY/zcUimZFV3AlPM2r+m
 iHGo5wD38DUGmygQ8MC6OzTyQ1b3eA6CZ3xYtG0PdFHvZP5DWJgqXDOpjJNrmwy+fZf1
 ftk48n+FpP2VoTkYuEKQM+TeOe/vmW0n80tIctuB5Z4Hnk5C4PaPbymWz+oBZZ0GResT
 oVsw==
X-Gm-Message-State: AOJu0Yyx6rAhFAzJzuLBj/lnbi2rSvi/tjkBjSVhJEI4N6PfR/wkM8vx
 0z/hmtZPDPy31ot5NTnHa7JIs/H350T2cVlJ1cbAVpmAoDKUp7kqj/0608PechCe51OJxOYEzrW
 VHPq1UtI/a/mDvU9QSQ8NoRqJ9+fqCTKAqSsApVIPtp0vSOQ=
X-Gm-Gg: ASbGnctSeeSNE1nhDAolDXUr2hVoLQbv7C9a/5lQjGDPUay1GhMhuIutUfLtIEEobCQ
 RNsDeQsO9HOWue9AOipzr63Z+CPFMr262yrzcrqALu3sfHueodDlZdS9Fa2Ih0j4MPOaLuel7VA
 ==
X-Google-Smtp-Source: AGHT+IEsKx6YW+RHLaf8cLYBGLYIqc4WazkjQiY52A6Tsu5nf4Ma90IMTkXLrf3Cha1bbbZddpRbj5Apf+EmSZdnFHg=
X-Received: by 2002:a17:907:3e13:b0:ab3:9a57:f4fd with SMTP id
 a640c23a62f3a-ab789b21ec1mr82254466b.28.1738889408742; Thu, 06 Feb 2025
 16:50:08 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-15-sjg@chromium.org>
 <20250203200902.GH1233568@bill-the-cat>
 <CAFLszTgR==OvRFb-FBF4OHfr9zAjM8mz9G6ts8Md7vNuv7oqkw@mail.gmail.com>
 <20250206232413.GQ1233568@bill-the-cat>
In-Reply-To: <20250206232413.GQ1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 17:49:55 -0700
X-Gm-Features: AWEUYZk1GFROuLowUrJzVnK9weCarRoMmaW3aQmQ7nptfKT7QbbBCQ0Mwz6Kvnk
Message-ID: <CAFLszTh92nrDzXcrDRL8za=MLYkpB3j-utPm3Sxs_jcw+dFGOw@mail.gmail.com>
Subject: Re: [PATCH 14/32] efi: Rename ImageBase to image_base
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Leo <ycliang@andestech.com>, Matthew Garrett <mgarrett@aurora.tech>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Rick Chen <rick@andestech.com>, Sam Edwards <CFSworks@gmail.com>
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

Hi Tom,

On Thu, 6 Feb 2025 at 16:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 06, 2025 at 02:27:30PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Feb 03, 2025 at 10:42:07AM -0700, Simon Glass wrote:
> > >
> > > > It is confusing to have a camel-case indentifier in the link scripts.
> > > > Rename it to fit with U-Boot's snake-case style.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > This isn't the linker script, it's the crt0 file.
> >
> > Yes, it's referred to in the x86 linker scripts. Probably we should
> > rationalise some of these names.
> >
> > > Given that this is intended to match up with
> > > https://learn.microsoft.com/en-us/windows/win32/debug/pe-format (which I
> > > got from looking at the commit message on commit 216459d2cf36
> > > ("efi_loader: correct SizeOfCode, SizeOfInitializedData") and
> > > include/pe.h I don't think this is a good change. Heinrich?
> >
> > Well, pe.h is a file format so I don't believe we need to use the same
> > code style. We had that discussion when the EFI code was coming in,
> > and decided that it wasn't a good idea (as I recall).
>
> I really don't think our linker script for making a specific output type
> should deviate from how the output type talks about things. Deviation is
> confusing.

Well in that case, it is pe.h that needs to change. The original file
I brought in was there because I was planning to add ARM support at
the time. As it turns out, the file isn't needed for arm64, so this
series removes most of it. For 32-bit ARM, the file is not used at all
(although Heinrich might correct me if sandbox on 32-bit ARM uses
it?). See:

arch/sandbox/lib/crt0_sandbox_efi.S

Regards,
Simon
