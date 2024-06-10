Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F4EC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1D8488610;
	Mon, 10 Jun 2024 17:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dOHA6b8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 151A0866F6; Mon, 10 Jun 2024 17:03:23 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DACE6866F6
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 17:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so3136437a12.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718031799; x=1718636599; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yh0g3Mp6AbWwC0VxWK0frBAcpm26qxHTjCofRl3Q+uA=;
 b=dOHA6b8DCjnHKIE4C5S5HrARqBQ4drFLYnApjf5U/GFzlyAJtXvkyU2RJl+Zm/zNCG
 +nP7w/tMBP1clO7v9UHVRRdaxXu3xU+7B4tDUnKnM+ebZ85c6TpVVcEUsttbeRJpSNQc
 +eU1RcYTkUfWG1H6z8pDBHfWiOoA1K8/j6eNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031799; x=1718636599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yh0g3Mp6AbWwC0VxWK0frBAcpm26qxHTjCofRl3Q+uA=;
 b=GgLfRA7Y3KLe15Cxj9OW2gEe4AWigEqJxJ8tP8pPu6g/oNomOqn62APJo8WBAZbzZy
 OqUA+X1UoTxDBZDZ8rwSL4nP2RoD/0UftnlDTp4Jpl7CDYgmKZqXUf7gTlAiiVIKkwsR
 LZ/OVgPz6lfLHchJsG6BIGaAoYL2RmDO8yGBUUgeL3M43v9CDaJSGChUIrpI6YzMeerb
 PVw0chxQfkbdfChNKBdRLOXsioStoBTrhXzPu/0UXFyQ1PYPJAIKd6PXx+OaFkHA45UV
 kWudHq0RU7lsYAF4wBBBhl3WtXAGcfEtNM9kpcXtTD2n0L9EcSLN9J30M/qjDsGqIhL3
 5a0w==
X-Gm-Message-State: AOJu0YwVF8mj/KhA0YWlk2nFWEEpQdtU2ktgflnxVnCmKx9LrDz+/kFF
 bR2Z98kceTlopKEX6QHmvNNevhow2VVpHb6dl4f+MrT1yVWu8Gcud1riZ6CaX5C2I1WIqMphQNO
 uQUgX+m5xI1Q8wEnYmzKdYfy2LoUdjkmuG7nt
X-Google-Smtp-Source: AGHT+IEuxVWH/690pGM3E7QVCnlFM9LTaEi97QHrup1lpzGL3gFTgmlOaUGoGhbRiOdS2VtmhFvznotd2HEFIw6RA2M=
X-Received: by 2002:a17:90b:2252:b0:2c3:236e:473c with SMTP id
 98e67ed59e1d1-2c3236e47admr659808a91.21.1718031799264; Mon, 10 Jun 2024
 08:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1714138688.git.michal.simek@amd.com>
 <66a52861-6203-4b6f-940e-52e21abfbb1a@amd.com>
 <CAC_iWjJzTrTSFNmnRcXH2JoPK5EB1bNgBzbHLvyEy0-JxQ-E2A@mail.gmail.com>
 <1cbaa06c-2f08-4d44-9829-e8c4b04a3f03@amd.com>
In-Reply-To: <1cbaa06c-2f08-4d44-9829-e8c4b04a3f03@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Jun 2024 09:03:05 -0600
Message-ID: <CAFLszTh9y740U7bwArNTfQ2VREUQwFHtwkOEfyY9T1bMEv62XQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] lib: smbios: Extend driver with using sysinfo driver
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Michal,

On Fri, 7 Jun 2024 at 01:53, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 5/24/24 12:07, Ilias Apalodimas wrote:
> > Hi Michal
> >
> >
> > On Fri, 24 May 2024 at 12:45, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >> Hi Ilias,
> >>
> >> On 4/26/24 15:38, Michal Simek wrote:
> >>> Hi,
> >>>
> >>> currently only DT way is supported and it is added directly to lib/smbios.c
> >>> but I think DT and env is only one way how information can be found that's
> >>> why this series is improving handling with using sysinfo driver which can
> >>> be platform specific.
> >>> At the end of day DT should be taken from smbios.c and put to sysinfo DT
> >>> driver instead of implementing it directly in this generic file.
> >>>
> >>> Thanks,
> >>> Michal
> >>>
> >>>
> >>> Michal Simek (3):
> >>>     xilinx: Enable SMBIOS command
> >>>     lib: smbios: Let detect the system via sysinfo
> >>>     lib: smbios: Detect system properties via SYSINFO IDs
> >>>
> >>>    configs/xilinx_versal_net_virt_defconfig |  1 +
> >>>    configs/xilinx_versal_virt_defconfig     |  1 +
> >>>    configs/xilinx_zynqmp_kria_defconfig     |  1 +
> >>>    configs/xilinx_zynqmp_virt_defconfig     |  1 +
> >>>    include/sysinfo.h                        |  9 +++++
> >>>    lib/smbios.c                             | 42 +++++++++++++++++++-----
> >>>    6 files changed, 46 insertions(+), 9 deletions(-)
> >>>
> >>
> >>
> >> Any comment on this series?
> >
> > It's mostly Simon that created that sysinfo stuff, so I was expecting
> > him to have a look.
> > I can put in on my bucket list, but that's going to take some time
>
> Simon: Any comment?

It looks OK to me.

Regards,
Simon
