Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B454C4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91ABB8772C;
	Thu,  2 Nov 2023 23:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AkYNDeud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F24D087745; Thu,  2 Nov 2023 23:49:18 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBCCA87711
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:49:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5af6c445e9eso17896427b3.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965352; x=1699570152; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/ceuEWl/XLPp6jD2SwJe++hx+RYwxbm5SzhADhcryTc=;
 b=AkYNDeuduSyUSKOXAwLLd1CCyq81DcebMwWFGU0yap7/k0Dg3Vee5D7bG+3wfNMegT
 N8P1U1d7WDUd+8fqZeLlmrI37FKR/J8Cv7jlr459cSoDUOYvoclcNnqp64shRF0va5Q2
 3zpWK+VX+12Fxn5jSYdiwO1XC6BKa57nouPYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965352; x=1699570152;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ceuEWl/XLPp6jD2SwJe++hx+RYwxbm5SzhADhcryTc=;
 b=tdSO56Koe2PisBHZo2axjS12YnYHtg/rTVGEJ2/GS3cgoY+kl8oydYrrIWt9RqEbmn
 hrcQxwlqyrmwjyYtnsjyHGPyG62mwSLazL1+xP6Hi07/CzSgypqqpTCUEXr5R1dyh4eP
 SE21OzYRZLYnfxppZ2H384ramK5Wn70xXKbQizkigCmDOXq0iytcji5JjdpEyDfXCxOV
 Bu0MrF2QuNljUnOb3NzkRjse4jYG3+/nlYk7BZQyLz3jGj7HfVK/gfclYpXa5sRi9F+J
 ntvlKxy1m1cAMIBsQ8ckkTxsPTJyD8VC2yRSkpBnGs/41ftYxNv+7mJu3VPwDwAIyw77
 4tdA==
X-Gm-Message-State: AOJu0YxtOLOsFu/TDMoNDW7fqU3O+yMosX84wx1AKstVYDYlsGEjYw0Z
 sRhZdROsDzBAZVYK2ewANdqZT7zDnkHTipKmKI66GDP87rvL2ZjfDgY=
X-Google-Smtp-Source: AGHT+IF4KS1QL3llCW+hosAKZdXwAkakm0nzCxoct/8RQc2mj/rF4dUS/P/jZVXAP9m5J+Ha39/f6uvDO3dHKaSLE8w=
X-Received: by 2002:a81:98d0:0:b0:59b:c0d7:6766 with SMTP id
 p199-20020a8198d0000000b0059bc0d76766mr1084588ywg.37.1698965352440; Thu, 02
 Nov 2023 15:49:12 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Nov 2023 17:49:07 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ1nA0bOBW4Kk+eFSJS7d=WF3DQBgVWauXTKvjdS_P6Qcg@mail.gmail.com>
References: <CAPnjgZ1nA0bOBW4Kk+eFSJS7d=WF3DQBgVWauXTKvjdS_P6Qcg@mail.gmail.com>
 <20231023080103.3780998-1-n-francis@ti.com>
 <20231023080103.3780998-2-n-francis@ti.com>
Date: Thu, 2 Nov 2023 17:49:07 -0500
X-Google-Sender-Auth: V2tmW-1lQ3d67ZNWCsrEqNHUxYI
Message-ID: <CAPnjgZ2Mfa+UV9U_M3wjYQVB9-OKsC2pZ7nkjQ5oJftK38bR7Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] binman: openssl: x509: ti_secure_rom: Add support
 for bootcore_opts
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, alpernebiyasak@gmail.com, u-boot@lists.denx.de, 
 vigneshr@ti.com, u-kumar1@ti.com, a-nandan@ti.com, 
 Neha Malcom Francis <n-francis@ti.com>
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

On Mon, 23 Oct 2023 at 01:01, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> According to the TRMs of K3 platform of devices, the ROM boot image
> format specifies a "Core Options Field" that provides the capability to
> set the boot core in lockstep when set to 0 or to split mode when set
> to 2. Add support for providing the same from the binman DTS. Also
> modify existing test case for ensuring future coverage.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Link to J721E TRM: https://www.ti.com/lit/zip/spruil1
> Section 4.5.4.1 Boot Info
>
> Changes in v4:
>         - corrected function comments, 0 for lockstep, 2 for split mode
>
> Changes in v3:
>         - updated function comments
>         - removed inconsistency in setting bootcore_opts to 32
>
> Changes in v2:
>         - included TRM link in commit message
>
>  tools/binman/btool/openssl.py           |  6 ++++--
>  tools/binman/entries.rst                |  1 +
>  tools/binman/etype/ti_secure_rom.py     | 11 +++++++++--
>  tools/binman/etype/x509_cert.py         |  3 ++-
>  tools/binman/test/297_ti_secure_rom.dts |  1 +
>  5 files changed, 17 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
