Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33BDC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59E3984AF5;
	Thu,  9 Jul 2026 03:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=yandex.com header.i=@yandex.com header.b="eu1dTpGK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A290384A77; Thu,  9 Jul 2026 00:09:52 +0200 (CEST)
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net
 [178.154.239.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D6C84A51
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 00:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@yandex.com
Received: from mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:83a9:0:640:50fd:0])
 by forward502d.mail.yandex.net (postfix) with ESMTPS id 39ADFC1B8F;
 Thu, 09 Jul 2026 01:09:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id d9SM1X2c2Ko0-MzpogFby; 
 Thu, 09 Jul 2026 01:09:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
 t=1783548588; bh=/qDihjdj7qNbPB5kr7HG+3X1Xk6ZPJIitl5Qi+02GKU=;
 h=In-Reply-To:Cc:Date:References:To:Subject:From:Message-ID;
 b=eu1dTpGKGP5uSIPRiGsRhA1oYeKYTG7IvS3CRC3vBS6aNdCQ3UCBilrR47xAe4ySe
 9hMVzPYYLHkcyY6VZuY5/CA44Q25GHQn/2rtr7NAMoBq+3BMhHPLIRnF3mVftDUZGn
 hJHEH1RJKmrcmZHF94zz/EFunfhR+ceE0/mVrDD8=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.com
Message-ID: <3dbb9203-47ac-4384-8993-662c4a6002c7@yandex.com>
Date: Thu, 9 Jul 2026 00:09:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@yandex.com>
Subject: Re: [PATCH 02/12] MAINTAINERS: add rkmux.py to ARM ROCKCHIP
To: Quentin Schulz <u-boot@0leil.net>, u-boot@lists.denx.de
Cc: Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
 <20260707-rk-custodian-v1-2-dbc9c696e613@0leil.net>
Content-Language: en-US, ar-EG
In-Reply-To: <20260707-rk-custodian-v1-2-dbc9c696e613@0leil.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 03:53:42 +0200
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



On 7/7/26 18:09, Quentin Schulz wrote:
> It is a tool to be used with Rockchip SoCs so let's add it to the
> MAINTAINERS entry for ARM ROCKCHIP.

Hi,

This script is more of a relict from the past.(Simon ?)
Maybe remove it together with a clean up of README.rockchip.

Johan

> 
> Signed-off-by: Quentin Schulz <u-boot@0leil.net>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e2c78ce39161..6f52fb76fede 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -594,6 +594,7 @@ F:	drivers/gpio/rk_gpio.c
>  F:	tools/rkcommon.c
>  F:	tools/rkcommon.h
>  F:	tools/rkimage.c
> +F:	tools/rkmux.py
>  F:	tools/rksd.c
>  F:	tools/rkspi.c
>  
> 

