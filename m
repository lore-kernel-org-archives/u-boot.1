Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4B3C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 06:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB59E83253;
	Tue,  5 Aug 2025 08:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754374592;
	bh=lMc1WSiPxhRMxDrHUCr/lyALYmIRNomHzlZitdTUesk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=RnP03/GER33uOmq4s4E++VBoe/42LrLxMwIUgigotQQYUE9MbI47tNLiL7Ck3sB8m
	 TEgMA/2ArVsKSoK9r9vOBneFfdieD228lQyWWPml0o7bjoaCohx4IfUDv4z8HcTHO5
	 T52XhGdk9ilBZgmyz56m4JT+CwCSdpwZhi1Z6DfAK1/mYIHSXXxTn/nDu3Q1zyPnBT
	 r5fzUxAvdpG5xjQVb2IXAeXbOq78zYcCSjT1yTTI9dNBKjDlcEeZhdjp7iwYGWSBIG
	 asDxPcGqILqgNqphl4SmhJ2tKi7Yr+EM/YsquBxQYJQZuKFlYVg+W6FqLhbnSMNWHl
	 TDyCIuysw4w0Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30BC383278; Tue,  5 Aug 2025 08:16:32 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84C6083106
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 08:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="L26IsqoR"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C15FF1038C126; 
 Tue,  5 Aug 2025 08:16:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754374587;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=lMc1WSiPxhRMxDrHUCr/lyALYmIRNomHzlZitdTUesk=;
 b=L26IsqoRUHDI/1Ke7QCxNlwmtL6LW+2VqEPiJNjaxaoqo9u/hruxytH94xnIDCN/ptnmbL
 qpWyqaj2sCLhRBhLLbAMukDQo34B5y8DJnPkrV9Xt1K1P/YMu+mTW4DVyArrNNJybeveft
 tpvqRsBQ8ykDdaufK7g1jBnseVFFPew6bFrjB++lzYvjiDIB1Febf4nfyc3foO/TXIPyy4
 J+4AZXNvAZRQKtZkBKiOAdiI2/KK91dSYKbOz7En2fD7D7K9MI4akKjySZ5n3bxgvUUGjy
 jnnNE1WzPSRE46K7YggtiX2sbvkKJ7g0bIIm4bnRdUqlNDb6uOy4VDSkggKGBw==
Message-ID: <785c7398-890a-2bcf-5329-f3b43853e373@denx.de>
Date: Tue, 5 Aug 2025 08:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 02/12] drivers: i3c: Add driver for MIPI DWI3C
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
 <20250728065612.6039-3-dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250728065612.6039-3-dinesh.maniyam@altera.com>
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

Hello Dinesh,

On 28.07.25 08:56, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> 
> Enable driver for Synopsis MIPI DWI3C for the family
> device agilex5. This driver is migrated from linux version 6.6.37 LTS
> 
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   drivers/i3c/device.c               |  262 ++++
>   drivers/i3c/internals.h            |   26 +
>   drivers/i3c/master.c               | 2060 ++++++++++++++++++++++++++++
>   drivers/i3c/master/dw-i3c-master.c | 1006 ++++++++++++++
>   include/dw-i3c.h                   |  248 ++++
>   include/linux/i3c/ccc.h            |  385 ++++++
>   include/linux/i3c/device.h         |  286 ++++
>   include/linux/i3c/master.h         |  697 ++++++++++
>   8 files changed, 4970 insertions(+)
>   create mode 100644 drivers/i3c/device.c
>   create mode 100644 drivers/i3c/internals.h
>   create mode 100644 drivers/i3c/master.c
>   create mode 100644 drivers/i3c/master/dw-i3c-master.c
>   create mode 100644 include/dw-i3c.h
>   create mode 100644 include/linux/i3c/ccc.h
>   create mode 100644 include/linux/i3c/device.h
>   create mode 100644 include/linux/i3c/master.h

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko

-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
