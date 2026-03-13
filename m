Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFDA107BCE6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 20:55:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 283E484372;
	Fri, 13 Mar 2026 21:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M+DxuLZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61F318438A; Fri, 13 Mar 2026 21:55:11 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1053F84372
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 21:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d74aa6bcdbso1933496a34.2
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773435308; x=1774040108; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8tcyu9OwhvZI5FRdL1UUjjwdZAVeWXh1AW8NGjgOGI=;
 b=M+DxuLZMkzwEC4j+5LGh9BIP5UKw8S1KbjCkIRO8h/DawOlHFYpzTn6nJsaUaFBRtU
 QwrlmKfUN324p0tyxNmWGR/bzwGarWr064MPaxzLFOIPd/GUit5gQ2GkF4Ow9qAqfy+E
 MrVGBp0tLNoyTWA781yAgtaxPvV6bu9z97h2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773435308; x=1774040108;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y8tcyu9OwhvZI5FRdL1UUjjwdZAVeWXh1AW8NGjgOGI=;
 b=NSyTsXcmSLBE8QDf27R8lhC8Cc1nkrbMeigxxWCnTDm+wi8UVlTZO5rMs+E3t4uDo0
 R8/vbzdj1udz6UUUKgxrOYDAFa9qHm6hZJIL4X1hn+TLdMyQ2KVghd5QR+PFJy9gVP6b
 oTXku14C5bB2rpZ0Y3lfC7hT6htCjDIbix0OHM6iQA7WUEv1Z+93UsFLfv0Jv5z/86Ee
 ZwVaG9f+wk2SfU5yakabSCW+GtprylNfUGRsTV2IbCjy7NrnrilY6oySwDm1M0kldN/q
 RdcROs2ANJ3BuYKoKt6niXRMO5z9ZIj/LMsesJHnQVOPutLuv/Uz6C/YR7VndAw22TnX
 UQ7A==
X-Gm-Message-State: AOJu0YwpXY3G27Yee9IU/yGLowFDU8uhsSgMpo0qnx2ikeT7b2PWffKd
 EmfpUC4AwRhDGcUtZc3xyNdxv/ySPcJ0KAwpRVnhGZ9o8PzIRoLiVIOnm4Jp99mukPw=
X-Gm-Gg: ATEYQzyKnMJo/l0v4skwOgBth1NeURvGsTqB3FaqTSPd+WDQNwuj0V8qpD2JhwYkyJA
 oyobIehlAqvd7cC5qOU3BzIthW1RvW0o51Kf9oscDhLOALOQo3mcNcQmdFc+oVMlyNQ/Olcsp/a
 xugCmVdJz8rZi5rDJl5ZWXKX/gUBpoJFE/cb7CVMfktZUMSS4BqNm2wZ7HL8C3CDqklIYAWNIxQ
 uHQPi/cY4hjCitz8sqnTMjOSnpAbvCdP8Y/K1j1jZW8ia/7N7qvY1YmuTc8SCwU+oddeX/ZmRzz
 f/PmNaxfT83ckBGPrDGdSygJNCewby2GrjJRC/LCiP887O3txQvDjyhLS/wYpae3BvmMOVgs0Mz
 qt61287o4ly8ZLxVWgwDi+bc2Lk+pKUTkpnh0Oo9W79cWK5s82o2z3mu5RPsscwStxW1YbU8P96
 gZCf+DWnS0rsratY3exa8yymG1K8TNNprD6fIY0G2t4PZw1ibYxXRPpI6K4rzEhm2llcVr8RNtL
 pwsSju0M3KrkgY/U17dWa5BKVi1FTaKLbAxlEKyZqVWe6NEU77Zt8c7/w==
X-Received: by 2002:a05:6830:44ac:b0:7d7:5e62:4f0f with SMTP id
 46e09a7af769-7d7825a098bmr3421822a34.34.1773435307812; 
 Fri, 13 Mar 2026 13:55:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae3a18bsm6857942a34.18.2026.03.13.13.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 13:55:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@amd.com, Michal Simek <michal.simek@amd.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Ye Li <ye.li@nxp.com>
In-Reply-To: <da5461e758daf9c39c59b644e9abbe49e746229c.1772098034.git.michal.simek@amd.com>
References: <da5461e758daf9c39c59b644e9abbe49e746229c.1772098034.git.michal.simek@amd.com>
Subject: Re: [PATCH] spl: Remake SPL elf from bin
Message-Id: <177343530596.1131472.13803346763056876867.b4-ty@konsulko.com>
Date: Fri, 13 Mar 2026 14:55:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 26 Feb 2026 10:27:16 +0100, Michal Simek wrote:

> On Xilinx MB-V there is a need to use ELF file for SPL which is placed
> in BRAM (Block RAM) because tools for placing code to bitstream requires to
> use ELF. That's why introduce SPL_REMAKE_ELF similar to REMAKE_ELF option
> as was originally done by commit f4dc714aaa2d ("arm64: Turn u-boot.bin back
> into an ELF file after relocate-rela").
> 
> There is already generic and simple linker script (arch/u-boot-elf.lds)
> which can be also used without any modification.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] spl: Remake SPL elf from bin
      commit: 60ef345b1a10ec859f29ebc706724f907e8771cb
-- 
Tom


