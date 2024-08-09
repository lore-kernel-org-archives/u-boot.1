Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8366AC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 15:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6F6188B36;
	Fri,  9 Aug 2024 17:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fSchD9tS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7084788B9B; Fri,  9 Aug 2024 17:58:02 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 270BE88600
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 17:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b7b349a98aso18116466d6.3
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723219079; x=1723823879; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4vBuVOOdkx0ivvIlg8NmwaK4ET/6crdDzRMRmR8d0dI=;
 b=fSchD9tSYdmSFBqGANlTXrFXLX/gpAaQtmT8YrC5Vdn20tUeZtnjgmPyO3JSMGvfAo
 2yoo6MG0laswwkm/nQYRnRQu7IyhVlu3VaMCFFeJOUOLKQ8rCxrMq36Ur5y0RQUDRjPH
 5QDLWfH/l8Fauz8IUhykItnJ2bRqYg+/dZPOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723219079; x=1723823879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4vBuVOOdkx0ivvIlg8NmwaK4ET/6crdDzRMRmR8d0dI=;
 b=LsMj9hEHoqXTeDygLAOIPMCKspJ127plxpLHzW3isKVaf/cFCmVma55AZolv5tW5rd
 WeRMPeypDWzecZg25o68AGHSizfcAATWFPI7wZoLeRfzdC+Dp1Z5dQtzNFxr5hjpJTOE
 tKTO025PiNoS7HDduKU69sBkR3fgbUh8z2UTFWeh2q5W34M54s91S9dihSKWc9FlFBwt
 NTzHDBZPULv/IOYsHiaEcIRwEe/lTQuVgfTM+ECI1N3P6OdGQ0Fx17en4majUeZ4JZoH
 GecwDPtnyQ+2eVyy9aPJFbNSfiBuXTjHfr4cH+BNxGgp4K77ZGravJoqcAzzdHopyDYj
 YIFg==
X-Gm-Message-State: AOJu0YxCGCPykyYl2Wk3GhAtIMP/oMQsrE4LXyfOyX6QaBPUczwTOndN
 babHD/SYan2sM+OLPtjaFTQto/lyT2mk7lRhtous1/ikT8fhTajua5JR4lELm+SQXyDkDdvr5Vt
 iII8Eyupqb6f2OWh2OwiG+lngkO+BPxupOULg
X-Google-Smtp-Source: AGHT+IFWNHiYtEtJyx4u21ciE6TSUXP3epuD2jv1Xr18DG8Cc2eOvP4cgUVIf9d+ph30yjSdpbYQL4+TWPPXDtAUJJc=
X-Received: by 2002:a05:6214:328a:b0:6b5:61:53a9 with SMTP id
 6a1803df08f44-6bd78db4c79mr21623796d6.28.1723219078871; Fri, 09 Aug 2024
 08:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240809093841.1304-1-venkatesh.abbarapu@amd.com>
In-Reply-To: <20240809093841.1304-1-venkatesh.abbarapu@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Aug 2024 09:57:48 -0600
Message-ID: <CAFLszThrXQKh5RFzM1v7Z48qTMEW_QvvQBibS8kY4hcfem0diQ@mail.gmail.com>
Subject: Re: [PATCH] sf: Add lock info option to sf command list
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, jagan@amarulasolutions.com, 
 git@amd.com
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

Hi Venkatesh,

On Fri, 9 Aug 2024 at 03:39, Venkatesh Yadav Abbarapu
<venkatesh.abbarapu@amd.com> wrote:
>
> Many SPI flashes have status/OTP bit for TOP or BOTTOM selection
> in the status register that can protect selected regions of
> the SPI NOR.
>
> Take this bit into consideration while locking the region.
> The command "sf lockinfo" shows whether the flash is TOP or
> BOTTOM protected, based on this info the "offset" is provided to
> the "sf protect lock" command.
>
> Versal> sf erase 0 100000
> SF: 1048576 bytes @ 0x0 Erased: OK
> Versal>sf lockinfo
> Flash is BOTTOM protected
> Versal> sf protect lock 0 20000
> Versal> sf erase 0 20000
> ERROR: flash area is locked
> Versal> sf protect unlock 0 20000
> Versal> sf erase 0 20000
> SF: 131072 bytes @ 0x0 Erased: OK
>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  cmd/sf.c                       | 30 +++++++++++++++++++++++++++++-
>  drivers/mtd/spi/spi-nor-core.c | 16 ++++++++++++++++
>  include/linux/mtd/spi-nor.h    |  1 +
>  include/spi.h                  |  3 +++
>  include/spi_flash.h            |  8 ++++++++
>  5 files changed, 57 insertions(+), 1 deletion(-)

Please can you add to doc/usage/cmd/sf.c and extend the test in
test/dm/sf.c ? Let me know if you need help with the test.

>
> diff --git a/cmd/sf.c b/cmd/sf.c
> index f43a2e08b3..62afa91057 100644
> --- a/cmd/sf.c
> +++ b/cmd/sf.c
> @@ -413,6 +413,30 @@ static int do_spi_protect(int argc, char *const argv[])
>         return ret == 0 ? 0 : 1;
>  }
>
> +static int do_spi_lock_info(int argc, char *const argv[])
> +{
> +       int ret;
> +
> +       if (argc != 1)
> +               return CMD_RET_USAGE;

Shouldn't be needed, see below.

> +
> +       ret = spi_flash_lock_info(flash);
> +       if (ret < 0) {
> +               printf("Flash info is not set\n");
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       if (ret == BOTTOM_PROTECT) {
> +               printf("Flash is BOTTOM protected\n");
> +               return CMD_RET_SUCCESS;
> +       } else if (ret == TOP_PROTECT) {
> +               printf("Flash is TOP protected\n");
> +               return CMD_RET_SUCCESS;

return 0 is better than CMD_RET_SUCCESS, to avoid confusion that
success might be anything other than 0.

> +       }
> +
> +       return CMD_RET_FAILURE;
> +}
> +
>  enum {
>         STAGE_ERASE,
>         STAGE_CHECK,
> @@ -607,6 +631,8 @@ static int do_spi_flash(struct cmd_tbl *cmdtp, int flag, int argc,
>                 ret = do_spi_flash_erase(argc, argv);
>         else if (IS_ENABLED(CONFIG_SPI_FLASH_LOCK) && strcmp(cmd, "protect") == 0)
>                 ret = do_spi_protect(argc, argv);
> +       else if (IS_ENABLED(CONFIG_SPI_FLASH_LOCK) && strcmp(cmd, "lockinfo") == 0)
> +               ret = do_spi_lock_info(argc, argv);

Eek this is a mess. Before adding your feature, please create a patch
to refactor this code to use U_BOOT_CMD_WITH_SUBCMDS() like other
commands with subcommands.

>         else if (IS_ENABLED(CONFIG_CMD_SF_TEST) && !strcmp(cmd, "test"))
>                 ret = do_spi_flash_test(argc, argv);
>         else
> @@ -632,7 +658,9 @@ U_BOOT_LONGHELP(sf,
>         "                                         or to start of mtd `partition'\n"
>  #ifdef CONFIG_SPI_FLASH_LOCK
>         "sf protect lock/unlock sector len      - protect/unprotect 'len' bytes starting\n"
> -       "                                         at address 'sector'"
> +       "                                         at address 'sector'\n"
> +       "sf lockinfo                            - shows whether the flash locking is top or bottom\n"
> +       "                                         protected\n"
>  #endif
>  #ifdef CONFIG_CMD_SF_TEST
>         "\nsf test offset len           - run a very basic destructive test"
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index aea611fef5..2114be1e61 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -1410,6 +1410,21 @@ static int stm_is_unlocked(struct spi_nor *nor, loff_t ofs, uint64_t len)
>
>         return stm_is_unlocked_sr(nor, ofs, len, status);
>  }
> +
> +static bool stm_lock_info(struct spi_nor *nor)
> +{
> +       int status;
> +
> +       status = read_sr(nor);
> +       if (status < 0)
> +               return status;
> +
> +       if (status & SR_TB)
> +               return BOTTOM_PROTECT;
> +
> +       return TOP_PROTECT;
> +}
> +
>  #endif /* CONFIG_SPI_FLASH_STMICRO */
>  #endif
>
> @@ -4145,6 +4160,7 @@ int spi_nor_scan(struct spi_nor *nor)
>                 nor->flash_lock = stm_lock;
>                 nor->flash_unlock = stm_unlock;
>                 nor->flash_is_unlocked = stm_is_unlocked;
> +               nor->flash_lock_info = stm_lock_info;
>         }
>  #endif
>
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index d1dbf3eadb..48d39a7052 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -580,6 +580,7 @@ struct spi_nor {
>         int (*quad_enable)(struct spi_nor *nor);
>         int (*octal_dtr_enable)(struct spi_nor *nor);
>         int (*ready)(struct spi_nor *nor);
> +       bool (*flash_lock_info)(struct spi_nor *nor);

Are we trying to keep this in sync with Linux mtd? It seems that Linux
has split these ops into a separate struct. We should really be using
an MTD uclass here, I suspect. But that is another discussion...

We have these members:

int (*flash_lock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
int (*flash_unlock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
int (*flash_is_unlocked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
int (*quad_enable)(struct spi_nor *nor);
int (*octal_dtr_enable)(struct spi_nor *nor);
int (*ready)(struct spi_nor *nor);

It seems to me that we need to sort this out a bit one day. But for
now (and your patch), how about a lock_info() call which fills in a
new 'struct spi_nor_info' with all the useful info? Then you can put
your bool in that struct and we can extend it to other things as
needed.

>
>         struct {
>                 struct spi_mem_dirmap_desc *rdesc;
> diff --git a/include/spi.h b/include/spi.h
> index 7e38cc2a2a..46d27f7564 100644
> --- a/include/spi.h
> +++ b/include/spi.h
> @@ -38,6 +38,9 @@
>
>  #define SPI_DEFAULT_WORDLEN    8
>
> +#define BOTTOM_PROTECT         1
> +#define TOP_PROTECT            0
> +
>  /**
>   * struct dm_spi_bus - SPI bus info
>   *
> diff --git a/include/spi_flash.h b/include/spi_flash.h
> index 10d19fd4b1..b8a6456fe4 100644
> --- a/include/spi_flash.h
> +++ b/include/spi_flash.h
> @@ -202,4 +202,12 @@ static inline int spi_flash_protect(struct spi_flash *flash, u32 ofs, u32 len,
>                 return flash->flash_unlock(flash, ofs, len);
>  }
>
> +static inline int spi_flash_lock_info(struct spi_flash *flash)
> +{
> +       if (!flash->flash_lock_info)
> +               return -EOPNOTSUPP;
> +
> +       return flash->flash_lock_info(flash);
> +}
> +
>  #endif /* _SPI_FLASH_H_ */
> --
> 2.17.1
>

Regards,
SImon
