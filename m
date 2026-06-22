Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6912ECDB46F
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 11:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5EE384866;
	Mon, 22 Jun 2026 13:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b/QRxHc+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19B6D848DC; Mon, 22 Jun 2026 13:30:12 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA3E84832
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 13:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-697bd41a4ecso707998a12.2
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 04:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782127809; cv=none;
 d=google.com; s=arc-20240605;
 b=Mx1yrd9QTRa1fKLnrOZ/htzPqp9pFVaEXXjhSVJzli2fE3dKGzWOb8/LT0Vmi+v/4E
 2aSo5Xcwh4g+aFBLuIolNIOBoccOfQL8upq3sjnNK7xWmQKHvU9WFaQkhRAkd1cT9Hjg
 KYs/ZMIngAW/ElbgtDOBIX/gxOuw0m5jyaSYBMHzfmfif5roZz5s4vAImlwOzE+7xR6t
 UYkZUOjX9rNw1iknKB/66FxmGeQR8gM5I5slENiSH3yJphrcBP70QaloCBWHz/RWbnhy
 icRf/1qVFZmvVrEQEcmXa5Y3S7V1s3uepuW4tUhxerDwcvW8q1v2AhAgdOl1YO3oHjVs
 O6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dTmgs161CsnotBLbY2OBB5++e2UU0tEw8aeyGdjp79M=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=MogirKeLEiPCoI4kJ5JibFCy9c/gO1EZs9ZsiCpVZ6wnnB43LSXhX9KC1QkMORc0hK
 rhZIIUhT+gnPXzJmIYP9bbKY14gP2ZmeVzP1FgWPtuPDGlnBm+ihw/EiA3GZwKiEQ4Kl
 J2nU+0b89879HeNLuoF54YQKYlYhsRmaRxXdp24BgYAg91Am4bckYtNzVn5CjgfjZsgQ
 aVIMdVNhqoGzyntefheenrqH7YIm0IJhhuMUAt/uYmGCii9FFC/SKnc2y75KhX8ZTaku
 mLvtDG9P0hI2U5idH9EocIN7fSt83wnDC1HE2NzLjzanKv68E0oo1uTgVDfG+QCrMQr+
 rcrA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782127809; x=1782732609; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dTmgs161CsnotBLbY2OBB5++e2UU0tEw8aeyGdjp79M=;
 b=b/QRxHc+LqmcxfbFIjteS0EZLZLbrs5/NwNEeQoSxRH97hoLJB80ycfEBBZY4iJ9TP
 0yHWxfUrglb3UvfWf+7o47mDWGT3GYpna1EpmTGJ50k7sASzDtY80umqTayHb7sRnXA9
 RmCbmwZPRAWS+qOXwYNz/nL7bgrXSLKg5Ru1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782127809; x=1782732609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dTmgs161CsnotBLbY2OBB5++e2UU0tEw8aeyGdjp79M=;
 b=dXRJuLt1TXdSsAyLfZY0BtSvEWXMgLaIka//NVWvWK1H3MsF7F1LHhSeeK8YwHq10y
 Dt9nsPfJ+cR0hpWxxMNkZ6WwZ6KIYttgzv7JG1XPW3N73Wp/EYfuKuNKZRbCxPHHiLcV
 HG/iwixOiUXCWsPLUR6kC8lipuD7d0WFlmK3faVCxaakCtdmEQybtMoLNZJQFCn/i4fw
 pmXlqcpKp4/MxUY4/cAsHcQ6QchogNjbagUZJDvlRa/3qh+qi5L+3HsIP501E47i3Lw4
 JaGC2oUVFyJXdV+m5U6YGloWW7SGVc5EqSsZGbFTGZWxmD4y9YOKsjVcU0t27WSdn39J
 3Vpw==
X-Gm-Message-State: AOJu0YzmEgNSxdwQ2trfi3usX63mJinWSwpTyXdBVOV6+93KC6dVDny3
 g+cONSjRMJl18YJmNoFb+knsApuKuifnOVfV8AInejpbiJDuh950b7KE8VDyFR4XkxuoWUA8vDw
 mimlFsaKQ5LwqbK7V7wpq3wxVyCSmvw83Yjp4P+QVeZbVf3mQH6jmGg==
X-Gm-Gg: AfdE7cksjGTpfEqNH5a8RH9JtQhusYf4JZ2Dw8YWJMHhDy2lqTL0/Y4vY4kcCsdCsP0
 /PEUe+GUI5IZ5hlb1o8JrJA/k3F1fM5DZtC76/r5fFDfSiNJmEOWEouozk4gqQqArVQG/QXYYdB
 ZNTzs01K13GxS1JXOHOJtkFu4kpuXcqzKgV2slvHeaSZp5mdLbKlajs1WsBoJxkV5RpKQSg1Tps
 5zNWDS9JsAejZOMTPIUKpGdy6mQLiAHZ+5/18xcusLZIeUQiMxp1BBwqxzecNny/Qjzj0o=
X-Received: by 2002:a05:6402:5289:b0:691:b5aa:5a7a with SMTP id
 4fb4d7f45d1cf-696e5106083mr6210344a12.21.1782127808905; Mon, 22 Jun 2026
 04:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260621051445.1763952-1-dmukhin@ford.com>
 <20260621051445.1763952-4-dmukhin@ford.com>
In-Reply-To: <20260621051445.1763952-4-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 22 Jun 2026 13:29:52 +0200
X-Gm-Features: AVVi8CfLCpnvSSqiCT87ES3j2iJCzgKY9UGsdkfJ5qDfc1sLuU5rSL-XsOfk7e8
Message-ID: <CAFLszTgU3X2GUTny3oG3+HxAuuKrGu9di7-oGBM3xaP8ZRVA6w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] test: bootdev: scan with a broken high-priority
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

On 2026-06-21T05:14:42, None <dmukhin@ford.com> wrote:
> test: bootdev: scan with a broken high-priority device
>
> Add bootdev_hunt_fallthrough() test to verify that 'bootflow scan -l'
> falls back to a lower-priority bootdev when a higher-priority hunter
> fails.
>
> Introduce a simple 'sandbox-bootdev' device for the test. The new
> bootdev can be configured to produce an error at the hunting stage.
>
> Adjust boot{dev,flow} tests which depend on bootdev hunters.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/block/Makefile          |  2 +-
>  drivers/block/host-uclass.c     | 17 +++++++++++
>  drivers/block/sandbox-bootdev.c | 62 +++++++++++++++++++++++++++++++++++++++++
>  include/sandbox_host.h          | 18 ++++++++++++
>  test/boot/bootdev.c             | 25 +++++++++--------
>  test/boot/bootflow.c            | 51 +++++++++++++++++++++++++++++++++
>  test/boot/bootstd_common.h      |  2 +-
>  7 files changed, 164 insertions(+), 13 deletions(-)

Thanks for digging into this....sorry quite a bit of minor feedback.

> diff --git a/drivers/block/host-uclass.c b/drivers/block/host-uclass.c
> @@ -150,6 +150,23 @@ struct udevice *host_find_by_label(const char *label)
> +int host_set_flags_by_label(const char *label, unsigned int flags)
> +{
> +     struct udevice *dev;
> +     struct uclass *uc;
> +
> +     uclass_id_foreach_dev(UCLASS_HOST, dev, uc) {
> +             struct host_sb_plat *plat = dev_get_plat(dev);
> +
> +             if (plat->label && !strcmp(label, plat->label)) {
> +                     plat->flags = flags;
> +                     return 0;
> +             }
> +     }
> +
> +     return -ENODEV;
> +}

Please reuse host_find_by_label() rather than duplicating the loop:

   dev = host_find_by_label(label);
   if (!dev)
           return -ENODEV;
   plat = dev_get_plat(dev);
   plat->flags = flags;

   return 0;

> diff --git a/drivers/block/sandbox-bootdev.c b/drivers/block/sandbox-bootdev.c
> @@ -0,0 +1,62 @@
> +static int sandbox_bootdev_hunt(struct bootdev_hunter *info, bool show)
> +{
> +     struct udevice *dev;
> +     struct uclass *uc;
> +     int ret;
> +
> +     uclass_id_foreach_dev(UCLASS_HOST, dev, uc) {
> +             struct host_sb_plat *plat = dev_get_plat(dev);
> +
> +             log_debug("hunting %s\n", plat->label);
> +
> +             if (plat->flags & BLK_HOST_BROKEN) {
> +                     ret = -ETIME;
> +                     log_err("cannot hunt sandbox device '%s': %d\n",
> +                            plat->label, ret);
> +                     return ret;
> +             }
> +     }
> +
> +     return 0;
> +}

This hunter never binds a bootdev - it only exists to fail. Please add
a comment at the top of the file making that clear, so nobody copies
it as an example of a real hunter.

I'd also prefer to drop the log_err() - a hunter failing is a legitimate
outcome that patch 2 makes the scan loop tolerate, and the
caller is the right place to decide whether that warrants
user-visible noise. At least for here, log_debug() is sufficient.

> diff --git a/drivers/block/sandbox-bootdev.c b/drivers/block/sandbox-bootdev.c
> @@ -0,0 +1,62 @@
> +struct bootdev_ops sandbox_bootdev_ops = {
> +};

Please make this static const - it is only referenced from the
U_BOOT_DRIVER() in this file.

> diff --git a/include/sandbox_host.h b/include/sandbox_host.h
> @@ -8,17 +8,26 @@
> +/**
> + * Device flags.
> + */
> +enum {
> +     BLK_HOST_BROKEN                 = BIT(0), /* Simulate broken device */
> +};

The BLK_ prefix reads as a block-layer flag, but this lives on
host_sb_plat and is consumed by the sandbox bootdev hunter. Please
rename to HOST_FLAG_BROKEN or similar and give the enum a tag so
it can be used as a type. Also, kerneldoc on an unnamed enum does
not generate useful output - either name it or drop the /** */.

> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> @@ -1532,3 +1534,52 @@ static int bootstd_images(struct unit_test_state *uts)
> +     /* Reset bootstd state */
> +     ut_assertok(bootstd_get_priv(&std));
> +     old_order = std->bootdev_order;
> +     std->bootdev_order = NULL;
> +     std->hunters_used = 0;

Please use bootstd_test_drop_bootdev_order(uts) rather than
open-coding this. As written, any ut_assertok() failure before the
'Clean up' block leaks the modified bootdev_order into subsequent
tests.

> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> @@ -1532,3 +1534,52 @@ static int bootstd_images(struct unit_test_state *uts)
> +     ut_assertok(run_command("bootflow scan -l", 0));
> +
> +     /* USB was hunted despite the sandbox hunter failure */
> +     ut_assert_skip_to_line("Bus usb@1: 5 USB Device(s) found");

Good test of the symptom, but please also assert that the sandbox
hunter's failure was reached - e.g. check std->hunters_used has the
sandbox hunter bit set, or ut_assert_skip_to_line() on its error
output before the USB line. Otherwise a regression that simply
skips priority 4 entirely would still pass.

> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> @@ -1532,3 +1534,52 @@ static int bootstd_images(struct unit_test_state *uts)
> +BOOTSTD_TEST(bootdev_hunt_fallthrough,
> +             UTF_DM | UTF_SCAN_FDT | UTF_SF_BOOTDEV | UTF_CONSOLE);
> +#endif /* CONFIG_SANDBOX */

Continuation should use a tab, not spaces. Also, test/boot/ is
already only built for sandbox in practice, so please drop the
#ifdef CONFIG_SANDBOX guard (or gate it the same way other
sandbox-only bits in this file are gated).

> commit 86288522b3f41eb776f9b0c7dc2d342a2ba078d9
>     Adjust boot{dev,flow} tests which depend on bootdev hunters.

Please mention in the commit message that this also adds a new
host_set_flags_by_label() API and a flags field to host_sb_plat -
that is not merely  an 'adjustment' to existing tests.

Regards,
Simon
