Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59256CD37AA
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 21:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2BB184C01;
	Thu,  7 May 2026 23:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fU598CWL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 085C184C06; Thu,  7 May 2026 23:11:45 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AF9C84C00
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 23:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso241561566b.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 14:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778188302; cv=none;
 d=google.com; s=arc-20240605;
 b=hh37UCKZ7y2GuVVza12LiWbnR55dWe7PZEoifBCN/B9FmaYChEvhX4I+fVeHD8sIxT
 3kITr26ppihOaUIwD3vkOlmGCpcVIFLRqIrmSDAQCDBSOxcF7kemNzOpblN4DUdePWO7
 i6g8SZfqKBxSdCIwgI/Syy06gvpr7Lhk+FOA00VORayNlaBvN15wD8DvU/drT1lusda+
 bq7wZpLGBXfaaQDbsKvOD8Vh4cwENPHU+ogwIu0E209AEDPJe+5fFrA3gszZ2wccOXeJ
 /Xn/u5sil64AJJoXt5rm4wv/NsgTySaREmUgXYQT3wPXs/YZsFZfBrGavLKeNiuzAzwA
 /a4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bK/0D/p5+4zoQFJqaRHmQRuhxmVLHc59YXdX9p0j6ms=;
 fh=qmb99AbYrxQTqbU8c3YoikZ37BstHm/br0rQHEGk45c=;
 b=bC/VtUUeuatwVbl67/7uHXTyQpyAmRJGDwrzYPiG5Ypmy3pXFj8IKBtrSyVwqSA6rA
 avf6ganMeSB6SzsPIgD9AH1BKuxEa7iCRRfGIhzkk5X+2UZgCg5T7PnUmWiYTXwOo9Fn
 umbckAhNRV/ebZoTB/Llyb2m5zfNK7Ip2/CIBYUC5dYsiqWi9HoG1LQ+r4qC73PdWwR0
 H/Nj5UUYKmTf4WXk1mz9+UMlpoc/V0IDMrqowegsp4OKBtC/jvkZiOy6W6qHl3MhsB+u
 VnHuz7+1uYW6SLa/NvB78behTeGJ6PRqMXP7NRKy2DX+RBJvrKaJqMeNtyogzqsNGYSR
 faqQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778188302; x=1778793102; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bK/0D/p5+4zoQFJqaRHmQRuhxmVLHc59YXdX9p0j6ms=;
 b=fU598CWLo+kB4nq+8ux3Y0DjfSCQtKyq6EMwvaViOeSVytD0p/OeDo6N2VUr36GBWa
 ujcsb2UmKsejaEcPp5Tu+3p3OdAGOtv78YvcfgAT9+ZF0T77vCS6W9ak0gFyygjPE+eQ
 WH34lQ5xFDCIkNILY9a6Cffe88G3PYcavZkDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778188302; x=1778793102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bK/0D/p5+4zoQFJqaRHmQRuhxmVLHc59YXdX9p0j6ms=;
 b=CcOWECCYJrQ2Mqa10AnByQ4l0TxfeHBYEyQg0Lff0WNnQteiStE2RbS7OK0eEOfJRM
 4vgNdRBrIXbtUD8yXD+RX8qvv0xm2jGh8GpCC0SUPunJtGOImE+T8usUfI5cIpHb888o
 iGORIFlHPScLZLCXT9bW796XR4s4A13GR7YgrjgqiDno2HEjOVaeNNg8qiTpd3wmrMdM
 GhPokOlilbJxfrAdD9r6ZIm2ac3lvmV5MiePyTLCeFYyca8/JpvZcyQSThTF98P6CWLm
 fly8cz1MDh3xJPodFQ5sirYE6wp/5In00uA0rrC4QbPm0IqFlVifxT0hldrGYBbLcTCm
 C74w==
X-Gm-Message-State: AOJu0YxvQYT2zbS9yuneT1MGy6viRaEy/I09rT2RfwesC3wSCmUs4eoV
 VCNuxvygfArD2GVWOdaPl3syHquYsDlrDDr2cWUhVv480i8kJlxPBFZJpA/C6P+Kv6UlpdN6etB
 tYFtbGg+SzyykLGTmVulOLXMAPBaKnYoCmzIzA+xr
X-Gm-Gg: AeBDiesxqzBylV0urJ5YvDQ96OPr22s3SV0v1wBQyhxxY+Np1R8nRv5xC2gC9O0nuds
 4IpmlWejw/VLEPkFsf7FtnYz00PRTjm1ThqFBnypSv83vWGy4ukQfC82e05xtwCAPzifENvLZPj
 K57e4KYCcMj/Q6LqlX1BQaOMLdo3mFgCsRYV7dFqE4Ws1ZwW9m4IBoxd6a/T6KEdIiECLN5nQSK
 3DrOr7ut7umhbSjYwsXWo+XcckNDHfYFOVn+0xIFElvTMhKiVGnoPjyWGvbRdaH4YBbv+7dNUA5
 ifjJ5w==
X-Received: by 2002:a17:907:3f8e:b0:b9c:5d3c:11e4 with SMTP id
 a640c23a62f3a-bc85c88dd5bmr238076266b.16.1778188301776; Thu, 07 May 2026
 14:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777984225.git.michal.simek@amd.com>
 <21c23cc7403153b45a81c958118b8d9f85f73140.1777984225.git.michal.simek@amd.com>
In-Reply-To: <21c23cc7403153b45a81c958118b8d9f85f73140.1777984225.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 15:11:28 -0600
X-Gm-Features: AVHnY4LWWI9E4hgJUuITa1rxLxxCUxiZdVQ-SzWRZwW2ATG_auFHh-wxg9aojXk
Message-ID: <CAFLszTiYJU028+L40rzNa=X-qqDYCfbPqYMfGhzpK3Xq2mr8ag@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] reset: Add sandbox tests for reset_reset() and
 reset_reset_bulk()
To: michal.simek@amd.com
Cc: u-boot@lists.denx.de, git@amd.com, Simon Glass <sjg@chromium.org>
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

On 2026-05-05T12:30:28, Michal Simek <michal.simek@amd.com> wrote:
> reset: Add sandbox tests for reset_reset() and reset_reset_bulk()
>
> Add DM test coverage for the new reset_reset() and reset_reset_bulk()
> API functions. The tests exercise the assert + deassert fallback path
> since the sandbox reset driver does not implement the rst_reset op.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
>
> arch/sandbox/include/asm/reset.h   |  3 ++
>  drivers/reset/sandbox-reset-test.c | 14 ++++++++
>  drivers/reset/sandbox-reset.c      | 31 ++++++++++++++++++
>  test/dm/reset.c                    | 67 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 115 insertions(+)

> diff --git a/drivers/reset/sandbox-reset.c b/drivers/reset/sandbox-reset.c
> @@ -66,6 +69,21 @@ static int sandbox_reset_deassert(struct reset_ctl *reset_ctl)
>       return 0;
>  }
>
> +static int sandbox_reset_reset(struct reset_ctl *reset_ctl, ulong delay_us)
> +{
> +     struct sandbox_reset *sbr = dev_get_priv(reset_ctl->dev);
> +
> +     debug("%s(reset_ctl=%p, delay_us=%lu)\n", __func__, reset_ctl,
> +           delay_us);
> +
> +     sbr->signals[reset_ctl->id].asserted = true;
> +     udelay(delay_us);
> +     sbr->signals[reset_ctl->id].asserted = false;
> +     sbr->signals[reset_ctl->id].reset_count++;
> +
> +     return 0;
> +}

Reviewed-by: Simon Glass <sjg@chromium.org>

Some optional nits / thoughts below.

The commit message says the tests exercise the fallback path since the
sandbox reset driver doesn't have rst_reset op, this patch adds that
method below - so the commit message could use an update.

If you want coverage for the fallback you could add a second
sandbox-reset driver without rst_reset, or hack the rest to clear and
restart ops->rst_reset,

> diff --git a/drivers/reset/sandbox-reset-test.c b/drivers/reset/sandbox-reset-test.c
> @@ -96,6 +96,20 @@ int sandbox_reset_test_deassert_bulk(struct udevice *dev)
> +int sandbox_reset_test_reset(struct udevice *dev)
> +{
> +     struct sandbox_reset_test *sbrt = dev_get_priv(dev);
> +
> +     return reset_reset(sbrt->ctlp, 0);
> +}
> +
> +int sandbox_reset_test_reset_bulk(struct udevice *dev)
> +{
> +     struct sandbox_reset_test *sbrt = dev_get_priv(dev);
> +
> +     return reset_reset_bulk(sbrt->bulkp, 0);
> +}

You could pass a non-zero value here if you want to test the delay.

Regards,
Simon
