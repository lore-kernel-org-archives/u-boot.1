Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A21D78313
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 12:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E8A88906C;
	Mon,  2 Dec 2024 13:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JE1qa9H7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07A5C8916D; Mon,  2 Dec 2024 01:12:23 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A792489137
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 01:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa53ebdf3caso713753766b.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 16:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733098340; x=1733703140; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HNLumPvGFMp+WtK7Ol6vQL9ilUWl5EmhkXrYwyDx/U4=;
 b=JE1qa9H7MrV/OdxZIADTOz/w95cIyaeSqnAz0rNFeglZIqHqmVaOeLedkx6TjNS1Z4
 kVCUpTVOfsexPoD5dWkJlS2weS0Ym64Sqm+KQKi/GbbQlbjsNWEsW1Vj1qdYp3oMwnpb
 RnR3sqBaFW2ezBB1k9sTVCf40EfCgmhqrrPLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733098340; x=1733703140;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HNLumPvGFMp+WtK7Ol6vQL9ilUWl5EmhkXrYwyDx/U4=;
 b=OCQvqoyXHeL6nc0CNNwkeavTC5A4XmBhIWUKD8dwXlsWSJEs1uw4quX9NcpFEo9x2n
 nD9izgV4/1pbKWFOY4XKIbDe1U4YZt6Tm1yxyj3TJgDnUZY4mp0+wtPUJavkKQ7wFfAT
 qbeV6AJHaCTJFBpQuYy6I7S8LtNO/jAkahEhZybBJzHmo72p+tjgf7kf9qu6LK5gUo78
 njOjZ8gAZM09vbO679z03U6NpB1L2AzKqgNWypwIjtQnSjM8T+zaia4GD7oLGVlG8K4B
 D9RExRT0CEKv9sJUyE0NGlmyvQfZ1FFFHwMabo1CUZZ/WWfPGlFSZqAKQKlS9L03lNRz
 uWig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkAjET8sToiszU+4Cg+Zz0HqlqbKZcYwBNacaGza+9s+uAaPwBGVkgdzgdcjT+9WkHZpBDyr4=@lists.denx.de
X-Gm-Message-State: AOJu0Yxfm4ANZr63L1UqbuaC4ZQFbRspjTpC1HWioARYjtKfxpBZSzWq
 /htTWPPeb4Bj7Wosfz4Q6Ly1bEW4ta5bUg4aJCPaqeJtpA3GeVU1R8mdaX12VAZFs2h7qtWxX8X
 sxfmSsl/l90iFMsnwshzk3CuUa5C9oKBuw1Di
X-Gm-Gg: ASbGncsaF1AUzKs8GSsohXx999E2+Vd+1F8cp3yRMwkOuVnKkFHneigecAln6OHpQLm
 7Agt4upvFZUBcZ/unL0luV08/sr7URiA=
X-Google-Smtp-Source: AGHT+IGsKatNTIgjJm2rR6LiB6j87lws2jEflrn7A0psjawIcPhJOw+KFudJsZwbXDRdFjFfUooh5TbBluRR8YNbL0M=
X-Received: by 2002:a17:907:7802:b0:a9e:441c:f729 with SMTP id
 a640c23a62f3a-aa580b2e09dmr2329934466b.0.1733098339955; Sun, 01 Dec 2024
 16:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20241028124815.47262-1-sjg@chromium.org>
 <CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com>
 <CAFLszTj9Dc-uF=GjSyxTue5Sw3ohUnDaAnAc5sz2dxfQ3gEuxw@mail.gmail.com>
 <CAC_iWjJkAfJHp_NDXJMfNPe7OhBp6B_WBMxvwU_qHU5tamm6ZA@mail.gmail.com>
 <CAFLszTiL88dHANMHo1bK2Uj5K1-7B56_Uk8keSQTo6FUfUoOVQ@mail.gmail.com>
 <CAC_iWjJOFv1v5VPoJ2UEu1YR84i1GUdB7tEng-uqgZ+6o_XWZw@mail.gmail.com>
 <CAFLszThCONSk2v30pGDGyGjz9mz2X0mtpqGCWSZJdbAuDaT0bw@mail.gmail.com>
 <CAC_iWj+g1nMA1DrWjguP=YiQhKOmyGKyu233Eb6Zjcv0x4yatA@mail.gmail.com>
 <20241120180633.GE3600562@bill-the-cat>
 <ED2EDEA3-44B9-48BC-9531-FE061A18F6D8@gmx.de>
 <CAFLszTgRUZsno=faHpch2bJ_7=8QOAvTOMeJgCpZtTZthp5vKA@mail.gmail.com>
In-Reply-To: <CAFLszTgRUZsno=faHpch2bJ_7=8QOAvTOMeJgCpZtTZthp5vKA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Dec 2024 17:12:08 -0700
Message-ID: <CAFLszTgE_HZEbG7B09_oo=XfugvH07ix=_0eoSGaEQ+KhyA4Qw@mail.gmail.com>
Subject: Re: [PATCH 00/15] efi_loader: Add support for logging to a buffer
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Igor Prusov <ivprusov@salutedevices.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Levi Yun <yeoreum.yun@arm.com>, Marek Vasut <marex@denx.de>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sean Anderson <seanga2@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Wei Ming Chen <jj251510319013@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 02 Dec 2024 13:35:10 +0100
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

On Wed, 20 Nov 2024 at 19:19, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Wed, 20 Nov 2024 at 13:49, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > Am 20. November 2024 19:06:33 MEZ schrieb Tom Rini <trini@konsulko.com>:
> > >On Wed, Nov 20, 2024 at 05:55:18PM +0200, Ilias Apalodimas wrote:
> > >> Hi Simon,
> > >>
> > >> On Wed, 20 Nov 2024 at 17:37, Simon Glass <sjg@chromium.org> wrote:
> > >> >
> > >> > HI Ilias,
> > >> >
> > >> > On Fri, 1 Nov 2024 at 05:32, Ilias Apalodimas
> > >> > <ilias.apalodimas@linaro.org> wrote:
> > >> > >
> > >> > > Hi Simon,
> > >> > >
> > >> > > On Thu, 31 Oct 2024 at 20:02, Simon Glass <sjg@chromium.org> wrote:
> > >> > > >
> > >> > > > Hi Ilias,
> > >> > > >
> > >> > > > On Tue, 29 Oct 2024 at 19:32, Ilias Apalodimas
> > >> > > > <ilias.apalodimas@linaro.org> wrote:
> > >> > > > >
> > >> > > > > On Tue, 29 Oct 2024 at 17:45, Simon Glass <sjg@chromium.org> wrote:
> > >> > > > > >
> > >> > > > > > Hi Ilias,
> > >> > > > > >
> > >> > > > > > On Tue, 29 Oct 2024 at 10:58, Ilias Apalodimas
> > >> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > >> > > > > > >
> > >> > > > > > > Hi Simon,
> > >> > > > > > >
> > >> > > > > > > On Mon, 28 Oct 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
> > >> > > > > > > >
> > >> > > > > > > > It is a bit of a pain to log EFI boot-services calls at present. The
> > >> > > > > > > > output goes to the console so cannot easily be inspected later. Also it
> > >> > > > > > > > would be useful to be able to store the log and review it later, perhaps
> > >> > > > > > > > after something has gone wrong.
> > >> > > > > > > >
> > >> > > > > > > > This series makes a start on implementing a log-to-buffer feature. It
> > >> > > > > > > > provides a simple 'efidebug log' command to inspect the buffer. For now,
> > >> > > > > > > > only memory allocations are logged.
> > >> > > > > > >
> > >> > > > > > > Why is this problem specific to EFI and no U-Boot in general? Do we
> > >> > > > > > > have a similar machinery for malloc()?
> > >> > > > > >
> > >> > > > > > Mostly because an app can make EFI calls and we want to know what they
> > >> > > > > > are, e.g. to debug them and figure out what might be wrong when
> > >> > > > > > something doesn't boot.
> > >> > > > >
> > >> > > > > EFI_PRINT() has been proven pretty useful for this. I don't personally
> > >> > > > > see the point of adding ~1300 lines of code to replace a print.
> > >> > > > > What would make more sense is teach EFI_PRINT to log errors in a buffer.
> > >> > > >
> > >> > > > Is that a NAK? Please be clear if you are reviewing the code or just
> > >> > > > rejecting the whole idea.
> > >> > >
> > >> > > For the idea, no. But I don't think what's implemented here is what we want.
> > >> > >
> > >> > > To track what EFI services are called, we already have EFI_ENTRY and EFI_EXIT.
> > >> > > Why don't we instead, add a logging service (and we already have
> > >> > > ftrace iirc) and plug it in the macros above?
> > >> > > That would make more sense not to mention way less code.
> > >> >
> > >> > I am wanting to programmatically log and manage what EFI_LOADER does,
> > >> > so that bootstd can present a high-level view of what is going on,
> > >> > e.g. which protocols are used, how much memory is allocated and where.
> > >> > So this is not just about logging text output.
> > >>
> > >> Why the EFI_LOADER only? Bootstd is supposed to cover more cases, so
> > >> why not a generic framework for all boot commands?
> > >
> > >This feels similar to the point I've made elsewhere in this overarching
> > >series, why not do this at existing common points in the code path?
> > >
> >
> > The common code point is the log library. Just add an event there for which the test can register a handler.
> >
> > With a log event you get:
> >
> > function name
> > source location
> > message class
> > message text
> > message priority
> >
> > and all of this with minimal invasiveness.
>
> OK guys, I think I got the message :-)
>
> I'm going to apply this to my tree for now. While I'm at it I think it
> is time to go through my backlog and apply some other things that I'd
> like in there.

One point I didn't mention is that this series allows logging of all
calls, not just the ones that come in from the app. At present there
are quite a few efi_allocate_pages() calls which are entirely
internal.

Regards,
Simon
