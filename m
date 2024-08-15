Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBDEC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A503F88B6E;
	Thu, 15 Aug 2024 22:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gx66OPtR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B788388B6E; Thu, 15 Aug 2024 22:32:35 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FF4188B23
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:32:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7bb75419123so1082228a12.3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753949; x=1724358749; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rP/1mm5clkvQzTykBU5CU807vzw0zGXbymLwSStrhc8=;
 b=gx66OPtR5gfHLO6cm5LsIJtKenKzA9tb/ybT6+7bOoBAIGODVz+Fq+YZa+PVvIew/0
 YtAsBt/xfLE/DCnATeksNrjfGy1UTDqUBtM94SHVqwcEVi7UoySuoC7rzCK59dc4qQL1
 vyXUyBX0uxTlWUXatpDa+Co/tfXURgd4M32VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753949; x=1724358749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rP/1mm5clkvQzTykBU5CU807vzw0zGXbymLwSStrhc8=;
 b=LkPvCUJve/Sc5P2TaTrou9MJS6/Qv3xjM9rkcYmfy4jpvk+CnWIr0gU7Loys4rwBOe
 383UBbasHgntAGILjrwGMMuZKm/VNZD5fB/F8FtI3ENbhqdj5kJNVpvzEz860zBLgc1l
 603Qos1xBH2D5gCgh/DPsblwfRlq2KRBYfb90bU8gRMuM7EzQYil+TxOL226QJp2YZ+m
 0C4FRvj+TSlXqSWfDJ+QXtqo3siq8Wp+yy8Ha6c+TrgdtCHaMhgwxjVCtM9yI6ftr2cx
 UoVJqCaH5CusXxTWd34WDjEXuL5BTApsq6P44gC7CpBLehUsYc/Oa4SvN/6SG/b+1gmb
 964A==
X-Gm-Message-State: AOJu0YxaLDrSCQU+qDBfcjCmip+yHdjZBOv8iL+Vwz+Ln2/SzEb0PTrL
 Okk+hRsZIVh+nBWvzFAVlP3MOaB8nrFogQRXb+uQUV9QZIr2ztMnPKNA/PwTaOWBVtSJWtXLlLh
 Mi31df9a+oLULEO2ipNoCyFoWMMGxE3qZDXeG
X-Google-Smtp-Source: AGHT+IGrS1hD88QSd9t996aU8Y4zXXAHv/VRqDqJvsZAoxfBgiOSpV2WfL3YtGbw++Buu+JReRob3oN1bFPOC0FLlNA=
X-Received: by 2002:a17:90b:14e:b0:2d3:c0d4:2c33 with SMTP id
 98e67ed59e1d1-2d3dfc6e82dmr896635a91.17.1723753949431; Thu, 15 Aug 2024
 13:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-20-sughosh.ganu@linaro.org>
In-Reply-To: <20240814110009.45310-20-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:32:16 +0100
Message-ID: <CAFLszTiVJ1YXTaf8zoMA8cEzQCS5io9BsxL46WsQ857BvHL+xA@mail.gmail.com>
Subject: Re: [PATCH v2 19/32] sandbox: move the TCG event log to the start of
 ram memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 14 Aug 2024 at 05:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The TCG event log buffer is being set at the end of ram memory. This
> region of memory is to be reserved as LMB_NOMAP memory in the LMB
> memory map. The current location of this buffer overlaps with the
> memory region reserved for the U-Boot image, which is at the top of
> the usable memory. This worked earlier as the LMB memory map was not
> global but caller specific, but fails now because of the overlap.
>
> Move the TCG event log buffer to the start of the ram memory region
> instead. Move the location of the bloblist address up by 8KB to
> accomodate the event log buffer, and update the sandbox memory map
> specified in the documentation accordingly.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Rejig the memory map to have the event log at 0xb000 and bloblist at
>   0xd000.
> * Update the memory map in the document accordingly.
>
>
>  arch/sandbox/dts/test.dts    | 2 +-
>  common/Kconfig               | 2 +-
>  doc/arch/sandbox/sandbox.rst | 3 ++-
>  test/lib/kconfig.c           | 4 ++--
>  4 files changed, 6 insertions(+), 5 deletions(-)

I think the TCG should be in a bloblist. I can do a patch to do that.

So if you are OK with that:

Reviewed-by: Simon Glass <sjg@chromium.org>

and I will send a patch later.

Regards,
SImon
