Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591DBE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 15:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BC97895A0;
	Sun,  8 Dec 2024 16:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hWPIh1KG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90D6789555; Sun,  8 Dec 2024 16:29:17 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FC9C89305
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 16:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa650ccbe0eso199969866b.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 07:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733671755; x=1734276555; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2vOhacydsoQBkbFRyWj/5vQk4hoVyPgGEWZXYHJZRLI=;
 b=hWPIh1KGRtWaHG1B0imcINv+RZIoE1Zs1Uonyvwt8pK1VkyErWt2/+DgzueWX3Z61P
 MdIh0nLrha9rdJlecFxIyTaOo7Tg3/8lIqjdHCC+3F0etky+s0fX3lHXpo/R1qWh8Doo
 4/Z7oZOyKfBYUTBD2Pd+xy0Z3yvXR5rr/L7uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733671755; x=1734276555;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2vOhacydsoQBkbFRyWj/5vQk4hoVyPgGEWZXYHJZRLI=;
 b=NlgUgIJZnSg4jXPaD3vMIS9UujdPreV/xmFfT/z41YIOLyCt6ArUquI8FxUKe3PyYG
 p1pjmOtimjUSwSmOJ1Vr7EKGITpM3qs62A1sGXFgg96aGRRV+4HTdKvwk1i4+wvs8KeE
 G1asW2Bpeen6K0UCrB20KW7W+NcmffmmedkX3acZMJS0wTWE9jRKZMwxrDImTbiiWxk2
 4HS0qbhk7UUocthEQIPdhd0DZA1Ybd2sE1eDjlvvmlGdiYG6g3VU8lnnxJ79W2xhDdE9
 LddQ95O2Q8vZX/b7dEXU/AoNlNyCOJ4SsDwLuhDIVu/e9frsRmYdNFX7iprCvnWI3bz3
 JXZQ==
X-Gm-Message-State: AOJu0YwCXNl+t0xl4ljEoi1Nilpi1NXeowXGXWV51V2YRA0cNVAzb3mh
 IMWPJ+qPYZrR7h9/HzwnuEmsgKr1tAOp+RhmIQjc3lTmj5lgympqwOpLdhySldaTAqLdULQcNt3
 +1JTZ6Fangz9k6XZeDBndnMK01KPQGJtLUpd+
X-Gm-Gg: ASbGncsVuWgPGShA2GQI+Wce5FtgRo8rSnt5XR4jZUfpPPdLk5QtKGRTea4YfR7T61N
 QdMWrK7RKVEa33LWAF0EEDlYygOHQyw1z
X-Google-Smtp-Source: AGHT+IEVfBCuYtGMEdf2mAckVJ6wKZDi9kDZzVQcZvmfPlJB1k1/lsLfAMzdEcJnxHbwZWtSm/r/W3BN0lkF7AE43Z0=
X-Received: by 2002:a17:907:9145:b0:aa5:630d:7de0 with SMTP id
 a640c23a62f3a-aa63a26a7c0mr822961466b.44.1733671755018; Sun, 08 Dec 2024
 07:29:15 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Dec 2024 15:29:13 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTguwP-7wAPv32UHvW10ORqtK35ZgiG_GpWiFXW8o1QRMQ@mail.gmail.com>
References: <CAFLszTguwP-7wAPv32UHvW10ORqtK35ZgiG_GpWiFXW8o1QRMQ@mail.gmail.com>
 <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-10-mjg59@srcf.ucam.org>
Date: Sun, 8 Dec 2024 15:29:13 +0000
X-Google-Sender-Auth: nKJKL4MfwyX-4k9gL11Zcst6pEY
Message-ID: <CAFLszThBM09r2WL2ng-KMEE-4qsKqTQbgTVfJeUkWiEbTcUXBQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] Fix efi_bind_block.
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Janis Danisevskis <jdanisevskis@aurora.tech>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Matthew Garrett <mjg59@srcf.ucam.org>
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

On Sat, 23 Nov 2024 at 12:57, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Janis Danisevskis <jdanisevskis@aurora.tech>
>
> efi_bind_block had two issues.
> 1. A pointer to a the stack was inserted as plat structure and thus used
> beyond its life time.
> 2. Only the first segment of the device path was copied into the
> platfom data structure resulting in an unterminated device path.
>
> Signed-off-by: Janis Danisevskis <jdanisevskis@aurora.tech>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>  lib/efi/efi_app_init.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to ci/master, thanks!
