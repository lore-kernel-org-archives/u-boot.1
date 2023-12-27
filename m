Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05A6C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 06:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1C15876C8;
	Wed, 27 Dec 2023 07:44:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ywmjye6g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 978C887707; Wed, 27 Dec 2023 07:44:11 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C412876C8
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 07:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50e72e3d435so2261181e87.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 22:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703659448; x=1704264248; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ec5cRmkeZpvM5+EsVnps7oXlO5N2W/0q+0MqgVDh5YY=;
 b=Ywmjye6g6xyR2uOgwq7pEW0u+8BRj8sKP6lhro4t/e0JWVgBtJaWZW5qVGBeI6MJoX
 1CypQKZTcdCGnszrLggOIjRe3ihWzHfQ/Wjtox6lYfXqyRtE9Az/40NGsiHv8v0AJGTk
 qHDRY/DhxRYy/SSB0EHwP9sM7yk5zoLkIji67lrNou0kaZJwyCb52Mi8Fl/6dgATluro
 ShAMKxnjWVC3z4CCX3BS2kMjFG4baHqFt1oxTtpfN/mDGJkOzndwb8KK2WdyCuKasNS1
 RTCjk2ki5He+92EiieS0dN/q86aV8U37pyMmM/gEP2z1K8EQ1oRPc2y4gM4tEzCuVkwt
 EQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703659448; x=1704264248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ec5cRmkeZpvM5+EsVnps7oXlO5N2W/0q+0MqgVDh5YY=;
 b=G49jst+T5ZDYfzuyFmnRlLCmxxV+td5CgCkm5E0qsutQ49J+ycouR/8BPQ8qwiWAQT
 982DU+Gja9xcD9Y8ZXwjNYk7Xl6nf5/R+knLoCMk8up2J50LTWHn5g3SSluwhYHEN1M/
 F2qDUcYroKRWZGT729MkE6WfxFfgBp+sOem5UEfGjKtfv6XN/2Rpi8V2Im3hYTdEFj9a
 ITyFdoLPTkn5RcHl32lS+16HOXG8LqJF4otZi0GP6AE8v6+QPselrMGSJipz47RyZAb+
 NRV2eIbRrYjHXouMopqrwmWuKbI4nuFf4eLBYE7GmMCVYcp/1OCuKwu2ZSI4m4C9Q07m
 jzNg==
X-Gm-Message-State: AOJu0Ywwr///MBFFBe8uyEQv+L/+QiD/XBb/qEitK6rjTRt7ErY2AxbD
 nSeNnAyjS7p7NPOG+oNkuFvMqYithQejlOJe/9pDQFQNH58qCg==
X-Google-Smtp-Source: AGHT+IF0AmtfNoIdJ8vDlNxfWDAKTFjqO9zfp5wKgFovqZAXcEgvDMSDZ1aWXG+RoyhhyJKtSeS1Rl89ksmqvQ+QVms=
X-Received: by 2002:a05:6512:3f4:b0:50e:7285:b638 with SMTP id
 n20-20020a05651203f400b0050e7285b638mr1271787lfq.110.1703659448357; Tue, 26
 Dec 2023 22:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20231226094625.221671-1-sjg@chromium.org>
 <20231226120710.GH2652760@bill-the-cat>
In-Reply-To: <20231226120710.GH2652760@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 08:43:32 +0200
Message-ID: <CAC_iWjLy1E9wEW3zX2waN9mc=tz7PTKE0gJ4RucqMmZR2cA6_Q@mail.gmail.com>
Subject: Re: [PATCH v4] fdt: Allow the devicetree to come from a bloblist
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marex@denx.de>, 
 Raymond Mao <raymond.mao@linaro.org>, Baruch Siach <baruch@tkos.co.il>, 
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>
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

Hi Tom,

On Tue, 26 Dec 2023 at 14:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 26, 2023 at 09:46:25AM +0000, Simon Glass wrote:
>
> > Standard passage provides for a bloblist to be passed from one firmware
> > phase to the next. That can be used to pass the devicetree along as well.
> > Add an option to support this.
> >
> > Tests for this will be added as part of the Universal Payload work.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> > The discussion on this was not resolved and is now important due to the
> > bloblist series from Raymond. So I am sending it again since I believe
> > this is a better starting point than building on OF_BOARD
>
> I really don't like adding another option for "DT is given to us". Why
> isn't adding another enum to fdt_source_t sufficient, and if we have
> bloblist enabled, that will look for and use if found? Maybe some other
> code needs to be restructured and cleaned up too?

Same here. On top of that the bloblist has a few items in there, e.g a
TPM eventlog. What are we going to do? Add a Kconfig for each item?

This has been going back and forth for a while. I've lost count of how
many times I repeated the same proposal, but here it goes again. We
have OF_BOARD and BLOBLIST options. The bloblist and its properties
are scannable at runtime. Can't we use the combination of these 2 can
be used to imply we expect things from a bloblist. If we want to be
stricter in the future and explicitly expect the DT from a bloblist,
we could add a Kconfig option failing the boot if that's missing.

Thanks
/Ilias
>
> --
> Tom
