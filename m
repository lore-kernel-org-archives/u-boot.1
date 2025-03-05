Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2668C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 08:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED8B6807B1;
	Wed,  5 Mar 2025 09:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qIQMgq7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD966807D9; Wed,  5 Mar 2025 09:13:23 +0100 (CET)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90241800C1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 09:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-867129fdb0aso5675098241.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 00:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741162400; x=1741767200; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jVglfwvUm0Xb4bVFnaO7u3WydqaKYSKwa23VkpqAPto=;
 b=qIQMgq7o/eS9SWkFkLpu4xIFa3us2RbLgQ2UZ8yWtcJH2+GPlE1/UgEUlyPUSqO9YP
 419yajmW32ag+dU+cRYDCx6LTMcrsM0asJ7uGKiZMRFdNTEypAkCOGhLP1T6+8IkRDDP
 IC0CfvuQb8SR1RciGuP+tzOkGuVZr2BFZ/L/YvDqVN9JgPMUMGpEg5ya71jg9QsizcBD
 xEl+aEpLiNZpidRn1XnBNFrr8foXhfbe0HFJsz9bjGqvdiPprZk69siJ1mqfK/VfOeLS
 Ekr9ZXiFh/rvnhx32rigJArfQgIlUeujj5RVMtFEj3IH1aFNRYyF9eadxVJqXgSk7KR4
 92GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741162400; x=1741767200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jVglfwvUm0Xb4bVFnaO7u3WydqaKYSKwa23VkpqAPto=;
 b=FOq5aQVM/jW202KZd51SXISXrv2JLdm4tBDVALfvIyWmctX0Xld1GqcfxO7KREb1QW
 6qkGqwT0Uji+COvCZZdfmEfdlwFChBaWc/zp6CuwlEEy4Ud/MJ5yhHQICSnZ7u8Ezs8O
 HgBWqCSclHXFQZ2qYSi/fS9byAjOVeuRvKfsHFQTw9u13WQUWZLIu6cbdu9q1K+/wbcr
 kA8q3TaPn5+Oud3O/k5IfY5zGjPghaxsxiAZtwwqd1IBNxVeLZ36Bvud+Ghhs9iWaf+h
 QkBc45SiwpBailnyb0MB9rRO34maJv42qkLq7kiIaGAbOY6+hiHv5tTdEt7S+u80vGpA
 8Caw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgFFRwhNVB5MzWXeWvLNxCTfP8bb0qlI8SIvtZXrJeUEuVmLiNyB2B6poxntDrkUG69EN4FA8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywz2NKc7jmKJjHLPWH24w7uQmpZCsNYr/nmsGYWCIXDBEir6sBW
 kU62EPds36yjj894HSrn61DqNYRFEvlenEzbYOS/OFUtUPdszc647AihdZqjW6dIC+6ET2P+YN5
 R2jo8DPTjdz6BJL0kEOzl3P8YVO62j0deMuSxGA==
X-Gm-Gg: ASbGncvC1Aqae6MJ83CerGt2TyoCiqr2yrOn6tSK+oC7Pz+2IFHDpvwjqPZqFVKFLdK
 m0AZOPk3lMopRoIxlyoHyzfiyARv+tfw5eWtTsuohghwvN6GUTKERHpjbjcVAE5deNObs5w3uzV
 uKq5wnbOpFu/Mn3hHkp2cZArPkEko=
X-Google-Smtp-Source: AGHT+IEs1rIingepAAv/bBgsyK4G2QlHq+aYfclSekFG4ExqPxuWQZfTjXjUnjOJamypk/bUsl3kcZoTfjVyLiJ6KBQ=
X-Received: by 2002:a05:6102:a48:b0:4c1:b022:2a60 with SMTP id
 ada2fe7eead31-4c2e2993539mr1035820137.24.1741162400383; Wed, 05 Mar 2025
 00:13:20 -0800 (PST)
MIME-Version: 1.0
References: <CdUirikQxEto6yzkO-G-y6mmWa-ek5NZPN9K7EYvyeUAmnxuge6UmHxfp0tb580qFmfHacX5aWFLqrXjXAFs87nP14AZ72vkClzp3U3WBw4=@bens.haus>
In-Reply-To: <CdUirikQxEto6yzkO-G-y6mmWa-ek5NZPN9K7EYvyeUAmnxuge6UmHxfp0tb580qFmfHacX5aWFLqrXjXAFs87nP14AZ72vkClzp3U3WBw4=@bens.haus>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 5 Mar 2025 13:43:09 +0530
X-Gm-Features: AQ5f1JoiUs00qR_4V7Q2gkNiO0M4Q9z4IhGsBvq2Uft1wN4jh8ioAniYZiZKWAs
Message-ID: <CADg8p971xqUzCHhV_yZDXbn8OMn_V2DfHoVschZOTfx1dFvV1A@mail.gmail.com>
Subject: Re: boottime->efi_allocate_pages() returning EFI_NOT_FOUND
To: Ben Schneider <ben@bens.haus>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Tue, 4 Mar 2025 at 23:34, Ben Schneider <ben@bens.haus> wrote:
>
> Hi, I'm trying to boot a compressed (via zboot) Linux kernel image
> for aarch64 and running into an error I didn't expect.
>
> To decompress itself, the kernel will run efi_zboot_entry() (found
> in drivers/firmware/efi/libstub/zboot.c) which wants additional
> memory so it asks for it via a call to the UEFI AllocatePages()
> service.
>
> U-Boot receives that request and runs efi_allocate_pages() (found
> in lib/efi_loader/efi_memory.c). In its call, Linux is setting
> type = EFI_ALLOCATE_ADDRESS, and memory_type = EFI_LOADER_CODE.
>
> Based on some testing, it seems that the call to lmb_alloc_addr()
> is not returning an address so efi_allocate_pages() returns
> along this path:
>
> addr = map_to_sysmem((void *)(uintptr_t)*memory);
> addr = (u64)lmb_alloc_addr(addr, len, flags);
> if (!addr)
>         return EFI_NOT_FOUND;
>

Can you check what is the address being asked for in the
lmb_alloc_addr() function. Then you can check through the bdinfo
command if that address is already reserved, or not added to the
memory map.

-sughosh

> It's not clear to me why I'm getting this error. I am using U-Boot
> 2025.04-rc3 configured with mvebu_espressobin_ultra-
> 8f3720_defconfig. I use Standard Boot (bootflow scan -b) to find
> and load a systemd-boot EFI application which then tries to boot
> the compressed Linux kernel. I am encountering this issue on a
> real device with 1GB of memory. I would appreciate any guidance.
>
> Thank you!
>
> Ben
