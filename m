Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01104CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ECF0849E0;
	Thu, 18 Jun 2026 17:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZORRx2Jz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39D5C849DA; Thu, 18 Jun 2026 17:54:53 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B39784874
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-68852b58d87so2144272a12.3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781798091; cv=none;
 d=google.com; s=arc-20240605;
 b=UqNz1gA0gKZc99DF6DrkLC19emFO8U5xMEaBjoKUbYEuyh6g0yEYoNdWpo25wL+0Ft
 o4p1fFudTGIQWzEpt1Lc3h6HRylBKeaVLpa4NyNPMgl7lcihmTkTxOLOZ0psT3XSetUr
 EqXPwDFIMk51ODcWqM3vW9oUN1H0ioGMxBdt8LGLZh0S5oFSzo9GY6wtv4YhJSdhwjUY
 0AqP0EivMK8oLL90LJGjgroC165OqnLWH/WP9U56KYS7/lfDSDnhpUZ2Lq+adE7j50qH
 JG851glvmt/aUqxAk4m+J6iXYbVHLg/7djXP7eDP/euDRYMwLzBoQbklbVvCXj/0ckhA
 ySvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s9vHEatK5CmH0zllX0wD9sGvyxebk/fhuozum4IqBGE=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=R14xzTKuzyrQdsVer0DKSQH9YXJr7yiUyq45FZRlmkKlQruP+B5uG+UpSzcuiYVdTB
 uCUkvlmWEuY5F+zzln3pWfiyU2uHlayF+gcwJf/U8dbMM6jBhrYdqhVQ0jKoblExRq6B
 ecWmRNsRf/cODY+V3qDBdiyvBZ99SGgJeh+muDvnOkuq2Kr+iK0oXAa7EMT+yJD1rADP
 SNdc83Xgha/y9mBkECaaYrjUunPSiG7Cx90e0slxTyLz6VM9WWe5iVdT8bv6ZQkvNBg+
 0HncSHHNROynqrBpMHrqfmPpldyfuiIGnOYYDnUhdlpgmf69/PG2ttOazbjXIR6hSmOK
 UBjQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781798091; x=1782402891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s9vHEatK5CmH0zllX0wD9sGvyxebk/fhuozum4IqBGE=;
 b=ZORRx2JzU8HuNPM5JfSHFKCofjbS8imIr3+ECm6Ls7VhjGfzXHWtd9daAJ7s1d9e5V
 ht0tHlyL2cO7k1Dnp8LczuQqPDy9QE4moJcLkxOeSOSCKPU5sGNDoNCGfiOIEcmvoiXy
 NGT3bLHNM/7IilWomuuUxbi4+iVY1Rsm0fCoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781798091; x=1782402891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9vHEatK5CmH0zllX0wD9sGvyxebk/fhuozum4IqBGE=;
 b=NK1r+jG1OC6ttwuTM0QW+4FRcMMdP7Z4b7CM6ARmGOFIqM/w2gHkZqCZUI9dyES19m
 HPniHASNnHm1hFBvr+9kiMQZPHzjV4cHgVsYdNb+HJrJe6KKqRuU8F4pKbnwTkgwQKKI
 Rp/ovdHp+kd9KTV7DTCvZO9mvNCcGpDYRoqcuVzHmRXAvlpDdaoBVZdF+Uqj9TjgEEWe
 9wbMu8LVOp5XrYb1JGuKjpY7IFNno8sEkIUyvB7SSMG5yXuADwtcCpCMTTjWGJgRR6XR
 Osgd5P9Ed6sSh295jEjFnZN87yTCa7RRILKnyFhhwGvKdZGJhzXw5taPC6ED0CN6lx/0
 OkgA==
X-Gm-Message-State: AOJu0YwSHZLYvlnkrpwWVR9mlI4O1XMTlJo5rLNOMZooCaRyj5K4Yo09
 jgOpQtRP2kQsTBUDsO//Y6cjeXMQOjJQuaT37+rt4XcLTqlqHaaGKYZcMArX95WqLWQIK7ex0O8
 oQYhPmxp+rDd+k3HGeKoXlEhhjnsAzd6n2s8rFzw2
X-Gm-Gg: AfdE7cmOX6XPMnNTGRgLCTC04wipeC6lV0QVgXNIxGdbujyI6lrn+xUqwL1CpKgRl4I
 ugp/MfuQtDjeMS0zyi9QWCXpXEsuv3Fn1IuelaDt7uBfgOBAMqIdzO9Xs8xuIU9eors3r1qEEDV
 91NU3rQopOR6kR0ugdwvYCsu5VB9q6peAUzR5QamEeasJ+T/76hAf/Ik21WlS54JZgqZqa4yrR+
 NokIK2FVttyrknWchj8t5reveLpBqXlzPcZiLiaNi7VIg+PR2DqlX3S65V6wZXb+2Tyv4DgkQ==
X-Received: by 2002:a05:6402:3511:b0:696:a4fb:f222 with SMTP id
 4fb4d7f45d1cf-696e4a4bc0dmr1918a12.13.1781798090848; Thu, 18 Jun 2026
 08:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260605033907.1909319-1-dmukhin@ford.com>
 <20260605033907.1909319-6-dmukhin@ford.com>
In-Reply-To: <20260605033907.1909319-6-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:54:33 +0100
X-Gm-Features: AVVi8Cck4eRRil5DODxggzjJ9UQ6cSbI-FWrTPOcXlPlEGVKGQJpbdcF-ViWVBc
Message-ID: <CAFLszTiZ-W8xVACQ6Nx1HWY+N8bTgsfp_3=Z4FoK68y0PdXafg@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] configs: sandbox: enable GPT flags extension
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

On 2026-06-05T03:38:59, None <dmukhin@ford.com> wrote:
> configs: sandbox: enable GPT flags extension
>
> Enable CONFIG_CMD_GPT_FLAGS to allow users experiment with GPT
> flags manipulation via 'gpt' command.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> configs/sandbox_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
