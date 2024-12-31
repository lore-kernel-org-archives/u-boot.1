Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC0AE7718B
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 18:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E48080584;
	Tue, 31 Dec 2024 19:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1735668801;
	bh=StJDaYUgyqUQiLY3n7GoSOfhAzL3h/15EwiPT0eJNCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vHMRpS8PHMBueEJxgle55blbCFrOhgKvTe9A/uq7VJTDn728PLMgAvUz03IDF/Okw
	 ke9dt+cZ1TQOZZxyVz+ILsqKGkNaqTxc9i7GhR5fBMNQIXvkS5uV7k/CIqMbXtLmXb
	 zQrtUEC80ndjmAnY5hiElfCXVCKhE7kASAiLJO/lnMiQ0RVgVdKiS4Bz/cV7fYcnJf
	 GxXk++okURpnOihBQ9IsvdvMqggyWRysxiUKefNK9MXjoQGh2EBS3CdW7QkdcGvA3a
	 Kg3n6S4ITppqfogzq1qFfTBjCgAt7eVeOy/s0OekiuOJVpQNDeIm3IgrOUN9ubV7qK
	 /IMY4LmGoJ6bw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id F079B80431; Tue, 31 Dec 2024 19:13:19 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB0C3801CE
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 19:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Vir8Q/J9"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 41EC210486D8F; Tue, 31 Dec 2024 19:13:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1735668797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=StJDaYUgyqUQiLY3n7GoSOfhAzL3h/15EwiPT0eJNCk=;
 b=Vir8Q/J9hCYozmlAyHgJxLymT8kCKb+J5Yr+NuQJN/e0d/T5grQ8xtwlsp7Af99HZHnNwc
 pS3Pc4HD6JPu1fZE9jd2UOrIQzOQvm0KV9tgNuANeGOWBI+meJUhwyB1yF8AtiD3kWOESt
 gfW/u6Py+FcICzuCxvbR8KN+CUht1SD3CdB6PYqQqyiLMeCLohPcIjvjtMpMh7DOKJs2Ws
 K8ujXADNK9LvUG1ftamMTPTeLLNCDHbMX1rzS11Ac0D5mYAXFLpwr06FiSX0eWtgTAGg5b
 npAF1CZEqFkO6bfyxH3virw1vJbxPDJIwuk1P8T1EMJT7mHxa69zzpQEJ2D3pw==
Message-ID: <bb372fcc-9acf-4590-85da-5726606bc10e@denx.de>
Date: Tue, 31 Dec 2024 19:10:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] usb: dwc2: Fix incorrect ULPI_UTMI_SEL bit setting
To: liujh2818@outlook.com, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>
References: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
 <20241230-dwc2-dev-v2-2-12cd9b8a2358@outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241230-dwc2-dev-v2-2-12cd9b8a2358@outlook.com>
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

On 12/30/24 4:30 AM, Junhui Liu via B4 Relay wrote:
> From: Junhui Liu <liujh2818@outlook.com>
> 
> The ULPI_UTMI_SEL bit in the DWC2 driver was set incorrectly. According
> to the datasheet [1], this bit should be set to 0 for UTMI interface and 1
> for ULPI interface. The existing code had this logic reversed,
> causing the interface selection to be incorrect.
> 
> This commit corrects the ULPI_UTMI_SEL bit setting to match the
> datasheet's description. Referencing the kernel's code [2] also confirms
> this fix.
> 
> [1] https://rockchip.fr/RK312X%20TRM/chapter-26-usb-otg-2-0.pdf#page=30
> [2] https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/usb/dwc2/core.c#L1106
> 
> Signed-off-by: Junhui Liu <liujh2818@outlook.com>
Reviewed-by: Marek Vasut <marex@denx.de>
