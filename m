Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE1FD4A619
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2AA2830E4;
	Fri, 16 Jan 2026 11:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EbCVeI1G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 497D2830E4; Fri, 16 Jan 2026 11:01:15 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6F6C83623
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-78e6dc6d6d7so19156497b3.3
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 02:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768557671; x=1769162471; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MM6XeCq/YQdBoxFt9PsMgatWvlct1NV0JkCMX+PtOLc=;
 b=EbCVeI1GlS45L+lTxeQ09CnTEqmLl+l2yAFXI/+zanaTDPT6lD/c3ZJrE1hSoGImlg
 iO1KQzsdqOyvL/DSX9a8QLrFtSCcg/hNuTBSEY+sv5K2XHmHiTLuAbbbVLppgL6DWuhx
 xttXqoqymxE//al6laq8AK+OMRJ12kd+oVl2YVbcx5q57jdqFs7ajS+6fpKqoWWB4A/k
 7vyjbQyTG6e9d+cw7oz8kEnLreJo+UVA6Oo12YhzSoCfGfD/pYvh3w+66ZTbTu/W/0m6
 pyTpGaQTMdktbZA5c80otuKfxOJIGH0HiE7XVjs5wHlQ2FNAq9N3d1kd7gP9HeNOZMsY
 h8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768557671; x=1769162471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MM6XeCq/YQdBoxFt9PsMgatWvlct1NV0JkCMX+PtOLc=;
 b=AvTM8h5U+7kRubi7GMaGpmin6uV6E76kdkbiYVDc6KAoRt2h0K3D6Ip9WKF+np12eT
 WjJFGT8HzhNzfYNbl5Qhy7yiEsP9SsPTWg/NAu2VcqMz5PAY41RQyFQXV6CUuLJLWPSA
 Bg8+w7tFLTvrRuU0QNb44zP0FIWBBPw8dYq07aaNsKVpdHtqCE0nhpq/pbPaFXIh0XTw
 KIYwDnfpTaw6fw5CEssk7XLRosnl1OpgdLgROntCZy16WlOEh9C9RjO+gYTNOuT+UAAW
 e6fqPI+FNe4zZq9LNybf1/0oSFBj62XfcLWXbRtmp3rN3xPCTkGW5ABxYBwiAMRA4ijj
 OOzA==
X-Gm-Message-State: AOJu0YyXLLSC2YW1XSDJ8JnCUrskvEMSCtDQPqq47nLd/T6a1NLahBG3
 ZuSPQPym5AbkafZ/jfeqCqrrh5w73fB8igCv62qdK7jONxT0NuEhomsn+jSPWbnvZRvyPfbDvbo
 Lx5gjnBw4MF0d0P0lNd1kVaUfM+YnTl5zKPLBkT1RRg==
X-Gm-Gg: AY/fxX7wvtLixkhQa/l2d0v1MdyB1iXB6434lv6bC7VTpGyz1GIiTSlzEqo87m4N1WQ
 k0Qg09mvBy6yQ5J/samxyAUonaTj8+iRDnaz57hlRydvLYZXHzg82cdkU6nU/yZkH1RBV7RIXnP
 VC4lQPeAxI3jvchSladKaNGOGzadAqj0fnxOEq8V5yy8gMAnthTmEv48iNpKasru4Z17zan2gf8
 S28UY7h4G46OJafEJZALb9Dx5cNQUx9LtqLZlyjkAdP+LEd8mQ7Y0EcuFMBZXpbxS5WV2vNDuS0
 WMHlLujdcwewUkYKN89xFL4bdE1Vs6lNV2EJIQrjh75CRA0F6Rcbwkn9u9JWD55IufXw7lvYJFE
 XcdiksmC+Ez9LmH5erBY2NaY8djeJGXtqvOOWdDSFXmg5Aya2HQPX6ve02PBI/b3jco9aMQ12z1
 JrC6b2WpvxZU0kYDWI7G8fplqVp7R2y9XySPxThZbhaETt8JNu/oXv4Qpc4Y7XZfeeMTRCS3PR9
 Aty9ddDAqQDnBEQol1Jpl9mqk73LvRjdgSVN4tPULydSVLIfaL2WCNLR1DJRaA6eOQOX7GQ+u68
 tZ3xA6JiIbccHJof/bJskxtr89ThmQDK6/i3ch7QV60=
X-Received: by 2002:a05:690c:f96:b0:78f:aa6d:48de with SMTP id
 00721157ae682-793c6426151mr18448367b3.0.1768557670724; Fri, 16 Jan 2026
 02:01:10 -0800 (PST)
MIME-Version: 1.0
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-5-trini@konsulko.com>
In-Reply-To: <20260115222828.3931345-5-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 16 Jan 2026 12:00:34 +0200
X-Gm-Features: AZwV_QgavaAeUJe1yXKiLq153XtS75ywb8SdPcgwyDkNvtmO2OqNLGvJ11nh-AM
Message-ID: <CAC_iWjJq-uQQRHjn+WPcUEobT0eAoKi161DjAtx2BLrBoHCB3g@mail.gmail.com>
Subject: Re: [PATCH 04/10] microblaze: Update linker scripts to ensure
 appended device tree is aligned
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Beleswar Padhi <b-padhi@ti.com>, Michal Simek <michal.simek@amd.com>, 
 Richard Henderson <richard.henderson@linaro.org>
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

On Fri, 16 Jan 2026 at 00:28, Tom Rini <trini@konsulko.com> wrote:
>
> With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
> v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
> device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
> Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
> that we must have ALIGN(x) statements inside of a section to ensure that
> padding is included and not simply that the linker address counter is
> incremented. To that end, this patch:
> - Aligns the final section before _end (for U-Boot) or _image_binary_end
>   (for xPL phases) by 8-bytes by adjusting the ALIGN(4) statement to be
>   ALIGN(8) in the final section before the symbol.
> - Ensure that we do have alignment by adding an ASSERT so that when not
>   aligned we fail to link (and explain why).
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> ---
>  arch/microblaze/cpu/u-boot-spl.lds | 5 ++++-
>  arch/microblaze/cpu/u-boot.lds     | 4 +++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/microblaze/cpu/u-boot-spl.lds b/arch/microblaze/cpu/u-boot-spl.lds
> index 09abbea84d06..620ef2c96dbd 100644
> --- a/arch/microblaze/cpu/u-boot-spl.lds
> +++ b/arch/microblaze/cpu/u-boot-spl.lds
> @@ -50,7 +50,7 @@ SECTIONS
>                 *(.bss)
>                 *(.bss.*)
>                 *(COMMON)
> -               . = ALIGN(4);
> +               . = ALIGN(8);
>                 __bss_end = .;
>         }
>         _end = . ;
> @@ -61,3 +61,6 @@ SECTIONS
>  ASSERT(_end - _start <= (CONFIG_SPL_MAX_FOOTPRINT), \
>          "SPL image plus BSS too big");
>  #endif
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/microblaze/cpu/u-boot.lds b/arch/microblaze/cpu/u-boot.lds
> index a2c8fb2e21c0..70fa49c31712 100644
> --- a/arch/microblaze/cpu/u-boot.lds
> +++ b/arch/microblaze/cpu/u-boot.lds
> @@ -67,8 +67,10 @@ SECTIONS
>                 *(.scommon)
>                 *(.bss*)
>                 *(COMMON)
> -               . = ALIGN(4);
> +               . = ALIGN(8);
>                 __bss_end = .;
>         }
>         _end = . ;
>  }
> +
> +ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
> --
> 2.43.0
>
