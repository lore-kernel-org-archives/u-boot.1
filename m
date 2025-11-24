Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A832ECFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 12:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DACA883BEF;
	Mon, 24 Nov 2025 13:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Icegg/GG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93BCD83D85; Mon, 24 Nov 2025 13:11:46 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 286E383BCF
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 13:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-78a8bed470bso22749957b3.0
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 04:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763986298; x=1764591098; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KWsbeqcA3pRv8HgJYZIaypluLxmKQejdTqo5olKyNO4=;
 b=Icegg/GGblXzm0csloK6UUVKMza4y8c8f9bxgi5dXqyibvzkmK7Vxwx8fW5DGN1++u
 3t3u7rbyUl93/5STNc12L0ejZZ1mlkkT3lXc+jSh30yLwLkHU2z62Q73IZmf2Wst2NP0
 Aq8BxMtm6xbsfSPnv8c2VbImJWJZ9Ix6HqkFyrHA0Fwz3obiJ9/kAwrQ+2pd3KJTCmC4
 UalcSQp/pzJY55aHCSLKv+LXI1a21zx1uOXNzDMrbBUaZrPNKo5PmOnvHz/lQfzjf4ps
 flIj/y2UawlMZCloWcGXT8669pb9pgEhkSuYdESpi2cqjMtWLtqjM+bvLk9sgS6IfRHt
 BCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763986298; x=1764591098;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWsbeqcA3pRv8HgJYZIaypluLxmKQejdTqo5olKyNO4=;
 b=CNaTVvNTivulB6++o1M3zHylG5x8HlAMe5WzJu+BaAu84EOrADIrYID0z4oihsjAAT
 xDmcvpAwZDBRKn71J/+WFYPqMH4hVde4q8hHV3AD91HRxLt5SQXjMYhwo/f6FXNc0xsq
 h8FwxKlSP1QaHwgE/2sdTGK+iE5EK7ykmJ15UrlN3MBHlQmbDa8lG5zHboESd8iaT6pV
 3WlEq1c7e80MYdEzie1ZbtpqfAb1oGkWIw8bpSLOczln22vIjU8zi6ohj5SaZ/pbUUhw
 lqF+velta8/dlgZbrUVTsA2FXlavAAiN3CVCQ5Allev2JPdPbuOoVbqejDai2s8djPDG
 qwLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2owAe1HS9haquj0Wu/ZT3ZeklrlVWhjUe6stATQfuV/3s97YgU99nVMH1MHN4DdrLqGFH8wc=@lists.denx.de
X-Gm-Message-State: AOJu0YyOLE7VFS+qIdxdKFrX36r95GT7x8EuFMZKqn41imfZtHwT4BcF
 AESNu3QO1qhcV/EMLH8dvurtl3h+26Bee3T6G0KBzUmiHfVLmuct+G6pC21FnDgsn2XBtLXUzrX
 UT8a8TCe3cHyBrF5aq/Qs/1a+lP42XvDd28VGj4HS1Q==
X-Gm-Gg: ASbGnctFSZMiHlsq0Wptar1Zf1QXPTnU3sbQ/mD6blwrDuz+B3KrEeeYqNyVWXpi+jU
 jYKWfUIegfNou6DWx6zUMPKi5gQkUhpZMJDaV50I++PXonoCkQ4SBvnPK0kK9hnZIQVzL7UXTjM
 e2kq9ovp+Ck0AIvZCNM/9QtR1tJC3u/gxCf77hf2m2RZL1rID69RJn+PjgE3WQWZvGQE2Hriqna
 z/QBGHUCzZjkLoRdJoQg5sgUQFNbfy7uNFW3E2Kw+LAQ8AftjGYXuYgtw2ahw9fp1xsPoHOYYhE
 FpxKG8OZ1pQaPDItUEZd7cy1KdEsMIjM6av5CJyuzXo4hh5q3xA=
X-Google-Smtp-Source: AGHT+IFGciXKlJZL2b8FPi6paWdazCgtHyj6fs9z4JZM/kHTSlQT6oqgcBgWw7srV/F4lmtmcGwxWY/sFmLaralAvhc=
X-Received: by 2002:a05:690c:9986:b0:786:96de:af5f with SMTP id
 00721157ae682-78a8b5511e7mr162221677b3.53.1763986297926; Mon, 24 Nov 2025
 04:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20251123011900.91233-1-heinrich.schuchardt@canonical.com>
 <20251123011900.91233-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251123011900.91233-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 24 Nov 2025 14:11:01 +0200
X-Gm-Features: AWmQ_bko0wigH7gwA86V3Cf9VmoXc_-4nbbOzdChCuSXYRZ4s1XRzO4ZKijiXms
Message-ID: <CAC_iWjJ=EiNnk8XfSdyqBjMNpLqqRmyybVaMm0_PksmR=hvG5w@mail.gmail.com>
Subject: Re: [PATCH 1/3] test: cmd/bdinfo: consider ARM architecture specific
 info
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
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

On Sun, 23 Nov 2025 at 03:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On ARM the bdinfo command prints architecture specific information.
> The test needs to accept these output lines.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  test/cmd/bdinfo.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
> index 28d448a0866..9ffa0d3cdd5 100644
> --- a/test/cmd/bdinfo.c
> +++ b/test/cmd/bdinfo.c
> @@ -224,6 +224,34 @@ static int bdinfo_test_all(struct unit_test_state *uts)
>         if (gd->arch.firmware_fdt_addr)
>                 ut_check_console_linen(uts, "firmware fdt");
>  #endif
> +#ifdef CONFIG_ARM
> +       ut_check_console_linen(uts, "arch_number");
> +#ifdef CFG_SYS_MEM_RESERVE_SECURE
> +       if (gd->arch.secure_ram & MEM_RESERVE_SECURE_SECURED)
> +               ut_check_console_linen(uts, "Secure ram");
> +#endif
> +#ifdef CONFIG_RESV_RAM
> +       if (gd->arch.resv_ram)
> +               ut_check_console_linen(uts, "Reserved ram");
> +#endif
> +#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
> +       ut_check_console_linen(uts, "TLB addr");
> +#endif
> +       ut_check_console_linen(uts, "irq_sp");
> +       ut_check_console_linen(uts, "sp start");
> +#ifdef CONFIG_CLOCKS
> +       ut_check_console_linen(uts, "ARM frequency =");
> +       ut_check_console_linen(uts, "DSP frequency =");
> +       ut_check_console_linen(uts, "DDR frequency =");
> +#endif
> +#ifdef CONFIG_BOARD_TYPES
> +       ut_check_console_linen(uts, "Board Type  =");
> +#endif
> +#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
> +       ut_check_console_linen(uts, "Early malloc usage:");
> +#endif
> +
> +#endif /* CONFIG_ARM */
>
>         return 0;
>  }
> --
> 2.51.0
>
