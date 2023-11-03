Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11A0C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 19:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F302287438;
	Fri,  3 Nov 2023 20:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T+NrTgkO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D7C48711A; Fri,  3 Nov 2023 20:39:22 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C8FD8711A
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 20:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so4059914a12.2
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 12:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699040350; x=1699645150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rd4/+UqRB6K+xBtDfJOsby58l8dvVcrSrpENckDB/cQ=;
 b=T+NrTgkOHMPTilu8TB2ZpqIzPidw4XR9w0XMvAGgc88C4J/xhEYJ10CiBGkoUbWWtn
 YJWwWAksSUDUi7sxFw3/pkf60Iizn51L4rrYXaW5xNSex63JBLbFL9LYm93qpShLeCOR
 zH+T/9La32NCdA0nq2Vdw9ArDWPUczOSSLCr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699040350; x=1699645150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rd4/+UqRB6K+xBtDfJOsby58l8dvVcrSrpENckDB/cQ=;
 b=TXi7DiJQ2jlmeKXdx6HCtNVUtWUVwbYDx9kLj2Eer7iYj3lMuEd6NtNcG6u2iLQwbd
 xEpQVu2muIWjucYsbdl6XNzXnhRCybx/IjxkkjZ6wS1cC2zfD7vNk+5bkFWJ98tA3j+b
 Dij0+SuBSIECJwjgsoek7xNT/7Fdcr09gJbzC19c/4JFWk6ygq3Kgmmi/IXEIBi4wU7i
 9gdkK7L+8jZdQ7jlMMrzuCqQrrFd1+ogbYU66NYEw19RAOvpbuMxQTUaFW4T1CxagBCU
 +QrJpSStV8W0La9jyPw2N38ZxHTKWQKlipUeh6Y4XFnwo4jfcC6pnsX3iCugD/oVf4kE
 vW1A==
X-Gm-Message-State: AOJu0Yw9/LcxnP26PkashLYx9HHVFYhw2GTfgcO/IqCyScYvZ4d5Y1ey
 9cZTXrx+4OGhJYTB+04aAiZ17QDEAICm1u970o6SaSvvJ438UVxLP/M=
X-Google-Smtp-Source: AGHT+IEaizdzLJlU+FRpPKD/TvLI/wki9Jl6v8A8q3ns44veST3u07b9xktbIAOEhnN0DTb0K/h83NRaMQ5A1WKq9v8=
X-Received: by 2002:a50:d482:0:b0:543:7706:af82 with SMTP id
 s2-20020a50d482000000b005437706af82mr9161873edi.32.1699040350061; Fri, 03 Nov
 2023 12:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231103183844.2308934-1-seanedmond@linux.microsoft.com>
 <20231103183844.2308934-5-seanedmond@linux.microsoft.com>
In-Reply-To: <20231103183844.2308934-5-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Nov 2023 13:38:57 -0600
Message-ID: <CAPnjgZ0-o61kX7yanfi8TQKJj+sjBANUA13hjGSzxWN6EZHZZQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dm: core: Modify default for OFNODE_MULTI_TREE
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, 
 ilias.apalodimas@linaro.org, trini@konsulko.com
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

On Fri, 3 Nov 2023 at 12:38, <seanedmond@linux.microsoft.com> wrote:
>
> From: Sean Edmond <seanedmond@microsoft.com>
>
> There is a preference to use the "ofnode" API for FDT fixups
> moving forward.  The FDT fixup will usually be for the kernel FDT.  To
> fixup the kernel FDT with the ofnode API, it's required to set the
> OFNODE_MULTI_TREE option.
>
> To ensure existing users of kaslr fdt fixup are not impacted, Let's modify
> the default value for OFNODE_MULTI_TREE to ensure it's always set if
> !OF_LIVE.  This will cause a 1007 byte increase in the code size.
>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  drivers/core/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
