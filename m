Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF2FEF99C0
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 17:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F46283DFF;
	Fri, 13 Feb 2026 18:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eyuqyrO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AD9B83DFF; Fri, 13 Feb 2026 18:53:55 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAC6283C4B
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 18:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b8f8f2106f1so159902766b.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:53:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771005232; cv=none;
 d=google.com; s=arc-20240605;
 b=UhrYHv6LLA5nqUYEfyjxgQDD5jW+LQaWVjnH/sjbLJ8Cd8/CI9Us485Vq2bYpn6GSl
 IoqoXgshLYzwsrUUPJhstuMHZHdbrEAV+YF+pVKHINChcf43pA3sEyoAgP82bUeYSx6H
 jmSbQChRa//fNw6wubrOp46ko0qEpfFULq3aUgUrOIrgDcmapOUwDDo0QNTYNi7r/vw3
 i+eQvWtdB7/N8Cpri0Frg/YR2p25AfM3J8wFRWJnrwuXBcvIwGsJhfsYv/GW/sDxJO9B
 3sLcdfe6ktNVIzULcdB0UkElnE0Hy7X1oCvFYohD2TE+5WXmZNEobJwCDVi2oYKUR5zk
 EbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UQ4Vqc/uMjGImmfqyFF0LNppmo926zWnwjsstGZxMEg=;
 fh=adFXIcqmP3L6/rADA4LLGejE18xke/VK1tygNc2s9oE=;
 b=FIFXW5/S9TAp2kPUvxpPRCXlV19/mDe9E1g1KQ+AbRLFOsYyH2ASwSzchnnDQ8jFO3
 NR0ju+X4A+hW2yb+E3bRsLvvDaTxEDsTTYe5L438pwwb4HIKR0XCsZ+5gkZceA6zEx5V
 C6n8gY4ZsNIzbCtebbUM1o1UwXyY4aLk/U9uV10T35z2ecQRF7j0p8qH3iWiDnoqymZZ
 rzglZqUOagzF0VanhWoXCcdr+F0HecingMngPA5jf7BrLyDRr4k4EddlvtzLVsSO0ayD
 hNsx72G0tHhz9EbJoAg6CbqjDlXWJvRMyuVk6RopbGXcVvazj8YAdo5Y2cWFw2XEeNkf
 Mv1w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771005232; x=1771610032; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UQ4Vqc/uMjGImmfqyFF0LNppmo926zWnwjsstGZxMEg=;
 b=eyuqyrO5ItivAlwbpVpwE2VN3bm0e+/iFehx/hR2yA+YacIHt0rytVths3EcZbJbe+
 1yqYVAtnE3ESCSEXnet/mWdL4VCzBocUe8kvadaO2vkUYSg6kTqcoB/STUsHflpX73LU
 ZCiZV/pIUEJQBmea4ej9IRYBtG+MK6YbLER1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771005232; x=1771610032;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQ4Vqc/uMjGImmfqyFF0LNppmo926zWnwjsstGZxMEg=;
 b=MnY+DQtsmxbwAVQn1JCIiHiJp1pvCxMqVNl1CdlmwyO3eHGVdtKZPZaIeoaIhSjxYP
 XyhCQ/AbUJxVgyEO3aSTCCg50df18xbbjJ7WG8DBvmYfZ0ayMAbte3VXh7nFubZMR4jW
 qnUemGyvGuRfBYNSzUwIo7kpPS9iaQ76g9MwXr7wLpw9MVR1V6hMa3c+LOvhw3kSzntt
 Aht5uo+xBJsrArBcKw4lJ/DGiHrQvTIwmjpjaYuYU8Db/IcNsNJH8BP/P145+VutqRJV
 fl+jVHWpZ0Y9Tc8enu/zK7EA5bQPfTJELFhllg8csREHLnKwuQro/40GrqAjGM+kpxIm
 C8sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLYO/pNY8dMJ9g1ajNBkb8q5SF15IgdovB51Vq/C2d3zMe0fPwasixvlw5rZodVzRME4wKL6s=@lists.denx.de
X-Gm-Message-State: AOJu0YxEqjMi2J2nJ79N5Gpv9XRnXYjT1JbQq8SxHpH4cUXJzaeb7QRo
 FM/cDC6LTwulESAn22/gRat1c6EEbpgMBAkKT9npAaJ3OHRjyezmWwIz6PIlyKuhhDdEf+zx90m
 cFTR+iWUWk5H2ccinI80JpLhIxCfkgLmdTRM0Vt5A
X-Gm-Gg: AZuq6aIqM9+FxMf+6zU782TEAq81eUSluxeE5rwiP5LxyZuVozF0tRDyHAIE6UJoARi
 MpIu1PzfHWxSGHpdw60XJ1Z1F4bsoAKLZpqSNDbDDKqoPEum/OMfPMZHAAS6WZWhTF7ZBuTH7wF
 gK0RAHgSefVp0OU2h8D3GJi4eWZ0JUOKE/GnI8R4Vr0IzdPnnZj9cULm+HMn5Xr422mAT/V8exo
 APS22kPzKXnuijs1yHb65BsKmfY9+84aY8AovFsMzXeqn2UjRAev8YF5DNMOSrun3ppen+cFfme
 nhKTBw==
X-Received: by 2002:a17:907:7213:b0:b8e:d162:2410 with SMTP id
 a640c23a62f3a-b8fc3a382b4mr16878066b.17.1771005232144; Fri, 13 Feb 2026
 09:53:52 -0800 (PST)
MIME-Version: 1.0
References: <20250714210249.4139916-1-eric.schikschneit@novatechautomation.com>
 <20250714210249.4139916-2-eric.schikschneit@novatechautomation.com>
 <20260203181444.GQ2603314@bill-the-cat>
 <CAFLszTgLx_TtEO-8qq_9uojLd7PgFdUuhs5_6kYqL7GuzFt7ow@mail.gmail.com>
 <SJ2PR07MB97113A17DC42B9E4E87E95EB8162A@SJ2PR07MB9711.namprd07.prod.outlook.com>
In-Reply-To: <SJ2PR07MB97113A17DC42B9E4E87E95EB8162A@SJ2PR07MB9711.namprd07.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Feb 2026 10:53:26 -0700
X-Gm-Features: AZwV_QjdPTYSGROVRrHUwHaiEFzXIBOI-ddZDtJ46V5fDmEXVFLbbF4CbXulmPw
Message-ID: <CAFLszThAYG9UXu0GoUDHv=k44G3b4CMBNdZjEUmHgrneJZAXOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Fix x86 baytrail boot flow, UPD/VPD Updates
To: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Cc: Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
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

Hi Eric,

On Tue, 10 Feb 2026 at 07:38, Eric Schikschneit
<eric.schikschneit@novatechautomation.com> wrote:
>
> Hello Simon, Tom,
>
> 1. Tom -
> > And we should spell out that device tree can't set these any more in the
> > commit message, along with spelling out why we can't do that anymore
> > safely (why can't we?). Thanks.
> I would be happy to move the code comment into the commit message:
>  /* NOTE: This breaks u-boot ability to set board options via    *
>   * device tree, but guarantees specific known values..          *
>   * you wouldnt use an uninitialized variable would you??        */
> These settings could be set by device tree, but every fdtdec* function must
> set a valid value. If a user has something set differently than called out in the
> FSP_MR5 Integration Guide the board stability will be compromised. Many of
> these settings are co-dependant so we would need much more robust error
> checking. This task would not be trivial. By using the specific values called out
> by the Integration guide we allow users to begin from a documented known
> good configuration. Maybe we could set all the values, and then check the
> device tree to see if the user specified a different value? If the device tree does
> not call out a specific setting we would not want to just set it to zero for example
> as this can cause undefined behavior.

The device tree is actually where these values are set for all x86
boards. If you change any value in a device tree you risk bricking any
board. It should be considered an integral part of the build. If you
change the C code you can also brick a board.

So I don't like the idea of changing this to C, sorry.

NAK from me sorry.

>
> Eric Schikschneit
> Senior Embedded Linux Engineer III
>
> ________________________________________
> From: Simon Glass <sjg@chromium.org>
> Sent: Tuesday, February 3, 2026 3:29 PM
> To: Tom Rini
> Cc: Eric Schikschneit; u-boot@lists.denx.de; bmeng.cn@gmail.com
> Subject: Re: [PATCH 2/2] Fix x86 baytrail boot flow, UPD/VPD Updates
>
> Hi,
>
> On Wed, 4 Feb 2026 at 07:14, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jul 14, 2025 at 04:02:49PM -0500, Eric Schikschneit wrote:
> >
> > > The VPD has been updated to include additional values found in the Intel
> > > FSP_MR5 Integration Guide.
> > >
> > > Disable MRC_CACHE for the baytrail platform as this will break the boot flow
> > > as well. This issue has not been diagnosed further, but I suspect it is similar
> > > to my previous patch and related to how modern GCC generates the low level
> > > op-codes.
> > >
> > > Patch 2 of 2
> > >
> > > Upstream-Status: Pending
> > >
> > > Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
> > [snip]
> > > +     /* Set all values to known good defaults as documented in       *
> > > +      * Intel FSP_MR5 file: BAYTRAIL_FSP.bsf                         */
> > > +
> > > +     /* NOTE: This breaks u-boot ability to set board options via    *
> > > +      * device tree, but guarantees specific known values..          *
> > > +      * you wouldnt use an uninitialized variable would you??        */
> >
> > /*
> >  * Multi-line comments like this please per
> >  * https://docs.u-boot.org/en/latest/develop/codingstyle.html
> >  */
> >
> > And we should spell out that device tree can't set these any more in the
> > commit message, along with spelling out why we can't do that anymore
> > safely (why can't we?). Thanks.
>
> Again I am not seeing this problem with minnowmax, so would like a few
> more details.
>

Which board is this?

Regards,
Simon
