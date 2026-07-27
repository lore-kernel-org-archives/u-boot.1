Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AEAC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 20:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40226407E0;
	Mon, 27 Jul 2026 20:53:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WRhCQmV5OgTo; Mon, 27 Jul 2026 20:53:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E163407CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785185632;
	bh=TBpXu8sagdZdg/+zeRbWFhp2+32Vo2zOLrCcZ1WXVRg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=df+O99i28PTAKq0pFvujBawVyXC7wGDFoP+omPPsenvXmvzs4vu7kFVLUQ/2iSuq6
	 aRa29m39Bc5jrjbltD/G/4pdcp/DZFpLisU8PrztVLcmws8YtTAJZE+i999R2VZn+Q
	 GWq6WI4tdbyzZ0SwDLxvVTQ8jtORQwtwRWGEbi2OsjYBEDh1m9NGWOFIUgONS2Bvyz
	 pK1qefZwtZoR5JYrGDlYUgiRYq2W/m0s8bN71jh4AoigVJ7ePzQKUiCaLPE4b4VSF1
	 EFh+Ft9FkbGxmt1tfUfBVfm6fUzFppGzHjG0QM/oRLmb42F6be48OxVYq051xyGM8V
	 9Ic9/D5UZ1gHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E163407CE;
	Mon, 27 Jul 2026 20:53:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CFACF350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 20:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B541A80F02
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 20:53:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DrSThb2zU9iO for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 20:53:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BB2DF80DFF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB2DF80DFF
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB2DF80DFF
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 20:53:49 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69f7130b47dso5523307a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785185627; cv=none;
 d=google.com; s=arc-20260327;
 b=bURNPbwIHwaJpQBFQZ8ezWz7raKlEAHH4Nax1NNDiGlRgxDxx/qgkazdGH6V//YtQF
 YUbTQ5WTuQLca8obz8lxj/XWo/FiKCaZ55JicnWCjdf9chRepOxTBJQpJXaErvLNSN9r
 lQppTCd+nzwrbfpov47uLjRGeWiAhzvxHGmwc+7eT6RqdqgPm4JU8PSjGI/HI9fsCsHD
 o0eY11Tp1zP5jMFGSLeuZEiRqLCYTNjzhLizu9zc5PU15t7iUPkPtLTuGyqE2UKa6VyX
 UFrjJhDtHyJhqFlDwaFraJioWcowdj4TibeGrPI2AzV69dcozunafSo7YFzwJuFkhNBX
 KT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TBpXu8sagdZdg/+zeRbWFhp2+32Vo2zOLrCcZ1WXVRg=;
 fh=cVJkdTH3uUk7etDt2nPOcJz4Vg9jQiqBWdeJRB/nURs=;
 b=YK+KA0TFdCs42XR3OaFwOesCW2HkVCo3OOaVt9k/Ux0ce9xR0EyPAsoqstPvFQZWIg
 ITaFraVpInqhWjeqxEkL4rpeAkYJHv1WTz1cAJGzGNRCl9/QtP7JCvwRpESVzenwx9RZ
 RiEekLuXrSx/BMIjHksOC0VY0v6oymHdoaoM1oTo7iZWAOFejObpMJtbWHqyAApgbbM3
 aF7PLZWvO3bi8dZUK+LPYzAT5TAbJ291M4FVSfHeDof5XADaiy4i8RleC226R9bd/JM0
 YAmZSaFxMNEqV3oKJzqP5+wcnEI4pYZgkaA29cgmG3PFCTAmi6a0OQ49X3XbL5lEzybb
 UCTg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785185627; x=1785790427;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TBpXu8sagdZdg/+zeRbWFhp2+32Vo2zOLrCcZ1WXVRg=;
 b=jagKCxtB1rp+/MR1Q3n8xPdHfcyhE9bUqWy57K48hQayC7rm+menEMnxBOsCVLEX7f
 BF97vHQwhwrE9RcCAW8jfygnpbm7HXdh5GbLaKGr8B9WLnJDxOvZZ/RPlfxOXt5p/RAS
 p6F/kQpFZj0BbrSyvzQAr1GMMZqi0gnEPESw5bdQRnTnEzrhuLzxh/E5w1IpRDAsz17f
 VaAWoRQCOpC2MJmlZrFCwzqtMxWJHKfjtNM3QcDfXXS0lW5wyyzQ83cTWH+3P/NvPQ7z
 J6qv8IyCV6ZjX66z1iiF+xIY/USmVZn1FFL9CGGJoGLK7c5UXcXB1ezNA2t9JVtSWzD4
 byFg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+i0g3ZQCOPdYxaG/diYn9V6VZMTAl2XLy/OnestiICckHpKb8z9gqMyDI3Xq9MsMlAlnYx6o=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwMnwgLuHi7W8jGbSFD/MCR7BoeXpA9pf6qCGZxvalRb3Oc6vZv
 3amHvzEfLRdJh+uVSqqU0qU7V65lSbEThTi91zpV6j8mBM+Zkg17bk6oenIun0fW5JD7HnDwNuj
 hg9VWE55b9z5kYA0e6zaAWoS/CfQPNB8XjB9HUoIk
X-Gm-Gg: AR+sD12eEIg9VOm+i8/QZEfLyXqqvYw5G/0cMjBxuRDmV5NkP3sHQuBK4+o9+44VK8j
 tDb1W8KZL1OhRKaygwScUrZzbneRlFMudN6bFPIFHbw+fJKcG9IFw5fFPAvBJpu64CRpCEczHE4
 zQLpwcDGUjEkT7NVa5EjyoJFcygSRqrlVGaCL7BrHN41LrssBgf6gtM7l7wEC+Dp2c9vEbvI0dN
 B1CDUAfhqr4srVFJCAjObPsl5rCMw3Y+HWoFjF92vcbJdkpYtrrtQNcnevs
X-Received: by 2002:a05:6402:24c3:b0:698:3469:fa99 with SMTP id
 4fb4d7f45d1cf-69fc0f70ba1mr3351191a12.0.1785185627265; Mon, 27 Jul 2026
 13:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
 <CAFLszTinPhEH9nCMV8u8SwMf9UJ5AG0z68En7+-T3e3RxpB6VA@mail.gmail.com>
 <CAEev2e8Mg2WReESLq4PDhiph9t9Bv8-Gsfx-WDcU9kfgAkfyYg@mail.gmail.com>
In-Reply-To: <CAEev2e8Mg2WReESLq4PDhiph9t9Bv8-Gsfx-WDcU9kfgAkfyYg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 27 Jul 2026 14:53:34 -0600
X-Gm-Features: AUfX_myQteGPTMMeLBsydUJ-jFmNg01TqEQAlPbv3bVISI4Fh3ZIaIrLp4ebGv8
Message-ID: <CAFLszTijpaTO5WNqaLdowd6LVUNfhTYNcCDSof6bYwUjMmayPA@mail.gmail.com>
Subject: Re: [0/8] Misc Fixes for VGA BIOS Emulation
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785185627; x=1785790427;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TBpXu8sagdZdg/+zeRbWFhp2+32Vo2zOLrCcZ1WXVRg=;
 b=SPwmUI+LKb/Ujlyx6Wb8gB23TAQNGGnv3404W+C5eoWIWo76ft/JfSipHJcb3SSMiU
 jehvV1TUTAI26G1iUtilIZm9I2V1SmUAZckM7eTHDzu07/Y/KaMjVuV9AS11DhExCJre
 2XNLzmFCd66zhOXIdZFz47Agc/lhzZPYxlM8k=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=SPwmUI+L
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

Hi Anirudh,

On Wed, 22 Jul 2026 at 08:37, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
>
> Hi Simon,
>
> On Mon, Jul 20, 2026 at 1:17=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Anirudh,
> >
> > On 2026-07-19T18:03:31, Anirudh Srinivasan
> > <asrinivasan@oss.tenstorrent.com> wrote:
> >
> > > Patches 1-5 contain misc fixes to drivers/bios_emulator that are
> > > suitable for upstream. I would like to get these reviewed and merged =
in
> > > if possible.
> > >
> > > Patches 6, 7, 8 are an implementation of how I got u-boot to actually
> > > talk to to the Aspeed VGA card.
> >
> > Thanks for looking at this. Please can you split this into two
> > submissions? Patches 1-5 stand on their own; mixing them with the
> > NOT-FOR-UPSTREAM material makes it awkward to pick up what is ready.
> > Send the RFC portion as its own series marked [RFC] in the subject.
>
> Thank you for your feedback on this series. I will polish it up based
> on your feedback and send something over for the first 5 patches next
> week.
>
> >
> > On the design: I suspect the right shape is a driver-specific hook
> > rather than open-coding Aspeed knowledge inside drivers/bios_emulator.
> > The emulator should stay generic and call out to the video driver (or
> > a small ops table) to translate an I/O port access into whatever the
> > card needs - MMIO on BAR2 here, real I/O on x86. See comment on patch
> > 7.
>
> Yes, I was thinking of something like this too, but wasn't sure what
> kind of hooks/routing other VBIOSes might need. I'll see if I can try
> out an AMD card with this approach.
>
> >
> > > This series contains a bunch of mischallaneous fixes to the BIOSEMU
> > > codebase
> >
> > miscellaneous - also I noticed  'to to' and 'There some checkpatch warn=
ings'.
> >
> > For upstream this will need a doc/ entry (which board, which
> > defconfig, what to expect) and ideally test coverage. The QEMU RISC-V
> > enablement in patch 8 is a nice way to make that reproducible - please
> > consider keeping it so it can run in CI.
>
> This setup requires you to have a PCIe VGA card and run a qemu VM with
> pcie passthrough (or a board with working PCIe in upstream u-boot).
> This isn't easily testable in CI, right? The doc/ entry would also
> become super specific to the setup I am currently using.
> What do you suggest I do here? Should I just document my specific
> setup and add another defconfig with these Kconfig options? I was
> thinking that we shouldn't add bloat to the existing
> qemu-riscv64_smode_defconfig.

I was able to run the BIOS in QEMU but it was years ago...and we've
never had tests. So I'd say don't worry about it.

Regards,
Simon
