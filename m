Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265BC109022C
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 14:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A424783E36;
	Thu, 19 Mar 2026 15:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NplHuHW5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D57B83F9B; Thu, 19 Mar 2026 15:19:25 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A30838FA
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 15:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=olteanv@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b1cf1212so45483f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 07:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773929963; x=1774534763; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W48drN7sQQKSr629pomvY6LgAaAeeqqYcuWYY2x1oZA=;
 b=NplHuHW553XBm/IqMSu4lJluq+/rUq+owfHNt5HlsOomuy1ydt5I1bMjMSyVv0n2Fk
 EzfUGSWlR+m/cXEBn7SW0LkFwHxNiy4gTIkzAxZ/TmvVNRKvbJ4zzvz3qO0ckZTEKhXb
 2AUoMKqpjzk4xYjoK6Lg3scGBoeGicbpkMYNb1sIo3eDKQMMLwc2Di+RcABLIBnlVoet
 js86zSlDbHTc+aY1no65OMkrV5HTXwLiL+DFIRHdz8BIVG/VAfZx+2E2bdXzB+/vHhIM
 xdU1SjA5woYVf9pYj6J88+1Us7qJioUBEPPktVw9LdrHaYxCWKItP8BuFpz+xcDZPmUH
 dhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773929963; x=1774534763;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W48drN7sQQKSr629pomvY6LgAaAeeqqYcuWYY2x1oZA=;
 b=at3hPHmxD85ZzOtfOqsN6W3kIQdr384XOBTwKzwDqF17DrtnJSPpLGEUFCtml6rB9C
 YEV03fmp6mzNlQQCEfFAnaHJcRDq/2gIIPbZccueFcA4B955Vy6fCH0fjgWqKFFtUCr2
 QOor1G5yQ5wicBDsac0hr195rrQX8oY4ohH73yNxR9z8Jy3qVnNZwff7yuLOLcvHSVXn
 CakZ2RCkHpJopmqjKLgOCy3lPiM85dMeMFCmx8385FM5xA7fclxvc3z/vliSgHJYM+Mm
 r2fBnVYACtnvwmf9NQdp9FD1hBz1wLNRUjVjVgj/w5jRZHJcfbaMv2qQCodrnO4pH2BY
 RIDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDrRo9cshzmEphtF8KeqO4sFoj++64q7PFaCf+L6eB+wG9bNSTT0HfiNtJoZ/gugwQ/uB+d4o=@lists.denx.de
X-Gm-Message-State: AOJu0YwprcSyd1paom4z+81y3QQ0TFXN9V7vS4vnzOxrFuwg00s051ee
 UNq+MRljonU9VNq/GrnsW/LEXChSKoxZpqXN9SoMiSmdtK3maXt8ifLE
X-Gm-Gg: ATEYQzwPG6wq1XfQgLrgp9YAejLe4jlwBLTG024PF5706frttvwkRP10p/j6Nv96N+s
 aXv0JaOaGYiGLukrCj7mcv6QtP5/oF644b4rNdjQsYq+wL3+S4rDQ2XQ4gj3IUXFYOqmaAkWSIb
 8taJW98jRoxTlnOHXDaYOMlDU0rjZ0hDOTp47XXM3cSe6FFl3m0mMG3AwopTB+jK+ouwjpgO9Nv
 NhszH6rPWirvadhYEbp8rvyO64b1eDsRQ8vjegJ2+PVA4khl12fyu71TjT3/gUjwBAkkK6cZQY+
 3+7zkwFeU+ysjPhxaTgFf2CrKXkax8CcdoZRBHFR4KzFA40WvOdEUxdabLm/IbNa/ibe39rSH5c
 cjH+DKFbeqFN/LWimg+xf+J+A2Sq2PIG9c0F/H4EY2C9fFPoog09j2HhWNRnR9eMkVY5DRxZNMm
 YpOA6hFWDGtYvHQ9Y=
X-Received: by 2002:adf:b64b:0:b0:439:c122:4fe3 with SMTP id
 ffacd0b85a97d-43b5279e6bfmr6089383f8f.1.1773929962432; 
 Thu, 19 Mar 2026 07:19:22 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:5ed6:aea5:dd72:edea])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892290sm15929010f8f.20.2026.03.19.07.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 07:19:21 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:19:19 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Ashish Kumar <Ashish.kumar@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Kuldeep Singh <kuldeep.singh@nxp.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] configs: ls1021atsn: enable serial driver
Message-ID: <20260319141919.7i4lvuivexnek2ni@skbuf>
References: <20260318142949.2479033-1-mwalle@kernel.org>
 <20260318142949.2479033-3-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318142949.2479033-3-mwalle@kernel.org>
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

On Wed, Mar 18, 2026 at 03:29:16PM +0100, Michael Walle wrote:
> Switching to DM_SERIAL disabled any serial driver. Re-enable it again.
> 
> Fixes: 191b10ac70d7 ("PowerPC / Layerscape: Finish migration to DM_SERIAL")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  configs/ls1021atsn_qspi_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/ls1021atsn_qspi_defconfig b/configs/ls1021atsn_qspi_defconfig
> index e36d336d84b..37629d88c48 100644
> --- a/configs/ls1021atsn_qspi_defconfig
> +++ b/configs/ls1021atsn_qspi_defconfig
> @@ -68,6 +68,7 @@ CONFIG_TSEC_ENET=y
>  CONFIG_NVME_PCI=y
>  CONFIG_PCIE_LAYERSCAPE_RC=y
>  CONFIG_DM_SERIAL=y
> +CONFIG_SYS_NS16550=y
>  CONFIG_SPI=y
>  CONFIG_DM_SPI=y
>  CONFIG_FSL_DSPI=y
> -- 
> 2.47.3
> 

Ok, in ls1021atsn_sdcard_defconfig it is selected by
CONFIG_SPL_SYS_NS16550_SERIAL=y. In ls1021atsn_qspi_defconfig it isn't
selected.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
