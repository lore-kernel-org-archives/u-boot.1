Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B104BFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F87845E9;
	Mon,  4 May 2026 14:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lGXq0/ow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D91B784656; Mon,  4 May 2026 14:18:22 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00B06845E3
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ba67b332bbaso572403866b.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:18:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897100; cv=none;
 d=google.com; s=arc-20240605;
 b=iKTS6sB0ZXOKFIC7nisWdCwdDhp8FgdJtkrLEhlFPePC83FUeZG6oYe+KfgJ6mEJTF
 kYHdrL8eInG/yJpquO+24r/QaIL+R75gc6DQD9MClnN/fqAEWxQzitbSxr/TZJi7+ciT
 FaDVG8tzsWDCrEGT1WjkPWhYYveXSy8Yd52O1sWUi20+t+9/Doxo7+xUcn5pMJ8QRkCF
 Qxp5WO1EulEimYhkERaTahFY1YGdsmFy4y0AS2EBEVxNFh/st6TxDkTIeJTr7NRykqtB
 t94gTHJUygAlwUFhPnMXFZ1KuW6z1VLJ8SgzMnFqXhOhf133XbKEm6kk9cU4Sb5ZNHPI
 DfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Pwpdy8Xe6PI7/DAIbw0PnqP214cxn2wIZWtWoCH89VM=;
 fh=jmbcoFG2RPEOJsmPKSiakkV0VWJqP8RiS13G+yktnmU=;
 b=OkTwBcKql+KnlI8YNlKFwEyu1Nc5+yXJtbvnWBiKSOgWoKZd29IGAadlOrvk5hQGDZ
 DxCXXTGqX5WPyw1NF2WcGWr5NF3aVTspTlaY0XkAaac8lH+Qnxt1Op7dlPc2+QU8wlLs
 t0X7Zj3TLciQ67J7BRqwOV50hqbkHV8acp3jAv+0vMdyrgVtH8m6mnibYTxAU4m0+Uc0
 cnx4J61Ij/TdOfR62RGym+PVULppGEVLhS3a4CpzpqHvlQV4ESL3Uvqm9osUHmBUgMzI
 FcjZvr5TcqTfpx7AY1E2xjGdZifp58YQlydxTrEZNFlVw0gZEOhJQfZfdk6dBGA2X1zL
 3lxA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897100; x=1778501900; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pwpdy8Xe6PI7/DAIbw0PnqP214cxn2wIZWtWoCH89VM=;
 b=lGXq0/ow47LCWUmE6qdBFnQ982XBeMsfIZctcl3tUx8mrxf5YqliZEWpyExDMkvnly
 wutdV4F3bzb37TNe7AA+/aHReSScCfN2h0muo6SUoITNwSwdS35dGRsRgNGfxoMvCUcm
 YQPrIOtaGwNOT6guTjTm/kvQBl0q15hNuPX/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897100; x=1778501900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pwpdy8Xe6PI7/DAIbw0PnqP214cxn2wIZWtWoCH89VM=;
 b=hbTCceBvapVfkAjYFICVqG2Gn1Qw0+qoqI9FTfgAdvTsUg2s6xOCCLhvS8+BOLxSUn
 W4okEUto6vR+RIQicCqGjCAIvYoRvF+cRZcxs01E3IgvJS2jCioLAotOSenkbAztQMmh
 tFnF4JlKlNnOJUew3PSl+Epp6+yTfa7YXVBV9TXQn3YevXj/eqCWyK/XgPeggyTmIxlI
 ZT1Fei+PPjeLHtol2iDX6FkQfhMQv/hmXTA789m34IrmXFkg59xgo0ZzY4Wedr20BXLv
 yWfR+v6BCYj5TAmyzzr7n/G+pWCkIM5mj1yhIrusNgkob6eSdYpWbi3riH/5ylckFr/n
 ky9Q==
X-Gm-Message-State: AOJu0YxRe/S+sCV7mrQX6GMIEPfYYTwq7O8zMylAYZOHSHQzz7GvCGlV
 1/fVLRcH0sObMGXAjpffsHVG/CGvzxj6nQWSNfe7IzCQMWCq2E5rbi46KnUln9pq0nucVykBXIn
 jPv2xOfoh3xey3uA/o30Uf3BYbIlkceTrcQyh852IMAD8wl4Vm1ITcA==
X-Gm-Gg: AeBDietS6isx0nkFMxw0stkgywG5rkFyE8uaGOnV6cbyyfCen2PHW4cb1H+tw9BBaE/
 ZjbozXaHc51QKQG68++M2ipWUJUu+K3jRblyhNu8yaoTGG+OZV0Np/ZFy1bAbCtq20SekFxUs5M
 ohSbUvPL4aLBCYnSZ7DZlZTp/qpHZPDCVMkzwYzp1BqtLWHLFJ+FchL4x6OMlFZ5g9n9e/P5mQK
 zihETmAglQRS1f9SxlX2FdUcBkiD24DIbUxIhtt5TXOTwkjtqHBkQk0JODvSqQPrFXNeInN9zJE
 nO8w37I76aQGX9za
X-Received: by 2002:a17:907:9617:b0:ba4:a7a3:d03f with SMTP id
 a640c23a62f3a-bbffaf45fafmr457471266b.27.1777897099367; Mon, 04 May 2026
 05:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777551598.git.michal.simek@amd.com>
 <0880332fd0d61e2f4d497da8dd7fd10c9d65dd9a.1777551598.git.michal.simek@amd.com>
In-Reply-To: <0880332fd0d61e2f4d497da8dd7fd10c9d65dd9a.1777551598.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:18:06 -0600
X-Gm-Features: AVHnY4ItxfSDjEdXCYboOZqTkP1bEv1KKqoeO3iynjAOr3_Qa2mnSZfpXd4tMZg
Message-ID: <CAFLszTiA6Xv_i2AOnsei-tosq7D_aSD_D=mBicFCV=vLRqS4jw@mail.gmail.com>
Subject: Re: [PATCH 3/4] spi: cadence: Use reset_reset_bulk() for proper reset
 cycling
To: michal.simek@amd.com
Cc: u-boot@lists.denx.de, git@amd.com
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

Hi Michal,

On 2026-04-30T12:20:00, Michal Simek <michal.simek@amd.com> wrote:
> spi: cadence: Use reset_reset_bulk() for proper reset cycling
>
> Use the new reset_reset_bulk() API to properly cycle reset signals
> during probe instead of just deasserting them. This ensures the
> controller is properly reset before initialization.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
>
> drivers/spi/cadence_qspi.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)

> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> @@ -255,23 +255,8 @@ static int cadence_spi_probe(struct udevice *bus)
> -             udelay(10);
> -
> -             /* Deassert all OSPI reset lines */
> -             ret = reset_deassert_bulk(priv->resets);
> -             if (ret) {
> -                     dev_err(bus, "Failed to deassert OSPI reset: %d\n", ret);
> -                     return ret;
> -             }
> -     }
> +     if (priv->resets)
> +             reset_reset_bulk(priv->resets);

This silently drops the 10us delay that commit 834d589b8f1 ('spi:
cadence_qspi: pulse controller reset at probe') deliberately added
between assert and deassert. Is that intended?

> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> @@ -255,23 +255,8 @@ static int cadence_spi_probe(struct udevice *bus)
> +     if (priv->resets)
> +             reset_reset_bulk(priv->resets);

The return value is now discarded - is that intended?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
