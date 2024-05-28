Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7ACC25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 16:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BBE58848A;
	Tue, 28 May 2024 18:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iivJ+agz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 167C78848A; Tue, 28 May 2024 18:19:22 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D02F1884D1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 18:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f3469382f2so8329115ad.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716913158; x=1717517958; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VhApwokuAgSTXhvo76Eshu2iMyC74Xe0yryrv0f5MqY=;
 b=iivJ+agzmcdI5El7RrF11BT/cAeVq5v24+bhP+MH62TOxfOg0D1d6QCUbecxOCsldN
 qglIDF+6Hjlm916AirTkl0v7S5SnVjsAog4ex/AgTnVDZ1e8ipaLVNSLdYE6oljBbqDU
 0F8fzbuFZckiaCVcY/s58uIcSLK3L2cRdMUGLk8BzDlRFs4OKc70s64GLQDE/JZ4ouvK
 NvdAb4SUs4IYrJ3j2mCKDSmuGY2QTkYmQp6Cn5/jPMz8mJEyrJcI4/0F8UdayF4Zk0V5
 lQDPkMYZDkmK2+F+zvG/G1PtO1/zL+J8Vxvg86fgd41LXdnmJy5CJdxHr1gXM1cETWui
 Bhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716913158; x=1717517958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VhApwokuAgSTXhvo76Eshu2iMyC74Xe0yryrv0f5MqY=;
 b=DY3ZK7mzBQ7H8Dnrrpw40mtucJK6Hblewo7I5FQPGb5EtPiRRf97fuN/tNiC7LDtwt
 RcIYEynhwpKK92C6c3+X7Hv/OcDF50YjTVH8QJvcYiR5sgjm3Cp2RXcsSXfTYARXAc/c
 o4yjQTzpc+hiQBW3PUu2f0xEkycXj4hfFJVCOo3KlKyuUEbjMT9De52wUpbUaKa314eS
 xfUrQgLC9EnHcw10aabQyF3cY0cna+yK01hlGkfC3NkAik+RTWehOERJQvnyufdE9YJG
 +pCmg2tFXfIwRsIJECLrc9mmyqS7Y1QYdCTDUJ7MMY7lRd1YCJs4JYCVPYNpp1X19Hat
 S/VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9olO37eui0ByYFQaqXdZv6qDSEnVHbZc289aFS/C4jlXZKfB78GwZHGTLJYmkaap9uPJKd6MTT8Fs5GHJWUugx/sbMA==
X-Gm-Message-State: AOJu0Ywwi5XkFb+qxJzmewqsgmQkZSe+nReNauVsWSUWyTEam0v29PW8
 2utIzy5yky6W9IKSy4J3awfZcswHDEX7zx2oal1LCdoEgfVxrX+ibqoFWtjWLt8Yvagkxj0VJDG
 QRujf2CetKDt1GMiy+mh3geimEEH/qApq3zzx0w==
X-Google-Smtp-Source: AGHT+IHrvBX/I7Yyn4F778XryTOOpG3ZJGUkIULxwMOFgUSZNPIZbP7xHKytPPa67uJaPwjtqfThcsmEZ6ViByuBxC8=
X-Received: by 2002:a17:902:ce87:b0:1f4:8738:64f9 with SMTP id
 d9443c01a7336-1f487386990mr106319605ad.39.1716913158279; Tue, 28 May 2024
 09:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <20240528144252.179247-2-heinrich.schuchardt@canonical.com>
 <CAC_iWjJFiSrPZveDDhX7wW9J-gBiTCUw2jXpw9MG_+K3nsGaEA@mail.gmail.com>
 <9bcf8dff-1c67-477c-b425-cbb79f5ecfc3@canonical.com>
In-Reply-To: <9bcf8dff-1c67-477c-b425-cbb79f5ecfc3@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 May 2024 19:18:42 +0300
Message-ID: <CAC_iWjLwRsgWK33q76rwqg0ovE4h80SHZTjjUqPUsPMgdh7SbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] efi_loader: allow concatenation with contained end
 node
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

[...]

> >> -               unsigned sz2 = efi_dp_size(dp2);
> >> +               size_t sz1;
> >> +               size_t sz2 = efi_dp_size(dp2);
> >>                  void *p;
> >>
> >> +               if (split_end_node < sizeof(struct efi_device_path))
> >
> > Can we be more explicit here pls? Someone might misuse this in the future
> > split_end_node < =1 ? And we can document we can use values up to
> > sizeof(struct efi_device_path) if we ever need extra functionality
>
> size_t split_end_node cannot be negative.
>
> The case split_end_node == 0 is handled below. What are you missing?

someone misusing it and passing a value of '3' for example and print
an error if the value is
1 < value < sizeof(struct efi_device_path)

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> >
> >> +                       sz1 = efi_dp_size(dp1);
> >> +               else
> >> +                       sz1 = split_end_node;
> >> +
> >>                  if (split_end_node)
> >>                          end_size = 2 * sizeof(END);
> >>                  else
> >> diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader/efi_device_path_utilities.c
> >> index c95dbfa9b5f..ac250bbfcc9 100644
> >> --- a/lib/efi_loader/efi_device_path_utilities.c
> >> +++ b/lib/efi_loader/efi_device_path_utilities.c
> >> @@ -76,7 +76,7 @@ static struct efi_device_path * EFIAPI append_device_path(
> >>          const struct efi_device_path *src2)
> >>   {
> >>          EFI_ENTRY("%pD, %pD", src1, src2);
> >> -       return EFI_EXIT(efi_dp_concat(src1, src2, false));
> >> +       return EFI_EXIT(efi_dp_concat(src1, src2, 0));
> >>   }
> >>
> >>   /*
> >> --
> >> 2.43.0
> >>
> >
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
