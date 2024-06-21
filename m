Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C14AC2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4831E884C6;
	Fri, 21 Jun 2024 21:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e2OI8ozy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41BF08845A; Fri, 21 Jun 2024 21:38:22 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B3568846D
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-795524bb6d9so140246285a.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718998699; x=1719603499; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CwPWIBKqWfbznHyi1rEqNUVa6jjnZd9yoNuQangUw8Y=;
 b=e2OI8ozyc1WvXhgHhIxfzq5tqLsl4XJI7a5s/LOLDedTQ14RbN003aC9zryRLS90vc
 FJSgPsx8xPN6/vEeyvKAVtKEQYsnqrNoxCR64A0TXoJffHMGbE7L60UrnyXm/1V9vGuw
 lX8v10046dtY7vzRuQyxEx7HIS1RqPjzVXUlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718998699; x=1719603499;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CwPWIBKqWfbznHyi1rEqNUVa6jjnZd9yoNuQangUw8Y=;
 b=hAIgHCn2bUjdGay7VAqpVO2KMHRWwVf0ulzw5GyuFAePTAHYzUMWDq6A8YnTf2Xe6x
 xHL5w/QCiJyyXp7a83Xwe0RCN++nXgj30udch11wOyw47cwWwksstoRK2foFk2A8Okac
 QzXXdJB6ARMd/gaRFgOUq8TZOm+9yEfaWVZDkp6zRrfjcZZWMbhkJ2B724WwESkhvoTU
 nafpO9Et2Khs7plg32q6hYBe+71TcmHukIXADsFi5QqE2Hl7DRXGtK1J53kRacDd9mOl
 5jwmV3nK0vcZgClbigKvUm2e+J89hMj0z6LimldERwFpZPbugq+TfLhbhW3f6In0+5EP
 qRTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWopm3nefaBRlxUxRt1ST0Gh8TIz/MuW6MsgO6cvRpHElPdGHmLDiT5pKuu7qrjGW9qOgR2NXjtbrvy4kejc2RuxhUmsw==
X-Gm-Message-State: AOJu0YzbKCpmzawn0sQ3wJPWDdBrgF3bPXQLAgWWUllNpW4VUMlMuzCt
 4hK9KB9d4vF+kth2ZivhoMznwaVf8vXOjcDqgRoAqlR76FghebXI5K/BFiawMIa1zK1wcOUunWr
 aaYIPufiiTVcq/Oh3Fhppwm4dsV89Sppm14FV
X-Google-Smtp-Source: AGHT+IFHZF7nI2jw5Qc3E2VAqxBKP23v3R40e8V7X5kNonE1MqFLhc/FJUIliJBd9Eo7oIdByP0O9xgyINc0vTEfKHY=
X-Received: by 2002:a05:6214:846:b0:6b0:7a82:8f96 with SMTP id
 6a1803df08f44-6b501e262e9mr114546756d6.22.1718998698867; Fri, 21 Jun 2024
 12:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240617171623.GY68077@bill-the-cat>
 <CAFLszThO9Hnfv90X4yu49h7LcWCfgMztSGtQdGwrCt9UDH_cGA@mail.gmail.com>
 <20240618141524.GO68077@bill-the-cat>
 <CAFLszTj--0hi4=isy2Zmq9fBDFr5DMciFs+BZtfuvvmFO-9o9Q@mail.gmail.com>
 <20240619153207.GF68077@bill-the-cat>
 <CAFLszTiHSn4Vw7oMBOwOBC1gAHNYQ3Xc4mT54FkT-dfGSb0F0A@mail.gmail.com>
 <20240620231943.GT68077@bill-the-cat>
 <CAFLszTgA6Gc1T55v07skZQ3U=_JuM7yW9aTxmAtXsoLTbSOtdQ@mail.gmail.com>
 <20240621160514.GY68077@bill-the-cat>
 <CAFLszTi45oeCoLRQK_noh2dHXTMGGteadT83M9Ce9cC2fcR9wA@mail.gmail.com>
 <20240621191915.GZ68077@bill-the-cat>
In-Reply-To: <20240621191915.GZ68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Jun 2024 13:38:07 -0600
Message-ID: <CAFLszTjdDSVsMPTU0OU09JrD0Njxb6NXmb_KKk4gUXC_JAgv8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>
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

On Fri, 21 Jun 2024 at 13:19, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jun 21, 2024 at 11:55:42AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 21 Jun 2024 at 10:05, Tom Rini <trini@konsulko.com> wrote:
> [snip]
> > > Yes, I very much do not like guessing about 3 numbers instead of
> > > guessing about 1 number and using the standard mechanism we already
> > > have. Please use BOARD_SIZE_LIMIT as this is the standard mechanism to
> > > enforce size limits on U-Boot itself.
> >
> > If it were that easy I would have sent a patch :-)
> >
> > Here is the map for this board:
> >
> > ImagePos    Offset      Size  Name
> > 00000000  00000000  00800000  rom
> > ff800000   ff800000  00001000  intel-descriptor
> > ff801000   ff801000  001ff000  intel-me
> > ffef0000   ffef0000  000999f0  u-boot-with-ucode-ptr
> > fff899f0   fff899f0  00005554  u-boot-dtb-with-ucode
> > fff8ef50   fff8ef50  00000000  u-boot-ucode
> > fff8ef50   fff8ef50  00000571  fdtmap
> > fff90000   fff90000  00010000  intel-vga
> > fffa0000   fffa0000  0002fc94  intel-mrc
> > fffcfc94   fffcfc94  00000000  private-files
> > fffff800   fffff800  00000070  x86-start16
> > fffffff0   fffffff0  00000005  x86-reset16
> > fffffff8   fffffff8  00000008  image-header
> >
> > What limit should I set on what?
>
> Is this a trick question?
> $ printf %d\\n $(( 0xfff90000 - 0xffef0000))
> 655360
>
> Of course since we're less than that today, you can reduce it by
> whatever other magic numbers I'm not seeing but are part of your assumed
> sizes.

That limit is on u-boot-nodtb.bin. Even with a size (for that file) of
634816 it doesn't fit. I need to calculate a size based on the size of
the dtb and the microcode...which of course can change.

>
> > - the U-Boot is the thing you are wanting to limit
> > - the dtb has microcode added
> > - the ucode is empty in this case
> > - the fdtmap is variable in size
> >
> > So this all seems a bit backwards. The actual limit is that
> > (u-boot-with-ucode-ptr + u-boot-dtb-with-ucode + u-boot-ucode +
> > fdtmap) fits in the space available. Note that some boards don't have
> > intel-vga or intel-mrc.
> >
> > With the other patch I sent I can have a sensible limit for all x86 boards.

Did you miss the comments above?

>
> And you can set the same sensible limit with the existing mechanism with
> the bonus of it not making x86 different from the rest?

I understand that it is possible to set a limit for u-boot-nodtb.bin
but that is not accurate nor sufficient in the presence of blobs. The
solution belongs in Binman.

Regards,
Simon
