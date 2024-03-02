Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA38C54798
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 23:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E75B87E40;
	Sun,  3 Mar 2024 00:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JDwR1DdH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84F9787E91; Sun,  3 Mar 2024 00:47:56 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79CDD87D97
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 00:47:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-690508d70e3so12226266d6.1
 for <u-boot@lists.denx.de>; Sat, 02 Mar 2024 15:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709423273; x=1710028073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZSnTZy/ieZyj6ywa5VrVg6ypqmpfmdG0ZN5ieobbdw=;
 b=JDwR1DdHeuyaIGSwtouDviyJnGcApA1t/e1Ievr/Syww+/weTSN+lsk5NW+Z3pkv2s
 KQ93X0yXJgwdyAK18u9mEuMLAlhOhi7HwrWEEusVMRAiMz/SIcbC+WVA8Szz6a+VFYHj
 VZabRRVETb2W54pSNO1Cdv9YyaT+U96a7Asao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709423273; x=1710028073;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZSnTZy/ieZyj6ywa5VrVg6ypqmpfmdG0ZN5ieobbdw=;
 b=V8JZ3PvlHwFLhAq+rS+V4eXOkt5Qd+mySqRNqAKLNdQ/5Ui6Qo0i4OTDU+VFTHPjge
 0ItZEPu8HzfyawIGE0lXJP3rkGkgT98iL1+geLj1T38nJxWlqjB+O9Iu4ZSRdDmIVP2a
 q3C12B2+TFqOGqujJ6MXY4kpBrhk674UX31XrJSWSkImDPPbzw+12JsF7wayKgGiS/ax
 BwiFomLVFxRpmS5RH2z5XHxREXcp69XeM0aGSmNOfIb8eT8klCsJSB8IEN40Ig3A7vBe
 YeUzLKKdq8cK2gVDIsiV9U9Ap3gOfJ8JwoV2YPNC1u+zPiwtZeO0CgbvHDqDH0zcDCWh
 Q4eA==
X-Gm-Message-State: AOJu0YzkN/Ofh1FnfWO9qm2dshNg9ctYGrdVdU2BKaWtPsjWysd1cFxQ
 +JSlb97+Nc7uwaDD1tPQCrHixFPTNXYQQZY0PYjP5FQMB5mbH/Ptz6lre+/es88=
X-Google-Smtp-Source: AGHT+IE2hMqlTe1sRHgFTsXAxo/M+IAGb7Zs1DEjhSfs/QI/KUcGTydiPLgHc/gQvmZPKvlRliWMRg==
X-Received: by 2002:ad4:4f14:0:b0:690:57bc:643b with SMTP id
 fb20-20020ad44f14000000b0069057bc643bmr4864937qvb.13.1709423273130; 
 Sat, 02 Mar 2024 15:47:53 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 kr23-20020a0562142b9700b0068f52a6f4besm3423017qvb.103.2024.03.02.15.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 15:47:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 00/19] ARM: renesas: Rename R-Mobile to Renesas
Message-Id: <170942327163.1817453.10347583559664217287.b4-ty@konsulko.com>
Date: Sat, 02 Mar 2024 18:47:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 27 Feb 2024 17:05:40 +0100, Marek Vasut wrote:

> Rename R-Mobile to Renesas all over the place because the chips are
> made by Renesas, while only a subset of them is from the R-Mobile line.
> 
> Marek Vasut (19):
>   ARM: renesas: Drop remnants of R8A7740 support
>   ARM: renesas: Drop unused sh_sdhi.h
>   ARM: renesas: Drop unused mmc.h
>   ARM: renesas: Drop unused pfc-r8a7790.h
>   ARM: renesas: Rename rmobile_get_cpu_type() to renesas_get_cpu_type()
>   ARM: renesas: Rename rmobile_get_cpu_rev_*() to
>     renesas_get_cpu_rev_*()
>   ARM: renesas: Rename RMOBILE_CPU_TYPE_* to RENESAS_CPU_TYPE_*
>   ARM: renesas: Rename rmobile_cpuinfo_idx() to renesas_cpuinfo_idx()
>   ARM: renesas: Rename rmobile_cpuinfo[] to renesas_cpuinfo[]
>   ARM: renesas: Simplify weak symbols
>   ARM: renesas: Rename rmobile_get_prr() to renesas_get_prr()
>   ARM: renesas: Rename ARCH_RMOBILE_BOARD_STRING to
>     ARCH_RENESAS_BOARD_STRING
>   ARM: renesas: Rename CONFIG_ARCH_RMOBILE_EXTRAM_BOOT to
>     CONFIG_RENESAS_EXTRAM_BOOT
>   ARM: renesas: Rename rmobile.h to renesas.h
>   ARM: renesas: Rename ARCH_RMOBILE to ARCH_RENESAS
>   ARM: renesas: Rename arch-/mach-rmobile to arch-/mach-renesas
>   ARM: renesas: Post rename fix ups
>   mmc: renesas-sdhi: Rename rmobile_is_gen3_mmc0() to
>     rcar_is_gen3_mmc0()
>   git-mailrc: Add renesas entry and update rmobile entry
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


