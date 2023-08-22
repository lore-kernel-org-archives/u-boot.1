Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317CDEE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 07:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53A586416;
	Tue, 22 Aug 2023 09:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tUXEMbtw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82FC686415; Tue, 22 Aug 2023 09:52:07 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CFCF86419
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bddac1b7bfso28317045ad.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 00:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692690723; x=1693295523;
 h=content-transfer-encoding:in-reply-to:references:subject:to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tG76fqhDXyAtyKKh6T2uSqDcFVzBM/iEV5c4rvtUJbM=;
 b=tUXEMbtwAqe02+32wUUCUtoHf6TNSMWT2IOz3u07Y2FH9C6MyZAjESPHQFCu52GVRB
 SajzAA4vA1RMy0L+YIqGVSSAvzoOChHo6cVY919h4JnpkdkQbiAhYSJCZPAr8NkV8ZJE
 6UMqWBqs341Mlqof/U48ySj58a61C4VeiV0h2Tsguyisyb6gbs6mBXSRYLMT6Evuvv6J
 J/rqE59TGsee9HWnpYohzcwKKfLGTXf9u3Eir+nvspDcs9djUN+BHAfVKE+BKuwp4xrB
 HRBGZgHEgMnP1LO6S14a4LQlJ4PGdCUdX/zvZU7F1HrvQehlg+BiHLPYwHy90elrPgD9
 xNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692690723; x=1693295523;
 h=content-transfer-encoding:in-reply-to:references:subject:to:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tG76fqhDXyAtyKKh6T2uSqDcFVzBM/iEV5c4rvtUJbM=;
 b=WjNI88qQTJIu8gp0OTfCC8PxmZRGBGFBuSWi4Uadxr9b1XllOntyFnllzTiS6hUBxm
 AHGgk4+HrIcclZJ3GKfmv0slCv/+Af2a6mfEgxAL8iLmAWs6PC6IfrTvrzML1XpVREbq
 qMs1d5QUmS77ADfb3OlS6BMAODW1j8IN2DkL3z822kR/PNgq/wl4SgVT66b1lZbewcnp
 DZOP3PxVSLWs+tBLXB0JExCKpjZFpcZoz6LmAHUlzC1EwTsPL4jo4kdaZIkoJtXuzMEX
 MO6nz7WGc15YX0hOtdBerWoi+HGNGVQSr2CA7I+lKLLSR/WCYSO8vJA6FhwgRODyJHw/
 fb3g==
X-Gm-Message-State: AOJu0YyPmD89PGgidiCO24+rqjEdRXsBlXfSocVoZ6FpEodBuH/l0trk
 1kDAiqjjM75CHfo+8jlYuueOmj2P6SNqyVlNDXg=
X-Google-Smtp-Source: AGHT+IE0PO7msy8F5CQgmBP1l2mWd7Sx3D3XE+1vSwS77kEce/kuSsTkl3gLMBjn+Qe1gV86EHUImg==
X-Received: by 2002:a17:902:f54a:b0:1bc:1e17:6d70 with SMTP id
 h10-20020a170902f54a00b001bc1e176d70mr13601391plf.24.1692690723028; 
 Tue, 22 Aug 2023 00:52:03 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:3924:9d49:2d2a:63e6:8974?
 ([2401:4900:1f3b:3924:9d49:2d2a:63e6:8974])
 by smtp.gmail.com with ESMTPSA id
 q6-20020a170902a3c600b001b89045ff03sm8485054plb.233.2023.08.22.00.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 00:52:02 -0700 (PDT)
Message-ID: <f73130b1-0926-d413-bf58-49adcaca112e@linaro.org>
Date: Tue, 22 Aug 2023 13:21:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From: bhupesh.sharma@linaro.org
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, sjg@chromium.org,
 bhupesh.linux@gmail.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/1] armv8: Fix compilation error with SYS_DCACHE_OFF
References: <20230811054228.3721455-1-bhupesh.sharma@linaro.org>
 <20230811140136.GD3630934@bill-the-cat>
In-Reply-To: <20230811140136.GD3630934@bill-the-cat>
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


On 8/11/23 7:31 PM, Tom Rini <trini@konsulko.com> wrote:
> On Fri, Aug 11, 2023 at 11:12:28AM +0530, Bhupesh Sharma wrote:
> 
> > If CONFIG_SYS_ICACHE_OFF and CONFIG_SYS_DCACHE_OFF are set, we see the
> > following errors while compiling u-boot:
> >
> >    arch/arm/cpu/armv8/cpu.c:60: undefined reference to `icache_disable'
> >    aarch64-linux-gnu-ld.bfd: arch/arm/cpu/armv8/cpu.c:68: undefined reference to `dcache_disable'
> >    aarch64-linux-gnu-ld.bfd: arch/arm/cpu/armv8/cpu.c:69: undefined reference to `invalidate_dcache_all'
> >    aarch64-linux-gnu-ld.bfd: arch/arm/cpu/armv8/exception_level.o: in function `entry_non_secure':
> >    arch/arm/cpu/armv8/exception_level.c:29: undefined reference to `dcache_enable'
> >    aarch64-linux-gnu-ld.bfd: arch/arm/cpu/armv8/exception_level.o: in function `switch_to_non_secure_mode':
> >    arch/arm/cpu/armv8/exception_level.c:52: undefined reference to `dcache_disable'
> >    aarch64-linux-gnu-ld.bfd: arch/arm/lib/relocate_64.o: in function `relocate_done':
> >    arch/arm/lib/relocate_64.S:92: undefined reference to `__asm_flush_dcache_range'
> >    aarch64-linux-gnu-ld.bfd: arch/arm/lib/relocate_64.S:93: undefined reference to `__asm_flush_l3_dcache'
> >    aarch64-linux-gnu-ld.bfd: arch/arm/lib/bootm.o: in function `do_nonsec_virt_switch':
> >    arch/arm/lib/bootm.c:191: undefined reference to `dcache_disable'
> >    aarch64-linux-gnu-ld.bfd: boot/bootm_os.o: in function `do_bootm_qnxelf':
> >    boot/bootm_os.c:392: undefined reference to `dcache_status'
> >    aarch64-linux-gnu-ld.bfd: boot/bootm_os.c:394: undefined reference to `dcache_disable'
> >    aarch64-linux-gnu-ld.bfd: boot/bootm_os.c:399: undefined reference to `dcache_enable'
> >    aarch64-linux-gnu-ld.bfd: cmd/elf.o: in function `do_bootvx':
> >    cmd/elf.c:280: undefined reference to `dcache_disable'
> >
> > While the following error message is expected when SYS_DCACHE_OFF is
> > set:
> >    arch/arm/cpu/armv8/cache_v8.c:697:2: error:
> >        #error Please describe your MMU layout in CONFIG_SYS_MEM_MAP and enable dcache.
> >
> > the rest of the compilation errors should be fixed.
> >
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >   arch/arm/cpu/armv8/Makefile | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> We should disable SYS_DCACHE_OFF (and SYS_ICACHE_OFF?) for ARMv8, and
> then rework the Makefiles too.


Ok, I have sent a v2 accordingly. Please help review the same.

Thanks,
Bhupesh
