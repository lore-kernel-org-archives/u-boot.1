Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125E2C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 336DA8363B;
	Mon, 26 May 2025 12:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KHhPYHsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AB1582DFD; Mon, 26 May 2025 12:16:10 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD5682B19
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ad1d1f57a01so426373866b.2
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254568; x=1748859368; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ilX4LaC6+vpUqtC2m8IIBGjBDO4YHosRQhujRo25IYE=;
 b=KHhPYHsjuzjCdEVOfMTs+AslpWjX0xI3R57waIkPFbJgu/GxDRexhNW6yPIYtOjXyq
 9AAAS7xczRD+y7z5am8BKwssN9BshZhJYLgY0ayB9ZvzGtxiO2nt1zezQTOJm1jdQ0cW
 KIMPUXnxQjqXZB7JyJqC7MYyCoQxz05m2H4RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254568; x=1748859368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ilX4LaC6+vpUqtC2m8IIBGjBDO4YHosRQhujRo25IYE=;
 b=I7yT2wxBdC5cOrjzd+qEjrvOBE7GmwiC8cLM/SnGbPE+fj6WwTkPHmPHKFLFdXKi63
 vNZKcaqcNYd54hv26GtZmSPfmofgIE5SNsWBS973/UNfhtxMkO2aNperRQCD5CCV05dy
 Ap2a3fwsZXM02TeHwg1rzgih63Xe/tgPlz8zs/Wke/B35j3ZkiaM9JAX7aEI/B16C2XZ
 /09mUBTtIimpT41+RzB9X051RrwCA1lO2W+TbTotl7GPJ/IYuNztARdevIZ9e4gv/bXN
 LH/TIw0HisG5rg7yY/thzPStub32/QPs9H3CEWmz/VvYlRYZIgv9qSSLXy5ZC9nfiKdu
 MhyQ==
X-Gm-Message-State: AOJu0YySNZktzwUiKR3TkNrktVikjyU9b6qNJy0FdjhDh7aKgsFCs3Fk
 Te1f4joDf/RhQqFROPgWt7nqj3WCDt9didHIjegg+2TMWm5ZU3B+xagISMhwHw/Ob38NBtvRh97
 rU8pzG3JhV4LI9DkiWm8szDlQaIsBgnoiFNej+DdK
X-Gm-Gg: ASbGnctEh7/rD43Tv2yFr0q6bA7UNtzFsWx6Rf8qmf91XmjaUpkv/RtVZA5bPWK8/5y
 2MiccRz9ZHqnD6HZZf3UajoTIxAlbPc/TFY3sIBoIjbtcBYHUIHb/iDGZmg8wJ4k6Icyfzc7Rdi
 3UIakOCQmLeQV2PQd1lMWDW/Kn2dY+kRk=
X-Google-Smtp-Source: AGHT+IFcTpdMRF5X43pbB3Z+VNgeRPmVLHsxGHR4rmjgMsn1vCJEqmCLYUFlix88SjLKap/ePgMj7Dn2w4k51ianqUo=
X-Received: by 2002:a17:907:1c0e:b0:ad8:8529:4f86 with SMTP id
 a640c23a62f3a-ad88529566cmr21828866b.58.1748254568148; Mon, 26 May 2025
 03:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250516081839.28587-1-adriano.cordova@canonical.com>
 <20250516081839.28587-9-adriano.cordova@canonical.com>
In-Reply-To: <20250516081839.28587-9-adriano.cordova@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 May 2025 11:15:56 +0100
X-Gm-Features: AX0GCFuER7NdoNLE0GHAvyZbo7eB_oeFlX4YVe0R_YF9ifofTfVCgVBI3FsJ-PM
Message-ID: <CAFLszTj=GuFw=0qjj87Tsgdujv-mda4nrPEjzMW0S9_TgiNzsQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] efi_loader: Add netdump efi app
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com, 
 Adriano Cordova <adriano.cordova@canonical.com>
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

Hi Adriano,

On Fri, 16 May 2025 at 09:17, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add a netdump EFI app to test the U-Boot EFI network
> stack.
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>  lib/efi_loader/Makefile  |   1 +
>  lib/efi_loader/netdump.c | 851 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 852 insertions(+)
>  create mode 100644 lib/efi_loader/netdump.c
>

We have a sandbox network driver, so it should be possible to test the
required features more directly, perhaps in addition to this. Or do
such tests already exist?

Is there a common file you can use for utility functions rather than
repeating them in each .c file?

Regards,
Simon
