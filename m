Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E43C43602
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 09:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 083DD838D7;
	Wed,  8 Jul 2026 11:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="drV/cei5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC6C78496E; Wed,  8 Jul 2026 11:15:36 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A67CD80433
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 11:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 09D99117CF2; Wed,  8 Jul 2026 11:15:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783502133;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=a4dSe9Uo83D55JRIhDa7dlnY8pdI3l+FhDa8/u11Ne4=;
 b=drV/cei5hKCi6F7yj+gNHwg6Ziazkn9DklpqEAwAGNz+fzMzN76MGcVOv8aAvlNHWxKffF
 vEWYFM52Xk4mezBdyH2zuhiO+wq7N1g30Ixp0zB2W0eV1y3/PO35kijS4wei+uE7RIy+hk
 zWocTC7F7NAiSUu36eOP7+riKp/5e1ro4X54/58L216ZtMpa6O2x+HyoW/aubqqFZPEgig
 ygBO48uxIWwoUzJU/ciRwPcEmB4v2gEc53nX9bp1aDWsAPaCO4vXeMG0sBQ7lOGqvxpHZe
 domal49wlqmJ1yJ1GpNbv+9iGI3g7aJ/HDWcA+exQu4pR2BHbDAATmqAb/dHmQ==
Message-ID: <797717d1-b9fe-43e8-b32e-6dcf6e0f06e8@nabladev.com>
Date: Wed, 8 Jul 2026 11:15:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] cmd: kconfig: i2c: add missing I2C API dependency
Content-Language: en-US
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
References: <20260702-cmd-i2-add-dm-i2c-dependency-v2-1-e048ab426191@baylibre.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260702-cmd-i2-add-dm-i2c-dependency-v2-1-e048ab426191@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Julian,

On 02.07.26 17:26, Julien Stephan wrote:
> CMD_I2C relies on either the Driver Model I2C API or the legacy I2C
> API, but its Kconfig currently does not enforce either dependency.
> 
> As a result, enabling CMD_I2C without DM_I2C or SYS_I2C_LEGACY can lead
> to link errors due to unresolved i2c_* symbols.
> 
> Require either DM_I2C or SYS_I2C_LEGACY to prevent unsupported
> configurations while preserving support for legacy platforms.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
> CMD_I2C relies on either the Driver Model I2C API or the legacy I2C
> API, but its Kconfig currently does not enforce either dependency.
> 
> In order to not break some legacy I2C board, we need to keep
> SYS_I2C_LEGACY in the depends on logic
> 
> $ ./tools/qconfig.py -f CMD_I2C ~DM_I2C
> 15 matches
> MPC837XERDB cl-som-imx7 d2net_v2 db-88f6720 db-88f6820-gp inetspace_v2 ls2080aqds_nand ls2080aqds_qspi ls2080ardb_nand net2big_v2 netspace_lite_v2 netspace_max_v2 netspace_mini_v2 netspace_v2 work_92105
> ---
> Changes in v2:
> - Add SYS_I2C_LEGACY in the depends on logic
> - Link to v1: https://patch.msgid.link/20260701-cmd-i2-add-dm-i2c-dependency-v1-1-19ebda3a80f8@baylibre.com

Reviewed-by: Heiko Schocher <hs@nabladev.com>

Thanks!

bye,
Heiko

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
