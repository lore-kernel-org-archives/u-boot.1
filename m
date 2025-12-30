Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C54DEE020B
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 15:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2542F83F5B;
	Tue, 30 Dec 2025 16:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wt++A2ut";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8CC983F5B; Tue, 30 Dec 2025 16:11:51 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A40BA83DA9
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 16:11:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64b7318f1b0so11917098a12.2
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 07:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767107508; x=1767712308; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+WQgG7fQTxW5tFBAiwVAR5DEAeQDHBQrYDuB+kdq/c=;
 b=Wt++A2utcugi3kbA6kfoM5oB7SmuyAdm5uqSGN0PZwzT3hXB5szxa6IJjfLzh/Emop
 Wb9GPEOgPE2gjvozERcCEHrVAjzHkGfogtu7NBpdb3LKah+af3VvkMVFXKNY9GxK9X42
 ULa5l30BpMYQUQNnPUCgGrirdDcDJhtM7zqXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767107508; x=1767712308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+WQgG7fQTxW5tFBAiwVAR5DEAeQDHBQrYDuB+kdq/c=;
 b=A6r6o5PhRKy4YyeM/lC5APfHfM+qaHlLrwE7nQdjQxqOMFD8BuOQjHQNn4JCAueQcb
 6TCS/i77Ene9gBxZoejfdIZYRm+4Jq2lWrHuFBs+rXQMa1MbwuycUszWS5TG3GMhQKsB
 AWWIMMzjG9dKJMwO1T6zsS411CF/xAFrH3DCDkrhybRdpaELbmtNl82zeUmaWXPyH2AY
 VwqZYiV8c04MtppcdKXsUbAf8jDaA8KeuWrKHAtpPIBkqpbevLVJPCubYd3FnOkEK1pI
 S38OD52M/n6NjeqBF6jJCkBFEqKiA6SJLLZMtTso5cmPlMFIlJNBkhJ/l/KDS/+N6lVA
 r7eg==
X-Gm-Message-State: AOJu0YxV6tmX0NZd1iT9dxi6GJCFZSpW0SYjSWNN704Pb6TpQZ0sh+VS
 HRzcFwwBI8kr8fexMzkuZLcofe0PmwpP+odGXRgLRxSuB1i/+zc76w4OEey3YFErwbYMUCEMloq
 SyWP3TxSgx18n9zuSWbUyl7uK/9ufmK+m5gycGlLw
X-Gm-Gg: AY/fxX5qGeBDfYJwlqPOZr0TcoxSPNbl57Lh2KtepSbOxJRaNtuMnmhHz2WBNW8rMZ4
 go8YliXmzsjxf1hUtdYjGAZE2VEb0/0FKTpFgP4tcAfL/SC8ALwDYiaJ85C3ZEewQZAhyC+zTEr
 k66oDfdX9uZbvaKJ7gdLSv3E0oq2eQ9Lzyl0Q0+flAxCzNZdrPta61hTPzmg+fMF7VgjelLVCKs
 NTEJkKoOu1j9lG123SHhWYvNnO/JzO4rmBfU6XDK86+/YcH79VEHr0aR2KfI+Ly6r3PiF5LeaE0
 S1OZ
X-Google-Smtp-Source: AGHT+IG+KZp/Io8NBIyCLyOzmxgL6WtLhXoshS/agX9GJVAARVFf2gtvH48lkvyJfhcblzwIalDE/54hxOQDMNOZjM4=
X-Received: by 2002:a17:906:eecd:b0:b83:7b8c:7c5f with SMTP id
 a640c23a62f3a-b837b8c7d0fmr573671966b.1.1767107507764; Tue, 30 Dec 2025
 07:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20251201194857.2371332-1-simon.glass@canonical.com>
 <CAFLszTiS_hQbKnguY=ykyNOKk_hsMzBOAZAnOPjn7U49eunuFw@mail.gmail.com>
 <20251227144800.GJ710860@bill-the-cat>
 <CAFLszTib_BXUxdfkNTey0_r+RV9bKLwv6mqMd8P-ab-YevoWLA@mail.gmail.com>
 <20251227150651.GK710860@bill-the-cat>
 <CAFLszTg+yDdJ4TFPJF=_Z9f_aT7M1fuVCBc54sLcYfyfvvd97g@mail.gmail.com>
 <20251227203009.GM710860@bill-the-cat>
In-Reply-To: <20251227203009.GM710860@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 30 Dec 2025 08:11:36 -0700
X-Gm-Features: AQt7F2oVm26ItxY3AWfywo5I8g6b9oGjLxxHA194b-bL2_ASQsALacDrP28S8FQ
Message-ID: <CAFLszTiNVr4SxM32sggDG8QxeshOBMz2ggKhdWTEp4tjuB=WUA@mail.gmail.com>
Subject: Re: [PATCH] dm: core: Create ofnode stubs when OF_REAL is disabled
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>, 
 Anurag Dutta <a-dutta@ti.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Sat, 27 Dec 2025 at 13:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Dec 27, 2025 at 11:51:02AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 27 Dec 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Dec 27, 2025 at 07:58:10AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 27 Dec 2025 at 07:48, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Dec 27, 2025 at 04:44:07AM -0700, Simon Glass wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On Mon, 1 Dec 2025 at 12:49, Simon Glass <sjg@chromium.org>
wrote:
> > > > > > >
> > > > > > > When there is no device tree there is not point in trying to
find nodes,
> > > > > > > etc. since they will all be null.
> > > > > > >
> > > > > > > Add static inlines to skip the code in that case.
> > > > > > >
> > > > > > > Unfortunately this makes the file a little convoluted and
there are
> > > > > > > two inlines for ofnode_is_enabled() and
ofnode_first/next_subnode(). But
> > > > > > > it seems better than the alternative.
> > > > > > >
> > > > > > > We could also consider splitting up the header file.
> > > > > > >
> > > > > > > Also add a rule in drivers/Makefile to compile ofnode.o when
OF_REAL is
> > > > > > > enabled but DM is not (for kontron-sl-mx6ul) and move the
> > > > > > > ofnode_for_each_compatible_node/prop() macros outside the
OF_REAL
> > > > > > > condition, since they only use functions that have stubs.
> > > > > > >
> > > > > > > Co-developed-by: Claude <noreply@anthropic.com>
> > > > > > > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > > > > > > ---
> > > > > > >
> > > > > > >  drivers/Makefile      |   4 +
> > > > > > >  drivers/core/Makefile |   3 +-
> > > > > > >  include/dm/ofnode.h   | 714
+++++++++++++++++++++++++++++++++++++-----
> > > > > > >  3 files changed, 641 insertions(+), 80 deletions(-)
> > > > > >
> > > > > > Any thoughts on this patch, please?
> > > > >
> > > > > I'm not sure what you're expecting for AI-developed patches after
we
> > > > > talked on the community call about not doing that.
> > > >
> > > > I haven't been able to join recently but should be able to join the
> > > > one in a few weeks. Which meeting was it?
> > >
> > > The last call you joined, where you asked about briging up AI, and I
> > > explained why I didn't think it was a good idea, and we should at
least
> > > wait until after kernel summit, which was going to talk about it,
before
> > > we do anything else.
> >
> > Oh, that call. Yes I heard what you said. I didn't got to plumbers,
> > but Marek might have heard something.
> >
> > See this patch for the current state:
> >
> >
https://lore.kernel.org/ksummit/20251114183528.1239900-1-dave.hansen@linux.intel.com/
> >
> > There will likely be a discussion next year about which tag to use.
> > But I suppose this is relevant too:
> >
> > https://www.linuxfoundation.org/legal/generative-ai
>
> Yes, and there's an LWN article about the summit portion. I also thought
> the need to not worry about slop yet since it hasn't happened yet funny,
> in light how of much slop gets posted everywhere else. And the comment
> about it just reproducing kernel code anyways so no need to worry about
> copyright reminded me of https://github.com/ocaml/ocaml/pull/14369 yet
> again.
>
> But the huge point was "no AI", which you ignored.

That's quite entertaining! I had vaguely heard about that one before. It
shows the perils of people using AI when they know nothing about the code
base, or even maybe software development. I hope you are not suggesting it
has any relevance to my use of AI here!

Since we are talking about the same meeting that I was in, we discussed AI
and you suggested delaying a formal decision until the kernel maintainers
summit, to see what they come up with. I agreed with that. It seems they
are landing on 'disclosure', but certainly not a ban.

For reference, the LWN article is here <https://lwn.net/Articles/1049830/>.
I read through some of the comments. I recently read a book called 'Don't
Be a Luddite: Learning to Love Change in a World that Fears It' (it's an
'airport' book, so I'm not necessarily recommending it) which has loads of
examples about how each new technology generally hit huge resistance at
first.

>
> > > > > That absolute briefest review I can give is that it didn't solve
the
> > > > > problem either, and so you didn't test it correctly.
> > > > >
> > > > > I was just planning to ignore this, rather than get in to another
long
> > > > > thread with you that I suspect few people would read.
> > > >
> > > > The problem solved is in the commit message. Is that the problem you
> > > > are referring to, or is there another one? We can discuss it in the
> > > > next call if you prefer.
> > >
> > > It seems like you forgot why you made this patch. But your patch also
> > > doesn't solve the problem it states, which you would have also found
if
> > > you did more in-depth testing.
> > >
> > > This patch is I think a great example of why as a project U-Boot
should
> > > have a "Don't use AI" policy. If with all your experience with the
> > > project this is the best you can get I fear others will have even
worse
> > > quality output.
> >
> > It seems like you have reviewed the patch and have some feedback, but
> > you want me to guess what it might be? Is that correct?
>
> Well, that's half correct. I could send along what a friend of mine had
> Claude review it and say needs to be done, or what Gemini Pro "thinking"
> told me needs to be done. But it also doesn't solve the problem you were
> going to solve, because you didn't like Marek's approach. And you then
> didn't test the available failure case.
>
> And of course both of the AI reviews start from the premise that your
> patch correctly does what it describes, and that it's a good idea to do
> what you describe. Neither of which are good assumptions to make for
> actual review.
>
> > That patch took quite a while to put together and is fairly ugly. I am
> > sure I could split it up, particularly if it doesn't have to be
> > bisectable. But it could easily become 10 patches and a few separate
> > files, given the current state of ofnode.h
> >
> > But no, I don't know what is wrong with it. If you would like to tell
> > me I can take a look.
>
> I'm not sure what the point would be. It doesn't solve the problem that
> lead you down this path (I've now pushed the patches that do). The next
> problem is the seemingly countless times you've been asked to provide
> changes in a reviewable state, of which this patch is not. Finally, if
> you had reviewed the outputs you might have noticed and then wondered
> how this could result in size growth of the platforms that should see a
> size reduction because they don't set OF_REAL.
>
> But really, most critically, the current policy is Don't use AI. It is
> producing lower quality work that is difficult to review.

Please see above. BTW I often ask Claude to do a code review, particularly
with Python. It does a pretty good job of the basics. It can undertake a
refactoring, but struggles to see when one is needed/useful. Anyway, my
commit message is:

"When there is no device tree there is no(t) point in trying to find nodes,
etc. since they will all be null.

Add static inlines to skip the code in that case."

So that is the problem I am trying to solve. Probably what I would like to
do is turn it into a series which splits up ofnode.h so that the inline
portions are not in the same file. I haven't tried that approach, though -
it is just an idea. What do you think?

Re the size issue, I see this in exactly two boards: am335x_evm and
kontron-sl-mx6ul. I honestly didn't notice. There are quite a few
combinations to consider and it seems I didn't get them all. I will take a
look.

Regards,
Simon
