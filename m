Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5991FCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8686E87199;
	Thu, 19 Oct 2023 16:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PeYYMi1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 465AF86CAF; Thu, 19 Oct 2023 16:00:20 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B46558701D
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-507c78d258fso2979512e87.2
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697724011; x=1698328811; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S/GCeFsCHNx94cVLWH0zxDsVh7se0CSMR8L93GvOfbU=;
 b=PeYYMi1+Yp1ORNr6uRDZDJKLhr99VYuK8PQ8KvA7QmXCajCw20s3q83obcMtb9MoDf
 V/sE1TWgu3zrmhL9Uqmwxd5l+e4nIpXtoVtoSx4SAichJLObB3ZLAPP3gHy9+WTZKleo
 0GMp4HIL+q5VHbsTj4F2XTNayZ+H5+xZ5EQZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697724011; x=1698328811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S/GCeFsCHNx94cVLWH0zxDsVh7se0CSMR8L93GvOfbU=;
 b=v9tL0j153lu0uor46STOj49GMMdEmgrfoHbgKTk+mUtjnJFy5A6kJW9ObrltAe/N3s
 mecvMT3+mXzGePyIayMu2zTpU8RLnLs84s7Xvu1rLVviTFhrQEia5gvIVik2dbE+RV57
 XK5Kp/CSdUImqwqIhjHzPGAljXQFcLMAfT74P6ztej4ucHyrhpotTV1ZmpP/+t8E5kL3
 UW8jBonFczFzgjK5gMd0Sm44C4JpSTmNKL69r8g7P67LOA+Td0qkY6fHz5N0DV8Mt5qY
 afMOqEe+tDwNtWzj0XNUDlLxS248DhCsQYX+3CgcSLr7IwpDJfVqqr2FOmDX5CC73A+z
 27Wg==
X-Gm-Message-State: AOJu0YxJC7xDejmgQan4S6tFtMbyDtaRIMbGOcfWtNEfDGiWo9lJmIRc
 vmplaK9i2rS/dxQaSHKrl7bxUj8QvoBJ0jNAXOW+1g==
X-Google-Smtp-Source: AGHT+IEYhxF9DFgGxclTzLZWNuJy6Gg7nvPtjxE9CspGWkOU6s2TiduXfbNnFelEh5NLxmpOP/Fi7nrRihdXlotFAag=
X-Received: by 2002:ac2:4824:0:b0:504:3a3d:5015 with SMTP id
 4-20020ac24824000000b005043a3d5015mr1411159lft.27.1697724011241; Thu, 19 Oct
 2023 07:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-33-sjg@chromium.org>
 <20231019023253.GA1856856@bill-the-cat>
In-Reply-To: <20231019023253.GA1856856@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Oct 2023 08:00:00 -0600
Message-ID: <CAPnjgZ1xFkn806tSJzM2_wKhKz_GbJvA9bCALiaRV+wGaXz6_g@mail.gmail.com>
Subject: Re: [PATCH v3 32/32] sandbox: Add a test for disabling CONFIG_CMDLINE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 18 Oct 2023 at 20:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 16, 2023 at 04:28:23PM -0600, Simon Glass wrote:
>
> > Now that everything is working, add a test to make sure that this
> > builds correctly.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > ---
> >
> > Changes in v3:
> > - Rebase on Tom's LONGHELP series
> > - Correct 'of' typo
> >
> >  test/py/tests/test_sandbox_opts.py | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 test/py/tests/test_sandbox_opts.py
>
> This is not doing the equivalent of:
> make sandbox_config
> sed -i -e 's/CONFIG_CMDLINE=y/CONFIG_CMDLINE=n/' .config
> make oldconfig
> make all

Buildman should do that automatically...is something failing?

Regards,
Simon
