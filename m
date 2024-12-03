Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7264FE74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F87896AD;
	Tue,  3 Dec 2024 20:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MWrMICjG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8237896DE; Tue,  3 Dec 2024 20:46:00 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33C26896AD
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ee397a82f6so4339693a91.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733255157; x=1733859957; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bdig8EuLunQR4emhUXsMYqQllPYB2LxBfBt1XvhiEnQ=;
 b=MWrMICjGkJqqA8bqq5BlIuRZOutw8VIvHoy6024F+/gAVYQyWhyASVPmbZnSCOcuTe
 AYO1ewcbId6BV6FD/FI2DFXDFUsnlVPY09YlCwROmtM477RWnXed9ZJsM07tTNp998eB
 bIC8g8NqNyhgOHXllRSx9ScMq7pYbYpKjS4To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255157; x=1733859957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bdig8EuLunQR4emhUXsMYqQllPYB2LxBfBt1XvhiEnQ=;
 b=QyW+YN1YIlxCvH5V1omyvty/4z7Mz84xIhZ9z7j/Kq2kDK/hDhMZlnPnGI7hsDHSU5
 EXFOIbVQKoyjKkPXF56CpUKaXeUXyniXAQtM4vOW8U92cVCJ1HkGwtXbuL+A1sY7QoXk
 8nj58kbtGpM7HowBJddwuVOsUtugp3fU5PuVmQ1cWnyL+Tn2o0+I+0Dl+HvKDQWl+D8v
 zMwmZfZvpoyfe1dHW9naUFSWp8BLXDRILTiKp1OyK/VKEPEbvh4JiQRqPZXeNEYDLF2q
 j1rcwt/is/b328FXFSVHY1diiXNOO9hvrFcuZ0Cn3kS2hHtMkJiUt/WnkA/nkfQkXa0v
 nyKw==
X-Gm-Message-State: AOJu0YymheEvo7cewPKU7CusTfHQH1rEt/2y5rlKkT5BldJZCxoL617J
 SgIBTZE17dz607w8nVcYlsoToCnCyn3IDcr7GqMQsTBK/GIBbttXye9TVIxCL7LH7Zp5OgJ5JrJ
 YdlJSg/WWLJ20n4e3xzC+A5Xw4stUZ2DNi6yF
X-Gm-Gg: ASbGnctWgGtyM6ZXZOLtKiia1i/VKh6/DFwNcXW9V+i7IXmWLSO93SH0hWkGj0PVMtI
 wBBdptauDwK7soUK8wPL1bEhKYVSnhm4O
X-Google-Smtp-Source: AGHT+IEY7OnspM9X4Ap9lVRjBTtYtQAAWcDF4j0v2MhQiKw1y9hTgziLQCSssvZ8KelewgFuveNs9Sl0qwTmEGXORYU=
X-Received: by 2002:a17:90b:4b83:b0:2ee:535f:ac27 with SMTP id
 98e67ed59e1d1-2ef01272aa3mr5138620a91.33.1733255156740; Tue, 03 Dec 2024
 11:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20241201152815.1668093-1-sjg@chromium.org>
 <20241201152815.1668093-4-sjg@chromium.org>
 <20241202215922.GI2457179@bill-the-cat>
 <CAFLszTgfPnJCi=Q+-ROMd2dU_z49C2h4wHgmFrq80TQ0kD_BFA@mail.gmail.com>
 <20241203140026.GS2457179@bill-the-cat>
In-Reply-To: <20241203140026.GS2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 12:45:37 -0700
Message-ID: <CAFLszThwNBRhrg8QjERSzzmff-rnFGFf0PrTY3Um=zeLO40iLw@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] board_f: Correct stack reservation
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, 
 This contributor prefers not to receive mails <noreply@example.com>
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

On Tue, 3 Dec 2024 at 07:00, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 03, 2024 at 06:53:55AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 2 Dec 2024 at 14:59, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Dec 01, 2024 at 08:28:05AM -0700, Simon Glass wrote:
> > >
> > > > The reserve_stack_aligned() function already ensures that the resulting
> > > > address is aligned to a 16-byte boundary. The comment seems to suggest
> > > > that 16 is passed reserve_stack_aligned() to make it aligned.
> > > >
> > > > Change the value to 0, since the stack can start at the current address,
> > > > if it is suitably aligned already.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > Er:
> > > /*
> > >  * reserve after start_addr_sp the requested size and make the stack pointer
> > >  * 16-byte aligned, this alignment is needed for cast on the reserved memory
> > >  * ref = x86_64 ABI: https://reviews.llvm.org/D30049: 16 bytes
> > >  *     = ARMv8 Instruction Set Overview: quad word, 16 bytes
> > >  */
> > > static unsigned long reserve_stack_aligned(size_t size)
> > > {
> > >         return ALIGN_DOWN(gd->start_addr_sp - size, 16);
> > > }
> > >
> > > is what the code is today.
> > >
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  common/board_f.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/common/board_f.c b/common/board_f.c
> > > > index 98dc2591e1d..677e37d93c0 100644
> > > > --- a/common/board_f.c
> > > > +++ b/common/board_f.c
> > > > @@ -601,7 +601,7 @@ __weak int arch_reserve_stacks(void)
> > > >  static int reserve_stacks(void)
> > > >  {
> > > >       /* make stack pointer 16-byte aligned */
> > > > -     gd->start_addr_sp = reserve_stack_aligned(16);
> > > > +     gd->start_addr_sp = reserve_stack_aligned(0);
> > > >
> > > >       /*
> > > >        * let the architecture-specific code tailor gd->start_addr_sp and
> > >
> > > And this is the last call to reserve_stack_aligned(). So, this is going
> > > to save us between 16 and 0 bytes of memory. If we're going to make a
> > > change here we need to comment in the code more what we're up to at this
> > > point, and the commit message should be more authoritatively worded too.
> >
> > So, other than that, what do you think? Should I respin it? Note that
> > this is part of a series which I doubt will be applied to your tree.
>
> I mean, yes, I've given you review comments. If you want this applied to
> mainline someday then you need to address them.
>
> > It would be nice if other archs could weigh in, but I see that I have
> > not copied them. Still, the current code is confusing (in that the
> > comment doesn't match the code), so we can likely figure this out in
> > -next
>
> Yes, my comment was that you need to make the comment match the code and
> expand upon the common since I expect it's been that way for a decade+
> at this point.
>
> > Heinrich expressed some concerns with RISC-V, but there doesn't seem
> > to be any breakage in CI. meminfo reports that the devicetree is above
> > the stack and it semes intact:
>
> Yes, I too was concerned about why exactly we're changing something here
> with a commit message that sounds unsure if it's correct to make these
> changes, only probably correct.

OK, it is true I was hoping for some comments. Unfortunately the code
has been there forever. But I'll reword it to be more assertive.

Regards,
Simon
