Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F151D116F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 12:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F0383E52;
	Tue,  2 Dec 2025 13:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yCroV1vn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0032E83E57; Tue,  2 Dec 2025 13:40:47 +0100 (CET)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD7D083CAA
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 13:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-640d43060d2so4041617d50.2
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 04:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764679244; x=1765284044; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H5ktJ3URRVxyV+3D314iN5gIWpL/tXp7W9q0eScT9Vc=;
 b=yCroV1vn2CyM9EtWY0D+tSLDjnY4BixiJ5QQHlcduZjGhWiO3trnI5Xz5NaOW00TUP
 uzstA5kkDghcFRouZEvp8t7ftjWViRldD7mtNr63aGT2uH+GLAKrBmACwmHlmds32LTQ
 205heFn/wbw1uJ5F8Z7N3+tJ6ZOICOk8QjY4/OdDtA1LYhcavrFCQyWTj7HCpE16EgIs
 KPnT/tdyEeC/CfU4AFRVdhrlQwnoPuZV2vWPddp+F4HeuWsNAV/4rDeVEACEZ37bKwYj
 LQU7/WY20D7yeurQWAfvb/mK1VIpIJrw1ugCvFamnnbWJ6EyHkaWvyhvcO+/zvVk8ZKJ
 i0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764679244; x=1765284044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5ktJ3URRVxyV+3D314iN5gIWpL/tXp7W9q0eScT9Vc=;
 b=NQz3pMf6nfMKBND6hGUkcGSx3C/+a3CtV2iT3Tq1eEqAa4COFsHzpNe2ONjn0kM8hm
 VDlztt59RO8dXl2IczLbkrir7W7xiKPtN+iHaL9UK5sRu/js9SBSzEng0WjqRlegUDFr
 04nH+k5ktKgfXVjXkbg0AAu57tUlJajVWfdbPf2Tj9Gv6supPvhMsyq/6hZSCbQcNGbb
 EU6xvT+c/kaM8r9P2iAjqOfWkzqXxIwAXWwhPrx8Egw7y2ZnbVuZog9/QemP+xMMN98i
 NViCO25ADiiWqO/c4i7167wMOZwEIIl2P32QcjQV72eOU+Q3bYvl6KQ3VhW879xoKdUL
 dmDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn+zOFenCmYXWe+anLPKBp+3ojiKX44VZRQ3Go+INLSxM0pW1VJePgispoBN8DRhpgxoc5TM4=@lists.denx.de
X-Gm-Message-State: AOJu0YxkB7IKM3lCMfySNoPQA12bm2RmvBWPhT9OP9LxVKP5Tj2gNQAX
 L93hYtH76aSgpxwS77tgw3I/DrQdEsW+9IrGodHFj0yNpTJxQFxQj37wYU3cNmKsYWljxUDGwnP
 vrhahMJmxY4k0WXTCFJeTVVfe+DBbuYI8rRZn3bHbtw==
X-Gm-Gg: ASbGncva5xdIg2LTSijY55HmW3mE9wVkdqtW5rKa+JDRNjUM6QxW9unaLDfDM6j1VkP
 oKdmRnMe8tdbqmTx1aZyxcm9ml78bI+Ei5P7c706yEKlRSU4Szz/Yda6IBcwekiwpYTo51b0XjL
 Oy1Spf4RuemOxYXOxTS4upgNYCz2/MiJdYLN1bLh9hd75Fl4h4nJEywj3ZgtdQN8x1+19Bl83hf
 R38Yg/jjcJbZ0AoMsbRgNgokqofeTE4QeNTScD22y/t8vjhogEoS+Lf66t8Cmi3jjuakT0f/7IV
 PD38ods8oDBmukZd/l4zMhBaKNYjyIhilR+H9LseoI/8aOlFVRg690h80Gcvj4ZFTaIQyHxrg07
 MTc1rZZk=
X-Google-Smtp-Source: AGHT+IEttf+F4kl4P0P1TX+XVdXQYTkSco74B03+bu3RDKWKyoZZy/0MmFXmY7slyUcwbl6Nnm4rx3cmlAhhEMxWaGI=
X-Received: by 2002:a53:c052:0:20b0:640:cc09:c5d8 with SMTP id
 956f58d0204a3-64302acca79mr26238115d50.59.1764679244475; Tue, 02 Dec 2025
 04:40:44 -0800 (PST)
MIME-Version: 1.0
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
 <20251123225711.227016-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251123225711.227016-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 2 Dec 2025 14:40:08 +0200
X-Gm-Features: AWmQ_blQOylyqsEb77cPm6iEAFgSjScfkyfD8efnVg6nTAvJp5f_lObFcbNyRCw
Message-ID: <CAC_iWjKESMSKCdUKnXistu2NmmRVHhUGaaHkrzQW3N2BzJ3Cyg@mail.gmail.com>
Subject: Re: [[RESEND][PATCH 02/19] test: cmd/bdinfo: consider ARM
 architecture specific info
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, Alexander Graf <agraf@csgraf.de>,
 Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Richard Weinberger <richard@nod.at>, Guillaume La Roque <glaroque@baylibre.com>,
 u-boot@lists.denx.de
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

On Mon, 24 Nov 2025 at 00:58, Heinrich Schuchardt
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
