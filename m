Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB8FC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 06:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49F878346A;
	Tue,  5 Aug 2025 08:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754374839;
	bh=a4ZxLorGgUzXcJvirMdBgTnAqdqLSbRH14hy+EAOxpg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Ji2scUJDWU1LIwIz7rnBPp0t0UujbBocCipe7XRHsCWe/8kVF5kIZn5DzuLLSV9kY
	 Rm/8zpTDo+utqjdY6dh9ZkC/oXr/Q+puU+/W8hPmNR868lgO1+d6g64s/0O6ls7ug+
	 jiZJRIli4Y+b54pFa0LZDiXGGxKN/O0GvEq8gs4Y8bVXn9GePscAeL2iFsdBCI4dcL
	 6ywrDRlin9mjPvCOZ0VKS3NcUcvYORx0HxhKdT6gzd1RVE550KyBvj2ZNliMEHtfH8
	 lP3yv5qMx42M03S8pRCTXj5tGAfQaVe1GmOBF8Jjkq93B8HMVwABbnaXTOgdI288oF
	 wkLyrls0c6SlQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32D2F84127; Tue,  5 Aug 2025 08:20:38 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A96E83314
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 08:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="iSMKp2JU"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9E9AE1038C126; 
 Tue,  5 Aug 2025 08:20:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754374834;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=a4ZxLorGgUzXcJvirMdBgTnAqdqLSbRH14hy+EAOxpg=;
 b=iSMKp2JUgRA7MwG6vbJvirspPc4to/aRvZYU4Dly2hRxzWslobOBmHP1CkhrXQ1xnYNZpu
 NlcnmqgFdfL/APYOfMRMZdxYbLDqeJkwWxZ2/neaZvm+nt6KEq13444pfCkr1/PYgPkHZA
 YloXi2w93cr2iPiwuU1UT6ecfScRTzoe+ph3zZByIAJN2IIyiulYotDFWN+BE7lt3PbRxi
 RIGi8RPk7CIZ/WxYnCkwXoghq0kYZD8+h6iNby0udbkPVeoW2Op2lCVztbXROQJrP9Db9V
 r3Sa73bSeRRpe3YU3NlqgxS+ODqzBkR9bDIHlM2SB/YMpsFsstT+njRx97S0wA==
Message-ID: <ce42a275-cf9c-faa6-ee6b-0ccf82ef36c5@denx.de>
Date: Tue, 5 Aug 2025 08:21:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 05/12] drivers: i3c: Enabled Kconfig and Makefile for
 DWI3C
Content-Language: en-US
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, Jonas Karlman
 <jonas@kwiboo.se>, Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
 <20250728065612.6039-6-dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250728065612.6039-6-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Dniesh,

On 28.07.25 08:56, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> 
> Enable the Kconfig and Makefile for the MIPI DWI3C driver.
> 
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   drivers/i3c/Kconfig         |  5 +++++
>   drivers/i3c/Makefile        |  1 +
>   drivers/i3c/master/Kconfig  | 11 +++++++++++
>   drivers/i3c/master/Makefile |  3 +++
>   4 files changed, 20 insertions(+)
>   create mode 100644 drivers/i3c/master/Kconfig
>   create mode 100644 drivers/i3c/master/Makefile

beside the typo Askar mentioned:

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
> 
> diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
> index fa68612787b..d4451057de0 100644
> --- a/drivers/i3c/Kconfig
> +++ b/drivers/i3c/Kconfig
> @@ -14,3 +14,8 @@ menuconfig I3C
>   	  If you want I3C support, you should say Y here and also to the
>   	  specific driver for your bus adapter(s) below.
>   
> +if I3C
> +
> +source "drivers/i3c/master/Kconfig"
> +
> +endif # I3C
> diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
> index 5bb44a8d64f..5ddc4743c86 100644
> --- a/drivers/i3c/Makefile
> +++ b/drivers/i3c/Makefile
> @@ -1,3 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
>   obj-y				:= i3c-uclass.o device.o master.o
> +obj-y				+= master/
> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
> new file mode 100644
> index 00000000000..22bb7c21ea1
> --- /dev/null
> +++ b/drivers/i3c/master/Kconfig
> @@ -0,0 +1,11 @@
> +config DW_I3C_MASTER
> +	tristate "Synospsys DesignWare I3C master driver"
> +	depends on I3C
> +	help
> +	  Support for Synopsys DesignWare MIPI I3C Controller.
> +
> +	  For details please see
> +	  https://www.synopsys.com/dw/ipdir.php?ds=mipi_i3c
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called dw-i3c-master.
> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> new file mode 100644
> index 00000000000..c7562f1aa33
> --- /dev/null
> +++ b/drivers/i3c/master/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_DW_I3C_MASTER) += dw-i3c-master.o
> 

-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
