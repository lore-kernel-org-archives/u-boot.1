Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFB3C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 07:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B02F82A4B;
	Thu, 12 Jun 2025 09:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="epikIPGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0439682B70; Thu, 12 Jun 2025 09:24:50 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2129828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 09:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 0A9CCA516B6;
 Thu, 12 Jun 2025 07:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E844C4CEEA;
 Thu, 12 Jun 2025 07:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749713086;
 bh=dMYWPAMmb41SroqkvvkUTS38ccyPJrFIrc+m8Zy/Wr4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=epikIPGGdQpDkQnZ4RgGihkR1DeuFUy5URtfaVNdaLpevRFb/Gcx8vfJ3zv6mjh8Z
 7mGiJ+cLy3NgKyLIEHGeeyxONJK/hHMhpEzKOcO6eep1N2ZSXXgF2PfsAZgdWNFRsN
 9yqCeNPjXBfFDgcOpz/1zgJyPeBoq2djuauwHef+K7LursvcTgzlFBHlQkjAsvmC8I
 EW1oS5ikPejjSEEAkNhmK8V6MQYFJYAUsaZobJX7q8CiT++Akk1GDCM8sM8W4//0DV
 YKeaNFGkIxiMNAcH3Je/QVKPe/HqUnVgM0KZxzvOu5XLkgs9VRYtlBOOuL2FN6xavm
 BlTc6MbQXeiBQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>, Tom
 Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg
 <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, gchan9527@gmail.com
Subject: Re: [PATCH v2 5/5] usb: gadget: Introduce usb gadget vendor/product
 default id for ARCH_QCOM
In-Reply-To: <20250607-sc7180-android-boot-v2-5-2df5d7f61124@gmail.com>
References: <20250607-sc7180-android-boot-v2-0-2df5d7f61124@gmail.com>
 <20250607-sc7180-android-boot-v2-5-2df5d7f61124@gmail.com>
Date: Thu, 12 Jun 2025 09:24:43 +0200
Message-ID: <87sek5a0ck.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi George,

Thank you for the patch.

On Sat, Jun 07, 2025 at 13:25, George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org> wrote:

> From: George Chan <gchan9527@gmail.com>
>
> Currently vendor/product id are both 0, and that might not as we want.
> Set to some arbitary known value that we can make it work more smoothly.
>
> Signed-off-by: George Chan <gchan9527@gmail.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Acked-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Casey, even if this is usb gadget, feel free to pick this up in your
tree.

Thanks,
Mattijs


> ---
>  drivers/usb/gadget/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 46a83141481..2a56e360b5f 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -60,6 +60,7 @@ config USB_GADGET_VENDOR_NUM
>  	default 0x0955 if ARCH_TEGRA
>  	default 0x1f3a if ARCH_SUNXI
>  	default 0x2207 if ARCH_ROCKCHIP
> +	default 0x18d1 if ARCH_QCOM
>  	default 0x0
>  	help
>  	  Vendor ID of the USB device emulated, reported to the host device.
> @@ -86,6 +87,7 @@ config USB_GADGET_PRODUCT_NUM
>  	default 0x350a if ROCKCHIP_RK3568
>  	default 0x350b if ROCKCHIP_RK3588
>  	default 0x350c if ROCKCHIP_RK3528
> +	default 0x4ee0 if ARCH_QCOM
>  	default 0x0
>  	help
>  	  Product ID of the USB device emulated, reported to the host device.
>
> -- 
> 2.43.0
