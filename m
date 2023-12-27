Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614EDC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 08:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23D2C87935;
	Wed, 27 Dec 2023 09:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tvfzVeeb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 816B587964; Wed, 27 Dec 2023 09:33:08 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D23987729
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:33:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ccae5719cfso31487131fa.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 00:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703665986; x=1704270786; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2TrCWjvIigsGU5pEvpdMyQPSflEG8vohdtNHmetkimA=;
 b=tvfzVeebJVVz+HpzwQ7Abmm0v4PA+Mf6/MkCUOPhc6IXt3kw8F9K9thE/nGXTRnxTv
 CVCSXbG1tz7iVTE9TJmLKXQcRqANFe4KAsec+a7KSKY8ZRc6KB4w0zkY7fTTSr7tOrSG
 Ki1gamPn5iQK68noI5usWDu/9S+wMBfQTMKmNKtPa7eC7CG+utF69mVjhGuRZ2VlM+1i
 +CRbJqa/P3k3UWaOGMIZ2VtUiCqg7oX8s4TK+rGpdjA5wU/Eip3sH8pGn5lZdxtGM70j
 mjJ7M8w7tbmAbNs4JEzstMwSL7rHDcIvK2D4DXVRd3khDKb8L+91csKc8cxttxMtaKP8
 ZFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703665986; x=1704270786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2TrCWjvIigsGU5pEvpdMyQPSflEG8vohdtNHmetkimA=;
 b=Dam/pE//skg4sNnuSmhfkGenFWv1/BhW5Of9wefqIjRyNKrsf49Rm3GOGdWrZx/veH
 P6kOBiH8Hl8UefqCzlhpggUlMSgg3xofX+9nKS1spedP952vNZ8i7bGT9vfMZwMYBip4
 emgUieP2Gg85d0ctfHIFsXIndLNCn+15rvXQ6EHzwySd9LfU6Oe3jVEQIIGYmQlMRQof
 Qx4w4e8gRYZy7VgSlD8AwxCPmw6EIca94PXSWZ/+rxATOIuZGwrmy5BDuoPuMYBQDEVH
 KbeWym3fi7h4yzfKnHzwl+/kKibG3udDdiZL/F7v8GtMOji69jdFBojNx/29NF7E60DF
 Gk3w==
X-Gm-Message-State: AOJu0YwNKC67/VzOk+igIXGE+pdS1Orv58BKZ8hap9Iq7yZDSDD2fNfK
 d7OfGHFvtZrd1tlZRIY67PIM1hpp92dDRMuKrTc+yKCHl2pHrQ==
X-Google-Smtp-Source: AGHT+IEBPInNxRlaIBzBabMIIVtXeXWGB+Oplq0z6isPGyc6owJ9xoUEp4XCDsrsGKaKyY7P4wwH0/oN44kTiVbd4UE=
X-Received: by 2002:a19:ac0d:0:b0:50e:6f4f:63d7 with SMTP id
 g13-20020a19ac0d000000b0050e6f4f63d7mr1053305lfc.73.1703665985865; Wed, 27
 Dec 2023 00:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-4-raymond.mao@linaro.org>
In-Reply-To: <20231222213110.660402-4-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 10:32:30 +0200
Message-ID: <CAC_iWjLTmmiDq7oP-mS0kvpsCz-k=S5C=8xNeS6VvKK5AeA4EA@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] bloblist: refactor of bloblist_reloc()
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>, 
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>
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

Hi Raymond

On Fri, 22 Dec 2023 at 23:31, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> The current bloblist pointer and size can be retrieved from global
> data, so we don't need to pass them from the function arguments.
> This change also help to remove all external access of gd->bloblist
> outside of bloblist module.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - New patch file created for v2.
> Changes in v3
> - Check the space size before copying the bloblist.
> - Add return code of bloblist_reloc().
>
>  common/bloblist.c  | 10 ++++++++--
>  common/board_f.c   |  8 ++------
>  include/bloblist.h |  8 ++++----
>  test/bloblist.c    |  6 ++----
>  4 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index db3fbb20cf..5ad1db137a 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -472,13 +472,19 @@ void bloblist_show_list(void)
>         }
>  }
>
> -void bloblist_reloc(void *to, uint to_size, void *from, uint from_size)
> +int bloblist_reloc(void *to, uint to_size)
>  {
>         struct bloblist_hdr *hdr;
>
> -       memcpy(to, from, from_size);
> +       if (to_size < gd->bloblist->total_size)
> +               return -ENOSPC;
> +
> +       memcpy(to, gd->bloblist, gd->bloblist->total_size);
>         hdr = to;
>         hdr->total_size = to_size;
> +       gd->bloblist = to;
> +
> +       return 0;
>  }
>
>  int bloblist_init(void)
> diff --git a/common/board_f.c b/common/board_f.c
> index d4d7d01f8f..00b0430889 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -676,13 +676,9 @@ static int reloc_bloblist(void)
>                 return 0;
>         }
>         if (gd->new_bloblist) {
> -               int size = CONFIG_BLOBLIST_SIZE;
> -
>                 debug("Copying bloblist from %p to %p, size %x\n",
> -                     gd->bloblist, gd->new_bloblist, size);
> -               bloblist_reloc(gd->new_bloblist, CONFIG_BLOBLIST_SIZE_RELOC,
> -                              gd->bloblist, size);
> -               gd->bloblist = gd->new_bloblist;
> +                     gd->bloblist, gd->new_bloblist, gd->bloblist->total_size);
> +               bloblist_reloc(gd->new_bloblist, CONFIG_BLOBLIST_SIZE_RELOC);

Why aren't we checking bloblist_reloc() for an error?

>         }
>  #endif
>
[...]

Thanks
/Ilias
