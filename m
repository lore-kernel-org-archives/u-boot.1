Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2A9C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 15:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EA26877BC;
	Fri, 22 Dec 2023 16:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OTp89Kxg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA7FC8785D; Fri, 22 Dec 2023 16:46:07 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC2AD877B8
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 16:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ccb4adbffbso1232861fa.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703259965; x=1703864765; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CdSgHYjPedNucOyhJXGjHLcrrD5cy2/z3BFeGTlASRo=;
 b=OTp89KxgfWwvaUUF4TaqgicMU4F1NO2brMopLVPAAJip5XCTTfMYbDv+3IzoSo6qUx
 Rb27eNNxtAbr5/rUyoBx1sTp04peVn2kUN30a4mJbrd/n4bRE26cqqzjWxCfSaYOd9Vw
 vFELrd+0/GwA3u9jNLBTuoMr0RiUG08p180eSVOFgfFspwvTtfl/9gwGkkd2mhWA/TtY
 +uL8a4PYqheTk6qP0FN/yqplrmZtx6tm3X6yeX6NH4Z9oGafj9hnFHZ6zgJQ0B7iqNXs
 iRAKIs5fsSgnA/NKldpQbvyTa03vvDuxdyvMoYEf0nll41vpBR0qVbP6M9FS7cE+hmjF
 oRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703259965; x=1703864765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CdSgHYjPedNucOyhJXGjHLcrrD5cy2/z3BFeGTlASRo=;
 b=rF7Plmp407FPiz9tsORym4sqF9yVU61Zm4WV5UT+YIpxOEb7hipvVN/Ncmp3M6aOM7
 1TCCJDSf3OoiHOKC45E9GP6XHS2u2d7rYwKhriGn92VcXi3HRB7usFvIhbm6FoF+bwbp
 EULlRFY+NOcU2opoC8rfCK1E1+ZeCA2OokPmH1cDJMMUBLqMDMI4SsKf0v05scvn7o+e
 wxRX1V2I0yZCBhBXTnRfnAj97LM8CaotChpTaVy8xtA5d+L8KcRKG6M7BIPXaf3Xc8lG
 78En2OUJoAa2tklgSgtr92/oxQ7yLFNIrcBueZohMzaSi9QQlFKsU7mJ7DqIhv6dOZe4
 Bc3A==
X-Gm-Message-State: AOJu0Yxyj49vcTIsvvnfSqOq6fcbnuwugg0OezV0+jnR5cyRgogZ84je
 FcqST8IpLULxxeiCESJIRcejjzjyiHNn8SasH48MQUyMliFGSg==
X-Google-Smtp-Source: AGHT+IENty/ZLhNi9uXf9Jp4E7KJGUN+tTfwEC80r/Dy+ViEPOM226S4LePdSmpOCJM2eRQ6PP73h7Vcnq3Sukb8qew=
X-Received: by 2002:ac2:4352:0:b0:50e:3f2e:c726 with SMTP id
 o18-20020ac24352000000b0050e3f2ec726mr848662lfl.87.1703259965124; Fri, 22 Dec
 2023 07:46:05 -0800 (PST)
MIME-Version: 1.0
References: <20231221004030.581388-1-raymond.mao@linaro.org>
 <20231221004030.581388-4-raymond.mao@linaro.org>
 <CAC_iWjL3JfxVA0HW_2vbV3ivWDm0H00R=Mj4to_BC2b2gNY4FA@mail.gmail.com>
 <CAEfUkUK22kEAsobLXS3eH-FJnUg4BW5TuWtfaBeYLGgJs-ksgA@mail.gmail.com>
In-Reply-To: <CAEfUkUK22kEAsobLXS3eH-FJnUg4BW5TuWtfaBeYLGgJs-ksgA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Dec 2023 17:45:29 +0200
Message-ID: <CAC_iWj+83faSBgg42G+9vUs1un92RFqiWYVCSq4hS8yn6GtFVA@mail.gmail.com>
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

On Fri, 22 Dec 2023 at 17:30, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias,
>
> On Fri, 22 Dec 2023 at 06:12, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Raymond,
>>
>> On Thu, 21 Dec 2023 at 02:41, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > The current bloblist pointer and size can be retrieved from global
>> > data, so we don't need to pass them from the function arguments.
>> > This change also help to remove all external access of gd->bloblist
>> > outside of bloblist module.
>> >
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > ---
>>
>> [...]
>>
>> >         }
>> >  }
>> >
>> > -void bloblist_reloc(void *to, uint to_size, void *from, uint from_size)
>> > +void bloblist_reloc(void *to, uint to_size)
>> >  {
>> >         struct bloblist_hdr *hdr;
>> >
>> > -       memcpy(to, from, from_size);
>> > +       memcpy(to, gd->bloblist, gd->bloblist->total_size);
>> >         hdr = to;
>> > -       hdr->total_size = to_size;
>> > +       if (to_size < gd->bloblist->total_size)
>>
>> What's the size of *to? Is it equal to to_size?
>> Because if to_size can be smaller that gd->bloblist->total_size the
>> memcpy above is wrong
>
> to_size should be 0 (use the total_size) or a value larger than total_size.
> I think I should keep the below line from the function header.

The point here is, are we certain that the *to is big enough? Or we'll
end up overflowing ?

Thanks
/Ilias
> >> - * @to_size: New size for bloblist (must be larger than from_size)
> I will refactor this part.
>
>>
>> > +               hdr->total_size = gd->bloblist->total_size;
>> > +       else
>> > +               hdr->total_size = to_size;
>> > +       gd->bloblist = to;
>> >  }
>> >
>> >  int bloblist_init(void)
>> > diff --git a/common/board_f.c b/common/board_f.c
>> > index d4d7d01f8f..00b0430889 100644
>> > --- a/common/board_f.c
>>
>> [...]
>>
>> /Ilias
