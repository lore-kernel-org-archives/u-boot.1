Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF0CCF042E
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A4A9890A9;
	Wed,  9 Oct 2024 03:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MiVhhkl3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D04D88910D; Wed,  9 Oct 2024 03:56:54 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB4B8890F7
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71dfe07489dso2438203b3a.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439011; x=1729043811; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/45cPSRzL344eaB+MP3SxFhqrWBCfc0SAG9JhQRFHbM=;
 b=MiVhhkl3OAG4KEqdVtRcQjuXhm3OAluRBkdpeW0ZcHzR0omqyyJtud265FyPNNpeeN
 zRFgBNLD0+eDf78+QK/PfdGjC3c7qonmHat0c5KlB23hG1tbcxhIsgR7wx3XGvr9EKeE
 4AfFwJQmgdkgSYH/dwx7y+OjYJQL2X8LyufKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439011; x=1729043811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/45cPSRzL344eaB+MP3SxFhqrWBCfc0SAG9JhQRFHbM=;
 b=s2kXXtCuN0CosC24L5UOKcFLJiGTSnxxy6+OX/6/ZWWJPdGt4zjKlGruIBv6ujdRDw
 6yguU5mtXWKPEA7Y3bZT7PWXlkIG7RvPz2Y/5atwefaGahqMRiAVsTltKVq4vn7bOvrT
 QyhqpPPttN/VR8F8DuTxkymwVC7dlfVRE482eVjFhdeQLHBo7KbT9rx6v/7s8PKqeD/y
 ManU9L7FeQLEsIKEhInvsLxVfsS2qYk0gqnd7B/u38iu2q/OPDkkB7EhByXZbi6ZY64b
 umUton8fTkiuxFHoLsfb+k/ymBmYna9wq+xhRK4ZwtwECjTYp7opmlGfqKePIQs5focK
 l+oA==
X-Gm-Message-State: AOJu0YzPUuIYAlipqAx6LJhRhLgxAWjcxefcEbcu1JO43+GU0ObmGR/I
 udvaGySWYnw5GT+xG1jPurNRlRvSoOYeyGov9CjJt3Kx14B5y0DlpnfTREC9kiSGo5n48NXRwh9
 qUMTn3eymEoqZ+oP7yHIDNuYz/Vo3GOL2koBY
X-Google-Smtp-Source: AGHT+IEnJtjxkqjtuYUtRX/R+vs75hiCOou3KlHhoSiv+uaOSwKnBD3G57iMeJwNtZE2N0OAphen3G4ndkURlXwA0wc=
X-Received: by 2002:a05:6a00:1894:b0:71e:66b:c7eb with SMTP id
 d2e1a72fcca58-71e1dbc9dc4mr1431547b3a.23.1728439011160; Tue, 08 Oct 2024
 18:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <f148161ee489d19d708df1b4fa7477821e06bb55.1727694230.git.michal.simek@amd.com>
 <9715605c232ce38a36a200204c14208b9d76cd83.1727694230.git.michal.simek@amd.com>
In-Reply-To: <9715605c232ce38a36a200204c14208b9d76cd83.1727694230.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:56:39 -0600
Message-ID: <CAFLszTjrWaRyWXi45s2uNAXwhV4Lk1Vm2H7JH5i8xKRuPy4n-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: versal: Wire USB0 in distro boot
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
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

Hi Michal,

On Mon, 30 Sept 2024 at 05:05, Michal Simek <michal.simek@amd.com> wrote:
>
> For unknown reason USB host hasn't been described for distro boot that's
> why wire it now.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  include/configs/xilinx_versal.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/configs/xilinx_versal.h b/include/configs/xilinx_versal.h
> index 212dc9df2a2e..64f123424cf7 100644
> --- a/include/configs/xilinx_versal.h
> +++ b/include/configs/xilinx_versal.h
> @@ -48,6 +48,12 @@
>  # define BOOT_TARGET_DEVICES_MMC(func)
>  #endif
>
> +#if defined(CONFIG_USB_STORAGE)
> +# define BOOT_TARGET_DEVICES_USB(func) func(USB, usb, 0)
> +#else
> +# define BOOT_TARGET_DEVICES_USB(func)
> +#endif
> +
>  #if defined(CONFIG_CMD_PXE) && defined(CONFIG_CMD_DHCP)
>  # define BOOT_TARGET_DEVICES_PXE(func) func(PXE, pxe, na)
>  #else
> @@ -118,6 +124,7 @@
>         BOOT_TARGET_DEVICES_XSPI(func) \
>         BOOT_TARGET_DEVICES_USB_DFU(func) \
>         BOOT_TARGET_DEVICES_USB_THOR(func) \
> +       BOOT_TARGET_DEVICES_USB(func) \
>         BOOT_TARGET_DEVICES_PXE(func) \
>         BOOT_TARGET_DEVICES_DHCP(func)
>
> --
> 2.43.0
>

I wonder if these could move to boostd? It would require implementing
something for dfu and thor, though.

Regards,
Simon
