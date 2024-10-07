Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE06CFB448
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 15:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07A6C88D5B;
	Mon,  7 Oct 2024 17:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lZ9AFP/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A1388DCC; Mon,  7 Oct 2024 17:24:18 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32B49888EB
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 17:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cb22e9c6dbso25506526d6.1
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728314655; x=1728919455; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m98LhbxfSZqDXpzvOctaDVRTp/F84leByCglEFjVhTc=;
 b=lZ9AFP/SD+JrhhAVniXcgbwOOOGQEffbnzPCVXtA3uk9s6aX0cdF2WRFXPQ+4F79Le
 noo3rdlaZFrOrA1M4awsSoz7J1pwQNXf0S0phaSS95rRkC5FFQGKqmalCScvc/cuS4Cr
 iuaoaNdcXQhO5CJ8dw+fxEdJzZAiTJ4qaCyI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728314655; x=1728919455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m98LhbxfSZqDXpzvOctaDVRTp/F84leByCglEFjVhTc=;
 b=qfnmtfwBiOSAXPfR5HOH6ZGMiS0GyVVEw19bexVQM5GqF5SbN3pqheuuBQ9mqMVbYi
 yj5kPPJnmyhWjIFOfJGvoDHXydiq0IvX5D2ghmnGn2lHh50AsfvIodzmGCZEd0n08sNt
 Y2+JlYzq6TN3fg4Vl6DTxW46hnoHXpVDCksapZALaHXDnFEHPLqob7r6lFJwXTlQknDy
 OKqtf1tV5POOEJ7pmXnaQN/edex1YNWzQIOQh0jK7wXy8O6rmJ3TEhs9U22wxlhhND0O
 Gng/HqVLcdVzLQom9Sp5Z0SWLSrfiLu7pBFd+gJO71bEoB8+Izphz+0luKVq+teTALts
 9xWQ==
X-Gm-Message-State: AOJu0Yy6Nefz5lqCjZqXZBOp3zevzekXMFEESfQFPoolk7YnrHStRdEb
 /mOxNykHN5lTOySLLYMkEyJk9ffxpk8+Op4NgQhHi8Ffrw5gyql9ujTxF9Br6vmxqxlP9alMH+t
 aYzTYPKzm+N8efj+MmsUpnroCtnTKfd8gevWq
X-Google-Smtp-Source: AGHT+IEWHrO6U8gkVIo82GVnDBPgoje2+pc7YQOAYWFpPR5sa96DDEsDl40cuYoFi5E3VvdrBFq50aDniuMdg0pGjGU=
X-Received: by 2002:a05:6214:5889:b0:6c1:6e3a:6d17 with SMTP id
 6a1803df08f44-6cb9a330d6amr208780666d6.6.1728314655030; Mon, 07 Oct 2024
 08:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241005011315.436233-1-marex@denx.de>
In-Reply-To: <20241005011315.436233-1-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Oct 2024 09:24:04 -0600
Message-ID: <CAFLszTj6fSV6o88GnzTy+vzuFyFxM1XCzCyYxjaACV=OiOfdqg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dts: Add ability to build fallback DTBOs from
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
 Stefano Babic <sbabic@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Fri, 4 Oct 2024 at 19:13, Marek Vasut <marex@denx.de> wrote:
>
> Currently the enablement of OF_UPSTREAM results on the build system
> searching for DTs only in dts/upstream/ . There are platforms which
> use U-Boot specific DTBOs applied on top of U-Boot control DT during
> SPL stage, and source DTs for these are located in arch/$(ARCH)/dtb.
>
> Add dedicated 'dtbos' target which builds only .dtbos and not .dtbs and
> in case CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS is enabled, build
> this target for arch/$(ARCH)/dtb to generate local U-Boot specific DTBOs.
>
> Adjust top level Makefile so binman would search for .dtb and .dtbo in
> both OF_UPSTREAM specific paths and arch/$(ARCH)/dtb for the .dtbo case
> in case CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS is enabled.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Lothar Rubusch <l.rubusch@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> ---
> V2: Gate this functionality behind CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS
> ---
> NOTE: Depends on https://lore.kernel.org/u-boot/20241004001118.322531-1-marex@denx.de/
> ---
>  Makefile             |  4 ++++
>  dts/Kconfig          | 16 ++++++++++++++++
>  dts/Makefile         | 14 +++++++++++++-
>  scripts/Makefile.dts |  6 ++++++
>  4 files changed, 39 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Congratulations, you win the prize for the longest CONFIG name!
