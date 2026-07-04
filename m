Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C58AC43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 22:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CB9B8484C;
	Sun,  5 Jul 2026 00:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pe95p7Mt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 734A684671; Sat,  4 Jul 2026 15:59:20 +0200 (CEST)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 417A48341A
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 15:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-9673385b1efso488532241.2
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 06:59:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783173557; cv=none;
 d=google.com; s=arc-20260327;
 b=mPSgK2YfkDrTriSW1/gb+Nb0AocWfYsklWfGMKQAWFhjnL0EWfnfs4Sk6gDt7KoaED
 3Xz2/x10EPL9FZZkC1n5qikfYEx1mfBMKDui+zLkU4zgbo9hURtrz5yALx3YDu+oDF/1
 pcLkoSEXad6k6lb8vc5m3ewbccBcN77r0gK9vVhymi39n0pu+lPX8Q5FBIC7q9LCwYvn
 QxsLw9UQXngyOIV2f6IGlSbM0FJag5YkXXGqw+ovU0ABSN5sET0xO1gQfsl30JnXsax2
 0or50kcCVFw12FYSdTCxFHesAeeU/GCjrYSCWXtyPkr6XESGzuXQvrM3gqzjbW+TJ7q8
 T5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RvXqK2qVtAnAmUC7HV8blu1FcPv544g5zoba10H8SUE=;
 fh=7M1wwQwAbDytFfRphAwteww+JCsKEHoQ7Eac0i1ag3w=;
 b=hGVnQGgRmRVjDJ44EnhmbZnbPS2mrt3Z4K2mhNHt280qbqCxeo9Xm31YwSZtKfkWOS
 elMMCcxQGFO3hZlX/6mVYXQ0bHNicOPyrpCXW+urNly0azZSUAJ7dwO6x7PCA/bEJJT4
 be5tXbv7gb9TB/prSTB7S7JOf2C7iEhaB3BBgkAnCVyIS0c2e90xHMs+hEo8sBYirw+J
 vOKqJyC9uAW/9jgYv5D7eiIKyuEhk3emnTokLYvdglG4zV3uShG+HHwo7B+HR9rc+Njn
 HYWFzBf23FIkhLfGoLesQM6ZtsRCSW5vjJAP0OxKyoOI4YqAfR6eCYivrzVgmUnT3O4F
 mzyg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783173557; x=1783778357; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvXqK2qVtAnAmUC7HV8blu1FcPv544g5zoba10H8SUE=;
 b=pe95p7Mt16A4hMmIMW4bRTldIZpbxiMM9Tfa3IWKzpQf0FhHL7wm4TB39q2+IK5pyO
 WCoXar6tvUeL56qUY9I4Akpa15Gq1mDB7cR38EH0joe/SqVfqOam4Uzr75iOpC42hnd+
 FA43RQUn5pzpXpNfY2dtY4XeYYaPcALLsrrmuu0rPjYjv4y3O6gDXjHMZm3eJOSF/nyT
 Cp0uHNmSabycolUrQEJaNHxM+yWGD7/4sEB8n7Ll0T1GzXYUDXWdVLMG2hvpEMHJgKME
 WGKklj3c7SYxB3Cj6rxgekURSSFmxr0V6Am8EIlX6DTz/20E6dZka6cnl3I7RB4J5Thq
 7Caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783173557; x=1783778357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RvXqK2qVtAnAmUC7HV8blu1FcPv544g5zoba10H8SUE=;
 b=NuTCCmB9m5aN35DsO73hZF059LTQva4CiG1b36fD/Gep8Z/Fr5a/z8XWy9KwtKlE/z
 ES+B06lpnjeY7qwpnAoOyrHkESqdDf8rAd1Rr0BdYIHUPOdtCQur3hmCQyBASDKjg/QX
 +q6r3bgqeNVetceGx0xciXZ/iGtNkT/p0BZdwSw0Hg7V6wsLvaXdOE4MbHcsw9dmXNVJ
 NtTk5eGvZmeOQZJtq5fdei3gQlKiHxRWEJs/ApRaBYQUDe8ENu5wwpq0y2U4lcVvVjzC
 qWIWFAIav3p1ueqER+8QWe8CGuB/FU6vqMCkWeuNH5FmG9qleY93okoPBbmOfHOPi/K0
 yEzw==
X-Gm-Message-State: AOJu0Yw+bvuVrNW1IqIx1GMEsWwUemXLGAXOTtWl+CEqPNcQSUfRqyEi
 Sddq50AztrPTLPSj0E/w+mK2jzGDg4axsGrR3O6AFgX648FcfqGfgkyRCLE4rmKqxhTALP4e1s8
 xzAMs4qPr4XLDyGtMU/egJAcK78F0mZ0=
X-Gm-Gg: AfdE7cnE/mWBtWjyCqKLqA3hPzML4AxEqdhBZEQTdTAv1sl2g7s2BkaqtkhTTjh2C8i
 W8nLvXMvMhQsiGDAqpTUna1H/wIefry0acc81b1XvrQ44W83b8zLMZ5xvX1Eh0bO9Lf7PCw37y6
 Z2CAoseuJBoAv0BlzBYqf7ztxBYFLlUPtVXY+/87xyiGn5RE3PImZk1GLfc9cianN1tV1CCcWZg
 4/o/L99fR5Hc6OwXPF4cym1srAbdecoq98sKRRCuWqlJmNsqvhSzqMwR00iOosRzXhvE2Wvo2Vn
 fYS4b5XPFHdRmxMlxS0On2TPHmGqgQEcVLE2U6gVdSKvhEN/cm/I6cOeoUeRGhnu9dHjGNZW5cU
 cLYrU0vsbBx0=
X-Received: by 2002:a05:6102:1489:b0:739:77a7:90bd with SMTP id
 ada2fe7eead31-7427f59277emr978252137.26.1783173556811; Sat, 04 Jul 2026
 06:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
 <CALeDE9O-_Qj0-WE+ig2F=oRc6s9kLji+GYzZE5sfY96Rd+tUXw@mail.gmail.com>
In-Reply-To: <CALeDE9O-_Qj0-WE+ig2F=oRc6s9kLji+GYzZE5sfY96Rd+tUXw@mail.gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 4 Jul 2026 07:59:05 -0600
X-Gm-Features: AVVi8Cf4cylLo_s2tTyMdm4swnfihOERZadflZlmvWPW7laXVeAZ-7Jh_1kynnI
Message-ID: <CADvTj4oWfd3iKzwdw4rKRyU8Et21vUX4Ev4cwdttR8rJQx5-Vw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] crypto: allwinner: enable sun8i-ce FIT crypto
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>,
 Ion Agorria <ion@agorria.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Randolph Sapp <rs@ti.com>, Heiko Schocher <hs@nabladev.com>,
 Alexey Charkov <alchark@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Michael Walle <mwalle@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Thierry Reding <treding@nvidia.com>, Francois Berder <fberder@outlook.fr>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 05 Jul 2026 00:28:48 +0200
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

On Sat, Jul 4, 2026 at 4:38=E2=80=AFAM Peter Robinson <pbrobinson@gmail.com=
> wrote:
>
> Hey James,
>
> > This series enables Allwinner Crypto Engine backed FIT decryption and
> > FIT signature/hash validation for secure-boot flows on H6/H616-class
> > boards, covering both SPL and U-Boot proper.
> >
> > The purpose is to use CE-backed AES for encrypted FIT payloads on H6/H6=
16
> > and CE-backed ECDSA validation where the CE ECC engine is available,
> > currently H616, instead of relying only on software crypto paths.
>
> Out of interest do you have details of the speed up?

I don't have direct comparisons for everything being added since
there doesn't appear to be a software ECDSA pathway in uboot for
example.

AES-256 CBC when I tested was generally going at least 25 MiB/s.

Hash algos were generally fairly similar.

I think ecdsa signatures were generally around 30ms per signature
validated but that was just measured via UART timing mostly.

Note that these are very rough numbers.

>
> > At a high level this adds:
> >
> >   - SPL driver-model crypto plumbing for AES and hash providers.
> >   - FIT decrypt-to-buffer support and SPL FIT cipher support, so SPL ca=
n
> >     decrypt an encrypted U-Boot proper FIT without allocating another f=
ull
> >     payload buffer.
> >   - A shared sun8i-ce parent driver with AES and hash children for H6/H=
616.
> >   - An H616 ECDSA child for CE-backed FIT signature validation, plus co=
mmon
> >     ECDSA curve-size and key-encoding fixes for secp224r1, prime256v1,
> >     secp384r1 and secp521r1.
> >
> > The AES child supports software-provided AES-128/192/256 keys in ECB an=
d
> > CBC modes. The hash child supports the CE one-shot MD5/SHA1/SHA256/SHA3=
84/
> > SHA512 methods used by FIT verification. The ECDSA child exposes the H6=
16
> > CE ECC verifier through UCLASS_ECDSA.
>
> This is me purely thinking out loud. I did some very basic testing on
> a Allwinner A64 device of the HW crypto engine and the arm native
> crypto extensions and while there was some difference I wonder whether
> it makes more sense to looks at implementing the later, upstream Linux
> seems to be going more in that route rather than device specific
> engines as the performance is compatible and it's more widely deployed
> and hence we'd have one code path that can benefit the majority of
> devices rather that a bunch of specific drivers that need maintenance.
> Had you considered that option?

Well I think it's probably good to have both as options either way as a
HW crypto engine may have various benefits beyond just performance.

For example some HW crypto engines can use efuse based keys
directly via special CE slots.
