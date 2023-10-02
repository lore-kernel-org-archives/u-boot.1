Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E11EE74911
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 18:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F047887143;
	Mon,  2 Oct 2023 20:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="2xuj6WI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E6948716D; Mon,  2 Oct 2023 20:56:36 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0482D87143
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 20:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9b1ebc80d0aso9761466b.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696272993; x=1696877793; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NDG2HaN+eaTG7EnFFcUkm/llwti1SOGm3EOG2FhNXrw=;
 b=2xuj6WI7MP90SEc1ZLB2EEF9BtAN/9ST97jWu+PXikHdRb/GWHUcUsk7oA4to/JjdV
 K1p/Ngcd0tT5Z26oOY4svUYyoUogP+E7vXs8hScYvn/7+rZxSaC1Bi978jeu/aoPh0yQ
 rz4nss3GdngF07vSpi7pBrwvexXZPRXk7/7z9asXy2HKRsnIUCMog8IrfsjDyRSrsI8L
 F6lh9fabEZ6WGc0Qd+t7hn6T/2wKGKafhhQ7Rc2wmnF4jnQZMNkyH2Ho5njUzAoaRThV
 Fnb9bopAfah+h+tqhtniBj7s2TAyBXYa1zWE+yxQ+7eOrcd3XHL4nElijHggsbeYXoDv
 Ev9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696272993; x=1696877793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NDG2HaN+eaTG7EnFFcUkm/llwti1SOGm3EOG2FhNXrw=;
 b=Wygq8wLcv35gAhJPxHxN0lZEVOaqdBrvxfC9QcrLuZcPY7o718q/MQ4uQlWKT8X6Pb
 grWJ0/53LX+xUtQ3ZbkzHXYok91XkrZ+qwhBYiVAuBZ8pAZVnu3D4lSDZBDLx40oejM3
 eRh0BfjPYdaggbupOJg3INVeFVo/bYKzmyux56XfAMzeZxMMi36MxketMMghSihbLhGr
 ZNw43pXh5rUHd4lsgZgzFQCVVycEfeXX8XJUdzBXPCa+wlgwI/Mh9DvVnCI/BJS1YxIf
 bQNFGoZicdWfbW3byRxxzk359GiTXVDiUtfNPTG/AV+qqwFg55xIwM2WOx7U4Ecr9n5Y
 fK9w==
X-Gm-Message-State: AOJu0YzgvpppE9+kuwVZ6uENT0M5gSOEUJMqBVPg744idb86XhHp8d9I
 hJrSUWU08Qgo7T1WFofAbyM0FIh122m6kwjzHoAxZg==
X-Google-Smtp-Source: AGHT+IGRaCM8kVoDSpwv7XDTzO6ux+PK7oEP3nAw2UHVK+QJdtPxPYXrXjesX7BtqthFOpyrZXkxbQOhZ+7e9fLnUQI=
X-Received: by 2002:a17:906:8a49:b0:9a5:d095:a8e1 with SMTP id
 gx9-20020a1709068a4900b009a5d095a8e1mr10532936ejc.11.1696272993308; Mon, 02
 Oct 2023 11:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230929230655.2932698-1-jonas@kwiboo.se>
In-Reply-To: <20230929230655.2932698-1-jonas@kwiboo.se>
From: Simon Glass <sjg@google.com>
Date: Mon, 2 Oct 2023 12:56:22 -0600
Message-ID: <CAPnjgZ2O7kxiRt9j3forPPjm=R5EgmLdZKVrwVbyR156YhNDpw@mail.gmail.com>
Subject: Re: [RFC] mmc: Remove alignment hole for cmdidx in struct mmc_cmd
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Ferass El Hafidi <vitali64pmemail@protonmail.com>
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

On Fri, 29 Sept 2023 at 17:07, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The alignment hole caused by cmdidx in struct mmc_cmd cause strange
> issues together with the peephole2 optimization on Amlogic SoCs.
> Following was observed while working on SPL support for Amlogic SoCs.
>
> sd_get_capabilities() normally issue a CMD55 followed by a CMD51.
> However, on at least Amlogic S905 (Cortex-A53) and S905X3 (Cortex-A55),
> CMD55 was instead followed by CMD8 (and a few reties) in SPL.
>
> Code from the call site:
>
>   cmd.cmdidx = SD_CMD_APP_SEND_SCR; // 51
>   ...
>   data.blocksize = 8;
>   ...
>   err = mmc_send_cmd_retry(mmc, &cmd, &data, 3);
>
> Running the code with MMC_TRACE enabled shows:
>
> CMD_SEND:55
>                 ARG                      0x50480000
>                 MMC_RSP_R1,5,6,7         0x00000920
> CMD_SEND:8
>                 ARG                      0x00000000
>                 RET                      -110
>
> Removing the alignment hole by changing cmdidx from ushort to uint or
> building with -fno-peephole2 flag seem to resolve this issue.
>
> CMD_SEND:55
>                 ARG                      0x50480000
>                 MMC_RSP_R1,5,6,7         0x00000920
> CMD_SEND:51
>                 ARG                      0x00000000
>                 MMC_RSP_R1,5,6,7         0x00000920
>
> Same issue was observed building U-Boot with gcc 8-13. Please advise on
> how to best work around this possible gcc optimization bug.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  arch/arm/cpu/armv8/config.mk | 2 ++
>  include/mmc.h                | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/cpu/armv8/config.mk b/arch/arm/cpu/armv8/config.mk
> index 4d74b2a533e0..7177dcd7c73b 100644
> --- a/arch/arm/cpu/armv8/config.mk
> +++ b/arch/arm/cpu/armv8/config.mk
> @@ -7,6 +7,8 @@ PLATFORM_RELFLAGS += $(call cc-option,-mbranch-protection=none)
>  PF_NO_UNALIGNED := $(call cc-option, -mstrict-align)
>  PLATFORM_CPPFLAGS += $(PF_NO_UNALIGNED)
>
> +PLATFORM_CPPFLAGS += $(call cc-option,-fno-peephole2)

Eek really?

> +
>  EFI_LDS := elf_aarch64_efi.lds
>  EFI_CRT0 := crt0_aarch64_efi.o
>  EFI_RELOC := reloc_aarch64_efi.o
> diff --git a/include/mmc.h b/include/mmc.h
> index 9aef31ea5deb..7b3868bb5664 100644
> --- a/include/mmc.h
> +++ b/include/mmc.h
> @@ -413,7 +413,7 @@ struct mmc_cid {
>  };
>
>  struct mmc_cmd {
> -       ushort cmdidx;
> +       uint cmdidx;

This bit looks OK.

>         uint resp_type;
>         uint cmdarg;
>         uint response[4];
> --
> 2.42.0
>

Regards,
Simon
