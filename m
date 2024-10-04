Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF09CF34DD
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 01:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A68B488B86;
	Fri,  4 Oct 2024 03:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NQ9BA4xK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8FF588BEF; Fri,  4 Oct 2024 03:29:12 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5438A888B2
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 03:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cb37b34a87so10528576d6.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 18:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728005349; x=1728610149; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vvMH3Qa+LQ4S59FO8lTfjFp+2P8Sal03oWm05geOLbc=;
 b=NQ9BA4xKn/U9d+dbwL3o0Hn3iN0R9yPgrzn41rFgG1DIxoGbslL0pso7wNad3c/QRf
 j3MWFwoO8K9GGTVX0d5qmFg8eznfbUeCyUTVXSZYXGvmTumtcAwHCwufIKfJGshT6BA8
 +CBkDSGUFTeor+vi2F8xqXDLJiC+UrznOqyPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728005349; x=1728610149;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vvMH3Qa+LQ4S59FO8lTfjFp+2P8Sal03oWm05geOLbc=;
 b=F5ZaKuDHxI4FbzdYbKOGIPXSEub9bJOP3qYZLABhDEtb0PQeXwMiHvzobRly9bJfZO
 Ghry5wJZVg6LUzqFVpT7J1jnmkRjlN4aiEte5wmkO7U6iuJlvwxZvXFjh3p2RRLU/PHS
 +rTU9PjGlnCVWfMMjSR1cUxLcu05HmYLY/p8hA+WdxywB466e2mXzsgXU2HjDnglJz0U
 0TbveHeX6n9p2qpO6bzgo/WmuN/tPa19pxESPeUrrvV+59ho6IynF87q6j4ppJyEG48I
 PWUY1Qc3kmY/mIQU9oU6T5WRZx76dyuqgSK5lk55VDyfcSqpRf5DY9MLAtAiKrjy65A6
 GFUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiI+rHIAs4vLRuv1yRp3djl7KaQAHGoAk2mDL9IhYcfqWKCDm7otcEVbnR0gzCASgY8nKoznk=@lists.denx.de
X-Gm-Message-State: AOJu0YyfzwxlB24Z6pjCV9TIiUuHQpfFKlAKEqsRymvbCzYhRSULo1qN
 9PycHwhyvQkb5L8tAtU7JmsXfSRxyCFY5JgxqYCqet6Kb4yb9vzPab2aASCEkNCV/DQaLER9Pzf
 ZMR1bbGYUoXkk/oe9tBDHYmuP46p3yVZh0Pg5
X-Google-Smtp-Source: AGHT+IFj9d85f1eQtHSkGvhdDNbkjJt9EH31b/BnJ1YBDDiqHP6jaUY8+wnu6eqM+gDybRwbnBYQBhNpSHze/gepBBQ=
X-Received: by 2002:a05:6214:5d0e:b0:6cb:9058:37ff with SMTP id
 6a1803df08f44-6cb9a44227amr19887356d6.14.1728005349116; Thu, 03 Oct 2024
 18:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-26-patrick.rudolph@9elements.com>
 <CAFLszTh-cEBp0-HP5XMONdwSUBepKWNgJSHLJfQ2VYW9FgJq=Q@mail.gmail.com>
 <20241003013516.GR4737@bill-the-cat>
 <CAFLszTgoD6YDpGTJLPxfqXoudR=TDDDAHQMUJzK+mxntpfhk4w@mail.gmail.com>
 <20241003144351.GU4737@bill-the-cat>
 <CAFLszThJ8ZUpq9_VVTxw6YwCmKqx1gghwinPx-=Srqc5k02UCw@mail.gmail.com>
 <20241003191751.GV4737@bill-the-cat>
 <CAFLszTi5nj-tXuO+UGJSPbJxqFtwQXkN8UsjT2hi1LF6zGLFHg@mail.gmail.com>
 <20241003222516.GW4737@bill-the-cat>
In-Reply-To: <20241003222516.GW4737@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Oct 2024 19:28:58 -0600
Message-ID: <CAFLszTgwkZCu9J5Yr0+0xeB4rgeekLAuzXiY1fmEzD4stoPDWQ@mail.gmail.com>
Subject: Re: [PATCH v6 25/37] board: emulation: Add QEMU sbsa support
To: Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>
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

On Thu, 3 Oct 2024 at 16:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 03, 2024 at 02:46:03PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 3 Oct 2024 at 13:17, Tom Rini <trini@konsulko.com> wrote:
> [snip]
> > > We don't, but this isn't quite a normal board?
> >
> > Don't be surprised if this becomes more common. For better or worse,
> > ARM has decided on ACPI for its servers and RISC-V is following. We
> > also have the EFI app, which has a devicetree, although of course no
> > actual addresses.
>
> True. And U-Boot being able to take and reasonably as far as the OS is
> concerned be the UEFI implementation in UEFI+ACPI boot opens us up to
> being able to be part of the software stack that's certified for
> SystemReady ES and SR. On that real hardware we can certainly expect to
> mandate that the previous part of the firmware stack gives us a device
> tree. It will be TF-A and so the "pass over a device tree" part
> shouldn't be an issue. And since yes, really (and for the future
> record), real hardware isn't allowed to fake this out like we're
> allowing here, today.

Indeed.

>
> Heck, it's possible that down the line and it's important to a lot more
> people, we can get the TF-A build for QEMU SBSA to have an option to
> include a device tree for U-Boot, because it's an important part of the
> stack for that project to be able to validate too.

We'll see!

>
> > > > Breaking down the SBSA_UART_BASE_ADDR:
> > > >
> > > > - this is in the uart0 node so obviously relates to the UART
> > > > - it is a reg property, so BASE_ADDR is obvious
> > > > - SBSA is the board name, which is in the filename, so don't really add anything
> > > >
> > > > Normally where the devicetree needs a value defined, we put it in the
> > > > dt-bindings directory. But even then, we don't typically put addresses
> > > > there. It is just for cases where we need the code and the devicetree
> > > > to be in sync about a property value. With addresses, the code reads
> > > > them from the devicetree, so doesn't need to have a #define to access
> > > > them...in fact that would defeat the purpose.
> > > >
> > > > If we did this sort of thing with other boards, we would have a heap
> > > > of binding files containing addresses that are only used in one place.
> > > > I just don't see the point.
> > > >
> > > > However for SBSA_PCIE_MMIO_BASE_ADDR I see that it is used in the .asl
> > > > and the memory map, so it seems fair enough to define that, at least
> > > > unless/until we can refer to devicetree addresses in the .asl file.
> > > > Even with this one though, I would expect something like:
> > > >
> > > > ranges = <0x02000000>, /bits/ 64 <SBSA_PCIE_MMIO_BASE_ADDR
> > > >
> > > > SBSA_PCIE_MMIO_BASE_ADDR>;
> > > >
> > > > But in this case I can see how a macro might be more convenient and
> > > > I'm not sure I have a strong opinion here.
> > >
> > > If you're strongly against using the macros here, OK, fine. But since
> > > this tree is only going to be read by humans in U-Boot, and consumed by
> > > U-Boot, I think it makes sense to deviate from the norms a little, in
> > > favour of human readability.
> >
> > How about only using them when there is code that need the same address?
> >
> > There are two lots of macros so just to check we are talking about the
> > same thing:
> >
> > - xxx_BASE_ADDR - IMO they should be open-coded into the devicetree if
> > it is the only user
> > - MAKE_PROP - IMO we should use /bit/ 64 instead
>
> OK.
>
> > > > > > But I very much doubt upstream would accept it with a macro. Other
> > > > > > 64-bit boards seem to use '/bits/ 64'.
> > > > >
> > > > > What upstream are you referring to here? I'm not sure what other project
> > > > > will want a device tree for the "no device tree only acpi" virtual
> > > > > reference platform.
> > > >
> > > > It depends if they want to run U-Boot or not. U-Boot always needs a
> > > > devicetree, as you know. It cannot use ACPI tables to configure itself
> > > > and I would rather it doesn't start.
> > > >
> > > > I don't actually see any reason why this devicetree could not be
> > > > upstreamed, except that QEMU actually creates a Linux devicetree right
> > > > now (on the ARM side) and takes no notice of what U-Boot needs... I
> > > > don't see any U-Boot patches from the maintainers, for example,
> > > > although I may have missed some. It seems very focussed on UEFI. I
> > > > would love that to change, as QEMU is widely used in U-Boot on ARM...
> > >
> > > I feel like we're lost the point here. This platform in question is the
> > > "never use device tree, only use ACPI" reference platform.
> >
> > never use device tree for Linux
> >
> > (U-Boot always uses it)
>
> True.
>
> > > This is not
> > > the regular "virt" platform, even. U-Boot needs a device tree because
> > > internally we use it for configuration. I do not see the QEMU project
> > > agreeing to have this platform generate a device tree for us to consume
> > > in this case, declaring instead that it's a U-Boot internal need and
> > > that no, it's fine if U-Boot can't use it. _We_ want it because it makes
> > > testing of the aarch64 + ACPI use case easy because it provides us with
> > > the ability to use the reference platform too and make sure that we
> > > aren't breaking the OS in unexpected ways.
> >
> > OK, well as you say this is not really the main issue, so that's fine.
> > I agree (and was lamenting) that QEMU seems unwilling at present to do
> > anything to assist U-Boot.
>
> At least today, I don't think this is even a QEMU issue, honestly. A
> point could be made in the future that EDKII will ignore TF-A passing a
> device tree, and that also needs to be confirmed / validated because
> <physical hardware platform> supports EDKII or U-Boot for ES/SR
> certification. That's a much stronger I think position to start from in
> asking QEMU to pass along the device tree that it could make.

Yes, sure. I do feel that if there were a few more U-Boot users in the
QEMU world then it might have already happened. I am almost tempted to
send a patch to add a pre-built u-boot.bin to QEMU :-)

Regards,
Simon
