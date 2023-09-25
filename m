Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6A5CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 13:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2351786B93;
	Mon, 25 Sep 2023 15:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a74U3P1n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E78E286D25; Mon, 25 Sep 2023 15:11:18 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1456886C45
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bff7d81b5eso107377831fa.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 06:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695647476; x=1696252276; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1mvBJ2+FJf2qVaj94GRyiBIn2gBsG6T+rp/EYFyj+qU=;
 b=a74U3P1neM9v4wYtcoWswzIxBaE1HA9+uPPj6RL4FISzGo3NT82YQRZeaiJ0IaNhws
 4Reisy2wKnxl8/3U5Tv/7gXBgAA5osRrLpVkTU+PpLZN02JtIUe57Q0HAXeZEGXl9xM6
 iFARufoKTNLW4euRe7YZlLPVf4t+IpGSHEr4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695647476; x=1696252276;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1mvBJ2+FJf2qVaj94GRyiBIn2gBsG6T+rp/EYFyj+qU=;
 b=dvTm4FiXQfWop2VyBroC55C8ClW15TZZDpTz+f9AH83YWAfeo62fnss/4PWIuCF5QK
 PHxlu6eMjILJis627kO3FJ7FZXRMb4/Bg2W1xz3EzVQtEoIELIXmFWVYlz0f5U0UFwxi
 J9/4KD8knwM3SfKThjpuEjUargXhe//KBMl0iE8ecE4epMhH1MRwomhYfKmocrF82c6k
 i81IuGJxTNus9JZkuC1qhk/myplq20JXwCtsPlLicQH3Zr+lsF8xMYCK8EB9FY5xRABv
 x4UNske23Ekj3l4BHRdJF/aEm5S7WCNzJxHLLMjmS9sLZOHvasw3mkfB91c7C8ZrjrYA
 z5cA==
X-Gm-Message-State: AOJu0Yybp8cvSf95boq9FaqtkWp5MgQ23XoPD++petCji7llL4Ptcg+Z
 idnx4iIfCKQUIhhBmb+DVLzIQyqZYR9tCKiHHcvhifq5fRM1uayrUwY=
X-Google-Smtp-Source: AGHT+IEVTQWeJfr1Rqm6fbNo8vv6I0rlw/BAVZnZh1Af/MDQp/PN7P8mD01UfOo8wd5DmRm5Aut5T18OgTM6bcrb+sI=
X-Received: by 2002:a05:6512:10d6:b0:504:3424:2157 with SMTP id
 k22-20020a05651210d600b0050434242157mr6389089lfg.42.1695647476093; Mon, 25
 Sep 2023 06:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
 <20230925080909.365098-5-rasmus.villemoes@prevas.dk>
In-Reply-To: <20230925080909.365098-5-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Sep 2023 07:10:36 -0600
Message-ID: <CAPnjgZ3VTDxm32my1PLU8rjQFpZ_HaejLAN06jRxgNVxzhpGMA@mail.gmail.com>
Subject: Re: [PATCH 4/5] sandbox: rename overlay sources to .dtso
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 25 Sept 2023 at 02:10, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> Distinguish more clearly between source files meant for producing .dtb
> from those meant for producing .dtbo. No functional change, as we
> currently have rules for producing a foo.dtbo from either foo.dts or
> foo.dtso.
>
> Note that in the linux tree, all device tree overlay sources have been
> renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
> 81d362732bac). So this is also a step towards staying closer to linux
> with respect to both Kbuild and device tree sources.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  arch/sandbox/dts/{overlay0.dts => overlay0.dtso} | 0
>  arch/sandbox/dts/{overlay1.dts => overlay1.dtso} | 0
>  2 files changed, 0 insertions(+), 0 deletions(-)
>  rename arch/sandbox/dts/{overlay0.dts => overlay0.dtso} (100%)
>  rename arch/sandbox/dts/{overlay1.dts => overlay1.dtso} (100%)

Reviewed-by: Simon Glass <sjg@chromium.org>
