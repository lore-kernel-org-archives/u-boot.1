Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75A4C282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD88D81249;
	Thu,  6 Mar 2025 17:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B9W2ucdR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB90C811C1; Thu,  6 Mar 2025 17:08:09 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF5E48164E
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e5b572e45cso1419284a12.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277284; x=1741882084; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jR8r6aFGm6QfecuBj1JZFxhliA3jOI+OCIP57pD9U0s=;
 b=B9W2ucdRClHc8e33M3R63avu7fO0eaEfoc1RpUzvfPBQk1WoBKNm80ng7jxPXCAhml
 +B1MBJLXuMgDgTLYeN/MLyyuRQANhlMUSvtbBbPTzQv+dsP5X2xzofff6jn4p+Vr/5o1
 Tr4RqBwo69qN9YxjGXqvnr4K5ZSMYxfjkv7Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277284; x=1741882084;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jR8r6aFGm6QfecuBj1JZFxhliA3jOI+OCIP57pD9U0s=;
 b=UZc2Yv9JD6NVlvlwN7XegE9xnivMY9jUSd/wUvif2fd2l0zOPdE64ihfsp6MSipV7D
 CKAO4wOW/kD0Mih2pN/N46Wfj516l67/oj/XJq71MPCIqozKJTI7tGA+sRxETjIQUTIQ
 BOZVrUz4P6no4AZWf1uHUK3+Ryod/79YaqmCJ24fWagPoe7nUWpCDos9kioS8FcB68hP
 WKOPx2YoiUMsaaIpZVosiwbtg9OFqPO9+4uYfal7HYp/hg0mH8RX//+m1J6DTldFtyHs
 PwJzJTDE1Fzxf5WiU2WKIqLtcGPOiFuCwvms7bKOblXlNXUtzitGcV77K8Joa3zJqRpR
 xz4g==
X-Gm-Message-State: AOJu0Yx4Byv8bfjDskT5qdUAk5ni4tfZ+bZfw/yrcOvpbQuOPnyqtSyZ
 rP0fv5q6N3U/6pv4CMM4Xll3QDWv5iCBEYOs/+0w/+TBNx0XqGDBSeaxCcZNS9mnwQrJqrDpumn
 P8VApAhY39YoTNjJ57PKyxWsEAJ+xjnUpo2g+
X-Gm-Gg: ASbGncsLmiyGUC6vEiUxx3uDk49Xhebd1Sj/I3V17FkIvpO3iJpyXByPhyDlW1/x+1U
 ENvzdIgM6BDtChuR5t0/A7uY3haTb/vCmc+ACBNMqOq8/Cv6nGEDoYgq55iqCBTqmC6cWDgCbRc
 cHMn9OoR+dE3sRKhd7WGdVg3YXNPw=
X-Google-Smtp-Source: AGHT+IFdpSAV5CdptD2GumgFd7nO32hUUICr3Qe9Ewffz4clG8QU3Ci1mg95++0biasFEbulgjgIubm2w0dXYu6dCGU=
X-Received: by 2002:a17:906:3684:b0:abf:5d9b:8076 with SMTP id
 a640c23a62f3a-ac20d92d606mr741455366b.33.1741277284106; Thu, 06 Mar 2025
 08:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20241018030027.842749-1-sjg@chromium.org>
 <87jze5ao26.fsf@prevas.dk>
 <CAFLszThFNXxM2cWdMHWFP8NsH5x6-X9u7aWNpPokgLWRAA55=g@mail.gmail.com>
 <CAFLszThznjs9Ama40sMtnrdMhThB0TfS4usVSH+yAZw-2Tj0tQ@mail.gmail.com>
 <87pliw62xn.fsf@prevas.dk>
 <CAFLszTjyJW05xpjg23B2KHMi9-tZVZhRd0Zpr3A7yfcQJc+4MQ@mail.gmail.com>
 <87zfhy44v3.fsf@prevas.dk>
In-Reply-To: <87zfhy44v3.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Mar 2025 09:07:52 -0700
X-Gm-Features: AQ5f1JraJrLyD11zV8faXx35FuNRHVuaawmTjZoVVnOmckA-Frzg8jaNTjt6YcU
Message-ID: <CAFLszTidXeiY_OtVg75vD18pXjTKykamsZgNpFqOuMm20mZ=Mw@mail.gmail.com>
Subject: Re: [PATCH 0/8] membuff: Add tests and update to support a flag for
 empty/full
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ion Agorria <ion@agorria.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marex@denx.de>, Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Rasmus,

On Thu, 6 Mar 2025 at 07:21, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Wed, Mar 05 2025, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Rasmus,
> >
> > On Tue, 4 Mar 2025 at 11:55, Rasmus Villemoes <ravi@prevas.dk> wrote:
> >>
> >> On Tue, Mar 04 2025, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> > Hi Rasmus,
> >> >
> >> > On Fri, 18 Oct 2024 at 08:55, Simon Glass <sjg@chromium.org> wrote:
> >> >>
> >> >> Hi Rasmus,
> >> >>
> >> >> On Fri, 18 Oct 2024 at 01:05, Rasmus Villemoes <ravi@prevas.dk> wrote:
> >> >> >
> >> >> >
> >> >> > If you want to do the churn of renaming anyway, I suggest doing it by
> >> >> > adding an implementation using the proper scheme under the new name,
> >> >> > switch users over, and dropping the old. IMO, this series as-is brings
> >> >> > no value (except for the tests, of course).
> >> >>
> >> >> OK. Do you think this series gets us closer to that, or further away?
> >> >
> >> > I didn't get a response to this (which is not a problem, I miss things
> >> > all the time). Anyway I don't like the power-of-two restriction and
> >> > you can see my other responses above. I've applied this to my tree as
> >> > I want to have the tests in place.
> >>
> >> I stand by my earlier comments that this is the wrong way to implement a
> >> circular buffer. I hope Tom doesn't pull this.
> >
> > OK. Are you saying that you think it should only support power-of-two
> > sizes,
>
> Yes, because that's the natural way to implement such a simple data
> structure on real hardware, and I don't agree that it limits its
> usefulness in any way. See how the linux kernel implements unix pipes,
> and their kfifo helper.
>
> > or something else? What specifically do you want?
>
> I don't "want" anything in particular. I'm merely voicing my opinion
> that I consider this approach to implementing a circular buffer
> inferior.
>
> > This series:
> > - adds tests
>
> Yes, always a good thing.
>
> > - renames to membuf
>
> While we can agree that is better than with two f's, I don't see it as a
> huge virtue.
>
> > - shows how we could switch to using an empty/full flag instead of
> > leaving an empty slot, so we can see the code-size image
>
> As I've said previously, I believe that actually makes the whole thing
> even worse. Not using the natural wrapping/masking is already
> error-prone enough, but needing to have two parallel implementations
> living in the same source files with #ifdeffery; please, no. Do one or
> the other, unconditionally.

Sure, I can remove that, since it seems that the flag is not that
useful. I'll send a patch.

>
> > - does all this without requiring the size to be a power of two (which
> > limits its usefulness IMO)
>
> On that, we'll just have to agree to disagree.

An example of this is parsing a text file. At present you can just:

membuf_init(size...)
membuf_readline()...

whereas presumably with power-of-two you would need to

int newsize = ALIGN(size, next power of two....)

void *newptr = malloc(newsize)
memcpy(newptr, data, size)
membuf_init(newsize...)
membuf_setup([so that only 'size' bytes are present])
membuf_readline()...

>
> Rasmus
>
> PS: Something like
> https://gist.github.com/Villemoes/332ac7a5dfc983c58ad40773c7bc6385 is
> what I consider a simple and readable implementation (it may be buggy,
> of course).

There are no tests, so who knows? But also, it doesn't allow 'raw'
access which is considerably more efficient in many situations, e.g.
you can find out the amount of space, read directly into that space
without a separate buffer, then confirm how much you read.

Certainly my code can be improved.

>
> Frankly, the triple-pointer use in membuff.c frightens me, and that the
> implementation of something as simple as membuff_avail() involves a
> struct copy and calling membuff_getraw() in a loop makes it really hard
> to reason about and verify.

We have tests for verification. But how about you send a patch against
the API in my tree? If we can come up with something we both like,
then perhaps Tom might apply it.

Regards,
Simon
