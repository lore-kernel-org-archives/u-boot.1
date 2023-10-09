Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0A3CD612A
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 19:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F4A864A0;
	Mon,  9 Oct 2023 21:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eqQMaJfx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E64B0864A9; Mon,  9 Oct 2023 21:22:41 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B646C86489
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 21:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9b95622c620so897959566b.0
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 12:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696879359; x=1697484159; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W213PjLTqM3JEmBmT6cQ0NV691A2RnRzmI4p6V+/cyA=;
 b=eqQMaJfxwyHI3P6qMu7kedvrXHFLzPai4t49yRd6aizixOvoI8nclKXwd46MESEv6S
 4MsnsNxJkh+N/lhC16KSVix8p9EFhxGgX7fN3eCwULBfcmv3MG59By+bkmdMGn0Qf+wr
 59LXHJswyptfJjKc5L3lYzISBvbcfpSBF7N/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696879359; x=1697484159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W213PjLTqM3JEmBmT6cQ0NV691A2RnRzmI4p6V+/cyA=;
 b=Z6i5OEWNIhr78XoDkeJP0DxHeKF/qbEca0MD0e8cEeC7s+IFthwhUKuJzmP6Gcwhuv
 NH7r+4PL66QO20MFvc9ifB2jL1IssAoQAcNDBI4CKAYcmeTWiWHvGSRaQsY/AIA2SWe4
 PQfRHJmSAT56Ukdqgl5j2i4hOjnlPz1YfqGcOttue1hzq2gcAqtRgTsGdkpzJST5dYLN
 qSyMtlAS4qxft50YmkNNEZIUcoFbhSiIzbs5J4VPNYvXd4UiS7BxsDcLMv+4B8uv6sAT
 l1FMOK7Dj+4AyNtN8DasO2HnrNk+vEe5QRewHKk1hS/ltsrKWgHpSXUWvxrhK+pVGbYG
 a8rg==
X-Gm-Message-State: AOJu0Yy9IrE/7ZZ1p+kZ70Q8tsahfimlpPkA+gGeur343AnNihlwU+xP
 VzuaPGO316IggQOaK17yEEo0mULuu3NSA4geJSzEHA==
X-Google-Smtp-Source: AGHT+IHc7jcdlWh8LiRicdltTnLDX2OAGb0AbRSSrZm/5DGfpUC/nMASnv47R9hAghm2qceVMSwbZySZxRl5RqG6+zE=
X-Received: by 2002:a17:906:3012:b0:9ae:4054:5d2a with SMTP id
 18-20020a170906301200b009ae40545d2amr14184483ejz.16.1696879358971; Mon, 09
 Oct 2023 12:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org>
In-Reply-To: <20230926194242.2732127-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Oct 2023 13:22:21 -0600
Message-ID: <CAPnjgZ1WgOB08C32PWdhagP5CRuBou8Z0ZPfxdAmRKD5uxKQJw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] schemas: memory: Add ECC properties
To: devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
 Lean Sheng Tan <sheng.tan@9elements.com>, lkml <linux-kernel@vger.kernel.org>, 
 Dhaval Sharma <dhaval@rivosinc.com>,
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Yunhui Cui <cuiyunhui@bytedance.com>, Guo Dong <guo.dong@intel.com>, 
 Tom Rini <trini@konsulko.com>, ron minnich <rminnich@gmail.com>,
 Gua Guo <gua.guo@intel.com>, 
 Chiu Chasel <chasel.chiu@intel.com>, linux-acpi@vger.kernel.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Ard Biesheuvel <ardb@kernel.org>
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

Hi Rob,

On Tue, 26 Sept 2023 at 13:42, Simon Glass <sjg@chromium.org> wrote:
>
> Some memories provide ECC detection and/or correction. For software which
> wants to check memory, it is helpful to see which regions provide this
> feature.
>
> Add this as a property of the /memory nodes, since it presumably follows
> the hardware-level memory system.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v7:
> - Drop unnecessary |
> - Add a blank line between properties
>
> Changes in v6:
> - Use a number of bits instead of a string property
> - Fix inidcates typo
>
> Changes in v5:
> - Redo to make this property specific to ECC
> - Provide properties both for detection and correction
>
> Changes in v3:
> - Add new patch to update the /memory nodes
>
>  dtschema/schemas/memory.yaml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
> index 1d74410..b3bf3c9 100644
> --- a/dtschema/schemas/memory.yaml
> +++ b/dtschema/schemas/memory.yaml
> @@ -35,6 +35,19 @@ patternProperties:
>            For the purpose of identification, each NUMA node is associated with
>            a unique token known as a node id.
>
> +      ecc-detection-bits:
> +        default: 0
> +        description: |
> +          If present, this indicates the number of bits of memory error which
> +          can be detected and reported by the Error-Correction Code (ECC) memory
> +          subsystem (typically 0, 1 or 2).
> +
> +      ecc-correction-bits:
> +        default: 0
> +        description: |
> +          If present, this indicates the number of bits of memory error which
> +          can be corrected by the Error-Correction Code (ECC) memory subsystem
> +          (typically 0, 1 or 2).
>
>      required:
>        - device_type
> --
> 2.42.0.515.g380fc7ccd1-goog
>

What is the status of this patch, please?

Regards,
Simon
