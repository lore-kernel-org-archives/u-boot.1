Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45710C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4B61812BB;
	Thu, 27 Feb 2025 17:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oZKP1vtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B677C810F5; Thu, 27 Feb 2025 17:26:21 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC9678129F
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6e41e18137bso8931326d6.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740673578; x=1741278378; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RCX7kYbK5x+GYbXDF+GnQJeOZ6N2B4vRrX8GYskSBto=;
 b=oZKP1vttcCUrzBZwlD8hhe/FYp5QrukxtiYWMb91Qf9OCv2YQdHQiXVMR3y3yoNhEY
 hD1lLVyI8C1QYJ9jDa9RcKi53BqldjOKme9o7M9ClhhdzFCtVIbosrqM/oEFKfuEtlHB
 5hl1Fij6eqbai1qiokOPYsR/jm3P1uhSzlsXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673578; x=1741278378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RCX7kYbK5x+GYbXDF+GnQJeOZ6N2B4vRrX8GYskSBto=;
 b=UqMiewBIQqWGK8/gRxFu7g3tgIzQh2sz8uXtOnJJ0yorq+9nOHoFkKsoMDaECnK/UX
 6WEOnwV8g7Md8JAEotN9DWUjAR++u+lC3j/Pr9LxIC6tV9aeFdF0hpczOzixpOfZwHpN
 zTCIw7eVS897CbGzULL1XqeUxVc44uFmf/sK46KGAgGNDnNH72A+0548dKYFCo9YMFo9
 14F1XTlLB2YNEK50MsQC3vwfy/k5XsakonWMdTUFQArricAcAbDIAYYO15/eqFiVsRJW
 CLF2fQvw56aP9K4NgW87SDXDQkDpZokzucNnKd96gwpuHWteUfHgQfOVsIJM53svycNp
 skAQ==
X-Gm-Message-State: AOJu0YxzexTPBKMrxBqDVeD8nCLhKXzdvvUySSOhYjo67rWHtuGmy0Ad
 LGrFpM9NK570M1w4V7jY1oZvcWsvIP6sIM8NXLLPI6f2/U+Rf/jHUmOpDGqFw9hpANpVYA2hE/x
 C+/eLRTqd9K8OKGPnf5TaoVUpmLoat70bQJovgSd/9q+oB0Y=
X-Gm-Gg: ASbGncvi5PsAbhj2oZnNLvRjHn9gsC7Hc15RqCBlEY+90Zkgm2UqZNNRtM9R4uZezms
 OooAYPWJXag5rItgh/XDcxQSsMT0znWb4hbkQgYFwO40C5j4foZOV/uKnSzFS8cu3b/ERRNzw/X
 036IWWoEdh
X-Google-Smtp-Source: AGHT+IEMYg9h45ClKuATISzTSolMiPx6khsHXcTLeV1T224U8+hKFbG1vjA0lW3P4KeWujbHcg0jFMm2ai71mhMR6kM=
X-Received: by 2002:a17:90b:2d87:b0:2ee:d024:e4fc with SMTP id
 98e67ed59e1d1-2fce8740f48mr45548248a91.33.1740673566983; Thu, 27 Feb 2025
 08:26:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <03a5c263b0449b397ca280d5d22bebf1d5496687.1740499185.git.jerome.forissier@linaro.org>
In-Reply-To: <03a5c263b0449b397ca280d5d22bebf1d5496687.1740499185.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Feb 2025 09:25:49 -0700
X-Gm-Features: AQ5f1JpL-oPGA_RKrL3IuASLwoXflZGu8jCwiUYOO3104Z6J1__ZMXfxf-oDh3o
Message-ID: <CAFLszTg2TXUzZS=ucjeSZaMWcXdhcChH-ABH+rkn8PYOQTVVUw@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] dm: usb: initialize and scan multiple buses
 simultaneously with uthread
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Julius Lehmann <lehmanju@devpi.de>,
 Guillaume La Roque <glaroque@baylibre.com>
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

Hi Jerome,

On Tue, 25 Feb 2025 at 09:35, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Use the uthread framework to initialize and scan USB buses in parallel
> for better performance. The console output is slightly modified with a
> final per-bus report of the number of devices found, common to UTHREAD
> and !UTHREAD. The USB tests are updated accordingly.
>
> Tested on two platforms:
>
> 1. arm64 QEMU on a somewhat contrived example (4 USB buses, each with
> one audio device, one keyboard, one mouse and one tablet)
>
>  $ make qemu_arm64_defconfig
>  $ make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
>  $ qemu-system-aarch64 -M virt -nographic -cpu max -bios u-boot.bin \
>      $(for i in {1..4}; do echo -device qemu-xhci,id=xhci$i \
>          -device\ usb-{audio,kbd,mouse,tablet},bus=xhci$i.0; \
>      done)
>
> 2. i.MX93 EVK (imx93_11x11_evk_defconfig) with two USB hubs, each with
> one webcam and one ethernet adapter, resulting in the following device
> tree:
>
>  USB device tree:
>    1  Hub (480 Mb/s, 0mA)
>    |  u-boot EHCI Host Controller
>    |
>    +-2  Hub (480 Mb/s, 100mA)
>      |  GenesysLogic USB2.1 Hub
>      |
>      +-3  Vendor specific (480 Mb/s, 350mA)
>      |    Realtek USB 10/100/1000 LAN 001000001
>      |
>      +-4   (480 Mb/s, 500mA)
>            HD Pro Webcam C920 8F7CD51F
>
>    1  Hub (480 Mb/s, 0mA)
>    |  u-boot EHCI Host Controller
>    |
>    +-2  Hub (480 Mb/s, 100mA)
>      |   USB 2.0 Hub
>      |
>      +-3  Vendor specific (480 Mb/s, 200mA)
>      |    Realtek USB 10/100/1000 LAN 000001
>      |
>      +-4   (480 Mb/s, 500mA)
>           Generic OnLan-CS30 201801010008
>
> Note that i.MX was tested on top of the downstream repository [1] since
> USB doesn't work in the upstream master branch.
>
> [1] https://github.com/nxp-imx/uboot-imx/tree/lf-6.6.52-2.2.0
>     commit 6c4545203d12 ("LF-13928 update key for capsule")
>
> The time spent in usb_init() ("usb start" command) is reported on
> the console. Here are the results:
>
>         | CONFIG_UTHREAD=n | CONFIG_UTHREAD=y
> --------+------------------+-----------------
> QEMU    |          5628 ms |          2212 ms
> i.MX93  |          4591 ms |          2441 ms
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  drivers/usb/host/usb-uclass.c | 92 ++++++++++++++++++++++++++++-------
>  test/boot/bootdev.c           | 14 +++---
>  test/boot/bootflow.c          |  2 +-
>  3 files changed, 83 insertions(+), 25 deletions(-)

What happens to output produced by a thread? Does it get stored
somewhere and written when the thread completes, or do the threads
intermingle their output?

I'm not sure if you saw my email about using a state machine for USB.
If so, could you please point me to your reply?

Regards,
Simon
