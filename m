Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6197C072A2
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 01:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 414028746E;
	Thu, 16 Nov 2023 02:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d0MMS8af";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6664B8729D; Thu, 16 Nov 2023 02:43:18 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AC5C8744D
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 02:42:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5be6d6c04bfso2819807b3.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 17:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700098967; x=1700703767; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J4QlO8WDCb4p84O98D5hJIQAww6UOmfTepbStKbktV4=;
 b=d0MMS8afqqHbI+IHG+NfUSjVea1y0AaRyZDm84QQQbCK3CWF8pnzx6PnPQC0n33+tU
 RajZMCmDbFC7Ch2FVsqCs771W0o4wgxKo59cHaJWG2JyPOMvHWDr5Fj8osO5dHLmv5d9
 7BWf8JE7hmYDs3XEyPcqfyv1DjWWZbWEld73w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700098967; x=1700703767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J4QlO8WDCb4p84O98D5hJIQAww6UOmfTepbStKbktV4=;
 b=eAJOnXNWZ6pTx7KHbzkYME5HhMx+VpWMAZD4qanypZr4N4mmyAWkeEULcoDYK4LMGP
 JkGN7knZQGvya1fKu4M3dlUj0eHSUFLTAGo/jrc6jZli5HyQpK5eQAWFQq3Q6llEmMzf
 O6oYs2Nr8CqV7tgbqiQEkD32IC1ZP8s8I147Q6Z9t8PijfsGUXCrPf91n/V3pXIF15Gr
 qGhNoqNCFeBBgxleALn6Cxfx+XfSCiCBdi9QMijAZNNtKtz3j1CaWiPLepeuJ430VEc0
 h1HKldkxpf88jIbLOmxH8ismdZ+5j90OOCtj8OQytTiI+aofZ9BTsNB7D+yepYMluPC9
 EYIA==
X-Gm-Message-State: AOJu0YwFYDF0IpoD6RLY7yDY7V2LCgByUFZZ4Q9TAbZHNe1VajTZ2LHZ
 ynEA9B240P1Dwes+PDyy3kOOuLJlYHh9DBvYhnlldQ==
X-Google-Smtp-Source: AGHT+IFEobZhba4sRpDDx/371UeTIrPCeMah5JT9hjWYvxhfGPQEU8pDgp5cctlRaJfC/5vSWwxH7HyrJcKVr64GeLY=
X-Received: by 2002:a25:2487:0:b0:d9c:cc27:cc4a with SMTP id
 k129-20020a252487000000b00d9ccc27cc4amr11302908ybk.32.1700098966726; Wed, 15
 Nov 2023 17:42:46 -0800 (PST)
MIME-Version: 1.0
References: <8b4de31e-4f4e-4e21-ab33-2ca64b745b54@gmx.de>
In-Reply-To: <8b4de31e-4f4e-4e21-ab33-2ca64b745b54@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 18:42:26 -0700
Message-ID: <CAPnjgZ09VDbJ3tH68QkyYJ4EdgEmaEqJ1jiWHj4y_o31f8v5YA@mail.gmail.com>
Subject: Re: Bug in distro_efi_boot()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Wed, 15 Nov 2023 at 17:54, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Hello Simon,
>
> In function distro_efi_boot() the bootefi command is called. The second
> argument should only be passed if a device-tree has actually been
> loaded. But this is not what the code does:
>
> For network boot methods the value of $fdt_addr_r is passed as second
> parameter though possibly no file has been loaded there. We should not
> pass a second parameter to bootefi in this case if no device-tree was
> loaded. The bootefi command will fall back to the U-Boot device-tree in
> this case.
>
> For other boot methods gd->fdt_blob is passed as second parameter. We
> should not pass a second parameter in this case either.

OK, thanks for the bug report. Can you send a patch?

Regards,
Simon
