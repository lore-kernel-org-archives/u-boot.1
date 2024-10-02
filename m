Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A432ECF6D2C
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 15:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 350C68931D;
	Wed,  2 Oct 2024 17:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727881273;
	bh=jRrhmVthbG4ZULp/M2UVj+DLNVyExCQhXdjiSfXoSIk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=swtVnWSYQIldgc5IkMA/cuPs79xFVQrEkMCHUiBJH0g/gF7i65Nd5UHMGfcWkhi8f
	 v+oWiJooAFDjhA0nlYYKpVm+ghdboVjm5ARiFRQ/Isb4soGQAzpCyvFHwNtVvcOaA9
	 UFDPPnhbLwC/cWvjXfZgVwQe/ZbiC9/7/2OMxOXJrU6IffqlqQcKxLczndun5HB3n1
	 Zr4aYLuC7wQU+zikpPWLEZqAnAbdwfSlLxjybsXQ8BraPW7JaOopKNpmm3IXoAxQAU
	 VtKfrgZAUtjkO8kSSsWYNwxA+vs0rZkkas1w2BlAIwbw7djpfSlvFoj2UFR3yiQmLM
	 2rE9gl+4Atz9g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9279389313;
 Wed,  2 Oct 2024 17:01:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727881271;
 bh=jRrhmVthbG4ZULp/M2UVj+DLNVyExCQhXdjiSfXoSIk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GYaYdIwIkhLU9cO4X4hK5GGFq+kz/VnpGE47YTcI1f7Q69uhAkNJJm+jufvqmTgwo
 5l2A6EzRsygHzbbNYoX9ncEpg+2zHDfzwPydwrhuCA5DTO/ixmWpLHDhPP6tJ5XLPk
 pX429qn7HEb849r3BSdEqIE/+GkP6ZGdWEEjkCgmFcdSX7smHfesD4a1gRujPYmIAF
 6X3C7sfY1iUEw+MmV90j1YT7A03r0RICp+JHBCTPSIXRJ7OD5zTBhloWJ9zNrRrW3x
 7rA5/BSb9IQy52eVZvQam9ZXGMgyXWUfFhtei3PG3KykGL6ClTgIyB04dbUfzn3uXi
 gnzTWmTX1MiMg==
Message-ID: <92d076b2-7f44-46f3-b754-5b458279ba39@denx.de>
Date: Wed, 2 Oct 2024 16:51:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] usb: dwc3: allocate setup_buf with
 dma_alloc_coherent()
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-0-5398088ef93c@linaro.org>
 <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-1-5398088ef93c@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-1-5398088ef93c@linaro.org>
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

On 10/2/24 4:39 PM, Neil Armstrong wrote:
> Since setup_buf is also consumed by hardware DMA, aligns it's
> allocation like other hardware buffers by introduce setup_buf_addr
> populated by dma_alloc_coherent(), and use it to pass the physical
> address of the buffer to the hardware.
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Marek Vasut <marex@denx.de>
