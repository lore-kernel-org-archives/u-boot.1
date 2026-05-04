Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1F7FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6231D845E3;
	Mon,  4 May 2026 14:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B2PR2XzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F3658460C; Mon,  4 May 2026 14:06:19 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 753C280F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ba67b332bbaso571098266b.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777896377; cv=none;
 d=google.com; s=arc-20240605;
 b=Nh9beM+AxwkcRLC9YX59fQs15tO/ZRZrofDu3MJslhdcJ+2qwljiBlRbdbgPfnMlne
 5ptfKngYX5UuAkJRFMezGsXobgXGHjg04qa00LNDHP15BvSyEsIv7K6ocCCiFxTvIrQb
 T2QpBDB71IGKgeUALxLyedj0h0yhaDffvo069ztwtK+1u2TvpglKi+POjJFTU5owcb2B
 6HC1ms62udmSiAZjX7JE8nTKvXHwbPs9Fhlv09KmayFp6N+YQ8YtN1dzpme4tfkA5X5i
 YjtcfL5Z6klifi0jqEtNwpZcy3H7ycWT3/zUrGdzSGGLwsIk2zJmW9L9oDoLPfe2fF02
 KZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jSUX023LhuHKZWiuGhFuVClDy6ZYdrcCYibqDKPyhoo=;
 fh=HUaaCF3pXo4vuMiSwAVilAnegcN7RQHzK4eRcFLb+3Q=;
 b=SShujNr31p/5JpiPu2RtPBF/bgw65HCmOhHPxqFJSPrWOcmsGhaURjcwqO/MC4g0Rm
 +PS5ScUpfM0FDUmMzBQAaxmTPgfuvMpOnC8VKmOgbkRugr5Lw/tF39slisNCxSrr5bb6
 vMf5SCvR0FkL/8cWAzMv2yyoB7v8T2hIvXadGSmrzmnqKU/ThiA1yjTuE6nYhlh/AR3l
 DhBJe0kwm+PzWjf+3ktjMkPhBnfQT37YbZ5hmrWWR+Drt8sVoity66H4m9bTqm/K2I3P
 5ZNIEoqUf8W9O+K0481cM4kknyKCXeQNXnAGM17HgX2NuAV/rJ19+q55sat9MPqiaA2t
 mY/g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777896377; x=1778501177; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jSUX023LhuHKZWiuGhFuVClDy6ZYdrcCYibqDKPyhoo=;
 b=B2PR2XzJR0FvNuq8y7lSGguoVPbeLAzPWgXSwzJDmzGKo8+QbhFCQIuCGRYIK/WmOg
 aN8Wcg6xoGKinfxZQIz3P4FRcqkLGi1PlQTIr67izXTZ3RGPEek2e7pHGXfu3YbhEOQi
 VyL9xFX6Z9uEekZtppe/vo0fFhpiT7DhJjnkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896377; x=1778501177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSUX023LhuHKZWiuGhFuVClDy6ZYdrcCYibqDKPyhoo=;
 b=QMJu3vUG2yxFQ61SjqVn+15NIiykggWYOzaz4XkXKVcJB94VkckkmdWDd6VGv802fa
 JbbL2EjV5YmiW4iV8BoShX/R9G2KHu3bkrMxEtfAhGteeXX5XZHvC/ttkraKApxCIahw
 z84FDrgterhoSlsPSlpyVjYRBBGCjD7WsjrayczACYKFZTX5N0hO1hIX8NCk1BRfbPXw
 GQsPMVy/avGwm/5Dq4hnioBm9Icolf9WRoQWSmRs8QuUZ2JCqagL1dl8FpNHXXVqC5VO
 kdpxn/fb5PcOVgJtTy+pWYhBsYdzPMT+q0vF2m17Ldx2Ij3qfAGftquDB5yIq4wpqFrt
 ocrQ==
X-Gm-Message-State: AOJu0YwQjgsCgMPvu+629K7As14z6o67k5rYOR0KboMU9P09FmaeoQLn
 UHkWg6r3s9WSqKyuCryo2hXEZRKIttyIAyybzMKJD6dOAIZJGjZ9qsGauMGSVSzCtx4cqDtqUKV
 Wcn97zfo+mxElXXBxvijDuu44qvvB5DcZwzzEjumxmSA3rn0uuY4=
X-Gm-Gg: AeBDiev+VLVVli/ZfxovcYv1b9CTO6Wk7lUkp77IKmMlIpyIN8eXa7bNuCUwaDyuLp5
 rVIZXGKCR1b/x5avMEvxe1MDgX9hFB/xgg3aSj4r05/wEhRWdZ+tFR3V7uxhJuHFV69uhh+0lY+
 w9KYNTKghL1B6HsLKEEWZrZIVurwyCcmmFP50/4ECb/QPog/yZsXGt04VpRk+/423A78jj/bpIy
 990ewZwX0FBW8scB6r67w02UPbl8ORltbeZt7sL9FH0uMr/XuovP4+DBrBYa928Da8SpuhQCVIi
 HCyBM+UHWO7qeLP7
X-Received: by 2002:a17:907:7b83:b0:b9c:2c55:3384 with SMTP id
 a640c23a62f3a-bbffb846e81mr528890366b.31.1777896376311; Mon, 04 May 2026
 05:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260428-ufetch-net-v1-0-5d58c7618239@cherry.de>
 <20260428-ufetch-net-v1-2-5d58c7618239@cherry.de>
In-Reply-To: <20260428-ufetch-net-v1-2-5d58c7618239@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:06:02 -0600
X-Gm-Features: AVHnY4J8a_IJYS__6aVuGuTLJpTk87MXRZcGtpZLOckd69-bMJ5dNjnlZCFSj2c
Message-ID: <CAFLszTj4H-mMfTUKkgr2oHg23r+kr=S7Yb6FbZwGerHQPzAQMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cmd: ufetch: only show comma separator if there was a
 previous feature
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On 2026-04-28T10:56:03, Quentin Schulz <foss+uboot@0leil.net> wrote:
> cmd: ufetch: only show comma separator if there was a previous feature
>
> Currently, if NET is disabled, the next feature to be printed will start
> with a comma and a space which is not pretty. Add the comma and
> whitespace only when a previous feature has already been shown.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> cmd/ufetch.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)

> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> @@ -157,26 +157,37 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
> +                     if (IS_ENABLED(CONFIG_CMD_CAT)) {
> +                             printf(":%scat :3", sep ? ", " : "");
> +                             sep = true;
> +                     }

Do you want the ':' before the '%s' ?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
