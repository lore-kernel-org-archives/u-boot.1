Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C971D132BF
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFDA788936;
	Mon,  4 Nov 2024 14:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WKId3XEJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 688D088CA0; Mon,  4 Nov 2024 14:07:38 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 677DF88B58
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9a628b68a7so669075966b.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730725655; x=1731330455; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6mL4BSC4KG/bf8bleKXY461p2QDfnD18F9ThU4ByZyk=;
 b=WKId3XEJM/y7HvbnDdniWU38N6UoqYG3NVr9e153mvMVJCYWpn4oS3lCUKQE4ZRcpo
 TpKrrJ/YpWkJWTYa94YBbgJUOXcMTg4Nipn/JLol1vXSmfXmR5AhK5Cai6cknmumVVEO
 TsGiVgG3+/r+WwqCeuXwBEimcusdg2MoHarkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730725655; x=1731330455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6mL4BSC4KG/bf8bleKXY461p2QDfnD18F9ThU4ByZyk=;
 b=qoptrFnc6ynjmihv2MBmGkyXJGoJmPduhRRhlumhItbsigyHjTGB53PSvxCRsjCJq9
 HT0J6vFsWMSzpHZePqpEtHBIqwg2VHwOoWgdQ+E7LNIwCBCuoDK7xxx21QScYxVZvmnh
 etWeJtwda2pcUFU0R6tG07BaVO2iAQLMKQwaiXrjfYpOoC7aXVuBR1iz0QC9eDVL2L1O
 bAZk0xWX8zY8CBIoNONk6/yldxMTrBH4Pi0EEY7+gXcz9Zlksnr9D1qdeK4uKQU8Co65
 8hElKU5LOjlgrHcKfAL450TL8fHAiTJ1IUgT7FHt0IMjGUwdtMOJ4UivpbGKivkylczD
 +Wng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS9lg/S73IiE4slORfk7XhT5bIJHfD63uITxZIXsGDTLRpPp6RL75YnhaetcLTNp+zrmQU+H4=@lists.denx.de
X-Gm-Message-State: AOJu0YzGbKaRkK9ImlAtATtm4Wv8hSaAlYlbk40UEnNv/67zYrQuNUhW
 jWmfoMQTvStEuayj7Ex0kpG3jEJLW3060VdZmdgKVxBtrhx/Pm0IKYTCS6uw84YXAXjXAgR51SE
 axKJF7rwXUpVq0bNO7e7NWBcQ1eoFN+mN6UET+sSLlLQ/xMRuWA==
X-Google-Smtp-Source: AGHT+IGsrVXkp/y8mo3Ues6SM1j/Aptrtmcl5H72DOOCycjgmPFliU3v/26UwCuGt4Fj/Jbu48+apIe5SAB/BIN6aHs=
X-Received: by 2002:a17:907:724e:b0:a9a:11f5:8cd9 with SMTP id
 a640c23a62f3a-a9e657fd8d3mr1162697366b.56.1730725655234; Mon, 04 Nov 2024
 05:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20241103002828.624931-1-sjg@chromium.org>
 <20241103002828.624931-3-sjg@chromium.org>
 <3eff8c78-e005-4ebd-8707-6b36b89f10ee@gmx.de>
In-Reply-To: <3eff8c78-e005-4ebd-8707-6b36b89f10ee@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Nov 2024 06:07:24 -0700
Message-ID: <CAFLszTi4j8ZQAb9YJ9KQdrYic4C-WV9epNAZ5i_+h8p3SE7arg@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] board_f: Correct stack reservation
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Sun, 3 Nov 2024 at 10:23, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/3/24 01:28, Simon Glass wrote:
> > The reserve_stack_aligned() function already ensures that the resulting
> > address is aligned to a 16-byte boundary. The comment seems to suggest
> > that 16 is passed reserve_stack_aligned() to make it aligned.
> >
> > Change the value to 0, since the stack can start at the current address,
> > if it is suitably aligned already.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   common/board_f.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/common/board_f.c b/common/board_f.c
> > index 98dc2591e1d..677e37d93c0 100644
> > --- a/common/board_f.c
> > +++ b/common/board_f.c
> > @@ -601,7 +601,7 @@ __weak int arch_reserve_stacks(void)
> >   static int reserve_stacks(void)
> >   {
> >       /* make stack pointer 16-byte aligned */
> > -     gd->start_addr_sp = reserve_stack_aligned(16);
> > +     gd->start_addr_sp = reserve_stack_aligned(0);
>
> In 1938f4a5b62f ("Introduce generic pre-relocation board_f.c") you wrote:
>
> /* setup stack pointer for exceptions */
> gd->dest_addr_sp -= 16;
> /* leave 3 words for abort-stack, plus 1 for alignment */
> gd->dest_addr_sp -= 16;
>
> Is that not relevant anymore?

Well that looks like ARM code that has moved to arch_reserve_stacks()
some time ago.

>
> Does all and every U-Boot architecture decrement the stack pointer
> before writing values to the stack?
>
> E.g. Microblaze, MIPS, RISC-V, and Super-H do not have a dedicated PUSH
> instruction.

I'm not sure about that, but they certainly need to. I see that
powerpc seems to write to values above the stack top! I don't think we
have enough people on this patch to look into powerpc, at least.

For RISC-V, does it use a full-descending stack, or empty? Looking at
relocate_code() I don't see it subtracting anything from the
stack-pointer that is passed in.

Regards,
SImon
