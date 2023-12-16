Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B49AC46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:48:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C66B87C34;
	Sat, 16 Dec 2023 19:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g9aEeJOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1753687C30; Sat, 16 Dec 2023 19:48:22 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 252C8876A4
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5e4fda12ef0so7483647b3.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752497; x=1703357297; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+54beplCkN8DE/PssNmI4FLUUvhXIBJWvRf7L5a6AsQ=;
 b=g9aEeJOvSEqwtuTeJ46JE95UO0txkb5H4T2P8psLmll17xWkDN32cGfGzMpmVA3pPK
 ELdPHwlRRh1kOacboW0C4vjHTL+cJ0l/UWqhlpQr8V7B23t4SSUSpXJnC0GgvXhJzb3P
 XIUb9m/V88KkeQ3t/RDzwHF4eci8Em2LXXvig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752497; x=1703357297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+54beplCkN8DE/PssNmI4FLUUvhXIBJWvRf7L5a6AsQ=;
 b=Pk88rC5H5WIJItsy/BMIy0AiKjKOU3ORJwUqKHtO3kalJS1A1yc9NvUPAD0AF8nm89
 HMeCoGbDJVj2LIdfnPWdXAf8SA6c1NEqpeE9Nuug6dYlCPm092EpCBlvTuG5irKUtJ21
 86N6iNgZv4nEnojzmMKSdCRF9KXiJW+p+3hetaIFYUw0Cy9RO8DjVgrKkUSiKMEAgCJ1
 6P0pf0x+Wv8GtA4Zd0h/oR9mhMpM0S0q90DPRE4x9PkRddEG/YRwm1lYwes05BG3MGYE
 z4rdlREd+VbZoUA+arnA2zfgEuLbIcrpzIqy/dLWWxJqNE16H4KqvWpBGdvDqV2Qdhfa
 58sA==
X-Gm-Message-State: AOJu0YwLElCtIKYWnDmIJF7VEtcWt8RT0PKMhoj+ZIUfllL/9xn9l4me
 +bhscuOs9nx51oOMa/JGvrafwpCvng6MTuHAPvehT1Ot4eRNw4OVsis=
X-Google-Smtp-Source: AGHT+IE+4Zz1dtyH9nSmyfaQRCMrtuBzU9azP9vJ8oHPVO5H9HIOS8TEAC8WXMnW9QUP82iD1cjs8WtYNTvBx8l4tfk=
X-Received: by 2002:a0d:f0c4:0:b0:5e5:64a6:a04 with SMTP id
 z187-20020a0df0c4000000b005e564a60a04mr546846ywe.32.1702752496563; Sat, 16
 Dec 2023 10:48:16 -0800 (PST)
MIME-Version: 1.0
References: <c3c391b1-a7ec-48e5-a193-1c63a6c696bb@longervision.com>
In-Reply-To: <c3c391b1-a7ec-48e5-a193-1c63a6c696bb@longervision.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:47:22 -0700
Message-ID: <CAPnjgZ3GCG7rv0oRrGnWf8o+4fqW7FKFtTeR-H06FpcQWeBbTw@mail.gmail.com>
Subject: Re: Where to find those definition for particular boards?
 CFG_SYS_INIT_RAM_ADDR, CFG_SYS_INIT_RAM_SIZE, GENERATED_GBL_DATA_SIZE? etc.
To: jiapei@longervision.com
Cc: u-boot@lists.denx.de
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

Hi,

On Fri, 15 Dec 2023 at 06:15, Pei Jia <jiapei@longervision.com> wrote:
>
>
> Hi, all:
>
> I'm using a *BeagleV-Fire*, However, I failed to build *u-boot*, and now
> traced to this step. Where to find those *macro values* specifically for
> this board *BeagleV-Fire*?

I assume that beaglebone.org has a U-Boot for this board. Perhaps it
is somewhere at [1] ?

If you are wanting to do the port yourself, then the SoC docs should
provide the memory map.

CUSTOM_SYS_INIT_SP_ADDR could be set to somewhere near the top of RAM,
perhaps? It is just used to start up U-Boot and prepare for
relocation.

>
>
> #ifdef CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR
> #define SYS_INIT_SP_ADDR    CONFIG_CUSTOM_SYS_INIT_SP_ADDR
> #else
> #ifdef CONFIG_MIPS
> #define SYS_INIT_SP_ADDR    (CFG_SYS_SDRAM_BASE + CFG_SYS_INIT_SP_OFFSET)
> #else
> #define SYS_INIT_SP_ADDR    \
>      (CFG_SYS_INIT_RAM_ADDR + CFG_SYS_INIT_RAM_SIZE -
> GENERATED_GBL_DATA_SIZE)
> #endif
> #endif
>
>
> Cheers
>
>
> --
> Dr. Pei Jia
> Email: jiapei@longervision.com
> Cell: +1 778-863-5816 <tel:+17788635816>
> Website: https://www.longervision.ca

Regards,
Simon

[1] https://github.com/orgs/beagleboard/repositories
