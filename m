Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC07CD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E7D846A5;
	Fri, 15 May 2026 15:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O07RH42b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B962A846CA; Fri, 15 May 2026 15:58:54 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2AFB80086
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bd2d8bb1068so763014266b.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778853532; cv=none;
 d=google.com; s=arc-20240605;
 b=FNKUGrJupuZncMUANvCcnditV54XuHrvKVSzUOUgzZdbS8luChmX7dGkZjhgtDzykh
 wVg0skUj0eVeiZwsEd3fTh4e57IOR7ykUK6tBSc63V033NWPdDd+b3LkTG9mbUC6RmP7
 v7FXkzzpZ7GCI9/wqWrcA5YbqZXkUmi3C3JexAwrz5jLAGHXGa04Q3fPynlPY47657DM
 W01YPX+Nf3qjRm70w5c/VkWMnDag3aAqRtKuIG0MOgPOblrlmzj7461avnoE43ImdGid
 bkIIcra3s31QFcZqStlUOw5eaWR/68xDss+r29y5KRrUO4sva9h1anWLsgFE5p2VtygQ
 ZpYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YO3agu0gp2Zj5kAdOjHgbFvXeMayrZzl2PQ4Y9ieZv4=;
 fh=ieaTsSYvgt2SieZEzsiTDAhh9eeO/3bTH+LGjyp/MAU=;
 b=T2NiairqrTBIjVUgAx/pfrcfAXcGaqbEh/bHVts+RHUBhlCNWYa9GQBP3KM0jF+Y1a
 Akds/Mpd5OMnSv0Yp9fZEl3hRj0ABEYQVLMuL2dS7cxQZzd1B8HkMTtrV7biWZhAz+HC
 K2UOEYms6khXN7r1Sq08JUbVTWc3Bnb6om4b6ousxAuETzKiSgDONTW8gl6+0vTOW4xN
 wFEr8gcYt/AokNv6F44ILbkavG4XG0mL4kKqMjZBpUEihwms9vn26+Q4aPtvm4642I1i
 0w87gaTKniIqoY12Bo3L0+jV2doMFc0YLcn30/1/CmTB5DYUNrn7VaLnnNumid+YZbWb
 wG6Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778853532; x=1779458332; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YO3agu0gp2Zj5kAdOjHgbFvXeMayrZzl2PQ4Y9ieZv4=;
 b=O07RH42bhKt2zH9mGUODy8FmLmrCl2HG7Zj0jEx5JKcq7LaUu1zF90vEvnOuk48QHZ
 U7N6GozbLSvVaYYdbceJAj8IOAR4VtvOkFk/IjsacFSEzT39aQwM1yVgcgbeeLCNFbNW
 1B1cJShe79QMCEaGNorZEgb9IXKUTcT8XW60s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778853532; x=1779458332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YO3agu0gp2Zj5kAdOjHgbFvXeMayrZzl2PQ4Y9ieZv4=;
 b=BJbuvVR7LI3hblQk0AiK37IvUxlli8PsrSPhUur5TRp3eiE8OhcMXRF0N3hsrPJtmv
 InD9EZ/RjDx8l5HgPqIljPVFI+B5FDLQf38bQmvwj5ceLpOFl3jlYHMAbHINeB8Nt5LZ
 0kJ3AjfH3WEGWeI0KpmtXiJMOYBseHuQMIL+H6L1STN6DbGDymrgqv+ypd8ZVdwXw9CQ
 yYGs8a0z0+WT7LVkvdF87CUnYTfQAL5NP7ILzHqM8VdrqrDclcR+XltbZ9ukm3jwjpqk
 3E5pgLzOnJIB6fjuMoKvoyShomQasv03UThGEkEyPXI5hwkT90it7Nw0bG8i7LGCaGTq
 tK0g==
X-Gm-Message-State: AOJu0YwxtocShg1C94rfaQl8ekQP+RdK8p34cAUPWELGWea3GziP+b/v
 dXOa06fbo9hoedjdsqaf5UQGGIUGQM6us4jGr/7imHd5dDpHfVKiMw756ONJZgXrVqXkkeR2n84
 zyYSRxE5Xp1jhLYh3mMpvDWS2+3I8TzPakzyezbdbs+4O7sVj2ypyYg==
X-Gm-Gg: Acq92OHUBFQm2OP/L+Q0emYVTdzVg9zcohuGKGPNd75UeZsGNF4I3WCpr/WUza8i+P6
 m91lEGiZmjYNb2YBG2m7fXQqq60lDYijOCB90HtpRdpVyQx2MHUPw7Xp7AgzYjYvqYi3/QwttkY
 rjiZsqg1VVLevVFttZi/YdjTIZV4HsiKCd1o+tRJ1AcrXavLT9CSwVOdu5QYOIIkQLU8fJ/v+mo
 4O4EmON5CJ10+GxZ/Es0PbrLlaejiV8E3DDKUUfkAdY9IP24hCvwGW6NuRWVXv9mX805T2AeSYb
 UaBH2w==
X-Received: by 2002:a17:907:a45:b0:bc5:bac6:5d5e with SMTP id
 a640c23a62f3a-bd51790581emr236416866b.23.1778853532049; Fri, 15 May 2026
 06:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <agXW8eM2DdZLEqt4@os.inf.tu-dresden.de>
In-Reply-To: <agXW8eM2DdZLEqt4@os.inf.tu-dresden.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 07:58:38 -0600
X-Gm-Features: AVHnY4LvNVRFAqYMYRdc8L0ySbOgd95vkjwlRkR0J19V6gNKN00SFdUe70XRlo4
Message-ID: <CAFLszTjn8H=3x2=UcBEVX22FGP+_27fsvFksE7CoeORL810xOQ@mail.gmail.com>
Subject: Re: [PATCH] common/command.c: Avoid NULL pointer use in
 cmd_auto_complete
To: adam@l4re.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Adam,

On 2026-05-14T14:06:41, Adam Lackorzynski <adam@l4re.org> wrote:
> common/command.c: Avoid NULL pointer use in cmd_auto_complete
>
> Avoid putting a potential NULL pointer to strcmp, which would lead to a
> load at address 0.
>
> Signed-off-by: Adam Lackorzynski <adam@l4re.org>
>
> common/command.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/common/command.c b/common/command.c
> @@ -373,7 +373,7 @@ int cmd_auto_complete(const char *const prompt, char *buf, int *np, int *colp)
>       const char *ps_prompt = CONFIG_SYS_PROMPT;
>  #endif
>
> -     if (strcmp(prompt, ps_prompt) != 0)
> +     if (ps_prompt && strcmp(prompt, ps_prompt) != 0)
>               return 0;       /* not in normal console */

This avoids the deref but isn't quite right. uboot_cli_readline() in
common/cli_hush.c falls back to CONFIG_SYS_PROMPT (or
CONFIG_SYS_PROMPT_HUSH_PS2 for promptmode 2) when PS1 is unset, so
prompt here is never NULL. With your change, a NULL PS1 makes the
comparison succeed unconditionally and promptmode 2 gets treated as
the normal console.

Please can you fall back to the default when env_get() returns NULL,
mirroring the readline path:

    const char *ps_prompt;

    if (IS_ENABLED(CONFIG_CMDLINE_PS_SUPPORT)) {
        ps_prompt = env_get('PS1');

        if (!ps_prompt)
                ps_prompt = CONFIG_SYS_PROMPT;
    } else {
        ps_prompt = CONFIG_SYS_PROMPT;
    }

What do you think?

Regards,
Simon
