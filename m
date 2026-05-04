Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8619FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8F3E8466D;
	Mon,  4 May 2026 14:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O1VU0hbL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA60884683; Mon,  4 May 2026 14:49:54 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C71A58460E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-baebe98afa0so566690766b.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777898992; cv=none;
 d=google.com; s=arc-20240605;
 b=eOhH5hEQI/DtkI5WotwI2MeCb47Ymsbk2pGFy/BdDV33UqUFZWJWPoyn6SlNL4zRJB
 BT2Ie+wSB0PljHRYY7MU58uScELJQ6/fGmiDmb1XDy5AoDm+CMS5mH8zXkQsuQHRFxOq
 Bmd2Z8yCUvCPjYM1Q8NFCx1yLG44RlaG2W96Fjqjg9gRiKk/whBEFeUPw2x0ZBWKnVuV
 uCdw0Af45HDucdX085h71wxen5WvsOoJ3JIu4hXjGLDVhatJzwzzvB3fzak4wNpq3tXD
 gvYqCnSVoYmPOVt5MLdHs9JnXWZVKa8ChsCIjvL1daeQImUyuTKaA3+MZcIjM6/xqIcs
 qhQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uN4HV/4OeeEdBczFDqTe21UDALruyPKmq3q/sgj5Wo8=;
 fh=+YWNXZflDqymfw6yT6Tw4ndNv9cJMPLg7YD2gVliQ4E=;
 b=kXDAN+a12P0kFgam/212J+6xfAGNmUwph77a2+l6vjkjOni7JJ57ANjYbUQNmwOJar
 BzoU2ftQNyDJvw+coENfmKXZJ+Xl/exCwTFt3zwFRVgoYVUdftU7HBbYB7zNo134rgKr
 UqT0A5jqKOOKw+++tiF5z+AJlign9aS8nVV14mVYzQcjy8b31VpOlwmSMQauXNBNp/Bp
 vmNUza79kG3FoIRqTdhEacqnpE62JMkNWCn6yiwG3Szw8aXWZq4EbVTf+OIjLaKvh3fq
 AtVCKSTvS2mnc/loVoY0DvB0mzmRjZlUTSIEpm+cB9+aeVMW6f2/EpjMMNvTPSniNbZj
 CbGg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777898992; x=1778503792; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uN4HV/4OeeEdBczFDqTe21UDALruyPKmq3q/sgj5Wo8=;
 b=O1VU0hbLEpqULF+wG81Z534fauoFS5zHAVSSl01SSIWoyCWasxHTyy4HTNWb6y3l/y
 H54VqfM2m8FVu0IZ/4Bfq3wCoquM65SI/2biHGnCTLvLQw9sBek9I2b5+ttGgErmF60U
 YUO4GL3IaafPqZW9j8/puYl5Md2fyzygKMbKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777898992; x=1778503792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uN4HV/4OeeEdBczFDqTe21UDALruyPKmq3q/sgj5Wo8=;
 b=lmTzkZAuXdR+KaRqfHYmn2dNlB17n+5MH/dNQJfSO6PuXr0Tn9oawJJ8AreDDCrKF5
 OqEg3IsCww4kBlbp9/OfMeX7evt/P2MmjZ4d0r9JJE/rV3qEGpvgWACZronrhklBc3pm
 8r2sfEHAPXHjIQmz48Yn3IeBTy0NKr6x8MQZjZKOjnZFyrbEdxNBwTpoq6BN+SxgcPHg
 fGBhorgeW01FxLsTB5MEAqIJmvgLrg3MOV6nm/PhB8pFRe6V8lVHuF3bTbjZ+NbLNecT
 fBecEf4UaGdeOEkVQSYPkVxPvr6aJ3hw4WugZfrlSIpdiMnIdxpTc/6vfn43FVY03fXL
 SlkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9AGTBHFQ66KgARGSJ73/caU1Y02hKdJhE9dSacHUR3+0aNg4wmf628SOhwtlz3MDlyh0bosoM=@lists.denx.de
X-Gm-Message-State: AOJu0YwiEquwmrKEat1NmOfKi27fnX7sVMJQxyE+ibbkSZ7cSRl/UFYY
 2sJvKgXCDPKkekA7cU3n2C9eWqySS9v7MDeLBrQDzR+7Nmkz3QUXLD5w7Egh6Xye3VnpYp4vZm5
 E1tj9OnTBLBAymohIixUJjVV2Df0BebSo1luwfyy9
X-Gm-Gg: AeBDies9/yr0Zsdkgv4yy80UbJGBNWIVD+y6HxCfcCDXZo+I2GhGsgdpRlFzb4PxeHC
 LlkP2zrH+5GKoy3L8RPlPLZ7QPigAFJHdojONhQ+/uonXRVjVspP6xRxApSJSh4a+mp/cxwaQAi
 hkbONdMZuea3Wt7w3B1EB2jLVsyZllIq9TGosUYtDksZKP2D4O2001Jl0gNdjj8TmrgNSaZUWbq
 XqNIIs2OZzjfB/xMOg0QreReNnL2I6axw1bkLDv/9WsayvLFXL0pQY/RI8sIQx+eKsW5yAl8uTO
 Pn6GkGaBb+DA7L2n
X-Received: by 2002:a17:907:7baa:b0:bab:812f:a894 with SMTP id
 a640c23a62f3a-bbffcf81d25mr519707966b.20.1777898992118; Mon, 04 May 2026
 05:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260429100400.2860345-1-ghidoliemanuele@gmail.com>
In-Reply-To: <20260429100400.2860345-1-ghidoliemanuele@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:49:38 -0600
X-Gm-Features: AVHnY4KqLVFrp6yA8G6-ctipz0UN_gmnCy_UhWaHkK1-ToNN2xdOaApIuB4i-RE
Message-ID: <CAFLszTixnexzzh8oQroAuMNV6T9+UN28yRB+wiZrxfzv_xXMGQ@mail.gmail.com>
Subject: Re: [PATCH v1] common: memsize: fix occasionally failing alias probing
To: ghidoliemanuele@gmail.com
Cc: Tom Rini <trini@konsulko.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

On 2026-04-29T10:03:56, Emanuele Ghidoli <ghidoliemanuele@gmail.com> wrote:
> common: memsize: fix occasionally failing alias probing
>
> probe_ram_size_by_alias() detects whether a probe address still aliases
> a lower address by writing through one address and reading through the
> other.
>
> On i.MX95 this occasionally reported a false non-alias when the alias
> read happened immediately after the write.
>
> A memory barrier alone, mb(), was tested but did not make the failure go
> away. This suggests that ordering the CPU accesses is not sufficient for
> this probe, likely because the issue is in the path to the memory
> controller rather than in the core itself.
>
> Read the written address back before checking the alias address. This
> appears to force the write to become observable at the probe address
> before using the alias read to decide whether the tested address range
> exists.
>
> If the readback does not match the written pattern, restore the saved
> value and continue with the next check. This keeps the probe robust for
> addresses that do not reliably retain the test pattern.
>
> Fixes: 0977448b45e2 ("common: memsize: add RAM size probe based on alias detection")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> common/memsize.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
