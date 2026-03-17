Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D222F33806
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 07:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFB378407E;
	Tue, 17 Mar 2026 08:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JToxuZ4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B36B58407F; Tue, 17 Mar 2026 08:04:27 +0100 (CET)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 198AD84067
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 08:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64ad79dfb7cso5661607d50.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 00:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773731063; cv=none;
 d=google.com; s=arc-20240605;
 b=ONBERl2zMghtaeKmX7CmxNmLMXwdvqkfxifd4Xub204OkOoYwzIyCYQdaVtfQgPZod
 T0mt/NAcn9mw6wkFmGvZ3v7i0OiEBe9qMg5mPcK+VWij0gqLYxgU7/av4RQtypVCb2ll
 wJsF1RxQkITv6nbcshLsUiM99AQMLBuhDar9uzxcnOjVS6slj2XKzobnwbgfuOaQeCd4
 oZlzoKBrBvLRlQU92arLIAgxMu9juPELdZVrPyDqvUplILrweG1TUhJ3W1ZBDDIm//Gv
 fF0gDLhTPdul6wx2jUL1g2UIGqoPRxhaFaKnbOrCD1Edtgezk5ICTxzZa4jWbBey/7IB
 HgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xu3+hXrISfZqnUpcpFxgyjJgJ+pWS3Hl/Lqq/Hvc9/g=;
 fh=FPXXfZj52/XCoNyVSjKO272r70uqlMEKRFVdv8ufLoM=;
 b=e9ylbdM8OjOdKBe87fmUBz34jMyD7fa+VoxzKhKjxj48rWvNVj6mFzMa//KV8jHq8F
 6Mkq0aNuwie1KXKxlL9EQEcmOMZ2bh3Z0fu6vSRvBrvbraXcaq4b/UNR0swyX373DSq0
 PUnCzcFg66Xhv5HtOnGDF90l1vNW4NvXwbXW+fikTePwRmhb2GEEytV/TjW20I3lJzHy
 RT1VdcX/CJKw4coInOFb/O6qXOkjCGRz0BbO/heIOE8M0EUeEo9W6rtUnCuwEl0a+ACz
 boxruEvrzGwavXAuzRbKdwlVgjYqoq2ZFxLLPaovBRvDTcBtF0SFUuEQHgOj3m/n04JW
 Lggw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773731063; x=1774335863; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xu3+hXrISfZqnUpcpFxgyjJgJ+pWS3Hl/Lqq/Hvc9/g=;
 b=JToxuZ4pRqYXnIRg1210lmoZ55qpwBboE/kk8KZihFmq4r3rqhAMbKzwRusWDZHFaK
 5sdTLnP5w4h0CiK/z6NEGavpQ41+rRCWU0UmZ7XF7S+p7muT/XDRthOavKlhZw47Srpc
 Yh64XyIu9Su9JMWwJAyYJ+AZkpMZeXMAaRXwPXmgnwFCJf0lLnERvJoqUlgZlGnNfUB3
 bpBmyDu46Nx9lHMpYtHh/5Nav48cBmzpkYuhkQRgBeavNYLzzu6ZMsDOQtswmPGfsLvO
 TrL9EF0QptiCvxqmS4VO/LHZ3JWGNnDpBIW1Gw0x6awTZGY/AYB/e0bxZ6plD4rALJWn
 q5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773731063; x=1774335863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xu3+hXrISfZqnUpcpFxgyjJgJ+pWS3Hl/Lqq/Hvc9/g=;
 b=JMyXsEeqCYYjo6XdR/CKwMRT7w+LaiG4O6IDoyZTRNlEX9sIa1i5brNgR1f+S41BSt
 N6MJDx6UmHjRW0dBvsWs89563m1Idxuoxki8zFkLsFIh2gzf5Lyyz6F+QUutzqYCyrua
 y8kUvYiGpwUwMvS/qolX6qt8jTqLn1CPLGPr0UlKkFk0MtvzkaWdZmCbM9zLGQcKCou1
 yEaJzZtKp/1L4iKSqalijNaK244ePkw43nRNllPdZctXcGICqUvabjh02TxypS8hudaU
 jFj+OUkvbflwXNP1RHKywewf8IpaYU/RmI1m5ZHOPwRvTJjXWk+W14QeWRup8sr6b9mI
 kLMw==
X-Gm-Message-State: AOJu0Ywxjx9irXJBKsseoIu+XzVLX76RKneO+cm9plb56QRvsfigFPa6
 snKTRNoCBugV1e7kt06MbhoLNvIQ1Lluc4s/JCdhFJLwzd1ZdTVGveTLudbvRBpC0YdXGF01L4E
 90Bu1JDryvnQgyvlGg5xeoYAEX0OQcUvh0Yd0U98HBA==
X-Gm-Gg: ATEYQzxKip78Wv9ddwJqvFmTu2E4WRLdxv4OCd8ytfXK7ClYVUqUXDgWhfgbN5WguSn
 WZGCYxl8lFHac0oz5cFilzu6zWcH6tasWqJiu1VFN8ukuxuxnUeUgpoqczsXFhHXXoBIKVCdxpV
 /GZEmlsjK7riWe0GSFklbBNnjOruUId/5liweQYbbDAxjrXoj2jnqjf3DLqUdQ92Ft7NoyNfpxR
 AN3SHLzzoz+/N2Qb0SDxUdJ7Gg0qOXpM/H4rxsKi9BV+lKQe1SSub76HYL3AF+GvHQX7Ful4ovA
 90tFJcjJPFSK73n0IUh71jP3bdqEAks83Z4u23NB+1Kkq6+KE9He6tRblNvUOGWBkfW3PhtPO2l
 MfCM/5T/O+79vWOVJwE8psZ7Cg/354JuwFX4NOuEgvgTECjPtKa2h0igYIpd78Sg/S3pRirK+Ck
 NZKU0KnL7j1ZsC7er6BvNZX1cr1VVhVs/HddXntvFLgWsdzg4Wl1fq/OOMQ8evgymqzCmdjan1n
 olSMwN1AMwHXFq3yierncyIDmxcvKtAOkBaDqFjrh8xUo84UsR4U7c3Qz7FGrExh1Bl8Keo3sB8
 MyppELHlsjdvNPi5O2M/BTt3gs5snUox+CAA4LTpj6KO
X-Received: by 2002:a53:e847:0:b0:640:caa5:57be with SMTP id
 956f58d0204a3-64e62f6f559mr12108161d50.28.1773731062851; Tue, 17 Mar 2026
 00:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260317012449.4162666-1-trini@konsulko.com>
In-Reply-To: <20260317012449.4162666-1-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Mar 2026 09:03:47 +0200
X-Gm-Features: AaiRm524qdQaEBvxOVwuIAC3LeP1Jm08lbJmjK07zS4gDvSFvycoQcYXQVIqg0c
Message-ID: <CAC_iWj+WHh14nTdYu2BUTqvSwrtHiJBJVncArPwrBqWb6kXnTA@mail.gmail.com>
Subject: Re: [PATCH] EFI Loader: Correct dependencies for EFI_HTTP_BOOT
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Tom,

On Tue, 17 Mar 2026 at 03:24, Tom Rini <trini@konsulko.com> wrote:
>
> As exposed by "make randconfig", we have an issue with the dependencies
> for EFI_HTTP_BOOT. As this is implemeneted by running commands (as seen
> by what it selects) it must depend on CMDLINE as well.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

In theory, you can configure UEFI with a set of prebuilt boot options.
If one of them is http(s) the device will boot even if CMDLINE is not
selected. I am not against this patch, but we will remove the
possibility to build a firmware without cmdline that just boots to
whatever is was preconfigured

Cheers
/Ilias
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/efi_loader/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index b5f81e0ff530..a9b2f813e1d5 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -600,6 +600,7 @@ config EFI_BOOTMGR
>  config EFI_HTTP_BOOT
>         bool "EFI HTTP Boot support"
>         depends on NET || NET_LWIP
> +       depends on CMDLINE
>         select CMD_NET
>         select CMD_DHCP
>         select CMD_DNS
> --
> 2.43.0
>
