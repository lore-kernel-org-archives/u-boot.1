Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B003C27C52
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 07:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51E848845A;
	Tue,  4 Jun 2024 09:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N7O6V0FM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8061888485; Tue,  4 Jun 2024 09:02:00 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0CD08845A
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 09:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-35dcff36522so649644f8f.1
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 00:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717484517; x=1718089317;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fkHOdpSr1+p94IJRowiC7BJQFJhEeb8VsuAy4hLB1lg=;
 b=N7O6V0FMZWZ5lw/dZMEuHFAH6nvg+s+jLz6CjsvaQqQHVweAeNPuV+IJArjVqRs5rM
 Q+LMNrBI2JjLKksM70kY9HfrqW9SGn7zbl6k4+0jHa82ZBXFGHwfvwFRrohqHbbBLmCi
 9J6YfHgGrORR9RRG2iSNnKFJbS049aUBHThOhijxe7RTzcKQAAmOM52LMgX75ML52tPj
 Dx63WV82RL4QtOsXVTIKQSoEi9mV/c/0K6Ok0/UF4spn46j2JkQtQ6mMJIXPbYAJtFUC
 zgi9XphGaaCFA+h8qSKdvxgjbWw8dtSwZ3TlgHMMXH70RSi6EX1l0tNEjm3JNUD4JME5
 DNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717484517; x=1718089317;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fkHOdpSr1+p94IJRowiC7BJQFJhEeb8VsuAy4hLB1lg=;
 b=Pny5viAYLxKClZXxxbmqvSz9qaHYjnTm6x62vDS0BgY5aHZXCESTikSGa9uIe/4Nl6
 Ff8ToEMomQqJrnTUwlFai0EwftOm+Y/TObilvHUrNeWAKNV4sKUGKxhtFyy3gs6Ba5kM
 okqr4StNtJGRHDpnn2+zOqNIFeZSnPENiyi9qTNvEXpxql1a/4B2ApiEfwYer3j667f/
 uUeCIztrJpataL7pSnLd2MyWavjfMRBNbm7y80MmkLmI9877w8/hDm92MRPb35FQZvvU
 C7w8KpfzzolCfbBFBIfpaiAdjkoCXL2qXQ0aePwW4siJIjLukdJxMhWDxsHfsj70P6G5
 THbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT1pggJ2u/RaSSy043e7fpVIiPTZ1nZJE3AjChpNGzu4XiklnjKqgbm71TtstlisKxAz7iHH2lqE+/eYKmFu06hu3eHA==
X-Gm-Message-State: AOJu0YzsDELQHEPhdcMJKVvAXZjYYGcEebRjLOI1I/r+SbNRitVMF3x2
 kRpw09zwT/8dxxGZStTcNpgxzPW0fqiD8W3oCzyFoRprkbtw0ElgIRFqbJR/Rec=
X-Google-Smtp-Source: AGHT+IGPS/CTL6dQYDDKLbuVO21qSYxjR+xyQyA2sz6J8JnDJNTKDeaCDrN8lKjN8FO8khRDC1U/Wg==
X-Received: by 2002:a5d:584e:0:b0:35e:61e5:3668 with SMTP id
 ffacd0b85a97d-35e61e53938mr2499193f8f.18.1717484517105; 
 Tue, 04 Jun 2024 00:01:57 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04caf50sm10646663f8f.41.2024.06.04.00.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 00:01:56 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Lukasz Majewski
 <lukma@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH v3 1/8] dfu: add scsi backend
In-Reply-To: <20240603-b4-qcom-capsule-updates-v3-1-fe2e083289ec@linaro.org>
References: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
 <20240603-b4-qcom-capsule-updates-v3-1-fe2e083289ec@linaro.org>
Date: Tue, 04 Jun 2024 09:01:54 +0200
Message-ID: <87zfs11999.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Caleb,

Thank you for the patch.

On lun., juin 03, 2024 at 14:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> This is extremely similar to the MMC backend, but there are some notable
> differences.
>
> Works with a DFU string like
>
>     scsi 4=u-boot-bin part 11
>
> Where "4" is the SCSI dev number (sequential LUN across all SCSI devices)
> and "11" is the partition number.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  doc/usage/dfu.rst      |  32 ++++
>  drivers/dfu/Kconfig    |   7 +
>  drivers/dfu/Makefile   |   1 +
>  drivers/dfu/dfu.c      |   5 +-
>  drivers/dfu/dfu_scsi.c | 435 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/dfu.h          |  26 +++
>  6 files changed, 505 insertions(+), 1 deletion(-)
>
> diff --git a/doc/usage/dfu.rst b/doc/usage/dfu.rst
> index 8cc09c308d82..f497dcf137a4 100644
> --- a/doc/usage/dfu.rst
> +++ b/doc/usage/dfu.rst
> @@ -21,8 +21,9 @@ U-Boot implements this DFU capability (CONFIG_DFU) with the command dfu
>  
>  Today the supported DFU backends are:
>  
>  - MMC (RAW or FAT / EXT2 / EXT3 / EXT4 file system / SKIP / SCRIPT)
> +- SCSI (UFS, RAW partition, FAT / EXT2 / EXT3 / EXT4 file system / SKIP / SCRIPT)
>  - NAND
>  - RAM
>  - SF (serial flash)
>  - MTD (all MTD device: NAND, SPI-NOR, SPI-NAND,...)
> @@ -166,8 +167,38 @@ mmc
>  
>      Please note that this means the user will be able to execute any
>      arbitrary commands just like in the u-boot's shell.

Can we please add CONFIG_DFU_SCSI in "Configuration Options" section at
the beginning of this document?

See:
https://docs.u-boot.org/en/latest/usage/dfu.html#configuration-options

Note: I requested that here:
https://lore.kernel.org/all/87o7a94pe1.fsf@baylibre.com/

With above addressed, feel free to add:
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

And please take this through your tree:
Acked-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>  
> +scsi

[...]
