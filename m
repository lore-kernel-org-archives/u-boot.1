Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C069FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0309D83FEC;
	Mon,  4 May 2026 14:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CoFxpECc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7B7284659; Mon,  4 May 2026 14:26:42 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 774868394E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bc1f0f48351so141969466b.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897600; cv=none;
 d=google.com; s=arc-20240605;
 b=f+XQNC/uoo75YsRFlSXY+obUME0iDJeYh2V7Xk3EQftqQsSxB8dERNEhf1ZWqcjwnX
 K8Yffh23mn2iV3GJrs01erLVrCvPyZSSC6mss33oEwTYkP6qTBpzqqE5bX4qux41dTzF
 vs4Nm/xW46D+x63wdhQwHnMyv3iynK+gd0RaFyhN8g6WyWHG9pfLgbQLR0KYiWmmA6vV
 26vd0ZtvVmK6SHJmhwga2YlEWvO2vY2pbt726tbCCF6kM17NdV0IY0E/LLc5eV6QKo1h
 s8N+wuAxsKOkqBc/wgwZMnceWDmefbrjs5aVCnrDB66mUughCyr7shxGWvmBjYMuzrHl
 ZZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y76pDYz/nbN939oGYhl/zfGg/AP8gJjfYX3ESgTpZXE=;
 fh=RsRYtTyPonxadUZAri9iyMFo/cRKZyv4RBBlyQb6vo4=;
 b=NkGqQyKSlo38d7umS20EbeR8V3Q95pS6HqzP3gdSFRVzIFO5fGiZS7V3PmIYOrXPwg
 UmcwwG62eXO57SwQ9GMX19H/BiwA5ioA/PeSTKDXOb6xxEkysyHcbPAFAD0OqeOTEDsQ
 TgR3AVaZZJBQnMxJ+kAEzSiSTsrtP3vGWo0q8Febn6fQNfnGJhQsKWLT/HUBCRDvBqu2
 3/UpQCJeob6iRIvjxe7qFkstcrtqdDOvNNWXIxfCWT9X967X+E9ixgx2H2GOlWZBpB92
 uaG4QY1iWuQAU97xyyGhEx6iCwynFkJh9lJWdGQH5jGBOWvhioDspCv+sEPKqApEXO0G
 /wrQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897600; x=1778502400; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y76pDYz/nbN939oGYhl/zfGg/AP8gJjfYX3ESgTpZXE=;
 b=CoFxpECcsfTn9Xc0gY2jeIMe2bwcA6FBI81KhPSinfmgFqttoPFL+cN70ELe+grk2b
 nVmExYRvN3vkelYoRa9+v92LBpIR8isbm2FdDgdHo29utg+ynOItzUJrXMtPrJSF92wi
 s5vNWZikah3RGolWcrry4n9N8TMozH7NaoIEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897600; x=1778502400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y76pDYz/nbN939oGYhl/zfGg/AP8gJjfYX3ESgTpZXE=;
 b=Wc7XOCxqTQWctbWl24dpUabsz61a7VnURA1qD3TR9c/JOqykK5zS2OGvGbIrT3oQry
 xHNKuH1w5y8p6mmMdJDC2nh+nZmpp36UH5w2uKg9ttXlkXy2xitH7hAJrfWPWx4vHwfe
 ZIUwBif6fOVoWBNcJtWoAyM7+nsezThnHnRpmGGt9SpEQ3CV1JsUJIsQKEbsj2eZpmkY
 lEQa85EakZgcuj5Tf/pAjFaEUkEfd+UcaLiC0h5MSBRGys/7hwwvELwBtYgbxEANVdNN
 dKDeMMCUK0eaCXyuM7dyImMfv2ezdcnoADTCy/RJNue1IFcTPxFlReHf8vpCeOCI/Bv1
 3qug==
X-Gm-Message-State: AOJu0YzrifyIfXFWoQt14HmSUPU5/ftLNeg9Nt1yZAMQkt9WqYSWYK+X
 sKQxqbh/hmR4APKBn46I+WN854RjB78afPiOSR2GajfO2QleoRT7AqgwMOr3XQ2YrRfP+nNy/7B
 jLGPq9y69swokk/tiHnX8FdP4Azt1xzGabDudEp7O
X-Gm-Gg: AeBDieuNfHmDHsSKzVG5z/y/agLIqpXZUtkHcBodr9jLiiWzNwMY2ExF9xn5kHRdk/2
 LQuowdJFyl5qPrldNnoWL8Ha1kO2PwLNG8QFZHQ+dFDFGNxBfSYMNN+TLnGCGC91N/IRIslGC+m
 zHTbFTUlVBv8KuqwRoAKjNv5vRgNBnnkhf1maTyO4bii8x2ZT+TzP5psmfF6WjIksAzaMW+17yR
 W2R93iOUbOu6e375li3/8wpDbDnP7r6BxBgFrrT11hBBdX3/NpYqU0u7iqawTDsSVDCUts381V6
 35lt/23gls5g1LNc
X-Received: by 2002:a17:907:ea5:b0:bb7:beb9:b6d5 with SMTP id
 a640c23a62f3a-bbffbf8531fmr532577866b.39.1777897599753; Mon, 04 May 2026
 05:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260430122629.606153-1-ludwig.nussel@siemens.com>
 <20260430142602.v2.3.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
In-Reply-To: <20260430142602.v2.3.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:26:26 -0600
X-Gm-Features: AVHnY4IzUxAZcTeKryG93lPePb_Hxl42SX9s-CP_8Q61_SHDqTHO0noJijkeDIs
Message-ID: <CAFLszTgtcho7vXgfAdAv-CDg11UtwJk_MHXS=u=cB-RK-mg2LA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] image-fit-sig: Optionally require signatures
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>,
 George Chan <gchan9527@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi Ludwig,

On 2026-04-30T12:25:59, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> image-fit-sig: Optionally require signatures
>
> If U-Boot is built with signature verification but no keys are
> included in the device tree, the boot would still continue.
> Introduce FIT_SIGNATURE_REQUIRED to avoid a fail-open setup. The
> default is enabled which may break existing setups that rely on the
> insecure behavior.
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> boot/Kconfig         | 10 ++++++++++
>  boot/image-fit-sig.c | 12 +++++++-----
>  2 files changed, 17 insertions(+), 5 deletions(-)

> diff --git a/boot/Kconfig b/boot/Kconfig
> @@ -124,6 +124,16 @@ config FIT_SIGNATURE
> +config FIT_SIGNATURE_REQUIRED
> +     bool "Require signature verification of FIT uImages"
> +     depends on FIT_SIGNATURE
> +     default y

I don't think we can flip this to default y in one go. Any board that
enables FIT_SIGNATURE today without a populated /signature node (or
without any key marked required='conf') will stop booting after this
lands, with no build-time warning. How about making default n and let
boards opt in?

> diff --git a/boot/Kconfig b/boot/Kconfig
> @@ -124,6 +124,16 @@ config FIT_SIGNATURE
> +     help
> +       This option requires that FIT uImages are signed. That
> +       means the U-Boot device tree must contain public keys for
> +       verification and all configuration sections must be signed
> +       using those keys.

"all configuration sections must be signed using those keys" is not
quite what the code does, i.e. fit_config_verify_required_keys()
honours the required-mode policy (all vs any), and only keys with
required='conf' participate. Please reword to match, and mention that
boot fails when no /signature node is present in the control DT.

> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> @@ -639,9 +639,11 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
>       key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
>       if (key_node < 0) {
> -             debug("%s: No signature node found: %s\n", __func__,
> -                   fdt_strerror(key_node));
> -             return 0;
> +             log_err("No signature node found: %s\n", fdt_strerror(key_node));
> +             if (IS_ENABLED(CONFIG_FIT_SIGNATURE_REQUIRED))
> +                     return -EPERM;
> +             else
> +                     return 0;
>       }

With REQUIRED=n we still take this path and now print an error on
every boot for systems that have FIT_SIGNATURE set but no keys. Please
only log_err() when REQUIRED is enabled (i.e. when about to fail) and
keep log_debug() otherwise. The else is also redundant after a return.

> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> @@ -685,8 +687,8 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
> -     if (reqd_sigs && !verified) {
> -             printf("Failed to verify 'any' of the required signature(s)\n");
> +     if ((reqd_sigs || IS_ENABLED(CONFIG_FIT_SIGNATURE_REQUIRED)) && !verified) {
> +             log_err("Failed to verify 'any' of the required signature(s)\n");

Just to clarify the new failure mode: with REQUIRED=y and a /signature
node that has keys but none marked required='conf', we fall through
with reqd_sigs==0 and verified==0 and now return -EPERM. This is OK,
but the "any of the required signature(s)" message is misleading since
none was required. Please use a distinct message for that case so the
user knows what to fix.

> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> @@ -685,8 +687,8 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
>               }
>       }
>
> -     if (reqd_sigs && !verified) {
> -             printf("Failed to verify 'any' of the required signature(s)\n");
> +     if ((reqd_sigs || IS_ENABLED(CONFIG_FIT_SIGNATURE_REQUIRED)) && !verified) {
> +             log_err("Failed to verify 'any' of the required signature(s)\n");
>               return -EPERM;
>       }

The other printf() calls in this function ("Failed to verify required
signature" inside the loop, and the @-name check above) are left as
printf(). Since you are converting messages here, we should probably
convert the neighbours too so the file is consistent.

Regards,
Simon
