Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5A2C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 18:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE8A1881E5;
	Wed, 29 May 2024 20:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s022dlOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87CFA88271; Wed, 29 May 2024 20:38:25 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD1E8803A
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 20:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6bce380eb9bso56787a12.0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717007901; x=1717612701; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/3hevPe6e3Zlr8w4FSLWDHgClk3gRZ5wGdWXWn3wQg=;
 b=s022dlOMECTFawBeY0Vrwl9C/WWZepaG/j/O+fmPCCi9JccwV2S6CV7a2+Xu8+i8sd
 4KnwyAohdUiWyVoigfNnP2Wm5cHB2RX2cHdgNXaM5nJbSpXQ2O+Hf8DC8hbIeZSK5cKR
 ZkKLAteQJWE37X/lAkJdIqQEpLe/a+dEfDpTSMtbTzwTAIdxw5PUJwLOuIntR4A+92kR
 RypEwkTDKmUsUEpD1KUEKYfymOFkI5JKNv3u5vbB7nioTieRl+E6A2CMGa1E4OMYJRGw
 PWAfkgQEBo4SGNjPNscFSqI30ed4R1s4GhwmlN3X1w6xZNFymOCl5qP1IQnqm0vtZ1ck
 Qhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717007901; x=1717612701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q/3hevPe6e3Zlr8w4FSLWDHgClk3gRZ5wGdWXWn3wQg=;
 b=RxM118vv8VVBrCBx546WmV+wnVDO/Fk2BK1ExuAZYq1qThb+mADEVNBFsu0ox7ZXkg
 SHCBNuMrkEoIdzsWmaimwpU5GhvAooCsN9JZ6uVntC3kqo9P+wl4aTWD47IGaYaaulZu
 jd9uTtHiT00oPbjD5nl0nQXgAGjvTU97uLGXDnK3jyVZ0FqSbNq1zm1Maq9sXh8vnUwz
 LLjIilCRnuOkVrPe8t90gvZCBsXrFAOH+Ql+j60Q/8vWIkS5dxqj9ZTr3t6rMZwLjW1Q
 jwbnTmW0hrJ8NtLuOCzzQoaYS+3CIEQnh/8K6wXMrSQgSsHR4zbNsV7vApGorjTEn47W
 spsw==
X-Gm-Message-State: AOJu0YzQEk0m2POz6t/g1HtFBUM5FTrdUM6f8Yeog9NS/3PQEiCvhpo/
 RhDmmUyeZRnoBbdDqpHTgal/tuQW1QQbX7vVkKsADzzX6AJ+gV0ir8jH2d3czHKDQ32HMhXBG6V
 9Cmsd0lTlQZyCpSMGak73u+o5GMcg0Og1HcLA6w==
X-Google-Smtp-Source: AGHT+IGjSkmi3rAdryanM2Pqoq2m6j9oviGRcH48Og7ASc0I7W2oR0/IcXIRaWlUBCqL8qoF2oY69i4NVdTlj4ITfFI=
X-Received: by 2002:a17:90a:df05:b0:2a2:7a00:f101 with SMTP id
 98e67ed59e1d1-2bf5f10a3e2mr13673313a91.47.1717007901354; Wed, 29 May 2024
 11:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
 <20240529165814.GQ2568172@bill-the-cat>
 <CAEfUkU+zKyaqc5tFy0rN3ofm3pRuckZX6PbD00VNtWQc5COZyA@mail.gmail.com>
 <20240529180129.GB3714513@bill-the-cat>
In-Reply-To: <20240529180129.GB3714513@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 29 May 2024 14:38:10 -0400
Message-ID: <CAEfUkUJj5Y+uVmRXx+=DP-6O7dpNcMjSA1jADKaJo07RSsBjHw@mail.gmail.com>
Subject: Re: [PATCH v3 03/25] mbedtls: add mbedtls into the build system
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stefan Bosch <stefan_b@posteo.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, 29 May 2024 at 14:01, Tom Rini <trini@konsulko.com> wrote:

> On Wed, May 29, 2024 at 01:42:16PM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Wed, 29 May 2024 at 12:58, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Tue, May 28, 2024 at 07:09:14AM -0700, Raymond Mao wrote:
> > >
> > > > Port mbedtls with dummy libc header files.
> > > > Add mbedtls default config header file.
> > > > Optimize mbedtls default config by disabling unused features to
> > > > reduce the target size.
> > > > Add mbedtls kbuild makefile.
> > > > Add Kconfig and mbedtls config submenu.
> > > [snip]
> > > > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > > > new file mode 100644
> > > > index 00000000000..d6e77d56871
> > > > --- /dev/null
> > > > +++ b/lib/mbedtls/Kconfig
> > > > @@ -0,0 +1,25 @@
> > > > +menuconfig MBEDTLS_LIB
> > > > +     bool "Use mbedtls libraries"
> > > > +     select MBEDTLS_LIB_CRYPTO
> > > > +     select MBEDTLS_LIB_X509
> > > > +     help
> > > > +       Enable mbedtls libraries
> > > > +
> > > > +if MBEDTLS_LIB
> > > > +
> > > > +config MBEDTLS_LIB_CRYPTO
> > > > +     bool "Crypto library"
> > > > +     help
> > > > +       Enable mbedtls crypto library
> > > > +
> > > > +config MBEDTLS_LIB_X509
> > > > +     bool "X509 library"
> > > > +     help
> > > > +       Enable mbedtls X509 library
> > > > +
> > > > +config MBEDTLS_LIB_TLS
> > > > +     bool "TLS library"
> > > > +     help
> > > > +       Enable mbedtls TLS library
> > > > +
> > > > +endif # MBEDTLS_LIB
> > >
> > > We need much more granularity here, and to re-think some existing
> > > symbols too perhaps. What we should be able to do is pick mbedTLS or
> > > "legacy SW implementation" or "HW implementation" for the various
> > > algorithms, and that in turn can have some higher level grouping to it.
> > > This should then negate a bunch of the Makefile work you're doing as we
> > > won't have CONFIG_SHA256 enabled as we'll have
> CONFIG_MBEDTLS_LIB_SHA256
> > > or whatever enabled.
> > >
> >
> > I think we should use CONFIG_MBEDTLS_LIB_[CRYPTO,X509,TLS] for high-level
> > grouping.
> > Underneath, the CONFIG_SHA[1,256,512] switches (and other crypto options)
> > can be
> > used as sub build options in both MbedTLS and "legacy libs".
> >
> > Take hash as an example, if the users prefer to use MbedTLS other than
> > "legacy libs" for
> > hash operation, CONFIG_MBEDTLS_LIB_CRYPTO should be defined as the main
> > switch
> > (the users can still prefer to use "legacy libs" for X509 by
> > keeping  CONFIG_MBEDTLS_LIB_X509
> > disabled).
> > Then enable the algorithms they need (e.g. CONFIG_SHA256) - the algorithm
> > options works
> > for both MbedTLS and "legacy libs".
> >
> > HW implementations with MbedTLS (aka, Alternative algorithms in MbedTLS)
> is
> > another
> > topic which is not covered in this patch set (It needs to migrate each
> > vendor's solution under
> > MbedTLS alternative algorithm).
> > Current patch set is focused on SW implementation with MbedTLS.
>
> The "easy" problem with what's in v3 is that X509 and CRYPTO are
> select'd under the main heading.

Not sure if I get what you mentioned, currently all MbedTLS options are
under
Library routines > Security support
Do you think we should keep them in other places?


> The harder problem is that we
> intentionally have granularity for SHA256, SHA512, etc, etc and all of
> that goes away with the current Kconfig option if you select mbedTLS. We
> need to bring that back. And we shouldn't need to have all of the ifneq
> statements in Makefiles because both CONFIG_SHA256 and
> CONFIG_MBEDLTS_LIB_CRYPTO_SHA256 will not be true (Or possibly,
> CONFIG_SHA256 gates things U-Boot's internal API for sha256'ing
> something and CONFIG_LEGACY_SHA256 controls building lib/sha256.c).
>
> I think we should not introduce new ones like CONFIG_LEGACY_,
CONFIG_SHA[1,256,512] should be used no matter whether MbedTLS is
enabled or not.
I understand your concern, I will bring CONFIG_SHA[1,256,512] back when
MbedTLS is enabled. Those options should control the options in the MbedTLS
default config file.

Regards,
Raymond
