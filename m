Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E089BC3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D6882B53;
	Sat, 10 May 2025 13:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y3cdBBf0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35AF082B53; Sat, 10 May 2025 13:26:21 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 455A782952
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5fcaff7274bso2250364a12.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876379; x=1747481179; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yg0vaHnjnk/hdQj7cwcBaqxbUNm20mIwyib8ZVRs9wQ=;
 b=Y3cdBBf0VlKEYcWvQPjr4CQnggD2+yeq6jU4K5O9bptbATgmqoEupwdndZwDsEsdP8
 rb2QL0yHq/+vf/4qMklh8V9Z5aktd84hLyEEq7YQglFpnRR/ibdhKMZDt6dotAfHyFFX
 jV8OKOWKcsLT0PbBGZZ0w1NR7ab7AqrgJdfC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876379; x=1747481179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yg0vaHnjnk/hdQj7cwcBaqxbUNm20mIwyib8ZVRs9wQ=;
 b=Bmsdv54TwzGGCI0s24+L1ogkqeGXcpcoyLDb5xbRaEiHI25yiJ+P7WfkB2P9eBuuN/
 l3+s3qrbsq16dqfGbErfdhJQCEQOq0DvzszBJes2Y45XmOYXjbzilLHAAyG9wjzRCTSK
 nByMRhS7RvGGb6M5nMGRBQlYU8xta0iT8Lm5o4OZzf4BYRK9SKJdt2byE2nGQbQeb0E/
 ikiYp9KQWnf3wVL/isrhVxfUxnnPQrDt9nPvlc55eVRTHvQpUOFZrCbkigqC4wVH4Mlo
 dfe4w5W8W0W90OUXlFZHbBVwb+SIBYUpT7x6a5hAlC5Uj8wcikBcPPJhlRHP6X7KyoCk
 aLRQ==
X-Gm-Message-State: AOJu0YwVWSw4oWglcstGQM7PgL/YZ7invo2fS6R5UIaOSZDZNsp1WpqM
 jpZvk8sHpPwWtSbZU5egNQbGqr4F175rrw2Rw+FUt3DXurVMHwwGq3pecYWiypH5mUKsMOLmZqz
 eJk4d2jwuRkoypXV0/UjDAGgiBuTeCVJWdnDL
X-Gm-Gg: ASbGncvvUaFAf2rnUdKNMpUYAkT+t0sOPoGuwqS1Mbcp9v4AlSs7+ns9AJmwhJrED4C
 TPfY89/nmaabMCa2KLGYWvgSP/Az3FTEaFwFr9fs0aeJT6hXaZEQOuGycjHmWQ6IcN10bU8e7cB
 16/tjwleE8HoVvt0ff5zrWPmJJRMa19K20bg==
X-Google-Smtp-Source: AGHT+IFXAdminctxlUmBJoqXB4qeTTIZQRjrRWZ//8WiWmubnnlwENAEttA2BZAAy0DuCz4NhVqudt2NpPSA/TUzIKA=
X-Received: by 2002:a05:6402:4409:b0:5fb:c4be:b1e with SMTP id
 4fb4d7f45d1cf-5fca075e214mr5675245a12.11.1746876378702; Sat, 10 May 2025
 04:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250501131858.2160756-1-sjg@chromium.org>
 <20250505181421.GI5430@bill-the-cat>
 <CAFLszTgp0Y-yJVwE_ZBKKOXrqra6nRZqE-phPgQhA9Et99qcDg@mail.gmail.com>
 <20250506163229.GY5430@bill-the-cat>
In-Reply-To: <20250506163229.GY5430@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:25:57 +0200
X-Gm-Features: AX0GCFsgUysaUFBoEkuCloGKjmL5L1bRA4FLfRPRSLF9HZ1hOQbBKgdSBVDOAnA
Message-ID: <CAFLszTg0YCntmLZ6EHXkWsJDhf0cCQyCHhCNzK31j+GHfBUz3A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] booti: Remove the SYS_BOOTM_LEN limit for booti
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eddie James <eajames@linux.ibm.com>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Tom,

On Tue, 6 May 2025 at 18:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, May 06, 2025 at 03:24:21PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 5 May 2025 at 20:14, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, May 01, 2025 at 07:18:32AM -0600, Simon Glass wrote:
> > >
> > > > This series restores the original behaviour of extlinux booting linux
> > > > 'Image' files, which is to ignore CONFIG_SYS_BOOTM_LEN and instead uses
> > > > a limit of 10x the compressed size.
> > > >
> > > > It also adds RISC-V support, since it uses a similar format to ARM64.
> > > >
> > > > Future work should integrate the code in 'booti' into main 'bootm'
> > > > logic.
> > >
> > > I don't like "in the future we'll remove duplicated code".
> >
> > Small series, fixes a problem, can be made larger but then it isn't a bug-fix.
>
> Which is why yes, this should have been instead of the however-many-part
> "PXE" series, and then fixups on top, a series to address this problem.
> Then other series to address other problems.

The whole effort is addressing problems, although it depends on your
definition of 'problem'.

I'm quite happy with the approach I have taken here, incremental
improvement towards a long-term goal. It doesn't need to be constantly
rebased into out-of-tree code. People can only test what is in-tree.

>
> > > I also don't
> > > like not seeing that what we really need to do, in all cases (not just
> > > booti) handle decompression like we do for FIT images, and ask LMB to
> > > give us a space to use.
> >
> > See bootm_load_os() which does already do this.
>
> Yes, that's what I was asking you to look at. I assume you're even
> specifically pointing to commit 69544c4fd8b1 ("bootm: Support
> kernel_noload with compression") which you and I did together.

I seldom look at the commits that produced the code, but yes.

>
> > > A problem is that CONFIG_SYS_BOOTM_LEN was never
> > > intended to be the limit on *decompression* as it's the limit on what
> > > we're loading to memory from disk. That's what getting me unhappy with
> > > this part of the series.
> >
> > From what I can tell, that was introduced 11 years ago by this commit:
> >
> > 081cc197472 (HEAD) bootm: Export bootm_decomp_image()
> >
> > I suppose the idea is that BOOTM is supposed to be a limit on the
> > image being loaded, so it is compressed, then the limit needs to apply
> > to the size of the uncompressed image, to maintain parity. Otherwise
> > there would be no limit at all, since it is pretty easy to devise an
> > 100-byte image which expands to fill all available memory.
> >
> > Using 10x the uncompressed size doesn't fill me with the joys of spring, TBH.
>
> Yes, it's a matter of heuristics, and also why we have things like lmb
> to check and make sure we don't overwrite ourselves. I do not recall if
> the 10x used there, or the 4x we used for kernel_noload FIT
> decompression, was based on checking what the compression factor the
> available algorithms get on typical kernel images or not. That would be
> another improvement area, sure.

That commit you pointed to does not actually pass the lmb_alloced()'d
size to image_decomp(), so it isn't perfect.

I would much rather use the BOOTM limit everywhere, including as the
maximum uncompressed size of images. That is what it is for, as I
understand it. Users would be quite surprised if the limit were
ignored in certain circumstances.

Regards,
Simon
