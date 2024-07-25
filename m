Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB733C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 14:26:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30A4086D4C;
	Thu, 25 Jul 2024 16:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="isnopeVL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08CD186E35; Thu, 25 Jul 2024 16:26:24 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54AE286464
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70d25b5b6b0so697691b3a.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 07:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721917580; x=1722522380; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RRlwJjN9uGUxYK2IKt1G0pPBIH8ezMJ0gwtOqeQCVl0=;
 b=isnopeVLBTC9qSuOQK0sDtYDx297nZB59UXNcfXak5HAF09fmKgSfXluZUNOhwm8Pg
 E4n2MsYxVdLREZmqHYFQYyoHgzP+s0uaEs+lAha/moc+AQcFrD5+n7XARiZ3WRuXkoyg
 PgV5H4cMi+nRhhLzDeRml3KvWAT/itHGVek4ZaVbbsEsrimaESWEsTb56ltHG44+pg1g
 5Lc6W8tYW+STdstSRi2upBUXJ6lwuxDS0S2UH+28SlBfxWRE1lZ6xW0ayoBjoi0/XUsD
 UL9YUtdZZfeSX62aatMUlpuCEaCt5lDewtLMqO3r4JdDjZwnRAk3dNYgDMP0SbtgBRFO
 XF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721917580; x=1722522380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RRlwJjN9uGUxYK2IKt1G0pPBIH8ezMJ0gwtOqeQCVl0=;
 b=pS7kVMawK91gJH14PwfmMDLYgSmhu+9TZIBAZitIIr2J+9cl/OQPSt0VQj+HOpsfCs
 tTWasJcgescnz3SWMlVsK3xIkx7umZICjRsnygzUNk8d3HGOP2awEBmLvblSY57dglEX
 SUdqV90tQbsQ2nlejix9GWI8Hpjuph4mVfOSPplis8ENEogApANktvKa1PKnSAZhjjAB
 Il+A5L+LweIWQvWKUtrgkTvNlWD4MnJ+/Efv132bXrHnTUccNmDLc8bpgKT1C+jfYmu+
 b/ci5YyS+o+8XcqjHkOKwD4UuEFRT/wn+AHZyyYvSP11kmD3auzEUF4ySo/EUSccUmZC
 wjDQ==
X-Gm-Message-State: AOJu0YxhMpYfTH/kTPneGGBGtuQMabbGCP1IpvCF+26FgoZG6fMxYH2o
 HoAdMfIDIkhUfPWna/zq0PMqOO9MnEMykPMyDsf9TKNWARfsP/5COS2ClykwANfmG2Laa25GSBU
 fRTRWc9q84zsfVUoMRDjJxPBBodx0Ey3MBgXpvQ==
X-Google-Smtp-Source: AGHT+IHfwU2bCVQBC0GWcnaoiQSlBjd3syVk7VzOtCrbdyFWUL+g69MGjjC4GZMPtVZgam+hfgREXWU66ZBd2kK3SKA=
X-Received: by 2002:a05:6a21:3390:b0:1c0:e3bb:83ba with SMTP id
 adf61e73a8af0-1c4727a5fa5mr4059037637.5.1721917579635; Thu, 25 Jul 2024
 07:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240725135629.3505072-1-sjg@chromium.org>
In-Reply-To: <20240725135629.3505072-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 25 Jul 2024 17:25:42 +0300
Message-ID: <CAC_iWjK4gn8GkUb7khSQFMC+LqPN4PQZLxqJK+gZE_TLnMfUKQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] efi: Start tidying up memory management
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Simon

On Thu, 25 Jul 2024 at 16:58, Simon Glass <sjg@chromium.org> wrote:
>
> We have been discussing the state of EFI memory management for some
> years so I thought it might be best to send a short series showing some
> of the issues we have talked about.
>
> This one just deals with memory allocation. It provides a way to detect
> EFI 'page allocations' when U-Boot' malloc() should be used. It should
> help us to clean up this area of U-Boot.
>
> It also updates EFI to use U-Boot memory allocation for the pool. Most
> functions use that anyway and it is much more efficient. It also avoids
> allocating things 'in space' in conflict with the loaded images.
>
> This series also includes a little patch to show more information in
> the index for the EFI pages.
>
> Note that this series is independent from Sugosh's lmb series[1],
> although I believe it will point the way to simplifying some of the
> later patches in that series.
>
> Overall, some issues which should be resolved are:
> - allocation inconsistency, e.g. efi_add_protocol() uses malloc() but
>   efi_dp_dup() does not (this series makes a start)

The EFI memory allocations and mappings are described in the EFI spec.
Look at chapter 7.2 Memory Allocation Services. This patchset breaks
various aspects of the spec, since the metadata needed for the EFI
memory map is not kept from malloc. The reason efi_add_protocol() uses
calloc, is that this is memory used from our internal implementation
of the protocol linked list -- IOW how to search and identify
protocols that we add in a list and not UEFI boot or runtime services.

Thanks
/Ilias


> - change efi_bl_init() to register events later, when the devices are
>   actually used
> - rather than efi_set_bootdev(), provide a bootstd way to take note of
>   the device images came from and allow EFI to query that when needed
> - EFI_LOADER_BOUNCE_BUFFER - can use U-Boot bounce buffers?
>
> Minor questions on my mind:
> - is unaligned access useful? Is there a performance penalty?
> - API confusion about whether something is an address or a pointer
>
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=416441
>
>
> Simon Glass (6):
>   doc: Show more information in efi index
>   efi: Convert device_path allocation to use malloc()
>   efi: Allow monitoring of page allocations
>   efi: Avoid pool allocation in efi_get_memory_map_alloc()
>   efi: Use malloc() for the EFI pool
>   efi: Show the location of the bounce buffer
>
>  doc/develop/uefi/index.rst               |   2 +-
>  include/efi_loader.h                     |  24 ++++
>  lib/efi_loader/efi_bootbin.c             |  10 ++
>  lib/efi_loader/efi_device_path.c         |  43 ++++---
>  lib/efi_loader/efi_device_path_to_text.c |   2 +-
>  lib/efi_loader/efi_memory.c              | 148 +++++++++++------------
>  lib/efi_loader/efi_setup.c               |   7 ++
>  7 files changed, 133 insertions(+), 103 deletions(-)
>
> --
> 2.34.1
>
