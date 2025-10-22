Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E885CCD1BF
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 20:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D79181E13;
	Wed, 22 Oct 2025 22:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZlyNbrkt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0124832BC; Wed, 22 Oct 2025 22:14:34 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79EAD80422
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 22:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-35c80c1dc3fso20513fac.3
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761164071; x=1761768871; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIWMcLABNBjrEdRD6C3N9FNd8VNz5nLUGEaATX7WFhE=;
 b=ZlyNbrktN5H8cu+JNum1/wtBDT3gT97cJXR37ActiArF+r84gFtQRJ2gaOJrCVsPXt
 aJxTfibXf8xvGDXZjdOGxzYX+awIxLePpDzMiKopBpBsb3m/M4Nu4zrFtysgDdjBkFTu
 N/5Ckcai0y6d8JZLZdj4u2lA+X4Zi9oQarWxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761164071; x=1761768871;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bIWMcLABNBjrEdRD6C3N9FNd8VNz5nLUGEaATX7WFhE=;
 b=FQhhWFHul2tI3zK1/FIsRqfF2+bKPtaVRm6fbe/O9rvVdVxqeqAoHoMTVPrvtJdL40
 L+pOuixBse8mhMCDtlEIBli9ulfoN0iWxgUGBcYZ0S+a5ED5NW9ZAEnHLZZkxDVlKo7C
 AfSjkKxO/hLJpPfu4T8e0yzvAXgjN5xRqOJk8mM7QLRt5ILU4f8jPMsU6zTwZFYF+4ku
 /M1GVe/BA6OE7FE9hP3hJkzXuc57R+Y8WIokCmRVmaDdfIqrYJGm0ZdEij4sXeLOXjuQ
 NheI54x9mchRcgZPYum3jevqMQm39RJIFWuLTiD30TaXkQwnVQckYOHMRe5IIiIvoqE3
 c1Nw==
X-Gm-Message-State: AOJu0YzqmpCrCiVcA6/Xs92WJIOj7q42ojr8rD85KxoHj4SVEmGoEhNi
 E5JzGzo0vMlKh7oVVa2IeLovVCWvuU/+3Y6aG8o/tcaP7sbW6ja7CDZ62kyOuXWQypw=
X-Gm-Gg: ASbGnct5Orf3xKdItT1PSdiKiZ8lvnKdi3Klz62CEG383rO6ZlawtpPWo9UZjxgRnwa
 L0a8IuIiFBWwlpMFiQU1Jw3YJt0H5LSdNqF/k1rMIo5N4Di4eJ4KV6jxPxr0Y+D/lpcLrn7f3RK
 jc+MPmjk3wtcFkhnUZYpXQhiHeYBrVSz2mFnrmheGg/MzA2Jaw4tTAiYKq3GHz4lnWHKcXjKFy0
 tVtPJaWQmfNWdvLM3EEtDj2fTR/duI+rJaA8AMv3AGQjvjAZEBNKNE0ndwW3WPJplmsMBrZJLmb
 va67kcxVWJyKbJWkLGrlFEDTwZopH9ZsOYsD5Ejh+TEv6o8Yr5VAIUMvVpWrSk2b3zpg5k19R/o
 oIeX31/du43Dv301DncATF/Aoe9vOEi9+rBbFgtwBkPNEcZz81FOXQmadad/OZlFfGrOcb+tN72
 VQQ87qnkAI02CCKVB6vBoxBEuZLDhcLhqRORDyimMNktoBdHQJs0bijKZf31s=
X-Google-Smtp-Source: AGHT+IFe/JgmjhXG+K3Hj2h1x8icc+T/QlPeurIENguwLMUHjjfs3SElBNWLpVt0dkDF8x0L45skNg==
X-Received: by 2002:a05:6870:d88c:b0:307:b1b1:aeb9 with SMTP id
 586e51a60fabf-3c98d11d690mr9971952fac.35.1761164071133; 
 Wed, 22 Oct 2025 13:14:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3cdc4e61d0csm58451fac.18.2025.10.22.13.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 13:14:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: d-gole@ti.com, b-padhi@ti.com, vigneshr@ti.com, nm@ti.com, 
 robertcnelson@gmail.com, w.egorov@phytec.de, francesco.dolcini@toradex.com, 
 ggiordano@phytec.com, m-chawdhry@ti.com, afd@ti.com, bb@ti.com, 
 u-kumar1@ti.com, devarsht@ti.com, ilias.apalodimas@linaro.org, 
 xypron.glpk@gmx.de
In-Reply-To: <20251017131540.3636067-1-anshuld@ti.com>
References: <20251017131540.3636067-1-anshuld@ti.com>
Subject: Re: [PATCH v11 00/11] Add support for dynamic MMU configuration
Message-Id: <176116406890.1665784.10807369863168978503.b4-ty@konsulko.com>
Date: Wed, 22 Oct 2025 14:14:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 17 Oct 2025 18:45:22 +0530, Anshul Dalal wrote:

> In U-Boot, TI only provides a single memory map for all k3 platforms, this
> does not scale for devices where atf and optee lie outside the range 0x80000000
> - 0x80080000 and 0x9e780000 - 0xa0000000 respectively.
> 
> There are also issues for devices with < 2GiB of memory (eg am62SiP with 512MiB
> of RAM) as the maximum size for the first DRAM bank is hardcoded to 2GiB in the
> current memory map. Furthermore the second DRAM bank is mapped even for devices
> that only have a single bank.
> 
> [...]

Applied to u-boot/master, thanks!

[01/11] mach-k3: use minimal memory map for all K3
        commit: 4673c8dcb48d6b14070a4819ee4a6277a0f2daa6
[02/11] mach-k3: use custom enable_cache
        commit: e55e57d240e0bdef604efca5b386978b1c70d513
[03/11] arm: armv8: mmu: export mmu_setup
        commit: 567a683e8ced54c3ffa53f62a4ed7e535268c6f2
[04/11] arm: armv8: invalidate dcache entries on dcache_enable
        commit: 9ebdbbc43e5fb5841d85ec7ebcb1dbf07f4c87b0
[05/11] arm: armv8: mmu: add mem_map_from_dram_banks
        commit: fe2647f2a0d4e4df5d47fdf068aeb2a1edd3d533
[06/11] mach-k3: map all banks using mem_map_from_dram_banks
        commit: f1c694b8fddece279cdd103ae4009bf25345d8e4
[07/11] arm: armv8: mmu: add mmu_unmap_reserved_mem
        commit: 856480eef0a25dde339cce6d1889efdc836c6be8
[08/11] spl: split spl_board_fixups to arch/board specific
        commit: 16ffcff0283d2f10821bad7cbcf89003a86c0063
[09/11] mach-k3: add reserved memory fixups for next boot stage
        commit: 859f68ed2ee7a0c1f88efaeb769202df01ef7a97
[10/11] mach-k3: add carveouts for TFA and optee
        commit: 4f5285f0e640c3e9b40420ba3b11358446646b11
[11/11] arm: mach-k3: reserve space for page table entries
        commit: 342fd918b1bf2f00f52216297d5fe22272e8c7ca
-- 
Tom


