Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1683CD98F2
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 18:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C307484119;
	Sun, 21 Jun 2026 20:17:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dY85N68t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 119D284844; Sun, 21 Jun 2026 20:17:07 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F2B584105
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 20:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-693c69b97e7so5859570a12.2
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 11:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782065823; cv=none;
 d=google.com; s=arc-20240605;
 b=GhiHEiLdsWEvkyhoUoUSrgpZo7s0Bs+7NiZ5q20ckgmoawGGZBVSk+PqPDi6k3StMi
 xC0XUM7G7Ygpia93nPDTvjj+YZOZP2gSdGWiOpCkivM7UZe3DX4FRPZLTQPJ+9nwml3W
 RhmhsCPWI0OQtnUkTiA8wB3Uw4DbBvS5BKidmhpszzzQmmVjXuCqnx0NIOSWozK6Qw9p
 uc0xoytJ2GbrDar43+DG1qHKcbVvP7X6rjhJrcRt/thub9m6lk51YcrQfsOePu391fDI
 MREr7QG8CumH0hrR4JqfOWspQp/CuMhOheM2fur7gsx9yUx4n8iS4A00hCvidhTRUjUB
 zxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HZ/7+Qhwx5J6SPXiAKFeeJI1pMAXX5wnK1guaOI5xng=;
 fh=T2gsTWyhJ/JEA8HZ9q6S8I9r06x7Bla+FvlPy9O7BgQ=;
 b=AZoJqpw1ovZG2NoQfYqapNwpYbWaqoRSVxuo5qu2U/RqVnKL7g3HCZ4iYZineMiVzk
 Owq5dOousx/RMeo9+zKGyBAv7lT+ajHFX2jJaGNivkKdJNIg9nfmiJVfu69+qBkTGDVE
 h1EKin2tk5z9ilPS2LGdaW5WR1I6e7zeF2INCsvkqMJUbjqk5LJN0iaOHuSLS12k0Hej
 dyg3iSAx+JzGA0w6x5t4SWFd8Vpw711jVEQncIJCaWKzmdq9MNFqndj3ihigD/4soGUd
 /Lkb62yz4gqPSZeTzA90TQQfc9Ar6W0MXoPQXaMmVUbsNVeSJwcIIgMcWi/wJA2buIp/
 CEmg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782065823; x=1782670623; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HZ/7+Qhwx5J6SPXiAKFeeJI1pMAXX5wnK1guaOI5xng=;
 b=dY85N68tRTLSIxtAlKlphnVq/T77t9rDwYC+nac++oOot63lSKk1zoHwJ7U614YZsg
 Pl5HkqV1IPcWvTSoGnWBCP3zZlPDTveg9DLoTcbG/YRTqN/9o/1uRx8FPPsASDIJFLcI
 xPUcHKdExid5aeBk8xY/rq+g68YCZOR1CODfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782065823; x=1782670623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZ/7+Qhwx5J6SPXiAKFeeJI1pMAXX5wnK1guaOI5xng=;
 b=MGAN5qxRriV8gmAUlhKGZDhoysTeNJnuFXfChUxYwbOzC0YnaBAk3t1YrVVjmvC1sT
 jzORpKoudHRCkUC/wdoF9eC3oXc2XZjJBgRIblS317F51u0KReVZUTFKqqrd5ogaCaY5
 VzCLKpMQO5bfy/m2ZM9gil/2aaM2SiM6b6KVg3NCo8tScuzi8yDxj9X4VF07knXdIDKI
 q9bjDQVtp9Uhz3y+O6FC5JA2Ug6vUNvkxeZWcz42yNLwPqnxfcd1G71hcYE0Cfji0VCO
 mUB/xDEYjxUzS1cPiFAHsgN7g7bWHFOUGj8lShkw6XSztKlShtGKaq7crBmVyLRPGUpH
 iRyw==
X-Gm-Message-State: AOJu0Yw4nL9Tmf1LjoEc2tOSjAPB28ti2t/aQL7NW/JdW9UOUOKb8fU5
 KLrsV7viLk8azPKmIM2Mk6LXcGpxkzUE52LgxaV0n14Vh9GE8wdIVXoFk1Rk8lDBfJyko/lgg8v
 dEWrcY0jOLYtjzembMLgmDeorsEAir3cP/x35YUPH
X-Gm-Gg: AfdE7cm/ehH2wRzaPYUBR6kSN0x+4EjevPo9lu6yZWQlhKSuopzXB2WMBfnG3dbL/FN
 SNXuB0epq+kkQVVkZKjAQeknNLt+IAGANDkrMFLdbaVUzNi5P9HUjxJsFBwZ7+0TemPQ4DK7n3q
 Mv8GszNGHuq6obLeXpMPN0oiXXEwg1e5XFimqh/vKds9kL6mRsndIOmGACeFC41NJtZ5XlrnqnS
 1xyX7laUxxGdcAp7+gAcZwXNEqExzB5MYSfBA73dcVCY4IrjdIhMDx0lK+FHjRUCyoZkpm486TS
 hfnXJwo5
X-Received: by 2002:a05:6402:268a:b0:674:5b2c:d42c with SMTP id
 4fb4d7f45d1cf-696edc828fcmr5339201a12.3.1782065823604; Sun, 21 Jun 2026
 11:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-1-b8203682507f@samcday.com>
 <CAFLszThpB_C7fdqJC=CRx3qm+jjvykHJgSKvz+s_xbngCCXSxQ@mail.gmail.com>
 <jyKa6pVYveQ4p_bPFRjTZZYE1_2BzhtpTq2JOWxf_Kg9M11SW11LLzQtJy54OqGkfO3z8KanForRXUJt6vTgtr71L6jI-ZATQmUmE3zVDT4=@samcday.com>
In-Reply-To: <jyKa6pVYveQ4p_bPFRjTZZYE1_2BzhtpTq2JOWxf_Kg9M11SW11LLzQtJy54OqGkfO3z8KanForRXUJt6vTgtr71L6jI-ZATQmUmE3zVDT4=@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 21 Jun 2026 19:16:51 +0100
X-Gm-Features: AVVi8CdKpOo-3M74GUNO8yNvCnrqBYhFn76480K5ym82FbgvQLLd94pyrEBcueQ
Message-ID: <CAFLszTg1cz8CC1mzsbubPkADrRneCfCYbpeR+T96jirgW6a61w@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] binman: Android boot image support
To: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Bryan Brattlof <bb@ti.com>, Yannic Moog <y.moog@phytec.de>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>,
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>
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

Hi Sam,

On Tue, 9 Jun 2026 at 08:20, Sam Day <me@samcday.com> wrote:
>
> Hello Simon,
>
> On Monday, 8 June 2026 at 11:25 PM, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Sam,
> >
> > On 2026-06-07T23:37:09, Sam Day via B4 Relay
> > <devnull+me.samcday.com@kernel.org> wrote:
> > > binman: Android boot image support
> > >
> > > Introduce initial support for Android boot images (abootimgs). This
> > > initial stab supports both v0 and v2 headers. The AOSP implementation
> > > was used as a reference.
> > >
> > > Since we're targeting U-Boot use cases here, a couple of things were
> > > omitted from this impl, namely 'second' and recovery_dtbo support.
> > >
> > > Link: https://android.googlesource.com/platform/system/tools/mkbootimg/
> > > Signed-off-by: Sam Day <me@samcday.com>
> > >
> > > tools/binman/etype/android_boot.py           | 313 +++++++++++++++++++++++++++
> > >  tools/binman/ftest.py                        |  66 ++++++
> > >  tools/binman/test/vendor/android_boot_v0.dts |  29 +++
> > >  tools/binman/test/vendor/android_boot_v2.dts |  46 ++++
> > >  4 files changed, 454 insertions(+)
> >
> > > diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> > > @@ -0,0 +1,313 @@
> > > +    @staticmethod
> > > +    def _CheckFit(name, data, size):
> > > +        if len(data) > size:
> > > +            raise ValueError('%s is %d bytes, maximum is %d' %
> > > +                             (name, len(data), size))
> > > +
> > > +        return data + b'\0' * (size - len(data))
> >
> > Please raise via self.Raise() so the user gets the node path. A bare
> > ValueError makes it hard to track down which entry overflowed when
> > several android-boot images are present.
>
> Ack, done in v3.
>
> >
> > > diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> > > @@ -0,0 +1,313 @@
> > > +    def _GetEntryData(self, name, required):
> > > +        entry = self._entries.get(name)
> > > +        data = entry.GetData(required)
> > > +        if data is None and not required:
> > > +            return None
> > > +
> > > +        return data
> > > +
> > > +    def _GetOptionalEntryData(self, name, required, default=b''):
> > > +        entry = self._entries.get(name)
> > > +        if not entry:
> > > +            return default
> > > +
> > > +        data = entry.GetData(required)
> > > +        if data is None and not required:
> > > +            return None
> > > +
> > > +        return data
> >
> > These two are almost identical and the names don't distinguish them,
> > i.e. _GetEntryData() will AttributeError if the name isn't present,
> > while _GetOptionalEntryData() returns the default. Please fold them
> > into one with a default=None parameter: None means required, anything
> > else means optional (function comment). Also, the 'if data is None and
> > not required' branch in _GetEntryData() does nothing - both arms
> > return data.
>
> Good catch, collapsed and simplified _GetEntryData() in v3.
>
> >
> > > diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> > > @@ -0,0 +1,313 @@
> > > +    def ReadNode(self):
> > > +        super().ReadNode()
> > > +        self.header_version = fdt_util.GetInt(self._node, 'header-version', 0)
> >
> > ...
> > > +        if self.header_version not in (0, 2):
> > > +            self.Raise('Only Android boot image header versions 0 and 2 are '
> > > +                       'supported')
> >
> > Please call this out in the commit message - AOSP defines v0..v4 and
> > readers will wonder why v1/v3/v4 are missing. Something like "v1, v3,
> > v4 are not implemented as no use case has come up yet" would help.
>
> Noted, added the explicit callout in v3.
>
> >
> > > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > > @@ -5598,6 +5598,72 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> > > +        self.assertEqual(U_BOOT_DATA, data[0x800:0x800 + len(U_BOOT_DATA)])
> > > +        self.assertEqual(U_BOOT_DTB_DATA,
> > > +                         data[0x1000:0x1000 + len(U_BOOT_DTB_DATA)])
> > > +
> > > +        self.assertEqual(U_BOOT_DATA, data[0x800:0x800 + len(U_BOOT_DATA)])
> >
> > Last assertion duplicates the first - please drop it.
>
> Apologies, this was junk I didn't properly catch in the zillionth rebasing
> session. It was already cleaned up in a subsequent commit. v3 will clean it
> up properly.
>
> >
> > > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > > @@ -5598,6 +5598,72 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> > > +    def testAndroidBootV0(self):
> > > +        """Test that binman can produce a plain legacy Android boot image"""
> > > +        data = self._DoReadFile('vendor/android_boot_v0.dts')
> >
> > Missing coverage for several error paths - U haven't run this but
> > there is Raise() for unsupported header_version, non-power-of-two
> > page-size, etc. Binman aims for full branch coverage - please add
> > tests for these, and verify 'binman test -T' still shows 100% coverage
> > for your etype
>
> As discussed in IRC, I agree this is very reasonable... I didn't appreciate
> just how far the proposed code was from that 100% goal, though ;)

Indeed...in particularly we are not used to adding tests for failure
cases and it can be a bit tedious. It does make you think though,
whether an error is needed, whether a condition should be removed,
etc. Also it becomes very hard for future changes to break your etype.

>
> v3 introduces a much more comprehensive suite that hits 100% coverage.
>
> >
> > > diff --git a/tools/binman/test/vendor/android_boot_v2.dts b/tools/binman/test/vendor/android_boot_v2.dts
> > > @@ -0,0 +1,46 @@
> > > +                     kernel-offset = <0x00008000>;
> > > +                     ramdisk-offset = <0x01000000>;
> > > +                     second-offset = <0x00f00000>;
> > > +                     tags-offset = <0x00000100>;
> >
> > 'second-offset' is silently ignored - the etype doesn't parse it and
> > the commit message says 'second' support is dropped. Do you need it?
>
> Nope, another vestige of a previous iteration that I didn't clean up
> properly in the rebasing, sorry about that! Removed in v3.
>
> >
> > > diff --git a/tools/binman/test/vendor/android_boot_v0.dts b/tools/binman/test/vendor/android_boot_v0.dts
> > > @@ -0,0 +1,29 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +
> > > +/dts-v1/;
> >
> > Why a new 'vendor/' subdirectory? The contents here are plain Android
> > boot images, not anything vendor-specific. I'd suggest 'android/' (or
> > leaving them in test/ alongside other etype .dts files), which also
> > leaves a clearer naming pattern for QCDT/DTBH later.
>
> Fair call - I've yanked everything up to the top level in v3.
>
> >
> > > diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> > > @@ -0,0 +1,313 @@
> > > +    Example::
> > > +        A v2 abootimg with control FDT placed in the DTB section:
> > > +
> > > +        android-boot {
> >
> > ...
> > > +        A v0 abootimg with embedded control FDT (v0 doesn't support DTBs) and
> > > +        an empty ramdisk (some bootloaders insist on a ramdisk being present):
> > > +        android-boot {
> >
> > These render as one big code block in the auto-generated docs, with
> > the v0 description folded into the literal. Please split into two
> > 'Example::' blocks, with a blank line between the v0 prose and its
> > 'android-boot {'.
>
> Ack, fixed in v3.
>
> >
> > Regards,
> > Simon
> >
>
> Thanks for the thorough review Simon, much appreciated.

You're welcome.

Regards,
Simon
