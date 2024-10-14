Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74238D1813D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 19:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BF8B89110;
	Mon, 14 Oct 2024 21:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iTsT9ptH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A520A8915C; Mon, 14 Oct 2024 21:13:54 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD3689096
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbd00dd21cso30310096d6.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728933230; x=1729538030; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YA9kngrAncJRY5Z+BcVqBNArY6gg9k0Zn78InmJ0zN4=;
 b=iTsT9ptHU9QZ7TbwCN3SVDb4rHT5isNMH7ID8TXgC8r8iRwZtuBez1M0ii3BcEAGvE
 fKzcfRXMBddo2jXNFxGJlQdp0/KUZCTpryuzkQqSg9zf8x5uv/z0bE6UC/yzlGqwniRV
 az0imSwGHYsKUCjjGvsfQ9A2AiUJrXCYcP5yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728933230; x=1729538030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YA9kngrAncJRY5Z+BcVqBNArY6gg9k0Zn78InmJ0zN4=;
 b=PvS5WhFUG4896b8yY2obhRUScBQcjVyt4UZ+i4FHzI1O0cNLWe4uXzCbXuGoVXsz30
 R1u50bderI86NbQrLT0PLU6d8aVqHWJ3pUGjqYj+GlDKoQn3yK544Yufw5U0TG4mx4B5
 lsHl+CmPl8hqPHOKwdHq/LqLkq+ES0c7MvBUADOoOnZRRlIygoaIqKgfcUjIWj2KddPm
 H71VoZcSqOs7CNYhmyOfMmLyjcWB1grhXs/jQoCgVxIv6cN4PpsYCFaS6NAlu5r5l0Pt
 +vfcEpXPEGmclFY+9qbz6YQ8nFJaI459ymSYH1mULOi72EBSBlQHk7j8snRV7HiHFcmj
 M6Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYpTwEtyhJUmARLTJ5T7YcIh2bL7bRdiDpgEUmmEN7X1jI6XPqHv4iTSyG5mcU2dbS7NWWQDE=@lists.denx.de
X-Gm-Message-State: AOJu0YyzZYN2zMRHw7+E3PdBhA4hIIPs5RirnJu/No38m66YEF93B1Wd
 GAbBVM1SZ8CYEITNAnyms9IrgaKfEosjsqcWHCQLeqjxjQmUVABx7c1834B+PadbI05n3EcACYS
 SORpmNE6Vp6EdmkKp9+F+kTMYAk618Z4iIZcAVx90Tu8X1kQ=
X-Google-Smtp-Source: AGHT+IHdrLCarip8t6Bj+EBMwEnmAIqyuWWQvx504mzdVZ/i4XX8v9om0lWXZQ+5Y4BmTFUqR0d6SuJmzwtV8qKRP1s=
X-Received: by 2002:a05:6214:4346:b0:6cb:fcbe:b34b with SMTP id
 6a1803df08f44-6cbfcbeb3dcmr145390116d6.32.1728933230697; Mon, 14 Oct 2024
 12:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
 <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
 <20241001002442.GC4737@bill-the-cat>
 <79d98f61-7659-47a3-938f-1eb79f402edf@gmx.de>
 <20241001180235.GH4737@bill-the-cat>
 <e02a9912-7260-4e0a-81d8-c7814907a791@gmx.de>
 <CAFLszTj6Zuj0b3kEA4OKOQY_D5XMWmtbn+HJXik+xSrB7LUjLA@mail.gmail.com>
 <20241011222807.GZ14210@bill-the-cat>
 <CAFLszTiAdR-LTLqMjpyLgXDT99p+_8KZyDPk1ZJ8hTHGaQd+oA@mail.gmail.com>
 <20241014022501.GC53053@bill-the-cat>
In-Reply-To: <20241014022501.GC53053@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 13:13:40 -0600
Message-ID: <CAFLszTiAf505RtnLjFY62PduhXyAEP_9v_gT_8CNORr_Fs+PPw@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sun, 13 Oct 2024 at 20:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Oct 13, 2024 at 01:33:32PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 11 Oct 2024 at 16:28, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Oct 11, 2024 at 04:16:28PM -0600, Simon Glass wrote:
> > >
> > > > Hi Heinrich, Tom,
> > > >
> > > > On Tue, 1 Oct 2024 at 16:18, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > [snip]
> > > > > The relevant error message is:
> > > > >
> > > > >      E   Exception: Bad pattern found on console: spl_signon
> > > > >
> > > > > The error occurs because the substring
> > > > >
> > > > >      U-Boot SPL 2024.10
> > > > >
> > > > > occurs multiple times during the reboot process. This is not expected in
> > > > > wait_for_boot_prompt().
> > > > >
> > > > > The EFI test is resetting the board and then calling restart_uboot()
> > > > > which by itself does another reset.
> > > >
> > > > We had this discussion a while back and I was very-much opposed to
> > > > restarting U-Boot within a test. It has set a bad precedent and now
> > > > several tests do it.
> > > >
> > > > This is another EFI thing that I would like to resolve at some point.
> > > > As previously mentioned, I understand we might be one test to check
> > > > that U-Boot does actually kick up a firmware update when started, but
> > > > I don't think we should be restarting willy-nilly.
> > >
> > > We should indeed not be restarting willy-nilly. And we don't. But the
> > > test for "can we restart the system" must restart the system. That's the
> > > test. It's not changing. Testing if we can restart the system by faking
> > > the restart is not testing restarting the system.
> >
> > If it were just one test I would be OK with it...but it has spread,
> > unfortunately. When I run under gdb I constantly have to manually
> > restart U-Boot.
>
> Then I'm sorry to say you picked a bad example to bring this up on.

Ha ha, yes! I will resend the series without the skipping.


- Simon
