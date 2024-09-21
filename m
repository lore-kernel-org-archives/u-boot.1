Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1E2CF9C5B
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 14:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3589488C4D;
	Sat, 21 Sep 2024 16:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726927527;
	bh=SQcFE9rQsBHMXw/bj/ewm8RFavTMBAFBIm0k6hYVgAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O9sKiuFz6HAHkGnc78cODJPc6kee4pdiSzH+N+4W082uyEkdVX8ARu9mWgYOSYINo
	 s2SA+B5z68AMJHmyDtFP8QEMHA9kPnVfQu2e4BAHx4ltBxDW7AD7877PuQI8lXzai/
	 fvbtP8NNSo52BTScSM+Vd4G4RFyiLR094qBYtc4oh4xaQlZUS/e66h+EHSQMKWt287
	 XY3/eeT/8KgpUHETusUt0V+e6u6JLRbzH9vE9Di7Bg06yEHBuxZOyMEu459lngb2O7
	 XGwaDv0h93KjaTbILSnWNS50RAEx+L2GZYwo6vMc81nHIOhW/mVAFtCSdyGjsrqsZ7
	 adm8Q+uwXNz5g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 09D1D889DA;
 Sat, 21 Sep 2024 16:05:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726927524;
 bh=SQcFE9rQsBHMXw/bj/ewm8RFavTMBAFBIm0k6hYVgAs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=xf1ZLfkd3BiYSUayRn9wik4K4wZQc/7FR8pPq1JtxU8nKTCjsGsOXHGz2DsAjuOLy
 nA+Kkp+wAxNWQdnlYLLyrOAhjpBzf99CucD2S6JBPMfTSzTaBuyMfy5ibcA5UM3NnH
 wMht+/0IjumBCm/g4Nv5hAGGTWwspA+OU4fk2kVfS7kCFsMfHz0XfWz23sf6NTKR2T
 AykuJdzGp8tgB78sNKUda6PGUIZko7Zk6LJuAPf2Dp35kHRUO2/33jO1iXuF74zkqL
 xlnKjXojZOq7Z4eWFX285ibGeCvrWXwIDdptw+SQWfBufZcJUI2zW3n87v98B0JkvK
 eappCoAjJynBw==
Message-ID: <ff0e3d55-52eb-4dce-bcf4-04a6a5930d1e@denx.de>
Date: Sat, 21 Sep 2024 15:58:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/20] arm: socfpga: smc: Add memory coherency support
 to mailbox command
To: tien.fong.chee@intel.com, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>, Mahesh Rao <mahesh.rao@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-16-tien.fong.chee@intel.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240920070242.20884-16-tien.fong.chee@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/20/24 9:02 AM, tien.fong.chee@intel.com wrote:
> From: Tien Fong Chee <tien.fong.chee@intel.com>
> 
> As cache is enabled in U-Boot and disabled in ATF(BL31). We need to
> perform cache flush of buffers that are shared between U-Boot and
> ATF using secure monitor calls.
> 
> Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
> ---
>   arch/arm/mach-socfpga/smc_api.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-socfpga/smc_api.c b/arch/arm/mach-socfpga/smc_api.c
> index ebaa0b8fa17..dac888c399f 100644
> --- a/arch/arm/mach-socfpga/smc_api.c
> +++ b/arch/arm/mach-socfpga/smc_api.c
> @@ -1,9 +1,10 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
> - * Copyright (C) 2020 Intel Corporation <www.intel.com>
> + * Copyright (C) 2020-2024 Intel Corporation <www.intel.com>
>    *
>    */
>   
> +#include <cpu_func.h>
>   #include <asm/ptrace.h>
>   #include <asm/system.h>
>   #include <linux/errno.h>
> @@ -40,10 +41,16 @@ int smc_send_mailbox(u32 cmd, u32 len, u32 *arg, u8 urgent, u32 *resp_buf_len,
>   	args[2] = len;
>   	args[3] = urgent;
>   	args[4] = (u64)resp_buf;
> -	if (resp_buf_len)
> +
> +	if (arg && len > 0)
> +		flush_dcache_range((u64)arg, (u64)arg + len);
If really needed, the cast should be some uintptr_t
