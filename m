Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393A5C282D0
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 19:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FE7281101;
	Fri, 28 Feb 2025 20:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740770844;
	bh=DnKMyBv7qNM6SMkUuWChPxH1Vh5Yj/xt2QT4XGF4UhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o/OKYAqojZihuTbBoGrPgxCdcWf1Pd+T9B7L0XoAXMcHLO0YoxapeNZ+vQe67YfTT
	 E2u7P1HdEi14DmZrfm2d8PEhGnr8nH3mR58Z6/kOqg1uePEqaBjlvbOCcsODgLzCzr
	 SSZYPXiFNtdTdXYQzeQf2AMSVsyyq5goapiEOIJjUTqRO1X2MuG3PniaKLm38NPEdw
	 /IpGFMu2a1AWjktN/XVWoaaCaN5Frhsp+WoMXqyP+oW55j5HzA4B6xj/U+2LxLj2pA
	 xCau0IdYwe4xBxzx89bZxYCyh9WJt4Kn+GKMBtGsKfNL9gyfIapS1KY8yTP8djjUnr
	 1LPBE9e5cDsOg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 979B8810FE; Fri, 28 Feb 2025 20:27:22 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4E4F810ED
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 20:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Hx74lNt/"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 584691034EACF; Fri, 28 Feb 2025 20:27:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740770840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DnKMyBv7qNM6SMkUuWChPxH1Vh5Yj/xt2QT4XGF4UhU=;
 b=Hx74lNt/ohboPIqed/6KkQ6j73l9QWSWNBv/gnA6A8djjrNu1i8Owk+PxekExvWiEsjgOj
 l05oace4UC2MRnkjZqeL6eOPEssKCGqqy/MjA2JT3owPcutVzb4C1H+mmVCU3bJHGZlM5p
 JGyvGIm901K5YK9KFnjjcx0jqLA7SDBDucjCOStX45fBp+z3OE63bhAwBfKH+v/OsFD/3S
 9XD2LqBv7UeIgGYLov65G93Ynn6a8OXaT9Wj/D4kQVerXyViiskxjNgQ2wgx9wZihK8gal
 2y5L07sODbirMyGmEnZlB6xeEvkazKMNND7S8F7hlaTP8v3ZeTpLHRoSf+IVzQ==
Message-ID: <579c1f50-1a7b-4663-98fe-c2687614079f@denx.de>
Date: Fri, 28 Feb 2025 20:08:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/20] mailbox: add i.MX Messaging Unit (MU) driver
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
 <20250228-imx95-v1-1-09594e93cc9b@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250228-imx95-v1-1-09594e93cc9b@oss.nxp.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2/28/25 11:53 AM, Alice Guo (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This patch provides a driver for i.MX Messaging Unit (MU) using the
> commom mailbox framework.
> 
> This is ported from Linux (v6.12.8) driver
> drivers/mailbox/imx-mailbox.c. Its commit SHA is:
> 39d7d6177f0c ("mailbox: imx: use device name in interrupt name")

[...]

> +static const struct udevice_id ids[] = {
> +	{ .compatible = "fsl,imx6sx-mu", .data = (ulong)&imx_mu_cfg_imx6sx },
> +	{ .compatible = "fsl,imx95-mu", .data = (ulong)&imx_mu_cfg_imx95 },
> +	{ }
> +};
Doesn't 6.12.y also support MX7ULP and MX8ULP MU ?

Also, please split the MU patch into separate series, so it can go in 
separately.
