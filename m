Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F203C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA80688854;
	Wed, 22 May 2024 18:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sL+sTtao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE84887F19; Wed, 22 May 2024 18:06:45 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4A8D88854
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-51f40b5e059so7336538e87.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716394003; x=1716998803; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D13nBv7LSY+DHtSjumEY2rg/MSTJbkrdO1Z4wHMsg/A=;
 b=sL+sTtaoC8Fs0ybXYclfuSVF6UJAo9RDgPbyqmqB7gAETsG2wFoLndRijBW9B1Vrc7
 hcIA8ikvA6PVDoOkXR8s1U8U53xZlXBd5SIeEZlYnN0Stev+SkLuFP7fdZmANdwqvF+5
 gPCCfH24sGrwtGZROGMxGleLD3GtPgrH1/RkfM/NsJwb3ABVVdtGdmVJ/fXcxr/no5sf
 KbGn+dEBHXBaQ85RJpH/pP4pbXo8XGY9egu1ffB2u1czF02QAQNIvXcfB4/KpGAEs7gx
 CYomI12r37AihbB6ILOcfW8o2+w+i4rBVdqanI4iRfM3wYSNceZvH07vLcNYyMmJfr4X
 v8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716394003; x=1716998803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D13nBv7LSY+DHtSjumEY2rg/MSTJbkrdO1Z4wHMsg/A=;
 b=D6QjFTHIX5GgGJV2cKHnf4LA8gfkRVICHCzsU+uJbfr8bsW+yV2T6b5mmmGdP0NynD
 eYePjeWdPBsK4iVh01+uUXpL+CWtKhHgGL5c6eZGiNNU+IfUX5UIvVZKhckeX7SGz5iK
 I+syv8dpL6vv0fwq9pRFjIj9GR5DLj0wQklKwyblSLoDMI72Eht/s9VEncl7+nhzAB9D
 Gnn+wW5bg0dAp0ygV0JFzxyYMbJFLimKIGzjwc0FS3K4pbiGZPgr794xFwmM5DwObwnN
 3X7SdXDTY11CG9M0Afd/+CB/h0JOi4pFWYjW9Y2lbMZoqI0sFelaKQXakCKC7YEed5UH
 l39w==
X-Gm-Message-State: AOJu0YyTlHey63ENRxZTyufBQYOpVYJEFhUy4EW7T/Gm71y3PBmOAFrJ
 2Jax2bv+3M8KjzgCW6Wq5gQ7LqsS0YbhYe9wYsJ4CsXm057En2/ROCl0F4F217UIXI4XmRYYQHe
 Xi04xGTa/VrMM0q+e+Xtcwjuniy3oJvxYpFX1YA==
X-Google-Smtp-Source: AGHT+IEeVWnrg8CCnz4mZP+g+y/2s7mjYzzuOzMyFK2oomsuNKnF+nNPHMQiWpMDA0QrJXFvh0aAnOxIutABRUsYhXg=
X-Received: by 2002:ac2:5e22:0:b0:51a:b933:b297 with SMTP id
 2adb3069b0e04-526bd694d3cmr1460567e87.2.1716394002879; Wed, 22 May 2024
 09:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <c5bfc875954340d5dffb57c6bce0b4a9a99f6051.1716393035.git.jerome.forissier@linaro.org>
In-Reply-To: <c5bfc875954340d5dffb57c6bce0b4a9a99f6051.1716393035.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 22 May 2024 19:06:07 +0300
Message-ID: <CAC_iWj+4QpvzQm5Qk07jyU-vYEsO=BC3u2pH7keBnj8Uj_j-bg@mail.gmail.com>
Subject: Re: [PATCH 11/15] cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nikhil M Jain <n-jain1@ti.com>
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

On Wed, 22 May 2024 at 19:04, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Support "bdinfo -e" when lwIP is selected.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  cmd/bdinfo.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
> index 79106caeec..690fb894bf 100644
> --- a/cmd/bdinfo.c
> +++ b/cmd/bdinfo.c
> @@ -152,7 +152,7 @@ static int bdinfo_print_all(struct bd_info *bd)
>         bdinfo_print_num_l("relocaddr", gd->relocaddr);
>         bdinfo_print_num_l("reloc off", gd->reloc_off);
>         printf("%-12s= %u-bit\n", "Build", (uint)sizeof(void *) * 8);
> -       if (IS_ENABLED(CONFIG_CMD_NET))
> +       if (IS_ENABLED(CONFIG_CMD_NET) || IS_ENABLED(CONFIG_CMD_NET_LWIP))
>                 print_eth();
>         bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_blob));
>         bdinfo_print_num_l("new_fdt", (ulong)map_to_sysmem(gd->new_fdt));
> @@ -198,7 +198,8 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>                 case 'a':
>                         return bdinfo_print_all(bd);
>                 case 'e':
> -                       if (!IS_ENABLED(CONFIG_CMD_NET))
> +                       if (!IS_ENABLED(CONFIG_CMD_NET) &&
> +                           !IS_ENABLED(CONFIG_CMD_NET_LWIP))
>                                 return CMD_RET_USAGE;
>                         print_eth();
>                         return CMD_RET_SUCCESS;
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
