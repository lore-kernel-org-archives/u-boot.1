Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E164EFCD77
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 09:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F2AD83A8C;
	Mon,  9 Mar 2026 10:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="BcX4NImF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D95083BC7; Mon,  9 Mar 2026 10:55:01 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40058839DF
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 10:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so4006954a12.3
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 02:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773050094; cv=none;
 d=google.com; s=arc-20240605;
 b=h9/RIH7aZr6modN3h/hsREjagXZr2QfPjc22zDiTYyoqMUjsmEVZbxWZ0paimmlxZb
 mrOpMHi+d9Pq9xCjmy34oH4GtZysrNUHAn6ZdLibCavP1aqpU9qAeHeP4jVOB7Iqf1Hs
 0dyRmyvXujRmfAgPXXMy67i0v5KYXIxmmDN5ErUZ80a70LxhMxDbSLAMS9vRTcz/TuCD
 C+3MCFA0VflLJzBcMhUpbDOkKWyd758viOAZwo0adiSQw1Qm83XdAIxMLuwu2HZPH8Sg
 59NP6dRy80HGDOopt2qsmG7FxuhsCBbgwz5XQu7CgxjgQDV75D336wnbhRpvJuvKJ/FN
 hpVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RTTtkgvq2dsJoy8MeHZv8MiUsgS6ayEJ+4f+JUw1rs4=;
 fh=mItdqSTowDZ7egH9Xgipm2VlE7NDJH3ClzVOu+9dhEU=;
 b=IBTQHvfSX5sIvPPktYTzvqVbcyXOErvcuXwDFB0ACd4jefmoDk+GGy/k7xdJ3fW0zL
 e9jo0K0TQH3MC8tPUUSQJ+5q+QlCphcTJf9/en5BmmJV6zWivHpl0gszHt4FH84de7w8
 GUXofAt1uYh6167olB7gTEEVGxQcIHLkei+lsdzk94ORsY2Zg9Af6XykTQB11+q72EC2
 9BvBnLfInK/RogBGK9rPS6xO5cufLpCoxoVWY9OsPhNiojthsfQoTkQZxZJxXWs30zlc
 CV8lQU3MkFIqSYNEt92fjiLE7lS/G4nC0+P2im/Alyf/UmMAJ0lgZcSTR0SWoeuowANs
 jtGg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1773050094; x=1773654894; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RTTtkgvq2dsJoy8MeHZv8MiUsgS6ayEJ+4f+JUw1rs4=;
 b=BcX4NImF/9qKLyQnVLgbvxsQcQPMH5wgRruL8ySH4OcpdVMY6d9vuHce4WOO48FKqv
 Q9oa/vHv/W4/lTaHFGJoKQ0Khh4qM6MOgBPUne2bplz0VzOnVCcRiMezl1g1icW26SFd
 hmcirGlXl8+i0jjOF5k9T4C0zQdfI901+XUs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773050094; x=1773654894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTTtkgvq2dsJoy8MeHZv8MiUsgS6ayEJ+4f+JUw1rs4=;
 b=GHHqAftPSqX3cDRFB2XzHIX39ZHJOE0WjVxwZqnskaNNTXapsYiB3Cwc2caIKRDj8O
 GYOMpWXI6zoSC/YFnAB5gtIzp7+zlvRRLieByWhAvToGKop1jFBYuBkbjNCax7PcOqK/
 4gANa6PGsNUHqtE+KScMejJLjzxxrtCUoRwdPyI4SbGaMmqgfaaPeM/dmleVCEn7BZFD
 LPu+EOS/PGHp2zOg6BbJQwl7nSYoC3Cs0Xrvgh+CZJXuR4YX4PXlNxei5iDSorG893jF
 OZlWLJI3AY3lmZl12gjc7FrwB8Cr7UV0Utj4qynBwlcgupiy9/G4InUCROLMYNu+ABLi
 +jig==
X-Gm-Message-State: AOJu0YwfIb9Kunq6mVvuxQGAlbwuM2Q6GE02JF3p0p9wRk92yprCSP5v
 Gw7cxs619apE4eG5V5pXWyhIsV/OoNRDbVsSygUF9eQxb0xL3Ro1lPaxZV3slEuIi09OY0x0bFf
 JRxZm3RIFk7SYYIXpUtehoDWCaqBbtaHtvwDm8j2Ayg==
X-Gm-Gg: ATEYQzxSR5JwG3LKUuJosoisbEY91JA1W6b/mYDQl0GT3n/r5B739H5aAnGIaStn5g9
 NiCb0KfOqpY/dlnEcKmFemGINtwh5plI2SeOi+fJ0CEom0aOTEEZSOuX6YnRzR0usbMRts/eM2R
 2RimS5mSMHFC6oPXz3qc8p3BVBnfGEMBCI35Ace4CWL2ca/Rg3UnMr4/zcN4XD0grMy3N2Ct2aY
 KOEVb/ZQsfNvr0sp9bnT3Rk/7UN9PB9W+DWPV9nUigIm9Qs3XatCwzZ0hSLVGhHTxEKfpnG+cYw
 k3zfG1T7tA==
X-Received: by 2002:a05:6a21:b89:b0:38d:f084:e349 with SMTP id
 adf61e73a8af0-398590b6252mr9523257637.54.1773050094325; Mon, 09 Mar 2026
 02:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260309023234.640209-1-daniel@0x0f.com>
 <aa6OgiIKC2Z6Hwv0@google.com>
In-Reply-To: <aa6OgiIKC2Z6Hwv0@google.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Mon, 9 Mar 2026 18:54:43 +0900
X-Gm-Features: AaiRm52qXejG9I1m0S1JH4GVlkeoSAi7Uj4jtLy49nBDwdbNPb185SdFk3UrUfY
Message-ID: <CAFr9PXkm_xnOofiya8e7n8Ywuwm6Pwhhj_Luq+LpckMpCr5GqQ@mail.gmail.com>
Subject: Re: [PATCH] serial: goldfish: Add DEBUG_UART support
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Kuan-Wei,

On Mon, 9 Mar 2026 at 18:10, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> I think we should also call debug_uart_init() in qemu-m68k.c. This way,
> the <debug_uart> string will be properly printed when the
> CONFIG_DEBUG_UART_ANNOUNCE option is enabled.

I looked up the other callers to debug_uart_init() and it looks like a
lot of them are in the start.S for the arch.
Maybe it should be added to arch/m68k/cpu/m680x0/start.S?

> > +     void *base = (void *)CONFIG_DEBUG_UART_BASE;
>
> It might be better to use CONFIG_VAL(DEBUG_UART_BASE) here to keep it
> robust for potential future SPL/TPL builds.
>
> Also, since this is a mmio register, I think casting to void __iomem *
> would be more appropriate.

Noted. I'll fix that up.

Cheers,

Daniel
