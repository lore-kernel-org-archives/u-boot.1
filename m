Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A15D15DBC
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 18:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E11E83B71;
	Wed,  3 Dec 2025 19:18:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WiKvtgne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18AAB83B8F; Wed,  3 Dec 2025 19:18:30 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0E7A83A71
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 19:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c52fa75cd3so35842a34.3
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 10:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764785906; x=1765390706; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgBncv8/DcZFy+bouh5b3+MBLluKMziJ6JS8HeGpw/c=;
 b=WiKvtgneSZ440oeHMUDWwKuf3WITBWnFBjCgO8Cq6U8s49LxabSHgC//p036k3EfE2
 LR2u0KNiR/iX2ZVGf6s8eb3PvUF78Q2gugCgofVSRLWq2LuXePAytiO4OjN4wPLNToXK
 RApYS2EBxCZzAeKDUI2CDEH0H5VzZNr52355o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764785906; x=1765390706;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jgBncv8/DcZFy+bouh5b3+MBLluKMziJ6JS8HeGpw/c=;
 b=PMxMsg9DjO3v6mjul+pWWybxG+whCyNY8DMoe1qrZoPUZG1ZDZ2LmD6CqgKpiF/XhU
 Bt681P90p3D1L/CucsYqlhKsatgkN7Tekg16Go73dyPpuNgDFqueaVk9BwE/5NqxRLdi
 WMrIClnVnuWj8FaDTRrS/fWGdYmw7NH8zUbl2iibENtRtGaQXNOlEjeG4NIh8LE5tkU/
 VsWDYElE8Z2Sd1liQ9uXXwQ9W+iEZnyUJ3WwPh1LBmxTnuGLw7jJoihbYfNV0A2pGfng
 FeCiqKrcequmWs4Qey6zQB/0AlV5OXR3u2MZdnGA0sIhQFi9Pbtu/BIk0+sRHC90zOBn
 n4bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd7cLEEZvZCDvJYOach9t02gt6lj43C1rsnF8Ay/fIepZGaDDu0jEuwP3HC9jBuu+hu44G5Ac=@lists.denx.de
X-Gm-Message-State: AOJu0YydJvvL1R6ILC2KeXBXFywX9ZRf1RJkMXZkHWYRtIBiW6mTZGtm
 dWXDODCApmPBFXIXP3sASKYRu1jNupZ4Crjf4uDjGdFzlJCcx0gRURTA/4NaRlL/91c=
X-Gm-Gg: ASbGnctURKHIA1sHpXThdTLLTb2SHQJDj7yIqGmq/7JitSg4g31Q0RxPwAKMohsbKSL
 9dNZcKC/yJSZdnjtwSXI23Mvq5X1FVWT7FjFP7kzqho/mtUX4nZ2IJPe87Qvt8LLzKOcsP3YdAF
 x6Dk0y4fZBMYGl5MWtilT/3nLz8Pb7MyJh2OYQh+yap5Kd33qwAJTCAqKV2K7cC324Apt63fB6y
 peUF2K3pPvFs26252fMoW44hCNd/RGBUuJnQ3Hb9ioziBcoVXu+Ecujf3CKELwSLkvKUmAqRX9v
 ZJW0b5QGyFz+KuOSaZ9WlfWU4qvCjuJBLMIeXoR/2WKFvzkVHnz+5js8yDl31JSlJWI6OBpVMmt
 /ZsA9KgU4EafsaNdONAemEygf+0qUjritS6upyGz7ll+j0C3VZnttsUxwV7/LL0BJhNz9o7kyxt
 S92lSikIvmqMLpVeshgxRsGVsrQRyRl6eerC6V7oAdnyrBP+NZ
X-Google-Smtp-Source: AGHT+IFb753UoDZIrN80JyIRvNUjUt6kJxWW/knYRALKegIjVxIHTRWPsohz/Khj7timJywSrZ1pOA==
X-Received: by 2002:a05:6830:3101:b0:7c7:59a1:48d3 with SMTP id
 46e09a7af769-7c94da8d4f4mr1606494a34.1.1764785906666; 
 Wed, 03 Dec 2025 10:18:26 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fe0be23sm9081915a34.21.2025.12.03.10.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 10:18:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ziping Chen <techping.chan@gmail.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, Quentin Schulz <foss+uboot@0leil.net>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Klaus Goger <klaus.goger@cherry.de>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Durai Manickam KR <durai.manickamkr@microchip.com>, 
 Stefan Roese <sr@denx.de>, Zixun LI <admin@hifiphile.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Alexander Dahl <ada@thorsis.com>
In-Reply-To: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
References: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
Subject: Re: [PATCH 00/11] led: remove u-boot,boot-led and u-boot,error-led
 + add cmd doc
Message-Id: <176478590510.3459899.7220764755940403918.b4-ty@konsulko.com>
Date: Wed, 03 Dec 2025 12:18:25 -0600
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

On Wed, 12 Nov 2025 18:48:05 +0100, Quentin Schulz wrote:

> u-boot,boot-led and u-boot,error-led aren't actually handled by some
> generic code but rather by board or architecture specific code. They
> also aren't properties that are part of the official dt-binding so they
> cannot be upstreamed. For u-boot,boot-led, there's actually a proper
> replacement which is /options/u-boot/boot-led[1] (+ CONFIG_LED_BOOT=y).
> 
> For Rockchip boards, either nothing (for RK3066, PX30 and RK3399) was
> using that property or (for RK3188) the code handling it was guarded by
> symbols that were not enabled in the defconfig. For those, the property
> and guarded code are removed.
> 
> [...]

Applied to u-boot/next, thanks!

[01/11] cmd: led: fix help text for blink subcommand
        commit: 29a7fe55c557e462457f4fb3dcb25681952b0803
[02/11] doc: move legacy API documented in README.LED to doc/api/led.rst
        commit: e8bc14192386b62fbd80c37baf5b0720cd4d61af
[03/11] doc: cmd: document the led shell command
        commit: b8c35fa9c58aeb16bd56433b551203ec70c87517
[04/11] doc: dt-bindings: remove duplicates with dts/upstream
        commit: b0f39c085dc8f99becd7b2a83d43958c5e6fa936
[05/11] arm: dts: rockchip: rk3188-radxarock: remove unused u-boot,boot-led
        commit: f8c3a6ddc62b0b8139dbe66dd8a1c610c41d76a4
[06/11] rockchip: rk3188: remove setup_led from xPL
        commit: 7759839fb299c9dea4beb1232dadb3141c7fa8bc
[07/11] arm: dts: rockchip: rk3399-puma: remove u-boot,boot-led
        commit: cf8e0d58cedc38375705ad2cf5c52b0f9bd760f2
[08/11] arm: dts: rockchip: px30-ringneck: remove u-boot,boot-led
        commit: 0636153fb199c110d0888c63072b248939f85594
[09/11] arm: dts: rockchip: rk3066a-mk808: remove unused u-boot,boot-led
        commit: d1ad89ad56ad27a5cb2dd5b4f82a74b7ccf966bd
[10/11] sam9x60-curiosity: migrate Boot LED setup to use /options/u-boot/boot-led
        commit: 98be3062088a81cf7124cf16f05c7ae735587bf7
[11/11] doc: remove u-boot,boot-led and u-boot,error-led from "binding"
        commit: eb02d87c7579f83f6fe153c80d420e5f53bde4c1
-- 
Tom


