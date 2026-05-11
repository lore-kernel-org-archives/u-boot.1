Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D720CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 08:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9229584715;
	Mon, 11 May 2026 10:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V+QhgD8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E4CC847C7; Mon, 11 May 2026 10:22:27 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95CD784706
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-67c9616b4feso5927148a12.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 01:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778487745; cv=none;
 d=google.com; s=arc-20240605;
 b=O/p7nJIDCcBUL7ejolvrw7H2mKwwG5K+K/8MCw2NCxCYi5lw/1pJie1jZh54f1zN2g
 e3gwjZpZ8iTzSzejlVKx0+lSz14WBBO9M9f2Aqi0TjLZPXZnCoTOhVg0n5VpcazAM6R5
 iMCMxD31O8QA7bMpdmRiD3Adu3q2ZxltrYHtOR7KV1DhX2RERKNbBVBBSE1CYjApcTK3
 w27cFDbq3AidQWm6HG7MTTet/jInAPysdsqYZX6ArvdOzpgVc4RICfHk31MvayQknZsF
 OFghBIZGufh8oCAdY88H1iq3I3b//RauEh9V2On6bQRbWeReiOx2aUy14Tkimopbo3bz
 4ozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=D0n070EtMJ0J4nwCOc5iKyA6cbaHzyau+QEowAUjEnE=;
 fh=2K8JEZe89Cg9mIn12L3R2Gvj32qUAuMJvPugKb6ns28=;
 b=YUQnoSn+gLM4bNKzWMUQD7ZYqBxcMVbgxUEVOFPlCb/rowQiGLtjfoKktMuCaIBYZ7
 7+jDCrSg+0vN8QW54W9bQQmBvL6CMQg22Uh3Rd9w/pk2JocM8lFe8QJwnfY99zqylxoW
 QHvA+F28rKy389xksLTy1+SOwWJ5bQMWH+2j7f6334pO+Nf0BFj317OYp4Lkv5IAs9ko
 ggYUXGxD9UQcAROUkoD4f0QrxpoNMr1PM24vsKAwkXgKYaDoiFGIjlEtSfcCOqWOflqa
 dGvK6rbfdoXny0aRsK0fcVYfGDtcJzWMZeDYAP4saL57GT9xT4dJw8+d0g1DU6FJOXqd
 4ERQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778487745; x=1779092545; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D0n070EtMJ0J4nwCOc5iKyA6cbaHzyau+QEowAUjEnE=;
 b=V+QhgD8rSzXupOcLbR0abOBBmWYnjcAINiT58s+MJhJUfstwoDeSQEs3wkyWuPF2t5
 Bm37QaWYKv9YaKSTivqeSCBVPwfv5KbUf7GS9CI8ftTZm86FtKwoZd/lNz5VG4Qrbqk/
 +D1Pnx/ODZVMMOL60SGYQM4uIqKlYYD2fMp/6kdWMAvsa6t9gBg2RJGaeFu9yTEQxkYR
 lXYUaUsQ7SHYL8aPuKxUO/x2Ejq8C3ly2pQp3q4lhlXF8YfOmgTnNmj8naQvSNBXrKEi
 ZkMjJ83LSJtGyWTa45w5rrhKKuUrtvKxFVjYeBgxqrEdZzPTmFoAsZ/Yewyx2HbrRnwg
 1U4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778487745; x=1779092545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D0n070EtMJ0J4nwCOc5iKyA6cbaHzyau+QEowAUjEnE=;
 b=cjGf9WTqaboZqfO8sCbWVDVmCXC6ANT6jV4TM9Kjtiu6efjwnXVR/JKkfxwpUNWS2Y
 5OlP4MFM6o4BrTK9ZnYJvh6SzyerZUc069jz41yL/Gwyhmwe+w/ov2rF3AuvITl7ZQXe
 Rx9szqauxT/PTMYtDPUVz2ZcgmkYreFe6CxpRJxS64KxaGZ6ysdIDYZE454NcrMl4l3E
 0jlGLfcpNKY19f/ZtIZk0Fy/D3JRT7p/Gy93k6Ms+aH1YFPk/VhbAFPwVjY5zjeit+kt
 9osgzCvAFEg+0Q1yusANOgjWuZQgn/uHK8LwT9VTWZ8bGEZEZPuxaUrwo0WO88iMf789
 R53A==
X-Gm-Message-State: AOJu0YzIqJ3fsca4AHnn6dkc4+GNvSGHLfo6V96Tun6RMjHtiaNB9cOg
 8+iPZZjSa9VFdMlmdy62Kj392pL/qDiPQvWquj+BnV5TPC4WMK9mycQ7nYqZZEapkT+8C1++DoA
 doDcHTrPUhLnPCYX3saRArckKI6jdYDvdD3cmJNo=
X-Gm-Gg: Acq92OGm8WUejzNjYgtWZts+0hekygKhWuyz6qaRMxaYSTqQ/V6LBovUel2CS0MPIlm
 er+VPMtWRPcSptK0HOlGT+3CoVOvP05PWjsLVyxUQKVZ2iKCcfJrq8D8M4TMTlrwGnjM7I3dVj0
 E8z+4fEfMhQUl6a48FewKEiayUOjZamYsNpgTgcStFcyVq0SFTB5+ZZoMA8vMJZv5hDZo2eY3Ay
 CkJYUcFI+6niVLc9IyZaA5co36yCRyzYN6CS+SOtIJoXBEKKybea02qVknW6rBWSYBSmZsurrOp
 jz0q7Y+sEiiI8f5qb64576CZeyU3Ia2rM6Xutn/rUu3RDxMxX2oK3c4Na9suzWP9L7NpzELKYkx
 fnkdn87FG55XiyEHcAIM59XN+nBHJ9zmkIDD2f3le1jLGAe3YD5uBqR8h2HHaf313zXA2b2F/Lo
 Wl
X-Received: by 2002:a05:6402:26c7:b0:678:f81a:76a1 with SMTP id
 4fb4d7f45d1cf-67f708ec099mr4020618a12.10.1778487744492; Mon, 11 May 2026
 01:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778277334.git.aidan@wolfssl.com>
 <72defd14df7e4e5a1946fb2f5507c17819ca7fc4.1778277334.git.aidan@wolfssl.com>
In-Reply-To: <72defd14df7e4e5a1946fb2f5507c17819ca7fc4.1778277334.git.aidan@wolfssl.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 11 May 2026 09:22:12 +0100
X-Gm-Features: AVHnY4KaQSkiFYR_GDvjnI0gsx_uwDM5ihWqiaJzRauED0asr6Nk29MMZJ-NELg
Message-ID: <CALeDE9MGTdOjAAD_BH-WECaaUbjqK3M2zy3hb9he9Rt-G1yriw@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] configs: enable wolfTPM in rpi_4_defconfig
To: Aidan Garske <aidan@wolfssl.com>
Cc: u-boot@lists.denx.de, David Garske <david@wolfssl.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Aidan,

Firstly you should be copying the maintainers of the components you're
changing, I see a bunch of changes to the Raspberry Pi but the
maintainers aren't copied.

> Enable SPI, TPM, and wolfTPM support in the Raspberry Pi 4 default
> configuration for out-of-the-box TPM 2.0 support with Infineon
> SLB9670/9672 TPM HATs.
>
> SPI support:
>   CONFIG_SPI, CONFIG_DM_SPI, CONFIG_BCM2835_SPI, CONFIG_CMD_SPI
>   Enables the BCM2835 hardware SPI driver. Soft SPI is disabled
>   since the hardware driver is used.

Why would the would the soft SPI driver be enabled, I don't see it as
a default y anywhere.

> TPM and wolfTPM:
>   CONFIG_TPM, CONFIG_TPM_V2, CONFIG_CMD_TPM: core TPM support
>   CONFIG_TPM_WOLF: wolfTPM library integration
>   CONFIG_CMD_WOLFTPM: wolfTPM command backend for tpm2
>   CONFIG_WOLFTPM_SLB9672: Infineon SLB9672 chip support
>   WOLFTPM_LINUX_DEV disabled: uses native wolfTPM TIS layer with
>   direct SPI communication rather than U-Boot's TPM driver model
>
> Logging:
>   CONFIG_LOG with level 7 (DEBUG) to enable log_debug() output
>   from wolfTPM commands.
>
> Testing:
>   CONFIG_UNIT_TEST, CONFIG_CONSOLE_RECORD, CONFIG_HEXDUMP for
>   running the wolfTPM C unit test suite.

The above tells me what you're doing, but I can see that from the
config changes below, it doesn't tell me *WHY*! So please explain!

> Signed-off-by: Aidan Garske <aidan@wolfssl.com>
> ---
>  configs/rpi_4_defconfig | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
> index 8362242b97f..22280d9b70e 100644
> --- a/configs/rpi_4_defconfig
> +++ b/configs/rpi_4_defconfig
> @@ -69,4 +69,31 @@ CONFIG_SYS_WHITE_ON_BLACK=y
>  CONFIG_VIDEO_BCM2835=y
>  CONFIG_CONSOLE_SCROLL_LINES=10
>  CONFIG_PHYS_TO_BUS=y
> -# CONFIG_HEXDUMP is not set
> +# HEXDUMP enabled for unit tests

Would we want this enabled for a default user on a RPi? I'm not sure we do.
> +# SPI support (hardware SPI - matches Linux tpm-slb9670 overlay)
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_BCM2835_SPI=y
> +# CONFIG_SOFT_SPI is not set
> +CONFIG_CMD_SPI=y

What does the below bring for the average RPi user? Why would I want
it as the maintainer?

> +# TPM and wolfTPM support
> +CONFIG_TPM=y
> +CONFIG_TPM_V2=y
> +CONFIG_CMD_TPM=y
> +CONFIG_TPM_WOLF=y
> +# CONFIG_WOLFTPM_LINUX_DEV is not set
> +CONFIG_WOLFTPM_SLB9672=y
> +CONFIG_CMD_WOLFTPM=y

For the below an absolute NAK, This config isn't what the average user
would want. The config isn't your play ground.

> +# Logging (debug level to see log_debug output)
> +CONFIG_LOG=y
> +CONFIG_LOGLEVEL=7
> +CONFIG_LOG_MAX_LEVEL=7
> +CONFIG_LOG_DEFAULT_LEVEL=7
> +
> +# Unit testing support
> +CONFIG_UNIT_TEST=y
> +CONFIG_CONSOLE_RECORD=y
> +CONFIG_HEXDUMP=y
> --
> 2.47.3
>
