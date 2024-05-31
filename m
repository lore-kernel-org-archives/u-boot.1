Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F60C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 06:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4470E8879F;
	Fri, 31 May 2024 08:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pte3PvZD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30BA2887A1; Fri, 31 May 2024 08:52:14 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AF4188270
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 08:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3d1d3c7f7c6so954155b6e.3
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 23:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717138331; x=1717743131; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wIf8nV+Z7Tni0mNE+pCh69fMe+4+uNgnecytVufMdZM=;
 b=Pte3PvZDY7okeuCSJz9KMS3y5TO59ZTjUxBC6vP4o0luNqZgolU9KRBrNwTPuszxC9
 8v7okW6GJ0Jey1wCImnUjtW0UlBtVriDsgtdOEKM0Ik+E1V9za17UjTsMEkFuKJ+MHYX
 Z6jk/yRCG+jfXUCzbhyzVNoUJSorVdJO8akbLJfhZ4yunJGrakj+WFqm4Lk9YEBXDsZ+
 tLUbxU6Y3WdjMdb8Jlv159BRaooMbmgq6Rnm1VFnc7lB+9fIxnlt+f5EF9SA2s5oDGl/
 0Qz4mjSGfIx9uwcrcB0abTnpW8EswDuSGwtLXTzn+ecmqDJCAVgA5dsXBGMUnSP13ACA
 Ziog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717138331; x=1717743131;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wIf8nV+Z7Tni0mNE+pCh69fMe+4+uNgnecytVufMdZM=;
 b=bBcQ1fHbFtmvv1ZJPUVYdU3CStVTz2GktgKVd+KMUaYFJ3yPXiCk28vHL41CXmAoXB
 w+8b4G60QXkUwObpjMkp2uvDfgFoar4Y93gLUeZokhGOW0jU+DJB0vkDYOXfKwutUnli
 GYEEnuGveBbTI3M8TNoLnxzgvenkZWRQd023WpdaD49S1RbAAfyvIxKJfTvSeMSmgmmv
 +jUNf7JmhvvUnUOSTNXmXNC3oDbuvj7irDepSHlgTFMSpdS+mFaCkOPy1hiNdf5XDjGN
 lFocLk6+z6K6tk+zutUgtXESnTHyiuAQFx7WfXMLdc6R+L1KHET/WKQkSo9ORjo7CUqA
 /hAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5+U8GHsehaQo+9oxjnAXR7rg00szHbPLFr81NvkF0MEHbZdjP0Q5SiHspDdxTaC8P/ilgSMssb1xSDdiQqCSkvxMGTQ==
X-Gm-Message-State: AOJu0YwyXRxb78iaSmZNnaB4lxI425b3MEKna2Z4iWQeLcrO3skIpoTl
 kpmTcQjQktYoTonu7bQWvswAAQsyzvNxl3ZjXoEiEhhoVbj+mFmpFtIz8a54pqr2LE6V7IWRudp
 5qtGcDDvleGF5rUmEDxS/kSC9/0k=
X-Google-Smtp-Source: AGHT+IHLXfiOOQWlaClKJo86qkdKnY2SsNrHrJuc1Tj6NSaCPHCbTHuLdfhZFl9i+mYBDvnyYdftZ50O/WjnB2xx154=
X-Received: by 2002:a05:6870:5a6:b0:24c:ba5b:54d6 with SMTP id
 586e51a60fabf-2508bbfca87mr1302766fac.59.1717138330716; Thu, 30 May 2024
 23:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240525215330.16609-1-semen.protsenko@linaro.org>
In-Reply-To: <20240525215330.16609-1-semen.protsenko@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Fri, 31 May 2024 15:51:55 +0900
Message-ID: <CALrBrZ1YP6DfxuX6+DGR_GUfiKe3EFv59bJcLQHbPZyg9rT+WQ@mail.gmail.com>
Subject: Re: [PATCH] arm: exynos: Map iRAM APM area for Exynos850 SoC
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Sun, 26 May 2024 at 06:53, Sam Protsenko <semen.protsenko@linaro.org>
wrote:

> This iRAM APM area is needed for I3C access to PMIC via APM block.
> Without this mapping any access to APM iRAM leads to "Synchronous Abort"
> exception.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  arch/arm/mach-exynos/mmu-arm64.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/mach-exynos/mmu-arm64.c
> b/arch/arm/mach-exynos/mmu-arm64.c
> index 30e522804fbf..4c154950f73b 100644
> --- a/arch/arm/mach-exynos/mmu-arm64.c
> +++ b/arch/arm/mach-exynos/mmu-arm64.c
> @@ -101,6 +101,14 @@ struct mm_region *mem_map = exynos7880_mem_map;
>
>  static struct mm_region exynos850_mem_map[] = {
>         {
> +               /* iRAM */
> +               .virt = 0x02000000UL,
> +               .phys = 0x02000000UL,
> +               .size = SZ_2M,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
>                 /* Peripheral block */
>                 .virt = 0x10000000UL,
>                 .phys = 0x10000000UL,
> --
> 2.39.2
>
>
applied to u-boot-samsung.

-- 
Thanks,
Minkyu Kang.
