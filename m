Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40055C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 07:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED5F682063;
	Thu,  3 Jul 2025 09:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hY9d3ehb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70EF082063; Thu,  3 Jul 2025 09:58:00 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3047181FEE
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 09:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4a44e94f0b0so104983281cf.1
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 00:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751529477; x=1752134277; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KoEExJjNoqKaCsC1kKBxOLL6PKfPsNG0q4+F+NNrGYU=;
 b=hY9d3ehbdhiMLvig1Xq/ZtbQPLIFG3a5MnDGDCq6js5BomZtBrjNevjCpiqIJzUujK
 9jxJkqtdw6KrGt29cQ8L7mKQ2Zdh86AuCOU+11C1nv7XjNAMf3qlraB9YnXbvmr/4Q3n
 2N+7RheWR601IiI5DB/Te0Uu5s9Zcfx43r+gvGWJhc9rMTlQ9VH2+tuwWj+c81hu9vgE
 rgFE6szivCJR6A8lned8aOtUMcTeCsNAMfDrdrB3jU66S96IarfnHiH+OC55XlWOoRwB
 hQgOJ3MxWFN/fQXzDqloWpIdpjJTnSBK2eMubvbCqBt/UKQTgENUmGIaBaZdHBEYiiGR
 F6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751529477; x=1752134277;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KoEExJjNoqKaCsC1kKBxOLL6PKfPsNG0q4+F+NNrGYU=;
 b=rjGeb/Kt5g0nLFzVLZqxwz3Jm4ongarTztausqwJu8vhiu63SNLb/fjZD/xLiPzjvk
 vxvkCYAJKbHLw6AqYk3poG2SNdNnxwGp0HwnYQt18NYG1tDwkoxISVhWES/ghueTtOQ0
 LdPbSfwlk+JtL5JdH85QPNXLFwujPWZNax4bIm0I30SDvFUMTbodpccTBlxLXhOrNYCD
 vsK+hJL2FjQNZvMToJdo6mURmYSjtQyAplKCB2Y/JZUsx/qaFIQKGpysKg32zp1+l0qA
 SIvhQidQS7l345N8wKHJBi3he8FuULT1OwNBrolhoY4SyYFTaKwLFsUFW25G4WfV0P28
 wCiA==
X-Gm-Message-State: AOJu0YzQ744CL1ot5XPVKmlLNN6mwF2fWz3wc/amfc94ua2IZV1/eT/+
 PCVS8p+jk7MuAXVc2w1tsU2s5j23IMvPDrPVmO5V9MY6jDdTKG44cIco1rus9DPqodpkvuszPiG
 YXEj63kGWz2iUhF0Kcq9ee3OLd2/lKGYdBKq2O8aSpw==
X-Gm-Gg: ASbGnct/UCTMz/LLqRQE/ec0/uWZqc2Fs1UDfTxNumP8Elr/dm3hs8nEYIzS6Ep6HNs
 KS3YQvjrsby5PRgPhPGgcGcn9ShBbYYX9V5ECeaqT3cmj9jnnzh3ufCwj81ywUK1AN8E+2aDl/n
 j8//WqpDda2/8p6KwGhgxrauH4YwTR17khppITusvJUTtx
X-Google-Smtp-Source: AGHT+IFqTklvIMHzatcBfB2DE1wwdyIpgutuuyu7X/8NepUepcuOQdMZBG5kPtF78vpORF2hbdCY73QoU/JfW25nfrQ=
X-Received: by 2002:ac8:640c:0:b0:4a6:f416:48b6 with SMTP id
 d75a77b69052e-4a9776d0d5emr75724501cf.28.1751529476739; Thu, 03 Jul 2025
 00:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250616094531.4158505-1-padmarao.begari@amd.com>
 <20250616094531.4158505-2-padmarao.begari@amd.com>
In-Reply-To: <20250616094531.4158505-2-padmarao.begari@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 3 Jul 2025 13:27:45 +0530
X-Gm-Features: Ac12FXy_F8eHnJoDghiCrZTocn9PdaxJzOFhSNw08bTTb29QFHjaPNhVwor6M_o
Message-ID: <CADg8p95sJScq7XbnppMQWgm5i1f1Cv45tOc1n5gNj650ZGz83A@mail.gmail.com>
Subject: Re: [PATCH 1/2] FWU: Add platform hook support for fwu metadata
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, michal.simek@amd.com, 
 venkatesh.abbarapu@amd.com, ilias.apalodimas@linaro.org
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

On Mon, 16 Jun 2025 at 15:15, Padmarao Begari <padmarao.begari@amd.com> wrote:
>
> FWU metadata information is unavailable for platform-specific
> operations since FWU initialization has not yet occurred.
> The initialization function is invoked as part of the main
> loop event. To address this, the FWU platform hook function
> is introduced during FWU initialization, allowing metadata
> processing with platform-specific operations.
>
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>  drivers/fwu-mdata/fwu-mdata-uclass.c | 17 +++++++++++++++
>  drivers/fwu-mdata/raw_mtd.c          |  6 ++++++
>  include/fwu.h                        | 32 ++++++++++++++++++++++++++++
>  lib/fwu_updates/fwu.c                |  8 +++++++
>  4 files changed, 63 insertions(+)
>
> diff --git a/drivers/fwu-mdata/fwu-mdata-uclass.c b/drivers/fwu-mdata/fwu-mdata-uclass.c
> index 92abb94dcc9..f63ee234c87 100644
> --- a/drivers/fwu-mdata/fwu-mdata-uclass.c
> +++ b/drivers/fwu-mdata/fwu-mdata-uclass.c
> @@ -50,6 +50,23 @@ int fwu_write_mdata(struct udevice *dev, struct fwu_mdata *mdata, bool primary,
>         return ops->write_mdata(dev, mdata, primary, size);
>  }
>
> +/**
> + * fwu_platform_hook() - Wrapper around fwu_mdata_ops.platform_hook()
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int fwu_platform_hook(struct udevice *dev, struct fwu_data *data)
> +{
> +       const struct fwu_mdata_ops *ops = device_get_ops(dev);
> +
> +       if (!ops->platform_hook) {
> +               log_debug("platform_hook() method not defined\n");
> +               return -ENOSYS;
> +       }
> +
> +       return ops->platform_hook(dev, data);
> +}
> +
>  UCLASS_DRIVER(fwu_mdata) = {
>         .id             = UCLASS_FWU_MDATA,
>         .name           = "fwu-mdata",
> diff --git a/drivers/fwu-mdata/raw_mtd.c b/drivers/fwu-mdata/raw_mtd.c
> index 78a709f766c..f7542474632 100644
> --- a/drivers/fwu-mdata/raw_mtd.c
> +++ b/drivers/fwu-mdata/raw_mtd.c
> @@ -106,6 +106,11 @@ static int fwu_mtd_write_mdata(struct udevice *dev, struct fwu_mdata *mdata,
>         return mtd_io_data(mtd, offs, size, mdata, FWU_MTD_WRITE);
>  }
>
> +__weak int fwu_mtd_platform_hook(struct udevice *dev, struct fwu_data *data)
> +{
> +       return 0;
> +}
> +
>  static int flash_partition_offset(struct udevice *dev, const char *part_name, fdt_addr_t *offset)
>  {
>         ofnode node, parts_node;
> @@ -272,6 +277,7 @@ static int fwu_mdata_mtd_probe(struct udevice *dev)
>  static struct fwu_mdata_ops fwu_mtd_ops = {
>         .read_mdata = fwu_mtd_read_mdata,
>         .write_mdata = fwu_mtd_write_mdata,
> +       .platform_hook = fwu_mtd_platform_hook,
>  };

Instead of doing this through the driver, it would be much easier to
just defined a weak platform hook function, and then have the actual
one in the platform specific code. We are not adding any value by
going through the driver, as this is not a generic function.

-sughosh

>
>  static const struct udevice_id fwu_mdata_ids[] = {
> diff --git a/include/fwu.h b/include/fwu.h
> index 6441de370c9..65797190f3e 100644
> --- a/include/fwu.h
> +++ b/include/fwu.h
> @@ -77,6 +77,15 @@ struct fwu_mdata_ops {
>          */
>         int (*write_mdata)(struct udevice *dev, struct fwu_mdata *mdata,
>                            bool primary, uint32_t size);
> +
> +       /**
> +        * platform_hook() - Hook the given FWU data copy
> +        * @dev: FWU metadata device
> +        * @data: Copy of the FWU metadata to hook
> +        *
> +        * Return: 0 if OK, -ve on error
> +        */
> +       int (*platform_hook)(struct udevice *dev, struct fwu_data *data);
>  };
>
>  #define FWU_IMAGE_ACCEPTED     0x1
> @@ -129,6 +138,29 @@ int fwu_read_mdata(struct udevice *dev, struct fwu_mdata *mdata,
>  int fwu_write_mdata(struct udevice *dev, struct fwu_mdata *mdata,
>                     bool primary, uint32_t size);
>
> +/**
> + * fwu_platform_hook() - Wrapper around fwu_mdata_ops.platform_hook()
> + * @dev: FWU metadata device
> + * @data: FWU metadata
> + *
> + * It is a platform-specific function that processes fwu metadata.
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int fwu_platform_hook(struct udevice *dev, struct fwu_data *data);
> +
> +/**
> + * fwu_mtd_platform_hook() - Hook the given FWU data copy
> + * @dev: FWU metadata device
> + * @data: FWU metadata
> +
> + * This function extracts the FWU metadata and prepares it for processing.
> + *
> + * Return: 0 if OK, -ve on error
> + *
> + */
> +int fwu_mtd_platform_hook(struct udevice *dev, struct fwu_data *data);
> +
>  /**
>   * fwu_get_mdata() - Read, verify and return the FWU metadata
>   *
> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> index 7f085a0211f..47aa6fad1ab 100644
> --- a/lib/fwu_updates/fwu.c
> +++ b/lib/fwu_updates/fwu.c
> @@ -712,6 +712,7 @@ static int fwu_boottime_checks(void)
>  {
>         int ret;
>         u32 boot_idx, active_idx;
> +       struct fwu_data *data;
>
>         ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
>         if (ret) {
> @@ -770,6 +771,13 @@ static int fwu_boottime_checks(void)
>         if (!ret)
>                 boottime_check = 1;
>
> +       data = fwu_get_data();
> +       ret = fwu_platform_hook(g_dev, data);
> +       if (ret && ret != -ENOSYS) {
> +               log_err("fwu_platform_hook() failed\n");
> +               return ret;
> +       }
> +
>         return 0;
>  }
>  EVENT_SPY_SIMPLE(EVT_MAIN_LOOP, fwu_boottime_checks);
> --
> 2.25.1
>
