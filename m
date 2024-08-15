Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0764AC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2111B88B23;
	Thu, 15 Aug 2024 22:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YV3m9Gna";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5932788B9C; Thu, 15 Aug 2024 22:32:37 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CD998657F
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2d3e46ba5bcso110195a91.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753950; x=1724358750; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XAzoQ22z0WK+2fP3FQh52oJ2l1jj8cEMJNjPrl++1NM=;
 b=YV3m9GnacR172sqEfLNEcLWrsz+eYLzy6tYEhBPSnJKtn4adbiBN5F9va6IjOVRCL5
 47NbPSP5HrR9WCxfcSvwe0kXMdlmTAaWvSH5cYQjzw5gFjYi24vPTntvY+CKRxQmvlM3
 BPTs6Jw+tywkyZC5cX2NBp+QKRlxzkPrxlC+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753950; x=1724358750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XAzoQ22z0WK+2fP3FQh52oJ2l1jj8cEMJNjPrl++1NM=;
 b=avyRBC1WB75m/r3KMDGqCfZqsvqy6vuN6pdl1GWMOglTolL41Izj3vJD4TZuPV3MAF
 BK6NILctwe4WIrs10aMBq+ek3C2u2WXkQxxxQt5zccsTINs8dcWBH001goKjcDa/XbEz
 1Lwc52Rb8vrsDRw2BLlXhj24L+WNvXR898+esQ5l8K8BPKGuMLE6d4TA2XlmWim4xxoj
 1HPu6yf5+7eV78y4LASudAAkI5MaSlfxn0DUYe8NoFIj3M1mOryobiLWMWbAh46GGaz2
 L64qXKuz5O5lLVSuTGt8Nox64ykp1sEDgcuIusaTSlsWugsjjd5toe9Ea/4pqqQxyLZo
 2A4Q==
X-Gm-Message-State: AOJu0Ywrm4bCHHb8gxZDn73iUXx6PrzlSPHUYMMJ5HHYdwLrfBzL3OAX
 E1N5UKhhOHb70Q2ZkgDikReqL/WwaWHHwTa3ydbk3oNIosw5NqtIYduU/hbDE2/uI2GYaVZLbQT
 EoEgUqnw7o3yfgrD1M/vc41sBNPeygxzgAcMo
X-Google-Smtp-Source: AGHT+IHI1qkr8YpyxruneZb9to64DgWAGmXRx3TakiyXiRS963mC20l90y+Xlh4bQeCXzMY7Rn8Nx4FRxA+I9+V+yiM=
X-Received: by 2002:a17:90a:46ce:b0:2c9:5a85:f8dd with SMTP id
 98e67ed59e1d1-2d3dfc66da0mr978230a91.18.1723753950077; Thu, 15 Aug 2024
 13:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-24-sughosh.ganu@linaro.org>
In-Reply-To: <20240814110009.45310-24-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:32:19 +0100
Message-ID: <CAFLszThQUM9N+r_vKHK5z0Au2WK+R=iX7txeAvtGbESSr6EZgA@mail.gmail.com>
Subject: Re: [PATCH v2 23/32] sandbox: iommu: remove lmb allocation in the
 driver
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

On Wed, 14 Aug 2024 at 05:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The sandbox iommu driver uses the LMB module to allocate a particular
> range of memory for the device virtual address(DVA). This used to work
> earlier since the LMB memory map was caller specific and not
> global. But with the change to make the LMB allocations global and
> persistent, adding this memory range has other side effects. On the
> other hand, the sandbox iommu test expects to see this particular
> value of the DVA. Use the DVA address directly, instead of mapping it
> in the LMB memory map, and then have it allocated.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Move the DVA address and page size as macros to the test.h header
>   file.
>
>
>  arch/sandbox/include/asm/test.h |  4 ++++
>  drivers/iommu/sandbox_iommu.c   | 25 ++++++-------------------
>  2 files changed, 10 insertions(+), 19 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
