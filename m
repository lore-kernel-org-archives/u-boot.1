Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B334C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 12:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EE4E830E4;
	Mon,  7 Jul 2025 14:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dIrGm3Ri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49218830F4; Mon,  7 Jul 2025 14:48:34 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC6CC830CA
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 14:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 559E75C0464;
 Mon,  7 Jul 2025 12:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF441C4CEE3;
 Mon,  7 Jul 2025 12:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751892510;
 bh=V4w287nJcrYU+vZnaPU0lScjZ7uXf8l2HEz4WVOwgVY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dIrGm3Ri1fFzOafaXBP+9dENRnPwI7SKsppCtJwNT7b0vu2ca9dwu22XAmM+d/L1V
 2WT3swQGyKpcUd0JzRQI5LAeK+mCys5Q4BBgXowUdIeLs5ljQeBINcNagY9PPIBn/O
 xH3vYiRew0S9991NoBTgZZK5ikkcO4yc55BRexWyIht5lgWE2RgpYY7PtwPGxdhp9u
 fIgrOBV0sB0HKHwnUy+yhLoTq70H/f3lRT6bs7lYTxnXF24bkOi0HEDLYVET0Y6w+l
 zRDA8A0hoF1MYiFIcXU+LnzO6coontn9j/H6XC73BoM/4uD6A6DdjLUmfSVBefYjy8
 k03erm2hO62lQ==
Date: Mon, 7 Jul 2025 18:18:24 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: Re: [PATCH v2 0/2] gpio: qcom: rewritte SPMI gpio driver from Linux
 driver
Message-ID: <aGvCGMmS56p3qqvO@sumit-X1>
References: <20250630-topic-sm8x50-pmic-gpio-pinctrl-new-v2-0-cc1512931197@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-topic-sm8x50-pmic-gpio-pinctrl-new-v2-0-cc1512931197@linaro.org>
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

On Mon, Jun 30, 2025 at 06:04:43PM +0200, Neil Armstrong wrote:
> The current SPMI gpio driver is very old and doesn't support
> pin state tracking to fully support the whole pinconf calls.
> 
> The simplest is to rewritte the driver using the v6.14 Linux
> driver and fully implement pinctrl, pinmux, pinconf and gpio
> support using all the newer interfaces.
> 
> The goal is to deprecate the old one it has been validated
> on currently supported hardware.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Collected tested-by
> - Rebased on next
> - Link to v1: https://lore.kernel.org/r/20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-0-74077ef0b464@linaro.org
>

The alignment with Linux driver is really a good step, feel free to add:

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> ---
> Neil Armstrong (2):
>       gpio: qcom: add new driver for SPMI gpios
>       gpio: qcom: move pm8550 gpio to new driver
> 
>  drivers/gpio/Makefile         |    2 +-
>  drivers/gpio/qcom_pmic_gpio.c |   20 +-
>  drivers/gpio/qcom_spmi_gpio.c | 1035 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1037 insertions(+), 20 deletions(-)
> ---
> base-commit: f2220962f9cb1366bfc003ec2cc5650499c68895
> change-id: 20250401-topic-sm8x50-pmic-gpio-pinctrl-new-2588c35a461c
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
> 
