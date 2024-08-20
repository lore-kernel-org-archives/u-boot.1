Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810E3C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 17:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A7B188D98;
	Tue, 20 Aug 2024 19:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dL0cHe7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81AAC88D94; Tue, 20 Aug 2024 19:11:21 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EB0B879C1
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 19:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a83597ce5beso874650866b.1
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 10:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724173878; x=1724778678; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uxAA8hRqigsb8cAhlxuHey76cW5bc3tAALHsa6hm2To=;
 b=dL0cHe7Q/Xx5IrLnmcOGJEnboGVYfbt2baWfYBZff5G9Ph2YbEc8/4V1bzVB/jbDoz
 hipEREGMmD5Xs8RxEdBbDjGFTepNpBR0dac0URnAgKNPrzx3B+vCV1EPr/VlGLJVSuFF
 v3MovCFHkJ7xwDSr5TK/Zar31hC5XKGfQbbdE6CjJYOfgYp3Y8KleqB+LlbRp5xPLVwX
 ThDDfZM3eQBa1pCKdc4ydro2cYIjvzqtDpSfaVsVwdomRhxg9wIqpzvhRTPbSucsDJNq
 rl1J3aqTkM7atlF8taLkGqZUGrqkC0Den5gFxdySf1Jm0LNKW7jRNYYFUQ+PUVk1oP0l
 6mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724173878; x=1724778678;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uxAA8hRqigsb8cAhlxuHey76cW5bc3tAALHsa6hm2To=;
 b=WNI5KkQzr+5bHt9//F+pyGjSsSVhoXfT1R6O7vL8v4wXaxVrfl9ll4zqahEtbYhfcE
 oBhcBKTFXwRVpKwrvtETcSdkbMkaGJhzwW7Svtq6f8TLWTI2RD9bgYhiMQBBfQr/EhGU
 m+HsyzugxJ+ioyczjnP7WknRh2kD5+TMlHrSovKGdSFR6N34KSmKuLGEGSkwpcLGdtXI
 TuoRF5WMjMikEIydzksCv57B756tUW8jeyZFl4jF9vpWNDIRn7fL4v0M7HOpj/pn/XrC
 Hr6Pxl9pg/NM5k/wVZwRt925AWzuPHrwrmr2QNq7J826gWdki5WA5gX6dPEpIIpIutRJ
 F+RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjXokaQEwDvWgM229soikS4l9w1z11+mz1qS62Pud83CTqr3cGhwP+1fzo16qrQrw0c/ClPSw=@lists.denx.de
X-Gm-Message-State: AOJu0YxblLqlnwsiybE3rfcA2Ly3ZblmYAuu6pONPVTvyhfd2f374eSy
 htQCjXGYi8jvZScpTW1CcoouWQQ9si66JKQqI+eNbfjc643XczNrMhPvN78fNl0=
X-Google-Smtp-Source: AGHT+IHAITPX8Ts3kXTcjZmOgnlXSg+LfFD9CxMV1Bc510pLPrJ5eUGn53P6wLSFKmVmVtZOi+jEQg==
X-Received: by 2002:a17:907:7e96:b0:a7a:acae:3419 with SMTP id
 a640c23a62f3a-a8644117264mr388924366b.28.1724173877764; 
 Tue, 20 Aug 2024 10:11:17 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::676e? ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a838396d304sm779509366b.212.2024.08.20.10.11.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 10:11:17 -0700 (PDT)
Message-ID: <d280f437-c873-47b7-8ff9-ebd42da7e572@linaro.org>
Date: Tue, 20 Aug 2024 19:11:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: ether: Handle gadget driver registration in
 start and stop
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Zixun LI <admin@hifiphile.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240726083102.380719-1-admin@hifiphile.com>
 <172301272563.244852.18199647448023901472.b4-ty@baylibre.com>
 <87le0ruqcj.fsf@baylibre.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <87le0ruqcj.fsf@baylibre.com>
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


> Instead, to enable usb ethernet, we should manually bind the UDC driver
> to the usb_ether gadget.
> 
> For example, on Khadas VIM3 board, this can be done with:
> 
> => bind /soc/usb@ffe09000/usb@ff400000 usb_ether

It would be great if this could be done like ums where the UDC index is 
given rather than having to figure out the magic DT path incantation :D

=> ums 0 scsi 0,1,2,3,4,5

> 
> Use "dm tree" to find the node path for your UDC. 

-- 
// Caleb (they/them)
