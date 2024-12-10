Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9B7E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 16:17:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C32E80282;
	Tue, 10 Dec 2024 17:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LZttVT3c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCCF880282; Tue, 10 Dec 2024 17:17:56 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E6E80269
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 17:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa692211331so364415666b.1
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 08:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733847474; x=1734452274; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DXvKe7ja+xgK6fzUpO2sQfOmVZKvOlg2j+UcznDrtXk=;
 b=LZttVT3cYPDAL/oi+4nHj2MljS3Sh3wBroPTdKnZTSjlYwSUonxP/hDKN1qxoMmD1I
 z7z80GrcOhIaAyDJyuAUxMTBLlVm6L+N5L50Bik2NRE3KLOGBZLlDjyG7pCoM0tyJk6T
 JhmgA7u6jtC1Vi3MkQmq6f47uYluZVAHerlT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847474; x=1734452274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DXvKe7ja+xgK6fzUpO2sQfOmVZKvOlg2j+UcznDrtXk=;
 b=Aar/MQC2ubejLaCPOrv1YZwxJ3kAvW7s536uzWjevlaY69Z+K3ZvNjHtGqkAck2fpd
 XtGYseR6L4TwRiDehdc5yNNDzwy5l5vMZvzJoHBCDcKBdlR71LhFo5eiB+fznhZzg3Gu
 hVVJB3ggdn6ZEXptjWVBYdAUCyqh9G/OyvRXmYcByPGYotZ/WjtpWyQzmDIsEcEmTYM6
 p2EiKRunDNVvnLxwlAuRmPTHDbivGfReaJjM0NEYUj8nCDAZwb/5GUP/e3MxbE/eJyEE
 DViepAYRS57CVNCrhAQFflMa/3ca8twb7FvTFQTqKkync8rNWSA/RJgPVuzZm3xoaRT5
 kjOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsf0t4W792IOKp5ANjnlz6IlgASFmBYEQjDgPRY5C0rBArTvTh5dxBYX0WRrl+cshmi6f/NvI=@lists.denx.de
X-Gm-Message-State: AOJu0YxL/NsIASfEJUzQd6GdxfcVZIVMgUHsz1cIkie+rvchdArfNcPp
 sK60wnpCTqDYV4smoA5jA8NuyVGnPTGvficmexru4RcQftDjtpEflqm2U0JAlMDTdzWJ3euZyzL
 iZCBo77fQLs4z/K/8XBHXIiv1pZ2cpz1LFU4KfNhLA4jFA6c=
X-Gm-Gg: ASbGncutUvGu5QTtDWsn0Wm0rpQxMfvx54PZoakwn63A0o3r1PGKNWvJOjw2MmNuVOv
 PKgHYWdQ8hrZSKIIjuInQQdjfA+/RP/NPtFzU
X-Google-Smtp-Source: AGHT+IFDK/Ts0z4UupqVmouTk9xr7c8ZwOvIjnsLvvv6pz8yZEXWvsv9lP+Qsip83aJmFVRvFtzoGy61nO9vNUn2aks=
X-Received: by 2002:a17:906:9d2:b0:aa6:7b49:28fb with SMTP id
 a640c23a62f3a-aa6a00794e5mr450655166b.14.1733847474212; Tue, 10 Dec 2024
 08:17:54 -0800 (PST)
MIME-Version: 1.0
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-10-sjg@chromium.org>
 <20c4487c-f908-40ef-be05-1ac7eb7e8be6@gmx.de>
 <CAFLszTgs9i4yrL8=YZvh91urYisj0s_ukH+vVGyWWBSULe71Dw@mail.gmail.com>
In-Reply-To: <CAFLszTgs9i4yrL8=YZvh91urYisj0s_ukH+vVGyWWBSULe71Dw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Dec 2024 09:17:43 -0700
Message-ID: <CAFLszTi88v1BFXLJCpp8UbnV_JO3Hg4Bx5CtWxEZ42__oVCFFA@mail.gmail.com>
Subject: Re: [PATCH v4 09/25] efi_loader: Use the enum for memory type
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>, 
 Moritz Fischer <moritzf@google.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Tue, 3 Dec 2024 at 08:53, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Heinrich,
>
> On Tue, 3 Dec 2024 at 07:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 01.12.24 16:24, Simon Glass wrote:
> > > Rather than an integer, it is better to use the enum provided, when
> > > referring to an EFI memory-type. Update existing uses.
> > >
> > > Call the value 'mem_type' consistently. Fix up one instance of
> > > upper-case hex.
> > >
> > > Fix up the calls in struct efi_boot_services so that they use the same
> > > enum, adding the missing parameter names and enum efi_allocate_type.
> > >
> > > While we are here, rename the 'memory' parameter to 'memoryp' so that it
> > > is clear it is a return value.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Simon, I have no clue why you keep ignoring reviews.
> > This is just annoying and won't lead to merging patches.
>
> I got your feedback on [1] and incorporated it in v2 onwards. Did you notice?
>
> >
> > NAK

It has been a week and I have not had any response on this. Does that
mean you are OK with the patch now?

Regards,
Simon
