Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAACAC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 204038745E;
	Sat, 16 Dec 2023 19:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TdiJ2GEo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F5A5870DF; Sat, 16 Dec 2023 19:47:42 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DFEA8774D
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5c85e8fdd2dso15597257b3.2
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752459; x=1703357259; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sLZHzf0rSo3OIDPcFO4z4mCmwtTgeV7shO9kg+celLk=;
 b=TdiJ2GEotXDcDnfz39pQ3LmTPOXJNqeqr60NdFHinV/N5vkWvN35/d8nPjnZQdBTAu
 5YlcE18JUGVJATGiqftMa375kjlhMM20cXdR0Q/jyZHZPtOHKoNF+TFX+D77o8yMhuJP
 NbSnOjYmOEtzCBuKzBjE00aIHrAT9IDhruvkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752459; x=1703357259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sLZHzf0rSo3OIDPcFO4z4mCmwtTgeV7shO9kg+celLk=;
 b=N983760dWyFaThgX1hkpoRxt5GFcx1FCqJsSuKspDezCsGWNnwNzEFSKp0IPCQJ9UI
 ntVWdoa/1eHWHXliUIJohyUAWIMRmdJLa5VPoZgIWY/xsBFeFaYHnCDyneiuPWXvKVI+
 2vozXaaGZ7eo2zf09EEqZadJu0y+CwOjq4nY+8HBRi7RucoJOJVRfZ7otaquByV1SKu0
 1MdkrA5v0K8Gnq7L2SYa6bw5vYtzTQOnVLNmAI1liyr1B8b7BxwXZO4u7aTRoPeilVVm
 Qh8Ku0PfBTO4i7rSm5L/nbUBoxpgDFqihVVLqq/HylwsaQRVwIM7SDzlcGjjblDi/U6H
 kIsw==
X-Gm-Message-State: AOJu0YxCRbX6uZXAelpCROrlF34NxYQMtZPi9AAf4xFL1lVB6du35UDD
 yM0xiy9nF64bUaBGnu4IYjfJwcoPitTvK3Oe/ZKHzw==
X-Google-Smtp-Source: AGHT+IHBcv1nnJp4Ul6GVDGFevxZYA+HFARUcIKqTA4LMkF+gHybAa/lhmSiba3y1DFyeFmRCd2h272+R5QBOluUY2I=
X-Received: by 2002:a81:4ac6:0:b0:5d7:1940:dd87 with SMTP id
 x189-20020a814ac6000000b005d71940dd87mr10985825ywa.93.1702752458865; Sat, 16
 Dec 2023 10:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20231214181658.3359902-1-trini@konsulko.com>
 <20231214181658.3359902-4-trini@konsulko.com>
In-Reply-To: <20231214181658.3359902-4-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:45:50 -0700
Message-ID: <CAPnjgZ1b=Qf9m-T35R-6YVwa9Ls6_dudun-7k5q15NZ8HsUC2g@mail.gmail.com>
Subject: Re: [v2 04/16] sandbox: Audit config.h and common.h usage
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Thu, 14 Dec 2023 at 11:17, Tom Rini <trini@konsulko.com> wrote:
>
> Remove and replace common.h and config.h in sandbox when it's not needed
> and add some explicit includes where needed.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - Drop <autoboot.h> from arch/sandbox/cpu/state.c as it's also not
>   needed and leads to unrelated build failures with CMDLINE=n
> ---
>  arch/sandbox/cpu/cache.c         | 1 -
>  arch/sandbox/cpu/cpu.c           | 1 -
>  arch/sandbox/cpu/sdl.c           | 2 +-
>  arch/sandbox/cpu/spl.c           | 1 -
>  arch/sandbox/cpu/start.c         | 2 +-
>  arch/sandbox/cpu/state.c         | 3 +--
>  arch/sandbox/include/asm/io.h    | 2 ++
>  arch/sandbox/include/asm/state.h | 1 -
>  arch/sandbox/lib/bootm.c         | 1 -
>  arch/sandbox/lib/fdt_fixup.c     | 1 -
>  arch/sandbox/lib/interrupts.c    | 1 -
>  arch/sandbox/lib/pci_io.c        | 1 -
>  board/sandbox/sandbox.c          | 2 +-
>  13 files changed, 6 insertions(+), 13 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
