Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58777C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 20:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E37D82AB2;
	Sat,  5 Apr 2025 22:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kohlschutter.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kohlschuetter-com.20230601.gappssmtp.com header.i=@kohlschuetter-com.20230601.gappssmtp.com header.b="qbr0iTh0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47F482ABA; Sat,  5 Apr 2025 22:45:15 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2637982AAF
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 22:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=kohlschutter.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian@kohlschuetter.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e5e34f4e89so6239773a12.1
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kohlschuetter-com.20230601.gappssmtp.com; s=20230601; t=1743885912;
 x=1744490712; darn=lists.denx.de; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pXcGrXjDi0/bfiORmkVEPySx4T4DEgyA9krlsCEV0B8=;
 b=qbr0iTh0MXRoibJ+45aJ2WMva89cZmJQ9VcxoJQOIfQDjXRxVhySEGFS9lJaHldkqV
 CDtakZgXx96cUOb/qlmg6tZatYLUeWQi6/r7PjLTQoZB49JYLU6xUyt1EFpbLm9gG1wa
 wDLlizipYmXN7POJZSMgkRRH1j33koOcAlP5HE3hvPg13sDz643eHFIiXzkMlqMU1ofh
 AGLbbhBn+GPJw/ITvqFQo4/pc2qUFWsta35SZlpweYVB83jalxREoNpWB+dyp6SWz1Mr
 vsygdderTcorrZSAkbFCu6PNU+9qMD1ccuqmU0yf7PP3RaJk6CyuNyfpRNnJYgPYWNvk
 5d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743885912; x=1744490712;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pXcGrXjDi0/bfiORmkVEPySx4T4DEgyA9krlsCEV0B8=;
 b=Z4EArIBwzlkr5y131wChaQrBiXD6NnAT3gmMS+TF6fa7Xw7I9yd+HaBnB2VbVsMb3C
 mUceniHaFJEGmQrx6XPM4UzK7tdP57rs4I8iFgfGMKS9JGcZf0V552u/XGxSFUtbr1D+
 7N9pHBaMydoI+nFPC8Ckrtd546FHlldO0NYNPr0IqBuQKeWqfCSYwwNqrNS505bh9vdp
 gSnK6TxIOoiNSVTuaa7mD02d0dXzwk7RvpV8r+p5pnNdjZPb6PKGT+UqMjJpdDAfcG4o
 5inhM+MGquPKrZ/yTFq3t7oXr5Y7B7jVgsA42VcLHILixvvl9l1CePMjsr6qfvM51paX
 n/eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbV/vyRypCUZ8biKdWJqytGq0qQpe8X8gJCTgBcgXBgemtxZUq7SaIwGPVrZO6QS0UMmUslOA=@lists.denx.de
X-Gm-Message-State: AOJu0YzkTD99B2NBDMNeWhK2gw7mNvSa7ThXnBuvo6dBidCLgM6GX1Fv
 VrerC/OdTHkuzXARSz7R/iRFa7P6pRePoCCeWkF1EnojbajITKNtDJ/x27czQnU=
X-Gm-Gg: ASbGncsTufo1Cbp0f9/Iv3CCAXajcY5pPgLBCKoQ1iYqfvvNWnQLI0b2CyNn6mM3/hL
 mFpSIXASeY8+ZejulgTEHwleD6RYD5ydxyODebf23MnKJ9AP2bP0Ku0mRS/Wiw4zqw9r6kZhvUd
 x/3OhfO4Y2XaZu0sXoU8uw730YdbWk6EU6uMGsYRLjRPriDwYQFqkSxjMC0KNEV8esJVR34EFvM
 5TBF99bNBzWvqn3cI7cqggMRwmduimUHrtr84lUBWGMOoiawUniP0is6Ub9c5qNDB3osVTsrdbY
 A3BLsr2dH7FfRBKp4u6qAvUx1DuyPttuZvhd7YQzEueUv7W5Lw6DURj+I6NaqbpglWH+
X-Google-Smtp-Source: AGHT+IFJC0TIjY0QtseM3QPjTALag4M7csKalDsyT39ybD+3UPzUXJBWN0VkQq0hy5n8bYnKWiecMQ==
X-Received: by 2002:a05:6402:2811:b0:5e8:bf2a:7e8c with SMTP id
 4fb4d7f45d1cf-5f0db81b4b8mr2678189a12.11.1743885912274; 
 Sat, 05 Apr 2025 13:45:12 -0700 (PDT)
Received: from smtpclient.apple ([91.64.76.218])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f08760f0a0sm4269876a12.0.2025.04.05.13.45.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 05 Apr 2025 13:45:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH 1/1] efi_loader: stop network in EXIT_BOOT_SERVICES
From: =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>
In-Reply-To: <CAC_iWjLk3dqrMjSB024dUQR-tX4LMDUuFTi-2x_01Bpn3gVZSw@mail.gmail.com>
Date: Sat, 5 Apr 2025 22:45:11 +0200
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michael Brown <mcb30@ipxe.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BECDA126-0292-4FCC-93A5-3D43C2FE4D52@kohlschutter.com>
References: <20250405065812.33027-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjLk3dqrMjSB024dUQR-tX4LMDUuFTi-2x_01Bpn3gVZSw@mail.gmail.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
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

On 5. Apr 2025, at 13:00, Ilias Apalodimas <ilias.apalodimas@linaro.org> =
wrote:
>=20
> On Sat, Apr 5, 2025, 08:58 Heinrich Schuchardt =
<heinrich.schuchardt@canonical.com> wrote:
> It has been reported that memory corruption can occurred because =
network
> packages where received after EXIT_BOOT_SERVICES. See the thread
> starting at [1].
>=20
> We try to remove all drivers when EXIT_BOOT_SERVICES is called. But
>=20
> * Some network drivers don't call their own stop method when removed.
> * Some network drivers don't have a remove method.
> * Some devices have CONFIG_DM_DEVICE_REMOVE=3Dn.
>=20
> Let's call eth_halt() in EXIT_BOOT_SERVICES explicitly.
>=20
> Thanks Heinrich
>=20
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>=20
> [1]
> =
https://lore.kernel.org/all/C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschut=
ter.com/
>=20
> Cc: Michael Brown <mcb30@ipxe.org>
> Reported-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_boottime.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/lib/efi_loader/efi_boottime.c =
b/lib/efi_loader/efi_boottime.c
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
> @@ -2235,6 +2236,8 @@ static efi_status_t EFIAPI =
efi_exit_boot_services(efi_handle_t image_handle,
>                 bootm_disable_interrupts();
>                 if (IS_ENABLED(CONFIG_USB_DEVICE))
>                         udc_disconnect();
> +               if (IS_ENABLED(CONFIG_DM_ETH))
> +                       eth_halt();
>                 board_quiesce_devices();
>                 dm_remove_devices_active();
>         }
> --=20
> 2.48.1
>=20

Works beautifully, and is not specific to any affected board. Very nice.

Tested-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com =
<mailto:christian@kohlschutter.com>>

Thanks a lot!
Christian

