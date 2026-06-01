Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50CFCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 14:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48297848FD;
	Mon,  1 Jun 2026 16:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="URfCXng9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D28078491C; Mon,  1 Jun 2026 16:55:07 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93D71848EE
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 16:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-68b73f1a8ebso6942485a12.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 07:55:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325704; cv=none;
 d=google.com; s=arc-20240605;
 b=hs2Gtj5aAc+paIpjgIN9lYcj5XRsQBDz3A4Ckah7P2JhvDN01rFJ5U5mH6wqJUjYJf
 ZqavA/L45BYG7c6aJc/TlYMDvw8wNGrB8+14rMfixNMGmQpERunL2o6saBcxySkWJltJ
 Wl4sVRYYW+llFqFP8sKFEd78yyvJt3UGIBCMJFBRdmcaWXYPk5d0ABUy/JmFouM6pk0i
 ywjIEWAiF4zUt3KT7Cws7u91aTp7iEAkj8rG+FecaZ+2+xUsobn6w1DTgy2IDybvcVE0
 BhVQYCnPdxNtcNhsrDEhZossmvq0tsymezVwWpC4fbeJer1cCAQTN4/iqahctH9Y9j+m
 x/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fRlrJFqC/9vXikSZLiBnwdP0LTGBRhff0kGeePBF82I=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=B58/RHwlsfXaF38ld6R+Ap2UvVQbBzfN6qKWmGPPFypDDl01KGdc2lEYkDQqMffXJd
 5szF2I1czzKmk/voDzpREgNuHS9doRqTU4M7hYh/2V6UxIhe6VQ/vh7SU29odZxXGR7t
 lr5IyDzKlR+3BL8nhH3wa/x5tWPwqpuKzXCOR1vpHFctxeNcZCUcwenYF+5Nr+v+/b9P
 2KhgJondMvbDpRd/ILIMxC+sOjeiqqaWRkK00Fvj8gWVLqjvdMp0noufQeV95e57BWKd
 a0WxjyJz+0W+WtZOOAvOvm2GxJHdYarrNfUnq9HYJ/0Cd1Cnyqnpzw2Px54B0iIdk9NJ
 yvhg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780325704; x=1780930504; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fRlrJFqC/9vXikSZLiBnwdP0LTGBRhff0kGeePBF82I=;
 b=URfCXng9Uiwz1pq7QHcWyjArSJsdqm3y1z9L00SDmrZIXUOW/xQsQTLSYqGAVm/UMq
 AAM7L1tHLf7jtxOdyU7MUGHoN/1kX43k0g2UuxKlr9dccllhPWtV2MTfi359u0P16rwg
 jrRFxFHnCkp6JLeCBKZBuTgbPJs5s49eYZkxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780325704; x=1780930504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRlrJFqC/9vXikSZLiBnwdP0LTGBRhff0kGeePBF82I=;
 b=FXxNtnCymMRxKcsXEmHbN0NjijZJto+UfsL8xa6lHwhsww/oov3TX210x+1ovjEWVO
 keDBKCHQ714DCWiJlc8BLkRDqE/6bGDFFAAwsaqUiDgQ5x1FDoGaLH1QRgqYtxcNtfqs
 YgbRBDP+BYldkbaaLm7FwtvcK08k2qkcLZDZqZIEOLl95k1J6wh9KNyOn4Oopvln0G8A
 qGeIl3KWwmkgWWmFP2D1D31OnmrJ2K609yqYfHowNqRjH1AyzXdc7rFv/j1p2fvhRn/o
 YBLwLmuhhFfVLPoBO14uECVF9hJQaMK/E0SWCO002fRPX8EeQtztI63R/Xwe0UPET2KU
 JQow==
X-Gm-Message-State: AOJu0YypM2kzzo3141QYoo0SgK8xJDKOAGlot1FSIPllvFel/cJ5zw1A
 +RRMYLbSjJ94zx06QOpqnTTOF/KaaOYMAp9CegF+nCHgauRNmpw+YKBR03jLIk1m2S1J9jWp0s9
 hGcOhzVPr5GgfOVwsEjZ9armt8JCODMcm4tSNTE7U
X-Gm-Gg: Acq92OEPXCY/BApkPriHIVm9vziNFDN1U9ihQLLNknNuQyFV8pyMLSQbQPLHK7NTjdF
 3QvRoDgH+3btX8jHNCQnesEHDA1tfbuGzJgvdkhI+ZniHtlOKrskbGggmUePkSGa0FoImUlLkJq
 wI4pMZlSuH7EtZre1BGNO8DxB65eDp0L7xhsEh5Hw7ckDjvMCnmq5St5UhJmhCP01CqfqLh3MLP
 69DgiSPzthiqlGPkdxxmMszlXdVmB69ACHiniqADXeVGtcduwcLZ0KsolBESL7CM8UuJNgkNwB9
 NL4r1zLdIuX18nAC
X-Received: by 2002:a17:907:3e89:b0:bd8:bb13:2227 with SMTP id
 a640c23a62f3a-beab394bd54mr583685166b.6.1780325703767; Mon, 01 Jun 2026
 07:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260529034839.2075806-1-dmukhin@ford.com>
 <20260529034839.2075806-5-dmukhin@ford.com>
In-Reply-To: <20260529034839.2075806-5-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 08:54:48 -0600
X-Gm-Features: AVHnY4IdLcLwydImLlRW575Wg3vhpLfD3ObYRaVwO8-SlA80MgFg6cWVqkfMIls
Message-ID: <CAFLszTgub5tR06FAO01gbdD7mnUADGWyVZrLOgkpz+hXnDnKAg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] reset: x86: Use cpu_hlt() in
 pch_sysreset_power_off()
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

Hi Denis,

On 2026-05-29T03:48:33, None <dmukhin@ford.com> wrote:
> reset: x86: Use cpu_hlt() in pch_sysreset_power_off()
>
> Use cpu_hlt() instead of open-coded 'hlt' in pch_sysreset_power_off().
>
> Also, replace the open-coded busy loop in efi_reset_system() and use
> cpu_hlt().
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/sysreset/sysreset_x86.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
> @@ -120,7 +120,8 @@ void __efi_runtime EFIAPI efi_reset_system(
>
>       /* TODO EFI_RESET_SHUTDOWN */
>
> -     while (1) { }
> +     for (;;)
> +             cpu_hlt();
>  }

Just to check - this is an __efi_runtime function, so the body must
not call outside the runtime section after SetVirtualAddressMap().
cpu_hlt() is static inline __always_inline in asm/processor.h so it
expands to a bare hlt here, which is fine. Worth mentioning in the
commit message so the runtime-safety is explicit.

Regards,
Simon
