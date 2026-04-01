Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4061112241
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 23:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD2E83CE3;
	Thu,  2 Apr 2026 01:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UHjyhdtA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A4683CF5; Thu,  2 Apr 2026 01:34:49 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 986EC839DF
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 01:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6618bc129acso381541a12.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 16:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775086487; cv=none;
 d=google.com; s=arc-20240605;
 b=QHVSC/kdIdZczM+lSMHtn99UB2Xar4mBXP/fyHY04806YSZIptPqG0/HBrImzLXuae
 cxX8p4FDcQglQfneLDB7mkMab+6O8mnrQrvVaqXd1EV3lvzCL1Dox9vmlF03q2vUFz8Z
 jDHxKCa1L8ZALa66kbIc7MExVJeDy278K5P2CcQmRJzyf1stOzJk1gLD+c3NKQh0f8Nw
 v2iNetHJgUfGwhGZRJbSm2PVxhuT0deyDXCKTZKaN+304uN855DWBRzFTa2GPZKjR8Sa
 LTXHsQFjoCR7fz+gI1XbTXy1r16P7U/JhsigcqiQ1EzKmIuoHyMQWCLuT3QqaIDXEd0l
 zoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aK+rnHJubb8NhRauVxwESaRliXPGwzJAlxZygreQi1Y=;
 fh=I6JHg6vWRqLBzH9Re+ndievaa6qWLmyT8ZwKIbNvq2I=;
 b=Q1jR3Z0tajF8qdlxt/CcChf3JufFXCoN9b47Aju3sCgCXGmOJNeP2v88A0sdNPsE52
 qsJ/QBjGOONn/Sk2SrcF6EJFrk6q4A6wgCEREZXNVPy0ojU/6Tc8AIjGjRmJU0txxRP0
 2rb5SJnYNUKaYNSiV3Ibp4CWAoxtrCY6yIbaA3Wjvs3TvjuAkvInDEC8BG2J1BhuIUJt
 xSLUFU+/6SiVXXXJnsT8Psr6gTbnshMghj+3ki2a8SjA0ImWXQ86MpzN7C5PqIQ257z6
 VmsGeCU6yohE5jrx8O55o6k9BBa0NR8LcYcDKTK98wXAnCY7nQF3/OeLR5ghn/iwcR21
 hFRA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775086487; x=1775691287; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aK+rnHJubb8NhRauVxwESaRliXPGwzJAlxZygreQi1Y=;
 b=UHjyhdtAvge9M43jI4j+bhbhJeu7zcNoHSqcDDxAXCtivRcNAhUhbqRZZKqYUeVm/N
 il28rXAIIZb32VLatmSRkhYv34LOUHmVegvvpYvk4KF+pB09TxdbqjFclVzQ+kef+7Gk
 sUjeo/0MR6xw0cnzAEdnJKah1FuEVGBxPelOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775086487; x=1775691287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aK+rnHJubb8NhRauVxwESaRliXPGwzJAlxZygreQi1Y=;
 b=bJDjjF1PgXMSKj4DOisGN+NsM+n3L+qZTwaWgXNvLMhBXIHl1yjkJwDx85gzC7awhl
 o0db7HxKeMaE0/7e+/5mrwCUuR315ErZIW9MbUmH2abECiW9E6n8h272o4UK6QCa5p+7
 3/zpsx+mtS+t32HZw2Co87W5+B8ou5PrzC3L+ZeBYUt4X3mkpsSWMXMTJfdT6f1Bc0qm
 LfAf5Ly3fqnCznG0HTvDzy3H4xrwOm9beFi6cRgMdXAVV6Y7aY34QPVKHqp2Qnv4XDlo
 /m9pjYecXwY91G/zqhJ5qyaRTOqe5okT4D4XTUlWwXmlwAowfcUAtTRgSuITrF6Cylng
 SGmg==
X-Gm-Message-State: AOJu0YxLgIjZ4F1S8HDSvcXNG4d6DYKSHH6HtJM1tnqCKcGrQ3ntS1gS
 A9XNLXbohtbaL5jPfyU9gqnnbnjJPiffNVcLV+GuUOraahLe61HlcXLBmc+UHlLwVlxgqQN3gc6
 b5So9+7Tjec767JLMZXTyJz6j56u9godN52B3x18o
X-Gm-Gg: ATEYQzyq201dAkYQ6k5R/7OSoTYgBujLAtw1skyM/SltOx+vUDmY+fBJu4TOzHDCGbd
 WgI6LdPXUSH8oAT3AI+6xpo+Id0wao8KtKxYSMy+XNAlUhFk5bep3jAouSt2XzPwrT/dKS+K3hs
 pDa5sY4HxfaapDs+62ofxk2otYQCjSCS49CU8mHtvCsjGWPhEWNTOISueFlAk44Vr9pRbI6anX8
 ZXb9PWG20p7Qh4H5kjrJUXu7OtqE5O6zYy+FNJMF0vaqKIMoObqoWbHdPMQlWh3KlQxvWIf9rBe
 g1kL/BKfjl0YtYLp
X-Received: by 2002:a17:907:d7ca:b0:b97:bc8a:f45e with SMTP id
 a640c23a62f3a-b9c1378bac0mr370032766b.1.1775086486989; Wed, 01 Apr 2026
 16:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260401-cmdline-v1-1-c56577f82960@missingno.tech>
In-Reply-To: <20260401-cmdline-v1-1-c56577f82960@missingno.tech>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 19:34:33 -0400
X-Gm-Features: AQROBzAD352KoCqIiKJfD2bbmoCO5NAILR5Avp5RIooOohc1uAJmKT5tERk2mG4
Message-ID: <CAFLszTjZn0RyOFoQE=vHOSkONNj4RD1vjR5uUgQ099uY6k73NQ@mail.gmail.com>
Subject: Re: arch/x86/lib: implement cmdline configuration property
To: ranquet.guillaume@gmail.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jeremy Compostella <jeremy.compostella@intel.com>, 
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Frank Wunderlich <frank-w@public-files.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Guillaume Ranquet <granquet@missingno.tech>
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

Hi Guillaume,

On 2026-04-01T20:52:14, Guillaume Ranquet <ranquet.guillaume@gmail.com> wrote:
> arch/x86/lib: implement cmdline configuration property
> arch/x86/lib: implement cmdline configuration property
>
> Implement the cmdline configuration property as described in the spec
> [1]
>
> [1]: https://fitspec.osfw.foundation/#id10
>
> Signed-off-by: Guillaume Ranquet <granquet@missingno.tech>

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1096,6 +1096,32 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
> +int fit_image_get_cmdline(const void *fit, int noffset, const char **cmdline)
> +{
> +     int len;
> +
> +     *cmdline = (const char *)fdt_getprop(fit, noffset, FIT_CMDLINE, &len);
> +     if (!cmdline) {

This should be 'if (!*cmdline)', right?

> diff --git a/include/image.h b/include/image.h
> @@ -1108,6 +1109,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
> +#define FIT_CMDLINE                  "cmdline"

Please can you rename this to FIT_CMDLINE_PROP to match the naming
convention used by all the other property macros in this list.

> diff --git a/include/image.h b/include/image.h
> @@ -365,6 +365,7 @@ struct bootm_headers {
>       const char      *fit_uname_cfg; /* configuration node unit name */
> +     int             fit_noffset_cfg;        /* os subimage node offset */

The comment is misleading - this is a configuration node offset, not
an os subimage node offset.

> diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
> @@ -279,7 +279,7 @@ struct boot_params *load_zimage(char *image, unsigned long kernel_size,
> +              ulong initrd_addr, ulong initrd_size, char *cmdline_force)

Since the cmdline data comes from the FIT and should not be modified,
please can you use 'const char *cmdline_force'

Regards,
Simon
