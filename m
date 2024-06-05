Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38476C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 15:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3174882E2;
	Wed,  5 Jun 2024 17:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nb/t7mqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8661A8831D; Wed,  5 Jun 2024 17:21:16 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD20C866F6
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 17:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f62217f806so60672305ad.2
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717600872; x=1718205672; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fo0xMd8Nz33os7nE32jf6BT+zR1T0k4zngMqe1hJTS4=;
 b=Nb/t7mqNOQJimPJKcIrMcP/LXg40ZJn8X35r590TPbCgMDh+WCN7BP6rj7AsObqHyW
 s7EvDIbfG5/u1FpGoTBf9ZapD3qegv/+YBGb2JVPap7Sjt9IGcdVvMs45RfDef6N10hw
 kPzPG19dlCZEpPdu5WfmJ3IX2rq9Hz3KY1m7VKapDgUvZLgUA7UthzmdzhymfVJ2Br2+
 lr4O21+wy0lwPrQGrSoOXVe3BZQKJAdb7l3VzIcuufG0WmNpq7Xjn72xZ4Aol1OeFXhU
 xNREDF3Gqeb0dbj1JTX00bqldoPrN+ZCkxKv138dD23zK8C30X1F+gAIexoY00WRrRWc
 D2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717600872; x=1718205672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fo0xMd8Nz33os7nE32jf6BT+zR1T0k4zngMqe1hJTS4=;
 b=H4edaLa6KsXErXczE95Q3hUMEgRxuSNFIWxb7J+jBzgaPk7/ZsLoxvofGdMsAcIh1U
 pormNAUOelDPl3sfhdh6FT3Jg0o14QldFwHwbEdTFGbqWv/8kgFihRltw71fvXJ/mhx/
 TU/7fi0Z7QO/aE5MQpySuqklfYYma0Rk2iGAoAgKaHr//YmgnlugJxmqY/kH6dZfQpFV
 EtCJ6iVxvFjpF6WNxt3u6gMJK8djBnDIR75nOFK2/HZBeYgvV+C92z6cOc1qwm9BD+vf
 VIBMJ5peqznLRmF7PwOurDHq80pizYpXkHln5V+/CWz6RcXybgwed9K1ATb8iZLkj56y
 4X/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKFx/1TtZ86wKb0ykwwe9OE6++ou2+E11nfeG6G8+ao3HL8pMP5ymO087Z5CaDcyhIhkzpQx2WUcR7EO9HHqtQ/0vZAA==
X-Gm-Message-State: AOJu0YxTwtindgkmGAK1ydULjXEFpamQlGkijYC1N40xFh/CdjQ0n3Pa
 gzjOjXTQIEu78dJcXtkHd8mUxRnnJOVhKLgsA0jgt+1tbx1QTJJLIN+7PH9qIGE7XUDkqlPelh5
 sqRQpUX9FHRtguJio39TvvjZJoLXwyN7psCf3dQ==
X-Google-Smtp-Source: AGHT+IEJO6f60dtNjcD962hgfqwYR/7Drr55fTe0o4uuumnlqfEjHWxG69q5T/gUFECwBcodHqboI1A4wyJbN8e0PV4=
X-Received: by 2002:a17:902:e752:b0:1f6:92f1:b01c with SMTP id
 d9443c01a7336-1f6a5a84908mr37769555ad.69.1717600872351; Wed, 05 Jun 2024
 08:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <CANV2PTOAc50sXtz2V6s7bgnEk02TV_7+VArxBpHhF_tCGNjsmA@mail.gmail.com>
 <CAFLszTikFOL3MCOLr+MVg+sGdt3sxcjq6zhbgZxCMyVf-scRdQ@mail.gmail.com>
 <2ce195a5-e1af-43d6-82bd-252bccaa8e24@canonical.com>
 <CAFLszTj2aoxmPJUFo7CFq9u5kD2mBRbJxmNVm5xXmjrBGN7=Rg@mail.gmail.com>
In-Reply-To: <CAFLszTj2aoxmPJUFo7CFq9u5kD2mBRbJxmNVm5xXmjrBGN7=Rg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Jun 2024 18:20:36 +0300
Message-ID: <CAC_iWjJd9W=+QNcdSSGTATpFhBM5tQyO18WYUK=UrJg5v6vdwg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] efi_loader: improve device-tree loading
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de, 
 E Shattow <lucent@gmail.com>
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

Hi Simon,

[...]

> > >>>
> > >>
> > >
> > > Can we use the best-match compatible approach as expected by the new
> > > 'make image.fit' in Linux?
> > >
> > > Filenames should be deprecated IMO. I am happy to help work on how to
> > > do that if you agree.
> >
> > Hello Simon,
> >
> > It is the OS that creates boot options. The OS can determine the exact
> > dtb file based on the compatible string and the kernel version once per
> > kernel upgrade. This is much more efficient than doing the same on every
> > boot.
> >
> > Replacing $fdtfile by a matching logic could make sense. But please
> > consider the effect on boot time if have to read through more than 1000
> > arm64 dtbs with U-Boot's non-caching file-system drivers.
>
> The suggested option here is to use FIT, which is very fast at
> scanning the files. Please see [1]
>
> Failing that, we could implement a way (in FIT) of specifying that the
> FDT is in an external file. In that case FIT would become a mapping
> from compatible strings to filenames.

This is kind of irrelevant to FIT. This is how the efibootmgr
configures the files it has to load.
commit 76e8acce12fe,  commit 53f6a5aa8626, and
doc/develop/uefi/uefi.rst, Chapter Load file 2 protocol has enough
information of how the initrd is implemented. What Heinrich is doing
here is extending the existing code to load a DT

Regards
/Ilias

>
> Regards,
> Simon
>
> [1] https://github.com/open-source-firmware/flat-image-tree/blob/main/source/chapter3-usage.rst
