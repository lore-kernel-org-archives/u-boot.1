Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8F9F34C5F
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 14:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 612AC841D7;
	Mon, 13 Apr 2026 16:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b/aLgcYw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8829841D7; Mon, 13 Apr 2026 16:58:57 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1000084258
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 16:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so704360766b.1
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 07:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776092334; cv=none;
 d=google.com; s=arc-20240605;
 b=AUoIdksTugwIDlEkaNF6lcSLnyhTCWc+GsGboTWkiHygkEZdFekxYIGsZxdiGi5GHG
 T4nH7Ie7PsF2VvrxSSp5G53kaf51aTbnOT6WyiV1CJKiXl0XC8cmC2Eyx997JbsX3vtR
 zNkQQpLUdxNQzrFmmDOhB9gj0C11pHwmS8UJgIZWsCut/g3DwPZgBAd1+jwoKMtMYEhN
 qr8s6NRh8JgOboSA1gyLLcj8/m8hXLo7xuLLFn+knRYx3hb6H3qSYCB2eDlDyFhV4aWe
 iO8o3QDCzwkuiIIez2gaK4e5+AwH9ec23Bn3YkIyhC+J8S54J83/9C5/EDQTSHD+zGpY
 I4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aesQnOoWTHlvvfhmig+pf1Sri4gfxsrEPFOLhM6/NXg=;
 fh=dF+eCHOIT6SIbAzI5tBwPFZclvSQgQQ7Zo1JXO6SSnQ=;
 b=KetoSHx0ejcft9j6cv09cWZc6Vi4FvR0kKg1j3oY6xts3liQ3eQFdHQix7FKRyKTWt
 lQRI4K/oyLQx0TRAeEMA54G9wwyWwThWliO2gIPBtGPaCeeVE0yCeNc5WwSNEnBsQXTk
 NWu95kRz9G73Eie1nw407XeXrapNazPCvd0E5HOggH+5Z2fUcD2qlUR8OLJHpjvNBUie
 MYoIBvZbHuP5Re/vymbhku7U7kdxb6mUyseldKAuMYIKrkVYAr9fGNUHJqCjrKl6tnJh
 TNM1RcYYhDvj5QtHzanGtRhfneMhq1FazZe7xDHK8FRjENbxG0KrfVu+cwO5+CDpo43F
 bwCg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776092334; x=1776697134; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aesQnOoWTHlvvfhmig+pf1Sri4gfxsrEPFOLhM6/NXg=;
 b=b/aLgcYwgZX5jvXWFLVuQh4QpYpNBvZXjHJNTE8wNUpt6jTbQEd+R3jsu/qAthq2Qg
 NbfQESdwBR1rI91EEqy1r5JCLoJhSkfxpdVw1RLvGoCTTgH5Ko+rGpNIAgEsX0I5Nrk6
 vnQOd0hNmHJfY31RsmDlZtwAy/rmCzA21tpCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776092334; x=1776697134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aesQnOoWTHlvvfhmig+pf1Sri4gfxsrEPFOLhM6/NXg=;
 b=VXvl7r1Lb3i4T7THXvU1mw/93Q2t/AsAFwLDUh0i6nn65jRHXvYO8msX6bXGyIoUEG
 AebQHYDD8iNYrDnnM5RDO/4Ol+pQhISNXGHQGl7sCEmZKUJ9j4F7QCmtyBT+ztqevtqc
 XO7v+gQN+HVh8uCYyZhLjsOjAJCdPpbCgTQddNwpbiEO6Tfq77AocjH/2jXW4hxBJQ7S
 +nZ0J9w0ALdNOFXbIbILTL/KbRmM68ge5g/IaMOClaTfy97OkKiR+6uH3UaOF8T4iIcC
 WBXThW9XalGpfpZyodH8UDbiRehmK3qyp9U1mdXpiDOQH94GPexrTsQJKFvZP4rUnZj3
 zOYQ==
X-Gm-Message-State: AOJu0YwMLZrpSj8LYWxEojERCsym/MC2d57GmZfeN5NWmxLTp+2JEyBc
 uEFJzyEmOu3ScGFLi66nC8OmRPA6S87+No1p7xfcpSFx4tBMDFDvfq0g1yx33I5/8BL1pEI9FDZ
 NY9Oly2q3Qj2IKB8NsfhyrkBqACgegKv71lDhtP5M
X-Gm-Gg: AeBDieuw29IYjv5wkaOawtHz5CBR7WFhDeHNLdqpB5qKamtoNsN1DCmVV5rXczd9H6H
 QPcHrLufOVzNHpP4/hKzUMmNjBANILryKNEjZVUw41Ne/xAuolV0vTBjmvOQ98d8UUFpkuvE8w2
 GAdocc+lCfqixP0qFPZ4NM3ZyWryVV3yD4iVpC6rD5kiI0pBF3MNrGOuyGn0aV5bN8BbxGBhKMy
 0hjqjWE8ZH53Q0pHYPpCBXYimlqAp2U1DQ8kkEQVc7spxESu46BcJDHJEp3fQyVP75zvWNXUsrO
 wGzOYA==
X-Received: by 2002:a17:907:c908:b0:b9d:3b68:954c with SMTP id
 a640c23a62f3a-b9d727aa0cbmr570914366b.24.1776092334465; Mon, 13 Apr 2026
 07:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260412195947.1982729-1-ravi@prevas.dk>
 <20260412195947.1982729-9-ravi@prevas.dk>
In-Reply-To: <20260412195947.1982729-9-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 08:57:27 -0600
X-Gm-Features: AQROBzDtMCWSzIEWthkcgDyoePUzgmy7gkheukuEAWWBbagVtyru4z2pPLuF-Ec
Message-ID: <CAFLszTjS4HvHxCA9tH7dgKiKO=+-sPqVyW1ouYFqw5ei4Gipng@mail.gmail.com>
Subject: Re: [PATCH 8/8] drivers/core: use memdup() instead of
 malloc()+memcpy()
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

On 2026-04-12T19:59:41, Rasmus Villemoes <ravi@prevas.dk> wrote:
> drivers/core: use memdup() instead of malloc()+memcpy()
>
> Use memdup() instead of open-coding it.
>
> In the dm_setup_inst() case, there was never any reason to use
> calloc(), as the whole allocation is definitely initialized via the
> immediately following memcpy().
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> drivers/core/acpi.c   | 3 +--
>  drivers/core/ofnode.c | 3 +--
>  drivers/core/root.c   | 3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
