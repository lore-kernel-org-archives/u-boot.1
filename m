Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ED5FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 05:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30D8683FEC;
	Mon,  4 May 2026 07:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QssyRHMb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E7F484255; Mon,  4 May 2026 07:43:27 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C840A83EF9
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 07:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-79495b1aaa7so38695117b3.1
 for <u-boot@lists.denx.de>; Sun, 03 May 2026 22:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777873402; cv=none;
 d=google.com; s=arc-20240605;
 b=kiW8Kg7Wm4keFW+xTeXHGg0J3/UlQFe1s/r+BvWWzNVurUAZTQQ2ku/AEajOt64kTH
 GsbgFumSIiSOOP7ZEUVc6IpARCXbZgXn6D5yoxjQ58yc0iJb+4NzkFXlY0KsgM9NrwDO
 Fz2p3XxtrwPEMGTxKyYiyh1i11ThC+jO0rPa2gQ+wpk9q5KPtxdapDxCMgQ7QW+cvyt+
 kmI4MeU/QHYVX88c0n6ITD8KpEzCFWXbuI/hmepsTtKYiaPySXs9QA0JLR/F/hWTfmkm
 1QpNAcUhvM4vX3FC3Ogw/ZDWf6h24Fx71hyEyl+QQTADPBBZtnEUPPkAWdqEmnAO4V+e
 sxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X9JegrQul9KT3OmxofCQlnT6k+mxp6vxyYWiehpVoHg=;
 fh=4Y8kJEZchCagPLVdL8bXPaT2yGWwO4W3NzTnAzFTFFM=;
 b=CqVjhDvxmtQzt+DzC6F0BCx3Qq9slUCDBE3Wm5JHIdTIMnjBkYxIxybsQokUN4AcQH
 FM76UM7yZAesf0HfA3XZwxuo4lEec583Ps+9SmNlRNj108/V31npTwGviHKsY8NvZOux
 1qPcE6imrBPlnaQEroaZUVUk7b64k0ko5wQv9O7muwCItsz0Oi/1ONcz7DwhaCvpm1VD
 DoFBExFHEqPCXO2YlftORopnQi6hbbp68pd8v5UXyHz7u1/HghhDg084NLy/Sx1wlLxu
 cbhg2ZcefV3zY2wDT1fyMafdt7vB5+sCuzGQkuBqgCDzbBHUIm1XwUszWawbKOTzzi7m
 6JHQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777873402; x=1778478202; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X9JegrQul9KT3OmxofCQlnT6k+mxp6vxyYWiehpVoHg=;
 b=QssyRHMb6oq8kxTUYn+J7EH40Uwa6KcPn/UyhsgMjR3qrsIWK4jYxHHK4uwJjp2KvL
 M73g3tw45nOIt9pRfzdg97LXF/aZvoQKM6iXBANRfj8MMYdsyOUx76XkGYPMNPcV5CjK
 KSej9OV8geHtMeaCxs0llTIkrvXRsGO9PHIjJDK89bXKiuvYC1+C4U5rtb7d/oH1OS9J
 WawDqQ6ZXInGoors/F62AmkY07LAFEu6IWa1t04OLkNuiKOpOHerUfU+Xvu8NcEBesvn
 LMs85Ks613RrJZf6o/xQCSKfQGbJdR2ewsBJz5gRGfAMqPk4pkY0xlVO8rmXFrIyOKaT
 9+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777873402; x=1778478202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X9JegrQul9KT3OmxofCQlnT6k+mxp6vxyYWiehpVoHg=;
 b=srJjnVA1VuhiHeZN6droQpeyOZbm3rUkK2LtMUSXXZ8KPv9/2f3fk4trj2nYtRCFai
 05IWIKp407IV17/QjQ+Zkckev7WS8qSbuR9gejtEj+AIASrzV4VmAgSxZJ5u8vaEVpup
 beuH7G1mMKX9yf3YphtHJGDKmRJZcRtI7/iU6Vo6ziBg7xltK9JM70L85b59rrbsm/zf
 KWwvfa7bE0Aqe+6GzUsYIgOiq+2SGrZ0+qhSv0nJ1VqP8cDulQlLFHxceb4DfhUC2IeG
 Q5Knv9m/UZ7Tb7VR+rG7rr256eiTaGVo2cF55Zw7QOosraUiVwLPecciUNYm27/lTt6x
 gBNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9W4iiJ/6wedS53M1zDkOiAnRApydDwJtD/Al+O7nQiGWcDu3nh5v4JUrIG1qnD7PDd0jKEJZQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxKQfL2JZfe7uMf2OyvbO5yz1OBfXjt7jbCgBUwjRNutGwuaEhq
 lX/gcDLNzJrHcHUCkvssziGsDTCV1Jb7/OSVfHnzvo7nJINzMgFhHzJQ5hlJrnHGfcy86UooAU/
 TyrNWNYBHsJxHXONHAHUdmfJwBUoE9Bav+jxHrRo7Kw==
X-Gm-Gg: AeBDiesFuof+f/sc4NDLILX27Z4Brq7sGNMlGXRscOn02Z6J4zKLWYZzs0ecWZGzfMV
 YK9s0felV+/0F7LeuOgUQyymHhLjBHB9ePtbB/g36KSj3r6y+4NEXPA9+zume5zrnU4d418xByF
 sPjamJOd22fsV3w/CaoZuLcDp/5ChNgrUcVJZ111BO62uhqcR9MRBi1AH+BkHT9uj/TlGUknM9z
 LNu0lYuuyrcpOk6MHh29lHHktpKPn0reHZUEm4rP/UW8hLFz3HtBSqOKelnHiVHheMRG5NE7S2y
 eRrGcoG+zFLMgpBzrttbacm4pZEgor2t5nRYbrNrEX4HY0og4P6NU05MG9WxdEu61uJmF2p5FUZ
 2Wxdpnz/7iRY4NxlU6iwl4LjKwwWHIriCTPzayaSD8G28sT4+LeFH1IVTetlTvLp0o/3+oftu6h
 K3CO/NtEXpW+nz2NgIE/o3ObGCjVxwZuOKSySHdgwvYIuByIKT2p3mTDMQD//5a8OVTIDCOTSXD
 jKoA6pyVOzZT0nTlU3JchIGPCm3Cj5ygUopciwkT19vTVFLJnBKMtRqcZDAvefZH1pMvfqzrA1L
 wCsSaxUEEw+d4NY6YSTozUgWZTiGisEAyRtL1dEdGr+zFRF0hdR0I01fDk4RMRm+Bz9Lh8oRtDQ
 fM9DWLPI9puUvZHSI
X-Received: by 2002:a53:d789:0:b0:65c:391:571c with SMTP id
 956f58d0204a3-65c3db4fd58mr6360222d50.49.1777873402332; Sun, 03 May 2026
 22:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260429165629.104063-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260429165629.104063-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 4 May 2026 08:42:46 +0300
X-Gm-Features: AVHnY4JTkzh591oVslHFRbwDtYhAv6ug84gBe5KzDwPHfSVYr5q-_HUhyZYgako
Message-ID: <CAC_iWjLiAEHJ3NNtdO7NJf1gGaRw1U456om2k7sOgtBFJUo+ww@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: eficonfig: adjust struct eficonfig_entry,
 field key
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
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

On Wed, 29 Apr 2026 at 19:56, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The number EFICONFIG_ENTRY_NUM_MAX - 1 must be printable
> to field key of struct eficonfig_entry.
>
> Fixes: 1f0583beeb32 ("eficonfig: set EFICONFIG_ENTRY_NUM_MAX to INT_MAX - 1")
> Fixes: 23aa0502a4b9 ("eficonfig: increase the number of menu entries")
> Addresses-Coverity-ID: 583414 - Out-of-bounds write
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  include/efi_config.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/efi_config.h b/include/efi_config.h
> index 23211e799fc..bff77a5f961 100644
> --- a/include/efi_config.h
> +++ b/include/efi_config.h
> @@ -24,7 +24,7 @@ typedef efi_status_t (*eficonfig_entry_func)(void *data);
>   *
>   * @num:       menu entry index
>   * @title:     title of entry
> - * @key:       unique key
> + * @key:       unique key, takes a number up to EFICONFIG_ENTRY_NUM_MAX - 1
>   * @efi_menu:  pointer to the menu structure
>   * @func:      callback function to be called when this entry is selected
>   * @data:      data to be passed to the callback function, caller must free() this pointer
> @@ -33,7 +33,7 @@ typedef efi_status_t (*eficonfig_entry_func)(void *data);
>  struct eficonfig_entry {
>         u32 num;
>         char *title;
> -       char key[3];
> +       char key[11];
>         struct efimenu *efi_menu;
>         eficonfig_entry_func func;
>         void *data;
> --
> 2.53.0
>
