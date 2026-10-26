Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E0606A31F
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r3YCptak;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=E9laEDzD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A31480DF0;
	Mon, 26 Oct 2026 09:46:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jeBNqo88-DG5; Mon, 26 Oct 2026 09:46:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 200E680DEA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793007991;
	b=mtPP6N8LP5PfQTyTIFr4uNv1iaI84V/PntDJ9SFaMlKHoUyKNwfBUwmERPfPEgd/OxQZ
	 6nmaS6tIo959GVk4gJKgPIpu2OkdTWfUzJMJ00kkiLoLMshRmBH/UYaaHXyQeJIh3GAKc
	 KGB2ODL5r4BYGt3zEbpbnZE0f9eg2GR2KVnP2QchDhIqoBPR1K2/D+vy6oyvfSzN0OStx
	 yI5FPzbJ2N1Hsj+lHjvSQJZq6K9wsxF27JaUoenBtNTqd+2QhkU3K9WSDHJGJIEHf48CX
	 obSidiDPhxe27dBhLwT7zbyrOSl2qHdwhlseMqqD9TcCjW78AfuxC/ePMor9IWYUxpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793007991;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZCQqETlxChOjtH2u9KdGEvW36Eq2MKkdUSmbGYLW84g=;
	b=Wws0AX6X1Mq3Y5jW42O0JcaLoJ9qpNrsr4H+fFmbTwXBtpm2zFP7xv9ALssdNcvMjDjO
	 uTy2/rzQ3sF2fnJfA4vrTTFx+SP2ICiWd2FFeYS3ejXrtfLDCdLqmuwitsXdCUa/dVvT3
	 rlogUX61F9NQnXVNeSmlkFthi4E90lvrPEl6Atkx8yd0/QCf3c6DNnCtPe/IH477nkC0O
	 qVJTZweFGBrILpFgSxPKTGO1CCBBkk7rXowfF5yqMqFbyYmVGZQ0wE5GO5YK5GOFeODob
	 hOIx0Wj9be6sDyzYEYtbQnMXxhk0PLh1jqdy++5tlXnNCUVMgYQZuSR5rMrG6kW3tuw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793007991;
	bh=ZCQqETlxChOjtH2u9KdGEvW36Eq2MKkdUSmbGYLW84g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r3YCptaks1td4MYYtzDTT5O+T96GM1Z3IC2BzhA7/dSwFs9Bhoa/wW50We61+r5Cq
	 XjYZ9UzwR4yAVa/kSl+joYUSi1ADOStIT+bmvlo8DvLoK5MyI1gu/5EGOsEXysrI0i
	 AV5y1LRaI9f/bw5aDMeeqqFLGG3BB/q3bMxJzbRyqz4HCQjlIfDn1mP5HKhvBIvZew
	 f2a5WZwxxiijkzV0Auvc+hEXGLNhzRnYYTqoB7AMVtucAjXNzyItkLBZuRPW5i7Xaz
	 rTKuBEe1jQbKdBtgjhz5KqWYq+iluey5gACV0Ynw2FFwyV+q9zsnP9pT1uXCgkGtCS
	 JzIBeMn/L+HsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 200E680DEA;
	Mon, 26 Oct 2026 09:46:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A2869356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88548405BB
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:46:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BM2socG7GDYR for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:46:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0E0F4405B9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793007988;
 b=LkWR0kk5MK7AvIEbqEruaVRfMMXW7N1GzMP6c+RACfwLq7ma/eiax2/nzgeN/sKWVGB/
 a4oE6T/ccuAQb8uB5meKJPKwWHpGVEXOdLlhuIf+QrRg+msJkEWsvDP3G80t2hTyffVgH
 TvpHpDqyQBcgNEjTJquKQ7Xflt63BE3Ay3Jei4l9fOWhdxmgSszny5jJzrDhWxmElw4Mz
 ib1xXU1I4m+uB0pWGi+kIn7gPBRM9QOHDALn5xbP5HmrCBROJifDub2Uqq5NoCdgJ4OnG
 aK9BiRg1/sgdwnaNeeppVs5yBNJhII2n0ihDdr8gccxVuWsrNMxwT8/+IqMa8pEfrTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793007988;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=ZCQqETlxChOjtH2u9KdGEvW36Eq2MKkdUSmbGYLW84g=;
 b=d+oJ9UQy8BYhNQ0+Nc1hXDQKgl6Rzx3hjau46+46NuY8yjnmYc+i+9zuWnvxB2eeAMuI
 7Re6wXaJDZ+8tkU6BL4APSgxYi2BaYeVEOJU65MZRYS6A6onnSqVnr1vGyVbKnO9IJiqz
 E7K+iPocRnO5h5uAReYyu+k6W/ieStyzNzej0MTZ8kIj7iPxf50qGlgqbcIPDKb49GQci
 bRTK8Jj5rh8eYYsNxXRIOBWOmbsu+mF1Vhlbnh/rWMiib/8rOD2/1JrYweWyxRlu+7RwE
 dZQBCdtp9958oeFJspvH04WMBXT35zC3tw0+zMGhxvKBU7OaaaCvY6Jj3mZJVahggSQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=E9laEDzD; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=E9laEDzD
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E0F4405B9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:46:26 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso2576450f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 02:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793007984; x=1793612784;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZCQqETlxChOjtH2u9KdGEvW36Eq2MKkdUSmbGYLW84g=;
 b=E9laEDzDhDuj2bB5gE9BuOpG/RUCzMAojRHcaIIwBYBsR1fG0IRrtcByVN5eRbU8hU
 YobOVAeZXErrrwbL1B+5qbaVlmdYvsRKTApd6aNsa1fngoyAVk/lySBFatsThgVKdh38
 N6uSFEHXixC/+tf+I1iPSjxH+7ph+d9/IcH2wAm7VVWMgQZlWgc6yxqBHT9+83MxHseK
 3y4qhSWKSi5TXLN+3OR+mfFeIEbjSxEMccOMVsa/hV0nEle6mAZtEsYko6SFor85/QK3
 cj2AsIcI8b7yq/sGSe+tH4Sb4cRqgyEX63WbVLEuhGB6SPxhcnFbIZp40UhMCffZCEbc
 sqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007984; x=1793612784;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZCQqETlxChOjtH2u9KdGEvW36Eq2MKkdUSmbGYLW84g=;
 b=aQZM+GoNpL4GdZalaMIR4pmCTHnwmo/jV5HCPOsx+HUU58bk4l37tlVDpNw5eVLfyF
 SMBmQq3Rh1B3jM8D2Djp2KBFhIGIe5S1yLLSZh7wYPFfhNSpsbp4ev3ymGp4Dn6HwB8q
 JCJXtXwfeJxGOPm1s/B/IZ0ME4mOy30iAEzecAeut1CeorkrnVop2Wgtf1ti/HHm3kcl
 ohLfFr5Qe7wjjYXBV6yaVmBKnFIptBKNG/lq4Ru5md1xVAgp+STK1TIoSwFnyRolwrWK
 JbHV79/YFVU9T8jtmEapSf3m2UdDgwn7ASU0JJmfwQS4/nScmjX7iEhj9mi+fR71QhrP
 GRgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBycTespJeYZIUXBFACfJ2iCIkxo1LTcULbq2Fi9a6n3u+feL1hxYm0H9DV7WfsFT/zFVx9e1WY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLazpZKq4hNpmCr4CAWXiG/al5SC3CemYK9Z7m7jxdYJaFdLISL
 pDOAPxg1uweWJ5LACFvrEHIkrk9nhjWlVzb9O7en4oBH3m65P01SSCzE+0iSNHgRwVI=
X-Gm-Gg: AYBFou0Jnp/bNmNMrvlg4MBYAwYUFNsOU0ONhP8GwqbZn+hr5T0yry01TLXGUJE+48b
 GEvXGa/OoeSxcnYXgJkjAvmcyCy8MpkcFtp3R7zFf9yLxWCWctVL78mUFI4ezfYllJXyJ5gAPIR
 fz2yU0KQRi7h715DRBX0iy/BjwGxGC/E0hGhxfsSkREi5W9X+JByGnB5CVjdfyOxaC63DBAdjOK
 3YD83bcXasHqvaOeXLaNYM4+F1WMVnoZf9uI3B3fhbnLGgDUv2pKzURkknSAI9BG4UKskpLuRmt
 56vBla5OJisXccjpxBjIqc9VdU2+SDxZ7dCbYCBfbnyLcpXHuXuqRHbb4MP9uoJj+PX+0Yw+/OC
 PJ2Yfey5C0X4MsIRKNBr4xa/D8xnH9Vu9z4zGjHDQvfkJpQO02QFJNTeVmdyPwQ/BJpKshDBPX2
 /tE9v0F3Tywoleh8HhUnv3byRFCMd84dR3+1rhWQFRdQ5s06FkurOK8/y6XFZ0EntepaIM6Pa3d
 q/aM3pubZUBYQ/gLit+4CHFkYvPyDjrm8YbIn8BlNxvXg2Ctr4hA23H2hblk/OzPdrZTZ9Giqpn
 3Wb9pvjN7GHlW3tLvdkZ6xBBhHADFg//mCmsnvod3kFKBisjyCyT6xgNna7hhmeJVUC7mZRsKg=
 =
X-Received: by 2002:a5d:6308:0:b0:48a:fff3:f9c1 with SMTP id
 ffacd0b85a97d-48e3eb87c2amr8598000f8f.20.1793007983908; 
 Mon, 26 Oct 2026 02:46:23 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ece5e4asm15167691f8f.59.2026.10.26.02.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 02:46:23 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:46:22 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 6/7] arm: mediatek: build Genio 520 and 720 boot images
 with binman
Message-ID: <at8hWm0XbNE0oyXa@macbook.homenet.telecomitalia.it>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
 <20261023-mtk-genio-720-spl-v1-6-f2c0ee094fd0@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-mtk-genio-720-spl-v1-6-f2c0ee094fd0@baylibre.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 19:09:12 +0100, David Lechner wrote:
> Allow CONFIG_MTK_GENIO_BOOT_IMAGES on MT8189 and reuse the Genio binman
> descriptions to assemble the BootROM image and firmware FIT for the
> Genio 520 and 720 EVKs.
> 
> The MT8189 BootROM loads the payload to 0x2001000 rather than 0x201000.
> The DDR loader needs more than 600 KiB of SRAM including its BSS, so
> reserve 640 KiB for it ahead of SPL. BL31 is linked at the same address
> as on MT8188. The DDR loader runs in AArch64, so request AArch64 BootROM
> entry in the image header.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Carlo Caione <ccaione@baylibre.com>

> ---
>  arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi |  9 +++++++++
>  arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi |  9 +++++++++
>  arch/arm/mach-mediatek/Kconfig                | 10 ++++++----
>  board/mediatek/MAINTAINERS                    |  2 ++
>  4 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi b/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
> index a69e2db5a04..53e06bc6af1 100644
> --- a/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
> +++ b/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
> @@ -1,3 +1,12 @@
>  // SPDX-License-Identifier: (GPL-2.0-only OR MIT)
>  
> +#include <config.h>
>  #include "mt8371-genio-common-u-boot.dtsi"
> +
> +#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
> +#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 520 bootloaders"
> +#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 520 boot chain"
> +#include "mtk-genio-binman-u-boot.dtsi"
> +#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
> +#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
> +#endif
> diff --git a/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi b/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
> index a69e2db5a04..0ee1ef3a869 100644
> --- a/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
> +++ b/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
> @@ -1,3 +1,12 @@
>  // SPDX-License-Identifier: (GPL-2.0-only OR MIT)
>  
> +#include <config.h>
>  #include "mt8371-genio-common-u-boot.dtsi"
> +
> +#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
> +#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 720 bootloaders"
> +#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 720 boot chain"
> +#include "mtk-genio-binman-u-boot.dtsi"
> +#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
> +#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
> +#endif
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index 1773da597ec..01db231a4f9 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -223,8 +223,8 @@ config SYS_CONFIG_NAME
>  config MTK_BROM_HEADER_INFO
>  	string
>  	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
> -	default "media=emmc;arm64=1" if TARGET_MT8188
> -	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8189 || TARGET_MT8195
> +	default "media=emmc;arm64=1" if TARGET_MT8188 || TARGET_MT8189
> +	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8195
>  	default "lk=1" if TARGET_MT7623
>  
>  config SPL_MTK_FIRMWARE_AB
> @@ -246,7 +246,7 @@ config SPL_MTK_FIRMWARE_AB
>  
>  config MTK_GENIO_BOOT_IMAGES
>  	bool "Build MediaTek firmware images"
> -	depends on TARGET_MT8188 && SPL
> +	depends on (TARGET_MT8188 || TARGET_MT8189) && SPL
>  	select BINMAN
>  	select MTK_GENIO_IMAGE_CONTRACT
>  	help
> @@ -261,6 +261,7 @@ if MTK_GENIO_IMAGE_CONTRACT
>  config MTK_GENIO_BROM_LOAD_ADDR
>  	hex "BootROM payload load address"
>  	default 0x201000 if TARGET_MT8188
> +	default 0x2001000 if TARGET_MT8189
>  	help
>  	  Address at which the MediaTek BootROM loads and enters the external
>  	  DDR loader.
> @@ -268,6 +269,7 @@ config MTK_GENIO_BROM_LOAD_ADDR
>  config MTK_GENIO_DDR_LOADER_SIZE
>  	hex "DDR-loader image region size"
>  	default 0x4b000 if TARGET_MT8188
> +	default 0xa0000 if TARGET_MT8189
>  	help
>  	  Size reserved for the external DDR loader at the start of the
>  	  BootROM payload. This is also the offset of U-Boot SPL and must match
> @@ -275,7 +277,7 @@ config MTK_GENIO_DDR_LOADER_SIZE
>  
>  config MTK_GENIO_BL31_LOAD_ADDR
>  	hex "BL31 load and entry address"
> -	default 0x54601000 if TARGET_MT8188
> +	default 0x54601000 if TARGET_MT8188 || TARGET_MT8189
>  	help
>  	  Address at which SPL loads and enters BL31. This must match the
>  	  platform firmware's link address and secure-memory layout.
> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> index 1129cd84c75..9087cb56c34 100644
> --- a/board/mediatek/MAINTAINERS
> +++ b/board/mediatek/MAINTAINERS
> @@ -4,6 +4,8 @@ S:	Maintained
>  F:	arch/arm/dts/mt8189*
>  F:	arch/arm/dts/mt8371-genio-*
>  F:	arch/arm/dts/mt8391-genio-*
> +F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
> +F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
>  F:	configs/mt8189.config
>  F:	configs/mt8371_genio_*
>  F:	configs/mt8391_genio_*
> 
> -- 
> 2.53.0
> 
