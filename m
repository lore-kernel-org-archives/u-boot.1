Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DD7FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE98B84679;
	Tue, 28 Apr 2026 20:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A2y6fiAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABC8284688; Tue, 28 Apr 2026 20:14:17 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0954684664
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-672645dbfeaso13215162a12.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777400054; cv=none;
 d=google.com; s=arc-20240605;
 b=UsORa/Z7HDfN9hgB9FPLc1oj8tb5oG74lhqdRfVf/htRcZEEUdrINVdgX741RsCdkD
 wyLUHRjDMdAjGCc6Ov+A3r91eyFW+FVmOVBFXKC257Bu5Pom8DD0n8/6WAR5nL+4Pfmm
 C+dP3NKeS6+cBXuNUY/zFOAFushZoMeAehd5edQ7GXpZsJr7GS/cwgSQ8fQPj/8gkZJx
 PKbupEhW+NA6Tju3TUUkz/eD8rgHM+cakh8sa3qZj2hSnF1/QJJoSnC2LNsybxYv7XoP
 2bn2ynDrvs/fHvjOx7dfSq42q2Hvdwhsg0AIs52IMWkns8VCBdsruA4K4TPFCgOkXYSf
 h1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IjuMrMk+Es2D4rI3g/XLy2C9tkt7bvV7qr0d+3jzFkE=;
 fh=GYIekQEhESPWanXHuipF/cx0w9AeOdHDaa7vPtUoRvA=;
 b=NkaUz8yQxnl58dn0trX2E+5wjMHt2wopz209rqqsSc1kvalNaftJ9pzSk/usGwIljw
 6AWQizHpwNbuGId6YJ8zY2QfM30yWNNaZoomBQp+1z96g8btwFuT3cNcI7W63gxB+WfK
 qCeMAvx9Ubg5cFu75JsH/3RJtLui1XIMPdW54DVswruxnkWhFkKgVghQfMsH4IGZwc4Q
 UkislvG72R/VklGtfCPqIlpRBG2YSgkkecz9KTLZHi4BMNK/XfZexSGX0pGzX74P7Edj
 UPiYNY7MD2ClnUwq0GNoBeQrqQKZK7oZbZjuXJfpw70WgXx94qi4UtHtK3QI0FeQLEpg
 q4lg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777400054; x=1778004854; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IjuMrMk+Es2D4rI3g/XLy2C9tkt7bvV7qr0d+3jzFkE=;
 b=A2y6fiAPvocGohEtOs5syXu0JZwH6xhEe1RCm29FtaHTGZNWTF2KgTpxZRs1CVOuIr
 iKmPUvxskm7i0MhuwpLju6eFrTrUJ/8ep3TtnIRuYCOOmbQCcCKLRCJalc/p8JFq0gi+
 1bz0T8Qxs2+4BM2G6y0E7vkQM2O8UrlFd+sCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400054; x=1778004854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjuMrMk+Es2D4rI3g/XLy2C9tkt7bvV7qr0d+3jzFkE=;
 b=nzVz17mPAW/0mNLCQ9236XvpRw+usVFw0q5TeGmuNsr6nvIZkyeViSxV5fXjz0C0TQ
 yscpHLJBZZ3UB4RRo7Bs8kCNKWpRG9ahAl03k7d+KguMmtBaGugv6JH+MvBKyd3XDlMo
 IizHVaMEy40k8TjTiY5rVGjy5gOjJ2DiZPP9kAz07uggz3B8uN4DxsEk+r55D1i/nVm4
 oxJuhigOg06bP0EfFWTodstVDlvc1FWeTKnKhVQa43huF5bRbiRqanVQfpqaNp15wtY+
 mFOxrVwsGr9HgWqiLTjxjykk/rVXQk3KdI7MPeR7E6qk51X6ekYqPn3dgbCxjJZc9nve
 5C0A==
X-Gm-Message-State: AOJu0YwYHhETenHLZ2ESvefyqUmDy3pkdLDB1Q0q2mH+HoaJfcxntHMs
 ne9ChspGdPnVsFUnwVTzkZ6HVbLFqlR8nVtlarpj4uddc4LSrtOLNNKxJ5tQUGsueLaYh8oymFE
 YzHSnEE/Gx4XEvbjCHsU5SLqwGIXd9XkdRcn5RR7+
X-Gm-Gg: AeBDievua8nDhOrD5dk9XOO3Q1bSMzLwRgfRWgYMD7hzAPMoTrrwBwCtmUY3fZD+YnK
 97I14V2i2Yo6k2mvgX/x0AshLgLIiLInLfVZd7gX8uzqjSzJZj/ENjnoHCxBuJcfORnMFomUSEE
 24nEApoEIjSeXYAk8XuDyUb/CwiLdfiMLmQnRPHZz1cievgvmDb+eqUWxdawpjVJdUfCN2p4Bws
 08lt0NVBRrCnD2DgUZA0BzrDeWl1Au/bbZhBrm9IQNjd8zJSaw1vs7Co75On7EYLqTIBH5xAk7T
 wjU0aCNEaLv/5Lqk
X-Received: by 2002:a17:907:c285:b0:ba4:a871:27de with SMTP id
 a640c23a62f3a-bb93c79d643mr32380366b.3.1777400054419; Tue, 28 Apr 2026
 11:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-12-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-12-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:14:01 -0600
X-Gm-Features: AVHnY4KudFVQfQyp4lV67OcdTU4mszn2qihVSYz6e8GBGKuvfReMl3ZMkPnaFmc
Message-ID: <CAFLszThZM7CRO3shhMOMYTipehB7HS4GjfK0SadZCSzhdbLz5g@mail.gmail.com>
Subject: Re: [PATCH 11/12] doc: bootefi: note two-phase runtime variables
 selftest
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Simon Glass <sjg@chromium.org>
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

Hi Harsimran,

On 2026-04-24T17:31:50, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> doc: bootefi: note two-phase runtime variables selftest
>
> Explain how the runtime variable selftest runs in two phases
>
> Document that the "variables at runtime" selftest runs in two
> phases when CONFIG_EFI_RT_VOLATILE_STORE is not enabled, and
> show how to select it with efi_selftest.
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> doc/usage/cmd/bootefi.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

> diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
> @@ -167,6 +177,8 @@ To use the *bootefi* command you must specify CONFIG_CMD_BOOTEFI=y.
>  The *bootefi bootmgr* sub-command requries CMD_BOOTEFI_BOOTMGR=y.
>  The *bootefi hello* sub-command requries CMD_BOOTEFI_HELLO=y.
>  The *bootefi selftest* sub-command depends on CMD_BOOTEFI_SELFTEST=y.
> +The *variables at runtime* selftest runs in two phases when
> +CONFIG\_EFI\_RT\_VOLATILE\_STORE is not enabled.

Please drop this addition. It duplicates what you wrote a few lines
above and the Configuration section is for build-time CONFIG_ options,
not runtime test behaviour. Also the backslash-escaped underscores are
not needed in rST and produce inconsistent rendering compared to the
plain CONFIG_EFI_RT_VOLATILE_STORE used in the paragraph above.

> diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
> @@ -160,6 +160,16 @@ environment variable to match one of the listed identifiers
>  Some of the tests execute the ExitBootServices() UEFI boot service and will not
>  return to the command line but require a board reset.
>
> +The test *variables at runtime* runs in two phases when
> +CONFIG_EFI_RT_VOLATILE_STORE is not enabled. Run it once to create a
> +runtime-accessible variable in non-volatile storage, reboot, then run it
> +again to validate, append, and delete that variable.

It would help to also say what happens when
CONFIG_EFI_RT_VOLATILE_STORE is enabled (single phase, no reboot
needed) so readers know which path applies to their build. A one-line
note is enough.

>     Explain how the runtime variable selftest runs in two phases
>
>     Document that the "variables at runtime" selftest runs in two
>     phases when CONFIG_EFI_RT_VOLATILE_STORE is not enabled, and
>     show how to select it with efi_selftest.

The first paragraph just restates the subject - please drop it and
lead with the motivation, then describe what the patch adds. Lines are
also wrapping well short of 72 columns.

Regards,
Simon
