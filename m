Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EF5C36000
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BCB5807D7;
	Fri, 21 Mar 2025 08:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MFzoAfqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C504E808A2; Fri, 21 Mar 2025 08:40:50 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6955F805C8
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-86c29c0acdfso716998241.3
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742542847; x=1743147647; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NwA9GZS4iBdK6FrWwsAC0lMYDLuDXyylr8KZqiHPyvk=;
 b=MFzoAfqm70turb4JVdmcBltB/DoA7E3L1cBL+7IVLNscXkGn9LwqC+Def/cxVoo+xZ
 2SMJI5rw/hsPI0MSXXWXUfC7fr4VFuRuhG8HN+x0RXaLeekl9UzD1Dar3+UdoO4+LiG6
 vkrjDdiK8MyYzbc1gSDn8CxbLfSiscK1S3qhO2iWqnR5whdeOf7WXCt1JvDtHgoXwarZ
 VmAzPRZedCJTxJ9s7wq/suyC45WQMmUrDD0xnvbEJsGAp/jP5BEIuLMNHtw5c/OFh+GD
 nckHYAFGuENyH4gjfXoqNFoxQXUa49hAiN5Q7G/kuoJb8G82QtUhp/kfLM+9z5QXTBz9
 RPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742542847; x=1743147647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NwA9GZS4iBdK6FrWwsAC0lMYDLuDXyylr8KZqiHPyvk=;
 b=qYkvxPORQNbMuKf6L+wIa4TmAnbHQjXjYpl46C1+4LeaFCT+KLZ5eqdsc9C3ttipa2
 3IGyGFZNkMCmtnjJNaaw0HVCb2HQY0+8VbvkHsyJrJ99meV6prarZI9RHFjn6SnxCBzW
 B9gunJTYCRysyEsH/PFgEnnJkHMy+i0pfJ0qNfBW0PxNrekbEY0WIKbkXjytH5ZEa8pL
 9SaN+BhlfEVryOz2FUDknV1AcluHkG3M0XfcfQTsbrvbMCZs88+t6y1MXYu4sdi8/fbj
 VA24dPqaFOYCYbYq023w9HcGINcIw4oLpW3YalbJJLpMftbm/dOoofPH2qrx/hTq8TM4
 FiNQ==
X-Gm-Message-State: AOJu0Yx1VNEReCqgdcgoDlzDT/nKE4R0jCjoxPaWcUrXEEoT4+XLI5AG
 mQi8jmsKzd/VrD1gWxfd+ipMfM/ML1w7UjzwYBK234L3MiPfs27kQPckba8tXISrsD+yrxACKfW
 31CCheyflB14i87N7tlNAEivAlBbI2SzCULy18Q==
X-Gm-Gg: ASbGncvcxQJagzn5NmrzL5jN+EDU2mKyH9DLSqTVApqyeaRTM8It2TZy4YkB+j5OICT
 bML/dPSOAMuQyNJuBzutK8PveuEp9EfnQlCu0z1pxlU6FAhL6kJ8mX0I2ve8LMb4ipX5plFWX1n
 iRN82rTZlBRa/ChGwTd7yYT2neHg8=
X-Google-Smtp-Source: AGHT+IH9sR6drO3YYMpBB9+O2Yw6bPAPL/9a+0R4qHZas/qV6K9pzBRLKJ4fKhPyXOnB5nC+NDZFxgRiDAIrHlljNro=
X-Received: by 2002:a05:6102:3908:b0:4c4:e21f:6481 with SMTP id
 ada2fe7eead31-4c50d47bbbbmr1529186137.4.1742542847235; Fri, 21 Mar 2025
 00:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <75c697a4f819bb5e8649ed658c5a559fb8cd1fd9.1717599342.git.michal.simek@amd.com>
In-Reply-To: <75c697a4f819bb5e8649ed658c5a559fb8cd1fd9.1717599342.git.michal.simek@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 21 Mar 2025 13:10:35 +0530
X-Gm-Features: AQ5f1JqGlrxfzzyiG1fRIz0bxUovETAuAWo-je5A4n30NWiOabUCIEL5KB7CXcg
Message-ID: <CADg8p96oba52R=nSKFg8hprE-BYNNtSuOkswLNi4raW1W770dQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cmd: fwu: Dump custom fields from mdata structure
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Etienne Carriere <etienne.carriere@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Wed, 5 Jun 2024 at 20:25, Michal Simek <michal.simek@amd.com> wrote:
>
> The commit cb9ae40a16f0 ("tools: mkfwumdata: add logic to append vendor
> data to the FWU metadata") added support for adding vendor data to mdata
> structure but it is not visible anywhere that's why extend fwu command to
> dump it.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---

Looks good. Just a couple of nits.

>
> I am using this for some time to check various configurations that's why it
> can be useful for others too.
> Sughosh: Maybe there is better way how to dump it.
> ---
>  cmd/fwu_mdata.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
> index 9c048d69a131..ff6435505167 100644
> --- a/cmd/fwu_mdata.c
> +++ b/cmd/fwu_mdata.c
> @@ -7,6 +7,7 @@
>  #include <dm.h>
>  #include <fwu.h>
>  #include <fwu_mdata.h>
> +#include <hexdump.h>
>  #include <log.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -45,6 +46,30 @@ static void print_mdata(struct fwu_data *data)
>                                img_info->accepted == 0x1 ? "yes" : "no");
>                 }
>         }
> +
> +       if (data->version == 2) {
> +               struct fwu_mdata *mdata = data->fwu_mdata;
> +               struct fwu_fw_store_desc *desc;
> +               void *end;
> +               u32 diff;
> +
> +               /*
> +                * fwu_mdata defines only header that's why taking it as array
> +                * which exactly point to image description location
> +                */
> +               desc = (struct fwu_fw_store_desc *)&mdata[1];
> +
> +               /* Number of entries is taken from for loop - variable i */
> +               end = &desc->img_entry[i];
> +               debug("mdata %p, desc %p, end %p\n", mdata, desc, end);
> +
> +               diff = data->metadata_size - ((void *)end - (void *)mdata);
> +               if (diff) {
> +                       printf("Custom fields covered by CRC 0x%x\n", diff);

It would be better to mention that the value being printed is the
length of the vendor data. Or not print the value.

> +                       print_hex_dump_bytes("CUSTOM ", DUMP_PREFIX_OFFSET,
> +                                            end, diff);
> +               }

Would be better to do a 'select HEXDUMP if FWU_MDATA_V2' under the
CMD_FWU_METADATA config.

With the above changes

Tested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed by: Sughosh Ganu <sughosh.ganu@linaro.org>

-sughosh

> +       }
>  }
>
>  int do_fwu_mdata_read(struct cmd_tbl *cmdtp, int flag,
> --
> 2.40.1
>
