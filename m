Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC42DCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C660D86DCA;
	Mon, 16 Oct 2023 18:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gtgQlL14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D03EB86DDE; Mon, 16 Oct 2023 18:22:35 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD29086BF2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53d8320f0easo8066508a12.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 09:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697473352; x=1698078152; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qFPp+n3hM8QyWBaeGcrQis758YckWGK7ehncWQiUObI=;
 b=gtgQlL14QdYrTpOEHCXyXNnUC/HAW8s/SDwilBTz+UGGsd5MSGA4/qWaBNwpfb5M0D
 T/stuZ7xbwO/vJzx/3gI5rEi/Wk/6718hvGzbUPu6cEN4Zi/5783dB7XuI+WggLRTSdy
 8uugkFOV3/cf5w9ruWDwraDabLY0i29Wox9f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697473352; x=1698078152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qFPp+n3hM8QyWBaeGcrQis758YckWGK7ehncWQiUObI=;
 b=mx2wB7eo1yZtuLSdhrWRqOM/l7FBU0g8PTz4EgVX8KAt1LAZQrFmUIyOmcvmCYp6Hh
 2mCPzQlNGnRp4271Zrne5mmPku3cyLerBDMsdikL+gtKzo/4fqSmh9n2Lj60RmYzM4MH
 dtIGlGkKmL7yiU5ANUFWX5HYwBASXeCc8rLbk5URbNnlWlFpOW9eNPpuMBKOZPu/GDKB
 CLC4n9PFOSZp/2xRbNgWp1Ww0l1EJjeIrabusRDogW70geajzPWrpmdnW/NosFDNozXK
 3zDlagQ0hq6rMzzFnL11wzVAQvxvjqW8T93QRLxb7T4eVzSUS3DNhadepSbmK9Xf7Nc2
 nF3g==
X-Gm-Message-State: AOJu0YxwmYs51LlkmH08NpjdcEf19K0PvnVMw6qeJcBSyYLLq1WDPgb+
 fPoZYMXzQ64oV9Es6qsxcQJIrac2JxIbMn7oLgR2Wg==
X-Google-Smtp-Source: AGHT+IEmPP4128gOvHBXv/dkI5sjqXwM5oHpdUfMUPkAMaXk+RWO2octppKMEitr2LrE2j3ohRlgo5ImBFHY6Zi8ZQ4=
X-Received: by 2002:a17:907:eab:b0:9c2:a072:78c4 with SMTP id
 ho43-20020a1709070eab00b009c2a07278c4mr4725145ejc.25.1697473351721; Mon, 16
 Oct 2023 09:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <ZSCw7eCcnSRpgkBN@alg-gentoo>
 <CAPnjgZ1jyvKku8V5UKqVxBHC4qEy7EtHN+yBuUNQW0pxxHpwkg@mail.gmail.com>
 <ZSNWVGTjPEt2jXn5@alg-gentoo> <20231016161424.GE3119521@bill-the-cat>
In-Reply-To: <20231016161424.GE3119521@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Oct 2023 10:22:12 -0600
Message-ID: <CAPnjgZ0v1QbPJLPz89HuhWwY5fzWfCKpVqHLmvYAn-wJgAb5aA@mail.gmail.com>
Subject: Re: [PATCH v2] cmd: mbr: Allow 4 MBR partitions without need for
 extended
To: Tom Rini <trini@konsulko.com>
Cc: Alexander Gendin <agendin@matrox.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi,

On Mon, 16 Oct 2023 at 10:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 09, 2023 at 01:24:36AM +0000, Alexander Gendin wrote:
>
> > Current code allows up to 3 MBR partitions without extended one.
> > If more than 3 partitions are required, then extended partition(s)
> > must be used.
> > This commit allows up to 4 primary MBR partitions without the
> > need for extended partition.
> >
> > Add mbr test unit. In order to run the test manually, mmc6.img file
> > of size 12 MiB or greater is required in the same directory as u-boot.
> > Test also runs automatically via ./test/py/test.py tool.
> > Running mbr test is only supported in sandbox mode.
> >
> > Signed-off-by: Alex Gendin <agendin@matrox.com>
> > ---
> > Changes for v2:
> > - Cleanup coding style
> > - Adjust commit message to the changes in v2
> > - Add mmc6 device to sandbox device tree
> > - Adjust boot/bootdev.c and dm/blk.c tests to include mmc6 in tests
> > - Auto-create mmc6.img in test_ut_dm_init()
> > - Add mbr test to the list of tests run by test.py. Test can be run manually
> >   too via 'ut mbr'.
> > - Change mbr test to use mmc6.img dedicated to the test, instead of mmc1.img.
> > - Clear read buffer before reading data from test file.
> >
> >  arch/sandbox/dts/test.dts |   7 +
> >  disk/part_dos.c           |   2 +-
> >  include/test/suites.h     |   1 +
> >  test/boot/bootdev.c       |   2 +-
> >  test/cmd/Makefile         |   1 +
> >  test/cmd/mbr.c            | 471 ++++++++++++++++++++++++++++++++++++++
> >  test/cmd_ut.c             |   4 +
> >  test/dm/blk.c             |  44 ++--
>
> So, in addition to the changes to test/dm/blk.c I had gotten as far as:
> diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
> index 66c151131edb..33babdcf699c 100644
> --- a/test/boot/bootdev.c
> +++ b/test/boot/bootdev.c
> @@ -43,8 +43,10 @@ static int bootdev_test_cmd_list(struct unit_test_state *uts)
>                                    "mmc", "mmc1.bootdev");
>                 ut_assert_nextline("%3x   [ %c ]  %6s  %-8s  %s", 2, probe_ch, "OK",
>                                    "mmc", "mmc0.bootdev");
> +               ut_assert_nextline("%3x   [ %c ]  %6s  %-8s  %s", 3, probe_ch, "OK",
> +                                  "mmc", "mmc6.bootdev");
>                 ut_assert_nextlinen("---");
> -               ut_assert_nextline("(3 bootdevs)");
> +               ut_assert_nextline("(4 bootdevs)");
>                 ut_assert_console_end();
>         }
>
> @@ -225,10 +227,11 @@ static int bootdev_test_order(struct unit_test_state *uts)
>         ut_assertok(env_set("boot_targets", "mmc spi"));
>         ut_asserteq(0, bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
>         ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
> -       ut_asserteq(3, iter.num_devs);
> +       ut_asserteq(4, iter.num_devs);
>         ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
>         ut_asserteq_str("mmc1.bootdev", iter.dev_used[1]->name);
>         ut_asserteq_str("mmc0.bootdev", iter.dev_used[2]->name);
> +       ut_asserteq_str("mmc6.bootdev", iter.dev_used[3]->name);
>         bootflow_iter_uninit(&iter);
>
>         return 0;
> @@ -254,7 +257,7 @@ static int bootdev_test_order_default(struct unit_test_state *uts)
>         ut_asserteq_str("mmc1.bootdev", iter.dev_used[1]->name);
>
>         ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
> -       ut_asserteq(3, iter.num_devs);
> +       ut_asserteq(4, iter.num_devs);
>         ut_asserteq_str("mmc0.bootdev", iter.dev_used[2]->name);
>         bootflow_iter_uninit(&iter);
>
> @@ -693,6 +696,10 @@ static int bootdev_test_next_prio(struct unit_test_state *uts)
>         ut_asserteq_str("mmc0.bootdev", dev->name);
>         ut_assert_console_end();
>
> +       ut_assertok(bootdev_next_prio(&iter, &dev));
> +       ut_asserteq_str("mmc6.bootdev", dev->name);
> +       ut_assert_console_end();
> +
>         ut_assertok(bootdev_next_prio(&iter, &dev));
>         ut_asserteq_str("spi.bin@0.bootdev", dev->name);
>         ut_assert_skip_to_line("Hunting with: spi_flash");
>
> To make the bootdev test pass (and they still don't with the above)
> before deciding that it seems like there's a bigger problem here, and
> maybe Simon can help explain or figure out what to do?  Is there no way
> to drop mmc6 once we've completed the new test here?

I did start looking at this. See u-boot-dm/mbr-working

In short you set status = "disabled" for mmc6 and then manually bind
it in the test.

But it still has one failure which I was trying to get to.

Regards,
Simon
