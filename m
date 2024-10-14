Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6D8D18129
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC7FF891BD;
	Mon, 14 Oct 2024 17:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kGUEzPs3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 280B4891C6; Mon, 14 Oct 2024 17:51:08 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 226DE8916A
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cb97afcec9so39271116d6.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921064; x=1729525864; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AFA1F2UU+j6RBxelTymj8DUs+po8H89ByOgo0HvrCbs=;
 b=kGUEzPs3beTidM8xSDJHcDjNLjeMKcDWX4AVLF2RMZsZM75oWOIIDHBqIsZXUaAwy0
 mo7wd8lpaOoXhNsXt+Y/jeV6Zwp1NJZenr37AiSjE2UNorEkWe/+JzNZWkQxhwSGpGZ8
 bGcFmNOPrbNKv2EctRFF1QsIMjYADVSV2XaT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921064; x=1729525864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AFA1F2UU+j6RBxelTymj8DUs+po8H89ByOgo0HvrCbs=;
 b=tSDD3PMRtG9Y60bnFAWlaDy10M9gb0sU8kf2bogNZh3/CgEK5RE8ST054p7W2Jx9jX
 uCnKPnvvzc2BW5HsCanOSx6IP9XTxyQaJkWMx6c7TuvDMBWLHu0KTXrrYOrWd6ufOVfG
 9W1LCxd7rYx6ju+AowukOxHbcLO1pB/I18KX24Etd1JG9DjAaoyH/esCcL2MyBfdFZ8e
 Keir9EByLJ8X/y+3TBc3UiyqcKtDha9Pkzns3r/FV27gYOF/gzAP+GjjeFBKMOO3RwTS
 nm77m2mb/9SUuW4DnT1KVQ8uzWljrRgF6g4OnI/rjzwON+8xZ/v/3+M4IqJnWxnimeQW
 NNIQ==
X-Gm-Message-State: AOJu0YzfDYaVV2ay35nkJC7l9Mkld43jCxKuFHTiaUoNZx6aOYB82inl
 VXXausI+d3+ZjW3d8VzEsFxXLz9/wcr9mNzXJyJ6HcJBMlPC1xRaB3sOCbbt87HJwqbTv88Sq/h
 ovoEJGks1iic1NszzE/S22dtPmFuX5y3LoIIE
X-Google-Smtp-Source: AGHT+IFhOD1GxoGor9vlosk3CNNhfiUDado/kt0VHYyWlLq/IgGeEjv4ZCFnDT8Yb/kA4ZPgA4Bi5owC7p2+Kilbizw=
X-Received: by 2002:a05:6214:3289:b0:6cb:83a5:8403 with SMTP id
 6a1803df08f44-6cbf005c186mr148698926d6.50.1728921063795; Mon, 14 Oct 2024
 08:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-13-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-13-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:50:53 -0600
Message-ID: <CAFLszTjwdKDuoeXJp=L74Y6U0U56UmnrqK_N9neVjsm8CYfysw@mail.gmail.com>
Subject: Re: [PATCH v3 12/15] x86: e820: use the lmb API for adding RAM memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

Hi Sughosh,

On Sun, 13 Oct 2024 at 04:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The EFI_CONVENTIONAL_MEMORY type is now being managed through the LMB
> module. Add a separate function, lmb_arch_add_memory() to add the RAM
> memory to the LMB memory map. The efi_add_known_memory() function is
> now used for adding any other memory type to the EFI memory map.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2: None
>
>  arch/x86/lib/e820.c | 47 ++++++++++++++++++++++++++++++++++-----------
>  lib/Kconfig         |  2 +-
>  2 files changed, 37 insertions(+), 12 deletions(-)
>

Hmmm x86 is a bit of a mess since it sets up an e820 table and then
uses that to set up EFI!

This should be an event. But otherwise, this patch seems
reasonable...any x86 cleanup can happen later.

Regards,
Simon
