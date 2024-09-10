Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F923EDE9AD
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 18:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39EF589106;
	Tue, 10 Sep 2024 20:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jr6PxlPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08C8688CE7; Tue, 10 Sep 2024 20:44:27 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 556388910C
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 20:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6c34fb4f65eso32909196d6.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725993863; x=1726598663; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I+mDaoNPzyCJpRN15sCzVBIoBgdyzeg2gyP5R+PuOTc=;
 b=jr6PxlPR3OCy46v5jfEGf9aIC4UflZ6UNlJFjqk2Y5TtI9nx1YzmNeyO01pQIqKpZo
 LgXTLT06iTy+s53mhU4/XV6LWMtRw/yePYGxpse/J4IHFiDg5Kb4aiTBszjLVyDuNt0v
 yQlgZyzPWLgnvn6SCxq7hSMJ1JRD7DoxAnnXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725993863; x=1726598663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I+mDaoNPzyCJpRN15sCzVBIoBgdyzeg2gyP5R+PuOTc=;
 b=qSp6xl3QgZRssAPTybDcVXIQFMh45Yu2YUBmhj9cFiAth+gOpz4xO+eDAnutmNeo/B
 MN0cIpAgHcJPeaghQjuLci8yA8be7UtEX+/D0X/BGbJVjD0sdJuZZCyWS2wRgCkmNNRt
 WFLNsWTFVSezkNgVtT2SEHcCeIF19CKIa0jfiGrFkEeZRQWiGnaNgIEDyrcM3p3Gyesk
 pgohf48wOAZMg+BBomFOP3j6He9jnzjp4mIRvP0JB9TE/e/eV2tWXMh7i8KHpEnnzjMB
 VflMU3rdPGswfXHjKDbe8D7kun+Qg6X1dHFlz8s0O1nE+GynVeJm1YmpbQrZWUHDofLz
 hSUA==
X-Gm-Message-State: AOJu0YySlHrxVafhW8nJFp0RGHNWqJVPzpafssG1/j5mwu4LXfXrEn3Q
 5rpowoSCIXX1f3wX1/NMc5RXyrmZTIOJKlIOmjRhlyRfOOzHN6B5cXIu+iJP4Uos6yBfe8nHQDm
 z7fVL+WqAEOhVitGZBv9vRuRsAQNPiXUpsYsV
X-Google-Smtp-Source: AGHT+IHZGo4lT6p0XUpmXguxO36u0vGhfKJxolxGs1iUzrKfrecbyXuHvgF2RU6vb0WEmZhFmslchyKGYXOvgeHx0hY=
X-Received: by 2002:a05:6214:3b87:b0:6c5:5324:6f44 with SMTP id
 6a1803df08f44-6c553246f52mr72886926d6.35.1725993863104; Tue, 10 Sep 2024
 11:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <CAFLszTiRy3dkrTVnkV-H=CcCxJH6W5=RBM9tokOiSN-AVXGywA@mail.gmail.com>
 <CAEfUkU++=WbmePTa_JwPkn6VoG0C+Y=U7SebXmNhcLyPTbKrZQ@mail.gmail.com>
 <CAFLszTh56FrvLaHvat6Oz97EVzw9xYmQr+WyDNtYE=c2qmyJ5w@mail.gmail.com>
 <CAEfUkU+iXQVBTmTc3A4HUEFdm2NapoqzQefOamczRkkhPsa0Bw@mail.gmail.com>
In-Reply-To: <CAEfUkU+iXQVBTmTc3A4HUEFdm2NapoqzQefOamczRkkhPsa0Bw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Sep 2024 12:44:12 -0600
Message-ID: <CAFLszThct-czdZcBr-pjco9+ewtYtPJMvKtWf6vJb5n2s=9=gg@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Integrate MbedTLS v3.6 LTS with U-Boot
To: Raymond Mao <raymond.mao@linaro.org>
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

Hi Raymond,

On Fri, 6 Sept 2024 at 08:50, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 5 Sept 2024 at 20:43, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Raymond,
>>
>> On Tue, 3 Sept 2024 at 08:59, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > Hi Simon,
>> >
>> > On Sat, 17 Aug 2024 at 11:58, Simon Glass <sjg@chromium.org> wrote:
>> >>
>> >> Hi Raymond,
>> >>
>> >> On Fri, 16 Aug 2024 at 15:44, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >> >
>> >> > Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.
>> >> >
>> >> > Motivations:
>> >> > ------------
>> >> >
>> >> > 1. MbedTLS is well maintained with LTS versions.
>> >> > 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
>> >> > 3. MbedTLS recently switched license back to GPLv2.
>> >> >
>> >> > Prerequisite:
>> >> > -------------
>> >> >
>> >> > This patch series requires mbedtls git repo to be added as a
>> >> > subtree to the main U-Boot repo via:
>> >> >     $ git subtree add --prefix lib/mbedtls/external/mbedtls \
>> >> >           https://github.com/Mbed-TLS/mbedtls.git \
>> >> >           v3.6.0 --squash
>> >> > Moreover, due to the Windows-style files from mbedtls git repo,
>> >> > we need to convert the CRLF endings to LF and do a commit manually:
>> >> >     $ git add --renormalize .
>> >> >     $ git commit
>> >> >
>> >> > New Kconfig options:
>> >> > --------------------
>> >> >
>> >> > `MBEDTLS_LIB` is for MbedTLS general switch.
>> >> > `MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto libs with
>> >> > MbedTLS.
>> >> > `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode, ASN1,
>> >> > and Pubkey parser with MbedTLS.
>> >> > `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto library.
>> >> > `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
>> >> > `LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
>> >> > For each of the algorithm, a pair of `<alg>_LEGACY` and `<alg>_MBEDTLS`
>> >> > Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
>> >> > introduced.
>> >> >
>> >> > In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X509
>> >> > are by default enabled in qemu_arm64_defconfig and sandbox_defconfig
>> >> > for testing purpose.
>> >> >
>> >> > Patches for external MbedTLS project:
>> >> > -------------------------------------
>> >> >
>> >> > Since U-Boot uses Microsoft Authentication Code to verify PE/COFFs
>> >> > executables which is not supported by MbedTLS at the moment,
>> >> > addtional patches for MbedTLS are created to adapt with the EFI loader:
>> >> > 1. Decoding of Microsoft Authentication Code.
>> >> > 2. Decoding of PKCS#9 Authenticate Attributes.
>> >> > 3. Extending MbedTLS PKCS#7 lib to support multiple signer's certificates.
>> >> > 4. MbedTLS native test suites for PKCS#7 signer's info.
>> >> >
>> >> > All above 4 patches (tagged with `mbedtls/external`) are submitted to
>> >> > MbedTLS project and being reviewed, eventually they should be part of
>> >> > MbedTLS LTS release.
>> >> > But before that, please merge them into U-Boot, otherwise the building
>> >> > will be broken when MBEDTLS_LIB_X509 is enabled.
>> >> >
>> >> > See below PR link for the reference:
>> >> > https://github.com/Mbed-TLS/mbedtls/pull/9001
>> >> >
>> >> > Miscellaneous:
>> >> > --------------
>> >> >
>> >> > Optimized MbedTLS library size by tailoring the config file
>> >> > and disabling all unnecessary features for EFI loader.
>> >> > From v2, original libs (rsa, asn1_decoder, rsa_helper, md5, sha1, sha256,
>> >> > sha512) are completely replaced when MbedTLS is enabled.
>> >> > From v3, the size-growth is slightly reduced by refactoring Hash functions.
>> >> > From v6, smaller implementations for SHA256 and SHA512 are enabled and
>> >> > target size reduce significantly.
>> >> > Target(QEMU arm64) size-growth when enabling MbedTLS:
>> >> > v1: 6.03%
>> >> > v2: 4.66%
>> >> > v3 - v5: 4.55%
>> >> > v6: 2.90%
>> >> >
>> >> > Please see the latest output from buildman for size-growth on QEMU arm64,
>> >> > Sandbox and Nanopi A64. [1]
>> >> >
>> >> > Tests done:
>> >> > -----------
>> >> >
>> >> > EFI Secure Boot test (EFI variables loading and verifying, EFI signed image
>> >> > verifying and booting) via U-Boot console.
>> >> > EFI Secure Boot and Capsule sandbox test passed.
>> >> >
>> >> > Known issues:
>> >> > -------------
>> >> >
>> >> > None.
>> >>
>> >> I wonder if we could leave out the SHA stuff? The algorithms are
>> >> stable and this would seem to avoid much of the size growth, and all
>> >> the pain of trying to integrate another yet another hashing layer (we
>> >> already have normal, progressive and h/w acceleration, plus
>> >> UCLASS_HASH which h/w acceleration should use but that migration never
>> >> happened). I struggle to see any benefit in replacing U-Boot's very
>> >> solid hashing infra with something else, particularly as this series
>> >> adds yet another. Better to invest the time to refactor it. I asked
>> >> about this before and was told that it would happen 'later'. Let's
>> >> just not change it at all, then it is more likely someone will sort it
>> >> out.
>> >>
>> > Unfortunately, MbedTLS depends on its own digest layer. Unless we patch MbedTLS
>> > to allow an external digest library from U-Boot ...
>>
>> Yes that sounds best. It looks like only a few call sites, so it
>> should be a matter of leaving out the MbedTLS code and adding some
>> static inlines.
>>
> Inspired by Ilias's reply to patch #7, though we can use the MbedTLS hash alternative options,
> we still need to convert all U-Boot hash APIs to adapt to the MbedTLS style.
> This will impact all callers in U-Boot and I don't think it worth to do, at least now.

Agreed.

> As the first patch set to introduce MbedTLS to U-Boot with turning on all necessary features,
> I think this patch set is in the best way with an overall consideration.

I am not convinced, sorry. Can you update MbedTLS so that its hash
algo can be changed to call the U-Boot one? Then we can deal with
hardware acceleration, driver model and avoid yet another layer of
cruft in common/hash.c

I see only a few calls...and the hash algos are so simple and stable
that there really is no value to U-Boot of all of this pain.

Alternatively, if for some reason you really want this series in as
is, if you have a plan and scheduling to tidy this up immediately
after this series, I could be convinced to look the other way.

Regards,
Simon
