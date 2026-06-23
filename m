Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0511BCDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 14:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48775849F3;
	Tue, 23 Jun 2026 16:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CD7QH45k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35395849F0; Tue, 23 Jun 2026 16:49:51 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C27E849E5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 16:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-697edb1bf6eso55669a12.1
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 07:49:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782226189; cv=none;
 d=google.com; s=arc-20240605;
 b=jEwQhd2SeEVkoUCcnwlMXzghA3asgKduRufT7aGvoON9u8CpF9WtSTsWL5aX8Jka3j
 QrIHPd+q8U6W7xT+nRVpaUYrQH8NPRYn8ciB4ssmgMx3fhyCppLghbUWVNqIyTD4WP0D
 Vsk72cVozYJuZZk9qvhbAIN6Jfw10ZA7lXHIaPhooBkJ1J59+IVtjvTqSgXk89K1MODX
 0ZQsSQVsB37ONZs94QUlFGTSD8ogEnRMU+C7ngukPTWRcTHAMVh5fUe74UOtT2eToTX6
 yd6sJ1ncAXVDk5cT+iE6RW85F7E+Be3knBYtXSXGiDkiYdFWILVMO5HSVbmtDId7An6L
 huUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fb4ub1DQmWoF2yf27p11i3DIH7KPN8EzWBqyGoh3cr4=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=EUBCALOs4Eiv4mrIu2J8eej06m3Zaum3Vq2+V/3KBk0EkjoMr/TWJgY7zubb6my1MR
 6c+1RbwcVCi2bJiIo8PO1Apm+hL0kmG5y+cHZJunphuw/P4PIDpBwVZKRywZSAsZQ5In
 fWA8bK75jqmagYwbc1Mg58T5naAJWNCkbdr+G24p5DIF9Bsij3IWgjWWGYPWnBE3OjYa
 /x1NzfY7Y+8z985mX9P90+AFyOo23hmNR5vO4tC2wGUC6KgIzA58AwAKKrHjvYXVqT/V
 tOVy1s65eglbycU8QtEmlfDd7Hd0Ko+WzcqTfE5OpChFtjP4zoxJqQkSwCyJmp3ktAmI
 rw3g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782226189; x=1782830989; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fb4ub1DQmWoF2yf27p11i3DIH7KPN8EzWBqyGoh3cr4=;
 b=CD7QH45kKPZnp0yXCu/Ba7n3ZnMHsSnDmcAwWMz2QTF9VYar6HcR/4EaDsNgxFeG7o
 DdCSa3BDIS9hKL3mOkV49V3oRCT0sEuBZk3gqo9MxlZfB2QKmsfgR6/8GJrsr7ciiFIW
 UYXW5roHnFq9pZzQ35Dd7j9m8+Vf+cF31p6Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782226189; x=1782830989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fb4ub1DQmWoF2yf27p11i3DIH7KPN8EzWBqyGoh3cr4=;
 b=k/sTylp/dlHXO9ayb9ilKUJ4oqHdz94rZJRelGS+DIHiIkSa1Z/DYC56alxFABreAU
 cxt86paqYHHF3iucF6WkFjDzk5fg/+NiYmABwOEbBJ3vL1Y7vmX77EbemGVHihCJpHun
 XLkzlnJ3lDdcF5UE/GShBorYlsVQqSO5GVL3+9/1XztGCLqcQyPAvhEyJa35hxYsXahr
 JonvtQZxggIrvFPFqSfDZP1TftsjfQ7JpfpOUMzKpZKyyZ70YlcSWI8mLSRnuXhA72wP
 iNxoOt1p+ZgilhTbnYKy0Azpm3SihAaEEnynaWwPU/ur6Q6zbVMFCfi7T4B5vwjn2dr5
 RTWQ==
X-Gm-Message-State: AOJu0Yw81/xH8uRuiJmLtTJ0LdBalvR29gSfou+ODvmmttwTMoeI3j3A
 3X4Ep0KzPXmmT4xkszb+jcAS4B/C8xJkY3B0gbyAb6jzwilt8OQYVA3jQVtHv+5ZaWGKHDYhEyp
 EusQvYJ2WbsZHs8G77rOs974YRO4/6OysUBckrHcQ
X-Gm-Gg: AfdE7cltfEEw4uxxxy7y4M4RCWE7ksJvHUA2U1JwNJ++GUbwPeln+gsFtMNJRvuI2J0
 wkljyYt7K24m+L8Uwc++RKbTNTWh2PqnArzcSEnXA/qWsG5g12qsgI7X3lutkQE7j+T+imkgjiP
 EwNfOBnUkOQhuSbntiHxjXiepIiLZ9PKdEapJ2bGAZVTLSgs8f40SC3ymcwQTjLHOG1D7P3GBU/
 q2U29GAK4ZcI8GgA1g+ljuKhygk7ROEVw5OI57ZhWbVzJ/IF7Cznn/8UFfCOzz9caKCTne51w==
X-Received: by 2002:a05:6402:541b:b0:695:ec53:976f with SMTP id
 4fb4d7f45d1cf-697dbb0b6f2mr1513450a12.10.1782226188663; Tue, 23 Jun 2026
 07:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260623014930.2741494-1-dmukhin@ford.com>
 <20260623014930.2741494-3-dmukhin@ford.com>
In-Reply-To: <20260623014930.2741494-3-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 23 Jun 2026 15:49:36 +0100
X-Gm-Features: AVVi8CfV0pnbAfOWL9rHi407cGpQy7XJtfbKWEnWtT7zydoKl51TJGdWBDgYyMo
Message-ID: <CAFLszThk7mWg+7LrVcN9xY5owrpUwhCTLdf=XHi0K-M-uPKzXg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] test: bootdev: scan with a broken high-priority
 device
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-06-23T01:49:28, None <dmukhin@ford.com> wrote:
> test: bootdev: scan with a broken high-priority device
>
> Add bootdev_hunt_fallthrough() test to verify that 'bootflow scan -l'
> falls back to a lower-priority bootdev when a higher-priority hunter
> fails.
>
> Introduce a simple 'sandbox-bootdev' device for the test. The new
> bootdev can be configured to produce an error at the hunting stage.
>
> Introduce new host_set_flags_by_label() API and a flags field to
> 'host_sb_plat' to simulate a bootdev hunter failure for the test.
>
> Adjust boot{dev,flow} tests which depend on bootdev hunters.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/block/Makefile          |  2 +-
>  drivers/block/host-uclass.c     | 15 +++++++++
>  drivers/block/sandbox-bootdev.c | 73 +++++++++++++++++++++++++++++++++++++++++
>  include/sandbox_host.h          | 18 ++++++++++
>  test/boot/bootdev.c             | 23 ++++++-------
>  test/boot/bootflow.c            | 46 ++++++++++++++++++++++++++
>  test/boot/bootstd_common.h      |  5 ++-
>  7 files changed, 169 insertions(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

code-style nits below

> diff --git a/drivers/block/sandbox-bootdev.c b/drivers/block/sandbox-bootdev.c
> @@ -0,0 +1,73 @@
> +/**
> + * sandbox_bootdev_hunt() - Hunt host bootdev.
> + *
> + * Note, this hunter exists for bootdev testing to simulate a fail
> + * mode.  Do not use as an example of a real hunter.
> + *
> + * @info: Hunder details.
> + * @show: Enable extra printouts.
> + *
> + * Returns: 0 if OK, -ve on error (expected by the test)
> + */

Typo: Hunder -> Hunter. Also 'a fail mode' reads better as 'a failure mode'.

> diff --git a/drivers/block/sandbox-bootdev.c b/drivers/block/sandbox-bootdev.c
> @@ -0,0 +1,73 @@
> +             if (plat->flags & HOST_FLAG_BROKEN) {
> +                     ret = -ETIME;
> +                     log_debug("cannot hunt sandbox device '%s': %d\n",
> +                                     plat->label, ret);
> +                     return ret;
> +             }

Please align the continuation with the character after the open
parenthesis (tab + spaces) (patman will check this for you)

> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> @@ -1532,3 +1534,47 @@ static int bootstd_images(struct unit_test_state *uts)
> +     ut_assert(!(std->hunters_used & BIT(HOST_HUNTER)));
> +
> +     /* USB was hunted despite the sandbox hunter failure */
> +     ut_assert(std->hunters_used & BIT(USB_HUNTER));
> +     ut_assert_skip_to_line("Bus usb@1: 5 USB Device(s) found");

It might be worth asserting that 'Hunting with: host' appears before
the USB one, so we know the host hunter was attempted?

Regards,
Simon
