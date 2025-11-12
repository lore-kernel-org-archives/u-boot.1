Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5624CD3431
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 17:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8AAD83CB5;
	Wed, 12 Nov 2025 18:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JtT90E1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A7AD83CB9; Wed, 12 Nov 2025 18:44:07 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B81A83C62
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 18:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c704bdd57aso548015a34.3
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 09:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762969444; x=1763574244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrIRKAUjL+svc6zjXOO5BKXJSqkG6itMV/b66objrNA=;
 b=JtT90E1T6Dw0lI5ToRRTQaUpbSH2fgCo5v+vLHgXE1Ye/AsGvgYrigK+LhHAxvCHvq
 iYkAgpdHoiqzrrmQdv+93bqxotIwXa3hOfg/JkefllJJxE///iQc7anEfoWveMEPuEgN
 Mhu5/3aGMN+XtHOWEpLUq6k0VGcl/ZexUOIhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762969444; x=1763574244;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DrIRKAUjL+svc6zjXOO5BKXJSqkG6itMV/b66objrNA=;
 b=X6Q8DROM/Sl0pVMhvWDCrgtYTsMmRpPa5TjKeRjxanBKeHj74SmfXkiwxDkPrLhrj2
 HTsJ61xdPa1FgyYmkcwaV7RihoT3ZuPh2R2N32Uid0rNO9qOulPDmNrR67YEzBynTIij
 baDpwm3Tklz2zgUQPJPU8Kq0RdtzPkCCaAKtS9gUZFihX4goST0+BlSknvFE04c60NPc
 FgDointiGI1OS4XsKJVUe39Gp6F0sFxAxKmi3nSrZMZ8bXeagYIPxzfLrL7U0OghwB+Q
 QNNTjVeWp60OniFpLtoGOvLiKjjaXRxmdYN2VBCsNzKarcP91rjzLYlPcK/OJy+gqUgb
 RDEQ==
X-Gm-Message-State: AOJu0YxpyA6W3yoe9ctA5x8TvOVmuyQhyPDudnTzdpMg+79Pw1Xi7ZY4
 KPys21037efNShctutBlIbPi0PqdYhrIKNleGCWKYXAiO4wg9zRQVGnMSJAB0WoabMS1oTybsIw
 ElaDGHVLVsQ==
X-Gm-Gg: ASbGncsW+Rlphnu01HHycsg4rwCrKHkBOH9E8evxk2ZSuN/C3BuvZg/TqCDn5x0vTo3
 yTkQIKswTv2QYUXshsLoUdZx3Nta3OuHksBt0Zw+lsKYWeRcf3Zzx85GkQgvltYEqcTHjyqz61e
 PJc9d2QZdVMY+8gmS7IFWeqXXL0M33XREr9kvPuRAz10B0oOxAKy9ZWSsX8oRpPuDr1QrEP0kaN
 LAxSTeO4WRfzyXhpebMFr/CBs2S34W6hirjJLwNyb4/4vh2O9u8+0iCbbtpyGFAv9GYKRoFIcat
 zI/MBEBjKP5vJNfHBxGxby274Go9VMsXBWWvbcmr/P5s8KoalpMwoajB3trM041iMJbRSPb+zxl
 b3UyPfPIX6+Xj7J5i41aRWQ0XRIhoYodU2QiC+QrRiU/tIWlK4IWbB2OUgi6i1YoyDfmUyRXQw4
 3dXK+E4sUaSVkr07HpxQNwMKwfJiFpJ0VRY95Mrw==
X-Google-Smtp-Source: AGHT+IEEaYOn/LUZlhek8CfHsGSgfYNEfmemPm2wuMPmEWHVMtNCquvsMWVFj2NXnE8OMiMELCrKaA==
X-Received: by 2002:a05:6830:917:b0:7c7:9b7:1bf with SMTP id
 46e09a7af769-7c72e39ead5mr2075305a34.24.1762969443970; 
 Wed, 12 Nov 2025 09:44:03 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f1132705sm8991050a34.28.2025.11.12.09.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 09:44:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Aparna Patra <a-patra@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Judith Mendez <jm@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Andrew Davis <afd@ti.com>, Aniket Limaye <a-limaye@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
In-Reply-To: <20251030-ti_speed_grade_fix-v1-0-703e4189640a@ti.com>
References: <20251030-ti_speed_grade_fix-v1-0-703e4189640a@ti.com>
Subject: Re: [PATCH 0/3] ti: add speed grades support for AM62a
Message-Id: <176296944226.1085282.16058927799444796107.b4-ty@konsulko.com>
Date: Wed, 12 Nov 2025 11:44:02 -0600
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

On Thu, 30 Oct 2025 18:33:19 +0530, Anshul Dalal wrote:

> TI offers SoCs in various speed grades, each speed grade specifies a
> certain maximum operating frequency of the clocks for each core.
> 
> In K3's boot flow, the R5 SPL starts the A53 or A72 core and configures
> the correct clocks and power using the K3 ARM64 rproc driver
> (compatible: ti,am654-rproc). However, the driver expects the dt node
> for the ARM64 core to be set with a correct "assigned-clock-rates"
> value.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] mach-k3: am62px: remove fdt_fixup_cpu_freq_nodes_am62p
      commit: 2a909c3da7197f9640a016e69a7b7984f1d6fa45
[2/3] mach-k3: refactor A53 speed grade clock-rate fixup
      commit: 65a6b83a9b7faff58e2ca60ddebbf5dc364c6ec9
[3/3] mach-k3: am62a: add support for speed grades
      commit: d4c0b8fed70d6cbce9f981611cd876dcdb1eae48
-- 
Tom


