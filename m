Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8BEC36005
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 02:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91AF5810FE;
	Sat, 22 Mar 2025 03:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742611794;
	bh=xCOwj8w/3Toy3RchQKbWkhqA2pW9vZSU4X6rPdKzYm4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l36exwzXaXqOGuxLngw+PPs2wDbPz/lF9Du8xG8RJarz7ZTorxIHcTzUbvKduCoUv
	 cQIW74Jl31MqT7IDLbgFX9RJm+oVEk3wXa0NWQlPNUetblPFxTXN9Nyx7MexXbHrh3
	 mNommBwcHZoKmZqKRF2Ma0xRY8e66War3SfSQs2j+yFoqTqzDU+tU8pd22htuo2bXr
	 jeu32ee1zFe1ry+1kJkWpVD5t1a4Z7aq9e2GOvGj7JVA1BC8RgfVBt5qyUBjJfxIT9
	 liffx3KCbMI69yLzHeHpmDo+wPSASziHteUkTt7v7dhOwIUwL8yeQebezBYYh2DdJ4
	 TvNB+kKP8oP+A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F832811AC; Sat, 22 Mar 2025 03:49:52 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B4C280ECC
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 03:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="EyUE5H4H"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 00B3F101E8FEC; Sat, 22 Mar 2025 03:49:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742611788; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=xCOwj8w/3Toy3RchQKbWkhqA2pW9vZSU4X6rPdKzYm4=;
 b=EyUE5H4HPwYTLx2sr/YbRcDKZCDm1/NY5EahyncfRcJN6Vs7q0LQ+jiB8GpvyOvRBEkyKP
 WQ4Szz+Pch+Hh/3oc2fP25gCSLwGXb1illCgRjlhuRAkibNdvqI2/XWy7RrFsKTY06dt4b
 Ry4m3xq7Yc+kPKfJTqqNrBv3HoncDQ+QWXl741Nb6g4PPrt12OBlVvbKmCjA9Ywr5j35Ml
 2P5V3N654sDYPJXeUlywOpYBEhQJZdUkJWHUBz1f6pPAQ5m4J0hPr+LeIBVm9jyyLfEvJ/
 dhoRoQ5S20Mzrhfq8y1pA0BQFYU2WwqvfPRt6Ot7EP6vpD+kA5+uyqq7Ba/qcw==
Message-ID: <aa808e29-5a8d-4662-b70a-21af4b011c19@denx.de>
Date: Sat, 22 Mar 2025 01:38:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/19] firmware: scmi: smt: Interrupt communication
 enable
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?=
 <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Viorel Suman <viorel.suman@nxp.com>,
 Ye Li <ye.li@nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-1-f2c8ba815f89@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250321-imx95-v1-1-f2c8ba815f89@oss.nxp.com>
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

On 3/21/25 8:15 AM, Alice Guo (OSS) wrote:

Hi,

> @@ -48,6 +58,9 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
>   	if (!smt->buf)
>   		return -ENOMEM;
>   
> +	if (IS_ENABLED(CONFIG_SCMI_TRANSPORT_SMT_INTR))
> +		scmi_smt_enable_intr(smt, true);
Can we somehow figure out whether this interrupt needs to be enabled 
purely from U-Boot control DT ? For example, check DT /firmware/scmi 
node for compatible == "arm,scmi" (or != "arm,scmi-smc") and presence of 
"mboxes" property ?
