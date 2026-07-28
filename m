Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DCDC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D45AF4099F;
	Tue, 28 Jul 2026 11:30:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4qiaQvvBnN8s; Tue, 28 Jul 2026 11:30:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EEA24409A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238258;
	bh=8mgo3UyWh41S5oJ/JA/kdvyJfaj9UltBwhlkseQz0/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uk45mn03xInoRtk+a0uFKW38yx04rjYNFa8f5ZNszuipbIaYpoaJcfhhvm/y4acD/
	 RRrT1loJTScPQBAuUEBkbz89deN1Q1vdojEJ3DoNqnq4nIkvfFQAqx02Slz/A6/xZ1
	 9o7Gwys7Kk5/CUApKyJ3HKfV22nOurLuYtKpBHIPsPyZpegMoINy30c0xc+uvNmZYa
	 Ob78q5GIxWVboJq4Zt8IaYtXAowmxOfEV8JHrYC0KHUNzGE/eRgafoMXPV8WnDH27+
	 +jTow5gui7bmud1fCjIKEqDYMgZOMS+xLr2QGzU/irO5HCwfFfxJHUrZk+9+G/3J9T
	 NcaFJhotqPrFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEA24409A8;
	Tue, 28 Jul 2026 11:30:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8321A2E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68A9D409A8
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:30:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tv-ytyzYl1cb for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:30:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C53284099F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C53284099F
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C53284099F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:30:53 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CBB58494B; Tue, 28 Jul 2026 13:30:52 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E41DB82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:30:49 +0200 (CEST)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cab973140bso49765555ad.3
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785238248; cv=none;
 d=google.com; s=arc-20260327;
 b=QqcnPJ9G7Hhq+K2xN8vx7pSrXPMEIp/rIXUkhBFQqVh2aiKh7ueTv9m1aTIh9HbOzO
 QjhA45Zs0b7ssO+IX7jh7wUNHM1xBhLrLKVc301HsIZUhZaAyUCESt/aqs7pp5kB6C37
 w0cI5EMPBT0paT7AURh9bZuUy1C59bvr/T/YXX++Nf2KmooLOHkvpQuX4zPGbOu5yMCX
 MSDIaaayI//L6AofgI18qGyFk67L3q2/LkzbegTDpV2HDLq5lbT7GQp54p8D77AuuRW4
 L4ERJdH/UduPEiWpnFebqoyK3ie8g9t7iVgcILNbsbOKiA0NuPRCPxMw1gGx4OD8SERX
 bnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8mgo3UyWh41S5oJ/JA/kdvyJfaj9UltBwhlkseQz0/8=;
 fh=6jQArLb/PaYgRNxaFnBYY+OsKZxfY7ygrIv8Q2AWA2M=;
 b=SPiQEapalBCziG9w/rCUZ1ai8PIV7lv3HTsc9jTwd2jJET66SCN88sCz+HYjxJ1Dzd
 zf1XcczgDyWreuue5kVXT7jpUmH9iD/qSUJAMc1yiwNGXXCnMAfTNRrjKrN2LXMYx2Kt
 AvOXSX+pjFAfL7dCWcJXaxRSaQM7Ltie+uW5oEDy7P5TF2yj4gaeth/aBl59iU9iKZRk
 ir1QZDqisj/MQmp5/PAsE7lV9P7vw/cFeDX7IHhosdTiOCtuG3Z/eD7Jyl14IbOd9BX/
 hDjA8xpVskgt1zIhPldDuYtN63Vb9zUW07+Hv2ui5wRv8x1UJ0ZUnL/x7kTgepL2N3SC
 gdZQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238248; x=1785843048;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8mgo3UyWh41S5oJ/JA/kdvyJfaj9UltBwhlkseQz0/8=;
 b=LscwFTPlIfRQsKwGhUjlSwSVgwMDepRkZ5lg17p+UmV5fgBCApTUL0MILSCK/hKdVs
 CdMbQzZ/IUBgO5rUSKEGrNoR8w1ROE7nIVSvwVhWqglw9aJPsGR5smjVFXWCcX9vN7Lv
 3tAwi82wOIinwxmJy5/2vtUN+T+ktHkauMx4t1Sbp5GNdpQ6ubM5uATAfGS428SggyOS
 6DhyyI1Z977FveDkqhBBZpnLdTCRaxPR2XEpQwruzQRg2u3S2bkFzv8fflv3UAfQB9CU
 FZ40IZjETIQ/Br+URRFcXSbTj5glNCAPFn2Dt5WgZFxw3uCpWji/Vok9RXnU6DrXQJvs
 PpAA==
X-Gm-Message-State: AOJu0Yy4n080nOsDLXtBrTnPuHXsRyWFpR3iWxtHEY1H8QMFYjhGrWbw
 JWEBx6DDDNZRkkz8kGOyEIPyxqyKIKH4qd5OStzqtzbl9DiOMzPRlfbiJ2xOeOpj4hw04dUmMiN
 iiywcCS+wn+wXxvmjjR1j9L+vzCRuYhyNIlb5gxQA
X-Gm-Gg: AR+sD104KC/38iiFvhCUq5XX2cq8FlVBzhYMNdJzKaVMhrwBnT2GepSJQLYrU4MEIoE
 JWTBcaqRrwaX6L9yBnmfle3aMXgznuo88Xx/Cnsvy82LYTGgya4B/V0SwXNfw763Nz0AXY9M7/p
 8EELz5iCt1o795agUuWy54hd7Y9eSIaOYxKc/25kbm0fFr1T9geXST97aBeA7NWTo1ZLAI7uHCd
 nvcVRC/Qa7bJfsaz6Vv5QwLW4ALvqSrbBI/RhazC/7H3rWt+EVdMxKyer1F
X-Received: by 2002:a17:902:da8d:b0:2cf:7882:a444 with SMTP id
 d9443c01a7336-2d015d00c55mr25451515ad.16.1785238248201; Tue, 28 Jul 2026
 04:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260708231711.2609159-1-james.hilliard1@gmail.com>
In-Reply-To: <20260708231711.2609159-1-james.hilliard1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:30:31 -0600
X-Gm-Features: AUfX_mzOKK2a2SHS6zeWbG8c7_R13qNOS4VaqFCFt7Ab_gGBVmm_nmr2otJysR0
Message-ID: <CAFLszThQG8+U1o-3_bpjPy29NBwKVYy=+vnJCqPtnTs8pqaUEw@mail.gmail.com>
Subject: Re: [PATCH] tools: fit: sign all config image references
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Paresh Bhagat <p-bhagat@ti.com>,
 Bryan Brattlof <bb@ti.com>, 
 Shiva Tripathi <s-tripathi1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Andrew Davis <afd@ti.com>, Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785238248; x=1785843048; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8mgo3UyWh41S5oJ/JA/kdvyJfaj9UltBwhlkseQz0/8=;
 b=YeKqef859WyCUaaV8f8CEetdA5VhwFoJ2vGgGEaPyOP8TvVdT+LUYYqqJE3NdwJjuj
 E2jGBB7senBaHArjMCvv4R72CBk0YeD2nvlKjlw6LVBwdN/a3FTfhIC92myxhVUfuyKA
 FYulY53H4nmXhHigEh7l/Jmo51iZBMoHQYfmM=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=YeKqef85
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="YeKqef85";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi James,

On 2026-07-08T23:17:07, James Hilliard <james.hilliard1@gmail.com> wrote:
> tools: fit: sign all config image references
>
> Target-side configuration verification builds the signed-region list from
> every image-reference property in the selected configuration. Host-side
> signing still uses either the signature node sign-images property or the
> legacy kernel/fdt/script default list.
>
> This lets mkimage generate configuration signatures which U-Boot cannot
> verify when the configuration references other image types, such as
> firmware, loadables or ramdisk entries. It also lets the host and target
> disagree when sign-images names only a subset of the configuration images.
>
> Build the host-side signing list from the configuration properties in the
> same way as target-side verification. This makes signed configurations
> cover the root node, the configuration node, every referenced image node,
> and its hash/cipher subnodes, regardless of image type.
>
> Update the signed-configuration documentation to describe the same rule and
> to stop recommending sign-images as a selection mechanism.
>
> [...]
>
> doc/board/ti/k3.rst                | 10 ++---
>  doc/usage/fit/beaglebone_vboot.rst |  5 +--
>  doc/usage/fit/sign-configs.rst     |  7 +++-
>  doc/usage/fit/signature.rst        | 25 ++++++------
>  doc/usage/fit/uefi.rst             |  2 -
>  tools/fit_image.c                  | 12 +++---
>  tools/image-host.c                 | 82 +++++++++++++++-----------------------
>  7 files changed, 63 insertions(+), 80 deletions(-)

> Build the host-side signing list from the configuration properties in the
> same way as target-side verification. This makes signed configurations
> cover the root node, the configuration node, every referenced image node,
> and its hash/cipher subnodes, regardless of image type.

Since you are changing mkimage behaviour you may need a test. The existing
vboot .its files only reference kernel and fdt, so nothing checks that a
ramdisk, firmware or loadables entry is covered by the signature. Please
can you extend one of the sign-configs .its files (or add a new one) with
such an entry and check the resulting hashed-nodes, or that tampering with
the extra image is detected? It may be worth keeping one file with
sign-images present, to confirm it is ignored, and dropping it from the
others.

I did check that signing and fit_check_sign work with a ramdisk entry, and
that the existing check in fit_image.c still catches dangling image
references, so the silent continue on a missing image node is fine.

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -1162,27 +1162,6 @@ static int strlist_add(struct strlist *list, const char *str)
> -     /* If there is an 'sign-image' property, use that */
> -     prop = fdt_getprop(fit, noffset, 'sign-images', lenp);
> -     if (prop) {
> -             *allow_missingp = 0;
> -             return *lenp ? prop : NULL;
> -     }

With this gone, sign-images is silently ignored, so anyone using it to
sign a subset gets a different signature with no indication of why. Please
can you add a one-line warning from mkimage when the property is present,
to help people migrate?

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -1306,34 +1286,38 @@ static int fit_config_get_hash_list(const void *fit, int conf_noffset,
> +             /* Skip properties that are not image references */
> +             if (!strcmp(prop_name, FIT_DESC_PROP) ||
> +                 !strcmp(prop_name, FIT_COMPAT_PROP) ||
> +                 !strcmp(prop_name, FIT_DEFAULT_PROP))
> +                     continue;

This skip list duplicates the one in fit_config_get_hash_list() in
boot/image-fit-sig.c and any drift between the two breaks verification,
which is exactly the bug this patch fixes. Please can you put the list in
one place, e.g. a shared array or helper declared in image.h? BTW the
comment on the target-side function mentions 'load-only' being skipped,
but neither implementation does that, so that needs fixing too.

> diff --git a/doc/usage/fit/sign-configs.rst b/doc/usage/fit/sign-configs.rst
> @@ -45,8 +45,13 @@ Signed configurations
> +For signed configurations, mkimage signs every image referenced by the
> +configuration node, such as `kernel, fdt, ramdisk, firmware and
> +loadables entries. No sign-images property is required. Older FIT
> +source files may still include sign-images`, but current mkimage and U-Boot
> +verification do not use it to limit the signed image list.

Please can you also mention that every referenced image must have at least
one hash subnode? Images outside the old default list (e.g. loadables
without hashes) previously signed fine, but fit_config_add_hash() now
fails with -ENOMSG for them, so this is a new requirement on existing
source files.

Regards,
Simon
