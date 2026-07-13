Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68C5C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 14:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4082D84BC5;
	Mon, 13 Jul 2026 16:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WHryvXi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB5AD84BD8; Mon, 13 Jul 2026 16:11:31 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 686DB84A5D
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-69c5eb6dfd3so3321279a12.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:11:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783951889; cv=none;
 d=google.com; s=arc-20260327;
 b=HXBDVtRsKGV10HXx7MJGAtLK+hnhZ6N7eI/NNZig70V+kAnsvz45jm2nxJr13755L0
 ALcIrCzkD0VMUhzNbt8+A/WQ6UgNX7oBakUWKJ9sTq6h4nA2FDcxIPhuUjdEZ7PrYlGn
 6Aa2pu04KnSbIg48lZgc0261ZUKr6Ov9fd5CCMhoypYnb4Fdn+cB3NRHQPhe+9k4qgbo
 JY45UHSokapn4/oxF5N4kGwwrsTELHIVa/nTgYGvc/X6yKD+ANDgofgdyEN6kd+PlTn7
 1zm1+j5M8SUvJLqF5ZEONTUE3X1TNDbO7eS62nvoNJVZyBqPmCZMMhLuGUmTGbZ0zpTv
 oCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bXqOHH9+Nde5GoUHc7XT08q4QbO2RmEFBqSaduZ6H1g=;
 fh=FC4AFx0LQh+WPMrQRVHzHfQnZ30zeOzn1zK++7eY8+w=;
 b=qmu5SgTiB5FLBDOjb0H+qwKEnRA1fU/cbQjJwMVG59PcLZ/RzQ/iDigq+G0R/o3CEI
 s3+dWi7S1bDP0faNInrp5yKolUh9pbpi/8XPDblbwDwz8PzOs4EAtAZisRIa22GmarMu
 pOjypCXmSEG8mUrxt4LHNEf+lm0/fhw87YObesqvy0FwZ0obGcqKCDW/Fp74m1lyWLT0
 Qv9LqF1dPanvR2iWq1UssB7fCkLYom4uMHCZPziY94DNUP/+nforlysTLWqNnn1Gx+rL
 tZ6O7zw1L3eMcIa12jXt9ey2ERonJGkKT9k0iLXuPU1ZC4Dm4AwDi9FMHE/XM3UhWk/h
 5DTg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783951889; x=1784556689; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bXqOHH9+Nde5GoUHc7XT08q4QbO2RmEFBqSaduZ6H1g=;
 b=WHryvXi6xEnPBOQacT6qVek2BVHQ8/jPQ9Lt7L7ipnBm+pgppKF/1oAXqD4JRrO4+0
 dAP7dAAthePDRYhV7qoF+00gDBN9mTmPx/+YvtPCIjZwekLajh8rmRi8DWwiydecCSFf
 p1AavIPZsevhPGQlHklfWJTLe6bn0Zm/vQjwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783951889; x=1784556689;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bXqOHH9+Nde5GoUHc7XT08q4QbO2RmEFBqSaduZ6H1g=;
 b=aDTSxWbBILrg7BbYKoD2c29bupfr3DUE4GYf2jTk8V6DC8mBnPpNbghbwFN3fnCaL/
 XZ9bOn7oAyaiC+476+RuizawX51KHRjuY7zGS9VcmkLdzi7IHDwZD4BPsdbdHJYgnFRY
 uaAhpFxGbnUogMgBEQprMaucLjOUE/eu5MceETA5ebnMaBSg4IjLjNgINhxFJ28abvs7
 xN4VCm0KmR9qhu9I1t4v6q8KZAHL5qCid3bwjYBAa1OGDdh2wUs9ME5S+LblouI3n9+D
 7YXz6aEiTZs24cgCWvm4PZMECDuKz5nXfPzV2zWYoMp2GjtL5y9BPz7Lcvc0hdo9hR0F
 vkOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQV1wEUNomyzlvo8j2BCulRMIPz1/GGk6DqHlQsfxNOS1iTS1SsdQ7wvjYceP2FT/x9TWBRnk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6r4W2qagoxFpLLlEBsWKu2IceEDK2Gn2a0u2CkY9Dqp88Bef5
 opzWeW+vBWygfbDauS3v7n7q0h6SHVeIgcKvmIL1TMSczh8vFzH9njMU+xzZNFdVyB7eTLwOKVf
 95ZhBJK4KPlWepoJJZbESqY0WU9jZF3cf1FEYwcg/Yw6H6Zw8CJ7loJMA
X-Gm-Gg: AfdE7ckndsvyw60jlVXohZf9gGBiaBiIJIvrtX0JgqCnnf88j51slmaCDmv4C5q1svA
 COQwS7eljvdNHC8rdKaF9bxsyPP660HWbzeRXWqqvZQrwflXeIxQpLd1jUFROcNeveHttjN7Ign
 S196Xmbx1LQgt2FObhtc5OM6uU/WODqTNkNq+sNiFwjjBroG/oSLaJvtdp/Ri2KRyBgsg2PrlZg
 kjvNiDSAALSXP+wVu7vXUQHU79U/gbl96mjqX4H6zgyMlZG8Yn09FDrB3+Pfjblec638mc=
X-Received: by 2002:a05:6402:3548:b0:66e:abe5:ab22 with SMTP id
 4fb4d7f45d1cf-69c5f0babd2mr3902950a12.5.1783951888823; Mon, 13 Jul 2026
 07:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <DJV8L3WDJM4Y.1DD4YDH3JEKK9@ti.com>
In-Reply-To: <DJV8L3WDJM4Y.1DD4YDH3JEKK9@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 08:11:16 -0600
X-Gm-Features: AUfX_myYnFJCMddhlOziaaScQPDXXOVmSA7Uir2jQX2lX9BpCSyOw7vWF6feUWk
Message-ID: <CAFLszTgcORCdBtLuGrsToxV_o8ZcqvOOb1WZ=4jCtXWvmYSwHw@mail.gmail.com>
Subject: Re: Proposed k3-binman.dtsi and k3-binman-capsule.dtsi cleanup
To: Randolph Sapp <rs@ti.com>
Cc: trini@konsulko.com, anshuld@ti.com, bb@ti.com, afd@ti.com, nm@ti.com, 
 u-boot@lists.denx.de
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

Hi Randolph,

On Fri, 10 Jul 2026 at 16:20, Randolph Sapp <rs@ti.com> wrote:
>
> Hello,
>
> We've got a device that's making it's way upstream "AM62Lx" that will break the
> current assumption in k3-binman.dtsi that specific binaries should or should not
> be produced based on the selected *architecture*.
>
> Right now I've seen we're just adding a platform specific "*-binman.dtsi" to get
> around that, but realistically speaking it's not defining anything *new*.
>
> I've got 2 ideas on how to clean this up a little bit. Wondering if this is
> worth doing and if so, which way we'll want to go.
>
> ---
>
> 1. New Kconfig options
>
> I've seen that sunxi-u-boot.dtsi has a nice Kconfig parameter for their binary
> definitions. A pattern that rockchip-u-boot.dtsi has adopted mostly (with one
> exception that's still checking the compilation architecture).
>
> I like this pattern. I think it's very clear that none of the binman definitions
> are actually architecture specific, it's just a byproduct of the specific
> device's boot-flow.
>
> We could easily replicate this with a TI_K3_TIBOOT, TI_K3_TISPL, and TI_K3_UBOOT
> (or similarly named) Kconfig options to remove both the proposed platform
> specific binman.dtsi and the current k3-binman-capsule-r5.dtsi in one go.
>
> It wouldn't require touching that many files, and we can keep a single clean
> include at the top of the u-boot.dtsi files. It'll also clean up the current
> conditional includes used for EFI capsule support.
>
> ---
>
> 2. Reuse existing Kconfig options
>
> Almost every K3 platform supporting capsules already has an ifdef for the A53
> and R5 target platform variants in their corresponding u-boot.dtsi. We could
> reuse that pattern and simply split the current k3-binman.dtsi into two parts.
>
> This would be a little weird if we kept the r5 naming convention for the files
> though, as the new platform doesn't have an r5 involved in the boot process. I
> kind of want to use "primary" and "secondary" naming since the split would
> appear to be arbitrary without this whole explanation.
>
> This also means we'll have to add this pattern to any platform's u-boot.dtsi
> that wasn't already supporting capsules. It'll result in an immediate line count
> increase across multiple files and a rather messy diff.
>
> ---
>
> Curious what opinions people have before I start shuffling files on my end.

Option 1 seems much better to me. The real problem is that
CONFIG_ARM64 is being used as a proxy for 'which images does this
build produce', and this proxy is breaking down. So the fix is to make
the condition say what it means.

A few suggestions:

- Name the options after the artefacts rather than the boot stage,
e.g. TI_K3_BINMAN_TIBOOT3 / _TISPL / _UBOOT, since 'tiboot3.bin' etc.
are the things being gated. Whatever the spelling, the option should
read as "this build produces this image".

- Make them hidden options (no prompt), selected by the SoC/target
Kconfig entries. Boards should not be able to choose an inconsistent
set, and it keeps the cost per target to a single select.

- The two capsule files can then merge into one, with each gated on
the same option as the image it wraps.

Obviously the genuinely architecture-specific parts (the FIT arch
properties, load addresses) should stay keyed off CONFIG_ARM64

Regards,
Simon
