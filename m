Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D31CDB47E
	for <u-boot@archiver.kernel.org>; Sat, 14 Oct 2023 00:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4DA586F10;
	Sat, 14 Oct 2023 01:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T7+u/fVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C382E86F6D; Sat, 14 Oct 2023 00:06:59 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 825EC86F8C
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 00:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9b96c3b4be4so391579966b.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697234444; x=1697839244; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=13BZAY0IEraljKUwq9mSNTvbIJsnlgPpz7CpszYXcbA=;
 b=T7+u/fVJxfWVhkVZZNs69NksXG4t/6gp7FB4+Fg6JMTejvQVvEflqFCvs1w5VLucWl
 62CQv8Vg+va4fFKRMIAn96f3Lj93G7sAxRBIgPG4LyehCDcawODyMx37EnySinSL2VIM
 p7TXtVJ7bOKFgAf37X90bCWtdUhGi/udeW8gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697234444; x=1697839244;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=13BZAY0IEraljKUwq9mSNTvbIJsnlgPpz7CpszYXcbA=;
 b=aVTokNuFcX4s4g9kiyoBL+c7d5sB0Zb+7gVUXd4O3ez8noWCMmiZZtsC6Y3rYQEy83
 GGuYE606NfTpmb8qp8qzXM3D0aA0aSVrBiF/P+bGU8ytZFKQ4Nd98HEqKbBSlbzKnTZ6
 NSJd04lc/KmVmPS+q0gmEsakm8yY6mLEBm3Ze19VZFD7eE9iNP58zxI2Mgza8sHMqfLN
 vD66jOokb7L/s+chgkU02xafVkrUdNUYCe3711yNaeNjqx97KLRdiygVnSNIJGZOC6nT
 /Ne6YFTVK9BrJTs9+/vJTY7y8yjaIHDSOCCVueBuilUrYYpS7+NQ9dGQgjje58lsG4Ph
 dHUQ==
X-Gm-Message-State: AOJu0Yxnoijph6tDoMqAc/BJWI/5tTut44Eetqq3PE/IuKszrV/CbN8x
 uK5WgOKGa/rKo+N35bLRL0zyjwRDeOKMsy7GLIIWhA==
X-Google-Smtp-Source: AGHT+IG7mxKg+lg8hu3rS/r2zhZMtYwTXOZ3JfYeKFOpLlteinFUyncEn5MB9nDQab7qzgtpsHfXQeIqhsmC1fTl4y8=
X-Received: by 2002:a17:906:30cd:b0:9ad:e20f:142f with SMTP id
 b13-20020a17090630cd00b009ade20f142fmr24085149ejb.22.1697234443971; Fri, 13
 Oct 2023 15:00:43 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Oct 2023 15:00:42 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0qFBDPcXxQ=xuBu_4q8GO=-ZqM6tZvZ4cfV=C0rZ19tQ@mail.gmail.com>
References: <CAPnjgZ0qFBDPcXxQ=xuBu_4q8GO=-ZqM6tZvZ4cfV=C0rZ19tQ@mail.gmail.com>
 <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
 <d4022e103b84d1d67615a728060afe6fb28bf747.1695817360.git.matthias.schiffer@ew.tq-group.com>
Date: Fri, 13 Oct 2023 15:00:42 -0700
X-Google-Sender-Auth: 1gCu21O9cjzmi0zBkgtOp7PBeQw
Message-ID: <CAPnjgZ3mEQr+EdDjeCY8iOtCYtE9oPVfQ_qp1mjRPUqWwKfeVw@mail.gmail.com>
Subject: Re: [PATCH 5/5] treewide: use dev_read_addr_*_ptr() where appropriate
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
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

On Wed, 27 Sept 2023 at 07:34, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> A follow-up to commit 842fb5de424e
> ("drivers: use devfdt_get_addr_size_index_ptr when cast to pointer")
> and commit 320a1938b6f7
> ("drivers: use devfdt_get_addr_index_ptr when cast to pointer").
>
> In addition to using the *_ptr variants of these functions where the
> address is cast to a pointer, this also changes devfdt_get_addr_*() to
> dev_read_addr_*() in a few places. Some variable and field types are
> changed from fdt_addr_t or phys_addr_t to void* where the cast was
> happening later.
>
> This patch fixes a number of compile warnings when building a 32bit
> U-Boot with CONFIG_PHYS_64BIT=y. In some places, it also fixes error
> handling where the return value of dev_read_addr() etc. was checked for
> NULL instead of FDT_ADDR_T_NONE.
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>
> This seems to work correctly (tested on x86 sandbox and TI AM62x; I have
> not tested the Tegra, Sun4i and BCM drivers), but I have two questions:
>
> It is not entirely clear to me what the difference between
> dev_read_addr_ptr*() and dev_remap_addr*() etc. is, but some drivers mix
> both. Should dev_remap_addr*() be used for __iomem? Is __iomem used
> consistently in U-Boot at all?

Perhaps there is no difference in U-Boot due to virtual and physical
addresses being the same mostly?

>
> Furthermore, can devfdt_get_*() be replaced with dev_read_*()
> unconditionally? Is there any reason why devfdt_get_*() hasn't been
> dropped entirely in a treewide search-and-replace?

Yes you can replace it...dev_read calls the devfdt interface if !OF_LIVE

>
> The k3-sec-proxy change goes on top of my other patch "mailbox:
> k3-sec-proxy: fix error handling for missing scfg in FDT" I submitted
> yesterday.
>
>
>  arch/arm/mach-k3/sysfw-loader.c       | 16 ++++++++--------
>  drivers/dma/ti/k3-udma.c              |  5 ++---
>  drivers/gpio/tegra186_gpio.c          |  4 ++--
>  drivers/mailbox/k3-sec-proxy.c        | 18 +++++++++---------
>  drivers/phy/allwinner/phy-sun4i-usb.c | 12 ++++++------
>  drivers/phy/phy-bcm-sr-pcie.c         |  4 ++--
>  drivers/ram/k3-am654-ddrss.c          | 20 ++++++++++----------
>  drivers/ram/k3-ddrss/k3-ddrss.c       | 23 ++++++++++-------------
>  drivers/soc/ti/k3-navss-ringacc.c     | 12 ++++++------
>  9 files changed, 55 insertions(+), 59 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
