Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE43BD3B7E5
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 21:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E8583C02;
	Sun, 28 Dec 2025 22:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RpNB/k7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BB3D83A8C; Sun, 28 Dec 2025 20:29:28 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90C183A3D
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 20:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7b9c17dd591so7296739b3a.3
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 11:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766950164; x=1767554964; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNcag82LWIMA9hrXqB2W/OZOMYOo7hopRWn4rOAhHfY=;
 b=RpNB/k7H4sBqkkwEfHAAwXL9jKw4/Je0dVBJUtHdwmLcf3GAZbVg3KQIM6V+0nVLZj
 5Sst6Szm1kUl+3Bn7CZt0Rj60MY2ykf9ovRdvCFkn3sGY9HCP14GIupaqkOBo8vqPtgM
 2PM5hoRER0HIw6VGQznoek25Tw0IxZj24UvIpHNhYQo3BMgogKmQwZp2uepGrooObm7Q
 Aehe4QsMtNhYNVwCJbo7Lr50v3Tx4kV+2awU6yXohnHyOPTukhQLtzc0Hm9bwWPqTyA7
 CvFIoYz8yfyGrVa/vTpvAYQ5j4Rw1/GPv63olBItcw5Mjh8ZERGAUiw8YW8Mk75/39sh
 JV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766950164; x=1767554964;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZNcag82LWIMA9hrXqB2W/OZOMYOo7hopRWn4rOAhHfY=;
 b=nG+QB8C83OQlX7fLC/yTg18SNao+mRILqBRfN9GhHTL9t3fh3rR/2FsP9Q0Q9FQzzG
 dRU3eNpIIvEzYVCtNTsKGbtpHgjfIrVDsw1ElhMb35D+2jJ1MZVfo+TAIfrS+de2CtVi
 Quc72JR+fbjbtpHHXkYvaKk5p9UpSh2iyT2vQlUkntb7kxPxmNd7d+Vk8NONYals/B1Z
 +VTDeE8O/gJlPupU9Oo3FraT7xEzW25a9lflLW/GxgtxFdQY7pAtr8Mb5hugolBI5t1u
 7ECczvkfurNUvDLxmqFl+PeAzxMzAzq0Clpts8XUbmXUUj7IdR3+I+kKyoWXCy4Hixoj
 UXng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiUQHctdb1FGKpvDY+g+qBhtEq/mANA5YNwlZqiC1Q8TlBsrPxxUtn3qYsNPQcmorIMyPgxCU=@lists.denx.de
X-Gm-Message-State: AOJu0YyDMPfi15iQ+xai9sDfjZV18GwR5/r6PtUKWnkoyS+83JkcqaxJ
 XwZlEzV2mWljIJnts3YlZyvH4I0Lbt/lQaGi/nfM0FBx+HlzP4b9NnX5
X-Gm-Gg: AY/fxX5fxBaE2mcAEgrjRQzZiQWJd2le4EknvXNWE7PZRasrZ9rOWZlZgtr8gOAZ0Iw
 KuYY84snGssJYIuOjMI4ml2Yp1GCFn1+37Qc5ah9k/Gx1NOJE2uhBCEkIjGWPlMeo1NEzZyRApK
 gChF7eQDFR5ydHAOldI+yxWguZCUhIw2lJN3mahxKSZUo8fAVDP/lKm8MxeQ2QrLO9mY9L45CoT
 3+uL/T9wfLXnv0H9UGz7nquk1F7YCC0dhGJ1Q0axc6kXRn/URugxzFeEV2N2tqMCvQ2nRH2ALBZ
 t8kozIQo92uJ//zbMHk5MzCdFCP/1VEcIMFD/tHRkXqpw7m5uyc9I7rljvZFBNpHT0rrVa6q684
 rq11RDWTZW9zE8FsR+9UkAHjHehy4We22KH2smLD/Jftnzcx/QwqDuyCpTGUTqba3Odp6sHK3aY
 6Mif6qLg6MfTz5NnHId0DxAmIk
X-Google-Smtp-Source: AGHT+IFiKPgmC8TU8EoytqpRXQAb3w7WHgxLiElstz1v/psJ2bczoLfmCjSVucd+SKBhZ/4MeiyzGA==
X-Received: by 2002:a05:6a21:6da6:b0:366:14b2:30f with SMTP id
 adf61e73a8af0-376aa0ed79fmr26970494637.66.1766950164319; 
 Sun, 28 Dec 2025 11:29:24 -0800 (PST)
Received: from google.com ([2402:7500:499:de94:67e0:3b56:a860:6efc])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7bd602desm24979585a12.21.2025.12.28.11.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 11:29:23 -0800 (PST)
Date: Mon, 29 Dec 2025 03:29:20 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com,
 me@ziyao.cc, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/4] m68k: Add support for M68040 CPU
Message-ID: <aVGFEFCFKsmYIT0b@google.com>
References: <20251226175400.1154417-1-visitorckw@gmail.com>
 <20251226175400.1154417-3-visitorckw@gmail.com>
 <CAFr9PX=JzXVa-HTvV-Cbw3m+kvwYP_7RiG_jE8+WW+KKG59unw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PX=JzXVa-HTvV-Cbw3m+kvwYP_7RiG_jE8+WW+KKG59unw@mail.gmail.com>
X-Mailman-Approved-At: Sun, 28 Dec 2025 22:40:09 +0100
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

Hi Daniel,

On Sun, Dec 28, 2025 at 10:28:59AM +0900, Daniel Palmer wrote:
> Hi Kuan-Wei,
> 
> On Sat, 27 Dec 2025 at 02:54, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > diff --git a/arch/m68k/cpu/m680x0/cpu.c b/arch/m68k/cpu/m680x0/cpu.c
> > new file mode 100644
> > index 00000000000..15e0c30980a
> > --- /dev/null
> > +++ b/arch/m68k/cpu/m680x0/cpu.c
> 
> > +void m68k_virt_init_reserve(ulong base)
> > +{
> 
> > +       /* FIXME: usage of memset() here caused a hang on QEMU m68k virt. */
> > +       for (i = 0; i < sizeof(*gd_ptr); i++)
> > +               p[i] = 0;
> 
> Connecting GDB and single stepping to work out where it is going would
> be helpful.

I did attempt to investigate this using gdb, but unfortunately, the
root cause remains elusive. memset itself appears to execute correctly,
successfully zeroing out the global data. However, using it seems to
trigger a side effect where initcall_run_f() returns (which should not
happen), leading to the hang.

> 
> > +void relocate_code(ulong sp, struct global_data *new_gd, ulong relocaddr)
> > +{
> > +       board_init_r(new_gd, relocaddr);
> > +}
> 
> I have this working so at a later date we can copy/paste that code and
> clean it up.

That sounds great. :)
I look forward to integrating that in the future.

> 
> > +unsigned long timer_read_counter(void) { return 0; }
> 
> Since there is now a goldfish RTC driver upstream
> (drivers/rtc/goldfish_rtc.c) we could take the timer part from my
> version (https://github.com/fifteenhex/u-boot/blob/mc68000/drivers/rtc/goldfish_timer.c)
> and supply a real timer to the board. Right now I think anything that
> uses delays will get stuck constantly reading back 0?

My original plan was to focus on a minimal boot to shell support in
this series and add rtc/timer support later. However, if you prefer to
have them included in this series, I am fine with that.

Since the timer driver is authored by you, I assume I should add
Co-developed-by and Signed-off-by tags with your name to credit you
properly. I wanted to explicitly ask for your permission first.

Also, regarding the tags, would you prefer I send the integrated patch
to you privately for verification before posting v3, or is posting it
directly to the list fine?
> 
> > +void __udelay(unsigned long usec) {}
> 
> Or maybe delays just won't happen?

I confirmed that delays do not occur during the boot to shell sequence.
They would only be triggered if specific commands (like sleep 5) are
executed after booting to shell.

Regards,
Kuan-Wei
