Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E64CFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 05:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 882FA88113;
	Fri,  4 Oct 2024 07:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TlpNg+Pb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B40588001; Fri,  4 Oct 2024 07:40:32 +0200 (CEST)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53DAD88CEB
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 07:40:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-50792ed3b0bso518960e0c.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 22:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728020427; x=1728625227; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CCHNanpUXIkB6k3Ji6JgL/MjuWWQ6P38iTYemVm6Gj0=;
 b=TlpNg+PbhOUDd3KHmXqxruVFUy5U9WeMZszn9vOhWYIlkJKyphUJWy2q59kVYN1bjE
 QoyvXk2VPgN7D0TCl3J2bj54gpk75LeqGl7uCJG9Jj0rO/XbMr+DyOoa6F126e5G36jb
 efGzKJMHpl5RjbbqWQcAV4gq6Qxl8KvX4o+iaJd4FP+Js/sIEiIey2BqjrFccdWQcxrW
 oyg3QAXGD0QJTBKt+kc75kjjH2GvxSOwXoLuAlWx+NgTqnvlzSiDcIcl8FswOc8UdATn
 yZ4PQcyDGlwgVfbH3An/tGZ2bVj5+Z8jDj3CPezwlseBlqudj/zWDoLNcDgVTgQgHow7
 cpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728020427; x=1728625227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CCHNanpUXIkB6k3Ji6JgL/MjuWWQ6P38iTYemVm6Gj0=;
 b=mvOMiNBcqnW0VtQkc3V4Q+2dhCwIp1UYStdnFBVLNR5KMggr/1CUOSf00aAAk0yrJF
 cg4CU3tEPASEqkjFArxzMI+zboMJ+DvXKPCi2WzXeZOCde/nYj1d15BHmUr5d0nHePNj
 A2sgRmbuttr7L4Du/gwa6RlKSX02SwQ54Vr/f3gB5Jd6PqrU3+f5O0R6Sp+mVAUPOoRr
 NhCMaFbfrGSTAm6F7qmLmAqLxglBzTcr7aX6RGDteru/uPnhgazOEJ+x1nfOqLwuptYl
 ldXTw4gph72BhiXPSvSkafKIm9587fNrVTzTs42cZC49E1E62pzrdcbBsebkGxEkR6We
 0d7w==
X-Gm-Message-State: AOJu0YwaJZ1+te8kWuBwzEwz95GcGZx4fSBXF2QSZA2NTO1GkzCfHS79
 WzurPMkXK0FtWKZtfkpo4tGJ6MVp05hEYrUlmy1NSQTaR9UdlzKmaAemDo6MW+VOwOh5907PalR
 tnzJJ4af5fVM/baMQRhuPYx7zZE5/N/wJlTYYrg==
X-Google-Smtp-Source: AGHT+IFJK5ABdL4ZSpkCVCf0ve772KCMRbSqmjnZPQPa2od9PIY+DOJe+V89/sAxq+dnVZs5u9XwlIZz2Eb8cZOU5qM=
X-Received: by 2002:a05:6122:3d15:b0:50c:79a4:c4a with SMTP id
 71dfb90a1353d-50c855966e4mr1142625e0c.13.1728020426820; Thu, 03 Oct 2024
 22:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240927214955.394224-1-marex@denx.de>
 <20240927214955.394224-2-marex@denx.de>
 <CAFA6WYPPXDJC4kSiBAR=jL-Z0v3a8+=_=+hLx+Ug0+yu407y3Q@mail.gmail.com>
 <75eb6eb6-dd55-4509-a041-a5941286493f@denx.de>
 <CAFA6WYM8KJQkTQ6YtMC7ByKU-h1Yss9K50veWmsnni3gYsgj_w@mail.gmail.com>
 <066867d2-6d16-4ebe-9a42-8ce58d3889ec@denx.de>
 <CAFA6WYNy+XzWvMcfJqmLRfinKUPnvx7Ha42xOxF4a=izPKMr4Q@mail.gmail.com>
 <609e203a-45cd-4155-8f0a-26f3f1e8c497@denx.de>
In-Reply-To: <609e203a-45cd-4155-8f0a-26f3f1e8c497@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 4 Oct 2024 11:10:15 +0530
Message-ID: <CAFA6WYOgEUXVPfkaja4ZXekyet5n7E5MUKyUQY-qXjPzFtxttA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dts: Add ability to build DTOs only from
 arch/$(ARCH)/dts
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@dh-electronics.com, Jan Kiszka <jan.kiszka@siemens.com>
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

On Fri, 4 Oct 2024 at 07:15, Marek Vasut <marex@denx.de> wrote:
>
> On 10/3/24 9:58 AM, Sumit Garg wrote:
>
> [...]
>
> >>> IMHO, the OF_UPSTREAM migration can wait until all the required DT
> >>> sources (.dts and .dtso) are present upstream. If we start to mix and
> >>> match DT sources then it is going to turn into maintainers' hardship
> >>> again. However, I am still open to further convincing arguments for
> >>> this.
> >> With some Linux kernel architectures, it takes months to get a singular
> >> patch review out of the maintainers.
> >
> > Okay I see the pain but we already have that rule for .dts files for
> > OF_UPSTREAM switch but having a different rule for .dtso files is
> > going to make maintainability complex.
>
> What kind of rule is that ?
>
> If the rule for .dts files is either dts/upstream or arch/*/dts, then
> the rule for .dtso is either dts/upstream+fallback to arch/*/dts or only
> arch/*/dts .

Yeah that the rule difference we will have after this patch for .dtso
but I can live with that given it being gated behind the Kconfig
option below.

>
> > The Linux kernel
> > sub-architecture maintainers remain the same for both .dts and .dtso
> > files.
>
> Well, yes.
>
> >> For systems which already have DTs
> >> upstream and only have DTOs left, the OF_UPSTREAM conversion and DTO
> >> upstreaming can be done in parallel, hence expedite the process.
> >
> > Fair enough, let's try to find a middle ground to gate the local DTOs
> > behind a config to make the use of local DTOs explicit. How about
> > CONFIG_OF_UPSTREAM_LOCAL_DTOS?
> Do you think another Kconfig option is really necessary ? I don't mind
> adding one if you think that would make a difference, but I don't see it
> as strictly necessary.

Yeah I think it will make explicit the usage of local DTOs vs upstream DTOs.

-Sumit
