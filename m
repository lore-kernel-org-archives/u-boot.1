Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CDFC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 11:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87FA58784C;
	Fri, 22 Dec 2023 12:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="imaJ15Wp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0950E869B6; Fri, 22 Dec 2023 12:12:13 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FB888784C
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 12:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50e1112b95cso1963643e87.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 03:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703243530; x=1703848330; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g4y0n3zm48OfrSDy0WYEOAZVmoIzBaptmWeYQEkS0fA=;
 b=imaJ15WpQLLGmpqkXpmwLjDyRJSscDiBrz1EHvvrRT2X7QZcIEVuzVUEDZTk57d9gv
 qRChVrT/OzNH8ISppAIfBcLTMSOyQIuQmbl7KKLPxlNEZsohgqtq24DzlPPk9rYiLZF5
 c7SIPftKYPatVuORSTpYTiMKnggsV7d29NiQB843ze9y+urqR07LLPyQd7rxD4+bFY79
 aXzM6uOmzIWIIw1Smy8AmcEwQdjf5+omBseFbD6FZAHW1rnP611iyaxQjJD/SWGlwiRn
 pAh+SxEat9YOBw+TJ3Hl6aSunltpi1PRyzpOiIItQrnd50KQp8iteOtDHUZfVf8IxJk0
 AuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703243530; x=1703848330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g4y0n3zm48OfrSDy0WYEOAZVmoIzBaptmWeYQEkS0fA=;
 b=qMAe/EDhaSKt5Xt7m3ehKnZJ5OXoqX3FK1RefmMKnEw7XHy9UizjVGpL2IVgFA9Z1A
 C918KDmDEUA+N4Evcx0uLIBukavIKTNvv9es2vGX+QR2VFj/4L5UbgEONVDvoHcn+mDI
 WfLVaBbrNpd8bEX76ztZvSAMv+fpDeDv0AYWduBNNW7YiGuIYwSXKZGOeXjrWsFwtxby
 PgXxYDKMmxxToYmS0v6mZM42Jp0hBGSKLvBTjzvvKyMmtqVcK1nT11YFjM4VP27Ly4Va
 FD4p13CLTqxcjZA4jDGnhFnnYC0nypXr6A46Yp7ebkVwufJWNzGD22gHNFR6ypYrPH3Q
 clGg==
X-Gm-Message-State: AOJu0YyQEZuexmbYOYHYkCH3sQTOf8U+UC0CQmkwfOEB/AEJ/X5D6kEw
 s2pMWZ8n/h7T7XtCWCNUTPQu+Xc8hr5XwlzbY9EHqAKkTJEqxA==
X-Google-Smtp-Source: AGHT+IHpnXGZ2xjZDJo1bH3AOVBeXM1QnYscbLpkkJQrLzmOKvwvssqg0APO5V41ASojk61ZUWtPiAddobVhciHIWWg=
X-Received: by 2002:ac2:5e33:0:b0:50e:6b49:dcc with SMTP id
 o19-20020ac25e33000000b0050e6b490dccmr199321lfg.117.1703243530389; Fri, 22
 Dec 2023 03:12:10 -0800 (PST)
MIME-Version: 1.0
References: <20231221004030.581388-1-raymond.mao@linaro.org>
 <20231221004030.581388-4-raymond.mao@linaro.org>
In-Reply-To: <20231221004030.581388-4-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Dec 2023 13:11:34 +0200
Message-ID: <CAC_iWjL3JfxVA0HW_2vbV3ivWDm0H00R=Mj4to_BC2b2gNY4FA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] bloblist: refactor of bloblist_reloc()
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>, 
 Sean Anderson <sean.anderson@seco.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
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

On Thu, 21 Dec 2023 at 02:41, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> The current bloblist pointer and size can be retrieved from global
> data, so we don't need to pass them from the function arguments.
> This change also help to remove all external access of gd->bloblist
> outside of bloblist module.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---

[...]

>         }
>  }
>
> -void bloblist_reloc(void *to, uint to_size, void *from, uint from_size)
> +void bloblist_reloc(void *to, uint to_size)
>  {
>         struct bloblist_hdr *hdr;
>
> -       memcpy(to, from, from_size);
> +       memcpy(to, gd->bloblist, gd->bloblist->total_size);
>         hdr = to;
> -       hdr->total_size = to_size;
> +       if (to_size < gd->bloblist->total_size)

What's the size of *to? Is it equal to to_size?
Because if to_size can be smaller that gd->bloblist->total_size the
memcpy above is wrong

> +               hdr->total_size = gd->bloblist->total_size;
> +       else
> +               hdr->total_size = to_size;
> +       gd->bloblist = to;
>  }
>
>  int bloblist_init(void)
> diff --git a/common/board_f.c b/common/board_f.c
> index d4d7d01f8f..00b0430889 100644
> --- a/common/board_f.c

[...]

/Ilias
