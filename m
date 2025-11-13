Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC15ECD98D4
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 19:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 984F58401A;
	Thu, 13 Nov 2025 20:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Oz7hzskm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DBE084033; Thu, 13 Nov 2025 20:34:15 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C84B8400F
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 20:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b403bb7843eso242569866b.3
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763062453; x=1763667253; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RkyqNGIOXHXQNyg3JQ6OnnVL89SyiHixTEDOyMcu9is=;
 b=Oz7hzskm4ChG9znkUl6yDr618BItyy1OTVCUP7iRLFR+IPuEOeaLPfTKgjhGM+I6/A
 VeH1b2ZPigzmkoSyAYT7f/kWWAdlqPTZ3oWpVnK5gPsCkmOd91jBiwtKfEvSifjOSclX
 7ySS9Xe7QJRsZLPfqUUTA7jKbqsMZwhT2d+wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763062453; x=1763667253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkyqNGIOXHXQNyg3JQ6OnnVL89SyiHixTEDOyMcu9is=;
 b=SO2M+4VqjKEevdxceVghg5EAcORsBgDQc+5wAGqzgmM00dnm1HIEOsqvuvekfav6Gh
 VKWbUZzwzPJoswZAyFwwPsVT+DW2PsgRIe1+yUNaG9im2vNWgjKgyPteK+wn0hE6eNQ4
 ANDp/9nVv+ctko6xFVYaIws9zsZPuYA+giN6Fqz2kGwGgkYEuZ1fwFxOw0lhnHlJlF4W
 4I3Et5g6ZVrrhSqjt6MSZlK9lDy0HRXYnb9M+BF0pvjrwoCgRZXn+dP3e9bJ2xvwfgCX
 aP5AypykKYhmmcRNmqvqXcDyM3h5qUb7vJxl3TyM26m8Adynihlxs1CeGIitiDX7PQ6a
 wbwA==
X-Gm-Message-State: AOJu0YwRKX8l0LAHH3ONenkG5ibqy/EEjF3hIhFrioUheuzv1nlgeusp
 FXzYUrR5Opn6Wk0SuFhKUwvPict3uT4TTytionEWy5eUnTWOM6SWDFkVEoaDZgKYWKxY2ym+pet
 mIJz/xW6WyGjpaLOEukdCkK88zJ1x7Ea4UPY8EQcW
X-Gm-Gg: ASbGncsciaMUtpQhEvWwakH80vhRPw26jAb0zU/K9sxGHsO8TGaswoMga9MiOosppbm
 22/susbhkPBgquu5WOuh70ZNymwbx460lCPF9hlUuHgv+4W1Gc1gkwc0606DGqTLucgBHIne34Z
 8xQX1q0NlCiKB89bfdcE4vcOkeKErSXNr7fLGcgmcws+IvDORS2Z0vAECc7JPrBZAzgqRyNbNIr
 n2B2FvCS3+ksCHhp6gtYfxd5OgUIltRZTbti6HuO4Lt54L/6LqjNY84cjw6b6LSuDLJbA==
X-Google-Smtp-Source: AGHT+IFcixB5XQtYK2WoFfK0HU3PkCX42kKtC24QbaUEjB1YO44cS8XN6I5bFiR/DermuE4nlQLeo1S1Ekp7jGg3w5I=
X-Received: by 2002:a17:907:7f19:b0:b71:3045:f73f with SMTP id
 a640c23a62f3a-b7367961db9mr34422966b.40.1763062452789; Thu, 13 Nov 2025
 11:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113122145.949112-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251113122145.949112-2-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Nov 2025 12:33:16 -0700
X-Gm-Features: AWmQ_blFwH1yvkbN8ey6bJN8UlHnC2WVMBglUHEhvP42H_mtac6op0vGxFBVWIY
Message-ID: <CAFLszTigJHK9H18rZG=AHRo09RPqKGHQmmVrHZ40mHPk-KkwqQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dm: core: Check ofnode_to_offset() return value
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Sam Edwards <cfsworks@gmail.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Thu, 13 Nov 2025 at 05:21, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The ofnode_to_offset() may return -1 , which is not a valid value
> and is not accepted by modern libfdt 1.7.2. Check the return value
> from ofnode_to_offset() and exit early in case it is not a valid
> offset.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Adriano Cordova <adrianox@gmail.com>
> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Sam Edwards <cfsworks@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/core/ofnode.c | 384 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 284 insertions(+), 100 deletions(-)
>
> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> index 071d998a0a5..55c2b3a10bb 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -335,7 +335,7 @@ bool ofnode_name_eq_unit(ofnode node, const char *name)
>  int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
>  {
>         const u8 *cell;
> -       int len;
> +       int len, off;
>
>         assert(ofnode_valid(node));
>         log_debug("%s: %s: ", __func__, propname);
> @@ -343,8 +343,13 @@ int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
>         if (ofnode_is_np(node))
>                 return of_read_u8(ofnode_to_np(node), propname, outp);
>
> -       cell = fdt_getprop(gd->fdt_blob, ofnode_to_offset(node), propname,
> -                          &len);
> +       off = ofnode_to_offset(node);
> +       if (off < 0) {
> +               log_debug("(not valid)\n");
> +               return -EINVAL;
> +       }

Ugh this is really horrible, sorry :-)

Better to put a wrapper around it than add all these checks, extra
code size, etc. Also in many cases the ofnode is known to be valid(TM)
so it might just be a waste.

Regards,
Simon
