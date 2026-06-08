Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4162CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81D9E84154;
	Mon,  8 Jun 2026 09:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wDJ0v/7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B9788466E; Mon,  8 Jun 2026 09:47:40 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D02CB83FEC
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 09:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-660512d80b4so4335596d50.1
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 00:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780904857; cv=none;
 d=google.com; s=arc-20240605;
 b=FY64xhWoNRlvO31fAu8xvM0apf0DFtkPhlAsG2tw+3YKmkiXoVz1xLaobkDpd8ZUwY
 ro/poNNFqEg2HjQN5qgU8bsKL5JxAF9/0D/0P1d88vvHryOPJ2jT3cUj4Y37hH5jAejb
 ilqC0fPNIfXm+3bhMt21H54ogCegDp6ZAf8w8kODg27/JnjEhvuRhNgUchMTD+isVsrS
 QJTPHMJtNrxnyAB3LjiVl2J6UPYF81Lzc+gisY1KNCERRzsqpZciX7E6GtnnhLvTXRnm
 aowKMWNg2En7nM82cLEgyEdrGMS3VKJTCiuNun/D2VWhjwCDKD2Zb51DFs8lKZvZJabQ
 Yu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z8LN4dj7vSjt7hTKZc2JDA/siO0OHDM6xMB4EFlwics=;
 fh=abU3vlk+UvvzRFEfjexdPApU5K06mJwT3WMVC226LCo=;
 b=WHWrWOrkh7zrwV0C09tZMqsLPYv97Sp0Gb6JSUxJrUswkFSmeYPvlDI5e6pP6rlSpO
 4Wt4h5m0O4fwJDkE1Xw7Swc7guv6KzSOthcZWq4V32fu4fg8tiEHXGVl/jPSSHvL/CDb
 1L9WM5HTBkvX0Iwtx9EX9q24QPYGEcE4rDy8o6sCP0qhPKCtZn2nqizvkuJ72UgARvOT
 D3tIH6ZRXacpt7ulf0m5PcfoTcZBZOUCwVbQXx7jXaQ+FV6unhI2y5oGmtv0EWOImVNX
 vj4ghaiapPHfshL7PL21jon4+KpKBc+HclTxiwNa35W+Aq1hJlTHxHO7ZmD2EA7xMCta
 CEPQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780904856; x=1781509656; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z8LN4dj7vSjt7hTKZc2JDA/siO0OHDM6xMB4EFlwics=;
 b=wDJ0v/7pSgNkQu2ya8CdUtCsObVaGgtyphTla/gnEupke5lvAzPqWPShQw5uHWWTQ0
 rjIfyxo+MqS0s+6k7pU0OjULzu2WxLFMKW8XflahjAx7ZtUem+lnduE6fazaIu8drIh3
 bLVl14I7GO345DGHv5YTfKw52L71zaL3/LLhxU8M8/Q6kC9Q+buuNGIjsN2Muum7jUgL
 syPjSX9cZ97a1goJZ4yjubpXg3zSYAo17Lz4/+y8Ztc2Ynt9ZueM4zQ+CoXJAdCfp3Fb
 p2/qhWeDjh9tg987eg0c/XElaD3k4CdMe2JgsovV9KhGkCdqlMaIDw3kElEAJN0E6rNy
 /xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780904857; x=1781509657;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8LN4dj7vSjt7hTKZc2JDA/siO0OHDM6xMB4EFlwics=;
 b=UEnrHhXpBRhTRd0hgKKqbX4KRCU0D52kztwWTG00BOaZeroId73jrtOk5XXZM5qALN
 D7vw90pZ3d24XtLSbGR0ARcrgcyNabLglt9BMSP1jhM2R/+Y2JQcag9kx/v4hCR3ZTke
 BdpB9899pQHAH5g5hLCuwSgp/Y1x+Ezwf1NzKZkk3iqlKV7foPks3moQl3ird+w0YCfo
 am3iV6n1A/60UQt8RyNlRx2FHrS4NBikiosyyQiQCEovFJyV86ZncqYoen9xvieQ1pjp
 W8LUW185vLmZQdOdlraIdprHr0vYaNPxXLW3Kfy+iLAwa+NAq4d55aonWpJvxJlDWKOj
 C+ow==
X-Gm-Message-State: AOJu0YwAJxRTa4+K1StbNile+jW31nlyKWYaFHspdCAYkJUaPM9DxnvZ
 lUJ1AYHHJQ5fNxPbs4erMy0OmmtGLXJs0gCV1o5iOkjF+mIBEOV+M9u5kzJfIkM1TjXPEf2es5E
 /yOlohHHzWe9pv+HeypTkjs234Vk60CbTfHh2JzRsyw==
X-Gm-Gg: Acq92OELs0lh498nRs4qOb07nWz7sPukknmRlE6Ml0ea4HTyHXWbOYPVy6pI4bhb58z
 2vOPifiBnBzls+qSQdEsSF4w9NvjqFlxR2yoOO2QGULN3Pgbg5rFwS/6gMuxgSEnVZX/Nt9kr5Y
 he+6ZLWOEhDhGGtB5/vGjUftE3q/VF4X5rRlVnFgXrj3M4rCZK4l1Sk7N2xhT/ajr1o6pBfaFgA
 kH2aCuBbDnx58iovDLCjPCS4+crGaJxdbs0BatQ6uT8PUf3+osy4y7t4K/3XV6ZrY/jpLZWC7vC
 0J3ANE+59JdSGoXKQdw8mhLrFT91mYOuIhwxTF7jIoaP2XE3krTPWJUCk3u6F1QWJCxH9joMPXm
 FyuB8Hk2Y7dnMNYohR8oorKjLpEFwM8mVosYIg3HrvfGntODO9c6oqwhCfdDBZ2e7NMXhn6Dy7T
 MX0L+N5sgYIc8v5E6wlFsGB43ZOMg5cicIo0GLpW6WTx0Zr9HCxpMDDUnktvdltiPfB80Z3IDQ5
 lfc7gCyjVdGHzxFg9QwatvgPQzc00RnEGfnNr6BkL4IGjvQELH20D3Ml2z4EnMXi6GSr5KsAY3D
 7iYBiDx1RqE6DZx3xQIOH8qSogVNXhpeNsgVqrWYWPWZCyxsu9WVBFt5IuhJpGwjUqsaEQzGj/7
 lyp9oYnOIzYMi6TOE
X-Received: by 2002:a05:690e:1905:b0:660:a652:2913 with SMTP id
 956f58d0204a3-6610a60c2camr8823697d50.3.1780904856603; Mon, 08 Jun 2026
 00:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260607230519.3022520-1-sjg@chromium.org>
 <20260607230519.3022520-4-sjg@chromium.org>
In-Reply-To: <20260607230519.3022520-4-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 8 Jun 2026 10:47:00 +0300
X-Gm-Features: AVVi8CccZ4VMX9SIBln4jR8AJ3IXzgfnTTCs2MZYqjCS6spkXdxPeqov09QihMo
Message-ID: <CAC_iWjJXQE8V18qQPSfFZ3eQMmXyqgd_E7zYwP=RjCtfJNcNTg@mail.gmail.com>
Subject: Re: [PATCH 3/5] x86: edison: Align U-Boot via binman to fix the boot
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Mon, 8 Jun 2026 at 02:05, Simon Glass <sjg@chromium.org> wrote:
>
> The mask ROM loads the OS image to 0x01100000 but enters it at
> 0x01101000, so U-Boot must sit 0x1000 (4KB) into the loaded image. This
> was arranged by board/intel/edison/config.mk, which prepended 4096 zero
> bytes to u-boot.bin through an 'INPUTS-y += u-boot-align.bin' rule whose
> recipe moved its output back over u-boot.bin.
>
> Commit bd3f9ee679b4 ("kbuild: Bump the build system to 6.1") stopped
> that rule from running, so u-boot.bin no longer gains the 4KB prefix.
> The mask ROM then jumps 4KB into U-Boot's code and the board never
> starts, sitting in BootROM download mode (DnX) and cycling.
>
> Since the Edison image is assembled by binman, provide the gap there
> instead: pad with a 'fill' of 4096 zero bytes ahead of the u-boot entry.
> Drop the now-redundant alignment hack from the board config.mk.

If this was missed during the kbuild update, why don't we reapply the
fix there and make binman a requirement for it?

Thanks
/Ilias
>
> Fixes: bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  arch/x86/dts/edison.dts      | 11 ++++++++++-
>  board/intel/edison/config.mk | 10 ----------
>  2 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/dts/edison.dts b/arch/x86/dts/edison.dts
> index 9c7630161e9..05391d49d02 100644
> --- a/arch/x86/dts/edison.dts
> +++ b/arch/x86/dts/edison.dts
> @@ -175,8 +175,17 @@
>                 intel-osip {
>                 };
>
> +               /*
> +                * The OSII loads the image to 0x01100000 but enters it at
> +                * 0x01101000, so U-Boot must sit 0x1000 (4KB) into the loaded
> +                * data. Pad with zeroes ahead of U-Boot to provide that gap.
> +                */
> +               fill {
> +                       size = <0x1000>;
> +                       fill-byte = [00];
> +               };
> +
>                 u-boot {
> -                       offset = <0x200>;
>                 };
>
>                 u-boot-env {
> diff --git a/board/intel/edison/config.mk b/board/intel/edison/config.mk
> index 3afebf0f0b1..da7c9acf1a2 100644
> --- a/board/intel/edison/config.mk
> +++ b/board/intel/edison/config.mk
> @@ -4,14 +4,4 @@
>  # Copyright (c) 2017 Intel Corporation
>  #
>
> -# Add 4096 bytes of zeroes to u-boot.bin
> -quiet_cmd_mkalign_eds = EDSALGN $@
> -cmd_mkalign_eds =                                                      \
> -       dd if=$^ of=$@ bs=4k seek=1 2>/dev/null &&                      \
> -       mv $@ $^
> -
> -INPUTS-y += u-boot-align.bin
> -u-boot-align.bin: u-boot.bin FORCE
> -       $(call if_changed,mkalign_eds)
> -
>  HOSTCFLAGS_include/autoconf.mk.dep = -Wno-variadic-macros
> --
> 2.43.0
>
