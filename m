Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171F6D62077
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 17:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4162488DC6;
	Tue, 19 Nov 2024 18:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="APTDmJLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79FCD8957F; Tue, 19 Nov 2024 18:21:15 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1717888DC6
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 18:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso33231675e9.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 09:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732036872; x=1732641672;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qyiOIRxu2XVeE05fIFWzY8AymSfRDSGGx1SqnKQW1hw=;
 b=APTDmJLTFqECFdJlzj2dqRncKEJtLDRzYiL2eq8UBP8FE0Ml7bAVgNQQPe0PvjkhR1
 HXfqb2YEkldtm/RDPnWjs4uIyHuED30pLPftVGf/DnMblCeThgaKQ6kwFttDQ84Sqxdw
 qhnehwIhs2Mwk89mtf89g1fTNTsAxupF+hfhLAVRbYiFZOe8B1Bval4Nby3IzRCsJlEi
 t14cjhDblOIG1CVS4gng7MuxFx6BvvS9kYjJ6yHglHOxm/mZy7LFi7AVCbWuS5/7UqFV
 sbpta54+7hNN1GDEGSk7t7rSs5dsBI0EBYkwRrc1jeLk/Huk6dUqy1XcJZKn5kyeA1zX
 6gOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732036872; x=1732641672;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qyiOIRxu2XVeE05fIFWzY8AymSfRDSGGx1SqnKQW1hw=;
 b=Vw5uQB63WBp9FYQKo2mUT5EBxG8HegC/krSdWfokR+Euf6XvDPBmYq9r4ALapzff9M
 dWfV98lOrsWHSCS+jbqt2rUtkA8NCCdDye6vaiNYoiC0q8QMn2tFLTcQB6HTtUA0mtm4
 Dw8LXN8hyuBggAcd+TOhm1+KhM7A+8K0GKQsXwCp50r0nJURGZkg3fXNWDVaiJYYyvY/
 EZafU3+dGVWd4NrHXy2M7vFBISHNVurH+ARNSM2rxEwGt4Vm/kA7FEJ8r0o+DyIhvoN7
 SBC9gaVCqh16A0kLhssrqF7Vqmc9QWDHEfJxbe/k1MufDv9OIt8S2qxyQD/8oJCp/PVH
 vXeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdx/shcYYKq0PFWLsy5TmOKIyg9XgkpN2a0zrmv2X/y51pFnpmt9/ba8YTLbeKIZIOWxcbQf8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/doiU2b+BjX5Ofz0ODSkgDtoabJ0tVAhs03rPioMDHXYfmrUr
 GgGGafQe3VqtG0pNCGgqVDC9BJ4Y1BGbiy980bNtUrEL1/wjLkwpHvOawdZhKGI=
X-Google-Smtp-Source: AGHT+IGqfy+lWRefSC4ejNiuylZ5kNAipR7ZGojlGieSVTyp7qXVtSQuCgREjg4t4i7wal2OXXTKpA==
X-Received: by 2002:a05:600c:4fce:b0:431:7ccd:ff8a with SMTP id
 5b1f17b1804b1-432f57df971mr37285705e9.14.1732036872449; 
 Tue, 19 Nov 2024 09:21:12 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da28bc11sm200968415e9.31.2024.11.19.09.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 09:21:11 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Guillaume La Roque
 <glaroque@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
In-Reply-To: <173202581313.45491.4764652989056463492.b4-ty@baylibre.com>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
 <173202581313.45491.4764652989056463492.b4-ty@baylibre.com>
Date: Tue, 19 Nov 2024 18:21:08 +0100
Message-ID: <87mshvxhq3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Guillaume,

On mar., nov. 19, 2024 at 15:16, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> Hi,
>
> On Tue, 19 Nov 2024 12:37:37 +0100, Guillaume La Roque wrote:
>> Actually bootmethod android only support android boot image version 4
>> and with AB image, some old platform wtill use android boot image
>> version 2 with AB or without AB slot.
>> 
>> This patchset add support of both version 2 and non-AB slot images.
>> It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC
>> 
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>
> [1/5] bootstd: android: add support of bootimage v2
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbe7eee992e90bbe84278db20d29159e3eedfe0d
> [2/5] bootstd: android: add non-A/B image support
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a85f2e0e7bd3665366ca2704d1142d3f16f22c36
> [3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88547773b2df5e4cabbaec57a0f2e7f212dbf823
> [4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4a2e58717f2f33ef0dbb422026ef71938f2265aa
> [5/5] bootstd: Add test for Android boot image v2
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/acaa7f35a33146f887948d34130229388280844a

CI has found some issues when applying these series:
https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23452

Could you have a look please?

Thanks!

>
> --
> Mattijs
