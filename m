Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AECE64AAA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6097088E5C;
	Tue,  3 Dec 2024 14:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cqIV6L2n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 970E989328; Tue,  3 Dec 2024 14:54:10 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 118D488E35
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:54:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d0e75335e3so3008248a12.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733234047; x=1733838847; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tejMubCISBhzFOYUc6R7p8Lt4/mErDM/CQ8k1Ppcn7w=;
 b=cqIV6L2ngtpCxwgrE+rYQIhnjxc6bOqYWubeobCx4VxfMZOv+kWHFv1okgYA+fIfnv
 j+xcNAyh9LTD4z1C+FUkTuP8f+V9Q2i8jQMQ1LNK2rLMcZeSDXVLwcQz1rel4sb8jfdu
 n4YR3KFoYoArbXgvGSoap9tavmdJ84AqNaGHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733234047; x=1733838847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tejMubCISBhzFOYUc6R7p8Lt4/mErDM/CQ8k1Ppcn7w=;
 b=NiKBErisbAREt7xGfAyToaHGoxkD/keOiD1KhZh4rXAVyffHDdOIDLqIHiuHi5cGDJ
 J/qZD4r+o5FDhpmUYW1dtkbSm/0J+NQALYasI6EUROsZ06CMyZEHYOEPLDVHaGBh2vvd
 jp7+DBrMXqJ1wY/lDBmNOdzW285NYV/xTA7XOY81gpyFg+f6wDwYoyk6QUcwI2GBkiX/
 B8j/jRSZi/CPpwwgeFl2+EUMdqCQATxHfj6mOsg2hkMscTYDQ4+OVHkV69DH3ldbpcTQ
 Y6w3rOBFUItD/Z7jiMDhkoCs11jZORGVfUVR+ZiOGCFGdEeLFKPKy5njFim3iJoKvmIp
 KCqg==
X-Gm-Message-State: AOJu0YzijP8v8UQ/noM+lHOsnCxJ6bjfIr3ZmCPUAif6YzufIRmfrfqk
 D9n6uw2Sg3WTzLy17qas+KtsMVIcGhE9J9IH40gz2cc6FnD25WLctCidJmJqzIAdN6a/gk9+LmN
 lsmhF/KcWNR9k+OS87bvSiqn/nDl370qU8a0C
X-Gm-Gg: ASbGncvLK3JQEtQUn2uZ1QiyRfg4mf6pRLU+bmY6aP2aHpBWgToAWEFc8GPAd/G6fTt
 KG/4xiIyOeup4bZC2ndE49cLGLXlc8LSC
X-Google-Smtp-Source: AGHT+IEgiW7r2HUYVmRt7yOIsBHuFt+duZ2mBPm8UQuLCsUOK95/RnYkFpspUx+0Eawc+FtKNXOGguWhPpKSH8O28rU=
X-Received: by 2002:a17:907:7d9e:b0:a9a:46:83ee with SMTP id
 a640c23a62f3a-aa5f7ef4c56mr206079966b.48.1733234047421; Tue, 03 Dec 2024
 05:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20241201152815.1668093-1-sjg@chromium.org>
 <20241201152815.1668093-4-sjg@chromium.org>
 <20241202215922.GI2457179@bill-the-cat>
In-Reply-To: <20241202215922.GI2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 06:53:55 -0700
Message-ID: <CAFLszTgfPnJCi=Q+-ROMd2dU_z49C2h4wHgmFrq80TQ0kD_BFA@mail.gmail.com>
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

On Mon, 2 Dec 2024 at 14:59, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Dec 01, 2024 at 08:28:05AM -0700, Simon Glass wrote:
>
> > The reserve_stack_aligned() function already ensures that the resulting
> > address is aligned to a 16-byte boundary. The comment seems to suggest
> > that 16 is passed reserve_stack_aligned() to make it aligned.
> >
> > Change the value to 0, since the stack can start at the current address,
> > if it is suitably aligned already.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Er:
> /*
>  * reserve after start_addr_sp the requested size and make the stack pointer
>  * 16-byte aligned, this alignment is needed for cast on the reserved memory
>  * ref = x86_64 ABI: https://reviews.llvm.org/D30049: 16 bytes
>  *     = ARMv8 Instruction Set Overview: quad word, 16 bytes
>  */
> static unsigned long reserve_stack_aligned(size_t size)
> {
>         return ALIGN_DOWN(gd->start_addr_sp - size, 16);
> }
>
> is what the code is today.
>
> > ---
> >
> > (no changes since v1)
> >
> >  common/board_f.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/common/board_f.c b/common/board_f.c
> > index 98dc2591e1d..677e37d93c0 100644
> > --- a/common/board_f.c
> > +++ b/common/board_f.c
> > @@ -601,7 +601,7 @@ __weak int arch_reserve_stacks(void)
> >  static int reserve_stacks(void)
> >  {
> >       /* make stack pointer 16-byte aligned */
> > -     gd->start_addr_sp = reserve_stack_aligned(16);
> > +     gd->start_addr_sp = reserve_stack_aligned(0);
> >
> >       /*
> >        * let the architecture-specific code tailor gd->start_addr_sp and
>
> And this is the last call to reserve_stack_aligned(). So, this is going
> to save us between 16 and 0 bytes of memory. If we're going to make a
> change here we need to comment in the code more what we're up to at this
> point, and the commit message should be more authoritatively worded too.

So, other than that, what do you think? Should I respin it? Note that
this is part of a series which I doubt will be applied to your tree.

It would be nice if other archs could weigh in, but I see that I have
not copied them. Still, the current code is confusing (in that the
comment doesn't match the code), so we can likely figure this out in
-next

Heinrich expressed some concerns with RISC-V, but there doesn't seem
to be any breakage in CI. meminfo reports that the devicetree is above
the stack and it semes intact:

$ qemu-system-riscv32 -nographic -machine virt -bios
/tmp/b/qemu-riscv32/u-boot.bin


U-Boot 2025.01-rc3-00068-g6f392929ea11-dirty (Dec 03 2024 - 06:51:44 -0700)

CPU:   riscv
Model: riscv-virtio,qemu
DRAM:  128 MiB
Core:  26 devices, 13 uclasses, devicetree: board
Flash: 32 MiB
Loading Environment from nowhere... OK
In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
No USB controllers found
Net:   No ethernet found.

Hit any key to stop autoboot:  0
=> meminfo
DRAM:  128 MiB

Region           Base     Size      End      Gap
------------------------------------------------
video        87800000   800000 88000000
code         87740000    bf2d8 877ff2d8      d28
malloc       86f20000   820000 87740000        0
board_info   86f1ffc0       40 86f20000        0
global_data  86f1fe50      170 86f1ffc0        0
devicetree   86f1ef30      f02 86f1fe32       1e
stack        85ede000  1000000 86ede000    40f30
lmb          85ede000        0 85ede000        0
lmb          85edb000     3000 85ede000        0
free         80000000 85edb000  5edb000 80000000
=> md 86f1ef30
86f1ef30: edfe0dd0 020f0000 38000000 980d0000  ...........8....
86f1ef40: 28000000 11000000 10000000 00000000  ...(............
86f1ef50: 6a010000 600d0000 00000000 00000000  ...j...`........

Regards,
Simon
