Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E823C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 20:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F287782ABA;
	Sat,  5 Apr 2025 22:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OjM/OmqY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9F4982ABA; Sat,  5 Apr 2025 22:46:30 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C61782AAF
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 22:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac2902f7c2aso541375266b.1
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743885988; x=1744490788; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cAr+G7eVJw38XT9/TusagT+aM8B082gjuTxa8SJvr6k=;
 b=OjM/OmqYwLnFaFIGYR026rV1nyLkVDbZ+f0V7/9Edabt2VsNDLjNJUBqrd3PUMiYsF
 KTMl6CHsoi5Uq3NuLVIFz0A5bZge3wxcEO/vvyuYJF6POZIDjRzM8WgpJ5hzCYz33Q6q
 fQYWWQnRu04bmqrSt94XmSuUkyrcdnKofZlQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743885988; x=1744490788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cAr+G7eVJw38XT9/TusagT+aM8B082gjuTxa8SJvr6k=;
 b=Amx0/FmsMj7CtTgvfP2dlm/lHRfdd5I2cCtn+LRULDdayZ1zM8Gk3IdwvgbIKhBwIP
 Y8wUpBQSElkXGQ85e5m0uLjdJq/3/U2FnVo0LL2QGkAHEmxX+EzKt1y4RhOS6g7pTNlD
 B09okQEghxPromt4jaDb/MfPKNKsWT3wKzbWdIdkk8o7I3VgmJL5mVw0puvBWHMYTdsW
 xd0UtTr//QvWQedqTc3LgujLwk7YTnMTBgOiUnTnMw8BQVB954hlUvcLEAsjDNCVZ8F9
 78hsM1Q0alzlte71DrOTJ5rCdq46oSQ3WXw9b60+UQ8anqFSFOTFLXmH33+7pzuQhmrw
 S8Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4jM8lxX/fQpGrQdKmFpCpk3z5y4OTtO2MzSSQUGB0wWA/C4M4+edJYpoZzEB4SaFiz8lChAk=@lists.denx.de
X-Gm-Message-State: AOJu0YxyQvObHSNW0Mgr4RBxhxNLJ6EZgA8tkzRishgvcCN4FSdPtnml
 I9d6asyCUtSmeEOCMdgmLLbxtwjdXp0enfI30szqrupGvnX4skWkllWCpRAZnf5K7UWhim69ZtQ
 BUX9bAyqUpgP5J2FN7ZyZHql7XJOF8VZDDbUT
X-Gm-Gg: ASbGncsKofejLxqMwwE3ITL5jxKUAou7rrfc1d2Cp23gU5aehlfBINRWKQ+OghT70VK
 gLYvOYOLNOs7A5N5e+dKsU4QLrWfe2Sad18gQddshqxWqwQlWKPn/EUz+zyDHRNwBef+n6ayiO5
 v9MqugDdKopFrHsOmnatcIOj84gvjK
X-Google-Smtp-Source: AGHT+IEPzHVuD07fcpHAAIWlqgqb1mx8u+bMspwBNo9K7JbhYgSkBFQpy5WbxyiU5peyV7Ou0XCWtNWEI6pmP4tnArM=
X-Received: by 2002:a17:907:97c1:b0:ac7:95c3:eb12 with SMTP id
 a640c23a62f3a-ac7d6d05ffamr724366866b.16.1743885987763; Sat, 05 Apr 2025
 13:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250405065812.33027-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250405065812.33027-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 6 Apr 2025 08:46:13 +1200
X-Gm-Features: ATxdqUHYhe4yfHloFdt66I1IRkSVc3sbiA6x6YGu8lv4mhHBrRRzpsb2MU67v1U
Message-ID: <CAFLszTgp38yBXnSigfT-mEFU=rqyAKjp0WBQGgHP_N3vRxCq=Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: stop network in EXIT_BOOT_SERVICES
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Michael Brown <mcb30@ipxe.org>,
 =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
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

Hi,

On Sat, 5 Apr 2025 at 19:58, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> It has been reported that memory corruption can occurred because network
> packages where received after EXIT_BOOT_SERVICES. See the thread
> starting at [1].
>
> We try to remove all drivers when EXIT_BOOT_SERVICES is called. But
>
> * Some network drivers don't call their own stop method when removed.
> * Some network drivers don't have a remove method.
> * Some devices have CONFIG_DM_DEVICE_REMOVE=3Dn.

A few points:
1. Only three boards disable DM_DEVICE_REMOVE and enable EFI_LOADER;
EFI_LOADER must depend on it or select it
2. If devices don't enable DM_DEVICE_REMOVE we'll have similar
problems with USB, etc.
3. The code in efi_boottime.c should be unified with
announce_and_cleanup() since otherwise this will happen on the non-EFI
path

Please do at least (1) now, if this patch is targeted at the imminent relea=
se.

Also, we need a fix in the affected network driver, although I suspect
the reporter will do that.

Regards,
Simon




>
> Let's call eth_halt() in EXIT_BOOT_SERVICES explicitly.
>
> [1]
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
> @@ -2235,6 +2236,8 @@ static efi_status_t EFIAPI efi_exit_boot_services(e=
fi_handle_t image_handle,
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
