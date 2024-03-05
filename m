Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E55FC54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 09:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D37C87FFD;
	Tue,  5 Mar 2024 10:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ax0Ech9U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D40E487EEF; Tue,  5 Mar 2024 10:01:40 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1110387FFF
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 10:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5132010e5d1so612206e87.0
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 01:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709629297; x=1710234097; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PlR1J3vEvtKhOCMbr5UZSB3LBeZ3MpapfDlr5pLWEbM=;
 b=ax0Ech9U/U5OYgQ7bz5JheNqcFbDSuLOGgWz76FrTgLUVOLvD/aGPTVbaBnfK0fWYK
 DHkxDOez91zLVPBk2qHw+URhnPlFA4VpMo+s9Q8ZOS/wfCYkntqasZndKWfh9ACZzbAX
 evU8uqOy4AzJbPXWO69fhMdWQBUr/WgwdKytDqTA0rdt8gB89bqVs/fzc66DxC7eS5TL
 zL5P7JsjYjnlM1QnPfRxXJc0QGG/tzOAXVDuGo+fI6CN7YZYEyLzqMcGVzQjbGDY0bPN
 63m+eMm03YZ+qGMI1gmNF4BO4qBI9gBlBH+MAJ10slDSYNXrHVCD5WQwk9+IobRn2bvG
 06vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709629297; x=1710234097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PlR1J3vEvtKhOCMbr5UZSB3LBeZ3MpapfDlr5pLWEbM=;
 b=osoG+75xG4nVIBlUdie3s7W0j05JzNBE4PFcxxs5AFVp7+wzOU/OiC+yyaOscIUmHC
 TC5mnbNZrEu3cX7woRlh2019qv/VKd6HnZahos1u6yFbD1NCmEjNThzNKy1ezzTV1pil
 6h6j4PieRYaRgjPJ7HyB8cp58Dk58Vncyxi373WYdZhpt/YMqVOLTcf85nM+WCpAACVr
 D4Hx7OU6ywapJe5XLm7z5/YVE2SnL8nP5FvT8XIf+bnpiruSp/CsvME9LSVNajumdlor
 IKS9qDE+dHkfQLKV/x2ZtnE8DDokThfniHXdTIhkypEJac6LRyvHv4shTeD1dADjM6XF
 oWtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSdNHc9ECLR+ScpS4ZDDqxbY0+Ot+9dN+LSVix43UJyavb7+ZlaewvL0wkHrqIEqc2eY9m5/NwbCLrVsLMvOmSq/JsDg==
X-Gm-Message-State: AOJu0Yx83FqRYWY2E5rr4OlQEAJnHzS3RMwhhH/bPruxs+/t8W8Sf1sp
 NSn1DbV7UVZVWvHvGQ5NvfYPdxr5NUxY+pdISffIXKWmA9NSSb1xuzMCW1XwDR89pxnLfD2KtCf
 7tQ6ju6d8YO3yV0R/KCehb+cDUjC+dGXKudZm/Q==
X-Google-Smtp-Source: AGHT+IGvN2o0eCi8dn7TiiQKK8+Lyv3Ju9Lh3spxbo/Ww9dQk0RQ8HPxQ5zj+hUtRWd4UeD4tIcTUhV/2hjlEQWFsnc=
X-Received: by 2002:a19:8c1b:0:b0:513:472c:1f50 with SMTP id
 o27-20020a198c1b000000b00513472c1f50mr877831lfd.52.1709629297152; Tue, 05 Mar
 2024 01:01:37 -0800 (PST)
MIME-Version: 1.0
References: <20240302112034.593441-1-pbrobinson@gmail.com>
In-Reply-To: <20240302112034.593441-1-pbrobinson@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 Mar 2024 11:01:00 +0200
Message-ID: <CAC_iWj+uiYqXbFLru7fvk10S_Ob3K+JQuSeGL4q+HtmscfuAEA@mail.gmail.com>
Subject: Re: [PATCH v4] disk: dos: Add all options for EFI System Partitions
To: Peter Robinson <pbrobinson@gmail.com>
Cc: mark.kettenis@xs4all.nl, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Sat, 2 Mar 2024 at 13:20, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> The EFI spec states that the ESP can be any of FAT12/16/32 but for
> compatibility doesn't necssarily require the partition to be the
> EFI partition table ID of 0xef. A number of arm devices will not
> find their firmware on a FAT partition with an ID of 0xef so also
> allow the original FAT12/16/32 partition IDs as they are also
> permissable for an ESP.
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>
> v2:
> - Add 0x0c option
> - Make hex constants consistent
> - Move from if to switch statement
> v3:
> - Fix switch brain fart
> v4:
> - Drop boot_ind out of switch
>
>  disk/part_dos.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/disk/part_dos.c b/disk/part_dos.c
> index 567ead7511d..a35181dff4f 100644
> --- a/disk/part_dos.c
> +++ b/disk/part_dos.c
> @@ -40,10 +40,21 @@ static int get_bootable(dos_partition_t *p)
>  {
>         int ret = 0;
>
> -       if (p->sys_ind == 0xef)
> +       switch (p->sys_ind) {
> +       case 0x01:
> +       case 0x06:
> +       case 0x0b:
> +       case 0x0c:
> +       case 0xef:
>                 ret |= PART_EFI_SYSTEM_PARTITION;
> +               break;
> +       default:
> +               break;
> +       }
> +
>         if (p->boot_ind == 0x80)
>                 ret |= PART_BOOTABLE;
> +
>         return ret;
>  }
>
> --
> 2.44.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
