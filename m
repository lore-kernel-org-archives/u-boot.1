Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75695CD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F235D846F8;
	Wed, 27 May 2026 14:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WPKdGIpT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80589847AF; Wed, 27 May 2026 14:32:12 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA63883FB0
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 14:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gQTX909CXz9txs;
 Wed, 27 May 2026 14:32:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779885129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sy5eeVVc6SVRVCo3oCU0yx4+m68ecmcV/n1sDMTG2iA=;
 b=WPKdGIpTl/2uP48ZTKaBd2cu57L0L0ZgVaqthchQpi4iYzpLV0afc82ZR9yK7NkuWH4ljw
 D88aIS5264uWkN1aiF4EyXmOt8tLt9QLxlgBdN+Pk/wGiRRL10T4QXDzu6jGwjqI+Zb/sr
 qRyRf2ePv1y2MshNm44rMOF+dgSeV6/pORxnAEyP3mEEkVSfGy1QpjvtgO7VzA9XRCThvE
 Sg61Pau30oIE+xmkLupZF2N953FZ9s660A8AeG0xyAvMDg/sjZtfR3eJuuGgrHwGhXKxt7
 eO6dVwpNHLZMnh5xQPXAGPo3ZJBv+7G4D+j3nKzhDqCwVzhgEEHWeIF6524j4g==
Message-ID: <1c22303b-b110-4966-82c1-a8fe95afeec5@mailbox.org>
Date: Wed, 27 May 2026 14:32:07 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] watchdog: mpc8xxx_wdt: Use dev_remap_addr()
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>
References: <20260525-devfdt-wdog-v1-0-d8142b674ba0@nxp.com>
 <20260525-devfdt-wdog-v1-3-d8142b674ba0@nxp.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260525-devfdt-wdog-v1-3-d8142b674ba0@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: kqxneh7mrxd3k15jjx51r36aem3b7asx
X-MBO-RS-ID: 491af6c3fce3d7edffd
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

On 5/25/26 05:51, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use dev_remap_addr() to replace devfdt_remap_addr which supports both live
> device tree and flat DT backends, avoiding direct dependency on
> devfdt_* helpers.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/watchdog/mpc8xxx_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index 7fcb866f574..068f99c5fc6 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -81,7 +81,7 @@ static int mpc8xxx_wdt_of_to_plat(struct udevice *dev)
>   {
>   	struct mpc8xxx_wdt_priv *priv = dev_get_priv(dev);
>   
> -	priv->base = (void __iomem *)devfdt_remap_addr(dev);
> +	priv->base = (void __iomem *)dev_remap_addr(dev);
>   
>   	if (!priv->base)
>   		return -EINVAL;
> 

