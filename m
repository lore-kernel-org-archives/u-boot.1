Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA98CC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 17:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A93DF87796;
	Mon, 11 Dec 2023 18:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OiNYoyZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22EF5877B2; Mon, 11 Dec 2023 18:53:12 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65BC7877AB
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d9caf5cc948so4609419276.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 09:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702317185; x=1702921985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=13ZovILlUhFA0lws9FHsCAfFkZRnsJ/gBzae1UyLoJg=;
 b=OiNYoyZ+Q1XSG5EE8es6jkImoQkd1hSElAP92KA+5pjI1ikLh9iW43juM48adSHwDH
 wAG1ji633q83nSqYH8WPra6FPaucv3GEbqGMZmpD6nNDzHlx3aEb/V1DxHnnHQr+fKsV
 do7JKjdAJGc8SrOW5jcPYeEJrgrclN+F59QXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317185; x=1702921985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=13ZovILlUhFA0lws9FHsCAfFkZRnsJ/gBzae1UyLoJg=;
 b=HbM4eSpUHEyEaN0b8gDVi04kTmHTzcX9Z8FNeYZlv5+/clpJzI5FO38KOMqU/rHMo6
 JFCFfZH03tw+mx4l/xaWf6VO3uQP8M1nUaqDH4wq/jZQrxjZefr7RWaGsZZdf4/VMmEk
 Eg6pwYe+Yu9KToK+Oaxw0V0jfg58C68AHC6yilqFclKkfeK63ZAJ+5H30Lj91Ssm8K69
 K+5VuF5xH9t9Z/a4W47XDCUeOGAm0PJYV6+vVH9goOENozDs5YPLIK8jCli8/AYjGxpv
 Dhn5ar8a8nGSjF09SApNvmrvhVQYn57LkUk7GGDNdAXbXAG0ReFyDTsglrBjUjfQIhpI
 wIzg==
X-Gm-Message-State: AOJu0Yw6OlGSIrOl/I6QKqeMYkpDGl37aJX7lD868I1+eBmgYyKUf3X9
 Xgb61mXjbJqnkRpXgor8uxR/Jk408xcOnPtFYoL+FQ==
X-Google-Smtp-Source: AGHT+IGzCLxJ/x9TGHTMUa7B3NVEC0BB5LLP0CFxPkmB+A1o9Fbuu85hRb0O2r1Tq/hLXM6gst0RMuJfa54iP/uNlNg=
X-Received: by 2002:a05:6902:3cc:b0:db5:4ae6:1605 with SMTP id
 g12-20020a05690203cc00b00db54ae61605mr2806790ybs.65.1702317184892; Mon, 11
 Dec 2023 09:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20231204003144.899097-1-sjg@chromium.org>
 <20231203173130.2.I826be28024caa3834c47f752d0be1000855dd4fd@changeid>
 <20231209183917.GU2513409@bill-the-cat>
In-Reply-To: <20231209183917.GU2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Dec 2023 10:52:10 -0700
Message-ID: <CAPnjgZ3gASnXP7Hx6r3SuCRtbKJ2nwOQyjAfRbDtWpVf77eAyQ@mail.gmail.com>
Subject: Re: [PATCH 02/14] bootm: Add a Kconfig option for bootm functionality
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Brodkin <abrodkin@synopsys.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Eric Nelson <eric@nelint.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Michal Simek <michal.simek@amd.com>, 
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
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

Hi Tom,

On Sat, 9 Dec 2023 at 11:39, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Dec 03, 2023 at 05:31:26PM -0700, Simon Glass wrote:
>
> > Create a separate Kconfig option which enables the bootm logic,
> > separate from the 'bootm' command. This will eventually allow booting
> > without CMDLINE enabled.
> >
> > Update boards which disable CMD_BOOTM to disable BOOTM instead, since
> > CMD_BOOTM now depends on BOOTM
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> This is fine, to start with. But I wonder if it shouldn't be an
> unprompted option and select'd by functionality as needed. That might be
> clearer to the user going through menus, but we can see better once the
> whole picture is available.

Perhaps. As you imply, it will likely become clearer later.

Regards,
Simon
