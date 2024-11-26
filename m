Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE7AD3B9A4
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 15:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92FFF89C8C;
	Tue, 26 Nov 2024 16:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I88ghdym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 257B088D13; Tue, 26 Nov 2024 16:38:55 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECCB989C8C
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53dde4f0f23so2923005e87.3
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732635532; x=1733240332; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o0rGRb+v+xELCVBLw83wGDae4JZLE0CJAlu3zf10lIQ=;
 b=I88ghdymi7HBjak7UfVdjZa4h8BS3A+NlJrdNUyVxGfoYCMq5l+s/ahn+n8iK5V0HY
 1+60OWhEALpkKZMHZqsTnWssst6Uq9nlJvb4VMJ+3ZCTTrgS0sk/MtK5GLX34YKzTxIW
 0DEZzTWBerObW3atcKn1o2mr002OqeWvOlxcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635532; x=1733240332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o0rGRb+v+xELCVBLw83wGDae4JZLE0CJAlu3zf10lIQ=;
 b=WZceCYk6AAjD2qHnECrkBVEsOTxreTX2+JNQP87VzL/7fNXHU0naEfacnP2OWpO4wp
 yuAn5P95dtMfR8vcGwFKwyZmqmq5HQuC+LDhaHTJNZYncCK9Hv/0Td1UaJqs7Yf4TC6+
 MKB6GZFQdV2sMwzVBzYhGSObs7xeQWYqRsOGmmlGAcbKyIWX4e2l4x1eUbgsr+x6L5u4
 uq4ujVXvDPbqAk/zrxru0xE9qMFQX9E9ReJFtfnwkreVwEeG6DMPl6UmydsdmtVTTg7J
 0jUnsrLL7nSB3rtjCSQpKTQyoTMPx1Ohbf4vHA/XPeBJFLp/Fp1eGKxHeg77QIIguLbk
 yp1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwGwLw9LuRufoDDQgqFeyPXeqJx04qOdS4zabmjh98YyPWtzCQveR0eeoLQhvSuhse9kH2sUI=@lists.denx.de
X-Gm-Message-State: AOJu0Yww1upv5mHj7K6+82MxRnQXcM0MqsodTUdBAds/sYw8LEhUgebd
 OyYlgMXoRDyAXNdMBuLJl6LbPsGprRTYqpQnnMmEmFzK/WMbAlUiCbms/nAWgE9B7XHTKRCOmse
 CBORGO9rfHgD1dSFFaf9UZV5KEaH3M/LlIWJg
X-Gm-Gg: ASbGncvs/T2JLwneeNXZjxEkFbdZH8KDJnED8SARMlcQbdhsegaVvMq9ZK+bdmw6iRP
 ZyG1hp963y1A+bgn5EwCWtcJ41KiRHsM=
X-Google-Smtp-Source: AGHT+IG9DV2lLKd3ITihjObOctEUni27GIFA61p2gUuCN/AuSRtvcMPZw85z9kaWFaTIKUjMYWhRU+6cFDwba2Huzjk=
X-Received: by 2002:a05:6512:b18:b0:53d:e537:c780 with SMTP id
 2adb3069b0e04-53de537c929mr4686399e87.35.1732635531906; Tue, 26 Nov 2024
 07:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20241124183832.2476928-1-caleb.connolly@linaro.org>
 <CAFLszThqtA_WBxOU-EnEvw956ZMN9KErx_C4gTzW_+p_tGu9qw@mail.gmail.com>
 <cd43db10-4939-4958-97f2-9a2046d82160@linaro.org>
In-Reply-To: <cd43db10-4939-4958-97f2-9a2046d82160@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Nov 2024 08:38:37 -0700
Message-ID: <CAFLszTgEhfbk4ug=JoU_jTgdzSkF-fXuqamGmPJHpdogwocbRA@mail.gmail.com>
Subject: Re: [PATCH] common/board_f: init malloc earlier
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
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

Hi Caleb,

On Tue, 26 Nov 2024 at 05:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> On 26/11/2024 01:32, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Sun, 24 Nov 2024 at 11:38, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Currently the early malloc initialisation is done partially in
> >> board_init_f_init_reserve() (on arm64 at least), which configures
> >> gd->malloc_base. But it isn't actually usable until initf_malloc() is
> >> called which doesn't happen until after fdtdec_setup().
> >>
> >> This causes problems in a few scenarios:
> >>
> >> 1. when using MULTI_DTB_FIT as this needs a working malloc (especially
> >>    for compressed FIT).
> >
> > Hmmm, how does this work today?
>
> I honestly have no idea, I assume boards that make use of it do some
> custom board_f.

OK.

> >
> >> 2. Some platforms may need to allocate memory as part of memory map
> >>    initialisation (e.g. Qualcomm will need this to parse the memory map
> >>    from SMEM).
> >
> > That really needs to be tidied up. When does this fixup need to be
> > done? I imagine it is somewhere prior to setup_dest_addr() ? Perhaps
>
> It's necessary in order to figure out gd->ram_base/ram_size. We do it in
> board_fdt_blob_setup() so that we can support another use-case where
> U-Boot has an internal FDT (which it should use) but the memory layout
> is provided via an external FDT which is unavailable (although this
> usecase isn't enabled upstream yet).
>
> > we could introduce an event to do 'memory map' stuff?
>
> We could, but considering that on most platforms the pre-relocation
> malloc is fixed at build time and at a known location relative to U-Boot
> there is no reason for us to arbitrary decide that some codepaths at the
> start of board_f aren't allowed to use malloc().
>
> Just moving the malloc initialization earlier ensures malloc() is
> consistently available and greatly simplifies things.

I'd like to see a more generic solution to this problem...I think we
discussed this before?

To my eye it looks like if we called an event in setup_dest_addr() we
could allow ram_base to be set.

>
> fwiw, I had another variation of this patch which dropped initf_malloc()
> entirely and just set up gd->malloc_limit/malloc_ptr in
> board_init_f_init_reserve() since that's where we set malloc_base
> anyways. But after digging some more there seem to be quite a few other
> entrypoints into U-Boot that don't go through
> board_init_f_init_reserve() (e.g. sandbox, EFI app) and it seemed more
> error prone to duplicate the implementation there.

Fair enough.

One more thing I notice in your board_fdt_blob_setup() implementation
in arch/arm/mach-snapdragon/board.c :

It seems to be using either an built-in or external devicetree. It
seems that we should show this in dm_announce(), i.e. with the call to
fdtdec_get_srcname() ?

Regards,
Simon


>
> Kind regards
>
> >
> > Regards,
> > Simon
> >
> >
> >>
> >> Move the initf_malloc() call earlier so that malloc is available during
> >> fdtdec_setup().
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>  common/board_f.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/common/board_f.c b/common/board_f.c
> >> index 98dc2591e1d0..bddfa6b992b9 100644
> >> --- a/common/board_f.c
> >> +++ b/common/board_f.c
> >> @@ -867,15 +867,15 @@ static int initf_upl(void)
> >>  }
> >>
> >>  static const init_fnc_t init_sequence_f[] = {
> >>         setup_mon_len,
> >> +       initf_malloc,
> >>  #ifdef CONFIG_OF_CONTROL
> >>         fdtdec_setup,
> >>  #endif
> >>  #ifdef CONFIG_TRACE_EARLY
> >>         trace_early_init,
> >>  #endif
> >> -       initf_malloc,
> >>         initf_upl,
> >>         log_init,
> >>         initf_bootstage,        /* uses its own timer, so does not need DM */
> >>         event_init,
> >> --
> >> 2.47.0
> >>
>
> --
> // Caleb (they/them)
>
