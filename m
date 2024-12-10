Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F173E77180
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 16:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D57480241;
	Tue, 10 Dec 2024 17:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qsw9oIrj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AA8180245; Tue, 10 Dec 2024 17:16:50 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C14F78023C
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 17:16:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434f74e59c7so28011135e9.3
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 08:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733847407; x=1734452207; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cdMGBhrhNk3lEMrB1SEHMk/f+eEBVvvT1gC4K8fu3ig=;
 b=Qsw9oIrjKb/I6wpq7zaXMqfMYIvaxfdzu3ccEFUGcQ2fziLXFCMlxaLT6JibxKd36+
 QJrzdEPMZMChW3Cqkvk67Yj8msVpmLDCwDk5OS0Pa1B+b1BnRNVoU8B4HFwH+w7mHfdy
 TU8yGUf2TfIsW+RuR8EINyVvhk9UY/mDFjbGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847407; x=1734452207;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cdMGBhrhNk3lEMrB1SEHMk/f+eEBVvvT1gC4K8fu3ig=;
 b=IszIHQPax0s2Q4XP19GJziRfsgc5QihLxVEzvfSvU5QItSsXKr74sMc0SJqfEtd86V
 sIin8iHU/dcu8GyYD/53NwkrIJA1CDaGp8OSVkXrpHQ6H+Knnf6KSiOyeJbh97LPRQRd
 aHsIkZaT5TAMx42oLqid530wy1yztt3tkaHemn1xF/bIH+lvu9oPRffTvAgsm0Tk5/Tb
 7YUcSJa0QF1UekT4q5AoDLNjWRI2MBctJom4pewIrHf8YXDMHycv8cR5GEDfv3RU5LOE
 e7SUTYBNMckipewf4kh2NlXQtzOyy0r4xnYgJrT/8nrIeCkTX5oP1YqhHMozQoDIeRYB
 +/pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3vdk0L6p48zBauvAApKNnA/BsWILGYrTPE3yDQ169nmbpL6Z/JeU0a0s4tpKpjWW6eofC6R4=@lists.denx.de
X-Gm-Message-State: AOJu0YxrinNOSfp7Wh5poQmHdclsvDk4gNzA906I6CfiyLNRqEdRIoYJ
 m7caUpmx9C7ek5bOZczV4rlLgdz4mgT5+Qm18n/rziWix/YgaEhOXTBLI7yv1T5PICdOqXRqA8X
 uefrTXeWJu4vOeCGweh3YfNf/WBDCyNVXQs5g
X-Gm-Gg: ASbGnctMfNExTOULywPcRABThReGGJLGCnrVmGyg+lTbahecVXFWwTBCOiC9h9LWRVc
 Srscu8D/1AXuEac9aHk6/V4ilXy9ItLJJWGxw
X-Google-Smtp-Source: AGHT+IGzGVQhoCOL9aqSkRAntBxgvt9fRkr8TJ0wovls84V3xzxI2jltVKPj/7FLhDPX5dovipvLngZZYaS6N7a1Znc=
X-Received: by 2002:a05:6000:1869:b0:386:3213:5ba1 with SMTP id
 ffacd0b85a97d-386453e10ffmr5504741f8f.24.1733847407145; Tue, 10 Dec 2024
 08:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
 <20241208105223.2821049-2-ilias.apalodimas@linaro.org>
 <CADg8p97-pEi7OTWwGQiDiTOvPaF+sq96UaK0bRhgU=YyQzTvRg@mail.gmail.com>
In-Reply-To: <CADg8p97-pEi7OTWwGQiDiTOvPaF+sq96UaK0bRhgU=YyQzTvRg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Dec 2024 09:16:35 -0700
Message-ID: <CAFLszTgu-sUN=cGkUEtqfw08J8dqTLLyXw4tVE2NG2qNi3U+QA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] lmb: Replace lmb_reserve() with
 lmb_reserve_flags()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de,
 trini@konsulko.com, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Baruch Siach <baruch@tkos.co.il>, 
 Nam Cao <namcao@linutronix.de>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Tue, 10 Dec 2024 at 02:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Sun, 8 Dec 2024 at 16:22, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > lmb_reserve() is just calling lmb_reserve_flags() with LMB_NONE.
> > There's not much we gain from this abstraction, so let's remove the
> > former and make the code a bit easier to follow.
> >
> > The code size increase is minimal - e.g for sandbox which includes all
> > of the LMB tests
> >
> > add/remove: 0/1 grow/shrink: 12/0 up/down: 46/-4 (42)
> > Function                                     old     new   delta
> > lib_test_lmb_overlapping_reserve            1018    1030     +12
> > version_string                                70      76      +6
> > test_get_unreserved_size                    1032    1038      +6
> > test_alloc_addr                             2933    2939      +6
> > test_multi_alloc.constprop                  3034    3036      +2
> > test_bigblock                                911     913      +2
> > load_serial                                  946     948      +2
> > lib_test_lmb_flags                          2101    2103      +2
> > do_bootz                                     526     528      +2
> > do_bootm_linux                              2067    2069      +2
> > bootm_run_states                            5275    5277      +2
> > boot_relocate_fdt                            599     601      +2
> > lmb_reserve                                    4       -      -4
> > Total: Before=2492742, After=2492784, chg +0.00%
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
>
> Fwiw, I had attempted this earlier on similar lines -- have a single
> API, which would take the flag as a parameter [1], but was asked not
> to take this approach as part of the review [2].
>

You missed that sandbox has LTO enabled. With that disabled (like many boards):

   sandbox: (for 1/1 boards) all -32.0 text -32.0

We just had a patch and discussion to remove a single function call to
save 8 bytes[3]

For firefly-rk3399 this adds 36 bytes:

   aarch64: (for 1/1 boards) all +68.0 bss +48.0 text +20.0

You could run buildman on all arm64 boards to check it, perhaps.

The other thing is that there is actually only one place apart from
tests where the flag is needed - in boot_fdt_add_mem_rsv_regions().
Boards don't use that flag. It is the flags themselves which are
confusing.

Regards,
Simon

> -sughosh
>
> [1] - https://lists.denx.de/pipermail/u-boot/2024-July/559790.html
> [2] - https://lists.denx.de/pipermail/u-boot/2024-August/561607.html
>
> >  arch/powerpc/cpu/mpc85xx/mp.c |  2 +-
> >  arch/powerpc/lib/misc.c       |  2 +-
> >  boot/bootm.c                  |  3 ++-
> >  boot/image-board.c            |  2 +-
> >  boot/image-fdt.c              |  5 +++--
> >  cmd/booti.c                   |  2 +-
> >  cmd/bootz.c                   |  2 +-
> >  cmd/load.c                    |  2 +-
> >  include/lmb.h                 |  1 -
> >  lib/lmb.c                     |  5 -----
> >  test/lib/lmb.c                | 30 +++++++++++++++---------------
> >  11 files changed, 26 insertions(+), 30 deletions(-)
> >

[3] https://patchwork.ozlabs.org/project/uboot/patch/f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com/
