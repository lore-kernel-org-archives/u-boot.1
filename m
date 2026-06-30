Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DB2C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 19:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8A0E84ACD;
	Tue, 30 Jun 2026 21:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iPujlWBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07D2084B03; Tue, 30 Jun 2026 21:30:28 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8FD884A49
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 21:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6a168dc590cso1631085eaf.0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 12:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782847824; x=1783452624; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RGJf4VybNqYYHDpReEoOjxS050hZSnlFlv2sgKnASpQ=;
 b=iPujlWBXN0uHM3yJkuGQjoF3iDy2Ke0OlrMZDdmB1BjVLJ0VhnbZwgfz2SLXogr8iu
 FVQ1dZBEz9FLqTtH9ov8RfMQCnp658k9SmwDOlRx/8OiGwEjZvqi9+a1noaPKpuASe5g
 carzruv6ljnrg3oQydMA2il1/5O82XUSkf57g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782847824; x=1783452624;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RGJf4VybNqYYHDpReEoOjxS050hZSnlFlv2sgKnASpQ=;
 b=jqiBogm/d/QuDamLkbflzAyrOmvlwGio/9REDd0hxy3IXwa54NQeSqH/o/pEbExGNi
 dwWQ/0f1QXlvOi3EMrGjZx9gt5e8lN1e2CUYUwEa9ypPVcTa1Cg2XrimZH46VsPa4bcw
 OZNdjUj6xgSx3W9rQVAXOv0kRE7xu0q6NZKUwHAB19oW1aYXkCnj4gfQU36Q4M8qM4SM
 aDNLwOg6KIRu5bohzyWGnc9oo67WuTiGGr+xJPTKm+JtWzY7ow1newX8Dyn6GYB10+wu
 6s1DNyflP8/bPA7eSdIcx3xg54TkAhq1mcbH+xAWMEGoHG1T6hYUB4L4dUPhWF68I6pJ
 PT1w==
X-Gm-Message-State: AOJu0YxQ45+Gnctml+dDvZ5reMZxIXP8iR1nifHh8NFunuetAApcNDkA
 GUS0kvmCVNbijjjpafmQx51nqc93j1a/UG/xJp3wEg0JYp6ZnpuJ0OduVFwnulkpVdU=
X-Gm-Gg: AfdE7ckMrRbkn6TgguQzLF+klu+aulqqS7D75n7JtnNojoWs/r7P/l1Ppe97yUH6dM1
 rpJHef/m54OaZqMtvm4crBafqSuaiFt8T/2n70Qs3Ezy0QgyohWnxds+wnKZOWF9YL950hR89lq
 EuwveSqDXZUtx432+4lnnt55e+SseUKAxhwvMWaki3RiyoA+GdWx1yhKS24DLCQwMucLSyGr8O1
 oXMD5aclhVp2IVXhGCBQui570IOq8KbpBoKGbeRRmK1u8KWiEu37vSwRSfaJbNxaqKvieBAkS8M
 HOxnwMpka2uddpbEj7R3Edmj1msgoScuKx2MZDo5y/p0HVCujMHodA+6MSYv+90VyvSGZgY8j+b
 oq/iR8VBjxX/Cqm5I4OgbPIFs8/DJngY2yBze2o11IVfF8nKlihiBSGSVZ0Ia/8/FL5S/lHvUTr
 11nvlsCTgbNCrmJqfPZ+Hkl/8wNmUCMNwePL7qeyLilbiAsRpE/RsC160MNBzSnwbQzBfXlIvip
 ZCn191SUFoou93UZsg2ncYKeizWmFQCfXNr0uo=
X-Received: by 2002:a05:6820:2f01:b0:6a1:5756:10e0 with SMTP id
 006d021491bc7-6a1891d3bb3mr2690547eaf.38.1782847824401; 
 Tue, 30 Jun 2026 12:30:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a18941c29asm2490438eaf.10.2026.06.30.12.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 12:30:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: Anshul Dalal <anshuld@ti.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Julien Stephan <jstephan@baylibre.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martin Schwan <m.schwan@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymondmaoca@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
In-Reply-To: <20260618130943.549083-1-ludwig.nussel@siemens.com>
References: <20260618130943.549083-1-ludwig.nussel@siemens.com>
Subject: Re: [PATCH v7 0/8] Improve FIT signature handling
Message-Id: <178284782188.2318957.3998288834722275890.b4-ty@konsulko.com>
Date: Tue, 30 Jun 2026 13:30:21 -0600
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

On Thu, 18 Jun 2026 14:47:35 +0200, Ludwig Nussel wrote:

> This patch series tries to improve dealing with FIT
> (configuration-)signatures a bit:
>   - make signatures work with QEMU. QEMU brings it's own device tree at
>     a memory address. U-Boot expects public keys in it's own DT though.
>     So merge both.
>   - (optionally) enforce signatures so we can't accidentally boot
>     unsigned fit images. Quite an easy oversight, esp when qemu
>     previously didn't even use the built in DT.
>   - make iminfo verify configuration signatures, not just image hashes
> 
> [...]

Applied to u-boot/next, thanks!

[1/8] test: include mapmem.h explicitly
      commit: e203526fb56e4db67679d23e92cdf1e00d7c92b5
[2/8] qemu-arm64: merge built-in DT
      commit: 9f6a014b9df8bc946ebed753b8e727c95d79a475
[3/8] mkimage: define log_err and log_info
      commit: 65e46af5c9c990bcc96fb39bd0bfe1b375771fcb
[4/8] image-fit-sig: Optionally require signatures
      commit: 38dc777ba6577f124605b3cc32fcb9af48e29512
[5/8] test: vboot: handle CONFIG_FIT_REQUIRE_CONFIG_SIGS in test_vboot
      commit: 947399c837bb0480b65fca2fbd5b806349849a48
[6/8] iminfo: also verify signatures
      commit: 7946505bdaf92831b3b7a889aaabcf13ae12c174
[7/8] test: vboot: refactor run_bootm
      commit: e4292038944c6251670d2aeca271cbba0e0d0894
[8/8] test: vboot: add iminfo checks
      commit: fb9670e004b5f32fc18301514884f0bde5a0084b
-- 
Tom


