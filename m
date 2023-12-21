Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B93C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 13:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59748877E5;
	Thu, 21 Dec 2023 14:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I5kNM6k/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 813788783A; Thu, 21 Dec 2023 14:01:14 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75594876B4
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 14:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d3c4bfe45so7728675e9.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 05:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703163668; x=1703768468; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TM/At2x44Xx9PtWTrfcZxOhuwNcbMCGAa1a2J9U0OdU=;
 b=I5kNM6k/0op749KNGX3RMOL2NHldJv7PA13FJ/Wks6Ac9ulNrtWwHyqGPlqt7AStr+
 N5OkEjWzmEl9Lby0ygOEtrFHLVi7hVt/n7ZPAO6ZIwR1yFn3gApU6Jkm0kkv7li+e5xt
 tC82RhYCgeRW7GwEnVlYba70EUGOfFjBGBKAdazvatI1kzHBIi44vW70RzH92iwfKh0d
 3EgawH28ZkZNk0i55bd6dCx/wN1xrBrzxAPeib23+dGsZiGeK37Sn+M8UDCDLpYubk34
 4Otk040D9dOoUyRloyj7EMhu5H+2iikJnqjvDFkGfo25eqnYcuJ3qQN9PVXvnf2UoNIo
 dJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703163668; x=1703768468;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TM/At2x44Xx9PtWTrfcZxOhuwNcbMCGAa1a2J9U0OdU=;
 b=jYF80vfdUkjeQBR3a2jT47C1pUIum4pkt5hmvXgMgAenlvf4Dd8CM5hBp2muaBNgDg
 AJwwqBc/Wq9kErdhlppJtv+k6USJiURYlnAUJ0+ksPGkVRMvMH7+ppXRADGNS329l8uA
 3+7xSKK3iSBBmH8TgR8LcIPGsWSiN0IRhUbbx+79mPW17jhfvpBQp+rJwNZI5Ajina4V
 a3lRmQyJK1BSOQLWFZgTNLEfaC9Sz9OCwuN6eRjL1R18Ui09+XKhNdetrlAYqWGzm5q9
 1KiIAbQmXu8z/KWTzCVS7CnUNxOoHBr4WjOEnM22Bw0gwK4ih8dLidi7HjnhHXkxNJmg
 3gLQ==
X-Gm-Message-State: AOJu0Yz2XeyI/WtQdvQqO73bFRf+OSSkVf67ho54aJGmJnQnCCfvZEto
 R7RCnkNsHdyOL8jkuRlEGnGc6iR/TlN+E4Qqm3k=
X-Google-Smtp-Source: AGHT+IFjY2IAy2fpz2QLgtWRYxLV6W6D2p/j0BN7lvdanvdhU9xXiu6WvffRruC0sIFDHMpuIMhM5e7vYAn39S6rCyk=
X-Received: by 2002:a05:600c:a081:b0:40d:40b4:bd08 with SMTP id
 jh1-20020a05600ca08100b0040d40b4bd08mr145449wmb.153.1703163667959; Thu, 21
 Dec 2023 05:01:07 -0800 (PST)
MIME-Version: 1.0
References: <20231221105017.6895-1-heinrich.schuchardt@canonical.com>
 <20231221105017.6895-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231221105017.6895-3-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 21 Dec 2023 21:01:02 +0800
Message-ID: <CAEUhbmX0Ea=p1pz4bf3Mz4vXxqg_W0P_c0bDUHPgvRKPdYqeUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] smbios: copy QEMU tables
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Thu, Dec 21, 2023 at 6:50=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> QEMU provides SMBIOS tables with detailed information. We should not try =
to
> replicate them in U-Boot.
>
> If we want to inform about U-Boot, we can add a Firmware Inventory
> Information (type 45) table in future.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/misc/Kconfig        |   8 ++
>  drivers/misc/Makefile       |   1 +
>  drivers/misc/qfw_smbios.c   | 195 ++++++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_smbios.c |   4 +-
>  4 files changed, 207 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/misc/qfw_smbios.c
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index e8e4400516..3d885f12c8 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -561,6 +561,14 @@ config QFW_MMIO
>           Hidden option to enable MMIO QEMU fw_cfg interface. This will b=
e
>           selected by the appropriate QEMU board.
>
> +config QFW_SMBIOS
> +       bool
> +       default y if ARM64
> +       default y if RISCV && 64BIT

Would you add QEMU x86 support as well?

> +       depends on QFW && SMBIOS
> +       help
> +         Hidden option to read SMBIOS tables from QEMU.
> +
>  config I2C_EEPROM
>         bool "Enable driver for generic I2C-attached EEPROMs"
>         depends on MISC

[snip]

Regards,
Bin
