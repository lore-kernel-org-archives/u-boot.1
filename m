Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57855C282C6
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 21:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BDFE81273;
	Mon,  3 Mar 2025 22:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741039039;
	bh=LSWWXNPCb+Zra1Qn0GYbsO1Rs4m1R/fXnyyXjiN4iBU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hqXbC65q2zuB+ZiyrBq2lS+UqzF9fMFOUs9Sui7mAy1fPrSHozCh6JiWKhm7ouBDJ
	 1fceZYIgqK0yRaCklSTYseyTHsPV9OjL70BUFjopo5J2Of6xjKbxNvacfFvQYXDoMb
	 u8SqGn5+7p2yLhrph8wXA6q6xIAIwRuHTPFYz5ds5+cXDWbsCr7kzz1KOIMvcnPSBZ
	 7dfF47+1d4TYMtw5gABzzK5Sf5n+HjOIfqVg+BNR40ZUeoByT3fLbFuXiX2CaipRdR
	 4NMFScNkaMpiRE3YjHlLExHxu+J1SgsXbPKd+YD3EGe7a+Ssf8dPxwJWBP7fFmQTqb
	 R2/E8BmUuJS2Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C8BD80786; Mon,  3 Mar 2025 22:57:17 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE5E811B3
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 22:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Hwx6q2wb"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 487DB10381917; Mon,  3 Mar 2025 22:57:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741039034; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=LSWWXNPCb+Zra1Qn0GYbsO1Rs4m1R/fXnyyXjiN4iBU=;
 b=Hwx6q2wbgb2QdVFMfiZNRLFFXDz44V6YLCqRW2xGM99wqS6aEXNopT0qBeUNpXaXiJ2wRW
 sWn2y2vBz2KeUk4Ei+gPP+QOR/3KwUuATZiFNI0jBEwqgWa5mtFcf8UZG7H4xngYYvMUy0
 BmRFk20wd7pR4v+gj3ZknI6u0pulgPv2YaBz9aPsJ9a2wbz7/pTsooFtIDDU+q2jSz59EX
 3936t+EiPNTG4o6U2Xc2APzsPGM3eHeP9aLN+i2bxvIXGDMW46WKBJ+vfGLulkatt6Fw9h
 mLrkkcQYXwhlrDkgwuQrm5CjWVVaBN9yZKWa/2hpbKEn4YjoEucC+Tpnb+aKlQ==
Message-ID: <3f5b9ee6-0def-43c6-a312-6248db8c588b@denx.de>
Date: Mon, 3 Mar 2025 21:05:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mailbox: add i.MX Messaging Unit (MU) driver
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, trini@konsulko.com,
 sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, alpernebiyasak@gmail.com
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, viorel.suman@nxp.com, ye.li@nxp.com
References: <20250303035231.2680198-1-alice.guo@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250303035231.2680198-1-alice.guo@oss.nxp.com>
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

On 3/3/25 4:52 AM, Alice Guo (OSS) wrote:

Hi,

> +static const struct udevice_id ids[] = {
> +	{ .compatible = "fsl,imx6sx-mu", .data = (ulong)&imx_mu_cfg_imx6sx },
> +	{ .compatible = "fsl,imx7ulp-mu", .data = (ulong)&imx_mu_cfg_imx7ulp },
> +	{ .compatible = "fsl,imx8ulp-mu", .data = (ulong)&imx_mu_cfg_imx8ulp },
> +	{ .compatible = "fsl,imx95-mu", .data = (ulong)&imx_mu_cfg_imx95 },
Wouldn't it be useful to include also fsl,imx95-mu-ele and 
fsl,imx95-mu-v2x for iMX95 ? Esp. the ELE is something which surely is 
present due to the AHAB container, right ?
