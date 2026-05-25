Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78907CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05CED84879;
	Mon, 25 May 2026 17:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m+AE0eRr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 065D38488A; Mon, 25 May 2026 17:06:56 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F9C84862
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bcceb394417so1176022966b.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779721613; cv=none;
 d=google.com; s=arc-20240605;
 b=cNLgPTCxtSz8dCYTmOC17mRc5t6rpZHn28AIz+yvDMHWb/R8M2YSUSESca5TYvsm75
 vlEvJpmrGVs/69+VC7PgZjSbBA/ULLx6KX9XhmDYWKqn8x2cGw600SJZbNIemOfrWx5v
 y39IeFiJxjYGpt/I6hxEsjAEAB0gG3po/6mtGdJJcnTpxIuhSlD/1wKwuNpEKxkm3WA0
 o30hIvCjAYmsLT1OeL/Lr4idDhcmFBV1KVx+d1IKTx7gqIPQGXxsxK4FOz5IjyrYdrg9
 8rA6bWLWL8uaitUMroXbDlO0JulLF0vp5fYRkXaJpor2FUWv7PBXc6dFXwu/8rW6hlFc
 xHkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s78XHzZcte3IdZAxtLc4fqpx/7CCc5JAsUo2jM0KKBU=;
 fh=E8i5n10XNmew4pFsbezk1l8PWdZuCHzZSzlRhvS0fOM=;
 b=EQBS0vD48GlbCNdvAr/reCDbdd3HMIxNDT+9CtZz2ME9Odpwb3un7o2Kf7hbvziexe
 HKMiasK3dkRGDS+AC5/6Lg+XnL0hCLtrnDcM5+FjtPg+QkZNlqVmitc9zdalx0xw3Sce
 lPUMXZtKYOCqtRwHHLAwuCXl58tDancnEtd4sczQf8D3MFiCE26+REPnqqeO1LxD9aN7
 M1RXd4lpYgUEn+NlUCXWZYkzeCwINcFgWTC46951udaS4SCp/6srnybyDhRyuvv8GO7N
 3jvWrLUJHEfKgHOo3v6oQGo42N9DVdGGRJRhR2RiuYe2lcDGnTrRTMSf/3PYt1cO38Xt
 OsXg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779721613; x=1780326413; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s78XHzZcte3IdZAxtLc4fqpx/7CCc5JAsUo2jM0KKBU=;
 b=m+AE0eRrI1/+68AN2fqiBw0OzsxyP1TMYRVAFTZmDiotDZgnafEDl8GyfIj/jPsz24
 Q1BQeSLa2N7wye51DQTbdURB0qyvIlqp1D68onusnwixE5JKsav2256bSBVoQxQPa8n5
 XcBTPGyZlpyUZ+F6DpxMSbiXYU+fFokoL0JE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721613; x=1780326413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s78XHzZcte3IdZAxtLc4fqpx/7CCc5JAsUo2jM0KKBU=;
 b=TWOXM6hiTLHNEC/LPBD9fAy3D9j9bSzwD86Ym5a28e1TKqqS72i1I4ixxIwEq8XmL+
 1I8aqwVI0NT/SNE6tRDDaFpfabl6q8RgCy2y8XEXdzLBDZh23poR6oAdLSsLhVNvT8eg
 sttbQB8J4uNELSrsbkhQB/N0AsmdiD0FqdNlMU3JTwmxPN5JePafP0Yk9ancKl3vMxY4
 pV/IHr78lfLlZitB7x9lV5S1mOFpfu1n8z3zcKBxCcTu2fNW7yDSqLTyHmrF8SRMBrsa
 jj6mHmG4CCqAaXwgPSt72eNkpWg9SzBMDGxIjIEHcp0estrNVNcgdF/yuztH008g1bam
 v5FA==
X-Gm-Message-State: AOJu0YyCMVFoBJDDQlUp2NfAeosgeD6cWjknBtx3qV/HIkUNwb60jnsw
 D37vqauDKHIBr+FyXa1RqAgDJuo2eoyf7XVg/DX+SUrTAmvPPT7F26lsQ4cxRV4ekXURd3qu0hh
 W9+U9NZYOcDy03+nUBPNVEQugdz6aqizjSEk+pxv0DuZxoMMwy/0Syg==
X-Gm-Gg: Acq92OH1hfPhNjTfYkwEMidQHmSUD7QqNgIyclfq2g5pKP3wF3/HmQqdkibI2veGiFt
 CLbHfY9MDkbujZzGJ8FygR6xLav3Hr4IdeRo4sjnbGkN67lyccIHQHz9cxlyGC2kobDSqbYznQ3
 P7Wyj+h8+L3OIJW4uIOvTtBYMTTNMRswADB1GLjclrM/lUZ3tp5T6iCW3f1HR7IS+sn22z3NmfM
 MynqWNlmuKDkaX3s8/SFFxSVEpcle2xFWt9KoOTOYtUwhEXMef2i6WZy0B6mIQLvxPGmhwK7n/t
 ckwwrQ==
X-Received: by 2002:a17:907:2678:b0:bd0:7949:a931 with SMTP id
 a640c23a62f3a-bdd2a408de2mr584939966b.27.1779721613523; Mon, 25 May 2026
 08:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260521191401.29310-1-ant.v.moryakov@gmail.com>
 <20260521191401.29310-4-ant.v.moryakov@gmail.com>
In-Reply-To: <20260521191401.29310-4-ant.v.moryakov@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:06:39 -0600
X-Gm-Features: AVHnY4L1LDIADLM-XRbVSvOYZiNviHKAWJ3PNljOk2jA6TpZiObDr3M05i8cDLQ
Message-ID: <CAFLszTiMCV-sdk_hkbikWRQHdvKJA_nNbfeQ-JZaBpduA39T=g@mail.gmail.com>
Subject: Re: [PATCH] x86: zimage: fix NULL pointer dereference in
 build_command_line
To: ant.v.moryakov@gmail.com
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

Hi Anton,

On 2026-05-21T19:14:01, Anton Moryakov <ant.v.moryakov@gmail.com> wrote:
> x86: zimage: fix NULL pointer dereference in build_command_line
>
> Static analysis reported a redundant NULL check at line 68, but the
> real issue is that env_command_line (from env_get('bootargs')) can
> be NULL and is dereferenced unconditionally by strstr() at line 56.
>
> If the 'bootargs' environment variable is not set, env_get() returns
> NULL, causing strstr(NULL, ...) to dereference a null pointer and crash.
>
> Fix: add NULL check before strstr() call:
>   if (env_command_line && !strstr(env_command_line, 'console='))
>
> The existing check at line 68 remains necessary to guard the strcat()
> call and is no longer redundant.
>
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
> I
> arch/x86/lib/zimage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
> @@ -64,7 +64,7 @@ static void build_command_line(char *command_line, int auto_boot)
>       env_command_line =  env_get('bootargs');
>
>       /* set console= argument if we use a serial console */
> -     if (!strstr(env_command_line, 'console=')) {
> +     if (env_command_line && !strstr(env_command_line, 'console=')) {

Please drop the line numbers from the commit message - they shift and
don't seem to match the tree today. Just describe the bug:
env_get('bootargs') can return NULL and strstr() dereferences it
unconditionally.

Subject should use parentheses: build_command_line()

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
