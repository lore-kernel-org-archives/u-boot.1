Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAACBC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 10:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 680E581ECD;
	Fri, 28 Mar 2025 11:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fNenXFI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6931E81ED8; Fri, 28 Mar 2025 11:45:08 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 649CD805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 11:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5e22e6ed2so2873744a12.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 03:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743158702; x=1743763502; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G1LMkIDZHdqYbSrrSUk7268hmXt+362sRH4D79SBWRg=;
 b=fNenXFI6P/FlcjLh0Dca7dswrB3Ix0bziXlOTD+twpR9HD1K89Hh/XKi1s6ByejAZS
 S6VdB1i4TJK6AYTNywNyMOmroTBDoyRiw8E86rQEqunS7jGnmdaZlkMh5qBqbuwS7+hK
 nUJQ0sM6RK4dBjUpQdDenWpzsbR5KyPXPew/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743158702; x=1743763502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G1LMkIDZHdqYbSrrSUk7268hmXt+362sRH4D79SBWRg=;
 b=lZBk64FS5PJwIUTQE1uo1mnPZZp6pb/OJDf4JpJZ++wPwTvykNGdi+bP8jVDykwB+d
 wOrM0Khay1wKnqrTc0XN9Zf3nvM5JLan4oFoh+kez/DTx+sUY9qrrJnEkT1/31vIoX1/
 V7oWOM/7g6a7EILSQSUg0Llx4Up5xeaoxj1ZIMq1Tmcy8pKMgIDZKMuAiEXxHmdeoEan
 82uWHnirV84txnk0lSU/pqWjNr+VYR5zAnF1R38oKkbT3sw0ykiZx0A5PDf7DQLKKCju
 BaWxYxfO0HugLj9+X3LR4HcYmI9q5KVRH1iGnCVwlq+DHI21lThpHmfGaHyUrHujpTrA
 MoSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUzBYM1GYvkGy9aBscjPBcVL1d4IBGr3IPkGHn2lEW6tguM8V9Z0j8orOCWu8iw1eJ4Rz4gm0=@lists.denx.de
X-Gm-Message-State: AOJu0YzMR17P06N7l47RqUhRGx+7Hulc5m/WVIs/RknGkgBlwoWZul4h
 EI1BIF/0TbzGX4FAbB0gfnwQlChFl2sqX3CpC9ZOVbrXNDJ60prc+uHx10c8X/iJ9W65AJWQUlJ
 2mJiatdLihu0mF/86rpWEMtIdA+vD+9xx0dIY
X-Gm-Gg: ASbGncv2U7z4GjePO4L3nar9i+6u6eMQ4FeuLABYFbuQ/I41WWQtFxdleO32xlOgW7M
 ZMi3RufbAuWKCV4uqxTAFyh5SJnRTayOzjevYQXTfFrHkPDGJM7l7dYX+cIiYolw0d+/DaSN9L7
 wj+CmCBK4zapG+TLjlZmJKJwUUCS4=
X-Google-Smtp-Source: AGHT+IEHwhZQm4Rax6w6GKbnNYmChY/7u5D7sRzL83vJEboh1UKX4dQuVMBKyFaGQ1WBh7MXZQMW9TcO2dIEYEHnULI=
X-Received: by 2002:a17:906:fd85:b0:ac6:f5ab:592b with SMTP id
 a640c23a62f3a-ac6fae622eamr691528666b.5.1743158701845; Fri, 28 Mar 2025
 03:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250324100121.2490314-1-quic_varada@quicinc.com>
 <20250324100121.2490314-2-quic_varada@quicinc.com>
In-Reply-To: <20250324100121.2490314-2-quic_varada@quicinc.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 04:44:48 -0600
X-Gm-Features: AQ5f1JqsH_FKdeczzssiRoVsqKTUYzkacey9o3mQTcXiJB2eyaDqIP3NKHRpra4
Message-ID: <CAFLszTgcmA+p32F8EoeKuUJeNF6HrgxZ9PWYP6gOtD55AJCHvw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drivers: scsi: Add 'erase' support
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: caleb.connolly@linaro.org, trini@konsulko.com, 
 marek.vasut+renesas@mailbox.org, neil.armstrong@linaro.org, lehmanju@devpi.de, 
 u-boot@lists.denx.de
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

Hi Varadarajan,

On Mon, 24 Mar 2025 at 04:02, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> UFS devices uses the block and scsi frameworks. Enable UFS erase
> support by adding erase support to SCSI.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  cmd/scsi.c          |  3 +-
>  drivers/scsi/scsi.c | 92 +++++++++++++++++++++++++++++++++++++++++++++
>  include/scsi.h      | 13 +++++++
>  3 files changed, 107 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/scsi.c b/cmd/scsi.c
> index c286bdc0726..9f7613424e5 100644
> --- a/cmd/scsi.c
> +++ b/cmd/scsi.c
> @@ -60,7 +60,8 @@ U_BOOT_CMD(
>         "scsi read addr blk# cnt - read `cnt' blocks starting at block `blk#'\n"
>         "     to memory address `addr'\n"
>         "scsi write addr blk# cnt - write `cnt' blocks starting at block\n"
> -       "     `blk#' from memory address `addr'"
> +       "     `blk#' from memory address `addr'\n"
> +       "scsi erase blk# cnt - erase `cnt' blocks starting at block `blk#'"
>  );
>
>  U_BOOT_CMD(
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index cd0b84c0622..dc93392642d 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -28,6 +28,10 @@ DEFINE_CACHE_ALIGN_BUFFER(u8, tempbuff, 512);        /* temporary data buffer */
>  #define SCSI_MAX_BLK 0xFFFF
>  #define SCSI_LBA48_READ        0xFFFFFFF
>
> +#define SCSI_UNMAP_PARAM_RESERVED 0
> +#define SCSI_UNMAP_PARAM_LEN 22
> +#define SCSI_UNMAP_PARAM_DATA_LEN 16
> +
>  static void scsi_print_error(struct scsi_cmd *pccb)
>  {
>         /* Dummy function that could print an error for debugging */
> @@ -121,6 +125,51 @@ static void scsi_setup_write_ext(struct scsi_cmd *pccb, lbaint_t start,
>               pccb->cmd[7], pccb->cmd[8]);
>  }
>
> +static void scsi_setup_erase_ext(struct scsi_cmd *pccb, lbaint_t start,
> +                                unsigned short blocks)
> +{
> +       u8 *param = tempbuff;
> +       const u8 param_size = 24;
> +
> +       memset(param, 0, param_size);
> +       param[0] = SCSI_UNMAP_PARAM_RESERVED;
> +       param[1] = SCSI_UNMAP_PARAM_LEN;
> +       param[2] = SCSI_UNMAP_PARAM_RESERVED;
> +       param[3] = SCSI_UNMAP_PARAM_DATA_LEN;
> +
> +       param[8]  = 0x0;
> +       param[9]  = 0x0;
> +       param[10] = 0x0;
> +       param[11] = 0x0;
> +       param[12] = (start >> 24) & 0xff;
> +       param[13] = (start >> 16) & 0xff;
> +       param[14] = (start >> 8) & 0xff;
> +       param[15] = (start) & 0xff;
> +       param[16] = (blocks >> 24) & 0xff;
> +       param[17] = (blocks >> 16) & 0xff;
> +       param[18] = (blocks >> 8) & 0xff;
> +       param[19] = (blocks) & 0xff;
> +
> +       memset(pccb->cmd, 0, sizeof(pccb->cmd));
> +       pccb->cmd[0] = SCSI_UNMAP;
> +       pccb->cmd[1] = 0;
> +       pccb->cmd[6] = 0;
> +       pccb->cmd[7] = 0;
> +       pccb->cmd[8] = param_size;
> +       pccb->cmd[9] = 0;
> +       pccb->cmdlen = 10;
> +
> +       pccb->pdata = param;
> +       pccb->datalen = param_size;
> +       pccb->dma_dir = DMA_TO_DEVICE;
> +
> +       debug("%s: cmd: %02X %02X startblk %02X%02X%02X%02X blccnt %02X%02X\n",
> +             __func__,
> +             pccb->cmd[0], pccb->cmd[1],
> +             pccb->cmd[2], pccb->cmd[3], pccb->cmd[4], pccb->cmd[5],
> +             pccb->cmd[7], pccb->cmd[8]);
> +}
> +
>  static ulong scsi_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>                        void *buffer)
>  {
> @@ -245,6 +294,48 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>         return blkcnt;
>  }
>
> +/*******************************************************************************
> + * scsi_erase
> + */
> +static ulong scsi_erase(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt)
> +{
> +       struct blk_desc *block_dev = dev_get_uclass_plat(dev);
> +       struct udevice *bdev = dev->parent;
> +       struct scsi_plat *uc_plat = dev_get_uclass_plat(bdev);
> +       lbaint_t start, blks, max_blks;
> +       struct scsi_cmd *pccb = (struct scsi_cmd *)&tempccb;
> +
> +       /* Setup device */
> +       pccb->target = block_dev->target;
> +       pccb->lun = block_dev->lun;
> +       start = blknr;
> +       blks = blkcnt;
> +       if (uc_plat->max_bytes_per_req)
> +               max_blks = uc_plat->max_bytes_per_req / block_dev->blksz;
> +       else
> +               max_blks = SCSI_MAX_BLK;
> +
> +       debug("\n%s: dev %d startblk " LBAF ", blccnt " LBAF "\n",
> +             __func__, block_dev->devnum, start, blks);
> +       do {
> +               if (blks > max_blks) {
> +                       scsi_setup_erase_ext(pccb, start, max_blks);
> +                       start += max_blks;
> +                       blks -= max_blks;
> +               } else {
> +                       scsi_setup_erase_ext(pccb, start, blks);
> +                       start += blks;
> +                       blks = 0;
> +               }
> +               if (scsi_exec(bdev, pccb)) {
> +                       scsi_print_error(pccb);
> +                       blkcnt -= blks;
> +                       break;
> +               }
> +       } while (blks != 0);
> +       return blkcnt;
> +}
> +
>  #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
>  static int scsi_buffer_aligned(struct udevice *dev, struct bounce_buffer *state)
>  {
> @@ -592,6 +683,7 @@ int scsi_scan(bool verbose)
>  static const struct blk_ops scsi_blk_ops = {
>         .read   = scsi_read,
>         .write  = scsi_write,
> +       .erase  = scsi_erase,
>  #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
>         .buffer_aligned = scsi_buffer_aligned,
>  #endif /* CONFIG_BOUNCE_BUFFER */
> diff --git a/include/scsi.h b/include/scsi.h
> index b18ae37b861..d6b6e6b665f 100644
> --- a/include/scsi.h
> +++ b/include/scsi.h
> @@ -9,6 +9,7 @@
>  #include <asm/cache.h>
>  #include <bouncebuf.h>
>  #include <linux/dma-direction.h>
> +#include <part.h>
>
>  struct udevice;
>
> @@ -181,6 +182,7 @@ struct scsi_cmd {
>  #define SCSI_WRT_VERIFY        0x2E            /* Write and Verify (O) */
>  #define SCSI_WRITE_LONG        0x3F            /* Write Long (O) */
>  #define SCSI_WRITE_SAME        0x41            /* Write Same (O) */
> +#define SCSI_UNMAP     0x42            /* Write 10-Byte (MANDATORY) */
>
>  /**
>   * enum scsi_cmd_phase - current phase of the SCSI protocol
> @@ -349,6 +351,17 @@ int scsi_scan(bool verbose);
>   */
>  int scsi_scan_dev(struct udevice *dev, bool verbose);
>
> +/**
> + * scsi_get_blk() - Provides SCSI partition information.
> + *
> + * @partition_name: Partition name for fetching its info
> + * @blk_desc_ptr:   Provides the blk descriptor
> + * @part_info_ptr:  Provides partition info
> + */
> +int scsi_get_blk(const char *partition_name,
> +                struct blk_desc **blk_desc_ptr,
> +                struct disk_partition *part_info_ptr);
> +
>  #define SCSI_IDENTIFY                                  0xC0  /* not used */
>
>  /* Hardware errors  */
> --
> 2.34.1
>

For testing purposes, could you please implement this method in
drivers/scsi/sandbox_scsi.c() and then try to erase the block in
test/dm/scsi.c ?

Regards,
Simon
