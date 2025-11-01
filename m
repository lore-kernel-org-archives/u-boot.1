Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DD9CCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 09:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB16D83A5A;
	Sat,  1 Nov 2025 10:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZKBcarRQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D30183A36; Sat,  1 Nov 2025 10:04:14 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC98839B9
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 10:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b6d3340dc2aso804017266b.0
 for <u-boot@lists.denx.de>; Sat, 01 Nov 2025 02:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1761987852; x=1762592652; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RqisBkHJ2je7rX7G4nHYoJ/GwbZacV4LJuUVB3qY7CQ=;
 b=ZKBcarRQHiHp+UVUH+q7eSyiABuweYqKui1c2z9X8YIu7Y9GC12YP5CCRrb0fsa5d3
 rO37gO+ar/qDmq7WcvkYXj/FFnWrR6Mk9eSlm/EFbWfil0fdzyBepv6hp9ZMyrUvFeGC
 zCnhPk7LfCRQPPbtD38ofuNfVCSh56UiFVeMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761987852; x=1762592652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RqisBkHJ2je7rX7G4nHYoJ/GwbZacV4LJuUVB3qY7CQ=;
 b=iPNA81rDbmx3Jeznq7cMr2mnQaBKElMbY3e1VdJxpEPUEeQemRfaWChOVioFOABNXu
 9SWjDS8RpqKzk1nveCdy6wzDQBdQa43rqVzonNcrHHzMA1tlygSOXGZdMeL7FKCW3vEf
 SBLhoE0is6OTHgXUDqsU4+HMu2HM5nVXju2o1taxIIcUuE9NrPW7zm/qQ/Dj6u+1/adr
 2LtlwdOnsCHQkKvS08/XOy/t9yPPZfOgsPxrDo8LD2cv0pO4ILxopOOTeuTcZ1FUDR9V
 uMonDzKPKIm49orOCr43QpCWc+2F3WgMie+AYsiDrvLSTcqkZ/788npA8LbmCDKKgsHo
 WR4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW8gfy/Cj2P5iJ8CWsKaXaFA0odYEKe7sjm7KiOHbh3ktqIzhFe9Od6uyk4sdi6CyEnxvxRUM=@lists.denx.de
X-Gm-Message-State: AOJu0Yxd1y18MhFiy0WEj1PebODC/aQaKk6ue0zIkXcUkpSUrwWiQ+Yf
 yCfBhLNNvVBd8qGvcpa+yaDUYJiSJluikehL2YcnTkI7Gk2pNRPci+0KFCbk7ePVe1Fkati/s8+
 Q2eReVcgPxANpgNmE5NtsKMYSehLz0Ct+6gx/ET85
X-Gm-Gg: ASbGncuC8WnY7P/uxHrTBN8kqkVssyFvdQWaJ5bbHjvIS7cHNNexbB3JMezUh1Mgfvg
 icGhERHoqWTBbwBS58CYNWHcMUK7cExjQyc7sCmzSDKE/nMN7Inhb4vfqCoAAo8VKT4SQjg2Z82
 p1hAeRtnVBv1wndAzRfRR1QQDRGDOIIe0gib947vzA1YMMHyUaed+Bb5FPVOeGDaTX3aWfvUCxO
 Mm2xlLnAp1Nym1PqwND4w+Y0tL+ShCLJ0pSRzvxNSlZNI9nrh+gGCUfMRa4wwN0QuxB4Ys=
X-Google-Smtp-Source: AGHT+IFwOIO6aOgy7fswsGuvWjzeJES+dMPTreoYl8gxqFStPlCBHvnlQk7V3v590T2H+sIVGwbc8XMgto5eMLDNzE0=
X-Received: by 2002:a17:907:6ea6:b0:b6d:6026:9f1d with SMTP id
 a640c23a62f3a-b7051f27e9emr1036713166b.1.1761987851852; Sat, 01 Nov 2025
 02:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250904-master-v3-0-b42847884974@foss.st.com>
 <20250904-master-v3-1-b42847884974@foss.st.com>
In-Reply-To: <20250904-master-v3-1-b42847884974@foss.st.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 1 Nov 2025 10:03:59 +0100
X-Gm-Features: AWmQ_bk-kd3YffpUBHGdTcqb2J8FUlXC2bINTQamEUoJy-kpddgT3ym8YhzoRLA
Message-ID: <CAFLszTiT9iLx6gguhVui2Qh0Ew89yhvpDggKwPo71cB+Rv=xJA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] ofnode: support panel-timings in
 ofnode_decode_display_timing
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Dillon Min <dillon.minfei@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Philippe Cornu <philippe.cornu@foss.st.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>, u-boot@lists.denx.de, 
 uboot-stm32@st-md-mailman.stormreply.com
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

Hi Raphael,

On Thu, 4 Sept 2025 at 14:53, Raphael Gallais-Pou
<raphael.gallais-pou@foss.st.com> wrote:
>
> The "Display Timings" in panel-common.yaml can be provided by 2 properties
> - panel-timing: when display panels are restricted to a single resolution
>                 the "panel-timing" node expresses the required timings.
> - display-timings: several resolutions with different timings are supported
>                    with several timing subnode of "display-timings" node
>
> This patch update the parsing function to handle this 2 possibility
> when index = 0.
>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Reviewed-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  drivers/core/ofnode.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> index e040e3f2806ffe74c58dcd82f36307351acd5a99..5a721b46e5a3214e7bd437739776362c2d22a3c9 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -1221,13 +1221,16 @@ int ofnode_decode_display_timing(ofnode parent, int index,
>         int ret = 0;
>
>         timings = ofnode_find_subnode(parent, "display-timings");
> -       if (!ofnode_valid(timings))
> -               return -EINVAL;
> -
> -       i = 0;
> -       ofnode_for_each_subnode(node, timings) {
> -               if (i++ == index)
> -                       break;
> +       if (ofnode_valid(timings)) {
> +               i = 0;
> +               ofnode_for_each_subnode(node, timings) {
> +                       if (i++ == index)
> +                               break;
> +               }
> +       } else {
> +               if (index != 0)
> +                       return -EINVAL;
> +               node = ofnode_find_subnode(parent, "panel-timing");
>         }
>
>         if (!ofnode_valid(node))
>
> --
> 2.25.1
>

Please add a test for this in test/dm/ofnode.c

Regards,
Simon
