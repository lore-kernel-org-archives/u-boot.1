Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991BAE67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 16:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2673D890D9;
	Sat,  2 Nov 2024 17:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EHS1zr53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9DF0890D9; Sat,  2 Nov 2024 17:33:36 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A3188F24
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 17:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9abe139088so425170466b.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 09:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730565214; x=1731170014; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g9ww2jLNUCoU4JdvIMb7yHlmCjNib92TKv2iO2dpPHA=;
 b=EHS1zr53ZaEoWMejcu1t216xj0B/kb1GMPh4x8zYhiVS1ij5mM43NKLfuhuK9MoT9B
 KSXLGCaDSKrfkWE6KSSrUhgQLiKMD8nbL3/f/YwW8NugRhHUugrbOCU0H17efI4xOx7O
 TkXgL0hwb7a1ZB2n2oR2jMoG9F+rqEE94lnZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730565214; x=1731170014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g9ww2jLNUCoU4JdvIMb7yHlmCjNib92TKv2iO2dpPHA=;
 b=EQcxoMu6NPRy51dToH/TCk852Ty4drcado0CRFr4JhOubg2EuWrTtu1qvrNsrd2aFC
 YqAehbNVXY3b1NLXzA0feNBdQU5U4PDGfyKSgezROYWCP8pSFIpdiuNaZXBdPrZyJUwp
 2wGEcjlCesrJy9g0ysF/ju/wGibNYk62wwJ1S6hmKeA/IhuYUinC0TUtics6iJpk5aeq
 +bn+teJL4DuR0280cRYs4Yg86hg9nwuhA4wARMDJ78XHxkCRoOV4+LFMSf96YahNdGJy
 Qy2fBuCaYggBBiPOE3wscdHrS6CntUYPYw/ggdBtmmLBGsmqVLeQ0lPWo+DAiUNdAjvL
 A/6g==
X-Gm-Message-State: AOJu0YznMt7FSFXQ0rjmaMIy+YD4KUGWgmVWfBtShoWx3xmtBG0CcS2c
 YkUuB/4j0VtR3sriPreMRA0MU40K3GQ5H6drl2tIiYlwpXK3eCBnloFhPTxT6Di64baxi1D3+Ji
 BamoMgiHK9PptwGA/vl5V6nCqJh9pdtHvZcdxclOJl0NVO8P3ft+T
X-Google-Smtp-Source: AGHT+IHfW2ls43DmvzRQWn/Tpg1Gfkr/GixtLc0AxYrFrY28onosT53IJ/hpC8efYQt3sDY1cjtK9rbfX54WZSzLK0c=
X-Received: by 2002:a17:907:60d6:b0:a99:fb10:1269 with SMTP id
 a640c23a62f3a-a9de5ce4ad3mr2854733766b.17.1730565214198; Sat, 02 Nov 2024
 09:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241101133848.2278151-1-andreas.gnau@iopsys.eu>
In-Reply-To: <20241101133848.2278151-1-andreas.gnau@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Nov 2024 10:33:20 -0600
Message-ID: <CAFLszTiJzLmm2MjbqphexrtmBNMLWB2OfveC_0mdbY_4gkP7AQ@mail.gmail.com>
Subject: Re: [PATCH] fdt: Update fdtcontroladdr if fdt_blob changes
To: Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: u-boot@lists.denx.de, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Andreas,

On Fri, 1 Nov 2024 at 14:40, Andreas Gnau <andreas.gnau@iopsys.eu> wrote:
>
> When a different FDT blob is chosen via fdtdec_resetup /
> board_fit_config_name_match, update the fdtcontroladdr environment
> variable accordingly. This fixes an issue where fdtcontroladdr would
> still point to the previously used FDT blob.
>
> Signed-off-by: Andreas Gnau <andreas.gnau@iopsys.eu>
> ---
>
>  lib/fdtdec.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index b06559880296..e3534b647556 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1759,6 +1759,8 @@ int fdtdec_resetup(int *rescan)
>
>                 *rescan = 1;
>                 gd->fdt_blob = fdt_blob;
> +               env_set_hex("fdtcontroladdr",
> +                           (unsigned long)map_to_sysmem(gd->fdt_blob));
>                 return fdtdec_prepare_fdt(fdt_blob);
>         }
>
> --
> 2.47.0
>

At least as it is documented in doc/develop/devicetree/control.rst
this variable is used to set the address of the FDT initially, rather
than reflecting its value after that.

I suggest instead that you add something like:

fdt addr -ce <varname>

to set an environment variable to the current control-FDT address

For your commit message, I sort-of understand the problem you are
seeing, but not why you want the control FDT in an env var. Can you
add that info too, please?

Also please consider how to test your change.

Regards,
Simon
