Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DDCC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 12:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 172DE82115;
	Tue,  1 Apr 2025 14:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TH3P8A3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3750882047; Tue,  1 Apr 2025 12:11:39 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A7048006D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 12:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0DF665C05E2;
 Tue,  1 Apr 2025 10:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E9AC4CEE4;
 Tue,  1 Apr 2025 10:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743502295;
 bh=LBbqzdSQNFqc3+hb0zmU6d5V/m8e/ekxeuwxZRk3pKU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=TH3P8A3CNc0ZxMneOD6HPu63++2vH/xUqxlg4HP/tAHUVFwh1aoVmAJWsBDyz60ty
 AkvwNvfdVadFUV24PLX1kGE0B3pkqE8nI1L6DrUW9wsYMQUGvbzOILLdHDGnoWgwoC
 T/6vViNK+04zFmV2WtjX+LmKOMOR5Dd8DZ6nd22VJvzM0B3bb9ifWWmtTpTo4QqSDZ
 BRbJTTw6wkRFCovuxbLwrRBa2ereMKBmgom5T00Wlx2R8wSdXujRpHaJb6n9uyV022
 4x3DVomX+R+cnsQPG1N+HLKO2X9xIxFRKweMmNiDNSq66kuiNfSXSCdfA3crYRXLGz
 i9tGDvUjLaLew==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Zixun LI <admin@hifiphile.com>, Eugen Hristev
 <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/3] ARM: dts: at91: sam9x60-curiosity: Enable USB
 gadget node
In-Reply-To: <20250331162611.1557759-4-admin@hifiphile.com>
References: <20250331162611.1557759-1-admin@hifiphile.com>
 <20250331162611.1557759-4-admin@hifiphile.com>
Date: Tue, 01 Apr 2025 12:11:32 +0200
Message-ID: <87semsnqcr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 01 Apr 2025 14:32:32 +0200
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

Hi Zixun,

Thank you for the patch.

On lun., mars 31, 2025 at 18:26, Zixun LI <admin@hifiphile.com> wrote:

> Enable USB gadget usb0 node support.
>
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  arch/arm/dts/at91-sam9x60_curiosity.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
> index 99867d2bf8e..08480df88c6 100644
> --- a/arch/arm/dts/at91-sam9x60_curiosity.dts
> +++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
> @@ -248,6 +248,10 @@
>  	};
>  };
>  
> +&usb0 {
> +	status = "okay";
> +};
> +
>  &usb1 {
>  	num-ports = <3>;
>  	atmel,vbus-gpio = <0
> -- 
> 2.49.0
