Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBFECD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B531184BB7;
	Thu,  7 May 2026 18:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jz6dgj9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A14584B58; Thu,  7 May 2026 18:44:23 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 324B384BB7
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so175540866b.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 09:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778172258; cv=none;
 d=google.com; s=arc-20240605;
 b=WH7J2S2H+hENT4hY/aP14KbiHSiZs4KJKTU7ttJLTDleEZs0HFUG9dN8HDvtM63uOE
 XBvLuLyBZesBlO9YNJg668qc38lZsnv71SEVyDx2hadssjz89wuPpczz1I4wQk76p15G
 E0urwV0bI/32tuE3O9RUWn9lhQTS04hohshhXg7gOenFiReZT17W/cpAKGSwxBrj1PRw
 X52qQCnskhrYNHQqWGi0j5bSoppbI56kvv3rosaQ6zsaa6638KpFfdqbRaFvyRoIHWgd
 qYnalNtEDAlP0+VpFwR8WKDXCx/W8X27tMV9wu5XEs2AaPVy5j3Y76eFyEAdIHhXsiMI
 Pv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=abqgcV8ObCv5cM1v8CBKHmg08FBqdpUxcmtcgkY2Tjw=;
 fh=oHA4XbAgLOUN2o4rTr89cig2bJ58UhQLNNObawHCHTU=;
 b=DNzJMifRw2Gqm+1qbB2UCsLBmhyornrPfybPIJWTxuwK1Mywg2ZNBHeKrSS7d9lPHu
 2pXVsHkEB1Yzze4XaiXIqOeUgT/ST1Bbqo+KRUKdky9WRaGw+t+IMOgZwBZ6WSUV3yAx
 EAkj85M5yP7SIlF5TRNBWknRBzMsk8IxMukDPoZdVTJvwZJSy+4khYWCrWiuKWN6CLrW
 GjNs3tSU8wX4dolCgHoL/Kb9xwJTovliAGyZFIequ/jV+n6opvn/FPj+6UU8YBGeDvIC
 X2YJ699aW1oaff16w9RU03mariftQIzDLbWkEW4Ax4yXx5xSIog4B9GIXJu6/YoiRBo7
 /chQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778172258; x=1778777058; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abqgcV8ObCv5cM1v8CBKHmg08FBqdpUxcmtcgkY2Tjw=;
 b=Jz6dgj9kGBHKI1wsIz+3kFTYR+J687wFKtFsSP/06RDy15DGvjLMx/cLL9wxrEi01H
 Y99rpZkE5PFw6YJAMYSdXiaXHoyh4xe+TgzP2QbS78Y1WroOUFAss0ra4YUsdoNjMJsY
 HavQabNqmJShrF9U/Ss42iCPSzKCGsVAN6tOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778172258; x=1778777058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=abqgcV8ObCv5cM1v8CBKHmg08FBqdpUxcmtcgkY2Tjw=;
 b=dmJjQTJUqCVlNyyjx6N/cm6cGe8e51ayyDGv6l+6S6y4cpXzsVy5qK4T/SIOuBz3ff
 Obh7OvkA+nrYEdUoz+Whbbu2ue2z7KU2YDPXX28vxjT6RLLYUDyHv9uY0EcogvpeuYPB
 ok3VP5etQI0+WwdVVU8ngvqlXsIdC2yMgqiHLpBparfBbkialkX77+8/XfV+J0gHJ/aE
 fyAqKW4NJEAdCI7F47j2Fkhin9gIWurWuMOhzsIqifmUVB/b9ppM3gV2TmsU4+popHMy
 hShvFDGN6zkDX5DjeILI9LYruHrnaPedG8lavWSuEOLi/q45TM+tWipxnm786Vh1q2o6
 E1DQ==
X-Gm-Message-State: AOJu0YxROpggxB1JUlssrQESZ4JaIQq/pwn5EZ1R+Tss7eviABJQrQjw
 hRF2M4KTls9eQyNaeD8lz/zCNf7h6WgAdQ4lsMwrofmHFEg8ZRje4IAcD5I9iU/y0aYmy2/7Eg7
 T8bNh2UOv3yQu3ldhpdDEA1GObkPRL1aVZY247DHR
X-Gm-Gg: AeBDiesaDtC6MjSa+XVmrBjfeUf1K8j2Ajr168Zq30eajpw+00BhFWvfK9nZpoAkjYy
 9ieE/lSoPdfsaZC0U8M7DGIgsByOf2dyC+GJyLJHQgDJwLb+Q/BILDB927HKXZP4aoqYwyJZhwW
 9I4MQKrdWN1maMetSMXDWVIoQPBlDkenXiEQXtyCKZpsC+oAB/5WaVUyp5VymBXcsHsnrWaKaNp
 cpf5bcYZtWpWo0VIAQ5ODvBPjyKaSEoOJnerXiVhstTiMhDPVArhYUDOCwM4JIwYZBBUhT5QS8W
 U6W/qCBDAG8YvDdR
X-Received: by 2002:a17:907:3c89:b0:bc5:7c6d:865d with SMTP id
 a640c23a62f3a-bc57c6d93c0mr499760866b.35.1778172258368; Thu, 07 May 2026
 09:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260507120735.310325-1-ludwig.nussel@siemens.com>
 <20260507140624.v3.3.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
In-Reply-To: <20260507140624.v3.3.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 10:44:07 -0600
X-Gm-Features: AVHnY4IgYwKuP7yAagWbMaIY5sFlcZ7bIyk84YF6_j2vQUIb1nK15diwJoGWfy4
Message-ID: <CAFLszTiyCTSG-cXeBU6kKsOFjwVjb4HrggnMPt5syRFe6dghqA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] image-fit-sig: Optionally require signatures
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>,
 George Chan <gchan9527@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martin Schwan <m.schwan@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On 2026-05-07T12:06:22, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> image-fit-sig: Optionally require signatures
>
> If U-Boot is built with signature verification but no keys are
> included in the device tree, the boot would still continue.
> Introduce FIT_SIGNATURE_REQUIRED to avoid a fail-open setup. The
> default is enabled which may break existing setups that rely on the
> insecure behavior.
>
> Consistently use log_err for errors in fit_config_verify_required_keys()
> while at it
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> boot/Kconfig         | 10 ++++++++++
>  boot/image-fit-sig.c | 22 ++++++++++++++--------
>  2 files changed, 24 insertions(+), 8 deletions(-)

> diff --git a/boot/Kconfig b/boot/Kconfig
> @@ -124,6 +124,16 @@ config FIT_SIGNATURE
> +config FIT_SIGNATURE_REQUIRED
> +     bool "Require signature verification of FIT uImages"
> +     depends on FIT_SIGNATURE
> +     help
> +       This option requires that FIT uImages are signed or boot will fai=
l.
> +       That means the U-Boot device tree must contain a '/signature' nod=
e
> +       and at least one public key with required=3D'conf'. All configura=
tion
> +       sections of a FIT file must be signed using those keys based on
> +       'required-mode' policy.

Just a few more thoughts.

The commit message says the default is enabled - please update to
something like 'defaults to off so existing setups are not affected;
boards wanting fail-closed behaviour must enable it explicitly'.

Also, since fail-closed is the safer default, can you say a word in
the help text about why a user might want to leave it off? Right now
it reads as 'always turn this on'.

> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> @@ -632,15 +632,16 @@ static int fit_config_verify_required_keys(const vo=
id *fit, int conf_noffset,
>       /* Work out what we need to verify */
>       key_node =3D fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
>       if (key_node < 0) {
> -             debug("%s: No signature node found: %s\n", __func__,
> -                   fdt_strerror(key_node));
> +             log_err("No signature node found: %s\n", fdt_strerror(key_n=
ode));
> +             if (IS_ENABLED(CONFIG_FIT_SIGNATURE_REQUIRED))
> +                     return -EPERM;
>               return 0;
>       }

This is a behaviour change for users without FIT_SIGNATURE_REQUIRED -
what was a quiet debug() now prints an error on every FIT boot when
the control DT has no /signature node, even though boot proceeds.
Please only log_err() in the REQUIRED case and keep log_debug() for
the permissive case.

> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> @@ -632,15 +632,16 @@ static int fit_config_verify_required_keys(const vo=
id *fit, int conf_noffset,
> +             if (IS_ENABLED(CONFIG_FIT_SIGNATURE_REQUIRED))
> +                     return -EPERM;

In U-Boot the convention for code that may be compiled into SPL/TPL is
CONFIG_IS_ENABLED(FIT_SIGNATURE_REQUIRED), which expands to the
SPL_/TPL_ variant in those builds. Please use that here (and at the
second site below) for consistency with the surrounding FIT_SIGNATURE
handling =E2=80=94 see CONFIG_IS_ENABLED(FIT_SIGNATURE) usage in cmd/bootm.=
c,
boot/image-fit.c, common/spl/spl_fit.c

You may also want to consider whether an SPL_FIT_SIGNATURE_REQUIRED
Kconfig is needed, given SPL_FIT_SIGNATURE exists.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
