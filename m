Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD38C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 13:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3E8484543;
	Thu,  7 Aug 2025 15:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZoobkUoB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F4248456B; Thu,  7 Aug 2025 15:55:21 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A119584541
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 15:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-71a455096e0so7252177b3.0
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754574915; x=1755179715; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q3zWa/H9ctgSbWuzFI/YiDf0RAuCAjpyqcKB4X7MuRg=;
 b=ZoobkUoB/B3B10eGACCS2B5kWy7LH+7rvNAOKizOq4qbycMfJ2ZGR+WKJ00q2I/LwW
 pfr2c8WmE2xgUuXDdBH5nX72e7Y3APGUdpq5WSXPKL1owJu5h0SrZWcOjhEz3L6nFPii
 mCWfv+EGytkSYY6FV/XCmEInRwCJALWK6kjszd4wKFbmMSZkFaXQwfIxIYp0R7eX/RVf
 zizi1ZuyqL0UBpjVKV4nCI5bFTPR0huy7MI0WgKQXKGYboYv/Cyx4pTiEUudyi3oSQYm
 vRTjzHg02HfUrPeoIAJ0R5SbXo6FAK1c7v6esK1VGooeBeaCCW2WMme4FRCbSBVPQeKu
 0kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754574915; x=1755179715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q3zWa/H9ctgSbWuzFI/YiDf0RAuCAjpyqcKB4X7MuRg=;
 b=vNUow/GQ7hPrGC6xZdj7AH9RdsOAynC9NG6Bl7hywjXNy6PgXjUAQspq3FdU5SbV0G
 a+HKNHQS8OhtnZcNLFMkYCtg9TOqjTP7kEM3ioYaPRnZj2gMWEZ4h6mpx3ksbbBIfIlL
 07bIFNVZXDr+zQfltKaxPHDi6e8vjEFb38BGVMatjyYFvsKV6GJAJfAzLNKWVHK9uH2C
 9y8SOPjE4TT3CRa9qnbXgBFvm8C8LTlja16aUD2+5rPu4DrBjl0R4203/tzwIjfMDdUy
 MtKXXhWrOcAkLYiHEGHjjZmPHxOlqZMGPm2BW3wSgyDUIib7zCEkZfoKbQyxZpA2ibC9
 E8Xw==
X-Gm-Message-State: AOJu0YxmrVqIfQHpZl9S9jFCMQFFPSNbcH3xE3ei+pTlN/WZr4L7Erlp
 XDOUAxUxo3o+SvCI1Zd0QC9qS+luieClqKkCwNMc7I80RxHFUCHuNNwyv7q9sk/gJIM4i2d0/Tk
 D8rNcAMuMSOZF57bMu9UwCDIIAqYhT3zfVk7F3p1g+3eBpHA8xWk+u9JEpw==
X-Gm-Gg: ASbGncui8j+0Fk00cpAfrtLOZIuTQXCkPjQ0W63Eq2OmofHufFE7tY26yQYMxuGj/u6
 ANUPjIkSExIpfJvWxLLNbX1mcx5WuBzA0AEEHwU7oU0d5GnAxkiFiKBYOfRVsVwVDYmwiX1SrfM
 d0NpXZ24UjNRe1Dgmx7Ol5XibhdJA14ussyow4N2RPtoihxsugPIoj/ODlT6SUp9GoewBTM5hKh
 PrFpayX/8JU+KCInCjaweRyfOYfPcpKskI2qZqo
X-Google-Smtp-Source: AGHT+IGj+Qh0b1Qgk/e0w5ep8qMlPvhnbC4vC5FpXVgE8eNoenfCkBEnWwEf1Y+lu5JBs5zuWNYHHKma/egPxFtBsOo=
X-Received: by 2002:a05:690c:fc4:b0:718:38bd:5433 with SMTP id
 00721157ae682-71bcc88e8b6mr80355177b3.42.1754574914492; Thu, 07 Aug 2025
 06:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250806145519.1664444-1-trini@konsulko.com>
In-Reply-To: <20250806145519.1664444-1-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Aug 2025 16:54:36 +0300
X-Gm-Features: Ac12FXwxTRYVIAtlHq42KgXGReJ9-GD1vosed1yjL84zGCFLqq3gYPwWqktVXmQ
Message-ID: <CAC_iWjKuB2WjFfoG=UhLzijjKVe_yM=rMCxOCFDdo2K2=AA9Kw@mail.gmail.com>
Subject: Re: [PATCH 1/3] tpm: tpm_tis_st33zp24: Remove unused drivers
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Wed, 6 Aug 2025 at 17:55, Tom Rini <trini@konsulko.com> wrote:
>
> The tpm_tis_st33zp24_i2c and tpm_tis_st33zp24_spi drivers are unused.
> Remove them.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Will you apply these or shall I send a PR via the TPM tree?

Cheers
/Ilias
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  README                             |  11 -
>  drivers/tpm/Kconfig                |  18 -
>  drivers/tpm/Makefile               |   2 -
>  drivers/tpm/tpm_tis_st33zp24_i2c.c | 545 -----------------------
>  drivers/tpm/tpm_tis_st33zp24_spi.c | 674 -----------------------------
>  5 files changed, 1250 deletions(-)
>  delete mode 100644 drivers/tpm/tpm_tis_st33zp24_i2c.c
>  delete mode 100644 drivers/tpm/tpm_tis_st33zp24_spi.c
>
> diff --git a/README b/README
> index 65305e6a0371..07cfded6be53 100644
> --- a/README
> +++ b/README
> @@ -390,17 +390,6 @@ The following options need to be configured:
>                         CONFIG_TPM_TIS_I2C_BURST_LIMITATION
>                         Define the burst count bytes upper limit
>
> -               CONFIG_TPM_ST33ZP24
> -               Support for STMicroelectronics TPM devices. Requires DM_TPM support.
> -
> -                       CONFIG_TPM_ST33ZP24_I2C
> -                       Support for STMicroelectronics ST33ZP24 I2C devices.
> -                       Requires TPM_ST33ZP24 and I2C.
> -
> -                       CONFIG_TPM_ST33ZP24_SPI
> -                       Support for STMicroelectronics ST33ZP24 SPI devices.
> -                       Requires TPM_ST33ZP24 and SPI.
> -
>                 CONFIG_TPM_ATMEL_TWI
>                 Support for Atmel TWI TPM device. Requires I2C support.
>
> diff --git a/drivers/tpm/Kconfig b/drivers/tpm/Kconfig
> index 01bc686d367d..219ea606b50a 100644
> --- a/drivers/tpm/Kconfig
> +++ b/drivers/tpm/Kconfig
> @@ -75,24 +75,6 @@ config TPM_AUTH_SESSIONS
>           TPM_LoadKey2 and TPM_GetPubKey are provided. Both features are
>           available using the 'tpm' command, too.
>
> -config TPM_ST33ZP24_I2C
> -       bool "STMicroelectronics ST33ZP24 I2C TPM"
> -       depends on TPM_V1 && DM_I2C
> -       ---help---
> -         This driver supports STMicroelectronics TPM devices connected on the I2C bus.
> -         The usual tpm operations and the 'tpm' command can be used to talk
> -         to the device using the standard TPM Interface Specification (TIS)
> -         protocol
> -
> -config TPM_ST33ZP24_SPI
> -       bool "STMicroelectronics ST33ZP24 SPI TPM"
> -       depends on TPM_V1 && DM_SPI
> -       ---help---
> -         This driver supports STMicroelectronics TPM devices connected on the SPI bus.
> -         The usual tpm operations and the 'tpm' command can be used to talk
> -         to the device using the standard TPM Interface Specification (TIS)
> -         protocol
> -
>  config TPM_FLUSH_RESOURCES
>         bool "Enable TPM resource flushing support"
>         depends on TPM_V1
> diff --git a/drivers/tpm/Makefile b/drivers/tpm/Makefile
> index 76e516dbbafa..b83ce703ec03 100644
> --- a/drivers/tpm/Makefile
> +++ b/drivers/tpm/Makefile
> @@ -7,8 +7,6 @@ obj-$(CONFIG_TPM_ATMEL_TWI) += tpm_atmel_twi.o
>  obj-$(CONFIG_TPM_TIS_INFINEON) += tpm_tis_infineon.o
>  obj-$(CONFIG_TPM_TIS_LPC) += tpm_tis_lpc.o
>  obj-$(CONFIG_TPM_TIS_SANDBOX) += tpm_tis_sandbox.o sandbox_common.o
> -obj-$(CONFIG_TPM_ST33ZP24_I2C) += tpm_tis_st33zp24_i2c.o
> -obj-$(CONFIG_TPM_ST33ZP24_SPI) += tpm_tis_st33zp24_spi.o
>
>  obj-$(CONFIG_$(PHASE_)TPM2_CR50_I2C) += cr50_i2c.o
>  obj-$(CONFIG_TPM2_TIS_SANDBOX) += tpm2_tis_sandbox.o sandbox_common.o
> diff --git a/drivers/tpm/tpm_tis_st33zp24_i2c.c b/drivers/tpm/tpm_tis_st33zp24_i2c.c
> deleted file mode 100644
> index 1a265b28b22f..000000000000
> --- a/drivers/tpm/tpm_tis_st33zp24_i2c.c
> +++ /dev/null
> @@ -1,545 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * STMicroelectronics TPM ST33ZP24 I2C UBOOT driver
> - *
> - * Copyright (C) 2016, STMicroelectronics - All Rights Reserved
> - * Author(s): Christophe Ricard <christophe-h.ricard@st.com> for STMicroelectronics.
> - *
> - * Description: Device driver for ST33ZP24 I2C TPM TCG.
> - *
> - * This device driver implements the TPM interface as defined in
> - * the TCG TPM Interface Spec version 1.21, revision 1.0 and the
> - * STMicroelectronics Protocol Stack Specification version 1.2.0.
> - */
> -
> -#include <dm.h>
> -#include <fdtdec.h>
> -#include <i2c.h>
> -#include <log.h>
> -#include <tpm-v1.h>
> -#include <errno.h>
> -#include <linux/delay.h>
> -#include <linux/types.h>
> -#include <asm/unaligned.h>
> -
> -#include "tpm_tis.h"
> -#include "tpm_internal.h"
> -
> -#define TPM_ACCESS                     0x0
> -#define TPM_STS                                0x18
> -#define TPM_DATA_FIFO                  0x24
> -
> -#define LOCALITY0                      0
> -
> -#define TPM_DUMMY_BYTE                 0xAA
> -#define TPM_ST33ZP24_I2C_SLAVE_ADDR    0x13
> -
> -#define TPM_WRITE_DIRECTION             0x80
> -
> -/*
> - * st33zp24_i2c_write8_reg
> - * Send byte to the TIS register according to the ST33ZP24 I2C protocol.
> - * @param: tpm_register, the tpm tis register where the data should be written
> - * @param: tpm_data, the tpm_data to write inside the tpm_register
> - * @param: tpm_size, The length of the data
> - * @return: Number of byte written successfully else an error code.
> - */
> -static int st33zp24_i2c_write8_reg(struct udevice *dev, u8 tpm_register,
> -                                  const u8 *tpm_data, size_t tpm_size)
> -{
> -       struct tpm_chip_priv *chip_priv = dev_get_uclass_priv(dev);
> -
> -       chip_priv->buf[0] = tpm_register;
> -       memcpy(chip_priv->buf + 1, tpm_data, tpm_size);
> -
> -       return dm_i2c_write(dev, 0, chip_priv->buf, tpm_size + 1);
> -}
> -
> -/*
> -* st33zp24_i2c_read8_reg
> -* Recv byte from the TIS register according to the ST33ZP24 I2C protocol.
> -* @param: tpm_register, the tpm tis register where the data should be read
> -* @param: tpm_data, the TPM response
> -* @param: tpm_size, tpm TPM response size to read.
> -* @return: Number of byte read successfully else an error code.
> -*/
> -static int st33zp24_i2c_read8_reg(struct udevice *dev, u8 tpm_register,
> -                                 u8 *tpm_data, size_t tpm_size)
> -{
> -       int status;
> -       u8 data;
> -
> -       data = TPM_DUMMY_BYTE;
> -       status = st33zp24_i2c_write8_reg(dev, tpm_register, &data, 1);
> -       if (status < 0)
> -               return status;
> -
> -       return dm_i2c_read(dev, 0, tpm_data, tpm_size);
> -}
> -
> -/*
> - * st33zp24_i2c_write
> - * Send byte to the TIS register according to the ST33ZP24 I2C protocol.
> - * @param: phy_id, the phy description
> - * @param: tpm_register, the tpm tis register where the data should be written
> - * @param: tpm_data, the tpm_data to write inside the tpm_register
> - * @param: tpm_size, the length of the data
> - * @return: number of byte written successfully: should be one if success.
> - */
> -static int st33zp24_i2c_write(struct udevice *dev, u8 tpm_register,
> -                             const u8 *tpm_data, size_t tpm_size)
> -{
> -       return st33zp24_i2c_write8_reg(dev, tpm_register | TPM_WRITE_DIRECTION,
> -                                      tpm_data, tpm_size);
> -}
> -
> -/*
> - * st33zp24_i2c_read
> - * Recv byte from the TIS register according to the ST33ZP24 I2C protocol.
> - * @param: phy_id, the phy description
> - * @param: tpm_register, the tpm tis register where the data should be read
> - * @param: tpm_data, the TPM response
> - * @param: tpm_size, tpm TPM response size to read.
> - * @return: number of byte read successfully: should be one if success.
> - */
> -static int st33zp24_i2c_read(struct udevice *dev, u8 tpm_register,
> -                            u8 *tpm_data, size_t tpm_size)
> -{
> -       return st33zp24_i2c_read8_reg(dev, tpm_register, tpm_data, tpm_size);
> -}
> -
> -/*
> - * st33zp24_i2c_release_locality release the active locality
> - * @param: chip, the tpm chip description.
> - */
> -static void st33zp24_i2c_release_locality(struct udevice *dev)
> -{
> -       u8 data = TPM_ACCESS_ACTIVE_LOCALITY;
> -
> -       st33zp24_i2c_write(dev, TPM_ACCESS, &data, 1);
> -}
> -
> -/*
> - * st33zp24_i2c_check_locality if the locality is active
> - * @param: chip, the tpm chip description
> - * @return: the active locality or -EACCES.
> - */
> -static int st33zp24_i2c_check_locality(struct udevice *dev)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -       u8 data;
> -       u8 status;
> -
> -       status = st33zp24_i2c_read(dev, TPM_ACCESS, &data, 1);
> -       if (!status && (data &
> -               (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) ==
> -               (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID))
> -               return chip->locality;
> -
> -       return -EACCES;
> -}
> -
> -/*
> - * st33zp24_i2c_request_locality request the TPM locality
> - * @param: chip, the chip description
> - * @return: the active locality or negative value.
> - */
> -static int st33zp24_i2c_request_locality(struct udevice *dev)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -       unsigned long start, stop;
> -       long ret;
> -       u8 data;
> -
> -       if (st33zp24_i2c_check_locality(dev) == chip->locality)
> -               return chip->locality;
> -
> -       data = TPM_ACCESS_REQUEST_USE;
> -       ret = st33zp24_i2c_write(dev, TPM_ACCESS, &data, 1);
> -       if (ret < 0)
> -               return ret;
> -
> -       /* wait for locality activated */
> -       start = get_timer(0);
> -       stop = chip->timeout_a;
> -       do {
> -               if (st33zp24_i2c_check_locality(dev) >= 0)
> -                       return chip->locality;
> -               udelay(TPM_TIMEOUT_MS * 1000);
> -       } while  (get_timer(start) < stop);
> -
> -       return -EACCES;
> -}
> -
> -/*
> - * st33zp24_i2c_status return the TPM_STS register
> - * @param: chip, the tpm chip description
> - * @return: the TPM_STS register value.
> - */
> -static u8 st33zp24_i2c_status(struct udevice *dev)
> -{
> -       u8 data;
> -
> -       st33zp24_i2c_read(dev, TPM_STS, &data, 1);
> -
> -       return data;
> -}
> -
> -/*
> - * st33zp24_i2c_get_burstcount return the burstcount address 0x19 0x1A
> - * @param: chip, the chip description
> - * return: the burstcount or -TPM_DRIVER_ERR in case of error.
> - */
> -static int st33zp24_i2c_get_burstcount(struct udevice *dev)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -       unsigned long start, stop;
> -       int burstcnt, status;
> -       u8 tpm_reg, temp;
> -
> -       /* wait for burstcount */
> -       start = get_timer(0);
> -       stop = chip->timeout_d;
> -       do {
> -               tpm_reg = TPM_STS + 1;
> -               status = st33zp24_i2c_read(dev, tpm_reg, &temp, 1);
> -               if (status < 0)
> -                       return -EBUSY;
> -
> -               tpm_reg = TPM_STS + 2;
> -               burstcnt = temp;
> -               status = st33zp24_i2c_read(dev, tpm_reg, &temp, 1);
> -               if (status < 0)
> -                       return -EBUSY;
> -
> -               burstcnt |= temp << 8;
> -               if (burstcnt)
> -                       return burstcnt;
> -               udelay(TIS_SHORT_TIMEOUT_MS * 1000);
> -       } while (get_timer(start) < stop);
> -
> -       return -EBUSY;
> -}
> -
> -/*
> - * st33zp24_i2c_cancel, cancel the current command execution or
> - * set STS to COMMAND READY.
> - * @param: chip, tpm_chip description.
> - */
> -static void st33zp24_i2c_cancel(struct udevice *dev)
> -{
> -       u8 data;
> -
> -       data = TPM_STS_COMMAND_READY;
> -       st33zp24_i2c_write(dev, TPM_STS, &data, 1);
> -}
> -
> -/*
> - * st33zp24_i2c_wait_for_stat wait for a TPM_STS value
> - * @param: chip, the tpm chip description
> - * @param: mask, the value mask to wait
> - * @param: timeout, the timeout
> - * @param: status,
> - * @return: the tpm status, 0 if success, -ETIME if timeout is reached.
> - */
> -static int st33zp24_i2c_wait_for_stat(struct udevice *dev, u8 mask,
> -                                     unsigned long timeout, int *status)
> -{
> -       unsigned long start, stop;
> -
> -       /* Check current status */
> -       *status = st33zp24_i2c_status(dev);
> -       if ((*status & mask) == mask)
> -               return 0;
> -
> -       start = get_timer(0);
> -       stop = timeout;
> -       do {
> -               udelay(TPM_TIMEOUT_MS * 1000);
> -               *status = st33zp24_i2c_status(dev);
> -               if ((*status & mask) == mask)
> -                       return 0;
> -       } while (get_timer(start) < stop);
> -
> -       return -ETIME;
> -}
> -
> -/*
> - * st33zp24_i2c_recv_data receive data
> - * @param: chip, the tpm chip description
> - * @param: buf, the buffer where the data are received
> - * @param: count, the number of data to receive
> - * @return: the number of bytes read from TPM FIFO.
> - */
> -static int st33zp24_i2c_recv_data(struct udevice *dev, u8 *buf, size_t count)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -       int size = 0, burstcnt, len, ret, status;
> -
> -       while (size < count &&
> -              st33zp24_i2c_wait_for_stat(dev, TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> -                               chip->timeout_c, &status) == 0) {
> -               burstcnt = st33zp24_i2c_get_burstcount(dev);
> -               if (burstcnt < 0)
> -                       return burstcnt;
> -               len = min_t(int, burstcnt, count - size);
> -               ret = st33zp24_i2c_read(dev, TPM_DATA_FIFO, buf + size, len);
> -               if (ret < 0)
> -                       return ret;
> -
> -               size += len;
> -       }
> -
> -       return size;
> -}
> -
> -/*
> - * st33zp24_i2c_recv received TPM response through TPM phy.
> - * @param: chip, tpm_chip description.
> - * @param: buf,        the buffer to store data.
> - * @param: count, the number of bytes that can received (sizeof buf).
> - * @return: Returns zero in case of success else -EIO.
> - */
> -static int st33zp24_i2c_recv(struct udevice *dev, u8 *buf, size_t count)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -       int size;
> -       unsigned int expected;
> -
> -       if (!chip)
> -               return -ENODEV;
> -
> -       if (count < TPM_HEADER_SIZE) {
> -               size = -EIO;
> -               goto out;
> -       }
> -
> -       size = st33zp24_i2c_recv_data(dev, buf, TPM_HEADER_SIZE);
> -       if (size < TPM_HEADER_SIZE) {
> -               debug("TPM error, unable to read header\n");
> -               goto out;
> -       }
> -
> -       expected = get_unaligned_be32(buf + 2);
> -       if (expected > count || expected < TPM_HEADER_SIZE) {
> -               size = -EIO;
> -               goto out;
> -       }
> -
> -       size += st33zp24_i2c_recv_data(dev, &buf[TPM_HEADER_SIZE],
> -                                  expected - TPM_HEADER_SIZE);
> -       if (size < expected) {
> -               debug("TPM error, unable to read remaining bytes of result\n");
> -               size = -EIO;
> -               goto out;
> -       }
> -
> -out:
> -       st33zp24_i2c_cancel(dev);
> -       st33zp24_i2c_release_locality(dev);
> -
> -       return size;
> -}
> -
> -/*
> - * st33zp24_i2c_send send TPM commands through TPM phy.
> - * @param: chip, tpm_chip description.
> - * @param: buf,        the buffer to send.
> - * @param: len, the number of bytes to send.
> - * @return: Returns zero in case of success else the negative error code.
> - */
> -static int st33zp24_i2c_send(struct udevice *dev, const u8 *buf, size_t len)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -       u32 i, size;
> -       int burstcnt, ret, status;
> -       u8 data, tpm_stat;
> -
> -       if (!chip)
> -               return -ENODEV;
> -       if (len < TPM_HEADER_SIZE)
> -               return -EIO;
> -
> -       ret = st33zp24_i2c_request_locality(dev);
> -       if (ret < 0)
> -               return ret;
> -
> -       tpm_stat = st33zp24_i2c_status(dev);
> -       if ((tpm_stat & TPM_STS_COMMAND_READY) == 0) {
> -               st33zp24_i2c_cancel(dev);
> -               if (st33zp24_i2c_wait_for_stat(dev, TPM_STS_COMMAND_READY,
> -                                              chip->timeout_b, &status) < 0) {
> -                       ret = -ETIME;
> -                       goto out_err;
> -               }
> -       }
> -
> -       for (i = 0; i < len - 1;) {
> -               burstcnt = st33zp24_i2c_get_burstcount(dev);
> -               if (burstcnt < 0)
> -                       return burstcnt;
> -
> -               size = min_t(int, len - i - 1, burstcnt);
> -               ret = st33zp24_i2c_write(dev, TPM_DATA_FIFO, buf + i, size);
> -               if (ret < 0)
> -                       goto out_err;
> -
> -               i += size;
> -       }
> -
> -       tpm_stat = st33zp24_i2c_status(dev);
> -       if ((tpm_stat & TPM_STS_DATA_EXPECT) == 0) {
> -               ret = -EIO;
> -               goto out_err;
> -       }
> -
> -       ret = st33zp24_i2c_write(dev, TPM_DATA_FIFO, buf + len - 1, 1);
> -       if (ret < 0)
> -               goto out_err;
> -
> -       tpm_stat = st33zp24_i2c_status(dev);
> -       if ((tpm_stat & TPM_STS_DATA_EXPECT) != 0) {
> -               ret = -EIO;
> -               goto out_err;
> -       }
> -
> -       data = TPM_STS_GO;
> -       ret = st33zp24_i2c_write(dev, TPM_STS, &data, 1);
> -       if (ret < 0)
> -               goto out_err;
> -
> -       return len;
> -
> -out_err:
> -       st33zp24_i2c_cancel(dev);
> -       st33zp24_i2c_release_locality(dev);
> -
> -       return ret;
> -}
> -
> -static int st33zp24_i2c_cleanup(struct udevice *dev)
> -{
> -       st33zp24_i2c_cancel(dev);
> -       /*
> -        * The TPM needs some time to clean up here,
> -        * so we sleep rather than keeping the bus busy
> -        */
> -       mdelay(2);
> -       st33zp24_i2c_release_locality(dev);
> -
> -       return 0;
> -}
> -
> -static int st33zp24_i2c_init(struct udevice *dev)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -
> -       chip->is_open = 1;
> -
> -       /* Default timeouts - these could move to the device tree */
> -       chip->timeout_a = TIS_SHORT_TIMEOUT_MS;
> -       chip->timeout_b = TIS_LONG_TIMEOUT_MS;
> -       chip->timeout_c = TIS_SHORT_TIMEOUT_MS;
> -       chip->timeout_d = TIS_SHORT_TIMEOUT_MS;
> -
> -       chip->locality = LOCALITY0;
> -
> -       /*
> -        * A timeout query to TPM can be placed here.
> -        * Standard timeout values are used so far
> -        */
> -
> -       return 0;
> -}
> -
> -static int st33zp24_i2c_open(struct udevice *dev)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -       int rc;
> -
> -       debug("%s: start\n", __func__);
> -       if (chip->is_open)
> -               return -EBUSY;
> -
> -       rc = st33zp24_i2c_init(dev);
> -       if (rc < 0)
> -               chip->is_open = 0;
> -
> -       return rc;
> -}
> -
> -static int st33zp24_i2c_close(struct udevice *dev)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -
> -       if (chip->is_open) {
> -               st33zp24_i2c_release_locality(dev);
> -               chip->is_open = 0;
> -               chip->vend_dev = 0;
> -       }
> -
> -       return 0;
> -}
> -
> -static int st33zp24_i2c_get_desc(struct udevice *dev, char *buf, int size)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -
> -       if (size < 50)
> -               return -ENOSPC;
> -
> -       return snprintf(buf, size, "1.2 TPM (%s, chip type %s device-id 0x%x)",
> -                       chip->is_open ? "open" : "closed",
> -                       dev->name,
> -                       chip->vend_dev >> 16);
> -}
> -
> -static const struct tpm_ops st33zp24_i2c_tpm_ops = {
> -       .open = st33zp24_i2c_open,
> -       .close = st33zp24_i2c_close,
> -       .recv = st33zp24_i2c_recv,
> -       .send = st33zp24_i2c_send,
> -       .cleanup = st33zp24_i2c_cleanup,
> -       .get_desc = st33zp24_i2c_get_desc,
> -};
> -
> -static int st33zp24_i2c_probe(struct udevice *dev)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -
> -       /* Default timeouts */
> -       chip->timeout_a = TIS_SHORT_TIMEOUT_MS;
> -       chip->timeout_b = TIS_LONG_TIMEOUT_MS;
> -       chip->timeout_c = TIS_SHORT_TIMEOUT_MS;
> -       chip->timeout_d = TIS_SHORT_TIMEOUT_MS;
> -
> -       chip->locality = LOCALITY0;
> -
> -       i2c_set_chip_offset_len(dev, 0);
> -
> -       debug("ST33ZP24 I2C TPM from STMicroelectronics found\n");
> -
> -       return 0;
> -}
> -
> -static int st33zp24_i2c_remove(struct udevice *dev)
> -{
> -       st33zp24_i2c_release_locality(dev);
> -
> -       return 0;
> -}
> -
> -static const struct udevice_id st33zp24_i2c_ids[] = {
> -       { .compatible = "st,st33zp24-i2c" },
> -       { }
> -};
> -
> -U_BOOT_DRIVER(st33zp24_i2c) = {
> -       .name   = "st33zp24-i2c",
> -       .id     = UCLASS_TPM,
> -       .of_match = of_match_ptr(st33zp24_i2c_ids),
> -       .probe  = st33zp24_i2c_probe,
> -       .remove = st33zp24_i2c_remove,
> -       .ops = &st33zp24_i2c_tpm_ops,
> -       .priv_auto      = sizeof(struct tpm_chip),
> -};
> diff --git a/drivers/tpm/tpm_tis_st33zp24_spi.c b/drivers/tpm/tpm_tis_st33zp24_spi.c
> deleted file mode 100644
> index 2cf690328d87..000000000000
> --- a/drivers/tpm/tpm_tis_st33zp24_spi.c
> +++ /dev/null
> @@ -1,674 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * STMicroelectronics TPM ST33ZP24 SPI UBOOT driver
> - *
> - * Copyright (C) 2016, STMicroelectronics - All Rights Reserved
> - * Author(s): Christophe Ricard <christophe-h.ricard@st.com> for STMicroelectronics.
> - *
> - * Description: Device driver for ST33ZP24 SPI TPM TCG.
> - *
> - * This device driver implements the TPM interface as defined in
> - * the TCG TPM Interface Spec version 1.21, revision 1.0 and the
> - * STMicroelectronics Protocol Stack Specification version 1.2.0.
> - */
> -
> -#include <dm.h>
> -#include <fdtdec.h>
> -#include <log.h>
> -#include <spi.h>
> -#include <tpm-v1.h>
> -#include <errno.h>
> -#include <linux/delay.h>
> -#include <linux/types.h>
> -#include <asm/unaligned.h>
> -#include <linux/compat.h>
> -
> -#include "tpm_tis.h"
> -#include "tpm_internal.h"
> -
> -#define TPM_ACCESS                     0x0
> -#define TPM_STS                                0x18
> -#define TPM_DATA_FIFO                  0x24
> -
> -#define LOCALITY0                      0
> -
> -#define TPM_DATA_FIFO                          0x24
> -#define TPM_INTF_CAPABILITY                    0x14
> -
> -#define TPM_DUMMY_BYTE                         0x00
> -#define TPM_WRITE_DIRECTION                    0x80
> -
> -#define MAX_SPI_LATENCY                                15
> -#define LOCALITY0                              0
> -
> -#define ST33ZP24_OK                                    0x5A
> -#define ST33ZP24_UNDEFINED_ERR                         0x80
> -#define ST33ZP24_BADLOCALITY                           0x81
> -#define ST33ZP24_TISREGISTER_UKNOWN                    0x82
> -#define ST33ZP24_LOCALITY_NOT_ACTIVATED                        0x83
> -#define ST33ZP24_HASH_END_BEFORE_HASH_START            0x84
> -#define ST33ZP24_BAD_COMMAND_ORDER                     0x85
> -#define ST33ZP24_INCORECT_RECEIVED_LENGTH              0x86
> -#define ST33ZP24_TPM_FIFO_OVERFLOW                     0x89
> -#define ST33ZP24_UNEXPECTED_READ_FIFO                  0x8A
> -#define ST33ZP24_UNEXPECTED_WRITE_FIFO                 0x8B
> -#define ST33ZP24_CMDRDY_SET_WHEN_PROCESSING_HASH_END   0x90
> -#define ST33ZP24_DUMMY_BYTES                           0x00
> -
> -/*
> - * TPM command can be up to 2048 byte, A TPM response can be up to
> - * 1024 byte.
> - * Between command and response, there are latency byte (up to 15
> - * usually on st33zp24 2 are enough).
> - *
> - * Overall when sending a command and expecting an answer we need if
> - * worst case:
> - * 2048 (for the TPM command) + 1024 (for the TPM answer).  We need
> - * some latency byte before the answer is available (max 15).
> - * We have 2048 + 1024 + 15.
> - */
> -#define ST33ZP24_SPI_BUFFER_SIZE (TPM_BUFSIZE + (TPM_BUFSIZE / 2) +\
> -                                 MAX_SPI_LATENCY)
> -
> -struct st33zp24_spi_phy {
> -       int latency;
> -
> -       u8 tx_buf[ST33ZP24_SPI_BUFFER_SIZE];
> -       u8 rx_buf[ST33ZP24_SPI_BUFFER_SIZE];
> -};
> -
> -static int st33zp24_spi_status_to_errno(u8 code)
> -{
> -       switch (code) {
> -       case ST33ZP24_OK:
> -               return 0;
> -       case ST33ZP24_UNDEFINED_ERR:
> -       case ST33ZP24_BADLOCALITY:
> -       case ST33ZP24_TISREGISTER_UKNOWN:
> -       case ST33ZP24_LOCALITY_NOT_ACTIVATED:
> -       case ST33ZP24_HASH_END_BEFORE_HASH_START:
> -       case ST33ZP24_BAD_COMMAND_ORDER:
> -       case ST33ZP24_UNEXPECTED_READ_FIFO:
> -       case ST33ZP24_UNEXPECTED_WRITE_FIFO:
> -       case ST33ZP24_CMDRDY_SET_WHEN_PROCESSING_HASH_END:
> -               return -EPROTO;
> -       case ST33ZP24_INCORECT_RECEIVED_LENGTH:
> -       case ST33ZP24_TPM_FIFO_OVERFLOW:
> -               return -EMSGSIZE;
> -       case ST33ZP24_DUMMY_BYTES:
> -               return -ENOSYS;
> -       }
> -       return code;
> -}
> -
> -/*
> - * st33zp24_spi_send
> - * Send byte to TPM register according to the ST33ZP24 SPI protocol.
> - * @param: tpm, the chip description
> - * @param: tpm_register, the tpm tis register where the data should be written
> - * @param: tpm_data, the tpm_data to write inside the tpm_register
> - * @param: tpm_size, The length of the data
> - * @return: should be zero if success else a negative error code.
> - */
> -static int st33zp24_spi_write(struct udevice *dev, u8 tpm_register,
> -                             const u8 *tpm_data, size_t tpm_size)
> -{
> -       int total_length = 0, ret;
> -       struct spi_slave *slave = dev_get_parent_priv(dev);
> -       struct st33zp24_spi_phy *phy = dev_get_plat(dev);
> -
> -       u8 *tx_buf = (u8 *)phy->tx_buf;
> -       u8 *rx_buf = phy->rx_buf;
> -
> -       tx_buf[total_length++] = TPM_WRITE_DIRECTION | LOCALITY0;
> -       tx_buf[total_length++] = tpm_register;
> -
> -       if (tpm_size > 0 && tpm_register == TPM_DATA_FIFO) {
> -               tx_buf[total_length++] = tpm_size >> 8;
> -               tx_buf[total_length++] = tpm_size;
> -       }
> -       memcpy(tx_buf + total_length, tpm_data, tpm_size);
> -       total_length += tpm_size;
> -
> -       memset(tx_buf + total_length, TPM_DUMMY_BYTE, phy->latency);
> -
> -       total_length += phy->latency;
> -
> -       ret = spi_claim_bus(slave);
> -       if (ret < 0)
> -               return ret;
> -
> -       ret = spi_xfer(slave, total_length * 8, tx_buf, rx_buf,
> -                      SPI_XFER_BEGIN | SPI_XFER_END);
> -       if (ret < 0)
> -               return ret;
> -
> -       spi_release_bus(slave);
> -
> -       if (ret == 0)
> -               ret = rx_buf[total_length - 1];
> -
> -       return st33zp24_spi_status_to_errno(ret);
> -}
> -
> -/*
> - * spi_st33zp24_spi_read8_reg
> - * Recv byte from the TIS register according to the ST33ZP24 SPI protocol.
> - * @param: tpm, the chip description
> - * @param: tpm_loc, the locality to read register from
> - * @param: tpm_register, the tpm tis register where the data should be read
> - * @param: tpm_data, the TPM response
> - * @param: tpm_size, tpm TPM response size to read.
> - * @return: should be zero if success else a negative error code.
> - */
> -static u8 st33zp24_spi_read8_reg(struct udevice *dev, u8 tpm_register,
> -                                u8 *tpm_data, size_t tpm_size)
> -{
> -       int total_length = 0, ret;
> -       struct spi_slave *slave = dev_get_parent_priv(dev);
> -       struct st33zp24_spi_phy *phy = dev_get_plat(dev);
> -
> -       u8 *tx_buf = (u8 *)phy->tx_buf;
> -       u8 *rx_buf = phy->rx_buf;
> -
> -       /* Pre-Header */
> -       tx_buf[total_length++] = LOCALITY0;
> -       tx_buf[total_length++] = tpm_register;
> -
> -       memset(&tx_buf[total_length], TPM_DUMMY_BYTE,
> -              phy->latency + tpm_size);
> -       total_length += phy->latency + tpm_size;
> -
> -       ret = spi_claim_bus(slave);
> -       if (ret < 0)
> -               return 0;
> -
> -       ret = spi_xfer(slave, total_length * 8, tx_buf, rx_buf,
> -                      SPI_XFER_BEGIN | SPI_XFER_END);
> -       if (ret < 0)
> -               return 0;
> -
> -       spi_release_bus(slave);
> -
> -       if (tpm_size > 0 && ret == 0) {
> -               ret = rx_buf[total_length - tpm_size - 1];
> -               memcpy(tpm_data, rx_buf + total_length - tpm_size, tpm_size);
> -       }
> -       return ret;
> -}
> -
> -/*
> - * st33zp24_spi_recv
> - * Recv byte from the TIS register according to the ST33ZP24 SPI protocol.
> - * @param: phy_id, the phy description
> - * @param: tpm_register, the tpm tis register where the data should be read
> - * @param: tpm_data, the TPM response
> - * @param: tpm_size, tpm TPM response size to read.
> - * @return: number of byte read successfully: should be one if success.
> - */
> -static int st33zp24_spi_read(struct udevice *dev, u8 tpm_register,
> -                            u8 *tpm_data, size_t tpm_size)
> -{
> -       int ret;
> -
> -       ret = st33zp24_spi_read8_reg(dev, tpm_register, tpm_data, tpm_size);
> -       if (!st33zp24_spi_status_to_errno(ret))
> -               return tpm_size;
> -
> -       return ret;
> -}
> -
> -static int st33zp24_spi_evaluate_latency(struct udevice *dev)
> -{
> -       int latency = 1, status = 0;
> -       u8 data = 0;
> -       struct st33zp24_spi_phy *phy = dev_get_plat(dev);
> -
> -       while (!status && latency < MAX_SPI_LATENCY) {
> -               phy->latency = latency;
> -               status = st33zp24_spi_read8_reg(dev, TPM_INTF_CAPABILITY,
> -                                               &data, 1);
> -               latency++;
> -       }
> -       if (status < 0)
> -               return status;
> -       if (latency == MAX_SPI_LATENCY)
> -               return -ENODEV;
> -
> -       return latency - 1;
> -}
> -
> -/*
> - * st33zp24_spi_release_locality release the active locality
> - * @param: chip, the tpm chip description.
> - */
> -static void st33zp24_spi_release_locality(struct udevice *dev)
> -{
> -       u8 data = TPM_ACCESS_ACTIVE_LOCALITY;
> -
> -       st33zp24_spi_write(dev, TPM_ACCESS, &data, 1);
> -}
> -
> -/*
> - * st33zp24_spi_check_locality if the locality is active
> - * @param: chip, the tpm chip description
> - * @return: the active locality or -EACCES.
> - */
> -static int st33zp24_spi_check_locality(struct udevice *dev)
> -{
> -       u8 data;
> -       u8 status;
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -
> -       status = st33zp24_spi_read(dev, TPM_ACCESS, &data, 1);
> -       if (status && (data &
> -               (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) ==
> -               (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID))
> -               return chip->locality;
> -
> -       return -EACCES;
> -}
> -
> -/*
> - * st33zp24_spi_request_locality request the TPM locality
> - * @param: chip, the chip description
> - * @return: the active locality or negative value.
> - */
> -static int st33zp24_spi_request_locality(struct udevice *dev)
> -{
> -       unsigned long start, stop;
> -       long ret;
> -       u8 data;
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -
> -       if (st33zp24_spi_check_locality(dev) == chip->locality)
> -               return chip->locality;
> -
> -       data = TPM_ACCESS_REQUEST_USE;
> -       ret = st33zp24_spi_write(dev, TPM_ACCESS, &data, 1);
> -       if (ret < 0)
> -               return ret;
> -
> -       /* wait for locality activated */
> -       start = get_timer(0);
> -       stop = chip->timeout_a;
> -       do {
> -               if (st33zp24_spi_check_locality(dev) >= 0)
> -                       return chip->locality;
> -               udelay(TPM_TIMEOUT_MS * 1000);
> -       } while  (get_timer(start) < stop);
> -
> -       return -EACCES;
> -}
> -
> -/*
> - * st33zp24_spi_status return the TPM_STS register
> - * @param: chip, the tpm chip description
> - * @return: the TPM_STS register value.
> - */
> -static u8 st33zp24_spi_status(struct udevice *dev)
> -{
> -       u8 data;
> -
> -       st33zp24_spi_read(dev, TPM_STS, &data, 1);
> -       return data;
> -}
> -
> -/*
> - * st33zp24_spi_get_burstcount return the burstcount address 0x19 0x1A
> - * @param: chip, the chip description
> - * return: the burstcount or -TPM_DRIVER_ERR in case of error.
> - */
> -static int st33zp24_spi_get_burstcount(struct udevice *dev)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -       unsigned long start, stop;
> -       int burstcnt, status;
> -       u8 tpm_reg, temp;
> -
> -       /* wait for burstcount */
> -       start = get_timer(0);
> -       stop = chip->timeout_d;
> -       do {
> -               tpm_reg = TPM_STS + 1;
> -               status = st33zp24_spi_read(dev, tpm_reg, &temp, 1);
> -               if (status < 0)
> -                       return -EBUSY;
> -
> -               tpm_reg = TPM_STS + 2;
> -               burstcnt = temp;
> -               status = st33zp24_spi_read(dev, tpm_reg, &temp, 1);
> -               if (status < 0)
> -                       return -EBUSY;
> -
> -               burstcnt |= temp << 8;
> -               if (burstcnt)
> -                       return burstcnt;
> -               udelay(TIS_SHORT_TIMEOUT_MS * 1000);
> -       } while (get_timer(start) < stop);
> -
> -       return -EBUSY;
> -}
> -
> -/*
> - * st33zp24_spi_cancel, cancel the current command execution or
> - * set STS to COMMAND READY.
> - * @param: chip, tpm_chip description.
> - */
> -static void st33zp24_spi_cancel(struct udevice *dev)
> -{
> -       u8 data;
> -
> -       data = TPM_STS_COMMAND_READY;
> -       st33zp24_spi_write(dev, TPM_STS, &data, 1);
> -}
> -
> -/*
> - * st33zp24_spi_wait_for_stat wait for a TPM_STS value
> - * @param: chip, the tpm chip description
> - * @param: mask, the value mask to wait
> - * @param: timeout, the timeout
> - * @param: status,
> - * @return: the tpm status, 0 if success, -ETIME if timeout is reached.
> - */
> -static int st33zp24_spi_wait_for_stat(struct udevice *dev, u8 mask,
> -                                 unsigned long timeout, int *status)
> -{
> -       unsigned long start, stop;
> -
> -       /* Check current status */
> -       *status = st33zp24_spi_status(dev);
> -       if ((*status & mask) == mask)
> -               return 0;
> -
> -       start = get_timer(0);
> -       stop = timeout;
> -       do {
> -               udelay(TPM_TIMEOUT_MS * 1000);
> -               *status = st33zp24_spi_status(dev);
> -               if ((*status & mask) == mask)
> -                       return 0;
> -       } while (get_timer(start) < stop);
> -
> -       return -ETIME;
> -}
> -
> -/*
> - * st33zp24_spi_recv_data receive data
> - * @param: chip, the tpm chip description
> - * @param: buf, the buffer where the data are received
> - * @param: count, the number of data to receive
> - * @return: the number of bytes read from TPM FIFO.
> - */
> -static int st33zp24_spi_recv_data(struct udevice *dev, u8 *buf, size_t count)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -       int size = 0, burstcnt, len, ret, status;
> -
> -       while (size < count &&
> -              st33zp24_spi_wait_for_stat(dev, TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> -                               chip->timeout_c, &status) == 0) {
> -               burstcnt = st33zp24_spi_get_burstcount(dev);
> -               if (burstcnt < 0)
> -                       return burstcnt;
> -               len = min_t(int, burstcnt, count - size);
> -               ret = st33zp24_spi_read(dev, TPM_DATA_FIFO, buf + size, len);
> -               if (ret < 0)
> -                       return ret;
> -
> -               size += len;
> -       }
> -       return size;
> -}
> -
> -/*
> - * st33zp24_spi_recv received TPM response through TPM phy.
> - * @param: chip, tpm_chip description.
> - * @param: buf,        the buffer to store data.
> - * @param: count, the number of bytes that can received (sizeof buf).
> - * @return: Returns zero in case of success else -EIO.
> - */
> -static int st33zp24_spi_recv(struct udevice *dev, u8 *buf, size_t count)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -       int size;
> -       unsigned int expected;
> -
> -       if (!chip)
> -               return -ENODEV;
> -
> -       if (count < TPM_HEADER_SIZE) {
> -               size = -EIO;
> -               goto out;
> -       }
> -
> -       size = st33zp24_spi_recv_data(dev, buf, TPM_HEADER_SIZE);
> -       if (size < TPM_HEADER_SIZE) {
> -               debug("TPM error, unable to read header\n");
> -               goto out;
> -       }
> -
> -       expected = get_unaligned_be32(buf + 2);
> -       if (expected > count || expected < TPM_HEADER_SIZE) {
> -               size = -EIO;
> -               goto out;
> -       }
> -
> -       size += st33zp24_spi_recv_data(dev, &buf[TPM_HEADER_SIZE],
> -                                  expected - TPM_HEADER_SIZE);
> -       if (size < expected) {
> -               debug("TPM error, unable to read remaining bytes of result\n");
> -               size = -EIO;
> -               goto out;
> -       }
> -
> -out:
> -       st33zp24_spi_cancel(dev);
> -       st33zp24_spi_release_locality(dev);
> -
> -       return size;
> -}
> -
> -/*
> - * st33zp24_spi_send send TPM commands through TPM phy.
> - * @param: chip, tpm_chip description.
> - * @param: buf,        the buffer to send.
> - * @param: len, the number of bytes to send.
> - * @return: Returns zero in case of success else the negative error code.
> - */
> -static int st33zp24_spi_send(struct udevice *dev, const u8 *buf, size_t len)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -       u32 i, size;
> -       int burstcnt, ret, status;
> -       u8 data, tpm_stat;
> -
> -       if (!chip)
> -               return -ENODEV;
> -       if (len < TPM_HEADER_SIZE)
> -               return -EIO;
> -
> -       ret = st33zp24_spi_request_locality(dev);
> -       if (ret < 0)
> -               return ret;
> -
> -       tpm_stat = st33zp24_spi_status(dev);
> -       if ((tpm_stat & TPM_STS_COMMAND_READY) == 0) {
> -               st33zp24_spi_cancel(dev);
> -               if (st33zp24_spi_wait_for_stat(dev, TPM_STS_COMMAND_READY,
> -                                              chip->timeout_b, &status) < 0) {
> -                       ret = -ETIME;
> -                       goto out_err;
> -               }
> -       }
> -
> -       for (i = 0; i < len - 1;) {
> -               burstcnt = st33zp24_spi_get_burstcount(dev);
> -               if (burstcnt < 0)
> -                       return burstcnt;
> -
> -               size = min_t(int, len - i - 1, burstcnt);
> -               ret = st33zp24_spi_write(dev, TPM_DATA_FIFO, buf + i, size);
> -               if (ret < 0)
> -                       goto out_err;
> -
> -               i += size;
> -       }
> -
> -       tpm_stat = st33zp24_spi_status(dev);
> -       if ((tpm_stat & TPM_STS_DATA_EXPECT) == 0) {
> -               ret = -EIO;
> -               goto out_err;
> -       }
> -
> -       ret = st33zp24_spi_write(dev, TPM_DATA_FIFO, buf + len - 1, 1);
> -       if (ret < 0)
> -               goto out_err;
> -
> -       tpm_stat = st33zp24_spi_status(dev);
> -       if ((tpm_stat & TPM_STS_DATA_EXPECT) != 0) {
> -               ret = -EIO;
> -               goto out_err;
> -       }
> -
> -       data = TPM_STS_GO;
> -       ret = st33zp24_spi_write(dev, TPM_STS, &data, 1);
> -       if (ret < 0)
> -               goto out_err;
> -
> -       return len;
> -
> -out_err:
> -       st33zp24_spi_cancel(dev);
> -       st33zp24_spi_release_locality(dev);
> -
> -       return ret;
> -}
> -
> -static int st33zp24_spi_cleanup(struct udevice *dev)
> -{
> -       st33zp24_spi_cancel(dev);
> -       /*
> -        * The TPM needs some time to clean up here,
> -        * so we sleep rather than keeping the bus busy
> -        */
> -       mdelay(2);
> -       st33zp24_spi_release_locality(dev);
> -
> -       return 0;
> -}
> -
> -static int st33zp24_spi_init(struct udevice *dev)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -       struct st33zp24_spi_phy *phy = dev_get_plat(dev);
> -
> -       chip->is_open = 1;
> -
> -       /* Default timeouts - these could move to the device tree */
> -       chip->timeout_a = TIS_SHORT_TIMEOUT_MS;
> -       chip->timeout_b = TIS_LONG_TIMEOUT_MS;
> -       chip->timeout_c = TIS_SHORT_TIMEOUT_MS;
> -       chip->timeout_d = TIS_SHORT_TIMEOUT_MS;
> -
> -       chip->locality = LOCALITY0;
> -
> -       phy->latency = st33zp24_spi_evaluate_latency(dev);
> -       if (phy->latency <= 0)
> -               return -ENODEV;
> -
> -       /*
> -        * A timeout query to TPM can be placed here.
> -        * Standard timeout values are used so far
> -        */
> -
> -       return 0;
> -}
> -
> -static int st33zp24_spi_open(struct udevice *dev)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -       int rc;
> -
> -       debug("%s: start\n", __func__);
> -       if (chip->is_open)
> -               return -EBUSY;
> -
> -       rc = st33zp24_spi_init(dev);
> -       if (rc < 0)
> -               chip->is_open = 0;
> -
> -       return rc;
> -}
> -
> -static int st33zp24_spi_close(struct udevice *dev)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -
> -       if (chip->is_open) {
> -               st33zp24_spi_release_locality(dev);
> -               chip->is_open = 0;
> -               chip->vend_dev = 0;
> -       }
> -
> -       return 0;
> -}
> -
> -static int st33zp24_spi_get_desc(struct udevice *dev, char *buf, int size)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -
> -       if (size < 50)
> -               return -ENOSPC;
> -
> -       return snprintf(buf, size, "1.2 TPM (%s, chip type %s device-id 0x%x)",
> -                       chip->is_open ? "open" : "closed",
> -                       dev->name,
> -                       chip->vend_dev >> 16);
> -}
> -
> -const struct tpm_ops st33zp24_spi_tpm_ops = {
> -       .open = st33zp24_spi_open,
> -       .close = st33zp24_spi_close,
> -       .recv = st33zp24_spi_recv,
> -       .send = st33zp24_spi_send,
> -       .cleanup = st33zp24_spi_cleanup,
> -       .get_desc = st33zp24_spi_get_desc,
> -};
> -
> -static int st33zp24_spi_probe(struct udevice *dev)
> -{
> -       struct tpm_chip_priv *uc_priv = dev_get_uclass_priv(dev);
> -
> -       uc_priv->duration_ms[TPM_SHORT] = TIS_SHORT_TIMEOUT_MS;
> -       uc_priv->duration_ms[TPM_MEDIUM] = TIS_LONG_TIMEOUT_MS;
> -       uc_priv->duration_ms[TPM_LONG] = TIS_LONG_TIMEOUT_MS;
> -       uc_priv->retry_time_ms = TPM_TIMEOUT_MS;
> -
> -       debug("ST33ZP24 SPI TPM from STMicroelectronics found\n");
> -
> -       return 0;
> -}
> -
> -static int st33zp24_spi_remove(struct udevice *dev)
> -{
> -       st33zp24_spi_release_locality(dev);
> -
> -       return 0;
> -}
> -
> -static const struct udevice_id st33zp24_spi_ids[] = {
> -       { .compatible = "st,st33zp24-spi" },
> -       { }
> -};
> -
> -U_BOOT_DRIVER(st33zp24_spi_spi) = {
> -       .name   = "st33zp24-spi",
> -       .id     = UCLASS_TPM,
> -       .of_match = of_match_ptr(st33zp24_spi_ids),
> -       .probe  = st33zp24_spi_probe,
> -       .remove = st33zp24_spi_remove,
> -       .ops = &st33zp24_spi_tpm_ops,
> -       .priv_auto      = sizeof(struct tpm_chip),
> -       .plat_auto      = sizeof(struct st33zp24_spi_phy),
> -};
> --
> 2.43.0
>
