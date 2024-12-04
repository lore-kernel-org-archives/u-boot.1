Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3EAE7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 14:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 326AF89384;
	Wed,  4 Dec 2024 15:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zvFy5mGV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1445B8936B; Wed,  4 Dec 2024 15:46:44 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94C4D89384
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 15:46:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa578d10d50so1098157466b.1
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 06:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733323601; x=1733928401; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6GnE0ym8yvfSqeczs6FmG+JjA31lv8h3rsJr3W3Hst8=;
 b=zvFy5mGVTQlnN8TRnK/ZxWIOJ7LOXUVdRuSfO85J1C+dHXvp2Zz72G3cVJiQXp12WA
 dznhXM0c1QR4zjWUezAnbXZ0T8R+sWSEyBSe98obkVFdsaqw8LTwuZKjxCo9Msz+pAOv
 6yFBufx9AgDJL8cZJAhNwUDQq008KksuI58WbO8VsFIR/dym+fJNHo50X9oOtk7wl5oy
 K+4d0egoE0SVTHMeMexFyhZi0piI/RsCVov86Ew7y2yJbqZ6gsXeUDMzVRnF1POuXoLp
 UjElwJvX6MtjwL+L6omZ9wBeuO7hHSkv01fITcLJ9N/2IJ6TJ49EON+QtOs7EkltBhBB
 qnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733323601; x=1733928401;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6GnE0ym8yvfSqeczs6FmG+JjA31lv8h3rsJr3W3Hst8=;
 b=ZYliP4KXv/Py0NqDuoFtP8u2Z6qWpp7b/y5kLgIBUWlSBc3+Gde5536TticI18cUq5
 SCmp/8iRI/cs1soV83WS7msNqYuHiMrGNBii1UDkSbeuXf8cMMR6t8RQQhgqpWJ/TXz7
 d3iJ6RLtDfN1UYc2mIvmho9i4tBEAOLPe2F3do9eCVaf3U5SOZ/lxjhHUNJvydAWS18G
 e1ml5f+jzO7+7ga5rOdyRB6IVpkoq5rjjD18CkIM80CRYMChhuG6CUqjgIhFEusI6OEp
 e2QG56hT3ygwN5NSvfARsbIdM58NXfhtCKnS18WbArQR6aIDU8FLit2RM/Q2BhPViueQ
 X+xA==
X-Gm-Message-State: AOJu0YyX/XPFj2Paf5ZWZnU+WPZablE9YcLdjymcVyJaWtN12ihPN0mt
 Cx8UVFIgYMtQdkF6oh28lJmxqyz7JY2qNCvlDxdNTWxmNq/rjA7xbRXFhT5k7mA=
X-Gm-Gg: ASbGnctzrX0UVjxVVwZbpq/zOVLQUW8476Go0RUUCLcStfZux1ofDJRVFKpuhdQX1dx
 AwvdVpnusM78AokRGgFyonS3UsFfzDxNMLZQNITIzJ8N5L9586k1bTBfWGCt5POfLhQk2YTE9HR
 lqtjoMKy56Uavtkpt+7iNLAhhkvzDl/aDr+6c38Y9lB4p9UqargdEFCpM5c8ZXLoK+J61IU/YY+
 gZ6uDTOmFKxQJVyZcOGSq6hN4posqAzdVC9m/4/Ews7mzvGXZMOdxSJfcTLJKvQtXQ+7UjJQqBM
 JTTk
X-Google-Smtp-Source: AGHT+IGu327vx270grLRKQC+nHCUege1xmDuA/+BnwLstY/GsMK2f8CRE6BdPTNyVFLgtUBd981m5A==
X-Received: by 2002:a17:906:b391:b0:aa5:cec:2785 with SMTP id
 a640c23a62f3a-aa601818e29mr444298366b.25.1733323600862; 
 Wed, 04 Dec 2024 06:46:40 -0800 (PST)
Received: from hera (ppp176092181030.access.hol.gr. [176.92.181.30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa599905defsm738265266b.137.2024.12.04.06.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 06:46:40 -0800 (PST)
Date: Wed, 4 Dec 2024 16:46:37 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matthias Brugger <mbrugger@suse.com>, Moritz Fischer <moritzf@google.com>,
 Patrick Wildt <pwildt@google.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v4 00/25] efi: Tidy up confusion between pointers and
 addresses
Message-ID: <Z1BrTaDcP0Aqk0Ym@hera>
References: <20241201152505.1666789-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201152505.1666789-1-sjg@chromium.org>
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

Hi Simon,

On Sun, Dec 01, 2024 at 08:24:19AM -0700, Simon Glass wrote:
> The EFI-loader implementation converts things back and forth between
> addresses and pointers, with not much consistency in how this is done.
>
> Within most of U-Boot a pointer is a void * and an address is a ulong
>
> This convention is very helpful, since it is obvious in common code as
> to whether you need to call map_sysmem() and friends, or not.
>
> As part of cleaning up the EFI memory-management, I found it almost
> impossible to know in some cases whether something is an address or a
> pointer. I decided to give up on that and come back to it when this is
> resolved.
>
> This series starts applying the normal ulong/void * convention to the
> EFI_loader code, so making things easier to follow. For now, u64 is
> often used instead of ulong, but the effect is the same.
>
> The main changes are:
> - Rather than using the external struct efi_mem_desc data-structure for
>   internal bookkeeping, create a new one, so it can have different
>   semantics
> - Within efi_memory.c addresses are used, rather than addresses
>   masquerading as pointers. The conversions are done in efi_boottime
>
> Link: https://lore.kernel.org/u-boot/20240725135629.3505072-1-sjg@chromium.org/

In v3 I did ask you to run SCT and spent some time on IRC to explain how to
run it.
The existing code passes all tests related to memory allocations.
This patch introduced 99 failures in MemoryAllocationServicesTest.
Apart from all the other feedback, SCT must pass.

Thanks
/Ilias

>
> Changes in v4:
> - Add new patch to show the address for pool allocations
> - Combine the various pointer-to-address patches into one
>
> Changes in v3:
> - Adjust comments
> - Show the returned address rather than the pointer
> - Put the header-file in its own section
> - Add comment to struct efi_device_path_memory
> - Use a pointer for the values in struct efi_device_path_memory
>
> Changes in v2:
> - Fix missing @
> - Note that this holds pointers, not addresses
> - Add a new patch with comments where incorrect addresses are used
> - Use EFI_PRINT() instead of log_debug()
> - Rebase on early patch
> - Add new patch to add the EFI-loader API documentation
> - Drop the changes to the boottime API
> - Add new patch to use a separate stuct for memory nodes
> - Drop patch 'Convert efi_get_memory_map() to return pointers'
> - Drop patch 'efi_loader: Make more use of ulong'
> - Significantly expand and redirect the series
>
> Simon Glass (25):
>   efi: Define fields in struct efi_mem_desc
>   efi_loader: Fix typos in enum efi_allocate_type
>   efi_loader: Drop extra brackets in efi_mem_carve_out()
>   efi_loader: Add comments where incorrect addresses are used
>   efi_loader: Show the resulting memory address from an alloc
>   efi_loader: Update startimage_exit self-test to check error
>   efi_loader: Move some memory-function comments to header
>   doc: efi: Add the EFI-loader API documentation
>   efi_loader: Use the enum for memory type
>   efi_loader: Use a separate struct for memory nodes
>   efi_loader: Drop virtual_start from priv_mem_desc
>   efi_loader: Drop reserved from priv_mem_desc
>   efi_loader: Use the enum for the memory type in priv_mem_desc
>   efi_loader: Avoid assigning desc in efi_mem_carve_out()
>   efi_loader: Move struct efi_mem_list fields together
>   efi_loader: Rename struct efi_mem_list to mem_node
>   efi_loader: Rename physical_start to base
>   efi_loader: Use correct type in efi_add_runtime_mmio()
>   efi_loader: Show the address for pool allocations
>   efi_loader: Don't try to add sandbox runtime code
>   efi_loader: Update to use addresses internally
>   efi_loader: Correct address-usage in copy_fdt()
>   efi_loader: Drop comments about incorrect addresses
>   efi_bootmgr: Avoid casts in try_load_from_uri_path()
>   efi_loader: Simplify efi_dp_from_mem()
>
>  arch/arm/cpu/armv8/fsl-layerscape/cpu.c       |   2 +-
>  arch/arm/mach-bcm283x/reset.c                 |   2 +-
>  doc/api/efi.rst                               |   6 +
>  include/efi.h                                 |  23 +-
>  include/efi_api.h                             |  10 +
>  include/efi_loader.h                          | 102 ++++--
>  lib/efi_loader/efi_bootbin.c                  |   3 +-
>  lib/efi_loader/efi_bootmgr.c                  |  10 +-
>  lib/efi_loader/efi_boottime.c                 |  53 ++-
>  lib/efi_loader/efi_device_path.c              |  18 +-
>  lib/efi_loader/efi_dt_fixup.c                 |   4 -
>  lib/efi_loader/efi_helper.c                   |   4 +-
>  lib/efi_loader/efi_image_loader.c             |   3 +-
>  lib/efi_loader/efi_memory.c                   | 301 +++++++-----------
>  lib/efi_loader/efi_runtime.c                  |   7 +-
>  lib/efi_loader/efi_var_mem.c                  |   6 +-
>  .../efi_selftest_startimage_exit.c            |   6 +-
>  lib/lmb.c                                     |  10 +-
>  18 files changed, 313 insertions(+), 257 deletions(-)
>
> --
> 2.43.0
>
