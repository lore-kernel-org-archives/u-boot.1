Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1238AC4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 14:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38DEE84E38;
	Fri, 17 Jul 2026 16:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ImnH2+Jx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0953384E50; Fri, 17 Jul 2026 16:11:59 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32FE84E05
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 16:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-69e7a5b61e4so446102a12.2
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 07:11:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784297515; cv=none;
 d=google.com; s=arc-20260327;
 b=QUrq2gSM6Zoe/tpm1MIcUwOiVNpL1nszaYkw4fNChlNSYsK4ANvma3v4AI71T5O7US
 jEysCgBpzlBFvsoAdtnrGj7WDB4D4Z/jOf+rz3CefYqaEUoQ8SZJ1mRVv0P01Oc4KYgJ
 1MayA0k9Gzck2p4mA+EtQ7rdkWXvn0AtFBqVZDaaTfQ3ZAuwx85+BIZw9e0coc8ApM3k
 ENGjvQsuHNfzJMhh6/5H456z2TwTltUhM3hHCe2g6w9mNoTZGjnX41/PVYVw9FCHrNba
 XBO6Buk/ghZUNWkHLXugsBz4Krs9er4JQZIfxqIedtWASaSJvaW2DEJmhd9iKUJMwvoB
 T09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QDRb8//P40qfcB4nK+/o/8no8J2jWq+oz7zqJLKDvIM=;
 fh=OqT8nV0sGx179V0pCjSZbhv8utV4J9HdN1hsQGVI7mE=;
 b=kYaURGbhKWmA4bmbZRK3sRlGEcPM1fZSrzU1U1Rsz44b5YfZ5WM9b9ElGQ/mKjIfHS
 GVwLqODx8ob0QdAtTmyKM2vMDlNFHWoAh174t34dN4GgrjYF1wcwT9gB36/x7HpYJP8+
 Pb40jibSefHFHtdv7t9ezFcKqWfU9WC2xyd+LfkqJiIz0mnpwUHzM9tNGfB4oFw6pYpk
 Xm7VZSrxuVrIt2cJ2gJUpVLNX8fLBn+lX2bA9i61widxJIty7oG8zfkU0zJIPLwh2+jg
 maAF5zQc27KB2wVSoi3R1Z0cidJoLL/M3Pd4dSTp5SAvLLdsiiPk+rniOT1/Hg/6Y+J5
 AObg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784297515; x=1784902315; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QDRb8//P40qfcB4nK+/o/8no8J2jWq+oz7zqJLKDvIM=;
 b=ImnH2+Jx6AidUMvR4LUKwQ+AfFpjnhj7kj71lhEe+a62KUHGWqYaCsXu3teV3B6rs0
 OevgXWk7REzdNLajsVwtFKt8raVq5b+kl/p4rbGtPo6xg/jKv+WzF18zW1e2Kt/ptHAJ
 ScsjJCthO8t2SIUt0eKZAeptOjnobNqTWiEOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784297515; x=1784902315;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QDRb8//P40qfcB4nK+/o/8no8J2jWq+oz7zqJLKDvIM=;
 b=nckN43t6YnZCO9iaae42hfet1lIqX9/phE3PYsbLrBRZOaI+dU+qYwWbiRmxO6K+Ux
 gCyjHWC6AzundnpNoSwOXkXff5G7RV05AKUAqm+hfrorVGyNxYy1GNKiFXD8jupAzINZ
 52rh3Gnm4+iak/KjL/KTwUCAPNPBLjHn5Pz+FtCUWlwS/e/R5QMafk8hBGFlLGqg2AVR
 BnE3u07HmDmD/OT0f1cOT8aJTVx4Uuq/U7M/Nx34NQbXMLbHOgcOxR21pPk5+NguKIkH
 4DjAlq3ycfz8bPZRYSzf6Mal7V2oAv+ezScAAPcGu/7FiGIcFsPQqKuZHDUOI4fSkC5M
 oj4A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8GZ6RA853H+EDKxxxSISt5qw/eD2LF5u5QzQsCNZiiO7+8pThaTlCdmsZ3RBND4KHZTabqbQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwbVB9fba2NP9jK6U3cUfld1KEkELvA+nhZ7w9Gq09uG0ZkT7FF
 Ib/8EzuKk2k1x8jflilPHvCKpoLJCZsF7tDZt1o29+7Q26fPhGa1hgPMZnIql4xVCWwSKdguoj3
 msorcHeUdaTeFcV5G57LfFyeYL12YHud8K7Yijboi
X-Gm-Gg: AfdE7cmsaAav6xv6Ycd3pj5BGaMMcRxbW7xmju3HUnYknEdHpkAgH94lcvjSTlaIugV
 USJEty0k0lxXcwHM0hj0HRmWGbJTbxKI/+JQHxFwLYM/vCtT0ssKqLyaWt/gzJN6yjbwEyw2MGJ
 0HP/neMrJLIxfp5UGoj4WVEsHWrDTKPfSha5BeaeAA8VBeq8hI5leTbLiVmWB7K8JEuN2yJ2Wi1
 hqzbfG8jRljyIaBmQJcYAKcRED1GbcYGHAHu/R5lnuFN827aiPtd2nuQVvW
X-Received: by 2002:a05:6402:3549:b0:698:3b7c:7e5c with SMTP id
 4fb4d7f45d1cf-69e6531cc15mr1041003a12.40.1784297515029; Fri, 17 Jul 2026
 07:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260713074539.32875-1-liulhong617@163.com>
In-Reply-To: <20260713074539.32875-1-liulhong617@163.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jul 2026 08:11:42 -0600
X-Gm-Features: AUfX_mwb8HYL2E8thzfp-zrKSSz7bzJx9FplbNuN5ycoCvIQa6CGFpPJ4bubODI
Message-ID: <CAFLszTjMJq2C02Xc0YTX0+5Q-DOPK+zrKn62PwU1qE+vPBASCw@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: depend on OF_LIST dts sources for
 fit-dtb.blob
To: liulhong617@163.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
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

Hi Lianghong,

On 2026-07-13T07:45:39, lianghong617 <liulhong617@163.com> wrote:
> Makefile: depend on OF_LIST dts sources for fit-dtb.blob
>
> When CONFIG_MULTI_DTB_FIT is enabled, fit-dtb.blob is produced by
> mkimage with one "-b <dtb>" argument for every entry in
> CONFIG_OF_LIST.  The make rule, however, only listed dts/dt.dtb
> (i.e. the CONFIG_DEFAULT_DEVICE_TREE blob) as a prerequisite:
>
>   fit-dtb.blob: dts/dt.dtb FORCE
>       $(call if_changed,mkimage)
>
> Because FORCE is PHONY, if_changed ignores it and rebuilds only when
> any-prereq or arg-check is non-empty.  Editing a non-default dts in
> OF_LIST rebuilds its .dtb (tracked correctly via fixdep), but that
> .dtb was not a prerequisite of fit-dtb.blob, so $? stayed empty; the
> mkimage command line was unchanged too, so arg-check was empty as
> well.  if_changed therefore skipped mkimage and fit-dtb.blob kept the
> stale dtbs.  u-boot.bin, which appends fit-dtb.blob, then shipped the
> old device tree and the dts change did not take effect.
>
> A previous attempt to fix this added every OF_LIST .dtb *output* as a
> [...]
>
> Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> Signed-off-by: lianghong617 <liulhong617@163.com>

Please can you use your real name in the Signed-off-by tag? Also we
don't normally use bullet points in a commit message.

>         edit still needs two make invocations to take effect under
>         parallel make (the bdm uboot flow runs make -j33).

The 'bdm uboot' flow and the out/.../build/uboot path are specific to
your downstream build system. Please can you generalise these to plain
'make -j' and a normal out-of-tree build directory?

> diff --git a/Makefile b/Makefile
> @@ -1476,7 +1476,7 @@ fit-dtb.blob.gz: fit-dtb.blob
> -fit-dtb.blob: dts/dt.dtb FORCE
> +fit-dtb.blob: dts/dt.dtb $(patsubst %,arch/$(ARCH)/dts/%.dts,$(subst ",,$(CONFIG_OF_LIST))) FORCE

This hardcodes arch/$(ARCH)/dts, but with CONFIG_OF_UPSTREAM the
sources live under dts/upstream/src/<arch>. For example,
rcar3_salvator-x has OF_LIST="renesas/r8a77951-salvator-x ..." with
sources in dts/upstream/src/arm64/renesas, so this prerequisite points
at arch/arm/dts/renesas/r8a77951-salvator-x.dts, which does not exist
in either objtree or srctree. Make then fails with 'No rule to make
target', breaking every OF_UPSTREAM board that uses MULTI_DTB_FIT.

Please can you use $(dt_dir) instead, as MKIMAGEFLAGS_fit-dtb.blob
already does just below? It handles both cases and VPATH finds the
sources in srctree. A helper variable would also keep the line under
80 columns as well as improving readability, e.g.

    of_list_srcs := $(patsubst %,$(dt_dir)/%.dts,$(subst ",,$(CONFIG_OF_LIST)))

> diff --git a/Makefile b/Makefile
> @@ -1476,7 +1476,7 @@ fit-dtb.blob.gz: fit-dtb.blob
> +fit-dtb.blob: dts/dt.dtb $(patsubst %,arch/$(ARCH)/dts/%.dts,$(subst ",,$(CONFIG_OF_LIST))) FORCE

Just to check, this only catches edits to the top-level .dts files. An
edit to an included .dtsi (including the *-u-boot.dtsi files) rebuilds
the .dtb but still leaves fit-dtb.blob stale, so the two-build problem
remains in that case. That seems an acceptable improvement, but please
can you mention the limitation in the commit message?

Regards,
Simon
