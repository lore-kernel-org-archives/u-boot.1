Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46185CD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 23:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 813E58464D;
	Fri, 15 May 2026 01:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H5hNzlq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18C6D84687; Fri, 15 May 2026 01:15:53 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA5808407D
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 01:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-40f1a1f77a6so6413955fac.2
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 16:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778800549; x=1779405349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GbIsYnc53C7qFa+yRbFFyx39toDLUOMeILFTuFaFFS0=;
 b=H5hNzlq/jOEyY/ACYEW5dk6FSIVdOgmvJGUszvVSy8OSbVDkdVqwb0d5o/YRSbnUhV
 G7xZLHweevzsnBFyBJ/e4R3lMyjSZGuZ2eOgWc2Y2GCOzusdjJfAhVEneXEBYzuNf19L
 oTiiX/x/L1GwSD9el17q1T0By3SLZFFzfhxYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778800549; x=1779405349;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GbIsYnc53C7qFa+yRbFFyx39toDLUOMeILFTuFaFFS0=;
 b=hyO2vBRf4CZu+rxCgAKWMKPHpK6zLUEBSxcgGGSuY4MB4P5dwE1z+8idtpiXyj9g5o
 3lRd6NvtKkdTa4gZVn77apme3DW99/OKJX2VtQnqUtXe+4PfA4OPKcPyNvtSI7Z9j/n6
 6BM6sunYmNMaaO+/BqT60g92sGrincSAm/yHefp0nLnaIJ8j1oWQupdCQxrGXS2Asl1E
 4F7RzAe/PeWM7jLwSln1I/NUly7luVIP37vnnEi2x3eF7aGEYbm2F2a5Gt8JpPKVb7TO
 WmKJPFpxeVKOyshJvplRFvgoXDyADoIOpnH34d+bB0vqwYDSYfy9mzqbd5uBd6itEE24
 Li9A==
X-Gm-Message-State: AOJu0YxgvH8o7PcWfngZuSsFtF1P59fg7qCewV8wYAzbLGJBmh6Q4ClE
 LDWAEhlbDWg7i9aLzeRZMcAgJh5CFW1GwIHG1sOqJuOmZOCuBs3EOg2YxpGdBomdVOg=
X-Gm-Gg: Acq92OH2XTKTmpmJ5UxursXYMXRX9qtm0qtlJXapGKloEkGrH6oHHHUJzYGyuGKZi1x
 t9mcZarNXUZHeGb4PDgRrPTvTPK6CCyyVJ1HlfSljZmLjN0Ok8UgA7iiS1J5A7BC3qZxjRQOO4I
 n2PK7B0HmjQFUeKTZoTf/Kfi4LYhiVIgXHkOnicu2y8M+yh5OKi71bR3nnzUy/GirDs4jU15f67
 i4ZZuJxN2Ypo0Pg6PIdf3MfN2zmK/mVqVFEiEUmS6OKIxZUMRyLuonBC2tpUtU5+Sy0JCFhnSMp
 Vr/oP0v+5riy4tlx95GG/o4x7d3BknGT5FMRSz5crLP+qY96IzYhW/Ib8Yyqfe/3Sh5fL+o9C9I
 gfgd+ZxkE3AjjSeDIr4FcGWIPKAFL54uINROG6kxuiuF+KX9dVVmNXKP5HgdF3zOuTfr82n9b27
 dwxeBx7jHmhz03+Fe4lPaaptblvUh8p6n1+wFlNdgYPe75B5liHsd4BZnCGMENiY3cwdltQiWVP
 NzUDVB8V0FTHoRYddXVC5Bt0VXU8+UUpcj/kUsFwwW/R3tMLA==
X-Received: by 2002:a05:6870:8e10:b0:439:baeb:7ee with SMTP id
 586e51a60fabf-43a2dd990demr1212376fac.15.1778800549560; 
 Thu, 14 May 2026 16:15:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fc144b86sm3020885fac.1.2026.05.14.16.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 16:15:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Alice Guo <alice.guo@nxp.com>, Andrew Davis <afd@ti.com>, 
 Anshul Dalal <anshuld@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Cyril Jean <cyril.jean@microchip.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Enrico Leto <enrico.leto@siemens.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Hiago De Franco <hiago.franco@toradex.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Peng Fan <peng.fan@nxp.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 =?utf-8?q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>
In-Reply-To: <20260503204936.3151124-1-sjg@chromium.org>
References: <20260503204936.3151124-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH 0/6] test: Quote variables in 'test -n'
 expressions across boards
Message-Id: <177880054740.4123088.9492425771246164880.b4-ty@konsulko.com>
Date: Thu, 14 May 2026 17:15:47 -0600
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

On Sun, 03 May 2026 14:49:18 -0600, Simon Glass wrote:

> Several boards use 'test -n ${var}' (unquoted) in env scripts to
> detect an empty variable and trigger a fallback or skip a hook. That
> works only because of a U-Boot 'test' quirk where calls with argc <
> 3 returned false; an empty variable made the expression 'test -n'
> (one operand) and hit that path.
> 
> 8b0619579b22 ("cmd: test: fix handling of single-argument form of
> test") aligned 'test' with POSIX so those expressions flipped to
> true.  f7e7c55e53e8 ("cmd: test: add bug-compatibility special case
> for 'test -n'") restored the old behaviour for the exact 'test -n'
> (one arg) case, so the boards are not broken at runtime today, but
> the reliance on a bug-compat path isn't great.
> 
> [...]

Applied to u-boot/next, thanks!

[2/6] ti: Quote board_init in ti_common.env
      commit: 825f8ee2fcf64ef5875a0bc0a3e2d8650acdc298
[3/6] siemens: Quote A/B flags in env tests
      commit: 6b109a1304a03b35ad489e551964737ad80f6a82
[4/6] beaglev_fire: Quote no_of_overlays in design test
      commit: 2120834c25d525b754a8473565d4e0f9c158d806
[5/6] mccmon6: Quote recovery_status in bootcmd test
      commit: 9458e39c6595e2e00a1d0a645676eaf935e783c7
[6/6] aristainetos2: Quote rescue_reason in rescueboot test
      commit: 93d7dc20e80e33ace9b871de44877548642f86cb
-- 
Tom


