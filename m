Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1F8CD3420
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2477B88A1D;
	Sun,  1 Sep 2024 22:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gz5e533k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D464888ABF; Sun,  1 Sep 2024 22:10:01 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F020988B1C
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6c35a23b378so5743936d6.2
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221398; x=1725826198; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O7sPeNhahDutYBf3ACCftDoZNu2cDd1NHS06xK6YfpU=;
 b=gz5e533kqpMO3rbiHSGB441X3WXkylRP7+EGPcgo1OLQruJUcuxke5puu1kIsBkMhn
 4eoFh7N01uruYRQicvdwnApcy8ONzNKkuY8+JwOB+2we6GTdA7AFsFj4AUrCh++MkMRC
 i3BY2Ctjxd/MRy2RAO6Oszk8oDGNlZ++bVNX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221398; x=1725826198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O7sPeNhahDutYBf3ACCftDoZNu2cDd1NHS06xK6YfpU=;
 b=RhDICO8QATF2ptHrVh+Vqwr5t2xxCX9ZPdF/+NmQRD3iVS4OhJvBEbRRHpLxThDbL3
 W/+2t8GM46Nk5iayxSFow5pWvEVCDj7B/DWMXhD55jWAX6s6wPjmHwLDVYHBpMrqvSeM
 bcau3aqkjiVsMacxoXrUKlt8s9M3itMgPRlqvWZHnRxQldEF6ZcWHP85LRotxvFSV4M5
 AKEFVxmd5ldn5tPH2Ua0VAPRQkLYNMB6XdFJBfxfKQ7SNvSQV980kuJz7y68sDQIxXpP
 yxwy6MO0pCw2u4MdRLSjYuI43bQLPhUuWM/kqrqeEa3XZRt70C9kfF2aq8r178aN2iPY
 P2Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmiTcWl76dTiN8QjbfggZu5KLMZMPp5DtcYzXmmY71nyBs3PgFkJe2EMVApDJTQmyHQreTAQI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9oZgSJlA5oD9Y1UFbY1Zn982FeZzPn1EsQXYrldNhmJ/tILxU
 IvqT3XRnNYYnktvj5zDZ4Bqcl2jW2RUQZ63e7mIGOsUxL071Sz+UHpSBrNF3tncjz1bKlfQzJ3+
 vd2MAIFSfU1bve/ka0xqhpLM4STqiRh4s7PyI
X-Google-Smtp-Source: AGHT+IHMzle1p4cCjUE7SHecINlADQbHPPShPaJk3R9DeZIbYtUwsEQuPK4lK1mmDpKugbl+mhZqmkBc8Wh+1bBCq6g=
X-Received: by 2002:a05:6214:570f:b0:6c1:6c63:e62f with SMTP id
 6a1803df08f44-6c33e6a7f48mr162127226d6.51.1725221397819; Sun, 01 Sep 2024
 13:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240830114528.267593-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20240830114528.267593-1-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:09:46 -0600
Message-ID: <CAFLszTiuN6pWqE+j1oEkwXMoVBz6B=4VyUtxWBA-wL6MCkcZPg@mail.gmail.com>
Subject: Re: [PATCH v2] Kconfig: clean up the efi configuration status
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Anton.Antonov@arm.com, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Sean Anderson <sean.anderson@seco.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

On Fri, 30 Aug 2024 at 05:45, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> The EFI_LOADER and EFI config options are randomly scattered under lib/
> making it cumbersome to navigate and enable options, unless you really
> know what you are doing. On top of that the existing options are in
> random order instead of a logical one.
>
> So let's move things around a bit and move them under boot/. Present a
> generic UEFI entry where people can select Capsules, Protocols,
> Services,  and an option to compile U-Boot as an EFI for X86
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since v1:
> - Move the EFI Loader under boot/ instead of having it on the main menu
> - Fold in the U-Boot as an EFI app option under the new EFI menu
>  boot/Kconfig           |   2 +
>  lib/Kconfig            |   2 -
>  lib/efi/Kconfig        |   5 +
>  lib/efi_loader/Kconfig | 204 +++++++++++++++++++++++------------------
>  4 files changed, 124 insertions(+), 89 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
