Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3F8CD128A
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 04:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 602A8882CF;
	Mon,  1 Apr 2024 06:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oVU022hL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E079882DE; Mon,  1 Apr 2024 06:49:21 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF8D882CF
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 06:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-47866551165so324904137.1
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 21:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711946957; x=1712551757; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EurL2iym7Sx6NrLVehhW+K4cMyeaGQOEfUVr4YBN83o=;
 b=oVU022hLD8T7y/K3IW7d4VOZOogW2ozSNjKDciYtEnxMS1HEBvibwf4vfXcPtrHH3J
 K0VkfKw/pr5sJ1eaVBjty9MU8zqwvPqNhu9AwgFEnTL1atgaSsIqXzxpJ1NDyY6OkkrR
 kDiWcdd1i50MfKWQYmdWuq6/H74OI0xmO0dHI8/FdtsR4dBV+2plhwiQIrLPJxw9LEM8
 a+9MkyK4dqf742+DIMghfE/pUtt6DZ8uOqxVEQXueQmuZ/J9uwYtxSWt+tRF4/RDidVX
 6uCRoNKMIZHyUj74OLFQ+lcRY8Rir2TxJTTGx64YkDNCV7sY4x0i2hE8QEO7aF+RhiPI
 EqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711946957; x=1712551757;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EurL2iym7Sx6NrLVehhW+K4cMyeaGQOEfUVr4YBN83o=;
 b=J4iF/nCVF+4+l8nTkno8i3DSa+xDkZSiYZtLHxNIqtbwhuKZKAAPw5/xsOOCTch7wO
 UVZ9qSKLj7A2Xz8saXyqf142Q7VJTNFq/cUfhlCykuv571NN4gP2pgijGmUhEBX4vzVS
 iiQanavRAZ1MuCBl/yRumvkzrnhMHrYQJPc0ebkkwTDnUPBCigawg8Y/9M4papKmg8F0
 VcCGimnYPIh5pW/unAR8boVfFqnb1e2Ut2XtKhii+OoO//bOKi8WxuT9XAgJbfJ3CTs/
 Wbvz18ezJpEOqYkk8n+irvhV4p1T3ic8capLJhgmpFAPTYIhBhWEEse6iMxW45mqGcIq
 OAgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkVliVmxqJ10I+7LLWmHKaE+pCpKuy4LP7XGcQ0HGTl2oRyfdTJi+0ijBzXT5DksnENGi7bqmlLqOu3zQZQ2hustkgqg==
X-Gm-Message-State: AOJu0YwV1g6cekYXeGDt76bXJXKp3heGYOY5Nk+t3snTcStekZ2dk+6y
 t7ymQulAdZxC1B83yPxyWHeyOAUB017fiOOBbOuxaBhAJFq/Z0GahcR+h2GFCp9cTVPLvtKheih
 MXf/LVnRWsQToQvSa/e9niQFJGn/nHLmU0NmZQA==
X-Google-Smtp-Source: AGHT+IFGP4/C+WYx7ygeG5ZiJo1KSxS/bPQtv5mHUKfbBxYDScwwByL7b6s8lPsxFPyU9qaWyqUBIQ8eNDq8ONddhkg=
X-Received: by 2002:a05:6102:4a8:b0:478:6d74:f31a with SMTP id
 r8-20020a05610204a800b004786d74f31amr2092728vsa.15.1711946957667; Sun, 31 Mar
 2024 21:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
 <20240328-b4-qcom-livetree-v5-13-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-13-4e98228b3d03@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 1 Apr 2024 10:19:06 +0530
Message-ID: <CAFA6WYNY9Y9py2K-ZFooCinRTYK6BOeTm1S4Bxaamn3+TO+XPA@mail.gmail.com>
Subject: Re: [PATCH v5 13/16] dts: sdm845-db845c: add u-boot fixups
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
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

On Thu, 28 Mar 2024 at 23:29, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> The USB VBUS supply for the type-A port is enabled via a GPIO regulator.
> This is incorrectly modelled in Linux where only the PCIe dependency is
> expressed. The correct way to handle this will be through a
> usb-connector node, but for now we'll just mark the regulator as
> always-on so that it will be enabled automatically during boot.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/dts/sdm845-db845c-u-boot.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/dts/sdm845-db845c-u-boot.dtsi b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
> new file mode 100644
> index 000000000000..906f9faa5451
> --- /dev/null
> +++ b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Needed for Linux to boot from USB, otherwise if PCIe driver is not in initramfs
> + * the VBUS supply will never get turned on.
> + * https://lore.kernel.org/linux-arm-msm/20240320122515.3243711-1-caleb.connolly@linaro.org/
> + */
> +&pcie0_3p3v_dual {
> +       regulator-always-on;
> +};
>
> --
> 2.44.0
>
