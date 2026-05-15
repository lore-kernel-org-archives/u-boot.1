Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB662CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A0A48468B;
	Fri, 15 May 2026 15:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ALZf9Exz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EEA78464D; Fri, 15 May 2026 15:09:26 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D444B84690
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bd3eb594960so388466266b.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:09:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778850563; cv=none;
 d=google.com; s=arc-20240605;
 b=J0WgEpuwfCijT3heJoqHqlilNDgY7aGVC8rJKvX623eILsgq9GSxQbuDemKHeiohWS
 qN0aowKfWykoEBAxyiBpQtoRQi+P3kQrVq4kQZ4tSXYatKas+323NqipVezpgSsjdqcY
 J3kL5P3dUcMGdb2hWvbuvIdLpCvmC76LjrRJXcbxhDDqanM+k7LOAGgf+rrI28hFYqbe
 s+SOqt5ERXiQ2cIOpM8LavpglV2dLz5sj2xiGDyEDovBEgpI4QGlNacs0ey38F1vSHbU
 NyT3WZo375l5x1fXocLMkoJcBzjauU/LR54vdfpEkrDrdQV6nNLf2Aw208q9r2ObYEMA
 K4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HPvIKYQNcV0BeP2ytRrfxV1nGAKO+yoDyXihFk2MSKY=;
 fh=p+5qEY7KshK5nNBu/OO78N81bwUQ6GeR8eoG5BHzLcY=;
 b=Yxe2TonfWi9eRIVb2bBXcdw8AREFWGDa9tVH8lnxrnWb6bq8WbLiQnutKzxwiVloeb
 +gBqcQlR/TxHlP+rfS8tNErMmPU3+4SbswmOWZXfPu8nLBU2dhw2mex+Ks+1Df6KnBlx
 C6TglaEQPK4I2WB9PEVPC4qXVNuZBApUD2rYu9JrzcSRK3oHweai3dZE0ft5E4qXCW+U
 ACUlPuvh52jpJJqeYdU5VbnJRNWRPSXjhOxcaoqp88hx/wvz3ZZpa/v//Efryk52EHjD
 eViKC3duUiopkx30rR/pkItjYBL02Z45fEaubqRxkUlXtkX2ZS/AoALeIk4McCMHJ8g3
 AZwA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778850563; x=1779455363; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HPvIKYQNcV0BeP2ytRrfxV1nGAKO+yoDyXihFk2MSKY=;
 b=ALZf9ExzfdlIH5rHqsPCncQPf7DUWDgsCRoiI7bJrA+flsU8Y12VPN9UsxgzUxnTTm
 H9+LUIYxmD7y+u64HC+LDPb/YsT8axwbtfU/xZXRm2eBXVZIy8jwUGBOY4d7Imcnjvg8
 jBvM5aLFLm8rwQcdgJ5LmLVk5wqCxSULaSGVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778850563; x=1779455363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HPvIKYQNcV0BeP2ytRrfxV1nGAKO+yoDyXihFk2MSKY=;
 b=Juxg6XO7JF+oazEVFfkN5JTNzbfj0U3IYA0AyHnk2BOsDqJG6AuG68TPftG5Id3jOY
 DdSJVItUbfmcPeFLdpJVJwR0G+fQmAsblND5khXf3AJjOYRMP9MX8NeqenrlO+k2HtwG
 AQSYq8TCvfykFwQXMUkQUx2yax0icditigTRv9KaL2UHDvJ3wh0HcHLic7fZKMvhoxf1
 KyC9q+Y1wVJWwlYp1aIGxHyQjunSp4wPusjiSYbMlS2fG39mWd4EmF3OH88NuhND0Ihz
 wAVIpc70I4yG9d95wXLUPdQgC0cbY1xt9bXFUxZp5h4iWRy7L28HxXOIxDQufkyY8zw/
 WEMw==
X-Gm-Message-State: AOJu0YwX8MjTgpgzH/iKkksodzyqzx1qapbIxLEvxuc0QKc3dghhRCzx
 USJ229aihXjQ1fWaKJwulcgKh8ryHQBtZmRvrn7JuqzEgSzs/vAJXJWrzvXFrdhyC/fvQH/HJw2
 B+zN0ztm/AABrpDrpwfwKM6j2cduKJGY11plM1tz5
X-Gm-Gg: Acq92OFEgoDufE2sXsKH67GS60LyXU2uPNUUmdfjmQXyl2lGiMH57FbJexITjiIUQca
 3Uhx8qSKao8KFBr+gpYzHb4aB7UL671VBJNUkCCm6s9HFZTkF6/eHj8DejPRMuNyJitk92wQb2j
 fWUWzX7h8dDbct70WiLlxaZsA/WyLQpup6AAFEdd22mwrDy3vwP3Q/am7dvJuD2Y5/ijkLQ9CzF
 kwHMVuhZUEtfZrJvQNu+22Vf1pPutdvDiEuhNM9/09MSqAAJPt697E3Vb1mFiPx4EVnZzlnfAXU
 H+L8+w==
X-Received: by 2002:a17:907:1c8f:b0:bb8:b593:edba with SMTP id
 a640c23a62f3a-bd517970900mr217333966b.38.1778850563229; Fri, 15 May 2026
 06:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778619453.git.aidan@wolfssl.com>
 <20260513002625.76915-5-aidan@wolfssl.com>
In-Reply-To: <20260513002625.76915-5-aidan@wolfssl.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 07:09:10 -0600
X-Gm-Features: AVHnY4IxNk0x7_jbhpoZTZFSbnZ69XXuVRSsqmyblk3ijBtZwqOH7JtH7QgB5js
Message-ID: <CAFLszTjAxmdrabtLzE8-ucEbpUfv5CH_zYSY35+bJAQP6vOf3w@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] arm: dts: qemu-arm64: add TPM TIS MMIO node
To: aidan@wolfssl.com
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 David Garske <david@wolfssl.com>
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

Hi Aidan,

On 2026-05-13T00:26:04, Aidan Garske <aidan@wolfssl.com> wrote:
> arm: dts: qemu-arm64: add TPM TIS MMIO node
>
> Add a TPM 2.0 TIS MMIO node at the address QEMU's virt machine
> exposes when started with -device tpm-tis-device.  This lets the
> in-tree QEMU+swtpm test path (used by the wolfTPM Python test
> suite, and similarly usable by anyone bringing up the existing
> TPM 2.0 stack against swtpm) work without having to inject a DT
> overlay at runtime.
>
> Address 0x0c000000 / size 0x5000 matches QEMU's virt machine TPM
> TIS region.
>
> Signed-off-by: Aidan Garske <aidan@wolfssl.com>
>
> arch/arm/dts/qemu-arm64.dts | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/arch/arm/dts/qemu-arm64.dts b/arch/arm/dts/qemu-arm64.dts
> @@ -12,4 +12,8 @@
>  / {
> +     tpm@0c000000 {
> +             compatible = 'tcg,tpm-tis-mmio';
> +             reg = <0x0 0x0c000000 0x0 0x5000>;
> +     };
>  };

I don't think this addition takes effect at runtime. qemu_arm64 sets
imply OF_HAS_PRIOR_STAGE and board_fdt_blob_setup() returns the DTB
QEMU loaded into RAM, so U-Boot uses QEMU's generated DT, not the
compiled-in qemu-arm64.dtb. OF_OMIT_DTB defaults to y when
OF_HAS_PRIOR_STAGE is set, so the compiled DT isn't even bundled into
u-boot.bin. See doc/develop/devicetree/dt_qemu.rst

When QEMU is started with -device tpm-tis-device it already adds a tpm
node at the same 0x0c000000 region, so the existing TPM 2.0 stack
picks it up without any change here. Have you confirmed that removing
this hunk actually breaks the test path? If not, please drop the
patch; if it does help in some specific path (e.g. -dtb u-boot.dtb),
the commit message should call that out.

See also this patch where a similar thing came up (due to a QEMU
maintainer refusing to support DT additions, U-Boot needs to do the
overlay itself).

https://patchwork.ozlabs.org/project/uboot/patch/20260507140624.v3.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid/

I also found the context re QEMU expectations (basically Tianocore).

https://patchwork.ozlabs.org/project/uboot/patch/20240911062511.494855-23-patrick.rudolph@9elements.com/

Also, the reg property uses four cells but the root node doesn't
declare #address-cells/#size-cells, so the defaults (2/1) apply and
the cell count is wrong. Per
dts/upstream/Bindings/tpm/tcg,tpm-tis-mmio.yaml the compatible needs a
vendor-specific string first with tcg,tpm-tis-mmio as the fallback -
tcg,tpm-tis-mmio alone fails the schema. If the node really is needed,
please match what QEMU emits (or pick a sensible vendor prefix) and
wrap it in a parent that sets the address/size cells.

Regards,
Simon
