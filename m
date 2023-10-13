Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69DCCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D44FA86F20;
	Fri, 13 Oct 2023 18:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S5dcskhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA8B386F1E; Fri, 13 Oct 2023 18:58:20 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 336AE86F14
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5a7e5dc8573so28508797b3.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697216293; x=1697821093; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lUwIgchCoztk/L+lDJuxiVfkCV3JYk9JWHOPGaE85TA=;
 b=S5dcskhuRRSSeNcTRFCEFzZ1V8eDA1U1nSxsrhYQTnWxdGPISbq+3siokgeGie+Vmx
 DD0/5joYleDOzvhNFSKq5gBa5Jv8vTm36/816tNHnF7tUSDpX0yoNeSjPKCXCBv9O1OS
 59++5w7o0bYqzCztPSazJxsdDYX272MkLyea0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697216293; x=1697821093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lUwIgchCoztk/L+lDJuxiVfkCV3JYk9JWHOPGaE85TA=;
 b=Mk74EgVV6qsayDBkmuermCWboJSjUuKq7GCeLRWvKfS1I2ZxT6K2zmrPrnYlO3m2qW
 JhxRUXPRLLlqfqUei1+CuIkZXgMVnrPxFYp4LfoXa7WjSPKrJbGbBqGPG2WNVj9zwyBc
 1O4OEaUOlT8sZjqy5ZlqsN6HP12dMNzqNuH5iorpZqCTymnvbWzghUUuSQBbdLfvHyTz
 biVLL4OnB3WYmlHfc4Lmp8BRhwPyXQolQlCaHCZ7OuoTuVoVG5aH5wlTxuttZPv/x9CI
 ICYQR93B+5HOXUAWbDXK+QvpKv9tdetIVyzoSzhoCKYATN+zyKEDrCTM/9D0GIrhtWRr
 Tp6A==
X-Gm-Message-State: AOJu0YyiZM7tFy2DnauFnPl68ADNJT3wtFKkoxsa2UAOTPT7GwttBpRy
 s014e1+RcQPLuiNt1of7qrvxGmTIr2dBKi1MNf3gZA==
X-Google-Smtp-Source: AGHT+IHN3EIlhSqC3r5lBbxPKObOXexO/MIWUO1UJMuEhMVqsUTIYCSP6ju+ArPVyTDQBuh1Xv7niGPO/R/E5vCWbT0=
X-Received: by 2002:a81:6dd5:0:b0:5a8:22b5:399c with SMTP id
 i204-20020a816dd5000000b005a822b5399cmr2372131ywc.24.1697216292719; Fri, 13
 Oct 2023 09:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
 <e704b87c2a636c5a5f11a4d1c693df065c0c2e92.1695817360.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <e704b87c2a636c5a5f11a4d1c693df065c0c2e92.1695817360.git.matthias.schiffer@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Oct 2023 09:57:42 -0700
Message-ID: <CAPnjgZ0gxfvDP7+khfz5bWZaq6be4RXqcRxVkfLZ_1NvU7Cy4w@mail.gmail.com>
Subject: Re: [PATCH 4/5] pinctrl: single: fix compile warnings with PHYS_64BIT
 on 32bit
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

On Wed, 27 Sept 2023 at 06:34, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> pinctrl-single uses fdt_addr_t and phys_addr_t inconsistently, but both
> are wrong to be passed to readb() etc., which expect a pointer or
> pointer-sized integer. Change the driver to use
> dev_read_addr_size_index_ptr(), so we consistently deal with void*
> (except for the sandbox case and single_get_pin_muxing()).
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>
> Tested on x86 sandbox and TI AM62x. No new unit test failures in
> sandbox.
>
>  drivers/pinctrl/pinctrl-single.c | 33 +++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
