Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCE9C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DF0F8692C;
	Thu, 25 Jul 2024 15:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A6RWdGen";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AABB487876; Thu, 25 Jul 2024 15:36:45 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A251F8641C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 15:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70cec4aa1e4so644232b3a.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 06:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721914601; x=1722519401; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xlwW+RuHHx1guQ1Q8b5kR32U9B+f1e5AdLP+YV3nQro=;
 b=A6RWdGen1ZFZOMT4CcCUmUYTiwi5yH+uMG4Z1TUBe92PuXWbrKHgRBe8mBrfAMIKbe
 i+bIRSmiUpvVh+D03BUxUHdIFuD555ukT/u4Q8HkDZfJX7y4MKx23V2TKnOKks20kAQo
 8NdC440M5vy1mg/1Jd99RhWk9ooCIrp2gtXRRcSl+zWpfoQwoDM47lS3pNuKaTFMxRnd
 DO8J4zw4aYLM8rZk/OpcyJ9LBv/GK/fziJIK4K89r4KgSHi1jdcUec+B42Wp2wZMCXr9
 SOMZaypcz9kzHnmuLZ+J/oxpc3ySRCHr/e7XR1ZogSPFqg0vA3VKVbYxj37XLpw33N25
 f0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721914601; x=1722519401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xlwW+RuHHx1guQ1Q8b5kR32U9B+f1e5AdLP+YV3nQro=;
 b=OlvJpymeefQXxQI/8iuRfGEnoE4RF092Y9MWGbIvQ8yGT9gFSGEX5yO0HomNxSNmii
 NIjNRI03XO/Z4pGvhRPiyeLP2Zv9Gs1ELfadgyMYU3KozCV+hTcBGgV9Amn9xwPDWqed
 lKCAXIlAy3rCR+4v3nZSUw+EnN83/Sd23VRL0uk+92dZdw57BzKoMf0IxH3aw1QZp9OP
 nPBSDWizruScY5mVsqsY8aJWsf6+cfQmx8jScD02mlIhN0qaDzdEW3CUlb2q8QJvanqn
 d85HCymg0Bkt9wBIB5zquvnoOzrN+dgUfbFRnKH1lKX/hFl+irhZtkFYGiFBoEwHwOXS
 Ae1w==
X-Gm-Message-State: AOJu0YzodDT2DDT1/nJSo553/BeF9tXLhM2wDcfrrfvgYEpoxaUEnT+m
 dCFUjXTgjROSAYj3R67WBzS4GESbWd3+e8YPRQgiTnggiQuIH0luS9tceJNl4OfRQDdEZj25mEM
 JEBWQr3MQL+huITJnILWJys2AeuF/P3Ea6qzrdg==
X-Google-Smtp-Source: AGHT+IGsY/9QejiuQ+tWv/TCLRRSX4e1NBLwzLFpqbFGENFUktNckrgH9OrQKXQTf51PTk7sZOUtT+LfvleB8SDg1B8=
X-Received: by 2002:a05:6a20:7f95:b0:1c0:f23c:28b1 with SMTP id
 adf61e73a8af0-1c472896309mr3866812637.23.1721914600993; Thu, 25 Jul 2024
 06:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240703012555.GX38804@bill-the-cat>
 <CAEfUkU+EKc_B3pGTWXisKbn3ZcQcvGaUhnMZ193L9ajm0pJ1xA@mail.gmail.com>
 <20240724224242.GQ989285@bill-the-cat>
In-Reply-To: <20240724224242.GQ989285@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 25 Jul 2024 09:36:28 -0400
Message-ID: <CAEfUkU+vB0-AdDyTXB8xEP2R4aH=u4bipsPuE+AFUrq=X8OxPw@mail.gmail.com>
Subject: Re: [PATCH v4 00/29] Integrate MbedTLS v3.6 LTS with U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Ilya Lukin <4.shket@gmail.com>, 
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

On Wed, 24 Jul 2024 at 18:42, Tom Rini <trini@konsulko.com> wrote:

> On Wed, Jul 24, 2024 at 10:34:50AM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Tue, 2 Jul 2024 at 21:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Tue, Jul 02, 2024 at 11:22:36AM -0700, Raymond Mao wrote:
> > >
> > > > Integrate MbedTLS v3.6 LTS (currently v3.6.0-RC1) with U-Boot.
> > > >
> > > > Motivations:
> > > > ------------
> > > >
> > > > 1. MbedTLS is well maintained with LTS versions.
> > > > 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> > > > 3. MbedTLS recently switched license back to GPLv2.
> > > >
> > > > Prerequisite:
> > > > -------------
> > > >
> > > > This patch series requires mbedtls git repo to be added as a
> > > > subtree to the main U-Boot repo via:
> > > >     $ git subtree add --prefix lib/mbedtls/external/mbedtls \
> > > >           https://github.com/Mbed-TLS/mbedtls.git \
> > > >           v3.6.0 --squash
> > > > Moreover, due to the Windows-style files from mbedtls git repo,
> > > > we need to convert the CRLF endings to LF and do a commit manually:
> > > >     $ git add --renormalize .
> > > >     $ git commit
> > > >
> > > > New Kconfig options:
> > > > --------------------
> > > >
> > > > `MBEDTLS_LIB` is for MbedTLS general switch.
> > > > `MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto libs
> > > with
> > > > MbedTLS.
> > > > `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode,
> ASN1,
> > > > and Pubkey parser with MbedTLS.
> > > > `MBEDTLS_LIB_TLS` is for SSL/TLS (Disabled until LWIP port for
> MbedTLS is
> > > > ready).
> > > > `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto
> library.
> > > > `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
> > > > `LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
> > > > For each of the algorithm, a pair of `<alg>_LEGACY` and
> `<alg>_MBEDTLS`
> > > > Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
> > > > introduced.
> > > >
> > > > In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and
> MBEDTLS_LIB_X509
> > > > are by default enabled in qemu_arm64_defconfig for testing purpose.
> > > >
> > > > Patches for external MbedTLS project:
> > > > -------------------------------------
> > > >
> > > > Since U-Boot uses Microsoft Authentication Code to verify PE/COFFs
> > > > executables which is not supported by MbedTLS at the moment,
> > > > addtional patches for MbedTLS are created to adapt with the EFI
> loader:
> > > > 1. Decoding of Microsoft Authentication Code.
> > > > 2. Decoding of PKCS#9 Authenticate Attributes.
> > > > 3. Extending MbedTLS PKCS#7 lib to support multiple signer's
> > > certificates.
> > > > 4. MbedTLS native test suites for PKCS#7 signer's info.
> > > >
> > > > All above 4 patches (tagged with `mbedtls/external`) are submitted to
> > > > MbedTLS project and being reviewed, eventually they should be part of
> > > > MbedTLS LTS release.
> > > > But before that, please merge them into U-Boot, otherwise the
> building
> > > > will be broken when MBEDTLS_LIB_X509 is enabled.
> > > >
> > > > See below PR link for the reference:
> > > > https://github.com/Mbed-TLS/mbedtls/pull/9001
> > > >
> > > > Miscellaneous:
> > > > --------------
> > > >
> > > > Optimized MbedTLS library size by tailoring the config file
> > > > and disabling all unnecessary features for EFI loader.
> > > > From v2, original libs (rsa, asn1_decoder, rsa_helper, md5, sha1,
> sha256,
> > > > sha512) are completely replaced when MbedTLS is enabled.
> > > > From v3, the size-growth is slightly reduced by refactoring Hash
> > > functions.
> > > >
> > > > Target(QEMU arm64) size-growth when enabling MbedTLS:
> > > > v1: 6.03%
> > > > v2: 4.66%
> > > > v3 & v4: 4.55%
> > > >
> > > > Please see the latest output of bloat-o-meter for the reference of
> the
> > > > size-growth on QEMU arm64 target [1].
> > > >
> > > > Tests done:
> > > > -----------
> > > >
> > > > EFI Secure Boot test (EFI variables loading and verifying, EFI signed
> > > image
> > > > verifying and booting) via U-Boot console.
> > > > EFI Secure Boot and Capsule sandbox test passed.
> > > >
> > > > Known issues:
> > > > -------------
> > > >
> > > > None.
> > > >
> > > > [1]: bloat-o-meter output between disabling/enabling MbedTLS (QEMU
> arm64)
> > > > ```
> > > > add/remove: 206/81 grow/shrink: 19/17 up/down: 55548/-17495 (38053)
> > >
> > > bloat-o-meter is a bit off then, since buildman shows:
> > > u-boot: add: 243/-17, grow: 18/-17 bytes: 65723/-8480 (57243)
> > >
> > > (Please use buildman for the size comparisons in the future).
> > >
> > > The reason that buildman is showing more growth is because I enable
> > "CONFIG_EFI_SECURE_BOOT=y" in my patch, which is off by default
> > for qemu_arm64.
> > Since the buildman is always comparing one local branch with the
> > 'upstream' (I didn't find a way to let it compare two local branches or
> > maybe
> > I am wrong), I guess I have to first merge one commit with just enabling
> > CONFIG_EFI_SECURE_BOOT to solve this. But I get this makes less
> > value...
> >
> > I think it is better to use sandbox for comparison from v5,
> > and I will add one more platform (e.g. imx8mp) for reference.
>
> Please note that I check the world before/after, not just single
> platforms, for size growth. I'll note some examples of issues when I
> find them, typically. And with the wrapper I posted, sometimes I will
> "--all" a platform to see which commit increases things.
>
> For your reference, below size-growth is for v5 (qemu_arm64, nanopi_a64,
sandbox):

aarch64: (for 2/2 boards) all +582.0 bss +40.0 data -64.0 rodata +206.0
text +400.0
  qemu_arm64     : all +7040 bss +80 data -64 rodata +212 text +6812
    u-boot: add: 28/-17, grow: 12/-16 bytes: 15492/-8304 (7188)
  nanopi_a64     : all -5876 data -64 rodata +200 text -6012
    u-boot: add: 21/-8, grow: 4/-8 bytes: 12312/-4364 (7948)
sandbox: (for 1/1 boards) all +22416.0 data +1440.0 rodata -4160.0 text
+25136.0
  sandbox        : all +22416 data +1440 rodata -4160 text +25136
    u-boot: add: 253/-203, grow: 115/-61 bytes: 93168/-76647 (16521)

I think the size-growth should be reasonable.
I will attach the details in v5 cover-letter.

Regards,
Raymond
