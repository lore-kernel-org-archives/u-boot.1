Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C338DCD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF667841C2;
	Mon,  8 Jun 2026 15:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TGpUTFJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFEE98466E; Mon,  8 Jun 2026 15:25:03 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C00B801A9
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69170548d0eso2461761a12.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780925099; cv=none;
 d=google.com; s=arc-20240605;
 b=lUjC7SRgxO4PZb2fG14RoUpl8yCbsnufv+30brDGQqVkrUzWt2EYvOUdRFfX2HhX79
 pu6+YPRMC071HGzQm53IsWxo8ahVYCdjdNCh3oWoI+yFKYKrwYQIgW1+QfZ1qjj3EuoS
 HwEXWNlS7HMoQGCHkMh8q+vq4M0OeoFtMFQJj/61c24NfUaiwJpHvwd/mspCEmqYdk6X
 BpJKPgX/jiZqpqVEaEIB7amFm+AtmRjXoT6O1dFb/G0gSeFK9bHJPsivVFzJnVtH1SCA
 8go35xe+KuGEddw4nC8HLPjLe9TSGqyP/01OuetznZY5U7XsHVlpA+gidXogEyXSfj0f
 gq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e1J9UD3mwtfpLASeV5rMyQNtcI+lkrINHRWsGlLOWhI=;
 fh=Odq9NGuM9IwpgVvl6kT7EijzuJ2AzFvZQNxDvfa4hmk=;
 b=TLszV7yXfxHfpQuRg/+jz/3U0GHHyYrxCKn75YZ3caTuuyu+xtgfOvas4nfKhhEKdw
 qheRNpXpymaVao19lGsBzvQ679cGgs90vlPxXvzIc4oFjtY3FdvO/HeH7ZK+hUaQJ/JP
 ZRC6IALqVqitXzEq+pXtJxCd5IUTFHKkB/9colTXyKBoz+bOHry26U/O8ksXUppi8mVw
 C9Rh63dKL01C21JJoVSeurdPONV+vW88EQFvQQZqeZjwgNYqTXjKJQaG7wK8TO6NhpsK
 GWFRTm0GXrgGFIGPg8sgBA2S70QaOqo4SI17BdHV3acTwOWv3v8jrSFIMbmTTmem5P6s
 HNoA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780925099; x=1781529899; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e1J9UD3mwtfpLASeV5rMyQNtcI+lkrINHRWsGlLOWhI=;
 b=TGpUTFJqhutHzSRV+nUl4bHmxlHD9zSy8kgxlZKBmlj1vXCXuEtLdXiYA3O5k9znhn
 sW0BXDViAtRe6aibN0/XkEoD39ShxBF+uA48pkLo0vAovQrDTAim70/34TLXywXsvQF0
 CPftl8B1hvs2d6lJ4xtXIsOSvjfSrmKdeeIGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925099; x=1781529899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1J9UD3mwtfpLASeV5rMyQNtcI+lkrINHRWsGlLOWhI=;
 b=OmHTotqAaRISCfcjENV2e+8iJjy2zoX2vl1/HS4YBcm8ufbWbr4/OThHDI8jEYcVki
 ABbdDaKrz8UdwvKA09KNhol7X6CM+NO5z5l4aHsE0fxdmNvdIWeG1k2IuNtB9AoDeAnC
 fgJ8Q5Q4cfrF4q2m0C6U8QmaJ6UUcOLEAMhfoC7CM00oo95i1GxSjkFvUKM2BWebbjRy
 9cqXrL0J9yXpaZxxRJVfNlNOx17MsFwc0K5Ksu2A9RRrZSpUCcN9M90cW7ICRCBzZg3u
 DfzD3He9NmqOfpTmVw3mHgHNey7auXt8B/jA/cwCPzVQaUHQ+wo03rD7D734AePjQGLC
 dD2A==
X-Gm-Message-State: AOJu0YwedIVfjG76KUlQVghbcj8LnwH3eDkeR//8mLtUUs1BU3ElRWwD
 SD952/RRBz13TPNpm72iCcALC+lYjxp3hh456ON9fh6rO3t2Fexwuta+N4/RFgGkkXcolWkeke7
 QgKWddrvSsHkLjNDCxK3Ko5loibC0eOHVZtA6r0ZS
X-Gm-Gg: Acq92OEUj75muQKFyQ1twCgNsDKljtn+Y563fiY/I2CcqggGZommYFRbfY54Anys4Fu
 arci75eGcr/VG0F9Skk76qA+/CrQvwoMo8cRdaIygA74YgmZYIshfdzP9VCCBhMfZbBLFFQiyiZ
 VOR+9WUC32zxRMGQ2QXB8RQOI207oVM/3jJOLRNWEvUk8gVg6GWGPbM7GWxH89hPMxHF3N0qXFC
 aMDLbL8YodMNCMaC7y5yakOJZRDJWv3OfAeDNr/cmcxKZQ/gQoDMynJGB77F3Hd4GicxyKz911e
 yxVAYHowPsgy4TqM
X-Received: by 2002:a05:6402:3222:b0:68b:5a49:5874 with SMTP id
 4fb4d7f45d1cf-68fa51523acmr6819776a12.21.1780925099476; Mon, 08 Jun 2026
 06:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-1-b8203682507f@samcday.com>
In-Reply-To: <20260608-android-binman-v2-1-b8203682507f@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 8 Jun 2026 07:24:45 -0600
X-Gm-Features: AVVi8CdnySJ7FkVyGYylYYz9ik7bg9VOKD3Jm3Pwqplt--SoHrKlElOKM8Pdy9o
Message-ID: <CAFLszThpB_C7fdqJC=CRx3qm+jjvykHJgSKvz+s_xbngCCXSxQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] binman: Android boot image support
To: me@samcday.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Javier Tia <floss@jetm.me>, Minkyu Kang <mk7.kang@samsung.com>, 
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

On 2026-06-07T23:37:09, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> binman: Android boot image support
>
> Introduce initial support for Android boot images (abootimgs). This
> initial stab supports both v0 and v2 headers. The AOSP implementation
> was used as a reference.
>
> Since we're targeting U-Boot use cases here, a couple of things were
> omitted from this impl, namely 'second' and recovery_dtbo support.
>
> Link: https://android.googlesource.com/platform/system/tools/mkbootimg/
> Signed-off-by: Sam Day <me@samcday.com>
>
> tools/binman/etype/android_boot.py           | 313 +++++++++++++++++++++++++++
>  tools/binman/ftest.py                        |  66 ++++++
>  tools/binman/test/vendor/android_boot_v0.dts |  29 +++
>  tools/binman/test/vendor/android_boot_v2.dts |  46 ++++
>  4 files changed, 454 insertions(+)

> diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> @@ -0,0 +1,313 @@
> +    @staticmethod
> +    def _CheckFit(name, data, size):
> +        if len(data) > size:
> +            raise ValueError('%s is %d bytes, maximum is %d' %
> +                             (name, len(data), size))
> +
> +        return data + b'\0' * (size - len(data))

Please raise via self.Raise() so the user gets the node path. A bare
ValueError makes it hard to track down which entry overflowed when
several android-boot images are present.

> diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> @@ -0,0 +1,313 @@
> +    def _GetEntryData(self, name, required):
> +        entry = self._entries.get(name)
> +        data = entry.GetData(required)
> +        if data is None and not required:
> +            return None
> +
> +        return data
> +
> +    def _GetOptionalEntryData(self, name, required, default=b''):
> +        entry = self._entries.get(name)
> +        if not entry:
> +            return default
> +
> +        data = entry.GetData(required)
> +        if data is None and not required:
> +            return None
> +
> +        return data

These two are almost identical and the names don't distinguish them,
i.e. _GetEntryData() will AttributeError if the name isn't present,
while _GetOptionalEntryData() returns the default. Please fold them
into one with a default=None parameter: None means required, anything
else means optional (function comment). Also, the 'if data is None and
not required' branch in _GetEntryData() does nothing - both arms
return data.

> diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> @@ -0,0 +1,313 @@
> +    def ReadNode(self):
> +        super().ReadNode()
> +        self.header_version = fdt_util.GetInt(self._node, 'header-version', 0)

...
> +        if self.header_version not in (0, 2):
> +            self.Raise('Only Android boot image header versions 0 and 2 are '
> +                       'supported')

Please call this out in the commit message - AOSP defines v0..v4 and
readers will wonder why v1/v3/v4 are missing. Something like "v1, v3,
v4 are not implemented as no use case has come up yet" would help.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5598,6 +5598,72 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +        self.assertEqual(U_BOOT_DATA, data[0x800:0x800 + len(U_BOOT_DATA)])
> +        self.assertEqual(U_BOOT_DTB_DATA,
> +                         data[0x1000:0x1000 + len(U_BOOT_DTB_DATA)])
> +
> +        self.assertEqual(U_BOOT_DATA, data[0x800:0x800 + len(U_BOOT_DATA)])

Last assertion duplicates the first - please drop it.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5598,6 +5598,72 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testAndroidBootV0(self):
> +        """Test that binman can produce a plain legacy Android boot image"""
> +        data = self._DoReadFile('vendor/android_boot_v0.dts')

Missing coverage for several error paths - U haven't run this but
there is Raise() for unsupported header_version, non-power-of-two
page-size, etc. Binman aims for full branch coverage - please add
tests for these, and verify 'binman test -T' still shows 100% coverage
for your etype

> diff --git a/tools/binman/test/vendor/android_boot_v2.dts b/tools/binman/test/vendor/android_boot_v2.dts
> @@ -0,0 +1,46 @@
> +                     kernel-offset = <0x00008000>;
> +                     ramdisk-offset = <0x01000000>;
> +                     second-offset = <0x00f00000>;
> +                     tags-offset = <0x00000100>;

'second-offset' is silently ignored - the etype doesn't parse it and
the commit message says 'second' support is dropped. Do you need it?

> diff --git a/tools/binman/test/vendor/android_boot_v0.dts b/tools/binman/test/vendor/android_boot_v0.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;

Why a new 'vendor/' subdirectory? The contents here are plain Android
boot images, not anything vendor-specific. I'd suggest 'android/' (or
leaving them in test/ alongside other etype .dts files), which also
leaves a clearer naming pattern for QCDT/DTBH later.

> diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> @@ -0,0 +1,313 @@
> +    Example::
> +        A v2 abootimg with control FDT placed in the DTB section:
> +
> +        android-boot {

...
> +        A v0 abootimg with embedded control FDT (v0 doesn't support DTBs) and
> +        an empty ramdisk (some bootloaders insist on a ramdisk being present):
> +        android-boot {

These render as one big code block in the auto-generated docs, with
the v0 description folded into the literal. Please split into two
'Example::' blocks, with a blank line between the v0 prose and its
'android-boot {'.

Regards,
Simon
