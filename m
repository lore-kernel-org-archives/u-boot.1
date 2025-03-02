Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905B8C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 16:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF4BE806FC;
	Sun,  2 Mar 2025 17:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="csraOpOL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 849448058A; Sun,  2 Mar 2025 17:02:10 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CB8F806FC
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 17:02:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 20E9520283;
 Sun,  2 Mar 2025 17:02:08 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S1jD5nDxxmpr; Sun,  2 Mar 2025 17:02:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1740931327; bh=6g61N/2sWSTWQtlvHAWKL1eD+hOv2bgVnmgd9jBVm40=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=csraOpOLinmKVF6NnVUh9SJ1n12fcFgDd6TBWElAw4OSe3hI5B2FqAuJ9MdKBdokP
 M+tznSRaAYu0BF9Mu+7PW6HU9twxMWAQRJxGWlAxokfaz8nF51T+j0j+hYrQZTLrPC
 KIb69UfRBz+ZfuCr70I7KGq9LLfQWymplw6jH/1kfTjlMd0cUD042sYzEXRmEQv2Ay
 81plM4uQ2qwzVb6Qp7pRV5jUzYUbFw4M12BPkSmLyRaIdTNRvY1FkdH2ueMHY61HYj
 G7LF1+V7ML29nDhei6BnvBWp0Pyuqv4TcyAvE3zu1liqUSf1A6atLbbK8sUIrkBfKt
 91bffRGPl5vUA==
Date: Sun, 2 Mar 2025 16:01:48 +0000
From: Yao Zi <ziyao@disroot.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Janne Grunau <j@jannau.net>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/5] arm: include asm-generic/int-ll64.h in setjmp.h
Message-ID: <Z8SA7NrvySYVcIWI@pie.lan>
References: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
 <20250302142121.150480-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302142121.150480-3-heinrich.schuchardt@canonical.com>
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

On Sun, Mar 02, 2025 at 03:21:18PM +0100, Heinrich Schuchardt wrote:
> Don't assume that u32 and u64 are already defined.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/arm/include/asm/setjmp.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/include/asm/setjmp.h b/arch/arm/include/asm/setjmp.h
> index 662bec86321..9a7f5af9f8f 100644
> --- a/arch/arm/include/asm/setjmp.h
> +++ b/arch/arm/include/asm/setjmp.h
> @@ -7,6 +7,8 @@
>  #ifndef _SETJMP_H_
>  #define _SETJMP_H_	1
>  
> +#include <asm-generic/int-ll64.h>
> +

>  /*
>   * This really should be opaque, but the EFI implementation wrongly
>   * assumes that a 'struct jmp_buf_data' is defined.

With PATCH 4 of the series, this comment isn't true anymore. Should we
fix it up at the same time?

> -- 
> 2.48.1
> 

Best regards,
Yao Zi
