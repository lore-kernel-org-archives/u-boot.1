Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DA8C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 07:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5500E874E0;
	Thu, 28 Dec 2023 08:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KKRugHRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2872874DD; Thu, 28 Dec 2023 08:37:23 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC1D187745
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 08:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ccc5fca3f6so27334511fa.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 23:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703749041; x=1704353841; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dqdbKFYm4jW0Qbvus3uFBjVDd/WBd+Adjje9LXdA+No=;
 b=KKRugHRlHQcINNRaX3rKqAH2Vf5HaxEfHLWexcsnD39sR0iSdIrjGgUm3QOI3S4Wqw
 5y4CqL55E0L3mqAXHMP9eg2CwTU77/KY82i71UjpNGfSxO8Kdz8XmejvBzATBE2bgaOg
 rK9t+uEdvu/SmJrxfj+WWRsGf+PeQNS2GqbzoqH/NDD9z2xE8r8qP48+ngyNppDzi0s7
 wa7gnThhZVYPsUctaxN8H5Kq1PV0m7MzHnhHPNLz3MojgnBvFx2NlvUKZap5RD7vV2fr
 bfe5bQOYBQeE+ckHiouz/3YWKNaWTc0ejOmlndN/mgPwllD4PO6d/dGIn0zIc0tnQTQh
 Q4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703749041; x=1704353841;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dqdbKFYm4jW0Qbvus3uFBjVDd/WBd+Adjje9LXdA+No=;
 b=YAujAxb9I1kSwXk93lLjnHMzSCqEnut0y6iHimfDby2Zar76V7OzFuvtUmTLCAD1Op
 3IivgQx0gr+qLa1LjUHF8jzu7UWmMmW+JbXBKonF2RxSdZ0akEJCnYeKnWUScpg6C4eW
 qgjiZdpBGk4b54hfjpSakGcIig3i4N21RKKMqNNuumN/75Al8yTfkO3DS3pDmMbVHAsi
 XZLj/9EeM1A/kjr2viH8g6QnUIGrJ9ovQX4jI9cqxz5WqYP0tLfv73FBCKOkKgBkew3l
 l4/SqdZyTVts7ux+lyuY0XyPvt0/unUZyA5Wkkn4d2tdN66nevLQJllXBHDiPcrl7oTj
 SjKQ==
X-Gm-Message-State: AOJu0Yz69rtm7DMdgeJ2/rV5TEDx0X66goXNq/eTZrElaeO/+I+95aqG
 y+MY36cZzxaxIqaOdSbykGg0WlSnHGq4xBzQY+xEZWJT1htY0A==
X-Google-Smtp-Source: AGHT+IERmGFR4dO6hI8sxchpIkv2H3aIODz8F6C84jxfSjF6aQowgHA7v0IJmAOWFZFVzdsR+BdfEv6+Td+RvFiU5IA=
X-Received: by 2002:ac2:5dd5:0:b0:50e:4f64:9c78 with SMTP id
 x21-20020ac25dd5000000b0050e4f649c78mr3550735lfq.129.1703749041103; Wed, 27
 Dec 2023 23:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20231227210712.712937-1-raymond.mao@linaro.org>
 <20231227210712.712937-11-raymond.mao@linaro.org>
In-Reply-To: <20231227210712.712937-11-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Dec 2023 09:36:45 +0200
Message-ID: <CAC_iWjJ4JA3yQ4NFG=NYMRQX7esqCfOYQaySjojgUyhjJTgXfw@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] bloblist: Adjust the bloblist header
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

Hi Raymond,

[...]

>
>  void bloblist_show_list(void)
> @@ -463,7 +477,7 @@ void bloblist_reloc(void *to, uint to_size, void *from, uint from_size)
>
>         memcpy(to, from, from_size);
>         hdr = to;
> -       hdr->size = to_size;
> +       hdr->total_size = to_size;
>  }
>
>  int bloblist_init(void)
> @@ -493,7 +507,7 @@ int bloblist_init(void)
>                                     addr, ret);
>                 } else {
>                         /* Get the real size, if it is not what we expected */
> -                       size = gd->bloblist->size;
> +                       size = gd->bloblist->total_size;
>                 }
>         }
>         if (ret) {
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 7024d7bf9e..4ec4b3d449 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -166,32 +166,33 @@ enum bloblist_tag_t {
>   * from the last.
>   *
>   * @magic: BLOBLIST_MAGIC
> + * @chksum: checksum for the entire bloblist allocated area. Since any of the
> + *     blobs can be altered after being created, this checksum is only valid
> + *     when the bloblist is finalized before jumping to the next stage of boot.
> + *     This is the value needed to make all checksummed bytes sum to 0
>   * @version: BLOBLIST_VERSION
>   * @hdr_size: Size of this header, normally sizeof(struct bloblist_hdr). The
>   *     first bloblist_rec starts at this offset from the start of the header
> - * @flags: Space for BLOBLISTF... flags (none yet)
> - * @size: Total size of the bloblist (non-zero if valid) including this header.
> - *     The bloblist extends for this many bytes from the start of this header.
> - *     When adding new records, the bloblist can grow up to this size.
> - * @alloced: Total size allocated so far for this bloblist. This starts out as
> + * @align_log2: Power of two of the maximum alignment required by this list
> + * @used_size: Size allocated so far for this bloblist. This starts out as
>   *     sizeof(bloblist_hdr) since we need at least that much space to store a
>   *     valid bloblist
> + * @total_size: The number of total bytes that the bloblist can occupy.
> + *     Any blob producer must check if there is sufficient space before adding
> + *     a record to the bloblist.
> + * @flags: Space for BLOBLISTF... flags (none yet)
>   * @spare: Spare space (for future use)
> - * @chksum: checksum for the entire bloblist allocated area. Since any of the
> - *     blobs can be altered after being created, this checksum is only valid
> - *     when the bloblist is finalised before jumping to the next stage of boot.
> - *     This is the value needed to make all checksummed bytes sum to 0
>   */
>  struct bloblist_hdr {
>         u32 magic;
> -       u32 version;
> -       u32 hdr_size;
> +       u8 chksum;
> +       u8 version;
> +       u8 hdr_size;
> +       u8 align_log2;
> +       u32 used_size;
> +       u32 total_size;
>         u32 flags;
> -
> -       u32 size;
> -       u32 alloced;
>         u32 spare;
> -       u32 chksum;
>  };

The patch generally looks ok, but while we are renaming things, can't
we just copy what the spec says instead of slightly changing the
names?

With this applied we end up with
  struct bloblist_hdr {
         u32 magic;
         u8 chksum;
         u8 version;
         u8 hdr_size;
         u8 align_log2;
         u32 used_size;
         u32 total_size;
         u32 flags;
         u32 spare;
  };

Can you at least rename the ones you touch here properly?
- Drop the patch that renames spare to _spare
- used_size -> size
- total_size -> max_size (which btw mean different things)
- spare -> reserved


Thanks
/Ilias

[...]

Thanks
/Ilias
