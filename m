Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4137CC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A888287E68;
	Mon, 18 Dec 2023 16:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JYJQqDVW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C19B587E6B; Mon, 18 Dec 2023 16:02:58 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A51A487E38
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5e32af77f15so25202137b3.2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911775; x=1703516575; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=allODNl3I9oH9ENbsvWSp/Frrm+inwRxCOSMqYewisE=;
 b=JYJQqDVWl+3QCzX42gPGgpgZcPmnn/vR03zV8m7/+2o4b1u29x6Sxn/kmPH8+HJnrs
 qnAtqaEy7jtUudaeooJXgIEVoba5jbQd4m1sKMG2aqgaKY8+nSs3QNJoc4Qhd7XwjnaB
 FRfdMXJxl0qeDWf/rv3TTaWbJNIz7wsL3veqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911775; x=1703516575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=allODNl3I9oH9ENbsvWSp/Frrm+inwRxCOSMqYewisE=;
 b=psBIQeaKamJeQMJSwi3WB68fhjC6iwxr/mC3W/VweHqi56gJR9TjsSY2EWe+TWz1tX
 Q0bIt+ndaf83zswRXTpEY0cQpdfGj/UEu+ljIUOKHbqQMt6dCAF0VAls3iXlhwotlrHr
 2QyuWP8Zfq0M63Ag/p5GnwZAYIDDzrcnlURFw5OLWn7Dt6hK/VwmXtuKZKUhm52CJw3v
 mTMt6eaVAhz3R64Rn1Gl2dmEksbwCNxgRmoiWRhWFE06337F0QPWfKZn9bnrKMMeGIz5
 tm8+mdctKPwtItCRmISq0JBZ02IJaierp6U4LAfTky/kTOQMIi14oF7IeJX8gdlN5Owc
 nR9Q==
X-Gm-Message-State: AOJu0YzrQ+sZHMxfCrNk4v9AbJjNYo10w6zgSpDi5ujzgHxH0PhqCNFp
 Oc8hPPlbUUZFwedLlyB2ClpXxAwmTJpl1CEUAKxH0A==
X-Google-Smtp-Source: AGHT+IFzwkEjQFGsVE9Mtig9zT6Dlru53NhtP0cPsHd28jCN2FX85nvrem0l4L8Ek33h8nyZHfiPLqqGTVyMKi+ZUcQ=
X-Received: by 2002:a0d:cc16:0:b0:5e2:6e50:e33c with SMTP id
 o22-20020a0dcc16000000b005e26e50e33cmr8683139ywd.9.1702911775258; Mon, 18 Dec
 2023 07:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-2-takahiro.akashi@linaro.org>
In-Reply-To: <20231218023842.281336-2-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:51 -0700
Message-ID: <CAPnjgZ3SyOqUWYJSRH878Z=J=_ez6pO59AneZ8P-FOo4sjc_OA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] efi_loader: split unrelated code from efi_bootmgr.c
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

Hi AKASHI,

On Sun, 17 Dec 2023 at 19:39, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Some code moved from cmd/bootefi.c is actually necessary only for "bootefi
> <addr>" command (starting an image manually loaded by a user using U-Boot
> load commands or other methods (like JTAG debugger).
>
> The code will never been opted out as unused code by a compiler which
> doesn't know how EFI boot manager is implemented. So introduce a new
> configuration, CONFIG_EFI_BINARY_EXEC, to enforce theem opted out
> explicitly.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  boot/Kconfig                     |   4 +-
>  cmd/Kconfig                      |   6 +-
>  include/efi_loader.h             |  28 +-
>  lib/efi_loader/Kconfig           |   9 +
>  lib/efi_loader/efi_bootmgr.c     | 493 ------------------------------
>  lib/efi_loader/efi_device_path.c |   3 +-
>  lib/efi_loader/efi_helper.c      | 499 ++++++++++++++++++++++++++++++-
>  7 files changed, 529 insertions(+), 513 deletions(-)

'helper' seems a bit vague to me. How about efi_boot.c ?

REgards,
Simon
