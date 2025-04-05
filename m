Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE43C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 11:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0F6182991;
	Sat,  5 Apr 2025 13:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JcKQSxKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F2D5829C3; Sat,  5 Apr 2025 13:00:17 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7652F8215B
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 13:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e6e1cd3f1c5so1532465276.0
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 04:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743850811; x=1744455611; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S6leKF1nlt4E6Womzqa1EsDMMdPgf7fBVjIWlJOkOuo=;
 b=JcKQSxKS7tCMiHOVlRtPSlHPw+WPM4yW1bwUs+F/8sh7WgqjbbOPoNWMnvLrLaHGwO
 m/S9tmvTEMAAVTR+AMHV6LiPXOZm2TrKHIuVBiWSy9XE9hjo26lect00VmsVAS2gvmGY
 3RtAdHnqMvR3kX/sac+C0HzewjaK020FTC1g6psAEx6BDKlfHsSHiYOH2PMNpNiYGlPV
 clEvl19qND4vGpT+31KhtwbVSNOYrSmkYFlZ9X5HExwveoDvX/2GqsEd4AG8l327wYtG
 w0t6e/DldVV+bn2Gqft4T5Q8wvlW2GOwf5N4FJ7O7IbnlnUVWL4nd1ozvWNBPqyLfbe+
 1YwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743850811; x=1744455611;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S6leKF1nlt4E6Womzqa1EsDMMdPgf7fBVjIWlJOkOuo=;
 b=RaIhMGoQoJo0mS6juCE7/l8OMy/dk/sGJiZbAUThWQs90w/2u1v8zoeyzuCAU3nOJ8
 qOPLzQkENrKW3cMjrHa2EnueTPgpkfXVabAl/bfw2BDPAy+jSgwLskuihsJ2f8w/qPGQ
 PaFGo4YzqRV/53USDQgllwPMJ3xKHkeFjK++FTIoHbXCRYWfnk7CggvhPfB1M2CA7GT1
 cHblFGn490S+GlBmlFRjvPmQeJT0x54ol/h1bCwf/iuUOXKm3zWK3Ok36Q3c4dSj430B
 trYB/ecfGxi1NBRMDSymFkdZ79sbtyFzJ7cFJpgsZRu60GzVLVU3H56riE0I4I3k9/Nf
 xqjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX94OGpDl6nGSU1CVPRQNUBvv0FX0nKRJqGmLMDHFKuzwuWcxuYNmUWMDCJ83ZCTW/iCA4w7MM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9qnZ99KGognMMspk8gW3h+oCpnZ4BdefpZE/hnSeP1LNB+juJ
 qrKJFLXJqxejTqAAVFSMrie/8pRp2XA7AlWsOZIRy3dUQozXoTBNoDiMHOJ2PBKaSswOmg956ux
 uTg0w4cP9NfUUYcmVxCzRLyl8v11RXHUOu/wm32rrBnCczclaMgA=
X-Gm-Gg: ASbGncuNSWWgZYrLqx2cSbxfBORXbFmuEBgq2zAeHiNGSrdtr0xa7BvvRSID1rXxviO
 jR1RidSBrmJTlE2yaNXnwfG1YJtozg37IqW8gkp9vOGe1SEGNxPG2AFZYJ6IWo/vjOkGhWbAECy
 u2nHYzKzV/Fexb81CCTc9QONR2
X-Google-Smtp-Source: AGHT+IHmOiSiblAwRlVTcChF/JM9CWCJ1YmitEIp4CTXMA0q/xJBx4IrZ51wn09W+uvggbMo8WfE4eTWdwjezHjtcKI=
X-Received: by 2002:a05:6902:2602:b0:e6d:e24c:34bb with SMTP id
 3f1490d57ef6-e6e316ea4eemr3799468276.2.1743850811193; Sat, 05 Apr 2025
 04:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250405065812.33027-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250405065812.33027-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 5 Apr 2025 13:00:00 +0200
X-Gm-Features: ATxdqUHAkcYgbls_UGQYYzDrMsTbQT8ZBPZ-174CfdPNMSG8ZTwkS013BueL-_0
Message-ID: <CAC_iWjLk3dqrMjSB024dUQR-tX4LMDUuFTi-2x_01Bpn3gVZSw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: stop network in EXIT_BOOT_SERVICES
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michael Brown <mcb30@ipxe.org>, 
 =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Sat, Apr 5, 2025, 08:58 Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> It has been reported that memory corruption can occurred because network
> packages where received after EXIT_BOOT_SERVICES. See the thread
> starting at [1].
>
> We try to remove all drivers when EXIT_BOOT_SERVICES is called. But
>
> * Some network drivers don't call their own stop method when removed.
> * Some network drivers don't have a remove method.
> * Some devices have CONFIG_DM_DEVICE_REMOVE=3Dn.
>
> Let's call eth_halt() in EXIT_BOOT_SERVICES explicitly.
>

Thanks Heinrich

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> [1]
>
> https://lore.kernel.org/all/C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschu=
tter.com/
>
> Cc: Michael Brown <mcb30@ipxe.org>
> Reported-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_boottime.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.=
c
> index 5164cb15986..eaa6464fa39 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -15,6 +15,7 @@
>  #include <irq_func.h>
>  #include <log.h>
>  #include <malloc.h>
> +#include <net-common.h>
>  #include <pe.h>
>  #include <time.h>
>  #include <u-boot/crc.h>
> @@ -2235,6 +2236,8 @@ static efi_status_t EFIAPI
> efi_exit_boot_services(efi_handle_t image_handle,
>                 bootm_disable_interrupts();
>                 if (IS_ENABLED(CONFIG_USB_DEVICE))
>                         udc_disconnect();
> +               if (IS_ENABLED(CONFIG_DM_ETH))
> +                       eth_halt();
>                 board_quiesce_devices();
>                 dm_remove_devices_active();
>         }
> --
> 2.48.1
>
>
