Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FEAC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D11F87E5C;
	Mon, 18 Dec 2023 16:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HABRrgmo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96E0A87E0A; Mon, 18 Dec 2023 16:02:46 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A5FD87E3B
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5cece20f006so26392207b3.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911753; x=1703516553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g7MOGvU6kiCwTp5ywOjB0xeytpLc42/7HC+dLN/LVSg=;
 b=HABRrgmoSwg77g4dFkaGGGit6DyPiGzqj+6dXxNR1CwUYESp6VT24SlM2T8zNEJuVl
 Xk294tNXoKZFBBX/oV++OTW7S8gB38mVzuZybfbN4H0wdn8iIo+X/OWL8bQxz2rrdXzj
 oQC5TqdPT+lEsJnqK7/zGYQmaRQnS7Ko2ohJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911753; x=1703516553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g7MOGvU6kiCwTp5ywOjB0xeytpLc42/7HC+dLN/LVSg=;
 b=GkXKc8oBFH2E3ZbODxsfSzj14860RA8fxqgULfYjeTDTh2FrBj6docFwG+FuQD6+l9
 EVw9MprucILZHP5e47RbdqXbxMqwqwsXG4p6L39Er90L8oUiICNnRbYVy46GuWAifDbX
 9+/OIezCYqVZuMRbiCxJU64fP0gGomaua8KRS3RdexWwyFglmE+9bLQqz6/ZC2czo+VX
 GMvyM7EAdIRAdlBlZAqvDaW517Jpw5n6tw5lc3ppywBO2/HLL+/d3SIjWuS47hQf5W/O
 xuaJ3hfgyinSxC7HH93Z/Z89h6/g/audDC+hvMBGeI84UErcg1SkGXB6CnPkjOsC6RyT
 zwRQ==
X-Gm-Message-State: AOJu0YwSgLorKUh80A7fo/c4ZX5lc82Vg8dw0If8Ssm6dTZ4UNIzDd1t
 yST0YrdQ7qJDda0dgKQLjIaYhblIy9G5nGUWr+VPQw==
X-Google-Smtp-Source: AGHT+IE1owjiJbZ0gZ6BDT/1NuV59KILNw6+1dJg2C8u9QcdYgTBnYXv0iH+tQWiw0CWE9sbdWlh03iaXtceJwnjuKw=
X-Received: by 2002:a0d:cb52:0:b0:5e7:5246:8f7b with SMTP id
 n79-20020a0dcb52000000b005e752468f7bmr280347ywd.79.1702911752804; Mon, 18 Dec
 2023 07:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-3-takahiro.akashi@linaro.org>
In-Reply-To: <20231218023842.281336-3-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:41 -0700
Message-ID: <CAPnjgZ12OPrTcnMU6CVqB8dOFoZZMJVmqVvfPm09=idf_W9D4g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: trini@konsulko.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
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

On Sun, 17 Dec 2023 at 19:39, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> At this point, EFI boot manager interfaces is fully independent from
> bootefi command. So just rename the configuration parameter.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  boot/Makefile           | 2 +-
>  cmd/Kconfig             | 4 ++--
>  cmd/efidebug.c          | 4 ++--
>  lib/efi_loader/Kconfig  | 2 +-
>  lib/efi_loader/Makefile | 2 +-
>  test/boot/bootflow.c    | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
