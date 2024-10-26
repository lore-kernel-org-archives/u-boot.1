Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0D2D10BE5
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 07:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAEEA88D13;
	Sat, 26 Oct 2024 09:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pZAxJvg0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04DA188D13; Sat, 26 Oct 2024 09:24:28 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43D5A87F19
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 09:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c9709c9b0cso3730579a12.1
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 00:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729927461; x=1730532261; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ahqipkSAMdcHfbqMR2LdHIFHYwsu7zoCYtTZMogQ8C4=;
 b=pZAxJvg0zCvXb3f5q+2te8drlz0QCKflNjUCJYpybQRFznmC5UnbbJJUBWcF0/k3nm
 aNSNjEMV/jtLjAzafWwNje/x4hSWHSW0SlDOxngmmocGBFiLe79Onz17CvimiIWJy3wN
 2GBUBec2PhJjjBNtSb4MVRp28bZhXRXxPWWl+thqqOAV1pXt2oqgzJQCb8MJYqcakuvo
 ajjOvP9qZajEclu6CBRr1smpGwodxr3LX8QpAmA7eF8abJjEmcjJu3NiwHEZxvrwFN23
 viO982eoOhiTLAcjbphmNbUQJ02xU5qRbfF5QQdk3bu82eShKozfsDPZxC/TuIZz/Cw+
 ygwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729927461; x=1730532261;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahqipkSAMdcHfbqMR2LdHIFHYwsu7zoCYtTZMogQ8C4=;
 b=wa/4YalyIUOlGi64DkV3MNLUZayUIb0qBoFm+cfp6Fugew0GbJjVbdIxVemI56Rjd9
 tm81XEBeb/+CscLT3HP/YIL0WA2cAWa/0Jiwc2Gk4nwiml3d93Dxae2/wetVTwiJMEyd
 WyvDKKYOoMwYfuF3de7wqbOpqXTbNmXOxVfslq51E/VWfAY6FWP4KzqJnBYJuo9lx/nn
 S2Tz2+uJBRJ1sRKLa0gSnqzcmckiux0rE+aD9ofZatsAcTkfc7qKTftj3bV4E1l2fIZZ
 4MsgongbQ4AY0EqYP9qGUIbvyLg5xh+McKKNFSMiWZbpiYkKaaehtVVTNR//f2D0xutM
 g0mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU56KyhHmqzeCghJg0auS+Zp2C+3aMtl1JziUuKm44lzhIqs58/ew09jcwTx/rbpKlVooJk9pY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6dpxYAMXlhZVHj50ed9leFxAd1i9o6RVnbITsJZVLgsgswxaN
 r/cX/nmWhO5GUSSH+WWdP1WrfV9wsJ1i/isKvK1/jiW8zlqZ1P26YQmPkG0JTHA=
X-Google-Smtp-Source: AGHT+IFBdBAlxS6tuAYgFLnqrapTGJKh4rmGFzbUiPSWL9d2CdyQBZStKv2GceSEe17QkdaEqFVcRw==
X-Received: by 2002:a05:6402:40c7:b0:5ca:e4e:59d6 with SMTP id
 4fb4d7f45d1cf-5cbbfa5483bmr1290010a12.26.1729927460665; 
 Sat, 26 Oct 2024 00:24:20 -0700 (PDT)
Received: from hades (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb63197bdsm1304292a12.70.2024.10.26.00.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 00:24:18 -0700 (PDT)
Date: Sat, 26 Oct 2024 10:24:15 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] cmd: simplify network definitions in Makefile
Message-ID: <ZxyZH0a+827NlMcr@hades>
References: <20241019102445.48624-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019102445.48624-1-heinrich.schuchardt@canonical.com>
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

Thanks Heinrich

On Sat, Oct 19, 2024 at 12:24:45PM +0200, Heinrich Schuchardt wrote:
> /Makefile already adds lib include paths to UBOOTINCLUDE. There is no point
> in adding the same paths again.
> 
> Clearly separate the lines relating to NET and to NET_LWIP.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/Makefile | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 3c5bd56e912..61992112f5f 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -127,13 +127,10 @@ obj-y += legacy-mtd-utils.o
>  endif
>  obj-$(CONFIG_CMD_MUX) += mux.o
>  obj-$(CONFIG_CMD_NAND) += nand.o
> -ifdef CONFIG_CMD_NET
> -obj-$(CONFIG_NET) += net.o
> -obj-$(CONFIG_NET_LWIP) += net-lwip.o
> -obj-$(filter y,$(CONFIG_CMD_NET) $(CONFIG_CMD_NET_LWIP)) += net-common.o
> -lwip-includes := -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
> -CFLAGS_net-lwip.o := $(lwip-includes)
> -CFLAGS_net-common.o := $(lwip-includes)
> +ifdef CONFIG_NET
> +obj-$(CONFIG_CMD_NET) += net.o net-common.o
> +else ifdef CONFIG_NET_LWIP
> +obj-$(CONFIG_CMD_NET) += net-lwip.o net-common.o
>  endif
>  obj-$(CONFIG_ENV_SUPPORT) += nvedit.o
>  obj-$(CONFIG_CMD_NVEDIT_EFI) += nvedit_efi.o
> -- 
> 2.45.2
> 
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

