Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3C9C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 13:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9F78886BA;
	Tue, 11 Jun 2024 15:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qz6AO8ud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26FB2886D3; Tue, 11 Jun 2024 15:50:48 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D246388685
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f6dfc17006so7624015ad.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718113844; x=1718718644; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jM42tcihyAMn0HeK3LZ6WE/wbVpPvSpzgOxSx5qxzIU=;
 b=qz6AO8udfnN85dhk/4Asaink6Nq5vk/zkyj8c2RfueoCKasSjrSfdqegAWJ4TciXpm
 Iqn6C25fKgz1rB1+nF1xvK0DkeYTYaRHbUydGLTygD/50LW3ELDyVnm/yj1ug+3hQ2BZ
 tyQKsj1LtfsoYWoscSefKtLsfwH66Sd0sRFYmH7wxZVJn9qUykyOa+mZrUAxR0Jn6hVA
 gpEf+ROspCVVBRurbdW9+7CVnbCUfHASHuw5THGmCle6B4LPjgjhLcT8O5iyeVN91P6D
 PbCm10m1OmMM4iaQSC35EinBCdJRsxs2nJmREc57iK+WX88hjiNnT6zOFW5uZNSXgfez
 nfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718113844; x=1718718644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jM42tcihyAMn0HeK3LZ6WE/wbVpPvSpzgOxSx5qxzIU=;
 b=C3OUs7+4IthWce5eeZyr1JqbcSTuAzYW32UT/YQk4Xo5YHYYaXU9P9g6lmfzssXc8u
 HmV9i9HyGbs423sFUW3x/84SZDxWuyk+3KG5I0w7tpVaAY3id/8MT8nixrkiwOPgtCDd
 7gkFrNEJip/L43jac1aERYuunlMz7/TJG4BWIhyFR5yLofV8lyNYayRWisYpnKnm4v1V
 c94h0nl8EQgHFzeT/Z14ybLFYwAIMtYgk5p2kSPPY76AJBRAdlgnuOjyuEVYI/5FP5ta
 XiC2AICm+E6BIm4NRtQ/k+PUJ8L+1dOu5Kw8ml4RizK/xmBGP4rd87xoBdsUB/oY2PT0
 uLrA==
X-Gm-Message-State: AOJu0YxE1tcOZaDs347E3S2P1t2/XyhiwNkQt562sOQSYzJ07obcqbso
 4QplKtB69gW0O/PSfCgqgZui8lDzdi3IZIRF3TMCAaa9TixwId1/yacBUVqil76HsMhGLY7mVlW
 4/tD2ghAcBcT9tC3bgH+GaWDN7fXbQfntfPAM/Q==
X-Google-Smtp-Source: AGHT+IFns2QNSOXPpYGfLzvMbjzhJutR7WaWAFS1V4tON/Aw1pnYUJtyKtl0aj4PCXGAea+UyxnJ0vs1dTSGNTTQPQY=
X-Received: by 2002:a17:903:32c7:b0:1f7:4ff:d17 with SMTP id
 d9443c01a7336-1f704ff1f5amr64693645ad.3.1718113814457; Tue, 11 Jun 2024
 06:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <20240517-mips-efi-v1-3-79096e3ca3b3@flygoat.com>
In-Reply-To: <20240517-mips-efi-v1-3-79096e3ca3b3@flygoat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Jun 2024 16:49:38 +0300
Message-ID: <CAC_iWjK+KdrYWWfdVVqzyzUia+b7sddKHPF+ziQFp_Am0CbzQQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] Makefile.lib: Preserve .rodata section for EFI file
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Jiaxun


On Fri, 17 May 2024 at 19:33, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> This is required in performing objcopy to MIPS EFI files.
>

This seems not mips specific. What was missing for your case?

Thanks
/Ilias
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  scripts/Makefile.lib | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 62f87517c09c..52aed7a65d47 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -469,7 +469,7 @@ $(obj)/%_efi.S: $(obj)/%.efi
>
>  quiet_cmd_efi_objcopy = OBJCOPY $@
>  cmd_efi_objcopy = $(OBJCOPY) -j .header -j .text -j .sdata -j .data -j \
> -               .dynamic -j .dynsym  -j .rel* -j .rela* -j .reloc \
> +               .dynamic -j .dynsym  -j .rel* -j .rela* -j .reloc -j .rodata \
>                 $(if $(EFI_TARGET),$(EFI_TARGET),-O binary) $^ $@
>
>  $(obj)/%.efi: $(obj)/%_efi.so
>
> --
> 2.34.1
>
