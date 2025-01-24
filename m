Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B0CC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:26:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44AE680B9C;
	Fri, 24 Jan 2025 16:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737732368;
	bh=VOiiy2EL9FuZTKaeZNDI+q7MYdMbEtl3Yz/21NBAvOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cge65Xz+f2s7G225QZzrzPJPA1gkSOSjwjmhlwtiAEwMrZbAgU/GRn4n2PL6aBunS
	 uHUeUrjpMQKZ5VGtUzofWwPThWBEWTH772W/IxyZnacMsFV1OSeGumf2+Y3Xa7BTbV
	 Lyb0NFZsTjTswCxFrnDVwka0ciO6N2J5Pa0xRCh+yw0MApkOHOEpkyRmje7PzImV6F
	 HRXo5kvY2RyfYjOyzPENTOxaz6WcvbSbXi9Y8/PcprvCHMtSz/dlfn+tTqTWCqLRgE
	 qdK51NJ2vI0+QapWKGXA6xxQLEARawDxpPnxAlEJJd18lnIwlNmbUBFxOby0XQlhEi
	 kfKoBZQsc/9gA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5014180B9B; Fri, 24 Jan 2025 16:26:07 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DA3D809D2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hD1jeUZB"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6BFAD1048EF44; Fri, 24 Jan 2025 16:25:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737732364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VOiiy2EL9FuZTKaeZNDI+q7MYdMbEtl3Yz/21NBAvOk=;
 b=hD1jeUZB9zUrRmLgo47aer5jW5T8VtUml97k7hYaXsLKRUQVRHAxfaBlxh613/nPDkT3DA
 uZDuNKiSJ06GfdyyVZpvtAW4SH53YgTk6zIssUb52SxVH/3EbQmr68fTPef15hbrcGFvjv
 hSwhDxm6AUulweTmq8QrZwmG9iuEoAx01bVNBQsJVvFtZndVEFldfLyfwhzlwCGNU2iH/3
 QmHRqQ5TCXaS+gUifjdHMFuuwt5K6vGbuv5ug+0Ss8z+85Sr6sEA1MfsShYfdx608JSZEX
 BUtAhDwyhlNQrdEuP0CTmvqzMkyQkcqJx9vonkCqBVscV6hnDzePkdptIzzeTg==
Message-ID: <f9bfd3d8-dd30-4f4e-a73d-ab9082f832a8@denx.de>
Date: Fri, 24 Jan 2025 11:35:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] common: board: make initcalls static
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
References: <cover.1737709089.git.jerome.forissier@linaro.org>
 <564c3f3b7f70c893b2c6b6dfc89a226b90d411de.1737709089.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <564c3f3b7f70c893b2c6b6dfc89a226b90d411de.1737709089.git.jerome.forissier@linaro.org>
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

On 1/24/25 10:10 AM, Jerome Forissier wrote:
> +#define INITCALL(_call) \
> +	do { \
> +		if (_call()) { \
> +			printf("%s(): initcall %s() failed\n", __func__, \
> +			       #_call); \
> +			hang(); \
> +		} \
> +	} while (0)

Can this be turned into some static inline function too , so 
typechecking would be retained ? Maybe the function can be passed in a 
function pointer to call ?
