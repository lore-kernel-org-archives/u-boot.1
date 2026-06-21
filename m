Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB4ECD98F0
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 18:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D8F4848DC;
	Sun, 21 Jun 2026 20:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VQG0+Rya";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5C1C8499C; Sun, 21 Jun 2026 20:18:11 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62EE848DC
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 20:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-697902dab39so1273488a12.2
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 11:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782065889; cv=none;
 d=google.com; s=arc-20240605;
 b=Vt+Jk9KDxRO+HJyymozoOmggg8p4hST76gy6A6W1MEMX+CP+s86PEdcu+ranE4noC0
 HGh9429LEI3HowvfpqCWwRAvUkIH6UW22DGKxy/EZIG9SolLYMIQRkMcHpX8ceYYPTkH
 vx0X7/YXD0bIPtYQaOoZa0k0hDzDwg4/JtZKbF+S/DIXgVNj0pIXPRT2E5TNfmjCfIbs
 5VyFzKyaLYZhXJ/okT5qD5jsqzy/VC93a4VN11zbMV8CmEpfz+4qyzS1dwnEFgE3fezd
 bFeJt3bgl7Jt5MuIEeLp+IIam9pF4vsGbU3Ib9Odi3Mo/Eg0JVuj4kAL6u1mZECi6vda
 oBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/h+rgxLhBpi/9xCkIxsn7mqf8Vn3kfaEUYs3fSPl24I=;
 fh=T2gsTWyhJ/JEA8HZ9q6S8I9r06x7Bla+FvlPy9O7BgQ=;
 b=HgopO80iaRcqePdJ+toq0P7+bZYdDDLxsXCtQEsk2Yk6ejcYgrWS2HKqdOqelPBwoy
 17xoeifCfHlXTdsBJ+Q4uS6hwyWF4L/bGVoc6Z0DJ4gJMpOIZm/sd1aTbNi0Pa876WRE
 i14kPMPQGy07ywfAC9WkXdNUkdUiHcB7N0P6f1N4EAQZOkPU7bGILrjOOBpjReGtVKJp
 X/knW5Wy1Og6FX3TNstcxMMb30iVQhjXVXSsG+8zpkrRCxqI5lxnTvnt8keKIDYnyUNn
 KlaLqYCFo9YUNO8AR/nS1Ml8o6l5yYjXu6TndmUu4d+UHNZWU7AfSz6/M4HB5Pcrj7X6
 a5CA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782065889; x=1782670689; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/h+rgxLhBpi/9xCkIxsn7mqf8Vn3kfaEUYs3fSPl24I=;
 b=VQG0+RyaHKCtUx7pw32L3LijlQ56ZCy6tAQ2ghiSIO6xbNl9kN+fePJrL4L/lArpII
 XGMbe0stJuVfJiM/btiYanyTf98Q5FPInAR6fKHMhVQTctYYqp6iDOhlQeGVWXGf0gs7
 BOxK7u6fU9rLcG9LVrWVGYyfGojfzZGZPobZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782065889; x=1782670689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/h+rgxLhBpi/9xCkIxsn7mqf8Vn3kfaEUYs3fSPl24I=;
 b=qe5+bd3SngxUt0p+8B41NslN7JqJeTa97DdjhrChHFOLr4sKASbd+bExSI88TLTvmY
 O4LBZUs1o4POO3NXvtVaWrJUs3XxZQ9os1YLd0APQnsbL7H4uqkm17UVAbDLQBFJGi9k
 kcxfHY2Ense6mkwPYhaqHtoPOkvF2gibyg+eurMomo6o+dUg2WV76+4D3mV9YQCEfx8L
 0uvL47Uyv+vHIEw4se6vD7rmKAOs4ON02rBsPFMc/+TDx3qoYCGZMZlwzHq5Uu3F3uVy
 5KoL4QQzyZh0bCZUI58gP8/W8Thy5PDq8UVgwt2b9ytMrJlBdkVUg8TqivVNTvnTeOv+
 8gBA==
X-Gm-Message-State: AOJu0YxORNKhoM4bGmHAm9gDgvRVkc5nUNynw74dBCDANSAobIswt7nc
 R52Hdo6U1+0EGRUexjjrz1hyJSgp3TLAAM+KV5DhoqEI90GyWX7atMKN6OIwBjomC7DE2ZGsyQv
 rWdZkGHd1dTe4gnccCwTZWWtLp/j0sQErn4nafj0uIOda/5V1VF68nw==
X-Gm-Gg: AfdE7cn08D80y4lAb3ZCbGhbRfyQn2qg4MGltcDC0fmVz0XwHiFlzi84A2/gp7ZD+17
 Lq3c3U5W8/t1w3BX+NQiCKP0K/06fg42smJDcbEs4xIyJDDSaKU43byig1m4tTpLCXOXs/L7JIB
 uJ2JveImvqrFS3yKZaXST+5jqTHAAmPuMxFwN5N0FkqEFQQ3/Id4M7O+pmDXVnVjleixhBAGtb5
 5UsMTI8a00N/nVzmw5kO61g4oS0WIehXsBC0eOsJpHTxP4k4PO+W6TQVCf3S36ve45+2WR0RAnP
 /r7KzMSI
X-Received: by 2002:a05:6402:d0d:b0:695:b02f:e9bf with SMTP id
 4fb4d7f45d1cf-696e52069f7mr5257576a12.25.1782065889271; Sun, 21 Jun 2026
 11:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-5-b8203682507f@samcday.com>
 <CAFLszTgj+h==F9rjS38JzY=E9xVV-qzUEXXQmbEt9qi094reMQ@mail.gmail.com>
 <GYJbTuIXLh_ITzIQPc6dJeuTu-YFrWUmgi6WLC2I2G0sQMpGol6yoA-wFPQTcJOul-dJKrrP2-IMduw6bZSpwYSj9-vADPoZ_uP548z2VYg=@samcday.com>
In-Reply-To: <GYJbTuIXLh_ITzIQPc6dJeuTu-YFrWUmgi6WLC2I2G0sQMpGol6yoA-wFPQTcJOul-dJKrrP2-IMduw6bZSpwYSj9-vADPoZ_uP548z2VYg=@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 21 Jun 2026 19:17:57 +0100
X-Gm-Features: AVVi8CeZlpokL_p3XQLoPfN5A448XeZMookwLpzHvpaSw_jJi_lvV9b44jhRuqM
Message-ID: <CAFLszThvSzWEK34hkeoPNDJLuCm4cOh11N7tv160GPMGkRovSQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] binman: android_boot: SEANDROIDENFORCE support
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

On Tue, 9 Jun 2026 at 10:31, Sam Day <me@samcday.com> wrote:
>
> Ahoy Simon,
>
> On Monday, 8 June 2026 at 11:27 PM, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Sam,
> >
> > On 2026-06-07T23:37:09, Sam Day via B4 Relay
> > <devnull+me.samcday.com@kernel.org> wrote:
> > > binman: android_boot: SEANDROIDENFORCE support
> > >
> > > Some older MSM8916-era bootloaders want to see this string appended to
> > > the abootimg, or they log an ugly warning to the screen.
> > >
> > > Signed-off-by: Sam Day <me@samcday.com>
> > >
> > > tools/binman/etype/android_boot.py                 | 11 +++++++++++
> > >  tools/binman/ftest.py                              |  6 ++++++
> > >  .../test/vendor/android_boot_seandroidenforce.dts  | 22 ++++++++++++++++++++++
> > >  3 files changed, 39 insertions(+)
> >
> > > diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> > > @@ -55,6 +57,7 @@ class Entry_android_boot(Entry_section):
> > >          - os-version: Encoded Android OS version and patch level, defaults to 0
> > >          - boot-name: Android boot image board name
> > >          - cmdline: Android boot command line
> > > +        - append-seandroid-enforce: Append Samsung SEANDROIDENFORCE trailer,
> >
> > Calling this 'Samsung' is misleading given the commit message
> > attributes it to MSM8916-era bootloaders - perhaps 'Append the
> > SEANDROIDENFORCE trailer expected by some MSM8916/Samsung
> > bootloaders'.
> >
> > > diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> > > @@ -174,6 +180,9 @@ class Entry_android_boot(Entry_section):
> > >                  self.Raise('page-size must fit the Android boot image header')
> > >              if 'dtb' not in self._entries:
> > >                  self.Raise("Missing required subnode 'dtb'")
> > > +            if self.append_seandroid:
> > > +                self.Raise("Property 'append-seandroid-enforce' requires "
> > > +                           "header-version 0")
> >
> > Just to check, is this a hard restriction of the format, or only a
> > reflection of which bootloaders are known to want this trailer? If v2
> > images can legitimately carry it too, it would be more flexible to
> > allow it. If it really is invalid, please add a short note in the
> > commit message saying why.
> >
> > > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > > @@ -5673,6 +5673,12 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> > > +    def testAndroidBootSeAndroidEnforce(self):
> > > +        """Test that binman appends SEANDROIDENFORCE"""
> > > +        data = self._DoReadFile('vendor/android_boot_seandroidenforce.dts')
> > > +
> > > +        self.assertEqual(b'SEANDROIDENFORCE', data[-16:])
> >
> > Please add a negative test for the v2 + append-seandroid-enforce
> > combination, to lock in the Raise(). It would also be worth asserting
> > the rest of the image (header, kernel page, ramdisk page) is intact,
> > so a regression that truncates the body but leaves the trailer in
> > place would still be caught.
>
> I've since realized that this entire patch is unnecessary, and I've
> dropped it from v3. Rather than codifying this, we can just take
> advantage of the flexibility binman already offers through the
> section etype, in conjunction with the text etype:
>
> binman {
>   android_boot { ... };
>   text { text = "SEANDROIDENFORCE"; };
> };
>
> Quite awesome, really :)

Ah, yes. Even so, if you want this as its own etype, you could
subclass the text one with a default/fixed string string.

Regards,
Simon
