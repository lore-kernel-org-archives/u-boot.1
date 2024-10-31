Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972B9D767F2
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 17:52:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 809628929D;
	Thu, 31 Oct 2024 18:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ihCGps14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD44188A4C; Thu, 31 Oct 2024 18:52:07 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B618929D
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 18:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9acafdb745so208820366b.0
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397125; x=1731001925; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EyOPzVxrq4J1OFDx9w1MiPoSVhaayO5BB3S2oky0kO0=;
 b=ihCGps14/+26EJKVkYLIl/ALMtARGWqQnmmJS9EiGfe5+1fbVST79gpPmYdAMdt7uL
 iXoiDTpY3vK+UyhymDUjcLNTjf14Il0/byzVzvjO82tDG1qQrItVPAx6EdEcLb1/HqnU
 9Gtc3PpbUjoOWoFHUG45N/yIyACJ5OhOpSd3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397125; x=1731001925;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EyOPzVxrq4J1OFDx9w1MiPoSVhaayO5BB3S2oky0kO0=;
 b=Ls3sbA5417hYNoFDdLffnoahvaTJpwsP4ejiRQNbIBDUqJjIT3QQtwMnFWfyM1ctz6
 UekAfUlhVB09C+DcADU9F4gQs+gQ82WHHnRMUlST1LsfBI9NeXbaFphD+24g0medzrGa
 EGU1ovdrCdDeK38EbVxIRhyr00uDD4amwDfmD/UupBxTyIKODMkUMtTue8BXqcd2XS5K
 gcoKlxe0VRKYHEOpZ4de81J3/vfgECHj8IRjLwt4k2KXJ4D1CxoOfKZwXfyBTp21Rdqy
 xt0DJ4ry4kNzOEpoISujDtsaCoPyO/8NzERw+UJGTfULMAXZn/OtoOOGDcfm1jgdqg/q
 VLkw==
X-Gm-Message-State: AOJu0YzgKXWNrOxX6s6sx2nVDbVIaA/WMp8wpKsUDVDScJ9u29y8/jet
 x4R0dz2pP9InNnyYHql4ffq32nGVkQozNhtyyx/8Ck0cHN/JZviBGC1CfSpmUXgzZj3JZmPk499
 n9KbIaBdL4D5dq3V+Pjp02bDLpridHbJEPGQ/Gi/ZYJ4b3psgyQ==
X-Google-Smtp-Source: AGHT+IFfqJXGk0KP26JpkOOaxVmyCiGBiV7H3+73Rk30J3Ftq/HnwDEQQItVBJSjfDucErItmgG+3Hf3sVWU9RypzU8=
X-Received: by 2002:a17:907:3f87:b0:a9a:cea7:1294 with SMTP id
 a640c23a62f3a-a9e65436316mr73863566b.21.1730397125287; Thu, 31 Oct 2024
 10:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241030003649.3506474-1-trini@konsulko.com>
In-Reply-To: <20241030003649.3506474-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 18:51:52 +0100
Message-ID: <CAFLszTgPA0vGCWLw3m_KHVCs7=hCouOGhSeZAx3XxWBHtP7oFg@mail.gmail.com>
Subject: Re: [PATCH] test/cmd/mem_copy.c: Use CONFIG_SYS_LOAD_ADDR for base
To: Tom Rini <trini@konsulko.com>
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

Hi Tom,

On Wed, 30 Oct 2024 at 01:36, Tom Rini <trini@konsulko.com> wrote:
>
> When reading/writing to memory we cannot assume that a base address of
> 0x0 is correct and functional. So use CONFIG_SYS_LOAD_ADDR as the base
> from which we add a bit more padding and being our tests.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  test/cmd/mem_copy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/cmd/mem_copy.c b/test/cmd/mem_copy.c
> index 1ba0cebbbe04..67eca328777a 100644
> --- a/test/cmd/mem_copy.c
> +++ b/test/cmd/mem_copy.c
> @@ -21,7 +21,7 @@ struct param {
>  static int do_test(struct unit_test_state *uts,
>                    const char *suffix, int d, int s, int count)
>  {
> -       const long addr = 0x1000;
> +       const long addr = CONFIG_SYS_LOAD_ADDR + 0x1000;

CFG_SYS_SDRAM_BASE would be better here, since it is the start of
memory (0 on sandbox and most boards).

>         u8 shadow[BUF_SIZE];
>         u8 *buf;
>         int i, w, bytes;
> --
> 2.43.0
>

Regards,
Simon
