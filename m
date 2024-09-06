Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2049CE7B1F
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 14:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6700688950;
	Fri,  6 Sep 2024 16:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KYounen4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57525886F9; Fri,  6 Sep 2024 16:50:34 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7300788C9F
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 16:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so1418498a12.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725634230; x=1726239030; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bi8Mgkprc/WI1nRt/mzhEtZbNM9nsRaAtCXAYP4BtjE=;
 b=KYounen46b4UhPfeeR7P73qvAFF9NcAkSxsh0G/alGTPe7XSV1vC3OLBFusgmIJ5QS
 ARVssYekO2eiiuOG7L8WVqzdQ8o1vJcQYEIJ6VRre5qXnWeviwvOF1caW4jFXbykpz+j
 z21XehHkx2H5reIFiPHWcqHOjEhRmIeefdYhgRkwcCJCxPhJnt9Im6dwgS+6eOn8OAkZ
 6+uPGSGonB997ZIdOKO9KANl4bP9568Zqiwfof/+LSnEeg1UW0ecFHm4yv4nMgPOovmL
 5/+bku0Y67Jln+yk1YrRbmKQtRG1lNydfxMhjcgR5y6eQIwbD/wt4drSopLzYdHLeCA1
 xlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725634230; x=1726239030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bi8Mgkprc/WI1nRt/mzhEtZbNM9nsRaAtCXAYP4BtjE=;
 b=K0J3scxrvkPnqTnxaq61qMTA1V7zaejl0lK+Hxigi8FbxZ7oQcvnaYZGnvoeCmwHh9
 9T+urlyXKCyKTdRam/8Pl2IsHOsswWI94QMpfAHLJXp1KYYIHFZEriImcQ0v7M99i5OU
 c/pGg0FKPunhIZ1sWv+wZEUGLKrJCGRTi0vdOgGgB8r4AgMc8AGezRZsQxsP/93HxsvW
 teYGlrY03tW8EDqQo0hjxDOglvuukCT9avRY2LTqN3rsNjnrXLCv+LBl14RoEOrGdRK6
 ovmiYIkked0Mk8ZmCI7oNC/kO3bWsiCKg5zQnzQ7tzUEOmbqApzzklQyKUM/ojQeRHz8
 8/PQ==
X-Gm-Message-State: AOJu0YyC0Y7wCoF49cAZXiJO1QUz1Hr4eG1XB8sogAgRrevGiJhxnIY0
 wdLbdRu0HQtgsrSsk/dG0Y0X1XnFUOa2yToXUhiz1TcS8ft5ZibDbq6bq6WHbDH+AAwoQa7MkgH
 LuI0iVBtzBbQBeQFFOQFE6OfYSgOHaNqs72az6A==
X-Google-Smtp-Source: AGHT+IGwC3qtjkYzFuyWDmZAj5dNwG3TW1ge6OPktQD7CDltNphL27L5fzxMmqkUVws6Z1pzTxc6jYZPG2tyqaWKc9g=
X-Received: by 2002:a05:6a21:710a:b0:1cf:122b:6c7a with SMTP id
 adf61e73a8af0-1cf1d131cafmr2424865637.29.1725634229756; Fri, 06 Sep 2024
 07:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <CAFLszTiRy3dkrTVnkV-H=CcCxJH6W5=RBM9tokOiSN-AVXGywA@mail.gmail.com>
 <CAEfUkU++=WbmePTa_JwPkn6VoG0C+Y=U7SebXmNhcLyPTbKrZQ@mail.gmail.com>
 <CAFLszTh56FrvLaHvat6Oz97EVzw9xYmQr+WyDNtYE=c2qmyJ5w@mail.gmail.com>
In-Reply-To: <CAFLszTh56FrvLaHvat6Oz97EVzw9xYmQr+WyDNtYE=c2qmyJ5w@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 6 Sep 2024 10:50:15 -0400
Message-ID: <CAEfUkU+iXQVBTmTc3A4HUEFdm2NapoqzQefOamczRkkhPsa0Bw@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Integrate MbedTLS v3.6 LTS with U-Boot
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
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

Hi Simon,

On Thu, 5 Sept 2024 at 20:43, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Tue, 3 Sept 2024 at 08:59, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Sat, 17 Aug 2024 at 11:58, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Raymond,
> >>
> >> On Fri, 16 Aug 2024 at 15:44, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> >> >
> >> > Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.
> >> >
> >> > Motivations:
> >> > ------------
> >> >
> >> > 1. MbedTLS is well maintained with LTS versions.
> >> > 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> >> > 3. MbedTLS recently switched license back to GPLv2.
> >> >
> >> > Prerequisite:
> >> > -------------
> >> >
> >> > This patch series requires mbedtls git repo to be added as a
> >> > subtree to the main U-Boot repo via:
> >> >     $ git subtree add --prefix lib/mbedtls/external/mbedtls \
> >> >           https://github.com/Mbed-TLS/mbedtls.git \
> >> >           v3.6.0 --squash
> >> > Moreover, due to the Windows-style files from mbedtls git repo,
> >> > we need to convert the CRLF endings to LF and do a commit manually:
> >> >     $ git add --renormalize .
> >> >     $ git commit
> >> >
> >> > New Kconfig options:
> >> > --------------------
> >> >
> >> > `MBEDTLS_LIB` is for MbedTLS general switch.
> >> > `MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto libs
> with
> >> > MbedTLS.
> >> > `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode,
> ASN1,
> >> > and Pubkey parser with MbedTLS.
> >> > `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto
> library.
> >> > `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
> >> > `LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
> >> > For each of the algorithm, a pair of `<alg>_LEGACY` and
> `<alg>_MBEDTLS`
> >> > Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
> >> > introduced.
> >> >
> >> > In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and
> MBEDTLS_LIB_X509
> >> > are by default enabled in qemu_arm64_defconfig and sandbox_defconfig
> >> > for testing purpose.
> >> >
> >> > Patches for external MbedTLS project:
> >> > -------------------------------------
> >> >
> >> > Since U-Boot uses Microsoft Authentication Code to verify PE/COFFs
> >> > executables which is not supported by MbedTLS at the moment,
> >> > addtional patches for MbedTLS are created to adapt with the EFI
> loader:
> >> > 1. Decoding of Microsoft Authentication Code.
> >> > 2. Decoding of PKCS#9 Authenticate Attributes.
> >> > 3. Extending MbedTLS PKCS#7 lib to support multiple signer's
> certificates.
> >> > 4. MbedTLS native test suites for PKCS#7 signer's info.
> >> >
> >> > All above 4 patches (tagged with `mbedtls/external`) are submitted to
> >> > MbedTLS project and being reviewed, eventually they should be part of
> >> > MbedTLS LTS release.
> >> > But before that, please merge them into U-Boot, otherwise the building
> >> > will be broken when MBEDTLS_LIB_X509 is enabled.
> >> >
> >> > See below PR link for the reference:
> >> > https://github.com/Mbed-TLS/mbedtls/pull/9001
> >> >
> >> > Miscellaneous:
> >> > --------------
> >> >
> >> > Optimized MbedTLS library size by tailoring the config file
> >> > and disabling all unnecessary features for EFI loader.
> >> > From v2, original libs (rsa, asn1_decoder, rsa_helper, md5, sha1,
> sha256,
> >> > sha512) are completely replaced when MbedTLS is enabled.
> >> > From v3, the size-growth is slightly reduced by refactoring Hash
> functions.
> >> > From v6, smaller implementations for SHA256 and SHA512 are enabled and
> >> > target size reduce significantly.
> >> > Target(QEMU arm64) size-growth when enabling MbedTLS:
> >> > v1: 6.03%
> >> > v2: 4.66%
> >> > v3 - v5: 4.55%
> >> > v6: 2.90%
> >> >
> >> > Please see the latest output from buildman for size-growth on QEMU
> arm64,
> >> > Sandbox and Nanopi A64. [1]
> >> >
> >> > Tests done:
> >> > -----------
> >> >
> >> > EFI Secure Boot test (EFI variables loading and verifying, EFI signed
> image
> >> > verifying and booting) via U-Boot console.
> >> > EFI Secure Boot and Capsule sandbox test passed.
> >> >
> >> > Known issues:
> >> > -------------
> >> >
> >> > None.
> >>
> >> I wonder if we could leave out the SHA stuff? The algorithms are
> >> stable and this would seem to avoid much of the size growth, and all
> >> the pain of trying to integrate another yet another hashing layer (we
> >> already have normal, progressive and h/w acceleration, plus
> >> UCLASS_HASH which h/w acceleration should use but that migration never
> >> happened). I struggle to see any benefit in replacing U-Boot's very
> >> solid hashing infra with something else, particularly as this series
> >> adds yet another. Better to invest the time to refactor it. I asked
> >> about this before and was told that it would happen 'later'. Let's
> >> just not change it at all, then it is more likely someone will sort it
> >> out.
> >>
> > Unfortunately, MbedTLS depends on its own digest layer. Unless we patch
> MbedTLS
> > to allow an external digest library from U-Boot ...
>
> Yes that sounds best. It looks like only a few call sites, so it
> should be a matter of leaving out the MbedTLS code and adding some
> static inlines.
>
> Inspired by Ilias's reply to patch #7, though we can use the MbedTLS hash
alternative options,
we still need to convert all U-Boot hash APIs to adapt to the MbedTLS style.
This will impact all callers in U-Boot and I don't think it worth to do, at
least now.
As the first patch set to introduce MbedTLS to U-Boot with turning on all
necessary features,
I think this patch set is in the best way with an overall consideration.

[snip]

Raymond
