Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3951E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03A5B87441;
	Mon,  2 Oct 2023 03:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nzpxZRlP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A117A871BD; Mon,  2 Oct 2023 03:22:18 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEADA871CA
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso2128569066b.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209731; x=1696814531; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jBFplmZ80JSg1RLawvTvQeUPdaoHOOOQdaFpOCJvsIY=;
 b=nzpxZRlP0CXHWKkCC1c9k3jp5aSxWmlvV5rekzrgxlKA3TvSZQAYQu0QD4jIuJSA+t
 fXrwBOBy2W0dKirtComqneVJ1TGzRiMWgGrHf7n85PYDvrXYjasd8qfCHtagnDNcddtZ
 whElUI2Tkar3d9HfWDMt4K84mrXJyzofgm9LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209731; x=1696814531;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jBFplmZ80JSg1RLawvTvQeUPdaoHOOOQdaFpOCJvsIY=;
 b=j0Nl19QZ7stFtK4phPG5mQ1lBhUxBHg8MBmJohhnpaAGUUbI1PUGY/yIk3p3S20GkT
 CnXu6sZmWR/4rBbyEl41z8jcj8eXdEXV8IF2WdjE/O7cg4EjJbSj5+HagIWqDo+29nci
 3abJBcg3R+6j++oSzCJJOTW/PJDfGfqQLNy2857cqhtIU8RA4dc8wThc0fAXFEDWrrRo
 kDfhGqX4W5GwFeCXrq2i96u87x7iFk2RGCH4TtBBBg7dD5SITBo+bk6PeuxomrUFb5o8
 VP6oL5yDoyMg/8D1rQyJqL+RwWBa2eg+JC9wr/CjUIHFHyJgDB2WU+3UQM8TxYhd1lRo
 vVZg==
X-Gm-Message-State: AOJu0Yx5EAzAdwU8o7vJhNiCzlUtJx9sYMDMJdtrFpLdRl1XLK6dKh23
 ll5PONSZXNRfmc23yv+HEdaJEc5YCBSaYLtrk48RIw==
X-Google-Smtp-Source: AGHT+IEPkV45+qCjMf2DkN6mpEdyvHM2OB5hOZRl5grz7aCxhYNixTOyhjtGX/NiMvteoNHA11Ki0b7zXf+Pak0lHik=
X-Received: by 2002:a17:906:538f:b0:9b2:703e:11ad with SMTP id
 g15-20020a170906538f00b009b2703e11admr9854710ejo.65.1696209731105; Sun, 01
 Oct 2023 18:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
 <d4022e103b84d1d67615a728060afe6fb28bf747.1695817360.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <d4022e103b84d1d67615a728060afe6fb28bf747.1695817360.git.matthias.schiffer@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:32 -0600
Message-ID: <CAPnjgZ0qFBDPcXxQ=xuBu_4q8GO=-ZqM6tZvZ4cfV=C0rZ19tQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] treewide: use dev_read_addr_*_ptr() where appropriate
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
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
