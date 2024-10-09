Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E5ECF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5584B890AF;
	Wed,  9 Oct 2024 03:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JkTDMH4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2741E89089; Wed,  9 Oct 2024 03:52:50 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAD888908F
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7e9f998e1e4so2918143a12.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438766; x=1729043566; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tFYyQvZEFlSRr9+XC7PybzeeEt2mvuxLLwQzTrnwu2g=;
 b=JkTDMH4OBdtsa6O3PmxsfAOXQqzXxG8/Homwu28diFx+tWuIsBZkl1JXuUAJOzC0cE
 kQtI2BWiWctNLHC5LYcs4NSBl8UcTXdRN+QPt2XiNlH11YaHr1HkhfB+iVy4+zCO1Ju9
 RF4I1pa0DMRCJ0kmZTSwKggb0BRwN8MOBjHNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438766; x=1729043566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tFYyQvZEFlSRr9+XC7PybzeeEt2mvuxLLwQzTrnwu2g=;
 b=iNV7H3Q7wonN7mQTfk1rG+FhVHzmvlFl78Lun3Q59jkMv60RcqllTEcdrnAb8yR5Q/
 SSSiLUxsBzo/W3TzSmQ+l1fdy4lAT1LiPY+fhnL77F935VCeKEhDGMce8MKujgNZqW3z
 K9pdiEHbpFcoWkjzushK2QbTca6H11YC1anfindu4I4RvIaF+FYTcew/LhcJAi6N8zl1
 5+jjPHjF3EHayAC7QRd28KwO+5p0ZMroNmccGSY/YJqJMlMQdNagtVAxnkw24s1h8BST
 G2n1M4pEl1DeRLGVSffANIfdT8VhgLTVsqqE1oC/dbGi3wMVEODl8EvNVRZEo/Mn9OGZ
 0rKg==
X-Gm-Message-State: AOJu0YxiEe/3d5pT+T65sG7mbZLymxJddgidAhRMx5FT6NUAy4Bpfy24
 VqbHz9Mf2P35GhoSK2Y+aMiBGTRwlGh6lkzGOUzNn6IuNvSvSwQzwcgZ5yUkvKrIgG469mSw/MO
 V7HYPaeyzGQHUwihdQUwUqb/rZnfpTzzWIHqT
X-Google-Smtp-Source: AGHT+IEwnzCQADY8nE6klvq5qp+vhpCmhkTJpT4ZPJozkKOU3xb08gN7SIi6VeOivqQIdkjKUUDzS3oHbomf9eRyhoU=
X-Received: by 2002:a05:6a20:9c97:b0:1d3:e4e:b2bf with SMTP id
 adf61e73a8af0-1d8a3bf2d0bmr1484642637.16.1728438765933; Tue, 08 Oct 2024
 18:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241005143356.10069-1-marex@denx.de>
In-Reply-To: <20241005143356.10069-1-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:52:33 -0600
Message-ID: <CAFLszTiEM_TNJc2o3Hu4M3GGaJRonYs19SLMkn=DXVCp360rPw@mail.gmail.com>
Subject: Re: [PATCH] sandbox: dts: Add missing sandbox,
 emul phandle to sandbox-pmic
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Sat, 5 Oct 2024 at 08:34, Marek Vasut <marex@denx.de> wrote:
>
> This phandle was missing in the sandbox DT, add it, otherwise sandbox-i2c
> driver cannot look up the emulator via i2c_emul_find(). This fixes the
> following i2c_emul_find() error:
>
> "
> $ ./u-boot -Dc ""
> ...
>        i2c_emul_find() No emulators for device 'sandbox_pmic'
>   sandbox_pmic_write() write error to device: 0000000018c568d0 register: 0x0!
>        out_set_value() PMIC write failed: -5
>        i2c_emul_find() No emulators for device 'sandbox_pmic'
>   sandbox_pmic_write() write error to device: 0000000018c568d0 register: 0x0!
>        out_set_value() PMIC write failed: -5
> ...
> "
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  arch/sandbox/dts/sandbox_pmic.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks



>
> diff --git a/arch/sandbox/dts/sandbox_pmic.dtsi b/arch/sandbox/dts/sandbox_pmic.dtsi
> index 565c382ed45..ff2cb42844c 100644
> --- a/arch/sandbox/dts/sandbox_pmic.dtsi
> +++ b/arch/sandbox/dts/sandbox_pmic.dtsi
> @@ -10,6 +10,7 @@
>
>  &sandbox_pmic {
>         compatible = "sandbox,pmic";
> +       sandbox,emul = <&emul_pmic0>;
>
>         buck1 {
>                 regulator-name = "SUPPLY_1.2V";
> --
> 2.45.2
>
