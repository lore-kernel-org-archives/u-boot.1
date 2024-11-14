Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D548D6A230
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 21:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB088968B;
	Thu, 14 Nov 2024 22:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731620196;
	bh=Aj+ZL5SbYRL5W6YL4jEmH94te1GtKeGsDvf9NLEwNek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EyhQQRDq7ZuBb9mgCrhevhlqK0GEtllTNtP5R6v+3DKoKje3PJPIiHiiXnUE0tws+
	 GMw7NaH36aHPv2GLhaRzg8XBXfjTi8sNsoR3QtdSq96luxDAPcAb9sct4xiM+e9hab
	 UL1+rKJ4D/ty7qCaMThMETAlphyT9OFcpjT+rTTqmf3LWS0SJmuh4zieYItyOKLSCc
	 EyjuuoG7OFkJ9L8xgY0ulezNS7eW+1q88xqfqHFHmws9aT9p8Raf0md6GsW8Xq4680
	 xrYtkbbYqJ3s6kTBv7EZvmpRN4IvjSdfmrWZWji1sCmNWfEWmceuWasgjryA+dKSqP
	 eyIRw9KheqXVg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B5A3688DF5;
 Thu, 14 Nov 2024 22:36:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731620195;
 bh=Aj+ZL5SbYRL5W6YL4jEmH94te1GtKeGsDvf9NLEwNek=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=b8RS3tGO07umELTErGrJluGvibHRX0s1wqwftxuDhEqw6RQD7HHjShYJPzbcGeRcC
 6k5JoKvdkEASp0fUVfCh+dJMLRH/XH5t9XkO1wa6t12kQxVm6pTquQlnRJdDxvNZIo
 vJzIh/wRnA4B5HiPlhLEruACuzh1KAGB3xiFL1RmOOxxWcdOkk5BbB1n1khSwfxpuF
 5PEWmaHOcUgADMoeOdAN7zBuBoZdeE4sUdwna1j9xOYeYnvokqZmI46DsGZuW+2wuf
 TSelxkCHDf8Ii2mqEH8/hiL6RZsgcFMFXuwzw8JX718dWGntUHnfPUYv8NbRJlxJHT
 1BD0C00B5BDsQ==
Message-ID: <cf9b422f-beec-43e4-b0d4-b0bc7838bce3@denx.de>
Date: Thu, 14 Nov 2024 22:36:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cmd: add a fetch utility
To: Caleb Connolly <caleb.connolly@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Sean Anderson
 <seanga2@gmail.com>, Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, u-boot@lists.denx.de
References: <20241114200856.3450012-1-caleb.connolly@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241114200856.3450012-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/14/24 9:08 PM, Caleb Connolly wrote:

[...]

> +		case IP:
> +			ipaddr = env_get("ipvaddr");

ipvaddr with 'v' in the middle ? Shouldn't that be 'ipaddr' ?

> +			if (!ipaddr)
> +				ipaddr = "none";
