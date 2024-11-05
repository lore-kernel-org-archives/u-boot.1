Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C399D2C11B
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B7B98913F;
	Tue,  5 Nov 2024 16:12:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C0kHhjxE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 468958915F; Tue,  5 Nov 2024 16:12:46 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2926C88F77
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9eaaab29bcso288614766b.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 07:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730819563; x=1731424363; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9ryudPQMdfx9xn8o2ERbKEc14Nlq1w1BXjs1kCa0XqM=;
 b=C0kHhjxEM6Qadtr1E1dK0axxjT+oFouedAOMaHS13pIl3/tGX7XZPtvH9l1+VD8rZO
 1hDRGnDP3cVgPZlbP8yNBSGas40SItxXQ87g66r4lRgdBPLpIoUumVr+IbLrJIP0J5SV
 3h/wXWf9l5eZogD3iwnJieWoNSySoqGGvwb8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819563; x=1731424363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ryudPQMdfx9xn8o2ERbKEc14Nlq1w1BXjs1kCa0XqM=;
 b=N899GgQCXGuVCXcmu32BctScHfAYaphETdeCzrdd0vw7fHWDm0ter5CpmfVoNw2RXn
 XSixY6Jukb4nsTvAP+njP50xJnm0OdXfCf6kDW7zxPYSPUFgI19+Ov2ldKjz714Y5M/p
 FTD3VdvpvkPNSF8MqWZ+lBdHojtwYSkUV48i+G//6gqK0PYO9q44JFCIWWacaRx3W6ML
 abNt87I19cBoeD9Cor3KkBWNOgSQVg8tCHO1XW/NitsQ7koa2jepM8Tao9sXCDSaxs22
 Xva/P9sFYsAB1Dm0DzoHJ+ptgEcQQVQiF7ZP9IIIdBSTt1RLbGH9ZpIFXLO3tt1UBHjQ
 Wvvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzRelnO+IkN2/gvy1e45YrAOcajXqHz8S5LSZ8UOJ1FTbA6fiY1gP8ozM6bRLefPRUli09F9w=@lists.denx.de
X-Gm-Message-State: AOJu0YyTLndCX28sPUZRq/0nSKMQqomsyOk7I73gYc4DPwQixF3McTmA
 j6kEB6aSKtLwVwb9sZ5bcgrsPJrzohsW05MhutO+d2YeEbXhozg5bLpSMlei/b83OH/nfG8IGtq
 ohdh/DMYSLYpxHrOcz5bSiiREaTJ3JcMZriJN
X-Google-Smtp-Source: AGHT+IEiYoOK4KkeGSg3zMCNUCKvv8s+e38pkQqgVVch6PVKkaxDmhbpqXwL9oCEaYJK20vk1SkQeckAJpwSA59i9Fk=
X-Received: by 2002:a17:907:7f0d:b0:a9e:447b:6f76 with SMTP id
 a640c23a62f3a-a9e50939fcfmr1897368166b.31.1730819563423; Tue, 05 Nov 2024
 07:12:43 -0800 (PST)
MIME-Version: 1.0
References: <20241102143020.129450-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241102143020.129450-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 08:12:31 -0700
Message-ID: <CAFLszTi1r18JmfdZtFLOrUPa1G0m3r5NPajUadkO5tGqXXNTDA@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: upl: initialize unit test state
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, 2 Nov 2024 at 08:30, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> do_upl_write() calls upl_get_test_data() which may increment the fail
> count in the unit test state. We should initialize it.
>
> Addresses-Coverity-ID: 510465 Uninitialized scalar variable
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/upl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/upl.c b/cmd/upl.c
> index 4996f36c787..c9a823bbc06 100644
> --- a/cmd/upl.c
> +++ b/cmd/upl.c
> @@ -50,7 +50,7 @@ static int do_upl_write(struct cmd_tbl *cmdtp, int flag, int argc,
>                         char *const argv[])
>  {
>         struct upl s_upl, *upl = &s_upl;
> -       struct unit_test_state uts;
> +       struct unit_test_state uts = { 0 };
>         struct abuf buf;
>         oftree tree;
>         ulong addr;
> --
> 2.45.2
>

This already exists. A memset() is in upl_init() which is called from
this function.

Regards,
Simon
