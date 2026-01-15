Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA470D3CCB7
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 07:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 852CF80325;
	Thu, 15 Jan 2026 08:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MttTa7sD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1187835B3; Thu, 15 Jan 2026 08:25:09 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B55380077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 08:25:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-79276cef7beso5145447b3.2
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 23:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768461906; x=1769066706; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AhzECc8Y/FpAiKkXvt8AkwouxAOkWRcMkV08bdOkLOU=;
 b=MttTa7sDlnPKf9JwcnDlWq+D/D0VpXDTLpRGYhrh35Xc96So92Z60rZP4AmN/HUM4G
 WJS4RRl2hVPlzZ3KA/8mS4bMzp0YVZmqqiVY5+ZVf5syOqbRe0R68j0nXQQJ7wNtv1/0
 EEWC5PC8e3lxDlTV5qR/yGTCv7Ow7XP2RXTaf5nq1cxXer8MH41UK7OYLqEqxCA31iLw
 EUZGElWpdLhpwfPKC1K1+CGZ/KW8H2DmKZQLdOpRYmfyWNdg7Q1SNNFf29hCI58rvLdK
 2q3H+8rEi/lCz9dwgKHPQswXgMu+LNA4MW8OcYGjnArOGfY89xQZRjYbnJxcRbS0VM9T
 bR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768461906; x=1769066706;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhzECc8Y/FpAiKkXvt8AkwouxAOkWRcMkV08bdOkLOU=;
 b=tNO/YiTB1R/BXIPgTcD3EFBKWgermBiKD3Tt3E7G2IKOWEsj2HXTqaX59ECgvgitRW
 fs3pb4zxcdQQYMySoWyMpiTTofHJ+KJAfnMQA33BUHxlE2prPq+5tz9yMJdy7y4TB6Kn
 hhOla2pIXL11MZ05WSYQcMnszzPtwpA+u1ciSiC7qMZ3PVKFt5OZyzq85RDvJPYf2Kzs
 HJois9jk8RIMrCBXWavMmVy2THrzUs8phANjZNtHSeb8IrysZphOU53bADsaG3ztc4O9
 y+TVwLJQjvffFT/eoHAXkIO5BXhjcygrqkXWUKL9XIpbRqVbyeK72t1ZJZEg8fBs3PdQ
 h2og==
X-Gm-Message-State: AOJu0YxNmP9NmsfgS2kc5OmcndOp1n0jC6Qc5dh1J0tFyUKb2oLLdp6/
 QLiGGafcWO1imERW4t/NVjFkdiUTxPeSAWhNfiuGDgOdMgJRdOxif8wSNAZuVlg/oTOv4JMRLvl
 GM+cm7pfgOXXIeDrocpeF7wB/aImnsaUsKC4/B0Uy8a5x4+g7az3ureA=
X-Gm-Gg: AY/fxX7LLbILdvdLpr9Rx9qPsSX7xPs85a7HuGo/OcAIlvgXb5C1F4EAhmd71nv2DNF
 YUMHwlbyfrQxd7qx9dtPpwj6oDpVflL2zfQcmFbzf2zNKSfhc23p6Y46+H1EBYN7hHDKshSzSOD
 2Wz/1OorKV2fND21oaDDSZ9At36dobKC3Zsta8CkwqnOokfUvBJaD+Gcq1R1eRQZs0AbL0Hbzux
 A+57+Tu0C32i/Ykdmga9vXzhjvMMSvX1WjJFW9ng5jH897PJ7lkC6e48GgANBIqurymBrSf84W/
 PqWCvChkHpYIysIR9m7PVWFKPFZZTJYvLArANIgBKL4M9B3bAXihhdB2cQdoX+44IIsK0j4D76l
 IREBLwudW/OnsmT9ZGffO8ODHMMy+spbb0ckyTkXEQeoCl+Ftr/8C3pin2rVmyiUPfpQs6FUh5+
 xKx8EipvqZjWcf6YQfPixdgrKh/c+du8E7uzcKe5SgZErB+i49NjdB2vtD9s2wAppKhjXJMIlrZ
 8P9slJ2nmbh/KhtlKRCIZ9pmR1dYdcrCI73fP9A3HPistfVypSmCbcwH8UD1Xefv6ZvBBjvdbOp
 MoiTc1FwCgsxx4ZO2IgW1yenPMNftWBj
X-Received: by 2002:a05:690e:1407:b0:63f:b444:da92 with SMTP id
 956f58d0204a3-64903b11c5amr3355548d50.31.1768461906009; Wed, 14 Jan 2026
 23:25:06 -0800 (PST)
MIME-Version: 1.0
References: <20260106141405.82637-1-hs@nabladev.com>
 <20260106141405.82637-2-hs@nabladev.com>
In-Reply-To: <20260106141405.82637-2-hs@nabladev.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 15 Jan 2026 09:24:29 +0200
X-Gm-Features: AZwV_QiBHBm_O61IhV3C8V5-1MBYF_RjXs_Ic2-YyzYI9TPdVITvYAkvMolyss0
Message-ID: <CAC_iWjL74ayBaoxnka1KZMQOJfAFWeLghSCasz41i56-AA4C-A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] lib: sm3: fix coverity error
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

On Tue, 6 Jan 2026 at 16:14, Heiko Schocher <hs@nabladev.com> wrote:
>
> Coverity scan reported:
>
> CID 449815:         Memory - illegal accesses  (OVERRUN)
> Overrunning array of 64 bytes at byte offset 64 by dereferencing pointer
> "sctx->buffer + partial". [Note: The source code implementation of the
> function has been overridden by a builtin model.]
>
> In line: 252
>    memset(sctx->buffer + partial, 0, SM3_BLOCK_SIZE - partial);
>
> The respective line should be:
>
> memset(sctx->buffer + partial, 0, SM3_BLOCK_SIZE - partial - 1);
>
> as partial gets incremented by one before.
>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
>  lib/sm3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/sm3.c b/lib/sm3.c
> index 2a4e825481d..05880099703 100644
> --- a/lib/sm3.c
> +++ b/lib/sm3.c
> @@ -249,7 +249,7 @@ void sm3_final(struct sm3_context *sctx, uint8_t output[SM3_DIGEST_SIZE])
>
>         sctx->buffer[partial++] = 0x80;
>         if (partial > bit_offset) {
> -               memset(sctx->buffer + partial, 0, SM3_BLOCK_SIZE - partial);
> +               memset(sctx->buffer + partial, 0, SM3_BLOCK_SIZE - partial - 1);
>                 partial = 0;
>
>                 sm3_block(sctx, sctx->buffer, 1, W);
> --
> 2.20.1
>
