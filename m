Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC225CF9C59
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F42D88CED;
	Fri, 20 Sep 2024 18:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n4qv+z0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D7288D2C; Fri, 20 Sep 2024 18:01:49 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6798788C7B
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6c34dd6c21aso13564496d6.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848099; x=1727452899; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bJ2tXQcJMUuUeSv2hljo8dh6K2vYnOK8yBfUOhthF5w=;
 b=n4qv+z0rCM77D9x7+axsF99r7phs6C9YobgoH/plSJsf3wmBcKZc2Z2xIzHTKfG3EZ
 sVoUnmxzhNqGYT2p26dQ88pYf5Oj0b+dhznycahldN6NuXHdewm4A0QJYF85K6RzAN/9
 KNcWmt6wHa7/xdmqtLTOT9h1jYOuJxkTTtwkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848099; x=1727452899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bJ2tXQcJMUuUeSv2hljo8dh6K2vYnOK8yBfUOhthF5w=;
 b=GI4bbDhDicjYvZpoS4y8UVpnUeOsyTw+XVR32MFcoIIh5IILczwtOX4YBQ7R87jqqt
 dZjTmnQo+8bWxMe8K3ORJD+n5fVunmKaVpnNz9XNtdjvmbICgFe64Y28LdvJSGyvnFZP
 lVmUP+3+QFIyos9k0NmPvp6ibfD+r9gB++7sJnqAtEZLbFdF2qTaOb83E8h6X/AAPTrv
 9AkeFJyTNH8aDLenkJf5msSSEIxN8M63MzyCZwexTshKCQ+e3Uf1podjZW/PCCs61uJE
 t+hecDETh++tR5FO29vOUWfNfSTXNzKcC8sh4xqmeur4vWH81KKTdH4tzse1B5fWN5dk
 biYA==
X-Gm-Message-State: AOJu0YznTUo2xao3drpF5GuPffOoPGOcj+82z9O7nMNDvnNC8w8b4p9G
 c0mW8tR8AsihwxMhg5Cfsel8fd5WONcgOB9u2pF+N5zJsQ+5GiSWaHG9Q+XIYMKr5xDD6YtsO3Q
 t8Ot5WdoLyKjvuHr2LehAL52XD0aET3SXTYpPQqetazRrcw1+8Qgl
X-Google-Smtp-Source: AGHT+IFjprHiMONtvhmZttn+mg7PNpmv5DopBvi16p4d93TYd10fQul1T7QtU7tgId1Ii4o5LoItCoFQiG7TJitYCyY=
X-Received: by 2002:a05:6214:460c:b0:6c1:6085:f118 with SMTP id
 6a1803df08f44-6c7bc6a48c3mr54745146d6.5.1726848099279; Fri, 20 Sep 2024
 09:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
 <20240710071612.1717460-5-rasmus.villemoes@prevas.dk>
In-Reply-To: <20240710071612.1717460-5-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:01:29 +0200
Message-ID: <CAFLszThWPMr=10XtKhTLUE_c4zgxoRVSmkVfxmQn6UUFvy+Ebw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] test/py: efi_capsule: rename device tree overlay
 source to .dtso
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Wed, 10 Jul 2024 at 09:18, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> Distinguish more clearly between source files meant for producing .dtb
> from those meant for producing .dtbo.
>
> Note that in the linux tree, all device tree overlay sources have been
> renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
> 81d362732bac). So this is also a step towards staying closer to linux
> with respect to both Kbuild and device tree sources, and eventually
> eliminating all .dts -> .dtbo instances.
>
> This also matches the documentation update done in commit 4fb7e570d6b.
>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  test/py/tests/test_efi_capsule/conftest.py                  | 6 +++---
>  .../py/tests/test_efi_capsule/{version.dts => version.dtso} | 0
>  2 files changed, 3 insertions(+), 3 deletions(-)
>  rename test/py/tests/test_efi_capsule/{version.dts => version.dtso} (100%)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
