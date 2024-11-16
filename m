Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7016D68BDA
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 02:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4004F891B4;
	Sat, 16 Nov 2024 03:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OvtzaYw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BFA689688; Sat, 16 Nov 2024 03:45:44 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DD82891B4
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 03:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cb6ca2a776so4024324a12.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 18:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731725141; x=1732329941; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SN53XNOmqFU8PHbbbpaY9lFHnqtQv96dJ0+zpur0jbk=;
 b=OvtzaYw24ar16xnSrURL4n1cDo1hfzTpADweb3og5/eXFirTczkUpVkdeI2GrWkpUX
 3FR7NIYpc2eyEVdwDJ913CkWVyNAXDLx/te1AmcgRDc95veXJYKSs/XRmEkwk0pOdDZ5
 K49l/XCvmSnn16F56qQYtZOMT6o8VwNTCGQPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731725141; x=1732329941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SN53XNOmqFU8PHbbbpaY9lFHnqtQv96dJ0+zpur0jbk=;
 b=ne0M5VktOAmPQjq6kjzcFtZcBuArWobZui4szliGPe9kVcEFwDT7JB9D+vGCbKVvto
 ECATNKVZK0xlRmSUX28cbUfKSv+y3qKwe7+3s9EncX8GFFzHkd9z34j458BZf+HPeI9e
 QiL6GpJaOHr5HBHe4FxnOQXSxOc9bptNavT9XnajQX5SNM6xf0tcFn/Y8w6m5dOOu5xx
 2TIOfs1rBfzij9HXLX2BzlseYlnsUBvFJgokMfwyn0iCSmbmS2lqllU5P9aGkSUJpQg7
 UjOBJUyiBc36Y7NW5lo2CX2nvp0nezP+YYCB80f2lCjW6Quz2pKtUOY/v0iLoVeAbkVB
 0arw==
X-Gm-Message-State: AOJu0Yx/jfdnAPZ2YY/N0U3vfPgg9lrFTZabwGiA6QsNqdbDTl5hk4GU
 akv4gtlk0JAg9XTCwa0x5t5wZ/M07QZlQ7jNQti62nYZTU5G222NfSLuPqz148TBIMDK5wPW9R3
 3alMb1aEr+e7XRxUAtBFWxwcf84WG8Q1OLRIN
X-Google-Smtp-Source: AGHT+IHsycXPeRL6KkALy9Ggeu8MxIKwdwRoUBgdmrXnoWibQOD1L6xo31mmpbvOhYZphgkN3dkl5quFfWA+Q4Khcac=
X-Received: by 2002:a17:907:3f15:b0:a99:f92a:7a66 with SMTP id
 a640c23a62f3a-aa48344e752mr417352066b.30.1731725141363; Fri, 15 Nov 2024
 18:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20241115165400.2486914-1-trini@konsulko.com>
 <20241115165400.2486914-3-trini@konsulko.com>
In-Reply-To: <20241115165400.2486914-3-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 19:45:28 -0700
Message-ID: <CAFLszTiyARoPDhdbzEZj4BCgCFxg6upN7U=4V0wG_PQ_O_BBdw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm: sunxi: Use "imply" for USB without further guards
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
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

On Fri, 15 Nov 2024 at 09:54, Tom Rini <trini@konsulko.com> wrote:
>
> Given that ARCH_SUNXI already implies that USB_GADGET should be enable,
> we should also imply USB being enabled.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Is this a tiny bit of a cheat to avoid patch 1/8 of Simon's bootstd
> series? Yes, a little. But it's also correct I believe.
>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

(from my side)
