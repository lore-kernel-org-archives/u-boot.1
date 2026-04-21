Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E63EF94CAA
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 20:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8AAD80433;
	Tue, 21 Apr 2026 22:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aB/Mt/LY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E60F383FED; Tue, 21 Apr 2026 22:42:48 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4668180433
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 22:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ba5b107eaa2so169633866b.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:42:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776804166; cv=none;
 d=google.com; s=arc-20240605;
 b=ZeMOdQ5mJRWFARUUCWyUHUdH8flKteFF5osyAmbDyMrg8EJfVrL1NG7Puy1F5Ipml5
 qSb6LO27cNO/Lo/b5KB32ifkuZhAXH1L/qzJ4fn6u7I0FMPMdarOWS+kkH9o3gZ2k9re
 +Ywz4cTwcIVdF8K/OnlKO6bmj/obX11v0h7UBscN0MfsRJlGW49lRW1ZoI/Uzr7w83xM
 RPS9LDD1NWV5NhCFijlB8jx9M4ueQTdy7uamsdjrDzPnC9KSHu4BaGwP2gfd1eJJ5ShI
 8Nymdk0fv6/+VxhuSUTn9z23P6wL/oakK6/cA02PkoUdYwIGoBkLAJQBKl2qCAZ0X6yC
 BbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tHXcsnRqmkE79jCcDEJaqbIaXZN7xllKDsIgM6CoRIc=;
 fh=VotdAeOBTvm9DU94Rw6PBYjbvlHh0uHd97nnQV3+qtw=;
 b=Y9yrZuWMLDqhpEIioamPv3BegdpYWRpC9lJutQci744qV0R8Jjnq6+bkIUHbaHdz+x
 CyuRPpYSw/wXjWASk+U+RJrWdDqJsQzGD6J96YNYPfKsFbxC8vdDu156g3qs7ZoqtHVU
 ZvMvRNsJurpG0jhvTWfYzGlkz221WfD1HGJoeNGwfSRKVd+JmPlXKBva+Drv61RY6Bfi
 vFY3g34kXbx93J0rkHrZbdutps1eVMzhiISsfdBT9lv2SC36risaugpEcAcIfhsRgVSc
 JaNtH0lGBrHCOz14WFCZq2ybFwYfz+GC9fDCGVTP0pqggRv9HfUXjWDmakIqv5wZGkQ6
 j0IQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776804166; x=1777408966; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tHXcsnRqmkE79jCcDEJaqbIaXZN7xllKDsIgM6CoRIc=;
 b=aB/Mt/LYoO5QkPrEhYtJ3qz99bc1eZGuyQ5V/tY18/vcOsJcAmg9ZzmpD1gu63BqOS
 EfOQ2sgGycV1maMtPFwoybU0xL9jCUpkg9fy5d1TouIYozrQRPepRB2pui2fsWX/vd66
 5LfuVv6uJ5J6FaxjtMJyrD9SYjLvkDkBc9eRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776804166; x=1777408966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHXcsnRqmkE79jCcDEJaqbIaXZN7xllKDsIgM6CoRIc=;
 b=cOTymf4rvIhFE7T+XMOH20spfATUdiVYqEn2Q1HKwjHekjeln7md3tKKHSx5fPawyP
 TDh9gkBu2bJtcA99x6OOJRqflHffNFaHTcmI9+XJ+Hp9LLSiSEEuaq7Bv9IInRkc3cEH
 fgZBjm09SWSI4NIwe5gB6UzginK5ee+h9lWi49f+Kubgsd3ptWB5f/Wl2qXzmStETw2l
 Gwri4wTL5iFX5Ot7Jg80jzUlJefLnz1sy1jY35NTft9lFfKUW+NlxUyeyKoyqsSCBBwB
 zFRmmKdSa6Gzs6Fic/mEfI/tnrV8j5cp1dVvmB6htG/15DdGM+rC2OpyTG9KZI0U0frL
 yOrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ulIlTs+YKMJ8nIvAgeMkJSkNmaBtsSMkRLNeAyBImpidSd+DgXMuR4pswuDh0NPSh0P21O7s=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3ON4QIubahJQVrJutxJv8ZMd5UNkMsYmCZnAwaxDl6Elrolb/
 qegiofxuELZa41zSB9ltNTBkJ6g5fkSOm764pKavYU2QPG82txh8T1mMd9iMUjMVleQumhSYz/R
 A25LlRn8TogxrPhQpS/VF0Z2SA1/xdEal0QWvIusn
X-Gm-Gg: AeBDies3aK6mxwhHMzLloEd2m9/STyzM4Pd0wHEjwkJF36XT8pcJUCZNUOpLoyfHjOD
 xjghdIwMJ4aNaRd6e2N4+22MzeEM6HOkEsWiWuG2AnTqdCtIPkRj92rNs2wACr734JICnX+LY0q
 MCzaGaNVf2t6U1M6LR/zCBqN3mnAl0z37btJoRoM4smVviUBsbr5nnP5zY53RApzmIZ9i7Rg4cM
 OZtys2N7YOzSnoSCEXVmOVLDKV77zT4m4IBPJGgGyCbEJt3UJJUWROrzhpVMBWrqB4+qErPT/DI
 hR+LBHXxXDCR5X9ufpZ7
X-Received: by 2002:a17:907:a607:b0:b9d:31c2:37f9 with SMTP id
 a640c23a62f3a-ba41828cbe5mr1036681866b.2.1776804165690; Tue, 21 Apr 2026
 13:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260420192520.1444749-1-rs@ti.com>
 <20260420192520.1444749-7-rs@ti.com>
In-Reply-To: <20260420192520.1444749-7-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 08:42:33 +1200
X-Gm-Features: AQROBzA5YXBx5syY2COc5zcLwe9WBPO8pgHCa0x2oEPsgB-qpuXHb3wGO573l24
Message-ID: <CAFLszTgjKjDKeF4eX0-tWe6a_TCDMnVrpQQAhnKb=zhTR4OUdw@mail.gmail.com>
Subject: Re: [PATCHv4 6/6] memory: reserve from start_addr_sp to
 initial_relocaddr
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
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

Hi Randolph,

On 2026-04-20T19:25:18, Randolph Sapp <rs@ti.com> wrote:
> memory: reserve from start_addr_sp to initial_relocaddr
>
> Add a new global data struct member called initial_relocaddr. This
> stores the original value of relocaddr, directly from setup_dest_addr.
> This is specifically to avoid any adjustments made by other init
> functions.
>
> Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
> gd->initial_relocaddr instead of gd->ram_top. This allows platform
> specific relocation addresses to work without unnecessarily painting
> over a large range.
>
> Since PRAM comes out of this initial area up to initial_relocaddr, we no
> longer need to account for it separately.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
>
> common/board_f.c                  |  9 ++++++++-
>  include/asm-generic/global_data.h |  7 +++++++
>  lib/efi_loader/efi_memory.c       |  9 ++++++---
>  lib/lmb.c                         | 39 ++++++---------------------------------
>  4 files changed, 27 insertions(+), 37 deletions(-)

> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> @@ -868,9 +868,12 @@ static void add_u_boot_and_runtime(void)
> +     uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
> +                    uboot_stack_size) &
> +                   ~EFI_PAGE_MASK;
> +     uboot_pages = (((uintptr_t)map_sysmem(gd->initial_relocaddr, 0) -
> +                     uboot_start) +
> +                    EFI_PAGE_MASK) >>
> +                   EFI_PAGE_SHIFT;

The reformatting makes the code harder to read. Please can you keep
the original formatting style and just change the variable reference?
Something like:

uboot_pages = ((uintptr_t)map_sysmem(gd->initial_relocaddr, 0) -
               uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;

Regards,
Simon
