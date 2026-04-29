Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9482FF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 05:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AB42846CB;
	Wed, 29 Apr 2026 07:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="otUhdbgL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81119846D2; Wed, 29 Apr 2026 07:04:56 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8331846C3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-65890a6ca20so3348832d50.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 22:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777439091; cv=none;
 d=google.com; s=arc-20240605;
 b=W8EYHYymPEfCGB9mAD7TbOHmGBcnJLtN4gEFrlKyV2ZxeseGKe7nAcqHHDjuWs99A8
 hzPdAzCebFOhbXY4ytcnfEarTBV2f5GVD9rK6sEACcrgLaf21pvcHFvpBGUCDR5SeloF
 tQ2U8TXmfIMBNPXdRKP0EcXoCKCWqbpKurTI5ji8II3JbH8TjF+6rxz4CPWPP8slzu2c
 UJWdyuPHNAqDEM7I9qXNmNG6lAa0lbLiTsrw0AwkVpJJtAWM5TnuxeR2hQcNpMzrGsRx
 BNrU6n4MBuPHmhCA6ePOGik4xT4VIo1AOT0hXaJ6vOx/axnDC+M5TFcpH6Nt6Wl6NfY7
 vqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8DEJKeQHnrjdLQVh2ii0HTN4k3m29MwqF/9i7iI3oR4=;
 fh=RdGkvKMvuRusWJvZUna/mKxw9cwzaobPq8+52GVNl1g=;
 b=hoqevAaXakFcerxXipEsdqirVxpBZxaPI01lyc1rEramtlmSoKPsU/yFwFGGfhVnDk
 AsmUQleOPaOUtfZoVEBwc2JeIFR+rAC1ltY6mGWrrKFN4mSDxY4BencXB/ksTE0HfmdQ
 15jvzopd8TPCpyxiHNir3ReNv3q3fJeDCiqX7qNrvi8D2PS3IFmp5TbsHjZoXgXqkxmx
 YFiZ/YcciH8ttCE+i6c6wPsQZA4jOScVVAQ5n9Qu+pd9baRKmKN0h+UMi1+fkIFFLDHT
 RES9QMSu2ZcmcbBSWyVI7nSM5NvFSGS8mWIycfbLTY7aQYUBUky7RUl48SmSpz8mOQ9L
 hzlQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777439091; x=1778043891; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DEJKeQHnrjdLQVh2ii0HTN4k3m29MwqF/9i7iI3oR4=;
 b=otUhdbgLRHdPdYR+eNFJrvPYdhFbF2ki1d6MQzjeBU47HR/aQQ/moy4853/h3g6elx
 Itze1WR9wJCN5bu+iCHHX6LtL17k3ZO1y1RtzpogfWZokiF2h814UKweQhZtgf80260i
 aotgl4PbyNdpZKyaBeGeTwH6K3+VvD1m6aG8oQOVOtMzzA7XxtTKBI53OZlqTexD+FzN
 Xab35BAHRRUkkmV7eLLL7SAapaRgLG6J02sFKqTvKAK6x3SreFYm0QV3eEG47vQjEZ7p
 0DxsnaVCSuwP4TCLqhzHJUmrLJ/U50AZp0a6tGy6SJJ8DHU2DClbVhyNtxCFBq5qSr+Y
 0K8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777439091; x=1778043891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8DEJKeQHnrjdLQVh2ii0HTN4k3m29MwqF/9i7iI3oR4=;
 b=LLfFY1PTMcj5IDYjljbzVqd/zC0FBuA+3wQY0Th7BcA3h4ijuJCxUNs82HX9leG/+v
 92scw64oMxTfog/6kG/F2HufMr6ZbsU26C9B0c6a52eJvGpUiLUxMM+4JchCmON1GH0U
 EKWSJMzhpylLtO8Q2lE0Iy8FoB7a584AiEuXB6qd7nPJwJ6UAxjU2yo/1/VQ4jb8RGFM
 SJ1eQVNgJ40iSB0bg66rAptXKkTevs/gSxrL43SDjAiZx1GENqTShNqXSBjfcXoImwAS
 sBoFDikwbR31dSWSaHF2vIeTVSA394P1b3uaSYp/c06pzMC3xfWg/nd0nqSW2nfP7uPV
 TNxQ==
X-Gm-Message-State: AOJu0Yx8SqKOZQBS2OR6uSEm7/oaLZ5v81xygybinI85j4ZIiLs/Dkb1
 20eQ18jeC1K2oY3zYSoXsR9f8w3HDKKmaJXvHgV6Yv9xutG+Nk7kuvOYKJ/ISATu3k48HS5KXDb
 JRtC37FV+jxK+kuy/Gnm2SQSEGIS1cfAj/+DblmTTMQ==
X-Gm-Gg: AeBDiesTpyEArO8b6M6xczhSnMtlFw548C6oi7FoAJ+52PfQm9OQT4X+rlm2CwyYbaL
 ksiQxX7Tn+/SuDsMC7o0nYwddzBf5L4c8iAYUaCqrss3N9ytzBHC3eokimx4koiCY6c3cSKYVjm
 sU01A99pimJDLqJ+nRh4HUdKJJVi5aU+ZB2kTl2v33xE4qqsEmvzbphZCH62TIuckEf7D9XaYfK
 VsrJIjviu/ejrn57cUZFviDMzlpScB+/Q9MRAWoWzmTdqoJ2Fc3P+bP4ALQjpsl6DHRWv2cZxw7
 BZyh/ISyFigJnsnY/7kH0hIxM7+ZkHzqtF09+cFWARvnn4kPMEvr1EMxCF9vlfTUQTF+R/7DNMk
 YseCYDqtTE22MS/5OVsmBjO61p8gnQjmOVFfalfzT88wqS/shZHz6CBuFoKTolgkTuvCtM6y5MK
 T5AvEJWSInleif95VXY4VuAP2/fipkZp86v3Qy+gQYHV0VsAcGLGxP4R0NlsGZWs+aAmO9toD4J
 bZlSf16k9uH+LBdzqJAZbRettG7sZGSKjsk5wIhb5ATyeKJVPH9huoJxxR9aYZe7Q/VpWSb4DcM
 eX+faUQk5+TExN4XD3MEz6itjeqWehOspxi8U9a/zE6fkr4MNFfqPMNW4gtxjaQxtfyzLI7a79s
 AzshCexHYsogA/1d9
X-Received: by 2002:a05:690e:448:b0:651:b234:87a1 with SMTP id
 956f58d0204a3-65bfb880546mr2014856d50.58.1777439091280; Tue, 28 Apr 2026
 22:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260427100832.581887-1-ilias.apalodimas@linaro.org>
 <CAFLszTj2hm=bGA6N==mt5pC2iyWMdj2q1A1zqPfx7OnMhNYAyw@mail.gmail.com>
In-Reply-To: <CAFLszTj2hm=bGA6N==mt5pC2iyWMdj2q1A1zqPfx7OnMhNYAyw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 29 Apr 2026 08:04:15 +0300
X-Gm-Features: AVHnY4I07VzfqC0VZJcomcvc4d4kZ_LFPFEaGVKwx6bylq0FjYmjPAdv2KYnE18
Message-ID: <CAC_iWjLUXLHyvuiCpepg7=YZNdoHs8_JJ4sbQTUbqD4aejRVTw@mail.gmail.com>
Subject: Re: [v3,0/6] Relocate U-Boot in the last bank
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 28 Apr 2026 at 20:49, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On 2026-04-27T10:08:21, Ilias Apalodimas <ilias.apalodimas@linaro.org> wr=
ote:
>
> > # RELOCATE_LAST_BANK not set
> > # RELOCATE_LAST_BANK enabled
>
> The Kconfig symbol added in patch #6 is RELOC_ADDR_TOP, not
> RELOCATE_LAST_BANK. Please can you update the cover letter and the
> bdinfo annotations to match.

Sure

>
> > Patch #2 - Introduce fdtdec_setup_mem_ram_top() from Marek
>
> fdtdec_setup_mem_ram_top() is added in patch 2 with a docstring saying
> it should be called from board_get_usable_ram_top(), but nothing in
> the series calls it - I think you should convert at least one
> board_get_usable_ram_top() to use it.

I can try to add qemu, which is the usual safe choice.

>
> Patch #6 moves dram_init_banksize() much earlier in initcall_run_f() =E2=
=80=94
> before setup_ram_config() and setup_dest_addr(), rather than after the
> reservations. That is a significant ordering change for every board
> with a custom dram_init_banksize(), and it is unconditional (not gated
> on RELOC_ADDR_TOP). Please mention it in the cover so reviewers of
> board-specific code know to look. The Tested-by tags only cover a
> couple of platforms.

I went through enough of the platforms, but didn't spot any place this
could cause a problem. I'll mention it regardless

>
> There is no doc/ update for RELOC_ADDR_TOP. Given the 32-bit DMA
> hazard, a short note in doc/develop/ explaining when to enable it
> would help platform maintainers.

Sure

>
> Is there any way to test this logic? We could perhaps have a sandbox
> test which tries the various combinations of RAM banks and calls
> functions to see what happens.

It depends on how sandbox initializes from dram_init_banksize(). We
can certianly test it with QEMU, by passing different memory layouts
and DTs with reserved nodes.
TBH I was trying to get this in for 2026.07, but since it's changing
the boot process a lot, I'll aim for -next and see if i can add a
test.

Thanks
/Ilias
>
> Regards,
> Simon
