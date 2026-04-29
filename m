Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD48FF885A
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 01:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6051584682;
	Wed, 29 Apr 2026 03:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e/jUgUGK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF15784682; Wed, 29 Apr 2026 03:01:16 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 274578466C
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 03:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6729c6f0ca7so14749592a12.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 18:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777424473; cv=none;
 d=google.com; s=arc-20240605;
 b=QjoghLiWedFWIqqvgyvfEugUitY3/mUgQ70uHvVFvbAeScTmFSbrCStzCNkQ3lCHoR
 zhA0ALm02AcWqisw3dDPDmRnlW97AdkN0EDxIXUgrpjQdVg+h4utxx4NVccPqlYyYDnV
 LsjMF9aRZpF75Mc9jXDJV/AeiaQrRt3VtwyGme2sh7cPWTpDNojiuzdCOZGlSyjDDxLw
 zUvucujsO+p4ycA1To1NZsCDdl/BL/lKXN0nSFkkFc/Kl8wua1/3OHvBneZDqilzIG05
 YWvzKpyjDEkrzzX0LgDxFFTa0y5qb+uRUrTMMCIpFcvzs5C0OegTwnKAbQ0evuddj7wS
 bHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1ixhyikA8JOXG2g67NgNQjdwr+4xIcpnZOyTHehfRLQ=;
 fh=u8f5vW+OC+LiD93U2lU1GpD1tRthT/4059lallvfePY=;
 b=Fg/AhDQAEGTT8VIrHG2rf52fid2TEYG6OAE9Uvl7DnR+ZWKNPmSRURbH7CvJdw1GUT
 ywVT8wZ0vmB7s0CHLCpn/TACKKBxqJFOATpvLeVHGsh4WDYOtIaBd2cgRMCkFnXvPepi
 xyQbzWzvhfv4DF4UvuC+q3hwZ9SPPD1PfQc/IiHucVlrsl4vaRoC3sA3mlCy5ucE+aGZ
 Ivqm1FjcH15J3OTAKVMbQgJgPGQ+rJlverbboYJQ5UI99+H5tiCAd8PmYEBvF2tVh17F
 dZR1kJRJ8lc0M2aZe36kM5b6LS5RmVyrgVntvFN4mGN61yHq27KhfGRGuoYmJ3PuJ2CC
 ntlQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777424473; x=1778029273; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1ixhyikA8JOXG2g67NgNQjdwr+4xIcpnZOyTHehfRLQ=;
 b=e/jUgUGK92jBlM6DwzUn387iGYMRtx45DvtYv0QGFoMc8cyEov5o9S6iyV6QtaJMzB
 Od+5NoZ+w5jeOE8UVk2NvEu6UzURrvwSmpsQaALKYG8cHiNquqXNhS48SG1ReDYgB8ve
 2kGwnbt5dJMxCCWnlOzPXioLyLcOLwUCEL9VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777424473; x=1778029273;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ixhyikA8JOXG2g67NgNQjdwr+4xIcpnZOyTHehfRLQ=;
 b=aS3jM16XnA9liEWv/tyWTxJ8ya95KRr4mdCSAn9S4m1NYTl/307S30DVs5lekPCfc3
 XiciR6vufAd6W/jOQJrjRgOh4rpz7+wOUx3ueWZS2Begc7Z80OZsGxRtE0Wf+wSfIX0n
 4rem6ey1yo3m0XHQMJG4KO4DLroLUhkKanB75uFHaasRV0HFAmRMgcC1B04K7f/DONKc
 L8202h9twu2sCdtp0ougBItyiVEj0NsOIXaMi3Rt2N6B2NP6s1KhYXEQ4fBkRRw3SYay
 /+uRBg0IsuV15q+MHaNBWC9iTPUrRQOfIWoxdboCU7kcEKalYsSQ0g/FBZ/zek2o1Y8L
 ipqA==
X-Gm-Message-State: AOJu0Yx43b2EoO9uYOgyfvOH9ss1ht8hhpcj13+HvkTQwJ+8JZ//8k58
 q12SG276qBkhKTVEo3PwICQCr1eN9akUZ6bRUr4qOGs7C89WhdYui0Rp1NPyAfbJZOaTL4C9rbG
 Xduy74GsLQasQpIbbKhwtNCyqbc9Uqburx1uIrVvD
X-Gm-Gg: AeBDievh9rMadl1+VLYkPfSm7fc1G6o+x940Crd5hH4kjw0h6clCO+IF/GqhVyD9XEC
 LE2kyClJigThRa9wKRehgJsOxRL3WljHtuK5QI/gI8T4IANhzszGWmUZmbqaGPtTHjm8kRI1Y3X
 N1RCGYv+tZMw/OmhE+Sdl74HhNx77B5SAubLdJvS7y+fqsBGKUTNIBQyGIgYCii7jm9ipEWhRTo
 6N0cnV7OvKgFiBUNiAyuT6f1IxTRU/QIU4nCm66ifVPRzNvwqpziHYgQe/BJ06DjG04z+/MOy4/
 312kHHCFjV/Kakqg
X-Received: by 2002:a17:907:cb29:b0:bad:ab6:450 with SMTP id
 a640c23a62f3a-bb93c4aaff5mr66093566b.3.1777424473501; Tue, 28 Apr 2026
 18:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260423-rk35-cnt-freq-v1-1-8f07677be5ca@cherry.de>
In-Reply-To: <20260423-rk35-cnt-freq-v1-1-8f07677be5ca@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 19:00:59 -0600
X-Gm-Features: AVHnY4K64LgQB9iISRqqh1cT3q-ZyU6ytp11DIHmedDRJqbDnaJxsyohndIcMVY
Message-ID: <CAFLszTgPv2eCq_iTHfyHE3quQY8gfX30Pn4zFz-DV-Gajo7wNQ@mail.gmail.com>
Subject: Re: [PATCH] rockchip: fix asm-operand-widths clang warning
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>
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

On 2026-04-23T14:05:13, Quentin Schulz <foss+uboot@0leil.net> wrote:
> rockchip: fix asm-operand-widths clang warning
>
> CONFIG_COUNTER_FREQUENCY is currently 24000000 for all SoCs, meaning it
> fits in a 32b type. For 64b SoCs, it's an issue since the registers are
> 64b.
>
> clang complains that we're trying to fit a 32b value into a 64b
> register:
>
> arch/arm/mach-rockchip/rk3528/rk3528.c:98:45: error: value size does not match register size specified by the constraint and modifier [-Werror,-Wasm-operand-widths]
>    98 |         asm volatile("msr cntfrq_el0, %0" : : 'r' (CONFIG_COUNTER_FREQUENCY));
>       |                                                    ^
> include/generated/autoconf.h:372:34: note: expanded from macro 'CONFIG_COUNTER_FREQUENCY'
>   372 | #define CONFIG_COUNTER_FREQUENCY 24000000
>       |                                  ^
> /home/qschulz/work/upstream/u-boot/arch/arm/mach-rockchip/rk3528/rk3528.c:98:32: note: use constraint modifier 'w'
>    98 |         asm volatile("msr cntfrq_el0, %0" : : 'r' (CONFIG_COUNTER_FREQUENCY));
>       |                                       ^~
>       |                                       %w0
>
> Even though cntfrq_el0[1] is only using the 32b LSB of its 64b, use the
> 'x' operand modifier[2] to force the value to be 64b and fix the
> warning.
>
> [1] https://developer.arm.com/documentation/ddi0601/2026-03/AArch64-Registers/CNTFRQ-EL0--Counter-timer-Frequency-Register?lang=en
> [2] https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#AArch64-Operand-Modifiers
>
> Suggested-by: Mark Kettenis <mark.kettenis@xs4all.nl>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> arch/arm/mach-rockchip/rk3528/rk3528.c | 2 +-
>  arch/arm/mach-rockchip/rk3576/rk3576.c | 2 +-
>  arch/arm/mach-rockchip/rk3588/rk3588.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
