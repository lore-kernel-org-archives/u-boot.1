Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72830C44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 14:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3ED6D40874;
	Wed, 22 Jul 2026 14:37:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6wl9kpc4Swmf; Wed, 22 Jul 2026 14:37:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F25784080A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784731045;
	bh=+7RZ+1wfM/brkPLOVqxrRKEjVikVqlx2ieog8rJH9vc=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=lGpEQgU+3HgiehcH+/ATSzf1fim9u1Be5OnnS7EJ1g8oNwqZ9l1elwsR1og0kLGRu
	 rho/EeefiieToM+JF9rcpqBG3hz8BsRHs72VQHa/JtguWU9qiVrCuZpkQclM60Amvb
	 exNCn6qSYILWn8txRfZR2j2r4kqWz8VqHBeQhquE48x3qe7RRI9P94NqrTypcJ/4i7
	 66E4Bb+PDozFA853IYbayQfLCI+nmdWL7wEsfXeFTn/j6nwBc8/wuSsT/jh6SPEH0n
	 RXaCdqIhv0q5t7kZCoSlnuercdjkY8InVJ5o6w5QZGsH9ioTVNRb52HtD0RnDocMqt
	 j0y0tU7Hbj/Rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F25784080A;
	Wed, 22 Jul 2026 14:37:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E65B21093
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC58180EE3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:37:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KJ547FmxkWgn for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 14:37:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9085D80DF5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9085D80DF5
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9085D80DF5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:37:22 +0000 (UTC)
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-664b05d408bso7744276d50.1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:37:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784731041; cv=none;
 d=google.com; s=arc-20260327;
 b=oIGhrFQ5OeRN7n0eyJXh4x3hKwy37QPWHcVDzw7zI0pfFO+PwesOziohqKJgSqL4C3
 XCf2XaC3t5BzWamT10Gacaa17P9cLg/K3XqdTcbuGBC7AVxMSHllu7fR60toGJqtF6Hg
 DTKH8UN8oJ436QROzHDB1K/ntq0B4dBd+tG4xk9hlxOOCNAes9VfUsDjLWgO4W+pIYj7
 jqN3ilrbhHlHXdlr53soQr8v8lqsRekfBPZBtai9azuMYPXdMvT/eIr3yVOmPh66ym9t
 SBwW7j8UQV9J+qrHjV2o/zMAVSu2VF9N6uA0WrgXu01+RXwMiqk4F6gNU2LL7ncCo7wb
 zdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+7RZ+1wfM/brkPLOVqxrRKEjVikVqlx2ieog8rJH9vc=;
 fh=dXa71YXaXpwCBpWBW+Ra9xICtkZVYT7LFunCrKmVkig=;
 b=nYP2nhlDECYsOSpgbkZGmy1z9Geuo0GeASxv/vaRhRIp6jKTpgprF/8lyInvhyrrzg
 6AVAQTKnNSbmdH8/hcTFZICZImfP/1wtZA1vWIHP+5UwToXUSg1GL8c2MLPyjFkXg+o2
 nbwjHSPhBKnKqPNn83LlRLpMrSelOm90vM6oLk+kuGZhQRB4sNovBCQoBAjjSL5fXodC
 q15MlDeCXyOmeYDTeC9HCjCNv4y3EAYmLwxFrtIoNR0fbD1AmJABPN3z5NEscjX4860q
 WQnhxlxS8fK2+RK0cM2NKtCfjRY8VimiZ57/O1CAkGtlV4UCo5DP9l7DmBBI4kxAn1lk
 i8EQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784731041; x=1785335841;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+7RZ+1wfM/brkPLOVqxrRKEjVikVqlx2ieog8rJH9vc=;
 b=EdF5NuWo5yox+6Wm3Uf98yYKfhG8TFcMEXGlm5hQY2czjgq9IEIKTnSydvcwdkEWqB
 KBLI2sLc4WCHHh7/Tqpi9kgtGp+iogiRYLJgdiMGmSkwiSs7qcrhviUY6Baa3HPoYb9T
 4ch+awNKlhvEIZpb2DHeH0jJkoizpVWwl6/F7C1MpxKWt/7dmzgSSli3i8JVqVf1jgAU
 IVPg8CPlkMS6sWYYL813XGPvVyxI0FvJjC2HJo/Rrg+NtNUDw9y0SyLZ8YoWLfm1yYcs
 sMARX0JX/E+6O3a9APZo40kxR1CFGaCh9mZo4r1cEFMQbyHvaJClR9jCU3yU31bQ/1CW
 fHfw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqteRlLeb25BGkvAwi7fGZL/T9Xkdw8rMbBVgp7i1dPC7QBjX/MAws1zhluEcYNafDkMKXxdvE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YykS+lUQi5Jc4sWOxyzaLQhMPPrtJ3C/BIvxXB86uiyrdlAM9h3
 It5XLjMdxIAVI2Cavp0+UiREPUwCM1GxPayD9wzZG4l+zsBT2uTl2NBVXlY0xwoeNxpJSnWwqau
 ESBsXANggWnawcwncy4EO4RkH7OaII2EE076lLdQ+6w==
X-Gm-Gg: AR+sD11MG4grqrJu+rTgygC0anrhTlkYUof6WniscDgEs4STQonedd5w45sB/BGXepw
 ttxN6IAOQIbCCE9Gc5iZdaw4MpvfvdnxwXf3v8woE0nI9hl0YZqnCALAl0dv+qVUyVAz7ALyEA4
 aZPEg6wrpWeEOCwZCVLljAYoOyf2BbPCEhHY/viL+MKTFU5VrZql/iPC3ilIE2s35fpOAR++LdB
 MfL3CJJV7apGpWksJ8v/nAwV33MN3RjiAPTYvnJcPZXS8H+hM8/1nRFawRf+hMoZOd+51A/p19V
 LvePaJkjBCYQPEhg
X-Received: by 2002:a05:690e:b4c:b0:664:ae6a:ef2 with SMTP id
 956f58d0204a3-668574aaademr4652738d50.80.1784731041191; Wed, 22 Jul 2026
 07:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
 <CAFLszTinPhEH9nCMV8u8SwMf9UJ5AG0z68En7+-T3e3RxpB6VA@mail.gmail.com>
In-Reply-To: <CAFLszTinPhEH9nCMV8u8SwMf9UJ5AG0z68En7+-T3e3RxpB6VA@mail.gmail.com>
Date: Wed, 22 Jul 2026 09:37:09 -0500
X-Gm-Features: AUfX_mwSzXCTFYrV_Ov1H2xkyErRipzm_4EUIu_XoNAJ5qoSvMtgzUGuTkrdk8E
Message-ID: <CAEev2e8Mg2WReESLq4PDhiph9t9Bv8-Gsfx-WDcU9kfgAkfyYg@mail.gmail.com>
Subject: Re: [0/8] Misc Fixes for VGA BIOS Emulation
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1784731041; x=1785335841;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+7RZ+1wfM/brkPLOVqxrRKEjVikVqlx2ieog8rJH9vc=;
 b=dFzXncgEjBqXzL0PL8xwlRJEluKf+zOlx0ZShYj6yiKkfspmZMQ0XDuP27qEn8IWTA
 Op137Edpdo2rilIa3P5AeQ4tJv6wfqVcZ9GjVkw+TFJ1rqmVM/UUy4UAc0DkdvoUhFkr
 f72nlCZHcJhTeYLayHA4AVmQ6Vsh5TrpvFXV7xgw58toHvysoP8ySD3mXoksTPjJ8tGT
 UnUveMM85jqj+UwC/b7Wak2Kz2VTG5sIKeXU89fM72DJW5R6onV/zMDc32zonobxQqG1
 UBqS42uIr38SOlMjONocVXST18W0xvxXgjjOpsU3ZEmvOBoNCsz2MiQzyUEpX+s6g6rD
 xS/A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.tenstorrent.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=dFzXncgE
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Anirudh Srinivasan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,

On Mon, Jul 20, 2026 at 1:17=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Anirudh,
>
> On 2026-07-19T18:03:31, Anirudh Srinivasan
> <asrinivasan@oss.tenstorrent.com> wrote:
>
> > Patches 1-5 contain misc fixes to drivers/bios_emulator that are
> > suitable for upstream. I would like to get these reviewed and merged in
> > if possible.
> >
> > Patches 6, 7, 8 are an implementation of how I got u-boot to actually
> > talk to to the Aspeed VGA card.
>
> Thanks for looking at this. Please can you split this into two
> submissions? Patches 1-5 stand on their own; mixing them with the
> NOT-FOR-UPSTREAM material makes it awkward to pick up what is ready.
> Send the RFC portion as its own series marked [RFC] in the subject.

Thank you for your feedback on this series. I will polish it up based
on your feedback and send something over for the first 5 patches next
week.

>
> On the design: I suspect the right shape is a driver-specific hook
> rather than open-coding Aspeed knowledge inside drivers/bios_emulator.
> The emulator should stay generic and call out to the video driver (or
> a small ops table) to translate an I/O port access into whatever the
> card needs - MMIO on BAR2 here, real I/O on x86. See comment on patch
> 7.

Yes, I was thinking of something like this too, but wasn't sure what
kind of hooks/routing other VBIOSes might need. I'll see if I can try
out an AMD card with this approach.

>
> > This series contains a bunch of mischallaneous fixes to the BIOSEMU
> > codebase
>
> miscellaneous - also I noticed  'to to' and 'There some checkpatch warnin=
gs'.
>
> For upstream this will need a doc/ entry (which board, which
> defconfig, what to expect) and ideally test coverage. The QEMU RISC-V
> enablement in patch 8 is a nice way to make that reproducible - please
> consider keeping it so it can run in CI.

This setup requires you to have a PCIe VGA card and run a qemu VM with
pcie passthrough (or a board with working PCIe in upstream u-boot).
This isn't easily testable in CI, right? The doc/ entry would also
become super specific to the setup I am currently using.
What do you suggest I do here? Should I just document my specific
setup and add another defconfig with these Kconfig options? I was
thinking that we shouldn't add bloat to the existing
qemu-riscv64_smode_defconfig.

>
> Regards,
> Simon
